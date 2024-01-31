Return-Path: <linux-kernel+bounces-45880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445384377B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83E7B2687A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21B4EB28;
	Wed, 31 Jan 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FuGC75CK"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D56A027
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685258; cv=none; b=Jra0ei3dZPOKHGFeH9TqIwWzGjWqFsJtpIYg3D9MpgAyeoT4JwCcTuQY++gLKaURvmYX7OK6V9c3oV6EYRHITgUjB9i9WOTgw/4soGv71rxNDJ73+RT+D8g1r3xI+A+aKwRufQ7Ra8V0f8oEe/oE3G937ynWSCLU1ek/+UPDDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685258; c=relaxed/simple;
	bh=PT0ZD0Z2SKXmRczfwp6Qkd82JVj/XscKz6H79+stjIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yxw8sUADlY+drIxOAVTTbcshFFYwIm7DbykyAmMhy0nqAB3O5AEP1feysbwG3N/oQKkhOqGIGtGcAT7MuzdBRge366YSYDQ3bkNLOAE0Nin/lakxgUAD3OBGhdvQ48v9K+wIv+uASFT8ynW/fE6Cfj1OoXg35NtYVYCsShakFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FuGC75CK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5101cd91017so5389649e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706685254; x=1707290054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SdT+kMMS7pKNh3tITSk53PjT41YklJL6IAyVaGSsU8=;
        b=FuGC75CK30KkUPPGsYv5HK8LyV7m4m6tcBous2FzLwNAcKJiAcpUl0a6JqGoTvHU5Z
         DM6YENXxOO59H+exLkgCfV9usfzu+sxrZdBEt6/O9cxTPLVuCK+V9lUi4eIj+kKpPzGj
         kXhOCs76V++dwf32MmwPSAuBdHUyld6vKYD+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706685254; x=1707290054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SdT+kMMS7pKNh3tITSk53PjT41YklJL6IAyVaGSsU8=;
        b=eQAcpBh9GvpTJvGQCxiD1Mr57tZFBfYRgLZB75GQrm90USd5NG4gqACxi6bT4EwXn1
         dWoLETBpvtYgmzgoTBPgY/sDjYFPhIIZkTjZrnK2hcWYPSOKlyhCxaYYLs6A+Y6CG5PG
         ttT/72cNAEun+eK54BEM8zjoNdTmROnKE2Zfa0NSLiYuyB0nY274L3HR5ap1zcUPWEXf
         4X9By9MZgYC9pj6VKoSPFxu1+WSmuIk9CphFEgQ3JMp8hp3abpkO301sDUNGB+zmIvEi
         g8RSpeWS9gUKqCGKOQ7Iu+UkhpOmSogiZAC/Zz8khRUyIQTDAzzyfMJSlkrG0aUH0zDe
         8wwQ==
X-Gm-Message-State: AOJu0Yxh29xIlAHTsmNXDaJLIf4A1B1+BdVgxfT/0pw7NBJB7uut44yg
	2uxJU+69w5clRl36SxT1bgPfKMp/yhsSxZToKiZOG4t+kXhRniMOj9iOciE6z/ZswzFk2qjIpm6
	KSSGmMPVLsyMsnBfGak502xKD5F20pLTZ+H7Z
X-Google-Smtp-Source: AGHT+IEGwV67FLONdWIax5SkjacKjnKU7tRRx9CowvW4B3C9QDqVGIhm4ETxaukmN+j6z+ZNnZGb7SS8+h7LvCNH0S8=
X-Received: by 2002:a05:6512:481a:b0:511:19af:f84 with SMTP id
 eo26-20020a056512481a00b0051119af0f84mr522489lfb.25.1706685253595; Tue, 30
 Jan 2024 23:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115084336.938426-1-angelogioacchino.delregno@collabora.com> <a79fa347-f42d-49a3-9faf-40fbefb69998@collabora.com>
