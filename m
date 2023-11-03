Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D3D7E01C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347464AbjKCLF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjKCLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:05:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11DC1A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:05:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B97DC433C8;
        Fri,  3 Nov 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699009518;
        bh=WbzEvZR+1Bw780CazrRCCK5Cz3D//L6XBlaXsKA2PLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8PTZc6DFHslHLyhUTwVbrBMvhzPCXtw4ULQY83KkeBQpmmKAYozOncVmFc+2J//m
         G8JQcQElRcne7hhVr6VqI+Rs99DvbOa7kUBN/3XgYTJOmY5+WL8LGOVO0C0yN/34uC
         vtSSEQcKx/stiQQ8Jsxj5dGCjCi1+JmqTrl09z0A=
Date:   Fri, 3 Nov 2023 12:05:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] USB: dwc3: only call usb_phy_set_suspend in
 suspend/resume
Message-ID: <2023110307-numeral-yogurt-e649@gregkh>
References: <20231103102236.13656-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103102236.13656-1-francesco@dolcini.it>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 11:22:36AM +0100, Francesco Dolcini wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Currently we have the following two call chains:
> dwc3_probe -> dwc3_core_init -> dwc3_phy_init -> usb_phy_init
> dwc3_probe -> dwc3_core_init -> dwc3_phy_power_on -> usb_phy_set_suspend
> 
> If we look at phy-generic we see the following calls:
> usb_gen_phy_init -> regulator_enable
> usb_gen_phy_init -> clk_prepare_enable
> 
> If we call usb_phy_set_suspend we call the following in phy-generic:
> nop_set_suspend -> clk_prepare_enable
> and we sent a patch to also call:
> nop_set_suspend -> regulator_enable
> 
> Because clk_prepare_enable and regulator_enable do reference counting we
> increased the reference counter of the clock and regulator to two. If we
> want to put the system into suspend we only decrease the reference
> counters by one and therefore the clock and regulator stay on.
> 
> This change fixes it by not calling usb_phy_set_suspend in
> dwc3_phy_power_on but only in dwc3_suspend_common.
> 
> Fixes: 8ba007a971bb ("usb: dwc3: core: enable the USB2 and USB3 phy in probe")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/usb/dwc3/core.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 9c6bf054f15d..fae24a9c480d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -770,12 +770,9 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
>  {
>  	int ret;
>  
> -	usb_phy_set_suspend(dwc->usb2_phy, 0);
> -	usb_phy_set_suspend(dwc->usb3_phy, 0);
> -
>  	ret = phy_power_on(dwc->usb2_generic_phy);
>  	if (ret < 0)
> -		goto err_suspend_usb3_phy;
> +		return ret;
>  
>  	ret = phy_power_on(dwc->usb3_generic_phy);
>  	if (ret < 0)
> @@ -785,9 +782,6 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
>  
>  err_power_off_usb2_phy:
>  	phy_power_off(dwc->usb2_generic_phy);
> -err_suspend_usb3_phy:
> -	usb_phy_set_suspend(dwc->usb3_phy, 1);
> -	usb_phy_set_suspend(dwc->usb2_phy, 1);
>  
>  	return ret;
>  }
> @@ -796,9 +790,6 @@ static void dwc3_phy_power_off(struct dwc3 *dwc)
>  {
>  	phy_power_off(dwc->usb3_generic_phy);
>  	phy_power_off(dwc->usb2_generic_phy);
> -
> -	usb_phy_set_suspend(dwc->usb3_phy, 1);
> -	usb_phy_set_suspend(dwc->usb2_phy, 1);
>  }
>  
>  static int dwc3_clk_enable(struct dwc3 *dwc)
> @@ -2018,6 +2009,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		break;
>  	}
>  
> +	usb_phy_set_suspend(dwc->usb2_phy, 1);
> +	usb_phy_set_suspend(dwc->usb3_phy, 1);
> +
>  	return 0;
>  }
>  
> @@ -2027,6 +2021,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  	int		ret;
>  	u32		reg;
>  
> +	usb_phy_set_suspend(dwc->usb2_phy, 0);
> +	usb_phy_set_suspend(dwc->usb3_phy, 0);
> +
>  	switch (dwc->current_dr_role) {
>  	case DWC3_GCTL_PRTCAP_DEVICE:
>  		ret = dwc3_core_init_for_resume(dwc);
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
