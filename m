Return-Path: <linux-kernel+bounces-66133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E45985577F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94FEB235F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAC1420DB;
	Wed, 14 Feb 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OM9jhaoz"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF11420B6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954687; cv=none; b=Tf4AdtTDUiPYnrpal+xEufa9pz68Nuj9fCDRIV8jymjrEdCTEPJaTugpFvW4lfeuMBYDXRVh0zGWNV7q8+KFncNxAKrLLbQ8UTGX5m5sc8HtbSpbwYyvoEWJAxlPBUYG6/OqBT1PIj9EA56kY9XOExruYUMIQTnIPN4tLyTlJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954687; c=relaxed/simple;
	bh=gC+EHOPYgEnF4B4thgpejb8qEq5JPx1Zww7p4djo4U8=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3lTgspzQd8Dd8hgg+R8wP7mLsFtPFobMzi1oUsUeqRssjJa8pHpMPH0njX1GbjqjFZVrh+oJELuBwKzxzMV3+EyjHo5a2bnlntBNSWPv+CEK/DHi9LL3d69/XSo3K42o5zdohvOqVs7zDspYlWK0aXc4yLHo5LghY09PJu2iwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OM9jhaoz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51197ca63f5so367022e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707954678; x=1708559478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC+EHOPYgEnF4B4thgpejb8qEq5JPx1Zww7p4djo4U8=;
        b=OM9jhaozeUM0qJdXcnYNfoZ5rOWPSyeUqfGlWFjFhhuUw+PFX71ToeEPbz3XF29S+i
         QJpWT9uDbkEJRy36Nxtcrp6Q/cpe26tKTXHvQJY3p+2enE+OIX84Afhks6re1yumjvZM
         DaVoJS0iLYfFeO9yS74w156tz+VGL/BwmeVCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707954678; x=1708559478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gC+EHOPYgEnF4B4thgpejb8qEq5JPx1Zww7p4djo4U8=;
        b=jMqNX0dSCERn9O5lbeXVQ/NWVkqJZw3Ax37CaNdQNbWsC2xMB2104zMuBIp/zr/gjQ
         PIuBim+IMUYX+DDk0F/gOOakS8L3rek9AdmyLEC2/LDI+j/nNBbs10QZCc9bWp2lt5og
         5pjvI6HhpQ/EMzIOCLBroBx40SMe5ePrI42z87EQGeUTzUVXq5r9BkkCzesh2A3nPq30
         2ajEPsFBYgR1btktOfGvDEnqhwhwsmD95tm2TygLR4+aqr9rSJaN1FQhRuDwJgUwDliM
         9liMMZZQZ/I3n9STeK/b9KjkFifEbrhmZAvJSbpQkYgQW8yWV9zIiE5jqQP1FMoGNFyk
         XY3g==
X-Forwarded-Encrypted: i=1; AJvYcCVaTzKzaq1dvwTg0xC8w66i9kEJcZs7vZWXcZtxZqU2x00ThX3Lp4sxcIyC9gwxC8t7BBFrkjTwocDQcP7BUPs3WIbG9HAzD7wI2wJc
X-Gm-Message-State: AOJu0YwWHJQ+86XzipNZkQkv4zZ3puNRXTAxkl8KNoESzHaNmx8Pnyze
	0Ib9WKECDxRdTU+ePx8K6RPCEhqPigUCM4mbxf/aDlgUCEqP/OP7/UzyF2yc9sLeRhw90wxV9bA
	86SD2EEvKZ+2mq/lbkO6tJE8tthfAAGLO5ZA3
