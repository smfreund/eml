<?xml version="1.0"?>
<!--
  *  '$RCSfile: eml-party-2.0.0.xsl,v $'
  *      Authors: Matthew Brooke
  *    Copyright: 2000 Regents of the University of California and the
  *               National Center for Ecological Analysis and Synthesis
  *  For Details: http://www.nceas.ucsb.edu/
  *
  *   '$Author: brooke $'
  *     '$Date: 2003-11-13 19:35:03 $'
  * '$Revision: 1.1 $'
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  * This is an XSLT (http://www.w3.org/TR/xslt) stylesheet designed to
  * convert an XML file that is valid with respect to the eml-variable.dtd
  * module of the Ecological Metadata Language (EML) into an HTML format
  * suitable for rendering with modern web browsers.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="html" encoding="iso-8859-1"/>
  
  <!-- This module is for party member and it is self contained-->

  <xsl:template name="party">
      <xsl:param name="partyfirstColStyle"/>
      <table class="tabledefault" width="100%">
        <xsl:choose>
         <xsl:when test="references!=''">
          <xsl:variable name="ref_id" select="references"/>
          <xsl:variable name="references" select="$ids[@id=$ref_id]" />
          <xsl:for-each select="$references">
            <xsl:apply-templates mode="party">
             <xsl:with-param name="partyfirstColStyle" select="$partyfirstColStyle"/>
            </xsl:apply-templates>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="party">
            <xsl:with-param name="partyfirstColStyle" select="$partyfirstColStyle"/>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
      </table>
  </xsl:template>

  <!-- *********************************************************************** -->

 
  <xsl:template match="individualName" mode="party">
      <xsl:param name="partyfirstColStyle"/>
      <xsl:if test="normalize-space(.)!=''">
        <tr><td width="{$firstColWidth}" class="{$partyfirstColStyle}" >
            Individual:</td><td width="{$secondColWidth}" class="{$secondColStyle}" >
           <xsl:value-of select="./salutation"/><xsl:text> </xsl:text>
           <xsl:value-of select="./givenName"/><xsl:text> </xsl:text>
           <xsl:value-of select="./surName"/>
        </td></tr>
      </xsl:if>
  </xsl:template>

 
  <xsl:template match="organizationName" mode="party">
      <xsl:param name="partyfirstColStyle"/>
      <xsl:if test="normalize-space(.)!=''">
        <tr><td width="{$firstColWidth}" class="{$partyfirstColStyle}" >
        Organization:</td><td width="{$secondColWidth}" class="{$secondColStyle}">
        <xsl:value-of select="."/>
        </td></tr>
      </xsl:if>
  </xsl:template>

  
  <xsl:template match="positionName" mode="party">
      <xsl:param name="partyfirstColStyle"/>
      <xsl:if test="normalize-space(.)!=''">
      <tr><td width="{$firstColWidth}" class="{$partyfirstColStyle}">
        Position:</td><td width="{$secondColWidth}" class="{$secondColStyle}">
        <xsl:value-of select="."/></td></tr>
      </xsl:if>
  </xsl:template>

  
  <xsl:template match="address" mode="party">
    <xsl:param name="partyfirstColStyle"/>
    <xsl:if test="normalize-space(.)!=''">
    <tr><td width="{$firstColWidth}" valign="top" class="{$partyfirstColStyle}">
        Address:</td><td width="{$secondColWidth}" >
    <table width="100%">
    <xsl:for-each select="./deliveryPoint">
    <tr><td><xsl:value-of select="."/><xsl:text>, </xsl:text></td></tr>
    </xsl:for-each>
    <!-- only include comma if city exists... -->
    <xsl:if test="normalize-space(./city)!=''">
        <tr><td><xsl:value-of select="./city"/><xsl:text>, </xsl:text></td></tr>
    </xsl:if>
    <xsl:if test="normalize-space(./administrativeArea)!='' or normalize-space(./postalCode)!=''">
        <tr><td><xsl:value-of select="./administrativeArea"/><xsl:text> </xsl:text><xsl:value-of select="./postalCode"/></td></tr>
    </xsl:if>
    <xsl:if test="normalize-space(./country)!=''">
      <tr><td><xsl:value-of select="./country"/></td></tr>
    </xsl:if>
    </table></td></tr>
    </xsl:if>
    </xsl:template>

 
  <xsl:template match="phone" mode="party">
      <xsl:param name="partyfirstColStyle"/>
      <tr><td width="{$firstColWidth}" class="{$partyfirstColStyle}" >
        Phone:</td><td width="{$secondColWidth}" >
       <xsl:value-of select="."/>
       <xsl:if test="normalize-space(./@phonetype)!=''">
            <xsl:text> (</xsl:text><xsl:value-of select="./@phonetype"/><xsl:text>)</xsl:text>
       </xsl:if></td></tr>
  </xsl:template>

 
  <xsl:template match="electronicMailAddress" mode="party">
      <xsl:param name="partyfirstColStyle"/>
      <xsl:if test="normalize-space(.)!=''">
      <tr><td width="{$firstColWidth}" class="{$partyfirstColStyle}" >
        Email Address:</td><td width="{$secondColWidth}">
        <xsl:value-of select="."/></td></tr>
      </xsl:if>
  </xsl:template>

  
  <xsl:template match="onlineUrl" mode="party">
      <xsl:param name="partyfirstColStyle"/> 
      <xsl:if test="normalize-space(.)!=''">
      <tr><td width="{$firstColWidth}" class="{$partyfirstColStyle}" >
        Web Address:</td><td width="{$secondColWidth}">
        <xsl:value-of select="."/></td></tr>
      </xsl:if>
  </xsl:template>


  <xsl:template match="userId" mode="party">
      <xsl:param name="partyfirstColStyle"/>
      <xsl:if test="normalize-space(.)!=''">
      <tr><td width="{$firstColWidth}" class="{$partyfirstColStyle}" >
        Id:</td><td width="{$secondColWidth}">
        <xsl:value-of select="."/></td></tr>
      </xsl:if>
  </xsl:template>

</xsl:stylesheet>