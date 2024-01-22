Return-Path: <linux-kernel+bounces-32296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B238359B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F218B22C30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95538184D;
	Mon, 22 Jan 2024 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S0lmDF+y"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6781847
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705893297; cv=none; b=CrQ3j2InuEjWBXr5u8nsEf62IM8TuJHqgNo0RJlMF8qAuFUW9ZyDN+bVCIcathBYyCMH7SKodFzsCoMZgQYqWx+WHWL/3jWzyYosmyZ6KuoAG+B6LCCe7OTvsHXDPDyu3Jt4uac8jMI6sYN3pO9Br4KkwZr8cWtkLk1DvOUYYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705893297; c=relaxed/simple;
	bh=+GDy3xPdrjhbIkjvi+PSrvF3PY51ekkIyNjWL9/y5j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4ZMmeXIh+UzLJznnmJghrZCtC+/evd0y9vxwQnXD/ku8OuhzDqxWPL/kH88e+EfD/Ul5YJRGept7TY9Y+oUkKxLJoY0hWG0rRmDeKYwTxljf6c3uT7tiT7CCX69soBjfPXurH7WQ3N6lQub3ZjoQgE8uhQM8dJPRV6D8ITIhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S0lmDF+y; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e72e3d435so2338998e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705893293; x=1706498093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIwH8u8/5jj2pBx8FxMnpPMe9QlITbo0kBdV2qazlVs=;
        b=S0lmDF+ycxcAeVM+fZtoZZWroEwLVPcc8bcnYCKwlPW3jEvKFmNi7hJnxG7KioOWst
         NCECpFFZ7WwZ02CbaZo9hZaE6FveTYIRG9yVeJIPL4PrJvfbdJUgr17uT+GtSnK3Lwkg
         LM9XKWI16ZlhGfzUxquv9Ff/E+SvOE/h11d2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705893293; x=1706498093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIwH8u8/5jj2pBx8FxMnpPMe9QlITbo0kBdV2qazlVs=;
        b=JQzW3G2oZNNwuZQjLml7neQ5sxi0RKVbis+oi+1YAY9F/nX3RsG7o+eI6xLzfC4CyW
         826iWSn0uAiKyqs0Tmfh7YNN0aTZZVA6JfW8H5usSbiuT6QGuNlNuFxOwGyMeQ6TjTiF
         m2z6ZQUpXClmj1+HvIuugCbpSNht0W8tyGnHL5CO0KiQWfsjYI6AQCjdlHRaA7W7vsUq
         0rrgivIlHh/k9rQbbC+ia0qFY7D4uHiJLinyjMwFBkRoaUdXbhgoLxiw7FgKxqmm7jRY
         gKPAfP3SSCN8GUyCQ/rM83x4QGc2rQcX/1YVU1kJVmOl2vVq3xUHz5f/T1Wr72SBj+aB
         Y1gg==
X-Gm-Message-State: AOJu0YzrUAICBp9MCDWc7cMwpR9ylNd95ZKhgR1ANvDt9HUcuR0HsL9T
	ef/vPG9VGqW8xLJcuzUHE/BosTgDCXxd72QdjeZuVBouxoGCtNCsZaGOpBvF8mkHr9TiGSyx0QD
	55T5RNSqgQAgEJsLRu2kyMZtjxkV2LDVS7crMge+aA1779H6SNA==
X-Google-Smtp-Source: AGHT+IG6AuOfNUIiLXBXFv6N8QEOaQrTM606vHb4YTb+l/QlkvcgDXSkhojmlB75Pyenuq4p7gCZoDQPC4rRxkqqY6A=
X-Received: by 2002:a05:6512:34d0:b0:50e:7d6c:b968 with SMTP id
 w16-20020a05651234d000b0050e7d6cb968mr775787lfr.201.1705893293315; Sun, 21
 Jan 2024 19:14:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213150435.4134390-1-wenst@chromium.org> <20231213150435.4134390-7-wenst@chromium.org>
 <13c8ccbc-0eef-43f5-ae37-29ec64d1606b@collabora.com> <CAGXv+5HO+TW6H9kLv62Dp7cihHW7fs99gzUBMWvAEnzdrNY7mg@mail.gmail.com>
 <420e5184-fe35-4725-95c4-782cc096252f@collabora.com>
