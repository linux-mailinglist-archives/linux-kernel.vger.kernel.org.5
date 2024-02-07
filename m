Return-Path: <linux-kernel+bounces-55878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697D84C2E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DF91F292E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32120FC0E;
	Wed,  7 Feb 2024 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pYQu4DVc"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C84FBEB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275047; cv=none; b=WZrN+iyChJCSVX2Lfi/xh8KJpns/PAXpmkmY7h86peJFDA9FnvRu+1J2T5mVevBBls0xjB6nqSzyFEnQmpC2jCmT2cbj0ZXFRoZNhY9lSCRA75yt7rjKl0Gq2jN/UTfL71oZOVxryIkeFt4h6+z4ZxdGgFNDg9Bh7xa5rZ0v9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275047; c=relaxed/simple;
	bh=v2ohjd1tPfCEYNoxFhZMJKuSM6tGRgHypJKq9edkKe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qejRRXr0+7bUbqgBqI+r0S+95WndMRGl2RJqJomn99lrfPoEFF0A8SH1N0DBceYpezM2d8dPQaY0uI8F51f5i5GzKknj7MXvUfv79T9DLIPTDXLCY79ncQismrIL4LR7rr8Inne0vMAJjaIr+C/lIORLRQjcJSnoe5giMJOhqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pYQu4DVc; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1956a3ac-fad2-46bc-b6d6-66f9ba334528@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707275044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aodKCO9SzZpERllHyASlIPFj8T1P/bqIO8tH069pJpo=;
	b=pYQu4DVc//xTINNAc+DeiXcMugmjLMddIiqIZLiMw/wvfgOYa0lKhqRopIqnA1kRUDV2Pn
	DHtfEsF9S30YcT4xO2FgTnFnBAdCWB+rSC0w6E0Mvi7cZEHViCyVPVQtRECzcCcPo6k3bn
	eMDS7+5sQUMqI2RWS2h2tqOohd+AjTs=
Date: Wed, 7 Feb 2024 11:03:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/swap_state: update zswap LRU's protection range
 with the folio locked
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <20240206180855.3987204-1-nphamcs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240206180855.3987204-1-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/7 02:08, Nhat Pham wrote:
> When a folio is swapped in, the protection size of the corresponding
> zswap LRU is incremented, so that the zswap shrinker is more
> conservative with its reclaiming action. This field is embedded within
> the struct lruvec, so updating it requires looking up the folio's memcg
> and lruvec. However, currently this lookup can happen after the folio is
> unlocked, for instance if a new folio is allocated, and
> swap_read_folio() unlocks the folio before returning. In this scenario,
> there is no stability guarantee for the binding between a folio and its
> memcg and lruvec:
> 
> * A folio's memcg and lruvec can be freed between the lookup and the
>   update, leading to a UAF.
> * Folio migration can clear the now-unlocked folio's memcg_data, which
>   directs the zswap LRU protection size update towards the root memcg
>   instead of the original memcg. This was recently picked up by the
>   syzbot thanks to a warning in the inlined folio_lruvec() call.
> 
> Move the zswap LRU protection range update above the swap_read_folio()
> call, and only when a new page is allocated, to prevent this.
> 
> Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000ae47f90610803260@google.com/
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

LGTM, thanks!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/swap_state.c | 10 ++++++----
>  mm/zswap.c      |  1 +
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index e671266ad772..7255c01a1e4e 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -680,9 +680,10 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	/* The page was likely read above, so no need for plugging here */
>  	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
>  					&page_allocated, false);
> -	if (unlikely(page_allocated))
> +	if (unlikely(page_allocated)) {
> +		zswap_folio_swapin(folio);
>  		swap_read_folio(folio, false, NULL);
> -	zswap_folio_swapin(folio);
> +	}
>  	return folio;
>  }
>  
> @@ -855,9 +856,10 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  	/* The folio was likely read above, so no need for plugging here */
>  	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
>  					&page_allocated, false);
> -	if (unlikely(page_allocated))
> +	if (unlikely(page_allocated)) {
> +		zswap_folio_swapin(folio);
>  		swap_read_folio(folio, false, NULL);
> -	zswap_folio_swapin(folio);
> +	}
>  	return folio;
>  }
>  
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 4aea03285532..8c548f73d52e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -827,6 +827,7 @@ void zswap_folio_swapin(struct folio *folio)
>  	struct lruvec *lruvec;
>  
>  	if (folio) {
> +		VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  		lruvec = folio_lruvec(folio);
>  		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
>  	}
> 
> base-commit: 91f3daa1765ee4e0c89987dc25f72c40f07af34d

