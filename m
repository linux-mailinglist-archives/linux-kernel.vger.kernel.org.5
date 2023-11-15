Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABF27ECA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjKOR5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjKOR5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:57:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E481B8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:57:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347A3C433C9;
        Wed, 15 Nov 2023 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700071052;
        bh=E3+pzFE8iRYk10BdpmIpByslUyT/gQ7QPb0/TlBw07E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sYMwAppSrkFvV55qdH71dJUqxdPf4EtCzT7b0rurs6aACyonFhzTdiwzdo1A2Rwt/
         4p2lM+kUPpklLWYibyFLRyndk751SQPckZZrT4NuTgBABNyNDqmhOs7nwEMSRLYlE+
         HQPUpzMnCC1oBIIbqqafAZ8wFo0g0dAJZy9cTbxWiozd2mutJyPno5SsG/TxsAKZp2
         A0scdnVV2KQ4M069VtaVI5APNpWlDj5rxGmpsTnDsLsNqAH/NwbYEeov5CHDnHb+cZ
         YHl1i1jAJ6oxfwysQQcqQ8wIM9e8hzADbH2frm4is9g+Xr721q45TnI1MzZJA1Q+eu
         1J63Z1wtuZcNQ==
Message-ID: <ee10d050-ef24-49b2-8712-c9bc8a911c2a@kernel.org>
Date:   Wed, 15 Nov 2023 10:57:30 -0700
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
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <ed875644-95e8-629a-4c28-bf42329efa56@huawei.com>
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

On 11/15/23 2:21 AM, Yunsheng Lin wrote:
> On 2023/11/14 21:16, Jason Gunthorpe wrote:
>> On Tue, Nov 14, 2023 at 04:21:26AM -0800, Mina Almasry wrote:
>>
>>> Actually because you put the 'strtuct page for devmem' in
>>> skb->bv_frag, the net stack will grab the 'struct page' for devmem
>>> using skb_frag_page() then call things like page_address(), kmap,
>>> get_page, put_page, etc, etc, etc.
>>
>> Yikes, please no. If net has its own struct page look alike it has to
>> stay entirely inside net. A non-mm owned struct page should not be
>> passed into mm calls. It is just way too hacky to be seriously
>> considered :(
> 
> Yes, that is something this patchset is trying to do, defining its own
> struct page look alike for page pool to support devmem.
> 

Networking needs to be able to move away from struct page references.
The devmem and host memory for Rx use cases do not need to be page based.

