Return-Path: <linux-kernel+bounces-76466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7E85F78E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0C62821F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E881482D3;
	Thu, 22 Feb 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkRu5pwR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4047F58
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602838; cv=none; b=YWcY/nWa/osAAqG5PqEs29qS+08pao/ulrQ1/hmN1ghXSiUyDHrGyHINwwBpKGZs+edqgM1Mrrb/2pDlGq7idtRaIaxuksn7t7TmM+91VsFhyUvjmqFnsZZxk22XpznbtsY+cfUVVSS168/TTTOmeHFOdfVzJ9t1qHecCHHDNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602838; c=relaxed/simple;
	bh=hK4pxYV9GrDhdvp+ZHYHLQFmxepY3EOddcsHm2aSlD4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qVtuIzQW0H+ts4l1wOWYA96mYbEM8YLN4zekt4q7RmbB2DjHZWWM5oeru2E5VG7K+1Vt1aOveSNGtpFNsIPkZgjK8OdCWE0Uls27LK4ig3vdnmfLa8yUaum9Xf2HV2ASMwfYlb/bNnjkvPIwtMWeNs1jTvRlXXok6RomzNpeU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkRu5pwR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708602837; x=1740138837;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hK4pxYV9GrDhdvp+ZHYHLQFmxepY3EOddcsHm2aSlD4=;
  b=NkRu5pwRouYfMeGjnskUOZDUDTwzQRSklGZPEyGeUcN3TdVM/FBmT7fw
   Ea15iG7t2IMSVZtMJPPj262GR6tGLTA4jeNrhuulx/i9VkywGOQlvn/Rl
   ksKpVoXGkJzbf+un/XADjjz0RUgupCgh6d1aAYrVZDdotpRpnNVEbtqEn
   hb+WE+oJVWtp1yGMh4gk2urHJAPvS6nEaWe83zUFBQGsMMWLqeMCfEtzW
   +/W5+WQ2t1uT3d53i0YbnlJpblBCMgL4RJVpXhsxNZ1W0qrLKWrZnOrXt
   vj+ZC5QrrST6lrHY07NXCdlz0y6/KgEJG8eiSEmGxzW7uJuALP/SRAAVM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13522715"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13522715"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5437426"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.222]) ([10.249.171.222])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:53:54 -0800
Message-ID: <4c64bfb2-26b1-4fed-af30-5acd4ac2759e@linux.intel.com>
Date: Thu, 22 Feb 2024 19:53:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Eric Badger <ebadger@purestorage.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240113181713.1817855-1-ebadger@purestorage.com>
 <20240116152215.GE50608@ziepe.ca>
 <7455b538-e934-4377-9ab5-004ee991b3d2@linux.intel.com>
 <20240221154012.GC13491@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240221154012.GC13491@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 23:40, Jason Gunthorpe wrote:
> On Wed, Jan 31, 2024 at 03:10:53PM +0800, Baolu Lu wrote:
>> I like this suggestion.
>>
>> Currently, the device_release callback for an iommu driver does the
>> following:
>>
>> a) Silent IOMMU DMA translation. This is done by detaching the existing
>>     domain from the IOMMU and bringing the IOMMU into a blocking state
>>     (some drivers might be in identity state);
>> b) Releases the resources allocated in the probe callback and restores
>>     the device to its previous state before the probe.
>>
>>  From my understanding of your suggestion, we should move a) out of the
>> release callback and make it a special domain, which could be a blocking
>> domain or identity domain, depending on the iommu hardware.
>>
>> In the end, the release_device callback of an iommu driver should focus
>> on the opposite operation of device_probe. This makes the concept
>> clearer.
> Right
> 
> Can someone make some patches to fix Eric's bug? We don't really need
> to do the release_domain stuff if the driver just self-attaches one of
> its known static domain types (blocking/identity)

I will follow up with a formal patch series.

Best regards,
baolu

