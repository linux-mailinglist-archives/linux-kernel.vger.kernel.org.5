Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2578C3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjH2L6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjH2L6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:58:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AA3199;
        Tue, 29 Aug 2023 04:58:35 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RZm9z2XZpzrSQZ;
        Tue, 29 Aug 2023 19:56:55 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 19:58:33 +0800
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Jakub Kicinski <kuba@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
CC:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com>
 <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org>
 <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org>
 <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org>
 <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
 <20230821113543.536b7375@kernel.org>
 <5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
 <20230822083821.58d5d26c@kernel.org>
 <79a49ccd-b0c0-0b99-4b4d-c4a416d7e327@huawei.com>
 <20230823072552.044d13b3@kernel.org>
 <CAKgT0UeSOBbXohq1rZ3YsB4abB_-5ktkLtYbDKTah8dvaojruA@mail.gmail.com>
 <5aae00a4-42c0-df8b-30cb-d47c91cf1095@huawei.com>
 <20230825170850.517fad7d@kernel.org>
 <CAKgT0UeHfQLCzNALUnYyJwtGpUnd=4JbMSy00srgdKZz=SFemw@mail.gmail.com>
 <20230828083810.4f86b9a3@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <2b570282-24f8-f23b-1ff7-ad836794baa9@huawei.com>
Date:   Tue, 29 Aug 2023 19:58:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230828083810.4f86b9a3@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/28 23:38, Jakub Kicinski wrote:
> On Mon, 28 Aug 2023 07:50:33 -0700 Alexander Duyck wrote:
>> Actually we could keep it pretty simple. We just have to create a
>> #define using DMA_BIT_MASK for the size of the page pool DMA. We could
>> name it something like PP_DMA_BIT_MASK. The drivers would just have to
>> use that to define their bit mask when they call
>> dma_set_mask_and_coherent. In that case the DMA API would switch to
>> bounce buffers automatically in cases where the page DMA address would
>> be out of bounds.
>>
>> The other tweak we could look at doing would be to just look at the
>> dma_get_required_mask and add a warning and/or fail to load page pool
>> on systems where the page pool would not be able to process that when
>> ANDed with the device dma mask.

As the all arches have used CONFIG_PHYS_ADDR_T_64BIT:
https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_ADDR_T_64BIT

arm: Large Physical Address Extension or LPAE, 40 bits of phys addr.
arc: Physical Address Extension or PAE, 40 bits of phys addr.
mips: eXtended Physical Addressing or PXA, 40 bits of phys addr.
powerpc: does not seems to have a name for the feature, and have 36
         bits of phys addr.
riscv: large physical address, 34 bits of phys addr.
x86: Physical Address Extension or PAE, 36 bits of phys addr.

It do seem that we are worrying too much, So I am going to follow jakub's
suggestion. If we make a wrong assumption, we print a warning for that.

>>
>> With those two changes the setup should be rock solid in terms of any
>> risks of the DMA address being out of bounds, and with minimal
>> performance impact as we would have verified all possibilities before
>> we even get into the hot path.
> 
> Sounds like a plan!
> .
> 
