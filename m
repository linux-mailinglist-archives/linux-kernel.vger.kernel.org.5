Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E0E7B3ECD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 09:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjI3HSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjI3HSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:18:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1350AFA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 00:18:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D8BC433C8;
        Sat, 30 Sep 2023 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696058282;
        bh=RJOESfC9EnjjXjWIGXaZMW/z4qLvxv9GJxGbs9/30f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2tLpaUxc1PSpipSv/Ozp8yrRKKkHG+s3G79lMPB4qJMAe+n69E6y+aewuWbFVkWM
         sCBRogduM+nQ3rAJ04Wn8Lh+SKIhhu2ISjmiyDAo7/rJWFNFkz4XLGZjZR4KdR9KuZ
         5YJ2OYXyqEOwfI4Rv8tposOnIhfDWZI9+PU17kG4=
Date:   Sat, 30 Sep 2023 09:17:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc:     michal.simek@amd.com, tanmay.shah@amd.com,
        sai.krishna.potthuri@amd.com, nava.kishore.manne@amd.com,
        ben.levinsky@amd.com, dhaval.r.shah@amd.com, marex@denx.de,
        robh@kernel.org, arnd@arndb.de, izhar.ameer.shaikh@amd.com,
        ruanjinjie@huawei.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] drivers: soc: xilinx: add check for platform
Message-ID: <2023093034-spiny-diagnoses-3da7@gregkh>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
 <20230929105558.11893-4-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929105558.11893-4-jay.buddhabhatti@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 03:55:54AM -0700, Jay Buddhabhatti wrote:
> Some error event IDs for Versal and Versal NET are different.
> Both the platforms should access their respective error event
> IDs so use sub_family_code to check for platform and check
> error IDs for respective platforms. The family code is passed
> via platform data to avoid platform detection again.
> Platform data is setup when even driver is registered.
> 
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c        |  2 +-
>  drivers/soc/xilinx/xlnx_event_manager.c | 25 ++++++++++++++++++++-----
>  include/linux/firmware/xlnx-zynqmp.h    | 16 ++++++++++++----
>  3 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 5f40288f69a9..6583efa9ac48 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -2019,7 +2019,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>  	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
>  	if (np) {
>  		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
> -						       -1, NULL, 0);
> +						       -1, &pm_sub_family_code, 4);
>  		if (IS_ERR(em_dev))
>  			dev_err_probe(&pdev->dev, PTR_ERR(em_dev), "EM register fail with error\n");
>  	}
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> index 38cfc161a713..8074ded7b39c 100644
> --- a/drivers/soc/xilinx/xlnx_event_manager.c
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -23,6 +23,7 @@ static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
>  
>  static int virq_sgi;
>  static int event_manager_availability = -EACCES;
> +static u32 pm_sub_family_code;

Why is this not a per-device variable?  Global variables like this for
drivers are almost always wrong.

thanks,

greg k-h
