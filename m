Return-Path: <linux-kernel+bounces-64589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89318854099
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF35B2A331
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02A64A;
	Wed, 14 Feb 2024 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HohXR0uB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328267F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869011; cv=none; b=TeNMBisFCWmTtJpZinosamy/uj7gpKk/v22wI9OFK73n33JOycYr8uq4QUvD8fLiQp33Z8hMaMDK87rN+KD8AmhJGguVcXr7URNo593kgpLM0oBXIcP2odkBVgAgOuNiTdoY2uVD56tAaomLwRCtSuDHOedkBWgcraPjv27TGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869011; c=relaxed/simple;
	bh=LUHwCmgFvsLI2w7Qfq1pAeSWXQrKo7dao4Gqpb0bey4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ekz7jTwcErmhPK/X77YY4jg6SZB93YV7JlVcL0eHjibSS4D300tqBTRZJNynUI8Xjm4XqpIr2ZiYeB6Y5fChtXpX1DXZI/6qtkX05z0hNNsM+iHLMPpL9dVqggEmFRHguhzS0CYrSViTT4iGPLfsCGbN8I9hMiTMUUejJII7GvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HohXR0uB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so223527366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707869008; x=1708473808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUHwCmgFvsLI2w7Qfq1pAeSWXQrKo7dao4Gqpb0bey4=;
        b=HohXR0uBw/a0jNLqSD3RWB2JJ51gKvKRLLEpqIsp8+P0RTMT7nNvTXF58kjEgifod6
         Qwnld6KZ13xh23UpOXLEHesq74Av7sy0u90WExt51sfpMTx2p2kVBh7OeJynlslSYL8A
         IepMan/+lXwGe1MWISJut/+3st5DitcOJcVkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869008; x=1708473808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUHwCmgFvsLI2w7Qfq1pAeSWXQrKo7dao4Gqpb0bey4=;
        b=tq3F1tB5QMUF94oquMhnyA5IK/TcZqigkhAMg9ky843VWMKw7/eULTLPAOOIqPReje
         hY2vr6qVc7rZ4+UxQxB53TtsinB5phd3yDTIHCd1osnBxfPZwHGYAeLcWehP1LJVyVhR
         fUe2i08dPmz/IL9HBJ17LuTAwsiNPN9SsKtfb9YtFk7qaYLWSCaqGXopvOU3muPB0sBl
         csEDuQ9l/9eoI835r7MyA0N0T3haQDjBMIK2a0UcLD0r64vdSbmOrj//24ZkxiiuWOh6
         cKb6akhPe4I3cfgDqRIBzxiYVF/uvn1+ESEsoMhf6/9RRYB2lx7gym1ufI6DZouFhQri
         TW/w==
X-Forwarded-Encrypted: i=1; AJvYcCWzeWbXVyXQdp89bdoIEJmPHuRQ1XigInMqs5V+oDOxhJHyUvc82+95NW9Yf4EtZuR7APQBsZ4ZtrFTf/yqiKTW+569M7RBdII1FQzt
X-Gm-Message-State: AOJu0YzWxPLkTDXnSDaV8PKie2WJqJiyINWFdAIujWAa0Wko3u6022AT
	qegIB3V7CaUiEiCeySySL7Bpz4RGNv0Gc/YeY6fOl05HEYMLX1IbWX1Uduhw/e8DvNqvtxELben
	91+Pn
X-Google-Smtp-Source: AGHT+IHkuoHBKR3IDcpm/w4tojXQFeNNBHLBeMHdeZE7nmOL4a6picEbAEeUaOavHdSM+7VQZjpPLA==
X-Received: by 2002:a17:906:54c8:b0:a3c:b313:fb57 with SMTP id c8-20020a17090654c800b00a3cb313fb57mr544144ejp.17.1707869008231;
        Tue, 13 Feb 2024 16:03:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsNbZHw3ebJJxJpHGihusjzOpznQFYKV3XXS680Y2gu8ai59NQnlK++HV9hRgoFvfyDLMBk1hIIga9YFho+bzpfN4n0VtfxcFRh1mb
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm1748030ejn.224.2024.02.13.16.03.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 16:03:27 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso42155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:03:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpQ8Nb6lNMgVW99FV6CjGuXR78eYDYdS7G5DMFcU1uqh21Th7jZkIB5zKLfVz95R+SF8dKDHT2V3TAGhG136za8vHLrsyHIfCDT4q9
X-Received: by 2002:a05:600c:519b:b0:411:e5c1:9b2a with SMTP id
 fa27-20020a05600c519b00b00411e5c19b2amr21434wmb.2.1707869006878; Tue, 13 Feb
 2024 16:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-5-swboyd@chromium.org>
In-Reply-To: <20240210070934.2549994-5-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Feb 2024 16:03:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UuunNnXJ0kAzRPVy0DX7Wv2eQOa-fMJQ-aKtaGnyQaQA@mail.gmail.com>
Message-ID: <CAD=FV=UuunNnXJ0kAzRPVy0DX7Wv2eQOa-fMJQ-aKtaGnyQaQA@mail.gmail.com>
Subject: Re: [PATCH 04/22] usb: core: Set connect_type of ports based on DT node
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Pin-yen Lin <treapking@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-usb@vger.kernel.org, 
	maciek swiech <drmasquatch@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 9, 2024 at 11:09=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> When a USB hub is described in DT, such as any device that matches the
> onboard-hub driver, the connect_type is set to "unknown" or
> USB_PORT_CONNECT_TYPE_UNKNOWN. This makes any device plugged into that
> USB port report their 'removable' device attribute as "unknown". Improve
> the connect_type attribute for ports, and in turn the removable
> attribute for USB devices, by looking for child devices with a reg
> property or an OF graph when the device is described in DT.
>
> If the graph exists, endpoints that are connected to a remote node must
> be something like a usb-{a,b,c}-connector compatible node, or an
> intermediate node like a redriver, and not a hardwired USB device on the
> board. Set the connect_type to USB_PORT_CONNECT_TYPE_HOT_PLUG in this
> case because the device is going to be plugged in. Set the connect_type
> to USB_PORT_CONNECT_TYPE_HARD_WIRED if there's a child node for the port
> like 'device@2' for port2. Set the connect_type to USB_PORT_NOT_USED if
> there isn't an endpoint or child node corresponding to the port number.

The above sounds good, but then I look at patch #18 ("dt-bindings:
chrome: Add binding for ChromeOS Pogo pin connector") and patch #22
("arm64: dts: qcom: sc7180-trogdor: Wire up USB and DP to
usb-c-connectors") and it makes my Spidey Sense tingle.

Specifically, I _think_ if a port is "hard wired" that can sometimes
tell the system that the port is a bit more trusted. In the case of
the "pogo" pins on detachables, though, I don't _think_ there's
anything that prevents someone from making a "pogo to USB A port"
adapter and then you could plug anything you wanted into the pogo
port. If there's any extra trust given to these "internal" ports a
nefarious attacker could presumably abuse that trust for the pogo
pins.

I have no idea if this is a realistic concern or not. I'm about 95%
sure that hardwired "PCIe" ports get extra trust and get "deferred
IOMMU flush" enabled and, in the case of PCIe, that actually is a real
security hole. For USB, though, I think the system is more isolated by
the USB host controller so I'm not sure that there is any extra trust
given to "hard wired" ports. ...so maybe the answer here is to just
ignore my rambling. ...or maybe the answer here is that everything is
fine but patches #18 and #22 should be modified not to cause the pogo
pins to be considered as "hard wired" since they really aren't...


-Doug

