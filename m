Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26D7A76BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjITJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjITI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:59:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8A710E4;
        Wed, 20 Sep 2023 01:59:06 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RrC6V0PwWzMlc0;
        Wed, 20 Sep 2023 16:55:30 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 20 Sep
 2023 16:59:04 +0800
Subject: Re: [PATCH net-next v8 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <brouer@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230912083126.65484-1-linyunsheng@huawei.com>
 <20230912083126.65484-2-linyunsheng@huawei.com>
 <84282e55-519c-0e17-30c5-b6de54d1001c@redhat.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <15f95505-dba9-4afd-6980-5bdf0a64d507@huawei.com>
Date:   Wed, 20 Sep 2023 16:59:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <84282e55-519c-0e17-30c5-b6de54d1001c@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/15 16:28, Jesper Dangaard Brouer wrote:
> Hi Lin,
> 
> This looks reasonable, but given you are changing struct-page
> (include/linux/mm_types.h) we need to MM-list <linux-mm@kvack.org>.
> Also Cc Wilcox.
> 
> I think it was Ilias and Duyck that validated the assumptions, last time
> this patch was discussed. Thus I want to see their review before this is
> applied.

FWIW, PAGE_SIZE aligned buffer being PAGE_SIZE aligned in DMA is
validated by Duyck:
https://lore.kernel.org/all/CAKgT0UfeUAUQpEffxnkc+gzXsjOrHkuMgxU_Aw0VXSJYKzaovQ@mail.gmail.com/

And I had done researching to find out there seems to be no combination of
the above arch with an address space >16TB:
https://lore.kernel.org/all/2b570282-24f8-f23b-1ff7-ad836794baa9@huawei.com/

> 
> -Jesper
> 
> On 12/09/2023 10.31, Yunsheng Lin wrote:
>> Currently page_pool_alloc_frag() is not supported in 32-bit
>> arch with 64-bit DMA because of the overlap issue between
>> pp_frag_count and dma_addr_upper in 'struct page' for those
>> arches, which seems to be quite common, see [1], which means
>> driver may need to handle it when using frag API.
>>
>> It is assumed that the combination of the above arch with an
>> address space >16TB does not exist, as all those arches have
>> 64b equivalent, it seems logical to use the 64b version for a
>> system with a large address space. It is also assumed that dma
>> address is page aligned when we are dma mapping a page aliged
>> buffer, see [2].
>>
>> That means we're storing 12 bits of 0 at the lower end for a
>> dma address, we can reuse those bits for the above arches to
>> support 32b+12b, which is 16TB of memory.
>>
>> If we make a wrong assumption, a warning is emitted so that
>> user can report to us.
>>
>> 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/
>> 2. https://lore.kernel.org/all/20230818145145.4b357c89@kernel.org/
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> CC: Lorenzo Bianconi <lorenzo@kernel.org>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> CC: Liang Chen <liangchen.linux@gmail.com>
>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
>> CC: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
>>   include/linux/mm_types.h        | 13 +------------
>>   include/net/page_pool/helpers.h | 20 ++++++++++++++------
>>   net/core/page_pool.c            | 14 +++++++++-----
>>   3 files changed, 24 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 36c5b43999e6..74b49c4c7a52 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -125,18 +125,7 @@ struct page {
>>               struct page_pool *pp;
>>               unsigned long _pp_mapping_pad;
>>               unsigned long dma_addr;
>> -            union {
>> -                /**
>> -                 * dma_addr_upper: might require a 64-bit
>> -                 * value on 32-bit architectures.
>> -                 */
>> -                unsigned long dma_addr_upper;
>> -                /**
>> -                 * For frag page support, not supported in
>> -                 * 32-bit architectures with 64-bit DMA.
>> -                 */
>> -                atomic_long_t pp_frag_count;
>> -            };
>> +            atomic_long_t pp_frag_count;
>>           };
>>           struct {    /* Tail pages of compound page */
>>               unsigned long compound_head;    /* Bit zero is set */
>> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
>> index 94231533a369..8e1c85de4995 100644
>> --- a/include/net/page_pool/helpers.h
>> +++ b/include/net/page_pool/helpers.h
>> @@ -197,7 +197,7 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>>       page_pool_put_full_page(pool, page, true);
>>   }
>>   -#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT    \
>> +#define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA    \
>>           (sizeof(dma_addr_t) > sizeof(unsigned long))
>>     /**
>> @@ -211,17 +211,25 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>>   {
>>       dma_addr_t ret = page->dma_addr;
>>   -    if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
>> -        ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
>> +    if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
>> +        ret <<= PAGE_SHIFT;
>>         return ret;
>>   }
>>   -static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>> +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>>   {
>> +    if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
>> +        page->dma_addr = addr >> PAGE_SHIFT;
>> +
>> +        /* We assume page alignment to shave off bottom bits,
>> +         * if this "compression" doesn't work we need to drop.
>> +         */
>> +        return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
>> +    }
>> +
>>       page->dma_addr = addr;
>> -    if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
>> -        page->dma_addr_upper = upper_32_bits(addr);
>> +    return false;
>>   }
>>     static inline bool page_pool_put(struct page_pool *pool)
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 77cb75e63aca..8a9868ea5067 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -211,10 +211,6 @@ static int page_pool_init(struct page_pool *pool,
>>            */
>>       }
>>   -    if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
>> -        pool->p.flags & PP_FLAG_PAGE_FRAG)
>> -        return -EINVAL;
>> -
>>   #ifdef CONFIG_PAGE_POOL_STATS
>>       pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>>       if (!pool->recycle_stats)
>> @@ -359,12 +355,20 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>>       if (dma_mapping_error(pool->p.dev, dma))
>>           return false;
>>   -    page_pool_set_dma_addr(page, dma);
>> +    if (page_pool_set_dma_addr(page, dma))
>> +        goto unmap_failed;
>>         if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>>           page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>>         return true;
>> +
>> +unmap_failed:
>> +    WARN_ON_ONCE("unexpected DMA address, please report to netdev@");
>> +    dma_unmap_page_attrs(pool->p.dev, dma,
>> +                 PAGE_SIZE << pool->p.order, pool->p.dma_dir,
>> +                 DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
>> +    return false;
>>   }
>>     static void page_pool_set_pp_info(struct page_pool *pool,
> 
> .
> 
