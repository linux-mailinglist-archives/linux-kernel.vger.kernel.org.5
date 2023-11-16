Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7607EDF46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345083AbjKPLMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjKPLMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:12:38 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3DAA;
        Thu, 16 Nov 2023 03:12:35 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SWHS01cx5zvQpM;
        Thu, 16 Nov 2023 19:12:16 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 16 Nov
 2023 19:12:33 +0800
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Mina Almasry <almasrymina@google.com>
CC:     Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <ZVNzS2EA4zQRwIQ7@nvidia.com>
 <ed875644-95e8-629a-4c28-bf42329efa56@huawei.com>
 <ee10d050-ef24-49b2-8712-c9bc8a911c2a@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <15c404e4-8efa-cc1c-174f-0752005b6755@huawei.com>
Date:   Thu, 16 Nov 2023 19:12:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <ee10d050-ef24-49b2-8712-c9bc8a911c2a@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/16 1:57, David Ahern wrote:
> On 11/15/23 2:21 AM, Yunsheng Lin wrote:
>> On 2023/11/14 21:16, Jason Gunthorpe wrote:
>>> On Tue, Nov 14, 2023 at 04:21:26AM -0800, Mina Almasry wrote:
>>>
>>>> Actually because you put the 'strtuct page for devmem' in
>>>> skb->bv_frag, the net stack will grab the 'struct page' for devmem
>>>> using skb_frag_page() then call things like page_address(), kmap,
>>>> get_page, put_page, etc, etc, etc.
>>>
>>> Yikes, please no. If net has its own struct page look alike it has to
>>> stay entirely inside net. A non-mm owned struct page should not be
>>> passed into mm calls. It is just way too hacky to be seriously
>>> considered :(
>>
>> Yes, that is something this patchset is trying to do, defining its own
>> struct page look alike for page pool to support devmem.
>>
> 
> Networking needs to be able to move away from struct page references.
> The devmem and host memory for Rx use cases do not need to be page based.

Yes, I am agreed the ultimate goal is to move away from struct page
references. But I am not sure if we can do it right away as there
still are different types of existing 'struct page' in the netstack,
see:

https://lore.kernel.org/all/8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com/

> 
> 
> .
> 
