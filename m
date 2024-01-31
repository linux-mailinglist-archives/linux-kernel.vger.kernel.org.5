Return-Path: <linux-kernel+bounces-45879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA8843775
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6034B255A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425856471;
	Wed, 31 Jan 2024 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHHdZcir"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD4B4EB45
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685062; cv=none; b=So4azcwprCy0wE4T26muXchGlnhPZG5LbatWogaqeBv6hNfNyS8FphLIttCumrtkV7sUsXVDZPA9WJgA5x0tVuvJETXLSTyuL6pyWgLuexC2PS0ZnIAURJZs+N15+ZQsZu46yuq5qU2AOfsWwMdpf3J+bnPs6y734/K+RBORGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685062; c=relaxed/simple;
	bh=aHc1LlB7RgaXdpNNltY2A/qSSMccnnrO3NYhJGWRT1s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pg0IXfcP+HGXcfMtmqrojgF3gOfweYZh+AHkRbJZgvdtGcMDaxedr01hrwd9M6sQnMEnc8B+1tJ4v3dKb18BD+fG5epB1dfJv1khNaKa4melIvw3rI38UYdIJ9BNGm+wOuD8ON2wxoxYDxmVqVkj+mSt9+UvBeqNpntxwPOpoaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHHdZcir; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706685060; x=1738221060;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aHc1LlB7RgaXdpNNltY2A/qSSMccnnrO3NYhJGWRT1s=;
  b=ZHHdZcir7+lDt6Rp71soFoO1+GG4rykU3NfjJSTDVZl6gek2LqXqupwS
   1wgspR2hMR6Nh5VvbON3WnlybEXZJ84UNzuhJ6n+wFO7GH+C3YxEYIxoI
   P8pkMIMijK8iAlCdDc1lr+dLKmfkgaQbrEfJFxHVw0UWzvMrHs+ENcYG+
   nyfzZ9tiWddsUClocOHpvsOo2v29UsiPwdTV936QZODwU3Xt2Sdody7kI
   J8icYDPP5yssdyeXqADkTTbqyjF7NxGZg2+cdkXKw1SodUUAIwtIs5H6C
   GhOoy7HXTnjn2pdm2nFIbNLcVhXojfioznLqOGK12fdEw6Fy0IF4bDbIr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10897261"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10897261"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 23:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822465084"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822465084"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.175.9]) ([10.249.175.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 23:10:55 -0800
Message-ID: <7455b538-e934-4377-9ab5-004ee991b3d2@linux.intel.com>
Date: Wed, 31 Jan 2024 15:10:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Eric Badger <ebadger@purestorage.com>
References: <20240113181713.1817855-1-ebadger@purestorage.com>
 <20240116152215.GE50608@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240116152215.GE50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/16 23:22, Jason Gunthorpe wrote:
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 6fb5f6fceea1..26e450259889 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3750,7 +3750,6 @@ static void domain_context_clear(struct device_domain_info *info)
>>   static void dmar_remove_one_dev_info(struct device *dev)
>>   {
>>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> -	struct dmar_domain *domain = info->domain;
>>   	struct intel_iommu *iommu = info->iommu;
>>   	unsigned long flags;
>>   
>> @@ -3763,11 +3762,14 @@ static void dmar_remove_one_dev_info(struct device *dev)
>>   		domain_context_clear(info);
>>   	}
>>   
>> -	spin_lock_irqsave(&domain->lock, flags);
>> +	if (!info->domain)
>> +		return;
>> +
>> +	spin_lock_irqsave(&info->domain->lock, flags);
>>   	list_del(&info->link);
>> -	spin_unlock_irqrestore(&domain->lock, flags);
>> +	spin_unlock_irqrestore(&info->domain->lock, flags);
>>   
>> -	domain_detach_iommu(domain, iommu);
>> +	domain_detach_iommu(info->domain, iommu);
>>   	info->domain = NULL;
>>   }
> This function is almost a copy of device_block_translation(), with
> some bugs added :\
> 
> Lu can they be made the same? It seems to me BLOCKED could always
> clear the domain context, even in scalable mode?

Yes. A part of dmar_remove_one_dev_info() is duplicated with
device_block_translation().

> 
> Anyhow, my suggestion is more like:

I like this suggestion.

Currently, the device_release callback for an iommu driver does the
following:

a) Silent IOMMU DMA translation. This is done by detaching the existing
    domain from the IOMMU and bringing the IOMMU into a blocking state
    (some drivers might be in identity state);
b) Releases the resources allocated in the probe callback and restores
    the device to its previous state before the probe.

 From my understanding of your suggestion, we should move a) out of the
release callback and make it a special domain, which could be a blocking
domain or identity domain, depending on the iommu hardware.

In the end, the release_device callback of an iommu driver should focus
on the opposite operation of device_probe. This makes the concept
clearer.

Best regards,
baolu

