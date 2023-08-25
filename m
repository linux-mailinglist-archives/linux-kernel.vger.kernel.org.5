Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDDA7883FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbjHYJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbjHYJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:40:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A515F1FD5;
        Fri, 25 Aug 2023 02:40:46 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXFJ117srzVkb3;
        Fri, 25 Aug 2023 17:38:25 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 17:40:43 +0800
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
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
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5aae00a4-42c0-df8b-30cb-d47c91cf1095@huawei.com>
Date:   Fri, 25 Aug 2023 17:40:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeSOBbXohq1rZ3YsB4abB_-5ktkLtYbDKTah8dvaojruA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/24 2:00, Alexander Duyck wrote:
> On Wed, Aug 23, 2023 at 7:25 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Wed, 23 Aug 2023 11:03:31 +0800 Yunsheng Lin wrote:
>>> On 2023/8/22 23:38, Jakub Kicinski wrote:
>>>> On Tue, 22 Aug 2023 17:21:35 +0800 Yunsheng Lin wrote:
>>>>> As the CONFIG_PHYS_ADDR_T_64BIT seems to used widely in x86/arm/mips/powerpc,
>>>>> I am not sure if we can really make the above assumption.
>>>>>
>>>>> https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_ADDR_T_64BIT
>>>>
>>>> Huh, it's actually used a lot less than I anticipated!
>>>>
>>>> None of the x86/arm/mips/powerpc systems matter IMHO - the only _real_
>>>
>>> Is there any particular reason that you think that the above systems does
>>> not really matter?
>>
>> Not the systems themselves but the combination of a 32b arch with
>> an address space >16TB. All those arches have 64b equivalent, seems
>> logical to use the 64b version for a system with a large address space.
>> If we're talking about a system which ends up running Linux.
>>
>>> As we have made a similar wrong assumption about those arches before, I am
>>> really trying to be more cautious about it.
>>>
>>> I searched through the web, some seems to be claiming that "32-bits is DEAD",
>>> I am not sure if there is some common agreement among the kernel community,
>>> is there any previous discussion about that?
>>
>> My suspicion/claim is that 32 + PAGE_SHIFT should be enough bits for
>> any 32b platform.
> 
> One additional thing we could consider would be to simply look at
> having page_pool enforce a DMA mask for the device to address any
> cases where we might not be able to fit the address. Then in the
> unlikely event that somebody is running a 32b system with over 16
> terabytes of RAM. With that the DMA subsystem would handle it for us
> and we wouldn't have to worry so much about it.

It seems there is a API to acquire the DMA mask used by the device:
https://elixir.free-electrons.com/linux/v6.4-rc6/source/include/linux/dma-mapping.h#L434

Is it possible to use that to check if DMA mask used by the device is
within 32 + PAGE_SHIFT limit, if yes, we use jakub's proposal to reduce
reduce the dma address bit, if no, we fail the page_pool creation?

> .
> 
