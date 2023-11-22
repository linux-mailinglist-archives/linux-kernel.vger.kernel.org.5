Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E37F44F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbjKVLft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKVLfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:35:47 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C98019E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:35:43 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67131800219so25190636d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700652942; x=1701257742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nKCzP1gjVynV6gUUEtVMbrveg7//HaaaERWD1+hGAUY=;
        b=ZnNeRoGTifWY7MKd+UJJa+JsRAvImissfVNRf7XPE89j0x2JSwb9FATo/ccAVhJuh1
         tR0t2fAG+cF70Lv7OpoGErLmM0Nk6EDerKTt5bXwpmvp2EBAIcOdiv8qSLzlUy62taWn
         nWcp+KWsiJsnezi+17Nsfa9cWpkDYDgCAGNPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700652942; x=1701257742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKCzP1gjVynV6gUUEtVMbrveg7//HaaaERWD1+hGAUY=;
        b=uyM5dRZ5YY/gQYEvksVqpn+eFRTEGIBOYoSeVIuYn78grki/Jmjy4D858T53lFVEPn
         ysyBp5glh/MVn4QN0NCvQPIfPSSe8WPmI7OwkLG6tqKzmyMFxmxsDl2DBUmLZchHxphR
         MhprV0OL8895UzXpmRUDquZn/yBZzq3FF1GxecF+WsFJhiWlBCj0gxwIANfrToe70350
         dFHkaTByEcHGsdCmZL5GA8r4LDCudlhkRaIj2qfWEaVEpTStceZvPtnFUXM35Oy7bTGr
         f9qERtXkSZouqeQD+RwXHAAEHOE1jr+6VTZgLmzXM0jdpx+vkuEZOqFl1pRC9b4y2syW
         73pQ==
X-Gm-Message-State: AOJu0Yz8J1GBKcsw+e6HBeuq3+ZB95gHXMV74hd7KPyfr8qtl7poIhDv
        AbmCkS6gY97MySgdeD07URC3fZPcpEjbB9E/95Gc8w==
