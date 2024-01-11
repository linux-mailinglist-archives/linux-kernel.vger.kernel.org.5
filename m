Return-Path: <linux-kernel+bounces-23816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18882B222
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F08C1F254D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F24F4F89C;
	Thu, 11 Jan 2024 15:50:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C74F88D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2C842F4;
	Thu, 11 Jan 2024 07:51:39 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33F133F5A1;
	Thu, 11 Jan 2024 07:50:53 -0800 (PST)
Message-ID: <016e052e-8a99-4d60-b864-87c9859953f2@arm.com>
Date: Thu, 11 Jan 2024 15:50:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommufd/selftest: Use right iommu_ops for mock device
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240111073213.180020-1-baolu.lu@linux.intel.com>
 <20240111144840.GW50608@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240111144840.GW50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/01/2024 2:48 pm, Jason Gunthorpe wrote:
> On Thu, Jan 11, 2024 at 03:32:13PM +0800, Lu Baolu wrote:
>> In the iommu probe device path, __iommu_probe_device() gets the iommu_ops
>> for the device from dev->iommu->fwspec if this field has been initialized
>> before probing. Otherwise, it will lookup the global iommu device list
>> and use the iommu_ops of the first iommu device which has no
>> dev->iommu->fwspec. This causes the wrong iommu_ops to be used for the mock
>> device on x86 platforms where dev->iommu->fwspec is not used.
>>
>> Preallocate the fwspec for the mock device so that the right iommu ops can
>> be used.
> 
> I really don't like this.
> 
> The lifecycle model for fwspec is already a bit confusing. Introducing
> a new case where a driver pre-allocates the fwspec is making it worse,
> not better.
> 
> eg iommu_init_device() error unwind will free this allocated fwspec
> leaving the device broken. We don't have the concept of a fwspec that
> is owned by the device, it is really owned by the probing code.

As I've tried to explain before, this is in fact the correct use of 
fwspec as originally designed, i.e. being set up by *bus code* before 
device_add() (remember this is not the "IOMMU driver" part of selftest.c).

Indeed for perfect symmetry the bus code would free the fwspec after the 
corresponding device_del() returns, but there's no harm in that being 
factored into iommu_release_device() since the notifier call occurs 
sufficiently late in device_del() itself as to make no practical difference.

I'm working to get things back to that model (wherein the dev_iommu and 
fwspec lifecycles become trivial), just with the slight tweak that these 
days it's going to make more sense to have the initialisation factored 
into device_add() itself (via iommu_probe_device()), rather than beforehand.

Thanks,
Robin.

> The fundamental issue is we now have a special kind of driver:
> 
> 	fwspec = dev_iommu_fwspec_get(dev);
> 	if (fwspec && fwspec->ops)
> 		ops = fwspec->ops;
> 	else
> 		ops = iommu_ops_from_fwnode(NULL);
>                                             ^^^^^^^^
> 
> Which represents a "global" non-fwspec using driver that will only
> bind to devices that didn't parse into a fwspec.
> 
> The code above supports only one of these drivers at time, but allows
> more than one to be registered - it is inconsistent.
> 
> I think the right/easy answer is to iterate over all the "global"
> drivers and call their probe instead of just the first one.
> 
> Especially since my approach over here migrates the whole thing to work
> by iterating:
> 
> https://lore.kernel.org/all/0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com/
> 
> And this patch:
> 
> https://lore.kernel.org/all/28-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com/
> 
> Is how I made the iterating logic, it could be pulled out and tidied a
> bit.
> 
> Jason

