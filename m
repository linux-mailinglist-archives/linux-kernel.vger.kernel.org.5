Return-Path: <linux-kernel+bounces-48968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15B38463E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667E21F28416
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659F46424;
	Thu,  1 Feb 2024 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiW1VHAB"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE545BE6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828235; cv=none; b=XSg72oEqv6ljnZZ7/uuc4HPxUWRVAH3AZT8sQbEBFtW2cPPQEXwn3jnfMrsdGHlAK7V0OKzlnobLmdOZDD/SwmfWUrZNZYtat/ZhNoWgaGi7AZWJosq3P06VGd8/vCWCZQI6sI86SgaKVztl1Lxxrj7AUkcZxigIVNGNK/Lsn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828235; c=relaxed/simple;
	bh=ZlrLcIjeqRNOlSZ3HB/cwib/SPm5jN/0suNYrWYybrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpOZWv/NWldGkkbYgnMEEBBJkcky9J4iNopiZd5yBeZRhVvYrUziaU6sYfGSDaLNpnIWMH2Tuc4/mysQtYind9a/aiaeMki/2cRBJrpVCVxjBUher3fOS3gZ75RsRtNwwaKdevzN0LArh/TJC2KjzDHIBiUW9I6JbMmVMOmxHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EiW1VHAB; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604191522daso14859107b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706828233; x=1707433033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OdsnChKuomg6j4pblO0liMjiO73rsaOwpJVo7hYzRr4=;
        b=EiW1VHABL0+atG6siOeo2hxBPqqTtplABWhtHEwlmI0JNWsZ02X2AtBqHbNp7uueTo
         21gufUe2G7LS0mTmk5Qs40SlMWdhfv0bVUAYK4nL4dvj16qeVp1SghpAyTkeOxQInuq6
         WHTrJYxCr5MdAMGp8B1p75S39OG2fGpl4sQOiyqs0dkQDwTy/VW34yANqRexQfCXvTuT
         uwSg/B6Lj1uUEPRnaYQv3oUP2sjnntArj1JWWoi7GE2P5GIpHDj9A8ndtoZ4/yOvjQRz
         WftEQy/OL7FxP9KRaedKq2I+qJV/0zOx5WqKNO1rgHCGXWZI832wQk7o3HluGBJKvRQz
         MQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706828233; x=1707433033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdsnChKuomg6j4pblO0liMjiO73rsaOwpJVo7hYzRr4=;
        b=OwVI4HLbDzsYBB9ynRD33bYRBErCaMHl/XGmLHHMm3iEgm/T45x83DKEUugo5KTFzm
         06bn1UyUkhK5p99/kFrqPXX9JEoD8e8UaIu5guLzzwe2yC+oOp1UgZtsjwD+LiCuXAu8
         EpkIDOBH0hRfXPj6NjoX8Mti4Knc44UhSxHyetuAx/Kau3Tt1FstgPOOKEq8d2tA1g+r
         kca4tgEYabAs4hlgUxBHMaLyrcOnbdDhb1TbGKpieyDh6o0ahNwU9XJg4dLli3aVbmLz
         vojlNZdiFV2R2Uw+nOhajb/PYtL0I8tj7UlUWPYVQS+XJ21CNLhQbT0AdI+j4uJwoL9J
         KnoA==
X-Gm-Message-State: AOJu0YwT0Ar8gv1k3el7MMuBOfTjMpCtAgYknTYAmNG6AlvZWe3x7WJc
	F4O8E58x9ndy7xQOGWPTBQYV+FEC+lHE36guxvUy/fBntrJAc//hm1L86FpSaN/8gG+KIrfJ9fw
	zpK+jyiSKeaV0vYi202pi8OhTiS3P/GiBLc9eFA==
X-Google-Smtp-Source: AGHT+IHnePb0nUlh5xvqq3tQ9c0zd26s7DREpm3fiPu4htO3BCGcGIehlU3hlZvLTGzFauhIp7JoNs06N/IHfCVTlTo=
X-Received: by 2002:a0d:e28a:0:b0:5f6:d2ee:2686 with SMTP id
 l132-20020a0de28a000000b005f6d2ee2686mr7022815ywe.2.1706828233099; Thu, 01
 Feb 2024 14:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126190110.148599-1-afd@ti.com> <CAPDyKFpc38-CFrzhnhutS7c78tZTLM6Bg6XsTKENP8oVT6SQXg@mail.gmail.com>
 <d81a060f-3d8f-44b2-8140-eb8e7ce35d93@ti.com>
