Return-Path: <linux-kernel+bounces-28446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62AB82FE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947D228915B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6136C17E9;
	Wed, 17 Jan 2024 01:57:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1545F10E9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456662; cv=none; b=k+B6dg1q/D92196bEDwFu7Cz8ORvby+N9n+A5vNM18Y1/8+Vb+5FawfoHQM/Z3aVSVwBB65o+/Qm//BZJLD/r8Hqixo+R8xTnFchIjPDmTDm35E/w5wh3kmdAGSVQ/8m4AoS8/qKvZ+ZiMpNTA7dZJn8UMklZcxKSXs2Hh5n5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456662; c=relaxed/simple;
	bh=/SrlWjIMTigyESjz1QsaSHrVg3bHKGkzoomgx993OW4=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=s5Yj1wdyey6D0hEwlVW73iSzTuVO7NXQ6vkIywKN7DOw1vjMY5lXUm/Msam3NDeVRy9aHjDjfkByg/m6bZqK7PzbrMKVaAmhbooflwq2rp+/14PHKtONIG/J7nYSg0kX/RaRj20aD3jV0pJtZRUkUK4COzFrcK+z1LnwcmRQC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D5182F4;
	Tue, 16 Jan 2024 17:58:24 -0800 (PST)
Received: from [10.57.46.46] (unknown [10.57.46.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4D763F5A1;
	Tue, 16 Jan 2024 17:57:36 -0800 (PST)
Message-ID: <46a61123-dd22-46cb-8b2a-15431fcc03f1@arm.com>
Date: Wed, 17 Jan 2024 01:57:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>, Eric Badger <ebadger@purestorage.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240113181713.1817855-1-ebadger@purestorage.com>
 <20240116152215.GE50608@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240116152215.GE50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-16 3:22 pm, Jason Gunthorpe wrote:
> On Sat, Jan 13, 2024 at 10:17:13AM -0800, Eric Badger wrote:
>> In the kdump kernel, the IOMMU will operate in deferred_attach mode. In
>> this mode, info->domain may not yet be assigned by the time the
>> release_device function is called, which leads to the following crash in
>> the crashkernel:
> 
> This never worked right? But why are you getting to release in a crash
> kernel in the first place, that seems kinda weird..
> 
>>      BUG: kernel NULL pointer dereference, address: 000000000000003c
>>      ...
>>      RIP: 0010:do_raw_spin_lock+0xa/0xa0
>>      ...
>>      _raw_spin_lock_irqsave+0x1b/0x30
>>      intel_iommu_release_device+0x96/0x170
>>      iommu_deinit_device+0x39/0xf0
>>      __iommu_group_remove_device+0xa0/0xd0
>>      iommu_bus_notifier+0x55/0xb0
>>      notifier_call_chain+0x5a/0xd0
>>      blocking_notifier_call_chain+0x41/0x60
>>      bus_notify+0x34/0x50
>>      device_del+0x269/0x3d0
>>      pci_remove_bus_device+0x77/0x100
>>      p2sb_bar+0xae/0x1d0
>>      ...
>>      i801_probe+0x423/0x740
>>
>> Signed-off-by: Eric Badger <ebadger@purestorage.com>
> 
> It should have a fixes line, but I'm not sure what it is..
> 
>> ---
>>   drivers/iommu/intel/iommu.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Unfortunately this issue is likely systemic in all the drivers.

All two of the drivers which support deferred attach, that is.

> Something I've been thinking about for a while now is to have the
> option for the core code release to set the driver to a specific
> releasing domain (probably a blocking or identity global static)
> 
> A lot of drivers are open coding this internally in their release
> functions, like Intel. But it really doesn't deserve to be special.

Either way it shouldn't apply in this case, though. Crash kernels *are* 
special. The whole point of deferred attach is that we don't disturb 
anything unless we've got as far as definitely using a given default 
domain (from which we can infer the relevant client device should have 
been reset and quiesced). Thus regardless of why release might get 
called, if a deferred attach never happened then the release should 
still avoid touching any hardware configuration either.

I'd suggest using dev->iommu->attach_deferred as the condition rather 
than a NULL domain, to be clear that it's the *only* valid reason to not 
have a domain at this point.

Thanks,
Robin.