In-Reply-To: <a79fa347-f42d-49a3-9faf-40fbefb69998@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 31 Jan 2024 15:14:02 +0800
Message-ID: <CAGXv+5F=9iQDo_=PQeNB06Wc-Rav3yODEkwX-h02CpoChCzkOA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add MTU3 nodes and
 correctly describe USB
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com, matthias.bgg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:32=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 15/01/24 09:43, AngeloGioacchino Del Regno ha scritto:
> > The MT8195 SoC has four USB controllers: only one is a direct path to
> > a XHCI controller, while the other three (0, 2 and 3) are behind the
> > MTU3 DRD controller instead!
> >
> > Add the missing MTU3 nodes, default disabled, for controllers 0, 2 and
> > 3 and move the related XHCI nodes to be children of their MTU3 DRD to
> > correctly describe the SoC.
> >
> > In order to retain USB functionality on all of the MT8195 and MT8395
> > boards, also move the vusb33 supply and enable the relevant MTU3 nodes
> > with special attention to the MT8195 Cherry Chromebook, where it was
> > necessary to set the dr_mode of all MTU3 controllers to host to avoid
> > interfering with the EC performing DRD on its own.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
>
> Hello Chen-Yu,
>
> even though I've carefully tested that on my MT8195 Chromebook, can you p=
lease
> check this one?

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> Four eyes are better than two. :-)
>
> P.S.: Sorry, I forgot to Cc you in the first submission....

No worries. I probably missed it as I was busy working on other devices.

> > ---
> >
> > Depends on [1]
> >
> > This patch was tested on a MT8395 board and on the MT8195 Cherry
> > Tomato Chromebook.
> >
> > [1]: https://lore.kernel.org/all/20240112133222.240038-1-angelogioacchi=
no.delregno@collabora.com
> >
> >   .../boot/dts/mediatek/mt8195-cherry.dtsi      |  26 +++-
> >   arch/arm64/boot/dts/mediatek/mt8195-demo.dts  |  18 ++-
> >   arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  12 ++
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 125 +++++++++++------=
-
> >   .../dts/mediatek/mt8395-genio-1200-evk.dts    |  17 ++-
> >   5 files changed, 140 insertions(+), 58 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm=
64/boot/dts/mediatek/mt8195-cherry.dtsi
> > index a136bea99d9c..e563a2dc4cce 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > @@ -1293,11 +1293,32 @@ &uart0 {
> >       status =3D "okay";
> >   };
> >
> > +/*
> > + * For the USB Type-C ports the role and alternate modes switching is
> > + * done by the EC so we set dr_mode to host to avoid interfering.
> > + */

Actually the USB roles can't be changed. The external ports all connect
to a USB hub. And the internal devices are either the Bluetooth device
or the USB cameras in the lid. So they all only work in host mode.

BTW, I think xhci1 can be disabled. There's nothing connected to it.
And the SS lines are used for PCIe instead.

ChenYu

