Return-Path: <linux-kernel+bounces-161371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35168B4B3D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203CA1C2090A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF72C56B69;
	Sun, 28 Apr 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aE9SyE5D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB45646E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714299756; cv=none; b=Whs8BRu9woLGZkd+qgcYEl4zQHTuwQAwOJ7SBh7kFYcZ5fZMbPKCXLjjgBS6qx34eDhcvGvHdBNygcC2Co7Wqy6dR++SkCTb7obdly+gNvgnL8iVW/weesEBHW0IX55wNAElN8ouZg/E2ZEYGtlxL2L4lSh1NMvDHKQ1k9qZYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714299756; c=relaxed/simple;
	bh=t7yVg/5llcD2DQRjFAumsRe9vh7we/yBmI/XPyc27SA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pReQQ5s3kSDEpGlEyPlSYN/IySoSSXcLc4iSh02/IrNYTfuPkqEXIP1C1aDb9fe+kKijLNQes5oogKDmXfOBOsxAsgoF8xtNlHdSv0vzAhZCoW8MZUsNyeg+p8MfMjPfjD4CPamWvGgVPpnq0QU3njn/aaSFkgzt0Tjnju7cU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aE9SyE5D; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714299755; x=1745835755;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t7yVg/5llcD2DQRjFAumsRe9vh7we/yBmI/XPyc27SA=;
  b=aE9SyE5D1LwMgQWPw/gu54Sd2f88xrEjrcceVBLSqvekGD28+Z/gjXhY
   1TsfYatDuWCF7ybKAmuOvNM2akNDsA8CMZbUOnLu1c6WWMeOMiIZ8WFKO
   euSU1SjatLJ8LwGRQzhUoCySYgtG0PzZ+NiNt22KKvO4pmk5Oc3fjqa39
   3OHzwQwVLRomA+32qYSbqVfFDfUf//4nJe8eeTDpYVE7zOA3UjWbBpPep
   FQZjY+88aJN9Xt1oBnYXHuEg9x77jfmaKPa5njQs5Cpus4GcXz/krXsln
   DcqZG97Zc96CD5AvltdrG6WHyI1W3n70UuOdnUZ62MgdnK3hpDZqxFzAg
   g==;
X-CSE-ConnectionGUID: eH6cktXBQt6j7NhfwEeg5A==
X-CSE-MsgGUID: 3obAn9iPS1mbFDJAREQZnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27497833"
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="27497833"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 03:22:34 -0700
X-CSE-ConnectionGUID: AR3/mjPPQwu5ubPNxBEAqA==
X-CSE-MsgGUID: IyJahcqkQWSNxFA+JVoF/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="63310673"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.244.72]) ([10.125.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 03:22:30 -0700
Message-ID: <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>
Date: Sun, 28 Apr 2024 18:22:28 +0800
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
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
 <20240409234800.GD223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240409234800.GD223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/10 7:48, Jason Gunthorpe wrote:
> On Tue, Apr 09, 2024 at 10:11:28AM +0800, Baolu Lu wrote:
>> On 4/8/24 10:19 PM, Jason Gunthorpe wrote:
>>> On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
>>>> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
>>>>> On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
>>>>>> +	/* A bond already exists, just take a reference`. */
>>>>>> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>>>>>> +	if (handle) {
>>>>>> +		mutex_unlock(&iommu_sva_lock);
>>>>>> +		return handle;
>>>>>>     	}
>>>>> At least in this context this is not enough we need to ensure that the
>>>>> domain on the PASID is actually an SVA domain and it was installed by
>>>>> this mechanism, not an iommufd domain for instance.
>>>>>
>>>>> ie you probably need a type field in the iommu_attach_handle to tell
>>>>> what the priv is.
>>>>>
>>>>> Otherwise this seems like a great idea!
>>>> Yes, you are right. For the SVA case, I will add the following changes.
>>>> The IOMMUFD path will also need such enhancement. I will update it in
>>>> the next version.
>>> The only use for this is the PRI callbacks right? Maybe instead of
>>> adding a handle type let's just check domain->iopf_handler  ?
>>>
>>> Ie SVA will pass &ommu_sva_iopf_handler as its "type"
>> Sorry that I don't fully understand the proposal here.
> I was talking specifically about the type field you suggested adding
> to the handle struct.
> 
> Instead of adding a type field check the domain->iopf_handler to
> determine the domain and thus handle type.
> 
>> The problem is that the context code (SVA, IOMMUFD, etc.) needs to make
>> sure that the attach handle is really what it has installed during
>> domain attachment. The context code needs some mechanism to include some
>> kind of "owner cookie" in the attach handle, so that it could check
>> against it later for valid use.
> Right, you have a derived struct for each user and you need a way to
> check if casting from the general handle struct to the derived struct
> is OK.
> 
> I'm suggesting using domain->iopf_handle as the type key.

After removing the refcount from the attach handle, I am trying to make
the code look like this,

         /* A bond already exists, just take a reference`. */
         handle = iommu_attach_handle_get(group, iommu_mm->pasid);
         if (handle) {
                 if (handle->domain->iopf_handler != 
iommu_sva_iopf_handler) {
                         ret = -EBUSY;
                         goto out_unlock;
                 }

                 refcount_inc(&handle->users);
                 mutex_unlock(&iommu_sva_lock);
                 return handle;
         }

But it appears that this code is not lock safe. If the domain on the
PASID is not a SVA domain, the check of "handle->domain->iopf_handler !=
iommu_sva_iopf_handler" could result in a use-after-free issue as the
other thread might detach the domain in between the fetch and check
lines.

Probably we still need to keep the refcount in the attach handle?

Best regards,
baolu

