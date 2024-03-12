Return-Path: <linux-kernel+bounces-100682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E6879BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCF21C2260F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA091419B4;
	Tue, 12 Mar 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fiY/wqP4"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990079DD4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269018; cv=none; b=d2gDbklxp1AeoBjqyIm2diG2az7+IC2kw8hH0xdWUxHmnHAd0yWiX8Eg13/BVYEYA/jed82lyhoiUrSqQfaqG5KQgpyakI6f2tNiXZ+3C8aS4QBpp9n6XAAMNF89YO+bK/Xl91jKeA9WVvWxyd+O5Ecs9XMJA2UUJh57y6zGHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269018; c=relaxed/simple;
	bh=hSR8lvPfoO0OHmPBahmqDkYqoISqwAqz4PkxOZKeVjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsawkpFuYl20dbj462b3H5fX0/Ydu9zTs5gF9IGo5B99vH0Y/C2if1bA7y/WHYEvZdhuCKvj7Bf8vwf69YU8oFMRdOS6+fE2YdrZpRRut4TIXeii14maqlZbK0o5ls++iv/JKLIgdEBMLkf5JUwpX98aYhA9im4Z8oqWl5WyjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fiY/wqP4; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e5343b915fso69600a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710269014; x=1710873814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rt7f+q+DTeqWhNoRdGZRpb3drbVDdbSe8MdSG9RnJy4=;
        b=fiY/wqP453K5h5yNC3DAHOT8LLOeqKzq+tcDQI+gOHs4UTefIJzBNMgDsGLd/PXwBH
         mHQez+QUCNxa2cpv/f9u+/Zr1OkCKyZDbVTAzWuRR7twteCRRxcju8UB0PuHsxyznwhL
         VD1dJFNTLNreW+myY5uurrJ+Wekp9KwwAtBHmC3rwVSR62Fx6Tnv4IksPzDhpyQNKazj
         dJEYP2GGVEjdP4plCB6ZlzSk6Cm8cnMIGBO047C+TSGwmFst4K7q3oaQmoyf/dn5ZjWp
         YipXjGg1m3n5kLrOuk1y/gc2pVwaT/Q87n1Ap7Xwkyks9OmSyDFrjUxWpNO1K2Xwddqk
         d9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710269014; x=1710873814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt7f+q+DTeqWhNoRdGZRpb3drbVDdbSe8MdSG9RnJy4=;
        b=XtnefOeFkzaNNHrG7DVsViY0fsTaGAt+VapVGLrPFES1aqI0+agkE3iWJC897RgqqR
         vZ89yUhoDyCod5gB2zqFQqavwH/hibZtF9rjeDGvmeBpWuAUQ8X6UU42uacBDAasHvDT
         arU7uHLB8XzjA3G8geO6ZDdfCrQ3aTcgaW5y1qT9slrHHTSwTxVNF4BoC4XJXz/xJGpi
         o1rCE70abo66QcthzycRpH3UX8upG3tH3VUOH22Q5sMkgiLKRqRAvoVg4PCVNIy6MTq2
         OEg8k+kIhma3PixobxhGGnmy2AJA6zpzjOI1YEvC6KH4uClHdhkEk2b1QXE3kdmaao86
         T+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb8mZykIShjXVsz6NRxeQULmQeCzZmQL14vuBTD2L/gdEQhvHQjmtAdz6rlPPgyQU+RtXcMdyrmlwmKpueQxqm+sg3lvNQUrfZw59l
X-Gm-Message-State: AOJu0YwJBbntin08SqtKBVcIl4b4AkhQ8Sa3HWWDVEqYxB7atWkHWmKO
	VaI6xM3MhUvrNZ4FMc5ya5D2qcZ5z7z/xJb/2/nXzJClpCmpkv05t+w4L04oHJk=
X-Google-Smtp-Source: AGHT+IEwgqJbo2Pl85BubNzexezi/41LXH6x4XWMmazgG18/DwJqO+pQ2IZQWHBrvoNHqriIMyRQUw==
X-Received: by 2002:a9d:7841:0:b0:6e4:8fa3:d861 with SMTP id c1-20020a9d7841000000b006e48fa3d861mr4294276otm.34.1710269014573;
        Tue, 12 Mar 2024 11:43:34 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id qp10-20020a05620a388a00b0078870b3ad29sm1966546qkn.126.2024.03.12.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 11:43:33 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:43:29 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <v-songbaohua@oppo.com>, Barry Song <baohua@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: Re: [PATCH v6] zswap: replace RB tree with xarray
Message-ID: <20240312184329.GA3501@cmpxchg.org>
References: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>

