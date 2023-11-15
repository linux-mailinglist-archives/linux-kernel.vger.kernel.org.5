Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68097EBF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjKOJVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjKOJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:21:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1EFC;
        Wed, 15 Nov 2023 01:21:04 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SVcyG45DXzmXDl;
        Wed, 15 Nov 2023 17:17:42 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 15 Nov
 2023 17:21:02 +0800
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Mina Almasry <almasrymina@google.com>
CC:     Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <ZVNzS2EA4zQRwIQ7@nvidia.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ed875644-95e8-629a-4c28-bf42329efa56@huawei.com>
Date:   Wed, 15 Nov 2023 17:21:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <ZVNzS2EA4zQRwIQ7@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/14 21:16, Jason Gunthorpe wrote:
> On Tue, Nov 14, 2023 at 04:21:26AM -0800, Mina Almasry wrote:
> 
>> Actually because you put the 'strtuct page for devmem' in
>> skb->bv_frag, the net stack will grab the 'struct page' for devmem
>> using skb_frag_page() then call things like page_address(), kmap,
>> get_page, put_page, etc, etc, etc.
> 
> Yikes, please no. If net has its own struct page look alike it has to
> stay entirely inside net. A non-mm owned struct page should not be
> passed into mm calls. It is just way too hacky to be seriously
> considered :(

Yes, that is something this patchset is trying to do, defining its own
struct page look alike for page pool to support devmem.

struct page for devmem will not be called into the mm subsystem, so most
of the mm calls is avoided by calling into the devmem memory provider'
ops instead of calling mm calls.

As far as I see for now, only page_ref_count(), page_is_pfmemalloc() and
PageTail() is called for devmem page, which should be easy to ensure that
those call for devmem page is consistent with the struct page owned by mm.
I am not sure if we can use some kind of compile/runtime checking to ensure
those kinds of consistency?

> 
>>> I would expect net stack, page pool, driver still see the 'struct page',
>>> only memory provider see the specific struct for itself, for the above,
>>> devmem memory provider sees the 'struct page_pool_iov'.
>>>
>>> The reason I still expect driver to see the 'struct page' is that driver
>>> will still need to support normal memory besides devmem.
> 
> I wouldn't say this approach is unreasonable, but it does have to be
> done carefully to isolate the mm. Keeping the struct page in the API
> is going to make this very hard.

I would expect that most of the isolation is done in page pool, as far as
I can see:

1. For control part: the driver may need to tell the page pool which memory
                     provider it want to use. Or the administrator specifies
                     which memory provider to use by some netlink-based cmd.

2. For data part: I am thinking that driver should only call page_pool_alloc(),
                  page_pool_free() and page_pool_get_dma_addr related function.

Of course the driver may need to be aware of that if it can call kmap() or
page_address() on the page returned from page_pool_alloc(), and maybe tell
net stack that those pages is not kmap()'able and page_address()'able.

> 
> Jason
> .
> 
