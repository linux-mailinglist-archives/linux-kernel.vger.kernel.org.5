Return-Path: <linux-kernel+bounces-103719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F4187C35F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B914B282E42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA887580B;
	Thu, 14 Mar 2024 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T70JdNY4"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1274BED;
	Thu, 14 Mar 2024 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710443898; cv=none; b=ePi5++tCshcGdBKR8LPisyL76m0Skqg6TIMSaG1oykxp9PdNeiBwhUdkDytnwe2nIHzzgOuVqwV0hy40PKPF8CESzGcTTsqw4M+txrrX5sFlq+m9x6Suo5PqfZoIqgIAxPoA4kEOYlTQb1Bf1Im2NjQ2sYRo9pyfcqrcXP0BBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710443898; c=relaxed/simple;
	bh=CpbdFfegw5dLM8f8I3A4plsin3V1YClG2u4d9P9hpeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5e/Tf3lAMd2xs513Err/gx2XuD57Hlc6Yloc8Ka5Hv1eEyErwkC/KVEo1Pp29PV5ZJhRWG8eill/O/vDQhoer2Hwi94aHkMPq3iHSMWYyGrx54uv8BmviUqeoQKGbzu9rSdy+5c52eOhEWuZv0MasgQmsI/mKm6i4B19irzkko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T70JdNY4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512e4f4e463so1558817e87.1;
        Thu, 14 Mar 2024 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710443895; x=1711048695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpNg02cIhm8koxG98iFwN9dy+0CNxfdd1E7AGL6M4N0=;
        b=T70JdNY4vIzmdhTn7UiYQuK7uzUpfa9p0+ahK9awsEOgfji28GrkZPg0Gj0fHPmI8H
         8GwPc1RwBn1fYgFQ909XGGcKDGIGEXldjNEXozge33opgsJDq6wEO+EEbJCXtEaxp3I7
         qfJGCxLN9xedcyvpSSG81ZP8Qil+dQv8503/oVcGRgjUDibQamPLWHURj6fDaQt6ASmY
         FcMB06p6iwnGYh5tsZ5xrri0SSbfmoqsSdpKcAF9AetC4K2FXX0zAOQ33YIo1JMTiTVZ
         25AoyVxoUVqeJWmS0jR+lbITeulGUMDb+Fq2ByA5hIqGkoCxRBzQTbHoQdjYspAqeQMi
         gAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710443895; x=1711048695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpNg02cIhm8koxG98iFwN9dy+0CNxfdd1E7AGL6M4N0=;
        b=F/5GaqCGeqUMNqjnCU9eH8dRCMznyp0M7sWrJM3w3UzdBCs++7ZTDDsfGgljqiDKMM
         C8S7kc+pNuaBiy10kJ1dKaEzulEypBIBU0NhhXJx9nXDoSg3FafZ2MYmeg3sK7BHxXlB
         Ws3BN4sZtQr+Sz4WyqYMFWWtkeMLeCHuMelaQiDPYC+N39aSs5rYmGvI/JmrJg0U4pMc
         yxUzhl5q19nl3Ik2GPk+lisA7zBLvntjmcn44HD6mbNdSeS0Qkx1F6g2JOACCuaGx3vG
         6lGpWz9U7FskL/+fubVYwesHMIpNEHhGEwRoBo6USXzk0DNZo4rK1ZCShfD38NG6CFAA
         +g3g==
X-Forwarded-Encrypted: i=1; AJvYcCUikhDCjCYXNA0AWut+pDwt8NcV2Hq63l7kYheOUBwQmA9eNEsxxymENSHLgejk/+WdTs14JcxaLuOsZ99GOqEWNmlBHnXCU7UeWrTWbm+SLRassz/DWwnoPdSMqcEX5Hds14L454MRmw==
X-Gm-Message-State: AOJu0YygEzh0VFBOMmNwbD5A4sTkXmwCmpJBrYRcwbfWKSka/CmmvwPg
	HGxvULBR1v3N9DmGjjIZbqPhOFCR7p+UgeUv8C/X+uFxtzmkQCMH
