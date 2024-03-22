Return-Path: <linux-kernel+bounces-111126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DA488683C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F208283C24
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3E1757D;
	Fri, 22 Mar 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KwAh6tz4"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16768830
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096396; cv=none; b=bcwl0DXbN7FYikG5RwJt1pyRyUp9tItiHJycivbGdD2Wd43Dxu9Cm6p8V4lwJq7gg1Zu7h9uXdgFPIL+KViZidDxX5xCnSwGnkCKLPuIeZcaFlwBs4S6o9bpxaN/bgUJrLYnbx4zJu2ea5Un6ZSUL7+YQPBs3FkB1l2ktZGShrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096396; c=relaxed/simple;
	bh=DMqtk3eEcJRBCUbrtHl8AhdATznh4eTtumELyvNBQ/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTCZAvjZFAOFnBq2q6n97vm1puS0xEoGsiz1aBjjsM3aW27GrkBcDI1U4ooam8WDvwRmH16B7GZ/TpTLUsVlO697Dl2doj6PArbvhBH7/OqWaC9rJmCJcM1/OJysKFH6ggguwnH8g3qIl5Zf3/pEAoKLWXTnT/vGr5UmyEvUXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KwAh6tz4; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-609f1f97864so20962937b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711096393; x=1711701193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eznPwTZk7ZAEffHpcAWZTr/ae6mBoD7RvlNvXt/B97o=;
        b=KwAh6tz4PCipzX1Gk1mm09km2zhqHrtRX+K3YSEzerCuj/MtVfyP95UeJ9tRFfAOQl
         lQSetUz2wQ2iMPcyap6EY/qdFHC1VOcLtNpvE7GPKfCwXXAOXH0ed1r/hkkyNuWv37D5
         Njb3bqSTJErIe8K44tslaJmml0gORkW+epjPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711096393; x=1711701193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eznPwTZk7ZAEffHpcAWZTr/ae6mBoD7RvlNvXt/B97o=;
        b=u4ny9YwowPm5GiPX99lIFdVd9foSA0yqlUxCO3Axa6Na4trINBFyvy8WervW1cNTG2
         FvyFweRzIDt0W990Z1LiroMp4+D+PLjTNIO9vfkM3dB6t1NrBH5vECUV2kXOMDwvEKX0
         LezUcsORGhOuMqqUtMCoxXOv0ELj6+wFcDqOTtFL9AXsxRFOeWfXFKK9rdfQqG6feCif
         Vt2I4XWlsTBaJgxVUlpvgkwWkEZlf7nr3abJwHF+xA6KztVuMkqXaNgvkXLUa9gTJ8hR
         scMK3rPr/Q513Xdi/v083rHS1jPjxfVdMVCOrdwXfvZbvC9nIm7V11DQ9HtwZqIx3QZg
         +RYw==
X-Forwarded-Encrypted: i=1; AJvYcCU6j0MqOWAAyKxRKfexOqmIiB1CCM/aJvO9x667d+rmXVw5FgF7p5Ddp254hcxGCojRqmeaT84z3JUJvoW5s7VaALTtWosXct6Y5h8C
X-Gm-Message-State: AOJu0YwF/KWrcznVaFkKUYyb6kGHYQODYXY3XeX24WZZ63eWs05W4JxU
	NHQ+fuoKDVmuQtNR2pgVXSIes9vAaSBbx/KndqvD7JEBeDc1M2jN0OIitWHFfistvkyYbzUa0bE
	=
X-Google-Smtp-Source: AGHT+IHINwdp7hQOvhwY3yMYw46a5HSs52jhojDBqs1n/ZQc8HjsIkDwkwUpZ8AogmZUkrBE71VwZA==
X-Received: by 2002:a81:5ec1:0:b0:60a:174f:b356 with SMTP id s184-20020a815ec1000000b0060a174fb356mr1820796ywb.3.1711096393210;
        Fri, 22 Mar 2024 01:33:13 -0700 (PDT)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id g2-20020a05620a218200b0078a0df3489esm592227qka.116.2024.03.22.01.33.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 01:33:12 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6962a97752eso14941256d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:33:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsT5Pw7urazpy9gxAN0dMghtmH+fnAEkWjg1mIkJs3n6qQd3Flczmroe9kDToPliVuIBRLsMxP/rqSprd6Vz/B/dX4iKciRjg8ExSe
X-Received: by 2002:a05:6214:2629:b0:68f:3c36:1b74 with SMTP id
 gv9-20020a056214262900b0068f3c361b74mr1581869qvb.41.1711096392048; Fri, 22
 Mar 2024 01:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-3-55a89f46f6be@chromium.org> <20240321234434.GC20938@pendragon.ideasonboard.com>
In-Reply-To: <20240321234434.GC20938@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Mar 2024 09:32:56 +0100
X-Gmail-Original-Message-ID: <CANiDSCs_dvKwRmws=DoN-YPaTzPeyJQLp0MCUxhRcK-R1T=YSA@mail.gmail.com>
Message-ID: <CANiDSCs_dvKwRmws=DoN-YPaTzPeyJQLp0MCUxhRcK-R1T=YSA@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] media: uvcvideo: Quirk for invalid dev_sof in
 Logitech C922
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Fri, 22 Mar 2024 at 00:44, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Mar 15, 2023 at 02:30:14PM +0100, Ricardo Ribalda wrote:
> > Logitech C922 internal SOF does not increases at a stable rate of 1kHz.
>
> The next thing you know they will redefine to value of pi to be 3.
>
> > This causes that the device_sof and the host_sof run at different rates,
> > breaking the clock domain conversion algorithm. Eg:
> >
> > 30 (6) [-] none 30 614400 B 21.245557 21.395214 34.133 fps ts mono/SoE
> > 31 (7) [-] none 31 614400 B 21.275327 21.427246 33.591 fps ts mono/SoE
> > 32 (0) [-] none 32 614400 B 21.304739 21.459256 34.000 fps ts mono/SoE
> > 33 (1) [-] none 33 614400 B 21.334324 21.495274 33.801 fps ts mono/SoE
> > * 34 (2) [-] none 34 614400 B 21.529237 21.527297 5.130 fps ts mono/SoE
> > * 35 (3) [-] none 35 614400 B 21.649416 21.559306 8.321 fps ts mono/SoE
> > 36 (4) [-] none 36 614400 B 21.678789 21.595320 34.045 fps ts mono/SoE
> > ...
> > 99 (3) [-] none 99 614400 B 23.542226 23.696352 33.541 fps ts mono/SoE
> > 100 (4) [-] none 100 614400 B 23.571578 23.728404 34.069 fps ts mono/SoE
> > 101 (5) [-] none 101 614400 B 23.601425 23.760420 33.504 fps ts mono/SoE
> > * 102 (6) [-] none 102 614400 B 23.798324 23.796428 5.079 fps ts mono/SoE
> > * 103 (7) [-] none 103 614400 B 23.916271 23.828450 8.478 fps ts mono/SoE
> > 104 (0) [-] none 104 614400 B 23.945720 23.860479 33.957 fps ts mono/SoE
> >
> > Instead of disabling completely the hardware timestamping for such
> > hardware we take the assumption that the packet handling jitter is
> > under 2ms and use the host_sof as dev_sof.
> >
> > We can think of the UVC hardware clock as a system with a coarse clock
> > (the SOF) and a fine clock (the PTS). The coarse clock can be replaced
> > with a clock on the same frequency, if the jitter of such clock is
> > smaller than its sampling rate. That way we can save some of the
> > precision of the fine clock.
> >
> > To probe this point we have run three experiments on the Logitech C922.
> > On that experiment we run the camera at 33fps and we analyse the
> > difference in msec between a frame and its predecessor. If we display
> > the histogram of that value, a thinner histogram will mean a better
> > meassurement. The results for:
> > - original hw timestamp: https://ibb.co/D1HJJ4x
> > - pure software timestamp: https://ibb.co/QC9MgVK
> > - modified hw timestamp: https://ibb.co/8s9dBdk
> >
> > This bug in the camera firmware has been confirmed by the vendor.
> >
> > lsusb -v
> >
> > Bus 001 Device 044: ID 046d:085c Logitech, Inc. C922 Pro Stream Webcam
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.00
> >   bDeviceClass          239 Miscellaneous Device
> >   bDeviceSubClass         2
> >   bDeviceProtocol         1 Interface Association
> >   bMaxPacketSize0        64
> >   idVendor           0x046d Logitech, Inc.
> >   idProduct          0x085c C922 Pro Stream Webcam
> >   bcdDevice            0.16
> >   iManufacturer           0
> >   iProduct                2 C922 Pro Stream Webcam
> >   iSerial                 1 80B912DF
> >   bNumConfigurations      1
> >
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
> >  drivers/media/usb/uvc/uvc_video.c  | 8 ++++++++
> >  drivers/media/usb/uvc/uvcvideo.h   | 1 +
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 7aefa76a42b3..678a5736c9df 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2549,6 +2549,15 @@ static const struct usb_device_id uvc_ids[] = {
> >         .bInterfaceSubClass   = 1,
> >         .bInterfaceProtocol   = 0,
> >         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
> > +     /* Logitech HD Pro Webcam C922 */
> > +     { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> > +                             | USB_DEVICE_ID_MATCH_INT_INFO,
> > +       .idVendor             = 0x046d,
> > +       .idProduct            = 0x085c,
> > +       .bInterfaceClass      = USB_CLASS_VIDEO,
> > +       .bInterfaceSubClass   = 1,
> > +       .bInterfaceProtocol   = 0,
> > +       .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_INVALID_DEVICE_SOF) },
> >       /* Chicony CNF7129 (Asus EEE 100HE) */
> >       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 1f416c494acc..4d566edb73e7 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -547,6 +547,14 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >       stream->clock.last_sof = dev_sof;
> >
> >       host_sof = usb_get_current_frame_number(stream->dev->udev);
> > +
> > +     /*
> > +      * On some devices, like the Logitech C922, the device SOF does not run
> > +      * at a stable rate of 1kHz. For those devices use the host SOF instead.
>
> I'm still not very convinced, as without a formal proof I think there's
> some luck involved, and it may break later. This being said, given that
> this is gated by a quirk, it won't impact other devices, and we can deal
> with regressions when they happen. Could we record it here:
>
>          * On some devices, like the Logitech C922, the device SOF does not run
>          * at a stable rate of 1kHz. For those devices use the host SOF instead.
>          * This improves the timestamp precision in the tests performed so far,
>          * even if the exact reason hasn't been fully determined.
>
> or something along those lines ?
How does this sound:


        /*
         * On some devices, like the Logitech C922, the device SOF does not run
         * at a stable rate of 1kHz. For those devices use the host SOF instead.
+        * In the tests performed so far, this improves the timestamp precision.
+        * This is probably explained by a small packet handling jitter from the
+        * host, but the exact reason hasn't been fully determined.
         */

>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > +      */
> > +     if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
> > +             dev_sof = host_sof;
> > +
> >       time = uvc_video_get_time();
> >
> >       /*
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 9a596c8d894a..07b2fdb80adf 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -73,6 +73,7 @@
> >  #define UVC_QUIRK_FORCE_Y8           0x00000800
> >  #define UVC_QUIRK_FORCE_BPP          0x00001000
> >  #define UVC_QUIRK_WAKE_AUTOSUSPEND   0x00002000
> > +#define UVC_QUIRK_INVALID_DEVICE_SOF 0x00004000
> >
> >  /* Format flags */
> >  #define UVC_FMT_FLAG_COMPRESSED              0x00000001
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

