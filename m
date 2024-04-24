Return-Path: <linux-kernel+bounces-156234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D988D8B0002
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FED2898CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7300B13A269;
	Wed, 24 Apr 2024 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCLYjfXU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1528139CEB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930382; cv=none; b=onj55CC2HREXl5n421ywVO59/HRsYv6fu8BFyBFIvDLri2k2C4ba5dXaUmcnz2TcysLLPmJQkSHdKvYDZh1cIMGXu9sSobrZhr6ro3ESI8BYjoAjl1l9RYAOAwsviNho0FjJsZQLFQPYUorE7DdFV30YPJyw9rUvwekQkfYdNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930382; c=relaxed/simple;
	bh=9f1FqymkcY84ZRJChezdXFafCZhSRXFxINpKY9hyCAg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iF4SpOL51idn09rZpx3s04DV+G2QVDD+vzMZ16E4xjUyu9UZHGC6aessySSGN5fK0aUWR4yxqRvLXFQbz7RlI2H2QuwAhi3xCJN2mTy/AKIblzo9EqRJG74/KeQBb4Ytl+CaPIWvyxvww7Q4WNm/bpbc0NBcrJ5dR+hB2Pbu0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCLYjfXU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713930382; x=1745466382;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9f1FqymkcY84ZRJChezdXFafCZhSRXFxINpKY9hyCAg=;
  b=KCLYjfXU8cjA2CtpG9EKsqtbOYOgPJGd04xHB15e1zlBVeHBryYm6Rp0
   W8HVDpb+ue8N48LqWQ4UbUkyok783QxFe9RB2Fui7VOEl/kCRvOFzAANz
   yonPEBr6lq0lZOJhGPRTKXc1nrGNOhpnt8AQ7X04SLrPdvS0RUpGcsAKB
   fzx/3XFI1UZXSABTI5wn1uAmfjMXNf3uRUNJJudJl7aLqTTfAZva20PxV
   sftJeWK7p1y4+p1Y0QoVimQk6VKDBhCBrw7Ca1meC1CtoKysN9N0izXYz
   WzJPFxKDKEBkjOfniUT9wh3b/OumyTDngs6/EevsVF8ZOlCjWo8NFG8HA
   g==;
X-CSE-ConnectionGUID: 65eV3iGOQKieVhdt5Ssf4w==
X-CSE-MsgGUID: 90ug6WM4Sdu+NhbfLWkBVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9371170"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9371170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 20:46:21 -0700
X-CSE-ConnectionGUID: UsrwtcwLSFSwEOQCIfOuhQ==
X-CSE-MsgGUID: M5Zm/i5fT9SMPRe7FENI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="25089694"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 23 Apr 2024 20:46:19 -0700
Message-ID: <4b3f6af7-d40e-4910-8e6d-449c59ab0dd2@linux.intel.com>
Date: Wed, 24 Apr 2024 11:44:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/intel: Use try_cmpxchg64{,_local}() in iommu.c
To: Uros Bizjak <ubizjak@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240414162454.49584-1-ubizjak@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240414162454.49584-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 12:23 AM, Uros Bizjak wrote:
> Replace this pattern in iommu.c:
> 
>      cmpxchg64{,_local}(*ptr, 0, new) != 0
> 
> .. with the simpler and faster:
> 
>      !try_cmpxchg64{,_local}(*ptr, &tmp, new)
> 
> The x86 CMPXCHG instruction returns success in the ZF flag, so this change
> saves a compare after the CMPXCHG.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak<ubizjak@gmail.com>
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>
> Cc: Robin Murphy<robin.murphy@arm.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Patch has been queued for iommu/vt-d.

Best regards,
baolu

