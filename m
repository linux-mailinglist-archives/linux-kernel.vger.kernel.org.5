Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6716C7E6059
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjKHWK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:10:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CCD258A;
        Wed,  8 Nov 2023 14:10:24 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F18F99CC;
        Wed,  8 Nov 2023 23:09:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699481399;
        bh=TcWlArFT+z2NAsDcr8LONGkSMaY5LyN8tJsNXYDYl0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unPHtO56c8M3koePY2oufdbYmdX0ZAdDuoiDmVsJA8zgPP3TAfCSaYXVljZGTmZaw
         N1aY6HvNOf1OOZSzosQ2LRS3j8ZNG/S1M1QU63ilrrQ4gSBWab6XhP00ENSD37Mb7J
         mFN/olq7m59TyBWaoosQNhHUV/aV4CReKCG+3w/o=
Date:   Thu, 9 Nov 2023 00:10:25 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     nicolas@ndufresne.ca
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Esker Wong <esker@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Esker Wong <esker@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
Message-ID: <20231108221025.GD21616@pendragon.ideasonboard.com>
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
 <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu>
 <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
 <fe672e31315b8f9c44a693c909d464a299e76093.camel@ndufresne.ca>
 <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
 <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
 <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 08, 2023 at 03:32:23PM -0500, nicolas@ndufresne.ca wrote:
> Le mercredi 08 novembre 2023 à 08:04 +0100, Ricardo Ribalda a écrit :
> > On Wed, 8 Nov 2023 at 07:54, Esker Wong wrote:
> > > 
> > > Hi Nicholas and Sakari,
> > > 
> > > We need it as precise as possible. Currently the earliest time of a
> > > frame we can have in userspace  is the dqbuf.
> > > 
> > > And for UVC timestamp, it is somewhat awkward for us to use. Since
> > > other functions in our stacks do not necessarily contain such
> > > timestamps. So we want some event to be trigger and we can get the
> > > system time directly.
> 
> The fact that you interpret the time from FRAME_SYNC to DQBUF (well the
> READ IO notification) as the actual latency is yours of course. It
> assumes that the camera on the other end does not introduce other
> source of latency (or that these are negligible). You are also going to
> introduce a lot of jitter, since it relies on when the OS decides to
> wake up your process.
> 
> I think my opinion resides in if you can accurately *enough* implement
> what the spec says for FRAME_SYNC then do it, otherwise just don't lie.
> I think for ISO, "after the first chunk" i a small lie, but acceptable.
> But for BULK, the way it was explained is that it will be always very
> close to DQBUF time. and it should not emit FRAME_SYNC for this type of
> UVC device. If it fits other events fine of course, I'm just making a
> judgment on if its fits V4L2_EVENT_FRAME_SYNC or not.

I agree. V4L2_EVENT_FRAME_SYNC should be fine for isoc-based devices as
it should be "close enough" to the start of frame. For bulk it woul dbe
too much of a lie, so I would not emit it for bulk-based devices.

> In term of accuracy, if timestamp was passed with the FRAME_SYNC event,
> it would not matter how fast your process the event anymore and greatly
> improve accuracy.
> 
> > Not to mention that the UVC timestamping requires a bit of love.
> > 
> > @Laurent Pinchart, @Kieran Bingham  any progress reviewing :P :
> > https://patchwork.linuxtv.org/project/linux-media/list/?series=10083
> 
> Thanks for working on this by the way, hope someone will find the time
> to review this. The timestamps should in theory provide a jitter free
> measurement of the delay Esker is trying to measure, and if it wasn't
> of bugs (and crazy complexity) it would in the worst case match the
> transfer time.

Assuming the device firmware isn't too buggy, the UVC timestamps should
indeed provide much better accuracy than when V4L2_EVENT_FRAME_SYNC
could give. I think the biggest problem will be to figure out if a
particular device can be trusted.

