Return-Path: <linux-kernel+bounces-102936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27AE87B8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E8B284119
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176415CDD3;
	Thu, 14 Mar 2024 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKnZC05/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644C5C8E4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402091; cv=none; b=cQwNS2JlDLoU++TYKRnTxHsF2S4a8l7BvBvevb6uLrCRuYCq/6PdRR5Wi5/HD5OttegUc/RuxBe6bZ+GvBnb6fXffJ2TRr5bkM9CJI+X6TSZ8/VBRZon4Q4sGy5g/lvUJuZr7QaSpPAZnMi/m+gVrJaZn2XD+ctGT9Qtn6aKOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402091; c=relaxed/simple;
	bh=tYLRFrjCwOGp9whBxYAiRelcKZZjcsXaVqhFiwh3zBg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AfzDCX69EkKL7cYc0zKok5DMG50tMpSNz18j2r+/4o6jc3AqtLFx3t/1XUOtLiMfzjEDSd+LJ66Z4jHsjHFu1PPvjDmakdfUdw0rRqDM3FIgxdO67T6+INZB08/Jlyo7b4+1zFOHH9i4OaZUYRoArBMD9Er+OJhjIHI+KFVMaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKnZC05/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710402090; x=1741938090;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tYLRFrjCwOGp9whBxYAiRelcKZZjcsXaVqhFiwh3zBg=;
  b=lKnZC05/PYJxO0Z1yvcMAYhmyGAou0uNS0pInR9Xio/Si915ITUd8D/+
   SQmEMpCOfaDw7AJFe7uzu5FmaK0SOUpad6Pp6cJ2+zqAOw5Nl/CB3l8Wc
   uVFnODm6qRBiYrivD+O/PawHUWm6FU0obtyk6eObCU/0JtXs6V/oTTT6m
   GX4T5CMsOhYWiAwQluN8RKhmN+pQHurhhTG3qVZdD7XwOKR6aXWwxoD52
   TC5i/dEyR3/I//MasyQi3C8F4m0Ol5BSffrecmN9I5wlu47+eXuQMKqkJ
   auOFXkGO9PhkOhphb3RP7odPHEYGL/zjnIgyMnirg3X+1vVm8G+xIGuii
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="30644718"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="30644718"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 00:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="16798366"
Received: from schen8x-mobl.ccr.corp.intel.com (HELO [10.255.29.38]) ([10.255.29.38])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 00:41:26 -0700
Message-ID: <b33bf29b-2fe5-4a2a-a2ce-9fd8d67c5f6f@linux.intel.com>
Date: Thu, 14 Mar 2024 15:41:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iommu/sva: Use iopf domain attach/detach interface
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-3-baolu.lu@linux.intel.com>
 <20240308174605.GV9225@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240308174605.GV9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/9 1:46, Jason Gunthorpe wrote:
> On Mon, Jan 22, 2024 at 03:38:57PM +0800, Lu Baolu wrote:
>> @@ -215,7 +202,23 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
>>   		group = abort_group;
>>   	}
>>   
>> +	cookie = iopf_pasid_cookie_get(iopf_param->dev, pasid);
>> +	if (!cookie && pasid != IOMMU_NO_PASID)
>> +		cookie = iopf_pasid_cookie_get(iopf_param->dev, IOMMU_NO_PASID);
>> +	if (IS_ERR(cookie) || !cookie) {
>> +		/*
>> +		 * The PASID of this device was not attached by an I/O-capable
>> +		 * domain. Ask the caller to abort handling of this fault.
>> +		 * Otherwise, the reference count will be switched to the new
>> +		 * iopf group and will be released in iopf_free_group().
>> +		 */
>> +		kfree(group);
>> +		group = abort_group;
>> +		cookie = NULL;
>> +	}
> 
> If this is the main point of the cookie mechansim - why not just have
> a refcount inside the domain itself?
> 
> I'm really having a hard time making sense of this cookie thing, we
> have a lifetime issue on the domain pointer, why is adding another
> structure the answer?

The whole cookie mechanism aims to address two things:

- Extend the domain lifetime until all pending page faults are resolved.
- Associate information about the iommu device with each attachment of
   the domain so that the iommufd device object ID could be quickly
   retrieved in the fault delivering path.


> I see we also need to stick a pointer in the domain for iommufd to get
> back to the hwpt, but that doesn't seem to need such a big system to
> accomplish - just add a void *. It would make sense for the domain to
> have some optional pointer to a struct for all the fault related data
> that becomes allocated when a PRI domain is created..

It's not getting back hwpt from domain, just getting the iommufd_device
in the fault delivering path. The iommufd_device is not per-domain, but
per-domain-attachment.

> 
> Also, I thought we'd basically said that domain detatch is supposed to
> flush any open PRIs before returning, what happened to that as a
> solution to the lifetime problem?

If I remember it correctly, what we discussed was to flush all pending
page faults when disabling PRI. Anyway, the current driver behavior is
to flush faults during domain detachment. And if we keep this behavior,
we no longer need to worry about domain lifetime anymore.

> 
> Regardless I think we should split this into two series - improve the PRI
> lifetime model for domains and then put iommufd on top of it..

Yes, agreed. Let's tackle those two points in a separate series.

Best regards,
baolu

