Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68379408D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbjIFPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjIFPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:40:13 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC621724;
        Wed,  6 Sep 2023 08:40:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bce552508fso220271fa.1;
        Wed, 06 Sep 2023 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694014805; x=1694619605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/HPucnlC02KhI0SeMm2PgbrX3vHL5Q/olvC4crY43c=;
        b=reUUNFobDpRDRbQaf4BCbd5n6zL5RkSqvMDrpx4aF7qvuO03tdF+R7dHZp5/TwaRZA
         e+pV9UnJ0u23nuu7GeP8Nrjdath38bUN3M6dGWXc+w1nQCis2ovDXOllZSjyRDgli5hp
         sqSkr3jSR+gRKpim3zA7VtCkHuApNncoUtnEHPCiObyTnhkLpD10NBZtudzVMeQOYrvU
         9k3Z3CKVARtzeZm5GG1WyZjDiHPecp2rHs1J5kskT7DoDp/2SbXKj9HDDfTolbBOIXLX
         DZGfDhhkTHXyU8A9aVlGPK0N9LftlcMJzGHWMmiGGCXDl9J+/tX10u4cc9he4mc87w2E
         tVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694014805; x=1694619605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/HPucnlC02KhI0SeMm2PgbrX3vHL5Q/olvC4crY43c=;
        b=f2zkbHxIyrk1fpJm49zch7QFoDsky9kmzM23AZ5I07GkFtyWUfyMrgkQDCNcJbD/aY
         rTz+QT5gBgdI36JMXnlx2TXzXZsAtTzlSUeeN8C6mw3Q9CxVIxBlup9qGRssG5WdsZPp
         /l4gR23Xke3ikXz6db/5Oowf/kfOL38g94Tyk21d438vb0TJswXDe5/ruUu9GrHXRPaZ
         89s8oxu7bWWOistBLPYaJNBHpq4hbkJgK9b4xuWHMnV14C5TRsJERuP613FrLpCz/0e3
         qSeY0HDY/3rvFCQ50FKPNLTWvOxDX0tpY7v4xDrhlF17JGAdOorQsQCsr1WrONCfRH41
         1Buw==
X-Gm-Message-State: AOJu0Ywt7+Q3Whuw2TX4uWd/9JDfDIfCL5H9P6QbX6m8a3p6s4huB9t6
        qpwSOJqpu2jdS8qF51TYQ00=
X-Google-Smtp-Source: AGHT+IHCnMGf52dMqIogIESmHIXmUwUyrQBgjv0g5Mn/v/6vJ7Xj8XnHckyDdvsromuU5o4bDp+zFw==
X-Received: by 2002:a2e:8898:0:b0:2b9:e93e:65e6 with SMTP id k24-20020a2e8898000000b002b9e93e65e6mr2430913lji.35.1694014804552;
        Wed, 06 Sep 2023 08:40:04 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id lu7-20020a170906fac700b0099bcf1c07c6sm9175356ejb.138.2023.09.06.08.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:40:03 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin.botka1@gmail.com>,
        Martin Botka <martin@biqu3d.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: allwinner: h616: Add BigTreeTech Pi support
Date:   Wed, 06 Sep 2023 17:39:59 +0200
Message-ID: <4511281.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20230906112434.460b46c4@donnerap.manchester.arm.com>
References: <20230807145349.2220490-1-martin@biqu3d.com> <1909632.taCxCBeP46@archlinux>
 <20230906112434.460b46c4@donnerap.manchester.arm.com>
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

Dne sreda, 06. september 2023 ob 12:24:34 CEST je Andre Przywara napisal(a):
> On Tue, 05 Sep 2023 22:45:27 +0200
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi,
>=20
> > On Thursday, August 24, 2023 10:48:20 PM CEST Martin Botka wrote:
> > > On Mon, Aug 14 2023 at 12:47:59 PM +02:00:00, Martin Botka
> > >=20
> > > <martin.botka@somainline.org> wrote:
> > > > On Mon, Aug 14 2023 at 12:26:07 PM +02:00:00, Jernej =C5=A0krabec
> > > >=20
> > > > <jernej.skrabec@gmail.com> wrote:
> > > >> Dne nedelja, 13. avgust 2023 ob 18:22:49 CEST je Martin Botka
> > > >>=20
> > > >> =7Fnapisal(a):
> > > >>>  On Sun, Aug 13 2023 at 05:55:35 PM +02:00:00, Jernej =C5=A0krabec
> > > >>> =20
> > > >>>  <jernej.skrabec@gmail.com> wrote:
> > > >>>  > Dne ponedeljek, 07. avgust 2023 ob 16:53:24 CEST je Martin Bot=
ka
> > > >>>  >=20
> > > >>>  > napisal(a):
> > > >>>  >>  The BigTreeTech Pi is an H616 based board based on CB1.
> > > >>>  >>  Just in Rpi format board.
> > > >>>  >> =20
> > > >>>  >>  It features the same internals as BTT CB1 but adds:
> > > >>>  >>      - Fan port
> > > >>>  >>      - IR receiver
> > > >>>  >>      - ADXL345 Accelerometer connector via SPI
> > > >>>  >>      - 24V DC power supply via terminal plugs
> > > >>>  >>      - USB to CAN module connector (The actual USB to CAN
> > > >>>=20
> > > >>> =7F=7Fhappens on
> > > >>>=20
> > > >>>  >> the
> > > >>>  >>=20
> > > >>>  >>  external module)
> > > >>>  >> =20
> > > >>>  >>  List of currently working things is same as BTT CB1 but also:
> > > >>>  >>      - IR receiver
> > > >>>  >>      - ADXL345 connector
> > > >>>  >> =20
> > > >>>  >>  Signed-off-by: Martin Botka <martin@biqu3d.com>
> > > >>>  >>  Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > > >>>  >>  ---
> > > >>>  >> =20
> > > >>>  >>  Changes in V2:
> > > >>>  >>      - Add UART alongside aliases and chosen for it
> > > >>>  >>      - Add model string
> > > >>>  >>      - Enable IR receiver
> > > >>>  >>      - Enable SPI0 for ADXL345 connector
> > > >>>  >> =20
> > > >>>  >>  Changes in V3:
> > > >>>  >>      - Add missing semicolons
> > > >>>  >>      - Add pinctrl for SPI0
> > > >>>  >>  =20
> > > >>>  >>   arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> > > >>>  >>   .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 70
> > > >>>  >>=20
> > > >>>  >> +++++++++++++++++++
> > > >>>  >>=20
> > > >>>  >>   2 files changed, 71 insertions(+)
> > > >>>  >>   create mode 100644
> > > >>>  >> =20
> > > >>>  >>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> > > >>>  >> =20
> > > >>>  >>  diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> > > >>>  >>  b/arch/arm64/boot/dts/allwinner/Makefile index
> > > >>>  >>=20
> > > >>>  >> 7b386428510b..0b6232a7f328
> > > >>>  >>=20
> > > >>>  >>  100644
> > > >>>  >>  --- a/arch/arm64/boot/dts/allwinner/Makefile
> > > >>>  >>  +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > > >>>  >>  @@ -39,5 +39,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D
> > > >>>  >>=20
> > > >>>  >> sun50i-h6-pine-h64-model-b.dtb
> > > >>>  >>=20
> > > >>>  >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> > > >>>  >> =20
> > > >>>  >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> > > >>>  >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D
> > > >>>=20
> > > >>> =7F=7Fsun50i-h616-bigtreetech-cb1-manta.dtb
> > > >>>=20
> > > >>>  >>  +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
> > > >>>  >> =20
> > > >>>  >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> > > >>>  >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> > > >>>  >> =20
> > > >>>  >>  diff --git
> > > >>>  >>=20
> > > >>>  >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> > > >>>  >>=20
> > > >>>  >>  b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.d=
ts
> > > >>>=20
> > > >>> =7F=7Fnew
> > > >>>=20
> > > >>>  >> file
> > > >>>  >>=20
> > > >>>  >>  mode 100644
> > > >>>  >>  index 000000000000..b0d0386e8f13
> > > >>>  >>  --- /dev/null
> > > >>>  >>  +++
> > > >>>=20
> > > >>> =7F=7Fb/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.=
dts
> > > >>>=20
> > > >>>  >>  @@ -0,0 +1,70 @@
> > > >>>  >>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > >>>  >>  +/*
> > > >>>  >>  + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
> > > >>>  >>  + */
> > > >>>  >>  +
> > > >>>  >>  +/dts-v1/;
> > > >>>  >>  +
> > > >>>  >>  +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> > > >>>  >>  +
> > > >>>  >>  +/ {
> > > >>>  >>  +	model =3D "BigTreeTech Pi";
> > > >>>  >>  +	compatible =3D "bigtreetech,pi", "allwinner,sun50i-
h616";
> > > >>>  >>  +
> > > >>>  >>  +	aliases {
> > > >>>  >>  +		serial0 =3D &uart0;
> > > >>>  >>  +	};
> > > >>>  >>  +
> > > >>>  >>  +	chosen {
> > > >>>  >>  +		stdout-path =3D "serial0:115200n8";
> > > >>>  >>  +	};
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&ehci0 {
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&ehci1 {
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&ehci2 {
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&ehci3 {
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&ir {
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&ohci0 {
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&ohci1 {
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&ohci2 {
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&ohci3 {
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&spi0 {
> > > >>>  >>  +	/* SPI connection for onboard connector for ADXL345
> > > >>>=20
> > > >>> =7F=7Faccelerometer
> > > >>>=20
> > > >>>  > */
> > > >>>  >=20
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +	pinctrl-names =3D "default";
> > > >>>  >>  +	pinctrl-0 =3D <&spi0_pins>, <&spi0_cs0_pin>;
> > > >>>  >=20
> > > >>>  > Driver and compatible for ADXL345 already exists, why don't you
> > > >>>=20
> > > >>> =7F=7Fadd
> > > >>>=20
> > > >>>  > child node
> > > >>>  > for it?
> > > >>>  >=20
> > > >>>  > Best regards,
> > > >>>  > Jernej
> > > >>> =20
> > > >>>  Ah. So the ADXL345 actually wont be driven by kernel.
> > > >>=20
> > > >> DT is hardware description, it's not concerned what is done on
> > > >> =7Fsoftware side,
> > > >> either kernel or user space.
> > > >=20
> > > > Im aware. But this is not a device that is on the board. Its simply=
 a
> > > > connector for the device.
> > > > Like Rpi has connectors for camera module :)
> >=20
> > Actually it matters only if this other board is firmly connected with b=
ase
> > board. If it is not, then SPI node should be dropped and be handled with
> > DT
> > overlays.
>=20
> So I do understand the reasoning behind not describing those generic pin
> header connectors, where people could hook up anything, and use it as a
> GPIO or as a special function device, but just wanted to check on this
> situation:
> Don't we even describe pins dedicated to those custom connectors,
> especially if there is an "obvious" external device to connect to? Is it
> the same situation like with these FPC camera connectors?

I would say yes. SPI connector can still be used as GPIOs or anything else,=
=20
since there is no device soldered directly to it.

Best regards,
Jernej

>=20
> Cheers,
> Andre
>=20
> > > >>>  The SPI connection is enabled so that klipper (3d printer
> > > >>>=20
> > > >>> firmware) =7F=7Fcan
> > > >>>=20
> > > >>>  be told to look for ADXL345 at this SPI and use it on its own.
> > > >>> =20
> > > >>>  Klipper will initialize and communicate with the ADXL on its own.
> > > >>=20
> > > >> What do you mean by firmware? User space app? In this case I suppo=
se
> > > >> =7Fyou'll use
> > > >> direct SPI commands from user space? AFAIK that's less and less
> > > >> =7Fsupported by
> > > >> kernel (in contrast to I2C).
> > > >=20
> > > > Firmware as in 3d printer firmware. Klipper runs on the board (CB1 =
or
> > > > BTT Pi) and is indeed an userspace app.
> > > > And indeed uses direct SPI commands to the device.
> > > >=20
> > > > The reason for this is the flexibility.
> > > > If Klipper read the values from kernel or well from the files the
> > > > ADXL driver would create
> > > > then it would be unable to communicate with ADXL that is on toolhead
> > > > board. Or would have to have
> > > > direct initialization either way for those. Thus it just controls t=
he
> > > > ADXL itself :)
> > > >=20
> > > > I understand that this may be bit confusing. If there is still
> > > > something not clear im more then happy to explain in
> > > > full detail how the userspace and 3D printer communicate :)
> >=20
> > As I said, DT doesn't care about implementation. DT is HW description, =
so
> > either if it's fixed connection (soldered wires), then describe in full,
> > otherwise it's considered addon board and thus non-essential, so it sho=
uld
> > be handled with DT overlays.
> >=20
> > Can be CB1 bought separately from 3D printer package and thus used with=
out
> > ADXL sensor?
> >=20
> > > > Cheers,
> > > > Martin.
> > >=20
> > > Hello,
> > > Jernej any comments on this ?
> > > I would like to resolve this conversation :)
> > > We do have a bunch of time before the new cycle but never hurts to get
> > > it figured out ahead of time :)
> >=20
> > Sorry, not enough free time over summer.
> >=20
> > Best regards,
> > Jernej
> >=20
> > > Cheers,
> > > Martin
> > >=20
> > > >> Best regards,
> > > >> Jernej
> > > >>=20
> > > >>>  >>  +};
> > > >>>  >>  +
> > > >>>  >>  +&uart0 {
> > > >>>  >>  +	pinctrl-names =3D "default";
> > > >>>  >>  +	pinctrl-0 =3D <&uart0_ph_pins>;
> > > >>>  >>  +	status =3D "okay";
> > > >>>  >>  +};




