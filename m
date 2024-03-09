Return-Path: <linux-kernel+bounces-97855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1C87707E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531A41C20DB0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F832C853;
	Sat,  9 Mar 2024 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="df/cieuF"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39052576F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980813; cv=none; b=TRSkjfKG3HMcVnHu8E61pVoIJvyHy4+c4vkWL5XPO693ff04UJ4/aRbKZazqUMwJRwz2+OrE4yQzArH65dGZE67vCKluJof6NIiCou2dUdFwuPiA0nxF9TZXer2PXVR66rJVD7dxnR2EbRUCunu32dk7Er+lbU/s0A0yesWRV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980813; c=relaxed/simple;
	bh=NP3cQDF260viwDSlbauqEdXoECn6VqXHgFbcF4uWnK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsaKU5bxcH0BNTUUrrSLo2h5+EdgwixzY50fXruYgEQsaICkJPh5K4LRYM9KyI6QGjBZC6Dxs8n84IYwn8q9Zkz5SQxUS/R2aoN7EzJfhVweWMrqpakU9ZqcrUpTy2y9CbBLnCy8R5flN+BnzQKv5tBFRAewfS5yxkdn1qthpXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=df/cieuF; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1902914276.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 02:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709980810; x=1710585610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP3cQDF260viwDSlbauqEdXoECn6VqXHgFbcF4uWnK8=;
        b=df/cieuFdq3DtVHtVow5BYEIFfsuhPFpTfRhh0OkC+9tpyu0Qs0QSShGHmg/NutQ08
         JnAiaRF4RLLfhGM/lwWP9ezcdshDyld+R0Nmn/GCh6C4UFX2qPZvK1/JV7kRVlpSJO2O
         btj1oM69gmQNjj2vdH6LfGtIeEU8boq4U6rtn6Tb624sE68W9K1YJlZzcZK9qav+R6KS
         e1IYYnOwz7UcnpHQ6L3mBFgUWPX4+QH91ID6lGVKWnQjEkLuYU9izP8qUF27gyWHBTD2
         mbXradsPTFfBFiO7yIhA3+56RWZGSpqJEGpm7gaohjHgWidz/1CsRbyjWDWbG4Y4RhOB
         jzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709980810; x=1710585610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP3cQDF260viwDSlbauqEdXoECn6VqXHgFbcF4uWnK8=;
        b=AlN/gxUbpBHs6h2M8MSUKbKoV3G1+W5PY1/MxaGjNwPlMAlWjycvQ5rON/F+t9usnA
         l7MIu2kJJ3W1oliS8fOqGVpuu04mvaS/5xe0J6iZjl+kDZNmsk2diGZ6Tl3sWIa6HfSo
         ya2QzTHZ//xpnd5Ox9VP+J/5tU3/3YvYHk2MUp5leiHkXqjYjy9H5r7LCXcZOUPPNPES
         Rc2PnjvJOyy9dS3sJUHtOzomYEgb+i6kvxllhbk8lUxgw+SYtw1x9Ck3QNJmNnLA2Wtd
         zY5rDzG8Ka5UR+albIm3DWUnVnIXvyqpvFE0W5m/igcpR+dQaq1jOI8Hm8+vJSUwuVBf
         faJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs2fQyPa0JQNuUFLPzZ6121daXi58mewARWcZnYfxUDr9BUhDX7cf28194ACJsoD2uydy7kjK/QxYqHWQDhsaJQhR6NQHlzWh1mHWG
X-Gm-Message-State: AOJu0YwMOUBztkSscQU5cFm8FjDh7wiapXD7K1cKhux2iDBQOAMuhlHY
	q2e3W6NOeaZTojOb6ZV8z0Mua7aTt5HbT/kXY0K89NskN2iQAjejvfXJ2Glt7qjfzS5BED5jd4F
	xq9RXNOAueIqWQacB7B96iW6LcdcKlRbOrLhRWg==
