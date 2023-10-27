Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28F67D9910
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbjJ0M4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbjJ0M4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:56:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD90D10E;
        Fri, 27 Oct 2023 05:56:16 -0700 (PDT)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 88CCD74A;
        Fri, 27 Oct 2023 14:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698411361;
        bh=CJU9T5GqjZmDTwSgidfqCYcFywtF++cj5X/IT435ysk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZFtNKTukqgw+nxgyxmEsiawmNCHmOhQDFSEcjSfB5SVQJn+SZsYs131IRjJq1l+oC
         TZKANW+zOBuOphX78u7TrAApl0VpMRIhtwITDMzK/tzWtWpqvFDjgiT8urzK5bthJf
         LsZR5sn3sbcZcd9fxaf72dNqmOf0K8+Wqv5pbSEo=
Message-ID: <e2c9d477-efe1-49dd-9800-c6f48e104ff1@ideasonboard.com>
Date:   Fri, 27 Oct 2023 13:56:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] usb: gadget: uvc: prevent use of disabled endpoint
Content-Language: en-US
To:     Avichal Rakesh <arakesh@google.com>, gregkh@linuxfoundation.org,
        laurent.pinchart@ideasonboard.com
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de
References: <20231019185319.2714000-1-arakesh@google.com>
 <20231024183605.908253-1-arakesh@google.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
Autocrypt: addr=dan.scally@ideasonboard.com; keydata=
 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
In-Reply-To: <20231024183605.908253-1-arakesh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avichal

On 24/10/2023 19:36, Avichal Rakesh wrote:
> Currently the set_alt callback immediately disables the endpoint and queues
> the v4l2 streamoff event. However, as the streamoff event is processed
> asynchronously, it is possible that the video_pump thread attempts to queue
> requests to an already disabled endpoint.
>
> This change moves disabling usb endpoint to the end of streamoff event
> callback. As the endpoint's state can no longer be used, video_pump is
> now guarded by uvc->state as well. To be consistent with the actual
> streaming state, uvc->state is now toggled between CONNECTED and STREAMING
> from the v4l2 event callback only.
>
> Link: https://lore.kernel.org/20230615171558.GK741@pendragon.ideasonboard.com/
> Link: https://lore.kernel.org/20230531085544.253363-1-dan.scally@ideasonboard.com/


Thank you for picking this up! And I'm sorry to have been so remiss looking at your patches - I will 
try to be more responsive to them. I spotted a typo below, but otherwise:


Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

> Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Avichal Rakesh <arakesh@google.com>
> ---
> v1 -> v2: Rebased to ToT and reworded commit message.
> v2 -> v3: Fix email threading goof-up
> v3 -> v4: Address review comments & re-rebase to ToT
> v4 -> v5: Add Reviewed-by & Tested-by
> v5 -> v6: No change
> v6 -> v7: No change
> v7 -> v8: No change. Getting back in review queue
>
>   drivers/usb/gadget/function/f_uvc.c     | 11 +++++------
>   drivers/usb/gadget/function/f_uvc.h     |  2 +-
>   drivers/usb/gadget/function/uvc.h       |  2 +-
>   drivers/usb/gadget/function/uvc_v4l2.c  | 20 +++++++++++++++++---
>   drivers/usb/gadget/function/uvc_video.c |  3 ++-
>   5 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index faa398109431..ae08341961eb 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -263,10 +263,13 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
>   	return 0;
>   }
>
> -void uvc_function_setup_continue(struct uvc_device *uvc)
> +void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep)
>   {
>   	struct usb_composite_dev *cdev = uvc->func.config->cdev;
>
> +	if (disable_ep && uvc->video.ep)
> +		usb_ep_disable(uvc->video.ep);
> +
>   	usb_composite_setup_continue(cdev);
>   }
>
> @@ -337,15 +340,11 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
>   		if (uvc->state != UVC_STATE_STREAMING)
>   			return 0;
>
> -		if (uvc->video.ep)
> -			usb_ep_disable(uvc->video.ep);
> -
>   		memset(&v4l2_event, 0, sizeof(v4l2_event));
>   		v4l2_event.type = UVC_EVENT_STREAMOFF;
>   		v4l2_event_queue(&uvc->vdev, &v4l2_event);
>
> -		uvc->state = UVC_STATE_CONNECTED;
> -		return 0;
> +		return USB_GADGET_DELAYED_STATUS;
>
>   	case 1:
>   		if (uvc->state != UVC_STATE_CONNECTED)
> diff --git a/drivers/usb/gadget/function/f_uvc.h b/drivers/usb/gadget/function/f_uvc.h
> index 1db972d4beeb..e7f9f13f14dc 100644
> --- a/drivers/usb/gadget/function/f_uvc.h
> +++ b/drivers/usb/gadget/function/f_uvc.h
> @@ -11,7 +11,7 @@
>
>   struct uvc_device;
>
> -void uvc_function_setup_continue(struct uvc_device *uvc);
> +void uvc_function_setup_continue(struct uvc_device *uvc, int disale_ep);


