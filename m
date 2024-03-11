Return-Path: <linux-kernel+bounces-99594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCE878A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B511F21FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A148157323;
	Mon, 11 Mar 2024 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhk+FpXU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A557314
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194980; cv=none; b=c0LqRGAjEdCEd8FF4ABwUm7TAwggkrSWmXB34y/I0VFj0oKEgy/8ktwSL28JlaBWrskhOBeHy3z+E9Rb3JRYJ8hLrRL75nKtyp8cuBlP9UjBUwnIx+XFgfR/+17iq0NT/JEx9CEk9lhKX+zWDRp8/76SWZDzvYdTsR6i0m0KJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194980; c=relaxed/simple;
	bh=KfCYvd4kRRmAaHRjwtYVDj7+0KuZFNGtYFFcTCg+INE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UeiOeOdXPzbzPOcjTsY4U2I6hKfnT5ZpOdC53m+FMLg29b3uexFWUrZEmMFggXvLRKtMPY0vm3XjuwxYBO44VNddtsqufuxWzQvyJejEDVRDXCn8fLgwFVdE/N1/E/uxmV7NH1T400wEChn6HYt7rn7xmGq7isNjplVcyYyK9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhk+FpXU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609d95434daso70291337b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710194977; x=1710799777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5gxKcBG9B2NwGIgck91cK0cCgZ6XAorrAmw0ICvRr8=;
        b=qhk+FpXU72FDx1jUxM2oBAIzqldzJhw2RxmCYiAr5wHCOVJqCzIDSnbU2+LXRV2OhN
         T4dFv+GX0d29KJrcZd3cItAcCfBDTi6b62PifZL7tkDy98LI4acPebI4Zuzd7rmVvElJ
         YTAFVrjNZnbDAyyYkX27VZqnZ49cQQgCIk+V6Q4CzL/FhV6BvE8GOS9vgRHaR+aUxMNU
         BrOP3sh5TDg9yYjXyxD1pkhwnP/QGO8jDodB+xYjn7K+Q3kiMNPViuxwOd0VeFUsh5UD
         lTjS/ykAKdn6WEYw4864ezMsdzfqLxgiTyhHP/+3jiilZbOBffHmvvwQYOxQvCpcFQss
         8a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710194977; x=1710799777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5gxKcBG9B2NwGIgck91cK0cCgZ6XAorrAmw0ICvRr8=;
        b=wkP662NcO3EQMOgcW6NiVnEnsCFaTpMliVC8K3svKUE7Cd0LKikLe3eptzJJ7+faYf
         wVw0nNaf5W5b7mGvLD3prGHldUA7nvGpQvMJ5v7OcQS1BDAsu19g1cWZBQW2/U779gps
         KVY31y77i+Tc9xp/r9TjRSMGd7Nw0m1dD6rKciwJe6tppGza7vNSuU34KSlsaruE4/JI
         PzKGRyiOOfZoYFoNKQaxW/VercqbSLXPZTbH/EZR6B66jx6fznF885hLoEoD+m1YufW5
         vOPY6D8QqVQQaBq2yWO6nZbudx0CodE4YW1E9UAY8UGytnD6w3TGvAcKtF3FAG+odY9z
         tXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf5pucOO4pvkQT68JwJf0DLjdZjwctrN1Rbn+8TP1O8q+MdtyiOAAy9N9KJvKWSA1UAokQGCPIRmPG9r5PJmsbr9LTSyoTpQ8w+uP8
X-Gm-Message-State: AOJu0YxUSOa0y05BKN+2Qqja4fLnXS8cWXpfOzGI1NZNRcFwDmCJRM9P
	1+kZS4ZtqZI8N2Rn03N3COsg2/B2ciNAY6bHlDs7TbUwiABLvwXFpHQGrb4xaRcQSrcGiUKetE5
	WbsLZ1Myym5wcRdkzJw==
X-Google-Smtp-Source: AGHT+IF1RBJE1y4HMiePUf4HmcGxy0skZsuDCxP/wlOEXOnJllclb1u65Ny1Tv6mofVWBbXbmXXmVD7XoiGKGLOD
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:110a:b0:dcc:50ca:e153 with
 SMTP id o10-20020a056902110a00b00dcc50cae153mr2168318ybu.7.1710194977555;
 Mon, 11 Mar 2024 15:09:37 -0700 (PDT)
