Return-Path: <linux-kernel+bounces-146699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAC88A6982
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25C1B21CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE61128834;
	Tue, 16 Apr 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1YzWqHS"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037186259;
	Tue, 16 Apr 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266318; cv=none; b=XQfJ8P3vNyaax/uOkY/CeUvZ+4ei6/6MeVuYBvO6k3KreJ5GAUCjIPo9Ok331h5FXaQvzZ4f8tbQrEdPOaNXFtUwurYvmeDZeOYXja5wNt98aMfr6EFpckVFfYLGf9Sj48HUG9q+GPuB5JZnRPgVXgMWE4msTZ6bFKH85Syxa3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266318; c=relaxed/simple;
	bh=kpQ1yuDjttfNfP4+fmCQ5YPN2/gdTzBoERqWcQ7bhJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzLLOhM2LRrMblxIEd8cc0cWB9bEucOvY5AprR+DhaJAw5XONbKnXw01mubt0CDFgxijpl1hBa0dboZpAW3lx1CmqZghf7Y5IQMvc7aGZZhfwK0qh2ffXoIcl2CEwh9R22jYVYRBM/kxfnnLCKZJ8bc53ngIMtvlEtKMSZaXHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1YzWqHS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57042f84cabso809343a12.2;
        Tue, 16 Apr 2024 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713266314; x=1713871114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+xoXI6wDSPeQ9KXnenP6ksJjguTa3RR9PTO48E5G8Y=;
        b=P1YzWqHSlZCko4hc06QnnBCRuPuRob6r6hYJX/7zutVDbphLxLaEhAoPOsOXnBVSbf
         mt+q+TIsRqEKvE6n+W7exsimGsNexSMK12ChW1MRD3Cp9wWrQUO4Begx0JoxxXAYQ48N
         M5bakEkJUlpnezcxuBjfzW9B0+RX+hxZMd6lIFBkM0GqSXTno/e+mt1XZ/fEAsDAjNxJ
         UF5tZSa3uo+V6DTja8d8HcPOe2W6I7Pif+jBphB8m3DE9pS1IIz3pE7m8ocnZ6Jf/g3o
         3J5NmwZJrJR0fJpnm2RnxElsJUhko1R2DUITPS/OQLljFXkFaZUFDpdWPbmlx3UQERM2
         YY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713266314; x=1713871114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+xoXI6wDSPeQ9KXnenP6ksJjguTa3RR9PTO48E5G8Y=;
        b=Sao1uN5mEz4baDEsHPfvwSKuizQd3h4qaMsUxX3NioQGLPrD1vGsHDq/TPJtCfD4sq
         wFPjKVewSie5vyexubbRl+yWekBZcOarJzJPZzEsg9uVJvj9ENP9dmxmmzDVnx4MsYC1
         2KxRN2mqY7SJSNBJdp9LoeRU+iPFN1B2bZCNg2H1AYoIctQqdAfs7K2FuXD7sx25Ty4Z
         CgyTcpPIoxmreXvHfZ8U2TRPL3qR9+IGKhnLJsbnGrkKNn3SJFRcgUMBcEBFxffm6RNv
         FpFfhZNaOfUcSEJCdlq5rdK44y1ZrBgOGBYIL1sogD+gR6OCb9D2CKBp/GcfLOr0bZjt
         ZGrw==
X-Forwarded-Encrypted: i=1; AJvYcCWP6Qx0LXonMaj/z6lB5+CNDoFSeavSR4SwIelJi0Taocyudma+V1dDC/+c9mWlOo3kNFI7Ij/2o6sTI/3qD2ttrlcrM16d8Y/LzLEI
X-Gm-Message-State: AOJu0YwVXvtXPmruSYi0qQRczSKRMImAsX3hJMPYJ5xQQmyAoFP2e13V
	ItdqDphZY9iwWT9LvCVufZauOv+CrTIMlqaIiep2/WjwHFVE5YGgBUgjJmBpQs/KwOUlUL+XpOb
	rcHBNe/v3TUMOemNB2Y+wMcpy1B8=
