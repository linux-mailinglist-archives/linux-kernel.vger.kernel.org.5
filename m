Return-Path: <linux-kernel+bounces-115264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F1889B07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B0A2A2147
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648FE12C7FE;
	Mon, 25 Mar 2024 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YNwn7HpM"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CF2BC60D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324908; cv=none; b=Ws4MemZXf9ryAvC2VUTax4Leqw6dSciN/i0dk7OCNZZlqDDkI7gfVclv0Wy5tZ9U0GhZqb6nllWCvHEkrFcQo8LRtERQB635YrW9yNdhxGBjQxjNs9adMhOCj3Y1OEx7F5lCYssD57lDN+eqWNNQAgIqAmxhXeJqrPg6PXyRrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324908; c=relaxed/simple;
	bh=aCEqBcnQ1M3aL4PZqiCWwY0AYWwbtDQp1WxPKatYQ2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slrjgEE9sfR7kW2/TX1LoBAR6lAvlCsKeka34RjdfaUBVaUx9VLEiWXIfNDr5SbTess1WtIQETqzzsvO3IMwoZrzQD3ktfy4phTzmJTG2s2MHFTOUVHdUQBXkT3i6xOni58xPod/e/fwpH0oY05jakj5eZf7bxmnZqNfwX33/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YNwn7HpM; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc4481a6-37f9-4648-bcf7-44f54a737523@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711324901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qe6xqHSlnnr+98KLEqZDrt/HGpOBcW/zRiJgat60DCo=;
	b=YNwn7HpM3USRSh+6cv0pYoNd+E6X22pLWZxAk1qdUSCMbNjj3+ZMFHvErjXOWrCKfxhYT9
	ds/+KKk1H6bHCdfhYMxrsvP+4B1lwIDVeJmPx0f+RxERmAoypc4cdeGAIRNxEo9hTeDUeu
	9pp3awR/frB0uEjRnve1WQMeGHY9O7c=
Date: Mon, 25 Mar 2024 08:01:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 Yosry Ahmed <yosryahmed@google.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240324210447.956973-1-hannes@cmpxchg.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240324210447.956973-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/25 05:04, Johannes Weiner wrote:
> Zhongkun He reports data corruption when combining zswap with zram.
> 
> The issue is the exclusive loads we're doing in zswap. They assume
> that all reads are going into the swapcache, which can assume
> authoritative ownership of the data and so the zswap copy can go.
> 
> However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try
> to bypass the swapcache. This results in an optimistic read of the
> swap data into a page that will be dismissed if the fault fails due to
> races. In this case, zswap mustn't drop its authoritative copy.
> 
> Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=zV9P691B9bVq33erwOXNTmEaUbi9DrDeJzw@mail.gmail.com/
> Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> Cc: stable@vger.kernel.org	[6.5+]
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>

Very nice solution!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/zswap.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 535c907345e0..41a1170f7cfe 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
>  	swp_entry_t swp = folio->swap;
>  	pgoff_t offset = swp_offset(swp);
>  	struct page *page = &folio->page;
> +	bool swapcache = folio_test_swapcache(folio);
>  	struct zswap_tree *tree = swap_zswap_tree(swp);
>  	struct zswap_entry *entry;
>  	u8 *dst;
> @@ -1634,7 +1635,20 @@ bool zswap_load(struct folio *folio)
>  		spin_unlock(&tree->lock);
>  		return false;
>  	}
> -	zswap_rb_erase(&tree->rbroot, entry);
> +	/*
> +	 * When reading into the swapcache, invalidate our entry. The
> +	 * swapcache can be the authoritative owner of the page and
> +	 * its mappings, and the pressure that results from having two
> +	 * in-memory copies outweighs any benefits of caching the
> +	 * compression work.
> +	 *
> +	 * (Most swapins go through the swapcache. The notable
> +	 * exception is the singleton fault on SWP_SYNCHRONOUS_IO
> +	 * files, which reads into a private page and may free it if
> +	 * the fault fails. We remain the primary owner of the entry.)
> +	 */
> +	if (swapcache)
> +		zswap_rb_erase(&tree->rbroot, entry);
>  	spin_unlock(&tree->lock);
>  
>  	if (entry->length)
> @@ -1649,9 +1663,10 @@ bool zswap_load(struct folio *folio)
>  	if (entry->objcg)
>  		count_objcg_event(entry->objcg, ZSWPIN);
>  
> -	zswap_entry_free(entry);
> -
> -	folio_mark_dirty(folio);
> +	if (swapcache) {
> +		zswap_entry_free(entry);
> +		folio_mark_dirty(folio);
> +	}
>  
>  	return true;
>  }


