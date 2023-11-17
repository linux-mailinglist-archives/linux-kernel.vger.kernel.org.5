Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2C7EF3B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjKQNbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:31:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A5D4B;
        Fri, 17 Nov 2023 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700227872; x=1731763872;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=uJH4Ph6hp15onxms+JDDCUYO9/U18VbMeMZeZR2BVAs=;
  b=SP/+SE4L9Cza8tBKI4Qn0PmkXQrEs7OHTQ44ZpLchPS0VptM0kJvjJyx
   +DQV0OF39rM/R6JXNmYQlWZ1gVvpnsRY8yzjngdNCkYEpEuaFEPoTeuvi
   UZB7uxGc1VVLfnc7nkAweiUWYbeaUQDnh4nTBF+I2hx9eWLfZ9OXPE0Ff
   tejx13utQBV+loUuvLP3zJAZrMNZ62xWGpqLJ2jVahx8rIOwQ0Yw3rrol
   JGsy6bT0Qb4/XTqn1R3ce/ASRWeK5lV4m2WDaYQluil4sptBQiBFVrMJA
   1gpxSwFULein8gpfIorj+doD7DG8Tb6vbN6OTlgVbXkvMCsqCYPLZQclO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4442693"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="4442693"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:31:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="715544005"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="715544005"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2023 05:31:09 -0800
Message-ID: <a4a129a3-e271-acbb-949c-534a8e1627ee@linux.intel.com>
Date:   Fri, 17 Nov 2023 15:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Kuen-Han Tsai <khtsai@google.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231117072131.2886406-1-khtsai@google.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: fix null pointer deref for xhci_urb_enqueue
In-Reply-To: <20231117072131.2886406-1-khtsai@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.2023 9.21, Kuen-Han Tsai wrote:
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

Thanks, nice catch

This patch does however need some additional tuning

> 
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---
>   drivers/usb/host/xhci.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 884b0898d9c9..e0766ebeff0e 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1522,23 +1522,32 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>   	struct urb_priv	*urb_priv;
>   	int num_tds;
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
> +
> +	ret = xhci_check_args(hcd, urb->dev, urb->ep, true, true, __func__);
> +	if (ret <= 0) {
> +		ret = ret ? ret : -EINVAL;
> +		goto done;
> +	}
>   
>   	slot_id = urb->dev->slot_id;
>   	ep_index = xhci_get_endpoint_index(&urb->ep->desc);
>   	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
>   
> -	if (!HCD_HW_ACCESSIBLE(hcd))
> -		return -ESHUTDOWN;
> +	if (!HCD_HW_ACCESSIBLE(hcd)) {
> +		ret = -ESHUTDOWN;
> +		goto done;
> +	}
>   
>   	if (xhci->devs[slot_id]->flags & VDEV_PORT_ERROR) {
>   		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto done;
>   	}
>   
>   	if (usb_endpoint_xfer_isoc(&urb->ep->desc))
> @@ -1552,8 +1561,10 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>   		num_tds = 1;
>   
>   	urb_priv = kzalloc(struct_size(urb_priv, td, num_tds), mem_flags);

kzalloc with spinlock held, should preferably be moved outside lock, otherwise should use GFP_ATOMIC

> -	if (!urb_priv)
> -		return -ENOMEM;
> +	if (!urb_priv) {
> +		ret = -ENOMEM;
> +		goto done;
> +	}
>   
>   	urb_priv->num_tds = num_tds;
>   	urb_priv->num_tds_done = 0;
> @@ -1571,13 +1582,11 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag

xhci_check_maxpacket() called here can't be called with spinlock held

>   			if (ret < 0) {
>   				xhci_urb_free_priv(urb_priv);
>   				urb->hcpriv = NULL;
> -				return ret;
> +				goto done;

Thanks
Mathias
