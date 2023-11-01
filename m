Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D987DDD01
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjKAHNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjKAHNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:13:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B27F1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 00:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698822782; x=1730358782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OAt4Yw2JTGLX7OAG02RBVDFeF4KuQ9B0kAKFvVyP+eM=;
  b=ayA5IbwInacPNnpg8gmGL/Jq8+GVAKPPMa6dsIyLV/kAxyaRAaS/xptB
   xpLm0yap46FxsmDUq/z+/fR7pMMMc97OXOkuoJJnoIpR8YJNu80gmFwsI
   6ILPuYNbnT1bHMWa92o77CbM96Zpwe9WVBPNBkdPH4C5YMiYLWyDe19wM
   JswJ0erzqrXDVwBUv0PugJwhRTpYVpt4F8gHNLuUmviwzJpGOw45rh/dV
   fJS9/kFHwExOP6Nmf+vCYFcVldMpRLhQL4BioAm6rQqSyV0bF5ddYLCQy
   kgH38yGThTJE0pxI/m7C6GKmN87TukhtEmt6uUHZyMIg9zchk72xBUIbR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="474688341"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="474688341"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="710695230"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="710695230"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Nov 2023 00:13:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A3E0352A; Wed,  1 Nov 2023 09:03:10 +0200 (EET)
Date:   Wed, 1 Nov 2023 09:03:10 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Chen Ni <nichen@iscas.ac.cn>
Cc:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Fix IRQ check
Message-ID: <20231101070310.GF17433@black.fi.intel.com>
References: <20231101062643.507983-1-nichen@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101062643.507983-1-nichen@iscas.ac.cn>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 06:26:43AM +0000, Chen Ni wrote:
> platform_get_irq() returns a negative error code to indicating an
> error. So in intel_lpss_probe() the unset / erroneous IRQ should be
> returned as is.
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")

There is no need for Fixes tag here.

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 1. Update commit message
> 2. Fix IRQ check in intel_lpcc_probe()
> ---
>  drivers/mfd/intel-lpss.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 9591b354072a..4c9d0222751a 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -378,9 +378,12 @@ int intel_lpss_probe(struct device *dev,
>  	struct intel_lpss *lpss;
>  	int ret;
>  
> -	if (!info || !info->mem || info->irq <= 0)
> +	if (!info || !info->mem)

This check (info->irq <= 0) covers both "invalid" interrupt numbers
(that's the negative errno and 0 as no interrupt) so I don't see how
this change makes it any better and the changelog does not clarify it
either.