> > +&ssusb0 {
> > +     dr_mode =3D "host";
> > +     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +     status =3D "okay";
> > +};
> > +
> > +&ssusb2 {
> > +     dr_mode =3D "host";
> > +     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +     status =3D "okay";
> > +};
> > +
> > +&ssusb3 {
> > +     dr_mode =3D "host";
> > +     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +     status =3D "okay";
> > +};
> > +
> >   &xhci0 {
> >       status =3D "okay";
> >
> >       rx-fifo-depth =3D <3072>;
> > -     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> >       vbus-supply =3D <&usb_vbus>;
> >   };
> >
> > @@ -1311,8 +1332,6 @@ &xhci1 {
> >
> >   &xhci2 {
> >       status =3D "okay";
> > -
> > -     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> >       vbus-supply =3D <&usb_vbus>;
> >   };
> >
> > @@ -1321,7 +1340,6 @@ &xhci3 {
> >
> >       /* MT7921's USB Bluetooth has issues with USB2 LPM */
> >       usb2-lpm-disable;
> > -     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> >       vbus-supply =3D <&usb_vbus>;
> >   };
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/=
boot/dts/mediatek/mt8195-demo.dts
> > index 69c7f3954ae5..9872743f743f 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > @@ -528,8 +528,22 @@ &u3phy3 {
> >       status =3D "okay";
> >   };
> >
> > -&xhci0 {
> > +&ssusb0 {
> > +     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +     status =3D "okay";
> > +};
> > +
> > +&ssusb2 {
> >       vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +     status =3D "okay";
> > +};
> > +
> > +&ssusb3 {
> > +     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +     status =3D "okay";
> > +};
> > +
> > +&xhci0 {
> >       vbus-supply =3D <&otg_vbus_regulator>;
> >       status =3D "okay";
> >   };
> > @@ -540,11 +554,9 @@ &xhci1 {
> >   };
> >
> >   &xhci2 {
> > -     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> >       status =3D "okay";
> >   };
> >
> >   &xhci3 {
> > -     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> >       status =3D "okay";
> >   };
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/b=
oot/dts/mediatek/mt8195-evb.dts
> > index 690dc7717f2c..341b6e074139 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> > @@ -160,6 +160,18 @@ &uart0 {
> >       status =3D "okay";
> >   };
> >
> > +&ssusb0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ssusb2 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ssusb3 {
> > +     status =3D "okay";
> > +};
> > +
> >   &xhci0 {
> >       status =3D "okay";
> >   };
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8195.dtsi
> > index 152cc0b191bb..45f278efd946 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1349,29 +1349,40 @@ queue3 {
> >                       };
> >               };
> >
> > -             xhci0: usb@11200000 {
> > -                     compatible =3D "mediatek,mt8195-xhci",
> > -                                  "mediatek,mtk-xhci";
> > -                     reg =3D <0 0x11200000 0 0x1000>,
> > -                           <0 0x11203e00 0 0x0100>;
> > +             ssusb0: usb@11201000 {
> > +                     compatible =3D "mediatek,mt8195-mtu3", "mediatek,=
mtu3";
> > +                     reg =3D <0 0x11201000 0 0x2dff>, <0 0x11203e00 0 =
0x0100>;
> >                       reg-names =3D "mac", "ippc";
> > -                     interrupts =3D <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0=
>;
> > -                     phys =3D <&u2port0 PHY_TYPE_USB2>,
> > -                            <&u3port0 PHY_TYPE_USB3>;
> > -                     assigned-clocks =3D <&topckgen CLK_TOP_USB_TOP>,
> > -                                       <&topckgen CLK_TOP_SSUSB_XHCI>;
> > -                     assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>,
> > -                                              <&topckgen CLK_TOP_UNIVP=
LL_D5_D4>;
> > +                     ranges =3D <0 0 0 0x11200000 0 0x3f00>;
> > +                     #address-cells =3D <2>;
> > +                     #size-cells =3D <2>;
> > +                     interrupts =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0=
>;
> >                       clocks =3D <&infracfg_ao CLK_INFRA_AO_SSUSB>,
> >                                <&topckgen CLK_TOP_SSUSB_REF>,
> > -                              <&apmixedsys CLK_APMIXED_USB1PLL>,
> > -                              <&clk26m>,
> >                                <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
> > -                     clock-names =3D "sys_ck", "ref_ck", "mcu_ck", "dm=
a_ck",
> > -                                   "xhci_ck";
> > -                     mediatek,syscon-wakeup =3D <&pericfg 0x400 103>;
> > +                     clock-names =3D "sys_ck", "ref_ck", "mcu_ck";
> > +                     phys =3D <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_=
TYPE_USB3>;
> >                       wakeup-source;
> > +                     mediatek,syscon-wakeup =3D <&pericfg 0x400 103>;
> >                       status =3D "disabled";
> > +
> > +                     xhci0: usb@0 {
> > +                             compatible =3D "mediatek,mt8195-xhci", "m=
ediatek,mtk-xhci";
> > +                             reg =3D <0 0 0 0x1000>;
> > +                             reg-names =3D "mac";
> > +                             interrupts =3D <GIC_SPI 129 IRQ_TYPE_LEVE=
L_HIGH 0>;
> > +                             assigned-clocks =3D <&topckgen CLK_TOP_US=
B_TOP>,
> > +                                               <&topckgen CLK_TOP_SSUS=
B_XHCI>;
> > +                             assigned-clock-parents =3D <&topckgen CLK=
_TOP_UNIVPLL_D5_D4>,
> > +                                                      <&topckgen CLK_T=
OP_UNIVPLL_D5_D4>;
> > +                             clocks =3D <&infracfg_ao CLK_INFRA_AO_SSU=
SB>,
> > +                                      <&topckgen CLK_TOP_SSUSB_REF>,
> > +                                      <&apmixedsys CLK_APMIXED_USB1PLL=
>,
> > +                                      <&clk26m>,
> > +                                      <&infracfg_ao CLK_INFRA_AO_SSUSB=
_XHCI>;
> > +                             clock-names =3D "sys_ck", "ref_ck", "mcu_=
ck", "dma_ck", "xhci_ck";
> > +                             status =3D "disabled";
> > +                     };
> >               };
> >
> >               mmc0: mmc@11230000 {
> > @@ -1452,52 +1463,68 @@ xhci1: usb@11290000 {
> >                       status =3D "disabled";
> >               };
> >
> > -             xhci2: usb@112a0000 {
> > -                     compatible =3D "mediatek,mt8195-xhci",
> > -                                  "mediatek,mtk-xhci";
> > -                     reg =3D <0 0x112a0000 0 0x1000>,
> > -                           <0 0x112a3e00 0 0x0100>;
> > +             ssusb2: usb@112a1000 {
> > +                     compatible =3D "mediatek,mt8195-mtu3", "mediatek,=
mtu3";
> > +                     reg =3D <0 0x112a1000 0 0x2dff>, <0 0x112a3e00 0 =
0x0100>;
> >                       reg-names =3D "mac", "ippc";
> > -                     interrupts =3D <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0=
>;
> > -                     phys =3D <&u2port2 PHY_TYPE_USB2>;
> > -                     assigned-clocks =3D <&topckgen CLK_TOP_USB_TOP_2P=
>,
> > -                                       <&topckgen CLK_TOP_SSUSB_XHCI_2=
P>;
> > -                     assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>,
> > -                                              <&topckgen CLK_TOP_UNIVP=
LL_D5_D4>;
> > +                     ranges =3D <0 0 0 0x112a0000 0 0x3f00>;
> > +                     #address-cells =3D <2>;
> > +                     #size-cells =3D <2>;
> > +                     interrupts =3D <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0=
>;
> > +                     assigned-clocks =3D <&topckgen CLK_TOP_USB_TOP_2P=
>;
> > +                     assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>;
> >                       clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>=
,
> >                                <&topckgen CLK_TOP_SSUSB_P2_REF>,
> > -                              <&clk26m>,
> > -                              <&clk26m>,
> >                                <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
> > -                     clock-names =3D "sys_ck", "ref_ck", "mcu_ck", "dm=
a_ck",
> > -                                   "xhci_ck";
> > -                     mediatek,syscon-wakeup =3D <&pericfg 0x400 105>;
> > +                     clock-names =3D "sys_ck", "ref_ck", "mcu_ck";
> > +                     phys =3D <&u2port2 PHY_TYPE_USB2>;
> >                       wakeup-source;
> > +                     mediatek,syscon-wakeup =3D <&pericfg 0x400 105>;
> >                       status =3D "disabled";
> > +
> > +                     xhci2: usb@0 {
> > +                             compatible =3D "mediatek,mt8195-xhci", "m=
ediatek,mtk-xhci";
> > +                             reg =3D <0 0 0 0x1000>;
> > +                             reg-names =3D "mac";
> > +                             interrupts =3D <GIC_SPI 533 IRQ_TYPE_LEVE=
L_HIGH 0>;
> > +                             assigned-clocks =3D <&topckgen CLK_TOP_SS=
USB_XHCI_2P>;
> > +                             assigned-clock-parents =3D <&topckgen CLK=
_TOP_UNIVPLL_D5_D4>;
> > +                             clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB=
_2P_XHCI>;
> > +                             clock-names =3D "sys_ck";
> > +                             status =3D "disabled";
> > +                     };
> >               };
> >
> > -             xhci3: usb@112b0000 {
> > -                     compatible =3D "mediatek,mt8195-xhci",
> > -                                  "mediatek,mtk-xhci";
> > -                     reg =3D <0 0x112b0000 0 0x1000>,
> > -                           <0 0x112b3e00 0 0x0100>;
> > +             ssusb3: usb@112b1000 {
> > +                     compatible =3D "mediatek,mt8195-mtu3", "mediatek,=
mtu3";
> > +                     reg =3D <0 0x112b1000 0 0x2dff>, <0 0x112b3e00 0 =
0x0100>;
> >                       reg-names =3D "mac", "ippc";
> > -                     interrupts =3D <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0=
>;
> > -                     phys =3D <&u2port3 PHY_TYPE_USB2>;
> > -                     assigned-clocks =3D <&topckgen CLK_TOP_USB_TOP_3P=
>,
> > -                                       <&topckgen CLK_TOP_SSUSB_XHCI_3=
P>;
> > -                     assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>,
> > -                                              <&topckgen CLK_TOP_UNIVP=
LL_D5_D4>;
> > +                     ranges =3D <0 0 0 0x112b0000 0 0x3f00>;
> > +                     #address-cells =3D <2>;
> > +                     #size-cells =3D <2>;
> > +                     interrupts =3D <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0=
>;
> > +                     assigned-clocks =3D <&topckgen CLK_TOP_USB_TOP_3P=
>;
> > +                     assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>;
> >                       clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>=
,
> >                                <&topckgen CLK_TOP_SSUSB_P3_REF>,
> > -                              <&clk26m>,
> > -                              <&clk26m>,
> >                                <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
> > -                     clock-names =3D "sys_ck", "ref_ck", "mcu_ck", "dm=
a_ck",
> > -                                   "xhci_ck";
> > -                     mediatek,syscon-wakeup =3D <&pericfg 0x400 106>;
> > +                     clock-names =3D "sys_ck", "ref_ck", "mcu_ck";
> > +                     phys =3D <&u2port3 PHY_TYPE_USB2>;
> >                       wakeup-source;
> > +                     mediatek,syscon-wakeup =3D <&pericfg 0x400 106>;
> >                       status =3D "disabled";
> > +
> > +                     xhci3: usb@0 {
> > +                             compatible =3D "mediatek,mt8195-xhci", "m=
ediatek,mtk-xhci";
> > +                             reg =3D <0 0 0 0x1000>;
> > +                             reg-names =3D "mac";
> > +                             interrupts =3D <GIC_SPI 536 IRQ_TYPE_LEVE=
L_HIGH 0>;
> > +                             assigned-clocks =3D <&topckgen CLK_TOP_SS=
USB_XHCI_3P>;
> > +                             assigned-clock-parents =3D <&topckgen CLK=
_TOP_UNIVPLL_D5_D4>;
> > +                             clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB=
_3P_XHCI>;
> > +                             clock-names =3D "sys_ck";
> > +                             status =3D "disabled";
> > +                     };
> >               };
> >
> >               pcie0: pcie@112f0000 {
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/a=
rch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> > index 7fc515a07c65..1558649f633c 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> > @@ -880,6 +880,21 @@ &ufsphy {
> >       status =3D "disabled";
> >   };
> >
> > +&ssusb0 {
> > +     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +     status =3D "okay";
> > +};
> > +
> > +&ssusb2 {
> > +     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +     status =3D "okay";
> > +};
> > +
> > +&ssusb3 {
> > +     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +     status =3D "okay";
> > +};
> > +
> >   &xhci0 {
> >       status =3D "okay";
> >   };
> > @@ -890,11 +905,9 @@ &xhci1 {
> >   };
> >
> >   &xhci2 {
> > -     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> >       status =3D "okay";
> >   };
> >
> >   &xhci3 {
> > -     vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> >       status =3D "okay";
> >   };
>
>

