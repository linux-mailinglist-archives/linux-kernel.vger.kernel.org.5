Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C3C7B7ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjJDMPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjJDMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:15:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14493
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:15:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCF7C433C8;
        Wed,  4 Oct 2023 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696421712;
        bh=xIXg9Ur+n+C90t8y/vlj+q0jEq7ejIRCVP+YY/RGSfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0X2Kj9N2cUtkmGzDKcacXgLyCyXLakHTgfWDMWA28EdwTu6yCV6Y+LK4L9kIXjhu
         kLMXt3zTQwBT4VFKjACSQfIlaLPUG1KMC4gHd53jwG24XNbJoR5+pMOFiRl+Dq8nwZ
         u2thoh503Dwfy9KWRiCIOwYz+9GpS/bLmH5GHnU4=
Date:   Wed, 4 Oct 2023 14:15:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc:     michal.simek@amd.com, tanmay.shah@amd.com,
        nava.kishore.manne@amd.com, ben.levinsky@amd.com, robh@kernel.org,
        dhaval.r.shah@amd.com, marex@denx.de, izhar.ameer.shaikh@amd.com,
        arnd@arndb.de, ruanjinjie@huawei.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/6] drivers: soc: xilinx: Fix error message on SGI
 registration failure
Message-ID: <2023100425-chivalry-pound-78d0@gregkh>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-5-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004094116.27128-5-jay.buddhabhatti@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:41:14AM -0700, Jay Buddhabhatti wrote:
> Failure to register SGI for firmware event notification is non-fatal error
> when feature is not supported by other modules such as Xen and TF-A. Add
> _info level log message for such special case.
> 
> Also add XST_PM_INVALID_VERSION error code and map it to -EOPNOSUPP Linux
> kernel error code. If feature is not supported or EEMI API version is
> mismatch, firmware can return XST_PM_INVALID_VERSION = 4 or
> XST_PM_NO_FEATURE = 19 error code.
> 
> Co-developed-by: Tanmay Shah <tanmay.shah@amd.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c        | 4 +++-
>  drivers/soc/xilinx/xlnx_event_manager.c | 7 ++++++-
>  include/linux/firmware/xlnx-zynqmp.h    | 1 +
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 00ea2508f692..de09d77cf1e4 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -92,6 +92,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
>  		return 0;
>  	case XST_PM_NO_FEATURE:
>  		return -ENOTSUPP;
> +	case XST_PM_INVALID_VERSION:
> +		return -EOPNOTSUPP;
>  	case XST_PM_NO_ACCESS:
>  		return -EACCES;
>  	case XST_PM_ABORT_SUSPEND:
> @@ -379,7 +381,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
>  
>  	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0,
>  				  0, NULL);
> -	if (!ret)
> +	if (ret != -EOPNOTSUPP && !ret)
>  		return ret;
>  
>  	/* try old implementation as fallback strategy if above fails */
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> index 38cfc161a713..bfa5cf4a0cab 100644
> --- a/drivers/soc/xilinx/xlnx_event_manager.c
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -653,7 +653,12 @@ static int xlnx_event_manager_probe(struct platform_device *pdev)
>  
>  	ret = zynqmp_pm_register_sgi(sgi_num, 0);
>  	if (ret) {
> -		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with %d\n", sgi_num, ret);
> +		if (ret == -EOPNOTSUPP)
> +			dev_info(&pdev->dev, "PM firmware event notification not supported\n");

Why is this "info"?  Why not error?

And what is userspace supposed to do with this information if it sees
it?

thanks,

greg k-h
