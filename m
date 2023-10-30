Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149837DB628
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjJ3Jbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjJ3Jbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:31:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80D8C6;
        Mon, 30 Oct 2023 02:31:28 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SJnvn0FsDzvQJQ;
        Mon, 30 Oct 2023 17:26:29 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 30 Oct
 2023 17:31:26 +0800
Subject: Re: [PATCH net] net: page_pool: add missing free_percpu when
 page_pool_init fail
To:     Jijie Shao <shaojijie@huawei.com>, <hawk@kernel.org>,
        <ilias.apalodimas@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jdamato@fastly.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231030091256.2915394-1-shaojijie@huawei.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <aca292af-025c-6034-29bf-cac7404effe2@huawei.com>
Date:   Mon, 30 Oct 2023 17:31:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20231030091256.2915394-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/30 17:12, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> When ptr_ring_init() returns failure in page_pool_init(), free_percpu()
> is not called to free pool->recycle_stats, which may cause memory
> leak.

LGTM.
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

> 
> Fixes: ad6fa1e1ab1b ("page_pool: Add recycle stats")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  net/core/page_pool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..31f923e7b5c4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -221,8 +221,12 @@ static int page_pool_init(struct page_pool *pool,
>  		return -ENOMEM;
>  #endif
>  
> -	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0)
> +	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
> +#ifdef CONFIG_PAGE_POOL_STATS
> +		free_percpu(pool->recycle_stats);
> +#endif
>  		return -ENOMEM;
> +	}
>  
>  	atomic_set(&pool->pages_state_release_cnt, 0);
>  
> 