In-Reply-To: <d81a060f-3d8f-44b2-8140-eb8e7ce35d93@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Feb 2024 23:56:37 +0100
Message-ID: <CAPDyKFonWCJNWcBcUTW2xrqDwJAh0fvg8Ane-phWz64GZ6tcRQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq: Use proper reboot notifier path
To: Andrew Davis <afd@ti.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Yangtao Li <frank.li@vivo.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

+ Oleksij

On Thu, 1 Feb 2024 at 17:20, Andrew Davis <afd@ti.com> wrote:
>
> On 1/30/24 6:04 AM, Ulf Hansson wrote:
> > On Fri, 26 Jan 2024 at 20:01, Andrew Davis <afd@ti.com> wrote:
> >>
> >> This driver registers itself as a reboot handler, which means it claims
> >> it can reboot the system. It does this so it is called during the system
> >> reboot sequence. The correct way to be notified during the reboot
> >> sequence is to register a notifier with register_reboot_notifier().
> >> Do this here.
> >>
> >> Note this will be called during normal reboots but not emergency reboots.
> >> This is the expected behavior, emergency reboot means emergency, not go
> >> do some cleanup with emmc pins.. The reboot notifiers are intentionally
> >> not called in the emergency path for a reason and working around that by
> >> pretending to be a reboot handler is a hack.
> >
> > I understand the reason for the $subject patch, but it will not work,
> > unfortunately.
> >
> > For eMMC we need to manage emergency reboots too. The fiddling with
> > GPIOs isn't a "cleanup", but tries to move the eMMC into a clean reset
> > state.
>
> That is by definition a "cleanup", even if the cleanup is really important.
>
> > This is needed on some platforms with broken bootloaders (ROM
> > code), that is expecting the eMMC to always start in a clean reset
> > state.
> >
>
> I understand the reason, I don't agree with the method used to get
> the result.
>
> > So, we need both parts, as was discussed here [1] too.
> >
>
> In this thread I see a lot of discussion about the priority of the
> handler. You want this to run before any real reboot handlers
> are run. Luckily for you, all reboot "notifiers" are run before
> any "handlers" are run. So if you register as a "notifier" as
> this patch does, you will be run first, no super high priority
> settings needed.

Right, I didn't say the solution we use for mmc is perfect, but it was
the easiest solution at hand at the introduction.

>
> The real issue is you want to be called even in the
> emergency_restart() path, which is fine. But from the
> docs for that function this type of restart is done:
>
> > Without shutting down any hardware
>
> So we have two options:
>
> 1. Add a new notifier list that *does* get called in the
>     emergency_restart() path. Then register this driver with
>     with that.
>
> 2. Remove emergency_restart() from the kernel. It only has a
>     couple of callers, and most of those callers look like they
>     should instead be using hw_protection_reboot() or panic().
>     That way all reboot paths activate the reboot notifiers.
>     Kinda wondering why you think you need to handle the
>     emergency_restart() case at all, will even be a thing on
>     your hardware, i.e. is this a real problem at all?

The "emergency reset" is needed, due to broken bootloaders, as I
pointed out earlier.

That said, I don't have any strong opinions around this, whatever
option you pick to rework the code is fine by me. The important point
is that we can continue to support the use cases we need for MMC.

BTW, there was a recent related discussion [1] that you may want to
catch up with too, before you start doing the restructuring of the
restart/reboot code. See the link below.

>
> Having this driver claim to be a real reboot handler to sneak
> around doing one of the above is preventing some cleanup I am
> working on. So if either of the above two options work for you
> just let me know, I'll help out in implementing them for you.

That would be great, thanks!

>
> Thanks,
> Andrew

Kind regards
Uffe

[1]
PATCH v1 0/3] introduce priority-based shutdown support]
https://lore.kernel.org/lkml/2023112520-paper-image-ef5d@gregkh/T/#mb45749c3bc9b89caecfeca6e66da8721d920191b

