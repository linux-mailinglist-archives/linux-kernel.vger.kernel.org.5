Return-Path: <linux-kernel+bounces-90165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BC86FB4C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0F21C21A15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD19171A3;
	Mon,  4 Mar 2024 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNItvujE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CEC168CD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539647; cv=none; b=USQZ2wCPNOfh7qI8HY2llOGUCQ4H1IXSX/KI8hqbRq7+vntNKTqLFvZ/2Ex88QGl85aW2LWmsY7FvXVx00z1mAScZbhKo/Z69WdyIfND/VihCijBiFuI2UDl6ptZJHASTyslJxwEyRBfnvf9Gm0UyMdRrH39MvPfJ11//2EvOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539647; c=relaxed/simple;
	bh=dMRTbw4iZl7sJrSFYrv3ms++N6+JBz9tv6hN222A2Ik=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NIXpKrtJa2r0k4XH3db89cTSEmPkKF1ml0dlfbstLrFvB8bONzAjDPr+pmA22niO8vDIk987+KAkNRh7hz9nNQCP4bPoHeXh934TuUaec2p7Ryf/lTRJ9ih5i16YctYhe9+HgSp8KlcERTi7ckq2xz9TmKyJs3xYosuYGtdVHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNItvujE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709539646; x=1741075646;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dMRTbw4iZl7sJrSFYrv3ms++N6+JBz9tv6hN222A2Ik=;
  b=RNItvujEy8x9ZkRdEoHY1OH4hQXkLEILjaHv717j/B8vXnpOYTxQVRQq
   wGVBrnKeLk2sYFuYBxDs7lT2gF/npHFbFs9YUPa/0bpuDXZzGEkC8sRpZ
   CUQHSgwEqKz9ruNHjlXidkw3MklfKMNxhSuLhOGnpxGNF6R/dEZ8iKgxI
   pFzzpcYN24oZpaGClsDpAufXqayE6uY0sSYTikgsZZfO6G6mHx5eWmnz2
   XKvpXjNIMQPD1xkhmGyKaSev2cFqx1NPI416FLG56h/hpjMyDuJbu8uZX
   tYFsWEIejI8aLVc76OKwdeyOqbgLVcPeKkiR/IsbWY+EtCzOAGqbskryr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7835006"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7835006"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8846492"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.18]) ([10.254.211.18])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:07:23 -0800
Message-ID: <2cc53838-c88f-43a0-b974-c5acb6f27849@linux.intel.com>
Date: Mon, 4 Mar 2024 16:07:20 +0800
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
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Fix NULL domain on device release
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
References: <20240229094613.121575-1-baolu.lu@linux.intel.com>
 <20240229094613.121575-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52764189F754ABF69D24E2AE8C232@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764189F754ABF69D24E2AE8C232@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/4 15:36, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, February 29, 2024 5:46 PM
>>
>> +
>> +/*
>> + * Cache invalidation for changes to a scalable-mode context table
>> + * entry.
>> + *
>> + * Section 6.5.3.3 of the VT-d spec:
>> + * - Device-selective context-cache invalidation;
>> + * - Domain-selective PASID-cache invalidation to affected domains
>> + *   (can be skipped if all PASID entries were not-present);
>> + * - Domain-selective IOTLB invalidation to affected domains;
> 
> the spec talks about domain-selective but the code actually does
> global invalidation.

I should have included the following comments below:

/* Given that we have no idea about which domain IDs and PASIDs were
  * used in the pasid table, upgrade them to global PASID and IOTLB
  * cache invalidation. This doesn't impact the performance significantly
  * as the clearing context entry is not a critical path.
  */

> 
>> + * - Global Device-TLB invalidation to affected functions.
>> + *
>> + * Note that RWBF (Required Write-Buffer Flushing) capability has
>> + * been deprecated for scable mode. Section 11.4.2 of the VT-d spec:
>> + *
>> + * HRWBF: Hardware implementations reporting Scalable Mode Translation
>> + * Support (SMTS) as Set also report this field as Clear.
> 
> RWBF info is a bit weird given existing code doesn't touch it

Yes. I will remove above note.

> 
>> + */
>> +static void sm_context_flush_caches(struct device *dev)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct intel_iommu *iommu = info->iommu;
>> +
>> +	iommu->flush.flush_context(iommu, 0, PCI_DEVID(info->bus, info-
>>> devfn),
>> +				   DMA_CCMD_MASK_NOBIT,
>> DMA_CCMD_DEVICE_INVL);
>> +	qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
>> +	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
>> +	devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
>> +}
>> +
>> +static void context_entry_teardown_pasid_table(struct intel_iommu
>> *iommu,
>> +					       struct context_entry *context)
>> +{
>> +	context_clear_entry(context);
>> +	if (!ecap_coherent(iommu->ecap))
>> +		clflush_cache_range(context, sizeof(*context));
> 
> this is __iommu_flush_cache(). You can use it throughout this and
> the 2nd series.

Yes.

> 
>> +
>> +void intel_pasid_teardown_sm_context(struct device *dev)
>> +{
> 
> it's clearer to call it just intel_teardown_sm_context. pasid_table
> is one field in the context entry. Having pasid leading is slightly
> confusing.

I used the intel_pasid prefix because this helper function is located in
the pasid.c file.

Best regards,
baolu

