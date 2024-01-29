Return-Path: <linux-kernel+bounces-42133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406CC83FCE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16AB2814AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5D125C1;
	Mon, 29 Jan 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NhLmcjLE"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71272101D5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499545; cv=none; b=ByFHwI7VwoaMHkDDwYcbFtpW3L4sMBU3WRKIcRtEK5YB2I25z68q7TlCxgAzupaVnI/XiS2cERRwMZrRj1P1z9WF/M8s2En4sl/A/cRlfnAt3lQ9LXtJUrkEM8pJUPiMvayDF89flV1PGvQn5ySlb1hIJhnAt/BuL/XljMUVolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499545; c=relaxed/simple;
	bh=wE4cixn0oIglWKeS/zIrvtFsWbeheeYOTmOIKWPKXCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJfB0U5C+YU7ky5zqC91IZn5eSu7UmmRXSbH1mA8iMudJWd/dH7nKfepYv/1+YA/eZj3hdIQLC91gVK09Tl5yz7lW4E7MLTEaFx26a9iWyDRABJLGD7dHCHpyuflqr4sEfBzu6ijW+ASfGmVZne8WoA4wQnzXiiuiA++sWBkhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NhLmcjLE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5110fae7af5so487691e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706499540; x=1707104340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yyUGF5rIxxEr8wGxy6mzO1hK1BzZ2gmE5L9TwgfgxA=;
        b=NhLmcjLEUKN0XxvcQ/70ZW2TkD9d3g8WQqvTjI3yX8UCNlQ/CJtbE2ApB9meI5+TDD
         zLtc948i1kSVgFnzBQqed5AHQyx2WT6BZL2t49gCmqte/vrmPc0r7DULnucETTnP0HP3
         ut/5ujrsQ0b8wjeFQqdJ+O7lkdfuLAYhny6R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706499540; x=1707104340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yyUGF5rIxxEr8wGxy6mzO1hK1BzZ2gmE5L9TwgfgxA=;
        b=pfQJbVHCLC66stRg6li4Po/3nK1ltY5zxh5CegS9WsBFNMSeeHYkEQAJD0wQP2XBTh
         OCymtnBdrOoSu4XzUaDowXJ10Ps4A1FLgtx6stKVd9420CMFtctJw8qsCvSO1QUzOYC1
         45z2U0VWfUFDe+DEAZjCbBb4f7LSESPeKYBm2fZ6JLecrqH3TQ1UECPaBYaESN5ejgZP
         hETdgURjQwhRIXuJiAZSoPn0pJm8lus5+3+dQTA03YK4huihN4iHcq5FBsGrQViLF8oK
         zq9S2Bk+oEJfaj9TC4kwEKOSJ8C1MFOywnFtNZzzBA1l3uHI3HDxZew4jGN4GNXG0V/k
         s6DA==
X-Gm-Message-State: AOJu0YxkifhKRoxWrI515A4iOuZ2XFWge9jJ/MrFZUl7OuYLuixW8Um6
	D2nihv9fgDqMRr7ehqAUuW6/IxH5AKW8mrL6/BJGy3LbKd48GzgYTBtoG5C9ON1YpCbJiFLDkNN
	ewioaM3A6u258KhefnfVCKicKgercUJe+SiRZ
X-Google-Smtp-Source: AGHT+IEXgMUgHt38rJa9lkZWY3kg2sc8NUxr6P4rZVQj9hDCI16H5nC2o9tzHW8pEEyFHfhwuR4GhhyhIWVA70eTXH0=
X-Received: by 2002:a05:6512:280e:b0:50e:b25e:94d8 with SMTP id
 cf14-20020a056512280e00b0050eb25e94d8mr3488177lfb.41.1706499540469; Sun, 28
 Jan 2024 19:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126063500.2684087-1-wenst@chromium.org> <20240126063500.2684087-2-wenst@chromium.org>
 <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org>
In-Reply-To: <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 29 Jan 2024 11:38:49 +0800
Message-ID: <CAGXv+5Hu+KsTBd1JtnKcaE3qUzPhHbunoVaH2++yfNopHtFf4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:40=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/01/2024 07:34, Chen-Yu Tsai wrote:
> > The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> > SDIO. While the Bluetooth function is fully discoverable, the chip
> > has a pin that can reset just the Bluetooth side, as opposed to the
> > full chip. This needs to be described in the device tree.
> >
> > Add a device tree binding for MT7921S Bluetooth over SDIO specifically
> > ot document the reset line.
>
> s/ot/to/
>
> >
> > Cc: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - Reworded descriptions
> > - Moved binding maintainer section before description
> > - Added missing reference to bluetooth-controller.yaml
> > - Added missing GPIO header to example
> >
> >  .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 53 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/med=
iatek,mt7921s-bluetooth.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,m=
t7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/med=
iatek,mt7921s-bluetooth.yaml
> > new file mode 100644
> > index 000000000000..ff11c95c816c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-=
bluetooth.yaml
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-blue=
tooth.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MT7921S Bluetooth
> > +
> > +maintainers:
> > +  - Sean Wang <sean.wang@mediatek.com>
> > +
> > +description:
> > +  MT7921S is an SDIO-attached dual-radio WiFi+Bluetooth Combo chip; ea=
ch
> > +  function is its own SDIO function on a shared SDIO interface. The ch=
ip
> > +  has two dedicated reset lines, one for each function core.
> > +  This binding only covers the Bluetooth part of the chip.
> > +
> > +allOf:
> > +  - $ref: bluetooth-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt7921s-bluetooth
>
> Can it be also WiFi on separate bus? How many device nodes do you need
> for this device?

For the "S" variant, WiFi is also on SDIO. For the other two variants,
"U" and "E", WiFi goes over USB and PCIe respectively. On both those
variants, Bluetooth can either go over USB or UART. That is what I
gathered from the pinouts. There are a dozen GPIO pins which don't
have detailed descriptions though. If you want a comprehensive
binding of the whole chip and all its variants, I suggest we ask
MediaTek to provide it instead. My goal with the binding is to document
existing usage and allow me to upstream new device trees.

For now we only need the Bluetooth node. The WiFi part is perfectly
detectable, and the driver doesn't seem to need the WiFi reset pin.
The Bluetooth driver only uses its reset pin to reset a hung controller.

> Missing blank line.

Will fix.

> > +  reg:
> > +    const: 2
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      An active-low reset line for the Bluetooth core; on typical M.2
> > +      key E modules this is the W_DISABLE2# pin.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
>
> Instead 'unevaluatedProperties: false'

Will fix.


Thanks
ChenYu