X-Google-Smtp-Source: AGHT+IEvuZt6fQrp596HXDsPdiMJarKNFRynPDVurkjVgkkTJ2nXLrZfqrYr2FAetCtlmXs8hFv70w==
X-Received: by 2002:a0c:cd0a:0:b0:66d:949d:717e with SMTP id b10-20020a0ccd0a000000b0066d949d717emr1781624qvm.42.1700652942372;
        Wed, 22 Nov 2023 03:35:42 -0800 (PST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id z1-20020a0cfec1000000b00677f40b564esm4694357qvs.117.2023.11.22.03.35.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 03:35:41 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-41f155c862bso40098261cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:35:41 -0800 (PST)
X-Received: by 2002:a05:6214:27ed:b0:679:f232:b938 with SMTP id
 jt13-20020a05621427ed00b00679f232b938mr2365229qvb.8.1700652941316; Wed, 22
 Nov 2023 03:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-2-d8a5eae2312b@chromium.org> <ZV3XDtUKJPuGLhw9@valkosipuli.retiisi.eu>
 <CANiDSCuXXD_GWadSJo43zxscGAOPzxhODK=TKixn0OPn7z_tCw@mail.gmail.com> <ZV3gHn8CuK_JJZbu@valkosipuli.retiisi.eu>
In-Reply-To: <ZV3gHn8CuK_JJZbu@valkosipuli.retiisi.eu>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 12:35:27 +0100
X-Gmail-Original-Message-ID: <CANiDSCsoJR+eaj=7cxrZ0EWiBT7sWQSSqRcB-HdRvhbKmD26cA@mail.gmail.com>
Message-ID: <CANiDSCsoJR+eaj=7cxrZ0EWiBT7sWQSSqRcB-HdRvhbKmD26cA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Do not halt the device after disconnect
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, 22 Nov 2023 at 12:04, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Ricardo,
>
> On Wed, Nov 22, 2023 at 11:32:16AM +0100, Ricardo Ribalda wrote:
> > Hi Sakari
> >
> > On Wed, 22 Nov 2023 at 11:25, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > Thank you for the patch.
> > >
> > > On Tue, Nov 21, 2023 at 07:53:49PM +0000, Ricardo Ribalda wrote:
> > > > usb drivers should not call to any usb_() function after the
> > > > .disconnect() callback has been triggered.
> > > >
> > > > If the camera is streaming, the uvc driver will call usb_set_interface or
> > > > usb_clear_halt once the device is being released. Let's fix this issue.
> > > >
> > > > This is probably not the only driver affected with this kind of bug, but
> > > > until there is a better way to do it in the core this is the way to
> > > > solve this issue.
> > > >
> > > > When/if a different mechanism is implemented in the core to solve the
> > > > lifetime of devices we will adopt it in uvc.
> > > >
> > > > Trace:
> > > > [ 1065.389723] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> > > > [ 1065.390160] drivers/media/usb/uvc/uvc_driver.c:2264 uvc_disconnect exit
> > > > [ 1065.433956] drivers/media/usb/uvc/uvc_v4l2.c:659 uvc_v4l2_release enter
> > > > [ 1065.433973] drivers/media/usb/uvc/uvc_video.c:2274 uvc_video_stop_streaming enter
> > > > [ 1065.434560] drivers/media/usb/uvc/uvc_video.c:2285 uvc_video_stop_streaming exit
> > > > [ 1065.435154] drivers/media/usb/uvc/uvc_v4l2.c:680 uvc_v4l2_release exit
> > > > [ 1065.435188] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_driver.c |  2 ++
> > > >  drivers/media/usb/uvc/uvc_video.c  | 45 ++++++++++++++++++++++++--------------
> > > >  drivers/media/usb/uvc/uvcvideo.h   |  2 ++
> > > >  3 files changed, 32 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > index 08fcd2ffa727..413c32867617 100644
> > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > @@ -2257,6 +2257,8 @@ static void uvc_disconnect(struct usb_interface *intf)
> > > >               return;
> > > >
> > > >       uvc_unregister_video(dev);
> > > > +     /* Barrier needed to synchronize with uvc_video_stop_streaming(). */
> > > > +     smp_store_release(&dev->disconnected, true);
> > > >       kref_put(&dev->ref, uvc_delete);
> > > >  }
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > index 28dde08ec6c5..032b44e45b22 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -2243,28 +2243,39 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
> > > >       return ret;
> > > >  }
> > > >
> > > > -void uvc_video_stop_streaming(struct uvc_streaming *stream)
> > > > +static void uvc_video_halt(struct uvc_streaming *stream)
> > > >  {
> > > > -     uvc_video_stop_transfer(stream, 1);
> > > > +     unsigned int epnum;
> > > > +     unsigned int pipe;
> > > > +     unsigned int dir;
> > > >
> > > >       if (stream->intf->num_altsetting > 1) {
> > >
> > > Doesn't this imply the device is using isochronous mode?
> >
> > I haven't changed the behaviour for halt, it is just that git diff is
> > being a bit too creative here:
> >
> > Basically it is doing:
> >
> > void video_halt() {
> >    if (is_isoc()) {
> >      usb_set_interface(stream->dev->udev, stream->intfnum, 0);
> >      return;
> >    }
> >    usb_clear_halt();
> > }
> >
> > instead of the old:
> >
> > void video_halt() {
> >    if (is_isoc()) {
> >      usb_set_interface(stream->dev->udev, stream->intfnum, 0);
> >    }  else {
> >       usb_clear_halt();
> >    }
> > }
> >
> > Thanks!
>
> Oops. I missed the removal of the else branch altogether while reading the
> patch.
>
> Shouldn't you also ensure the disconnect callback won't return until the
> streaming has been stopped here?

This patch is just for calls after .disconnect. It will not protect
for concurrent calls.

I have sent a v4 making this explicit. We still need:

media: uvcvideo: Lock video streams and queues while unregistering

or similar.

Thanks!

>
> > >
> > > >               usb_set_interface(stream->dev->udev, stream->intfnum, 0);
> > > > -     } else {
> > > > -             /*
> > > > -              * UVC doesn't specify how to inform a bulk-based device
> > > > -              * when the video stream is stopped. Windows sends a
> > > > -              * CLEAR_FEATURE(HALT) request to the video streaming
> > > > -              * bulk endpoint, mimic the same behaviour.
> > > > -              */
> > > > -             unsigned int epnum = stream->header.bEndpointAddress
> > > > -                                & USB_ENDPOINT_NUMBER_MASK;
> > > > -             unsigned int dir = stream->header.bEndpointAddress
> > > > -                              & USB_ENDPOINT_DIR_MASK;
> > > > -             unsigned int pipe;
> > > > -
> > > > -             pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> > > > -             usb_clear_halt(stream->dev->udev, pipe);
> > > > +             return;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * UVC doesn't specify how to inform a bulk-based device
> > >
> > > Then this comment doesn't look right. What about the code? This isn't
> > > mentioned in the commit message either.
> > >
> > > > +      * when the video stream is stopped. Windows sends a
> > > > +      * CLEAR_FEATURE(HALT) request to the video streaming
> > > > +      * bulk endpoint, mimic the same behaviour.
> > > > +      */
> > > > +     epnum = stream->header.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
> > > > +     dir = stream->header.bEndpointAddress & USB_ENDPOINT_DIR_MASK;
> > > > +     pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> > > > +     usb_clear_halt(stream->dev->udev, pipe);
> > > > +}
> > > > +
> > > > +void uvc_video_stop_streaming(struct uvc_streaming *stream)
> > > > +{
> > > > +     uvc_video_stop_transfer(stream, 1);
> > > > +
> > > > +     /*
> > > > +      * Barrier needed to synchronize with uvc_disconnect().
> > > > +      * We cannot call usb_* functions on a disconnected USB device.
> > > > +      */
> > > > +     if (!smp_load_acquire(&stream->dev->disconnected))
> > > > +             uvc_video_halt(stream);
> > > > +
> > > >       uvc_video_clock_cleanup(stream);
> > > >  }
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index 6fb0a78b1b00..4318ce8e31db 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -559,6 +559,8 @@ struct uvc_device {
> > > >       unsigned int users;
> > > >       atomic_t nmappings;
> > > >
> > > > +     bool disconnected;
> > > > +
> > > >       /* Video control interface */
> > > >  #ifdef CONFIG_MEDIA_CONTROLLER
> > > >       struct media_device mdev;
>
> --
> Kind regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda
