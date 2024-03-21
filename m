Return-Path: <linux-kernel+bounces-110000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B2A8858C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BF1283211
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2D76034;
	Thu, 21 Mar 2024 12:05:24 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA26E602;
	Thu, 21 Mar 2024 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022723; cv=none; b=IE5kjOkDepMKJfxnetrE505ghhovp+xeogmlUyMx2gM2WKIn1531SYyF1UMnZjFxLXIV36T84fOrFngZWCTxsx2Xr5KjDPCB6rdeLWy2/BWkp1MdDyYCrw+GSJlbzGq1h7Heq4ChK/AU87X9UHoU3UXIY6ThhBRaRY/0yVMd/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022723; c=relaxed/simple;
	bh=EERyoR1JLibpqXpHBJIxplkz5PbGSchJCH8HqFMz73k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4c2UBBedDp6QWnx+83vH7ULKK9xUqnND0B8p1NMJYbJexzE7Uzhk758NAlHGUT7A9mMnpK6cDMGoHXvsS0XKAzPCYAKACrCQ5Dg7ZsKTTBbpwd26gWwEhkHIi0EhsTX2y5CLzzYd8V1NM8U7z2YdZElQ3C1iTuYxrGilxnDyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [172.20.10.9] (unknown [176.59.168.90])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4V0kfq1c5wzqSPm;
	Thu, 21 Mar 2024 15:05:07 +0300 (MSK)
Message-ID: <bec13e5c-0632-4841-adf9-38a47d290ffd@astralinux.ru>
Date: Thu, 21 Mar 2024 15:04:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Content-Language: ru
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240320125635.1444-1-abelova@astralinux.ru>
 <Zfrmv4u0tVcYGS5n@nanopsycho>
 <b67f3efb-509e-4280-90f2-729d217c20c7@astralinux.ru>
 <ZfwSmlZ-Ie1dFlue@nanopsycho>
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <ZfwSmlZ-Ie1dFlue@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehnrghsthgrshhirgcuuegvlhhovhgruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepkeetkefhhedugfekfeevteefuedufffggedvheetgedtgefhleeghfeghfekledtnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppedujeeirdehledrudeikedrledtnecurfgrrhgrmhephhgvlhhopegludejvddrvddtrddutddrlegnpdhinhgvthepudejiedrheelrdduieekrdeltdemgeehfeefvddpmhgrihhlfhhrohhmpegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeejpdhrtghpthhtohepjhhirhhisehrvghsnhhulhhlihdruhhspdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
 hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12528151, Updated: 2024-Mar-21 09:51:42 UTC]



21/03/24 13:57, Jiri Pirko пишет:
> Thu, Mar 21, 2024 at 10:36:53AM CET, abelova@astralinux.ru wrote:
>>
>> 20/03/24 16:38, Jiri Pirko пишет:
>>> Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
>>>> skb is an optional parameter, so it may be NULL.
>>>> Add check defore dereference in eth_hdr.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>> Either drop this line which provides no value, or attach a link to the
>>> actual report.
>>>
>> It is an established practice for our project. You can find 700+ applied
>> patches with similar line:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=linuxtesting.org
> Okay. So would it be possible to attach a link to the actual report?

Unfortunately no as far as results of the SVACE static analysis tool are
not available publicly at the moment.


Also I agree that this is quite a minor fix, but I still insist
that it would be better to add a check.

>
>>
>>>> Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
>>> This looks incorrect. I believe that this is the offending commit:
>>> commit 690e36e726d00d2528bc569809048adf61550d80
>>> Author: David S. Miller <davem@davemloft.net>
>>> Date:   Sat Aug 23 12:13:41 2014 -0700
>>>
>>>       net: Allow raw buffers to be passed into the flow dissector.
>>>
>> Got it.
>>
>>>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>>>> ---
>>>> net/core/flow_dissector.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>>>> index 272f09251343..05db3a8aa771 100644
>>>> --- a/net/core/flow_dissector.c
>>>> +++ b/net/core/flow_dissector.c
>>>> @@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
>>>> 		rcu_read_unlock();
>>>> 	}
>>>>
>>>> -	if (dissector_uses_key(flow_dissector,
>>>> +	if (skb && dissector_uses_key(flow_dissector,
>>>> 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
>>>> 		struct ethhdr *eth = eth_hdr(skb);
>>>> 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
>>> Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
>>> FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?
>> I agree, I'll send the second version.
>>
>> Anastasia Belova
>>



