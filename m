Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFACB766D61
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjG1Mjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjG1Mj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:39:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8EB187;
        Fri, 28 Jul 2023 05:39:27 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RC6Zl4YsJzLnt2;
        Fri, 28 Jul 2023 20:36:47 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 20:39:24 +0800
Subject: Re: [PATCH net-next 6/9] page_pool: avoid calling no-op externals
 when possible
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-7-aleksander.lobakin@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a79cc7ed-5355-ef7d-8865-0ba9673af5c6@huawei.com>
Date:   Fri, 28 Jul 2023 20:39:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230727144336.1646454-7-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/27 22:43, Alexander Lobakin wrote:
> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
> even when on DMA-coherent platforms (like x86) with no active IOMMU or
> swiotlb, just for the call ladder.
> Indeed, it's
> 
> page_pool_put_page()
>   page_pool_put_defragged_page()                  <- external
>     __page_pool_put_page()
>       page_pool_dma_sync_for_device()             <- non-inline
>         dma_sync_single_range_for_device()
>           dma_sync_single_for_device()            <- external
>             dma_direct_sync_single_for_device()
>               dev_is_dma_coherent()               <- exit
> 
> For the inline functions, no guarantees the compiler won't uninline them
> (they're clearly not one-liners and sometimes compilers uninline even
> 2 + 2). The first external call is necessary, but the rest 2+ are done
> for nothing each time, plus a bunch of checks here and there.
> Since Page Pool mappings are long-term and for one "device + addr" pair
> dma_need_sync() will always return the same value (basically, whether it
> belongs to an swiotlb pool), addresses can be tested once right after
> they're obtained and the result can be reused until the page is unmapped.
> Define the new PP DMA sync operation type, which will mean "do DMA syncs
> for the device, but only when needed" and turn it on by default when the
> driver asks to sync pages. When a page is mapped, check whether it needs
> syncs and if so, replace that "sync when needed" back to "always do
> syncs" globally for the whole pool (better safe than sorry). As long as
> the pool has no pages requiring DMA syncs, this cuts off a good piece
> of calls and checks. When at least one page required it, the pool
> conservatively falls back to "always call sync functions", no per-page
> verdicts. It's a fairly rare case anyway that only a few pages would
> require syncing.
> On my x86_64, this gives from 2% to 5% performance benefit with no
> negative impact for cases when IOMMU is on and the shortcut can't be
> used.
> 

It seems other subsystem may have the similar problem as page_pool,
is it possible to implement this kind of trick in the dma subsystem
instead of every subsystem inventing their own trick?
