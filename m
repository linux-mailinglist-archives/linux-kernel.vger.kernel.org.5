Return-Path: <linux-kernel+bounces-117482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACD88ABDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E456300AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A79112CD84;
	Mon, 25 Mar 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hBhsBvN4"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12445025
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384683; cv=none; b=iNTRSTZGbS7uPq4vp4tKavIhpDy0j3UX3exTaK9KRyKJI12IE+HqVdztQ3+Mxq/t49Vrt3QW6ve7JTO3HYbNv/FClG45xUFerhE4wWo/P5L1KHtkjNps/AFJ9CYl7D0KhIXCQWe7uYp5UtrvPYXNZhIJIOCbRBRNvrtOBmWYUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384683; c=relaxed/simple;
	bh=mb4drqRfxZq4T3ftO8AwMnyk+5biU1dSHayjYQONSBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDgzCe0soHgW1n2pys+h8HUgk8/3NuWUz6gurTsL3iuKP9WH44Qmwybq1tCOZzEoV5CQhOHsS2bw6ffT2mcAsOwQ5j4TzmuOkH+kVQQzZFnSywLnMGYrSbBod57l0yib6fuu/Y/075ZJsE7V8xyjoXGOJNEtiHXgE0VNfHtGb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hBhsBvN4; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-695df25699fso40324946d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711384680; x=1711989480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKWDfYW3CtNpY4Yu6k3TKGJvrjBzgrTrwxBpvIufx6g=;
        b=hBhsBvN4FVqIXE/c+n/lm550kowc4XTPAvRpGBiPXxrOowGkrzS7aUIIaofNK3gaq1
         yv83e37Z6+MRo97+bM1+GZPTgdgIPNdRigopI0KcOsgi2iGG/rTA5dCmMjrVE0y1hiGq
         2TSTOWbjIPFEp7YvN/7OcvrP6E/IRS3v9+Bo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384680; x=1711989480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKWDfYW3CtNpY4Yu6k3TKGJvrjBzgrTrwxBpvIufx6g=;
        b=kRXdFY3Bf73jumTYpCfhGITox7DcmYrQXShdkM9jZHfN8/UG1W9KoFzqYXMr1JT5V2
         pJbr8P/kYQ67Jux04VHQAW0FyKMZuK5zkATnMoDzHNvIvRZrJLBJivZp7s8/8z0X3brx
         MFVgDcSY8WxFwToQSWBfoaISgxnsFm2vZz+GuKudBVIfpMMN1/vHpteDWSpOlOmohEgm
         5vvaj2dzndzz00YPBjEp9Vc4QOvJRYikCWOcWnq5i97YfoJDct2hXh3vbtBlwOczcDN2
         nkLmcHvjTYm5cLeiYlyq0ExzMoOM4y3ae8+IHyv+4zS5Kmvneo64eQ1sC5VhmuxpzWE4
         Z27A==
X-Forwarded-Encrypted: i=1; AJvYcCVgu7qwxIMaqbjH59fwrLcFdAHYkHgba4vvmxl4dcGOw0KVxbY5vKv6KFp69dGlvheFUW4cZSktfOvfLa6LY/6gahRK+dltcJMsyB7M
X-Gm-Message-State: AOJu0YzR4VpdWehyESs6MtJLTR4zNFn4Q8tuUfH/0kBK4SNcqg88/A9A
	//2heQxwT6apDrZYarGwII1Fx4ioDbmTDYdq72vuMJjULG3GAcU/DLnoWH5315TSJL2VeuPRicy
	Asw==
X-Google-Smtp-Source: AGHT+IEmfDrm0TOUKJEobD2jl3hcZFqIUxh/CE+8/Q0Tcgrq6oHWyclo3ik9hjiEBPIxNonOqEFMMg==
X-Received: by 2002:ad4:5c4e:0:b0:696:7ed9:9d8b with SMTP id a14-20020ad45c4e000000b006967ed99d8bmr8678966qva.2.1711384679929;
        Mon, 25 Mar 2024 09:37:59 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id jf8-20020a0562142a4800b006942dcac56asm4207890qvb.103.2024.03.25.09.37.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:37:59 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-696719f8dfcso19633976d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:37:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPBhk9w4H8VEgWDlfQZ8tSMvlpcI30+TwXA0LMnuB8T7ahjS+i+oLMUFcD1Holfkf+gTxTHP9D5boeoTuBOPgqgyte9O7OUbzGORG5
X-Received: by 2002:a05:6214:1d0e:b0:696:33e9:e0 with SMTP id
 e14-20020a0562141d0e00b0069633e900e0mr9952116qvd.35.1711384679037; Mon, 25
 Mar 2024 09:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122-guenter-mini-v5-0-15d8cd8ed74f@chromium.org>
 <20231122-guenter-mini-v5-1-15d8cd8ed74f@chromium.org> <e4b2fc02-977f-4eb6-be7a-a4493a5a3931@xs4all.nl>
In-Reply-To: <e4b2fc02-977f-4eb6-be7a-a4493a5a3931@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 17:37:43 +0100
X-Gmail-Original-Message-ID: <CANiDSCsP74bJJZcT8cKUWCOcTT1h3RiPiFKdYfFNQ-WRkBugEA@mail.gmail.com>
Message-ID: <CANiDSCsP74bJJZcT8cKUWCOcTT1h3RiPiFKdYfFNQ-WRkBugEA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] media: uvcvideo: Lock video streams and queues
 while unregistering
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Tomasz Figa <tfiga@chromium.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Hans

On Thu, 21 Mar 2024 at 16:47, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Hi Ricardo,
>
> On 22/11/2023 12:45 pm, Ricardo Ribalda wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> >
> > The call to uvc_disconnect() is not protected by any mutex.
> > This means it can and will be called while other accesses to the video
> > device are in progress. This can cause all kinds of race conditions,
> > including crashes such as the following.
> >
> > usb 1-4: USB disconnect, device number 3
> > BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 0 PID: 5633 Comm: V4L2CaptureThre Not tainted 4.19.113-08536-g5d29ca36db06 #1
> > Hardware name: GOOGLE Edgar, BIOS Google_Edgar.7287.167.156 03/25/2019
> > RIP: 0010:usb_ifnum_to_if+0x29/0x40
> > Code: <...>
> > RSP: 0018:ffffa46f42a47a80 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff904a396c9000
> > RDX: ffff904a39641320 RSI: 0000000000000001 RDI: 0000000000000000
> > RBP: ffffa46f42a47a80 R08: 0000000000000002 R09: 0000000000000000
> > R10: 0000000000009975 R11: 0000000000000009 R12: 0000000000000000
> > R13: ffff904a396b3800 R14: ffff904a39e88000 R15: 0000000000000000
> > FS: 00007f396448e700(0000) GS:ffff904a3ba00000(0000) knlGS:0000000000000000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 000000016cb46000 CR4: 00000000001006f0
> > Call Trace:
> >  usb_hcd_alloc_bandwidth+0x1ee/0x30f
> >  usb_set_interface+0x1a3/0x2b7
> >  uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
> >  uvc_video_start_streaming+0x91/0xdd [uvcvideo]
> >  uvc_start_streaming+0x28/0x5d [uvcvideo]
> >  vb2_start_streaming+0x61/0x143 [videobuf2_common]
> >  vb2_core_streamon+0xf7/0x10f [videobuf2_common]
> >  uvc_queue_streamon+0x2e/0x41 [uvcvideo]
> >  uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
> >  __video_do_ioctl+0x33d/0x42a
> >  video_usercopy+0x34e/0x5ff
> >  ? video_ioctl2+0x16/0x16
> >  v4l2_ioctl+0x46/0x53
> >  do_vfs_ioctl+0x50a/0x76f
> >  ksys_ioctl+0x58/0x83
> >  __x64_sys_ioctl+0x1a/0x1e
> >  do_syscall_64+0x54/0xde
> >
> > usb_set_interface() should not be called after the USB device has been
> > unregistered. However, in the above case the disconnect happened after
> > v4l2_ioctl() was called, but before the call to usb_ifnum_to_if().
> >
> > Acquire various mutexes in uvc_unregister_video() to fix the majority
> > (maybe all) of the observed race conditions.
> >
> > The uvc_device lock prevents races against suspend and resume calls
> > and the poll function.
> >
> > The uvc_streaming lock prevents races against stream related functions;
> > for the most part, those are ioctls. This lock also requires other
> > functions using this lock to check if a video device is still registered
> > after acquiring it. For example, it was observed that the video device
> > was already unregistered by the time the stream lock was acquired in
> > uvc_ioctl_streamon().
> >
> > The uvc_queue lock prevents races against queue functions, Most of
> > those are already protected by the uvc_streaming lock, but some
> > are called directly. This is done as added protection; an actual race
> > was not (yet) observed.
> >
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 08fcd2ffa727..ded2cb6ce14f 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1907,14 +1907,22 @@ static void uvc_unregister_video(struct uvc_device *dev)
> >  {
> >       struct uvc_streaming *stream;
> >
> > +     mutex_lock(&dev->lock);
> > +
> >       list_for_each_entry(stream, &dev->streams, list) {
> >               if (!video_is_registered(&stream->vdev))
> >                       continue;
> >
> > +             mutex_lock(&stream->mutex);
> > +             mutex_lock(&stream->queue.mutex);
> > +
> >               video_unregister_device(&stream->vdev);
> >               video_unregister_device(&stream->meta.vdev);
> >
> >               uvc_debugfs_cleanup_stream(stream);
> > +
> > +             mutex_unlock(&stream->queue.mutex);
> > +             mutex_unlock(&stream->mutex);
>
> Part of the problem here is that video_unregister_device does not stop streaming.
>
> For 'normal' drivers that leave most of the locking to the core framework and
> that use the standard vb2_fop_* and vb2_ioctl_* helpers, instead of calling
> video_unregister_device, they call vb2_video_unregister_device(). This will
> safely unregister the device and stop streaming at the same time.
>
> Since after the device is unregistered the only file operation that is accepted
> is close(), it will be impossible to restart streaming.
>
> In other words, this guarantees that when the disconnect function exits there
> is nothing streaming anymore.

I have tested this approach and it seems to work :)

I have updated and sent for review, and in the meantime I will
continue torturing my device to figure out if we are missing any other
race.

Thanks!

>
> This makes it much easier to deal with disconnects, and I think this should
> happen here as well. I wonder if this will obsolete patch 3/3 and perhaps
> 2/3.
>
> I don't think taking the queue.mutex is needed, especially if you stop
> streaming here.
>
> Regards,
>
>         Hans
>
> >       }
> >
> >       uvc_status_unregister(dev);
> > @@ -1925,6 +1933,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
> >       if (media_devnode_is_registered(dev->mdev.devnode))
> >               media_device_unregister(&dev->mdev);
> >  #endif
> > +     mutex_unlock(&dev->lock);
> >  }
> >
> >  int uvc_register_video_device(struct uvc_device *dev,
> >
>


-- 
Ricardo Ribalda

