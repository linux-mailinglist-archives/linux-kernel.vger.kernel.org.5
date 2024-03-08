Return-Path: <linux-kernel+bounces-96434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB11875C10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66B51F21BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2251E22EED;
	Fri,  8 Mar 2024 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iwd7Qkay"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED613225D4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709862404; cv=none; b=HlBQVY3Z2rm5worq8msUrdQwMwG5ZLfcjoi9YXZcmLTfaVQ8pwq3xZo0xmUeBHI6nntoRSRbYKnfTpFYUpYvh7wckv4ETWnQPuHGfrti0eCdiE0X5V07xRyczTn/Inlv+PvFZh2NUve+vz6iNJGBoWiwj0L8CzAa+ApFb0vKw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709862404; c=relaxed/simple;
	bh=IVPq8N2j/iOv1/7Yev/gBsEV7HoD32GIq2O/4f9aOlE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tlsdtO/e4hxMdotrTcUg7yAcDIEWmkdZjIEsG33CYAuo083XkjdaNK3fv/OuIRUo8/+THipO2tsQe12EUwtr92hVX5BfMeUiqsVKdU912omQGQEm8oy6AAclYXJBdz982aLOUnmn8iTikuNp4tCCJcYZXJyqsYK8ViH/VJXGHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iwd7Qkay; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709862404; x=1741398404;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IVPq8N2j/iOv1/7Yev/gBsEV7HoD32GIq2O/4f9aOlE=;
  b=Iwd7Qkay4GCvI0cct6QMrdhf3Gud2dPVvjcoAJQlH/i4pM8cI2VwYzsY
   chFRPUbPkPBWjnAqGoM2emYM3TTWisyF2lVpukLhaEU1PYw2SL8e/E/Tz
   QDc9kzO/VJ93t65SeFf2hGGoMFWbqHwE8PAK3CfrVoEU8OyiFbUa2WRzb
   Wqg+18swkFM9hye3RZMYiZncAhkOfDmolYiEck/LjsIGLgLW2DuqG27OB
   tHmlXhSvl+TGCQ/jQXv/2TJ/GWmZaugUsbM4ftiRykmokUE+CmIUnPdg4
   t7SfjmiN2fTWJOHTQdyx0o265OTNrQp8Bz5QfcgUD5HeMCjWZZhdsOj4l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4498342"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4498342"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 17:46:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10244795"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 07 Mar 2024 17:46:38 -0800
Message-ID: <6afb82b4-379d-4a6c-8cc0-00fc72caa72e@linux.intel.com>
Date: Fri, 8 Mar 2024 09:40:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, haifeng.zhao@linux.intel.com,
 iommu@lists.linux.dev, jgg@ziepe.ca, jiaqing.huang@intel.com,
 joro@8bytes.org, kevin.tian@intel.com, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH] iommu: fix compilation without CONFIG_IOMMU_INTEL
Content-Language: en-US
To: Bert Karwatzki <spasswolf@web.de>
References: <20240307194419.15801-1-spasswolf@web.de>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240307194419.15801-1-spasswolf@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/24 3:44 AM, Bert Karwatzki wrote:
> When the kernel is comiled with CONFIG_IRQ_REMAP=y but without
> CONFIG_IOMMU_INTEL compilation fails since commit def054b01a8678 with an
> undefined reference to device_rbtree_find(). This patch makes sure that
> intel specific code is only compiled with CONFIG_IOMMU_INTEL=y.
> 
> Fixes: def054b01a8678 ("iommu/vt-d: Use device rbtree in iopf reporting path")

I think it should fix below commit:

Fixes: 80a9b50c0b9e ("iommu/vt-d: Improve ITE fault handling if target 
device isn't present")

> 
> Signed-off-by: Bert Karwatzki<spasswolf@web.de>

For users who want a configuration with interrupt remapping and without
DMA remapping, they can achieve this by selecting
IOMMU_DEFAULT_PASSTHROUGH or using kernel command "iommu.passthrough=1".

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu



