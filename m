Return-Path: <linux-kernel+bounces-106149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B187E9DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF881C20F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2E3BBCA;
	Mon, 18 Mar 2024 13:09:22 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E93BBC5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767362; cv=none; b=eUAi1M5BgwCM2ne30EgZJNW1kdsMi2EhO4gH3/yaXMoVpjZ2K1FGl/CbNUOYChpO7Y8S07x06mNSaIJVoSBDdL5CIsGapFrMfDl5TRXMEYjNqMHHzXJzrjB8bsxyuGU5Ihsanfv19G+k8aMqiFs3jU3t96em8gz/wIM/XRLv+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767362; c=relaxed/simple;
	bh=zVKoSp9MJ5rj38NlbSUrwPP0dgLqjGy1AqRmOpBYZzU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LZsKvXpcDGVsp5rnJJCP7K/pV2XiP885/RA6wENztdvHMC47AlykDNP0gPzKHtRoxBTS/EpV481tjQIUK9xaX/ur1fA2DDfJrCWuj0xVlILp3tp56gY2NRjGqz2N2JEnTSGjyjqfR/RMdlsLDZgVOLmX+64s3degsT19slXN70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Tyvsv4yQqz9xHvc
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:53:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 03501140124
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:09:17 +0800 (CST)
Received: from [10.81.220.121] (unknown [10.81.220.121])
	by APP2 (Coremail) with SMTP id GxC2BwCHcyf1PPhlpmyFBA--.45229S2;
	Mon, 18 Mar 2024 14:09:16 +0100 (CET)
Message-ID: <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
Date: Mon, 18 Mar 2024 14:09:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
 <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCHcyf1PPhlpmyFBA--.45229S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF18Wr17tF1rGr17Cr4kZwb_yoW8AFWUpF
	s3Ga18tFZFgF12vanrXa4qvr4xKa9rt3W7CrsrA34Fvr1q9FyfArW5KwnrCw1j9rWrKa1f
	tFWYyr9rAws8Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

On 3/12/2024 4:07 PM, Petr Tesarik wrote:
> On 2/23/2024 3:04 PM, Petr Tesarik wrote:
>> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>>
>> If a segmentation fault is caused by accessing an address in the vmalloc
>> area, check that the target page is present.
>>
>> Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
>> assumes that the fault is caused by a stale mapping and will be fixed by
>> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
>> a guard page, no mapping is created, and when the faulting instruction is
>> restarted, it will cause exactly the same fault again, effectively creating
>> an infinite loop.
> 
> Ping. Any comment on this fix?

I don't think I have seen a reply from you. If you did comment, then
your email has not reached me.

Please, can you confirm you have seen my patch?

Kind regards
Petr T

> Petr T
> 
>>
>> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>> ---
>>  arch/um/kernel/trap.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
>> index 6d8ae86ae978..d5b85f1bfe33 100644
>> --- a/arch/um/kernel/trap.c
>> +++ b/arch/um/kernel/trap.c
>> @@ -206,11 +206,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>>  	int err;
>>  	int is_write = FAULT_WRITE(fi);
>>  	unsigned long address = FAULT_ADDRESS(fi);
>> +	pte_t *pte;
>>  
>>  	if (!is_user && regs)
>>  		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
>>  
>>  	if (!is_user && (address >= start_vm) && (address < end_vm)) {
>> +		pte = virt_to_pte(&init_mm, address);
>> +		if (!pte_present(*pte))
>> +			page_fault_oops(regs, address, ip);
>>  		flush_tlb_kernel_vm();
>>  		goto out;
>>  	}
> 


