Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5127C8225
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjJMJhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjJMJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:37:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593795;
        Fri, 13 Oct 2023 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697189836; x=1728725836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UrEbenIXGfNrxoFbHyeBMYdN4ubBHqzWO0s1RMba6Ds=;
  b=SH5Yy4Gj2lDIlEyVDxm3dcAib8WO/TF9YLxoScC1hU3cnIwzJSBz8+jg
   wFWo/Z1pfcgh6Ebvwskyr/3CQznApHXnKV0+tRfyWIxJyWWaZFqpirIev
   rZRNQoUi9gZB+XOD/9UfdwRk+JNjhWimwbvWiXYiZ1kMEfVSLjq1DwfKZ
   VsZ4svv4U6S4wJaUiOzAm0qAghe8j3jXjIyDhOII/Y5mmIzTBb+FA7C0C
   7oc/TPNUz5XPsP/CKhjVroiNihctu1XsZhPjYy2Nadj49ooY40MPU+5Zf
   59tEfm4yVWrGkUrDLTIhluUFFbeKMRLikqlLtoCs3nzmm4glzpVRZ9Bt9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="364506756"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="364506756"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 02:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="928352273"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="928352273"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 13 Oct 2023 02:37:11 -0700
Date:   Fri, 13 Oct 2023 17:36:13 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        kernel test robot <lkp@intel.com>,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Fix unused
 xlnx_pr_decoupler_of_match warning for !CONFIG_OF
Message-ID: <ZSkPjRp/xPfVQ/NB@yilunxu-OptiPlex-7050>
References: <20231012192149.1546368-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012192149.1546368-1-robh@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 02:21:48PM -0500, Rob Herring wrote:
> Commit 8c966aadcc02 ("fpga: Use device_get_match_data()") dropped the

Hi rob:

Unfortunately I re-applied Commit 8c966aadcc02 and the previous commit
id is lost.

Since the 2 patches are not upstreamed yet, could I just merge them into
one?

Thanks,
Yilun

> unconditional use of xlnx_pr_decoupler_of_match resulting in this
> warning:
> 
> drivers/fpga/xilinx-pr-decoupler.c:94:34: warning: unused variable 'xlnx_pr_decoupler_of_match' [-Wunused-const-variable]
> 
> The fix is to drop of_match_ptr() which is not necessary because DT is
> always used for this driver.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310100247.Y7BFcalX-lkp@intel.com/
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/fpga/xilinx-pr-decoupler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 0c012d0f616d..68835896f180 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -167,7 +167,7 @@ static struct platform_driver xlnx_pr_decoupler_driver = {
>  	.remove = xlnx_pr_decoupler_remove,
>  	.driver = {
>  		.name = "xlnx_pr_decoupler",
> -		.of_match_table = of_match_ptr(xlnx_pr_decoupler_of_match),
> +		.of_match_table = xlnx_pr_decoupler_of_match,
>  	},
>  };
>  
> -- 
> 2.42.0
> 
