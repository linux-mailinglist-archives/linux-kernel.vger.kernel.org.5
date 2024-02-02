Return-Path: <linux-kernel+bounces-50325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B084776B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C00B2912CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA625B1E4;
	Fri,  2 Feb 2024 18:27:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055F149012
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898475; cv=none; b=Ddv9yV/WgIpYFZZSnERmWZGngrgsw9U1U9azUWWN8Y77z8Yhi4YqeyI21+XeFNRn9JZNIe0LAiK1XVEtkjU5kc1/a2KYpMXNBxzAXQNRDoCuFqW+Q3bNA1iK0L7aKMDSRLVUnsXLybF5PvC8HuXY/1N/A1iQomaueFv07nUGO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898475; c=relaxed/simple;
	bh=N0FDuOpnGhNTTGAFeSRftIb2dtVj0TarzbSfZakHWCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeM+8kkwF5sMqXitHARZbQOdt8Y07/GGecC1o77LLR/FgZaAXIs7mNkdKe+NoZqmk/hysp22oOjK9RkvY8nuWSFXfKIzQiKlN5007A5lK3Xyh46G8t7DxmncRsALTimjofDvTOjIbUXPArrS9PUkeacqBywNU6i8Zo8jaYcShHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4313FDA7;
	Fri,  2 Feb 2024 10:28:35 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24AD3F762;
	Fri,  2 Feb 2024 10:27:51 -0800 (PST)
Message-ID: <bcddef81-3979-4ad0-b3f6-771871a44433@arm.com>
Date: Fri, 2 Feb 2024 18:27:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
Content-Language: en-GB
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com
References: <20240201193014.2785570-1-tatashin@google.com>
 <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
 <CA+CK2bD_q3pnThtLVSzFCjyevBEaG6Ad+1o2=1tVZsYg35UMmg@mail.gmail.com>
 <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com>
 <CA+CK2bCFbeRHT172KUci5+8WJNUeo-2A1M=UXsSqqOy64w1LJw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CA+CK2bCFbeRHT172KUci5+8WJNUeo-2A1M=UXsSqqOy64w1LJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 6:04 pm, Pasha Tatashin wrote:
>> Hmm, I did misspeak slightly (it's late and I really should have left
>> this for tomorrow...) - that's 12KB per CPU *per domain*, but still that
>> would seem to imply well over 100 domains if you have 242MB of magazine
>> allocations while the iommu_iova cache isn't even on the charts... what
>> the heck is that driver doing?
>>
>> (I don't necessarily disagree with the spirit of the patch BTW, I just
>> really want to understand the situation that prompted it, and make sure
>> we don't actually have a subtle leak somewhere.)
> 
> Hi Robin,
> 
> The following tracing is without Google TPU, simply upstream kernel:
> 
> The iova_domain_init_rcaches is called 159 with the following stack:
> 
>   iova_domain_init_rcaches
>   iommu_setup_dma_ops
>   amd_iommu_probe_finalize
>   bus_iommu_probe
>   iommu_device_register
>   iommu_init_pci
>   amd_iommu_init_pci
>   state_next
>   iommu_go_to_state
>   amd_iommu_init
>   pci_iommu_init
>   do_one_initcall
> 
> Each time 1536K is allocated: in total 159 * 1536K = 238.5M

Yikes, so it really does just have that many IOMMU groups? OK, fair 
enough, call me convinced :)

On balance though, I think I'd prefer to just stick the lifecycle 
management into iova_cache_{get,put} for simplicity - spending ~256 
bytes on another kmem_cache we might not use can hardly be significantly 
more than the extra code and static data necessary to track its usage 
separately anyway.

Thanks,
Robin.

> The allocation happens like this:
> for (IOVA_RANGE_CACHE_MAX_SIZE)
>      for_each_possible_cpu()
>          iova_magazine_alloc
>          iova_magazine_alloc
> 
> IOVA_RANGE_CACHE_MAX_SIZE = 6
> ncpu = 128
> sizeof (struct iova_magazine) = 1K
> 
> 6 * 128 * (1K + 1K) = 1536K
> 
> Pasha

