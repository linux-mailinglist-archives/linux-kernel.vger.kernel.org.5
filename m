Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C47E69BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjKILea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjKILe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:34:27 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B1E2D6B;
        Thu,  9 Nov 2023 03:34:24 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20447AE;
        Thu,  9 Nov 2023 12:34:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699529640;
        bh=fUZEfz/0pac4QQkUe5FHTJcFNgwiEsw+aeCPLBNCs0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEYNlWKJsQ6OHxWwASFUGlIzxp2J07zz7ipOZtZ5BxX+PBQ6Knj1MJmF3MZEYVKml
         fVq/f5c6tH2AkO4P3r+rQ2y5GT5icT+wzVkBWCaZ1jeNP/eorXzzQ7MH4hkYnpzXlJ
         6Utl/Wv9Zbq1pR6wQr7V33wv0U+R/b38q9eBH6Sg=
Date:   Thu, 9 Nov 2023 13:34:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Esker Wong <esker@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, nicolas@ndufresne.ca,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Esker Wong <esker@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
Message-ID: <20231109113428.GI21616@pendragon.ideasonboard.com>
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
 <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu>
 <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
 <fe672e31315b8f9c44a693c909d464a299e76093.camel@ndufresne.ca>
 <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
 <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
 <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
 <CANiDSCunRRyod3Rg+L9ZsffOZyC7CKbMVTHX3u-n5iuNyZQk0w@mail.gmail.com>
 <20231109000327.GE21616@pendragon.ideasonboard.com>
 <CAEZL83rcMocCohTi1ddAOyQ7BDK_AqR3-h33ZnHkWRMFO7cuwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEZL83rcMocCohTi1ddAOyQ7BDK_AqR3-h33ZnHkWRMFO7cuwg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esker,

On Thu, Nov 09, 2023 at 08:59:13AM +0800, Esker Wong wrote:
> Hi Laurent,
> 
> The use case here we want is actually the latency. We want to know
> what is the most accurate delay the user will feel when the camera
> capture the frame to the frame get displayed. So anytime earlier then
> the dqbuf should be an improvement here. It would help us know better
> of a camera quality.

If it's the latency you're after, wouldn't it be best to use the
timestamp produced by the camera ? That's the most accurate information.
It is expressed relative to the camera internal clock, but UVC transmits
information that enables conversion of the value to a system timestamp.

