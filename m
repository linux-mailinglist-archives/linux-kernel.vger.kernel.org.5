Return-Path: <linux-kernel+bounces-55019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B6384B65C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975ADB2766F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220A130E46;
	Tue,  6 Feb 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K25BlzDs"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C873195
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226242; cv=none; b=HQHg+bVhC3szYQAgScJMbnggnGQIe7sWaaOo0H5dt+ow9bgL/APeYmfYOGjdjTvmr4imUTaagy6jshm2alYOjmuZwaYQL1eM3CcjZaI//PEwVhSitXzzHIa4JaTKgbTBgfcwlSBduAq2aqm4iYuuaUYSEm5dvS85c//Kj8Ng+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226242; c=relaxed/simple;
	bh=YSNq6rJliKE1wVcRHtRcsn1hSsqD2vpjoxqRPoTDYqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPba4go+wYHa6vqCzfUBTXdiPLyko3iLvFPdKkIhIlus1cWseMgVRrE3kY5L9rDP8FXzm7Hj8uAq07TgmF4zywwbhlFsXhr4S86fRSP1gAv497U+fzpFLzSckICMzaa2ik4HRESvI0pm7agOqQ4ZP1yldSGzsHOhHaXMxBKtJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=K25BlzDs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fc82b57f3so9937675e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707226238; x=1707831038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsYkGdM7KmCkPXBNIy3sTIvZdpa98vAWS2UDOyFOwHA=;
        b=K25BlzDsah6TN7aX7Q+KN+k+r8nGVgpLG9s5Vft+oDAhLaSyrVXoSXfFDWtCkwQ3vi
         yOXAuhSdhhJVOE3akhML8jLZD53mu+ylA6cZjYVM/gRbb7aBuSPBHm8gMkpp1Jai5KWY
         edsqDaKDKAk2tmqQOSRaABRrfN206BI1R6xeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226238; x=1707831038;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsYkGdM7KmCkPXBNIy3sTIvZdpa98vAWS2UDOyFOwHA=;
        b=XEzrUvdykJHhGhiGkyOOc+YBt8yDPZjGs1/2l2Xu+BKWruoR6W7CrfiCAHnq1ebmix
         S9CJ0+0zXgdMaVlHE6E+7sQrkFn6kV5UUo0ZFqD7iCQm9dbOLRmchUYA5UAZN2a5D5PG
         HXr68iNyExIhSxjMupMNNoBQAezhjEGSLYlBsUUaR2L9h+tmR20WvaFagNmTj7V8VZZA
         A4ryaALTINAyL2OG1CIhWBSCzNk/eaTsuKIrXtqSxCnjjpZfAkAY3FnjNgtDSN8SCi6v
         HlRjNhT4bn7UOjX/dxjT0uEOsnA4Y/rT/hXdx53B3dwcWfoPYxxV3V43re1C4WhpdQ+Z
         yS8Q==
X-Gm-Message-State: AOJu0YzRqjuK9/UboTiDgfADN01ONU+nqVID6nKJvKMNqO3r7uoV5g9M
	z474J0IeZ7UPW3S6ITcTYAk73PwnwqrbZztmfwwqEH/1Frcb5+qGsqLZpkXMXfw=
X-Google-Smtp-Source: AGHT+IFCB8s+7sYgzNhmn05fwzPqkFwBua36HlUBmKHloMm2zsA1gvjmRfvfqWQexeDh34pLU/c2ZA==
X-Received: by 2002:a05:600c:1c26:b0:40f:c34a:b69 with SMTP id j38-20020a05600c1c2600b0040fc34a0b69mr2207987wms.2.1707226238239;
        Tue, 06 Feb 2024 05:30:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW9ivc+6+iu6716dc1/tI0KbY0A0fOWnFDVQoS2EZ1M99VQHAA3w5RZ2QIIU44dUIugWh2hLn+8np5ftqBJn3iHpjS9s4KFAltpBndMrtQwMd6CDwuUr6iaj0cV5KuETT0DDBRKpaWad8xVNzRATz3SwBdZJnvnGXpraY2U0fAiTPUxJs3o9czz1YhSiyjHF/o/5iHs+pmT2FD2cQunIUxLsrBpeDpo2A==
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa30b000000b0033b14f22180sm2160974wrb.20.2024.02.06.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:30:37 -0800 (PST)
Date: Tue, 6 Feb 2024 14:30:35 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dave Airlie <airlied@gmail.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, airlied@redhat.com,
	daniel@ffwll.ch,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mgag200: Flush the cache to improve latency
Message-ID: <ZcI0e7VG_hE3bJh-@phenom.ffwll.local>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, airlied@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231019135655.313759-1-jfalempe@redhat.com>
 <660c0260-0e22-4e9c-ab13-157adaa0b14d@suse.de>
 <74b367bd-ac80-478b-8f82-e98cb6e40475@redhat.com>
 <f19a2cb4-57b6-427c-b69c-47a848420530@redhat.com>
 <CAPM=9twkLUFP+4aeKt+BRi4sO1c3hypq-dD33JKabHVQZ3oV9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twkLUFP+4aeKt+BRi4sO1c3hypq-dD33JKabHVQZ3oV9A@mail.gmail.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Mon, Feb 05, 2024 at 05:02:58PM +1000, Dave Airlie wrote:
> On Mon, 6 Nov 2023 at 20:47, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> >
> > On 23/10/2023 10:30, Jocelyn Falempe wrote:
> > > On 20/10/2023 14:06, Thomas Zimmermann wrote:
> > >> (cc'ing lkml for feedback)
> > >>
> > >> Hi Jocelyn
> > >>
> > >> Am 19.10.23 um 15:55 schrieb Jocelyn Falempe:
> > >>> We found a regression in v5.10 on real-time server, using the
> > >>> rt-kernel and the mgag200 driver. It's some really specialized
> > >>> workload, with <10us latency expectation on isolated core.
> > >>> After the v5.10, the real time tasks missed their <10us latency
> > >>> when something prints on the screen (fbcon or printk)
> > >>
> > >> I'd like to hear the opinion of the RT-devs on this patch. Because
> > >> AFAIK we never did such a workaround in other drivers. And AFAIK
> > >> printk is a PITA anyway.
> > >
> > > Most other drivers uses DMA, which means this workaround can't apply to
> > > them.
> > >
> > >>
> > >> IMHO if that RT system cannot handle differences in framebuffer
> > >> caching, it's under-powered. It's just a matter of time until
> > >> something else changes and the problem returns. And (honest question)
> > >> as it's an x86-64, how do they handle System Management Mode?
> > >
> > > I think it's not a big news, that the Matrox G200 from 1999 is
> > > under-powered.
> > > I was also a bit surprised that flushing the cache would have such
> > > effect on latency. The tests we are doing can run 24h with the
> > > workaround, without any interrupt taking more than 10us. Without the
> > > workaround, every ~30s the interrupt failed its 10us target.
> > >
> > >>
> > >>>
> > >>> The regression has been bisected to 2 commits:
> > >>> 0b34d58b6c32 ("drm/mgag200: Enable caching for SHMEM pages")
> > >>> 4862ffaec523 ("drm/mgag200: Move vmap out of commit tail")
> > >>>
> > >>> The first one changed the system memory framebuffer from Write-Combine
> > >>> to the default caching.
> > >>> Before the second commit, the mgag200 driver used to unmap the
> > >>> framebuffer after each frame, which implicitly does a cache flush.
> > >>> Both regressions are fixed by the following patch, which forces a
> > >>> cache flush after each frame, reverting to almost v5.9 behavior.
> > >>
> > >> With that second commit, we essentially never unmap an active
> > >> framebuffer console. But with commit
> > >>
> > >> 359c6649cd9a ("drm/gem: Implement shadow-plane {begin, end}_fb_access
> > >> with vmap")
> > >>
> > >> we now again unmap the console framebuffer after the pageflip happened.
> > >>
> > >> So how does the latest kernel behave wrt to the problem?
> > >
> > > The regression was found when upgrading the server from v5.4 to v5.14,
> > > so we didn't test with later kernels.
> > > We will test with v6.3 (which should have 359c6649cd9a ) and see what it
> > > gives.
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
> I think we should either add a config option or command line parameter here.

Yeah I think the situation is cursed enough that we need that, and module
option for mgag200 sounds like the most reasonable way.

> I'd don't think adding nopat to the kernel command line is a good
> suggestion in the long run, servers often have other cards plugged
> into them like nvidia gpus or rdma etc, you don't want to cripple them
> because you want reduced latency on the crappy on-board.
> 
> I'd rather we put the default back to what it used to be, which was
> flush the cache though, I'm not sure why we have any objection to
> doing that, it used to work, it was clearly fine in operation, why
> undo it?

Uh that default is a few patches back and I think it's not great if we
change that, since it means all drivers using shadow buffers for fdbev
will again suffer from rendering fbcon into a wc instead of wb buffer.

But Jocelyn has meanwhile dug out more info in another reply, I'll reply
there.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

