Return-Path: <linux-kernel+bounces-40280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811B683DD86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CBD1C20E19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68661CF9C;
	Fri, 26 Jan 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="TpaCTmCa"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7001CF8D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283097; cv=none; b=XTX4x1Vna6aAFTLJjDOzr42ct/rryErJ+3emlZ5N9rv1QLB1j50pFcXf49K7tYcBd6NN5ugQViPO9hUfUCzCIGgU0eBO1U0x+QwRPqhLvYnGM0t3wO0vWobbRDA6nNnd/BYMNx/rLcBrHIOBm5G4TKgmDwkgAYFyGRuUt9M6Kc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283097; c=relaxed/simple;
	bh=QGeiumQXZjpUAJEqfwMDTAKedmLTwPe9t13tKiWWoJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSo6SXqjte70mv5RzjeprwWJ8IMKkcT2e1zqQrR1gMR2dF69SKOD04ph5HWC9IAl72gUZMmc+/N+hmeNmTHARbXIYItkegfyZJy5asts3sG5Ur/0JjIEnIxMdg0lsIB4q2GQuIFpPGIgtdRa4MlSiVEHyqNfRVnvJt7tsHTrrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=TpaCTmCa; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a7aa96669so3852201cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706283093; x=1706887893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8xFaWQCHWurka6SrH6X4+S0f4rWeYvomsMFMS1hldQ=;
        b=TpaCTmCaqPLqLyV7A9b6SoXME6sAdQHYaqDvqovLADNW/l3su8sBFNnJ6VVYL7Za2p
         2tUvktMmPI5gRwCJjlav2DyqRLOaMo1mMdAPpCz8CxMxwMCrJ+RhrBpjEeqhQp2Zckfz
         zmqFP3F9iHU0UW7FX0xDu9z6olUFNvhSVapSB7KKmP6TKZSfRegC+Cy0o03OCGUKugoT
         Dg1PV9mNIu/AhwyLUY6I26epFov2Nu/iiEepV07aevXduC2v0c+6Ms84kQqe+/4HYOGF
         7JLT3Q0gi2oVyZ0Y0KbXfb9gGtMVq+fNe+JC70sArdy0uFP98hGZ/BaWjCTnU8JwTJqM
         rI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283093; x=1706887893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8xFaWQCHWurka6SrH6X4+S0f4rWeYvomsMFMS1hldQ=;
        b=ujy9urV3rtNKK2Uof+oBfrCPUzeXgJqJ0adW+6Zj3kDXX40PiQsM8zHAVbBjrqVL0k
         oLTB+qVSqysVp7K4orUvK/PtN0d6aonrV+MhPz4UYKeVmEn6treMpXfKt3U8QA8jFM4A
         KWe/LSMiSCUFCW1unu+xIHBJAltUlV1GHCCNOgQR5tuQtVnaOmP5FdEUp3jdW3i0Qoz0
         Ag9u60DjPgbp0puTMinxdrwRSxe9oJeqIr453jXdd52setoN7s6SNdlyu/igjvYaC3pJ
         uv7LKvBgjniaXi1Gf38ekviuHJLrynnu+vA4P06OMW7IXfh9m+wKoxtMx1KrBS0ijnwl
         xSwg==
X-Gm-Message-State: AOJu0Yzh+CmGHLGkGqM9Cl2Q4FAKsAPiWWuLC7IG1/91jNwPY/jSnjN4
	rDjJ73GZY3IsYPduWAsmjOgFhafSql/e6G9d9RtIlKWy1O+FLKzYcdrqAqbwBcA=
X-Google-Smtp-Source: AGHT+IE5Fh/DjIILtcBC05Tkvn3HXStuS1QvOx0c0621W5YJW7xHdA8k9CRqvRWkxySjah4k3K84mA==
X-Received: by 2002:a05:622a:1a20:b0:42a:53f4:3198 with SMTP id f32-20020a05622a1a2000b0042a53f43198mr2756qtb.99.1706283093090;
        Fri, 26 Jan 2024 07:31:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:271e])
        by smtp.gmail.com with ESMTPSA id bq11-20020a05622a1c0b00b0042a4402bd75sm612257qtb.27.2024.01.26.07.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:31:32 -0800 (PST)
Date: Fri, 26 Jan 2024 10:31:26 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: chengming.zhou@linux.dev
Cc: yosryahmed@google.com, nphamcs@gmail.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 2/2] mm/zswap: fix race between lru writeback and swapoff
Message-ID: <20240126153126.GG1567330@cmpxchg.org>
References: <20240126083015.3557006-1-chengming.zhou@linux.dev>
 <20240126083015.3557006-2-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126083015.3557006-2-chengming.zhou@linux.dev>

