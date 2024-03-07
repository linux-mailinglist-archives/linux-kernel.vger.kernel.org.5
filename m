Return-Path: <linux-kernel+bounces-96211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448948758B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEED4B245E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CB1386AF;
	Thu,  7 Mar 2024 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY2qapAO"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209001386BA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844070; cv=none; b=MwnWc+RgyT3JL6eW+xS06/6SAn0l48i5lQJm6Myl4JUZi7xNdjaN8s70emlUTbj3k9+0h3QvOIJVHNucTdjszNS0gokqCWy/hDp96499TPzGMI0mE4fsIrB9tssHVsO4QLjUfbxgHv+DseZeHRr7yk211zTrxruaLD7jE9YcCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844070; c=relaxed/simple;
	bh=LZwpWWtQugQBGQc9yylVT8P8cssAXQMrW5mU3/cIZqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4/2W+cZJzn2krHSELbOlVabibVuzASVKlNJQjJ8X6+D1hlF0CytYkXkAMYOy1M/GSHqAcsUVTf0nys4y0PMcjvVR+FXzND/Wv5qxITtrZOMLucYK1h1R4xbSQOCy7LSksEL2YBW1YD14mX1aQOOKnz8ZvH0wOsynJrDalRkFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DY2qapAO; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so216132276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709844068; x=1710448868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2pm64rJrWGf2TC7i7wriz0x1Yj7IyNIZ1jq+izBNKQc=;
        b=DY2qapAOP9ZAQarZ6CcBOwCPl7X8gQQSWDILQrw/GW5US6+0OsJZYRIqDaUKXMzoU6
         epqrbRSX8F2HdWh9WPKJRmGDHmUjnGVLphXKsry3HKsxWufl29TuTRe1rTekXTXo5vdE
         TTrY6vIPeHb9my6NA2hxmesnstJUhmmPjCcGZBIS1LrFEkFa6AbyEL+HNqSa9OJw5E7j
         yjblkVvyyHBissOWoQrWKwI/X7cYuu1EFnpeSItvCs20fFxSfeO66PigWLzYgOC2XJKq
         hqekBfEwIKXiVV/L7GRiEKFeZ6y49esgFZmG3dBONLDT6rLkBGNEd0t3fzpKspW1BtZ/
         Vj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709844068; x=1710448868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pm64rJrWGf2TC7i7wriz0x1Yj7IyNIZ1jq+izBNKQc=;
        b=m1X2AQFEgr/PlYIUoqV+P8CGkslkFLcn8CokPfPeoJGOevdzzjYzk6cSeCz7Atosg6
         dT0tZUIEYKdhIb1RvkfaHC6ZeH/c0MrdQoKa3qBJdL4X6x+8N0N8+M+rSyn1pgY53nRo
         jo3FjKn2Au+qXqEMr466U6FM0qMfHJFLPSZBInEO1r1f4xy2KiwkEVueiHeKphqIQ6OY
         F6y6j68h/hQzBC3kW6D1PfGK4LtEi9gVlgzGFAzBY5WkvhNcdOi3mXOGrxjDZXn88uyJ
         OdrXRLq6qzEjK3K7ra8CWfoguEuROPiZLnhQ/nxr6Opefyko7b7Lztgo2omVuiwgTdNC
         MN/A==
X-Forwarded-Encrypted: i=1; AJvYcCUfU4GDR0GHpORTEXlXk00pFNX6MH/2wdHGJwpxSsmdr97hNYipael6kOpQkxW7h9HvoW6AfWHKACV1FVLEKmSvRZFUq8UvbbchnRb8
X-Gm-Message-State: AOJu0Yx/9Bwz9vXP1Ag2jcizCoS6wCxIl++9ijm3WStD/a++unBM3x6D
	Zmug0SF/1VvjI/jT7a/JdG4Pf+/nhH0d9/u9ad11Ln0pBVBjw+G1jZza8NVRFhLQHAaL7ScrXrK
	/78PR1r8QeBlH/EV6CMlPgbqZ3iIgtO+j9rVwUg==
X-Google-Smtp-Source: AGHT+IHkjxheAmKWL1zaxlw07oKvsmcoHtfNta5lFV/Ex3O+sqsAW8w16SuKppgIm8WsgtsUjDTPVMnvFKFSfSaSs3Y=
X-Received: by 2002:a05:6902:1347:b0:dcc:7131:ad4a with SMTP id
 g7-20020a056902134700b00dcc7131ad4amr15089431ybu.62.1709844068015; Thu, 07
 Mar 2024 12:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
 <20240307172334.1753343-2-sui.jingfeng@linux.dev> <CAA8EJpp8tsHi0RhsJXG+r6nOsV3AUC_n6jNHL0Cr6Ku2h3NMog@mail.gmail.com>
 <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev> <CAA8EJpqq1-cEke6wEFZFDnpz4tFBcL6HF3=Qtf-8Q3WbogLS8A@mail.gmail.com>
 <c84fcdba-af50-4212-a8e3-f492c2b02ce4@linux.dev>
In-Reply-To: <c84fcdba-af50-4212-a8e3-f492c2b02ce4@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 22:40:56 +0200
Message-ID: <CAA8EJppTcPO3j7GpGcGbKPUjQ=3rTMMOrU1SYR3mtkWLztf2qQ@mail.gmail.com>
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

On Thu, 7 Mar 2024 at 22:32, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2024/3/8 03:37, Dmitry Baryshkov wrote:
> > On Thu, 7 Mar 2024 at 21:20, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >> Hi,
> >>
> >>
> >> On 2024/3/8 02:43, Dmitry Baryshkov wrote:
> >>>> +
> >>>>    MODULE_AUTHOR("Ajay Kumar<ajaykumar.rs@samsung.com>");
> >>>>    MODULE_DESCRIPTION("DRM bridge infrastructure");
> >>>>    MODULE_LICENSE("GPL and additional rights");
> >>>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> >>>> index 3606e1a7f965..d4c95afdd662 100644
> >>>> --- a/include/drm/drm_bridge.h
> >>>> +++ b/include/drm/drm_bridge.h
> >>>> @@ -26,6 +26,7 @@
> >>>>    #include <linux/ctype.h>
> >>>>    #include <linux/list.h>
> >>>>    #include <linux/mutex.h>
> >>>> +#include <linux/of.h>
> >>>>
> >>>>    #include <drm/drm_atomic.h>
> >>>>    #include <drm/drm_encoder.h>
> >>>> @@ -721,6 +722,8 @@ struct drm_bridge {
> >>>>           struct list_head chain_node;
> >>>>           /** @of_node: device node pointer to the bridge */
> >>>>           struct device_node *of_node;
> >>> In my opinion, if you are adding fwnode, we can drop of_node
> >>> completely. There is no need to keep both of them.
> >>
> >> But the 'struct device' have both of them contained, we should *follow the core*, right?
> >> They are two major firmware subsystems (DT and ACPT), both are great and large, right?
> >> Personally, I think the drm_bridge should embeds 'struct device', after all, drm bridge
> >> are mainly stand for display bridges device. And also to reflect what you said: "to
> >> reflect the hardware perfectly" and remove some boilerplate.
> > struct device contains both because it is at the root of the hierarchy
> > and it should support both API. drm_bridge is a consumer, so it's fine
> > to have just one.
> >
>
> What I really means is that
> if one day a 'struct device *dev' is embedded into struct drm_bridge,
> we only need to improve(modify) the implement ofdrm_bridge_set_node().
> This is *key point*. Currently, they(of_node and fwnode) point to the
> same thing, it is also fine.
>
> For the various drm bridge drivers implementations, the 'struct drm_bridge'
> is also belong to the driver core category. drm bridges are also play the
> producer role.
>
> >> I think I'm not good enough to do such a big refactor, sorry. I believe that Maxime
> >> and Laurent are the advanced programmers who is good enough to do such things, maybe
> >> you can ask them for help?
> > Well, you picked up the task ;-)
>
>
> Well, my subject(title) is "*Allow* to use fwnode based API to get drm bridges".
> not "Replace 'OF' with fwnode", My task is to provide an alternative solution
> for the possible users. And to help improve code sharing and improve code reuse.
> And remove some boilerplate. Others things beyond that is not being taken by
> anybody. Thanks.

Ok, I'd defer this to the maintainers decision then.

>
>
> >
> > But really, there is nothing so hard about it:
> > - Change of_node to fw_node, apply an automatic patch changing this in
> > bridge drivers.
> > - Make drm_of_bridge functions convert passed of_node and comp
> >
> > After this we can start cleaning up bridge drivers to use fw_node API
> > natively as you did in your patches 2-4.
>
>
> Yes, it's not so hard. But I'm a little busy due to other downstream developing
> tasks. Sorry, very sorry!
>
> During the talk with you, I observed that you are very good at fwnode domain.
> Are you willing to help the community to do something? For example, currently
> the modern drm bridge framework is corrupted by legacy implement, is it possible
> for us to migrate them to modern? Instead of rotting there? such as the lontium-lt9611uxc.c
> which create a drm connector manually, not modernized yet and it's DT dependent.
> So, there are a lot things to do.

Actually, lontium-lt9611uxc.c does both of that ;-) It supports
creating a connector and it as well supports attaching to a chain
without creating a connector. Pretty nice, isn't it?


-- 
With best wishes
Dmitry

