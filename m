Return-Path: <linux-kernel+bounces-157914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37A08B1887
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115971C21A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246DD12E55;
	Thu, 25 Apr 2024 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BO71NDTG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B010A0A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009393; cv=none; b=l0zNee5584tbBi4o4LKPQSdgxZnTTIcFe1qVke7TbelKWqiDVfd1stUBuZ9hG7eglzdJImDnkTI8gCtl0/auhHr44KvRfl9FN4vChL+k53RoCUOlJBP1lbPnnFk/4QuxKJi/2GmRBNzxb/b15FqeoduZoMdJd4m7IYhx9Xa1LqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009393; c=relaxed/simple;
	bh=vCTcIpU4tuNNZiG4seFWTcZ8ixen+NgPcl6fLdpAfag=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FpGD6ShC6KfD/VIPxvYYRcGZcgQyoyiSn7Gj84beNaO0f7CMckr3oIkVF9hw4Z1fO1/WVUialB16BloUEnpDfLlGAxoDsditGGaDkp1Uoo4BPRy2dlkdi3Hw2UTzpQ7ggXUlq8pFjtNbipLBTfgA7Botgzz/J2wFWHsuVSNaTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BO71NDTG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714009392; x=1745545392;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vCTcIpU4tuNNZiG4seFWTcZ8ixen+NgPcl6fLdpAfag=;
  b=BO71NDTGWt6mHtJYwNIXW3TBotwuW2W1tefeIZgaB5d16EohOU5SBbtr
   NcPn9EhPmhgZA2Red3yJs/26Kyux78pIZjEOxTJtf/izZHzvv182p7nPp
   6b9etFGTGDsZJSYL/eSrfSjZv2Pyz1iVLSNTT8tzB4kbZm8ZS6RtsDfgJ
   ak6Nv3tl1PJFq8DnMhVbrqiOq7Q/+YICWAdjAGcR65hn21PXb1SNUZ0qx
   gqY8dVbqn+GOPKwa6gv02tsuH48Bx4LQjd/CgdOH2hM6mChW2cH92EDWn
   ccc/KLd83Y0aHffyB0g/IApsYufGDzCU2mPYmFFhCE68tb5RwnvGtnTZ/
   g==;
X-CSE-ConnectionGUID: qM2W0gESTNOMmsJ9jSvj2Q==
X-CSE-MsgGUID: h33G9cqcRDy+yR4BR3UYow==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="12607396"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="12607396"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 18:43:11 -0700
X-CSE-ConnectionGUID: O8KuCFEcTm6KZ535BdsK2A==
X-CSE-MsgGUID: HNXd/qeESMKjvD4disWUSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="48151282"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa002.fm.intel.com with ESMTP; 24 Apr 2024 18:43:08 -0700
Message-ID: <7648b859-3685-41d7-a7b9-e137441c98a0@linux.intel.com>
Date: Thu, 25 Apr 2024 09:41:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 joro@8bytes.org, will@kernel.org, ewagner12@gmail.com,
 suravee.suthikulpanit@amd.com, vashegde@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
 <3cf97e3c-c8d9-4282-a8ca-e4c1ea383dbd@arm.com>
 <20240424130457.GF231144@ziepe.ca>
 <77fd2bba-fc59-4997-a91a-2d9235ce5cd6@linux.intel.com>
 <20240424143702.GH231144@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240424143702.GH231144@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 10:37 PM, Jason Gunthorpe wrote:
> On Wed, Apr 24, 2024 at 10:18:00PM +0800, Baolu Lu wrote:
> 
>> For example, the intel iommu driver allows users to opt-in graphic in
>> passthrough mode, in that case def_domain_type will return
>> IOMMU_DOMAIN_IDENTITY no matter the device is trusted or not.
>>
>>      if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
>>           return IOMMU_DOMAIN_IDENTITY;
>>
>> this potentially creates same conflict as the amd driver.
> These performance policy choices should be done in the core code and
> they should interact correctly with other policy knobs like untrusted.
> 
> If Intel Graphics has some performance reason to prefer IDENTITY then
> it should work the same no matter the IOMMU it is connected to. I
> think just because the GPU is co-packaged with the IOMMU isn't a good
> reason to organize the software like this.
> 
> If having a policy of a performance boost to some devices is
> legitimate then I guess we'd need more levels on the command line:
>   fast           all IDENTITY
>   fast-secure    all DMA expect IDENTIY for special devices
>   mostly-secure  all DMA but unmapping is not strict
>   secure         all DMA and strict unmapping
> 
> How exactly you decide when the performance reason justfies IDENTITY,
> I don't know.. Would mlx5 800G NICs that can overwhelm most IOMMUs
> also go in that bucket too?
> 
> But yes, I'm quite adament that drivers should not be using
> def_domain_type as some kind of performance policy thing.

Yes. I will follow up to address this issue in the intel driver.

Best regards,
baolu

