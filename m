Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6355D7FCD18
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376810AbjK2Cy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376788AbjK2Cy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:54:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0EA19A4;
        Tue, 28 Nov 2023 18:55:03 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sg3nf1VjFzvRHv;
        Wed, 29 Nov 2023 10:54:30 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 Nov
 2023 10:55:01 +0800
Subject: Re: [PATCH net-next v5 01/14] page_pool: make sure frag API fields
 don't span between cachelines
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-2-aleksander.lobakin@intel.com>
 <9902d1c4-5e51-551a-3b66-c078c217c5ad@huawei.com>
 <5e6859d3-d3e7-44c1-acee-2c4ec568615d@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <bd35cf74-698f-e811-43be-af207a88fdc7@huawei.com>
Date:   Wed, 29 Nov 2023 10:55:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <5e6859d3-d3e7-44c1-acee-2c4ec568615d@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/27 22:08, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Sat, 25 Nov 2023 20:29:22 +0800
> 
>> On 2023/11/24 23:47, Alexander Lobakin wrote:
>>> After commit 5027ec19f104 ("net: page_pool: split the page_pool_params
>>> into fast and slow") that made &page_pool contain only "hot" params at
>>> the start, cacheline boundary chops frag API fields group in the middle
>>> again.
>>> To not bother with this each time fast params get expanded or shrunk,
>>> let's just align them to `4 * sizeof(long)`, the closest upper pow-2 to
>>> their actual size (2 longs + 2 ints). This ensures 16-byte alignment for
>>> the 32-bit architectures and 32-byte alignment for the 64-bit ones,
>>> excluding unnecessary false-sharing.
>>>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> ---
>>>  include/net/page_pool/types.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
>>> index e1bb92c192de..989d07b831fc 100644
>>> --- a/include/net/page_pool/types.h
>>> +++ b/include/net/page_pool/types.h
>>> @@ -127,7 +127,7 @@ struct page_pool {
>>>  
>>>  	bool has_init_callback;
>>
>> It seems odd to have only a slow field between tow fast
>> field group, isn't it better to move it to the end of
>> page_pool or where is more appropriate?
> 
> 1. There will be more in the subsequent patches.
> 2. ::has_init_callback happens each new page allocation, it's not slow.
>    Jakub did put it here for purpose.
> 
>>
>>>  
>>> -	long frag_users;
>>> +	long frag_users __aligned(4 * sizeof(long));
>>
>> If we need that, why not just use '____cacheline_aligned_in_smp'?
> 
> It can be an overkill. We don't need a full cacheline, but only these
> fields to stay within one, no matter whether they are in the beginning
> of it or at the end.

I am still a little lost here, A comment explaining why using '4' in the
above would be really helpful here.
