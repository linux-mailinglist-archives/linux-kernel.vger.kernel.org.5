Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA27EFD2D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjKRCbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjKRCbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:31:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229B41A1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700274676; x=1731810676;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OehhV+d7VO0CSQ4vXI/Vdbgi96ek9dXfotfoBbJcYbo=;
  b=CTYFMz1i+VRMHfJcV/WccyglVv8A8YOCnaU284sGx7EiR6OI8b68EpWG
   mNcDwF8pXjvq8aOuJLWrAowACDcSjeYhObMUbA+FQa92HADvB/lu5t9ZT
   paa36P/++fAqkcbDaucg0/11SSPcsXPuUjYSkummIK8fKHbMbC1jskWGo
   pPPlR2omAYLP1WjWH5rW3wReTvxGO6WBOaSojytI78UCJtFu0sXg0PDRs
   SkUiY5XyWT0Df6Yn4nWYSPXbQlUFLTx0NAyxmXeRb7Ug02/HDvbBT5KZ2
   BZPx7YBnmTVmTNoOlRJIBGnCBUAlGlHkZo0IvHmVai3cHzqUXG4abE7yl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="422494485"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="422494485"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 18:31:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="7023525"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 17 Nov 2023 18:31:14 -0800
Message-ID: <79a1f935-12c1-4e12-92c8-2214bf6b7a73@linux.intel.com>
Date:   Sat, 18 Nov 2023 10:26:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iommu/vt-d: Introduce dev_to_iommu()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276CF0833BF362C1BE5F2268CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <053e89dd-8de9-43f3-8530-1f65181efd46@linux.intel.com>
 <20231117130756.GA6501@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231117130756.GA6501@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/23 9:07 PM, Jason Gunthorpe wrote:
> On Thu, Nov 16, 2023 at 11:23:56AM +0800, Baolu Lu wrote:
>> On 11/16/23 11:19 AM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Thursday, November 16, 2023 9:51 AM
>>>>
>>>> +static inline struct intel_iommu *dev_to_iommu(struct device *dev)
>>>> +{
>>>> +	/*
>>>> +	 * Assume that valid per-device iommu structure must be installed
>>>> +	 * if iommu_probe_device() has succeeded. This helper could only
>>>> +	 * be used after device is probed.
>>>> +	 */
>>>> +	return ((struct device_domain_info *)dev_iommu_priv_get(dev))-
>>>>> iommu;
>>>> +}
>>> Not sure whether this helper is useful. This is only used by 2 out of 5
>>> post-probe users. Probably just open-coding in all 5 places is clearer.
>> I thought it should get more users in the future development.
> The pattern in the SMMUv2 driver is like
> 
>    struct device_domain_info *info = dev_iommu_priv_get(dev);
>    struct intel_iommu *iommu = info->iommu;
> 
> Which really isn't worth the helper, unless you have lots of caes
> where info isn't needed at all?

No. As Kevin pointed out, there are only 2 places.

I will drop this helper.

Best regards,
baolu
