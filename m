Return-Path: <linux-kernel+bounces-148333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A18A8112
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5101F21CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E1F13C67F;
	Wed, 17 Apr 2024 10:36:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D639A13C3EA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350199; cv=none; b=Z85BFfZy7WrKU8oLcHEuMYpLzB4TIltG6fAgCOQscrseLqBD48i1j1PI2In+g0mTSTh3zB0OVsslbOvPUQ7IOz9P0OjDA8vncF7HeKEI1r2F8ca5R5YdaeS3HrqWBJNnwDoWhSyBHmkjqO1xzgEYKNTPqERFKt6SrI7x2qDukeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350199; c=relaxed/simple;
	bh=wK3zkKd+UDmBzbfDsMuwS6Y4b8KUIj/36OIFXRYFiWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qif0lPZ/C6PxupChEHRSeplFjaVS8BUn//rFoBexuvFxFpnM4JhKmeOf/l7Eoz3N8qvHJRF6SjTQgsCg8tgRMzWVA6OM87mapWCokMJHwcubph/mtjMAxzCLFlIPRNrF9Xa38qTDZJt6IBuAvzgg9geRDCmMwtEtbx3d7aOfQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 215CC339;
	Wed, 17 Apr 2024 03:37:05 -0700 (PDT)
Received: from [10.57.19.189] (unknown [10.57.19.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D766C3F64C;
	Wed, 17 Apr 2024 03:36:35 -0700 (PDT)
Message-ID: <bb417978-06b4-4b2c-bcf6-a39601b079be@arm.com>
Date: Wed, 17 Apr 2024 11:36:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Vasant Hegde <vashegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Eric Wagner <ewagner12@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>
 <4ec76a54-cb83-40b1-a156-a6da3453da5c@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <4ec76a54-cb83-40b1-a156-a6da3453da5c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-04-16 1:44 pm, Vasant Hegde wrote:
> Robin,
> 
> On 4/16/2024 4:55 PM, Robin Murphy wrote:
>> On 2024-04-16 1:39 am, Jason Gunthorpe wrote:
>>> On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
>>>> On 2024-04-15 7:57 pm, Eric Wagner wrote:
>>>>> Apologies if I made a mistake in the first bisect, I'm new to kernel
>>>>> debugging.
>>>>>
>>>>> I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
>>>>> 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both 
>>>>> were good.
>>>>> Then I ran git bisect again with 
>>>>> e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
>>>>> as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good 
>>>>> and the
>>>>> bisect log is attached. It ended up at the same commit as before.
>>>>>
>>>>> I've also attached a picture of the boot screen that occurs when it 
>>>>> hangs.
>>>>> 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's 
>>>>> causing the
>>>>> problem.
> 
> .../...
> 
>>
>> "Failing" iommu_probe_device is merely how we tell ourselves that 
>> we're not interested in a device, and consequently tell the rest of 
>> the kernel it doesn't have an IOMMU (via device_iommu_mapped() 
>> returning false). This is normal and expected for devices which 
>> legitimately have no IOMMU in the first place; conversely we don't do 
>> a great deal for unexpected failures since those typically represent 
>> system-fatal conditions whatever we might try to do. We've never had 
>> much of a notion of expected failures when an IOMMU *is* present, but 
>> even then, denying any trace of the IOMMU and removing ourselves from 
>> the picture is clearly not the ideal way to approach that. We're 
>> running off a bus notifier (or even later), so ultimately our return 
>> value is meaningless; at that point the device already exists and has 
>> been added to its bus, we can't undo that.
>>
>> However it looks to be even more fun if failure occurs in *deferred* 
>> default domain creation via bus_iommu_probe(), since then we give up 
>> and dismiss the entire IOMMU. Except the x86 drivers ignore the return 
>> from iommu_device_register(), so further hilarity ensues...
>>
>> I think I've now satisfied myself that a simple fix for the core code 
>> is appropriate and will write that up now; one other thing I couldn't 
>> quite figure out is whether the AMD driver somehow prevents PASIDs 
>> being used while the group is attached to a non-identity (and 
>> non-nested) domain - that's probably one for Vasant to confirm.
> 
> AMD driver supports PASID with below domain type :
>    - Identity domain
>    - DMA translation mode (DMA and DMA_FQ) with AMD v2 page table 
> (amd_iommu=pgtbl_v2).
> 
> 
> Currently amd_iommu_def_domain_type() tries to put PASID capable devices 
> in identity domain mode. This is something to fix. Its in my TODO list. 
> I will try to get into it soon.
> 
> Hope this clarifies.

Ooh, I see you now have GIoV to allow that similarly to how SMMUv3 does 
it - that wasn't in the older version of the spec that I've previously 
been referring to :)

Can you confirm there's no hardware actually been made to the older 
spec, supporting v2 and PASIDs but *not* having GIoV? Otherwise, I think 
you'll still have the problem that if you use the GPA-SPA translation in 
the DTE to implement IOMMU_DOMAIN_DMA for the RID, it makes all the 
PASID GVA-GPA mappings useless for host SVA.

Cheers,
Robin.

