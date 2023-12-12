Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842FE80E3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjLLFW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLLFWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:22:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CECE;
        Mon, 11 Dec 2023 21:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702358551; x=1733894551;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vBcOqMVGmk5DzvYxiQ5N9EnkBoAt4mO+G28rTQngrAU=;
  b=XmUCJP2iv9Ngmz8X2E2XQZLgQciHI0bnlMmJGRcU2zxPmiZmVJu3NNFD
   BBKyd3GiwSv8rdma3ALo8ALpXi1XcVjm3Yp+sg0ZU8D2FrRJzQIU5ObVF
   HbrrWMD+/n8MsYg6KDJFCSQ4R6IL9KryrjC4G62duUV0zgfIbnNZjZn6M
   7hYekLuhwsOI6OoaBEJuV/WKjmpMXIdyoe4OcKpoRUUXwXXX07Z+j4RF6
   Xi/VyHTCzGpfwprMrWqsxlMIrgyZguFhED/No/wBDGspCoxB7TsmN/m/K
   IPvPwgmJ0Ltmt5ojjp9YAfHhChml5/8yp+f8OX1BwARRtkvcQhF8T7lV1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480952860"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480952860"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 21:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="773388115"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="773388115"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2023 21:22:26 -0800
Message-ID: <416b6639-8904-4b31-973c-d5522e2731d8@linux.intel.com>
Date:   Tue, 12 Dec 2023 13:17:47 +0800
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
        Longfang Liu <liulongfang@huawei.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211152456.GB1489931@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231211152456.GB1489931@ziepe.ca>
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

On 12/11/23 11:24 PM, Jason Gunthorpe wrote:
> Also iopf_queue_remove_device() is messed up - it returns an error
> code but nothing ever does anything with it 🙁 Remove functions like
> this should never fail.

Yes, agreed.

> 
> Removal should be like I explained earlier:
>   - Disable new PRI reception

This could be done by

	rcu_assign_pointer(param->fault_param, NULL);

?

>   - Ack all outstanding PRQ to the device

All outstanding page requests are responded with
IOMMU_PAGE_RESP_INVALID, indicating that device should not attempt any
retry.

>   - Disable PRI on the device
>   - Tear down the iopf infrastructure
> 
> So under this model if the iopf_queue_remove_device() has been called
> it should be sort of a 'disassociate' action where fault_param is
> still floating out there but iommu_page_response() does nothing.

Yes. All pending requests have been auto-responded.

> IOW pass the refcount from the iommu_report_device_fault() down into
> the fault handler, into the work and then into iommu_page_response()
> which will ultimately put it back.

Yes.

Best regards,
baolu
