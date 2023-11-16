Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2197EDF40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjKPLLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345158AbjKPLL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:11:27 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C737CC1;
        Thu, 16 Nov 2023 03:11:21 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SWHKZ5v5XzMmsp;
        Thu, 16 Nov 2023 19:06:42 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 16 Nov
 2023 19:11:19 +0800
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     Mina Almasry <almasrymina@google.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
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
 <CAHS8izMR-FrTtCty8v29atAMor5FmzV_Ogk85H=gqGaJNvJnuA@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <28b65d3b-4df4-ce8b-00b6-abe565c0ab70@huawei.com>
Date:   Thu, 16 Nov 2023 19:11:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izMR-FrTtCty8v29atAMor5FmzV_Ogk85H=gqGaJNvJnuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 2023/11/16 1:44, Mina Almasry wrote:
> On Wed, Nov 15, 2023 at 1:21 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
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
>> struct page for devmem will not be called into the mm subsystem, so most
>> of the mm calls is avoided by calling into the devmem memory provider'
>> ops instead of calling mm calls.
>>
>> As far as I see for now, only page_ref_count(), page_is_pfmemalloc() and
>> PageTail() is called for devmem page, which should be easy to ensure that
>> those call for devmem page is consistent with the struct page owned by mm.
> 
> I'm not sure this is true. These 3 calls are just the calls you're
> aware of. In your proposal you're casting mirror pages into page* and
> releasing them into the net stack. You need to scrub the entire net
> stack for mm calls, i.e. all driver code and all skb_frag_page() call
> sites. Of the top of my head, the driver is probably calling
> page_address() and illegal_highdma() is calling PageHighMem(). TCP
> zerocopy receive is calling vm_insert_pages().

For net stack part, I believe your patch below is handling to aovid those
mm calls? I don't include it in this patchset as I thought it is obvious
that whatever the proposal is, we always need those checking.
Maybe we should have included it to avoid this kind of confusion.
https://lore.kernel.org/all/20231106024413.2801438-10-almasrymina@google.com/

For driver part, I was thinking if the driver supports devmem, it should check
that if it can call page_address() related call on a specific 'stuct page', or
maybe we should introduce a new helper to make it obvious?
