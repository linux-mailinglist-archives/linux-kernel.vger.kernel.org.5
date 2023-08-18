Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3DA7807A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358846AbjHRI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358835AbjHRI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:59:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42337358D;
        Fri, 18 Aug 2023 01:59:18 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRwjZ6NptzVkVR;
        Fri, 18 Aug 2023 16:57:06 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 16:59:15 +0800
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com>
 <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org>
 <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org>
 <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <f71d9448-70c8-8793-dc9a-0eb48a570300@huawei.com>
Date:   Fri, 18 Aug 2023 16:59:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/18 14:12, Ilias Apalodimas wrote:
> On Fri, 18 Aug 2023 at 02:57, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Thu, 17 Aug 2023 19:59:37 +0300 Ilias Apalodimas wrote:
>>>> Can we assume the DMA mapping of page pool is page aligned? We should
>>>> be, right?
>>>
>>> Yes
>>>
>>>> That means we're storing 12 bits of 0 at the lower end.
>>>> So even with 32b of space we can easily store addresses for 32b+12b =>
>>>> 16TB of memory. "Ought to be enough" to paraphrase Bill G, and the
>>>> problem is only in our heads?
>>>
>>> Do you mean moving the pp_frag_count there?
>>
>> Right, IIUC we don't have enough space to fit dma_addr_t and the
>> refcount, but if we store the dma addr on a shifted u32 instead
>> of using dma_addr_t explicitly - the refcount should fit?
> 
> struct page looks like this:
> 
> unsigned long dma_addr;
> union {
>       unsigned long dma_addr_upper;
>       atomic_long_t pp_frag_count;
> };
> 
> So, on 32bit platforms with 64bit dma we can't support a frag count at all.
> We could either use the lower 12 bits (and have support for 4096 frags
> 'only') or do what you suggest.

Maybe we can rethink about defining a new memdesc for page used by
the network stack. As I took a glance at the Device Memory TCP v2
patchset from Mina, we may use the new memdesc to support more new
memory types, to decupple page_pool from the spcae limitation of
'stuct page', and to support frag page for 32bit platforms with
64bit dma too.

> TBH I don't love any of these and since those platforms are rare (or
> at least that's what I think), I prefer not supporting them at all.
> 
>>
>>> I was questioning the need to have PP_FLAG_PAGE_SPLIT_IN_DRIVER
>>> overall.  With Yunshengs patches such a platform would allocate a
>>> page, so why should we prevent it from splitting it internally?
>>
>> Splitting it is fine, the problem is that the refcount AKA
>> page->pp_frag_count** counts outstanding PP-aware references
>> and page->refcount counts PP-unaware references.
>>
>> If we want to use page->refcount directly we'd need to unmap
>> the page whenever drivers calls page_pool_defrag_page().
>> But the driver may assume the page is still mapped afterwards.
> 
> What I am suggesting here is to not add the new
> PP_FLAG_PAGE_SPLIT_IN_DRIVER flag.  If a driver wants to split pages
> internally it should create a pool without
> PP_FLAG_DMA_SYNC_DEV to begin with.  The only responsibility the

I am not sure why using PP_FLAG_DMA_SYNC_DEV is conflicted with page
split if the frag page is freed with dma_sync_size being -1 and the
pool->p.max_len is setup correctly.

I was thinking about defining page_pool_put_frag() which corresponds
to page_pool_dev_alloc_frag() and page_pool_free() which corresponds
to page_pool_dev_alloc(), so that driver author does not misuse the
dma_sync_size parameter for page_pool_put_page() related API.

And PP_FLAG_PAGE_SPLIT_IN_DRIVER is used to fail the page_pool creation
when driver is using page->pp_frag_count to split page itself in 32-bit
arch with 64-bit DMA.

> driver would have is to elevate the page refcnt so page pool would not
> try to free/recycle it.  Since it won't be able to allocate fragments
> we don't have to worry about the rest.
> 
>> We can change the API to make this behavior explicit. Although
>> IMHO that's putting the burden of rare platforms on non-rare
>> platforms which we should avoid.
> 
> Yep, agree here.
> 
>>
>> ** I said it before and I will keep saying this until someone gets
>>    angry at me - I really think we should rename this field because
>>    the association with frags is a coincidence.

As my understanding, currently the naming is fine as it is because
page->pp_frag_count is used to indicate the number of frags a page
is split, there is only one user holding onto one frag for now.

But if there are more than one user holding onto one frag, then we
should probably rename it to something like page->pp_ref_count as
Jakub suggested before, for example below patch may enable more than
one user holding onto one frag.

https://patchwork.kernel.org/project/netdevbpf/patch/20230628121150.47778-1-liangchen.linux@gmail.com/
