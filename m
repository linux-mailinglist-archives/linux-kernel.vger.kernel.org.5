Return-Path: <linux-kernel+bounces-80582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED48669EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B14B20D03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7651BC3E;
	Mon, 26 Feb 2024 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kp9m4xuY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FBC1BF28
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928007; cv=none; b=G+PqegsLE+xih+ZhpA5Mo8kVp8Ju4f4Lu7yclM0WH175XXznxPAp7BG5WjjwwHJf/8Zx7b6jjfAHI3RpF8Uy9R48SQrKTFMwfyH6AVSJRQaJLjaVF2oeT289mnS4IdzapPcMAln5hv7oZ2WiCni6Pz66kzfvK4cDouKzhBmQub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928007; c=relaxed/simple;
	bh=L85jrdnuvWMYNRaKJflVjhzs3F+SyK8Kz4ffE7SFr9w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZnfeI34EO4EprjlH1/1YaZFTsDRls+nG/3t3VBXOf3fr+loIfxFnb1Uql5M4eiPNLI3nZXV8h35B1pM/mQ00UoN/Sp65H9cq/5W12Bt9Rsbi+ncoSewcXBdsFYe0h45g4SOk4QJZtQRun+Uguv3HvHWQhJiZgOQyK59OuvpE2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kp9m4xuY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708928006; x=1740464006;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L85jrdnuvWMYNRaKJflVjhzs3F+SyK8Kz4ffE7SFr9w=;
  b=Kp9m4xuYdkrg0/IDNA30iempjSDeTWAN4LiyJan9OEYbcG8DzJrOXJRe
   owsQqNt/rW08GfKLHccGWfw6u7R6cwJiPJXAKeLPrR03TyK1xd7c/+VmI
   KTvsIHgXk9HVZB+IH5Gu30kyRhrLNAokuI4XsykY7+FQR6u7faLq10+rN
   BfCnGkoHE+iAcw/DMTfMZC16iFD1wAoPMbgwYYXexhW2fnugDWPlfo01k
   EjgHiq/pNBaBkVgh5tXfpn/Gr752SLLcmT/7592o6fizIpNOQIfgnmGjc
   mWSGEWLxzI3Ofifvaf6ywK+S5ZnHg34J2gCEkOpjyw9W+RKBRPT+/Qf+d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3738230"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3738230"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11129742"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 25 Feb 2024 22:13:22 -0800
Message-ID: <b2dac6a4-3916-4a67-b7d9-8f69e5b0eb78@linux.intel.com>
Date: Mon, 26 Feb 2024 14:07:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, iommu@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240130060823.57990-1-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240130060823.57990-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 2:08 PM, Lu Baolu wrote:
> Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA option for
> broken graphics drivers") was introduced 24 years ago as a temporary
> workaround for graphics drivers that used physical addresses for DMA and
> avoided DMA APIs. This workaround was disabled by default.
> 
> As 24 years have passed, it is expected that graphics driver developers
> have migrated their drivers to use kernel DMA APIs. Therefore, this
> workaround is no longer required and could been removed.
> 
> The Intel iommu driver also provides a "igfx_off" option to turn off
> the DAM translation for the graphic dedicated IOMMU. Hence, there is
> really no good reason to keep this config option.
> 
> Suggested-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> ---
>   drivers/iommu/intel/iommu.c |  4 ----
>   drivers/iommu/intel/Kconfig | 11 -----------
>   2 files changed, 15 deletions(-)

I have queued this patch for v6.9.

Best regards,
baolu

