Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC057F4797
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344109AbjKVNTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344098AbjKVNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:19:33 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365B01A5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:19:29 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cbbe2cba33so16136177b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700659168; x=1701263968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vB3h17ZiZ1W4dA7P94tMnhpktj3v+3WDCq3z7CXQplU=;
        b=Um7ABIw75/7Zu3kE8hojnBlSlnTXIKIykW86iovazp6BwkDpkOUMOSgtpbKeVoGkdV
         Ywz8rSaTv22fikUJyychvl9sDWuDsMmgPgxDvi5QpJ8rbw4CVlKJGnPQF5OkSrsBE+iW
         DJuAr8NfdV6SwJwogoYlQwtbTR+sZP5eheq2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700659168; x=1701263968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vB3h17ZiZ1W4dA7P94tMnhpktj3v+3WDCq3z7CXQplU=;
        b=koFw9CJVo1L1HbLHtxAkTYCqpzulbJH2sKQILjfoDS8iQNoAQ2UTIgXgf+W9/XyLXg
         DMNTouisr00VeZ918eYhkWQSJr8aQC23ShL2r3LiTJEEURYBKsS1Yo1fA6lkkGuUJJac
         Tjs1qcLQf14ADqbt5pxcvwgedpIgWD1wIC2gaW9xbY1B5etiz25/MjO0ALnVumU+wqk/
         zZ92Bp6axP/8KAeNW0Uo75sViuTHvFVOm4NY6XfE79GBKx8w0jd42K64Dwed2RuTs482
         wPKzyou6dcJUBcIauBm5ae3Xv8WrcrtL5VlSiQnSbqvF4Nc25rsuxP6cxtEkZeEjSuGk
         v25g==
X-Gm-Message-State: AOJu0Yzn+JJFm0PtT8SZ7c8Q4NOoUsvm/vDX6305oKbILJHbOBoNfW6X
        1+9dJmTj5rJG7AziNOeiWqU28aN2hPbtZ3FUYYc/yA==
X-Google-Smtp-Source: AGHT+IG40KkPAgtM+mYO9x30FI6sqZXQ6lrHnyP4mTumJncSPHmhCLGipcixU2m+iAmH2ymCR3S6Cw==
X-Received: by 2002:a81:798f:0:b0:5cc:a937:e with SMTP id u137-20020a81798f000000b005cca937000emr937875ywc.19.1700659168067;
        Wed, 22 Nov 2023 05:19:28 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id en15-20020a05690c2b8f00b005cab0d7b0f1sm1769368ywb.6.2023.11.22.05.19.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 05:19:27 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db048181cd3so6611167276.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:19:27 -0800 (PST)
X-Received: by 2002:a25:6605:0:b0:da3:ab41:33c6 with SMTP id
 a5-20020a256605000000b00da3ab4133c6mr1946922ybc.65.1700659167137; Wed, 22 Nov
 2023 05:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20231106-uvc-event-v3-1-c2d2fdaa2e2c@chromium.org> <995f8f26-ed20-44d2-a76a-e354fc68d65e@xs4all.nl>
In-Reply-To: <995f8f26-ed20-44d2-a76a-e354fc68d65e@xs4all.nl>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 14:19:14 +0100
X-Gmail-Original-Message-ID: <CANiDSCvniNQOfQ1a3o33UPf4roEa4-EOE=1ggHrwumpyNsxR5g@mail.gmail.com>
Message-ID: <CANiDSCvniNQOfQ1a3o33UPf4roEa4-EOE=1ggHrwumpyNsxR5g@mail.gmail.com>
Subject: Re: [PATCH v3] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esker Wong <esker@chromium.org>
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

Hi Hans

On Tue, 21 Nov 2023 at 11:37, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Ricardo,
>
> Sorry, I missed the whole discussion for the v2 patch. I've now read it and
> will reply here.
>
> On 11/6/23 12:00, Ricardo Ribalda wrote:
> > Add support for the frame_sync event, so user-space can become aware
> > earlier of new frames.

Will fix the description in the next version thanks!