X-Google-Smtp-Source: AGHT+IG/QCOY+uHYrMmSTbhmuvcvfxKiVeKzU7GtkdKMvWNWYEFUoL2UkhpZzFM5F5xYDEfeEvoGKE0vJ4plEaP4OFA=
X-Received: by 2002:a50:9b1e:0:b0:568:bfcd:e895 with SMTP id
 o30-20020a509b1e000000b00568bfcde895mr8459679edi.41.1713266313976; Tue, 16
 Apr 2024 04:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416034626.317823-1-liujianfeng1994@gmail.com> <20240416034626.317823-4-liujianfeng1994@gmail.com>
In-Reply-To: <20240416034626.317823-4-liujianfeng1994@gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Tue, 16 Apr 2024 19:18:22 +0800
Message-ID: <CAHk0HotDt0MCoU12eFD9f6-7y1Vmjijjx_jbQd3WiyT=tofypg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: rockchip: Add ArmSom Sige7 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	sfr@canb.auug.org.au, weizhao.ouyang@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:46=E2=80=AFAM Jianfeng Liu <liujianfeng1994@gmai=
l.com> wrote:
>
> Specification:
>         Rockchip Rk3588 SoC
>         4x ARM Cortex-A76, 4x ARM Cortex-A55
>         8/16/32GB Memory LPDDR4/LPDDR4x
>         Mali G610MP4 GPU
>         2=C3=97 MIPI-CSI Connector
>         1=C3=97 MIPI-DSI Connector
>         1x M.2 Key M (PCIe 3.0 4-lanes)
>         2x RTL8125 2.5G Ethernet
>         Onboard AP6275P for WIFI6/BT5
>         32GB/64GB/128GB eMMC
>         MicroSD card slot
>         1x USB2.0, 1x USB3.0 Type-A, 1x US3.0 Type-C
>         1x HDMI Output, 1x type-C DP Output
>
> Functions work normally:
>         USB2.0 Host
>         USB3.0 Type-A Host
>         M.2 Key M (PCIe 3.0 4-lanes)
>         2x RTL8125 2.5G Ethernet
>         eMMC
>         MicroSD card
>
> More information can be obtained from the following website
>         https://docs.armsom.org/armsom-sige7
>
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

nit: RK3588 GPU and USB-DP support is in the linux-rockchip tree and
waiting for the next merge window.
Other looks good to me.

Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>

BR,
Weizhao

> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 724 ++++++++++++++++++
>  2 files changed, 725 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/=
rockchip/Makefile
> index 7da198be8..0624c7284 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -111,6 +111,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5-io-expander.dtbo
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-armsom-sige7.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-coolpi-cm5-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-edgeble-neu6a-io.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-edgeble-neu6a-wifi.dtbo
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/=
arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
> new file mode 100644
> index 000000000..f1fc7cc48
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
> @@ -0,0 +1,724 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include "rk3588.dtsi"
> +
> +/ {
> +       model =3D "ArmSoM Sige7";
> +       compatible =3D "armsom,sige7", "rockchip,rk3588";
> +
> +       aliases {
> +               mmc0 =3D &sdhci;
> +               mmc1 =3D &sdmmc;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial2:1500000n8";
> +       };
> +
> +       analog-sound {
> +               compatible =3D "audio-graph-card";
> +               label =3D "rk3588-es8316";
> +
> +               widgets =3D "Microphone", "Mic Jack",
> +                         "Headphone", "Headphones";
> +
> +               routing =3D "MIC2", "Mic Jack",
> +                         "Headphones", "HPOL",
> +                         "Headphones", "HPOR";
> +
> +               dais =3D <&i2s0_8ch_p0>;
> +               hp-det-gpio =3D <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&hp_detect>;
> +       };
> +
> +       leds {
> +               compatible =3D "gpio-leds";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&led_rgb_b>;
> +
> +               led_blue: led-0 {
> +                       function =3D LED_FUNCTION_STATUS;
> +                       color =3D <LED_COLOR_ID_BLUE>;
> +                       gpios =3D <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger =3D "heartbeat";
> +               };
> +
> +               led_red: led-1 {
> +                       function =3D LED_FUNCTION_STATUS;
> +                       color =3D <LED_COLOR_ID_RED>;
> +                       gpios =3D <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger =3D "none";
> +               };
> +       };
> +
> +       fan: pwm-fan {
> +               compatible =3D "pwm-fan";
> +               cooling-levels =3D <0 95 145 195 255>;
> +               fan-supply =3D <&vcc5v0_sys>;
> +               pwms =3D <&pwm1 0 50000 0>;
> +               #cooling-cells =3D <2>;
> +       };
> +
> +       vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc3v3_pcie2x1l2";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               startup-delay-us =3D <5000>;
> +               vin-supply =3D <&vcc_3v3_s3>;
> +       };
> +
> +       vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> +               compatible =3D "regulator-fixed";
> +               enable-active-high;
> +               gpios =3D <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> +               regulator-name =3D "vcc3v3_pcie30";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               startup-delay-us =3D <5000>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_host: vcc5v0-host-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc5v0_host";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               enable-active-high;
> +               gpio =3D <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&vcc5v0_host_en>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_sys: vcc5v0-sys-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc5v0_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +       };
> +
> +       vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc_1v1_nldo_s3";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <1100000>;
> +               regulator-max-microvolt =3D <1100000>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +       };
> +};
> +
> +&combphy0_ps {
> +       status =3D "okay";
> +};
> +
> +&combphy1_ps {
> +       status =3D "okay";
> +};
> +
> +&combphy2_psu {
> +       status =3D "okay";
> +};
> +
> +&cpu_b0 {
> +       cpu-supply =3D <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b1 {
> +       cpu-supply =3D <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +       cpu-supply =3D <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +       cpu-supply =3D <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_l0 {
> +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> +};
> +
> +&gpu {
> +       mali-supply =3D <&vdd_gpu_s0>;
> +       status =3D "okay";
> +};
> +
> +&i2c0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c0m2_xfer>;
> +       status =3D "okay";
> +
> +       vdd_cpu_big0_s0: regulator@42 {
> +               compatible =3D "rockchip,rk8602";
> +               reg =3D <0x42>;
> +               fcs,suspend-voltage-selector =3D <1>;
> +               regulator-name =3D "vdd_cpu_big0_s0";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <550000>;
> +               regulator-max-microvolt =3D <1050000>;
> +               regulator-ramp-delay =3D <2300>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +
> +       vdd_cpu_big1_s0: regulator@43 {
> +               compatible =3D "rockchip,rk8603", "rockchip,rk8602";
> +               reg =3D <0x43>;
> +               fcs,suspend-voltage-selector =3D <1>;
> +               regulator-name =3D "vdd_cpu_big1_s0";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <550000>;
> +               regulator-max-microvolt =3D <1050000>;
> +               regulator-ramp-delay =3D <2300>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +};
> +
> +&i2c6 {
> +       status =3D "okay";
> +
> +       hym8563: rtc@51 {
> +               compatible =3D "haoyu,hym8563";
> +               reg =3D <0x51>;
> +               #clock-cells =3D <0>;
> +               clock-output-names =3D "hym8563";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&hym8563_int>;
> +               interrupt-parent =3D <&gpio0>;
> +               interrupts =3D <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +               wakeup-source;
> +       };
> +};
> +
> +&i2c7 {
> +       status =3D "okay";
> +
> +       es8316: audio-codec@11 {
> +               compatible =3D "everest,es8316";
> +               reg =3D <0x11>;
> +               clocks =3D <&cru I2S0_8CH_MCLKOUT>;
> +               clock-names =3D "mclk";
> +               assigned-clocks =3D <&cru I2S0_8CH_MCLKOUT>;
> +               assigned-clock-rates =3D <12288000>;
> +               #sound-dai-cells =3D <0>;
> +
> +               port {
> +                       es8316_p0_0: endpoint {
> +                               remote-endpoint =3D <&i2s0_8ch_p0_0>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2s0_8ch {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2s0_lrck
> +                    &i2s0_mclk
> +                    &i2s0_sclk
> +                    &i2s0_sdi0
> +                    &i2s0_sdo0>;
> +       status =3D "okay";
> +
> +       i2s0_8ch_p0: port {
> +               i2s0_8ch_p0_0: endpoint {
> +                       dai-format =3D "i2s";
> +                       mclk-fs =3D <256>;
> +                       remote-endpoint =3D <&es8316_p0_0>;
> +               };
> +       };
> +};
> +
> +/* phy1 - right ethernet port */
> +&pcie2x1l0 {
> +       reset-gpios =3D <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +       status =3D "okay";
> +};
> +
> +/* phy2 - WiFi */
> +&pcie2x1l1 {
> +       reset-gpios =3D <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
> +       status =3D "okay";
> +};
> +
> +/* phy0 - left ethernet port */
> +&pcie2x1l2 {
> +       reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> +       status =3D "okay";
> +};
> +
> +&pcie30phy {
> +       status =3D "okay";
> +};
> +
> +&pcie3x4 {
> +       reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +       vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> +       status =3D "okay";
> +};
> +
> +&pinctrl {
> +       hym8563 {
> +               hym8563_int: hym8563-int {
> +                       rockchip,pins =3D <0 RK_PB0 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +       };
> +
> +       leds {
> +               led_rgb_b: led-rgb-b {
> +                       rockchip,pins =3D <0 RK_PB7 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +               led_rgb_r: led-rgb-r {
> +                       rockchip,pins =3D <0 RK_PB7 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +       };
> +
> +       sound {
> +               hp_detect: hp-detect {
> +                       rockchip,pins =3D <1 RK_PD5 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +       };
> +
> +       usb {
> +               vcc5v0_host_en: vcc5v0-host-en {
> +                       rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +       };
> +};
> +
> +&pwm1 {
> +       status =3D "okay";
> +};
> +
> +&saradc {
> +       vref-supply =3D <&avcc_1v8_s0>;
> +       status =3D "okay";
> +};
> +
> +&sdhci {
> +       bus-width =3D <8>;
> +       no-sdio;
> +       no-sd;
> +       non-removable;
> +       mmc-hs200-1_8v;
> +       status =3D "okay";
> +};
> +
> +&sdmmc {
> +       max-frequency =3D <200000000>;
> +       no-sdio;
> +       no-mmc;
> +       bus-width =3D <4>;
> +       cap-mmc-highspeed;
> +       cap-sd-highspeed;
> +       disable-wp;
> +       sd-uhs-sdr104;
> +       vmmc-supply =3D <&vcc_3v3_s3>;
> +       vqmmc-supply =3D <&vccio_sd_s0>;
> +       status =3D "okay";
> +};
> +
> +&spi2 {
> +       status =3D "okay";
> +       assigned-clocks =3D <&cru CLK_SPI2>;
> +       assigned-clock-rates =3D <200000000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&spi2m2_cs0 &spi2m2_pins>;
> +       num-cs =3D <1>;
> +
> +       pmic@0 {
> +               compatible =3D "rockchip,rk806";
> +               spi-max-frequency =3D <1000000>;
> +               reg =3D <0x0>;
> +
> +               interrupt-parent =3D <&gpio0>;
> +               interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pmic_pins>, <&rk806_dvs1_null>,
> +                           <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +
> +               system-power-controller;
> +
> +               vcc1-supply =3D <&vcc5v0_sys>;
> +               vcc2-supply =3D <&vcc5v0_sys>;
> +               vcc3-supply =3D <&vcc5v0_sys>;
> +               vcc4-supply =3D <&vcc5v0_sys>;
> +               vcc5-supply =3D <&vcc5v0_sys>;
> +               vcc6-supply =3D <&vcc5v0_sys>;
> +               vcc7-supply =3D <&vcc5v0_sys>;
> +               vcc8-supply =3D <&vcc5v0_sys>;
> +               vcc9-supply =3D <&vcc5v0_sys>;
> +               vcc10-supply =3D <&vcc5v0_sys>;
> +               vcc11-supply =3D <&vcc_2v0_pldo_s3>;
> +               vcc12-supply =3D <&vcc5v0_sys>;
> +               vcc13-supply =3D <&vcc_1v1_nldo_s3>;
> +               vcc14-supply =3D <&vcc_1v1_nldo_s3>;
> +               vcca-supply =3D <&vcc5v0_sys>;
> +
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               rk806_dvs1_null: dvs1-null-pins {
> +                       pins =3D "gpio_pwrctrl1";
> +                       function =3D "pin_fun0";
> +               };
> +
> +               rk806_dvs2_null: dvs2-null-pins {
> +                       pins =3D "gpio_pwrctrl2";
> +                       function =3D "pin_fun0";
> +               };
> +
> +               rk806_dvs3_null: dvs3-null-pins {
> +                       pins =3D "gpio_pwrctrl3";
> +                       function =3D "pin_fun0";
> +               };
> +
> +               regulators {
> +                       vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <550000>;
> +                               regulator-max-microvolt =3D <950000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_gpu_s0";
> +                               regulator-enable-ramp-delay =3D <400>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <550000>;
> +                               regulator-max-microvolt =3D <950000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_cpu_lit_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_log_s0: dcdc-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <675000>;
> +                               regulator-max-microvolt =3D <750000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_log_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
750000>;
> +                               };
> +                       };
> +
> +                       vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <550000>;
> +                               regulator-max-microvolt =3D <950000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_vdenc_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_ddr_s0: dcdc-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <675000>;
> +                               regulator-max-microvolt =3D <900000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_ddr_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
850000>;
> +                               };
> +                       };
> +
> +                       vdd2_ddr_s3: dcdc-reg6 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-name =3D "vdd2_ddr_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_2v0_pldo_s3: dcdc-reg7 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <2000000>;
> +                               regulator-max-microvolt =3D <2000000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_2v0_pldo_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
2000000>;
> +                               };
> +                       };
> +
> +                       vcc_3v3_s3: dcdc-reg8 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc_3v3_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
3300000>;
> +                               };
> +                       };
> +
> +                       vddq_ddr_s0: dcdc-reg9 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-name =3D "vddq_ddr_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8_s3: dcdc-reg10 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "vcc_1v8_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       avcc_1v8_s0: pldo-reg1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "avcc_1v8_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8_s0: pldo-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "vcc_1v8_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       avdd_1v2_s0: pldo-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <1200000>;
> +                               regulator-name =3D "avdd_1v2_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_3v3_s0: pldo-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vcc_3v3_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vccio_sd_s0: pldo-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vccio_sd_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       pldo6_s3: pldo-reg6 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "pldo6_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       vdd_0v75_s3: nldo-reg1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <750000>;
> +                               regulator-max-microvolt =3D <750000>;
> +                               regulator-name =3D "vdd_0v75_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
750000>;
> +                               };
> +                       };
> +
> +                       vdd_ddr_pll_s0: nldo-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <850000>;
> +                               regulator-max-microvolt =3D <850000>;
> +                               regulator-name =3D "vdd_ddr_pll_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
850000>;
> +                               };
> +                       };
> +
> +                       avdd_0v75_s0: nldo-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <750000>;
> +                               regulator-max-microvolt =3D <750000>;
> +                               regulator-name =3D "avdd_0v75_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_0v85_s0: nldo-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <850000>;
> +                               regulator-max-microvolt =3D <850000>;
> +                               regulator-name =3D "vdd_0v85_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_0v75_s0: nldo-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <750000>;
> +                               regulator-max-microvolt =3D <750000>;
> +                               regulator-name =3D "vdd_0v75_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&uart2 {
> +       pinctrl-0 =3D <&uart2m0_xfer>;
> +       status =3D "okay";
> +};
> +
> +&u2phy0 {
> +       status =3D "okay";
> +};
> +
> +&u2phy0_otg {
> +       status =3D "okay";
> +};
> +
> +&u2phy1 {
> +       status =3D "okay";
> +};
> +
> +&u2phy1_otg {
> +       status =3D "okay";
> +};
> +
> +&u2phy3 {
> +       status =3D "okay";
> +};
> +
> +&u2phy3_host {
> +       phy-supply =3D <&vcc5v0_host>;
> +       status =3D "okay";
> +};
> +
> +&usbdp_phy1 {
> +       status =3D "okay";
> +};
> +
> +&usb_host1_ehci {
> +       status =3D "okay";
> +};
> +
> +&usb_host1_ohci {
> +       status =3D "okay";
> +};
> +
> +&usb_host1_xhci {
> +       dr_mode =3D "host";
> +       status =3D "okay";
> +};
> --
> 2.34.1
>
>
>

