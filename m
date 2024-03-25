Return-Path: <linux-kernel+bounces-117241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A888A903
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943761C61824
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A46155722;
	Mon, 25 Mar 2024 14:21:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192D12FF7B;
	Mon, 25 Mar 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376515; cv=none; b=QHGb/mb1UYeAVCISSCjqg+XQvIAAzUk0bjm4kFChu8v3tnmov7dbhUv4PpPs8RECVYxAA86bqgrtDsG2ruwa0I4tLz9XoaflSEbdEMS22s7ge5hCQsysYVNLT9DbZ8JIU+vjXvLZw1fF9wJ2hyWJU71ulFPJfp3DMEyhCwLMV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376515; c=relaxed/simple;
	bh=remlzvMPT/QCPT/BdyHqvjUubqtO2O/mnAw+udlqkt0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aNQ3z6McWqDhMRTeUT3j4m9K/WRzodiVRHjkPJuBcYgsNNiH6gUpR0Fsy4hXO+CQU70//YWtGdEF5hNaafWvkIqlRo8+ocoNqj1KAmLSd8RHym78L/tfLJy9s1fcSCfNT9aj0aOH0rgI1ooq8Wpz2xRBNH9vnkj7cANcoFrz9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V3FV76DKfz1GD06;
	Mon, 25 Mar 2024 22:21:19 +0800 (CST)
Received: from canpemm500008.china.huawei.com (unknown [7.192.105.151])
	by mail.maildlp.com (Postfix) with ESMTPS id B6D541A0172;
	Mon, 25 Mar 2024 22:21:48 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 22:21:48 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 22:21:47 +0800
Subject: Re: [PATCH] scsi: libsas: Add SMP request allocation handler callback
To: Damien Le Moal <dlemoal@kernel.org>, Yihang Li <liyihang9@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<john.g.garry@oracle.com>, <chenxiang66@hisilicon.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@huawei.com>, <yangxingui@huawei.com>
References: <20240325131751.1840329-1-liyihang9@huawei.com>
 <da4de4e0-6d13-4509-b288-a9d122d1c2d3@kernel.org>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <e7612e81-dc44-7bc6-3bd2-0b71367408ec@huawei.com>
Date: Mon, 25 Mar 2024 22:21:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <da4de4e0-6d13-4509-b288-a9d122d1c2d3@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/25 22:03, Damien Le Moal wrote:
> On 3/25/24 22:17, Yihang Li wrote:
>> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
>> (from 128).
> 
> And ? What is the point you are trying to convey here ?
> 
>> The hisi_sas has special requirements on the memory address alignment
>> (must be 16-byte-aligned) of the command request frame, so add a SMP
>> request allocation callback and fill it in for the hisi_sas driver.
> 
> 128 is aligned to 16. So what is the problem you are trying to solve here ?
> Can you clarify ? I suspect this is all about memory allocation optimization ?

After series [1] been merged, kmalloc is 8-byte-aligned, however 
hisi_sas hardware needs 16-byte-aligned. That's the problem.

> 
>>
>> Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
>> Signed-off-by: Yihang Li <liyihang9@huawei.com>
>> ---
>>   drivers/scsi/hisi_sas/hisi_sas_main.c | 14 ++++++++++++
>>   drivers/scsi/libsas/sas_expander.c    | 31 ++++++++++++++++++---------
>>   include/scsi/libsas.h                 |  3 +++
>>   3 files changed, 38 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
>> index 097dfe4b620d..40329558d435 100644
>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>> @@ -2031,6 +2031,19 @@ static int hisi_sas_write_gpio(struct sas_ha_struct *sha, u8 reg_type,
>>   				reg_index, reg_count, write_data);
>>   }
>>   
>> +static void *hisi_sas_alloc_smp_req(int size)
>> +{
>> +	u8 *p;
>> +
>> +	/* The address must be 16-byte-aligned. */
> 
> ARCH_DMA_MINALIGN is not always 16, right ?
> 
>> +	size = ALIGN(size, ARCH_DMA_MINALIGN);
>> +	p = kzalloc(size, GFP_KERNEL);
>> +	if (p)
>> +		p[0] = SMP_REQUEST;
>> +
>> +	return p;
>> +}
>> +
>>   static void hisi_sas_phy_disconnected(struct hisi_sas_phy *phy)
>>   {
>>   	struct asd_sas_phy *sas_phy = &phy->sas_phy;
>> @@ -2130,6 +2143,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
>>   	.lldd_write_gpio	= hisi_sas_write_gpio,
>>   	.lldd_tmf_aborted	= hisi_sas_tmf_aborted,
>>   	.lldd_abort_timeout	= hisi_sas_internal_abort_timeout,
>> +	.lldd_alloc_smp_req	= hisi_sas_alloc_smp_req,
> 
> Why this complexity ? Why not simply modify alloc_smp_req() to have the required
> alignment ? This will avoid a costly indirect function call.

Yeah, I think it's simpler to modify alloc_smp_req() directly too. 
Yihang, Can you please cook a new one?

Thansk,
Jason

