Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A197FDCE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjK2QVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjK2QVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:21:51 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC5010C2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:21:56 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77d8d1b7952so238266485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701274916; x=1701879716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYHLv9CSAfTThewWoacMTkgj93sBj76qjRtYqdHw6QM=;
        b=oczT/7yNyh2rO2+7Z2ZVrnrrRD6hoAnih2ZVATXEbWprimOauqiUxqBSSikHAUTivz
         qNzZEic2KGFZmNoMXcNva4w1+GHOGVpTsihm5aOpN2xls3bhXDn2c4IlEm2UzuLMzVlF
         /X4VkDvU0oXFoeFNdYCsnxllbNUy79mj/O1p8QW7RzNSnvJ6TA8Hndix9jm8lmYhrE2o
         +lz2X2SCA9qvQuO8xUHF2Epm1wgGHMB1b9t1rHD3+iuQ+sC6mTRTm94Y5dMxl4B8BzUY
         QVdab3hzh0OfMkziuJTW74gffSal0jYV5unfwo++rkSmKFcB1tssNiihW24TIpnPJJUw
         GbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701274916; x=1701879716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYHLv9CSAfTThewWoacMTkgj93sBj76qjRtYqdHw6QM=;
        b=ekBFkKUsqVSC1vQjML07PEjvAzoQRrROlGx3XU8NPnLMdR8o8/Ugxd1KtqoLY4EH0N
         yq6BxrUFyV8V1R7cJWyt9N/N0OVNsUuMm5KUPLBHmyljfjn6CIXoqo+giHXMqaLxhTRL
         DhTNeCz3G9CCCkrlPl9B/1dqe74jJxM7obWl0WLMnNG5i6VHHlqkOIBtx93vQwRePsdC
         TnZKmu+PJb5ExeiqsonRjbYZPVL21N96E05FRHtH9ZO63/X4zV1kiI/sf5PAicBe9nKs
         bXONvGXefP2o0nTb5GK7vLCPFOeZk4SuknK75i1NU2DJ6ttnbu71Q+Ue0NL599N1zZ4r
         iniA==
X-Gm-Message-State: AOJu0YxD2cGE4QcBFsuYAGu89L8AzQnlqkshKMsm/JZoBy+TPXF7IGsN
        4fDWzQ3ahZbkbSIFo1gUPLDtKA==
X-Google-Smtp-Source: AGHT+IExE8UXik9bRCJxcJyoMa34oV6Hn3YLIHwRECfowsGDeobteC5UhV2ag8pFjY+6iqyHgOuSyg==
X-Received: by 2002:a05:6214:86:b0:67a:2b0b:c591 with SMTP id n6-20020a056214008600b0067a2b0bc591mr16240106qvr.25.1701274915900;
        Wed, 29 Nov 2023 08:21:55 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id k14-20020ad4450e000000b0067a26d7ce6fsm4550774qvu.55.2023.11.29.08.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:21:55 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:21:50 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v7 6/6] zswap: shrinks zswap pool based on memory pressure
Message-ID: <20231129162150.GE135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:46:00PM -0800, Nhat Pham wrote:
> Currently, we only shrink the zswap pool when the user-defined limit is
> hit. This means that if we set the limit too high, cold data that are
> unlikely to be used again will reside in the pool, wasting precious
> memory. It is hard to predict how much zswap space will be needed ahead
> of time, as this depends on the workload (specifically, on factors such
> as memory access patterns and compressibility of the memory pages).
> 
> This patch implements a memcg- and NUMA-aware shrinker for zswap, that
> is initiated when there is memory pressure. The shrinker does not
> have any parameter that must be tuned by the user, and can be opted in
> or out on a per-memcg basis.
> 
> Furthermore, to make it more robust for many workloads and prevent
> overshrinking (i.e evicting warm pages that might be refaulted into
> memory), we build in the following heuristics:
> 
> * Estimate the number of warm pages residing in zswap, and attempt to
>   protect this region of the zswap LRU.
> * Scale the number of freeable objects by an estimate of the memory
>   saving factor. The better zswap compresses the data, the fewer pages
>   we will evict to swap (as we will otherwise incur IO for relatively
>   small memory saving).
> * During reclaim, if the shrinker encounters a page that is also being
>   brought into memory, the shrinker will cautiously terminate its
>   shrinking action, as this is a sign that it is touching the warmer
>   region of the zswap LRU.
> 
> As a proof of concept, we ran the following synthetic benchmark:
> build the linux kernel in a memory-limited cgroup, and allocate some
> cold data in tmpfs to see if the shrinker could write them out and
> improved the overall performance. Depending on the amount of cold data
> generated, we observe from 14% to 35% reduction in kernel CPU time used
> in the kernel builds.

I think this is a really important piece of functionality for zswap.

Memory compression has been around and in use for a long time, but the
question of zswap vs swap sizing has been in the room since the hybrid
mode was first proposed. Because depending on the reuse patterns,
putting zswap with a static size limit in front of an existing swap
file can be a net negative for performance as it consumes more memory.

It's great to finally see a solution to this which makes zswap *much*
more general purpose. And something that distributions might want to
turn on per default when swap is configured.

Actually to the point where I think there should be a config option to
enable the shrinker per default. Maybe not right away, but in a few
releases when this feature has racked up some more production time.

> @@ -687,6 +687,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  					&page_allocated, false);
>  	if (unlikely(page_allocated))
>  		swap_readpage(page, false, NULL);
> +	zswap_lruvec_swapin(page);

The "lruvec" in the name vs the page parameter is a bit odd.
zswap_page_swapin() would be slightly better, but it still also sounds
like it would cause an actual swapin of some sort.

zswap_record_swapin()?

> @@ -520,6 +575,95 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
>  	return entry;
>  }
>  
> +/*********************************
> +* shrinker functions
> +**********************************/
> +static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
> +				       spinlock_t *lock, void *arg);
> +
> +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> +		struct shrink_control *sc)
> +{
> +	struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
> +	unsigned long shrink_ret, nr_protected, lru_size;
> +	struct zswap_pool *pool = shrinker->private_data;
> +	bool encountered_page_in_swapcache = false;
> +
> +	nr_protected =
> +		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> +	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
> +
> +	/*
> +	 * Abort if the shrinker is disabled or if we are shrinking into the
> +	 * protected region.
> +	 */
> +	if (!zswap_shrinker_enabled || nr_protected >= lru_size - sc->nr_to_scan) {
> +		sc->nr_scanned = 0;
> +		return SHRINK_STOP;
> +	}

I'm scratching my head at the protection check. zswap_shrinker_count()
already factors protection into account, so sc->nr_to_scan should only
be what is left on the list after excluding the protected area.

Do we even get here if the whole list is protected? Is this to protect
against concurrent shrinking of the list through multiple shrinkers or
swapins? If so, a comment would be nice :)

Otherwise, this looks great to me!

Just nitpicks, no show stoppers:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
