Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69087BBA1C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjJFOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjJFOVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:21:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5D9A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:21:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A08C433C7;
        Fri,  6 Oct 2023 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696602078;
        bh=2Grp6Qh6qeNuh49mj8YjpgGdvSj5dFC4iUiXZ5AqqSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdWZmuPPmt/PM3EzsBffE6Dhf7B3EJmmPf60vBYWZal9yf9ON/z+QETHTIf8NrnfQ
         8GCGiqXzqiXSxZq0kajOYf2UpC5dyiSgKvl0rW/3TKTZ21xD+53BmShz6fwpQDA0zg
         VIals/MScQD0okxkGaInq9o3/yAgHrEb/esZFrwo=
Date:   Fri, 6 Oct 2023 16:21:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     s.hauer@pengutronix.de, jonathanh@nvidia.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_linyyuan@quicinc.com, paul@crapouillou.net,
        quic_eserrao@quicinc.com, erosca@de.adit-jv.com,
        gah2hi <external.Hardik.Gajjar@de.bosch.com>
Subject: Re: [PATCH] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Message-ID: <2023100656-swagger-anagram-a381@gregkh>
References: <20231006141231.7220-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006141231.7220-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:12:31PM +0200, Hardik Gajjar wrote:
> From: gah2hi <external.Hardik.Gajjar@de.bosch.com>
> 
> This patch replaces the usage of netif_stop_queue with netif_device_detach
> in the u_ether driver. The netif_device_detach function not only stops all
> tx queues by calling netif_tx_stop_all_queues but also marks the device as
> removed by clearing the __LINK_STATE_PRESENT bit.
> 
> This change helps notify user space about the disconnection of the device
> more effectively, compared to netif_stop_queue, which only stops a single
> transmit queue.
> 
> Signed-off-by: gah2hi <external.Hardik.Gajjar@de.bosch.com>
> ---
>  drivers/usb/gadget/function/u_ether.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 4bb0553da658..9d1c40c152d8 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -1200,7 +1200,7 @@ void gether_disconnect(struct gether *link)
>  
>  	DBG(dev, "%s\n", __func__);
>  
> -	netif_stop_queue(dev->net);
> +	netif_device_detach(dev->net);
>  	netif_carrier_off(dev->net);
>  
>  	/* disable endpoints, forcing (synchronous) completion
> -- 
> 2.17.1
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