> > > If the V4L2_EVENT_FRAME_SYNC will be earlier then V4L2_EVENT_VSYNC,
> > > then it has value. We would want to know the delay of a frame being
> > > captured to the time it is displayed.
> > > 
> > > I'm not sure for bulk is the V4L2_EVENT_VSYNC more accurate?
> > 
> >  V4L2_EVENT_VSYNC wont be more accurate than V4L2_EVENT_FRAME_SYNC.
> > 
> > My understanding is that Sakari thinks that the description of
> > V4L2_EVENT_FRAME_SYNC
> > https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-dqevent.html#description
> >  does not match the current implementation, and suggests using
> > V4L2_EVENT_VSYNC instead.
> > 
> > > On Wed, Nov 8, 2023 at 3:27 AM <nicolas@ndufresne.ca> wrote:
> > > > Le mardi 07 novembre 2023 à 13:06 +0800, Esker Wong a écrit :
> > > > > [send again in text mode]
> > > > > Hi Sakari,
> > > > > 
> > > > > Sequence number is important to us. We need it to measure the latency
> > > > > from this event to the time we display the frame.
> > > > 
> > > > how much precision do you expect, because as described, this number
> > > > will be completely false for bulk.
> > > > 
> > > > Aren't UVC timestamp support to allow measuring latency properly ?
> > > > 
> > > > > On Mon, Nov 6, 2023 at 7:06 PM Sakari Ailus wrote:
> > > > > > On Mon, Nov 06, 2023 at 10:52:27AM +0000, Ricardo Ribalda wrote:
> > > > > > > Add support for the frame_sync event, so user-space can become aware
> > > > > > > earlier of new frames.
> > > > > > > 
> > > > > > > Suggested-by: Esker Wong <esker@chromium.org>
> > > > > > > Tested-by: Esker Wong <esker@chromium.org>
> > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > ---
> > > > > > > We have measured a latency of around 30msecs between frame sync
> > > > > > > and dqbuf.
> > > > > > > ---
> > > > > > > Changes in v2:
> > > > > > > - Suggested by Laurent. Split sequence++ and event init.
> > > > > > > - Link to v1: https://lore.kernel.org/r/20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org
> > > > > > > ---
> > > > > > >  drivers/media/usb/uvc/uvc_v4l2.c  | 2 ++
> > > > > > >  drivers/media/usb/uvc/uvc_video.c | 7 +++++++
> > > > > > >  2 files changed, 9 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > > > index f4988f03640a..9f3fb5fd2375 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > > > @@ -1352,6 +1352,8 @@ static int uvc_ioctl_subscribe_event(struct v4l2_fh *fh,
> > > > > > >       switch (sub->type) {
> > > > > > >       case V4L2_EVENT_CTRL:
> > > > > > >               return v4l2_event_subscribe(fh, sub, 0, &uvc_ctrl_sub_ev_ops);
> > > > > > > +     case V4L2_EVENT_FRAME_SYNC:
> > > > > > > +             return v4l2_event_subscribe(fh, sub, 0, NULL);
> > > > > > >       default:
> > > > > > >               return -EINVAL;
> > > > > > >       }
> > > > > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > > > > index 28dde08ec6c5..4f3a510ca4fe 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > > > > @@ -1073,9 +1073,16 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
> > > > > > >        * that discontinuous sequence numbers always indicate lost frames.
> > > > > > >        */
> > > > > > >       if (stream->last_fid != fid) {
> > > > > > > +             struct v4l2_event event = {
> > > > > > > +                     .type = V4L2_EVENT_FRAME_SYNC,
> > > > > > > +             };
> > > > > > > +
> > > > > > >               stream->sequence++;
> > > > > > >               if (stream->sequence)
> > > > > > >                       uvc_video_stats_update(stream);
> > > > > > > +
> > > > > > > +             event.u.frame_sync.frame_sequence = stream->sequence,
> > > > > > > +             v4l2_event_queue(&stream->vdev, &event);
> > > > > > 
> > > > > > uvc_video_decode_start() is called when the reception of the entire frame
> > > > > > has been completed. However, the documentation for V4L2_EVENT_FRAME_SYNC
> > > > > > says that the event is "Triggered immediately when the reception of a frame
> > > > > > has begun.". The functionality here doesn't seem to fit to this patch.
> > > > > > 
> > > > > > Wouldn't V4L2_EVENT_VSYNC be a better fit, even if we don't really have a
> > > > > > concept of vertical sync in the case of USB? That event doesn't have the
> > > > > > sequence though but I guess it's not an issue at least if your case.
> > > > > > 
> > > > > > Another technically correct option could be to create a new event for this
> > > > > > but I'm not sure it's worth it.
> > > > > > 
> > > > > > >       }
> > > > > > > 
> > > > > > >       uvc_video_clock_decode(stream, buf, data, len);
> > > > > > > 

-- 
Regards,

Laurent Pinchart
