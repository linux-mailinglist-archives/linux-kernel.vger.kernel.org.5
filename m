Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF99F7EF3E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjKQNxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQNxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:53:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65FD51
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:53:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A35C433C8;
        Fri, 17 Nov 2023 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700229200;
        bh=K/JjWna5WH0BIy6eoXxUf5f8W17a1PwItdoPzNiEMcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxAEQO1uVK5dvP4fuKInNcZIi88TLaCoVVDVRJccvUd0P6VN76Yr/5vczr24lAcjY
         Pdp/ZsmUHDAK4FNuN61EC6unlf0BkRibSczsUzWlzq9zWNfVLBySQXh5Bq4QoFYPg6
         FLcaC8OgLl+Gee+D48+S1yA7RJLvYQ7XoMJvXmKQ=
Date:   Fri, 17 Nov 2023 08:53:18 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kuen-Han Tsai <khtsai@google.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: fix null pointer deref for xhci_urb_enqueue
Message-ID: <2023111705-showroom-consonant-7a7b@gregkh>
References: <20231117072131.2886406-1-khtsai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117072131.2886406-1-khtsai@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 03:21:28PM +0800, Kuen-Han Tsai wrote:
> The null pointer dereference happens when xhci_free_dev() frees the
> xhci->devs[slot_id] virtual device while xhci_urb_enqueue() is
> processing a urb and checking the max packet size.
> 
> [106913.850735][ T2068] usb 2-1: USB disconnect, device number 2
> [106913.856999][ T4618] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> [106913.857488][ T4618] Call trace:
> [106913.857491][ T4618]  xhci_check_maxpacket+0x30/0x2dc
> [106913.857494][ T4618]  xhci_urb_enqueue+0x24c/0x47c
> [106913.857498][ T4618]  usb_hcd_submit_urb+0x1f4/0xf34
> [106913.857501][ T4618]  usb_submit_urb+0x4b8/0x4fc
> [106913.857503][ T4618]  usb_control_msg+0x144/0x238
> [106913.857507][ T4618]  do_proc_control+0x1f0/0x5bc
> [106913.857509][ T4618]  usbdev_ioctl+0xdd8/0x15a8
> 
> This patch adds a spinlock to the xhci_urb_enqueue function to make sure
> xhci_free_dev() and xhci_urb_enqueue() do not race and cause null
> pointer dereference.

I thought we had a lock for this already, what changed to cause this to
start triggering now, all these years later?

> 
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>

What commit id does this fix?


> ---
>  drivers/usb/host/xhci.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 884b0898d9c9..e0766ebeff0e 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1522,23 +1522,32 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>  	struct urb_priv	*urb_priv;
>  	int num_tds;
>  
> -	if (!urb)
> -		return -EINVAL;
> -	ret = xhci_check_args(hcd, urb->dev, urb->ep,
> -					true, true, __func__);
> -	if (ret <= 0)
> -		return ret ? ret : -EINVAL;
> +	spin_lock_irqsave(&xhci->lock, flags);
> +
> +	if (!urb) {
> +		ret = -EINVAL;
> +		goto done;
> +	}

Why does this have to be inside the lock?  The urb can't change here,
can it?

> +
> +	ret = xhci_check_args(hcd, urb->dev, urb->ep, true, true, __func__);
> +	if (ret <= 0) {
> +		ret = ret ? ret : -EINVAL;
> +		goto done;
> +	}
>  
>  	slot_id = urb->dev->slot_id;
>  	ep_index = xhci_get_endpoint_index(&urb->ep->desc);
>  	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
>  
> -	if (!HCD_HW_ACCESSIBLE(hcd))
> -		return -ESHUTDOWN;
> +	if (!HCD_HW_ACCESSIBLE(hcd)) {
> +		ret = -ESHUTDOWN;
> +		goto done;

Note, we now have completions, so all of this "goto done" doesn't need
to happen anymore.  Not a complaint, just a suggestion for future
changes or this one, your choice.

thanks,

greg k-h
