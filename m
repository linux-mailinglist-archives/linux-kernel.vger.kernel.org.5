Return-Path: <linux-kernel+bounces-144422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9808A463A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891141C212FA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE5137761;
	Sun, 14 Apr 2024 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2U68kaLK"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0148134433
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713139165; cv=none; b=d5kjb6KZ8pjikUFIaTsYFOyfNbVI3pxqzxBrOunobLjxLyyeqmqRfkyfd4CWQXejzh3vRwBD6dfc8dE/p/6kubOMtTuCNX9HJWxtM46/Mg8bq/R5pqyE0VtpD05sUX4vC+gPNESW3OnyI8sLixQS1QLXcwL3tydCxHBwEGuJAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713139165; c=relaxed/simple;
	bh=DVbhIAD4dD6zMv8y6fV1Wzg0o8HMaAj0cEuHgs2xF/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPSmbP1/KWm1VyKiUa3nAvdTH0CdzSezjEJx2zmWUy4qqcQd6Jgvx98HULAIAULaaWRRRGeDK7bx3Kdmz4KbKf0M4B1sAnTaUUfr1ltkIWf0Mlua090cv75eJsiHcJNsYZCw1hAMoaErqEJKBFJpX22FEbuKZjKu5vfE1I/Auf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2U68kaLK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so18964605ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 16:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1713139163; x=1713743963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGV27/0yG6UjQSbUj317jOwq2KsNUae71ElB8pdHdTg=;
        b=2U68kaLKKBm/qwsuWIa9QTsZgVQpPSF29wkcBREdm3CAXPIEycHe1jvkj1ggwJ01so
         peEhUMoP4U8ncuZpB01Cm5MBBJXOFFRphwqfiHoqHuLFPLDA/GCJ4LI8cAXNce69GCl2
         rWjsK+ARhBB3GFq+qi9e5YI7S4zF8XDWFORkBZV8e8zH1T1bbeeV/U3j7hsXPhsyyfUs
         68+F4PHaD18a0aRmYdBFu5zznk4l609Pir5IZzj2CFJas4M6PlsexvGMAh2thPg2nSbz
         2Paa9EHzvbQfQcKOOM/6l72YhcByEmgEowKePe0GBulQooDzpS3QR0881+z9BE73hLrv
         +T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713139163; x=1713743963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGV27/0yG6UjQSbUj317jOwq2KsNUae71ElB8pdHdTg=;
        b=q+LaUs4cspNaKJzFAxkYE0B4ooS+Btt5waXc7liARUwhIxtcscvzwyVuRsmn1F/gUV
         woAa+7g5FeAfnuJZ6SijwkAudRXpDbA9RKJcI+NpdyQFhC0y+OLZ3qSbKrnUxGaQHDRL
         rhmIMydw8Pvn31k4e+hzX9HXX5tzV1gr4y5TE86StnxgP7f4BYY3UsEtUTCPqEBNcMYT
         1wp9DD4M3xU1Qkn6CwiCFQCLvlUfyYrLJfjOAHWQu1N711fvHnCNPwOZLf2OMaVW9ZmA
         j9gU+A3XHMIGNgKe2z/FPx0zjYugtUnPt+u/SWvgBaGIhY3Sfp0AwbaLYfzih4NiNwGt
         CMHg==
X-Forwarded-Encrypted: i=1; AJvYcCXCcml2+fxgiOTOujiOOgiSXJLnLFHAZH4w7BE0YtxgJ7n/UcUug7hGz0Dt/ue1qeVrI+dXatiBfgJ9ld17+g6/atBr5zJGNkSkFMHB
X-Gm-Message-State: AOJu0YyrdsRFB2Usqtn447pociK7rtsI8QWChlITZ3Ls9OcGXL7j6MP9
	fX+eEinrA0hDsljQilLKwDkfMpI/RwRIluBttoQ8NH5qWaiJ8Tvj96IAqSoWTTE=
X-Google-Smtp-Source: AGHT+IHFHu5EI4F4Qvvr4K46o+uEyBuZTAyTZ/KZLyxcZYs/+Nc6uhWqc94xlNok0j1ktZdLHFsdVQ==
X-Received: by 2002:a17:903:4282:b0:1e4:60d4:916b with SMTP id ju2-20020a170903428200b001e460d4916bmr7028967plb.64.1713139162823;
        Sun, 14 Apr 2024 16:59:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d50900b001dee4a22c2bsm6580711plg.34.2024.04.14.16.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 16:59:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rw9kk-00FqSa-30;
	Mon, 15 Apr 2024 09:59:18 +1000
Date: Mon, 15 Apr 2024 09:59:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: lipeifeng@oppo.com
Cc: akpm@linux-foundation.org, zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev, 21cnbao@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/shrinker: add SHRINKER_NO_DIRECT_RECLAIM
Message-ID: <Zhxt1uL+QPisq4rE@dread.disaster.area>
References: <20240413015410.30951-1-lipeifeng@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413015410.30951-1-lipeifeng@oppo.com>

On Sat, Apr 13, 2024 at 09:54:10AM +0800, lipeifeng@oppo.com wrote:
> From: Peifeng Li <lipeifeng@oppo.com>
> 
> In the case of insufficient memory, threads will be in direct_reclaim to
> reclaim memory, direct_reclaim will call shrink_slab to run sequentially
> each shrinker callback. If there is a lock-contention in the shrinker
> callback,such as spinlock,mutex_lock and so on, threads may be likely to
> be stuck in direct_reclaim for a long time, even if the memfree has reached
> the high watermarks of the zone, resulting in poor performance of threads.