X-Google-Smtp-Source: AGHT+IEJwcizfo5A8gfKqIygwwbgsE2Tdi29/QzTZ5gb8cld1hDMTE9LBt/lM02SHJSSn4cViiX35Os1mROyOKGXZFA=
X-Received: by 2002:a25:874c:0:b0:dc7:4460:878a with SMTP id
 e12-20020a25874c000000b00dc74460878amr855917ybn.3.1709980810558; Sat, 09 Mar
 2024 02:40:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
 <20240307172334.1753343-2-sui.jingfeng@linux.dev> <CAA8EJpp8tsHi0RhsJXG+r6nOsV3AUC_n6jNHL0Cr6Ku2h3NMog@mail.gmail.com>
 <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev> <CAA8EJpqq1-cEke6wEFZFDnpz4tFBcL6HF3=Qtf-8Q3WbogLS8A@mail.gmail.com>
 <c84fcdba-af50-4212-a8e3-f492c2b02ce4@linux.dev> <CAA8EJppTcPO3j7GpGcGbKPUjQ=3rTMMOrU1SYR3mtkWLztf2qQ@mail.gmail.com>
 <7535b3ba-6bbb-411c-82a4-cd4ac45de1a6@linux.dev>
In-Reply-To: <7535b3ba-6bbb-411c-82a4-cd4ac45de1a6@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 9 Mar 2024 12:39:59 +0200
Message-ID: <CAA8EJpp3yd33pYweL_exrXMJ3g-m7-yjJrjiVMVMevOadBtt8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/bridge: Add fwnode based helpers to get the
 next bridge
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Mar 2024 at 11:33, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2024/3/8 04:40, Dmitry Baryshkov wrote:
> >>> But really, there is nothing so hard about it:
> >>> - Change of_node to fw_node, apply an automatic patch changing this i=
n
> >>> bridge drivers.
> >>> - Make drm_of_bridge functions convert passed of_node and comp
> >>>
> >>> After this we can start cleaning up bridge drivers to use fw_node API
> >>> natively as you did in your patches 2-4.
> >> Yes, it's not so hard. But I'm a little busy due to other downstream d=
eveloping
> >> tasks. Sorry, very sorry!
> >>
> >> During the talk with you, I observed that you are very good at fwnode =
domain.
> >> Are you willing to help the community to do something? For example, cu=
rrently
> >> the modern drm bridge framework is corrupted by legacy implement, is i=
t possible
> >> for us to migrate them to modern? Instead of rotting there? such as th=
e lontium-lt9611uxc.c
> >> which create a drm connector manually, not modernized yet and it's DT =
dependent.
> >> So, there are a lot things to do.
> > Actually, lontium-lt9611uxc.c does both of that =F0=9F=98=89 It support=
s
> > creating a connector and it as well supports attaching to a chain
> > without creating a connector. Pretty nice, isn't it?
>
>
> But why the drm_bridge_connector helpers and/or the drm_connector bridge =
can't suit you need?
> Coding this way just add boilerplate into drm bridge subsystem, right?

Because there are platforms, like iMX LCDIF which can use the
lt9611uxc bridge, but do not make use of the drm_bridge_connector yet.

> The code path of "creating a connector" plus the code path of "not creati=
ng a connector"
> forms a 'side-by-side' implementation imo.
>
> Besides, I have repeated many times: the DT already speak everything.
> Device drivers can completely know if there is a display connector OF dev=
ice created and how many
> display bridges in the whole chain. If there are connector device node in=
 the DT, then it should
> has a device driver bound to it(instead of create it manually) for a perf=
ect implementation. As
> you told me we should not *over play* the device-driver model, right?

Please, don't mix the connector node in DT and the drm_connector. If
you check the code, you will see that the driver for hdmi-connector,
dp-connector and other such devices creates a drm_bridge.

--=20
With best wishes
Dmitry

