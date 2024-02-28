Return-Path: <linux-kernel+bounces-84335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894C186A507
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4301C2850BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE3F4A32;
	Wed, 28 Feb 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jV8Tl60O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98D4400
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083722; cv=none; b=eDY8eu1gghSIejtqrcEYlYMEgVtZGgoi5VTl0hO4eZEcJ3EuTa/mifSJvLYCsVhXf2SExts97zfMR4eSGlQASffL2ErjtuKSs2ajphYE0jy+KLfD9Q7FHoyBq/JmROrbrSr2mXMWc58+4bnZjVFcoOIPmIizciZXEo+w4/jEqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083722; c=relaxed/simple;
	bh=sJR9z4eckKcNzeUdP4oLegXejIZJep7SfGn1kxt7Ufk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EpmDbPVNE7VNFzJfUB+BHpMmA9ZF6YIKkY5z4Lirbp/rPb4aBaQ/mNh16S+TOF/vGjH2X/guVmTg8CsmLC4BxpeiQ5LbZ/LFLVrHODxIJoG4ipSORVCJxuCAtqT79/hrX5vItKgrdxJcA/VIekHFaJEg1hzhCPuaSW8EH70s0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jV8Tl60O; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709083722; x=1740619722;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sJR9z4eckKcNzeUdP4oLegXejIZJep7SfGn1kxt7Ufk=;
  b=jV8Tl60Ou8TAmusD67Cgo6Cet+iHcEyCAcQjoGYBC8Bm2cWEK16fJ8Uh
   XE5sPonOSpiovjQdyoq3McmNrSsR/oj2JpcWsMLOoe6O3WcLhQfQJaaWy
   IDh68esVtA2ewrNms94tBbGg+TNk+hsKCahmLV+I88iyG4mSt3NG5l4UQ
   9V5/AjLsXgYbLGY6GvZpWrq6WvcH9G3kqsPD4CQlK76A/n17qa3ZgBCYy
   EcbdMA886V6qDQzGI1zp4WUZlgOXQiXedEjmkD3EI7hp1hZsuwTwrWMtl
   XWFw18LkDiDRvP83iJfAkTvemq9Cmezf6JylJUs5y7VEGQ4p8SGz1vFSY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3624787"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3624787"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 17:28:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11877504"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 27 Feb 2024 17:28:38 -0800
Message-ID: <64a1f1ff-793d-4bf7-91fc-00984336594c@linux.intel.com>
Date: Wed, 28 Feb 2024 09:22:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Fix NULL domain on device release
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
References: <20240223051302.177596-1-baolu.lu@linux.intel.com>
 <20240223051302.177596-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52763D19A01C804FB514419F8C592@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763D19A01C804FB514419F8C592@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 3:40 PM, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Friday, February 23, 2024 1:13 PM
>>
>> -static void dmar_remove_one_dev_info(struct device *dev)
>> -{
>> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> -	struct dmar_domain *domain = info->domain;
>> -	struct intel_iommu *iommu = info->iommu;
>> -	unsigned long flags;
>> -
>> -	if (!dev_is_real_dma_subdevice(info->dev)) {
>> -		if (dev_is_pci(info->dev) && sm_supported(iommu))
>> -			intel_pasid_tear_down_entry(iommu, info->dev,
>> -					IOMMU_NO_PASID, false);
>> -
>> -		iommu_disable_pci_caps(info);
>> -		domain_context_clear(info);
>> -	}
>> -
>> -	spin_lock_irqsave(&domain->lock, flags);
>> -	list_del(&info->link);
>> -	spin_unlock_irqrestore(&domain->lock, flags);
>> -
>> -	domain_detach_iommu(domain, iommu);
>> -	info->domain = NULL;
>> -}
>> -
> what's required here is slightly different from device_block_translation()
> which leaves context entry uncleared in scalable mode (implying the
> pasid table must be valid). but in the release path the pasid table will
> be freed right after then leading to a use-after-free case.
> 
> let's add an explicit domain_context_clear() in intel_iommu_release_device().

Nice catch!

How about moving the scalable mode context entry management to probe and
release path? Currently, it's part of domain switch, that's really
irrelevant.

Best regards,
baolu

