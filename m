Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E241F7EDE34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjKPKJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjKPKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:09:30 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155FD192;
        Thu, 16 Nov 2023 02:09:26 -0800 (PST)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC8CD11B4;
        Thu, 16 Nov 2023 11:08:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700129337;
        bh=2y46PRMq+vrRMKNjBaJ3DpjVuXglm8rnT/ScmL9HJXc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jdyuxrsce42HOtZi5Ijnex9O7tsVCEtRRneh1tizNoRRJqBQfvQQRpEvoOuOtZpUi
         XR329edXwm5xhSij/1RrMb3pMk1wOPJl74Wx/Dsz3aTlwjZsUww9Sfs8mOuZDFC+dP
         NGs+L3x5VkZ1I/GM8uX+C1NAqSwMtQAB4vQK2Tv4=
Message-ID: <908009f0-e2b5-4330-a9f7-48b13f6ed528@ideasonboard.com>
Date:   Thu, 16 Nov 2023 10:09:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] usb:gadget:uvc Do not use worker thread to pump isoc
 usb requests
Content-Language: en-US
To:     Jayant Chowdhary <jchowdhary@google.com>,
        stern@rowland.harvard.edu, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org
Cc:     Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20231109021251.542558-1-jchowdhary@google.com>
 <20231109073453.751860-1-jchowdhary@google.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
Autocrypt: addr=dan.scally@ideasonboard.com; keydata=
 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
In-Reply-To: <20231109073453.751860-1-jchowdhary@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayant, thanks for the update. I just have a couple of styling comments.

