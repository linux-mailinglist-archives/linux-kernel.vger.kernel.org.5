Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E6380A273
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjLHLn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHLnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:43:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2839AD59;
        Fri,  8 Dec 2023 03:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702035811; x=1733571811;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZmkAP0N/gOOmFK2HS73Ar6ckEAFg8Q3aZC+p9EeSO1Y=;
  b=GOZ1N66uIDbEVMD4+BhgoazD/AoEsfQ94BjrcIkQdHTbZUOB5cnjx47X
   b64apZQ1fMDcaDzkh8O4CJIpwkdxJr/vhPfEChmsi75RVxt1aXVXXQzxB
   W+H9MQYM2Ahv6KqGPo4K8vabl7GWHNn3liYDbGfm7tgdjIPL0X8VyGGEw
   8/vyGDS5TGKwe0JC95SLyOCcTg5zDK1Ezx/wL0qSmaqTuvP9hsK6irLog
   7MjevueSoiPOw9liSjmTcgQuNXxUFdyT/X+/+S93SEGX8yAN7YdXWojhm
   WmVN0GCDJ930q5xO0c5jYG+ESr0EJL4l6R23fPTx8oc/zIikDVW4qai2i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="394134276"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="394134276"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="765465888"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="765465888"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.238]) ([10.255.31.238])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:43:27 -0800
Message-ID: <abc94be4-a909-4255-bb08-f0fcf45a21b8@linux.intel.com>
Date:   Fri, 8 Dec 2023 19:43:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <20231201152459.GB1489931@ziepe.ca>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231201152459.GB1489931@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/1 23:24, Jason Gunthorpe wrote:
> On Thu, Oct 26, 2023 at 10:49:28AM +0800, Lu Baolu wrote:
> 
>> +static ssize_t hwpt_fault_fops_write(struct file *filep,
>> +				     const char __user *buf,
>> +				     size_t count, loff_t *ppos)
>> +{
>> +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
>> +	struct hw_pgtable_fault *fault = filep->private_data;
>> +	struct iommu_hwpt_page_response response;
>> +	struct iommufd_hw_pagetable *hwpt;
>> +	struct iopf_group *iter, *group;
>> +	struct iommufd_device *idev;
>> +	size_t done = 0;
>> +	int rc = 0;
>> +
>> +	if (*ppos || count % response_size)
>> +		return -ESPIPE;
>> +
>> +	mutex_lock(&fault->mutex);
>> +	while (!list_empty(&fault->response) && count > done) {
>> +		rc = copy_from_user(&response, buf + done, response_size);
>> +		if (rc)
>> +			break;
>> +
>> +		/* Get the device that this response targets at. */
>> +		idev = container_of(iommufd_get_object(fault->ictx,
>> +						       response.dev_id,
>> +						       IOMMUFD_OBJ_DEVICE),
>> +				    struct iommufd_device, obj);
>> +		if (IS_ERR(idev)) {
>> +			rc = PTR_ERR(idev);
>> +			break;
>> +		}
> 
> See here it might be better to have a per-fd list of outstanding
> faults per-fd and then the cookie would just index that list, then you
> get everything in one shot instead of having to do a xarray looking
> and then a linear list search

Yours is more efficient. I will do it that way in the next version.

> 
>> +static const struct file_operations hwpt_fault_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.read		= hwpt_fault_fops_read,
>> +	.write		= hwpt_fault_fops_write,
>> +};
> 
> nonseekable_open() behavior should be integrated into this

Sure.

> 
>> +static int hw_pagetable_get_fault_fd(struct hw_pgtable_fault *fault)
>> +{
>> +	struct file *filep;
>> +	int fdno;
>> +
>> +	fdno = get_unused_fd_flags(O_CLOEXEC);
>> +	if (fdno < 0)
>> +		return fdno;
>> +
>> +	filep = anon_inode_getfile("[iommufd-pgfault]", &hwpt_fault_fops,
>> +				   fault, O_RDWR);
>> +	if (IS_ERR(filep)) {
>> +		put_unused_fd(fdno);
>> +		return PTR_ERR(filep);
>> +	}
>> +
>> +	fd_install(fdno, filep);
>> +	fault->fault_file = filep;
>> +	fault->fault_fd = fdno;
> 
> fd_install must be the very last thing before returning success from a
> system call because we cannot undo it.

Yes.

> 
> There are other failure paths before here and the final return
> 
> Jason

Best regards,
baolu

