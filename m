Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46CD7AD700
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjIYLbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYLbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:31:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29ECC6;
        Mon, 25 Sep 2023 04:31:42 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RvLFz4vpqzNnnZ;
        Mon, 25 Sep 2023 19:27:51 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 19:31:40 +0800
Subject: Re: [PATCH net-next v8 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC:     Jesper Dangaard Brouer <jbrouer@redhat.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <brouer@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230912083126.65484-1-linyunsheng@huawei.com>
 <20230912083126.65484-2-linyunsheng@huawei.com>
 <84282e55-519c-0e17-30c5-b6de54d1001c@redhat.com>
 <15f95505-dba9-4afd-6980-5bdf0a64d507@huawei.com>
 <CAC_iWjL_u=R+UK-6rhnv=32qX2P9SY72LFu928Y64u11EVoOPQ@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b0388db7-d4b2-443b-12f0-fbe6ae4002cd@huawei.com>
Date:   Mon, 25 Sep 2023 19:31:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAC_iWjL_u=R+UK-6rhnv=32qX2P9SY72LFu928Y64u11EVoOPQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/25 18:37, Ilias Apalodimas wrote:
> Hi
> 
> On Wed, 20 Sept 2023 at 11:59, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/9/15 16:28, Jesper Dangaard Brouer wrote:
>>> Hi Lin,
>>>
>>> This looks reasonable, but given you are changing struct-page
>>> (include/linux/mm_types.h) we need to MM-list <linux-mm@kvack.org>.
>>> Also Cc Wilcox.
>>>
>>> I think it was Ilias and Duyck that validated the assumptions, last time
>>> this patch was discussed. Thus I want to see their review before this is
>>> applied.
>>
>> FWIW, PAGE_SIZE aligned buffer being PAGE_SIZE aligned in DMA is
>> validated by Duyck:
>> https://lore.kernel.org/all/CAKgT0UfeUAUQpEffxnkc+gzXsjOrHkuMgxU_Aw0VXSJYKzaovQ@mail.gmail.com/
>>
>> And I had done researching to find out there seems to be no combination of
>> the above arch with an address space >16TB:
>> https://lore.kernel.org/all/2b570282-24f8-f23b-1ff7-ad836794baa9@huawei.com/
> 
> Apologies for the late reply.  I just saw you sent a v9, I'll review
> that instead, but I am traveling right now, will take a while

Actually there is a newer v10, see:
https://lore.kernel.org/all/20230922091138.18014-2-linyunsheng@huawei.com/

Thanks for the time reviewing.

> 
> Thanks
> /Ilias

