Return-Path: <linux-kernel+bounces-42609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B28403C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBAC1C2290E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C115BAD8;
	Mon, 29 Jan 2024 11:24:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6445FBB1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527457; cv=none; b=AeMwbOfUsyVG8b5OYincpDWsrWYp9buQSmJ5IrE8EGz2axGAFxolVTNVmj5M1i1nQkg7RfyfKz7kzR9bXtrgJg0+BSXWOf0L3hZ8dOhODLN2Ntkx4AfqMDCWlCovcOQilbkvl2180wDpQYQJ1HLwoe0w9Wop0CthexTgnsCAiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527457; c=relaxed/simple;
	bh=WH7PYjaSBNnuD+pJLor2J13V+w5N5SZnUqFkJocu1Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cl0wcZvEL1UT4LLGrVZFsukKO/OUCBVA1LqfswpBtqp+hu72SaASFY++1f9Tbe1wQYQNpZC+TfVf6MkAb9m/2sHdHu4T3o0SR3dgEMfFoDX6nc0ewXp++34EGMRK0IMUP9c+ZHfQjZtsXPF3dX61afLvPFP38b89HYtPv1XHYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 478D91FB;
	Mon, 29 Jan 2024 03:24:58 -0800 (PST)
Received: from [10.57.77.253] (unknown [10.57.77.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DAF23F7D8;
	Mon, 29 Jan 2024 03:24:13 -0800 (PST)
Message-ID: <e8b8f470-f7f9-4238-a473-a6ed764353a4@arm.com>
Date: Mon, 29 Jan 2024 11:24:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Content-Language: en-GB
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Christoph Hellwig <hch@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240127064512.16744-1-baolu.lu@linux.intel.com>
 <Zbc_mdOYxMIxWAdd@infradead.org>
 <BN9PR11MB5276D63FAC442A415018ACB58C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abc6771f-fafe-4ca7-898a-aecbe017b3c7@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <abc6771f-fafe-4ca7-898a-aecbe017b3c7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-29 7:24 am, Baolu Lu wrote:
> On 2024/1/29 14:08, Tian, Kevin wrote:
>>> From: Christoph Hellwig <hch@infradead.org>
>>> Sent: Monday, January 29, 2024 2:03 PM
>>>
>>> On Sat, Jan 27, 2024 at 02:45:12PM +0800, Lu Baolu wrote:
>>>> Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA
>>> option for
>>>> broken graphics drivers") was introduced 24 years ago as a temporary
>>>> workaround for graphics drivers that used physical addresses for DMA 
>>>> and
>>>> avoided DMA APIs. This workaround was disabled by default.
>>>>
>>>> As 24 years have passed, it is expected that graphics driver developers
>>>> have migrated their drivers to use kernel DMA APIs. Therefore, this
>>>> workaround is no longer required and could been removed.
>>>
>>> How about you Cc the intel graphics maintainers and get a confirmation?
>>>
>>
>> in the worst case there is still "igfx_off" option available to 
>> achieve the
>> same effect.
>>
>> there is really no good reason to keep this config option so long 
>> while it
>> was intended to be removed in 2.6.32.
>>
>> but yes the Intel graphics maintainers should be CCed.
>>
> 
> You both are right.
> 
> I will add above in the commit message and Cc graphic guys with a new
> upgraded version.

Right, you're not removing the actual workaround at all, you're only 
removing the Kconfig option to force it on by default, which clearly 
nobody is using since it's been dead code since 2009 with 0c02a20ff769 
("intel-iommu: Kill DMAR_BROKEN_GFX_WA option.")

Cheers,
Robin.

