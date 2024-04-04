Return-Path: <linux-kernel+bounces-131492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5CA898899
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4461C218A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B21272CB;
	Thu,  4 Apr 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cBv5OokM"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA9823C3;
	Thu,  4 Apr 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236351; cv=none; b=qnRpyXaMGVvLzLHNh+0w+W86XMvvBtHJmCGuhThaFgx1XPTFs6FpebzjIPEm2+Ozp0kZIgLVQt1+jqESaH0chFAcynGeRReKju/PpauxLd+dsEioBq6MFr+YSbgPnEDU0eghskWg/b8bdvc3lBXJM8mQ0qTta6KzN/wRJIfj3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236351; c=relaxed/simple;
	bh=E2Ym1kUqVzjOH0XmO1ZZvC5uU8KCJxej7UD8A9ggl18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6h7mYVW/ww84Q43dKZhVAZYVA/lSI6HBG4/a0FQ205t1D3MD1f9ZTVTc8oUHgl/k3Wi1PthDDC0xHxY7g+E15LlgJyAgpcHFYNwZ3ruL8h8ElwnOavckZeuakENdG1ZR2lDH0kbXx3OjzWodZW/mGxrTKg7woQjNv1HI7IRVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cBv5OokM; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712236339; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xOnC9TcmNIYHT66WMGU1uDCwRMaiasXF54VBLXYtEEM=;
	b=cBv5OokM8O5FYXFYhnOIT4yywgochNztR/YZyh3spUC7GaxHZ6dS7n6rD8yjSxD0LfV6ENQriRk29vKw4tK3L4T+D6rqsxK+yovoTPtpPIYKyRPhgC2ieQMv+nlvwpMVt+Bg4ODvX9vdk4iKHyM6rulSPM6CtPIjzw+4GK631OA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W3uXYZ-_1712236337;
Received: from 30.236.60.242(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W3uXYZ-_1712236337)
          by smtp.aliyun-inc.com;
          Thu, 04 Apr 2024 21:12:19 +0800
Message-ID: <7a0fc481-658e-4c99-add7-ccbd5f9dce1e@linux.alibaba.com>
Date: Thu, 4 Apr 2024 21:12:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 04/11] net/smc: implement some unsupported
 operations of loopback-ism
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <20240324135522.108564-5-guwen@linux.alibaba.com>
 <3122eece5b484abcf8d23f85d6c18c36f0b939ff.camel@linux.ibm.com>
 <1db6ccab-b49f-45d2-a93c-05b0f79371a3@linux.alibaba.com>
 <3b3ff37643e9030ec1246e67720683a2cf5660e5.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <3b3ff37643e9030ec1246e67720683a2cf5660e5.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/4 19:42, Niklas Schnelle wrote:
> On Thu, 2024-04-04 at 17:32 +0800, Wen Gu wrote:
>>
>> On 2024/4/4 00:25, Gerd Bayer wrote:
>>> On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
>>>> This implements some operations that loopback-ism does not support
>>>> currently:
>>>>    - vlan operations, since there is no strong use-case for it.
>>>>    - signal_event operations, since there is no event to be processed
>>>> by the loopback-ism device.
>>>
>>> Hi Wen,
>>>
>>> I wonder if the these operations that are not supported by loopback-ism
>>> should rather be marked "optional" in the struct smcd_ops, and the
>>> calling code should call these only when they are implemented.
>>>
>>> Of course this would mean more changes to net/smc/smc_core.c - but
>>> loopback-ism could omit these "boiler-plate" functions.
>>>
>>
>> Hi Gerd.
>>
>> Thank you for the thoughts! I agree that checks like 'if(smcd->ops->xxx)'
>> can avoid the device driver from implementing unsupported operations. But I
>> am afraid that which operations need to be defined as 'optional' may differ
>> from different device perspectives (e.g. for loopback-ism they are vlan-related
>> opts and signal_event). So I perfer to simply let the smc protocol assume
>> that all operations have been implemented, and let drivers to decide which
>> ones are unsupported in implementation. What do you think?
>>
>> Thanks!
>>
> 
> I agree with Gerd, in my opinion it is better to document ops as
> optional and then allow their function pointers to be NULL and check
> for that. Acting like they are supported and then they turn out to be
> nops to me seems to contradict the principle of least surprises. I also
> think we can find a subset of mandatory ops without which SMC-D is
> impossible and then everything else should be optional.

I see. If we all agree to classify smcd_ops into mandatory and optional ones,
I'll add a patch to mark the optional ops and check if they are implemented.

> 
> As a first guess I think the following options may be mandatory:
> 
> * query_remote_gid()
> * register_dmb()/unregister_dmb()
> * move_data()
>    For this one could argue that either move_data() or
>    attach_dmb()/detach_dmb() is required though personally I would
>    prefer to always have move_data() as a fallback and simple API
> * supports_v2()
> * get_local_gid()
> * get_chid()
> * get_dev()
I agree with this classification. Just one point, maybe we can take
supports_v2() as an optional ops, like support_dmb_nocopy()? e.g. if
it is not implemented, we treat it as an ISMv1.

Thanks!

>>>

