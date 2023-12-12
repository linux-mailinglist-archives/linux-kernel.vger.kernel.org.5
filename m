Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABCF80E43D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjLLGZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjLLGZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:25:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E16BF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 22:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702362339; x=1733898339;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kACYgNP4fFKqMuvf/CAgyapT7zWGWBcU7fPSLJDh5J0=;
  b=mojpuUH6D8O5DyDyn11mph6ctrKVSxOsqUUpOGnDmWV7AxiF76RPiwKz
   tCA3w1FQDnxDwrarKeP29tmF+7z+KgxuGjb7FcrBobWF17r6+yaCWYC6m
   ClSVKDcJybI49XFXQeimwYqv2UmtqetdoRmqanT9pGc1js+kc11whyWWr
   vZBp8BBvtQq9oajbKbcMqB11ABG9DrkxhzOFsfCFLzI/VK+AgXCZdhgzB
   YLOoZ1wSXPX9Nie0ZaGJcO6v5OJ20UBMjXiiy4sskPz0SRSuPkUkZ6494
   /wHs81gmTMK/y0aGz/j9tQRxl/CQEjSEjb2Y46l52d3+RcoZVMKrP0RUg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1622586"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1622586"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 22:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="802347749"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="802347749"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga008.jf.intel.com with ESMTP; 11 Dec 2023 22:25:35 -0800
Message-ID: <bef0f903-3665-492f-8999-fe759be5fed4@linux.intel.com>
Date:   Tue, 12 Dec 2023 14:20:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1161d8aa-9fcc-4e9e-a7d3-c461fee19a54@linux.intel.com>
 <BN9PR11MB5276AC40C423A0BAAE9F40A98C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276AC40C423A0BAAE9F40A98C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 11:58 AM, Tian, Kevin wrote:
>>> there are two cases above which mandates IDENTITY. Have you confirmed
>>> that those platforms support hardware passthrough? otherwise this
>> change
>>> is broken.
>> Those two cases should be hardware quirks for SoC-integrated devices. It
>> makes no reason that a quirk requires IOMMU passthrough translation, but
>> the hardware doesn't support it.
>>
>> If, unfortunately, those quirks turn out to be workarounds for a poorly
>> designed device driver, we should remove those quirks and request the
>> device driver to utilize the DMA ownership framework to achieve the same
>> functionality within the driver itself.
>>
> if that is the case you should fix the drivers first before breaking them.
> 
> But at a glance looks those two quirks are just fine.
> 
> For Azalia sound device the problem is that BIOS enables a dedicated
> DMAR for it but allocates zero TLB entries to cause deadlock. This
> implies a hw passthrough mode otherwise it's still broken.

Yes. It's safe for Azalia sound device.

> 
> For GFX it's a workaround added since day one. there is even still
> an option CONFIG_INTEL_IOMMU_BROKEN_GFX_WA available. But
> now its meaning is really disabling IOMMU instead of using identity.
> 
> sounds like IDENTMAP_GFX can be fully removed now:
> 
> #ifdef CONFIG_INTEL_IOMMU_BROKEN_GFX_WA
> 	dmar_map_gfx = 0;
> #endif

We should already remove the workaround for the 2.6 kernel. :-)

It's default "n". Therefore, if any gfx driver still needs this
workaround, there should already be a bug report.

> 
> 	if (!dmar_map_gfx)
> 		iommu_identity_mapping |= IDENTMAP_GFX;

So with above cleaned up, we have no need to worry about drivers that
are not capable of handling remapped dma address any more.

Did I miss anything?

Best regards,
baolu
