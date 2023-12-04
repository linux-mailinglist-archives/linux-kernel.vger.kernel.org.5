Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA939802A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjLDDvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 22:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjLDDvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 22:51:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D211B6;
        Sun,  3 Dec 2023 19:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701661870; x=1733197870;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x6EE+AhGPhDn7GdBQS0cdPrBG4VIAC2IhVhjOkZ66cc=;
  b=acvkaiZMPhA22jq7pPg1G9w+4PbXE1Upx0BwrcT6jHHBNEe6VYk6luU8
   R+ps/zUJ2V7ylfRlZn3Tjc/RzawdnNvGOK+X1W4nf61R0fVKE0yGBvcAM
   9AJDF4nElkkcBFFemb3kqo124c9x2hCTsyCq8N6duHNVSkRF4HCTT/Th7
   dXrFWcPcJFUcEREL0SHUjEgPsBRqSG1B8y+1Uxq1QUS8LQTu12rkWYXcA
   u3xC65hPmDnD7HL/OQcPHbjBzEiimEp9xmFnHM070CPcTBpRJekx3sXr8
   Z2sgjKAEEvn8JjYsinuhPd2kUefWIXRqx+5tMo7+EBAM43h8+DJWBX2Gk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="397566700"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="397566700"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 19:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="836447404"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="836447404"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2023 19:51:05 -0800
Message-ID: <93a57e63-352c-407c-ac3f-4b91c11d925d@linux.intel.com>
Date:   Mon, 4 Dec 2023 11:46:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] iommu: Improve iopf_queue_flush_dev()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-13-baolu.lu@linux.intel.com>
 <20231201203536.GG1489931@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231201203536.GG1489931@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/23 4:35 AM, Jason Gunthorpe wrote:
> I'm looking at this code after these patches are applied and it still
> seems quite bonkers to me 🙁
> 
> Why do we allocate two copies of the memory on all fault paths?
> 
> Why do we have fault->type still that only has one value?
> 
> What is serializing iommu_get_domain_for_dev_pasid() in the fault
> path? It looks sort of like the plan is to use iopf_param->lock and
> ensure domain removal grabs that lock at least after the xarray is
> changed - but does that actually happen?
> 
> I would suggest, broadly, a flow for iommu_report_device_fault() sort
> of:
> 
> 1) Allocate memory for the evt. Every path except errors needs this,
>     so just do it
> 2) iopf_get_dev_fault_param() should not have locks in it! This is
>     fast path now. Use a refcount, atomic compare exchange to allocate,
>     and RCU free.
> 3) Everything runs under the fault_param->lock
> 4) Check if !IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE, set it aside and then
>     exit! This logic is really tortured and confusing
> 5) Allocate memory and assemble the group
> 6) Obtain the domain for this group and incr a per-domain counter that a
>     fault is pending on that domain
> 7) Put the*group*  into the WQ. Put the*group*  on a list in fault_param
>     instead of the individual faults
> 8) Don't linear search a linked list in iommu_page_response()! Pass
>     the group in that we got from the WQ that we*know*  is still
>     active. Ack that passed group.
> 
> When freeing a domain wait for the per-domain counter to go to
> zero. This ensures that the WQ is flushed out and all the outside
> domain references are gone.
> 
> When wanting to turn off PRI make sure a non-PRI domain is
> attached to everything. Fence against the HW's event queue. No new
> iommu_report_device_fault() is possible.
> 
> Lock the fault_param->lock and go through every pending group and
> respond it. Mark the group memory as invalid so iommu_page_response()
> NOP's it. Unlock, fence the HW against queued responses, and turn off
> PRI.
> 
> An*optimization*  would be to lightly flush the domain when changing
> the translation. Lock the fault_param->lock and look for groups in the
> list with old_domain.  Do the same as for PRI-off: respond to the
> group, mark it as NOP. The WQ may still be chewing on something so the
> domain free still has to check and wait.

Very appreciated for all the ideas. I looked through the items and felt
that all these are good optimizations.

I am wondering whether we can take patch 1/12 ~ 10/12 of this series as
a first step, a refactoring effort to support delivering iopf to
userspace? I will follow up with one or multiple series to add the
optimizations.

Does this work for you? Or, you want to take any of above as the
requirement for iommufd use case?

Best regards,
baolu
