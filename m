Return-Path: <linux-kernel+bounces-146703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B02A8A6990
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9555A1C20BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A756A1292D2;
	Tue, 16 Apr 2024 11:25:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DA06D1BC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266757; cv=none; b=niGggI0sHkvNrvBNMEwNcBG+obS2xgUxgprs6eg4sqva5xWVN8gaDsPmU54TXH+dY2XgrWaY5q4U3VK9hFJR0bR8bobn9ILG5O6toYPaBzPADRARkmWJ2MZ7UUtoBkN4j+0Rcu3Uo3bmj/zzzGMxpATGA2GgEe9eDTDQ170fo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266757; c=relaxed/simple;
	bh=UG4jP07F2hYAqQijSJCJ54Bps/Mjtct7kysvFkNFmsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIzTDv9OeUAJ9HvNfc4RM5XQQSLvskqXqf/OFjQH/gXQMN5C/muyhMv0xKMAkC8DB9Xm6lne26WUw9/pv2kKhZZ+LvVUz4Ow8q877j9Kvgmxx9NL3fxM7FCvlvXdUPyWv75V9dLU5i1Adv4owbE5Pm386caHICwZRY/S+wMEWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 431CD339;
	Tue, 16 Apr 2024 04:26:23 -0700 (PDT)
Received: from [10.57.19.239] (unknown [10.57.19.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 950753F738;
	Tue, 16 Apr 2024 04:25:53 -0700 (PDT)
Message-ID: <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>
Date: Tue, 16 Apr 2024 12:25:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Cc: Eric Wagner <ewagner12@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240416003903.GR223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-16 1:39 am, Jason Gunthorpe wrote:
> On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
>> On 2024-04-15 7:57 pm, Eric Wagner wrote:
>>> Apologies if I made a mistake in the first bisect, I'm new to kernel
>>> debugging.
>>>
>>> I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
>>> 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
>>> Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
>>> as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
>>> bisect log is attached. It ended up at the same commit as before.
>>>
>>> I've also attached a picture of the boot screen that occurs when it hangs.
>>> 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
>>> problem.
>>
>> Looks like 59ddce4418da483 probably broke things most - prior to that, the
>> fact that it's behind a Thunderbolt port would have always taken precedence
>> and forced IOMMU_DOMAIN_DMA regardless of what the driver may have wanted to
>> saywhereas now we ask the driver first, then complain that it conflicts
>> with the untrusted status and ultimately don't configure the IOMMU
>> at all.
> 
> Yes, if the driver wants to force a domain type it should be
> forced. Driver knows best. Eg AMD forces IDENTITY when the HW/driver
> is incapable of supporting otherwise.

No, in the case of AMD it only forces identity if it thinks the device 
might want to use PASIDs (because of the architectural limitation that 
the RID always operates in GPA space so can't have its own independent 
translation).

Either way, though, there's really little sense to that argument - if 
enforcing strict translation *might* compromise the device's 
functionality, we should instead go out of our way to ensure it's 
definitely as broken as possible? I fail to see how that can be 
justified as useful or desirable behaviour.

>> Meanwhile the GPU driver presumably goes on to believe it's using dma-direct
>> with no IOMMU present, resulting in fireworks when its traffic reaches the
>> IOMMU. Great :(
> 
> I wonder where is the missing error handling.. iommu probe failure
> should not go on to allow driver attach, there is no guarentee any DMA
> works now that many iommus are booting up in BLOCKED.

What do you mean error handling? After you spent a year rewriting the 
probing code to your own grand design, don't suggest you don't even know 
how it fundamentally works...

"Failing" iommu_probe_device is merely how we tell ourselves that we're 
not interested in a device, and consequently tell the rest of the kernel 
it doesn't have an IOMMU (via device_iommu_mapped() returning false). 
This is normal and expected for devices which legitimately have no IOMMU 
in the first place; conversely we don't do a great deal for unexpected 
failures since those typically represent system-fatal conditions 
whatever we might try to do. We've never had much of a notion of 
expected failures when an IOMMU *is* present, but even then, denying any 
trace of the IOMMU and removing ourselves from the picture is clearly 
not the ideal way to approach that. We're running off a bus notifier (or 
even later), so ultimately our return value is meaningless; at that 
point the device already exists and has been added to its bus, we can't 
undo that.

However it looks to be even more fun if failure occurs in *deferred* 
default domain creation via bus_iommu_probe(), since then we give up and 
dismiss the entire IOMMU. Except the x86 drivers ignore the return from 
iommu_device_register(), so further hilarity ensues...

I think I've now satisfied myself that a simple fix for the core code is 
appropriate and will write that up now; one other thing I couldn't quite 
figure out is whether the AMD driver somehow prevents PASIDs being used 
while the group is attached to a non-identity (and non-nested) domain - 
that's probably one for Vasant to confirm.

Thanks,
Robin.

