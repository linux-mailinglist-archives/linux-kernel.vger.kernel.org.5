Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF03C7F498B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbjKVO7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344072AbjKVO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:59:33 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B195892
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:59:27 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7c43d42e2ceso160544241.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700665166; x=1701269966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2VncLCBHyIe1i2YTHZ6g0rQXYsO0zdfGE67kCLk906U=;
        b=WORlM01eoz9RTvPBZ2xsSgBKkJQ1yiNJSaoR+w7ugW45Y6n7tVZmQUiPvS25rNQS/3
         9Bd8owB6D0qjzcIsVJjP6M21H765jnA7SYQ519gS+yOxlp9gNG19YP5yweQ1k4MEM/Xo
         QQ15s1X0KQKyWJaPjZeS5aMeogJU8ymzXD8so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665166; x=1701269966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VncLCBHyIe1i2YTHZ6g0rQXYsO0zdfGE67kCLk906U=;
        b=kXjwn/72fAYqMdINduCghTovji9kkDtj/nMY3BrzwAGMK7YnASyHSzFeQPwYo0UMwi
         DnU6RS1gJRXFnFKRc5I09IqLFFDEtoomkghQow5LGN0/NcitbFuJ3yy7FjM3N05KKNnf
         kKs8yjfraO5ZkkADFv9WVpUrd2si0+5v+3IAaTbfgAmIBoXZRjmujCVxNtFaULVOrRMH
         hvaMSyU/1tUlRuIb8ah0trzMtJWoT6NY7AUgvil9aweh/vJz0d+mS5n7auoruWZSugnv
         bDeSKbO+X+G5Lt+UFrINIxqm3R15JhWJX2QLJdwb15ElSeBGE7tfZMsQX4C1WBa3IHCS
         RfpQ==
X-Gm-Message-State: AOJu0Yy7elzWKNhlWF9D6g6RK0VTZ9Vh9SUW98CAnqo/oVos4rLroJbB
        gd7UXv6PwRBxImqu8mbHPA+05tKAy5mnFAilFa+JyA==
X-Google-Smtp-Source: AGHT+IFRoQJPGJ77r8Zn0nHpixmf7mEXMCQ8ZMMx1GMtsRfWS89vNqu0Ad9RRV1htea0P0VAQnlAKA==
X-Received: by 2002:a1f:4b87:0:b0:495:bd61:a184 with SMTP id y129-20020a1f4b87000000b00495bd61a184mr1946282vka.2.1700665166029;
        Wed, 22 Nov 2023 06:59:26 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id k18-20020ab059d2000000b007bafd9ad4a1sm1778684uad.11.2023.11.22.06.59.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 06:59:25 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7bae0c07007so1609824241.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:59:25 -0800 (PST)
X-Received: by 2002:a67:f248:0:b0:460:f36e:beee with SMTP id
 y8-20020a67f248000000b00460f36ebeeemr2002245vsm.30.1700665164834; Wed, 22 Nov
 2023 06:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20231122-guenter-mini-v5-0-15d8cd8ed74f@chromium.org>
 <20231122-guenter-mini-v5-3-15d8cd8ed74f@chromium.org> <20231122133330.GE3909@pendragon.ideasonboard.com>
In-Reply-To: <20231122133330.GE3909@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 15:59:10 +0100
X-Gmail-Original-Message-ID: <CANiDSCunxALoBJg-u_s=A1Zi-NF3SaNRFhv3=2jTx0oeAPrCZw@mail.gmail.com>
Message-ID: <CANiDSCunxALoBJg-u_s=A1Zi-NF3SaNRFhv3=2jTx0oeAPrCZw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] media: uvcvideo: Do not use usb_* functions after .disconnect
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Wed, 22 Nov 2023 at 14:33, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Nov 22, 2023 at 11:45:49AM +0000, Ricardo Ribalda wrote:
> > usb drivers should not call to any I/O function after the
> > .disconnect() callback has been triggered.
> > https://www.kernel.org/doc/html/latest/driver-api/usb/callbacks.html#the-disconnect-callback
> >
> > If an application is receiving frames form a camera and the device is
> > disconnected: the device will call close() after the usb .disconnect()
> > callback has been called. The streamoff path will call usb_set_interface
> > or usb_clear_halt, which is not allowed.
> >
> > This patch only solves the calls to close() *after* .disconnect() is
> > being called.
> >
> > Trace:
> > [ 1065.389723] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> > [ 1065.390160] drivers/media/usb/uvc/uvc_driver.c:2264 uvc_disconnect exit
> > [ 1065.433956] drivers/media/usb/uvc/uvc_v4l2.c:659 uvc_v4l2_release enter
> > [ 1065.433973] drivers/media/usb/uvc/uvc_video.c:2274 uvc_video_stop_streaming enter
> > [ 1065.434560] drivers/media/usb/uvc/uvc_video.c:2285 uvc_video_stop_streaming exit
> > [ 1065.435154] drivers/media/usb/uvc/uvc_v4l2.c:680 uvc_v4l2_release exit
> > [ 1065.435188] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c |  2 ++
> >  drivers/media/usb/uvc/uvc_video.c  | 45 ++++++++++++++++++++++++--------------
> >  drivers/media/usb/uvc/uvcvideo.h   |  2 ++
> >  3 files changed, 32 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index d5dbf2644272..d78640d422f4 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2266,6 +2266,8 @@ static void uvc_disconnect(struct usb_interface *intf)
> >               return;
> >
> >       uvc_unregister_video(dev);
> > +     /* Barrier needed to pair with uvc_video_stop_streaming(). */
> > +     smp_store_release(&dev->disconnected, true);
>
> I can't think this would be such a hot path that we really need barriers
> in the driver.

Using the same variable from two contexts without any sync feels weird.

Your concern is that there will be a big penalty by using the
barriers? This is only used in stop_streaming and the shutdown path.

Regards!

>
> >       kref_put(&dev->ref, uvc_delete);
> >  }
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 28dde08ec6c5..f5ef375088de 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -2243,28 +2243,39 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
> >       return ret;
> >  }
> >
> > -void uvc_video_stop_streaming(struct uvc_streaming *stream)
> > +static void uvc_video_halt(struct uvc_streaming *stream)
> >  {
> > -     uvc_video_stop_transfer(stream, 1);
> > +     unsigned int epnum;
> > +     unsigned int pipe;
> > +     unsigned int dir;
> >
> >       if (stream->intf->num_altsetting > 1) {
> >               usb_set_interface(stream->dev->udev, stream->intfnum, 0);
> > -     } else {
> > -             /*
> > -              * UVC doesn't specify how to inform a bulk-based device
> > -              * when the video stream is stopped. Windows sends a
> > -              * CLEAR_FEATURE(HALT) request to the video streaming
> > -              * bulk endpoint, mimic the same behaviour.
> > -              */
> > -             unsigned int epnum = stream->header.bEndpointAddress
> > -                                & USB_ENDPOINT_NUMBER_MASK;
> > -             unsigned int dir = stream->header.bEndpointAddress
> > -                              & USB_ENDPOINT_DIR_MASK;
> > -             unsigned int pipe;
> > -
> > -             pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> > -             usb_clear_halt(stream->dev->udev, pipe);
> > +             return;
> >       }
> >
> > +     /*
> > +      * UVC doesn't specify how to inform a bulk-based device
> > +      * when the video stream is stopped. Windows sends a
> > +      * CLEAR_FEATURE(HALT) request to the video streaming
> > +      * bulk endpoint, mimic the same behaviour.
> > +      */
> > +     epnum = stream->header.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
> > +     dir = stream->header.bEndpointAddress & USB_ENDPOINT_DIR_MASK;
> > +     pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> > +     usb_clear_halt(stream->dev->udev, pipe);
> > +}
> > +
> > +void uvc_video_stop_streaming(struct uvc_streaming *stream)
> > +{
> > +     uvc_video_stop_transfer(stream, 1);
> > +
> > +     /*
> > +      * Barrier needed to pair with uvc_disconnect().
> > +      * We cannot call usb_* functions on a disconnected USB device.
> > +      */
> > +     if (!smp_load_acquire(&stream->dev->disconnected))
> > +             uvc_video_halt(stream);
> > +
> >       uvc_video_clock_cleanup(stream);
> >  }
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index ba8f8c1f2c83..5b1a3643de05 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -559,6 +559,8 @@ struct uvc_device {
> >       unsigned int users;
> >       atomic_t nmappings;
> >
> > +     bool disconnected;
> > +
> >       /* Video control interface */
> >  #ifdef CONFIG_MEDIA_CONTROLLER
> >       struct media_device mdev;
> >
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda
