Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434997F2AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjKUKh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjKUKhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:37:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB6B10EB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:36:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA44CC433C7;
        Tue, 21 Nov 2023 10:36:54 +0000 (UTC)
Message-ID: <995f8f26-ed20-44d2-a76a-e354fc68d65e@xs4all.nl>
Date:   Tue, 21 Nov 2023 11:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esker Wong <esker@chromium.org>
References: <20231106-uvc-event-v3-1-c2d2fdaa2e2c@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20231106-uvc-event-v3-1-c2d2fdaa2e2c@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Sorry, I missed the whole discussion for the v2 patch. I've now read it and
will reply here.

On 11/6/23 12:00, Ricardo Ribalda wrote:
> Add support for the frame_sync event, so user-space can become aware
> earlier of new frames.

I don't think this describes why you want this. Specifically, you want to use
this to measure latency inside the driver between the arrival of the first USB
packet and the time the buffer is dequeued.

And this is presumably meant for debugging/measuring, but not for normal
capturing. Right?

Based on the discussion it looks like everyone is OK with this for the BULK
case, and V4L2_EVENT_FRAME_SYNC makes sense to me there. You want to see the
sequence number in the event, and the description of the event matches what
happens.

The problem is the ISOC case where it is debatable if this adds anything.

Perhaps in the ISOC case this event shouldn't be supported? Unless you can
show that it does provide useful information in the ISOC case. I didn't see
that in the v2 discussion, but I might have missed it.

Regards,

	Hans

> 
> Suggested-by: Esker Wong <esker@chromium.org>
> Tested-by: Esker Wong <esker@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> We have measured a latency of around 30msecs between frame sync
> and dqbuf.
> ---
> Changes in v3:
> - Sent wrong patch as v2 sorry :S
> - Link to v2: https://lore.kernel.org/r/20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org
> 
> Changes in v2:
> - Suggested by Laurent. Split sequence++ and event init.
> - Link to v1: https://lore.kernel.org/r/20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c  | 2 ++
>  drivers/media/usb/uvc/uvc_video.c | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index f4988f03640a..9f3fb5fd2375 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1352,6 +1352,8 @@ static int uvc_ioctl_subscribe_event(struct v4l2_fh *fh,
>  	switch (sub->type) {
>  	case V4L2_EVENT_CTRL:
>  		return v4l2_event_subscribe(fh, sub, 0, &uvc_ctrl_sub_ev_ops);
> +	case V4L2_EVENT_FRAME_SYNC:
> +		return v4l2_event_subscribe(fh, sub, 0, NULL);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 28dde08ec6c5..6a9410133908 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1073,9 +1073,16 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
>  	 * that discontinuous sequence numbers always indicate lost frames.
>  	 */
>  	if (stream->last_fid != fid) {
> +		struct v4l2_event event = {
> +			.type = V4L2_EVENT_FRAME_SYNC,
> +		};
> +
>  		stream->sequence++;
>  		if (stream->sequence)
>  			uvc_video_stats_update(stream);
> +
> +		event.u.frame_sync.frame_sequence = stream->sequence;
> +		v4l2_event_queue(&stream->vdev, &event);
>  	}
>  
>  	uvc_video_clock_decode(stream, buf, data, len);
> 
> ---
> base-commit: ce55c22ec8b223a90ff3e084d842f73cfba35588
> change-id: 20231020-uvc-event-d3d1bbbdcb2f
> 
> Best regards,

