Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06607A4081
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbjIRFhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbjIRFgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:36:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C8ED2;
        Sun, 17 Sep 2023 22:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695015401; x=1726551401;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xb/dp+do5fxvyOyftlUPUmIspOQcsSZjn7fEnjla9E0=;
  b=lWbffep6TGu0QrqbGYM5YgwRCdOx2oIEmK/K9NpUauC0ehQUz3nIJ0hy
   IhAfCIBg/3HTxGrwJUYCi4SFzjVGnsR8OH4DsRzGtluJiPVoIjBnHRPP3
   OzTYNLYHzYX9M2v7J6yj8j76QswCTD139YgeOGY+C5DF2yzC0A1ub+PhH
   J7u0OhzCuvrl42Esi8lNkfxLsQGGDkU9Vk7IpkrSTcpJb8vh0Em7AtB7g
   dREJrinoG5t9/ti/5AawoXohxx1XZQTXvB6s2eNZBFa5kTTdDnabMx93S
   A8xSdZkcn7EWtUvRFKRgjoZHzOlK03kMZHkT/kebsOJDGQOe1Jo8kh6Ui
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="465914704"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="465914704"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 22:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="738994554"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="738994554"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 17 Sep 2023 22:36:37 -0700
Message-ID: <9334dfcd-7749-6ae1-1170-b4952f2b8181@linux.intel.com>
Date:   Mon, 18 Sep 2023 13:33:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, jgg@nvidia.com,
        jean-philippe@linaro.org, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix soft lockup triggered by
 arm_smmu_mm_invalidate_range
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        robin.murphy@arm.com
References: <20230901203904.4073-1-nicolinc@nvidia.com>
 <ZQQLNmmAOsNmvtDs@Asurada-Nvidia>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZQQLNmmAOsNmvtDs@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 3:43 PM, Nicolin Chen wrote:
> I found this patch cannot be applied to v6.6-rc1 due to conflicts
> with some new commits that were merged during the previous cycle.
> 
> I can redo a version rebasing on the v6.6-rc1, yet the new version
> won't apply to earlier kernel stable trees. Is there a way to make
> it happen that both mainline and earlier trees can have this fix?

Normally, bug fixes should first be submitted to the mainline kernel
(also known as Linus's tree). If you use the "Fixes" and "CC-stable"
tags, the patch will be automatically picked up for the appropriate
stable kernels.

If the patch does not apply to any stable kernel that you want it to be
there, you can then post a back-ported patch to the stable mailing list.

When doing so, it's better to include the following information:

- The mainline commit ID of the back-ported patch.
- The versions of the stable kernel(s) to which you want the back-ported
   patch to be applied.

Hope this helps.

Best regards,
baolu
