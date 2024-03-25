Return-Path: <linux-kernel+bounces-116534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87988A071
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AC52C2911
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4880C0A;
	Mon, 25 Mar 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+qgGCTT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6215ECF3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342901; cv=none; b=kfluZdaSxLG++crXlLPrQO0BjtDcvbZKD2nENPFFJyAhSlWB6wPNWyK14CJGGxE1ywlIyACXFP8iXQWDEcuFMpI1O5rXpWhopelyCy5/0J9/2Xy68lKezYCv7e3iV4OhSL3Gh8VJaH5nzShI6QwJ77b0CRpd6Jjpa4+zZ9YYJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342901; c=relaxed/simple;
	bh=/N5JTo1cqebm9N//Jwpzh45pjE1qsAYdVPNGOLORkyI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C/detiEjZW0103SX3mltXzBnR143QaHrkD5vye4IxwAdftE1gPeSmGWiky461BsHrN0Z5hu2cMI1zeLdqEnxVbpgjhGSodZZHT7CG7reI3wFlr/78cEPXlERNvxnONi765cpSPKTAhOIgVuYa6BaLbqbMjSM48KmalGwmildeJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+qgGCTT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711342899; x=1742878899;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/N5JTo1cqebm9N//Jwpzh45pjE1qsAYdVPNGOLORkyI=;
  b=U+qgGCTTNmJear1eHz9rCeJ9Dl9qhfrZZD3WmbAEUITjtwbmcejefq2Q
   A7LUfV/Ubr2bB6WEHEmgxmSLFPSJs//S6p7d0FGLsbL2MKVlV8ZS2n6nT
   1ku4SoS92LLexMTv6zSbkBWsQWRBIlf8YqFAj4gFm7tYshBiBuqgqoCEp
   2TbCBhL7WGZufucOni5yk7T1YtLkyJ7pg1exwLlAJKluiYFldPjLF5S6m
   eexVUquH6EmxV65DMzGNK4JPug4AixWsipErmzIrHLaWro9nmfAdsG0Bs
   pqW1YM9S9su8t9ePK091REJDy2cXfUH1Ad2w7Xjm03r2h90sefiaXQFE0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="31764838"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="31764838"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 22:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15932605"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.86]) ([10.254.209.86])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 22:01:35 -0700
Message-ID: <90813c19-5fef-4c29-9387-6c9e2770a549@linux.intel.com>
Date: Mon, 25 Mar 2024 13:01:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] iommufd: Add iommufd fault object
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
 <20240308180332.GX9225@ziepe.ca>
 <e66064d7-c384-4f14-9459-ea21809b51b5@linux.intel.com>
 <20240322170939.GJ66976@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240322170939.GJ66976@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/23 1:09, Jason Gunthorpe wrote:
> On Fri, Mar 15, 2024 at 09:46:06AM +0800, Baolu Lu wrote:
>> On 3/9/24 2:03 AM, Jason Gunthorpe wrote:
>>> On Mon, Jan 22, 2024 at 03:38:59PM +0800, Lu Baolu wrote:
>>>> --- /dev/null
>>>> +++ b/drivers/iommu/iommufd/fault.c
>>>> @@ -0,0 +1,255 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/* Copyright (C) 2024 Intel Corporation
>>>> + */
>>>> +#define pr_fmt(fmt) "iommufd: " fmt
>>>> +
>>>> +#include <linux/file.h>
>>>> +#include <linux/fs.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/iommufd.h>
>>>> +#include <linux/poll.h>
>>>> +#include <linux/anon_inodes.h>
>>>> +#include <uapi/linux/iommufd.h>
>>>> +
>>>> +#include "iommufd_private.h"
>>>> +
>>>> +static int device_add_fault(struct iopf_group *group)
>>>> +{
>>>> +	struct iommufd_device *idev = group->cookie->private;
>>>> +	void *curr;
>>>> +
>>>> +	curr = xa_cmpxchg(&idev->faults, group->last_fault.fault.prm.grpid,
>>>> +			  NULL, group, GFP_KERNEL);
>>>> +
>>>> +	return curr ? xa_err(curr) : 0;
>>>> +}
>>>> +
>>>> +static void device_remove_fault(struct iopf_group *group)
>>>> +{
>>>> +	struct iommufd_device *idev = group->cookie->private;
>>>> +
>>>> +	xa_store(&idev->faults, group->last_fault.fault.prm.grpid,
>>>> +		 NULL, GFP_KERNEL);
>>>
>>> xa_erase ?
>>
>> Yes. Sure.
>>
>>> Is grpid OK to use this way? Doesn't it come from the originating
>>> device?
>>
>> The group ID is generated by the hardware. Here, we use it as an index
>> in the fault array to ensure it can be quickly retrieved in the page
>> fault response path.
> 
> I'm nervous about this, we are trusting HW outside the kernel to
> provide unique grp id's which are integral to how the kernel
> operates..

Agreed.

> 
>>>> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
>>>> +				       size_t count, loff_t *ppos)
>>>> +{
>>>> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
>>>> +	struct iommufd_fault *fault = filep->private_data;
>>>> +	struct iommu_hwpt_pgfault data;
>>>> +	struct iommufd_device *idev;
>>>> +	struct iopf_group *group;
>>>> +	struct iopf_fault *iopf;
>>>> +	size_t done = 0;
>>>> +	int rc;
>>>> +
>>>> +	if (*ppos || count % fault_size)
>>>> +		return -ESPIPE;
>>>> +
>>>> +	mutex_lock(&fault->mutex);
>>>> +	while (!list_empty(&fault->deliver) && count > done) {
>>>> +		group = list_first_entry(&fault->deliver,
>>>> +					 struct iopf_group, node);
>>>> +
>>>> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
>>>> +			break;
>>>> +
>>>> +		idev = (struct iommufd_device *)group->cookie->private;
>>>> +		list_for_each_entry(iopf, &group->faults, list) {
>>>> +			iommufd_compose_fault_message(&iopf->fault, &data, idev);
>>>> +			rc = copy_to_user(buf + done, &data, fault_size);
>>>> +			if (rc)
>>>> +				goto err_unlock;
>>>> +			done += fault_size;
>>>> +		}
>>>> +
>>>> +		rc = device_add_fault(group);
>>>
>>> See I wonder if this should be some xa_alloc or something instead of
>>> trying to use the grpid?
>>
>> So this magic number will be passed to user space in the fault message.
>> And the user will then include this number in its response message. The
>> response message is valid only when the magic number matches. Do I get
>> you correctly?
> 
> Yes, then it is simple xa_alloc() and xa_load() without any other
> searching and we don't have to rely on the grpid to be correctly
> formed by the PCI device.
> 
> But I don't know about performance xa_alloc() is pretty fast but
> trusting the grpid would be faster..
> 
> IMHO from a uapi perspective we should have a definate "cookie" that
> gets echo'd back. If the kernel uses xa_alloc or grpid to build that
> cookie it doesn't matter to the uAPI.

Okay, I will head in this direction.

Best regards,
baolu


