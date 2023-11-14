Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8D97EB036
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjKNMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjKNMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:49:15 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4518B;
        Tue, 14 Nov 2023 04:49:10 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SV5ct2vmsz1P7cN;
        Tue, 14 Nov 2023 20:45:50 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 14 Nov
 2023 20:49:08 +0800
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     Mina Almasry <almasrymina@google.com>
CC:     Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com>
Date:   Tue, 14 Nov 2023 20:49:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/14 20:21, Mina Almasry wrote:
> On Tue, Nov 14, 2023 at 12:23 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> +cc Christian, Jason and Willy
>>
>> On 2023/11/14 7:05, Jakub Kicinski wrote:
>>> On Mon, 13 Nov 2023 05:42:16 -0800 Mina Almasry wrote:
>>>> You're doing exactly what I think you're doing, and what was nacked in RFC v1.
>>>>
>>>> You've converted 'struct page_pool_iov' to essentially become a
>>>> duplicate of 'struct page'. Then, you're casting page_pool_iov* into
>>>> struct page* in mp_dmabuf_devmem_alloc_pages(), then, you're calling
>>>> mm APIs like page_ref_*() on the page_pool_iov* because you've fooled
>>>> the mm stack into thinking dma-buf memory is a struct page.
>>
>> Yes, something like above, but I am not sure about the 'fooled the mm
>> stack into thinking dma-buf memory is a struct page' part, because:
>> 1. We never let the 'struct page' for devmem leaking out of net stacking
>>    through the 'not kmap()able and not readable' checking in your patchset.
> 
> RFC never used dma-buf pages outside the net stack, so that is the same.
> 
> You are not able to get rid of the 'net kmap()able and not readable'
> checking with this approach, because dma-buf memory is fundamentally
> unkmapable and unreadable. This approach would still need
> skb_frags_not_readable checks in net stack, so that is also the same.

Yes, I am agreed that checking is still needed whatever the proposal is.

> 
>> 2. We inititiate page->_refcount for devmem to one and it remains as one,
>>    we will never call page_ref_inc()/page_ref_dec()/get_page()/put_page(),
>>    instead, we use page pool's pp_frag_count to do reference counting for
>>    devmem page in patch 6.
>>
> 
> I'm not sure that moves the needle in terms of allowing dma-buf
> memory to look like struct pages.
> 
>>>>
>>>> RFC v1 was almost exactly the same, except instead of creating a
>>>> duplicate definition of struct page, it just allocated 'struct page'
>>>> instead of allocating another struct that is identical to struct page
>>>> and casting it into struct page.
>>
>> Perhaps it is more accurate to say this is something between RFC v1 and
>> RFC v3, in order to decouple 'struct page' for devmem from mm subsystem,
>> but still have most unified handling for both normal memory and devmem
>> in page pool and net stack.
>>
>> The main difference between this patchset and RFC v1:
>> 1. The mm subsystem is not supposed to see the 'struct page' for devmem
>>    in this patchset, I guess we could say it is decoupled from the mm
>>    subsystem even though we still call PageTail()/page_ref_count()/
>>    page_is_pfmemalloc() on 'struct page' for devmem.
>>
> 
> In this patchset you pretty much allocate a struct page for your
> dma-buf memory, and then cast it into a struct page, so all the mm
> calls in page_pool.c are seeing a struct page when it's really dma-buf
> memory.
> 
> 'even though we still call
> PageTail()/page_ref_count()/page_is_pfmemalloc() on 'struct page' for
> devmem' is basically making dma-buf memory look like struct pages.
> 
> Actually because you put the 'strtuct page for devmem' in
> skb->bv_frag, the net stack will grab the 'struct page' for devmem
> using skb_frag_page() then call things like page_address(), kmap,
> get_page, put_page, etc, etc, etc.

Yes, as above, skb_frags_not_readable() checking is still needed for
kmap() and page_address().

get_page, put_page related calling is avoided in page_pool_frag_ref()
and napi_pp_put_page() for devmem page as the above checking is true
for devmem page:
(pp_iov->pp_magic & ~0x3UL) == PP_SIGNATURE

> 
>> The main difference between this patchset and RFC v3:
>> 1. It reuses the 'struct page' to have more unified handling between
>>    normal page and devmem page for net stack.
> 
> This is what was nacked in RFC v1.
> 
>> 2. It relies on the page->pp_frag_count to do reference counting.
>>
> 
> I don't see you change any of the page_ref_* calls in page_pool.c, for
> example this one:
> 
> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L601
> 
> So the reference the page_pool is seeing is actually page->_refcount,
> not page->pp_frag_count? I'm confused here. Is this a bug in the
> patchset?

page->_refcount is the same as page_pool_iov->_refcount for devmem, which
is ensured by the 'PAGE_POOL_MATCH(_refcount, _refcount);', and
page_pool_iov->_refcount is set to one in mp_dmabuf_devmem_alloc_pages()
by calling 'refcount_set(&ppiov->_refcount, 1)' and always remains as one.

So the 'page_ref_count(page) == 1' checking is always true for devmem page.