In-Reply-To: <420e5184-fe35-4725-95c4-782cc096252f@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 22 Jan 2024 11:14:42 +0800
Message-ID: <CAGXv+5GEdHxhOZ+BbSj7HrnihjKO+6-TgjngaYk0pRLMqskArQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Eugen Hristev <eugen.hristev@collabora.com>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 9:19=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 14/12/23 15:37, Chen-Yu Tsai ha scritto:
> > On Thu, Dec 14, 2023 at 7:31=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 13/12/23 16:04, Chen-Yu Tsai ha scritto:
> >>> Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> >>> Krabby design.
> >>>
> >>> Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> >>> convertible device with touchscreen and stylus.
> >>>
> >>> Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a lapto=
p
> >>> device. It does not have a touchscreen or stylus.
> >>>
> >>> The two devices both have two variants. The difference is a second
> >>> source touchpad controller that shares the same address as the origin=
al,
> >>> but is incompatible.
> >>>
> >>> The extra SKU IDs for the Tentacruel devices map to different sensor
> >>> components attached to the Embedded Controller. These are not visible
> >>> to the main processor.
> >>>
> >>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >>> ---
> >>> Changes since v3:
> >>> - Reorder some properties to conform better to the newly proposed DT
> >>>     style guidelines
> >>> - Drop unused labels
> >>> - Rename bt-sco node name to bt-sco-codec
> >>> - Drop i2s*-share properties from afe node
> >>> - Drop aud_gpio_tdm_{on,off} pinctrl nodes
> >>> - Replace interrupts with interrupts-extended in tpm node
> >>> - Enable adsp device
> >>>
> >>> Changes since v2:
> >>> - Picked up Conor's ack
> >>> - Rename touchpad to trackpad
> >>> - Drop pinctrl properties from trackpad in tentacruel/tentacool secon=
d
> >>>     source trackpad
> >>>
> >>> Changes since v1:
> >>> - Reorder SKU numbers in descending order.
> >>> - Fixed pinconfig node names
> >>> - Moved pinctrl-* properties after interrupts-*
> >>> - Switched to interrupts-extended for external components
> >>> - Marked ADSP as explicitly disabled, with a comment explaining that =
it
> >>>     stalls the system
> >>> - Renamed "touchpad" to "trackpad"
> >>> - Dropped bogus "no-laneswap" property from it6505 node
> >>> - Moved "realtek,jd-src" property to after all the regulator supplies
> >>> - Switched to macros for MT6366 regulator "regulator-allowed-modes"
> >>> - Renamed "vgpu" regulator name to allow coupling, with a comment
> >>>     containing the name used in the design
> >>> - Renamed "cr50" node name to "tpm"
> >>> - Moved trackpad_pins reference up to i2c2; workaround for second sou=
rce
> >>>     component resource sharing.
> >>> - Fix copyright year
> >>> - Fixed touchscreen supply name
> >>> ---
> >>>    arch/arm64/boot/dts/mediatek/Makefile         |    4 +
> >>>    .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  129 ++
> >>>    .../mt8186-corsola-tentacool-sku327681.dts    |   57 +
> >>>    .../mt8186-corsola-tentacool-sku327683.dts    |   24 +
> >>>    .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
> >>>    .../mt8186-corsola-tentacruel-sku262148.dts   |   26 +
> >>>    .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1707 +++++++++++++=
++++
> >>>    7 files changed, 1991 insertions(+)
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-kra=
bby.dtsi
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ten=
tacool-sku327681.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ten=
tacool-sku327683.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ten=
tacruel-sku262144.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ten=
tacruel-sku262148.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dts=
i
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/=
dts/mediatek/Makefile
> >>> index e6e7592a3645..442af61b1305 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/Makefile
> >>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> >>> @@ -43,6 +43,10 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-koda=
ma-sku32.dtb
> >>>    dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku0.dtb
> >>>    dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku176.dtb
> >>>    dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-pumpkin.dtb
> >>> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacool-sku327681.=
dtb
> >>> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacool-sku327683.=
dtb
> >>> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacruel-sku262144=
dtb
> >>> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacruel-sku262148=
dtb
> >>>    dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-evb.dtb
> >>>    dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-hayato-r1.dtb
> >>>    dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-hayato-r5-sku2.dtb
> >>
> >> ..snip..
> >>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-s=
ku262148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku26=
2148.dts
> >>> new file mode 100644
> >>> index 000000000000..447b57b12b41
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku26214=
8.dts
> >>> @@ -0,0 +1,26 @@
> >>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >>> +/*
> >>> + * Copyright 2023 Google LLC
> >>> + */
> >>> +
> >>> +#include "mt8186-corsola-tentacruel-sku262144.dts"
> >>> +
> >>> +/ {
> >>> +     compatible =3D "google,tentacruel-sku262151", "google,tentacrue=
l-sku262150",
> >>> +                  "google,tentacruel-sku262149", "google,tentacruel-=
sku262148",
> >>> +                  "google,tentacruel", "mediatek,mt8186";
> >>> +};
> >>> +
> >>> +/* This variant replaces only the trackpad controller. */
> >>> +&i2c2 {
> >>> +     /delete-node/ trackpad@15;
> >>> +
> >>> +     trackpad@15 {
> >>> +             compatible =3D "hid-over-i2c";
> >>> +             reg =3D <0x15>;
> >>> +             interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> >>> +             hid-descr-addr =3D <0x0001>;
> >>> +             vdd-supply =3D <&pp3300_s3>;
> >>> +             wakeup-source;
> >>> +     };
> >>> +};
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/=
arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> >>> new file mode 100644
> >>> index 000000000000..adbeb0c765d3
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> >>> @@ -0,0 +1,1707 @@
> >>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >>> +/*
> >>> + * Copyright (C) 2022 MediaTek Inc.
> >>> + */
> >>> +/dts-v1/;
> >>> +#include "mt8186.dtsi"
> >>> +#include <dt-bindings/pinctrl/mt8186-pinfunc.h>
> >>> +#include <dt-bindings/gpio/gpio.h>
> >>> +#include <dt-bindings/input/input.h>
> >>> +#include <dt-bindings/input/gpio-keys.h>
> >>> +#include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
> >>> +
> >>
> >> ..snip..
> >>
> >>> +
> >>> +&i2c2 {
> >>> +     pinctrl-names =3D "default";
> >>> +     /*
> >>> +      * Trackpad pin put here to work around second source component=
s
> >>> +      * sharing the pinmux in steelix designs.
> >>> +      */
> >>> +     pinctrl-0 =3D <&i2c2_pins>, <&trackpad_pin>;
> >>> +     clock-frequency =3D <400000>;
> >>> +     i2c-scl-internal-delay-ns =3D <10000>;
> >>> +     status =3D "okay";
> >>> +
> >>> +     trackpad@15 {
> >>> +             compatible =3D "elan,ekth3000";
> >>
> >> You forgot to change this one.
> >>
> >> Remove compatible from this node and stop using /delete-node/ in devic=
e specific
> >> devicetrees.
> >
> > I believe I already replied to the previous version why we can't and sh=
ouldn't
> > do that.
> >
> > "elan,ekth3000" and "hid-over-i2c" have incompatible bindings, specific=
ally
> > the former uses "vcc-supply" while the latter uses "vdd-supply".
> >
> > One has to track down if a property is a "sharable" property or not,
> > then put it in the correct place, otherwise getting DT binding validati=
on
> > errors.
> >
> > To me it seems cleaner to just delete the node wholesale to not have an=
y
> > remnants of the original node, i.e. start from a clean slate. Trying to
> > "share" common properties is asking for a headache.
> >
> > This feels more like a preference thing. I also asked if deleting the n=
ode
> > through the label would be cleaner, but you didn't reply.
> >
>
> I am truly sorry for not replying to that - and for replying to this one =
very late.
>
> Ok, in that case, I still don't really like seeing /delete-node/ statemen=
ts... and
> unless there is a truly valid reason to have those, can we please just ge=
t each
> node to each *.dts?
>
> Just to clarify, a valid scenario to have a /delete-node/ statement there=
 would be
> the following:
>   - Same platform, like Corsola in this case
>   - Four devices
>     - Three have one trackpad (better if expected more with the same TP)
>     - One has the other trackpad
>
> Even though I am flexible with that, I just don't see the value in deleti=
ng the
> trackpad because we've got a 50-50 situation here!
>
> At this point IMO it's worth defining the trackpad twice + twice instead.=
. but
> if you expect to have more devices, conforming to the valid scenario that=
 I have
> described above, then okay - keep going with /delete-node/.

It's not 50-50, because all the other MT8186 devices inherit the original
trackpad in mt8186-corsola.dtsi. So for those devices it either means
pushing it down to the next level in mt8186-corsola-steelix.dtsi, or
down to the individual .dts files, of which we already have six within
this series, and another two for the Voltorb devices. So that's 10 vs 2.

I think that makes a very valid case for using /delete-node/ and not
duplicating the device node everywhere?

Maybe we'll be able to clean this mess up a bit with overlays and FIT
images, but the FIT image stuff is still under discussion.


ChenYu

> > Also, "elan,ekth3000" is the one that was designed and tested on the Co=
rsola
> > reference design, so I think it rightfully belongs there. The Tentacrue=
l
> > SKU replaced it with another part, so the original part should be disab=
led,
> > or in this case, deleted, because otherwise there would be a conflict.
>
> If you really want to document the fact that the Corsola Reference Design
> suggests to use a Elan eKTH3000 part, you can always leave a comment in t=
he
> dtsi, though, that's interesting mostly only to OEMs... but anyway I'm no=
t
> against having a comment, at all.
>
> Cheers,
> Angelo
>
> >
> >
> > Regards
> > ChenYu
> >
> >
> >
> >>> +             reg =3D <0x15>;
> >>> +             interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> >>> +             vcc-supply =3D <&pp3300_s3>;
> >>> +             wakeup-source;
> >>> +     };
> >>> +};
> >>
> >>
> >> corsola.dtsi (here):
> >>
> >> &i2c2 {
> >>          pinctrl-names =3D "default";
> >>          /*
> >>           * Trackpad pin put here to work around second source compone=
nts
> >>           * sharing the pinmux in steelix designs.
> >>           */
> >>          pinctrl-0 =3D <&i2c2_pins>, <&trackpad_pin>;
> >>          clock-frequency =3D <400000>;
> >>          i2c-scl-internal-delay-ns =3D <10000>;
> >>          status =3D "okay";
> >>
> >>          trackpad_i2c2_15: trackpad@15 {
> >>                  /*
> >>                   * Those are common properties for i2c2 trackpad on C=
orsola boards.
> >>                   * The compatible string is declared in device specif=
ic devicetrees
> >>                   */
> >>                  reg =3D <0x15>;
> >>                  interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> >>                  vcc-supply =3D <&pp3300_s3>;
> >>                  wakeup-source;
> >>                  status =3D "disabled";
> >>          };
> >> };
> >>
> >> corsola-some-device.dts:
> >>
> >> &trackpad_i2c2_15 {
> >>          compatible =3D "hid-over-i2c";
> >>          hid-descr-addr =3D <0x0001>;
> >>          status =3D "okay";
> >> };
> >>
> >> corsola-some-other-device.dts:
> >>
> >> &trackpad_i2c2_15 {
> >>          compatible =3D "elan,ekth3000";
> >>          status =3D "okay";
> >> };
> >>
> >> ....everything else looks good.
> >>
> >> Cheers,
> >> Angelo
>
>
>

