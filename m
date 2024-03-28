Return-Path: <linux-kernel+bounces-122567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A8188F9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF9F1F277B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045441C62;
	Thu, 28 Mar 2024 08:11:42 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D833C0B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613502; cv=none; b=UBdkI7374TLFZCji6UE5oQSpen7veRMfDGJ6+9LrnCwx1vowWWEcioDvvQpZs6XXVjxKJs1jZd41KrgVhtN//u1YsotAR06dp4LuBilZyuIoL/OLqHuive61UnWMGiAYglqByEcb5cDFsfT/z/FNZfKD24Nk4OjsYov8ayCX2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613502; c=relaxed/simple;
	bh=Y82VdzFzmjXfxBXVodOSz/QFARL593f+ckQ6qJTqgoU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RlWqm5aLzEed2mjRH5loTiEQZv1w45dwgOPx8KRoW29I/DQRynsyueHFWoUn+ES7psuOcYHpE68h5iHPH7ah+jUmV/qnna+dtMw5SH1agNyEnazBHHfFpgrb+FvBwFPmISumFMg4iOGAz0HG6GOOE0fdvBcGbfXhKiQOuik18V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4V4wnR1SkTz9xrdp
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:55:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 6888E140893
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:11:25 +0800 (CST)
Received: from [10.81.206.1] (unknown [10.81.206.1])
	by APP2 (Coremail) with SMTP id GxC2BwD3LyQlJgVmWJYbBQ--.7342S2;
	Thu, 28 Mar 2024 09:11:24 +0100 (CET)
Message-ID: <a8e2444e-7fab-485e-975b-6563504f3efa@huaweicloud.com>
Date: Thu, 28 Mar 2024 09:11:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering winch
 IRQ
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
 <2d70513e9f84e650ef1ede5a8ae5960a9de782bc.camel@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <2d70513e9f84e650ef1ede5a8ae5960a9de782bc.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwD3LyQlJgVmWJYbBQ--.7342S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy8KF4kWr4fZrykGF4rXwb_yoW8Kry8pF
	WDKasakrWFq3W09anrXan0yF97Aws7Gr1Uur1kK3y5Zryqvr9aqF1rGa4agF1DCry7Jr93
	Xr4rCa9xuFZ8AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj5vieQACsm

On 3/7/2024 1:43 PM, Roberto Sassu wrote:
> On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Registering a winch IRQ is racy, an interrupt may occur before the winch is
>> added to the winch_handlers list.
>>
>> If that happens, register_winch_irq() adds to that list a winch that is
>> scheduled to be (or has already been) freed, causing a panic later in
>> winch_cleanup().
>>
>> Avoid the race by adding the winch to the winch_handlers list before
>> registering the IRQ, and rolling back if um_request_irq() fails.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Fixes: 42a359e31a0e ("uml: SIGIO support cleanup")
> 
> I see that before that commit there was the same ordering (list_add()
> before um_request_irq()).
> 
> Failure from um_request_irq() should not result in executing
> winch_interrupt() which could call list_del() itself. Then, it should
> be fine to delete the winch in the error path.

Richard, did you have time to look at this?

Thanks

Roberto

> Roberto
> 
>> ---
>>   arch/um/drivers/line.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
>> index ffc5cb92fa36..d82bc3fdb86e 100644
>> --- a/arch/um/drivers/line.c
>> +++ b/arch/um/drivers/line.c
>> @@ -676,24 +676,26 @@ void register_winch_irq(int fd, int tty_fd, int pid, struct tty_port *port,
>>   		goto cleanup;
>>   	}
>>   
>> -	*winch = ((struct winch) { .list  	= LIST_HEAD_INIT(winch->list),
>> -				   .fd  	= fd,
>> +	*winch = ((struct winch) { .fd  	= fd,
>>   				   .tty_fd 	= tty_fd,
>>   				   .pid  	= pid,
>>   				   .port 	= port,
>>   				   .stack	= stack });
>>   
>> +	spin_lock(&winch_handler_lock);
>> +	list_add(&winch->list, &winch_handlers);
>> +	spin_unlock(&winch_handler_lock);
>> +
>>   	if (um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
>>   			   IRQF_SHARED, "winch", winch) < 0) {
>>   		printk(KERN_ERR "register_winch_irq - failed to register "
>>   		       "IRQ\n");
>> +		spin_lock(&winch_handler_lock);
>> +		list_del(&winch->list);
>> +		spin_unlock(&winch_handler_lock);
>>   		goto out_free;
>>   	}
>>   
>> -	spin_lock(&winch_handler_lock);
>> -	list_add(&winch->list, &winch_handlers);
>> -	spin_unlock(&winch_handler_lock);
>> -
>>   	return;
>>   
>>    out_free:


