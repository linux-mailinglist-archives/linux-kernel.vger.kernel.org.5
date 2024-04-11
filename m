Return-Path: <linux-kernel+bounces-140209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B440A8A0CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419CFB218FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E298145B13;
	Thu, 11 Apr 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CVVvhwES"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E11422C4;
	Thu, 11 Apr 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829414; cv=none; b=TW33NRQJi1EinsRF/B6EaT4Q/1iVG7vHOLK65TTeFjxm9vBdWyuapuep4TJzAd4nO5HPOhA44Kj6uS56va2BCJiCgTfhFo5p17qdhQQxnC0KJFkQgCiynsmXJoXULDCYTLFY2x1vlBwHIq1b0k6kw66x+UUjVJsw/RfYkN4QfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829414; c=relaxed/simple;
	bh=JisuNm5PdnQhqJTAX4I/4V5ER0EyXTdv9Mbeyuz+wzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRRcGn+7KxCKfaq38Myd1FKUtXPdeVCAZYr0Kd94mip4E9NrOwGKiG7IyUBLFhL1luPZMVhMXzpv9hg4uoM6nDegEGZ3b8EszdyYu17Nck4/K2adp7q7o8uK0gWuu+tHCH6qasyw/uolgCAQ4Jc5YYmryf5jPu1vmUg2Ssh8mT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CVVvhwES; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712829408; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vFOgTq/QwRApttd5rEXmIKzcIIfmxDlVKZH9cKLJh2c=;
	b=CVVvhwESLa/fTADWCYVzrZtFcIG/CVK02VPgsv0U2oPu//XKfNFJ8cvFnCUoTbFyrVMsH7FiNF5Uz2q2tmf+u6wHJV2CPPrTIBkvsoQigfiLrqUmtrhVjidzrD05+8r/ldyTP8Zo95E/Xiudzwr9APOckAZ3VKdxV3PSfwj0UqM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4KqBTo_1712829406;
Received: from 30.221.130.208(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4KqBTo_1712829406)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 17:56:47 +0800
Message-ID: <71fd5cae-b4d0-42c5-b03f-bf4e35301ebb@linux.alibaba.com>
Date: Thu, 11 Apr 2024 17:56:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Wenjia Zhang <wenjia@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 jaka@linux.ibm.com
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <ae3ea4bc-4a9c-416e-a593-2885fea96ae5@linux.alibaba.com>
 <27deaa5dbb30c467fcdaa0667ef39da86bcee03f.camel@linux.ibm.com>
 <fc274220-cb6e-43be-aa76-69e37449e535@linux.alibaba.com>
 <ddd181fc-307f-4c2f-bc9b-6941a17f16d9@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ddd181fc-307f-4c2f-bc9b-6941a17f16d9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/11 17:32, Wenjia Zhang wrote:
> 
> 
> On 11.04.24 09:45, Wen Gu wrote:
>>
>>
>> On 2024/4/3 19:10, Gerd Bayer wrote:
>>> On Wed, 2024-04-03 at 14:35 +0800, Wen Gu wrote:
>>>>
>>>>
>>>> On 2024/3/24 21:55, Wen Gu wrote:
>>>>> This patch set acts as the second part of the new version of [1]
>>>>> (The first
>>>>> part can be referred from [2]), the updated things of this version
>>>>> are listed
>>>>> at the end.
>>>>
>>>>> Change log:
>>>>>
>>>>> RFC v5->RFC v4:
>>>>> - Patch #2: minor changes in description of config SMC_LO and
>>>>> comments.
>>>>> - Patch #10: minor changes in comments and
>>>>> if(smc_ism_support_dmb_nocopy())
>>>>>     check in smcd_cdc_msg_send().
>>>>> - Patch #3: change smc_lo_generate_id() to smc_lo_generate_ids()
>>>>> and SMC_LO_CHID
>>>>>     to SMC_LO_RESERVED_CHID.
>>>>> - Patch #5: memcpy while holding the ldev->dmb_ht_lock.
>>>>> - Some expression changes in commit logs.
>>>>>
>>>>
>>>> Hi, Jan. Do you have any comments on this version and should I post a
>>>> new patch series without 'RFC'? Thank you.
>>>
>>> Hi Wen,
>>>
>>> Jan has been out sick for a little while now, and Wenjia is expected
>>> back from a longer vacation tomorrow. So if you could hold off until
>>> begin of next week, Wenjia might have some more feedback.
>>>
>>> In the meantime, I'm looking at your patchset...
>>>
>>> Thank you, Gerd
>>>
>>
>> Hi Gerd, is there any further information? I am wondering if I
>> should wait for more feedback from SMC maintainers. Thanks!
>>
>>
>> Hi Wenjia, when it's convenient for you, could you please confirm
>> if [1] and [2] need to be included in the next version? Thanks!
>>
>> [1] https://lore.kernel.org/netdev/7291dd1b2d16fd9bbd90988ac5bcc3a46d17e3f4.camel@linux.ibm.com/
>> [2] https://lore.kernel.org/netdev/60b4aec0b4bf4474d651b653c86c280dafc4518a.camel@linux.ibm.com/
>>
> 
> Hi Wen,
> 
> I'm just back, thank you for the patience!
> 
> Firstly I want to thank Gerd and Niklas for review and bringing up these points!
> 
> Here are some of my options on that:
> 
> To [1]:
> I agree to document the ops as otional if it must not be supported. Since I don't really have any ideas, the 
> classification souds reasonable to me. Going to the details, what about to take following options as mandatory:
> 
> * query_remote_gid()
> * register_dmb()/unregister_dmb()
> * move_data() : I do see the necessary here.
> * get_local_gid()
> * get_chid()
> * get_dev()
> 
> To [2]:
> I also agree to keep the ism-loopback at the very beginning of the List. That acting is also what I imaged previously. 
> Thank you, gerd, again for testing it and find it out!
> 
> Thanks,
> Wenjia

Hi Wenjia, welcome back! :)

OK, then I will take these in my next version. Thank you all!

