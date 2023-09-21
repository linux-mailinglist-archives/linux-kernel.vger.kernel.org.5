Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B2B7A96C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjIURFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjIURFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:05:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A0144A7;
        Thu, 21 Sep 2023 10:04:08 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RrsT30PBqzVkyG;
        Thu, 21 Sep 2023 18:43:51 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 21 Sep
 2023 18:46:50 +0800
Subject: Re: [PATCH net-next v9 5/6] page_pool: update document about frag API
To:     Dima Tisnek <dimaqq@gmail.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <linux-doc@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230920115855.27631-1-linyunsheng@huawei.com>
 <20230920115855.27631-6-linyunsheng@huawei.com>
 <CAGGBzXLu7rO4bTet0wqb2Z7FmqsSu0BVuVw_LprcJcPKO1vXEg@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <7e6cd2d7-7213-15e3-8aff-6237cce91788@huawei.com>
Date:   Thu, 21 Sep 2023 18:46:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAGGBzXLu7rO4bTet0wqb2Z7FmqsSu0BVuVw_LprcJcPKO1vXEg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/21 9:02, Dima Tisnek wrote:
> Minor comment on natural language:
> 
> On Wed, Sep 20, 2023 at 9:04 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> As more drivers begin to use the frag API, update the
>> document about how to decide which API to use for the
>> driver author.
> 
> the fragment API
> 
>> +/**
>> + * page_pool_dev_alloc_frag() - allocate a page frag.
> 
> allocate a page fragment.
> 
> the precedent is set in
> https://www.kernel.org/doc/html/v5.0/vm/page_frags.html
> foo_frag is used in C code, and foo fragment in English docs.

Sure.

It seems I need to respin anyway as the newly merged idpf driver
from intel is also using the frag API, and removing PP_FLAG_PAGE_FRAG
flag breaks it.

And idpf driver really should be using the new API instead of
selecting which API to use according to the buf_size as below
in drivers/net/ethernet/intel/idpf/idpf_txrx.h, as it seems to
be assuming PAGE_SIZE always being 4K, and we may be able to
enable page split for buf_size > 2048 and PAGE_SIZE > 4K if using
the new API.

static inline dma_addr_t idpf_alloc_page(struct page_pool *pool,
                                         struct idpf_rx_buf *buf,
                                         unsigned int buf_size)
{
        if (buf_size == IDPF_RX_BUF_2048)
                buf->page = page_pool_dev_alloc_frag(pool, &buf->page_offset,
                                                     buf_size);
        else
                buf->page = page_pool_dev_alloc_pages(pool);

        if (!buf->page)
                return DMA_MAPPING_ERROR;

        buf->truesize = buf_size;

        return page_pool_get_dma_addr(buf->page) + buf->page_offset +
               pool->p.offset;
}


> 
> .
> 
