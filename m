Return-Path: <linux-kernel+bounces-54180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 000D584ABF5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A11A1F22D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AFC56B62;
	Tue,  6 Feb 2024 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LV73bJJY"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD05677B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185249; cv=none; b=f7x7ekVxI2GleR5V21DFRtCrQ7N/LcYOzio0AK4bXbw6C8rWN/5U1MEzHwbSi3QHCHkCyDV9hbvHIwV7woxjwbYkpd2A/ULMx4xDTty7TN1Wk4KrSPzGfD1hX0t1uWBO9yygFDmYgQxcJ1txgl/++0LqitbyfPeLr3iNfTUAXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185249; c=relaxed/simple;
	bh=mqZDvLVTP8VLg8Z0roufiMafcQM1Hvn1MKVhNCmazPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1nd8Hk9NG7ezoGVTHr5Iy15GWqLnbHZBydpBZalHeCbkL8dOHL/ipLdxAfjuZ9oAM1CZ0emQUtT6xVxlrdEC0hTb9SHgw04Bke4DJV9riyrY6+cl0w8VO9O/0Jl6+Je5q1+9fJNb9t7a486kPTwa9KOFQ4I6CuEQNwCFcHvkos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LV73bJJY; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <38dae4da-7afe-4405-9545-294efc18fb8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707185245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eIJijInYFu0cUG/tmLajV3LIHwabmz8bTWiDitWtQ+k=;
	b=LV73bJJYq+BC3YGCCBAWgfDKtcFLErH41Ml9O9zbPiFRre+qDKQcXllfi1XubWXUBEvFDH
	KwuK1d1z4y8kBULaXqi8ehf+wTFSQwz4MmtNl/FK+QWr/hw+o+72dUCpbYpwbyoXfze0tm
	NmFxfyNHo1Qf/tEcRKhOcVB7M0Kmu90=
Date: Tue, 6 Feb 2024 10:07:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/swap_state: update zswap LRU's protection range with
 the folio locked
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <20240205232442.3240571-1-nphamcs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240205232442.3240571-1-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/6 07:24, Nhat Pham wrote:
> Move the zswap LRU protection range update above the swap_read_folio()
> call, and only when a new page is allocated. This is the case where
> (z)swapin could happen, which is a signal that the zswap shrinker should
> be more conservative with its reclaiming action.
> 
> It also prevents a race, in which folio migration can clear the
> memcg_data of the now unlocked folio, resulting in a warning in the
> inlined folio_lruvec() call.
> 
> Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000ae47f90610803260@google.com/
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

LGTM, thanks!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/swap_state.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
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
> 
> base-commit: 91f3daa1765ee4e0c89987dc25f72c40f07af34d

