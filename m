Return-Path: <linux-kernel+bounces-136733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A824889D7B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F4C1F24F02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7BE7D3E8;
	Tue,  9 Apr 2024 11:18:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2684D02
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661487; cv=none; b=cffkuRV0gpi+mMhGatNuiHXnVlzwvuzxnjnRBW52s+7ilqsIAZMXlTLDF397TXwG2aujWMsyWFnFYc1NitGD/6tXfEuscfD4DYOlHrnOeIO1CvDtGkNZ8DOwNSPDccAPIl1fp+BUj7Tg0eWstP+6S9o145nKpgh/aB2pK+hFILk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661487; c=relaxed/simple;
	bh=eeWEVJVftQIYGIeFfQPuu7VDG7lFVceItNQBy+NQGr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKUmV/Zo5Ez2LgotWfmfF8dJ6ENb3iYGeJVB0+BHe5tsi0BCQarNgPVRUQEz/hdW0sz+Ul+FP7Oce28xhsVxxML+X+iU0jxtqZzjGumq6US9P0IsxHJDCIIjpkNmyhPdVy+bj0LuVBbVb00UE5V2jvGdPJrBLv9xvQWTeV7+yLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1263ADA7;
	Tue,  9 Apr 2024 04:18:35 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB2F3F766;
	Tue,  9 Apr 2024 04:18:02 -0700 (PDT)
Message-ID: <8a7f0218-39e3-4e4b-ba99-7fe4389fb703@arm.com>
Date: Tue, 9 Apr 2024 12:17:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Content-Language: en-GB
To: Mostafa Saleh <smostafa@google.com>,
 Aleksandr Aprelkov <aaprelkov@usergate.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Michael Shavit <mshavit@google.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240403053759.643164-1-aaprelkov@usergate.com>
 <ZhUbw6gAeBjpFz5C@google.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZhUbw6gAeBjpFz5C@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/04/2024 11:43 am, Mostafa Saleh wrote:
> Hi Aleksandr,
> 
> On Wed, Apr 03, 2024 at 12:37:59PM +0700, Aleksandr Aprelkov wrote:
>> If devm_add_action() returns ENOMEM, then MSIs allocated but
>> not freed on teardown.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 166bdbd23161 ("iommu/arm-smmu: Add support for MSI on SMMUv3")
>> Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
>> ---
>> v2: Use appropriate function for registration failure as
>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> suggested.
>>
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 41f93c3ab160..8800af041e5f 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3402,7 +3402,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>   	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>>   
>>   	/* Add callback to free MSIs on teardown */
>> -	devm_add_action(dev, arm_smmu_free_msis, dev);
>> +	ret = devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
>> +	if (ret)
>> +		dev_warn(dev, "failed to add free MSIs callback - falling back to wired irqs\n");
> 
> I am not sure that is the right fix, as allowing the driver to probe
> without MSIs, seems worse than leaking MSI memory.
> 
> IMHO, we can just add something like:
>      dev_err(smmu->dev, “Can’t allocate devm action, MSIs are never freed! !\n”) ;

Honestly I don't think this matters. If we ever really did fail to 
allocate 16 bytes, SLUB would already be screaming and spewing 
stacktraces, and the system is dead already.

> Also, we can’t unconditionally fallback to wired irqs if MSI exists,
> according to the user manual:
>      An implementation must support one of, or optionally both of,
>      wired interrupts and MSIs
>      ...
>      The discovery of support for wired interrupts is IMPLEMENTATION DEFINED.
> 
> We can add some logic, to check dt/acpi irqs and to choose to fallback
> or not based on that, but, if we get -ENOMEM, (especially early at
> probe) something really went wrong, so I am not sure it’s worth
> the complexity.

That logic already exists in arm_smmu_setup_unique_irqs() - the messages 
here are in the sense of "we're giving up on MSIs and falling back to 
trying whatever wired IRQs we may or may not have." The critical point 
is that we're not using MSIs for some potentially actionable reason, 
i.e. if the user does expect the system to be MSI-capable, then it could 
be an indication of perhaps a wrong or missing msi-parent, for which 
they may pursue a firmware fix. In other cases it's normal and expected 
not to use MSIs though (e.g. the system just doesn't have an ITS), so we 
don't want to be *too* noisy about it.

Thanks,
Robin.

> 
>>   }
>>   
>>   static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>> -- 
>> 2.34.1
>>
> Thanks,
> Mostafa

