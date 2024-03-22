Return-Path: <linux-kernel+bounces-111120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1A9886827
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2271E1F2387C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2CA171C9;
	Fri, 22 Mar 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RPyDmw9G"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA3171CD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095780; cv=none; b=WMHHYXQmHZlbJ2+9ovHvog0x1+qpRnzWbYXUi9bhhN7KKwZuPw32Z7ldtTGG1YD3zJlxTihftIa5XEmKbv52LcdJXEHDaSMQx43b17oH7pKGaCEwV9+ZEJkedgmcbedYZ5/WIgLmsjvhUbkrveyNH74pRcwk0oq7lBovUjUdvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095780; c=relaxed/simple;
	bh=fpCoiLmXxI9qiJhzsLseFGJE1mlYGa6QJuto7FOwQ7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xgqge1wy2IEaqg/c1RAb2Ey2pgtZ6fNhof9V9GkYsAU+9SCx2U7/my4J0AEIZ9Ty/1vfk0cUGLkNUEYJvu+dEm/C3sunikIViqp6NmWPSGhn474kidKbk2QryN15l3eecjklvnUeBia3WMHnAkDOcr9ZdfIOHO97zvTjV1SY0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RPyDmw9G; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6963cf14771so17181216d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711095777; x=1711700577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ob+YyW8fixoBQX9n6g1bpmXJDOp1r9Uolwp6GpqIv4=;
        b=RPyDmw9Gp88AANEc270UUeILYJKls/v1L3/wOvgB+hTwN/Pqh6AhV2ZZO1fLSh8ZCF
         xxPZIRT5Qa9kbKoZAYCHuPVNF98MYEpXpqegQy/P69lOrTplguamzhbecI+8DPrjHJZM
         bJ1YVlZzN+i4KjVQJEt9tf/udg2IT/mzOlu/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095777; x=1711700577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ob+YyW8fixoBQX9n6g1bpmXJDOp1r9Uolwp6GpqIv4=;
        b=uVmA3I15vECtrpZpwql/H++E+QuXqCg2IWBaBFJcwEasxlW7kRa7+dE8eWC5VJEeMv
         OgChVW43OyS82naQSQiFar5Sd8Gqqu5vbFEyrkDO/VN1jCDwqeRf7neSKG5QQXNYmr8V
         9/JmInzahxeVaemLZvzrpGNxacjgLs25utBXASwsRxLrF4gFXTBk75qE8c3dITYReKkO
         qBT+1GxRA9BwS6R5PBDWrS8tCqALc68K3Rx/fcNP4ntiKikD17RSgVf4x570LJzhfE8Q
         /sdUKIaYBFGA8mKtpFihq09K03FB6jb4VjYkkLN7iFaDKXex1O2QIDaA5XWjnBmKaIG1
         NoVA==
X-Forwarded-Encrypted: i=1; AJvYcCVFeHxxJzUvbqKEZ/+MJEUOJOwWD0udzltUcwbBi5aKucPAWTOWBYYK+NOzDR4TxgMhisMoamylFj2Wyvj5Tm8hYAfki4dVu1sZFx0T
X-Gm-Message-State: AOJu0Yyhg6PflOJiHmuAjvpRQkG9bhxrXIiLEjZ7Igc3QNMKr0Kd/aT6
	5vgb7Bg5DlPZIO1b4pVEW6QxvELbADcjffRjbTdz3vQTFPvBQfrwQn6Ld1QRVTHKzWMY6lRUOUI
	=
X-Google-Smtp-Source: AGHT+IHJ9eJyIyRs6S0bWP2J56Sr46KtFgcLpGL1FpiyNVxTT6XdELFfmaKMTOi0ItVZmbAigx87xw==
X-Received: by 2002:a05:6214:d4c:b0:690:e036:fcf1 with SMTP id 12-20020a0562140d4c00b00690e036fcf1mr1878456qvr.25.1711095777412;
        Fri, 22 Mar 2024 01:22:57 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id f12-20020a056214076c00b00690d3bf9ea0sm841806qvz.141.2024.03.22.01.22.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 01:22:56 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6962e6fbf60so18830036d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:22:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7wcJ59d8G+JvUH/epAorWG4CMWebioSHYfdpGjA8/ICoIyZVA+LT+xlSTASDeVKWXaLIEzy46svYvOMpj0pUhnk9yo6jUebN8CTK6
X-Received: by 2002:a05:6214:1c0c:b0:691:873a:7753 with SMTP id
 u12-20020a0562141c0c00b00691873a7753mr1427986qvc.38.1711095776052; Fri, 22
 Mar 2024 01:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-2-55a89f46f6be@chromium.org> <20240321232602.GB20938@pendragon.ideasonboard.com>
In-Reply-To: <20240321232602.GB20938@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Mar 2024 09:22:39 +0100
X-Gmail-Original-Message-ID: <CANiDSCt7Y4v3MUCoVyuzwLg6rq1=4MTUGtJ1+HkMMRY7sfjYjA@mail.gmail.com>
Message-ID: <CANiDSCt7Y4v3MUCoVyuzwLg6rq1=4MTUGtJ1+HkMMRY7sfjYjA@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] media: uvcvideo: Ignore empty TS packets
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

Hi, I added some minor modifications, hope that it is fine with you.

Thanks!!

On Fri, 22 Mar 2024 at 00:26, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Mar 15, 2023 at 02:30:13PM +0100, Ricardo Ribalda wrote:
> > Some SunplusIT cameras took a borderline interpretation of the UVC 1.5
> > standard, and fill the PTS and SCR fields with invalid data if the
> > package does not contain data.
> >
> > "STC must be captured when the first video data of a video frame is put
> > on the USB bus."
> >
> > Eg:
>
> "Some SunplusIT devices send, e.g.,"
>
> >
> > buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
> > buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
> > buffer: 0xa7755c00 len 000668 header:0x8c stc 73779dba sof 070c pts 7376d37a
>
> "while the UVC specification meant that the first two packets shouldn't
> have had the SCR bit set in the header."
>
> >
> > This borderline/buggy interpretation has been implemented in a variety
> > of devices, from directly SunplusIT and from other OEMs that rebrand
> > SunplusIT products. So quirking based on VID:PID will be problematic.
> >
> > All the affected modules have the following extension unit:
> > VideoControl Interface Descriptor:
> >   guidExtensionCode         {82066163-7050-ab49-b8cc-b3855e8d221d}
> >
> > But the vendor plans to use that GUID in the future and fix the bug,
> > this means that we should use heuristic to figure out the broken
> > packets.
>
> Because it would have been too easy otherwise of course :-)
>
> >
> > This patch takes care of this.
> >
> > lsusb of one of the affected cameras:
> >
> > Bus 001 Device 003: ID 1bcf:2a01 Sunplus Innovation Technology Inc.
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.01
> >   bDeviceClass          239 Miscellaneous Device
> >   bDeviceSubClass         2 ?
> >   bDeviceProtocol         1 Interface Association
> >   bMaxPacketSize0        64
> >   idVendor           0x1bcf Sunplus Innovation Technology Inc.
> >   idProduct          0x2a01
> >   bcdDevice            0.02
> >   iManufacturer           1 SunplusIT Inc
> >   iProduct                2 HanChen Wise Camera
> >   iSerial                 3 01.00.00
> >   bNumConfigurations      1
> >
> > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 4ff4ab4471fe..1f416c494acc 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -478,6 +478,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >       ktime_t time;
> >       u16 host_sof;
> >       u16 dev_sof;
> > +     u32 dev_stc;
> >
> >       switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
> >       case UVC_STREAM_PTS | UVC_STREAM_SCR:
> > @@ -526,6 +527,23 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >       if (dev_sof == stream->clock.last_sof)
> >               return;
> >
> > +     dev_stc = get_unaligned_le32(&data[header_size - 6]);
> > +
> > +     /*
> > +      * STC (Source Time Clock) is the clock used by the camera. The UVC 1.5
> > +      * standard states that it "must be captured when the first video data
> > +      * of a video frame is put on the USB bus".
> > +      * Most of the vendors, clear the `UVC_STREAM_SCR` bit when the data is
> > +      * not valid, other vendors always set the `UVC_STREAM_SCR` bit and
> > +      * expect that the driver only samples the stc if there is data on the
> > +      * packet.
> > +      * Ignore all the hardware timestamp information if there is no data
> > +      * and stc and sof are zero.
> > +      */
>
> I'd like to expand this a bit (partly to make sure I understand the
> issue correctly):
>
>         /*
>          * STC (Source Time Clock) is the clock used by the camera. The UVC 1.5
>          * standard states that it "must be captured when the first video data
>          * of a video frame is put on the USB bus". This is generally understood
>          * as requiring devices to clear the payload header's SCR bit before
>          * the first packet containing video data.
>          *
>          * Most vendors follow that interpretation, but some (namely SunplusIT)
namely SunplusIT on some devices
>          * always set the `UVC_STREAM_SCR` bit, fill the SCR field with 0's,
>          * and expect that the driver only processes the SCR if there is data in
>          * the packet.
>          *
>          * Ignore all the hardware timestamp information if we haven't received
>          * any data for this frame yet, the packet contains no data, and both
>          * STC and SOF are zero. This heuristics should be safe on compliant
>          * devices. This should be safe with compliant devices, as in the very
>          * unlikely case where a UVC 1.1 device would send timing information
>          * only before the first packet containing data, and both STC and SOF
>          * happen to be zero for a particular frame, we would only miss one
>          * clock sample and the clock recovery algorithm wouldn't suffer from
one clock sample from many
>          * this condition.
>          */
>
> Is this correct (and fine with you) ? If so,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > +     if (buf && buf->bytesused == 0 && len == header_size &&
> > +         dev_stc == 0 && dev_sof == 0)
> > +             return;
> > +
> >       stream->clock.last_sof = dev_sof;
> >
> >       host_sof = usb_get_current_frame_number(stream->dev->udev);
> > @@ -564,7 +582,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >       spin_lock_irqsave(&stream->clock.lock, flags);
> >
> >       sample = &stream->clock.samples[stream->clock.head];
> > -     sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
> > +     sample->dev_stc = dev_stc;
> >       sample->dev_sof = dev_sof;
> >       sample->host_sof = host_sof;
> >       sample->host_time = time;
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

