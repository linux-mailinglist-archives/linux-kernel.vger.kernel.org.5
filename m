Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E187FE8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344401AbjK3FoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3FoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:44:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F904D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 21:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701323064; x=1732859064;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b2dMFYdOcHAo38z3q2kDlbOysHjM082XDpQ6VTrvX3c=;
  b=Y3ATY60O/0afwW30HzJmQ5TOaqRaMuMZ5LHJz+VTUkTla3tU2Qb5kiUi
   y99N3Ihzem9IVNYOrQxBRQPTl3/B3F1XOXoLPlXtGR9xV5IQ2SNP3CDJ7
   lA4qVGE+9VkWOwEsBDVchUP1vFKkaawVkaoAhpSRvBUr1G84aV0qC/O5w
   FLBPN+mPFa8PhN35Za4QzGuUrT3vQ9y1ve5qBOD7wveW3DpcT1LCwBJaQ
   by+YcHvBigENcNXryLA3Mo2HB4UAzbRpBv6AtSptRIYgqCpBbZxPLrjPw
   gby0UE/Gwal3BAlokggeH6aVeN/Yx8UitfLcKHHZk0G/t5goojyTotvDD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="263295"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="263295"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 21:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="860079707"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="860079707"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.155]) ([10.249.171.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 21:44:21 -0800
Message-ID: <8186755c-fe80-424c-9b50-06ea213b3b17@linux.intel.com>
Date:   Thu, 30 Nov 2023 13:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
 <20231129201324.GL1312390@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231129201324.GL1312390@ziepe.ca>
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

On 2023/11/30 4:13, Jason Gunthorpe wrote:
> On Tue, Nov 14, 2023 at 09:10:35AM +0800, Lu Baolu wrote:
>> When IOMMU hardware operates in legacy mode, the TT field of the context
>> entry determines the translation type, with three supported types (Section
>> 9.3 Context Entry):
>>
>> - DMA translation without device TLB support
>> - DMA translation with device TLB support
>> - Passthrough mode with translated and translation requests blocked
>>
>> Device TLB support is absent when hardware is configured in passthrough
>> mode.
>>
>> Disable the PCI ATS feature when IOMMU is configured for passthrough
>> translation type in legacy (non-scalable) mode.
> Oh.. That is the same horrible outcome that ARM has 🙁
> 
> The issue is what to do if the RID translation is in identity but a
> PASID is attached that should be using ATS - eg do you completely
> loose SVA support if the RID is set to the optimized identity mode?

This fix only affects the non-scalable mode that doesn't support PASID
  features.

> I vote no. We should make the drivers aware that they should not use
> ATS on their RIDs instead 🙁

Intel VT-d hardware does not supported ATS in non-scalable mode when
translation is set to passthrough mode. Historically, the Intel IOMMU
driver has never enabled the ATS feature in this configuration.

Commit 0faa19a1515f changed this behavior by accident, potentially
leading to incorrect hardware configuration. This patch fixes the issue
by reverting to the previous behavior. Otherwise, it leads to hardware
configuration errors and potential DMA malfunction, as all translated
DMA requests would be blocked by the IOMMU.

Going forward, I agree that device drivers should have the ability to
access and potentially control the ATS status. I have a upcoming series
that will enable device drivers or user-space to manage the ATS as we
have discussed in other threads before.

Best regards,
baolu
