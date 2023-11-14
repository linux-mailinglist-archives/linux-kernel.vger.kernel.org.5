Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542C77EAADE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjKNHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:24:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8379C18D;
        Mon, 13 Nov 2023 23:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699946672; x=1731482672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KJqeOLuYzLfQ91M1Q9XpfE1fjEBWzDQzN8zukQ1ADKQ=;
  b=k1tvcIb7PLBf6cO6Z7AbXTtFnOMlNcHp6qkk9AOuOp2761oUCMYCquSt
   Ra0lClaZ86mrJiHdKQ6p/gOBFJVqkSpiwY33UC9giNWkOmKpJKgAPL6bG
   J1uzrLHTddbX3a2wMCW3C1KxEfFi89nHB9sv2nkZx6EQACpKRPKO5asva
   AmHeMgB8350pdF4z6SFbRqMzlk9d8yWQrZQS9aRFTz49OJ51OIYGXhDyr
   m0hZULidxMozjhQNoO7b6T636S1R+WUWTaRFvoWAHf6AtwsBZnwz4eoiJ
   FtFwk3PO+ZR18mRDE5GPOPZPx1Iht9rkb4wYE+1HOAcRgx4iQcjPSacYw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394512591"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="394512591"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 23:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011814638"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="1011814638"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 13 Nov 2023 23:24:29 -0800
Date:   Tue, 14 Nov 2023 15:22:47 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drivers/fpga: copy userspace array safely
Message-ID: <ZVMgR4Z71l7ZsllC@yilunxu-OptiPlex-7050>
References: <20231102184908.49558-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102184908.49558-2-pstanner@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 07:49:09PM +0100, Philipp Stanner wrote:
> dfl.c utilizes memdup_user() and array_size() to copy a userspace array.
> Currently, this does not check for an overflow.

array_size() actually checks for overflow, so please re-write the changelog.

Thanks,
Yilun

> 
> Use the new wrapper memdup_array_user() to copy the array more safely.
> 
> Suggested-by: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> Linus recently merged this new wrapper for Kernel v6.7
> ---
>  drivers/fpga/dfl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index dd7a783d53b5..e69b9f1f2a50 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -2008,8 +2008,8 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>  	    (hdr.start + hdr.count < hdr.start))
>  		return -EINVAL;
>  
> -	fds = memdup_user((void __user *)(arg + sizeof(hdr)),
> -			  array_size(hdr.count, sizeof(s32)));
> +	fds = memdup_array_user((void __user *)(arg + sizeof(hdr)),
> +				hdr.count, sizeof(s32));
>  	if (IS_ERR(fds))
>  		return PTR_ERR(fds);
>  
> -- 
> 2.41.0
> 
