Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF698759163
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGSJSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGSJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:18:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368EC9D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:18:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qM3KN-0003zm-MY; Wed, 19 Jul 2023 11:18:35 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qM3KM-00083D-QN; Wed, 19 Jul 2023 11:18:34 +0200
Date:   Wed, 19 Jul 2023 11:18:34 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        dan.scally@ideasonboard.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] arm64: dts: freescale: Add DEBIX SOM A and SOM A
 I/O Board support
Message-ID: <20230719091834.amfmakhwcp6562wu@pengutronix.de>
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
 <20230717165127.2882535-4-m.felsch@pengutronix.de>
 <20230719081615.GQ151430@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719081615.GQ151430@dragon>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 23-07-19, Shawn Guo wrote:
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
> > +		off-on-delay-us = <110000>;
> > +		enable-active-high;
> 
> Can we place this right after the line below?
> 
>   gpio = <&expander0 10 GPIO_ACTIVE_HIGH>;

Sure.

> > +		regulator-always-on;
> > +	};

...

> > +&i2c4 {
> > +	expander0: gpio@20 {
> > +		compatible = "nxp,pca9535";
> > +		reg = <0x20>;
> > +		gpio-controller;
> > +		#gpio-cells = <0x02>;
> > +	};
> > +
> > +	expander1: gpio@23 {
> > +		compatible = "nxp,pca9535";
> > +		reg = <0x23>;
> > +		gpio-controller;
> > +		#gpio-cells = <0x02>;
> > +
> > +		/*
> > +		 * Since USB1 is bound to peripheral mode we need to ensure
> > +		 * that VBUS is turned off.
> > +		 */
> > +		usb30-otg-hog {
> > +			gpio-hog;
> > +			gpios = <13 GPIO_ACTIVE_HIGH>;
> > +			output-low;
> > +			line-name = "USB30_OTG_EN";
> > +		};
> > +	};
> > +
> > +	eeprom@52 {
> > +		compatible = "atmel,24c02";
> > +		reg = <0x52>;
> > +		pagesize = <16>;
> > +	};
> > +
> > +	rtc@51 {
> 
> Sort them in order of unit-address.

Of course, thanks.

> > +		compatible = "haoyu,hym8563";
> > +		reg = <0x51>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_rtc>;
> > +		interrupt-parent = <&gpio4>;
> > +		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> > +		#clock-cells = <0>;
> > +	};
> > +};

> > +&i2c4 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c4>;
> > +	status = "okay";
> > +
> > +	adc@48 {
> > +		 compatible = "ti,ads1115";
> > +		 reg = <0x48>;
> > +
> 
> Unnecessary newline.

Dropped it, thanks.

> > +		 #address-cells = <1>;
> > +		 #size-cells = <0>;
> > +
> > +		 channel@4 {
> > +			 reg = <4>;
> > +			 ti,gain = <1>;
> > +			 ti,datarate = <7>;
> > +		 };
> 
> Have a newline between nodes.

Sure.

Regards,
  Marco
