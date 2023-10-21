Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACC87D1A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 03:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjJUBcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 21:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjJUBcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 21:32:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902FD68
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 18:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697851957; x=1729387957;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=70i1/C+fbIE2VpSwskddcgtUORM3772WnaPj85EQ9bk=;
  b=HQKKfZCg4n1MtDsa76TVBtUlgQyI6gcG+Vq1k/3pmASwH0Jxp2lSdMWT
   78en9vU2hEIuz+x3yDHb/ZLTErXYNHq1IcMh0YUVRqSk9opKgpMUzreC/
   +5UMmnxB54k+U7UeijIor01MalK/CYCWwkZliKBznlM+fo8OdXDnAJc8y
   qXZ9n446p1Egtm8gZLPkNozl+d+i6A3h8FP49sofPzf2MCQ+hMGLA1Kmg
   imM67WJrr5gqu6HvBDEJrkrEha9LzJRUWVjTi69LzWakFFLiuZm0xkjqE
   vO4CqsYBuLsaL/pfvfMdTirIUGaknGcNv8Tt60PSivJZVTyEkQ3syrSu0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="383808087"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="383808087"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 18:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="848253825"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="848253825"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.224]) ([10.255.30.224])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 18:32:34 -0700
Message-ID: <2201ae4d-b825-49a5-ba73-c6b310e2969c@linux.intel.com>
Date:   Sat, 21 Oct 2023 09:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH 0/2] iommufd: Only enforce_cache_coherency when allocating
 hwpt
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
        kevin.tian@intel.com
References: <cover.1697848510.git.nicolinc@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <cover.1697848510.git.nicolinc@nvidia.com>
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

On 2023/10/21 8:37, Nicolin Chen wrote:
> https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/
> The conversation above concluded that a hwpt should only enforce cache
> coherency per device at the stage of its allocation, and it should not
> be changed or updated in the attach/replace routines.
> 
> Add two patches dropping the enforce_cache_coherency calls from attach
> and replce routines respectively, since they were introduced with two
> different commits.
> 
> Nicolin Chen (2):
>    iommufd/device: Drop enforce_cache_coherency in
>      iommufd_device_do_replace
>    iommufd/device: Drop enforce_cache_coherency in
>      iommufd_hw_pagetable_attach
> 
>   drivers/iommu/iommufd/device.c          | 19 ++-----------------
>   drivers/iommu/iommufd/hw_pagetable.c    |  2 +-
>   drivers/iommu/iommufd/iommufd_private.h |  1 -
>   3 files changed, 3 insertions(+), 19 deletions(-)

Hi Kevin and Jason,

With these two fixes, there's no issue in the intel driver any more. Do
I understand it right?

Best regards,
baolu
