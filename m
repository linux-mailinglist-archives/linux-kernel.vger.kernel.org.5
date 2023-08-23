Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A71A785F21
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbjHWSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbjHWSD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:03:56 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9710C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 11:03:49 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C29C62049E;
        Wed, 23 Aug 2023 20:03:46 +0200 (CEST)
Date:   Wed, 23 Aug 2023 20:03:44 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: Add Sony Xperia 10 V (PDX235)
 support
Message-ID: <kg6c5bkic3zbytfb67ed3honq6fyfl4vwya5blaozpljuyggpt@2pqdwgmnjaj3>
References: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
 <20230818-topic-10v-v1-5-dbb6464223c6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-topic-10v-v1-5-dbb6464223c6@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-18 17:23:28, Konrad Dybcio wrote:
> 10 V is a carbon copy of the 10 IV, sans:
> 
> - camera setup (V obviously has a new, better one)
> - the phone's body and SIM/sdcard tray changed a bit
> - SM5038 is gone, PMIC QGauge is used for battery monitoring
> - some wires may be routed differently (e.g. i2c devices are routed to
>   different hosts)
> - possibly some small other differences that we're about to discover
> 
> Introduce support for PDX235, currently requiring zero changes other
> than adding msm-id and board-id, which seems to be the result of Sony
> (or their chinese ODM) fusing in a non-zero value in there..
> 
> All of the flashing and prepwork shenanigans described in
> Commit 4420e60416cb ("arm64: dts: qcom: Add device tree for Sony Xperia
> 10 IV") are also necessary on this device :/
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |  1 +
>  .../dts/qcom/sm6375-sony-xperia-murray-pdx235.dts  | 54 ++++++++++++++++++++++

I just learned that the new device actually has a slightly different
board, with codename zambezi:

https://github.com/sonyxperiadev/kernel-copyleft-dts/blob/68.0.A.0.xxx/somc/blair-zambezi-pdx235_common.dtsi

How do you want to represent that?  We could have:

    sm6375-sony-xperia(-common?).dtsi
    sm6375-sony-xperia-murray-pdx225.dts
    sm6375-sony-xperia-zambezi-pdx235.dts

So that you can still keep 95% of the common configuration in the same
file, but without pretending that pdx235 uses the murray board.

- Marijn

>  .../boot/dts/qcom/sm6375-sony-xperia-murray.dtsi   |  2 +-
>  3 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2cca20563a1d..832b4acb20dd 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -196,6 +196,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx235.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx235.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx235.dts
> new file mode 100644
> index 000000000000..80a61961e5c5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx235.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Konrad Dybcio <konrad.dybcio@linaro.org>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/arm/qcom,ids.h>
> +
> +#include "sm6375-sony-xperia-murray.dtsi"
> +
> +/ {
> +	model = "Sony Xperia 10 V";
> +	compatible = "sony,pdx235", "qcom,sm6375";
> +	chassis-type = "handset";
> +	qcom,msm-id = <QCOM_ID_SM6375 0x10000>;
> +	qcom,board-id = <QCOM_BOARD_ID(QRD, 0x1, 0x0) 0x0>;
> +
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c7;
> +		i2c2 = &i2c10;
> +		i2c3 = &i2c8;
> +	};
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* NXP SN2x0 NFC @ 28. (or on &spi2.. TBD!) */
> +};
> +
> +&i2c7 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Awinic AW882xx audio amplifier ("channel 0") @ 34 */
> +};
> +
> +/* I2C8 inherited from common DTSI */
> +
> +&i2c10 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Awinic AW882xx audio amplifier ("channel 1") @ 34 */
> +	/* PM8008 @ 8, 9 */
> +};
> +
> +/* For reasons yet unknown, it's broken on the mark V.. */
> +&touchscreen {
> +	status = "fail";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi
> index 072f7ce2a7f6..243e60d9bbb5 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi
> @@ -123,7 +123,7 @@ &i2c8 {
>  	clock-frequency = <400000>;
>  	status = "okay";
>  
> -	touchscreen@48 {
> +	touchscreen: touchscreen@48 {
>  		compatible = "samsung,s6sy761";
>  		reg = <0x48>;
>  		interrupt-parent = <&tlmm>;
> 
> -- 
> 2.41.0
> 