Date: Mon, 11 Mar 2024 22:09:35 +0000
In-Reply-To: <20240311161214.1145168-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311161214.1145168-1-hannes@cmpxchg.org>
Message-ID: <Ze-BH5HDNUG5ohJS@google.com>
Subject: Re: [PATCH 1/2] mm: zswap: optimize zswap pool size tracking
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024 at 12:12:13PM -0400, Johannes Weiner wrote:
> Profiling the munmap() of a zswapped memory region shows 50%(!) of the
> total cycles currently going into updating the zswap_pool_total_size.

Yikes. I have always hated that size update scheme FWIW.

I have also wondered whether it makes sense to just maintain the number
of pages in zswap as an atomic, like zswap_stored_pages. I guess your
proposed scheme is even cheaper for the load/invalidate paths because we
do nothing at all.  It could be an option if the aggregation in other
paths ever becomes a problem, but we would need to make sure it
doesn't regress the load/invalidate paths. Just sharing some thoughts.

> 
> There are three consumers of this counter:
> - store, to enforce the globally configured pool limit
> - meminfo & debugfs, to report the size to the user
> - shrink, to determine the batch size for each cycle
> 
> Instead of aggregating everytime an entry enters or exits the zswap
> pool, aggregate the value from the zpools on-demand:
> 
> - Stores aggregate the counter anyway upon success. Aggregating to
>   check the limit instead is the same amount of work.
> 
> - Meminfo & debugfs might benefit somewhat from a pre-aggregated
>   counter, but aren't exactly hotpaths.
> 
> - Shrinking can aggregate once for every cycle instead of doing it for
>   every freed entry. As the shrinker might work on tens or hundreds of
>   objects per scan cycle, this is a large reduction in aggregations.
> 
> The paths that benefit dramatically are swapin, swapoff, and
> unmaps. There could be millions of pages being processed until
> somebody asks for the pool size again. This eliminates the pool size
> updates from those paths entirely.

This looks like a big win, thanks! I wonder if you have any numbers of
perf profiles to share. That would be nice to have, but I think the
benefit is clear regardless.

I also like the implicit cleanup when we switch to maintaining the
number of pages rather than bytes. The code looks much better with all
the shifts and divisions gone :)

I have a couple of comments below. With them addressed, feel free to
add:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

[..]  
> @@ -1385,6 +1365,10 @@ static void shrink_worker(struct work_struct *w)
>  {
>  	struct mem_cgroup *memcg;
>  	int ret, failures = 0;
> +	unsigned long thr;
> +
> +	/* Reclaim down to the accept threshold */
> +	thr = zswap_max_pages() * zswap_accept_thr_percent / 100;

This calculation is repeated twice, so I'd rather keep a helper for it
as an alternative to zswap_can_accept(). Perhaps zswap_threshold_page()
or zswap_acceptance_pages()?

>  
>  	/* global reclaim will select cgroup in a round-robin fashion. */
>  	do {
> @@ -1432,10 +1416,9 @@ static void shrink_worker(struct work_struct *w)
>  			break;
>  		if (ret && ++failures == MAX_RECLAIM_RETRIES)
>  			break;
> -
>  resched:
>  		cond_resched();
> -	} while (!zswap_can_accept());
> +	} while (zswap_total_pages() > thr);
>  }
[..]
> @@ -1711,6 +1700,13 @@ void zswap_swapoff(int type)
>  
>  static struct dentry *zswap_debugfs_root;
>  
> +static int debugfs_get_total_size(void *data, u64 *val)
> +{
> +	*val = zswap_total_pages() * PAGE_SIZE;
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, "%llu");

I think we are missing a newline here to maintain the current format
(i.e "%llu\n").

> +
>  static int zswap_debugfs_init(void)
>  {
>  	if (!debugfs_initialized())
> @@ -1732,8 +1728,8 @@ static int zswap_debugfs_init(void)
>  			   zswap_debugfs_root, &zswap_reject_compress_poor);
>  	debugfs_create_u64("written_back_pages", 0444,
>  			   zswap_debugfs_root, &zswap_written_back_pages);
> -	debugfs_create_u64("pool_total_size", 0444,
> -			   zswap_debugfs_root, &zswap_pool_total_size);
> +	debugfs_create_file("pool_total_size", 0444,
> +			    zswap_debugfs_root, NULL, &total_size_fops);
>  	debugfs_create_atomic_t("stored_pages", 0444,
>  				zswap_debugfs_root, &zswap_stored_pages);
>  	debugfs_create_atomic_t("same_filled_pages", 0444,
> -- 
> 2.44.0
> 

