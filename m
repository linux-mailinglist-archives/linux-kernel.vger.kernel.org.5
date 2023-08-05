Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32A3770E1D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHEGcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEGcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:32:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A174ED6;
        Fri,  4 Aug 2023 23:32:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso3613820a12.3;
        Fri, 04 Aug 2023 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691217156; x=1691821956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKCckyyqZk8/acMlfQW6ywm6XBXeAYUmbzGxRIyudVE=;
        b=ilzMSkvo/+6lGMIs7xfu+ApcF+Cx05/zlxw1lUcWIfmCrkg88LN54LhmQqiZggQa+V
         SJ0ltYbqwSXBXAjp2e/SWYneOySiqugIUr+Qh/hPNH3l6G8JWkrF/nNjQ9e59aiqECBM
         CdyRBxaVir9foypmvaQ440VLImuMs+REe2pvi7/iXD3njWMzd25C3dpiDYLzUePO/OI6
         yNsoOWWaL6wSR8hgi5oWAxO5cSQRaogDHk8rSpulBeE1FABQOJ3ynqWkw1qrEPF24xJP
         rMmQ4mc7fuztt20GtO8Rabhe5ActrI2+m9N2VW6dYKxsrX+1DStek7QTsJ5Q+bLRD9+B
         Wl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691217156; x=1691821956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKCckyyqZk8/acMlfQW6ywm6XBXeAYUmbzGxRIyudVE=;
        b=kg2EwbB/ZXPVWNUbtlIhXfVvTgxL3+ovdIZ+d5CopMoNUZXG0NqzeYklGAbyIVRELF
         VWZ8r/HlDcxGMV30bCcJf+LPo570pBxRKsdmB7SkHnkPmS5Fk6blD5imQvf6ZSg7YxaT
         KBil8RpvPPd4Z00VeFxjm5+mIGs6U2ujIgzF0N2KoEiqZgLmxfExJzxXtjG5qTRPZz3i
         9K3LbYQ71jQAarYgjd9D/k7h2mci28QTtCS8GONeuF4fAPQkDZCeGlw4i4sJ7a4vjAOl
         r17A9Lh1GqGWFRBGo7yzA95TrAnTQHbiob/HJdYRbWcpKMW5OMFx2+pMTxRBHbcEVBBq
         xtvQ==
X-Gm-Message-State: AOJu0YzD/+JhKcX7Dm5Uuc8XrhPoI97m+IdIHkK13UUF062izGdI0PYs
        OW/HbMIg5PqoEN3WamLTpKM=
X-Google-Smtp-Source: AGHT+IGQUL7hhD4BqC3rXbG1o00H6NiQPmWJWyqZ8Fsks3qK3SIW7phGKHhGZbNB4nHMvpPoebPHlA==
X-Received: by 2002:aa7:c558:0:b0:523:2816:773b with SMTP id s24-20020aa7c558000000b005232816773bmr1059717edr.20.1691217155971;
        Fri, 04 Aug 2023 23:32:35 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id n24-20020a05640204d800b0052307566ed2sm2223953edw.14.2023.08.04.23.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 23:32:35 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: h616: Add OrangePi Zero 3 board
 support
Date:   Sat, 05 Aug 2023 08:32:34 +0200
Message-ID: <2691070.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230804235827.3f32fa8f@slackpad.lan>
References: <20230804170856.1237202-1-andre.przywara@arm.com>
 <4500165.LvFx2qVVIh@jernej-laptop> <20230804235827.3f32fa8f@slackpad.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 05. avgust 2023 ob 00:58:27 CEST je Andre Przywara napisal(a):
