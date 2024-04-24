Return-Path: <linux-kernel+bounces-156223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C08AFFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060951F23A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEDC139CEB;
	Wed, 24 Apr 2024 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVJ+ZtYo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA213340B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930153; cv=none; b=dTvEPh8t/CjSIOkcShqhl8h4znK1OQYRDjrhTfDhirx1ktyg14x5Tq2vwQfIyshgkulOJFFVRPJw/w47b9tz4xSb6YqdPaxdfgkJcJU5s45umspvnS485CDtNXOz7JkBL4cCPZ+vygpsAjWBEhviphoc2LlqbcwxewDkU9V6hrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930153; c=relaxed/simple;
	bh=NaV8fJtdZNvQ2q6d/ly1hbkq/RvaEZpbmNlPteDHQWQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UqdfSeXflbo3M7JmROn4HfmO7ibFbP8HbN8dsZPsaWajj6pwqOtWTXj9kN4AbCyCYSpnsacEW0b98ABm7p34zykBqv5ArnyW/hl6aCtL3faAU0Yls9M0OosQBV7N3L/CqJ0ItLdAXJXOWQFX+Yb08Fcw3krmB7LDMEKTmlK51zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVJ+ZtYo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713930152; x=1745466152;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NaV8fJtdZNvQ2q6d/ly1hbkq/RvaEZpbmNlPteDHQWQ=;
  b=nVJ+ZtYoXofZzf9eIyLl25RUTL27rX6+8ACzAndV7TGZZq7+iofWXlAe
   JCIrkppLR2E4q6TA4y6pMXqji9W+FLuUjY0vBOAuLrox60lo7EV6AjK0P
   Wde1c7T5iZHeQtCisl0jY0jHqfrVuuJp1F5vZqp2C945Kf1nf1YDjNp7I
   7ICBKmLC1IcZtHj4r0PTZURC66/lcHG2wyxsy83SYuvZsj1TVim9jd793
   qUCNy7/q6GL2gkK02e9cfZQXVQFZypCCIqmKKV/0H0zfgB3YtCRoxQW4C
   N6fNXG1vwaFEPxm78AE/Rk6ekvv6LOHcIaqc171kiCLKME+tfp2SY2A9G
   g==;
X-CSE-ConnectionGUID: mNQEn0X2R/CDFiKCgcdD0Q==
X-CSE-MsgGUID: CQl1UERaSlGCwyJDtaO3mQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9409308"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9409308"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 20:42:31 -0700
X-CSE-ConnectionGUID: 2eSLtHPzRS2Agdj31p61sQ==
X-CSE-MsgGUID: TSfV7Yz6QTa49Qn7xr1NKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24609150"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 23 Apr 2024 20:42:28 -0700
Message-ID: <daf746ef-f5db-46aa-876f-42a9deb65445@linux.intel.com>
Date: Wed, 24 Apr 2024 11:41:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: iommu@lists.linux.dev
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240415013835.9527-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 9:38 AM, Lu Baolu wrote:
> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure
> entries except for the first-stage translation. The caching mode is
> irrelevant to the device TLB, therefore there is no need to check it
> before a device TLB invalidation operation.
> 
> Remove two caching mode checks before device TLB invalidation in the
> driver. The removal of these checks doesn't change the driver's behavior
> in critical map/unmap paths. Hence, there is no functionality or
> performance impact, especially since commit <29b32839725f> ("iommu/vt-d:
> Do not use flush-queue when caching-mode is on") has already disabled
> flush-queue for caching mode. Therefore, caching mode will never call
> intel_flush_iotlb_all().
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

Patch has been queued for iommu/vt-d.

Best regards,
baolu

