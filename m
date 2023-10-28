Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD57DA93B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjJ1UNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1UNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:13:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D75CC;
        Sat, 28 Oct 2023 13:13:47 -0700 (PDT)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 993C157E;
        Sat, 28 Oct 2023 22:13:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698524009;
        bh=WmT5kZ0+Wb+TJhzIVtG2TQ+c/X5DRYyYMMl3fHXbj6w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZJFV0FZ9TgFud7lp5t7jYtqOrhk7cS3OBqbvz3JIzGbeohIsh6yxZM/OAEJ/dXbEe
         1QaivXF4KybhY5ejOR/rt/QXoV599tVVC462R7X7d8ad7RcmQ8r2D0kWmQqtkfWl/G
         oTFyF5TsQDt7pdvH1ZStaH+FrRkZZx6wDw0qO7RE=
Message-ID: <5f21a75f-7b09-4e17-b300-b5fb0ff12807@ideasonboard.com>
Date:   Sat, 28 Oct 2023 21:13:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] usb: gadget: uvc: Allocate uvc_requests one at a
 time
Content-Language: en-US
To:     Avichal Rakesh <arakesh@google.com>
Cc:     etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
 <20231027201959.1869181-1-arakesh@google.com>
 <20231027201959.1869181-2-arakesh@google.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
Autocrypt: addr=dan.scally@ideasonboard.com; keydata=
 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
In-Reply-To: <20231027201959.1869181-2-arakesh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avichal

On 27/10/2023 21:19, Avichal Rakesh wrote:
> Currently, the uvc gadget driver allocates all uvc_requests as one array
> and deallocates them all when the video stream stops. This includes
> de-allocating all the usb_requests associated with those uvc_requests.
> This can lead to use-after-free issues if any of those de-allocated
> usb_requests were still owned by the usb controller.
>
> This patch is 1 of 2 patches addressing the use-after-free issue.
> Instead of bulk allocating all uvc_requests as an array, this patch
> allocates uvc_requests one at a time, which should allows for similar
> granularity when deallocating the uvc_requests. This patch has no
> functional changes other than allocating each uvc_request separately,
> and similarly freeing each of them separately.
>
> Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
> Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>


Sorry - I was unclear in my response to the first patch on v8. I meant my R-b to apply to the first 
patch only rather than to all of them. For this one I understand now the use of the conditional in 
uvc_video_free_request(), so that point is fine. I agree with Greg that the BUG_ON() shouldn't stand 
though.

> Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Avichal Rakesh <arakesh@google.com>
> ---
> v1 -> v2: Rebased to ToT
> v2 -> v3: Fix email threading goof-up
> v3 -> v4: Address review comments & re-rebase to ToT
> v4 -> v5: Address more review comments. Add Reviewed-by & Tested-by.
> v5 -> v6: No change
> v6 -> v7: No change
> v7 -> v8: No change. Getting back in review queue
> v8 -> v9: Address review comments.
>
>   drivers/usb/gadget/function/uvc.h       |  3 +-
>   drivers/usb/gadget/function/uvc_video.c | 89 ++++++++++++++-----------
>   2 files changed, 52 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index 989bc6b4e93d..993694da0bbc 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -81,6 +81,7 @@ struct uvc_request {
>   	struct sg_table sgt;
>   	u8 header[UVCG_REQUEST_HEADER_LEN];
>   	struct uvc_buffer *last_buf;
> +	struct list_head list;
>   };
>
>   struct uvc_video {
> @@ -102,7 +103,7 @@ struct uvc_video {
>
>   	/* Requests */
>   	unsigned int req_size;
> -	struct uvc_request *ureq;
> +	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
>   	struct list_head req_free;
>   	spinlock_t req_lock;
>
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index c334802ac0a4..f8f9209fee50 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -227,6 +227,24 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
>    * Request handling
>    */
>
> +static void
> +uvc_video_free_request(struct uvc_request *ureq, struct usb_ep *ep)
> +{
> +	sg_free_table(&ureq->sgt);
> +	if (ureq->req && ep) {
> +		usb_ep_free_request(ep, ureq->req);
> +		ureq->req = NULL;
> +	}
> +
> +	kfree(ureq->req_buffer);
> +	ureq->req_buffer = NULL;
> +
> +	if (!list_empty(&ureq->list))
> +		list_del_init(&ureq->list);
> +
> +	kfree(ureq);
> +}
> +
>   static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
>   {
>   	int ret;
> @@ -293,27 +311,12 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>   static int
>   uvc_video_free_requests(struct uvc_video *video)
>   {
> -	unsigned int i;
> -
> -	if (video->ureq) {
> -		for (i = 0; i < video->uvc_num_requests; ++i) {
> -			sg_free_table(&video->ureq[i].sgt);
> +	struct uvc_request *ureq, *temp;
>
> -			if (video->ureq[i].req) {
> -				usb_ep_free_request(video->ep, video->ureq[i].req);
> -				video->ureq[i].req = NULL;
> -			}
> -
> -			if (video->ureq[i].req_buffer) {
> -				kfree(video->ureq[i].req_buffer);
> -				video->ureq[i].req_buffer = NULL;
> -			}
> -		}
> -
> -		kfree(video->ureq);
> -		video->ureq = NULL;
> -	}
> +	list_for_each_entry_safe(ureq, temp, &video->ureqs, list)
> +		uvc_video_free_request(ureq, video->ep);
>
> +	INIT_LIST_HEAD(&video->ureqs);
>   	INIT_LIST_HEAD(&video->req_free);
>   	video->req_size = 0;
>   	return 0;
> @@ -322,39 +325,45 @@ uvc_video_free_requests(struct uvc_video *video)
>   static int
>   uvc_video_alloc_requests(struct uvc_video *video)
>   {
> +	struct uvc_request *ureq;
>   	unsigned int req_size;
>   	unsigned int i;
>   	int ret = -ENOMEM;
>
>   	BUG_ON(video->req_size);
> +	BUG_ON(!list_empty(&video->ureqs));
>
>   	req_size = video->ep->maxpacket
>   		 * max_t(unsigned int, video->ep->maxburst, 1)
>   		 * (video->ep->mult);
>
> -	video->ureq = kcalloc(video->uvc_num_requests, sizeof(struct uvc_request), GFP_KERNEL);
> -	if (video->ureq == NULL)
> -		return -ENOMEM;
> +	for (i = 0; i < video->uvc_num_requests; i++) {
> +		ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
> +		if (ureq == NULL)
> +			goto error;
> +
> +		INIT_LIST_HEAD(&ureq->list);
> +
> +		list_add_tail(&ureq->list, &video->ureqs);
>
> -	for (i = 0; i < video->uvc_num_requests; ++i) {
> -		video->ureq[i].req_buffer = kmalloc(req_size, GFP_KERNEL);
> -		if (video->ureq[i].req_buffer == NULL)
> +		ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
> +		if (ureq->req_buffer == NULL)
>   			goto error;
>
> -		video->ureq[i].req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
> -		if (video->ureq[i].req == NULL)
> +		ureq->req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
> +		if (ureq->req == NULL)
>   			goto error;
>
> -		video->ureq[i].req->buf = video->ureq[i].req_buffer;
> -		video->ureq[i].req->length = 0;
> -		video->ureq[i].req->complete = uvc_video_complete;
> -		video->ureq[i].req->context = &video->ureq[i];
> -		video->ureq[i].video = video;
> -		video->ureq[i].last_buf = NULL;
> +		ureq->req->buf = ureq->req_buffer;
> +		ureq->req->length = 0;
> +		ureq->req->complete = uvc_video_complete;
> +		ureq->req->context = ureq;
> +		ureq->video = video;
> +		ureq->last_buf = NULL;
>
> -		list_add_tail(&video->ureq[i].req->list, &video->req_free);
> +		list_add_tail(&ureq->req->list, &video->req_free);
>   		/* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
> -		sg_alloc_table(&video->ureq[i].sgt,
> +		sg_alloc_table(&ureq->sgt,
>   			       DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
>   					    PAGE_SIZE) + 2, GFP_KERNEL);
>   	}
> @@ -489,8 +498,8 @@ static void uvcg_video_pump(struct work_struct *work)
>    */
>   int uvcg_video_enable(struct uvc_video *video, int enable)
>   {
> -	unsigned int i;
>   	int ret;
> +	struct uvc_request *ureq;
>
>   	if (video->ep == NULL) {
>   		uvcg_info(&video->uvc->func,
> @@ -502,9 +511,10 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
>   		cancel_work_sync(&video->pump);
>   		uvcg_queue_cancel(&video->queue, 0);
>
> -		for (i = 0; i < video->uvc_num_requests; ++i)
> -			if (video->ureq && video->ureq[i].req)
> -				usb_ep_dequeue(video->ep, video->ureq[i].req);
> +		list_for_each_entry(ureq, &video->ureqs, list) {
> +			if (ureq->req)
> +				usb_ep_dequeue(video->ep, ureq->req);
> +		}
>
>   		uvc_video_free_requests(video);
>   		uvcg_queue_enable(&video->queue, 0);
> @@ -536,6 +546,7 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
>    */
>   int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>   {
> +	INIT_LIST_HEAD(&video->ureqs);
>   	INIT_LIST_HEAD(&video->req_free);
>   	spin_lock_init(&video->req_lock);
>   	INIT_WORK(&video->pump, uvcg_video_pump);
> --
> 2.42.0.820.g83a721a137-goog