X-Google-Smtp-Source: AGHT+IFc6aloMTsh2ISBLTsjCt71++MriTrbDTOTaYvsFlBwDspWwYgqaPfgPJmyzSatiWotn3h94Q==
X-Received: by 2002:ac2:4db7:0:b0:513:cc4f:52b8 with SMTP id h23-20020ac24db7000000b00513cc4f52b8mr2046150lfe.12.1710443894370;
        Thu, 14 Mar 2024 12:18:14 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709066b8c00b00a4605a343ffsm965896ejr.21.2024.03.14.12.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 12:18:13 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: hitechshell@mail.ru
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Thu, 14 Mar 2024 20:18:12 +0100
Message-ID: <4203654.1IzOArtZ34@jernej-laptop>
In-Reply-To: <20240314181858.2mhw62qfiie6mqg5@hitech>
References:
 <20240314155306.11521-1-hitechshell@mail.ru>
 <2451572.jE0xQCEvom@jernej-laptop> <20240314181858.2mhw62qfiie6mqg5@hitech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 14. marec 2024 ob 19:18:58 CET je hitechshell@mail.ru nap=
isal(a):
> On Thu, Mar 14, 2024 at 06:14:48PM +0100, Jernej =C5=A0krabec wrote:
> > Hi Denis!
> >=20
> > Dne =C4=8Detrtek, 14. marec 2024 ob 16:53:06 CET je Denis Burkov napisa=
l(a):
> > > What works:
> > >=20
> > > - Serial console
> > > - mmc0, mmc2 (both microSD card slots on the board)
> > > - All buttons (gpio and lradc based)
> > > - Power LED
> > > - PMIC
> > > - RTC
> > > - USB OTG/gadgets mode
> > >=20
> > > Signed-off-by: Denis Burkov <hitechshell@mail.ru>
> > > ---
> > >  arch/arm/boot/dts/allwinner/Makefile          |   2 +
> > >  .../sun5i-a13-pocketbook-614-plus.dts         | 254 ++++++++++++++++=
++
> > >  2 files changed, 256 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-=
614-plus.dts
> > >=20
> > > diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts=
/allwinner/Makefile
> > > index 2d26c3397f14..fe321865beed 100644
> > > --- a/arch/arm/boot/dts/allwinner/Makefile
> > > +++ b/arch/arm/boot/dts/allwinner/Makefile
> > > @@ -61,6 +61,7 @@ dtb-$(CONFIG_MACH_SUN5I) +=3D \
> > >  	sun5i-a13-olinuxino.dtb \
> > >  	sun5i-a13-olinuxino-micro.dtb \
> > >  	sun5i-a13-pocketbook-touch-lux-3.dtb \
> > > +	sun5i-a13-pocketbook-614-plus.dtb \
> > >  	sun5i-a13-q8-tablet.dtb \
> > >  	sun5i-a13-utoo-p66.dtb \
> > >  	sun5i-gr8-chip-pro.dtb \
> > > @@ -82,6 +83,7 @@ dtb-$(CONFIG_MACH_SUN5I) +=3D \
> > >  	sun5i-a13-olinuxino.dtb \
> > >  	sun5i-a13-olinuxino-micro.dtb \
> > >  	sun5i-a13-pocketbook-touch-lux-3.dtb \
> > > +	sun5i-a13-pocketbook-614-plus.dtb \
> > >  	sun5i-a13-q8-tablet.dtb \
> > >  	sun5i-a13-utoo-p66.dtb \
> > >  	sun5i-gr8-chip-pro.dtb \
> >=20
> > This merge artefact. Can you add patch before this one and remove dupli=
cate definitions?
> >=20
> Sorry, I didn't quite understand. Should I remove the duplicate block in =
a separate commit? or enable this one?

Yes, remove block in a separate patch, which should be positioned before th=
is one.

