Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED187EAB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjKNIXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjKNIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:23:36 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653E41B2;
        Tue, 14 Nov 2023 00:23:32 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4STzhv6WCdzMmvG;
        Tue, 14 Nov 2023 16:18:55 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 14 Nov
 2023 16:23:30 +0800
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     Jakub Kicinski <kuba@kernel.org>,
        Mina Almasry <almasrymina@google.com>
CC:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
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
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
Date:   Tue, 14 Nov 2023 16:23:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20231113180554.1d1c6b1a@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Christian, Jason and Willy

On 2023/11/14 7:05, Jakub Kicinski wrote:
> On Mon, 13 Nov 2023 05:42:16 -0800 Mina Almasry wrote:
>> You're doing exactly what I think you're doing, and what was nacked in RFC v1.
>>
>> You've converted 'struct page_pool_iov' to essentially become a
>> duplicate of 'struct page'. Then, you're casting page_pool_iov* into
>> struct page* in mp_dmabuf_devmem_alloc_pages(), then, you're calling
>> mm APIs like page_ref_*() on the page_pool_iov* because you've fooled
>> the mm stack into thinking dma-buf memory is a struct page.

Yes, something like above, but I am not sure about the 'fooled the mm
stack into thinking dma-buf memory is a struct page' part, because:
1. We never let the 'struct page' for devmem leaking out of net stacking
   through the 'not kmap()able and not readable' checking in your patchset.
2. We inititiate page->_refcount for devmem to one and it remains as one,
   we will never call page_ref_inc()/page_ref_dec()/get_page()/put_page(),
   instead, we use page pool's pp_frag_count to do reference counting for
   devmem page in patch 6.

>>
>> RFC v1 was almost exactly the same, except instead of creating a
>> duplicate definition of struct page, it just allocated 'struct page'
>> instead of allocating another struct that is identical to struct page
>> and casting it into struct page.

Perhaps it is more accurate to say this is something between RFC v1 and
RFC v3, in order to decouple 'struct page' for devmem from mm subsystem,
but still have most unified handling for both normal memory and devmem
in page pool and net stack.

The main difference between this patchset and RFC v1:
1. The mm subsystem is not supposed to see the 'struct page' for devmem
   in this patchset, I guess we could say it is decoupled from the mm
   subsystem even though we still call PageTail()/page_ref_count()/
   page_is_pfmemalloc() on 'struct page' for devmem.

The main difference between this patchset and RFC v3:
1. It reuses the 'struct page' to have more unified handling between
   normal page and devmem page for net stack.
2. It relies on the page->pp_frag_count to do reference counting.

>>
>> I don't think what you're doing here reverses the nacks I got in RFC
>> v1. You also did not CC any dma-buf or mm people on this proposal that
>> would bring up these concerns again.
> 
> Right, but the mirror struct has some appeal to a non-mm person like
> myself. The problem IIUC is that this patch is the wrong way around, we
> should be converting everyone who can deal with non-host mem to struct
> page_pool_iov. Using page_address() on ppiov which hns3 seems to do in
> this series does not compute for me.

The hacking use of ppiov in hns3 is only used to do the some prototype
testing, so ignore it.

> 
> Then we can turn the existing non-iov helpers to be a thin wrapper with
> just a cast from struct page to struct page_pool_iov, and a call of the
> iov helper. Again - never cast the other way around.

I am agreed that a cast from struct page to struct page_pool_iov is allowed,
but a cast from struct page_pool_iov to struct page is not allowed if I am
understanding you correctly.

Before we can also completely decouple 'struct page' allocated using buddy
allocator directly from mm subsystem in netstack, below is what I have in
mind in order to support different memory provider.

                                +--------------+
                                |   Netstack   |
                                |'struct page' |
                                +--------------+
                                        ^
                                        |
                                        |
                                        v
                              +---------------------+
+----------------------+      |                     |      +---------------+
|      devmem MP       |<---->|     Page pool       |----->|    **** MP    |
|'struct page_pool_iov'|      |   'struct page'     |      |'struct **_iov'|
+----------------------+      |                     |      +---------------+
                              +---------------------+
                                        ^
                                        |
                                        |
                                        v
                                +---------------+
                                |    Driver     |
                                | 'struct page' |
                                +---------------+

I would expect net stack, page pool, driver still see the 'struct page',
only memory provider see the specific struct for itself, for the above,
devmem memory provider sees the 'struct page_pool_iov'.

The reason I still expect driver to see the 'struct page' is that driver
will still need to support normal memory besides devmem.

> 
> Also I think this conversion can be done completely separately from the
> mem provider changes. Just add struct page_pool_iov and start using it.

I am not sure I understand what does "Just add struct page_pool_iov and
start using it" mean yet.

> 
> Does that make more sense?
> 
> .
> 
