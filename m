Return-Path: <linux-kernel+bounces-109859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536F8856A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE181F21A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC2654BDB;
	Thu, 21 Mar 2024 09:44:01 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63430C2E6;
	Thu, 21 Mar 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014241; cv=none; b=iL4sELiYtmgOWw48/3cAYxIJRollGp6QYP1aDY2NIpvd4oY9lSiFkcAWwxbbD5bOWSxpRpDf/peOqk/3RzlsGCD9l8zwP3I9y+T/yCtWrLHtY0QV1uv0UBJta5fHhw8jSw+0ibG5oLWhGF/uKWflU32uwytET3XslyPO0BEO7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014241; c=relaxed/simple;
	bh=pE1D1CwmKJCNu/grzQTR/2Ua4Iq0YHN5QiyjUaPNT0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Efk/XtfFITAdm/WZVGicVNgtNp3j6txK4QjApza5iqngxU8O2XZU9bozEsNKuI4B1jnuYeaNM4ZC1xxiCM7EQ3nNI2cKzOL3O/0HUtIcWRu/dYlzdmkalK+sElLErXV7HSBSjP6hwpEfUktqvBUeAEfA9qhFhmJ5jV4mxPxKvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [172.20.10.9] (unknown [176.59.43.255])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4V0gNc0YG3zqSPj;
	Thu, 21 Mar 2024 12:37:35 +0300 (MSK)
Message-ID: <b67f3efb-509e-4280-90f2-729d217c20c7@astralinux.ru>
Date: Thu, 21 Mar 2024 12:36:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240320125635.1444-1-abelova@astralinux.ru>
 <Zfrmv4u0tVcYGS5n@nanopsycho>
Content-Language: ru
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <Zfrmv4u0tVcYGS5n@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehnrghsthgrshhirgcuuegvlhhovhgruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepkeetkefhhedugfekfeevteefuedufffggedvheetgedtgefhleeghfeghfekledtnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppedujeeirdehledrgeefrddvheehnecurfgrrhgrmhephhgvlhhopegludejvddrvddtrddutddrlegnpdhinhgvthepudejiedrheelrdegfedrvdehheemheekieekvddpmhgrihhlfhhrohhmpegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeejpdhrtghpthhtohepjhhirhhisehrvghsnhhulhhlihdruhhspdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
 hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12528093, Updated: 2024-Mar-21 08:02:36 UTC]



20/03/24 16:38, Jiri Pirko пишет:
> Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
>> skb is an optional parameter, so it may be NULL.
>> Add check defore dereference in eth_hdr.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> Either drop this line which provides no value, or attach a link to the
> actual report.
>

It is an established practice for our project. You can find 700+ applied
patches with similar line:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=linuxtesting.org


>> Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
> This looks incorrect. I believe that this is the offending commit:
> commit 690e36e726d00d2528bc569809048adf61550d80
> Author: David S. Miller <davem@davemloft.net>
> Date:   Sat Aug 23 12:13:41 2014 -0700
>
>      net: Allow raw buffers to be passed into the flow dissector.
>

Got it.

>
>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> ---
>> net/core/flow_dissector.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>> index 272f09251343..05db3a8aa771 100644
>> --- a/net/core/flow_dissector.c
>> +++ b/net/core/flow_dissector.c
>> @@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
>> 		rcu_read_unlock();
>> 	}
>>
>> -	if (dissector_uses_key(flow_dissector,
>> +	if (skb && dissector_uses_key(flow_dissector,
>> 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
>> 		struct ethhdr *eth = eth_hdr(skb);
>> 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
> Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
> FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?

I agree, I'll send the second version.

Anastasia Belova


