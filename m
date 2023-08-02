Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AAE76CBDF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjHBLhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjHBLho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:37:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3162139;
        Wed,  2 Aug 2023 04:37:39 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RG8z16DmlzLp2H;
        Wed,  2 Aug 2023 19:34:53 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 19:37:36 +0800
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
 <799ebbaf-961d-860a-6071-b74e10360e29@huawei.com>
 <1644b9d0-27a5-0c2b-c530-bcaa347f73c2@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <00695c43-b376-169d-a62d-c1a373cde90c@huawei.com>
Date:   Wed, 2 Aug 2023 19:37:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1644b9d0-27a5-0c2b-c530-bcaa347f73c2@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/1 21:42, Alexander Lobakin wrote:
...

>>>>
>>>> It seems other subsystem may have the similar problem as page_pool,
>>>> is it possible to implement this kind of trick in the dma subsystem
>>>> instead of every subsystem inventing their own trick?
>>>
>>> In the ladder I described above most of overhead comes from jumping
>>> between Page Pool functions, not the generic DMA ones. Let's say I do
>>> this shortcut in dma_sync_single_range_for_device(), that is too late
>>> already to count on some good CPU saves.
>>
>> We can force inline the page_pool_dma_sync_for_device() function if it
>> is 'the good CPU saves' you mentioned above.
>>
>>> Plus, DMA sync API operates with dma_addr_t, not struct page. IOW it's
>>> not clear to me where to store this "we can shortcut" bit in that case.
>>
>> It seems we only need one bit in 'struct device' to do the 'shortcut',
>> and there seems to have avaliable bit at the end of 'struct device'?
> 
> dma_need_sync() can return different results for two different DMA
> addresses within the same device.

Yes, that's why we need a per device state in order to do the
similar trick like this patch does.

> 
>>
>> Is it possible that we do something like this patch does in
>> dma_sync_single_range_for_device()?
>>
>> One thing to note is that there may be multi concurrent callers to
>> dma_sync_single_range_for_device(), which seems to be different from
>> atomic context for page_pool_dma_map(), so it may need some atomic
>> operation for the state changing if we want to implement it in a 'generic'
>> way.
>>
>>>
>>> >From "other subsystem" I remember only XDP sockets. There, they also
>>> avoid calling their own non-inline functions in the first place, not the
>>> generic DMA ones. So I'd say both cases (PP and XSk) can't be solved via
>>> some "generic" solution.
>>
>> If PP and XSk both have a similar trick, isn't it a more clear sight
>> that it may be solved via some "generic" solution?
> 
> Both shortcut their own functions in the first place, so I don't know
> what generic solution could be to optimize non-generic functions.

If we are able to shortcut the generic functions, for the page_pool
and XSK case，it seems the non-generic functions just need to be
inlined if I understand your concern correctly.

And for that we may be able to shortcut the generic functions for
dma_sync_single_range_for_device() used in driver too?

> 
>>
>> Is there any reason there is no a similar trick for sync for cpu in
>> XSk as below code indicates?
>> https://elixir.free-electrons.com/linux/v6.4-rc6/source/include/net/xsk_buff_pool.h#L152
