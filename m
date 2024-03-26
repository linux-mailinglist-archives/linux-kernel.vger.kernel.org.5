Return-Path: <linux-kernel+bounces-118211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD2E88B5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4B71F39C97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498631370;
	Tue, 26 Mar 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lbhIi28c"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904C37E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412502; cv=none; b=pQNJJ+e75jPCCvSMNVIR8E842i31124Y4KqniEczVIpLNAu8/rOTSNDUjsgs8u8czu/mnyVtiDxUVs5vwZsAtwDox+pRftbva3k01si/sp5Nwdt7WVtwhgWWdjP2xCm77IiasYqPF7JmbM0k4cLVIIpVfGr1QVaBEcolrr2LlE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412502; c=relaxed/simple;
	bh=FT1EM+1Bc7G4g/4wAtGmRHTGx5UzYVlDVsxgfD76rkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOlKc/eK46IDQ5NKVw2sOhbIM+kGNn47STzJTIcu0FIX+XnjqZDp2Tj8aa6zpmuxmsKhjlzuQMjnuSh/IgWvDRuOEu0pdUnf7gS99FHcfJuxHS4f2t0QbPWJZpzBPnPPOX5gVA0+o/MtgqOke7vmPwAJeFVJ7yvyduScLqySp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lbhIi28c; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a5f7269e3so44310985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711412498; x=1712017298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJErg4VRvYhsmdtGKXiUunocztQDn+7oNfRma22BjII=;
        b=lbhIi28czBNU+uDbHEvl7A30ynrPfuf+7vQ/ZQl4le/FUPfyC4gyiiCf8wAu+Jf3L0
         9NwwPuylMNp5k9eRNzNLjO6qXwyuoOjLXnGa0GYmydAQtq4i5LUl/dBofo4GNX++wZ3e
         /ZI++ZA0hmZugUL1my4SgZ+nkWjdrAb09ljyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711412498; x=1712017298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJErg4VRvYhsmdtGKXiUunocztQDn+7oNfRma22BjII=;
        b=g++CfU1cVV3Xq6tJ2Be8RC+eKNJmpQ7MMQzye7lc/S03/F43VyZ/qVeX6JPIbgKoC8
         WB6nO2Kf4cyZAojSpl8VlUDuthtuQMvNJnm6IDkTVv6ZEpoFZpUlrpGzbWoBMNnStoWo
         zP+1dG/YZ5WKH1piT9wN+1YaEXyuRFqPUEgQTn+T1EvlZyIfXH5oyBpMA+If/6DsTGvy
         Nwf2LZy2nY+++rGk1NLz8wzMKoAgDwcCsoYQpNyWNvv8gnLa3u0YJqoG46SV1wrcLUWN
         omfvP7oacyepkToklDbp0DDQ7e6dn2JmO1+CvKLUio5Wwa7SIFg0Kim0x/4zo2k7wVHM
         9G8g==
X-Forwarded-Encrypted: i=1; AJvYcCU3+xT2GyNWZxCPyTIUig379ETF7QQ9K0avZTGxZGzoufkly03qu8H2eNlkpjFh4Vnr77GJ0JVV46SmJwK8vUSCNkJsohUP2+Q9fCiU
X-Gm-Message-State: AOJu0YwD9bu0eNPvx2K4BAeVcJPrdxM2jjbEAfFWlLyAYrWVfu7z2cQ3
	U8og90a15Q+5KT0SIkPcUPi9gW5KAis6jUCZGBv+wdVuhelvMcc1mxxq7IBkRiiwPI+jHz3yOTM
	=
X-Google-Smtp-Source: AGHT+IG/zNeSKUlrUc/78b9YRGcpq8nX/yJerpqmL+0H4iF04+EWl9r1VGS/VfZGK4X2Pfv1XjvthA==
X-Received: by 2002:a05:620a:2488:b0:78a:557a:41d6 with SMTP id i8-20020a05620a248800b0078a557a41d6mr7980924qkn.24.1711412498548;
        Mon, 25 Mar 2024 17:21:38 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a12e900b00789dd526bc7sm2541467qkl.129.2024.03.25.17.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 17:21:37 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42ee0c326e8so57801cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:21:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXP1LOgoAQNaBJ45owf3p5Qw1Ww0ueh5Gg6CWAWX5DAIJVjNWzJHxlPfO0wmsJCAGNdDGYhO4d/PUKfkgQKQ8O9YTMjIKgxCTGt1EsW
X-Received: by 2002:a05:622a:4c89:b0:431:6352:80fb with SMTP id
 ez9-20020a05622a4c8900b00431635280fbmr74987qtb.16.1711412497043; Mon, 25 Mar
 2024 17:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12472820.O9o76ZdvQC@mephi-laptop>
