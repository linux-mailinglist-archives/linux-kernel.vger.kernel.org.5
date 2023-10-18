Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF327CDAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjJRLrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJRLrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:47:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75152112;
        Wed, 18 Oct 2023 04:47:19 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9TVJ4M6WzvQ7d;
        Wed, 18 Oct 2023 19:42:32 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 19:47:17 +0800
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related API
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
 <20231016182725.6aa5544f@kernel.org>
 <2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
 <20231017081303.769e4fbe@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <67f2af29-59b8-a9e2-1c31-c9a625e4c4b3@huawei.com>
Date:   Wed, 18 Oct 2023 19:47:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20231017081303.769e4fbe@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/17 23:13, Jakub Kicinski wrote:
> On Tue, 17 Oct 2023 15:56:48 +0800 Yunsheng Lin wrote:
>>> And I can't figure out now what the "cache" in the name is referring to.
>>> Looks like these are just convenience wrappers which return VA instead
>>> of struct page..  
>>
>> Yes, it is corresponding to some API like napi_alloc_frag() returning va
>> instead of 'struct page' mentioned in patch 5.
>>
>> Anyway, naming is hard, any suggestion for a better naming is always
>> welcomed:)
> 
> I'd just throw a _va (for virtual address) at the end. And not really

_va seems fine:)

> mention it in the documentation. Plus the kdoc of the function should
> say that this is just a thin wrapper around other page pool APIs, and
> it's safe to mix it with other page pool APIs?

I am not sure I understand what do 'safe' and 'mix' mean here.

For 'safe' part, I suppose you mean if there is a va accociated with
a 'struct page' without calling some API like kmap()? For that, I suppose
it is safe when the driver is calling page_pool API without the
__GFP_HIGHMEM flag. Maybe we should mention that in the kdoc and give a
warning if page_pool_*alloc_va() is called with the __GFP_HIGHMEM flag?

For the 'mix', I suppose you mean the below:
1. Allocate a page with the page_pool_*alloc_va() API and free a page with
   page_pool_free() API.
2. Allocate a page with the page_pool_*alloc() API and free a page with
   page_pool_free_va() API.

For 1, it seems it is ok as some virt_to_head_page() and page_address() call
between va and 'struct page' does not seem to change anything if we have
enforce page_pool_*alloc_va() to be called without the __GFP_HIGHMEM flag.

For 2, If the va is returned from page_address() which the allocation API is
called without __GFP_HIGHMEM flag. If not, the va is from kmap*()? which means
we may be calling page_pool_free_va() before kunmap*()? Is that possible?


> .
> 