On Tue, Mar 12, 2024 at 10:31:12AM -0700, Chris Li wrote:
> Very deep RB tree requires rebalance at times. That
> contributes to the zswap fault latencies. Xarray does not
> need to perform tree rebalance. Replacing RB tree to xarray
> can have some small performance gain.
> 
> One small difference is that xarray insert might fail with
> ENOMEM, while RB tree insert does not allocate additional
> memory.
> 
> The zswap_entry size will reduce a bit due to removing the
> RB node, which has two pointers and a color field. Xarray
> store the pointer in the xarray tree rather than the
> zswap_entry. Every entry has one pointer from the xarray
> tree. Overall, switching to xarray should save some memory,
> if the swap entries are densely packed.
> 
> Notice the zswap_rb_search and zswap_rb_insert always
> followed by zswap_rb_erase. Use xa_erase and xa_store
> directly. That saves one tree lookup as well.
> 
> Remove zswap_invalidate_entry due to no need to call
> zswap_rb_erase any more. Use zswap_free_entry instead.
> 
> The "struct zswap_tree" has been replaced by "struct xarray".
> The tree spin lock has transferred to the xarray lock.
> 
> Run the kernel build testing 10 times for each version, averages:
> (memory.max=2GB, zswap shrinker and writeback enabled,
> one 50GB swapfile, 24 HT core, 32 jobs)
> 
> mm-9a0181a3710eb             xarray v5
> user       3532.385			3535.658
> sys        536.231                      530.083
> real       200.431                      200.176

This is a great improvement code and complexity wise.

I have a few questions and comments below:

What kernel version is this based on? It doesn't apply to
mm-everything, and I can't find 9a0181a3710eb anywhere.

> @@ -1555,28 +1473,35 @@ bool zswap_store(struct folio *folio)
>  insert_entry:
>  	entry->swpentry = swp;
>  	entry->objcg = objcg;
> -	if (objcg) {
> -		obj_cgroup_charge_zswap(objcg, entry->length);
> -		/* Account before objcg ref is moved to tree */
> -		count_objcg_event(objcg, ZSWPOUT);
> -	}
>  
> -	/* map */
> -	spin_lock(&tree->lock);
>  	/*
>  	 * The folio may have been dirtied again, invalidate the
>  	 * possibly stale entry before inserting the new entry.
>  	 */

The comment is now somewhat stale and somewhat out of place. It should
be above that `if (old)` part... See below.

> -	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> -		zswap_invalidate_entry(tree, dupentry);
> -		WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
> +	old = xa_store(tree, offset, entry, GFP_KERNEL);
> +	if (xa_is_err(old)) {
> +		int err = xa_err(old);
> +		if (err == -ENOMEM)
> +			zswap_reject_alloc_fail++;
> +		else
> +			WARN_ONCE(err, "%s: xa_store failed: %d\n",
> +				  __func__, err);
> +		goto store_failed;

No need to complicate it. If we have a bug there, an incorrect fail
stat bump is the least of our concerns. Also, no need for __func__
since that information is included in the WARN:

	if (xa_is_err(old)) {
		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
		zswap_reject_alloc_fail++;
		goto store_failed;
	}

I think here is where that comment above should go:

	/*
	 * We may have had an existing entry that became stale when
	 * the folio was redirtied and now the new version is being
	 * swapped out. Get rid of the old.
	 */
> +	if (old)
> +		zswap_entry_free(old);
> +
> +	if (objcg) {
> +		obj_cgroup_charge_zswap(objcg, entry->length);
> +		/* Account before objcg ref is moved to tree */
> +		count_objcg_event(objcg, ZSWPOUT);
>  	}
> +
>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
>  		zswap_lru_add(&zswap.list_lru, entry);
>  		atomic_inc(&zswap.nr_stored);
>  	}
> -	spin_unlock(&tree->lock);

We previously relied on the tree lock to finish initializing the entry
while it's already in tree. Now we rely on something else:

	1. Concurrent stores and invalidations are excluded by folio lock.

	2. Writeback is excluded by the entry not being on the LRU yet.
	   The publishing order matters to prevent writeback from seeing
	   an incoherent entry.

I think this deserves a comment.

>  	/* update stats */
>  	atomic_inc(&zswap_stored_pages);
> @@ -1585,6 +1510,12 @@ bool zswap_store(struct folio *folio)
>  
>  	return true;
>  
> +store_failed:
> +	if (!entry->length) {
> +		atomic_dec(&zswap_same_filled_pages);
> +		goto freepage;
> +	}

It'd be good to avoid the nested goto. Why not make the pool
operations conditional on entry->length instead:

store_failed:
	if (!entry->length)
		atomic_dec(&zswap_same_filled_pages);
	else {
		zpool_free(zswap_find_zpool(...));
put_pool:
		zswap_pool_put(entry->pool);
	}
freepage:

Not super pretty either, but it's a linear flow at least.

