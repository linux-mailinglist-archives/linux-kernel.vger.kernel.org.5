Return-Path: <linux-kernel+bounces-56399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5970784C9B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE69B2645C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7798E1B7F4;
	Wed,  7 Feb 2024 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RyHYWm9R"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D91D532;
	Wed,  7 Feb 2024 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305783; cv=none; b=DG88QzGLhi/9ne1sVQ9FdJumBmtwwWC7WddVxtptWg5HgwLZYi+eoJR0K3/Kq2IbvomLiPIyf5AbdfCm0r687Bp9aW5ezQU+hvwbCb8kriIL24gJdqQHS9Y5mskab2C6lVE/PXRmwzPx4bkQzPmz/+y7DYDJSxo9E1PAOt9REwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305783; c=relaxed/simple;
	bh=y2qgN8MJm856AbPLVRHw2w4AuCKAtkRx0CO7coFhoIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBrK2dTzhZIrgbNqCFT1uwx/fmZfUlIYa/L9NTfzhIPTuPcirs+Ve9Y7EO3iZRA149+2IPYsJzDshKCJJKj3FGOD9Yoisn1WrhE5HsIwI9kX/6TyBJmIUqQtiINYp/34D2m6C1cjRiMjklPV7wCcj3joKAqqFex0sGKGMe6Yrv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RyHYWm9R; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c289c094-6440-49dc-b7cd-09c0f49da1f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707305779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwYC5Iw0QVlv46eQ3xV5uqeU2c0WlPeQhqg/YeYM5W8=;
	b=RyHYWm9Rq12CQe3E+U+/nAMYv2rW2Ysz9pKaVvq2bqBISZiYgUBMn6/YkIO3lAOiNcTHAY
	CHJLgcu93mBOQmQ2YgtzDyYAFZIuIxVyhDTKXQ+0blnsdZBDD+nUPkB/Yxeu9gglxuJMqN
	+68AeJPM3kWV0mcSfzaRwsdH7IOg+VU=
Date: Wed, 7 Feb 2024 19:36:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm/zswap: invalidate old entry when store fail or
 !zswap_enabled
Content-Language: en-US
To: hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org
References: <20240207033857.3820921-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240207033857.3820921-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/7 11:38, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We may encounter duplicate entry in the zswap_store():
> 
> 1. swap slot that freed to per-cpu swap cache, doesn't invalidate
>    the zswap entry, then got reused. This has been fixed.
> 
> 2. !exclusive load mode, swapin folio will leave its zswap entry
>    on the tree, then swapout again. This has been removed.
> 
> 3. one folio can be dirtied again after zswap_store(), so need to
>    zswap_store() again. This should be handled correctly.
> 
> So we must invalidate the old duplicate entry before insert the
> new one, which actually doesn't have to be done at the beginning
> of zswap_store(). And this is a normal situation, we shouldn't
> WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
> to detect swap entry UAF problem? But not very necessary here.)
> 
> The good point is that we don't need to lock tree twice in the
> store success path.
> 
> Note we still need to invalidate the old duplicate entry in the
> store failure path, otherwise the new data in swapfile could be
> overwrite by the old data in zswap pool when lru writeback.
> 
> We have to do this even when !zswap_enabled since zswap can be
> disabled anytime. If the folio store success before, then got
> dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store(). So later lru writeback
> may overwrite the new data in swapfile.
> 
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Cc: <stable@vger.kernel.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v3:
>  - Fix a few grammatical problems in comments, per Yosry.
> 
> v2:
>  - Change the duplicate entry invalidation loop to if, since we hold
>    the lock, we won't find it once we invalidate it, per Yosry.
>  - Add Fixes tag.
> ---
>  mm/zswap.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index cd67f7f6b302..d9d8947d6761 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1518,18 +1518,8 @@ bool zswap_store(struct folio *folio)
>  		return false;
>  
>  	if (!zswap_enabled)
> -		return false;
> +		goto check_old;
>  
> -	/*
> -	 * If this is a duplicate, it must be removed before attempting to store
> -	 * it, otherwise, if the store fails the old page won't be removed from
> -	 * the tree, and it might be written back overriding the new data.
> -	 */
> -	spin_lock(&tree->lock);
> -	entry = zswap_rb_search(&tree->rbroot, offset);
> -	if (entry)
> -		zswap_invalidate_entry(tree, entry);
> -	spin_unlock(&tree->lock);
>  	objcg = get_obj_cgroup_from_folio(folio);
>  	if (objcg && !obj_cgroup_may_zswap(objcg)) {
>  		memcg = get_mem_cgroup_from_objcg(objcg);
> @@ -1608,14 +1598,12 @@ bool zswap_store(struct folio *folio)
>  	/* map */
>  	spin_lock(&tree->lock);
>  	/*
> -	 * A duplicate entry should have been removed at the beginning of this
> -	 * function. Since the swap entry should be pinned, if a duplicate is
> -	 * found again here it means that something went wrong in the swap
> -	 * cache.
> +	 * The folio may have been dirtied again, invalidate the
> +	 * possibly stale entry before inserting the new entry.
>  	 */
> -	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> -		WARN_ON(1);
> +	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
>  		zswap_invalidate_entry(tree, dupentry);
> +		VM_WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));

Oh, I just realized this is empty if !CONFIG_DEBUG_VM, will post v4.

Thanks.

>  	}
>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
> @@ -1638,6 +1626,17 @@ bool zswap_store(struct folio *folio)
>  reject:
>  	if (objcg)
>  		obj_cgroup_put(objcg);
> +check_old:
> +	/*
> +	 * If the zswap store fails or zswap is disabled, we must invalidate the
> +	 * possibly stale entry which was previously stored at this offset.
> +	 * Otherwise, writeback could overwrite the new data in the swapfile.
> +	 */
> +	spin_lock(&tree->lock);
> +	entry = zswap_rb_search(&tree->rbroot, offset);
> +	if (entry)
> +		zswap_invalidate_entry(tree, entry);
> +	spin_unlock(&tree->lock);
>  	return false;
>  
>  shrink:

