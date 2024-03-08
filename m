Return-Path: <linux-kernel+bounces-96419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C2875BDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9481028347C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271F224DD;
	Fri,  8 Mar 2024 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQ0Dce4D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51420219FC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860316; cv=none; b=pyls3b4dAmW6SPoge/jGj2GstbTL4Hf7PXz0l4d61J3AfZWZQgE/zH1m8ImWCeIwyJpeb8yw89M9zkFhK4B9X5L4hGLSesM6QdBrQwm29kn2+1NeCfAxlVAoYPrjoGx4n794m+1M3X0BrPjJc8wl0rWl+UEpRX4F7O8s8A+XJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860316; c=relaxed/simple;
	bh=UH2NMaQQbXycY8nTN3zcaCTvKnRM7PFycZeWYzrJJa4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UWcMaNf2k/OEkrF3BX249J8FcAZzRakHy2xGrjtJ1Dz5zSeMIwg8oH6JH2elI9AQJs/ZOOuDoZZDEmOsANnVh59nQbJpX7ssTYJTri6C4Vsgo2usX6ZcONTCYxF5W9zkmfsZoTF1T/wkf0N1OEPLl5q3b1d+jiLonjUFwLQqec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQ0Dce4D; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709860315; x=1741396315;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UH2NMaQQbXycY8nTN3zcaCTvKnRM7PFycZeWYzrJJa4=;
  b=IQ0Dce4DcbkByzQtH9AOmGphzkkF89eyjckSGpgfFyFKyzwNWlo5YwrJ
   1eW35oF0vxyooNdXJc2L5RcNNwGQXA4gh4/fEyQfdkOY168j35xekTdvo
   8KTy5useIpyJlP67MdbhI35TlJeLoP/wC6iEb5H8XBqN5vnVu8ZNWFPgY
   pTz1ptYw/qEbo5ZoU6J2kyGF7p5v0XSLJ8AMWKwexbi5DFM7AXQ9/03Pz
   /RvNlal+jGZvmgcBeTQyHCPrFM5AE70hjx0jEJ3c+GqOZpAOyWC/Y+1wm
   G2tqGmCcUfOHUAgHzg6g1Dq0HkPFKMWBgKTYMHfKXG4GTPtLYME951DGW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22019261"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="22019261"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 17:11:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="14861453"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 07 Mar 2024 17:11:49 -0800
Message-ID: <1b1acbb7-409f-4263-928d-bb73d6c328ab@linux.intel.com>
Date: Fri, 8 Mar 2024 09:05:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@elte.hu>,
 Suresh Siddha <suresh.b.siddha@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: always select INTEL_IOMMU for IRQ_REMAP
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20240307140547.2201713-1-arnd@kernel.org>
 <95554e96-d8b9-4325-aa73-e698b1873a79@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <95554e96-d8b9-4325-aa73-e698b1873a79@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/24 11:48 PM, Robin Murphy wrote:
> On 07/03/2024 2:05 pm, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> CONFIG_INTR_REMAP was originally split out of the intel iommu code to be
>> shared by IRQ_REMAP. This recently broke again because the IRQ_REMAP
>> code calls the global device_rbtree_find() function that is unavailable
>> for builds without INTEL_IOMMU:
>>
>> x86_64-linux-ld: vmlinux.o: in function `qi_submit_sync':
>> (.text+0x10771e0): undefined reference to `device_rbtree_find'
>>
>> It seems that the intel iommu code now contains a lot of generic helper
>> functions that are not specific to intel, such as alloc_pgtable_page(),
>> iommu_flush_write_buffer(), domain_attach_iommu() etc, so presumably
>> it is not x86 specific any more.
> 
> No, it's still all very much Intel-specific, which in fact means it is 
> just recently now x86-specific since IA-64 has departed.
> 
> Historically it's always been the case that building IRQ remapping 
> support on its own without IOMMU_API was supported, and for a while we 
> even had the awkward iommu_device_set_ops() wrapper and various other 
> indirections and stubs in the core API solely to make it work. IMO the 
> underlying issue here is that there have never been very clear lines of 
> separation between the ACPI DMAR code, the IOMMU API driver, and the IRQ 
> remapping driver, so unless the whole design could be improved to make 
> it harder to break, it probably is time to start asking the question of 
> whether anyone actually cares about this config combination any more.

IOMMU in passthrough mode + interrupt remapping might be a reasonable
alternative to no IOMMU API + interrupt remapping.

Best regards,
baolu

