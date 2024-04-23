Return-Path: <linux-kernel+bounces-154980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1402D8AE3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378781C22BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337E82888;
	Tue, 23 Apr 2024 11:26:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA14823D9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871615; cv=none; b=JcMGIi1Ppx9/1CzT18QJ+hE+oiITdZR8qsMx2DOFgtIsKiFDeoyf0ry39Y8PRFC3uY+9/ost1LgZzlHDOt+Y52RHAWld/hJ1MuxFDTe1M3vU3hCnj3MquNa2g7snXF84VREdqz64yaSDsSu12jx7D4+fgu8e3zF+MAD8r/KR3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871615; c=relaxed/simple;
	bh=wJKPniY4/Ci5B83yC2QKM57byNuiwW1P7++ILqKKhzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4Yho/DxDs5I9T7QbJWcd0LmA6WB+7xgZZtQpUE75R2Pt60SQRHfRypTymm+Fo81KONMzVthnX7C72R6q6gqAGGFAprIXaw1p2Hz41PpuY3MXdF5sJLCDaO0t9FYp/QDq11nZFge4CPyEUXMK7ztog3n07oBGpnKKDoB4eUda4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0ABE339;
	Tue, 23 Apr 2024 04:27:21 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570B83F7BD;
	Tue, 23 Apr 2024 04:26:51 -0700 (PDT)
Message-ID: <3cf97e3c-c8d9-4282-a8ca-e4c1ea383dbd@arm.com>
Date: Tue, 23 Apr 2024 12:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, ewagner12@gmail.com,
 suravee.suthikulpanit@amd.com, vashegde@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240416152943.GU223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2024 4:29 pm, Jason Gunthorpe wrote:
> On Tue, Apr 16, 2024 at 02:00:43PM +0100, Robin Murphy wrote:
>> Previously, an untrusted device forcing IOMMU_DOMAIN_DMA always took
>> precedence over whatever a driver's def_domain_type may have wanted to
>> say. This was intentionally handled in core code since 3 years prior,
>> to avoid drivers poking at the details of what is essentially a policy
>> between the PCI core and the IOMMU core. Now, though, we go to the
>> length of evaluating both constraints to check for any conflict, and if
>> so throw our toys out of the pram and refuse to handle the device at
>> all. Regardless of any intent, in practice this leaves the device, and
>> potentially the rest of its group or even the whole IOMMU, in a largely
>> undetermined state, which at worst may render the whole system
>> unusable.
> 
> For systems supporting untrusted device security the translation must
> be BLOCKED at this point.

So why is that not enforced then? Simply hoping that calling 
ops->release_device() or returning an error from iommu_device_register() 
might do the right thing is no guarantee. Furthermore I'm pretty sure 
we're still letting an untrusted device be hotplugged into an existing 
group without any checks at all.

Meanwhile if we go back to letting untrusted take priority and attach 
the device to an empty DMA domain, oh hey look it's blocked, and what's 
more we also retain control of the IOMMU to keep it that way. Problem 
solved. You intentionally changed the code to be less effective at what 
you say it should be doing, so once again I'm left a little puzzled as 
to what point you're trying to argue here.

>> Unfortunately it turns out that this is a realistic situation to run
>> into by connecting a PASID-capable device (e.g. a GPU) to an AMD-based
>> laptop via a Thunderbolt expansion box, since the AMD IOMMU driver needs
>> an identity default domain for PASIDs to be usable, and thus sets a
>> def_domain_type override based on PASID capability.
> 
> The majority of places implementing def_domain_type are using it as a
> statement of HW capability that should not be ignored by the core code:
> 
>   - DART
>     * system page size is too small, can't map IOPTEs, force identity

Not a hardware limitation at all, it supports paging just fine, and 
iommu-dma *could* in principle work with larger pages with a bit of 
effort (some proof-of-concept patches were posted some time ago). This 
is entirely the driver hacking around the legacy of iommu-dma and core 
code not expecting the situation and thus not detecting it or handling 
it gracefully. In fact I should be able to sort that out relatively 
soon, once my other stuff lands and I'm able to start pulling 
iommu_dma_init_domain() apart.

>     * iommu does not support IDENTITY at all, force paging
>   - tegra: Device quirks mean paging and DMA API doesn't work

Hmm, I don't recall any specific device concerns. What I do know is that 
historically this driver has always wanted to prevent the ARM DMA domain 
or older versions of iommu-dma (prior to iommu_get_dma_domain()) from 
getting in the way of what the host1x drivers expect, so if there is any 
actual hardware policy here, it's very much implicitly hanging on the 
coat-tails of software policy.

>   - amd: The driver can't support PAGING when in SNP mode
>   - SMMU: The driver can't support paging when in legacy binding mode and
>           paging domain allocation fails as well

Quite obviously nothing to do with hardware. That's there solely because 
using the old binding prevents us from reasonably being able to order 
binding the IOMMU driver against the client drivers, so we can't risk 
having iommu-dma come up and change the DMA ops underneath an 
already-active device.

>   - qcom: Looks like these devices have some iommu bypass bus in their
>           HW and paging doesn't work

I believe that is true for some of the modem stuff, however again 
there's also plenty of software policy in there too; some of it the same 
thing about default domains getting in the way of how the GPU/display 
drivers want to use dma-direct for cache maintenance underneath their 
own unmanaged domains, one is completely abusing the domain type in a 
devious hack which just happens to make some behaviour fall out of the 
rest of the driver to satisfy an unrelated hardware/firmware constraint 
(which is still *supposed* to be only a temporary fix pending a proper 
solution, ha...)

>   - SMMUv3: The comment says HISI devices cannot support paging due to a HW quirk
> 
> For these force overriding the driver knowledge will either result in
> domain allocate/attach failure or a broken DMA environment anyhow.
> 
> The AMD PASID thing is actually unique because the driver can still
> fully support PAGING, despite it wrongly telling the core code that it
> can't.
> 
> This is happening because it is all just a hack to work around the
> incomplete SW implementation in the AMD driver.

Not really, it's shown up because the core code took an illogical step 
backwards. Without significant surgery to IOMMU and/or driver core code, 
the best and most reasonable thing to do at the moment is still the one 
which happens to work out OK for the current AMD behaviour. Yes, if we 
*had* done all the work to make the core code super-robust then the 
issue could have been the GPU driver gracefully failing rather than 
wedging the whole system, and the remaining blame could then be fairly 
laid on amd_iommu_def_domain_type(), but that is not the case and cannot 
be claimed to be.

Per our API expectations, a driver's def_domain_type can go one of three 
ways; do nothing, request IOMMU_DOMAIN_DMA, or request 
IOMMU_DOMAIN_IDENTITY. For the first two it's clear that untrusted 
forcing IOMMU_DOMAIN_DMA without even asking is perfectly fine. In the 
third case, we still definitely want untrusted to take precedence, since 
our policy is that the device not having access to things it shouldn't 
is more important that it having to access things it should. Sure, in 
the almost-impossible case that we did have an external device which 
genuinely couldn't handle translation, then the user may allow a driver 
to bind, which ends up not working and causing IOMMU faults, however 
that would be equally true of any kind of blocking notion we could 
implement right now, so there's no appreciable loss of functionality. 
However, the overwhelming fact is that the few devices genuinely 
requiring IDENTITY overrides are on-chip integrated things, any of which 
suddenly turning up on external ports would be highly suspect, so that's 
actually a big argument in *favour* of not believing def_domain_type 
either in such cases.

In fact the more I think about it, I could swear I've had this 
discussion and worked through this reasoning before, possibly back when 
we first introduced it?

> When the AMD driver is
> completed its def_domain_type should be removed entirely.
> 
> Since actual PASID AMD attach isn't implemented yet we could just
> remove that check from def_domain_type as an RC fix. Vasant can sort
> it out properly by disabling pasid support on untrusted devices until
> the DTE logic is fully completed.
> 
>> In general, restoring the old behaviour of forcing translation will not
>> make that device's operation any more broken than leaving it potentially
>> blocked or subject to the rest of a group's translations would, nor will
>> it be any less safe than leaving it potentially bypassed or subject to
>> the rest of a group's translations would, so do that, and let eGPUs work
>> again.
> 
> Well, this is true, since we can't handle the probe error it doesn't
> matter what we do.

OK, so after all that you do in fact agree? In that case, why are we 
still mucking about proposing hacks on top of hacks in the AMD driver 
rather than just fixing the regression sensibly?

Thanks,
Robin.

