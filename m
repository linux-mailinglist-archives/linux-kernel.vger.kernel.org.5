Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9607C6E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378434AbjJLM5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343995AbjJLM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:57:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A58BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697115464; x=1728651464;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eLgI4Z9uatFwbzYeyq1iwRm+eHP+m2Ni4SKD5c1f350=;
  b=nzzcxuga2sUmuDSEk1+cVZInbaquFLIbmNNZ+6ZnY3HPFhP1PvlUe2PP
   Z1sLQUDmy8OacK/vbatagC9ODMT6qA2KmlOgMSi4oRGGx/z85j3BcJwlw
   OnVmEKHQgbpK72v5kQsH6wXg1UNRGtfpY79uNU5hSSBYWY6X8YUJvmxD8
   ycmCyrur57Kq7slppTLTYM3vCbBG+d107wifxOPAvQaw070M/j4cYR47P
   YixrAy3jXrWPZQY2iVdZ4OjcvC6jx5NHRIiSRQWRtMfdI3hxsWIRxJTU/
   mxUjWoD68oVgVvfgIrsAy/Tqmk5eQOYRgNkNftAJv22Nle7nERZkCjdIe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388769031"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388769031"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758007757"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="758007757"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.230]) ([10.254.213.230])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:57:42 -0700
Message-ID: <1894abdd-b88b-7d29-1ffd-2244d9086f94@linux.intel.com>
Date:   Thu, 12 Oct 2023 20:57:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] iommu: Decouple iommu_present() from bus ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <6711338e24dd1edfd02187f25cf40d8622cefdb2.1697047261.git.robin.murphy@arm.com>
 <43ca2a88-942e-4d65-87f1-30a7cf537edd@linux.intel.com>
 <42bbeab4-84f3-470e-bd42-2dae31b5775c@arm.com>
 <20231012123755.GH3952@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231012123755.GH3952@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/12 20:37, Jason Gunthorpe wrote:
> On Thu, Oct 12, 2023 at 12:40:01PM +0100, Robin Murphy wrote:
>> On 2023-10-12 07:05, Baolu Lu wrote:
>>> On 10/12/23 2:14 AM, Robin Murphy wrote:
>>>> Much as I'd like to remove iommu_present(), the final remaining users
>>>> are proving stubbornly difficult to clean up, so kick that can down the
>>>> road and just rework it to preserve the current behaviour without
>>>> depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup
>>>
>>> The iommu_present() is only used in below two drivers.
>>>
>>> $ git grep iommu_present
>>> drivers/gpu/drm/mediatek/mtk_drm_drv.c: if
>>> (!iommu_present(&platform_bus_type))
>>> drivers/gpu/drm/tegra/drm.c:    if (host1x_drm_wants_iommu(dev) &&
>>> iommu_present(&platform_bus_type)) {
>>>
>>> Both are platform drivers and have the device pointer passed in. Just
>>> out of curiosity, why not replacing them with device_iommu_mapped()
>>> instead? Sorry if I overlooked previous discussion.
>>
>> Yes, we've already gone round in circles on this several times, that's why
>> it's explicitly called out as "stubbornly difficult" in the commit message.
>> The Mediatek one is entirely redundant, but it seems I have yet to figure
>> out the right CC list to get anyone to care about that patch[1].

I see now. Thanks for the explanation.

> 
> Please just have Joerg take such a trivial patch, there is no reason
> we need to torture outselves because DRM side is not behaving well. :(

I was not object to the patch. Just want to make sure that I understand
the reason why device_iommu_mapped() can't be used in those two drivers.

It's fine to me. I will add my r-b.

Best regards,
baolu

