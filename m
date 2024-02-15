Return-Path: <linux-kernel+bounces-66231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AA58558D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D79B24E59
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857A3FEF;
	Thu, 15 Feb 2024 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="knnoSljP"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75898184E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707961959; cv=none; b=aul2esPkPsvTowi/Co2M+Vwgu4VLSNauSryDyOIGQTa9gbtYCSQW5d/WD8PiCl/kyIc7350iYbUxjHg1/D/fRMrZa+pU8ighWaM+GTV/ENafMwl8eck76Mh9y12GLDZeHmXUeAMjpffH7A/TP1r7eBKu9AroPPbk2smWxZBrBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707961959; c=relaxed/simple;
	bh=WM4lIFwJI9aZm3EQ8zP4FUSooeEH5PxJSUNKg7XTZcc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTUs3XDHqnMKLbduRn9ohfdBGjK28ntI3e+Yvf6lXj78V/QFispX4J5mbEBG8wezeeWsCHnzZh1UIJQA9uJxqcoRiih9UQrqb+1cKqGKssPJ3Ght3o3ZonO0JqL7+5gZyQcvsvquCeQgJKs/Zo4rZDNICkeYhiZP4yhM0cI3Zsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=knnoSljP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so440990e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707961954; x=1708566754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUDhpSWaktAHgDMHaIrpDrRKHGUYByMrZIOMk1w7exc=;
        b=knnoSljPUP+DM1q4EMtV2bDAAb6wIdB1rpq5jDDQp977DvZOKlJHbAOcoHZfTeY/hT
         VlMqL+2IXbDcD+Xyax7DAc0CZc6hV/UkpDgJLcPE0NDSZr/L1qbCUHcbRIfNyI18WnSV
         Eny5jKbXMoEjZaLIrpMF0G91ntEWWActU7VM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707961954; x=1708566754;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUDhpSWaktAHgDMHaIrpDrRKHGUYByMrZIOMk1w7exc=;
        b=n6sUroGvsNb1W08jDI9E4oQjrUVnQZw1+LgHVaDB9BjpFiumqBhPuGoFDwygB1tVJ+
         Mpm0CKN6NihAnD3n2E5gQexskFwajZhJ99dgDVCm3VfdZMgUJj55HPKhePVAqdVK26Mc
         Zpl1QW4HNtEwgPU+dfTywbtPewpXl21hYI3iheXErWLw2pSc6+lzSbZ2fAu/oXAuQB0x
         komvJWsFJlaZyBdVTiSO0qY7d2sCi2/Ge58mqwauIPYv1VSu8+KjGwC12nIajZihEzVB
         J3u1hcDDkWGzbf77zHiSLBZH6GQMO1HoF3C6L6lMj6KIvNJavSI8vgtLBqWd7sVIQqVV
         oo2w==
X-Gm-Message-State: AOJu0YzMDH9E+iIO4/fWE0b0iModnBrZDTrG0y/25Gr6g6DlvSQPuyLV
	eJIaS+V6RMBoKWaeD+mGl4b6yx/6qCjKBDhewXE/T6EvV55HRK6AlonjAv4Thk2du9hZsx+0Qum
	eU/mlGwExWJfYp5PqhK/035Jcv7QnXZqPnT1w
X-Google-Smtp-Source: AGHT+IGRTMpBbk9bxMzh6L25v7/Xsvqzk7aZ8aOwSIfCL6t8r+0G7VepodLsRuDT3PsIwVmpPB02ksb47t2sauMlvis=
X-Received: by 2002:a05:6512:2c8f:b0:512:88a8:1520 with SMTP id
 dw15-20020a0565122c8f00b0051288a81520mr107848lfb.18.1707961954357; Wed, 14
 Feb 2024 17:52:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Feb 2024 17:52:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <46ac6ab8-b0a5-497d-91b6-1d2ced33184b@linaro.org>
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-14-swboyd@chromium.org>
 <46ac6ab8-b0a5-497d-91b6-1d2ced33184b@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 14 Feb 2024 17:52:33 -0800
Message-ID: <CAE-0n52TzOAqN8Y7EdJPjDxY2iY-6Jr-Pq8fFMFtF-cXo5+OyA@mail.gmail.com>
Subject: Re: [PATCH 13/22] dt-bindings: chrome: Add google,cros-ec-typec-switch
 binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Prashant Malani <pmalani@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Krzysztof Kozlowski (2024-02-11 05:34:25)
> On 10/02/2024 08:09, Stephen Boyd wrote:
> > Add a binding for the USB type-c switch controls found on some ChromeOS
> > Embedded Controllers (ECs). When this device is a mode switch, it takes
> > one DisplayPort (DP) port as input and some number (possibly zero) of
> > USB SuperSpeed ports (bundles of USB SS lanes) as input, and muxes those
> > lanes into USB type-c SuperSpeed lanes suitable for the SSTRX1/2 pins on
> > a usb-c-connector. When this device is an orientation switch, it
> > redirects the DP lanes to the proper USB type-c SSTRX lanes.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Lee Jones <lee@kernel.org>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Prashant Malani <pmalani@chromium.org>
> > Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> > Cc: <devicetree@vger.kernel.org>
> > Cc: <chrome-platform@lists.linux.dev>
> > Cc: Pin-yen Lin <treapking@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../chrome/google,cros-ec-typec-switch.yaml   | 365 ++++++++++++++++++
> >  .../bindings/mfd/google,cros-ec.yaml          |   5 +
> >  2 files changed, 370 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml
> > new file mode 100644
> > index 000000000000..17a0ba928f5d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml
> > @@ -0,0 +1,365 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec-switch.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Google Chrome OS EC(Embedded Controller) USB Type C Switch
> > +
> > +maintainers:
> > +  - Benson Leung <bleung@chromium.org>
> > +  - Prashant Malani <pmalani@chromium.org>
> > +  - Stephen Boyd <swboyd@chromium.org>
> > +
> > +description:
> > +  Chrome OS devices have an Embedded Controller(EC) which has access to USB
> > +  Type C switching. This node is intended to allow the OS to control Type C
> > +  signal muxing for USB-C orientation and alternate modes. The node for this
> > +  device should be under a cros-ec node like google,cros-ec-spi.
> > +
>
> If this is USB Type C switch, then you miss reference to
> usb-switch.yaml, but then ports look a bit different.

Thanks for the pointer. I suspect that's in linux-next only? I'm going
to move this to the cros-ec-typec.yaml file but I'll still need some
sort of property like 'mode-switch' or 'orientation-switch' to describe
what needs to be done in the kernel by changing lane assignments in the
drm_bridge.

One problem with those properties is that they're boolean for the whole
device. If I have a google,cros-ec-typec node that has two input DP
ports and two output USB-C ports then it may be that one port needs
orientation switching and the other only needs to do mode switching.
This needs to be expressed somehow and a top-level boolean property
doesn't do that. It could be part of the DP endpoint node itself.

Also I don't know how to indicate that mode switching can't be changed
here directly. For example, on Trogdor the mode is switched by the EC,
and the kernel can't change the mode. Changing DP lane assignments isn't
going to change the situation either. The mode is still going to be
something like DP+USB, or just DP, etc. Maybe there needs to be a
different property, like 'dp-mode-lane-assignment = <array of ports>',
that indicates which DP ports need to do lane assignment or
'dp-orientation-lane-assignment = <array of ports>' for orientation
control. Either way, I'm saying that 'mode-switch' and
'orientation-switch' properties don't make any sense here. I was using
them to wedge the code into the typec switch callbacks, but if I move
this into the cros-ec-typec driver then I don't need them.

>
> > +
> > +  no-hpd:
> > +    description: Indicates this device doesn't signal HPD for DisplayPort
> > +    type: boolean
> > +
> > +  ports:
[...]
> > +
> > +          endpoint@7:
> > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +            description: USB-C data for EC's 7th type-c port
> > +            unevaluatedProperties: false
> > +            properties:
> > +              data-lanes:
> > +                $ref: /schemas/types.yaml#/definitions/uint32-array
> > +                description: |
> > +                  An array of physical USB-C data lane indexes.
> > +                  - 0 is SSRX1 lane
> > +                  - 1 is SSTX1 lane
> > +                  - 2 is SSTX2 lane
> > +                  - 3 is SSRX2 lane
> > +                minItems: 4
> > +                maxItems: 4
> > +                items:
> > +                  maximum: 3
> > +
> > +        anyOf:
> > +          - required:
> > +              - endpoint@0
>
> I don't get what you want to say here. This anyOf should have no effect.

I'm trying to say that there should be at least one usb-c data lane
output endpoint if there's a port@2 (usb-c output).

>
> > +          - required:
> > +              - endpoint@1
> > +          - required:
> > +              - endpoint@2
[...]
>
> > +
> > +required:
> > +  - compatible
> > +  - ports
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        no-hpd: true
>
> I don't understand this either. What is it for? Where did you see such
> syntax?

This is saying that if the no-hpd property is present then the port@0
port (DP input port) is required. Otherwise no-hpd doesn't really make
any sense because this device isn't muxing DP onto USB type-c connectors.

I found this syntax by searching the schema website and reading this
page[1]. The last yellow note about "country" not being a required
property led me to this syntax.

[1] https://json-schema.org/understanding-json-schema/reference/conditionals#ifthenelse

