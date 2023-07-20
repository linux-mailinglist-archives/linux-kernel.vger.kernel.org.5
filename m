Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB13775AF95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGTNWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjGTNWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCDAE60;
        Thu, 20 Jul 2023 06:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACF961A28;
        Thu, 20 Jul 2023 13:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEDAC433C8;
        Thu, 20 Jul 2023 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689859362;
        bh=UxGNS4Tm6QXbkmz0tPWtSTwsEwS6W+sxPDlrcmJzi4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFsbvlwUy0eZzVtaNrYod3QeHOgHvnrJpDQShlhOyL2ojGnnIJM0YAo/qTdK9hkTs
         QwpHFQXZeL1PDMK3YHfl9au7pabLMpYvk6tMXsiMAXzDVmgqcGbquQQdsrXmwOPUK5
         Eh379GAva0qS0Xvex5vh3aKupbnfFNYFuZ0K057s=
Date:   Thu, 20 Jul 2023 15:22:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aman Deep <aman.deep@samsung.com>
Cc:     stern@rowland.harvard.edu, laurent.pinchart@ideasonboard.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anuj Gupta <anuj01.gupta@samsung.com>
Subject: Re: [PATCH] USB: Fix race condition during UVC webcam disconnect
Message-ID: <2023072013-reconvene-capsize-0286@gregkh>
References: <CGME20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b@epcas5p1.samsung.com>
 <20230720113142.3070583-1-aman.deep@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720113142.3070583-1-aman.deep@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 05:01:42PM +0530, Aman Deep wrote:
> In the bug happened during uvc webcam disconect,there is race
> between stopping a video transfer and usb disconnect.This issue is
> reproduced in my system running Linux kernel when UVC webcam play is
> stopped and UVC webcam is disconnected at the same time. This causes the
> below backtrace:
> 
> [2-3496.7275]  PC is at 0xbf418000+0x2d8 [usbcore]
> [2-3496.7275]  LR is at 0x00000005
> [2-3496.7275] pc : [<bf4182d8>]((usb_ifnum_to_if
> </drivers/usb/core/usb.c:283
> [usbcore.ko]>)) lr : [<00000005>]() psr: 20000013
> [2-3496.7275] Function entered at [<bf4182a4>]((usb_ifnum_to_if
> </drivers/usb/core/usb.c:275
> [usbcore.ko]>)) (0xbf418000+0x2a4 [usbcore]) from
> [<bf423974>]((usb_hcd_alloc_bandwidth
> </drivers/usb/core/hcd.c:1947
> [usbcore.ko]>)) (0xbf418000+0xb974 [usbcore])
> [2-3496.7275] Function entered at [<bf423738>]((usb_hcd_alloc_bandwidth
> </drivers/usb/core/hcd.c:1876
> [usbcore.ko]>)) (0xbf418000+0xb738 [usbcore]) from
> [<bf426ca0>]((usb_set_interface
> </drivers/usb/core/message.c:1461
> [usbcore.ko]>)) (0xbf418000+0xeca0 [usbcore])
> [2-3496.7275] Function entered at [<bf426b9c>]((usb_set_interface
> </drivers/usb/core/message.c:1385
> [usbcore.ko]>)) (0xbf418000+0xeb9c [usbcore]) from
> [<bf9c4dd4>]((uvc_video_clock_cleanup
> </drivers/media/usb/uvc/uvc_video.c:598
> uvc_video_stop_streaming
> </drivers/media/usb/uvc/uvc_video.c:2221
> [uvcvideo.ko]>)) (0xbf9bd000+0x7dd4 [uvcvideo])
> [2-3496.7275] Function entered at [<bf9c4d98>]((uvc_video_stop_streaming
> </drivers/media/usb/uvc/uvc_video.c:2200
> [uvcvideo.ko]>)) (0xbf9bd000+0x7d98 [uvcvideo]) from
> [<bf9bfab8>]((spin_lock_irq
> </include/linux/spinlock.h:363
> uvc_stop_streaming
> </drivers/media/usb/uvc/uvc_queue.c:194
> [uvcvideo.ko]>)) (0xbf9bd000+0x2ab8 [uvcvideo])
> [2-3496.7276] Function entered at [<bf9bfa94>]((uvc_stop_streaming
> </drivers/media/usb/uvc/uvc_queue.c:186
> [uvcvideo.ko]>)) (0xbf9bd000+0x2a94 [uvcvideo]) from
> [<be307150>]((__read_once_size
> </include/linux/compiler.h:290
> (discriminator 1) __vb2_queue_cancel
> </drivers/media/common/videobuf2/videobuf2-core.c:1893
> (discriminator 1) [videobuf2_common.ko]>)) (0xbe306000+0x1150
> [videobuf2_common])
> [2-3496.7276] Function entered at [<be307120>]((__vb2_queue_cancel
> </drivers/media/common/videobuf2/videobuf2-core.c:1877
> [videobuf2_common.ko]>)) (0xbe306000+0x1120 [videobuf2_common]) from
> [<be308894>]((vb2_core_streamoff
> </drivers/media/common/videobuf2/videobuf2-core.c:2053

Odd wrapping, please fix.

> 
> This below solution patch fixes this race condition at USB core level
> occurring during UVC webcam device disconnect.
> 
> Signed-off-by: Anuj Gupta <anuj01.gupta@samsung.com>
> Signed-off-by: Aman Deep <aman.deep@samsung.com>

What commit id does this fix?  SHould this go to the stable trees?

> ---
>  drivers/usb/core/hcd.c     | 7 ++++++-
>  drivers/usb/core/message.c | 4 ++++
>  drivers/usb/core/usb.c     | 9 ++++++---
>  3 files changed, 16 insertions(+), 4 deletions(-)

Why are you making changes to the core USB stack for a driver bug?

> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 8300baedafd2..a06452cbbaa4 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1931,7 +1931,12 @@ int usb_hcd_alloc_bandwidth(struct usb_device *udev,
>  		}
>  	}
>  	if (cur_alt && new_alt) {
> -		struct usb_interface *iface = usb_ifnum_to_if(udev,
> +		struct usb_interface *iface;
> +
> +		if (udev->state == USB_STATE_NOTATTACHED)
> +			return -ENODEV;
> +
> +		iface = usb_ifnum_to_if(udev,
>  				cur_alt->desc.bInterfaceNumber);
>  
>  		if (!iface)
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index b5811620f1de..f31c7287dc01 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1575,7 +1575,11 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
>  	for (i = 0; i < iface->cur_altsetting->desc.bNumEndpoints; i++)
>  		iface->cur_altsetting->endpoint[i].streams = 0;
>  
> +	if (dev->state == USB_STATE_NOTATTACHED)
> +		return -ENODEV;
> +
>  	ret = usb_hcd_alloc_bandwidth(dev, NULL, iface->cur_altsetting, alt);
> +

Why the extra line?

And why can't the state change right after you check for it?  What
happens if the device is unattached right here?

>  	if (ret < 0) {
>  		dev_info(&dev->dev, "Not enough bandwidth for altsetting %d\n",
>  				alternate);
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 901ec732321c..6fb8b14469ae 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -352,10 +352,13 @@ struct usb_interface *usb_ifnum_to_if(const struct usb_device *dev,
>  
>  	if (!config)
>  		return NULL;
> -	for (i = 0; i < config->desc.bNumInterfaces; i++)
> -		if (config->interface[i]->altsetting[0]
> -				.desc.bInterfaceNumber == ifnum)
> +	for (i = 0; i < config->desc.bNumInterfaces; i++) {
> +		if (config->interface[i] &&
> +				config->interface[i]->altsetting[0]
> +				.desc.bInterfaceNumber == ifnum) {
>  			return config->interface[i];

I don't understand this change, what does it do?

Your changelog does not say why you are doing any of this, only that
"there is a problem", please explain this better when you resubmit this.

thanks,

greg k-h