> On Fri, 04 Aug 2023 21:05:36 +0200
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi Jernej,
>=20
> > Dne petek, 04. avgust 2023 ob 19:08:56 CEST je Andre Przywara napisal(a=
):
> > > The OrangePi Zero 3 is a development board based on the Allwinner H618
> > > SoC,
> > > which seems to be just an H616 with more L2 cache. The board itself i=
s a
> > > slightly updated version of the Orange Pi Zero 2. It features:
> > > - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
> > > - 1/1.5/2/4 GiB LPDDR4 DRAM SKUs (only up to 1GB on the Zero2)
> > > - AXP313a PMIC (more capable AXP305 on the Zero2)
> > > - Raspberry-Pi-1 compatible GPIO header
> > > - extra 13 pin expansion header, exposing pins for 2x USB 2.0 ports
> > > - 1 USB 2.0 host port
> > > - 1 USB 2.0 type C port (power supply + OTG)
> > > - MicroSD slot
> > > - on-board 16MiB bootable SPI NOR flash (only 2MB on the Zero2)
> > > - 1Gbps Ethernet port (via Motorcomm YT8531 PHY) (RTL8211 on the Zero=
2)
> > > - micro-HDMI port
> > > - (yet) unsupported Allwinner WiFi/BT chip
> > >=20
> > > Add the devicetree file describing the currently supported features,
> > > namely LEDs, SD card, PMIC, SPI flash, USB. Ethernet seems unstable at
> > > the moment, though the basic functionality works.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >=20
> > >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> > >  .../allwinner/sun50i-h618-orangepi-zero3.dts  | 94 +++++++++++++++++=
++
> > >  2 files changed, 95 insertions(+)
> > >  create mode 100644
> > >=20
> > > arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> > >=20
> > > diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> > > b/arch/arm64/boot/dts/allwinner/Makefile index
> > > 6a96494a2e0a3..3b0ad54062381
> > > 100644
> > > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > > @@ -40,3 +40,4 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.d=
tb
> > >=20
> > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> > >=20
> > > +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h618-orangepi-zero3.dtb
> > > diff --git
> > > a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> > > b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts new fi=
le
> > > mode 100644
> > > index 0000000000000..96a6851728111
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> > > @@ -0,0 +1,94 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > +/*
> > > + * Copyright (C) 2023 Arm Ltd.
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "sun50i-h616-orangepi-zero.dtsi"
> > > +
> > > +/ {
> > > +	model =3D "OrangePi Zero3";
> > > +	compatible =3D "xunlong,orangepi-zero3", "allwinner,sun50i-h618";
> > > +};
> > > +
> > > +&emac0 {
> > > +	phy-supply =3D <&reg_dldo1>;
> > > +};
> > > +
> > > +&ext_rgmii_phy {
> > > +	motorcomm,clk-out-frequency-hz =3D <125000000>;
> > > +};
> > > +
> > > +&mmc0 {
> > > +	/*
> > > +	 * The schematic shows the card detect pin wired up to PF6, via an
> > > +	 * inverter, but it just doesn't work.
> > > +	 */
> > > +	broken-cd;
> > > +	vmmc-supply =3D <&reg_dldo1>;
> > > +};
> > > +
> > > +&r_i2c {
> > > +	status =3D "okay";
> > > +
> > > +	axp313: pmic@36 {
> > > +		compatible =3D "x-powers,axp313a";
> > > +		reg =3D <0x36>;
> > > +		#interrupt-cells =3D <1>;
> > > +		interrupt-controller;
> > > +		interrupt-parent =3D <&pio>;
> > > +		interrupts =3D <2 9 IRQ_TYPE_LEVEL_LOW>;	/* PC9=20
*/
> > > +
> > > +		vin1-supply =3D <&reg_vcc5v>;
> > > +		vin2-supply =3D <&reg_vcc5v>;
> > > +		vin3-supply =3D <&reg_vcc5v>;
> > > +
> > > +		regulators {
> > > +			/* Supplies VCC-PLL, so needs to be always
> >=20
> > on. */
> >=20
> > > +			reg_aldo1: aldo1 {
> > > +				regulator-always-on;
> > > +				regulator-min-microvolt =3D
> >=20
> > <1800000>;
> >=20
> > > +				regulator-max-microvolt =3D
> >=20
> > <1800000>;
> >=20
> > > +				regulator-name =3D "vcc1v8";
> > > +			};
> > > +
> > > +			/* Supplies VCC-IO, so needs to be always=20
on.
> >=20
> > */
> >=20
> > > +			reg_dldo1: dldo1 {
> > > +				regulator-always-on;
> > > +				regulator-min-microvolt =3D
> >=20
> > <3300000>;
> >=20
> > > +				regulator-max-microvolt =3D
> >=20
> > <3300000>;
> >=20
> > > +				regulator-name =3D "vcc3v3";
> > > +			};
> > > +
> > > +			reg_dcdc1: dcdc1 {
> > > +				regulator-always-on;
> > > +				regulator-min-microvolt =3D
> >=20
> > <810000>;
> >=20
> > > +				regulator-max-microvolt =3D
> >=20
> > <990000>;
> >=20
> > > +				regulator-name =3D "vdd-gpu-sys";
> > > +			};
> >=20
> > Is it safe to change sys voltage when system is running?
>=20
> I don't know. All I know is that the H616 datasheet lists VDD_SYS as
> having the exact same range as VDD_GPU, and that is does not give a
> "typical" voltage value. As this DT stands at the moment, this doesn't
> really matter, since nothing will change DCDC1.
>=20
> I see that the Orange Pi Zero 2 (with a "proper" PMIC) also ties SYS and
> GPU together, so it's not just because of the few rails of the AXP313.
>=20
> I'd say we will figure that out once we start experimenting with GPU
> DVFS, but meanwhile nothing references DCDC1, so it will just stay put
> at the AXP313's 0.9V reset value.
>=20
> Does that make sense?

Yeah, I'm fine with it.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> Cheers,
> Andre
>=20
> > > +
> > > +			reg_dcdc2: dcdc2 {
> > > +				regulator-always-on;
> > > +				regulator-min-microvolt =3D
> >=20
> > <810000>;
> >=20
> > > +				regulator-max-microvolt =3D
> >=20
> > <1100000>;
> >=20
> > > +				regulator-name =3D "vdd-cpu";
> > > +			};
> > > +
> > > +			reg_dcdc3: dcdc3 {
> > > +				regulator-always-on;
> > > +				regulator-min-microvolt =3D
> >=20
> > <1100000>;
> >=20
> > > +				regulator-max-microvolt =3D
> >=20
> > <1100000>;
> >=20
> > > +				regulator-name =3D "vdd-dram";
> > > +			};
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&pio {
> > > +	vcc-pc-supply =3D <&reg_dldo1>;
> > > +	vcc-pf-supply =3D <&reg_dldo1>;
> > > +	vcc-pg-supply =3D <&reg_aldo1>;
> > > +	vcc-ph-supply =3D <&reg_dldo1>;
> > > +	vcc-pi-supply =3D <&reg_dldo1>;
> > > +};