> > > diff --git a/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plu=
s.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> > > new file mode 100644
> > > index 000000000000..89898fa16ff7
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> > > @@ -0,0 +1,254 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2024 Denis Burkov <hitechshell@mail.ru>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "sun5i-a13.dtsi"
> > > +#include "sunxi-common-regulators.dtsi"
> >=20
> > Extra empty line here.
> >=20
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/input/input.h>
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +/ {
> > > +	model =3D "PocketBook 614 Plus";
> > > +	compatible =3D "pocketbook,614-plus", "allwinner,sun5i-a13";
> > > +
> > > +	aliases {
> > > +		serial0 =3D &uart1;
> > > +		i2c0 =3D &i2c0;
> > > +		i2c1 =3D &i2c1;
> > > +		i2c2 =3D &i2c2;
> > > +		rtc0 =3D &pcf8563;
> >=20
> > Please drop aliases except serial0.
> >=20
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path =3D "serial0:115200n8";
> > > +	};
> > > +
> > > +	leds {
> > > +		compatible =3D "gpio-leds";
> > > +		pinctrl-names =3D "default";
> > > +		pinctrl-0 =3D <&led_pins_pocketbook>;
> >=20
> > Drop pinctrl nodes. GPIOs don't need them.
> >=20
> > > +
> > > +		led {
> > > +			gpios =3D <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
> > > +			default-state =3D "on";
> >=20
> > Add additional properties, like function and color.
> >=20
> > > +		};
> > > +	};
> > > +
> > > +	gpio-keys {
> > > +		compatible =3D "gpio-keys";
> > > +		autorepeat;
> >=20
> > Why is autorepeat needed?
> >=20
> > > +		label =3D "GPIO Keys";
> >=20
> > I guess label is self evident and not needed?
> >=20
> > > +		pinctrl-names =3D "default";
> > > +		pinctrl-0 =3D <&pocketbook_btn_pins>;
> >=20
> > Again, GPIOs don't need pinctrl nodes. I know that you specified pull u=
p, but
> > please try without. Other boards have same design and it's not needed.
> >=20
> > > +
> > > +		key-right {
> > > +			label =3D "Right";
> > > +			linux,code =3D <KEY_NEXT>;
> > > +			gpios =3D <&pio 6 9 GPIO_ACTIVE_LOW>; /* PG9 */
> > > +		};
> > > +
> > > +		key-left {
> > > +			label =3D "Left";
> > > +			linux,code =3D <KEY_PREVIOUS>;
> > > +			gpios =3D <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
> > > +		};
> > > +	};
> > > +
> > > +	reg_3v3_mmc0: regulator-mmc0 {
> > > +		compatible =3D "regulator-fixed";
> > > +		regulator-name =3D "vdd-mmc0";
> > > +		regulator-min-microvolt =3D <3300000>;
> > > +		regulator-max-microvolt =3D <3300000>;
> > > +		pinctrl-names =3D "default";
> > > +		pinctrl-0 =3D <&pocketbook_reg_mmc0_pins>;
> >=20
> > again, pinctrl not needed.
> >=20
> > > +		gpio =3D <&pio 4 4 GPIO_ACTIVE_LOW>; /* PE4 */
> > > +		vin-supply =3D <&reg_vcc3v3>;
> > > +	};
> > > +};
> > > +
> > > +&cpu0 {
> > > +	cpu-supply =3D <&reg_dcdc2>;
> > > +};
> > > +
> > > +&ehci0 {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&i2c0 {
> > > +	status =3D "okay";
> > > +
> > > +	axp209: pmic@34 {
> > > +		compatible =3D "x-powers,axp209";
> > > +		reg =3D <0x34>;
> > > +		interrupts =3D <0>;
> > > +	};
> > > +};
> > > +
> > > +#include "axp209.dtsi"
> > > +
> > > +&i2c1 {
> > > +	status =3D "okay";
> > > +
> > > +	pcf8563: rtc@51 {
> > > +		compatible =3D "nxp,pcf8563";
> > > +		reg =3D <0x51>;
> > > +		#clock-cells =3D <0>;
> > > +	};
> > > +};
> > > +
> > > +&i2c2 {
> > > +	status =3D "okay";
> > > +
> > > +	/* Touchpanel is connected here. */
> >=20
> > Any reason why don't you specify touch panel device here?
> >=20
> My mistake, I copied this node from another device. This device does not =
have a touchpanel at all.
> > > +};
> > > +
> > > +&lradc {
> > > +	vref-supply =3D <&reg_ldo2>;
> > > +	status =3D "okay";
> > > +
> > > +	button-300 {
> > > +		label =3D "Down";
> > > +		linux,code =3D <KEY_DOWN>;
> > > +		channel =3D <0>;
> > > +		voltage =3D <300000>;
> > > +	};
> > > +
> > > +	button-700 {
> > > +		label =3D "Up";
> > > +		linux,code =3D <KEY_UP>;
> > > +		channel =3D <0>;
> > > +		voltage =3D <700000>;
> > > +	};
> > > +
> > > +	button-1000 {
> > > +		label =3D "Left";
> > > +		linux,code =3D <KEY_LEFT>;
> > > +		channel =3D <0>;
> > > +		voltage =3D <1000000>;
> > > +	};
> > > +
> > > +	button-1200 {
> > > +		label =3D "Menu";
> > > +		linux,code =3D <KEY_MENU>;
> > > +		channel =3D <0>;
> > > +		voltage =3D <1200000>;
> > > +	};
> > > +
> > > +	button-1500 {
> > > +		label =3D "Right";
> > > +		linux,code =3D <KEY_RIGHT>;
> > > +		channel =3D <0>;
> > > +		voltage =3D <1500000>;
> > > +	};
> > > +};
> > > +
> > > +&mmc0 {
> > > +	vmmc-supply =3D <&reg_3v3_mmc0>;
> > > +	bus-width =3D <4>;
> > > +	cd-gpios =3D <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&mmc2 {
> > > +	pinctrl-names =3D "default";
> > > +	pinctrl-0 =3D <&mmc2_4bit_pc_pins>;
> > > +	vmmc-supply =3D <&reg_vcc3v3>;
> > > +	bus-width =3D <4>;
> > > +	non-removable;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&ohci0 {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&otg_sram {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&pio {
> > > +	led_pins_pocketbook: led-pin {
> > > +		pins =3D "PE8";
> > > +		function =3D "gpio_out";
> > > +	};
> > > +	pocketbook_btn_pins: btn-pins {
> > > +		pins =3D "PG9", "PG10";
> > > +		function =3D "gpio_in";
> > > +		bias-pull-up;
> > > +	};
> > > +	pocketbook_reg_mmc0_pins: reg-mmc0-pins {
> > > +		pins =3D "PE4";
> > > +		function =3D "gpio_out";
> > > +	};
> > > +};
> >=20
> > Whole PIO node can be dropped.
> >=20
> > Best regards,
> > Jernej
> >=20
> > > +
> > > +&reg_dcdc2 {
> > > +	regulator-always-on;
> > > +	regulator-min-microvolt =3D <1000000>;
> > > +	regulator-max-microvolt =3D <1500000>;
> > > +	regulator-name =3D "vdd-cpu";
> > > +};
> > > +
> > > +&reg_dcdc3 {
> > > +	regulator-always-on;
> > > +	regulator-min-microvolt =3D <1000000>;
> > > +	regulator-max-microvolt =3D <1400000>;
> > > +	regulator-name =3D "vdd-int-dll";
> > > +};
> > > +
> > > +&reg_ldo1 {
> > > +	regulator-name =3D "vdd-rtc";
> > > +};
> > > +
> > > +&reg_ldo2 {
> > > +	regulator-always-on;
> > > +	regulator-min-microvolt =3D <3000000>;
> > > +	regulator-max-microvolt =3D <3000000>;
> > > +	regulator-name =3D "avcc";
> > > +};
> > > +
> > > +&reg_ldo3 {
> > > +	regulator-min-microvolt =3D <3300000>;
> > > +	regulator-max-microvolt =3D <3300000>;
> > > +	regulator-name =3D "vcc-wifi";
> > > +};
> > > +
> > > +&reg_usb0_vbus {
> > > +	status =3D "okay";
> > > +	gpio =3D <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> > > +};
> > > +
> > > +&reg_usb1_vbus {
> > > +	gpio =3D <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&uart1 {
> > > +	pinctrl-names =3D "default";
> > > +	pinctrl-0 =3D <&uart1_pg_pins>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&usb_otg {
> > > +	dr_mode =3D "otg";
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&usb_power_supply {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&battery_power_supply {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&usbphy {
> > > +	usb0_id_det-gpios =3D <&pio 6 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>;=
 /* PG2 */

I missed this before, but is pull up property really needed? It doesn't make
much sense.

> > > +	usb0_vbus_det-gpios =3D <&axp_gpio 1 GPIO_ACTIVE_HIGH>;
> > > +	usb0_vbus-supply =3D <&reg_usb0_vbus>;
> > > +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> > > +	status =3D "okay";
> > > +};
> > >=20
> >=20
> >=20
> >=20
> >=20
> Yes, everything works without pincrtl. One guy told me that I need to spe=
cify pinctrl for each pin used.

pinctrl node is only needed when multiplexed pin is used for something else=
 than GPIO.

Best regards,
Jernej

> Thanks for the review.
> Best regards,
> Denis
>=20





