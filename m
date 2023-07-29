Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006A0767F39
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjG2Mqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjG2Mq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:46:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A06186;
        Sat, 29 Jul 2023 05:46:28 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCkjS171yzVjf2;
        Sat, 29 Jul 2023 20:44:44 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 20:46:22 +0800
Subject: Re: [PATCH net-next 6/9] page_pool: avoid calling no-op externals
 when possible
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-7-aleksander.lobakin@intel.com>
 <a79cc7ed-5355-ef7d-8865-0ba9673af5c6@huawei.com>
 <604d4f6c-a6e7-e921-2d9a-45fe46ab9e79@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <799ebbaf-961d-860a-6071-b74e10360e29@huawei.com>
Date:   Sat, 29 Jul 2023 20:46:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <604d4f6c-a6e7-e921-2d9a-45fe46ab9e79@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/28 22:14, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Fri, 28 Jul 2023 20:39:24 +0800
> 
>> On 2023/7/27 22:43, Alexander Lobakin wrote:
>>> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
>>> even when on DMA-coherent platforms (like x86) with no active IOMMU or
>>> swiotlb, just for the call ladder.
>>> Indeed, it's
>>>
>>> page_pool_put_page()
>>>   page_pool_put_defragged_page()                  <- external
>>>     __page_pool_put_page()
>>>       page_pool_dma_sync_for_device()             <- non-inline
>>>         dma_sync_single_range_for_device()
>>>           dma_sync_single_for_device()            <- external
>>>             dma_direct_sync_single_for_device()
>>>               dev_is_dma_coherent()               <- exit
>>>
>>> For the inline functions, no guarantees the compiler won't uninline them
>>> (they're clearly not one-liners and sometimes compilers uninline even
>>> 2 + 2). The first external call is necessary, but the rest 2+ are done
>>> for nothing each time, plus a bunch of checks here and there.
>>> Since Page Pool mappings are long-term and for one "device + addr" pair
>>> dma_need_sync() will always return the same value (basically, whether it
>>> belongs to an swiotlb pool), addresses can be tested once right after
>>> they're obtained and the result can be reused until the page is unmapped.
>>> Define the new PP DMA sync operation type, which will mean "do DMA syncs
>>> for the device, but only when needed" and turn it on by default when the
>>> driver asks to sync pages. When a page is mapped, check whether it needs
>>> syncs and if so, replace that "sync when needed" back to "always do
>>> syncs" globally for the whole pool (better safe than sorry). As long as
>>> the pool has no pages requiring DMA syncs, this cuts off a good piece
>>> of calls and checks. When at least one page required it, the pool
>>> conservatively falls back to "always call sync functions", no per-page
>>> verdicts. It's a fairly rare case anyway that only a few pages would
>>> require syncing.
>>> On my x86_64, this gives from 2% to 5% performance benefit with no
>>> negative impact for cases when IOMMU is on and the shortcut can't be
>>> used.
>>>
>>
>> It seems other subsystem may have the similar problem as page_pool,
>> is it possible to implement this kind of trick in the dma subsystem
>> instead of every subsystem inventing their own trick?
> 
> In the ladder I described above most of overhead comes from jumping
> between Page Pool functions, not the generic DMA ones. Let's say I do
> this shortcut in dma_sync_single_range_for_device(), that is too late
> already to count on some good CPU saves.

We can force inline the page_pool_dma_sync_for_device() function if it
is 'the good CPU saves' you mentioned above.

> Plus, DMA sync API operates with dma_addr_t, not struct page. IOW it's
> not clear to me where to store this "we can shortcut" bit in that case.

It seems we only need one bit in 'struct device' to do the 'shortcut',
and there seems to have avaliable bit at the end of 'struct device'?

Is it possible that we do something like this patch does in
dma_sync_single_range_for_device()?

One thing to note is that there may be multi concurrent callers to
dma_sync_single_range_for_device(), which seems to be different from
atomic context for page_pool_dma_map(), so it may need some atomic
operation for the state changing if we want to implement it in a 'generic'
way.

> 
>>From "other subsystem" I remember only XDP sockets. There, they also
> avoid calling their own non-inline functions in the first place, not the
> generic DMA ones. So I'd say both cases (PP and XSk) can't be solved via
> some "generic" solution.

If PP and XSk both have a similar trick, isn't it a more clear sight
that it may be solved via some "generic" solution?

Is there any reason there is no a similar trick for sync for cpu in
XSk as below code indicates?
https://elixir.free-electrons.com/linux/v6.4-rc6/source/include/net/xsk_buff_pool.h#L152

> 
> Thanks,
> Olek
> 
> .
> 
