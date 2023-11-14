Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AC67EA91F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjKND0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKND0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:26:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88418D45
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699932392; x=1731468392;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Lrgjz0p3fqKsXXSmPfXk4FbDshEG0LNAMEKNDR7cwY=;
  b=TKJN/nlIxuAr4NS1cHW6DujHUy0+yOJf7cLon0BH3Oj8UlHHyPlSGm3t
   J4ZkPSgTjA7V/n4iOTXdyrfAJhCgLPRX9jZspWA79Y2IZ8EFNPvFbnpYN
   e+86PKEtNLLBSc8NL97F5NH6P8ByVoGrncIe3NDwk1Ob3w3+tCONt69Xd
   /V0QkyqIb8rf3HVSA56Gg6OygiGBrwGWlkXSl0I/dIFU7x7DJ7pdwnV3/
   R7L2sLH+DhCE+2ZZo/ijkVa7bkeg4VZ0TOuxmgVSLbJxSHfxig49Rm2ja
   Y3nma6tYbsQmm5xFOT9kHHVbOrw28b6BhLwPfzvoqNnBMJXmmp2aghgpf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="390366526"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="390366526"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 19:26:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="793623114"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="793623114"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2023 19:26:29 -0800
Message-ID: <c3053d76-433b-4c4d-b19b-13ff61c7dab4@linux.intel.com>
Date:   Tue, 14 Nov 2023 11:22:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Make context clearing consistent with
 context mapping
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52765C637BFAD28ADF1D24738CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765C637BFAD28ADF1D24738CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 11:20 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, November 14, 2023 9:11 AM
>>
>> In the iommu probe_device path, domain_context_mapping() allows setting
>> up the context entry for a non-PCI device. However, in the iommu
>> release_device path, domain_context_clear() only clears context entries
>> for PCI devices.
>>
>> Make domain_context_clear() behave consistently with
>> domain_context_mapping() by clearing context entries for both PCI and
>> non-PCI devices.
>>
>> Fixes: 579305f75d34 ("iommu/vt-d: Update to use PCI DMA aliases")
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> The code before the fix tag also has the same problem. If we really want
> backport then let's find out the very first commit which exhibits this
> problem.

Commit 579305f75d34 allows non-PCI devices.

+       if (!dev_is_pci(dev))
+               return domain_context_mapping_one(domain, iommu, bus, devfn,
                                                   translation);
+
+       data.domain = domain;
+       data.iommu = iommu;
+       data.translation = translation;
+
+       return pci_for_each_dma_alias(to_pci_dev(dev),
+                                     &domain_context_mapping_cb, &data);

But it forgot to update the domain_context_clear() helper. So this is
actually a fix for that commit.

> 
> But I wonder the actual impact w/o such fix. If there is no hot-remove
> possible for those non-PCI devices the context entry will be leaved
> enabled until the machine is off. Then this fix is nice-to-have then
> probably no need to backport?

It doesn't cause real issues as far as I can see. So there's no need to
back port it to stable kernels. That's the reason I didn't add cc-stable
tag. But we still need a fix tag as it's actually a fix.

Best regards,
baolu
