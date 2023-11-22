Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1A67F47D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbjKVNda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343773AbjKVNd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:33:28 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEDE197;
        Wed, 22 Nov 2023 05:33:25 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 21726276;
        Wed, 22 Nov 2023 14:32:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700659973;
        bh=ovNRFCOwfiedgo/BxjM6ABJ6tIltn5tkgyoVDp1O/vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKeOAKQZCqI9EPX5E6sIkR1baYbxjtlCecJ7izSg2dK9xA9w8qXyoaBdtUN3KP4UC
         il2klRfQnZOL0sNGdJorB2DLCGXAnhJcqtdTlyxOQWEi6y+o1dVT14fXuQ4VHzpn46
         QwqPh4q3j5X1xrg3ImeanqvUsq1vaHgURP+PRUmw=
Date:   Wed, 22 Nov 2023 15:33:30 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v5 3/3] media: uvcvideo: Do not use usb_* functions after
 .disconnect
Message-ID: <20231122133330.GE3909@pendragon.ideasonboard.com>
References: <20231122-guenter-mini-v5-0-15d8cd8ed74f@chromium.org>
 <20231122-guenter-mini-v5-3-15d8cd8ed74f@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122-guenter-mini-v5-3-15d8cd8ed74f@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:45:49AM +0000, Ricardo Ribalda wrote:
> usb drivers should not call to any I/O function after the
> .disconnect() callback has been triggered.
> https://www.kernel.org/doc/html/latest/driver-api/usb/callbacks.html#the-disconnect-callback
> 
> If an application is receiving frames form a camera and the device is
> disconnected: the device will call close() after the usb .disconnect()
> callback has been called. The streamoff path will call usb_set_interface
> or usb_clear_halt, which is not allowed.
> 
> This patch only solves the calls to close() *after* .disconnect() is
> being called.
> 
> Trace:
> [ 1065.389723] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> [ 1065.390160] drivers/media/usb/uvc/uvc_driver.c:2264 uvc_disconnect exit
> [ 1065.433956] drivers/media/usb/uvc/uvc_v4l2.c:659 uvc_v4l2_release enter
> [ 1065.433973] drivers/media/usb/uvc/uvc_video.c:2274 uvc_video_stop_streaming enter
> [ 1065.434560] drivers/media/usb/uvc/uvc_video.c:2285 uvc_video_stop_streaming exit
> [ 1065.435154] drivers/media/usb/uvc/uvc_v4l2.c:680 uvc_v4l2_release exit
> [ 1065.435188] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c |  2 ++
>  drivers/media/usb/uvc/uvc_video.c  | 45 ++++++++++++++++++++++++--------------
>  drivers/media/usb/uvc/uvcvideo.h   |  2 ++
>  3 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index d5dbf2644272..d78640d422f4 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2266,6 +2266,8 @@ static void uvc_disconnect(struct usb_interface *intf)
>  		return;
>  
>  	uvc_unregister_video(dev);
> +	/* Barrier needed to pair with uvc_video_stop_streaming(). */
> +	smp_store_release(&dev->disconnected, true);

I can't think this would be such a hot path that we really need barriers
in the driver.

>  	kref_put(&dev->ref, uvc_delete);
>  }
>  
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 28dde08ec6c5..f5ef375088de 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -2243,28 +2243,39 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
>  	return ret;
>  }
>  
> -void uvc_video_stop_streaming(struct uvc_streaming *stream)
> +static void uvc_video_halt(struct uvc_streaming *stream)
>  {
> -	uvc_video_stop_transfer(stream, 1);
> +	unsigned int epnum;
> +	unsigned int pipe;
> +	unsigned int dir;
>  
>  	if (stream->intf->num_altsetting > 1) {
>  		usb_set_interface(stream->dev->udev, stream->intfnum, 0);
> -	} else {
> -		/*
> -		 * UVC doesn't specify how to inform a bulk-based device
> -		 * when the video stream is stopped. Windows sends a
> -		 * CLEAR_FEATURE(HALT) request to the video streaming
> -		 * bulk endpoint, mimic the same behaviour.
> -		 */
> -		unsigned int epnum = stream->header.bEndpointAddress
> -				   & USB_ENDPOINT_NUMBER_MASK;
> -		unsigned int dir = stream->header.bEndpointAddress
> -				 & USB_ENDPOINT_DIR_MASK;
> -		unsigned int pipe;
> -
> -		pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> -		usb_clear_halt(stream->dev->udev, pipe);
> +		return;
>  	}
>  
> +	/*
> +	 * UVC doesn't specify how to inform a bulk-based device
> +	 * when the video stream is stopped. Windows sends a
> +	 * CLEAR_FEATURE(HALT) request to the video streaming
> +	 * bulk endpoint, mimic the same behaviour.
> +	 */
> +	epnum = stream->header.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
> +	dir = stream->header.bEndpointAddress & USB_ENDPOINT_DIR_MASK;
> +	pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> +	usb_clear_halt(stream->dev->udev, pipe);
> +}
> +
> +void uvc_video_stop_streaming(struct uvc_streaming *stream)
> +{
> +	uvc_video_stop_transfer(stream, 1);
> +
> +	/*
> +	 * Barrier needed to pair with uvc_disconnect().
> +	 * We cannot call usb_* functions on a disconnected USB device.
> +	 */
> +	if (!smp_load_acquire(&stream->dev->disconnected))
> +		uvc_video_halt(stream);
> +
>  	uvc_video_clock_cleanup(stream);
>  }
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index ba8f8c1f2c83..5b1a3643de05 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -559,6 +559,8 @@ struct uvc_device {
>  	unsigned int users;
>  	atomic_t nmappings;
>  
> +	bool disconnected;
> +
>  	/* Video control interface */
>  #ifdef CONFIG_MEDIA_CONTROLLER
>  	struct media_device mdev;
> 

-- 
Regards,

Laurent Pinchart
