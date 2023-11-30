Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDFC7FE828
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjK3EHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344410AbjK3EG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:06:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7310CB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701317224; x=1732853224;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KxJStMIjvmZs8RPaJO7hZ8ggE4sIsO6JisfWuT7Iv7g=;
  b=DE1ZLcaDbtezW340PO6lWTB2/Cr3A4imTzzLvyI4MQzmFRtWmcjwW7Pd
   sYpYoxNTj7rtpZiQiSifVLnwPVQjHWN95X3Vk1u0ooPttrXSp9T4Xu5jo
   GPryUO9364ZhyGVNYfdjkhWAYxJ2UIA5LT0heA5G+5ZQu9i9PaLC9gQOt
   LWbweAJbLVLfClMazh3t5kFhfVskTVqbxMyZ98UYjflcvtiW5+Mxxi2Y5
   CK6OLhh3MzM9rZ4HCDylmCZnGT33j9RdOkqlX/v3WtfQ9pQR+anDR10p+
   fzMsLm+G2HHiyegWk2eiwiFYzmlJxh7ZcXXQqD7eiKWcTY4LLDasIM878
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392130204"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392130204"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 20:07:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="10614646"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.155]) ([10.249.171.155])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 20:07:02 -0800
Message-ID: <2f2582df-fb56-4b46-8ce3-364879b34734@linux.intel.com>
Date:   Thu, 30 Nov 2023 12:06:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
 <20231129201020.GK1312390@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231129201020.GK1312390@ziepe.ca>
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

On 2023/11/30 4:10, Jason Gunthorpe wrote:
> On Tue, Nov 14, 2023 at 09:10:34AM +0800, Lu Baolu wrote:
>> The latest VT-d spec indicates that when remapping hardware is disabled
>> (TES=0 in Global Status Register), upstream ATS Invalidation Completion
>> requests are treated as UR (Unsupported Request).
>>
>> Consequently, the spec recommends in section 4.3 Handling of Device-TLB
>> Invalidations that software refrain from submitting any Device-TLB
>> invalidation requests when address remapping hardware is disabled.
>>
>> Verify address remapping hardware is enabled prior to submitting Device-
>> TLB invalidation requests.
>>
>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
> How did you get to the point where flush_dev_iotlb could even be
> called if the iommu has somehow been globally disabled?
> 
> Shouldn't the attach of the domain compeltely fail if the HW is
> disabled?
> 
> If the domain is not attached to anything why would flushing happen?

The VT-d hardware can be in a state where the hardware is on but DMA
translation is deactivated. In this state, the device probe process
during boot proceeds as follows:

1) Initialize the IOMMU contexts: This sets up the data structures that
    the IOMMU uses to manage address translation for DMA operations.

2) Register the IOMMU devices: This registers the IOMMU devices to the
    core. The core then probes devices on buses like PCI.

3) Enable DMA translation: This step activates DMA translation.

With regard to step 2), the call to iommu_flush_iotlb_all() in
iommu_create_device_direct_mappings() can potentially cause device TBL
invalidation when the VT-d DMA translation is deactivated.

Best regards,
baolu
