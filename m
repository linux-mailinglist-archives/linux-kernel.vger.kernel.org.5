Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54457B37DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjI2QXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjI2QX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:23:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282CFBE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:23:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449B5C433C7;
        Fri, 29 Sep 2023 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696004606;
        bh=vdHsFS1qwouM+3ZESdMWBKhRRi64cXjRGOWqnTWm4nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiKXhd8fVklhkUvZLY/7nVB9NKzzeU+CKrADgeA2VwJVUpuWHiHGUV7uVaUcd3oQz
         VRjklVMCsTZ0MT4mgBsdx42amXJ993diG7iv3JZKM78vHl3G2s/muANlcfbmZSBXvv
         vsVntbyTdWfsJSiGresmpLIY2AnnnG0HDr6BKSlMzhqGMisPBMOsKdII/RVMX8HzQ1
         NmZ7E/PLEudfKlQjsGJROfj/RndTmFX1aaT+jV5ewhGa529PLNG8uBCVeyIlm+MXQW
         SPqgJwnCWE+JkFjHlVMZEcQYG+e+JwVWSoLmglreLJJsvVt1fm3WIVrmtafI3V5gYv
         iMV8gsUxh6Low==
Date:   Fri, 29 Sep 2023 21:53:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 04/15] phy: allow querying the address of
 protocol converters through phy_get_status()
Message-ID: <ZRb5+h4TnGRKl3/6@matsya>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-5-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-5-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-09-23, 16:48, Vladimir Oltean wrote:
> The bit stream handled by a SerDes lane needs protocol converters to be
> usable for Ethernet. On Freescale/NXP SoCs, those protocol converters
> are located on the internal MDIO buses of the Ethernet MACs that need
> them.
> 
> The location on that MDIO bus, on these SoCs, is not fixed, but given by
> some control registers of the SerDes block itself.
> 
> Because no one modifies those addresses from the power-on default, so
> far we've relied on hardcoding the default values in the device trees,
> resulting in something like this:
> 
> 		pcs_mdio1: mdio@8c07000 {
> 			compatible = "fsl,fman-memac-mdio";
> 
> 			pcs1: ethernet-phy@0 {
> 				reg = <0>;
> 			};
> 		};
> 
> where the "reg" of "pcs1" can actually be retrieved from "serdes_1".
> 
> That was for the PCS. For AN/LT blocks, that can also be done, but the
> MAC to PCS to AN/LT block mapping is non-trivial and extremely easy to
> get wrong, which will confuse and frustrate any device tree writers.
> 
> The proposal is to take advantage of the fact that these protocol
> converters *are* discoverable, and to side-step that entire device tree
> mapping issue by not putting them in the device tree at all. So, one of
> the consumers of the SerDes PHY uses the phy_get_status() API to figure
> out the address on the MDIO bus, it also has a reference to the MDIO bus
> => it can create the mdio_device in a non OF-based manner.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: patch is new
> 
>  include/linux/phy/phy.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index f1f03fa66943..ee721067517b 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -56,6 +56,33 @@ enum phy_media {
>  enum phy_status_type {
>  	/* Valid for PHY_MODE_ETHERNET and PHY_MODE_ETHTOOL */
>  	PHY_STATUS_CDR_LOCK,
> +	PHY_STATUS_PCVT_ADDR,
> +};
> +
> +/* enum phy_pcvt_type - PHY protocol converter type

It is not a generic protocol converter but an ethernet phy protocol
converter, so i guess we should add that here (we are generic phy and
not ethernet phy here!

> + *
> + * @PHY_PCVT_ETHERNET_PCS: Ethernet Physical Coding Sublayer, top-most layer of
> + *			   an Ethernet PHY. Connects through MII to the MAC,
> + *			   and handles link status detection and the conversion
> + *			   of MII signals to link-specific code words (8b/10b,
> + *			   64b/66b etc).
> + * @PHY_PCVT_ETHERNET_ANLT: Ethernet Auto-Negotiation and Link Training,
> + *			    bottom-most layer of an Ethernet PHY, beneath the
> + *			    PMA and PMD. Its activity is only visible on the
> + *			    physical medium, and it is responsible for
> + *			    selecting the most adequate PCS/PMA/PMD set that
> + *			    can operate on that medium.
> + */
> +enum phy_pcvt_type {
> +	PHY_PCVT_ETHERNET_PCS,
> +	PHY_PCVT_ETHERNET_ANLT,
> +};
> +
> +struct phy_status_opts_pcvt {
> +	enum phy_pcvt_type type;
> +	union {
> +		unsigned int mdio;
> +	} addr;
>  };
>  
>  /* If the CDR (Clock and Data Recovery) block is able to lock onto the RX bit
> @@ -71,9 +98,11 @@ struct phy_status_opts_cdr {
>   * union phy_status_opts - Opaque generic phy status
>   *
>   * @cdr:	Configuration set applicable for PHY_STATUS_CDR_LOCK.
> + * @pcvt:	Configuration set applicable for PHY_STATUS_PCVT_ADDR.
>   */
>  union phy_status_opts {
>  	struct phy_status_opts_cdr		cdr;
> +	struct phy_status_opts_pcvt		pcvt;
>  };
>  
>  /**
> -- 
> 2.34.1

-- 
~Vinod
