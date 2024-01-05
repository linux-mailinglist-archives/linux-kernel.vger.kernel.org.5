Return-Path: <linux-kernel+bounces-17785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 943328252B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991EAB213EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7F22C692;
	Fri,  5 Jan 2024 11:24:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875252C680
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cambridgegreys.com
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rLiIU-009MXW-Dv; Fri, 05 Jan 2024 11:23:31 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rLiIN-0024Bu-2P;
	Fri, 05 Jan 2024 11:23:30 +0000
Message-ID: <d5859c6e-e924-4413-bff5-7009acd8718f@cambridgegreys.com>
Date: Fri, 5 Jan 2024 11:23:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: fix return value check in vector_legacy_rx
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Ma Ke <make_ruc2021@163.com>
Cc: richard@nod.at, xiangyang3@huawei.com, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231006122717.3984017-1-make_ruc2021@163.com>
 <CAFLxGvytpwjXM0bdLrxt0itfEBPqJSmuM6otB7dTBmsTaAAPgw@mail.gmail.com>
 <1c098c26132b60ebebc46a39e8b7827a29e3a166.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <1c098c26132b60ebebc46a39e8b7827a29e3a166.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett

On 05/01/2024 08:42, Johannes Berg wrote:
> On Thu, 2024-01-04 at 22:05 +0100, Richard Weinberger wrote:
>> On Fri, Oct 6, 2023 at 2:28 PM Ma Ke <make_ruc2021@163.com> wrote:
>>>
>>> In vector_legacy_rx, to avoid an unexpected result returned by
>>> pskb_trim, we should check the return value of pskb_trim().
>>>
>>> Signed-off-by: Ma Ke <make_ruc2021@163.com>
>>> ---
>>>   arch/um/drivers/vector_kern.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
>>> index 131b7cb29576..822a8c0cdcc1 100644
>>> --- a/arch/um/drivers/vector_kern.c
>>> +++ b/arch/um/drivers/vector_kern.c
>>> @@ -890,7 +890,8 @@ static int vector_legacy_rx(struct vector_private *vp)
>>>                                          skb->ip_summed = CHECKSUM_UNNECESSARY;
>>>                                  }
>>>                          }
>>> -                       pskb_trim(skb, pkt_len - vp->rx_header_size);
>>> +                       if (pskb_trim(skb, pkt_len - vp->rx_header_size))
>>> +                               return 0;
>>
>> I think this adds a memory leak. Also, can pskb_trim() really fail in
>> this scenario?
>> The function controls skb creation and knows all lengths.
>>
> We had pretty much the exact same discussion in the other patch ...
> 
> https://patchwork.ozlabs.org/project/linux-um/patch/20231007005104.3994678-1-make_ruc2021@163.com/
> 
> 
> No point arguing with people who care about static checkers only, I
> guess. This person here never even came back to respond to the comments,
> my take is they're throwing patches over the wall they didn't think
> about, just to see what sticks.

CV padding, the 2024 way. Accomplishments: submitted 231 patches to the 
linux kernel.

> 
> johannes
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


