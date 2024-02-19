Return-Path: <linux-kernel+bounces-70823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52C4859CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD41F215C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F2420B10;
	Mon, 19 Feb 2024 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZOWkR23"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622120B04
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327482; cv=none; b=cwwoxF5EiegQXtbAUWJ2GDkjl122Lfa/PaH05vvlNSQDUqbVV3BiTWP7T8NKuG2+mFJLTxGZJBCy59PCswAEP4G+MOEiYbY9+GmXrU/vwCF1JiiE9W//vUgf6wD6mMnnwjBTfSlZz0BZmq+Q759KsbfCJt+/DIGKeJUs9DFpsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327482; c=relaxed/simple;
	bh=Y5OgD0gzlaPjteSizS3leXdfZRmgjidV4tkL6TXn8LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMQT7MD+a13ZgkhY0Utd27meS2XejN18z1XRukRuv805fLiq/YyL2CqjSHV2pY+B1ygsFNJXv/+Bhyx4VIlru/xLAVc25kBt/7PBbEPQUPGMdY6mT39RXQSSTyj7oGmRaWqWeAxfaiQAPrziU4eOWkneoMLzi907MUcCjXw7YAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZOWkR23; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708327481; x=1739863481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y5OgD0gzlaPjteSizS3leXdfZRmgjidV4tkL6TXn8LA=;
  b=fZOWkR23WGjy5ySclCvAzQNGZ1rx3vMpCHIrLNyCSBQVlQqxMrQHOW6l
   pgK2+9QNsgjOCY/ZrY/5hm8ZR7oBJ8ngTxYbFV/FU3BtEtdZ2Rxd5uPa2
   bkE0ArLXaDnuxDPn3z2sLMwjZ126H8JaYbT2Ov31iPswt62b34TNCSiNC
   DSvxn/1zx9EMxkiHe/tCwQ29ibG32PmJRvzgrKlTvEC0SsS/GliSa1rue
   tkwQHJpOyitUYt4WX96W+QKw3OYgH2JbsESxw7uFeBJDVQ/aveY2Jcnzc
   YbvQ9ZCs7RnyjpWmt3DfBbisg1U1yuBdJmQnj+GYWG2fZL76kUwGJwfvA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19821119"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19821119"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9021525"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.209.179]) ([10.254.209.179])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:24:38 -0800
Message-ID: <a0b16fc8-4812-4126-8dab-445aa974307a@linux.intel.com>
Date: Mon, 19 Feb 2024 15:24:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Huang Jiaqing <jiaqing.huang@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-2-baolu.lu@linux.intel.com>
 <eace2ec0-0b8b-450d-b05f-7b7ca3e473a7@linux.intel.com>
 <942dd645-7475-4c43-99c6-304601fb09eb@linux.intel.com>
 <ba137a34-68d1-4f61-a6dd-30841610c079@linux.intel.com>
 <11a2a48f-aad9-42b0-a9a1-29ea1c0f7f45@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <11a2a48f-aad9-42b0-a9a1-29ea1c0f7f45@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/2024 2:47 PM, Baolu Lu wrote:
> On 2024/2/19 13:33, Ethan Zhao wrote:
>> On 2/19/2024 12:04 PM, Baolu Lu wrote:
>>> On 2024/2/19 10:45, Ethan Zhao wrote:
>>>>> @@ -4264,25 +4313,34 @@ static struct iommu_device 
>>>>> *intel_iommu_probe_device(struct device *dev)
>>>>>       }
>>>>>       dev_iommu_priv_set(dev, info);
>>>>> +    ret = device_rbtree_insert(iommu, info);
>>>>> +    if (ret)
>>>>> +        goto free;
>>>>>       if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>>>>>           ret = intel_pasid_alloc_table(dev);
>>>>>           if (ret) {
>>>>>               dev_err(dev, "PASID table allocation failed\n");
>>>>> -            kfree(info);
>>>>> -            return ERR_PTR(ret);
>>>>> +            goto clear_rbtree;
>>>>>           }
>>>>>       }
>>>>>       intel_iommu_debugfs_create_dev(info);
>>>>>       return &iommu->iommu;
>>>>> +clear_rbtree:
>>>>> +    device_rbtree_remove(info);
>>>>> +free:
>>>>> +    kfree(info);
>>>>> +
>>>>> +    return ERR_PTR(ret);
>>>>>   }
>>>>>   static void intel_iommu_release_device(struct device *dev)
>>>>>   {
>>>>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>>> +    device_rbtree_remove(info);
>>>>
>>>> Perhpas too early here to remove dev from the rbtree, if it is 
>>>> wanted in
>>>> devTLB invalidation steps in intel_pasid_tear_down_entry().
>>>
>>> Perhaps the caller of device_rbtree_find() should not depend on the
>>
>> I didn't catch up here. seems have to maintain the lifecycle as PCI 
>> subsystem
>> does, or there would be mutli instances for the same BDF(e.g. the 
>> device is
>> removed then plugged, again and again.....in the same slot) in the 
>> rbtree ?
>
> There should not be multiple instances for a same BDF. The lifecycle of
> a device is managed by the device and driver core. The iommu subsystem
> registers a notification to the core and take actions on device ADD and
> REMOVE events.

Move device_rbtree_remove(info) to end of this REMOVED notifier callback, or such
beautiful code wouldn't work :)

struct device *dev = device_rbtree_find(iommu, ite_sid);
if (!dev || !pci_device_is_present(to_pci_dev(dev)))
   return -ETIMEDOUT;

Thanks,
Ethan

  

>
> Best regards,
> baolu
>