In-Reply-To: <12472820.O9o76ZdvQC@mephi-laptop>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 17:21:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8N0g0P1d85P0nJHHSkb9xZ-hxJATYD2+b_nNrwqfsUg@mail.gmail.com>
Message-ID: <CAD=FV=X8N0g0P1d85P0nJHHSkb9xZ-hxJATYD2+b_nNrwqfsUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel: Remove redundant checks in multiple panels
To: Emilio Mendoza Reyes <emendoz@g.clemson.edu>
Cc: neil.armstrong@linaro.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 23, 2024 at 7:05=E2=80=AFPM Emilio Mendoza Reyes
<emendoz@g.clemson.edu> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> From: Emilio Mendoza Reyes <emendoz@clemson.edu>
>
> The patch ("drm/panel: Check for already prepared/enabled in drm_panel")
> moved checking for (en/dis)abled and [un]prepared panels before specific
> function calls to drm_panel.c.Those checks that still exist within the
> panels are redundant. This patch removes those redundant checks.
>
> Removing those checks was/is also a todo in the kernel docs
> Link: https://www.kernel.org/doc/html/v6.8/gpu/todo.html#clean-up-checks-=
for-already-prepared-enabled-in-panels
>
> Signed-off-by: Emilio Mendoza Reyes <emendoz@clemson.edu>
> - ---
>  drivers/gpu/drm/panel/panel-boe-himax8279d.c     | 12 ------------
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c   |  6 ------
>  drivers/gpu/drm/panel/panel-edp.c                | 14 --------------
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c    | 12 ------------
>  drivers/gpu/drm/panel/panel-jdi-lt070me05000.c   | 12 ------------
>  drivers/gpu/drm/panel/panel-khadas-ts050.c       |  9 ---------
>  .../gpu/drm/panel/panel-kingdisplay-kd097d04.c   | 12 ------------
>  .../gpu/drm/panel/panel-leadtek-ltk050h3146w.c   |  6 ------
>  .../gpu/drm/panel/panel-leadtek-ltk500hd1829.c   |  6 ------
>  drivers/gpu/drm/panel/panel-novatek-nt36672a.c   |  6 ------
>  .../gpu/drm/panel/panel-olimex-lcd-olinuxino.c   | 12 ------------
>  .../gpu/drm/panel/panel-osd-osd101t2587-53ts.c   | 12 ------------
>  .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c | 12 ------------
>  drivers/gpu/drm/panel/panel-raydium-rm67191.c    | 12 ------------
>  drivers/gpu/drm/panel/panel-raydium-rm692e5.c    |  6 ------
>  drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 16 ----------------
>  drivers/gpu/drm/panel/panel-seiko-43wvf1g.c      | 12 ------------
>  drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c  | 12 ------------
>  drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c  |  6 ------
>  drivers/gpu/drm/panel/panel-simple.c             | 14 --------------
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c    |  6 ------
>  drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c     |  6 ------
>  drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c |  6 ------
>  23 files changed, 227 deletions(-)

Aside from the formatting issues (several lines start with an extra
"-" and there is the PGP stuff), there are a few high-level issues
here:

1. In general, you need to be a little more careful here because not
all these panels are going through the code path that the new code
covers. For instance, look at the first panel here
("panel-boe-himax8279d.c"). The panel_shutdown() function in that
driver _directly_ calls boe_panel_disable() and boe_panel_unprepare()
rather than calling the drm_panel equivalent function. That means that
they _won't_ get the benefit of the checking I added to drm_panel.c.
What that means is that if someone using the "panel-boe-himax8279d.c"
panel shuts down / reboots while their panel is off you'll probably
get a bunch of errors. I _think_ this is as simple as just changing
all those panels to call the drm_panel equivalent function.

2. As much as possible, not only should you be removing the checks,
but you should also be removing all the code that tracks the state of
prepared/enabled in the panel drivers and then removing the "prepared"
/ "enabled" members from the structs. If the panel driver needs to
track prepared/enabled for something else, you might need to keep it
though. One example would be sony-acx565akm, as per my previous
attempt [1].

In general, maybe a good approach would be to actually start with
patches #5 - #9 in my previous series [2] but instead of calling
drm_panel_helper_shutdown() just do:
  drm_panel_disable(...);
  drm_panel_unprepare(...);

Feel free to take my patches, change them, and post them. If you want,
you could add a Co-Developed-by (see submitting-patches.rst).

For some panels the above would be just leaving what's already there.
For some panels that might convert them from their static function to
the drm_panel equivalent.

Leaving the drm_panel_disable() / drm_panel_unprepare() in the panel
driver shutdown/remove code is not an ideal long term solution, but it
at least moves us on the right path and at least lets us get rid of
most of the prepared / enabled tracking. IMO that should be landable,
though perhaps others would have different opinions.

After doing all that, then you could submit patches that simply get
rid of the drm_panel_disable() / drm_panel_unprepare() for any panel
drivers if you know that those panels are only used by DRM drivers
that properly call the DRM shutdown code. See my series that tried to
add that to a bunch of DRM drivers [3]. Not everything landed, but
quite a bit of it did. As Maxime and I talked about [4] that _should_
be as simple as tracking down the panel's compatible string, seeing
which device trees use it, and then seeing if the associated DRM
driver is properly shutting things down.

Finally, after you've removed the calls to drm_panel_disable() /
drm_panel_unprepare() from the majority of the panel drivers then you
could go forward with your patch #2 where you change this to a WARN().
Personally, I'd be a little hesitant to land that change, though,
until at least panel-simple and panel-edp got rid of the calls since
that would add WARN for A LOT of people. Unfortunately, those two
panels drivers are also among the hardest to validate since they're
used with nearly all DRM drivers out there. However, IMO even if we
aren't ready to convert to a full WARN all the rest of the stuff I've
talked about here is worth doing.

Hopefully that's not too overwhelming.


[1] https://lore.kernel.org/lkml/20230804140605.RFC.9.I6a51b36831a5c7b2b82b=
ccf8c550cf0d076aa541@changeid/
[2] https://lore.kernel.org/lkml/20230804210644.1862287-1-dianders@chromium=
org/
[3] https://lore.kernel.org/lkml/20230921192749.1542462-1-dianders@chromium=
org/
[4] https://lore.kernel.org/lkml/c6kwqxz2xgl64qb6dzetjjh6j2a6hj7mvbkeg57f5u=
lfs2hrib@ocjjsoxw3ns6/

