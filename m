Return-Path: <linux-kernel+bounces-70785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9460D859C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4411D2815A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5892031A;
	Mon, 19 Feb 2024 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSXFxpCA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E29200C9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325236; cv=none; b=pvvfJzdc1/Q3TfSNCgW4qsRzVuXOhZHC6FZPtl4XZRnyBrpw+skxfwIOfwn2QL5l7p44GmAgA0fJ9IjvtCVXZx14Rl8GlYBwAKfA4eDZlQGCKI81oQY/MVwKXHJ8/NXbKNACg9nUlFRytGO717Y6KBLZQ30pXDaSOgIzlZV1IJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325236; c=relaxed/simple;
	bh=AQgWjzvqTiOHr11WQ/mBCiNAoANxgSSG+XlUuNZd+yM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bNm9aKrK3v6l0RzHu/7wosSfImNmWtNdSPbijewLPU3fVQcresvMkRpZtsXpLzkOV/gaGgrSYMAKTF11TyfbNczZIbztVEW4L/48v6mnxylR+KBMASWtEoMJ63poqGbssN/3xhagG5g/dnkGn0GU3fmNA5HEly1hmI9yzEGWewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSXFxpCA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708325234; x=1739861234;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AQgWjzvqTiOHr11WQ/mBCiNAoANxgSSG+XlUuNZd+yM=;
  b=nSXFxpCADiF7HbP0jfhVf/7f7RYOHnEGruHEwb5kuE+lRO0tvUsMY10W
   S+TRsOKjvQih61KEUC+fkPaxl5Qenv71a+cOTqi9uYs3zIWesqJu1zSz8
   qGd2pi4wE6Ij5yApX1KD2YyAR0Zp2bV6LbHn4+FHshVgCtHlyjFutfWYu
   1glfpvpRMrswHPlq4MbqZGhogdDX2+SdJBkZDapU0UPpUkp+gjsn/Igry
   9fat9149qQH6pWdw8kWGDtxYrqMj+8t+NOL9bWuzY/M7Vg5k6m3Mu7SvN
   iPMYEbds1DkvgSfbVjukIVMYjwXdcxhwe8DvLXE2ZSzRCjPPGXnmPuWpf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2253335"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2253335"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4659757"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.112]) ([10.254.215.112])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:47:11 -0800
Message-ID: <11a2a48f-aad9-42b0-a9a1-29ea1c0f7f45@linux.intel.com>
Date: Mon, 19 Feb 2024 14:47:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Huang Jiaqing <jiaqing.huang@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-2-baolu.lu@linux.intel.com>
 <eace2ec0-0b8b-450d-b05f-7b7ca3e473a7@linux.intel.com>
 <942dd645-7475-4c43-99c6-304601fb09eb@linux.intel.com>
 <ba137a34-68d1-4f61-a6dd-30841610c079@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ba137a34-68d1-4f61-a6dd-30841610c079@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/19 13:33, Ethan Zhao wrote:
> On 2/19/2024 12:04 PM, Baolu Lu wrote:
>> On 2024/2/19 10:45, Ethan Zhao wrote:
>>>> @@ -4264,25 +4313,34 @@ static struct iommu_device 
>>>> *intel_iommu_probe_device(struct device *dev)
>>>>       }
>>>>       dev_iommu_priv_set(dev, info);
>>>> +    ret = device_rbtree_insert(iommu, info);
>>>> +    if (ret)
>>>> +        goto free;
>>>>       if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>>>>           ret = intel_pasid_alloc_table(dev);
>>>>           if (ret) {
>>>>               dev_err(dev, "PASID table allocation failed\n");
>>>> -            kfree(info);
>>>> -            return ERR_PTR(ret);
>>>> +            goto clear_rbtree;
>>>>           }
>>>>       }
>>>>       intel_iommu_debugfs_create_dev(info);
>>>>       return &iommu->iommu;
>>>> +clear_rbtree:
>>>> +    device_rbtree_remove(info);
>>>> +free:
>>>> +    kfree(info);
>>>> +
>>>> +    return ERR_PTR(ret);
>>>>   }
>>>>   static void intel_iommu_release_device(struct device *dev)
>>>>   {
>>>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>> +    device_rbtree_remove(info);
>>>
>>> Perhpas too early here to remove dev from the rbtree, if it is wanted in
>>> devTLB invalidation steps in intel_pasid_tear_down_entry().
>>
>> Perhaps the caller of device_rbtree_find() should not depend on the
> 
> I didn't catch up here. seems have to maintain the lifecycle as PCI 
> subsystem
> does, or there would be mutli instances for the same BDF(e.g. the device is
> removed then plugged, again and again.....in the same slot) in the rbtree ?

There should not be multiple instances for a same BDF. The lifecycle of
a device is managed by the device and driver core. The iommu subsystem
registers a notification to the core and take actions on device ADD and
REMOVE events.

Best regards,
baolu

