Return-Path: <linux-kernel+bounces-111598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF73886E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67E1285732
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EFC47A6B;
	Fri, 22 Mar 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hkqv0UQs"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1147A48;
	Fri, 22 Mar 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117150; cv=none; b=sSrJmgiLTGUTxY+JT4jxGF6j0l7YthvuN+pwIf7mpHawpDK0X6WRekuWS7fCHqYbU/MqJklyoYLRsWmwNrNIJ1wiFxh4wYSIw3gKb/bl38U7pAhTCm0EGvrp5CDuU8UY/fYchA/6/a3PfWGRg/mzqK4iipoltGqKgkNT+vl692o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117150; c=relaxed/simple;
	bh=PTURMPFQn7attYISZHemSwcitlPK027nPcC5wSNohQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuHIafWfXINA6oW2nWlSW3CF88zS0WgUrFoyowLrMwjWbGCATRfMBQZ71A7fEUrtWT4E8hDYFoKnXSbVdDVcP79PNa1tSLEZn9rFcFq3uGdGoUKgKfAWfyZkrR4cE6XOvgKi0NQHumoj+/IX/xC5IwsydRyewsTAWCloU+z7lLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hkqv0UQs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B70982A;
	Fri, 22 Mar 2024 15:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711117117;
	bh=PTURMPFQn7attYISZHemSwcitlPK027nPcC5wSNohQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkqv0UQsW55rGrAnJqN/5DJBlIz6UdQ6tiTQg7WU6NTxWYHTA94KwAZu8tIAo9KWk
	 cqdT/bffSjC33ZDvOQsbshltlp1PD2401X5foSfKC1tzNZcm3xUyJyW+Y2ukTC85lF
	 ef4qQN4BFSg5qqzl8S06n8Ayh0LVb4Prj6i4ePWI=
Date: Fri, 22 Mar 2024 16:19:02 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Tomasz Figa <tfiga@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sean Paul <seanpaul@chromium.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v5 3/3] media: uvcvideo: Do not use usb_* functions after
 .disconnect
Message-ID: <20240322141902.GV18799@pendragon.ideasonboard.com>
References: <20231122-guenter-mini-v5-0-15d8cd8ed74f@chromium.org>
 <20231122-guenter-mini-v5-3-15d8cd8ed74f@chromium.org>
 <20231122133330.GE3909@pendragon.ideasonboard.com>
 <CANiDSCunxALoBJg-u_s=A1Zi-NF3SaNRFhv3=2jTx0oeAPrCZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCunxALoBJg-u_s=A1Zi-NF3SaNRFhv3=2jTx0oeAPrCZw@mail.gmail.com>

Hi Ricardo,

On Wed, Nov 22, 2023 at 03:59:10PM +0100, Ricardo Ribalda wrote:
> On Wed, 22 Nov 2023 at 14:33, Laurent Pinchart wrote:
> > On Wed, Nov 22, 2023 at 11:45:49AM +0000, Ricardo Ribalda wrote:
> > > usb drivers should not call to any I/O function after the
> > > .disconnect() callback has been triggered.
> > > https://www.kernel.org/doc/html/latest/driver-api/usb/callbacks.html#the-disconnect-callback
> > >
> > > If an application is receiving frames form a camera and the device is
> > > disconnected: the device will call close() after the usb .disconnect()
> > > callback has been called. The streamoff path will call usb_set_interface
> > > or usb_clear_halt, which is not allowed.
> > >
> > > This patch only solves the calls to close() *after* .disconnect() is
> > > being called.
> > >
> > > Trace:
> > > [ 1065.389723] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> > > [ 1065.390160] drivers/media/usb/uvc/uvc_driver.c:2264 uvc_disconnect exit
> > > [ 1065.433956] drivers/media/usb/uvc/uvc_v4l2.c:659 uvc_v4l2_release enter
> > > [ 1065.433973] drivers/media/usb/uvc/uvc_video.c:2274 uvc_video_stop_streaming enter
> > > [ 1065.434560] drivers/media/usb/uvc/uvc_video.c:2285 uvc_video_stop_streaming exit
> > > [ 1065.435154] drivers/media/usb/uvc/uvc_v4l2.c:680 uvc_v4l2_release exit
> > > [ 1065.435188] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_driver.c |  2 ++
> > >  drivers/media/usb/uvc/uvc_video.c  | 45 ++++++++++++++++++++++++--------------
> > >  drivers/media/usb/uvc/uvcvideo.h   |  2 ++
> > >  3 files changed, 32 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > index d5dbf2644272..d78640d422f4 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -2266,6 +2266,8 @@ static void uvc_disconnect(struct usb_interface *intf)
> > >               return;
> > >
> > >       uvc_unregister_video(dev);
> > > +     /* Barrier needed to pair with uvc_video_stop_streaming(). */
> > > +     smp_store_release(&dev->disconnected, true);
> >
> > I can't think this would be such a hot path that we really need barriers
> > in the driver.
> 
> Using the same variable from two contexts without any sync feels weird.
> 
> Your concern is that there will be a big penalty by using the
> barriers? This is only used in stop_streaming and the shutdown path.

