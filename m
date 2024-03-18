Return-Path: <linux-kernel+bounces-106803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636387F400
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCEAB22203
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FB5F56A;
	Mon, 18 Mar 2024 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+3Bza5M"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330B5EE67;
	Mon, 18 Mar 2024 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710804530; cv=none; b=UOUaJHaLv+Wxqukq5wonHjl4gh0FEEe+1NlH6LYlM7jAwhKnnE1FHAQZP7YwDVVWMC/Xwd5FQdj1PKlsK+ChnGT7t8bYwcmlLsoTe9oeSU1TI9sim2nm2BM+XVA8LInz3ThnQy5M0G1lsGssM3Y2OMg+JEHyEZ7n81EPt55SoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710804530; c=relaxed/simple;
	bh=YpUt/4ImvuWAnLJ6H8L3Om3/A77U7GJ9Sw9foL6S6HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0N6sLNIhPJvicWfBc9om6W5LsATVp+/BMtiTOyve+BhbgnJrsRYjQqtmfxb415OsCAazvbB3V0rmAJ4UPIEbLqWCa+NHeBtA7thMuyKAaViWTMQVeTlQk8w3ccKYOtM+hzVcPXfByCyIxFA4pcAyscV7B+FEB4UgUBfEn/m4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+3Bza5M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4140a9f25adso15765195e9.2;
        Mon, 18 Mar 2024 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710804526; x=1711409326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Je+QHKggTjRYZ872OZO73N9y5goT8Xf/6jT0hRsCT4o=;
        b=g+3Bza5Mbp4w7nsE8YzcyEkY9NBVHLWpqcq9Z83gEWbpRfbOColhQb5DugfjbsDHw0
         4UUSoHj7dtw/Xejx8tFtc3lBzlEiK29P/1XwH9+LZ3uXywa2XbuegVq4hw9nefmJnNqu
         02VblCAPV6euXpAMN2/13QyB4V+uN57TBv76IdxfRe9QO9ae57zmIY5iMG+Y8aENdvDj
         m2maOaa3y2FpFksdKYtFs8mkpyIoW8B2Fh9jumalaMTV/clOgxXvlQi42rh2MR7LRKbF
         nROVk+cKoMafvo6WRd+21TM630bkXbfi1wrHwj3NENG3b/hjF+Hd96V2U3Qk5aheB6VJ
         LKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710804526; x=1711409326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Je+QHKggTjRYZ872OZO73N9y5goT8Xf/6jT0hRsCT4o=;
        b=LSlN/h8cQt8e/lg/pDwcOzF2G61xfDYZsvsa6kJJQ1c+PCEFx4k7ul88kZlA9DsPIs
         re0ddP3Y81FS3B/QzRfIrJWlaWj8LoKwBK8uzy4GAlH4RzrluGkyUhk4amq1ff8zwAix
         NKAaC1+v1DtFIKqHFj9bU86MMQ4LJIlGIZfyACJhtJzuCBq90C71XdS+/LrFODWGl8P2
         EJTfXGCRrsIYxZbPh+iv2CTAz0tfnUcisWFvTqaylvz4WDUwz2PFumVPty50GzTMmEAn
         h8DqrATyNm4DKlzewsumIsmeG429uHBkNn9Xeh/NI6FABhXB1dl1ikqBZE5HSKETZwbu
         62aw==
X-Forwarded-Encrypted: i=1; AJvYcCVmtAEVIuWMZCpmNrD3N3uNYSAr64ahrK0BwJvBlhaNC8OKAB+Pfr0FOCmFD+bSzNJyPs3GOyBmzLcNT7v0CHFNVU6X4szMAwu/XCqvLseP0RhKWQo5hKSS5BaEdsOFEjk1nwfAqLtC5g==
X-Gm-Message-State: AOJu0YyyECYnZ/cpUAvpfv2OLc80V6piddyUPRWZxChEvZOY4cvFuRIX
	yxTIhxSEXwAGkRXLivF2kMFeOp1X6xi4g16YaP5FTiqbXFK3JLLN
