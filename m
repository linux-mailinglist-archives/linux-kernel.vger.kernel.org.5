Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB33375B1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjGTO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjGTO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:56:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 20D84EE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:55:59 -0700 (PDT)
Received: (qmail 1683964 invoked by uid 1000); 20 Jul 2023 10:55:59 -0400
Date:   Thu, 20 Jul 2023 10:55:59 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Aman Deep <aman.deep@samsung.com>
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anuj Gupta <anuj01.gupta@samsung.com>
Subject: Re: [PATCH] USB: Fix race condition during UVC webcam disconnect
Message-ID: <fad2a76f-f17f-4e14-b795-2edede643cf3@rowland.harvard.edu>
References: <CGME20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b@epcas5p1.samsung.com>
 <20230720113142.3070583-1-aman.deep@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720113142.3070583-1-aman.deep@samsung.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

This backtrace doesn't show what actually caused the bug.  You should 
have included several lines from the system log _preceding_ the 
backtrace.  Without those lines, we can only guess at what the problem 
was.

> This below solution patch fixes this race condition at USB core level
> occurring during UVC webcam device disconnect.

How can a race in the UVC driver be fixed by changing the USB core?  It 
seems obvious that the only way to fix such a race is by changing the 
UVC driver.

> Signed-off-by: Anuj Gupta <anuj01.gupta@samsung.com>
> Signed-off-by: Aman Deep <aman.deep@samsung.com>
> ---
>  drivers/usb/core/hcd.c     | 7 ++++++-
>  drivers/usb/core/message.c | 4 ++++
>  drivers/usb/core/usb.c     | 9 ++++++---
>  3 files changed, 16 insertions(+), 4 deletions(-)
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

What will happen if the state changes to USB_STATE_NOTATTACHED at this 
point, after that test was made?

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

Same question: What happens if the state changes right here?

> +
>  	ret = usb_hcd_alloc_bandwidth(dev, NULL, iface->cur_altsetting, alt);
> +
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

This new test can fail only if the routine is called after (or while) 
the device is unconfigured or removed.  But if a driver makes such a 
call then the driver is buggy.  The proper solution is to fix the 
driver, not add this test here.

Besides, this test has the same problem as the others you added above.  
What happens if config->interface[i] gets set to NULL right here?

Alan Stern

> +				config->interface[i]->altsetting[0]
> +				.desc.bInterfaceNumber == ifnum) {
>  			return config->interface[i];
> +		}
> +	}
>  
>  	return NULL;
>  }
> -- 
> 2.34.1
> 
