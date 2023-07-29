Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF80767EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjG2Lk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjG2LkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:40:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B229E4B;
        Sat, 29 Jul 2023 04:40:23 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RCjD60fflzLnvl;
        Sat, 29 Jul 2023 19:37:42 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 19:40:20 +0800
Subject: Re: [PATCH net-next 2/9] net: skbuff: don't include
 <net/page_pool/types.h> to <linux/skbuff.h>
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
 <20230727144336.1646454-3-aleksander.lobakin@intel.com>
 <f283dfa9-d599-7311-1c2f-4317c2f7957d@huawei.com>
 <5ba84af2-51d1-de5d-14cc-752c08e5371f@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5830338c-d025-2fb8-46a6-58508493b2cf@huawei.com>
Date:   Sat, 29 Jul 2023 19:40:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <5ba84af2-51d1-de5d-14cc-752c08e5371f@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/28 21:58, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Fri, 28 Jul 2023 20:02:51 +0800
> 
>> On 2023/7/27 22:43, Alexander Lobakin wrote:
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>
>> ...
>>
>>> +bool page_pool_return_skb_page(struct page *page, bool napi_safe)
>>
>> Still having the 'page_pool_' prefix seems odd here when it is in the
>> skbuff.c where most have skb_ or napi_ prefix, is it better to rename
>> it to something like napi_return_page_pool_page()?
> 
> Given that how the function that goes next is named, maybe
> skb_pp_return_page() (or skb_pp_put_page())?

skb_pp_put_page() seems better.

And I like napi_pp_put_page() with 'napi_' prefix better as
it does not take a skb as parameter and the naming is aligned
with the 'napi_safe' parameter.

> 
>>
>>> +{
>>> +	struct napi_struct *napi;
>>> +	struct page_pool *pp;
>>> +	bool allow_direct;
>>> +
>>> +	page = compound_head(page);
>>> +
>>> +	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
>>> +	 * in order to preserve any existing bits, such as bit 0 for the
>>> +	 * head page of compound page and bit 1 for pfmemalloc page, so
>>> +	 * mask those bits for freeing side when doing below checking,
>>> +	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
>>> +	 * to avoid recycling the pfmemalloc page.
>>> +	 */
>>> +	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
>>> +		return false;
>>> +
>>> +	pp = page->pp;
>>> +
>>> +	/* Allow direct recycle if we have reasons to believe that we are
>>> +	 * in the same context as the consumer would run, so there's
>>> +	 * no possible race.
>>> +	 */
>>> +	napi = READ_ONCE(pp->p.napi);
>>> +	allow_direct = napi_safe && napi &&
>>> +		READ_ONCE(napi->list_owner) == smp_processor_id();
>>> +
>>> +	/* Driver set this to memory recycling info. Reset it on recycle.
>>> +	 * This will *not* work for NIC using a split-page memory model.
>>> +	 * The page will be returned to the pool here regardless of the
>>> +	 * 'flipped' fragment being in use or not.
>>> +	 */
>>> +	page_pool_put_full_page(pp, page, allow_direct);
>>> +
>>> +	return true;
>>> +}
>>> +EXPORT_SYMBOL(page_pool_return_skb_page);
>>> +
>>>  static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
> 
> (this one)
> 
>>>  {
>>>  	if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)

We may need the 'IS_ENABLED(CONFIG_PAGE_POOL' checking in the newly
moved function too.

>>>
> 
> Thanks,
> Olek
> 
> .
> 