>
> I don't think this describes why you want this. Specifically, you want to use
> this to measure latency inside the driver between the arrival of the first USB
> packet and the time the buffer is dequeued.
>
> And this is presumably meant for debugging/measuring, but not for normal
> capturing. Right?
>
> Based on the discussion it looks like everyone is OK with this for the BULK
> case, and V4L2_EVENT_FRAME_SYNC makes sense to me there. You want to see the
> sequence number in the event, and the description of the event matches what
> happens.
>
> The problem is the ISOC case where it is debatable if this adds anything.
>
> Perhaps in the ISOC case this event shouldn't be supported? Unless you can
> show that it does provide useful information in the ISOC case. I didn't see
> that in the v2 discussion, but I might have missed it.

There are the following times
- t_exposure: Time when the exposure happens. We can get it from
v4l2_buffer.timestamp based on the hw timestamp
- t_usb_first: Time when the first usb frame arrives at the usb host.
We cannot get it (or better said.. I do not know how to get it)
- t_urb: Time when the first urb is processed by the driver.
Implemented as V4L2_EVENT_FRAME_SYNC in this driver
- t_dqbuf: Time when the buffer can be dequeded by userspace.
Implemented a timestamp in userspace when the syscall finishes.

What we would like to measure is (t_dqbuf-t_usb_first), but we cannot
obtain t_usb_first.

(t_urb-t_usb_first) is relatively small so it can be ignored: For ISO
the max we have measured is 1.8 msec vs 31 msec (t_dqbuf-t_urb)
(t_urb-t_usb_first) is also always constant. If you are measuring
trends, you do not care about an offset.

There are two proposed alternatives to this patch:
- that we use (t_dqbuf-t_exposure), but that measurement is dependent
on the exposure time, so we cannot use that measurement.
- use ftrace: but we will have to use different userspace methods for
every driver, which defeats the purpose of V4L2_EVENT_FRAME_SYNC, and
the metric will be as "bad" as the current proposal.

If you are curious you can take a look at a trace here:
https://ui.perfetto.dev/#!/?s=061a0fb7ebb0333e5dcbe35f487c18980e8e00a6e1b227c98d5e2569163924e0

Thanks!


>
> Regards,
>
>         Hans
>
> >
> > Suggested-by: Esker Wong <esker@chromium.org>
> > Tested-by: Esker Wong <esker@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > We have measured a latency of around 30msecs between frame sync
> > and dqbuf.
> > ---
> > Changes in v3:
> > - Sent wrong patch as v2 sorry :S
> > - Link to v2: https://lore.kernel.org/r/20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org
> >
> > Changes in v2:
> > - Suggested by Laurent. Split sequence++ and event init.
> > - Link to v1: https://lore.kernel.org/r/20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org
> > ---
> >  drivers/media/usb/uvc/uvc_v4l2.c  | 2 ++
> >  drivers/media/usb/uvc/uvc_video.c | 7 +++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index f4988f03640a..9f3fb5fd2375 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -1352,6 +1352,8 @@ static int uvc_ioctl_subscribe_event(struct v4l2_fh *fh,
> >       switch (sub->type) {
> >       case V4L2_EVENT_CTRL:
> >               return v4l2_event_subscribe(fh, sub, 0, &uvc_ctrl_sub_ev_ops);
> > +     case V4L2_EVENT_FRAME_SYNC:
> > +             return v4l2_event_subscribe(fh, sub, 0, NULL);
> >       default:
> >               return -EINVAL;
> >       }
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 28dde08ec6c5..6a9410133908 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -1073,9 +1073,16 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
> >        * that discontinuous sequence numbers always indicate lost frames.
> >        */
> >       if (stream->last_fid != fid) {
> > +             struct v4l2_event event = {
> > +                     .type = V4L2_EVENT_FRAME_SYNC,
> > +             };
> > +
> >               stream->sequence++;
> >               if (stream->sequence)
> >                       uvc_video_stats_update(stream);
> > +
> > +             event.u.frame_sync.frame_sequence = stream->sequence;
> > +             v4l2_event_queue(&stream->vdev, &event);
> >       }
> >
> >       uvc_video_clock_decode(stream, buf, data, len);
> >
> > ---
> > base-commit: ce55c22ec8b223a90ff3e084d842f73cfba35588
> > change-id: 20231020-uvc-event-d3d1bbbdcb2f
> >
> > Best regards,
>


--
Ricardo Ribalda
