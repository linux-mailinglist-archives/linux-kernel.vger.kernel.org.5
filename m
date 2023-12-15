Return-Path: <linux-kernel+bounces-835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DA8146DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37461C21D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096E24B4A;
	Fri, 15 Dec 2023 11:27:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174EE14F87;
	Fri, 15 Dec 2023 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ss61m2ykFz1Q6dq;
	Fri, 15 Dec 2023 19:09:48 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id C05F718006C;
	Fri, 15 Dec 2023 19:09:58 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Dec
 2023 19:09:58 +0800
Subject: Re: [PATCH net-next] page_pool: Rename frag_users to frag_cnt
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
References: <20231215073119.543560-1-ilias.apalodimas@linaro.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6fddeb22-0906-e04c-3a84-7836bef9ffa2@huawei.com>
Date: Fri, 15 Dec 2023 19:09:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231215073119.543560-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2023/12/15 15:31, Ilias Apalodimas wrote:
> Since [0] got merged, it's clear that 'pp_ref_count' is used to track
> the number of users for each page. On struct_page though we have
> a member called 'frag_users'. Despite of what the name suggests this is
> not the number of users. It instead represents the number of fragments of
> the current page. When we have a single page this is set to one. When we
> split the page this is set to the actual number of frags and later used
> in page_pool_drain_frag() to infer the real number of users.
> 
> So let's rename it to something that matches the description above
> 
> [0]
> Link: https://lore.kernel.org/netdev/20231212044614.42733-2-liangchen.linux@gmail.com/
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  include/net/page_pool.h | 2 +-
>  net/core/page_pool.c    | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 813c93499f20..957cd84bb3f4 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -158,7 +158,7 @@ struct page_pool {
>  	u32 pages_state_hold_cnt;
>  	unsigned int frag_offset;
>  	struct page *frag_page;
> -	long frag_users;
> +	long frag_cnt;

I would rename it to something like refcnt_bais to mirror the pagecnt_bias
in struct page_frag_cache.

> 
>  #ifdef CONFIG_PAGE_POOL_STATS
>  	/* these stats are incremented while in softirq context */
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 9b203d8660e4..19a56a52ac8f 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -659,7 +659,7 @@ EXPORT_SYMBOL(page_pool_put_page_bulk);
>  static struct page *page_pool_drain_frag(struct page_pool *pool,
>  					 struct page *page)
>  {
> -	long drain_count = BIAS_MAX - pool->frag_users;
> +	long drain_count = BIAS_MAX - pool->frag_cnt;

drain_count = pool->refcnt_bais;

or

remove it and use pool->refcnt_bais directly.

> 
>  	/* Some user is still using the page frag */
>  	if (likely(page_pool_defrag_page(page, drain_count)))
> @@ -678,7 +678,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
> 
>  static void page_pool_free_frag(struct page_pool *pool)
>  {
> -	long drain_count = BIAS_MAX - pool->frag_users;
> +	long drain_count = BIAS_MAX - pool->frag_cnt;

Same here.

>  	struct page *page = pool->frag_page;
> 
>  	pool->frag_page = NULL;
> @@ -721,14 +721,14 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
>  		pool->frag_page = page;
> 
>  frag_reset:
> -		pool->frag_users = 1;
> +		pool->frag_cnt = 1;

pool->refcnt_bais = BIAS_MAX - 1;

>  		*offset = 0;
>  		pool->frag_offset = size;
>  		page_pool_fragment_page(page, BIAS_MAX);
>  		return page;
>  	}
> 
> -	pool->frag_users++;
> +	pool->frag_cnt++;

pool->refcnt_bais--;

>  	pool->frag_offset = *offset + size;
>  	alloc_stat_inc(pool, fast);
>  	return page;
> --
> 2.37.2
> 
> .
> 