s/disale_ep/disable_ep

>
>   void uvc_function_connect(struct uvc_device *uvc);
>
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index 6751de8b63ad..989bc6b4e93d 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -177,7 +177,7 @@ struct uvc_file_handle {
>    * Functions
>    */
>
> -extern void uvc_function_setup_continue(struct uvc_device *uvc);
> +extern void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep);
>   extern void uvc_function_connect(struct uvc_device *uvc);
>   extern void uvc_function_disconnect(struct uvc_device *uvc);
>
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index 3f0a9795c0d4..7cb8d027ff0c 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -451,7 +451,7 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
>   	 * Complete the alternate setting selection setup phase now that
>   	 * userspace is ready to provide video frames.
>   	 */
> -	uvc_function_setup_continue(uvc);
> +	uvc_function_setup_continue(uvc, 0);
>   	uvc->state = UVC_STATE_STREAMING;
>
>   	return 0;
> @@ -463,11 +463,18 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
>   	struct video_device *vdev = video_devdata(file);
>   	struct uvc_device *uvc = video_get_drvdata(vdev);
>   	struct uvc_video *video = &uvc->video;
> +	int ret = 0;
>
>   	if (type != video->queue.queue.type)
>   		return -EINVAL;
>
> -	return uvcg_video_enable(video, 0);
> +	uvc->state = UVC_STATE_CONNECTED;
> +	ret = uvcg_video_enable(video, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	uvc_function_setup_continue(uvc, 1);
> +	return 0;
>   }
>
>   static int
> @@ -500,6 +507,14 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
>   static void uvc_v4l2_disable(struct uvc_device *uvc)
>   {
>   	uvc_function_disconnect(uvc);
> +	/*
> +	 * Drop uvc->state to CONNECTED if it was streaming before.
> +	 * This ensures that the usb_requests are no longer queued
> +	 * to the controller.
> +	 */
> +	if (uvc->state == UVC_STATE_STREAMING)
> +		uvc->state = UVC_STATE_CONNECTED;
> +
>   	uvcg_video_enable(&uvc->video, 0);
>   	uvcg_free_buffers(&uvc->video.queue);
>   	uvc->func_connected = false;
> @@ -647,4 +662,3 @@ const struct v4l2_file_operations uvc_v4l2_fops = {
>   	.get_unmapped_area = uvcg_v4l2_get_unmapped_area,
>   #endif
>   };
> -
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 91af3b1ef0d4..c334802ac0a4 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -384,13 +384,14 @@ static void uvcg_video_pump(struct work_struct *work)
>   	struct uvc_video_queue *queue = &video->queue;
>   	/* video->max_payload_size is only set when using bulk transfer */
>   	bool is_bulk = video->max_payload_size;
> +	struct uvc_device *uvc = video->uvc;
>   	struct usb_request *req = NULL;
>   	struct uvc_buffer *buf;
>   	unsigned long flags;
>   	bool buf_done;
>   	int ret;
>
> -	while (video->ep->enabled) {
> +	while (uvc->state == UVC_STATE_STREAMING && video->ep->enabled) {
>   		/*
>   		 * Retrieve the first available USB request, protected by the
>   		 * request lock.
> --
> 2.42.0.758.gaed0368e0e-goog
