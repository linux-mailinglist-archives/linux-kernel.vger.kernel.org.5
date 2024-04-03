Return-Path: <linux-kernel+bounces-129625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6F5896D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7756BB2AE1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A914199C;
	Wed,  3 Apr 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tmk3XL9O"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36713AA35
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141845; cv=none; b=XXFa2wzSDzfFEaAjYpkQz6Wp8q9iyWEq8AsJsZRquCtORg9NCdrYBrSAOrHte+pQhKnQFeo+chyEQef/KTWXZx+jFPwhdm3VObMrICdCRdvlzBM2TIVtoTQLzzuAmdowvJe+3rs/4b0AaNLWiMhYng7+O9MbTnsHUfF8dBJli7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141845; c=relaxed/simple;
	bh=m0zk9FRh18K+wDKJhpcfq1yf3TtUxVXllnWMP63G82g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDlk4BQsIHbSZo740+dBJ/B36yVw9S26XayF9GyAM1+WOioqs8jakqRZMGGtZHiNiNbRbjjWYhUrTRKXyUjiHcaGNY2mAcLA4ywCd0h39xRrPy/baSKu4NdFj6IVW6kUwxy4v/HwiUReJXB55LLJkgu3vngsCMpILFuBllH4+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tmk3XL9O; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so6115222276.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712141843; x=1712746643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QbyTmTpoY0+1ocSTCWq7XN3ElG/TMFU5FD0sWO7oH58=;
        b=Tmk3XL9OUSiu/VmGSdgcC1ZiaysxPh05mH+YzRknN0sRYOB7o3JRf6Isaw0nRSzfE2
         CokEmhq8WF2juSnriedP4RJpFE2BTgzStMNB5oVnm6HAN8jn+b/QyxKOy4LjQU5+ggFG
         Z5X2JFT1JfxracivCxhP7EoqBFtOQHs5bDdihrmFFMvD0ltHwibkjwqdyWIh0BhbUOGD
         /ZBy/JEg9MHPneYX7RmIcVKolDZAGKQ155CVT8jtow0FBwO+ANNuj2yl5b281jLvyqyR
         0ELlhqEJvYjkOj6vK0+eqUT9VszfSsVLq5rdu2J5IPHli6pZG2IAZW6batSWJWUREtTy
         SEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712141843; x=1712746643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbyTmTpoY0+1ocSTCWq7XN3ElG/TMFU5FD0sWO7oH58=;
        b=W3wyOLxlmGUvxKF4ndA7fFuLrq7W83AS7p+hggwUPDhy5ltXMCIQ6y40mqc70QcmzT
         10vGVeDSKEvDOzZ2DjbkK0+Nll5rCvS/LfwSgMXnDmfY1aG+Xs5JxSEQ1vJjneXa3O3h
         dQ8VqefSQ9YjU8cZfheWB5KI/RhXd53pNRGfsaXnaLcW8KGJy68fEunSXLVkOx/u5v6g
         PNiKjvaU6BcPbHK2UoS/yYv3/V/tynOH7wbzkKJFqw5u0eHc2bXXp5cIpJUEmAZ3zUs3
         5QaFH7DbaUfksVx/fW/j/JKDEWBp688vO++uogpIN5U96X/Vk9PH8c/A6QjpKUuW7lhH
         MO3g==
X-Forwarded-Encrypted: i=1; AJvYcCWn4DHgePAIUvPuwVnfdiE+nvlNv2kR0O7Sq33OVNDqmjd/N/pUsJlh6+tFdP8pfEMnganIpH/ElGHxrwUYchgtYeYDs9+9+SX82wv8
X-Gm-Message-State: AOJu0YxAFUSyRiTvLaDi/goW+fU6mP6dfqgkHEr1CcadbmZPCZXHOfJI
	3WyGO2hD/IKMc7glpqzjVVoNXgWXf6Bw4FhvBT22zGEXiwRBrr6Ync4TDXPRzeKyHhC3XW8fVyX
	X85VNXA6rGglyX6lE5s6eWLN+gWyZ0J8+VYWyHw==
X-Google-Smtp-Source: AGHT+IHzW2jF9neEIPgzxnPVJ1X4FEEg0VI4xdndQO62nW4/7QDCepVVu9WOtbxV33ia6Nj3o1T81R8EWNCcF04IL5M=
X-Received: by 2002:a5b:889:0:b0:dcd:a28e:e5e0 with SMTP id
 e9-20020a5b0889000000b00dcda28ee5e0mr1976843ybq.25.1712141842839; Wed, 03 Apr
 2024 03:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403104415.30636-1-alexander.reimelt@posteo.de> <20240403104415.30636-3-alexander.reimelt@posteo.de>
In-Reply-To: <20240403104415.30636-3-alexander.reimelt@posteo.de>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 13:57:12 +0300
Message-ID: <CAA8EJppkSTbRyMVT==iWnDXQdDb3Pc-Q=a18WOWgGR1OtBXJMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add basic support for LG G4 (H815)
To: Alexander Reimelt <alexander.reimelt@posteo.de>
Cc: andersson@kernel.org, pvorel@suse.cz, konrad.dybcio@linaro.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 13:46, Alexander Reimelt
<alexander.reimelt@posteo.de> wrote:
>
> To make it easier for downstream projects and avoid duplication of work.
> Makes the device bootable and enables all buttons, most regulators, hall sensor, eMMC and SD-Card.
>
> Signed-off-by: Alexander Reimelt <alexander.reimelt@posteo.de>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts | 422 +++++++++++++++++++
>  2 files changed, 423 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 7d40ec5e7d21..5b7f8741006f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_QCOM)       += msm8956-sony-xperia-loire-kugo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8956-sony-xperia-loire-suzu.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-lg-bullhead-rev-10.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-lg-bullhead-rev-101.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += msm8992-lg-h815.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-msft-lumia-octagon-talkman.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-xiaomi-libra.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8994-huawei-angler-rev-101.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
> new file mode 100644
> index 000000000000..b7fa48337e25
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * MSM8992 LG G4 (h815) device tree.
> + *
> + * Copyright (c) 2024, Alexander Reimelt <alexander.reimelt@posteo.de>
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8992.dtsi"
> +#include "pm8994.dtsi"
> +#include "pmi8994.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/* different mapping */
> +/delete-node/ &cont_splash_mem;
> +
> +/* disabled downstream */
> +/delete-node/ &dfps_data_mem;
> +
> +&CPU0 {
> +       enable-method = "spin-table";
> +};
> +
> +&CPU1 {
> +       enable-method = "spin-table";
> +};
> +
> +&CPU2 {
> +       enable-method = "spin-table";
> +};
> +
> +&CPU3 {
> +       enable-method = "spin-table";
> +};
> +
> +&CPU4 {
> +       enable-method = "spin-table";
> +};
> +
> +&CPU5 {
> +       enable-method = "spin-table";
> +};
> +
> +/ {
> +       model = "LG G4 (International)";
> +       compatible = "lg,h815", "qcom,msm8992";
> +       chassis-type = "handset";
> +
> +       qcom,msm-id = <251 0>;
> +       qcom,pmic-id = <0x10009 0x1000a 0x00 0x00>;
> +       qcom,board-id = <0xb64 0>;
> +
> +       /* psci is broken */
> +       /delete-node/ psci;
> +
> +       chosen {
> +               bootargs = "earlycon=tty0 console=tty0";

Could you please drop this?

> +       };
> +
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               spin-table@6000000 {
> +                       reg = <0 0x6000000 0 0x1000>;
> +                       no-map;
> +               };
> +
> +               ramoops@ff00000 {
> +                       compatible = "ramoops";
> +                       reg = <0x0 0xff00000 0x0 0x100000>;
> +                       console-size = <0x20000>;
> +                       pmsg-size = <0x20000>;
> +                       record-size = <0x10000>;
> +                       ecc-size = <0x10>;
> +               };
> +
> +               cont_splash_mem: fb@3400000 {
> +                       compatible = "framebuffer";
> +                       reg = <0 0x3400000 0 0xc00000>;
> +                       no-map;
> +               };
> +
> +               crash_fb_mem: crash_fb@4000000 {
> +                       reg = <0 0x4000000 0 0xc00000>;
> +                       no-map;
> +               };
> +       };
> +
> +       gpio-hall-sensor {
> +               compatible = "gpio-keys";
> +
> +               pinctrl-0 = <&hall_sensor_default>;
> +               pinctrl-names = "default";
> +
> +               label = "Hall Effect Sensor";
> +
> +               event-hall-sensor {
> +                       gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
> +                       label = "hall effect sensor";
> +                       linux,input-type = <EV_SW>;
> +                       linux,code = <SW_LID>;
> +                       linux,can-disable;
> +                       wakeup-source;
> +               };
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +
> +               key-vol-up {
> +                       label = "volume up";
> +                       gpios = <&pm8994_gpios 3 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_VOLUMEUP>;
> +                       wakeup-source;
> +                       debounce-interval = <15>;
> +               };
> +       };
> +};
> +
> +&pm8994_spmi_regulators {
> +       vdd_s8-supply = <&vph_pwr>;
> +       vdd_s11-supply = <&vph_pwr>;
> +
> +       pm8994_s8: s8 {
> +               regulator-min-microvolt = <700000>;
> +               regulator-max-microvolt = <1180000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +
> +       pm8994_s11: s11 {
> +               regulator-min-microvolt = <700000>;
> +               regulator-max-microvolt = <1225000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +};
> +
> +&rpm_requests {
> +       regulators-0 {
> +               compatible = "qcom,rpm-pm8994-regulators";
> +
> +               vdd_s3-supply = <&vph_pwr>;
> +               vdd_s4-supply = <&vph_pwr>;
> +               vdd_s5-supply = <&vph_pwr>;
> +               vdd_s7-supply = <&vph_pwr>;
> +               vdd_l1-supply = <&pmi8994_s1>;
> +               vdd_l2_26_28-supply = <&pm8994_s3>;
> +               vdd_l3_11-supply = <&pm8994_s3>;
> +               vdd_l4_27_31-supply = <&pm8994_s3>;
> +               vdd_l5_7-supply = <&pm8994_s5>;
> +               vdd_l6_12_32-supply = <&pm8994_s5>;
> +               vdd_l8_16_30-supply = <&vph_pwr>;
> +               vdd_l9_10_18_22-supply = <&pmi8994_bby>;
> +               vdd_l13_19_23_24-supply = <&pmi8994_bby>;
> +               vdd_l14_15-supply = <&pm8994_s5>;
> +               vdd_l17_29-supply = <&pmi8994_bby>;
> +               vdd_l20_21-supply = <&pmi8994_bby>;
> +               vdd_l25-supply = <&pm8994_s5>;
> +               vdd_lvs1_2-supply = <&pm8994_s4>;
> +
> +               pm8994_s3: s3 {
> +                       regulator-min-microvolt = <1300000>;
> +                       regulator-max-microvolt = <1300000>;
> +               };
> +
> +               /* sdhc1 vqmmc and bcm */
> +               pm8994_s4: s4 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-system-load = <325000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               pm8994_s5: s5 {
> +                       regulator-min-microvolt = <2150000>;
> +                       regulator-max-microvolt = <2150000>;
> +               };
> +
> +               pm8994_s7: s7 {
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1000000>;
> +               };
> +
> +               pm8994_l1: l1 {
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1000000>;
> +               };
> +
> +               pm8994_l2: l2 {
> +                       regulator-min-microvolt = <1250000>;
> +                       regulator-max-microvolt = <1250000>;
> +                       regulator-system-load = <10000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               /* camera */
> +               pm8994_l3: l3 {
> +                       regulator-min-microvolt = <1050000>;
> +                       regulator-max-microvolt = <1050000>;
> +               };
> +
> +               pm8994_l4: l4 {
> +                       regulator-min-microvolt = <1225000>;
> +                       regulator-max-microvolt = <1225000>;
> +               };
> +
> +               /* L5 is inaccessible from RPM */
> +
> +               pm8994_l6: l6 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +               };
> +
> +               /* L7 is inaccessible from RPM */
> +
> +               pm8994_l8: l8 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +               };
> +
> +               pm8994_l9: l9 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +               };
> +
> +               /* touch  */
> +               pm8994_l10: l10 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +               };
> +
> +               pm8994_l11: l11 {
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +               };
> +
> +               pm8994_l12: l12 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-system-load = <10000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               /* sdhc2 vqmmc */
> +               pm8994_l13: l13 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <2950000>;
> +                       regulator-system-load = <22000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               /* camera */
> +               pm8994_l14: l14 {
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-system-load = <10000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               pm8994_l15: l15 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +               };
> +
> +               pm8994_l16: l16 {
> +                       regulator-min-microvolt = <2700000>;
> +                       regulator-max-microvolt = <2700000>;
> +               };
> +
> +               /* camera */
> +               pm8994_l17: l17 {
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <2800000>;
> +               };
> +
> +               pm8994_l18: l18 {
> +                       regulator-min-microvolt = <2850000>;
> +                       regulator-max-microvolt = <2850000>;
> +               };
> +
> +               /* LCD */
> +               pm8994_l19: l19 {
> +                       regulator-min-microvolt = <3000000>;
> +                       regulator-max-microvolt = <3000000>;
> +               };
> +
> +               /* sdhc1 vmmc */
> +               pm8994_l20: l20 {
> +                       regulator-min-microvolt = <2950000>;
> +                       regulator-max-microvolt = <2950000>;
> +                       regulator-system-load = <570000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               /* sdhc2 vmmc */
> +               pm8994_l21: l21 {
> +                       regulator-min-microvolt = <2950000>;
> +                       regulator-max-microvolt = <2950000>;
> +                       regulator-system-load = <800000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               /* touch */
> +               pm8994_l22: l22 {
> +                       regulator-min-microvolt = <3000000>;
> +                       regulator-max-microvolt = <3000000>;
> +               };
> +
> +               /* camera */
> +               pm8994_l23: l23 {
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <2800000>;
> +               };
> +
> +               pm8994_l24: l24 {
> +                       regulator-min-microvolt = <3075000>;
> +                       regulator-max-microvolt = <3150000>;
> +               };
> +
> +               /* IRRC */
> +               pm8994_l25: l25 {
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1000000>;
> +               };
> +
> +               pm8994_l26: l26 {
> +                       regulator-min-microvolt = <987500>;
> +                       regulator-max-microvolt = <987500>;
> +               };
> +
> +               /* hdmi */
> +               pm8994_l27: l27 {
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1000000>;
> +               };
> +
> +               pm8994_l28: l28 {
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1000000>;
> +                       regulator-system-load = <10000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               /* camera */
> +               pm8994_l29: l29 {
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <2800000>;
> +               };
> +
> +               /* camera */
> +               pm8994_l30: l30 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +               };
> +
> +               pm8994_l31: l31 {
> +                       regulator-min-microvolt = <1262500>;
> +                       regulator-max-microvolt = <1262500>;
> +               };
> +
> +               pm8994_l32: l32 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +               };
> +
> +               pm8994_lvs1: lvs1 {};
> +
> +               pm8994_lvs2: lvs2 {};
> +       };
> +
> +       regulators-1 {
> +               compatible = "qcom,rpm-pmi8994-regulators";
> +
> +               vdd_s1-supply = <&vph_pwr>;
> +               vdd_bst_byp-supply = <&vph_pwr>;
> +
> +               pmi8994_s1: s1 {
> +                       regulator-min-microvolt = <1025000>;
> +                       regulator-max-microvolt = <1025000>;
> +               };
> +
> +               /* S2 & S3 - VDD_GFX */
> +
> +               pmi8994_bby: boost-bypass {
> +                       regulator-min-microvolt = <3150000>;
> +                       regulator-max-microvolt = <3600000>;
> +               };
> +       };
> +};
> +
> +&pm8994_resin {
> +       status = "okay";

If I remember correctly, status should be the last property (and few
other cases below).

> +       linux,code = <KEY_VOLUMEDOWN>;
> +};
> +
> +&sdhc1 {
> +       status = "okay";
> +       mmc-hs400-1_8v;
> +       vmmc-supply = <&pm8994_l20>;
> +       vqmmc-supply = <&pm8994_s4>;
> +       non-removable;
> +};
> +
> +&sdhc2 {
> +       status = "okay";
> +       vmmc-supply = <&pm8994_l21>;
> +       vqmmc-supply = <&pm8994_l13>;
> +       cd-gpios = <&pm8994_gpios 8 GPIO_ACTIVE_LOW>;
> +};
> +
> +&tlmm {
> +       hall_sensor_default: hall-sensor-default-state {
> +               pins = "gpio75";
> +               function = "gpio";
> +               drive-strength = <2>;
> +               bias-pull-up;
> +       };
> +};
> --
> 2.44.0
>
>


-- 
With best wishes
Dmitry

