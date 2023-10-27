Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872357D9052
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjJ0HvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjJ0HvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:51:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6199196;
        Fri, 27 Oct 2023 00:51:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A82074A;
        Fri, 27 Oct 2023 09:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698393058;
        bh=EZyMEZiph2QncZXCWTjoVxf/ZFNaM3gPBMh135lA2qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1Q9hyJSGEsVVNpaXgz1cK1PtLQm1eqX9MyLw++J8o2DMSOxcmQffWG92o1hmjlAJ
         bGNjM4OjJCgkXjtQ9czPefke0P+2NVLmqidhHG1gKzvvIRm9zw3imUJnfRSWGbzqL9
         Y6/Ywn4iqiyqDcWPQko8ytFHbP2m1rjluvXnuQLA=
Date:   Fri, 27 Oct 2023 10:51:17 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jayant Chowdhary <jchowdhary@google.com>
Cc:     mgr@pengutronix.de, Thinh.Nguyen@synopsys.com, arakesh@google.com,
        etalvala@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH v2] usb:gadget:uvc Do not use worker thread to pump usb
 requests
Message-ID: <20231027075117.GJ26306@pendragon.ideasonboard.com>
References: <ZToOJhyOFeGCGUFj@pengutronix.de>
 <20231026215635.2478767-1-jchowdhary@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231026215635.2478767-1-jchowdhary@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayant,

Thank you for the patch.

On Thu, Oct 26, 2023 at 09:56:35PM +0000, Jayant Chowdhary wrote:
> This patch is based on top of
> https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:
> 
> When we use an async work queue to perform the function of pumping
> usb requests to the usb controller, it is possible that thread scheduling
> affects at what cadence we're able to pump requests. This could mean usb
> requests miss their uframes - resulting in video stream flickers on the host
> device.
> 
> In this patch, we move the pumping of usb requests to
> 1) uvcg_video_complete() complete handler for both isoc + bulk
>    endpoints. We still send 0 length requests when there is no uvc buffer
>    available to encode.

This means you will end up copying large amounts of data in interrupt
context. The work queue was there to avoid exactly that, as it will
introduce delays that can affect other parts of the system. I think this
is a problem.

> 2) uvc_v4l2_qbuf - only for bulk endpoints since it is not legal to send
>    0 length requests.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
> Suggested-by: Jayant Chowdhary <jchowdhary@google.com>
> Suggested-by: Avichal Rakesh <arakesh@google.com>
> Tested-by: Jayant Chowdhary <jchowdhary@google.com>
> ---
>  v1->v2: Fix code style and add self Signed-off-by
> 
>  drivers/usb/gadget/function/f_uvc.c     |  4 --
>  drivers/usb/gadget/function/uvc.h       |  4 +-
>  drivers/usb/gadget/function/uvc_v4l2.c  |  5 +-
>  drivers/usb/gadget/function/uvc_video.c | 71 ++++++++++++++++---------
>  drivers/usb/gadget/function/uvc_video.h |  2 +
>  5 files changed, 51 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index ae08341961eb..53cb2539486d 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -959,14 +959,10 @@ static void uvc_function_unbind(struct usb_configuration *c,
>  {
>  	struct usb_composite_dev *cdev = c->cdev;
>  	struct uvc_device *uvc = to_uvc(f);
> -	struct uvc_video *video = &uvc->video;
>  	long wait_ret = 1;
>  
>  	uvcg_info(f, "%s()\n", __func__);
>  
> -	if (video->async_wq)
> -		destroy_workqueue(video->async_wq);
> -
>  	/*
>  	 * If we know we're connected via v4l2, then there should be a cleanup
>  	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index be0d012aa244..498f344fda4b 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -88,9 +88,6 @@ struct uvc_video {
>  	struct uvc_device *uvc;
>  	struct usb_ep *ep;
>  
> -	struct work_struct pump;
> -	struct workqueue_struct *async_wq;
> -
>  	/* Frame parameters */
>  	u8 bpp;
>  	u32 fcc;
> @@ -116,6 +113,7 @@ struct uvc_video {
>  	/* Context data used by the completion handler */
>  	__u32 payload_size;
>  	__u32 max_payload_size;
> +	bool is_bulk;

This should be introduced in a separate patch.

>  
>  	struct uvc_video_queue queue;
>  	unsigned int fid;
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index f4d2e24835d4..678ea6df7b5c 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -414,10 +414,7 @@ uvc_v4l2_qbuf(struct file *file, void *fh, struct v4l2_buffer *b)
>  	ret = uvcg_queue_buffer(&video->queue, b);
>  	if (ret < 0)
>  		return ret;
> -
> -	if (uvc->state == UVC_STATE_STREAMING)
> -		queue_work(video->async_wq, &video->pump);
> -
> +	uvcg_video_pump_qbuf(video);
>  	return ret;
>  }
>  
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index ab3f02054e85..0fcd8e5edbac 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -24,6 +24,8 @@
>   * Video codecs
>   */
>  
> +static void uvcg_video_pump(struct uvc_video *video);
> +
>  static int
>  uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
>  		u8 *data, int len)
> @@ -329,7 +331,9 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>  	 */
>  	if (video->is_enabled) {
>  		list_add_tail(&req->list, &video->req_free);
> -		queue_work(video->async_wq, &video->pump);
> +		spin_unlock_irqrestore(&video->req_lock, flags);
> +		uvcg_video_pump(video);
> +		return;
>  	} else {
>  		uvc_video_free_request(ureq, ep);
>  	}
> @@ -409,20 +413,31 @@ uvc_video_alloc_requests(struct uvc_video *video)
>   * Video streaming
>   */
>  
> +void uvcg_video_pump_qbuf(struct uvc_video *video)
> +{
> +	/*
> +	 * Only call uvcg_video_pump() from qbuf, for bulk eps since
> +	 * for isoc, the complete handler will call uvcg_video_pump()
> +	 * consistently. Calling it for isoc eps, while correct
> +	 * will increase contention for video->req_lock since the
> +	 * complete handler will be called more often.
> +	*/
> +	if (video->is_bulk)
> +		uvcg_video_pump(video);

Am I the only one to see the *major* race condition that this patch
introduces ?

> +}
> +
>  /*
>   * uvcg_video_pump - Pump video data into the USB requests
>   *
>   * This function fills the available USB requests (listed in req_free) with
>   * video data from the queued buffers.
>   */
> -static void uvcg_video_pump(struct work_struct *work)
> +static void uvcg_video_pump(struct uvc_video *video)
>  {
> -	struct uvc_video *video = container_of(work, struct uvc_video, pump);
>  	struct uvc_video_queue *queue = &video->queue;
> -	/* video->max_payload_size is only set when using bulk transfer */
> -	bool is_bulk = video->max_payload_size;
>  	struct usb_request *req = NULL;
> -	struct uvc_buffer *buf;
> +	struct uvc_request *ureq = NULL;
> +	struct uvc_buffer *buf = NULL, *last_buf = NULL;
>  	unsigned long flags;
>  	bool buf_done;
>  	int ret;
> @@ -455,7 +470,8 @@ static void uvcg_video_pump(struct work_struct *work)
>  		if (buf != NULL) {
>  			video->encode(req, video, buf);
>  			buf_done = buf->state == UVC_BUF_STATE_DONE;
> -		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
> +		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) &&
> +				!video->is_bulk) {
>  			/*
>  			 * No video buffer available; the queue is still connected and
>  			 * we're transferring over ISOC. Queue a 0 length request to
> @@ -500,18 +516,30 @@ static void uvcg_video_pump(struct work_struct *work)
>  			req->no_interrupt = 1;
>  		}
>  
> -		/* Queue the USB request */
> -		ret = uvcg_video_ep_queue(video, req);
>  		spin_unlock_irqrestore(&queue->irqlock, flags);
> -
> +		spin_lock_irqsave(&video->req_lock, flags);
> +		if (video->is_enabled) {
> +			/* Queue the USB request */
> +			ret = uvcg_video_ep_queue(video, req);
> +			/* Endpoint now owns the request */
> +			req = NULL;
> +			video->req_int_count++;
> +		} else {
> +			ret =  -ENODEV;
> +			ureq = req->context;
> +			last_buf = ureq->last_buf;
> +			ureq->last_buf = NULL;
> +		}
> +		spin_unlock_irqrestore(&video->req_lock, flags);
>  		if (ret < 0) {
> +			if (last_buf != NULL) {
> +				// Return the buffer to the queue in the case the
> +				// request was not queued to the ep.

Wrong comment style.

> +				uvcg_complete_buffer(&video->queue, last_buf);
> +			}
>  			uvcg_queue_cancel(queue, 0);
>  			break;
>  		}
> -
> -		/* Endpoint now owns the request */
> -		req = NULL;
> -		video->req_int_count++;
>  	}
>  
>  	if (!req)
> @@ -556,7 +584,6 @@ uvcg_video_disable(struct uvc_video *video)
>  	}
>  	spin_unlock_irqrestore(&video->req_lock, flags);
>  
> -	cancel_work_sync(&video->pump);
>  	uvcg_queue_cancel(&video->queue, 0);
>  
>  	spin_lock_irqsave(&video->req_lock, flags);
> @@ -626,14 +653,16 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
>  	if (video->max_payload_size) {
>  		video->encode = uvc_video_encode_bulk;
>  		video->payload_size = 0;
> -	} else
> +		video->is_bulk = true;
> +	} else {
>  		video->encode = video->queue.use_sg ?
>  			uvc_video_encode_isoc_sg : uvc_video_encode_isoc;
> +		video->is_bulk = false;
> +	}
>  
>  	video->req_int_count = 0;
>  
> -	queue_work(video->async_wq, &video->pump);
> -
> +	uvcg_video_pump(video);
>  	return ret;
>  }
>  
> @@ -646,12 +675,6 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>  	INIT_LIST_HEAD(&video->ureqs);
>  	INIT_LIST_HEAD(&video->req_free);
>  	spin_lock_init(&video->req_lock);
> -	INIT_WORK(&video->pump, uvcg_video_pump);
> -
> -	/* Allocate a work queue for asynchronous video pump handler. */
> -	video->async_wq = alloc_workqueue("uvcgadget", WQ_UNBOUND | WQ_HIGHPRI, 0);
> -	if (!video->async_wq)
> -		return -EINVAL;
>  
>  	video->uvc = uvc;
>  	video->fcc = V4L2_PIX_FMT_YUYV;
> diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/function/uvc_video.h
> index 03adeefa343b..29c6b9a2e9c3 100644
> --- a/drivers/usb/gadget/function/uvc_video.h
> +++ b/drivers/usb/gadget/function/uvc_video.h
> @@ -18,4 +18,6 @@ int uvcg_video_enable(struct uvc_video *video, int enable);
>  
>  int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc);
>  
> +void uvcg_video_pump_qbuf(struct uvc_video *video);
> +
>  #endif /* __UVC_VIDEO_H__ */

-- 
Regards,

Laurent Pinchart
