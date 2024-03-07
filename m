Return-Path: <linux-kernel+bounces-96118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8014875757
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49495B2261A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12B1369A6;
	Thu,  7 Mar 2024 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrEF6z5w"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866A136663
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840248; cv=none; b=LLkBBeLUUgApV3dpTiW+NbxYO6DeRdUBnboQTT41dX1XUuLXsAYhM+sO8U/2DeWSYgUcnKRncXTdTGiOeKkxYQ5VQYZL0sbRLMJkmeYzWAMVhZJ/2Nkf5VFuHBZ8YG8on7o0NMyGZ4ELhzISb3lPl47WFtQ9+Er+QY+U3efCdug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840248; c=relaxed/simple;
	bh=a6lwjcKCqdtsf90Qal7wyFWTBM8QUGg4Zfu+M6m/CPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLkHgQkR+//SpmGVaKkcEplDkLlCoBGiMfrJBihvavq64BJ6u/o9Pm1h3KP1lZTK0wgGfoYE1CpqJMOyqoeWA2B+peOoPWEdfXmWgFiNuC/0/XdUi0AqSM97EkKvReMfGv1Lyr2XjSDeaqCLQFdOz8qiM09H+26jSfMrTYcXApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wrEF6z5w; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso1303665276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709840245; x=1710445045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D+atELKvQOOLnHOaCYsPXNofIf9HuHvn8BNu51WCFxw=;
        b=wrEF6z5weOcO0/ZTj1X0NNaZICgd42SzgcmwgzNqNWBhMQHXVAJsBqOgYzzLEnU2H/
         SiDNT2EUCboN6nrZSv7G897HY8DSVK29x0ofqq5SS7Z0h/9TWbK/1fCQceuayMxnKYar
         LZJxk/McgHHFMef/U42dENSD7AOdaxwjzNSI8krIZJ1VRXff6UTucMeJbMpI2GL6lsT2
         jsLQzm8qrhgX02DKHOgCBJDNsRh1HdIJZMFr0X0TOKbVTvOl3RSqR+NEKR8ZztyEAW4v
         SPEU0EZLXGhnPna2bBvwT14Cnj2Wxt2Idn5PK+Brun/SQapQEqW2mdd6Bxey1xHr0o9t
         +D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709840245; x=1710445045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+atELKvQOOLnHOaCYsPXNofIf9HuHvn8BNu51WCFxw=;
        b=XSa+caL6VZwY/L0OWjJDKy5Ib2C7ICSKVqueCCKPKaNQMrxWrf3xX+YBW/QjmvlIVL
         TGs8GhE7tY682F8+Z0+DH5BX+r1dowB2DYWECcrP8ZLBLBQRQYDltxsfdOoqBk8F+zJJ
         X/pL+G4L3qjMAAYgATyqlwnhmelkos39czWY9Nh+3uO4lo54plV5//Tqk98leynGWWFR
         Ak8S+CtAz+4wlW57foHE7VHYS5M3ncEUdEdcpG63nUusGvEvy6qBfuhITCHHcQv9idm6
         K3aT0IIxcMD1tdD6X0PrM1w71CodidZ2LPnz9f2uC7+u9AaZvZrO5oL8HrqvBuhVmEwj
         HIow==
X-Forwarded-Encrypted: i=1; AJvYcCUKHcZ6uxQqz8KCP5a2iC8petctMRsx6XH47I62guO+xSUP2GSoZfljfa2JOWKQs62EP64FHxcdPL15hjcnxvnhZRugiJXdhXZP7Jpn
X-Gm-Message-State: AOJu0YwqoQWhiFXPSJ9rc9ADyLiBeplyymO5eTZdNWcmsrF1trYv63Ih
	1GAzQtiZZRTWYlzXlMDcrzqE81FV6cJbn/kepiAYymdxaqJUce19zzCA3j1ohgBMUyVK4ReJr+g
	nOoC49EPcMehqo8VtJ93PkOAzXFMrEd3OlhLuPg==
X-Google-Smtp-Source: AGHT+IFAnShZV5B8zjpb+Ymnm9dteFJx1LbcFdYtXwIKtOPBCLHsKmz4rnlqziHI0HmbJieqTl2MvvMl+PazihZSUw8=
X-Received: by 2002:a25:d502:0:b0:dbd:553d:9d6a with SMTP id
 r2-20020a25d502000000b00dbd553d9d6amr15441308ybe.40.1709840245408; Thu, 07
 Mar 2024 11:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
 <20240307172334.1753343-2-sui.jingfeng@linux.dev> <CAA8EJpp8tsHi0RhsJXG+r6nOsV3AUC_n6jNHL0Cr6Ku2h3NMog@mail.gmail.com>
 <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev>
In-Reply-To: <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 21:37:14 +0200
Message-ID: <CAA8EJpqq1-cEke6wEFZFDnpz4tFBcL6HF3=Qtf-8Q3WbogLS8A@mail.gmail.com>
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

On Thu, 7 Mar 2024 at 21:20, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2024/3/8 02:43, Dmitry Baryshkov wrote:
> >> +
> >>   MODULE_AUTHOR("Ajay Kumar<ajaykumar.rs@samsung.com>");
> >>   MODULE_DESCRIPTION("DRM bridge infrastructure");
> >>   MODULE_LICENSE("GPL and additional rights");
> >> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> >> index 3606e1a7f965..d4c95afdd662 100644
> >> --- a/include/drm/drm_bridge.h
> >> +++ b/include/drm/drm_bridge.h
> >> @@ -26,6 +26,7 @@
> >>   #include <linux/ctype.h>
> >>   #include <linux/list.h>
> >>   #include <linux/mutex.h>
> >> +#include <linux/of.h>
> >>
> >>   #include <drm/drm_atomic.h>
> >>   #include <drm/drm_encoder.h>
> >> @@ -721,6 +722,8 @@ struct drm_bridge {
> >>          struct list_head chain_node;
> >>          /** @of_node: device node pointer to the bridge */
> >>          struct device_node *of_node;
> > In my opinion, if you are adding fwnode, we can drop of_node
> > completely. There is no need to keep both of them.
>
>
> But the 'struct device' have both of them contained, we should *follow the core*, right?
> They are two major firmware subsystems (DT and ACPT), both are great and large, right?
> Personally, I think the drm_bridge should embeds 'struct device', after all, drm bridge
> are mainly stand for display bridges device. And also to reflect what you said: "to
> reflect the hardware perfectly" and remove some boilerplate.

struct device contains both because it is at the root of the hierarchy
and it should support both API. drm_bridge is a consumer, so it's fine
to have just one.

>
> I think I'm not good enough to do such a big refactor, sorry. I believe that Maxime
> and Laurent are the advanced programmers who is good enough to do such things, maybe
> you can ask them for help?

Well, you picked up the task ;-)

But really, there is nothing so hard about it:
- Change of_node to fw_node, apply an automatic patch changing this in
bridge drivers.
- Make drm_of_bridge functions convert passed of_node and comp

After this we can start cleaning up bridge drivers to use fw_node API
natively as you did in your patches 2-4.

>
> Beside this, other reviews are acceptable and will be fixed at the next version,
> thanks a lot for review.
>
>
> Best Regards,
> Sui
>


-- 
With best wishes
Dmitry

