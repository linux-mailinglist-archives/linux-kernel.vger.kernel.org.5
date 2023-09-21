Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FAE7AA4F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjIUW1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjIUW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:26:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BEBA0F4F;
        Thu, 21 Sep 2023 10:57:03 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rrv5n1mB5z15NQt;
        Thu, 21 Sep 2023 19:57:17 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 21 Sep
 2023 19:59:24 +0800
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
Message-ID: <addf5abe-1683-d432-bf4b-e011ceba134c@huawei.com>
Date:   Thu, 21 Sep 2023 19:59:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAGGBzXLu7rO4bTet0wqb2Z7FmqsSu0BVuVw_LprcJcPKO1vXEg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
