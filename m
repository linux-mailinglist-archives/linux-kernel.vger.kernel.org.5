Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47480A1CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573718AbjLHLGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573699AbjLHLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:05:43 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4B123;
        Fri,  8 Dec 2023 03:05:46 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rBYfp-0005wn-UT; Fri, 08 Dec 2023 12:05:37 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Sam Edwards <cfsworks@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Daniel =?utf-8?B?S3VraWXFgmE=?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Joshua Riek <jjriek@verizon.net>,
        Sam Edwards <CFSworks@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add PCIe pinctrls to Turing RK1
Date:   Fri, 08 Dec 2023 12:05:36 +0100
Message-ID: <6311244.MhkbZ0Pkbq@diego>
In-Reply-To: <20231208062510.893392-1-CFSworks@gmail.com>
References: <20231208062510.893392-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Am Freitag, 8. Dezember 2023, 07:25:10 CET schrieb Sam Edwards:
> The RK3588 PCIe 3.0 controller seems to have unpredictable behavior when
> no CLKREQ/PERST/WAKE pins are configured in the pinmux. In particular, it
> will sometimes (varying between specific RK3588 chips, not over time) shut
> off the DBI block, and reads to this range will instead stall
> indefinitely.
> 
> When this happens, it will prevent Linux from booting altogether. The
> PCIe driver will stall the CPU core once it attempts to read the version
> information from the DBI range.
> 
> Fix this boot hang by adding the correct pinctrl configuration to the
> PCIe 3.0 device node, which is the proper thing to do anyway. While
> we're at it, also add the necessary configuration to the PCIe 2.0 node,
> which may or may not fix the equivalent problem over there -- but is the
> proper thing to do anyway. :)
> 
> Fixes: 2806a69f3fef6 ("arm64: dts: rockchip: Add Turing RK1 SoM support")
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
> 
> Hi list,
> 
> Compared to v1, v2 removes the `reset-gpios` properties as well -- this should
> give control of the PCIe resets exclusively to the PCIe cores. (And even if the
> `reset-gpios` props had no effect in v1, it'd be confusing to have them there.)

Hmm, I'd think this could result in differing behaviour.

I.e. I tried the same on a different board with a nvme drive on the pci30x4
controller. But moving the reset from the gpio-way to "just" setting the
perstn pinctrl, simply hung the controller when probing the device.

So I guess I'd think the best way would be to split the pinctrl up into the
3 separate functions (clkreqn, perstn, waken) so that boards can include
them individually.

Nobody is using the controller pinctrl entries so far anyway :-) .


Heiko


> Note that it is OK for the pcie2x1l1 node to refer to pcie30x1m1_pins. The
> pcie2x1l1 device is *in fact* a PCIe 3.0 controller, and the pcie30x1m1_pins
> pinmux setting is so-named to reflect this. The pcie2x1l1 node is so-named
> because Linux does not (currently) support routing it to a PCIe 3.0 PHY; so in
> practice it is effectively a PCIe 2.0 controller, for the time being.
> 
> Cheers and thank you for your time,
> Sam
> 
> ---
>  .../boot/dts/rockchip/rk3588-turing-rk1.dtsi     | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> index 9570b34aca2e..875446fdb67e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> @@ -214,8 +214,7 @@ rgmii_phy: ethernet-phy@1 {
>  &pcie2x1l1 {
>  	linux,pci-domain = <1>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_reset>;
> -	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> +	pinctrl-0 = <&pcie30x1m1_pins>;
>  	status = "okay";
>  };
>  
> @@ -226,8 +225,7 @@ &pcie30phy {
>  &pcie3x4 {
>  	linux,pci-domain = <0>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_reset>;
> -	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +	pinctrl-0 = <&pcie30x4m1_pins>;
>  	vpcie3v3-supply = <&vcc3v3_pcie30>;
>  	status = "okay";
>  };
> @@ -245,17 +243,7 @@ hym8563_int: hym8563-int {
>  		};
>  	};
>  
> -	pcie2 {
> -		pcie2_reset: pcie2-reset {
> -			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
>  	pcie3 {
> -		pcie3_reset: pcie3-reset {
> -			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
>  		vcc3v3_pcie30_en: pcie3-reg {
>  			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
> 




