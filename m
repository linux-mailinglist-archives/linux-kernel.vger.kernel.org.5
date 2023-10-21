Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFC7D1C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJUKKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:10:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7501A4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:10:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878A1C433C8;
        Sat, 21 Oct 2023 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697883006;
        bh=l2uGjtCIejrc6L6O3rXUOz/2g7u2EwJLoiJlt0FIuo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYkQ+BVOg6kCqPEW1B9ax8pPK6R+fdAT4cX2JnwULQw21k9NGW6AZI8czxC0KGC6l
         RR42HeXHp8tIbyXvCf/ToLzs3wfuvUk+GF/97XfiVtkQ+NKlI23AJxqAbUy4xCwrVG
         pM5PaT4bpOv9DGbjomWWZkM4NAfltHJld8yVRicI=
Date:   Sat, 21 Oct 2023 12:10:03 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "i@zenithal.me" <i@zenithal.me>
Subject: Re: ZDI-CAN-22273: New Vulnerability Report
Message-ID: <2023102134-reflux-saddling-c750@gregkh>
References: <DM5PR0102MB347711AF2F5655852AC60BEB80DBA@DM5PR0102MB3477.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR0102MB347711AF2F5655852AC60BEB80DBA@DM5PR0102MB3477.prod.exchangelabs.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:25:27PM +0000, zdi-disclosures@trendmicro.com wrote:
> ### Analysis
> 
> ```
> race condition bug exists in the usb/ip VHCI driver
> it leads to UAF on `struct usb_device`
> thread 1                                                thread 2
> vhci_device_reset()                             vhci_urb_enqueue()
>  usb_put_dev(vdev->udev);
>                                                                  usb_put_dev(vdev->udev);               // free
>                                                                  vdev->udev = usb_get_dev(urb->dev);    // UAF
>  vdev->udev = NULL;
> ```
> 
> here is the patch in order to trigger the bug more easier
> ```
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 37d1fc34e..7242244d7 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -11,7 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> -
> +#include <linux/delay.h>
>  #include "usbip_common.h"
>  #include "vhci.h"
> 
> @@ -781,6 +781,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>                                 usbip_dbg_vhci_hc(
>                                         "Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
> 
> +                       mdelay(200);
>                         usb_put_dev(vdev->udev);
>                         vdev->udev = usb_get_dev(urb->dev);
>                         goto out;
> @@ -1075,6 +1076,7 @@ static void vhci_device_reset(struct usbip_device *ud)
>         vdev->devid  = 0;
> 
>         usb_put_dev(vdev->udev);
> +       mdelay(200);
>         vdev->udev = NULL;
> 
>         if (ud->tcp_socket) {
> ```

So you are resetting a device while it is enumerating?  That's a very
narrow window to handle, and you need a malicious device to do this,
right?

Can you submit a patch to just save off the reference of the device
before the put is called on it to be sure that all is in sync properly?

thanks,

greg k-h
