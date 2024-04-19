Return-Path: <linux-kernel+bounces-151108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35A18AA931
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177171F21BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D7D4779E;
	Fri, 19 Apr 2024 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GvsB4zR6"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A643FBB1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511767; cv=none; b=WM3ZLC2z8tmeLH31gJtNKT1mgigVGcWYeTfH8m+7druTFuPDzREk8HgNDa/p1HwT4M128fTUhn6WPzhUvNSDliW7YUjMyKjTDnpDbERjMk8FJ9N+RdnzLE70pXXktjnKGlMhYKSdLkFNRXej25lRnVFMe9RTdw2T09RmCI8EZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511767; c=relaxed/simple;
	bh=S8DO2HFyYSl1dcSD9FRB2ZOM2NyN8saMkxk/luRtdwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6B+mui539GMcNdourfNIpSLX8F1rrVNUrDHvuME5yswNg316GPNveoaE6h+ALpI6LeWnt425CqOPLnREXWPgeySvXD2BQOAxvCRpFioZ1z90ozmuTyMpd7Xi4Qen/BK4qA5VHOY3sWuPi40qZKLvnXrgsUfPYIYqbHHHVu6eCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=GvsB4zR6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5568bef315so305602366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1713511764; x=1714116564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mElcEKhuLk52w4oq9MFLR6eWNTcnGQX29vGz3K6vKu8=;
        b=GvsB4zR6dzOQ4NYRftjFiNLlOjZ90ZLEvACK7Y+B26ugDBQGQ6VytUyLxbFrZLI4KM
         yKvmLMyN7++ibpQrgfFobFJUJF5pzDUUkjd1Q6d8IAthHnmSE3eB17COM66si6kMLAEb
         PZqDe70MdmNv9VRpnQXG/mTrDuhmir7NPshyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713511764; x=1714116564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mElcEKhuLk52w4oq9MFLR6eWNTcnGQX29vGz3K6vKu8=;
        b=jQ8UXJST5RRKn8SdGUcU5vL5aQpDaGAH+muQ18J/clRCTqrmo2B6zdSFQ8lW3RBK7P
         E4F6+VmMO12rFFeMB5EgbiP0eJkk5knORzmwxAQoqWavhlw0ZTja22lXM/IK78xfIFAn
         GVW4OiWckpWAHg2kjxYZtMxp33XqSF3nUGDcAVwVSBv1Fw+p2U1Vm5Zn0b9AZTLfT2JP
         qsG+DRXr3/8O0QuFmUPDXAoNQMJsiB/Tg0EGbbNKuJdBo+yf+s1pzLBTN/I/zeHfMmkS
         +hcPWJF8/STEG5EI+mkRtj9/wFHDYnbzG03N10ln5RYyvMuv2fDVuuhpytjU8hxZ8FWE
         b8IA==
X-Forwarded-Encrypted: i=1; AJvYcCWwRMCAqZTfVTZICAzfReNCReda3RDeDd/gbXd/nsp73iZFPUVE0QeQQh9V5Mae3k4OK2GDbjPyJ2cARsuN17DJ6ouaqsnEXIdCSoDF
X-Gm-Message-State: AOJu0Ywfj6nO8E7Re3oVQflGEHi9lBnMcg+BDEfLojJRGiCtEp7B/SHk
	lrZnVdwU64e3V07R5lCoqs9Qw6vGTbXNMhocZqQNLgiFAyrHOJ5nPPtx5ENjcvr3U1ryQ//lrHm
	VpeRmKwVnkQe/sFtqw3+Hsny6rGJBLW7XnZNh6w==
X-Google-Smtp-Source: AGHT+IFvXL5mXipH36N+6mGBKq6I3EEwZw9bJxy5jGM+9DUiRF3PSsTJCVa53BWXJrQWoHfZi4MxqLBj8Cm/a1cLdIg=
X-Received: by 2002:a17:906:68cc:b0:a52:3451:8a18 with SMTP id
 y12-20020a17090668cc00b00a5234518a18mr1320987ejr.29.1713511763595; Fri, 19
 Apr 2024 00:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418133923.3705-1-fabio.aiuto@engicam.com> <20240418133923.3705-4-fabio.aiuto@engicam.com>
In-Reply-To: <20240418133923.3705-4-fabio.aiuto@engicam.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 19 Apr 2024 09:29:12 +0200
Message-ID: <CAOf5uwmy_3NOupkroYX=W2WJKK1sgg0r0L22fOrbbZ3Z6z1jFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM
 2.0 Starter Kit
