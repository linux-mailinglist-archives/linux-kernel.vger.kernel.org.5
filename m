Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D147A73F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjITHYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjITHYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:24:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA582119
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:24:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89382C433C7;
        Wed, 20 Sep 2023 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695194646;
        bh=WJGZQke9HDC2xBjSxowARs+R7cWy3tpanlmLcL8xNuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+41xrY2Bu3boiNQxkGy9HATMh5m/oxDZIvdWWh5ooshveb0ScBLR83ZPBQmU4Exc
         bnVgIfMbllffWUoLgusmI5Zz9lvkvsfi7RYgumU2bOH1XIgwn5T7fqJgGqPN6xaAR3
         UE61d1FUPF8rg6IeX76j1hkqVaw09yB32AGgdXwY=
Date:   Wed, 20 Sep 2023 09:24:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: host: xhci: Avoid XHCI resume delay if SSUSB
 device is not present
Message-ID: <2023092049-debating-matted-7276@gregkh>
References: <20230919224327.29974-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919224327.29974-1-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 03:43:27PM -0700, Wesley Cheng wrote:
> There is a 120ms delay implemented for allowing the XHCI host controller to
> detect a U3 wakeup pulse.  The intention is to wait for the device to retry
> the wakeup event if the USB3 PORTSC doesn't reflect the RESUME link status
> by the time it is checked.  As per the USB3 specification:
> 
>   tU3WakeupRetryDelay ("Table 7-12. LTSSM State Transition Timeouts")
> 
> This would allow the XHCI resume sequence to determine if the root hub
> needs to be also resumed.  However, in case there is no device connected,
> or if there is only a HSUSB device connected, this delay would still affect
> the overall resume timing.
> 
> Since this delay is solely for detecting U3 wake events (USB3 specific)
> then ignore this delay for the disconnected case and the HSUSB connected
> only case.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
> Depends-on:
> https://lore.kernel.org/linux-usb/20230915143108.1532163-3-mathias.nyman@linux.intel.com/
> 
>  drivers/usb/host/xhci.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index e1b1b64a0723..1855cab1be56 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -805,6 +805,18 @@ static void xhci_disable_hub_port_wake(struct xhci_hcd *xhci,
>  	spin_unlock_irqrestore(&xhci->lock, flags);
>  }
>  
> +/*
> + * Utilize suspended_ports and bus_suspended to determine if USB3 device is
> + * connected.  The bus state bits are set by XHCI hub when root hub udev is
> + * suspended.  Used to determine if USB3 remote wakeup considerations need to
> + * be accounted for during XHCI resume.
> + */
> +static bool xhci_usb3_dev_connected(struct xhci_hcd *xhci)
> +{
> +	return !!xhci->usb3_rhub.bus_state.suspended_ports ||
> +		!!xhci->usb3_rhub.bus_state.bus_suspended;
> +}
> +
>  static bool xhci_pending_portevent(struct xhci_hcd *xhci)
>  {
>  	struct xhci_port	**ports;
> @@ -968,6 +980,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
>  	int			retval = 0;
>  	bool			comp_timer_running = false;
>  	bool			pending_portevent = false;
> +	bool			usb3_connected = false;
>  	bool			reinit_xhc = false;
>  
>  	if (!hcd->state)
> @@ -1116,9 +1129,14 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
>  		 * Resume roothubs only if there are pending events.
>  		 * USB 3 devices resend U3 LFPS wake after a 100ms delay if
>  		 * the first wake signalling failed, give it that chance.
> +		 * Avoid this check if there are no devices connected to
> +		 * the SS root hub. (i.e. HS device connected or no device
> +		 * connected)
>  		 */
>  		pending_portevent = xhci_pending_portevent(xhci);
> -		if (!pending_portevent && msg.event == PM_EVENT_AUTO_RESUME) {
> +		usb3_connected = xhci_usb3_dev_connected(xhci);
> +		if (!pending_portevent && usb3_connected &&
> +		     msg.event == PM_EVENT_AUTO_RESUME) {
>  			msleep(120);
>  			pending_portevent = xhci_pending_portevent(xhci);
>  		}
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
