Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C66A7FEB46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjK3JAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjK3JAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:00:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53A12C;
        Thu, 30 Nov 2023 01:00:55 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sgqnj1l50zsR46;
        Thu, 30 Nov 2023 16:57:13 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 Nov
 2023 17:00:52 +0800
Subject: Re: [PATCH net-next 03/12] mm: Make the page_frag_cache allocator
 alignment param a pow-of-2
To:     Alexander H Duyck <alexander.duyck@gmail.com>,
        David Howells <dhowells@redhat.com>, <netdev@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Jeroen de Borst <jeroendb@google.com>,
        Catherine Sullivan <csully@google.com>,
        Shailend Chand <shailend@google.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>
References: <20230524153311.3625329-1-dhowells@redhat.com>
 <20230524153311.3625329-4-dhowells@redhat.com>
 <51161740e832334594960ed43430b868a6f892c3.camel@gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e841d2f4-b221-9099-8312-6b859ccb98de@huawei.com>
Date:   Thu, 30 Nov 2023 17:00:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <51161740e832334594960ed43430b868a6f892c3.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/27 23:54, Alexander H Duyck wrote:
> On Wed, 2023-05-24 at 16:33 +0100, David Howells wrote:
>> Make the page_frag_cache allocator's alignment parameter a power of 2
>> rather than a mask and give a warning if it isn't.
>>
>> This means that it's consistent with {napi,netdec}_alloc_frag_align() and
>> allows __{napi,netdev}_alloc_frag_align() to be removed.

I am trying to rmove the page frag implemetation in
vhost_net_page_frag_refill() by using page_frag_alloc_align(), and
I ended up having a simiar patch as this one.

>>
> 
> This goes against the original intention of these functions. One of the
> reasons why this is being used is because when somebody enables
> something like 2K jumbo frames they don't necessarily want to have to
> allocate 4K SLABs. Instead they can just add a bit of overhead and get
> almost twice the utilization out of an order 3 page.
> 
> The requirement should only be cache alignment, not power of 2
> alignment. This isn't meant to be a slab allocator. We are just
> sectioning up pages to handle mixed workloads. In the case of
> networking we can end up getting everything from 60B packets, to 1514B
> in the standard cases. That was why we started sectioning up pages in
> the first place so putting a power of 2 requirement on it doens't fit
> our use case at all and is what we were trying to get away from with
> the SLAB allocators.

It seems that is_power_of_2() checking in this patch does not excluding
the non-align case if we are passing 'align' being 1, which means we still
can support the 'everything from 60B packets, to 1514B' case.

> 
> .
> 
