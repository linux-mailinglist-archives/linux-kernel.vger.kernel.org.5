Return-Path: <linux-kernel+bounces-125726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98698892B3A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB252831F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73E4208CA;
	Sat, 30 Mar 2024 12:41:36 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED71C0DFD;
	Sat, 30 Mar 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711802496; cv=none; b=LGmwZNFXyCCsqWnLR4pjHJOk+gQm4hrUh+SxA5w+zR/HODre8mfihPKwWy3zer3udQ+6bjabYjRp8oAIeXh7kxaXajQ2DwsmeDW90oIwsO+gzg3qWCKOV0FuODyROel8ZBy20IA9R6JnrJhvAfUAxMxHK+FqpgA0zbmnpFOgmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711802496; c=relaxed/simple;
	bh=Q/Ts2ZkLLxwryuuyznDOCeo07lzHRru1XTR0ifhcknc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QeXbyu+JQ15TkWwMTJpSj5/Y9CCwKD2LdYGqMe33m41PSpZ6P/rS+lU864GSBvUsuw1dJg+25WOSyisI35iXTaN4pWZR3RW7qO85WrnMgp0dIoIOeYdCmtJSQmqjaLc6aZphtVppbhr7Mvkv0CVTNMIR3YwPUsJbFuONoDlMwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V6H084bcpzNmfB;
	Sat, 30 Mar 2024 20:39:20 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id DE05E140156;
	Sat, 30 Mar 2024 20:41:24 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 30 Mar
 2024 20:41:24 +0800
Subject: Re: [PATCH net-next 1/2] page_pool: check for PP direct cache
 locality later
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240329165507.3240110-1-aleksander.lobakin@intel.com>
 <20240329165507.3240110-2-aleksander.lobakin@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5699d031-d6d2-9cae-7025-2589eb60c0a0@huawei.com>
Date: Sat, 30 Mar 2024 20:41:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240329165507.3240110-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/3/30 0:55, Alexander Lobakin wrote:
> Since we have pool->p.napi (Jakub) and pool->cpuid (Lorenzo) to check
> whether it's safe to use direct recycling, we can use both globally for
> each page instead of relying solely on @allow_direct argument.
> Let's assume that @allow_direct means "I'm sure it's local, don't waste
> time rechecking this" and when it's false, try the mentioned params to
> still recycle the page directly. If neither is true, we'll lose some
> CPU cycles, but then it surely won't be hotpath. On the other hand,
> paths where it's possible to use direct cache, but not possible to
> safely set @allow_direct, will benefit from this move.
> The whole propagation of @napi_safe through a dozen of skb freeing
> functions can now go away, which saves us some stack space.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/skbuff.h | 12 ++++----
>  net/core/page_pool.c   | 31 +++++++++++++++++--
>  net/core/skbuff.c      | 70 +++++++++++++-----------------------------
>  net/ipv4/esp4.c        |  2 +-
>  net/ipv6/esp6.c        |  2 +-
>  5 files changed, 58 insertions(+), 59 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index dadd3f55d549..f7f6e42c6814 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3515,25 +3515,25 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
>  		    unsigned int headroom);
>  int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
>  			 struct bpf_prog *prog);
> -bool napi_pp_put_page(struct page *page, bool napi_safe);
> +bool napi_pp_put_page(struct page *page);
>  
>  static inline void
> -skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
> +skb_page_unref(const struct sk_buff *skb, struct page *page)
>  {
>  #ifdef CONFIG_PAGE_POOL
> -	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
> +	if (skb->pp_recycle && napi_pp_put_page(page))
>  		return;
>  #endif
>  	put_page(page);
>  }
>  
>  static inline void
> -napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> +napi_frag_unref(skb_frag_t *frag, bool recycle)
>  {
>  	struct page *page = skb_frag_page(frag);
>  
>  #ifdef CONFIG_PAGE_POOL
> -	if (recycle && napi_pp_put_page(page, napi_safe))
> +	if (recycle && napi_pp_put_page(page))
>  		return;
>  #endif
>  	put_page(page);
> @@ -3549,7 +3549,7 @@ napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
>   */
>  static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
>  {
> -	napi_frag_unref(frag, recycle, false);
> +	napi_frag_unref(frag, recycle);
>  }
>  
>  /**
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index dd364d738c00..9d56257e444b 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -690,8 +690,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>  			page_pool_dma_sync_for_device(pool, page,
>  						      dma_sync_size);
>  
> -		if (allow_direct && in_softirq() &&
> -		    page_pool_recycle_in_cache(page, pool))
> +		if (allow_direct && page_pool_recycle_in_cache(page, pool))
>  			return NULL;
>  
>  		/* Page found as candidate for recycling */
> @@ -716,9 +715,35 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>  	return NULL;
>  }
>  
> +static bool page_pool_napi_local(const struct page_pool *pool)
> +{
> +	const struct napi_struct *napi;
> +	u32 cpuid;
> +
> +	if (unlikely(!in_softirq()))
> +		return false;
> +
> +	/* Allow direct recycle if we have reasons to believe that we are
> +	 * in the same context as the consumer would run, so there's
> +	 * no possible race.
> +	 * __page_pool_put_page() makes sure we're not in hardirq context
> +	 * and interrupts are enabled prior to accessing the cache.
> +	 */
> +	cpuid = smp_processor_id();
> +	if (READ_ONCE(pool->cpuid) == cpuid)
> +		return true;
> +
> +	napi = READ_ONCE(pool->p.napi);
> +
> +	return napi && READ_ONCE(napi->list_owner) == cpuid;
> +}
> +
>  void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
>  				unsigned int dma_sync_size, bool allow_direct)
>  {
> +	if (!allow_direct)

It seems we are changing some semantics here, in_softirq() is checked
even if allow_direct is true before this patch. And it seems in_softirq()
is not checked if allow_direct is true after this patch? I think we might
need some assertion to ensure @allow_direct really means "I'm sure it's
local, don't waste time rechecking this". As my understanding, it is really
hard to debug this kind of problem, so in_softirq() is always checking.

Perhaps add something like WARN_ONCE() or DEBUG_NET_WARN_ON_ONCE for
allow_direct being true case to catch the API misuse?

> +		allow_direct = page_pool_napi_local(pool);
> +
>  	page = __page_pool_put_page(pool, page, dma_sync_size, allow_direct);
>  	if (page && !page_pool_recycle_in_ring(pool, page)) {
>  		/* Cache full, fallback to free pages */
> @@ -969,7 +994,7 @@ void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
>  static void page_pool_disable_direct_recycling(struct page_pool *pool)
>  {
>  	/* Disable direct recycling based on pool->cpuid.
> -	 * Paired with READ_ONCE() in napi_pp_put_page().
> +	 * Paired with READ_ONCE() in page_pool_napi_local().
>  	 */
>  	WRITE_ONCE(pool->cpuid, -1);
>  


