Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC97EDA39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344906AbjKPD2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjKPD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:28:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FE9D44
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700105291; x=1731641291;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DhK1ix88G1Yi7MN02s45jcyCSJlvBkl/JOoMUxCCVrc=;
  b=IW5watGy1x+DTzxKxB1E8b2WyfFfuEdj7IZ1TFY2pAMa6UExksMY/aJd
   nm5kDgTzgvLGlG/KZZxO9l9LYGosb27gvZpNwrU6hFU0eOJ1+yOWBb0FN
   RVW86ltcpc5Mc9pp24seqr893zLAU40ON50hrQqHaftgbtUASGnywFkj0
   I+uO5S34QLop50f97vilWVxleAmifYX/2S5JNOVtok+MxEjTIZ39jToYr
   gLteiJyTsTMJnsmsLfbpb37TL0zApAEQAOLfTsQvod81fu7oR+Z4pOH85
   ceC0P3wa+uPrvB7ULvP4hHAo2EFgALiC8Z/5NiUB+CcVWR4ggMya4wcOA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4132673"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="4132673"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765180519"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="765180519"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2023 19:28:08 -0800
Message-ID: <053e89dd-8de9-43f3-8530-1f65181efd46@linux.intel.com>
Date:   Thu, 16 Nov 2023 11:23:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iommu/vt-d: Introduce dev_to_iommu()
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276CF0833BF362C1BE5F2268CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276CF0833BF362C1BE5F2268CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 11:19 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 16, 2023 9:51 AM
>>
>> +static inline struct intel_iommu *dev_to_iommu(struct device *dev)
>> +{
>> +	/*
>> +	 * Assume that valid per-device iommu structure must be installed
>> +	 * if iommu_probe_device() has succeeded. This helper could only
>> +	 * be used after device is probed.
>> +	 */
>> +	return ((struct device_domain_info *)dev_iommu_priv_get(dev))-
>>> iommu;
>> +}
> 
> Not sure whether this helper is useful. This is only used by 2 out of 5
> post-probe users. Probably just open-coding in all 5 places is clearer.

I thought it should get more users in the future development.

Best regards,
baolu

