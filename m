Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712507BC577
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbjJGHRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343644AbjJGHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:17:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8238B9;
        Sat,  7 Oct 2023 00:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696663049; x=1728199049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gLXJeDyuHUbqo88VCpEmeE/4yFNV+xV2FELdzhx9+f8=;
  b=QStIkWfETkcPD2fFGt3DNDy4oIhPoyW3Q+Ok6QB6dbMk1wsMytacnEIe
   OEDwOhB7QGZDRkORKHV22tQJWx/mRwhqus14hvHuqJStcz6l104umT9a/
   mStAiZNMs2Q0KIloFYCpn5+2/YtfdeqzNOq63eNjNYRQCcprPHFTKVuvR
   tSeTvyh2PpTgTYdAdujpMjqudeFLr91fonp0q1dRZccWCDZiMjvOhMy1P
   hbaIaZvSo25/IGJcxY5U45YHYjXgpNdT353pUBg1eGgg6HDriH8ma0KMF
   /00UpG/teLqKnlMArK9paCLUy3/QTWzduUvm5xdirY0X03SAKcMrecNod
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="383784289"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="383784289"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="843124782"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="843124782"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2023 00:17:27 -0700
Date:   Sat, 7 Oct 2023 15:16:37 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] fpga: versal: Add support for 44-bit DMA operations
Message-ID: <ZSEF1TOpd13BkCXL@yilunxu-OptiPlex-7050>
References: <20231003071409.4165149-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003071409.4165149-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 12:44:09PM +0530, Nava kishore Manne wrote:
> The existing implementation support only 32-bit DMA operation.
> So, it fails to load the bitstream for the high DDR designs(Beyond 4GB).
> To fix this issue update the DMA mask handling logic to support 44-bit

This is the HW defined DMA addressing capability. Does the device
only support up to 44 bits DMA? Any Doc?

Thanks,
Yilun

> DMA operations.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  drivers/fpga/versal-fpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
> index e1601b3a345b..3710e8f01be2 100644
> --- a/drivers/fpga/versal-fpga.c
> +++ b/drivers/fpga/versal-fpga.c
> @@ -48,7 +48,7 @@ static int versal_fpga_probe(struct platform_device *pdev)
>  	struct fpga_manager *mgr;
>  	int ret;
>  
> -	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
>  	if (ret < 0) {
>  		dev_err(dev, "no usable DMA configuration\n");
>  		return ret;
> -- 
> 2.25.1
> 
