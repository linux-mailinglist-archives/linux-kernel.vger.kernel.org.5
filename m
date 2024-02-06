Return-Path: <linux-kernel+bounces-55023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA484B67D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86DF1C24567
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B01131740;
	Tue,  6 Feb 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HK39Er8J"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2165413172E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226446; cv=none; b=DlCTvGby8i3yKkdEw/15d8gaNL3vji/1dPEMxomF1mdEVId9HgXnEFwCWRh7lfLfStizAKzzcJaKjidZQ4vI8bbSATNWQDkmMyKJDAoZzcNI3N1eeEmLFW/1Ph+fuhmbcukbB2kQApa95tBJiGmau95jTRXynye8L8CUIP0VehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226446; c=relaxed/simple;
	bh=Rqy3lZ7vXHlxcWmiSj223jWM4ub6v4QMOBwaT+BbOZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGuFzEEy/AhiN73bKvCTDCalXpFTFldAkCKFsfwU2/F9fMCz61cJwoLQ/0m2hyLy+azjE6u9e6O3gPrVem4vs7qiBtcVyE+re5u/eH91VolJzKC5zacYHiIRfl10jW+4qbh6ghl2+10wG4Fop+5FEZZ3s9Oo5rD4MEA5Od66i0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=HK39Er8J; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fc82b57f3so9944065e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707226442; x=1707831242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb5lZYMLzYzJwekhZ+J9CG6nQdp0vbMqIfMnla1njGQ=;
        b=HK39Er8Jkw4PWGN3lJvp41E5R1K4wpyk5U33TCwGqPoR1fp9M1bRSBNpa6R7ScDgFd
         ww2y8GNi/HtjT5Yqm/nlDYD/bdtY9QPcx/x3aAeRLDWfGH3JjxEsIgU0YHdwmF0UdAQG
         Bug955THu7CP6RihxZ67XxwoUdeL7qPTWU3Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226442; x=1707831242;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cb5lZYMLzYzJwekhZ+J9CG6nQdp0vbMqIfMnla1njGQ=;
        b=K6PN/JyF75zinCakKE5v/SI55DTh1D5CTs2GhYJ0uj/Xs15plpPp2OIc3YsENworwK
         qeEzu4yJPunw+YjBIUs/VsrdK7LxJY6Hy1dD8Vw6ETDiiBSX7DlFYRxD4kzUuNNG+t71
         6L4lQOgjJKvdsp5D0uu2X8iSMrUhu7MBNUyMja0CI31B8E+x4YAiJ4laSWIL1FdBC5pv
         kG/vKwUUYd7CxRyL7r89ucVYCEDBitZSX89JslfcfN28cEI7WIBfgGzV7/xmjnG5glmV
         DOyFCTRxGM+1HQUKPITj2x8Df/slaIEJttAuLp4Rf2MXnLvBYHepnYZuWBz/piRmIPKL
         StZw==
X-Gm-Message-State: AOJu0YxxaIfZv7XnhuMAB256q/vwrjqT8JIIcFnY7T1DOfPbrDOExed/
	d8mhKdRE2+e1IFxhyq0QMFS0XfI3Sqszf0X6gkLfyQy/73FoWv2OkJGGObfcuXM=
X-Google-Smtp-Source: AGHT+IEs8V1S6TINyqxrY1nt2sLO53PWnu3noIj70OHc4tAmBecxZeCCdSa/artAiB7YYOcnJHSC1w==
X-Received: by 2002:a05:600c:1d07:b0:40f:c996:307f with SMTP id l7-20020a05600c1d0700b0040fc996307fmr2216638wms.3.1707226441999;
        Tue, 06 Feb 2024 05:34:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUUmg8ndlbqKGc98foRno2ZYy/mlNs8ofGX+olxx9h05ZV32YWXb5wXI8Z+UAaTVwj09W+vpw58NKB6IP6lySoQOlJ7I/xjzr96wvEge+lUXDZhks/ItQpsQ0twAr66hdzoaR0p9sRH8Plv8A7iCc3kKo+QO4UHmLVSxz3BmMe6ZrSguk/bnA5Fthde4hfZoPebcw==
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b0040fb783ad93sm2066390wmb.48.2024.02.06.05.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:34:01 -0800 (PST)
Date: Tue, 6 Feb 2024 14:33:59 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, airlied@redhat.com,
	daniel@ffwll.ch,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mgag200: Flush the cache to improve latency
