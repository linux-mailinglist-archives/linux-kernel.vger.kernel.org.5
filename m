Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AD57CD230
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJRCRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJRCRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:17:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB9AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697595455; x=1729131455;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zbbwNv+ayFL5lv8H+Tmp9KLbwONaDvNHG8Bb7FwbVIA=;
  b=G5kTw51tMNsb4xOeSsgGzNXUJSKz7RFeeYj9QiMsqyPgnwLwXIOpp0KB
   +Odu4UW2IvGeYXI0b9jN0oR/n0MYLzk3BAtHDCHYfEzRJEaPIhjMuPNqt
   tTDtRUwHr2xEnsH/AylhV1GuumBZiypICBqSQXRIFwSS6rltNNSMMKBUm
   LUuD7R3VOZW3MQdHKAZW8hcenXvY6ivodbYgHNM9MRvEZwCXEX1DSOwNI
   VsN3LZGIK1wkWpDyRfDOYgjSxr4lc+XovQchmdx9N1k3dVdnPjM6HRXDO
   WX63laDypxZ5LUVsysy7uQIp7s1to+IPH44BwxATcv2fTD4GwBsKUx7co
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384799732"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384799732"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1087722972"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="1087722972"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2023 19:17:31 -0700
Message-ID: <746a5243-74ad-4330-9ea9-845fac1a57e4@linux.intel.com>
Date:   Wed, 18 Oct 2023 10:13:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 0/5] Share sva domains with all devices bound to a mm
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>
References: <20231017004802.109618-1-tina.zhang@intel.com>
 <20231017164150.GF282036@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231017164150.GF282036@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 12:41 AM, Jason Gunthorpe wrote:
> On Tue, Oct 17, 2023 at 08:47:57AM +0800, Tina Zhang wrote:
>> This series is to share sva(shared virtual addressing) domains with all
>> devices bound to one mm.
>>
>> Problem
>> -------
>> In the current iommu core code, sva domain is allocated per IOMMU group,
>> when device driver is binding a process address space to a device (which is
>> handled in iommu_sva_bind_device()). If one than more device is bound to
>> the same process address space, there must be more than one sva domain
>> instance, with each device having one. In other words, the sva domain
>> doesn't share between those devices bound to the same process address
>> space, and that leads to two problems:
>> 1) device driver has to duplicate sva domains with enqcmd, as those sva
>> domains have the same PASID and are relevant to one virtual address space.
>> This makes the sva domain handling complex in device drivers.
>> 2) IOMMU driver cannot get sufficient info of the IOMMUs that have
>> devices behind them bound to the same virtual address space, when handling
>> mmu_notifier_ops callbacks. As a result, IOMMU IOTLB invalidation is
>> performed per device instead of per IOMMU, and that may lead to
>> superfluous IOTLB invalidation issue, especially in a virtualization
>> environment where all devices may be behind one virtual IOMMU.
>>
>> Solution
>> --------
>> This patch-set tries to fix those two problems by allowing sharing sva
>> domains with all devices bound to a mm. To achieve this, a new structure
>> pointer is introduced to mm to replace the old PASID field, which can keep
>> the info of PASID as well as the corresponding shared sva domains.
>> Besides, function iommu_sva_bind_device() is updated to ensure a new sva
>> domain can only be allocated when the old ones cannot work for the IOMMU.
>> With these changes, a device driver can expect one sva domain could work
>> for per PASID instance(e.g., enqcmd PASID instance), and therefore may get
>> rid of handling sva domain duplication. Besides, IOMMU driver (e.g., intel
>> vt-d driver) can get sufficient info (e.g., the info of the IOMMUs having
>> their devices bound to one virtual address space) when handling
>> mmu_notifier_ops callbacks, to remove the redundant IOTLB invalidations.
>>
>> Arguably there shouldn't be more than one sva_domain with the same PASID,
>> and in any sane configuration there should be only 1 type of IOMMU driver
>> that needs only 1 SVA domain. However, in reality, IOMMUs on one platform
>> may not be identical to each other. Thus, attaching a sva domain that has
>> been successfully bound to device A behind a IOMMU A, to device B behind
>> IOMMU B may get failed due to the difference between IOMMU A and IOMMU
>> B. In this case, a new sva domain with the same PASID needs to be
>> allocated to work with IOMMU B. That's why we need a list to keep sva
>> domains of one PASID. For the platform where IOMMUs are compatible to each
>> other, there should be one sva domain in the list.
>>
>> v8:
>>   - CC more people
>>   - CCiommu@lists.linux.dev  mailing list.
>>     When sending version 7, some issue happened in my CC list and that caused
>>     version 7 wasn't sent toiommu@lists.linux.dev.
>>   - Rebase to v6.6-rc6 and make a few format changes.
> You should based it on Joerg's tree so he can take it without
> conflcits.
> 
> The conflicts are trivial though (Take Michael's version and switch
> mm->pasid with mm_get_enqcmd_pasid(mm))
> 
> It looks fine, please lets get it in this cycle, the ARM and AMD SVA
> series depend on it.

The vt-d driver also has series depending on it.

https://lore.kernel.org/linux-iommu/20231017032045.114868-1-tina.zhang@intel.com/

Best regards,
baolu