X-Google-Smtp-Source: AGHT+IHY6HUhss7mHx1ExihADt6J1OI5zkXYcKo2xuLwjQ63JGNlMqWZ5oVvebM0eOWq56qXmv8DOgdu6dbCXc/ooo8=
X-Received: by 2002:a05:6512:3ca5:b0:511:87c6:3060 with SMTP id
 h37-20020a0565123ca500b0051187c63060mr321912lfv.12.1707954678054; Wed, 14 Feb
 2024 15:51:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Feb 2024 15:51:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UuunNnXJ0kAzRPVy0DX7Wv2eQOa-fMJQ-aKtaGnyQaQA@mail.gmail.com>
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-5-swboyd@chromium.org>
 <CAD=FV=UuunNnXJ0kAzRPVy0DX7Wv2eQOa-fMJQ-aKtaGnyQaQA@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 14 Feb 2024 15:51:17 -0800
Message-ID: <CAE-0n51b9=BJv6PMmsdLDT7tcgKT63qrqNknp-CQd5BOb1dhjA@mail.gmail.com>
Subject: Re: [PATCH 04/22] usb: core: Set connect_type of ports based on DT node
To: Doug Anderson <dianders@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Pin-yen Lin <treapking@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-usb@vger.kernel.org, 
	maciek swiech <drmasquatch@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Quoting Doug Anderson (2024-02-13 16:03:11)
> Hi,
>
> On Fri, Feb 9, 2024 at 11:09=E2=80=AFPM Stephen Boyd <swboyd@chromium.org=
> wrote:
> >
> > When a USB hub is described in DT, such as any device that matches the
> > onboard-hub driver, the connect_type is set to "unknown" or
> > USB_PORT_CONNECT_TYPE_UNKNOWN. This makes any device plugged into that
> > USB port report their 'removable' device attribute as "unknown". Improv=
e
> > the connect_type attribute for ports, and in turn the removable
> > attribute for USB devices, by looking for child devices with a reg
> > property or an OF graph when the device is described in DT.
> >
> > If the graph exists, endpoints that are connected to a remote node must
> > be something like a usb-{a,b,c}-connector compatible node, or an
> > intermediate node like a redriver, and not a hardwired USB device on th=
e
> > board. Set the connect_type to USB_PORT_CONNECT_TYPE_HOT_PLUG in this
> > case because the device is going to be plugged in. Set the connect_type
> > to USB_PORT_CONNECT_TYPE_HARD_WIRED if there's a child node for the por=
t
> > like 'device@2' for port2. Set the connect_type to USB_PORT_NOT_USED if
> > there isn't an endpoint or child node corresponding to the port number.
>
> The above sounds good, but then I look at patch #18 ("dt-bindings:
> chrome: Add binding for ChromeOS Pogo pin connector") and patch #22
> ("arm64: dts: qcom: sc7180-trogdor: Wire up USB and DP to
> usb-c-connectors") and it makes my Spidey Sense tingle.
>
> Specifically, I _think_ if a port is "hard wired" that can sometimes
> tell the system that the port is a bit more trusted. In the case of
> the "pogo" pins on detachables, though, I don't _think_ there's
> anything that prevents someone from making a "pogo to USB A port"
> adapter and then you could plug anything you wanted into the pogo
> port. If there's any extra trust given to these "internal" ports a
> nefarious attacker could presumably abuse that trust for the pogo
> pins.

The pogo pins on detachables are connected via the OF graph, so they are
only ever going to be either "not connected" or "hotplug". They can't
become "hard wired" because they're not a child node with a reg property
corresponding to the USB port.

>
> I have no idea if this is a realistic concern or not. I'm about 95%
> sure that hardwired "PCIe" ports get extra trust and get "deferred
> IOMMU flush" enabled and, in the case of PCIe, that actually is a real
> security hole. For USB, though, I think the system is more isolated by
> the USB host controller so I'm not sure that there is any extra trust
> given to "hard wired" ports. ...so maybe the answer here is to just
> ignore my rambling. ...or maybe the answer here is that everything is
> fine but patches #18 and #22 should be modified not to cause the pogo
> pins to be considered as "hard wired" since they really aren't...
>

Pogo pins should be considered hot plug with this patch series, but I
will double check that I didn't mess up that logic.