Message-ID: <ZcI1R7s10Fs8GSk8@phenom.ffwll.local>
Mail-Followup-To: Jocelyn Falempe <jfalempe@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, airlied@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231019135655.313759-1-jfalempe@redhat.com>
 <660c0260-0e22-4e9c-ab13-157adaa0b14d@suse.de>
 <74b367bd-ac80-478b-8f82-e98cb6e40475@redhat.com>
 <f19a2cb4-57b6-427c-b69c-47a848420530@redhat.com>
 <e64f641d-44b7-4019-866d-1050277ef885@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64f641d-44b7-4019-866d-1050277ef885@redhat.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Mon, Dec 11, 2023 at 10:31:28AM +0100, Jocelyn Falempe wrote:
> On 06/11/2023 11:46, Jocelyn Falempe wrote:
> > On 23/10/2023 10:30, Jocelyn Falempe wrote:
> > > On 20/10/2023 14:06, Thomas Zimmermann wrote:
> > > > (cc'ing lkml for feedback)
> > > > 
> > > > Hi Jocelyn
> > > > 
> > > > Am 19.10.23 um 15:55 schrieb Jocelyn Falempe:
> > > > > We found a regression in v5.10 on real-time server, using the
> > > > > rt-kernel and the mgag200 driver. It's some really specialized
> > > > > workload, with <10us latency expectation on isolated core.
> > > > > After the v5.10, the real time tasks missed their <10us latency
> > > > > when something prints on the screen (fbcon or printk)
> > > > 
> > > > I'd like to hear the opinion of the RT-devs on this patch.
> > > > Because AFAIK we never did such a workaround in other drivers.
> > > > And AFAIK printk is a PITA anyway.
> > > 
> > > Most other drivers uses DMA, which means this workaround can't apply
> > > to them.
> > > 
> > > > 
> > > > IMHO if that RT system cannot handle differences in framebuffer
> > > > caching, it's under-powered. It's just a matter of time until
> > > > something else changes and the problem returns. And (honest
> > > > question) as it's an x86-64, how do they handle System
> > > > Management Mode?
> > > 
> > > I think it's not a big news, that the Matrox G200 from 1999 is
> > > under-powered.
> > > I was also a bit surprised that flushing the cache would have such
> > > effect on latency. The tests we are doing can run 24h with the
> > > workaround, without any interrupt taking more than 10us. Without the
> > > workaround, every ~30s the interrupt failed its 10us target.
> > > 
> > > > 
> > > > > 
> > > > > The regression has been bisected to 2 commits:
> > > > > 0b34d58b6c32 ("drm/mgag200: Enable caching for SHMEM pages")
> > > > > 4862ffaec523 ("drm/mgag200: Move vmap out of commit tail")
> > > > > 
> > > > > The first one changed the system memory framebuffer from Write-Combine
> > > > > to the default caching.
> > > > > Before the second commit, the mgag200 driver used to unmap the
> > > > > framebuffer after each frame, which implicitly does a cache flush.
> > > > > Both regressions are fixed by the following patch, which forces a
> > > > > cache flush after each frame, reverting to almost v5.9 behavior.
> > > > 
> > > > With that second commit, we essentially never unmap an active
> > > > framebuffer console. But with commit
> > > > 
> > > > 359c6649cd9a ("drm/gem: Implement shadow-plane {begin,
> > > > end}_fb_access with vmap")
> > > > 
> > > > we now again unmap the console framebuffer after the pageflip happened.
> > > > 
> > > > So how does the latest kernel behave wrt to the problem?
> > > 
> > > The regression was found when upgrading the server from v5.4 to
> > > v5.14, so we didn't test with later kernels.
> > > We will test with v6.3 (which should have 359c6649cd9a ) and see
> > > what it gives.
> > 
> > I don't have a clear explanation, but testing with v6.3, and forcing the
> > Write Combine, doesn't fix the latency issue. So forcing the cache flush
> > is still needed.
> > 
> > Also, on some systems, they use "isolated cpu" to handle RT task, but
> > with a standard kernel (so without the CONFIG_PREEMPT_RT).
> > So I'm wondering if we can use a kernel module parameter for this,
> > so that users that wants to achieve low latency, can opt-in ?
> > 
> > something like mgag200.force_cache_flush=1 or mgag200.low_latency=1 ?
> 
> Hi,
> 
> I have now access to a server that reproduce the issue, and I was able to
> test different workarounds.
> 
> So it is definitely related to the "Write Combine" mode of the mga internal
> RAM. If I comment the two lines to enable wc: https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/mgag200/mgag200_drv.c#L150,
> then the latency is <10us (but the performances are worse, from 20ms to 87ms
> to draw a full frame).

Ok this is very strange, but at least it starts to make sense. Apparently
if we stream a _lot_ of writes from wb to wc memory on a cpu that results
in high latencies on other cpus. And the only way to fix that is by
artificially making the wb source suffer from cache misses by flushing
them out.

> I also tried to flush the vram using:
> drm_clflush_virt_range(mdev->vram + clip->y1 * fb->pitches[0],
> drm_rect_height(clip) * fb->pitches[0]);
> And that lower the latency to ~20us, but it's not enough.
> 
> I tried "sfence" which I though would flush the WC buffers of the CPU, but
> that has no effect in practice.
> 
> I think I can send a new patch, to not map the VRAM as Write Combine, either
> if CONFIG_PREEMPT_RT is set or if a module parameter is set.
> What do you think is the best approach ?

I think an mgag200 module option like Dave suggested is best.

Plus the entire above debug story in the commit message, especially the
things you've figured out in your latest testing (apologies for missing
your mail from Dec, pls ping again if things get dropped like that) kinda
explains what's going on.

