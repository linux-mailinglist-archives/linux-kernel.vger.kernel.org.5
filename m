Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84CF7E1EB1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjKFKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:42:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283DF99;
        Mon,  6 Nov 2023 02:42:39 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B3C4672;
        Mon,  6 Nov 2023 11:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699267337;
        bh=LhNtk/nSwRZtfXgSWCgSIqPYb/rXuEPu9bAk43W2SCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsdZGutabTHrpDQbFGAzG1ovVlFHn/RWjBwSGlx2m32qMwQojlIA1PEIJwQzKF6Cg
         qSzrfHsDq32zEqfQIsIM3LcYqgK80kblBbPmvVx/DvWBUpNTJ2w8irj3X3JVTjBFfi
         LnpE5opR/VCindFYTA2TLZqOFBIJJYGOpu6npxMk=
Date:   Mon, 6 Nov 2023 12:42:45 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esker Wong <esker@chromium.org>
Subject: Re: [PATCH] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
Message-ID: <20231106104245.GB19272@pendragon.ideasonboard.com>
References: <20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org>
 <20231106103925.GA19272@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106103925.GA19272@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 12:39:26PM +0200, Laurent Pinchart wrote:
> On Fri, Oct 20, 2023 at 06:41:45AM +0000, Ricardo Ribalda wrote:
> > Add support for the frame_sync event, so user-space can become aware
> > earlier of new frames.
> > 
> > Suggested-by: Esker Wong <esker@chromium.org>
> > Tested-by: Esker Wong <esker@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > We have measured a latency of around 30msecs between frame sync
> > and dqbuf.
> 
> Not surprising, especially for large resolutions. I'm curious though,
> what do you use this event for ?
> 
> > ---
> >  drivers/media/usb/uvc/uvc_v4l2.c  | 2 ++
> >  drivers/media/usb/uvc/uvc_video.c | 8 +++++++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index f4988f03640a..9f3fb5fd2375 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -1352,6 +1352,8 @@ static int uvc_ioctl_subscribe_event(struct v4l2_fh *fh,
> >  	switch (sub->type) {
> >  	case V4L2_EVENT_CTRL:
> >  		return v4l2_event_subscribe(fh, sub, 0, &uvc_ctrl_sub_ev_ops);
> > +	case V4L2_EVENT_FRAME_SYNC:
> > +		return v4l2_event_subscribe(fh, sub, 0, NULL);
> >  	default:
> >  		return -EINVAL;
> >  	}
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 28dde08ec6c5..1d4b4807b005 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -1073,9 +1073,15 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
> >  	 * that discontinuous sequence numbers always indicate lost frames.
> >  	 */
> >  	if (stream->last_fid != fid) {
> > -		stream->sequence++;
> > +		struct v4l2_event event = {
> > +			.type = V4L2_EVENT_FRAME_SYNC,
> > +			.u.frame_sync.frame_sequence =  ++stream->sequence,
> 
> Extra space before ++.
> 
> It's easy to miss the ++ there when reading the code, would the
> following be more readable ?
> 
> 		struct v4l2_event event = {
> 			.type = V4L2_EVENT_FRAME_SYNC,
> 		};
> 
> 		stream->sequence++;
> 		if (stream->sequence)
> 			uvc_video_stats_update(stream);
> 
> 		.u.frame_sync.frame_sequence = stream->sequence;

Obviously this should read

 		event.u.frame_sync.frame_sequence = stream->sequence;

> 		v4l2_event_queue(&stream->vdev, &event);
> 
> > +		};
> > +
> >  		if (stream->sequence)
> >  			uvc_video_stats_update(stream);
> > +
> > +		v4l2_event_queue(&stream->vdev, &event);
> >  	}
> >  
> >  	uvc_video_clock_decode(stream, buf, data, len);
> > 
> > ---
> > base-commit: ce55c22ec8b223a90ff3e084d842f73cfba35588
> > change-id: 20231020-uvc-event-d3d1bbbdcb2f

-- 
Regards,

Laurent Pinchart