X-Google-Smtp-Source: AGHT+IFlqZHrRZvHmS9yQjhpImZ/zyxNI2T5dWJHSjNy+cI0ouMUsI93wgzihsv9I6CZENXpz65YcQ==
X-Received: by 2002:a05:6000:932:b0:33e:c593:c03d with SMTP id cx18-20020a056000093200b0033ec593c03dmr8394069wrb.27.1710804525880;
        Mon, 18 Mar 2024 16:28:45 -0700 (PDT)
Received: from [192.168.100.117] (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id m24-20020aa7d358000000b0056729e902f7sm5066592edr.56.2024.03.18.16.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 16:28:45 -0700 (PDT)
Message-ID: <6ed87122-22ff-4d71-a6e6-06b578212f00@gmail.com>
Date: Tue, 19 Mar 2024 00:28:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: allwinner: h616: add support for T95
 tv boxes
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
 <20240317-add-t95-axp313-support-v3-3-0d63f7c23d37@gmail.com>
 <20240318114257.46667aef@donnerap.manchester.arm.com>
Content-Language: pl, en-GB
From: Kamil Kasperski <ressetkk@gmail.com>
In-Reply-To: <20240318114257.46667aef@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

W dniu 18.03.2024 o 12:42, Andre Przywara pisze:
> On Sun, 17 Mar 2024 20:44:51 +0100
> Kamil Kasperski <ressetkk@gmail.com> wrote:
>
> Hi Kamil,
>
> thanks a lot for putting together those patches and sending them
> for upstream inclusion!
>
>> Add dtsi file for T95 tv boxes and add initial support for T95 5G AXP313A
>> variant with a board name H616-T95MAX-AXP313A-v3.0 Internal storage is not
>> accessible due to lack of support for H616 NAND controller.
> Them using raw NAND is really unfortunate. I think the original T95 box
> used eMMC?

I'm not sure. I don't have access to the other revision of this box.

>
>> Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>>  arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi | 109 +++++++++++++++++++++
>>  .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  85 ++++++++++++++++
>>  3 files changed, 195 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>> index 21149b346a60..294921f12b73 100644
>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> @@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-t95max-axp313.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-longanpi-3h.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero2w.dtb
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
>> new file mode 100644
>> index 000000000000..815cf2dac24b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
>> @@ -0,0 +1,109 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
>> + *
>> + * Common DT nodes for H616-based T95 TV boxes
>> + * There are two versions reported with different PMIC variants.
>> + */
>> +
>> +#include "sun50i-h616.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +	aliases {
>> +		ethernet1 = &sdio_wifi;
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	reg_vcc5v: vcc5v {
>> +		/* board wide 5V supply directly from the DC input */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc-5v";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_vcc3v3: vcc3v3 {
>> +		/* discrete 3.3V regulator */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc-3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	wifi_pwrseq: wifi-pwrseq {
> Krzysztof recently sent a patch to just use "pwrseq" as the node name,
> so can you do the same here?
>
> https://lore.kernel.org/linux-sunxi/20240317184130.157695-2-krzysztof.kozlowski@linaro.org/T/#u

Sure. I'll send v4.

>
>> +		compatible = "mmc-pwrseq-simple";
>> +		clocks = <&rtc CLK_OSC32K_FANOUT>;
>> +		clock-names = "ext_clock";
>> +		pinctrl-0 = <&x32clk_fanout_pin>;
>> +		pinctrl-names = "default";
>> +		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
>> +	};
>> +};
>> +
>> +&ehci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci2 {
>> +	status = "okay";
>> +};
>> +
>> +&ir {
>> +	status = "okay";
>> +};
>> +
>> +&mmc0 {
>> +	cd-gpios = <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
>> +	bus-width = <4>;
>> +	status = "okay";
>> +};
>> +
>> +&mmc1 {
>> +	mmc-pwrseq = <&wifi_pwrseq>;
>> +	bus-width = <4>;
>> +	non-removable;
>> +	status = "okay";
>> +
>> +	sdio_wifi: wifi@1 {
>> +		reg = <1>;
>> +	};
> So does the WiFi work with mainline drivers? IIUC the BCM43342 is not
> supported by the existing Broadcom drivers?

It's actually BCM43342/1 It System doesn't detect this chip by default.
The most relevant message from dmesg is:
[   14.042035] kernel: brcmfmac: brcmf_fw_alloc_request: Unknown chip BCM43342/1
I believe that it's only a matter of missing module. I don't think it is
supported in mainline ATM. I left it to have a wi-fi node accessible
and detectable by kernel. If you think that it's better to remove the
node if it's not supported I can do it.

Somebody actually extracted modified precompiled module from custom
5.15.16 rockchip kernel, which implements support for this card. There's no
patch for it that could be submitted to mainline unfortunately ATM.

I've found a patch that adds chip id strings to brcmfmac, but I would like to
test it beforehand.

>
>> +};
>> +
>> +&ohci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci2 {
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_ph_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&uart1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>> +	uart-has-rtscts;
>> +	status = "okay";
> Similar question here, what is the Bluetooth situation in mainline? I
> guess it's not supported, since you didn't put a BT node in here?

I haven't tested that yet. It's partially due to lack of experience with
DTS. I would like to figure out mainline support eventually, but for now
I would like to just have a working foundation for these TVB.

If that's also not really a wanted option to leave those nodes, I can
remove them for now.

>
>> +};
>> +
>> +&usbotg {
>> +	dr_mode = "host";	/* USB A type receptable */
>> +	status = "okay";
>> +};
>> +
>> +&usbphy {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
>> new file mode 100644
>> index 000000000000..c8650aca2407
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
>> + *
>> + * Configuration for T95 TV box with board label H616-T95MAX-AXP313A-v3.0
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sun50i-h616-t95.dtsi"
>> +
>> +/ {
>> +	model = "T95 5G (AXP313)";
>> +	compatible = "t95,t95max-axp313", "allwinner,sun50i-h616";
>> +};
>> +
>> +&mmc0 {
>> +	vmmc-supply = <&reg_dldo1>;
>> +};
>> +
>> +&mmc1 {
>> +	vmmc-supply = <&reg_dldo1>;
>> +	vqmmc-supply = <&reg_aldo1>;
>> +};
>> +
>> +&r_i2c {
>> +	status = "okay";
>> +
>> +	axp313: pmic@36 {
>> +		compatible = "x-powers,axp313a";
>> +		reg = <0x36>;
>> +		#interrupt-cells = <1>;
>> +		interrupt-controller;
>> +		interrupt-parent = <&pio>;
> I don't think you need interrupt-parent unless you also actually specify
> an interrupt line.
> (But please keep #interrupt-cells and interrupt-controller.)

I think you may be right. I based this part off of OPiZ3 dts, rather than
transpeed. Will update in the v4.

>
>> +
>> +		vin1-supply = <&reg_vcc5v>;
>> +		vin2-supply = <&reg_vcc5v>;
>> +		vin3-supply = <&reg_vcc5v>;
>> +
>> +		regulators {
>> +			reg_aldo1: aldo1 {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "vcc1v8";
>> +			};
>> +
>> +			reg_dldo1: dldo1 {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcc3v3";
>> +			};
>> +
>> +			reg_dcdc1: dcdc1 {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <810000>;
>> +				regulator-max-microvolt = <990000>;
>> +				regulator-name = "vdd-gpu-sys";
>> +			};
>> +
>> +			reg_dcdc2: dcdc2 {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <810000>;
>> +				regulator-max-microvolt = <1100000>;
>> +				regulator-name = "vdd-cpu";
>> +			};
>> +
>> +			reg_dcdc3: dcdc3 {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <1500000>;
>> +				regulator-max-microvolt = <1500000>;
>> +				regulator-name = "vdd-dram";
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&pio {
>> +	vcc-pc-supply = <&reg_aldo1>;
>> +	vcc-pf-supply = <&reg_dldo1>;
>> +	vcc-pg-supply = <&reg_dldo1>;
> So if vqmmc-supply for MMC1 is at the 1.8V from ALDO1, that must mean that
> the whole of PortG is at 1.8V, right? So I think this would need to be
> reg_aldo1 here.
>
> Apart from those minor things it looks good to me.
>
> Cheers,
> Andre

Good catch. Will update in v4.

Cheers,
Kamil

>> +	vcc-ph-supply = <&reg_dldo1>;
>> +	vcc-pi-supply = <&reg_dldo1>;
>> +};
>>