That's always been a problem. That's a shrinker implementation
problem, not a shrinker infrastructure problem.

> Example 1: shrinker callback may wait for spinlock
> static unsigned long mb_cache_shrink(struct mb_cache *cache,
>                                      unsigned long nr_to_scan)
> {
>         struct mb_cache_entry *entry;
>         unsigned long shrunk = 0;
> 
>         spin_lock(&cache->c_list_lock);
>         while (nr_to_scan-- && !list_empty(&cache->c_list)) {
>                 entry = list_first_entry(&cache->c_list,
>                                          struct mb_cache_entry, e_list);
>                 if (test_bit(MBE_REFERENCED_B, &entry->e_flags) ||
>                     atomic_cmpxchg(&entry->e_refcnt, 1, 0) != 1) {
>                         clear_bit(MBE_REFERENCED_B, &entry->e_flags);
>                         list_move_tail(&entry->e_list, &cache->c_list);
>                         continue;
>                 }
>                 list_del_init(&entry->e_list);
>                 cache->c_entry_count--;
>                 spin_unlock(&cache->c_list_lock);
>                 __mb_cache_entry_free(cache, entry);
>                 shrunk++;
>                 cond_resched();
>                 spin_lock(&cache->c_list_lock);
>         }
>         spin_unlock(&cache->c_list_lock);
> 
>         return shrunk;
> }

Yeah, we learnt a -long- time ago that using global locks in
shrinkers that have -unbounded concurrency- is a really bad idea.
This is just a poorly implemented shrinker implemenation because it
doesn't take into account memory reclaim concurrency.

This is, for example, why list_lru exists is tightly tied into
the SHRINKER_NUMA_AWARE infrastructure - it gets rid of the need for
global locks in reclaim lists that shrinkers traverse.

> Example 2: shrinker callback may wait for mutex lock
> static
> unsigned long kbase_mem_evictable_reclaim_scan_objects(struct shrinker *s,
> 		struct shrink_control *sc)
> {
> 	struct kbase_context *kctx;
> 	struct kbase_mem_phy_alloc *alloc;
> 	struct kbase_mem_phy_alloc *tmp;
> 	unsigned long freed = 0;
> 
> 	kctx = container_of(s, struct kbase_context, reclaim);
> 
> 	// MTK add to prevent false alarm
> 	lockdep_off();

That's just -broken-.

If shrinkers are called from a context that they can't take locks
because they might deadlock, then they must either use trylocks and
abort (i.e. SHRINK_STOP) or use context flags provided by the
allocation context (e.g. GFP_NOFS, memalloc_nofs_save()) to tell
reclaim that context specific subsystem locks are held and the
shrinker should not attempt to take them and/or run in this context.

> 	mutex_lock(&kctx->jit_evict_lock);

That's also wrong.

Shrinkers must be non-blocking, otherwise the cause memory reclaim
latencies that will result in unpredicatable memory allocation
latencies and that makes anyone running applications with latency
specific SLAs very unhappy.

IOWs, this is a subsystem shrinker that is very poorly implemented
and needs to be fixed before we do anything else.

> In mobile-phone,threads are likely to be stuck in shrinker callback during
> direct_reclaim, with example like the following:
> <...>-2806    [004] ..... 866458.339840: mm_shrink_slab_start:
> 			dynamic_mem_shrink_scan+0x0/0xb8 ... priority 2
> <...>-2806    [004] ..... 866459.339933: mm_shrink_slab_end:
> 			dynamic_mem_shrink_scan+0x0/0xb8 ...

Yup, that's exactly the problem with blocking shrinkers - they can
screw the whole system over because it stops memory allocation in
it's tracks. Shrinkers must be non-blocking.

> For the above reason, the patch introduces SHRINKER_NO_DIRECT_RECLAIM that
> allows driver to set shrinker callback not to be called in direct_reclaim
> unless sc->priority is 0.

No, that's fundamentally flawed, too.

Firstly, it doesn't avoid deadlocks, nor does it avoid lock
contention under heavy memory pressure - it just hides these
problems until we are critically low on memory. Which will happen
much faster, because we aren't reclaiming memory from caches that
hold memory that needs to be reclaimed. This isn't good.

Further, it bypasses the mechanism we use to defer the shrinker
work to a context where it can be executed safely (i.e. kswapd).
Shrinkers that cannot run in the current context are supposed to
return SHRINK_STOP to tell the shrink_slab infrastructure to
accumulate the work for the next context that can run the reclaim
rather than execute it.

This allows kswapd to do the reclaim work instead of direct reclaim.
It also ensures that all the memory pressure being applied to the
shrinkers is actually actioned so we keep all the caches and memory
usage in relative balance.

IOWs, the choice of running the shrinker or not is controlled by two
things:

1. the shrinker implementation itself, and
2. the reclaim context flags provided by the allocation that needs
reclaim to be performed.

Long story short: if a shrinker is causing direct reclaim problems
because of poor locking design, latency and/or context specific
deadlocks, then the subsystem and it's shrinker needs to be fixed.
We should not be skipping direct reclaim just because a shrinker is
really poorly implemented.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

