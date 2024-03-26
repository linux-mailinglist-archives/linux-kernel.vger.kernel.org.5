Return-Path: <linux-kernel+bounces-118420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2F488BA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09F8B22206
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C847EF09;
	Tue, 26 Mar 2024 06:34:50 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B28F66;
	Tue, 26 Mar 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434890; cv=none; b=rMFp+S2tFq+QbtcXVijeRx4Wqi5djZpaotj5WL8Dut88WDbZZ7T69PuZ790ZXsHwHYsYY0DegRRe8Rm+ZDRJ4UsdO8XVgqgVEck9CcEwF6qUS02fE2A4VQw2XaoBqFdxpac/ylGEY7A7xLOySnYrVWG5q7fcCrt2tFVj+pfpkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434890; c=relaxed/simple;
	bh=LrbkdzMjwwb8BnnnwkhHxKdMp/k+Ftblz/NexU7S31I=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uNSVmTPqvQ5aEZ7rluQ0D429S9zb/cusH7WhwXBjx9Ytx5ABvmBCwwK8qahKk2hRxgsqtRZf/Ll3mKwcLmUBwPxPMzaGrqLG1c9zSDoVq/9FjVe8bqx9IOaSgAiOfJ7s1mXDdT7KjLC2WC+2UN+mPwf85w2BHuUHWh/nQXPJTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V3g2106zLzXjmJ;
	Tue, 26 Mar 2024 14:31:53 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 550511402CB;
	Tue, 26 Mar 2024 14:34:38 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 14:34:37 +0800
Subject: Re: [PATCH] scsi: libsas: Add SMP request allocation handler callback
To: Jason Yan <yanaijie@huawei.com>, Damien Le Moal <dlemoal@kernel.org>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<john.g.garry@oracle.com>, <chenxiang66@hisilicon.com>
References: <20240325131751.1840329-1-liyihang9@huawei.com>
 <da4de4e0-6d13-4509-b288-a9d122d1c2d3@kernel.org>
 <e7612e81-dc44-7bc6-3bd2-0b71367408ec@huawei.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@huawei.com>, <yangxingui@huawei.com>,
	<liyihang9@huawei.com>
From: Yihang Li <liyihang9@huawei.com>
Message-ID: <bbf8376a-fcab-0aaf-e834-379a72672496@huawei.com>
Date: Tue, 26 Mar 2024 14:34:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e7612e81-dc44-7bc6-3bd2-0b71367408ec@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/3/25 22:21, Jason Yan wrote:
> On 2024/3/25 22:03, Damien Le Moal wrote:
>> On 3/25/24 22:17, Yihang Li wrote:
>>> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
>>> (from 128).
>>
>> And ? What is the point you are trying to convey here ?
>>
>>> The hisi_sas has special requirements on the memory address alignment
>>> (must be 16-byte-aligned) of the command request frame, so add a SMP
>>> request allocation callback and fill it in for the hisi_sas driver.
>>
>> 128 is aligned to 16. So what is the problem you are trying to solve here ?
>> Can you clarify ? I suspect this is all about memory allocation optimization ?
> 
> After series [1] been merged, kmalloc is 8-byte-aligned, however hisi_sas hardware needs 16-byte-aligned. That's the problem.

Yes, that's the problem. I will explain it in detail in the next version.

> 
>>
>>>
>>> Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
>>> Signed-off-by: Yihang Li <liyihang9@huawei.com>
>>> ---
>>>   drivers/scsi/hisi_sas/hisi_sas_main.c | 14 ++++++++++++
>>>   drivers/scsi/libsas/sas_expander.c    | 31 ++++++++++++++++++---------
>>>   include/scsi/libsas.h                 |  3 +++
>>>   3 files changed, 38 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> index 097dfe4b620d..40329558d435 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> @@ -2031,6 +2031,19 @@ static int hisi_sas_write_gpio(struct sas_ha_struct *sha, u8 reg_type,
>>>                   reg_index, reg_count, write_data);
>>>   }
>>>   +static void *hisi_sas_alloc_smp_req(int size)
>>> +{
>>> +    u8 *p;
>>> +
>>> +    /* The address must be 16-byte-aligned. */
>>
>> ARCH_DMA_MINALIGN is not always 16, right ?
>>
>>> +    size = ALIGN(size, ARCH_DMA_MINALIGN);
>>> +    p = kzalloc(size, GFP_KERNEL);
>>> +    if (p)
>>> +        p[0] = SMP_REQUEST;
>>> +
>>> +    return p;
>>> +}
>>> +
>>>   static void hisi_sas_phy_disconnected(struct hisi_sas_phy *phy)
>>>   {
>>>       struct asd_sas_phy *sas_phy = &phy->sas_phy;
>>> @@ -2130,6 +2143,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
>>>       .lldd_write_gpio    = hisi_sas_write_gpio,
>>>       .lldd_tmf_aborted    = hisi_sas_tmf_aborted,
>>>       .lldd_abort_timeout    = hisi_sas_internal_abort_timeout,
>>> +    .lldd_alloc_smp_req    = hisi_sas_alloc_smp_req,
>>
>> Why this complexity ? Why not simply modify alloc_smp_req() to have the required
>> alignment ? This will avoid a costly indirect function call.
> 
> Yeah, I think it's simpler to modify alloc_smp_req() directly too. Yihang, Can you please cook a new one?

Sure, I will post a new version later.
The reason why I did not directly modify alloc_smp_req() is that I think the requirement that the command frame must be 16-byte aligned is hisi_sas private and not a general requirement.
To avoid the impact on other drivers, I only add aligned to 16B in hisi_sas. If this measure is considered pointless, I will directly modify alloc_smp_req().

Thanks,
Yihang

> 
> Thansk,
> Jason
> .
> 

