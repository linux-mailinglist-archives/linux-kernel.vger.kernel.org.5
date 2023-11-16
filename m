Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407317EDF43
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjKPLML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjKPLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:12:09 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CB7B5;
        Thu, 16 Nov 2023 03:12:05 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SWHLQ4G81zMmfN;
        Thu, 16 Nov 2023 19:07:26 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 16 Nov
 2023 19:12:03 +0800
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     Mina Almasry <almasrymina@google.com>
CC:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
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
 <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com>
 <CAHS8izMj_89dMVaMr73r1-3Kewgc1YL3A1mjvixoax2War8kUg@mail.gmail.com>
 <3ff54a20-7e5f-562a-ca2e-b078cc4b4120@huawei.com>
 <6553954141762_1245c529423@willemb.c.googlers.com.notmuch>
 <8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com>
 <CAHS8izOBe2X3iPHmvc7JQGiawgm7Gyxov8xq62SShUTXDRguFw@mail.gmail.com>
 <CAHS8izO8bJSpD9ziNQHxpraLsUc8JnazgLA5=ziDBtzriRSQHA@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0366d9e8-7796-b15a-d309-d2fd81f9d700@huawei.com>
Date:   Thu, 16 Nov 2023 19:12:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izO8bJSpD9ziNQHxpraLsUc8JnazgLA5=ziDBtzriRSQHA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/16 3:05, Mina Almasry wrote:
> On Wed, Nov 15, 2023 at 10:07 AM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Wed, Nov 15, 2023 at 1:29 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>
>>> On 2023/11/14 23:41, Willem de Bruijn wrote:
>>>>>
>>>>> I am not sure dma-buf maintainer's concern is still there with this patchset.
>>>>>
>>>>> Whatever name you calling it for the struct, however you arrange each field
>>>>> in the struct, some metadata is always needed for dmabuf to intergrate into
>>>>> page pool.
>>>>>
>>>>> If the above is true, why not utilize the 'struct page' to have more unified
>>>>> handling?
>>>>
>>>> My understanding is that there is a general preference to simplify struct
>>>> page, and at the least not move in the other direction by overloading the
>>>> struct in new ways.
>>>
>>> As my understanding, the new struct is just mirroring the struct page pool
>>> is already using, see:
>>> https://elixir.free-electrons.com/linux/v6.7-rc1/source/include/linux/mm_types.h#L119
>>>
>>> If there is simplifying to the struct page_pool is using, I think the new
>>> stuct the devmem memory provider is using can adjust accordingly.
>>>
>>> As a matter of fact, I think the way 'struct page' for devmem is decoupled
>>> from mm subsystem may provide a way to simplify or decoupled the already
>>> existing 'struct page' used in netstack from mm subsystem, before this
>>> patchset, it seems we have the below types of 'struct page':
>>> 1. page allocated in the netstack using page pool.
>>> 2. page allocated in the netstack using buddy allocator.
>>> 3. page allocated in other subsystem and passed to the netstack, such as
>>>    zcopy or spliced page?
>>>
>>> If we can decouple 'struct page' for devmem from mm subsystem, we may be able
>>> to decouple the above 'struct page' from mm subsystem one by one.
>>>
>>>>
>>>> If using struct page for something that is not memory, there is ZONE_DEVICE.
>>>> But using that correctly is non-trivial:
>>>>
>>>> https://lore.kernel.org/all/ZKyZBbKEpmkFkpWV@ziepe.ca/
>>>>
>>>> Since all we need is a handle that does not leave the network stack,
>>>> a network specific struct like page_pool_iov entirely avoids this issue.
>>>
>>> Yes, I am agree about the network specific struct.
>>> I am wondering if we can make the struct more generic if we want to
>>> intergrate it into page_pool and use it in net stack.
>>>
>>>> RFC v3 seems like a good simplification over RFC v1 in that regard to me.
>>>> I was also pleasantly surprised how minimal the change to the users of
>>>> skb_frag_t actually proved to be.
>>>
>>> Yes, I am agreed about that too. Maybe we can make it simpler by using
>>> a more abstract struct as page_pool, and utilize some features of
>>> page_pool too.
>>>
>>> For example, from the page_pool doc, page_pool have fast cache and
>>> ptr-ring cache as below, but if napi_frag_unref() call
>>> page_pool_page_put_many() and return the dmabuf chunk directly to
>>> gen_pool in the memory provider, then it seems we are bypassing the
>>> below caches in the page_pool.
>>>
>>
>> I think you're just misunderstanding the code. The page recycling
>> works with my patchset. napi_frag_unref() calls napi_pp_put_page() if
>> recycle == true, and that works the same with devmem as with regular
>> pages.
>>
>> If recycle == false, we call page_pool_page_put_many() which will call
>> put_page() for regular pages and page_pool_iov_put_many() for devmem
>> pages. So, the memory recycling works exactly the same as before with
>> devmem as with regular pages. In my tests I do see the devmem being
>> recycled correctly. We are not bypassing any caches.
>>
>>
> 
> Ah, taking a closer look here, the devmem recycling works for me but I
> think that's a side effect to the fact that the page_pool support I
> implemented with GVE is unusual. I currently allocate pages from the
> page_pool but do not set skb_mark_for_recycle(). The page recycling
> still happens when GVE is done with the page and calls
> page_pool_put_full_pgae(), as that eventually checks the refcount on
> the devmem and recycles it.
> 
> I will fix up the GVE to call skb_mark_for_recycle() and ensure the
> napi_pp_put_page() path recycles the devmem or page correctly in the
> next version.

What about other features? Like dma mapping optimization and frag support
in the page pool.

I understand that you use some trick in the gen_gool to avoid the per chunk
dma_addr storage in the 'struct page_pool_iov' and do not need frag support
for now.

But for other memory provider, if they need those supports, we probably need
to extend 'struct page_pool_iov' to support those features, then we may have
a 'struct page_pool_iov' to be looking alike to the sepcific union for page_pool
in 'struct page', see:

https://elixir.free-electrons.com/linux/v6.7-rc1/source/include/linux/mm_types.h#L119

We currently don't have a way to decouple the existing 'struct page' from mm
subsystem yet as my understanding, if we don't mirror the above union in the
'struct page', we may have more 'if' checking added in the future.
