Return-Path: <linux-kernel+bounces-108483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606C880B14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72AD1C21F18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588D182A1;
	Wed, 20 Mar 2024 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XF+cZOMl"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFC17999
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915214; cv=none; b=gtr+RUAXD4V0eVoolYiZg0C3MYOr9Edp1APBP5vXcOGPyQFwnitzeMasYz7sAGtRAYBSv85jhyoa7uN+UroolV8guY9VAL2/f/xwbZHjQHHDPhbGt+lDM38QGF2UtWLhfJKZQ2HcXWMy6T8Wo470vTevMzNVH54subvi4tp359M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915214; c=relaxed/simple;
	bh=t10QgWkXbF+snM1gcYNzie0VdR/jb+14jMHjgFqoeVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kge/8OySccY9G9XGgDAJb1BAh8fTcrQxT8CZzaeUKQTce5dJSsWOQNYC2yOXIA9KUQMFRYKXLPvpQEIs9yjEq4AcPZYaMkWiwrdEbbKS+udOA+R9nGYzD9utpgROyDM/rTyCy+LgPd+VqNXmUP5lLIihja8dDjwqWEdGiovhvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XF+cZOMl; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso9198208276.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710915212; x=1711520012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj7+zABO75II9g/KOKonpSfKZraBzKkEO6GqLn+SlEA=;
        b=XF+cZOMlAbFNuJvTYS/Jd69joCmMex7Nqu9mu/dSn4rOeUQmQ8Mr2LQzQK3mpQ7FuT
         hbzre7fA3jMs6ezpozXiEVGQQWmrjpPPHPAtS8wxZ0TQkMSSBxfHIhep4narYGeWHgof
         zpg4KKdWcy0x/IwIbeFY+9vMP3gvTIm4qdRQaqedU3KYcq3vDiB/1rzjonpXex2ZWh4n
         D7+XfW9dgj8YOfzM4E6Cz3MqBzxPQT597cuZVsJlBplfXeC1k8V/MlV+T6B5mpNhoxuL
         u1m3wACWd/vjEyWmuE20uxYR2r2l8eSv54L2nj8DWR1PYX94apTZRW2nPOStS7EdcC3L
         E6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710915212; x=1711520012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj7+zABO75II9g/KOKonpSfKZraBzKkEO6GqLn+SlEA=;
        b=HBP53ksOwcQC9kvhS/h8UYdclhusAas57+imuD9o1ZPAvaqW5c48/ykj98Fx7C3/q7
         1w0M85Yudp33nhMtxBcCbNg/M0vj6TKhMRDFz6Ts3ZRIOC4aHuXAQKrafTy/qm3cqOKE
         MJgyC9TiqL3KZqUDLRtTJfS1u3mEP/nmkQVxTqddzpTj6+pDm6h7b2RsgrsPbBN8BzQV
         ZDFUU2zRI7q7OPjaTATf910n4l8r9bqLA0UPJIG1iArz26t1qQCCIjyEFZ8AZd7Gffw9
         KZJObQ8WRTbb/gzv4MDmOWkmL/AeH9+38v9BWdWihKJhH3gnJSj6zvP2P7dR5dnR/3Xj
         38mA==
X-Forwarded-Encrypted: i=1; AJvYcCVdNWOsRJuv7NAgmg7QXw2aMMeVs6Yf9wj+eLvMWs9HtT/bJR3eE864sHxMcg5hCgc4DIzmbKUN25XRw5GL+SdfeWUKL2KPb4r46Pqi
X-Gm-Message-State: AOJu0YwdyHBz9PAkZvKk2Kin4YgoVwRfwvDeeGC3txASnBAbhcXdmPHd
	yicZvFwRjE4Tcvqld2/0TknaqEvuB67Qso4DNGNnyf/nREoCHC+Uxmf1ZPrB9e1G3kGnMC+vcCq
	NAlFjoVjYx7afZlaVqQ==
X-Google-Smtp-Source: AGHT+IHO9jutXv2J30LOwCgyAcPL12KG1J8A/WJiPynw9T5KQ+ILRwx7sQKwyC0nvXiVA5ubtcdJojtJnUNqj7tq
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1b03:b0:dd9:1db5:8348 with
 SMTP id eh3-20020a0569021b0300b00dd91db58348mr1156570ybb.8.1710915212100;
 Tue, 19 Mar 2024 23:13:32 -0700 (PDT)
Date: Wed, 20 Mar 2024 06:13:29 +0000
In-Reply-To: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
Message-ID: <Zfp-iWaDfqeCOElt@google.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 19, 2024 at 10:52:26PM -0700, Chris Li wrote:
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
> mm-unstable-a824831a082f     xarray v7
> user       3547.264			3541.509
> sys        531.176                      526.111
> real       200.752                      201.334
> 
> ---

I believe there shouldn't be a separator before Rb and Sb below.

> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>

I have some comments below, with them addressed:

Acked-by: Yosry Ahmed <yosryahmed@google.com>

[..]
> @@ -1556,28 +1474,43 @@ bool zswap_store(struct folio *folio)
>  insert_entry:
>  	entry->swpentry = swp;
>  	entry->objcg = objcg;
> +
> +	old = xa_store(tree, offset, entry, GFP_KERNEL);
> +	if (xa_is_err(old)) {
> +		int err = xa_err(old);

There should be a blank line after the declaration.

> +		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
> +		zswap_reject_alloc_fail++;
> +		goto store_failed;
> +	}
> +
> +        /*
> +         * We may have had an existing entry that became stale when
> +         * the folio was redirtied and now the new version is being
> +         * swapped out. Get rid of the old.
> +         */

This comment is mis-indented.

checkpatch would have caught these btw.

> +	if (old)
> +		zswap_entry_free(old);
> +
>  	if (objcg) {
>  		obj_cgroup_charge_zswap(objcg, entry->length);
> -		/* Account before objcg ref is moved to tree */
>  		count_objcg_event(objcg, ZSWPOUT);
>  	}
>  
> -	/* map */
> -	spin_lock(&tree->lock);
>  	/*
> -	 * The folio may have been dirtied again, invalidate the
> -	 * possibly stale entry before inserting the new entry.
> +	 * We finish initializing the entry while it's already in xarray.
> +	 * This is safe because:
> +	 *
> +	 * 1. Concurrent stores and invalidations are excluded by folio lock.
> +	 *
> +	 * 2. Writeback is excluded by the entry not being on the LRU yet.
> +	 *    The publishing order matters to prevent writeback from seeing
> +	 *    an incoherent entry.

As I mentioned before, writeback is also protected by the folio lock.
Concurrent writeback will find the folio in the swapcache and abort. The
fact that the entry is not on the LRU yet is just additional protection,
so I don't think the publishing order actually matters here. Right?

