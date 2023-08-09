Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9073F774FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjHIASZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHIASY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:18:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E64E10C8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691540304; x=1723076304;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HJlcHiHuNgv/7TraiPpo1NPMzUrumGGz0oolwOb/Hvs=;
  b=GnbAb4/1jbgcwMBnL6Cw7CCnt6YhGsiK9zfWQ9q5xuOs2vs1QeTfvjki
   CSUsC8KoFzVTFyqkTQNJmsdHzi+Rzeq8xdAa+Vk8FrKeEob6fBSKL4JHF
   AHsNwH0pSx1QM0yJQVfgtonJYFxge8dEwAPxJv2IrFSCJBmM0Mx23pMWN
   IlrccYTv7Cu2eZc2pmC//KLclyZJr8Rmo7zQmWRrFiXU+GLWPjUHmMsyT
   vmq31sC2n/up13/gmEoHmJs+XHgVA/A+jmzege6Ep21sQampnScWhMFtV
   est58TgJ657IFp04FUd0p5RIayg1qL4Ts2MlvkUiCofhX+Xwp+DiB7Z4g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373766058"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="373766058"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="978163637"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="978163637"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.46]) ([10.249.169.46])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:18:21 -0700
Message-ID: <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>
Date:   Wed, 9 Aug 2023 08:18:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Share sva domains with all devices bound to a mm
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230808074944.7825-1-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/8 15:49, Tina Zhang wrote:
> A sva domain's lifetime begins with binding a device to a mm and ends
> by releasing all the bound devices from that sva domain. Technically,
> there could be more than one sva domain identified by the mm PASID for
> the use of bound devices issuing DMA transactions.
> 
> To support mm PASID 1:n with sva domains, each mm needs to keep both a
> reference list of allocated sva domains and the corresponding PASID.
> However, currently, mm struct only has one pasid field for sva usage,
> which is used to keep the info of an assigned PASID. That pasid field
> cannot provide sufficient info to build up the 1:n mapping between PASID
> and sva domains.

Is it more appropriate to have the same life cycle for sva domain and mm
pasid? I feel that they represent the same thing, that is, the address
space shared by mm to a device.

Best regards,
baolu

> 
> This patch-set fills the gap by adding an mm_iommu field[1], whose type is
> mm_iommu_data struct, to replace the old pasid field. The introduced
> mm_iommu_data struct keeps info of both a reference list of sva domains
> and an assigned PASID.
> 
> 
> [1]: https://lore.kernel.org/linux-iommu/ZIBxPd1%2FJCAle6yP@nvidia.com/
> 
> 
> The RFC version of this patch-set is here:
> https://lore.kernel.org/linux-iommu/20230707013441.365583-1-tina.zhang@intel.com/
> 
> Tina Zhang (5):
>    iommu: Add mm_get_pasid() helper function
>    iommu: Call helper function to get assigned pasid value
>    mm: Add structure to keep sva information
>    iommu: Support mm PASID 1:n with sva domains
>    mm: Deprecate pasid field
> 
>   arch/x86/kernel/traps.c                       |  2 +-
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 ++---
>   drivers/iommu/intel/svm.c                     |  8 +--
>   drivers/iommu/iommu-sva.c                     | 50 ++++++++++++-------
>   include/linux/iommu.h                         | 19 +++++--
>   include/linux/mm_types.h                      |  3 +-
>   kernel/fork.c                                 |  1 -
>   mm/init-mm.c                                  |  3 --
>   8 files changed, 58 insertions(+), 40 deletions(-)
> 