On 09/11/2023 07:34, Jayant Chowdhary wrote:
> When we use an async work queue to perform the function of pumping
> usb requests to the usb controller, it is possible that amongst other
> factors, thread scheduling affects at what cadence we're able to pump
> requests. This could mean isoc usb requests miss their uframes - resulting
> in video stream flickers on the host device.
>
> To avoid this, we make the async_wq thread only produce isoc usb_requests
> with uvc buffers encoded into them. The process of queueing to the
> endpoint is done by the uvc_video_complete() handler. In case no
> usb_requests are ready with encoded information, we just queue a zero
> length request to the endpoint from the complete handler.
>
> For bulk endpoints the async_wq thread still queues usb requests to the
> endpoint.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
> Suggested-by: Avichal Rakesh <arakesh@google.com>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>   Based on top of
>   https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:
>   v1->v2: Added self Signed-Off-by and addressed review comments
>   v2->v3: Encode to usb requests in async_wq; queue to ep in complete handler
> 	 for isoc transfers.
>   v3->v4: Address review comments around code style.
>   v4->v5: Update comments. Remove 0 length request queueing from async_wq
> 	 thread since it is already done by the complete handler.
>   v5->v6: Fix checkpatch.pl suggestions.
>
>   drivers/usb/gadget/function/uvc.h       |   8 +
>   drivers/usb/gadget/function/uvc_video.c | 204 ++++++++++++++++++------
>   2 files changed, 166 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index e8d4c87f1e09..5ff454528bd8 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -105,7 +105,15 @@ struct uvc_video {
>   	bool is_enabled; /* tracks whether video stream is enabled */
>   	unsigned int req_size;
>   	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
> +
> +	/* USB requests that the video pump thread can encode into */
>   	struct list_head req_free;
> +
> +	/*
> +	 * USB requests video pump thread has already encoded into. These are
> +	 * ready to be queued to the endpoint.
> +	 */
> +	struct list_head req_ready;
>   	spinlock_t req_lock;
>   
>   	unsigned int req_int_count;
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 53feb790a4c3..d5311456fa8a 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -268,6 +268,100 @@ static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
>   	return ret;
>   }
>   
> +/* This function must be called with video->req_lock held. */
> +static int uvcg_video_usb_req_queue(struct uvc_video *video,
> +	struct usb_request *req, bool queue_to_ep)
> +{
> +	bool is_bulk = video->max_payload_size;
> +	struct list_head *list = NULL;
> +
> +	if (!video->is_enabled) {
> +		uvc_video_free_request(req->context, video->ep);
> +		return -ENODEV;
> +	}
> +	if (queue_to_ep) {
> +		struct uvc_request *ureq = req->context;
> +		/*
> +		 * With USB3 handling more requests at a higher speed, we can't
> +		 * afford to generate an interrupt for every request. Decide to
> +		 * interrupt:
> +		 *
> +		 * - When no more requests are available in the free queue, as
> +		 *   this may be our last chance to refill the endpoint's
> +		 *   request queue.
> +		 *
> +		 * - When this is request is the last request for the video
> +		 *   buffer, as we want to start sending the next video buffer
> +		 *   ASAP in case it doesn't get started already in the next
> +		 *   iteration of this loop.
> +		 *
> +		 * - Four times over the length of the requests queue (as
> +		 *   indicated by video->uvc_num_requests), as a trade-off
> +		 *   between latency and interrupt load.
> +		 */
> +		if (list_empty(&video->req_free) || ureq->last_buf ||
> +			!(video->req_int_count %
> +			DIV_ROUND_UP(video->uvc_num_requests, 4))) {
> +			video->req_int_count = 0;
> +			req->no_interrupt = 0;
> +		} else {
> +			req->no_interrupt = 1;
> +		}
> +		video->req_int_count++;
> +		return uvcg_video_ep_queue(video, req);
> +	}
> +	/*
> +	 * If we're not queuing to the ep, for isoc we're queuing
> +	 * to the req_ready list, otherwise req_free.
> +	 */
> +	list = is_bulk ? &video->req_free : &video->req_ready;
> +	list_add_tail(&req->list, list);
> +	return 0;
> +}
> +
> +/*
> + * Must only be called from uvcg_video_enable - since after that we only want to
> + * queue requests to the endpoint from the uvc_video_complete complete handler.
> + * This function is needed in order to 'kick start' the flow of requests from
> + * gadget driver to the usb controller.
> + */
> +static void uvc_video_ep_queue_initial_requests(struct uvc_video *video)
> +{
> +	struct usb_request *req = NULL;
> +	unsigned long flags = 0;
> +	unsigned int count = 0;
> +	int ret = 0;
Add an empty line here please
> +	/*
> +	 * We only queue half of the free list since we still want to have
> +	 * some free usb_requests in the free list for the video_pump async_wq
> +	 * thread to encode uvc buffers into. Otherwise we could get into a
> +	 * situation where the free list does not have any usb requests to
> +	 * encode into - we always end up queueing 0 length requests to the
> +	 * end point.
> +	 */
> +	unsigned int half_list_size = video->uvc_num_requests / 2;
> +
> +	spin_lock_irqsave(&video->req_lock, flags);
> +	/*
> +	 * Take these requests off the free list and queue them all to the
> +	 * endpoint. Since we queue 0 length requests with the req_lock held,
> +	 * there isn't any 'data' race involved here with the complete handler.
> +	 */
> +	while (count < half_list_size) {
> +		req = list_first_entry(&video->req_free, struct usb_request,
> +					list);
> +		list_del(&req->list);
> +		req->length = 0;
> +		ret = uvcg_video_ep_queue(video, req);
> +		if (ret < 0) {
> +			uvcg_queue_cancel(&video->queue, /*disconnect*/0);


Drop the /*disconnect*/ comment please

> +			break;
> +		}
> +		count++;
> +	}
> +	spin_unlock_irqrestore(&video->req_lock, flags);
> +}
> +
>   static void
>   uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>   {
> @@ -276,6 +370,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>   	struct uvc_video_queue *queue = &video->queue;
>   	struct uvc_buffer *last_buf = NULL;
>   	unsigned long flags;
> +	bool is_bulk = video->max_payload_size;
> +	int ret = 0;
>   
>   	spin_lock_irqsave(&video->req_lock, flags);
>   	if (!video->is_enabled) {
> @@ -329,8 +425,46 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>   	 * back to req_free
>   	 */
>   	if (video->is_enabled) {
> -		list_add_tail(&req->list, &video->req_free);
> -		queue_work(video->async_wq, &video->pump);
> +		/*
> +		 * Here we check whether any request is available in the ready
> +		 * list. If it is, queue it to the ep and add the current
> +		 * usb_request to the req_free list - for video_pump to fill in.
> +		 * Otherwise, just use the current usb_request to queue a 0
> +		 * length request to the ep. Since we always add to the req_free
> +		 * list if we dequeue from the ready list, there will never
> +		 * be a situation where the req_free list is completely out of
> +		 * requests and cannot recover.
> +		 */
> +		struct usb_request *to_queue = req;
> +
> +		to_queue->length = 0;
> +		if (!list_empty(&video->req_ready)) {
> +			to_queue = list_first_entry(&video->req_ready,
> +				struct usb_request, list);
> +			list_del(&to_queue->list);
> +			/* Add it to the free list. */
I would drop the "Add it to the free list" comment; the code is clear already.
> +			list_add_tail(&req->list, &video->req_free);
> +			/*
> +			 * Queue work to the wq as well since it is possible that a
> +			 * buffer may not have been completely encoded with the set of
> +			 * in-flight usb requests for whih the complete callbacks are
> +			 * firing.
> +			 * In that case, if we do not queue work to the worker thread,
> +			 * the buffer will never be marked as complete - and therefore
> +			 * not be returned to userpsace. As a result,
> +			 * dequeue -> queue -> dequeue flow of uvc buffers will not
> +			 * happen.
> +			 */
> +			queue_work(video->async_wq, &video->pump);
> +		}
> +		/*
> +		 * Queue to the endpoint. The actual queueing to ep will
> +		 * only happen on one thread - the async_wq for bulk endpoints
> +		 * and this thread for isoc endpoints.
> +		 */
> +		ret = uvcg_video_usb_req_queue(video, to_queue, !is_bulk);
> +		if (ret < 0)
> +			uvcg_queue_cancel(queue, 0);
>   	} else {
>   		uvc_video_free_request(ureq, ep);
>   	}
> @@ -347,6 +481,7 @@ uvc_video_free_requests(struct uvc_video *video)
>   
>   	INIT_LIST_HEAD(&video->ureqs);
>   	INIT_LIST_HEAD(&video->req_free);
> +	INIT_LIST_HEAD(&video->req_ready);
>   	video->req_size = 0;
>   	return 0;
>   }
> @@ -424,8 +559,7 @@ static void uvcg_video_pump(struct work_struct *work)
>   	struct usb_request *req = NULL;
>   	struct uvc_buffer *buf;
>   	unsigned long flags;
> -	bool buf_done;
> -	int ret;
> +	int ret = 0;
>   
>   	while (true) {
>   		if (!video->ep->enabled)
> @@ -454,15 +588,6 @@ static void uvcg_video_pump(struct work_struct *work)
>   
>   		if (buf != NULL) {
>   			video->encode(req, video, buf);
> -			buf_done = buf->state == UVC_BUF_STATE_DONE;
> -		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
> -			/*
> -			 * No video buffer available; the queue is still connected and
> -			 * we're transferring over ISOC. Queue a 0 length request to
> -			 * prevent missed ISOC transfers.
> -			 */
> -			req->length = 0;
> -			buf_done = false;
>   		} else {
>   			/*
>   			 * Either the queue has been disconnected or no video buffer
> @@ -473,45 +598,25 @@ static void uvcg_video_pump(struct work_struct *work)
>   			break;
>   		}
>   
> -		/*
> -		 * With USB3 handling more requests at a higher speed, we can't
> -		 * afford to generate an interrupt for every request. Decide to
> -		 * interrupt:
> -		 *
> -		 * - When no more requests are available in the free queue, as
> -		 *   this may be our last chance to refill the endpoint's
> -		 *   request queue.
> -		 *
> -		 * - When this is request is the last request for the video
> -		 *   buffer, as we want to start sending the next video buffer
> -		 *   ASAP in case it doesn't get started already in the next
> -		 *   iteration of this loop.
> -		 *
> -		 * - Four times over the length of the requests queue (as
> -		 *   indicated by video->uvc_num_requests), as a trade-off
> -		 *   between latency and interrupt load.
> -		 */
> -		if (list_empty(&video->req_free) || buf_done ||
> -		    !(video->req_int_count %
> -		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
> -			video->req_int_count = 0;
> -			req->no_interrupt = 0;
> -		} else {
> -			req->no_interrupt = 1;
> -		}
> -
> -		/* Queue the USB request */
> -		ret = uvcg_video_ep_queue(video, req);
>   		spin_unlock_irqrestore(&queue->irqlock, flags);
>   
> +		spin_lock_irqsave(&video->req_lock, flags);
> +		/* For bulk end points we queue from the worker thread
> +		 * since we would preferably not want to wait on requests
> +		 * to be ready, in the uvcg_video_complete() handler.
> +		 * For isoc endpoints we add the request to the ready list
> +		 * and only queue it to the endpoint from the complete handler.
> +		 */
> +		ret = uvcg_video_usb_req_queue(video, req, is_bulk);
> +		spin_unlock_irqrestore(&video->req_lock, flags);
> +
>   		if (ret < 0) {
>   			uvcg_queue_cancel(queue, 0);
>   			break;
>   		}
>   
> -		/* Endpoint now owns the request */
> +		/* The request is owned by  the endpoint / ready list. */
>   		req = NULL;
> -		video->req_int_count++;
>   	}
>   
>   	if (!req)
> @@ -567,7 +672,7 @@ uvcg_video_disable(struct uvc_video *video)
>   
>   	spin_lock_irqsave(&video->req_lock, flags);
>   	/*
> -	 * Remove all uvc_reqeusts from ureqs with list_del_init
> +	* Remove all uvc_requests from ureqs with list_del_init

Did the alignment of the * get messed up here as well as the typo fix or is it just my mail client 
being weird?


>   	 * This lets uvc_video_free_request correctly identify
>   	 * if the uvc_request is attached to a list or not when freeing
>   	 * memory.
> @@ -580,8 +685,14 @@ uvcg_video_disable(struct uvc_video *video)
>   		uvc_video_free_request(req->context, video->ep);
>   	}
>   
> +	list_for_each_entry_safe(req, temp, &video->req_ready, list) {
> +		list_del(&req->list);
> +		uvc_video_free_request(req->context, video->ep);
> +	}
> +
>   	INIT_LIST_HEAD(&video->ureqs);
>   	INIT_LIST_HEAD(&video->req_free);
> +	INIT_LIST_HEAD(&video->req_ready);
>   	video->req_size = 0;
>   	spin_unlock_irqrestore(&video->req_lock, flags);
>   
> @@ -635,7 +746,7 @@ int uvcg_video_enable(struct uvc_video *video)
>   
>   	video->req_int_count = 0;
>   
> -	queue_work(video->async_wq, &video->pump);
> +	uvc_video_ep_queue_initial_requests(video);
>   
>   	return ret;
>   }
> @@ -648,6 +759,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>   	video->is_enabled = false;
>   	INIT_LIST_HEAD(&video->ureqs);
>   	INIT_LIST_HEAD(&video->req_free);
> +	INIT_LIST_HEAD(&video->req_ready);
>   	spin_lock_init(&video->req_lock);
>   	INIT_WORK(&video->pump, uvcg_video_pump);
>   