Still doesn't make much sense that a cpu doing a lot of wb->wc transfers
can hurt other cores like this, but at least that seems technically
plausible.

Also please link to this thread for all the details on test setup, I think
the above is enough as a summary for the commit message. But if you want
you can include all the details below too.

Cheers, Sima

> My tests setup:
> 
> I either flood the console with "cat /dev/urandom | base64" from the BMC, or
> write to fb0 with "while true; do dd if=/dev/urandom of=/dev/fb0 ; done"
> 
> then I run:
> 
> cd /sys/kernel/debug/tracing
> echo 0 > tracing_on
> echo 950000 > hwlat_detector/width
> echo hwlat > current_tracer
> echo 10 > tracing_thresh
> echo 1 > tracing_on
> sleep 300
> cat trace
> echo 0 > tracing_on
> echo nop > current_tracer
> 
> 
> Test Results:
> 
> V6.6 (~40us latency)
> 
> # tracer: hwlat
> #
> # entries-in-buffer/entries-written: 6/6   #P:56
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>            <...>-8795    [001] dn...   613.749741: #1 inner/outer(us):
> 41/41    ts:1702045267.016266287 count:9976
>            <...>-8804    [000] dn...   675.201727: #2 inner/outer(us):
> 40/40    ts:1702045328.469859973 count:6506
>            <...>-8804    [000] dn...   731.435258: #3 inner/outer(us):
> 40/41    ts:1702045384.704861049 count:9578
>            <...>-8804    [000] d....   787.684533: #4 inner/outer(us):
> 41/41    ts:1702045440.955603974 count:22591
>            <...>-8804    [000] d....   844.303041: #5 inner/outer(us):
> 41/41    ts:1702045497.575594006 count:33324
>            <...>-8804    [000] d....   900.494844: #6 inner/outer(us):
> 40/40    ts:1702045553.768864888 count:1924
> 
> 
> V6.6 + clfush mdev->vram (~20us latency)
> 
> # tracer: hwlat
> #
> # entries-in-buffer/entries-written: 3/3   #P:56
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>            <...>-8983    [001] d....   534.595415: #1 inner/outer(us):
> 21/20    ts:1702024432.844243126 count:3018
>            <...>-8983    [000] dn...   758.560453: #2 inner/outer(us):
> 21/21    ts:1702024656.824367474 count:22238
>            <...>-8983    [000] dn...   815.117057: #3 inner/outer(us):
> 21/21    ts:1702024713.373220580 count:26455
> 
> 
> V6.6 + no Write Combine for VRAM (<10us latency)
> 
> # tracer: hwlat
> #
> # entries-in-buffer/entries-written: 0/0   #P:56
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
> 
> 
> Best regards,
> 
> -- 
> 
> Jocelyn
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