> On Thu, Nov 9, 2023 at 8:03 AM Laurent Pinchart wrote:
> > On Wed, Nov 08, 2023 at 11:46:40PM +0100, Ricardo Ribalda wrote:
> > > On Wed, 8 Nov 2023 at 21:32, <nicolas@ndufresne.ca> wrote:
> > > >
> > > > The fact that you interpret the time from FRAME_SYNC to DQBUF (well the
> > > > READ IO notification) as the actual latency is yours of course. It
> > > > assumes that the camera on the other end does not introduce other
> > >
> > > We want to use this signal to measure how much power is used since we
> > > start receiving the frame until we can use it.
> > > I agree with you that the latency between capture and dqbuf should be
> > > measured using the timestamp. That is not our use case here.
> > >
> > > > source of latency (or that these are negligible). You are also going to
> > > > introduce a lot of jitter, since it relies on when the OS decides to
> > > > wake up your process.
> > >
> > > We have measured a jitter of around 2.5 msec, which is acceptable for our needs.
> > >
> > > > I think my opinion resides in if you can accurately *enough* implement
> > > > what the spec says for FRAME_SYNC then do it, otherwise just don't lie.
> > >
> > > What the specs says is:
> > > ```
> > > Triggered immediately when the reception of a frame has begun
> > > ```
> > > In my opinion, that is true for usb devices, we are triggering it as
> > > soon as the transfer has started to the eyes of the driver. We cannot
> > > trigger earlier than that.
> > >
> > >
> > > > I think for ISO, "after the first chunk" i a small lie, but acceptable.
> > > > But for BULK, the way it was explained is that it will be always very
> > > > close to DQBUF time. and it should not emit FRAME_SYNC for this type of
> > > > UVC device. If it fits other events fine of course, I'm just making a
> > > > judgment on if its fits V4L2_EVENT_FRAME_SYNC or not.
> > >
> > > nit: I believe that you have swapped iso and bulk on this description
> >
> > I've confused the USB packet size and the UVC payload size. The latter
> > is typically much bigger for bulk devices than isoc devices, but the
> > former will be in similar order of magnitudes in a large number of
> > cases, but not all cases.
> >
> > The URB size is the result of the USB packet size and number of packets
> > per URB. The uvcvideo driver currently sets the number of packets per
> > URB to 32 at most (and lowers it if the frame size is small, or if not
> > enough memory can be allocated). This could be increased or made dynamic
> > in the future, as higher speeds typically benefit from larger URB sizes.
> > The packet size differs between bulk and isoc endpoints.
> >
> > For bulk, the packet size can be up to 512 bytes for USB 2.0 and 1024
> > bytes for USB 3.0, and the device can select a smaller size. The largest
> > URB size (again based on the current implementation of the uvcvideo
> > driver) is thus 32 KiB.
> >
> > For isochronous the situation is more complicated. The term "packet" as
> > used in the uvcvideo driver actually means all the data transferred in
> > one service interval, thus made of multiple isoc packets. It is heavily
> > dependent on the USB speed, and the device can advertise different
> > supported sizes (which translate directly to the reserved bandwidth for
> > the transfer), with the driver picking the smallest bandwidth large
> > enough for the data rate required by the resolution and frame rate. The
> > theoretical worst case is 1024 bytes per isoc packet * 16 isoc packets
> > per burst * 6 burst per interval * 32 "packets" per URB, equal to 3 MiB.
> >
> > Even with the largest URB size you have witnessed of ~1 MiB, we will end
> > up lying quite a bit if we consider the URB completion callback for the
> > first URB of the frame as indicating the start of reception.
> >
> > > > In term of accuracy, if timestamp was passed with the FRAME_SYNC event,
> > > > it would not matter how fast your process the event anymore and greatly
> > > > improve accuracy.
> > >
> > > +1 to that. If we could easily change the uAPI for FRAME_SYNC that
> > > should definitely be implemented.
> > >
> > > > > Not to mention that the UVC timestamping requires a bit of love.
> > > > >
> > > > > @Laurent Pinchart, @Kieran Bingham  any progress reviewing :P :
> > > > > https://patchwork.linuxtv.org/project/linux-media/list/?series=10083
> > > >
> > > > Thanks for working on this by the way, hope someone will find the time
> > > > to review this. The timestamps should in theory provide a jitter free
> > >
> > > It already has a couple of Reviewed-by stamped in.... ;)
> > >
> > > > measurement of the delay Esker is trying to measure, and if it wasn't
> > > > of bugs (and crazy complexity) it would in the worst case match the
> > > > transfer time.
> > >
> > > Sorry to repeat myself, but just to avoid the confusion: Esker needs
> > > to know how much power is used since we start receiving a frame until
> > > it is available for dqbuf, not de frame latency.
> >
> > As I think everybody is aware, the earliest notification you get on the
> > CPU side is the *end* of reception of the first URB, which can possibly
> > be significantly later than the start of reception of the frame.
> >
> > Based on what I understand, the goal is to measure the CPU power
> > consumption related to CPU processing of the frame. If that's the case,
> > there's good and bad news. The good news is that the CPU doesn't process
> > the frame at all until the URB has been received (if you were to measure
> > the power consumption of the USB host controller too, it would be a
> > different story), so the delay shouldn't be a problem. The bad news is
> > that I don't see how the information you're trying to get will help you,
> > as there's plenty of other things unrelated to the uvcvideo driver that
> > can take CPU time while a frame is being received. That may not be any
> > of my business, but from the point of view of the uvcvideo driver, I'm
> > less inclined to accept a possibly significant V4L2_EVENT_FRAME_SYNC lie
> > if the use case ends up making little sense :-)

-- 
Regards,

Laurent Pinchart
