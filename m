Return-Path: <linux-kernel+bounces-136808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80689D879
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B76287CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B891292DC;
	Tue,  9 Apr 2024 11:47:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA93127B67
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663223; cv=none; b=A7rYvrvFsmDahui6VvMfMEnupNJGbogsZSVgUWr6TS66q/c0cLUfidTuILFHoYC3EUK/cvKiNMoiJXUNN/oQxzBvAxx0E7jXiNHoLGpHpVC5iM3Lvg1v13XkN4JoiB+8GONFgDAm3vAiRrNnycUsSjP0Uc2IqQSxI9+45ub14qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663223; c=relaxed/simple;
	bh=i5AH29WhKinYbSz33pvKiQWhYew5DFICwVHBn8QBFcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNlc6mHO6yxXDN6UlAHxhgYDkavzzV6nWNKtKOs2nGfge44K/+idFtJ/phVDBWNVp72EoyF99fqNPu53pFccrSTAL8D7dSerlCtmAgb3mdX1g2KQUqguq0P8+S2SgHdMNszvEsqLGWkQjZucc89brlJT7KAxl7ZjygjGTlZeZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349A51007;
	Tue,  9 Apr 2024 04:47:31 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94BEF3F766;
	Tue,  9 Apr 2024 04:46:59 -0700 (PDT)
Message-ID: <2af66586-c528-43be-adee-e1eb6baf00fd@arm.com>
Date: Tue, 9 Apr 2024 12:46:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Content-Language: en-GB
To: Mostafa Saleh <smostafa@google.com>
Cc: Aleksandr Aprelkov <aaprelkov@usergate.com>, Will Deacon
 <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Michael Shavit <mshavit@google.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240403053759.643164-1-aaprelkov@usergate.com>
 <ZhUbw6gAeBjpFz5C@google.com> <8a7f0218-39e3-4e4b-ba99-7fe4389fb703@arm.com>
 <ZhUnK1-Pvcix5dyI@google.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZhUnK1-Pvcix5dyI@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/04/2024 12:31 pm, Mostafa Saleh wrote:
> Hi Robin,
> 
> On Tue, Apr 09, 2024 at 12:17:54PM +0100, Robin Murphy wrote:
>> On 09/04/2024 11:43 am, Mostafa Saleh wrote:
>>> Hi Aleksandr,
>>>
>>> On Wed, Apr 03, 2024 at 12:37:59PM +0700, Aleksandr Aprelkov wrote:
>>>> If devm_add_action() returns ENOMEM, then MSIs allocated but
>>>> not freed on teardown.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>
>>>> Fixes: 166bdbd23161 ("iommu/arm-smmu: Add support for MSI on SMMUv3")
>>>> Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
>>>> ---
>>>> v2: Use appropriate function for registration failure as
>>>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> suggested.
>>>>
>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> index 41f93c3ab160..8800af041e5f 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> @@ -3402,7 +3402,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>>>    	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>>>>    	/* Add callback to free MSIs on teardown */
>>>> -	devm_add_action(dev, arm_smmu_free_msis, dev);
>>>> +	ret = devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
>>>> +	if (ret)
>>>> +		dev_warn(dev, "failed to add free MSIs callback - falling back to wired irqs\n");
>>>
>>> I am not sure that is the right fix, as allowing the driver to probe
>>> without MSIs, seems worse than leaking MSI memory.
>>>
>>> IMHO, we can just add something like:
>>>       dev_err(smmu->dev, “Can’t allocate devm action, MSIs are never freed! !\n”) ;
>>
>> Honestly I don't think this matters. If we ever really did fail to allocate
>> 16 bytes, SLUB would already be screaming and spewing stacktraces, and the
>> system is dead already.
>>
>>> Also, we can’t unconditionally fallback to wired irqs if MSI exists,
>>> according to the user manual:
>>>       An implementation must support one of, or optionally both of,
>>>       wired interrupts and MSIs
>>>       ...
>>>       The discovery of support for wired interrupts is IMPLEMENTATION DEFINED.
>>>
>>> We can add some logic, to check dt/acpi irqs and to choose to fallback
>>> or not based on that, but, if we get -ENOMEM, (especially early at
>>> probe) something really went wrong, so I am not sure it’s worth
>>> the complexity.
>>
>> That logic already exists in arm_smmu_setup_unique_irqs() - the messages
>> here are in the sense of "we're giving up on MSIs and falling back to trying
>> whatever wired IRQs we may or may not have." The critical point is that
>> we're not using MSIs for some potentially actionable reason, i.e. if the
>> user does expect the system to be MSI-capable, then it could be an
>> indication of perhaps a wrong or missing msi-parent, for which they may
>> pursue a firmware fix. In other cases it's normal and expected not to use
>> MSIs though (e.g. the system just doesn't have an ITS), so we don't want to
>> be *too* noisy about it.
> 
> The case I am worried about in this patch, is for systems with
> MSIs only.
> With this patch, that means, we fallback to wired irqs which don't
> exist, so the driver will probe with no interrupts at all, which in my
> opinion worse than leaking the memory.

True, the logic looks a bit off at first glance - I was halfway through 
writing a reply to that effect - but then if you look past the reality 
that this is all academic since it's never really going to happen 
anyway, if we *did* fail to allocate 16 bytes here, there's an 
incredibly high chance that immediately proceeding into 
iommu_device_sysfs_add() is also going to result in another (larger) 
allocation failure which ends up aborting the whole probe anyway. Plus 
the chance of subsequently being able to allocate any 
domains/pagetables/etc. for any meaningful IOMMU usage would seem slim.

Honestly I'd be inclined to do nothing more than add the _or_reset to 
shut the static checkers up, and not waste code and data on a useless 
message for a theoretical condition at all.

Cheers,
Robin.

