Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070C877C599
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjHOCGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHOCGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:06:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FF1702
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692065164; x=1723601164;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MKYGLe8IyShNbMGzrNuYJbpA1fTUIc5suwq/YoZTq9A=;
  b=IsFu/A0M/fcFWqmzYsJQ5B0HdwzC6M9q2EOfcwTvKXRGAHrG+bFr5kwF
   D7YQ7+RScOCjEUd+kK8Etv9tL5ui2LCk2UJenDuohbucqbEXP70bSGMLv
   BuRkDFAOaYhFXTPNkzsfo8eVcka5XdfLvMfMP83lNu6MXiF7KbKlrc+aw
   26uRxr+sOus2WV93vVdbs7ZQHxWHPp4TjiCH0KHUPQw6z4eE9N5O4fmfX
   J+f/e9i9gZUdYryFblUX7jEAfOlTJBIwbGho3k3/kyn5BphBKAQqJOmX+
   vkb9GDicaPvAiSwWlzXY0isaAT6rFbUpyT9Zb3AJJZiLvLd/ZsYpoGPei
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357148185"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357148185"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 19:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736739582"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736739582"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.149]) ([10.254.215.149])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 19:06:00 -0700
Message-ID: <4b356a28-5637-d492-9540-d7f5e6c617ec@linux.intel.com>
Date:   Tue, 15 Aug 2023 10:05:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, xianting.tian@linux.alibaba.com,
        kaijieguo@linux.alibaba.com, daishengdong@yeah.net
Subject: Re: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer
 granularity
Content-Language: en-US
To:     Jie Ji <jijie.ji@linux.alibaba.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please allow me to include Kevin and Alex in this thread.]

On 2023/8/14 20:10, Jie Ji wrote:
> With the addition of IOMMU support for IO page fault, it's now possible
> to unpin the memory which DMA remapping. However, the lack of support
> for unmapping a subrange of the I/O page table (IOPT) in IOMMU can lead
> to some issues.

Is this the right contract about how iommu_map/unmap() should be used?
If I remember it correctly, IOVA ranges should be mapped in pairs. That
means, if a range is mapped by iommu_map(), the same range should be
unmapped with iommu_unmap().

Any misunderstanding or anything changed?

> 
> For instance, a virtual machine can establish IOPT of 2M/1G for better
> performance, while the host system enable swap and attempts to swap out
> some 4K pages. Unfortunately, unmap subrange of the large-page mapping
> will make IOMMU page walk to error level, and finally cause kernel crash.

Sorry that I can't fully understand this use case. Are you talking about
the nested translation where user spaces manage their own IO page
tables? But how can those pages been swapped out?

> This patch support splitting the page table to a finer granularity and
> atomic switch to it when unmap subrange of the large-page mapping. It
> is much better than the unmap then map method to change IOPT, because
> during interval time, all unmapped address space could trigger IO page
> fault, which is unacceptable.
> 
> Signed-off-by: Jie Ji<jijie.ji@linux.alibaba.com>
> Reviewed-by: Kaijie Guo<kaijieguo@linux.alibaba.com>
> ---
>   drivers/iommu/intel/iommu.c | 97 +++++++++++++++++++++++++++++--------
>   drivers/iommu/intel/iommu.h |  1 +
>   2 files changed, 78 insertions(+), 20 deletions(-)

Best regards,
baolu
