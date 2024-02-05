Return-Path: <linux-kernel+bounces-52105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B5849429
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BDE1F21868
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91B10A11;
	Mon,  5 Feb 2024 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1ZsXF6G"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453F10A28
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116593; cv=none; b=liSFvYzzhVgh+AOLQP8huKn8q3xazMBy/HN7ObXhnsHduI9LuBVwTJQXgu0MZJKNkVswkuaPDxmPc0hFE3E7m7MOtfXBu81/xifSb6utUxPH8Zse8/RFEUDpuCoP23BDTi5FTVLcWblojy1h5YrRuNZzNDxKzktpn9S7RbSkzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116593; c=relaxed/simple;
	bh=SmODjWl9XxT/MZiATDetkZp8pVHFQ7zqqtGcepJ25ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz4UHrQb/RfONHQ6hoWiEIbbXao8sr3eSVYf/duu/WQ1YepFC7gF6XmCi1zQOFOeRPgresOLLn8fIZ6FbdgCqUSaR0b1u8Q8lN/K1esqbAfhSSM1FnLxgnktfugTxJDWKRjOjaWhYdzmHSeJjgWt5eT5/TpDiohQ9JJg8PlplxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1ZsXF6G; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3566c0309fso499542866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 23:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707116590; x=1707721390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SmODjWl9XxT/MZiATDetkZp8pVHFQ7zqqtGcepJ25ro=;
        b=B1ZsXF6GCZioZWhk6ApaJPeuGztNrUtd2Q3pDhxJqy+TFYrAbrUBUsrAAyA751V3HV
         SLIicS16nDe0tEiYJMKF0qVuKt/lTiqg5MZPnC+BWclJzk31wt7fRylnRRE6wKj7Tg0d
         3XTdxUZ4LtVGmMN73gNl8yIN6PqbCWs6NKRJh5uAp/GtX1pzS8Ngvn5a4lGt0qDM3Mm1
         XZr3Xkg+EoRcxMIeDwqYqeq+AnPuLkNDnFOsQy1uA0kQMegcF8FYtb7CLrCDxKZjbFXd
         At43pDlVF7ngF13wWewiNCDj2SgOX3Lpg019/5lOGDQVkJ0wdWTvDq0BULWtZQr6KDh4
         vvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707116590; x=1707721390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmODjWl9XxT/MZiATDetkZp8pVHFQ7zqqtGcepJ25ro=;
        b=TqVLo+/TZ7hvn7nSLgm6plOiqiNgp4JlUoVlRByIMbzEprdgQxtnK83fGmVMimMTvQ
         5OmaHrwekEjjCYHSzE6ZFaAxTsfZzR8pckWTdTB9HddkmrBHwS4Ntkk+OCGcms6khdcH
         fNmAJFltf4ZyAevs3tBhe+hJKBw2KCA53or6+NaRo3UeP3XAZPQAIAvDVMP5rD6kvPrW
         RWxvKwJ6QIm5yH9zldEg8VduFoVMs1XA4/djTTx+2KurZlYH5xbgDHJ3qYMeRJ/HP9TH
         sCU40+FXCrTIEOI6dRtr4UWCu+78r0d9dDRLpE+jdbKNaKjEP+Ony4CCHC4hE9q1CPX5
         G48Q==
X-Gm-Message-State: AOJu0YwJLJSsgRhLQPYar/gYTyoPqTqGca/Jrww4GBK0y7lQotcCuIzF
	+/hOMG0BlMcq78bwLSlOX8zRXij544vxpShUjFSc8xJ6bH2QiEK7bsHjrJM/6P9iHFJ7VdScR1B
	rvwHn9gKfLLLO3C2pRttLXshJRbo=
X-Google-Smtp-Source: AGHT+IE4uSKWUY1Kd2JanzsmRAU3KZvSr9WlJ+DN9wDhfPPzNWneoOpZnACdKmTI2b9b/FyGk/HNwrDj27xo/Odx+Ng=
X-Received: by 2002:a17:906:e2c7:b0:a37:b331:da3c with SMTP id
 gr7-20020a170906e2c700b00a37b331da3cmr1494299ejb.27.1707116589995; Sun, 04
 Feb 2024 23:03:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019135655.313759-1-jfalempe@redhat.com> <660c0260-0e22-4e9c-ab13-157adaa0b14d@suse.de>
 <74b367bd-ac80-478b-8f82-e98cb6e40475@redhat.com> <f19a2cb4-57b6-427c-b69c-47a848420530@redhat.com>
