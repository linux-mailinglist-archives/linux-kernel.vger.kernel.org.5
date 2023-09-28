Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41937B1F29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjI1ODb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjI1OD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:03:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C7136;
        Thu, 28 Sep 2023 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695909807; x=1727445807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+3nPBskHQtQ+vZtXlLq6a5EoIP45tYw3tkbcwadFREc=;
  b=nJDJ31uAJ6lg/U8jrRj1U8JhozDr+IPxLN7xKp48Yx38BRt5BMia8ofj
   4NemlwKqyu0acivwtopyj/4y55v+cf8xycUXl7Sk6H9u09E9WrSsYPY+y
   GB6qdWR6IZNogZANmMQivs4OqHsGSSyCht6Cji12MpNtL4TI2QGMmKG1M
   zvr6B4L1wB5ILZe/3k8Zmag4wmmtOUpZMmJYrDC6g+n8cG8CL5M4mkCsS
   8g4typYDmdDQuW2zBBeGIJ1swUvqStQFkMBXe0QL2pAsnMx63AWE3U1Wh
   A8ZyQZ2Oqe9bNSN1FWtVVFtcUTeSQIxSFUk0G70HGPhbA/q5iGFSB7pzn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="361445291"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="361445291"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="865271803"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="865271803"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2023 07:03:24 -0700
Date:   Thu, 28 Sep 2023 22:02:43 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, russell.h.weight@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] fpga: region: Fix possible memory leak in
 fpga_region_register_full()
Message-ID: <ZRWHg9r9RsuOpedS@yilunxu-OptiPlex-7050>
References: <20230928091636.1209914-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928091636.1209914-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 05:16:36PM +0800, Jinjie Ruan wrote:
> If device_register() fails in fpga_region_register_full(), the region
> allocated by kzalloc() and the id allocated by ida_alloc() also need be
> freed otherwise will cause memory leak.

How did you observe the memory leak? Please help provide some trace.

Thanks,
Yilun

> 
> Fixes: 8886a579744f ("fpga: region: Use standard dev_release for class driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/fpga/fpga-region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index b364a929425c..9dc6314976ef 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -228,12 +228,13 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  
>  	ret = device_register(&region->dev);
>  	if (ret) {
> -		put_device(&region->dev);
> -		return ERR_PTR(ret);
> +		goto err_put_device;
>  	}
>  
>  	return region;
>  
> +err_put_device:
> +	put_device(&region->dev);
>  err_remove:
>  	ida_free(&fpga_region_ida, id);
>  err_free:
> -- 
> 2.34.1
> 