To: Fabio Aiuto <fabio.aiuto@engicam.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Matteo Lisi <matteo.lisi@engicam.com>, Mirko Ardinghi <mirko.ardinghi@engicam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fabio

On Thu, Apr 18, 2024 at 3:43=E2=80=AFPM Fabio Aiuto <fabio.aiuto@engicam.co=
m> wrote:
>
> i.Core MX93 is a NXP i.MX93 based SoM by Enigcam which
> needs to be mounted on top of Engicam baseboards.
>
> Add support for EDIMM 2.0 Starter Kit hosting
> i.Core MX93.
>
> Starter Kit main features:
>
> 2x LVDS interfaces
> HDMI output
> Audio out
> Mic in
> Micro SD card slot
> USB 3.0 A port
> 3x USB 2.0 A port
> Gb Ethernet
> 2x CAN bus, 3x UART interfaces
> SIM card slot
> M.2 KEY_B slot
>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx93-icore-mx93-edimm2.dts | 354 ++++++++++++++++++
>  2 files changed, 355 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2=
dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts=
/freescale/Makefile
> index 045250d0a040..d26c0a458a44 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -226,6 +226,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-tqma8xqp-mba8xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-icore-mx93-edimm2.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-segin.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxla.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts b/=
arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
> new file mode 100644
> index 000000000000..8d57374eebdf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 NXP
> + * Copyright 2024 Engicam s.r.l.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx93-icore-mx93.dtsi"
> +
> +/ {
> +       model =3D "Engicam i.Core MX93 - EDIMM 2 Starterkit";
> +       compatible =3D "engicam,icore-mx93-edimm2", "engicam,icore-mx93",
> +                    "fsl,imx93";
> +
> +       aliases {
> +               rtc1 =3D &bbnsm_rtc;
> +       };
> +
> +       bt_reg_on: regulator-btregon {
> +               compatible =3D "regulator-gpio";
> +               regulator-name =3D "BT_REG_ON";
> +               pinctrl-names =3D "default";
> +               regulator-min-microvolt =3D <100000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               states =3D <3300000 0x1>, <100000 0x0>;
> +               gpios =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +               regulator-always-on;
> +       };
> +

Are you sure about regulator always on? I have seen that you broadcom
wifi and bluetooth connected. Same comment for the other
patches where you have almost all the regulator boot on , always on. I
can not be sure that is really true

Please take a look here
arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi

Michael

> +       chosen {
> +               stdout-path =3D &lpuart1;
> +       };
> +
> +       reg_1v8_sgtl: regulator-1v8-sgtl {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "1v8_sgtl";
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +               always-on;
> +       };
> +
> +       reg_3v3_avdd_sgtl: regulator-3v3-avdd-sgtl {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "3v3_avdd_sgtl";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               always-on;
> +       };
> +
> +       reg_3v3_sgtl: regulator-3v3-sgtl {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "3v3_sgtl";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               always-on;
> +       };
> +
> +       reserved-memory {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +
> +               linux,cma {
> +                       compatible =3D "shared-dma-pool";
> +                       reusable;
> +                       alloc-ranges =3D <0 0x80000000 0 0x40000000>;
> +                       size =3D <0 0x10000000>;
> +                       linux,cma-default;
> +               };
> +
> +               rsc_table: rsc-table@2021f000 {
> +                       reg =3D <0 0x2021f000 0 0x1000>;
> +                       no-map;
> +               };
> +
> +               vdevbuffer: vdevbuffer@a4020000 {
> +                       compatible =3D "shared-dma-pool";
> +                       reg =3D <0 0xa4020000 0 0x100000>;
> +                       no-map;
> +               };
> +
> +               vdev0vring0: vdev0vring0@a4000000 {
> +                       reg =3D <0 0xa4000000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev0vring1: vdev0vring1@a4008000 {
> +                       reg =3D <0 0xa4008000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev1vring0: vdev1vring0@a4000000 {
> +                       reg =3D <0 0xa4010000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev1vring1: vdev1vring1@a4018000 {
> +                       reg =3D <0 0xa4018000 0 0x8000>;
> +                       no-map;
> +               };
> +       };
> +
> +       sound {
> +               compatible =3D "simple-audio-card";
> +               simple-audio-card,name =3D "imx93-sgtl5000";
> +               simple-audio-card,format =3D "i2s";
> +               simple-audio-card,bitclock-master =3D <&dailink_master>;
> +               simple-audio-card,frame-master =3D <&dailink_master>;
> +               /*simple-audio-card,mclk-fs =3D <1>;*/
> +               simple-audio-card,cpu {
> +                       sound-dai =3D <&sai3>;
> +               };
> +
> +               dailink_master: simple-audio-card,codec {
> +                       sound-dai =3D <&sgtl5000>;
> +                       clocks =3D <&clk IMX93_CLK_SAI3_IPG>;
> +               };
> +       };
> +
> +       usdhc3_pwrseq: usdhc3-pwrseq {
> +               compatible =3D "mmc-pwrseq-simple";
> +       };
> +
> +       wl_reg_on: regulator-wlregon {
> +               compatible =3D "regulator-gpio";
> +               pinctrl-names =3D "default";
> +               regulator-name =3D "WL_REG_ON";
> +               regulator-min-microvolt =3D <100000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               states =3D <3300000 0x1>,
> +                                <100000 0x0>;
> +               gpios =3D <&gpio2 22 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               vin-supply =3D <&bt_reg_on>;
> +       };
> +};
> +
> +&cm33 {
> +       mbox-names =3D "tx", "rx", "rxdb";
> +       mboxes =3D <&mu1 0 1>,
> +                <&mu1 1 1>,
> +                <&mu1 3 1>;
> +       memory-region =3D <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> +                       <&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> +       status =3D "okay";
> +};
> +
> +&flexcan1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_flexcan1>;
> +       fsl,stop-mode =3D <&aonmix_ns_gpr 0x10 4>;
> +       status =3D "okay";
> +};
> +
> +&flexcan2 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_flexcan2>;
> +       fsl,stop-mode =3D <&aonmix_ns_gpr 0x10 4>;
> +       status =3D "okay";
> +};
> +
> +&lpi2c1 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       clock-frequency =3D <400000>;
> +       pinctrl-names =3D "default", "sleep";
> +       pinctrl-0 =3D <&pinctrl_lpi2c1>;
> +       pinctrl-1 =3D <&pinctrl_lpi2c1>;
> +       status =3D "okay";
> +
> +       pcf8523: rtc@68 {
> +               compatible =3D "nxp,pcf8523";
> +               reg =3D <0x68>;
> +       };
> +
> +       sgtl5000: codec@a {
> +               compatible =3D "fsl,sgtl5000";
> +               status =3D "okay";
> +               #sound-dai-cells =3D <0>;
> +               reg =3D <0x0a>;
> +               clocks =3D <&clk IMX93_CLK_SAI3_GATE>;
> +               clock-names =3D "mclk";
> +               assigned-clock-rates =3D <12000000>, <12000000>;
> +               VDDA-supply =3D <&reg_3v3_avdd_sgtl>;
> +               VDDIO-supply =3D <&reg_3v3_sgtl>;
> +               VDDD-supply =3D <&reg_1v8_sgtl>;
> +       };
> +};
> +
> +&lpuart1 { /* console */
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart1>;
> +       status =3D "okay";
> +};
> +
> +&lpuart5 { /* RS485 */
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart5>;
> +       status =3D "okay";
> +};
> +
> +&lpuart8 { /* RS232 */
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart8>;
> +       status =3D "okay";
> +};
> +
> +&micfil {
> +       #sound-dai-cells =3D <0>;
> +       pinctrl-names =3D "default";
> +       assigned-clocks =3D <&clk IMX93_CLK_PDM>;
> +       assigned-clock-parents =3D <&clk IMX93_CLK_AUDIO_PLL>;
> +       assigned-clock-rates =3D <196608000>;
> +       status =3D "okay";
> +};
> +
> +&mu1 {
> +       status =3D "okay";
> +};
> +
> +&mu2 {
> +       status =3D "okay";
> +};
> +
> +&sai1 {
> +       #sound-dai-cells =3D <0>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_sai1>;
> +       assigned-clocks =3D <&clk IMX93_CLK_SAI1>;
> +       assigned-clock-parents =3D <&clk IMX93_CLK_AUDIO_PLL>;
> +       assigned-clock-rates =3D <12288000>;
> +       status =3D "okay";
> +};
> +
> +&sai3 {
> +       pinctrl-names =3D "default";
> +       #sound-dai-cells =3D <0>;
> +       pinctrl-0 =3D <&pinctrl_sai3>;
> +       assigned-clocks =3D <&clk IMX93_CLK_SAI3>;
> +       assigned-clock-parents =3D <&clk IMX93_CLK_AUDIO_PLL>;
> +       assigned-clock-rates =3D <24576000>;
> +       fsl,sai-mclk-direction-output;
> +       status =3D "okay";
> +};
> +
> +&usdhc3 { /* WiFi */
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc3>, <&pinctrl_laird>;
> +       pinctrl-1 =3D <&pinctrl_usdhc3>, <&pinctrl_laird>;
> +       pinctrl-2 =3D <&pinctrl_usdhc3>, <&pinctrl_laird>;
> +       vmmc-supply =3D <&wl_reg_on>;
> +       bus-width =3D <4>;
> +       no-1-8-v;
> +       non-removable;
> +       max-frequency =3D <25000000>;
> +       status =3D "okay";
> +
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +
> +       brcmf: bcrmf@1 {
> +               reg =3D <1>;
> +               compatible =3D "brcm,bcm4329-fmac";
> +       };
> +};
> +
> +&wdog3 {
> +       status =3D "okay";
> +};
> +
> +&iomuxc {
> +
> +       pinctrl_flexcan1: flexcan1grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_PDM_CLK__CAN1_TX               0x139e
> +                       MX93_PAD_PDM_BIT_STREAM0__CAN1_RX       0x139e
> +               >;
> +       };
> +
> +       pinctrl_flexcan2: flexcan2grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_GPIO_IO25__CAN2_TX     0x139e
> +                       MX93_PAD_GPIO_IO27__CAN2_RX     0x139e
> +               >;
> +       };
> +
> +       pinctrl_laird: lairdgrp {
> +               fsl,pins =3D <
> +                       MX93_PAD_GPIO_IO22__GPIO2_IO22          0x31e // =
WL_REG_ON
> +                       MX93_PAD_GPIO_IO19__GPIO2_IO19          0x31e // =
BT_REG_ON
> +               >;
> +       };
> +
> +       pinctrl_lpi2c1: lpi2c1grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_I2C1_SCL__LPI2C1_SCL           0x40000b9=
e
> +                       MX93_PAD_I2C1_SDA__LPI2C1_SDA           0x40000b9=
e
> +               >;
> +       };
> +
> +       pinctrl_sai1: sai1grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_SAI1_TXC__SAI1_TX_BCLK         0x31e
> +                       MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC        0x31e
> +                       MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00      0x31e
> +                       MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00      0x31e
> +               >;
> +       };
> +
> +       pinctrl_sai3: sai3grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_GPIO_IO26__SAI3_TX_SYNC        0x31e
> +                       MX93_PAD_GPIO_IO16__SAI3_TX_BCLK        0x31e
> +                       MX93_PAD_GPIO_IO17__SAI3_MCLK           0x31e
> +                       MX93_PAD_GPIO_IO21__SAI3_TX_DATA00      0x31e
> +                       MX93_PAD_GPIO_IO20__SAI3_RX_DATA00      0x31e
> +               >;
> +       };
> +
> +       pinctrl_uart1: uart1grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_UART1_RXD__LPUART1_RX          0x31e
> +                       MX93_PAD_UART1_TXD__LPUART1_TX          0x31e
> +               >;
> +       };
> +
> +       pinctrl_uart5: uart5grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_GPIO_IO01__LPUART5_RX          0x31e
> +                       MX93_PAD_GPIO_IO00__LPUART5_TX          0x31e
> +                       MX93_PAD_GPIO_IO02__LPUART5_CTS_B       0x31e
> +                       MX93_PAD_GPIO_IO03__LPUART5_RTS_B       0x31e
> +               >;
> +       };
> +
> +       pinctrl_uart8: uart8grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_GPIO_IO13__LPUART8_RX          0x31e
> +                       MX93_PAD_GPIO_IO12__LPUART8_TX          0x31e
> +               >;
> +       };
> +
> +       pinctrl_usdhc3: usdhc3grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_SD3_CLK__USDHC3_CLK            0x17fe
> +                       MX93_PAD_SD3_CMD__USDHC3_CMD            0x13fe
> +                       MX93_PAD_SD3_DATA0__USDHC3_DATA0        0x13fe
> +                       MX93_PAD_SD3_DATA1__USDHC3_DATA1        0x13fe
> +                       MX93_PAD_SD3_DATA2__USDHC3_DATA2        0x13fe
> +                       MX93_PAD_SD3_DATA3__USDHC3_DATA3        0x13fe
> +               >;
> +       };
> +};
> --
> 2.34.1
>
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

