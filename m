Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61A7DA93A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjJ1UQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1UQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:16:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA935CC;
        Sat, 28 Oct 2023 13:16:06 -0700 (PDT)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B9A557E;
        Sat, 28 Oct 2023 22:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698524150;
        bh=FADP+aNXp3YMXcPXdJyU95OLiez4jnl4rAOVugnc2ag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gHNgs2mH2EZ6/Iicx+JLWatfaRiBNRbQw302lQtC+P2RTVTUA/vg0kudVAgXTitGq
         qR2dQKrIH8Ztnpi8Ev//NrWuHTyu4NAZ0Gl6C3luDsqnTYlLMKTM6zvkzXNrieDM1e
         aDJ5+fJpP8SrpOMROgM49TPLfBvXAfA7YvnslcIE=
Message-ID: <46ec546d-f883-41ea-a493-e2179bd48469@ideasonboard.com>
Date:   Sat, 28 Oct 2023 21:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] usb: gadget: uvc: move video disable logic to its
 own function
Content-Language: en-US
To:     Avichal Rakesh <arakesh@google.com>
Cc:     etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
 <20231027201959.1869181-1-arakesh@google.com>
 <20231027201959.1869181-3-arakesh@google.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
Autocrypt: addr=dan.scally@ideasonboard.com; keydata=
 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
In-Reply-To: <20231027201959.1869181-3-arakesh@google.com>
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
> This patch refactors the video disable logic in uvcg_video_enable
> into its own separate function 'uvcg_video_disable'. This function
> is now used anywhere uvcg_video_enable(video, 0) was used.
>
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>


For this patch you can keep the R-b - it's fine by me now :)

> Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Avichal Rakesh <arakesh@google.com>
> ---
> v6: Introduced this patch to make the next one easier to review
> v6 -> v7: Add Suggested-by
> v7 -> v8: No change. Getting back in review queue
> v8 -> v9: Call uvcg_video_disable directly instead of uvcg_video_enable(video, 0)
>
>   drivers/usb/gadget/function/uvc_v4l2.c  |  6 ++--
>   drivers/usb/gadget/function/uvc_video.c | 40 ++++++++++++++++---------
>   drivers/usb/gadget/function/uvc_video.h |  3 +-
>   3 files changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index 7cb8d027ff0c..904dd283cbf7 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -443,7 +443,7 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
>   		return -EINVAL;
>
>   	/* Enable UVC video. */
> -	ret = uvcg_video_enable(video, 1);
> +	ret = uvcg_video_enable(video);
>   	if (ret < 0)
>   		return ret;
>
> @@ -469,7 +469,7 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
>   		return -EINVAL;
>
>   	uvc->state = UVC_STATE_CONNECTED;
> -	ret = uvcg_video_enable(video, 0);
> +	ret = uvcg_video_disable(video);
>   	if (ret < 0)
>   		return ret;
>
> @@ -515,7 +515,7 @@ static void uvc_v4l2_disable(struct uvc_device *uvc)
>   	if (uvc->state == UVC_STATE_STREAMING)
>   		uvc->state = UVC_STATE_CONNECTED;
>
> -	uvcg_video_enable(&uvc->video, 0);
> +	uvcg_video_disable(&uvc->video);
>   	uvcg_free_buffers(&uvc->video.queue);
>   	uvc->func_connected = false;
>   	wake_up_interruptible(&uvc->func_connected_queue);
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index f8f9209fee50..1081dd790fd6 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -494,31 +494,43 @@ static void uvcg_video_pump(struct work_struct *work)
>   }
>
>   /*
> - * Enable or disable the video stream.
> + * Disable the video stream
>    */
> -int uvcg_video_enable(struct uvc_video *video, int enable)
> +int
> +uvcg_video_disable(struct uvc_video *video)
>   {
> -	int ret;
>   	struct uvc_request *ureq;
>
>   	if (video->ep == NULL) {
>   		uvcg_info(&video->uvc->func,
> -			  "Video enable failed, device is uninitialized.\n");
> +			  "Video disable failed, device is uninitialized.\n");
>   		return -ENODEV;
>   	}
>
> -	if (!enable) {
> -		cancel_work_sync(&video->pump);
> -		uvcg_queue_cancel(&video->queue, 0);
> +	cancel_work_sync(&video->pump);
> +	uvcg_queue_cancel(&video->queue, 0);
>
> -		list_for_each_entry(ureq, &video->ureqs, list) {
> -			if (ureq->req)
> -				usb_ep_dequeue(video->ep, ureq->req);
> -		}
> +	list_for_each_entry(ureq, &video->ureqs, list) {
> +		if (ureq->req)
> +			usb_ep_dequeue(video->ep, ureq->req);
> +	}
>
> -		uvc_video_free_requests(video);
> -		uvcg_queue_enable(&video->queue, 0);
> -		return 0;
> +	uvc_video_free_requests(video);
> +	uvcg_queue_enable(&video->queue, 0);
> +	return 0;
> +}
> +
> +/*
> + * Enable the video stream.
> + */
> +int uvcg_video_enable(struct uvc_video *video)
> +{
> +	int ret;
> +
> +	if (video->ep == NULL) {
> +		uvcg_info(&video->uvc->func,
> +			  "Video enable failed, device is uninitialized.\n");
> +		return -ENODEV;
>   	}
>
>   	if ((ret = uvcg_queue_enable(&video->queue, 1)) < 0)
> diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/function/uvc_video.h
> index 03adeefa343b..8ef6259741f1 100644
> --- a/drivers/usb/gadget/function/uvc_video.h
> +++ b/drivers/usb/gadget/function/uvc_video.h
> @@ -14,7 +14,8 @@
>
>   struct uvc_video;
>
> -int uvcg_video_enable(struct uvc_video *video, int enable);
> +int uvcg_video_enable(struct uvc_video *video);
> +int uvcg_video_disable(struct uvc_video *video);
>
>   int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc);
>
> --
> 2.42.0.820.g83a721a137-goog
