Return-Path: <linux-kernel+bounces-116451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE7388A2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980C5BA46A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E781552F5;
	Mon, 25 Mar 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmAEkXFt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9F26CC0C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337275; cv=none; b=nwFBtO5bBdJV56j5xrJcN0ha03BVg6VI8Z3QiZ69Accb56dApNeXUhv3wxTuLVtf+TGQdreWtZQUlUOQJ2BZWQpmK/OReTW7P2uXljcvlNMPWMMC/F37Sy0Yb+vuehjJaNh4PmyF+X8+nelRUD2J9+dtrFkN2VThaP5jmSAS3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337275; c=relaxed/simple;
	bh=8GEkeuAmsQ5Ut/QQW7+jcdbWaLfMKQm0ScLz9EoS63Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t1iy9gwbzqniU4rfGa9f/kn4WEDoEG1ZMmSEom/J8WGB0B4wwT7CrczPJaQ7PsjadcX6/CrYhxMQmhgQg9+SEN5YrMeIm+MVP5awIFWMm4noRLuDUjtV1BPUKxHa3fPXdaJyd/xJP4QAWl8xBgw5akzRnmHVyoyz29Buk2VMK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmAEkXFt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711337273; x=1742873273;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8GEkeuAmsQ5Ut/QQW7+jcdbWaLfMKQm0ScLz9EoS63Q=;
  b=bmAEkXFtIN58LMOa6p+WPujjm33DyhfQN2IjxEbjeGsrHoAMkwGtLpOo
   IGvGwgXSshe2ueSq4zzzIxU5iTEsf5LGppcskQ066g1+wTn+N4dxdXQRl
   oBD3Q+VuPLWvVtrZSo8XDpxloGsow1fr8U1/0I7sN5DwbjumUp4QImbSF
   UuVTK0qXXXb6AfAhzy7AropnA8+sbrQif0o9vPHV8dsYMXi8ec8Mt3j6u
   oxgufrPEjaWGoVCzHkGLh98v+GclzpvbUZhSg5vloLV1DVS61ahB5Ulu0
   dWyL2AaywnAeYr0kln+i9zsp5WgDYhRgf2smucKCXCXGY35GwalSqtB4i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6177059"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6177059"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="19951825"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 24 Mar 2024 20:27:48 -0700
Message-ID: <45fc6507-f077-4626-98cb-96cda1585718@linux.intel.com>
Date: Mon, 25 Mar 2024 11:26:57 +0800
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
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/8] iommufd: Add iommufd fault object
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
 <ad4575588dd247fa8beae60963f36404@huawei.com>
 <20240322172232.GK66976@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240322172232.GK66976@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/24 1:22 AM, Jason Gunthorpe wrote:
> On Wed, Mar 20, 2024 at 04:18:05PM +0000, Shameerali Kolothum Thodi wrote:
>> What I have noticed is that,
>> -read interface works fine and I can receive struct tiommu_hwpt_pgfault data.
>> -But once Guest handles the page faults and returns the page response,
>>   the write to fault fd never reaches the kernel. The sequence is like below,
>>   
>>    sqe = io_uring_get_sqe(ring);
>>    io_uring_prep_write(sqe, hwpt->fault_fd, resp, sizeof(*resp), 0);
>>    io_uring_sqe_set_data(sqe, resp);
>>    io_uring_submit(ring);
>>    ret = io_uring_wait_cqe(ring, &cqe);
>>    ....
>> Please find the function here[2]
>>
>> The above cqe wait never returns and hardware times out without receiving
>> page response. My understanding of io_uring default op is that it tries to
>> issue an sqe as non-blocking first. But it looks like the above write sequence
>> ends up in kernel poll_wait() as well.Not sure how we can avoid that for
>> write.
> Ah, right, it is because poll can't be choosy about read/write, it has
> to work equally for both directions. iommufd_fault_fops_poll() never
> returns EPOLLOUT
> 
> It should just always return EPOLLOUT because we don't have any queue
> to manage.

Are you suggesting the poll file operation to be like below?

static __poll_t iommufd_fault_fops_poll(struct file *filep,
                                         struct poll_table_struct *wait)
{
         struct iommufd_fault *fault = filep->private_data;
         __poll_t pollflags = EPOLLOUT;

         poll_wait(filep, &fault->wait_queue, wait);
         mutex_lock(&fault->mutex);
         if (!list_empty(&fault->deliver))
                 pollflags = EPOLLIN | EPOLLRDNORM;
         mutex_unlock(&fault->mutex);

         return pollflags;
}

The diff is,

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index ede16702d433..a33f8aa92575 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -175,7 +175,7 @@ static __poll_t iommufd_fault_fops_poll(struct file 
*filep,
                                         struct poll_table_struct *wait)
  {
         struct iommufd_fault *fault = filep->private_data;
-       __poll_t pollflags = 0;
+       __poll_t pollflags = EPOLLOUT;

         poll_wait(filep, &fault->wait_queue, wait);
         mutex_lock(&fault->mutex);


I was originally thinking that poll file operation is specifically
designed for polling on read events associated with IOMMU faults.

Best regards,
baolu

