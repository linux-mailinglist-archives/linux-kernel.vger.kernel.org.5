Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B777D576F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjJXQJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJXQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:09:09 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D9AA1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:09:06 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7789cc5c8ccso377034185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1698163745; x=1698768545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOgTqaWod2GIRMlQnZ21kgeA7fU4We2gZHXmH2gakWs=;
        b=HnxUkBWN+fNe0/jn27fSEWXczaAvhrMLtG+uZiImetWKZhEDcOUzgTh8O/1YcJqPnp
         nEUUQDEwok6hzsT4rdLO/+9a+kXx7pJWWQw2nlhAkMo51aKnxoI2q+NpOIgIMEC0hJog
         Gmn79q3r8cwL4W6hHerFgFJQgXFpoTexI0UuiQbzW/o7bdEByShdf85fNneoQn9swLnk
         S4diAq+8JY1jmc2g4T4v1tP0y3/g2Ta4o+f5Oj1qKGYP/572C4oUl7jJwG8nYY4Sf2ni
         VBYr8BiEXVaHLITop5cQM6s5g1NpChFOfmv1qkjAnq5HzkIvEoUJJneFuj/gC00HXfCc
         9mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163745; x=1698768545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOgTqaWod2GIRMlQnZ21kgeA7fU4We2gZHXmH2gakWs=;
        b=HCBY9tN+5xHHnByYz9CLJLrUv0AOb+Zm4b3cakEDXdCHP+fSxv/BPpskxZO1viLgZp
         2uVdPRimvL0qpDU+I7/ooUnY589VfvqziGCZxB+14p7GTxfLvJWqAQp0Y4kkFBujdOrz
         hxi2pDYPXG9jZW6Cgqf8yWcuBEIMPoWlbYqvXFt/NcmMK4u18yEvj3g9vcWTP91fj2yL
         lCgBtx18/K244EX/XDANdDMSQd9XVebMlPrbjrGVpwDDJeDiBtgEsbg5CkjarlEed1c7
         bHw7tMqO1NZ4tRnim6DA6TGb5ZeC/dWqomw36sMu/JMk/NMdWurCAlkGwlo39t39AI80
         epQQ==
X-Gm-Message-State: AOJu0YzyXzjF/aX1tWVXf4AdAI4VQN3CuUquEiMToz4ftUYpa3iEJ/sA
        q02JEgzwXsWB1ioUT++O/wHY2A==
X-Google-Smtp-Source: AGHT+IE4iOSeMFxlVe/rUGgAvUrIKN/iHb2FxiHseAUx3vVefnmIsABNiiFtr0ZTnpRstzIYxb6ysQ==
X-Received: by 2002:a05:620a:448a:b0:773:ac84:3f57 with SMTP id x10-20020a05620a448a00b00773ac843f57mr17278800qkp.5.1698163745326;
        Tue, 24 Oct 2023 09:09:05 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id r16-20020a05620a299000b007756c8ce8f5sm3505539qkp.59.2023.10.24.09.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:09:05 -0700 (PDT)
Date:   Tue, 24 Oct 2023 12:09:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] zswap: export more zswap store failure stats
Message-ID: <20231024160904.GA1971738@cmpxchg.org>
References: <20231024000702.1387130-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024000702.1387130-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 05:07:02PM -0700, Nhat Pham wrote:
> Since:
> 
> "42c06a0e8ebe mm: kill frontswap"
> 
> we no longer have a counter to tracks the number of zswap store
> failures. This makes it hard to investigate and monitor for zswap
> issues.
> 
> This patch adds a global and a per-cgroup zswap store failure counter,
> as well as a dedicated debugfs counter for compression algorithm failure
> (which can happen for e.g when random data are passed to zswap).
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

I agree this is an issue.

> ---
>  include/linux/vm_event_item.h |  1 +
>  mm/memcontrol.c               |  1 +
>  mm/vmstat.c                   |  1 +
>  mm/zswap.c                    | 18 ++++++++++++++----
>  4 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 8abfa1240040..7b2b117b193d 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -145,6 +145,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_ZSWAP
>  		ZSWPIN,
>  		ZSWPOUT,
> +		ZSWPOUT_FAIL,

Would the writeback stat be sufficient to determine this?

Hear me out. We already have pswpout that shows when we're hitting
disk swap. Right now we can't tell if this is because of a rejection
or because of writeback. With a writeback counter we could.

And I think we want the writeback counter anyway going forward in
order to monitor and understand the dynamic shrinker's performance.

Either way we go, one of the metrics needs to be derived from the
other(s). But I think subtle and not so subtle shrinker issues are
more concerning than outright configuration problems where zswap
doesn't work at all. The latter is easier to catch before or during
early deployment with simple functionality tests.

Plus, rejections should be rare. They are now, and they should become
even more rare or cease to exist going forward. Because every time
they happen at scale, they represent problematic LRU inversions.  We
have patched, have pending patches, or discussed changes to reduce
every single one of them:

	/* Store failed due to a reclaim failure after pool limit was reached */
	static u64 zswap_reject_reclaim_fail;

With the shrinker this becomes less relevant. There was also the
proposal to disable the bypass to swap and just keep the page.

	/* Compressed page was too big for the allocator to (optimally) store */
	static u64 zswap_reject_compress_poor;

You were working on eradicating this (with zsmalloc at least).

	/* Store failed because underlying allocator could not get memory */
	static u64 zswap_reject_alloc_fail;
	/* Store failed because the entry metadata could not be allocated (rare) */
	static u64 zswap_reject_kmemcache_fail;

These shouldn't happen at all due to PF_MEMALLOC.

IOW, the fail counter is expected to stay zero in healthy,
well-configured systems. Rather than an MM event that needs counting,
this strikes me as something that could be a WARN down the line...

I agree with adding the debugfs counter though.
