Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D43F7EE4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjKPP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjKPP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:58:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9BF181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:58:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112C7C433C7;
        Thu, 16 Nov 2023 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700150303;
        bh=B68vNXPafDpm5CGgjZh28GWJpryYr4kJVI5IqZmIOAU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GFvO8ncPeCB+lYOze6sJv8uYgYrc9blZ3UiA0uep+7xQ2BwuoBD9W63q0cffxkm7Y
         e2IFtKODsXXF/nfRcpEPscQnmZcKaTjFooJla+oTpYGw+EjYxzwZiv+Mn5e4cMQjNk
         wROQl+4KJEt21jcR//JgHbxloe2hUv+qDnSJZdituWiSnqD53DlAdo8lwFqhanvK3L
         BHSC+PciRYHpIvXq0nmJYz/yvU43H+m/ggR/A6z1v8RZ0fWJeqEkNRhsuXFf0+Z08U
         zfjKHNribL13+mTts2dPjHah84UMvWeg/HlIol5LmaA6JewtFss3T4f7DTWrPz9QVG
         afP8J6PpE0s4w==
Message-ID: <d5672499-ce5b-45c0-b47a-e5bb188f6c7f@kernel.org>
Date:   Thu, 16 Nov 2023 08:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
 <15c404e4-8efa-cc1c-174f-0752005b6755@huawei.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <15c404e4-8efa-cc1c-174f-0752005b6755@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 4:12 AM, Yunsheng Lin wrote:
> On 2023/11/16 1:57, David Ahern wrote:
>> On 11/15/23 2:21 AM, Yunsheng Lin wrote:
>>> On 2023/11/14 21:16, Jason Gunthorpe wrote:
>>>> On Tue, Nov 14, 2023 at 04:21:26AM -0800, Mina Almasry wrote:
>>>>
>>>>> Actually because you put the 'strtuct page for devmem' in
>>>>> skb->bv_frag, the net stack will grab the 'struct page' for devmem
>>>>> using skb_frag_page() then call things like page_address(), kmap,
>>>>> get_page, put_page, etc, etc, etc.
>>>>
>>>> Yikes, please no. If net has its own struct page look alike it has to
>>>> stay entirely inside net. A non-mm owned struct page should not be
>>>> passed into mm calls. It is just way too hacky to be seriously
>>>> considered :(
>>>
>>> Yes, that is something this patchset is trying to do, defining its own
>>> struct page look alike for page pool to support devmem.
>>>
>>
>> Networking needs to be able to move away from struct page references.
>> The devmem and host memory for Rx use cases do not need to be page based.
> 
> Yes, I am agreed the ultimate goal is to move away from struct page
> references. But I am not sure if we can do it right away as there
> still are different types of existing 'struct page' in the netstack,
> see:
> 
> https://lore.kernel.org/all/8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com/

yes, that is the point of a blended approach -- pages and buffers (or
iov) -- leveraging the LSB of the address. That proposal is the right
direction to be moving for co-existence. Adding fake struct page
instances is the wrong direction.
