Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC5809B97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjLHFOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjLHFOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:14:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0C10D8;
        Thu,  7 Dec 2023 21:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702012498; x=1733548498;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eMqZIBfmXsW4JIGVz2VpEyeyCc8OAVvggzWL9Lorv+E=;
  b=KHqW05BFCOsrKdTN0f28nOoNf0Ekp5GLHowo324aWo/3rVQnzUm7FkGK
   LLPte9FZP04ZqtRIrQuguESpWyilpvlo8hMPCOZm/lA0DMPfFLPi2Ac1w
   IlE6OE7l8q8gxGpFa/zic3lyemFmBVjHktR+BZkIYRoJHFoMq2g82TY8C
   tXaD1UMAOj1btoxmSMVFfMdoPPgobtnCUm9vX96SnzPpcrOM8Alqoldou
   i/2ICWFS3u21Ogy4fxgAKJn8aVM0mfaBfY6i2OfKrPxIV3ebsh/IG5JR6
   cdwMHgsIo3fIKLKxSK+kUiXVqPcKHXOKgJuUW/XMKu8pow+W3tIBLZpM7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480554314"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="480554314"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="775684230"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="775684230"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2023 21:14:54 -0800
Message-ID: <8d29c6fb-0928-4c11-a9af-02647597cb4e@linux.intel.com>
Date:   Fri, 8 Dec 2023 13:10:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Content-Language: en-US
To:     Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a@eucas1p2.samsung.com>
 <20231204150744.db3hfpq4v55cuavn@localhost>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231204150744.db3hfpq4v55cuavn@localhost>
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

On 12/4/23 11:07 PM, Joel Granados wrote:
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
>> Hi folks,
>>
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework for nested translation. Nested
> Does this mean the IOPF_CAPABLE HWPT needs to be parented by a HWPT
> created with IOMMU_HWPT_ALLOC_NEST_PARENT set?

No. It's generic, nested translation is simply a use case that is
currently feasible.

Best regards,
baolu
