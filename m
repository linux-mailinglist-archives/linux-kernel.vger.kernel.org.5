Return-Path: <linux-kernel+bounces-140447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A118A14C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64651B258BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF021E4A0;
	Thu, 11 Apr 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJLP11s6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AFD5382
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839143; cv=none; b=RJ7/dNTPeS46bZvlL7cC7qBTzQFia0MHYZCTOEZl7hDH/77juZ55BXA1V18knQtB4hj8rUjGa6DTzci9ckFp/ep8uIIsbIkV52VZdyWPIte9XRGUofzF1WDHFUT3x1sgeKQfgkAFhwVehWMmGUAXBEmBU9jNYZgkGalYw1rFoNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839143; c=relaxed/simple;
	bh=+uVP9jm5OMN6jCpq6EPFPAQTk7vKRlcxoJx2hqFB2pg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HXej3r+2lBqQQntlRuX5K4iFwUUQnivuJQh3tZ7HZyt9grEw1SmB0A24prv7jSjO/kKpLC978vNmgXHQj4lSVtLi6wyI5TFfogpz9n3aO+KD8XLOS0W1aLVBslEdxfVW1mTbeh4LbBSJSA6PElmsdRWh2VQhm64tT9XO9dCv7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJLP11s6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712839143; x=1744375143;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+uVP9jm5OMN6jCpq6EPFPAQTk7vKRlcxoJx2hqFB2pg=;
  b=VJLP11s6n6VuVcgpeeFXwikcYOv39b5m6592dGoW5suDfbFCh2A4lmFy
   PHXXN/8gR0qGL19oatwOjr1s/cN7F6kZrKFdQBPo002QCRgTAG2SHNLyw
   xH57BJCizAMosHN+HkkYGC/6EkeAveLpphh8YSAnUWP9cPhFMmnTVWNAj
   PnfBNpEUZv0bsSLvtghFZJsm2gNyayleSZIeOamXeE9Nnvob1x8Sm+UJk
   bA8VsHqgxgpZ1xuyW7YwpjrTKpAt8y6+aKhKZdm7+FgruA7PhRdLDtY9M
   GyK0Y97MkLHGY5OTRvDLIWtwyYyJ4rXkTQ3uOqsR1vOBFsYEZgI+sxOOj
   Q==;
X-CSE-ConnectionGUID: Sm6VI1ZTQ/WdlxaTyCznvQ==
X-CSE-MsgGUID: Px+ehQ4MTMOoEiOYgV2k8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19636332"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="19636332"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:39:02 -0700
X-CSE-ConnectionGUID: zhKQjPKeQuqTfbEqQTv+Fw==
X-CSE-MsgGUID: FRgzNuerR1GU8QertMhZLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25363380"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:39:00 -0700
Message-ID: <40b32537-b2c3-450a-866a-82cf4686057a@linux.intel.com>
Date: Thu, 11 Apr 2024 20:38:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Tina Zhang <tina.zhang@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <20240410154134.GG223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240410154134.GG223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/10 23:41, Jason Gunthorpe wrote:
>> +struct cache_tag {
>> +	struct list_head node;
>> +	enum cache_tag_type type;
>> +	struct intel_iommu *iommu;
>> +	struct device *dev;
> iommu and dev probably don't both need to be stored together. We have
> iommu_get_iommu_dev() now.. I suppose this is probably a union of the
> two pointers depending on tag. DEVTLB needs the dev and IOTLB needs
> the iommu.

I forgot to reply this comment in previous reply. Sorry about it.

struct cache_tag {
         [ ... ]
         struct intel_iommu *iommu;
         struct device *dev;
         [ ... ]
};

I treat @iommu as the queued invalidation interface. All cache
invalidation raises to hardware through the invalidation queue.

The @dev field represents the location of the cache. For IOTLB cache, it
resides on the IOMMU hardware. In this case, the field stores the device
pointer to the IOMMU hardware. For DevTLB cache, it locates in the PCIe
endpoint. Here, the field stores the device pointer to that endpoint.

A correctly set @dev pointer allows users to see more accurate trace
message.

Best regards,
baolu

