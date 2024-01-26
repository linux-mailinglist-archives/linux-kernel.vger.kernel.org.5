Return-Path: <linux-kernel+bounces-39568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B9E83D2F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF43D1F24BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B16B657;
	Fri, 26 Jan 2024 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvuGBhh+"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BEAD21
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706239600; cv=none; b=P3Zg+lJV4W8HS9559AtEhmxoGjwMWt+5HNO/DXYOgfBZJGbTuJVRsPlIuVL6CZfgAQxo9H9AB9WCmGkJccD5wC0k8hnn4VpUj3YEC0H6xZnyoZFSGy5qcE1gfmj3EWUZkJ6WzJ7f9X81/lJhdiT99FkldfuWpvvXlYo49UguuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706239600; c=relaxed/simple;
	bh=g4i+w63+sy9yYZPW+kGZdrOYodleOa12DosNrHLn0ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9MihumT5toNLV25rib+3Df+B6RDqhuTJ4/72xV3dubGWC9NKThGN7ZpmLfPRsgjvmnlmJ5CW9sAMOdA3/bimZuWvee65M7/WHNdgnu2ODVpHZIgcc3GCbwj60rsrfZDm+rQMyi1L7aPlTSpH79OJIbyFo1JCPwXIkUK5hqtbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KvuGBhh+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so549651fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706239596; x=1706844396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WyUC6MmB08/BiaNWVTf9K2ZnTvIR5FpF1Gb9asD+uw=;
        b=KvuGBhh+zU0JKA19AEukbWG8KwvsdTj+hxPNAe3MX67kOBoX/+UQLmq0/N36s3XB6v
         f54yUKT7P3+avfVhCQj6yLZRfiFNNVDPHl244RJUtuM5qRLA+RMYoSXF98Pg7oI6wTzK
         q4uUbAUvTsF3XpTiADM6w9cgFXm4Bic4DZ9hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706239596; x=1706844396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WyUC6MmB08/BiaNWVTf9K2ZnTvIR5FpF1Gb9asD+uw=;
        b=vAKsIlyEg473zmMpxQrRSsSEtrwNiKpICDqaefBlO9s/1sw7YjCoJwlZvImbFbsIPJ
         Ss7aZC5Xxz8YfVFJqZ6D6vGIoN1FWNFnOzivBJo5CIp5HGChVK10StOnrUx1by2GIINF
         KJhkyDAcGl+bkSUL9IkdbIdPdMp/dh2vpMhGST/87sef2THT3esSZZpChSKs10GAW4Ri
         XKi4+Zrud+CeUzEvUGAhCeoGkb/mrnU0OTLXYKS+Ljjh79hhERkG3B0FG45kADFqFIB0
         FmvK4Dovgtbqgj5RgEBdvBNGsiSQbBqxu5h0AhwZZtxAb0O0g/hI7uGo2yE6APIST3As
         fi1Q==
X-Gm-Message-State: AOJu0Yz9XmxQxZ1A6RlQXOtp7y5NLfxD4D7/NJrzsWWzZvbPvlvdPWS8
	qDKhhwGkyXXBsySiJg+HaUx6G+x5fpJSk/JJW5CARt8CpqQdrucch6z2E8WPvii7ONdTUAoYiPa
	kEUJFGNvw1sGBjIBBfKI7GjdTWkOXB9OalR6X
X-Google-Smtp-Source: AGHT+IEDjNQzwVaWPwAv+h5mtaVgEfszPvfXWHkJHOd/8GLlNf7ga0naC1J+rIBTXRI404s6h2BKMm+4EmCTd7dMJ8I=
X-Received: by 2002:a05:651c:b1f:b0:2cc:a569:48d with SMTP id
 b31-20020a05651c0b1f00b002cca569048dmr210919ljr.44.1706239596392; Thu, 25 Jan
 2024 19:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125095240.2308340-1-wenst@chromium.org> <20240125095240.2308340-2-wenst@chromium.org>
 <68249675-4081-48d9-abbb-1b2e49894fae@collabora.com>
In-Reply-To: <68249675-4081-48d9-abbb-1b2e49894fae@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 26 Jan 2024 11:26:25 +0800
Message-ID: <CAGXv+5GG+Ko4nZKCvpQ2TnjeHDKWi5qS_SWAgLcrZ6fn_ySiug@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 7:39=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 25/01/24 10:52, Chen-Yu Tsai ha scritto:
> > The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> > SDIO. While the Bluetooth function is fully discoverable, the chip
> > has a pin that can reset just the Bluetooth side, as opposed to the
> > full chip. This needs to be described in the device tree.
> >
> > Add a device tree binding for MT7921S Bluetooth over SDIO specifically
> > ot document the reset line.
> >
> > Cc: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 49 ++++++++++++++++++=
+
> >   MAINTAINERS                                   |  1 +
> >   2 files changed, 50 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/me=
diatek,mt7921s-bluetooth.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,m=
t7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/med=
iatek,mt7921s-bluetooth.yaml
> > new file mode 100644
> > index 000000000000..bbe240e7cc40
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-=
bluetooth.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-blue=
tooth.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MT7921S Bluetooth
> > +
>
> title:
>
> maintainers:
>
> description:
>
> ... and then, you missed
>
> allOf:
>    - $ref: bluetooth-controller.yaml#

(facepalm)

> Everything else looks good.
>
> Cheers,
> Angelo
>
> > +description:
>
> MT7921S is a (dual?) SDIO-attached dual-radio WiFi+Bluetooth combo chip;
> this chip has two dedicated reset lines, one of which is used to reset
> the Bluetooth core.
> The WiFi part of this chip is described in ....where? :-)

The function itself is fully probable and the implementation doesn't make
use of the WiFi's reset line, so I don't see any reason to describe it?
I don't actually know what the reset line does in the chip hardware.
This patch is just described what is already used.

> > +  This binding describes the Bluetooth side of the SDIO-attached MT792=
1S
> > +  WiFi+Bluetooth combo chips. These chips are dual-radio chips support=
ing
> > +  WiFi and Bluetooth. Bluetooth works over SDIO just like WiFi. Blueto=
oth
> > +  has its own reset line, separate from WiFi, which can be used to res=
et
> > +  the Bluetooth core.
> > +
> > +maintainers:
> > +  - Sean Wang <sean.wang@mediatek.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt7921s-bluetooth
> > +  reg:
> > +    const: 2
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: A GPIO line connected to the Bluetooth subsystem rese=
t line.
> > +      Typically the W_DISABLE2# pin on M.2 E-key modules. If present t=
his
> > +      shall be flagged as active low.
>
> description:
>    An active-low reset line connected for the Bluetooth core;

connected to?

>    on typical M.2 Key-E modules this is the W_DISABLE2# pin.

Otherwise this looks better. Thanks.


ChenYu

> Cheers,
> Angelo
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    mmc {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        bluetooth@2 {
> > +            compatible =3D "mediatek,mt7921s-bluetooth";
> > +            reg =3D <2>;
> > +            reset-gpios =3D <&pio 8 GPIO_ACTIVE_LOW>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b64a64ca7916..662957146852 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13657,6 +13657,7 @@ M:    Sean Wang <sean.wang@mediatek.com>
> >   L:  linux-bluetooth@vger.kernel.org
> >   L:  linux-mediatek@lists.infradead.org (moderated for non-subscribers=
)
> >   S:  Maintained
> > +F:   Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-=
bluetooth.yaml
> >   F:  Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> >   F:  drivers/bluetooth/btmtkuart.c
> >
>

