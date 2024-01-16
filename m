Return-Path: <linux-kernel+bounces-27683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDCE82F40F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB261F24B07
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F91CF92;
	Tue, 16 Jan 2024 18:19:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5225B1D543
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429148; cv=none; b=fyFh/aNu9vSpX9hPjbhn0C6kq54DGVv4x8u8ghgetl9vdMlapQQE/3mdqER0ACR+hqN6czZC8G8HLB65d4OQPT01Hx44mjYV8ZB8CQpwPQJEhH5V9AxGB/mAehxlYNtVELepPNn80qUzfyctP2vdN9XyQMc+OpNHbKF9RHUQtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429148; c=relaxed/simple;
	bh=Rz3I1lH5RQdCuuVTAh4WddpjwYP/Y3NtCklm/FBIa68=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=adIbT6DCTVYJgvwpiHQJydFW+hygzWFneJ8yloyBvad9b69W61vICeFsuhCZyNGkBHViediZ6RNlLvnTHwGmzROv/OAqDK2nAD0b6zT/YMcSjaDgPSiiVbr5gI4mLzFuCLH6XZLgZ4s4XhHLQBFoV+SHgc/1WlMO1i+5IlXzOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 253B52F4;
	Tue, 16 Jan 2024 10:19:49 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9D023F5A1;
	Tue, 16 Jan 2024 10:19:01 -0800 (PST)
Message-ID: <e08cd3b3-7ce0-47c9-b2f3-28095987f46b@arm.com>
Date: Tue, 16 Jan 2024 18:19:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommufd/selftest: Use right iommu_ops for mock device
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240111073213.180020-1-baolu.lu@linux.intel.com>
 <20240111144840.GW50608@ziepe.ca>
 <016e052e-8a99-4d60-b864-87c9859953f2@arm.com>
 <20240111155648.GX50608@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240111155648.GX50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/01/2024 3:56 pm, Jason Gunthorpe wrote:
> On Thu, Jan 11, 2024 at 03:50:51PM +0000, Robin Murphy wrote:
>> On 11/01/2024 2:48 pm, Jason Gunthorpe wrote:
>>> On Thu, Jan 11, 2024 at 03:32:13PM +0800, Lu Baolu wrote:
>>>> In the iommu probe device path, __iommu_probe_device() gets the iommu_ops
>>>> for the device from dev->iommu->fwspec if this field has been initialized
>>>> before probing. Otherwise, it will lookup the global iommu device list
>>>> and use the iommu_ops of the first iommu device which has no
>>>> dev->iommu->fwspec. This causes the wrong iommu_ops to be used for the mock
>>>> device on x86 platforms where dev->iommu->fwspec is not used.
>>>>
>>>> Preallocate the fwspec for the mock device so that the right iommu ops can
>>>> be used.
>>>
>>> I really don't like this.
>>>
>>> The lifecycle model for fwspec is already a bit confusing. Introducing
>>> a new case where a driver pre-allocates the fwspec is making it worse,
>>> not better.
>>>
>>> eg iommu_init_device() error unwind will free this allocated fwspec
>>> leaving the device broken. We don't have the concept of a fwspec that
>>> is owned by the device, it is really owned by the probing code.
>>
>> As I've tried to explain before, this is in fact the correct use of fwspec
>> as originally designed, i.e. being set up by *bus code* before device_add()
>> (remember this is not the "IOMMU driver" part of selftest.c).
> 
> I understand it was the intention, but it doesn't relaly match how the
> code works today..

The fact that some things aren't following the pattern, and are broken 
and problematic in several ways as a result, does not mean that other 
things that *can* follow the pattern correctly shouldn't.

>> Indeed for perfect symmetry the bus code would free the fwspec after the
>> corresponding device_del() returns, but there's no harm in that being
>> factored into iommu_release_device() since the notifier call occurs
>> sufficiently late in device_del() itself as to make no practical difference.
> 
> IIRC there were issues with leaking the dev_iommu :(

AFAICS there was only an issue introduced last year when some unrelated 
stuff added an erroneous early return to iommu_release_device() if no 
group was assigned, thus subtly broke the existing code (and it did end 
up getting fixed in a roundabout manner a couple of months later).

>> I'm working to get things back to that model (wherein the dev_iommu and
>> fwspec lifecycles become trivial), just with the slight tweak that these
>> days it's going to make more sense to have the initialisation factored into
>> device_add() itself (via iommu_probe_device()), rather than beforehand.
> 
> I would prefer to simply remove fwspec as I've already shown patches
> for. You should give some comment on them.

You mean the 1600 lines of churn which did nothing to address any real 
problem (but did at least acknowledge so in the cover letter)? I thought 
I had responded to that, but it must have been one of the many drafts 
which end up getting deleted out of utter exasperation. Needless to say, 
the response was a NAK. For the last time, any fwspec lifetime issues 
are a *symptom* of a well-understood problem which exists, and not a 
problem in themselves. Yes, due to the evolution of the API there is 
also now some stuff being carried around in iommu_fwspec that really 
shouldn't need to be, but once probing is properly fixed it will get 
stripped back down to the useful shared abstraction of stored firmware 
data that has always been its true spirit. In the meantime, adding a 
load more complexity to unabstract it and support 2 or 3 different ways 
of drivers all individually open-coding storage of the same data is not 
helpful now, and even less helpful in future.

> My main complaint is there is no full vision to remove the 'global
> drivers', we will always have some drivers doing FW parsing in probe
> and then this different fwspec thing on the side for other drivers.

Honestly I would love to see the DMAR/IVRS parsing decoupled a bit more 
from the Intel/AMD drivers, not least in the hope that it might allow 
cleaner separation of the IRQ remapping drivers from the IOMMU API 
drivers. However I don't have my hopes up since in practice it's 
probably a non-trivial amount of work with no real functional benefit in 
the end, and it's certainly not something I'd ever have the time or 
inclination to attempt myself. The SoC drivers doing their own weird 
things to parse DT bindings will get cleaned up once arch/arm 
understands groups, and that *is* all on my to-do list (and as for the 
arm-smmu legacy binding, if it still gets in the way at all by that 
point I'll be inclined to call it obsolete and drop support).

Thanks,
Robin.

