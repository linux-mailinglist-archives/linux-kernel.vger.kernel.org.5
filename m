Return-Path: <linux-kernel+bounces-74210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF8485D130
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00AD1F2635F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85713B1AB;
	Wed, 21 Feb 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4sV2ZFF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995583A8DD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500083; cv=none; b=fj44Z2lw99Wjav80Bf5axol973CZJGClBe8hfcRCGXCK28NP7YBp52qaEqNHimkHe/jXqI+n5fa3jHnOL1dlE5m0N6pYuM5ApC47uvAPW2PCRdEYrUhtJq9WQfY/N/KjLBgWPrl/jSm0cCyrR78SilojWQYz9XEDhxdPjRIOPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500083; c=relaxed/simple;
	bh=IoYu+i7KKnzz4BOoEaK041vDn3DjPnDvaToCAeVuexQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mwXupaOFY5NjvW2WWek6n0iiaRZ4Iwnv3N7UrdxHXnjn4ewPgDfSGNEQxEl7tNnaBuzuy79QorAHY4QcxrbdWW66StKWB76H/tck3rLs9UIDOEjhXwMZqFeoXqT0hMZfwpHTVwdXUcppr9dMn4mKFvsNZQWtHWibTuLKTXerMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4sV2ZFF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708500082; x=1740036082;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IoYu+i7KKnzz4BOoEaK041vDn3DjPnDvaToCAeVuexQ=;
  b=B4sV2ZFFU/Dbcz8IntRRE4SYhLQoJFVhxdUnIsgK9aRe0hXBpyT0b7Lx
   swuJ4q5F5AcguKclETSMxUJnMcrkbTPsOdaRh3gHodmEiGi/0RxVBYf5O
   vn5kHPX9dzC9Ic8ir1Hf28lh+pRkmlgX14qb+/6/3lsWZmko3nRBM7CSv
   BX/N3eofHqKUYcxOMq+edX3MB3ryrPWuAnvxBAMRRt1wRY4ZO+yqxZFT5
   bj+MARQlU/iRmvEz0qRjjQVtTpIpCrQD7x4jWaua0L1uQgBxW+UluAzde
   XmLu0ihYEgvVI61/yLa+RhqJjavG2zaT7LH1UBFTZt0kzmGe+f6wl7VW1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2516570"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2516570"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="42523584"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:21:15 -0800
Message-ID: <e77922a5-89d3-4036-8d98-9c3fbef4f39c@linux.intel.com>
Date: Wed, 21 Feb 2024 15:21:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] iommu: Add iopf domain attach/detach/replace
 interface
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527629BF9A0E27E36D3925B18C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b0f5e418-8faa-45d1-b086-61f6c009c0cb@linux.intel.com>
 <BN9PR11MB5276151E34AC91883986A39D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276151E34AC91883986A39D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 14:49, Tian, Kevin wrote:
>>>> +struct iopf_attach_cookie {
>>>> +	struct iommu_domain *domain;
>>>> +	struct device *dev;
>>>> +	unsigned int pasid;
>>>> +	refcount_t users;
>>>> +
>>>> +	void *private;
>>>> +	void (*release)(struct iopf_attach_cookie *cookie);
>>>> +};
>>> this cookie has nothing specific to iopf.
>>>
>>> it may makes more sense to build a generic iommu_attach_device_cookie()
>>> helper so the same object can be reused in future other usages too.
>>>
>>> within iommu core it can check domain iopf handler and this generic cookie
>>> to update iopf specific data e.g. the pasid_cookie xarray.
>> This means attaching an iopf-capable domain follows two steps:
>>
>> 1) Attaching the domain to the device.
>> 2) Setting up the iopf data, necessary for handling iopf data.
>>
>> This creates a time window during which the iopf is enabled, but the
>> software cannot handle it. Or not?
>>
> why two steps? in attach you can setup the iopf data when recognizing
> that the domain is iopf capable...

Oh, maybe I misunderstood. So your proposal is to make the new interface
generic, not for iopf only?

Best regards,
baolu

