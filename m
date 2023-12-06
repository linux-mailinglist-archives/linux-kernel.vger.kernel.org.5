Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB2A80731C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378998AbjLFO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442161AbjLFOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:55:54 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BDD46;
        Wed,  6 Dec 2023 06:55:58 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rAtJZ-0002pK-BA; Wed, 06 Dec 2023 15:55:53 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Sam Edwards <cfsworks@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Daniel =?utf-8?B?S3VraWXFgmE=?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Joshua Riek <jjriek@verizon.net>,
        Sam Edwards <CFSworks@gmail.com>
Subject: Re: [RESEND PATCH] arm64: dts: rockchip: Add PCIe pinctrls to Turing RK1
Date:   Wed, 06 Dec 2023 15:55:52 +0100
Message-ID: <3331042.e9J7NaK4W3@diego>
In-Reply-To: <20231205202900.4617-1-CFSworks@gmail.com>
References: <20231205202900.4617-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. Dezember 2023, 21:28:59 CET schrieb Sam Edwards:
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
>  .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> index 9570b34aca2e..129f14dbd42f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> @@ -214,7 +214,7 @@ rgmii_phy: ethernet-phy@1 {
>  &pcie2x1l1 {
>  	linux,pci-domain = <1>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_reset>;
> +	pinctrl-0 = <&pcie30x1m1_pins>;
>  	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
>  	status = "okay";
>  };
> @@ -226,7 +226,7 @@ &pcie30phy {
>  &pcie3x4 {
>  	linux,pci-domain = <0>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_reset>;
> +	pinctrl-0 = <&pcie30x4m1_pins>;

also, why are you throwing out the pinctrl for the reset pin.
That seems not related to the regular pins and you could instead just do

+	pinctrl-0 = <&pcie30x4m1_pins>, <&pcie3_reset>;

Thanks
Heiko

>  	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply = <&vcc3v3_pcie30>;
>  	status = "okay";
> @@ -245,17 +245,7 @@ hym8563_int: hym8563-int {
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