On Fri, Jan 26, 2024 at 08:30:15AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> LRU writeback has race problem with swapoff, as spotted by Yosry[1]:
> 
> CPU1			CPU2
> shrink_memcg_cb		swap_off
>   list_lru_isolate	  zswap_invalidate
> 			  zswap_swapoff
> 			    kfree(tree)
>   // UAF
>   spin_lock(&tree->lock)
> 
> The problem is that the entry in lru list can't protect the tree from
> being swapoff and freed, and the entry also can be invalidated and freed
> concurrently after we unlock the lru lock.
> 
> We can fix it by moving the swap cache allocation ahead before
> referencing the tree, then check invalidate race with tree lock,
> only after that we can safely deref the entry. Note we couldn't
> deref entry or tree anymore after we unlock the folio, since we
> depend on this to hold on swapoff.

This is a great simplification on top of being a bug fix.

> So this patch moves all tree and entry usage to zswap_writeback_entry(),
> we only use the copied swpentry on the stack to allocate swap cache
> and return with folio locked, after which we can reference the tree.
> Then check invalidate race with tree lock, the following things is
> much the same like zswap_load().
> 
> Since we can't deref the entry after zswap_writeback_entry(), we
> can't use zswap_lru_putback() anymore, instead we rotate the entry
> in the LRU list so concurrent reclaimers have little chance to see it.
> Or it will be deleted from LRU list if writeback success.
>
> Another confusing part to me is the update of memcg nr_zswap_protected
> in zswap_lru_putback(). I'm not sure why it's needed here since
> if we raced with swapin, memcg nr_zswap_protected has already been
> updated in zswap_folio_swapin(). So not include this part for now.

Good observation.

Technically, it could also fail on -ENOMEM, but in practice these size
allocations don't fail, especially since the shrinker runs in
PF_MEMALLOC context. The shrink_worker might be affected, since it
doesn't But the common case is -EEXIST, which indeed double counts.

To make it "correct", you'd have to grab an objcg reference with the
LRU lock, and also re-order the objcg put on entry freeing after the
LRU del. This is probably not worth doing. But it could use a comment.

I was going to ask if you could reorder objcg uncharging after LRU
deletion to make it more robust for future changes in that direction.
However, staring at this, I notice this is a second UAF bug:

	if (entry->objcg) {
		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
		obj_cgroup_put(entry->objcg);
	}
	if (!entry->length)
		atomic_dec(&zswap_same_filled_pages);
	else {
		zswap_lru_del(&entry->pool->list_lru, entry);

zswap_lru_del() uses entry->objcg to determine the list_lru memcg, but
the put may have killed it. I'll send a separate patch on top.

> @@ -860,40 +839,34 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>  {
>  	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
>  	bool *encountered_page_in_swapcache = (bool *)arg;
> -	struct zswap_tree *tree;
> -	pgoff_t swpoffset;
> +	swp_entry_t swpentry;
>  	enum lru_status ret = LRU_REMOVED_RETRY;
>  	int writeback_result;
>  
> +	/*
> +	 * First rotate to the tail of lru list before unlocking lru lock,
> +	 * so the concurrent reclaimers have little chance to see it.
> +	 * It will be deleted from the lru list if writeback success.
> +	 */
> +	list_move_tail(item, &l->list);

We don't hold a reference to the object, so there could also be an
invalidation waiting on the LRU lock, which will free the entry even
when writeback fails.

It would also be good to expand on the motivation, because it's not
clear WHY you'd want to hide it from other reclaimers.

Lastly, maybe mention the story around temporary failures? Most
shrinkers have a lock inversion pattern (object lock -> LRU lock for
linking versus LRU lock -> object trylock during reclaim) that can
fail and require the same object be tried again before advancing.

How about this?

	/*
	 * Rotate the entry to the tail before unlocking the LRU,
	 * so that in case of an invalidation race concurrent
	 * reclaimers don't waste their time on it.
	 *
	 * If writeback succeeds, or failure is due to the entry
	 * being invalidated by the swap subsystem, the invalidation
	 * will unlink and free it.
	 *
	 * Temporary failures, where the same entry should be tried
	 * again immediately, almost never happen for this shrinker.
	 * We don't do any trylocking; -ENOMEM comes closest,
	 * but that's extremely rare and doesn't happen spuriously
	 * either. Don't bother distinguishing this case.
	 *
	 * But since they do exist in theory, the entry cannot just
	 * be unlinked, or we could leak it. Hence, rotate.
	 */

Otherwise, looks great to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