What I meant is that lockless concurrency is much harder to get right
than locked concurrency. Unless there's an important reason not to use
lock (which would I think need to be related to performance, and I don't
see that being an issue here), I think using locks will be less
error-prone and more maintainable. That's the KISS approach to
concurrency (even if it doesn't directly address lockless concurrency, I
like the approach advocated by Sima in
https://blog.ffwll.ch/2022/07/locking-engineering.html).

> > >       kref_put(&dev->ref, uvc_delete);
> > >  }
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > index 28dde08ec6c5..f5ef375088de 100644
> > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > @@ -2243,28 +2243,39 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
> > >       return ret;
> > >  }
> > >
> > > -void uvc_video_stop_streaming(struct uvc_streaming *stream)
> > > +static void uvc_video_halt(struct uvc_streaming *stream)
> > >  {
> > > -     uvc_video_stop_transfer(stream, 1);
> > > +     unsigned int epnum;
> > > +     unsigned int pipe;
> > > +     unsigned int dir;
> > >
> > >       if (stream->intf->num_altsetting > 1) {
> > >               usb_set_interface(stream->dev->udev, stream->intfnum, 0);
> > > -     } else {
> > > -             /*
> > > -              * UVC doesn't specify how to inform a bulk-based device
> > > -              * when the video stream is stopped. Windows sends a
> > > -              * CLEAR_FEATURE(HALT) request to the video streaming
> > > -              * bulk endpoint, mimic the same behaviour.
> > > -              */
> > > -             unsigned int epnum = stream->header.bEndpointAddress
> > > -                                & USB_ENDPOINT_NUMBER_MASK;
> > > -             unsigned int dir = stream->header.bEndpointAddress
> > > -                              & USB_ENDPOINT_DIR_MASK;
> > > -             unsigned int pipe;
> > > -
> > > -             pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> > > -             usb_clear_halt(stream->dev->udev, pipe);
> > > +             return;
> > >       }
> > >
> > > +     /*
> > > +      * UVC doesn't specify how to inform a bulk-based device
> > > +      * when the video stream is stopped. Windows sends a
> > > +      * CLEAR_FEATURE(HALT) request to the video streaming
> > > +      * bulk endpoint, mimic the same behaviour.
> > > +      */
> > > +     epnum = stream->header.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
> > > +     dir = stream->header.bEndpointAddress & USB_ENDPOINT_DIR_MASK;
> > > +     pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> > > +     usb_clear_halt(stream->dev->udev, pipe);
> > > +}
> > > +
> > > +void uvc_video_stop_streaming(struct uvc_streaming *stream)
> > > +{
> > > +     uvc_video_stop_transfer(stream, 1);
> > > +
> > > +     /*
> > > +      * Barrier needed to pair with uvc_disconnect().
> > > +      * We cannot call usb_* functions on a disconnected USB device.
> > > +      */
> > > +     if (!smp_load_acquire(&stream->dev->disconnected))
> > > +             uvc_video_halt(stream);
> > > +
> > >       uvc_video_clock_cleanup(stream);
> > >  }
> > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > index ba8f8c1f2c83..5b1a3643de05 100644
> > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > @@ -559,6 +559,8 @@ struct uvc_device {
> > >       unsigned int users;
> > >       atomic_t nmappings;
> > >
> > > +     bool disconnected;
> > > +
> > >       /* Video control interface */
> > >  #ifdef CONFIG_MEDIA_CONTROLLER
> > >       struct media_device mdev;
> > >

-- 
Regards,

Laurent Pinchart

