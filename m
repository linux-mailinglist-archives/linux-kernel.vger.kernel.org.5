Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8410F7690DB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjGaIyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGaIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:53:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF70FF3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:51:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qQOd2-0004QZ-8p; Mon, 31 Jul 2023 10:51:48 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qQOd1-000458-El; Mon, 31 Jul 2023 10:51:47 +0200
Date:   Mon, 31 Jul 2023 10:51:47 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dan.scally@ideasonboard.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] arm64: dts: freescale: Add DEBIX SOM A and SOM A
 I/O Board support
Message-ID: <20230731085147.isqy3zte3pcoyuhi@pengutronix.de>
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
 <20230717165127.2882535-4-m.felsch@pengutronix.de>
 <20230725132607.GE21640@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725132607.GE21640@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 23-07-25, Laurent Pinchart wrote:
> Hi Marco,
> 
> Thank you for the patch.
> 
> On Mon, Jul 17, 2023 at 06:51:27PM +0200, Marco Felsch wrote:

...

> > +	reg_baseboard_vdd3v3: regulator-baseboard-vdd3v3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-name = "BB_VDD3V3";
> > +		gpio = <&expander0 10 GPIO_ACTIVE_HIGH>;
> > +		/* Required timings for ethernet phy's */
> > +		startup-delay-us = <50000>;
> 
> The regulator's datasheet shows a much smaller delay (about 1500µs with
> a 3A load).
> 
> > +		off-on-delay-us = <110000>;
> 
> Is this really a property of the regulator ? Or a requirement of the
> ethernet PHY ? In the latter case, shouldn't it be handled by the PHY ?

As written in the above comment: the delays are required by the PHYs.

> > +		enable-active-high;
> > +		regulator-always-on;
> 
> Why always on ? Same for the other supplies.

I don't have the SoM schematics and I wanted to keep it simple while
porting the downstream DTS. For this regulator we can drop the
'regulator-alaways-on' property but for the others I rather tend to keep
it. As this is an EVK this board should never made it into real products
and so power-consumption/optimization isn't really important.

> > +	};
> > +
> > +	reg_baseboard_vdd5v0: regulator-baseboard-vdd5v0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-name = "BB_VDD5V";
> > +		gpio = <&expander0 9 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +
> > +	regulator-som-vdd1v8 {
> > +		compatible = "regulator-fixed";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		regulator-name = "SOM_VDD1V8_SW";
> > +		gpio = <&expander0 12 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
> > +
> > +	regulator-som-vdd3v3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-name = "SOM_VDD3V3_SW";
> > +		gpio = <&expander0 11 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reg_usdhc2_vmmc: regulator-usdhc2 {
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> > +		regulator-name = "VSD_3V3";
> 
> This seems to be produced by the SoM, it should be moved to the SoM
> .dtsi.

You're right, albeit the arrow is pointing to J6. I'll fix this.

> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +
> > +	regulator-vbus-usb20 {
> > +		compatible = "regulator-fixed";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-name = "USB20_5V";
> > +		gpio = <&expander1 14 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +		vin-supply = <&reg_baseboard_vdd5v0>;
> > +	};
> > +
> > +	regulator-vbus-usb30 {
> > +		compatible = "regulator-fixed";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-name = "USB30_5V";
> > +		gpio = <&expander1 12 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +		vin-supply = <&reg_baseboard_vdd5v0>;
> > +	};
> > +
> > +	reg_vdd5v0: regulator-vdd5v0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-name = "VDD_5V";
> > +		gpio = <&expander0 8 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +};
> > +
> > +&eqos {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_eqos>;
> > +	phy-supply = <&reg_baseboard_vdd3v3>;
> > +	phy-handle = <&ethphy0>;
> > +	phy-mode = "rgmii-id";
> > +	status = "okay";
> > +
> > +	mdio {
> > +		compatible = "snps,dwmac-mdio";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		ethphy0: ethernet-phy@0 {
> 
> Unless I'm mistaken, the PHYs are both at address 1. Address 0 works as
> it's the broadcast address, but is there a good reason not to use the
> real address ? Same below.

Didn't verified the phy-addr since it was working after respecting the
power-delays. I will give it a try and assign the correct address.

Regards,
  Marco
