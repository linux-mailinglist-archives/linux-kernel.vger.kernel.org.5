Return-Path: <linux-kernel+bounces-103973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A32687C74F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C0CB20EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B054C96;
	Fri, 15 Mar 2024 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlBYgVYF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1727476
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710467210; cv=none; b=nTjU+2K4Jmeb7LVfRgXbISHfKD/p/JSDP9BhpubBC1G9emur4/d2DJHPrDNMQpwHeDuSv/i8heCp4xbCfblotFrDnnc8oYUSkPjrkC5e2TkJT448G8JxydBkzb+d9UqA4Gu72iMnJjC/EeYTYCJT4LYq9swMWVQv9Kt38GFZQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710467210; c=relaxed/simple;
	bh=l81d10+lHaftFL1YK7CpbPytTHQnfGv0yfai+oBbApQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qVpny/22+Es1hlFRr3euKgDShTSSUrX9qqIQGUmd80fs4em/HAJDgqaPYGAXsmT9pieXD7eHYe8XG/XkPz7WXucZo+xOrDCcn0R/9iRIVncyRCndE2ZKB9ZI8Qe2bffj9b1rZYBRoTO4tybJcDsbpf5I+yq1i7gNqPQIajil1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlBYgVYF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710467209; x=1742003209;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l81d10+lHaftFL1YK7CpbPytTHQnfGv0yfai+oBbApQ=;
  b=QlBYgVYFOmG1NHIPlnCM3emSqu1VD1h+WaoZlqXcpIwTCv3SyHjOImLd
   Dul/BdaLYbZqdw4MfBXBpa224WvJ6z3zrUn9BRiTkzcxMcuS/PZpWEsrx
   Dt2ePNTmQ8wqEmI+P8cskLVbPrK1Fgjd3Cg4Qa1fMbK0D6vnyu1xOhAWL
   52PhSxvnLKzE7xvL2WtmqFPBptJNf/D2JVnlaeETXNcZsBUyawRG5as0B
   vkRd7Zpie3e3PqLHuRWxuHc/fmAFSNPZDUNPiQyv933D4mYf0c1Gzljxe
   lebkPwThBwsK1wvXNU/7h9m+WOKctnJp1Tuo6jay7m12iJ2Ere7HOVLU3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="22780096"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="22780096"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:46:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12412987"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 14 Mar 2024 18:46:45 -0700
Message-ID: <e66064d7-c384-4f14-9459-ea21809b51b5@linux.intel.com>
Date: Fri, 15 Mar 2024 09:46:06 +0800
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
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
 <20240308180332.GX9225@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240308180332.GX9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/24 2:03 AM, Jason Gunthorpe wrote:
