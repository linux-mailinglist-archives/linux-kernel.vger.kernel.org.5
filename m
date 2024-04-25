Return-Path: <linux-kernel+bounces-158416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C5F8B1FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D865F1F23DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762B7374D3;
	Thu, 25 Apr 2024 10:52:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9E42C182
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042362; cv=none; b=cpTgRM33zm82pX0dB9SOVR4pgOSRRrSEjAaaDfmUsVqJwCYn9nLX/Tf/6NBkTMd/7S/HpMVLq/iWwueiKRSI9J0aLM9Lw4ar0UDrbvaorajA6B27Xa4Ro71KSdkRaUXdSJAHK9QAe67T1CMuPvTyyUQ+V1gHB/rjGTRyFfLN1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042362; c=relaxed/simple;
	bh=Ar1GqtbHV7TvYScxEgkS4ik5kDQlPzxCfA0GlbTjt+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQITheqAIhFE85bElxwa2FxrBh6bALCagNtqdmLp+NikxruXC0NHnBwm61jjSG/3AK/o/X/jSZncQxgq9W2I0oglGMXSYcyPQ8a7aDQycWjeWjWB47wZTVFwdD664DlgjTyfxSha+Zw7BlKGpy+9n3ifKXdl7peuyJMT1ObiM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D9E71007;
	Thu, 25 Apr 2024 03:53:07 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CBBC3F7BD;
	Thu, 25 Apr 2024 03:52:38 -0700 (PDT)
Message-ID: <e3175546-5357-4946-97b1-7677b0596772@arm.com>
Date: Thu, 25 Apr 2024 11:52:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/amd: Fix memory leak in alloc_pci_segment()
To: "Kun(llfl)" <llfl@linux.alibaba.com>, Joerg Roedel <joro@8bytes.org>,
 Vasant Hegde <vasant.hegde@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <a06d50c3a82214a82ccb88c22aa4e4a1d595b39c.1714040214.git.llfl@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <a06d50c3a82214a82ccb88c22aa4e4a1d595b39c.1714040214.git.llfl@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/04/2024 11:17 am, Kun(llfl) wrote:
> Fix the memory leak issue that occurs when resource allocation fails in
> alloc_pci_segment(). The dev_table, alias_table, and rlookup_table were
> introduced individually in three commits. But they all fail to release
> allocated resources when other allocations fail.

As far as I can tell the returned error should end up being handled in 
state_next(), which *will* then clean these up again, at least in the 
!irq_remapping_enabled path. If there's any cleanup missing from the 
other path, then I think it should be fixed there, since it may well 
represent more than just these particular allocations.

Thanks,
Robin.

> Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
> Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table"),
> Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table").
> Reported-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>
> Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
> ---
>   drivers/iommu/amd/init.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index ac6754a85f35..4ce567f39473 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1642,13 +1642,22 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
>   	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
>   
>   	if (alloc_dev_table(pci_seg))
> -		return NULL;
> +		goto alloc_dev_fail;
>   	if (alloc_alias_table(pci_seg))
> -		return NULL;
> +		goto alloc_alias_fail;
>   	if (alloc_rlookup_table(pci_seg))
> -		return NULL;
> +		goto alloc_rlookup_fail;
>   
>   	return pci_seg;
> +
> +alloc_rlookup_fail:
> +	free_rlookup_table(pci_seg);
> +alloc_alias_fail:
> +	free_alias_table(pci_seg);
> +alloc_dev_fail:
> +	free_dev_table(pci_seg);
> +	kfree(pci_seg);
> +	return NULL;
>   }
>   
>   static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,

