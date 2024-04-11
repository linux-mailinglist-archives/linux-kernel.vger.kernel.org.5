Return-Path: <linux-kernel+bounces-140273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420D28A114A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B661C2360A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD921474AB;
	Thu, 11 Apr 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnSPDfTe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821842EAE5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832148; cv=none; b=DzezDda9tCeIJOCSPQIUzaVZoAHVAsh/XMtq0aVCGRw8LUS3vpda6cd5gKbbXLcD78KzkrwGI7GVpCE3g32D6SIe2y+PPcs88FgSOvnLyKP+S1oJnJ2/We+aFvU7qzDu/x/wHP9ZnetIYinqBnrSc3DIcpF8GTzWhk5gzCSIOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832148; c=relaxed/simple;
	bh=OwXbvvCmxzRGwwaybj47loKYypz/fXRm1xIcyTzXQbM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DNJ50GLpmbZVkHHsScZB6bAkfe50+D/fct841ITnjLbCi8etaSkZDVPfdkuaApdPSG3IxoLAmHfZpM+ZTls5DjXHIHVVVPVbUihdkcKfDTJMST2x8OhzZRvWXUKlcTO4eqyq/upD1EcBRdMmm/CH5FgGA+pNdO5hTYYvRrBZ49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnSPDfTe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712832146; x=1744368146;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OwXbvvCmxzRGwwaybj47loKYypz/fXRm1xIcyTzXQbM=;
  b=lnSPDfTeiutikpDgVBtleIoHDyRA96AKx06vScz4LcryhSnKowxz5Sey
   MIH35bvEoqN7pLvxYpkvk6PWcIkaTxfslU/I3JK/uJvtEur0dtOXcp8my
   ltkUmKg7sWI1gsNMUovugydv+C7LMmtUYGHP2fZ/h19IBBXjdgTXvHexM
   xngqOuPYc5WcTcrBTSZbfTLVm9azwGlNtUVpVFdXq54tbo52ySr7rMUng
   AOGSbb4a8A5z5VrVaFmL+9xCdRLSSuCDm4QcIaIQReQx8s6UcfJlR+oqv
   EOFwUrdZEJxfUizbbARgjC6wCRDRjJlYSPs+mC/oYDL6UObr7VpZ7WmPc
   Q==;
X-CSE-ConnectionGUID: /LyUPWaSSZ2tAvpa0WXDzA==
X-CSE-MsgGUID: L8h2RdPYSkOjEotnF9kALg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8454301"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8454301"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:42:26 -0700
X-CSE-ConnectionGUID: hDZT6KtFTeuTEAq3eTW6Og==
X-CSE-MsgGUID: jTcZalKBS2qx+VHLg4eWmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25515549"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:42:23 -0700
Message-ID: <3f0e134a-3da4-4a45-851a-3d15a8786f9a@linux.intel.com>
Date: Thu, 11 Apr 2024 18:42:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 12/12] iommu/vt-d: Retire struct intel_svm
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-13-baolu.lu@linux.intel.com>
 <20240410154951.GH223006@ziepe.ca>
 <b24f3380-1ac3-41c4-9163-56c1dcff6297@linux.intel.com>
 <BN9PR11MB52767D3287A7E000AD17BC9B8C052@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52767D3287A7E000AD17BC9B8C052@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/11 16:32, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Thursday, April 11, 2024 3:56 PM
>>
>> On 2024/4/10 23:49, Jason Gunthorpe wrote:
>>> On Wed, Apr 10, 2024 at 10:08:44AM +0800, Lu Baolu wrote:
>>>> @@ -4388,14 +4386,8 @@ static void
>> intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>>>    	WARN_ON_ONCE(!dev_pasid);
>>>>    	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>>>
>>>> -	/*
>>>> -	 * The SVA implementation needs to handle its own stuffs like the
>> mm
>>>> -	 * notification. Before consolidating that code into iommu core, let
>>>> -	 * the intel sva code handle it.
>>>> -	 */
>>>>    	if (domain->type == IOMMU_DOMAIN_SVA) {
>>>>    		cache_tag_unassign_domain(dmar_domain,
>> FLPT_DEFAULT_DID, dev, pasid);
>>>> -		intel_svm_remove_dev_pasid(domain);
>>>>    	} else {
>>>>    		did = domain_id_iommu(dmar_domain, iommu);
>>>>    		cache_tag_unassign_domain(dmar_domain, did, dev, pasid);
>>> It seems very strange that SVA has a different DID scheme, why is
>>> this? PASID and SVA should not be different at this layer.
>> The VT-d spec recommends that all SVA domains share a single domain ID.
>> The PASID is unique to each SVA domain, hence the cache tags are unique.
>> Currently, the Intel IOMMU driver assigns different domain IDs for all
>> domains except the SVA type.
>>
>> Sharing a domain ID is not specific to SVA. In general, for devices
>> under a single IOMMU, domains with unique PASIDs can share the same
>> domain ID.
>>
>> In the long term (also on my task list), we will extend the cache tag
>> code to support sharing domain IDs and remove the domain type check from
>> the main code. This will also benefit the nesting case, where user
>> domains nested on the same parent could share a domain ID.
>>
> at least above might be changed to a unified call with the helper
> accepting an iommu parameter and then finding proper did
> internally based on domain type, e.g.
> 
> cache_tag_unassign_domain(domain, iommu, dev, pasid)
> {
> 	if (domain->type == IOMMU_DOMAIN_SVA)
> 		did = FLPT_DEFAULT_DID;
> 	else
> 		did = domain_id_iommu(domain, iommu);
> 
> 	...
> }

Yeah, your code is more graceful.

Best regards,
baolu