> On Mon, Jan 22, 2024 at 03:38:59PM +0800, Lu Baolu wrote:
>> --- /dev/null
>> +++ b/drivers/iommu/iommufd/fault.c
>> @@ -0,0 +1,255 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (C) 2024 Intel Corporation
>> + */
>> +#define pr_fmt(fmt) "iommufd: " fmt
>> +
>> +#include <linux/file.h>
>> +#include <linux/fs.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/iommufd.h>
>> +#include <linux/poll.h>
>> +#include <linux/anon_inodes.h>
>> +#include <uapi/linux/iommufd.h>
>> +
>> +#include "iommufd_private.h"
>> +
>> +static int device_add_fault(struct iopf_group *group)
>> +{
>> +	struct iommufd_device *idev = group->cookie->private;
>> +	void *curr;
>> +
>> +	curr = xa_cmpxchg(&idev->faults, group->last_fault.fault.prm.grpid,
>> +			  NULL, group, GFP_KERNEL);
>> +
>> +	return curr ? xa_err(curr) : 0;
>> +}
>> +
>> +static void device_remove_fault(struct iopf_group *group)
>> +{
>> +	struct iommufd_device *idev = group->cookie->private;
>> +
>> +	xa_store(&idev->faults, group->last_fault.fault.prm.grpid,
>> +		 NULL, GFP_KERNEL);
> 
> xa_erase ?

Yes. Sure.

> Is grpid OK to use this way? Doesn't it come from the originating
> device?

The group ID is generated by the hardware. Here, we use it as an index
in the fault array to ensure it can be quickly retrieved in the page
fault response path.

>> +void iommufd_fault_destroy(struct iommufd_object *obj)
>> +{
>> +	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
>> +	struct iopf_group *group, *next;
>> +
>> +	mutex_lock(&fault->mutex);
>> +	list_for_each_entry_safe(group, next, &fault->deliver, node) {
>> +		list_del(&group->node);
>> +		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
>> +		iopf_free_group(group);
>> +	}
>> +	list_for_each_entry_safe(group, next, &fault->response, node) {
>> +		list_del(&group->node);
>> +		device_remove_fault(group);
>> +		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
>> +		iopf_free_group(group);
>> +	}
>> +	mutex_unlock(&fault->mutex);
>> +
>> +	mutex_destroy(&fault->mutex);
> 
> It is really weird to lock a mutex we are about to destroy? At this
> point the refcount on the iommufd_object is zero so there had better
> not be any other threads with access to this pointer!

You are right. I will remove the lock/unlock and add a comment instead.

> 
>> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
>> +				       size_t count, loff_t *ppos)
>> +{
>> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
>> +	struct iommufd_fault *fault = filep->private_data;
>> +	struct iommu_hwpt_pgfault data;
>> +	struct iommufd_device *idev;
>> +	struct iopf_group *group;
>> +	struct iopf_fault *iopf;
>> +	size_t done = 0;
>> +	int rc;
>> +
>> +	if (*ppos || count % fault_size)
>> +		return -ESPIPE;
>> +
>> +	mutex_lock(&fault->mutex);
>> +	while (!list_empty(&fault->deliver) && count > done) {
>> +		group = list_first_entry(&fault->deliver,
>> +					 struct iopf_group, node);
>> +
>> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
>> +			break;
>> +
>> +		idev = (struct iommufd_device *)group->cookie->private;
>> +		list_for_each_entry(iopf, &group->faults, list) {
>> +			iommufd_compose_fault_message(&iopf->fault, &data, idev);
>> +			rc = copy_to_user(buf + done, &data, fault_size);
>> +			if (rc)
>> +				goto err_unlock;
>> +			done += fault_size;
>> +		}
>> +
>> +		rc = device_add_fault(group);
> 
> See I wonder if this should be some xa_alloc or something instead of
> trying to use the grpid?

So this magic number will be passed to user space in the fault message.
And the user will then include this number in its response message. The
response message is valid only when the magic number matches. Do I get
you correctly?

> 
>> +	while (!list_empty(&fault->response) && count > done) {
>> +		rc = copy_from_user(&response, buf + done, response_size);
>> +		if (rc)
>> +			break;
>> +
>> +		idev = container_of(iommufd_get_object(fault->ictx,
>> +						       response.dev_id,
>> +						       IOMMUFD_OBJ_DEVICE),
>> +				    struct iommufd_device, obj);
> 
> It seems unfortunate we do this lookup for every iteration of the loop,
> I would lift it up and cache it..

Okay.

> 
>> +		if (IS_ERR(idev))
>> +			break;
>> +
>> +		group = device_get_fault(idev, response.grpid);
> 
> This looks locked wrong, it should hold the fault mutex here and we
> should probably do xchng to zero it at the same time we fetch it.

Okay, will fix it.

> 
>> +		if (!group ||
>> +		    response.addr != group->last_fault.fault.prm.addr ||
>> +		    ((group->last_fault.fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
>> +		      response.pasid != group->last_fault.fault.prm.pasid)) {
> 
> Why? If grpid is unique then just trust it.

I was just considering that we should add some sanity check here to
ensure the response message is composed in the right way.

> 
>> +			iommufd_put_object(fault->ictx, &idev->obj);
>> +			break;
>> +		}
>> +
>> +		iopf_group_response(group, response.code);
>> +
>> +		mutex_lock(&fault->mutex);
>> +		list_del(&group->node);
>> +		mutex_unlock(&fault->mutex);
>> +
>> +		device_remove_fault(group);
>> +		iopf_free_group(group);
>> +		done += response_size;
>> +
>> +		iommufd_put_object(fault->ictx, &idev->obj);
>> +	}
>> +
>> +	return done;
>> +}
>> +
>> +static __poll_t iommufd_fault_fops_poll(struct file *filep,
>> +					struct poll_table_struct *wait)
>> +{
>> +	struct iommufd_fault *fault = filep->private_data;
>> +	__poll_t pollflags = 0;
>> +
>> +	poll_wait(filep, &fault->wait_queue, wait);
>> +	mutex_lock(&fault->mutex);
>> +	if (!list_empty(&fault->deliver))
>> +		pollflags = EPOLLIN | EPOLLRDNORM;
>> +	mutex_unlock(&fault->mutex);
>> +
>> +	return pollflags;
>> +}
>> +
>> +static const struct file_operations iommufd_fault_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.open		= nonseekable_open,
>> +	.read		= iommufd_fault_fops_read,
>> +	.write		= iommufd_fault_fops_write,
>> +	.poll		= iommufd_fault_fops_poll,
>> +	.llseek		= no_llseek,
>> +};
> 
> No release? That seems wrong..

Yes. Will fix it.

> 
>> +static int get_fault_fd(struct iommufd_fault *fault)
>> +{
>> +	struct file *filep;
>> +	int fdno;
>> +
>> +	fdno = get_unused_fd_flags(O_CLOEXEC);
>> +	if (fdno < 0)
>> +		return fdno;
>> +
>> +	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
>> +				   fault, O_RDWR);
>                                     ^^^^^^
> 
> See here you stick the iommufd_object into the FD but we don't
> refcount it...
> 
> And iommufd_fault_destroy() doesn't do anything about this, so it just
> UAFs the fault memory in the FD.
> 
> You need to refcount the iommufd_object here and add a release
> function for the fd to put it back
> 
> *and* this FD needs to take a reference on the base iommufd_ctx fd too
> as we can't tolerate them being destroyed out of sequence.

Good catch. I will fix it.

> 
>> +int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_fault_alloc *cmd = ucmd->cmd;
>> +	struct iommufd_fault *fault;
>> +	int rc;
>> +
>> +	if (cmd->flags)
>> +		return -EOPNOTSUPP;
>> +
>> +	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
>> +	if (IS_ERR(fault))
>> +		return PTR_ERR(fault);
>> +
>> +	fault->ictx = ucmd->ictx;
>> +	INIT_LIST_HEAD(&fault->deliver);
>> +	INIT_LIST_HEAD(&fault->response);
>> +	mutex_init(&fault->mutex);
>> +	init_waitqueue_head(&fault->wait_queue);
>> +
>> +	rc = get_fault_fd(fault);
>> +	if (rc < 0)
>> +		goto out_abort;
> 
> And this is ordered wrong, fd_install has to happen after return to
> user space is guarenteed as it cannot be undone.
> 
>> +	cmd->out_fault_id = fault->obj.id;
>> +	cmd->out_fault_fd = rc;
>> +
>> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>> +	if (rc)
>> +		goto out_abort;
>> +	iommufd_object_finalize(ucmd->ictx, &fault->obj);
> 
> fd_install() goes here

Yes. Sure.

> 
>> +	return 0;
>> +out_abort:
>> +	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
>> +
>> +	return rc;
>> +}
> 
> Jason

Best regards,
baolu