In-Reply-To: <f19a2cb4-57b6-427c-b69c-47a848420530@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 5 Feb 2024 17:02:58 +1000
Message-ID: <CAPM=9twkLUFP+4aeKt+BRi4sO1c3hypq-dD33JKabHVQZ3oV9A@mail.gmail.com>
Subject: Re: [PATCH] drm/mgag200: Flush the cache to improve latency
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	airlied@redhat.com, daniel@ffwll.ch, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Nov 2023 at 20:47, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>
> On 23/10/2023 10:30, Jocelyn Falempe wrote:
> > On 20/10/2023 14:06, Thomas Zimmermann wrote:
> >> (cc'ing lkml for feedback)
> >>
> >> Hi Jocelyn
> >>
> >> Am 19.10.23 um 15:55 schrieb Jocelyn Falempe:
> >>> We found a regression in v5.10 on real-time server, using the
> >>> rt-kernel and the mgag200 driver. It's some really specialized
> >>> workload, with <10us latency expectation on isolated core.
> >>> After the v5.10, the real time tasks missed their <10us latency
> >>> when something prints on the screen (fbcon or printk)
> >>
> >> I'd like to hear the opinion of the RT-devs on this patch. Because
> >> AFAIK we never did such a workaround in other drivers. And AFAIK
> >> printk is a PITA anyway.
> >
> > Most other drivers uses DMA, which means this workaround can't apply to
> > them.
> >
> >>
> >> IMHO if that RT system cannot handle differences in framebuffer
> >> caching, it's under-powered. It's just a matter of time until
> >> something else changes and the problem returns. And (honest question)
> >> as it's an x86-64, how do they handle System Management Mode?
> >
> > I think it's not a big news, that the Matrox G200 from 1999 is
> > under-powered.
> > I was also a bit surprised that flushing the cache would have such
> > effect on latency. The tests we are doing can run 24h with the
> > workaround, without any interrupt taking more than 10us. Without the
> > workaround, every ~30s the interrupt failed its 10us target.
> >
> >>
> >>>
> >>> The regression has been bisected to 2 commits:
> >>> 0b34d58b6c32 ("drm/mgag200: Enable caching for SHMEM pages")
> >>> 4862ffaec523 ("drm/mgag200: Move vmap out of commit tail")
> >>>
> >>> The first one changed the system memory framebuffer from Write-Combine
> >>> to the default caching.
> >>> Before the second commit, the mgag200 driver used to unmap the
> >>> framebuffer after each frame, which implicitly does a cache flush.
> >>> Both regressions are fixed by the following patch, which forces a
> >>> cache flush after each frame, reverting to almost v5.9 behavior.
> >>
> >> With that second commit, we essentially never unmap an active
> >> framebuffer console. But with commit
> >>
> >> 359c6649cd9a ("drm/gem: Implement shadow-plane {begin, end}_fb_access
> >> with vmap")
> >>
> >> we now again unmap the console framebuffer after the pageflip happened.
> >>
> >> So how does the latest kernel behave wrt to the problem?
> >
> > The regression was found when upgrading the server from v5.4 to v5.14,
> > so we didn't test with later kernels.
> > We will test with v6.3 (which should have 359c6649cd9a ) and see what it
> > gives.
>
> I don't have a clear explanation, but testing with v6.3, and forcing the
> Write Combine, doesn't fix the latency issue. So forcing the cache flush
> is still needed.
>
> Also, on some systems, they use "isolated cpu" to handle RT task, but
> with a standard kernel (so without the CONFIG_PREEMPT_RT).
> So I'm wondering if we can use a kernel module parameter for this,
> so that users that wants to achieve low latency, can opt-in ?
>
> something like mgag200.force_cache_flush=1 or mgag200.low_latency=1 ?

I think we should either add a config option or command line parameter here.

I'd don't think adding nopat to the kernel command line is a good
suggestion in the long run, servers often have other cards plugged
into them like nvidia gpus or rdma etc, you don't want to cripple them
because you want reduced latency on the crappy on-board.

I'd rather we put the default back to what it used to be, which was
flush the cache though, I'm not sure why we have any objection to
doing that, it used to work, it was clearly fine in operation, why
undo it?

Dave.

