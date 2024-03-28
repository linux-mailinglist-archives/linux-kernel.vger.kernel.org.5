Return-Path: <linux-kernel+bounces-122569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3BE88F9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672471C2B86F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3254673;
	Thu, 28 Mar 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E4z2wUN7"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E054773
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613565; cv=none; b=RWiz8dY7FKoquLdh+GtBJDHEWfjlwIYs+5HpZ6nPcMgfk06nifwbKtR97Cxr7iWeP1KJUHsAS93/fIr4LYdQbKUO+bC5En9OI15o5WAG0BzQGlk692aqNc4fpVh0CzsYaJOjuY2SpqdgD6McVtJG2JoBwWCnjisJ6+CI1YglDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613565; c=relaxed/simple;
	bh=PFeWiLIAKM8JaPmrSFnV15YMIsPtkTmht+d/gq6PPKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxIQwkKeWnb7BKRLOz4G71Crnvlhv9ZuT0l7nuePwYR9cHlRjuPTcmf8myn9jxJZfAeJnCEDp5Xme2eBrx+8kP9AbK63imXkykwqXpwdqPp1R3P1fA2ET/thhwvFqKiOV1usuAk+C41XL452DFwJxhLxnlvrFmxk7PpuOKT4GkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E4z2wUN7; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <098bfa48-75d5-45b5-b81d-a2a84b394352@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711613559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+z86Nxu+WnBrjtSTW47HkgM2M7XmIhiMD7Mp8KdBeRU=;
	b=E4z2wUN7Sx3Tt3DqFMxB2tqqJACJcSfpHfhXm5Sonb0EWOesDfpI9WYWmmVmtcR2n6omSs
	QVjfIZUZoHljMcySgJHhu+52Tdn+uVmT3yuARaa3wsZ5hTlQBv3b07wsfOxKOiiLfoJXM0
	7ZgNghLmGreRRgQrZnP0Zbea29codik=
Date: Thu, 28 Mar 2024 16:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 7/9] mm: zswap: store zero-filled pages without a
 zswap_entry
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-8-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240325235018.2028408-8-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/26 07:50, Yosry Ahmed wrote:
> After the rbtree to xarray conversion, and dropping zswap_entry.refcount
> and zswap_entry.value, the only members of zswap_entry utilized by
> zero-filled pages are zswap_entry.length (always 0) and
> zswap_entry.objcg. Store the objcg pointer directly in the xarray as a
> tagged pointer and avoid allocating a zswap_entry completely for
> zero-filled pages.
> 
> This simplifies the code as we no longer need to special case
> zero-length cases. We are also able to further separate the zero-filled
> pages handling logic and completely isolate them within store/load
> helpers.  Handling tagged xarray pointers is handled in these two
> helpers, as well as the newly introduced helper for freeing tree
> elements, zswap_tree_free_element().
> 
> There is also a small performance improvement observed over 50 runs of
> kernel build test (kernbench) comparing the mean build time on a skylake
> machine when building the kernel in a cgroup v1 container with a 3G
> limit. This is on top of the improvement from dropping support for
> non-zero same-filled pages:
> 
> 		base            patched         % diff
> real            69.915          69.757		-0.229%
> user            2956.147        2955.244	-0.031%
> sys             2594.718        2575.747	-0.731%
> 
> This probably comes from avoiding the zswap_entry allocation and
> cleanup/freeing for zero-filled pages. Note that the percentage of
> zero-filled pages during this test was only around 1.5% on average.
> Practical workloads could have a larger proportion of such pages (e.g.
> Johannes observed around 10% [1]), so the performance improvement should
> be larger.
> 
> This change also saves a small amount of memory due to less allocated
> zswap_entry's. In the kernel build test above, we save around 2M of
> slab usage when we swap out 3G to zswap.
> 
> [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

The code looks good, just one comment below.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>  mm/zswap.c | 137 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 78 insertions(+), 59 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 413d9242cf500..efc323bab2f22 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -183,12 +183,11 @@ static struct shrinker *zswap_shrinker;
>   * struct zswap_entry
>   *
[..]
>  
> @@ -1531,26 +1552,27 @@ bool zswap_load(struct folio *folio)
>  	struct page *page = &folio->page;
>  	struct xarray *tree = swap_zswap_tree(swp);
>  	struct zswap_entry *entry;
> +	struct obj_cgroup *objcg;
> +	void *elem;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  
> -	entry = xa_erase(tree, offset);
> -	if (!entry)
> +	elem = xa_erase(tree, offset);
> +	if (!elem)
>  		return false;
>  
> -	if (entry->length)
> +	if (!zswap_load_zero_filled(elem, page, &objcg)) {
> +		entry = elem;

nit: entry seems no use anymore.

> +		objcg = entry->objcg;
>  		zswap_decompress(entry, page);
> -	else
> -		clear_highpage(page);
> +	}
>  
>  	count_vm_event(ZSWPIN);
> -	if (entry->objcg)
> -		count_objcg_event(entry->objcg, ZSWPIN);
> -
> -	zswap_entry_free(entry);
> +	if (objcg)
> +		count_objcg_event(objcg, ZSWPIN);
>  
> +	zswap_tree_free_element(elem);
>  	folio_mark_dirty(folio);
> -
>  	return true;
>  }
[..]

