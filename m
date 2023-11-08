Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896177E50C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjKHHEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjKHHEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:04:39 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF60310F9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:04:37 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778a20df8c3so453838285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 23:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699427076; x=1700031876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcU13thsvap35S5C2SsaVJ2hfOrQntDefG1Kr7WrM/w=;
        b=igCVShKTqvBo9hiCuoklJEn3nsV8AW8YziYOiOdsdU4r2ki9eF/AApUGfdOSx8TDcn
         yg0UZIVuuuatm6fl1N4my579DOn8Pm1U/iUqdJ/vJXd16IkzHiAa0g6tYuVnd8oZT+2C
         JjoB2FL18Tbzxq5+3aqtcTsX6meFFNlaI3ptw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699427076; x=1700031876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcU13thsvap35S5C2SsaVJ2hfOrQntDefG1Kr7WrM/w=;
        b=vTyCl68ttbBgTJCg/eRaKMJPrWta7rIsK/7EC8DaU9Kdsuu0olfV1szc26zVwJBCNZ
         XorVW9H7KUe3ORwCy3KGFZoRC8o2BNNZh48BCzzDcRbRmU/X18VWGJJwLp4pE+hLNh4H
         1OUILD9ycD8sujSRBABRfqMsSc4hvd0NUzucVO0ybYaBOL3w+CshEeK/zzkuY5rigUAl
         vG2BrFM9aKElItKvSA48/hmOIVAYuXWfiaAtsM9fdzSqwpkBh8gTUHGPu7D/r4vA++uU
         mOZsL9ia4uW/KFBiA8YSzOdSOBqes5rXXxlHFfOf+cWBbZ21+NY9a6zVAO8P4ZbliovV
         FGkA==
X-Gm-Message-State: AOJu0YylO9g3jc6li71THCqI8hCa7ngLbhZ6qFhFEVcd/erQlV/eDnP/
        KSKemtANgCAj1RPMhVfuqvWbE+owEGpJmnV45lQbCQ==
X-Google-Smtp-Source: AGHT+IG/xi7G70cMMhzFNos4p9X4BzRn5JuJTXe5aEzzcEvUmV4/V6GdhCfnJYdGZPXXg2VB+wPVZg==
X-Received: by 2002:a05:620a:2902:b0:77a:29e:e329 with SMTP id m2-20020a05620a290200b0077a029ee329mr812484qkp.22.1699427076475;
        Tue, 07 Nov 2023 23:04:36 -0800 (PST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id az43-20020a05620a172b00b007671678e325sm730472qkb.88.2023.11.07.23.04.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 23:04:35 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-672096e0e89so41708606d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 23:04:35 -0800 (PST)
X-Received: by 2002:a05:6214:19ea:b0:66d:326a:ee4b with SMTP id
 q10-20020a05621419ea00b0066d326aee4bmr1178051qvc.33.1699427074969; Tue, 07
 Nov 2023 23:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
 <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu> <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
 <fe672e31315b8f9c44a693c909d464a299e76093.camel@ndufresne.ca> <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
In-Reply-To: <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 8 Nov 2023 08:04:18 +0100
X-Gmail-Original-Message-ID: <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
Message-ID: <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
To:     Esker Wong <esker@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     nicolas@ndufresne.ca, Sakari Ailus <sakari.ailus@iki.fi>,
        Esker Wong <esker@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esker

On Wed, 8 Nov 2023 at 07:54, Esker Wong <esker@google.com> wrote:
>
> Hi Nicholas and Sakari,
>
> We need it as precise as possible. Currently the earliest time of a
> frame we can have in userspace  is the dqbuf.
>
> And for UVC timestamp, it is somewhat awkward for us to use. Since
> other functions in our stacks do not necessarily contain such
> timestamps. So we want some event to be trigger and we can get the
> system time directly.

Not to mention that the UVC timestamping requires a bit of love.

@Laurent Pinchart, @Kieran Bingham  any progress reviewing :P :
https://patchwork.linuxtv.org/project/linux-media/list/?series=3D10083



>
> If the V4L2_EVENT_FRAME_SYNC will be earlier then V4L2_EVENT_VSYNC,
> then it has value. We would want to know the delay of a frame being
> captured to the time it is displayed.
>
> I'm not sure for bulk is the V4L2_EVENT_VSYNC more accurate?

 V4L2_EVENT_VSYNC wont be more accurate than V4L2_EVENT_FRAME_SYNC.

My understanding is that Sakari thinks that the description of
V4L2_EVENT_FRAME_SYNC
https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-dqevent.html#des=
cription
 does not match the current implementation, and suggests using
V4L2_EVENT_VSYNC instead.


>
> Esker
>
>
> On Wed, Nov 8, 2023 at 3:27=E2=80=AFAM <nicolas@ndufresne.ca> wrote:
> >
> > Hi,
> >
> > Le mardi 07 novembre 2023 =C3=A0 13:06 +0800, Esker Wong a =C3=A9crit :
> > > [send again in text mode]
> > > Hi Sakari,
> > >
> > > Sequence number is important to us. We need it to measure the latency
> > > from this event to the time we display the frame.
> >
> > how much precision do you expect, because as described, this number
> > will be completely false for bulk.
> >
> > Aren't UVC timestamp support to allow measuring latency properly ?
> >
> > Nicolas
> >
> > >
> > > Regards,
> > > Esker
> > >
> > >
> > > On Mon, Nov 6, 2023 at 7:06=E2=80=AFPM Sakari Ailus <sakari.ailus@iki=
.fi> wrote:
> > > >
> > > > Hi Ricardo,
> > > >
> > > > On Mon, Nov 06, 2023 at 10:52:27AM +0000, Ricardo Ribalda wrote:
> > > > > Add support for the frame_sync event, so user-space can become aw=
are
> > > > > earlier of new frames.
> > > > >
> > > > > Suggested-by: Esker Wong <esker@chromium.org>
> > > > > Tested-by: Esker Wong <esker@chromium.org>
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > > We have measured a latency of around 30msecs between frame sync
> > > > > and dqbuf.
> > > > > ---
> > > > > Changes in v2:
> > > > > - Suggested by Laurent. Split sequence++ and event init.
> > > > > - Link to v1: https://lore.kernel.org/r/20231020-uvc-event-v1-1-3=
baa0e9f6952@chromium.org
> > > > > ---
> > > > >  drivers/media/usb/uvc/uvc_v4l2.c  | 2 ++
> > > > >  drivers/media/usb/uvc/uvc_video.c | 7 +++++++
> > > > >  2 files changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb=
/uvc/uvc_v4l2.c
> > > > > index f4988f03640a..9f3fb5fd2375 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > @@ -1352,6 +1352,8 @@ static int uvc_ioctl_subscribe_event(struct=
 v4l2_fh *fh,
> > > > >       switch (sub->type) {
> > > > >       case V4L2_EVENT_CTRL:
> > > > >               return v4l2_event_subscribe(fh, sub, 0, &uvc_ctrl_s=
ub_ev_ops);
> > > > > +     case V4L2_EVENT_FRAME_SYNC:
> > > > > +             return v4l2_event_subscribe(fh, sub, 0, NULL);
> > > > >       default:
> > > > >               return -EINVAL;
> > > > >       }
> > > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/us=
b/uvc/uvc_video.c
> > > > > index 28dde08ec6c5..4f3a510ca4fe 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > > @@ -1073,9 +1073,16 @@ static int uvc_video_decode_start(struct u=
vc_streaming *stream,
> > > > >        * that discontinuous sequence numbers always indicate lost=
 frames.
> > > > >        */
> > > > >       if (stream->last_fid !=3D fid) {
> > > > > +             struct v4l2_event event =3D {
> > > > > +                     .type =3D V4L2_EVENT_FRAME_SYNC,
> > > > > +             };
> > > > > +
> > > > >               stream->sequence++;
> > > > >               if (stream->sequence)
> > > > >                       uvc_video_stats_update(stream);
> > > > > +
> > > > > +             event.u.frame_sync.frame_sequence =3D stream->seque=
nce,
> > > > > +             v4l2_event_queue(&stream->vdev, &event);
> > > >
> > > > uvc_video_decode_start() is called when the reception of the entire=
 frame
> > > > has been completed. However, the documentation for V4L2_EVENT_FRAME=
_SYNC
> > > > says that the event is "Triggered immediately when the reception of=
 a frame
> > > > has begun.". The functionality here doesn't seem to fit to this pat=
ch.
> > > >
> > > > Wouldn't V4L2_EVENT_VSYNC be a better fit, even if we don't really =
have a
> > > > concept of vertical sync in the case of USB? That event doesn't hav=
e the
> > > > sequence though but I guess it's not an issue at least if your case=
.
> > > >
> > > > Another technically correct option could be to create a new event f=
or this
> > > > but I'm not sure it's worth it.
> > > >
> > > > >       }
> > > > >
> > > > >       uvc_video_clock_decode(stream, buf, data, len);
> > > > >
> > > >
> > > > --
> > > > Regards,
> > > >
> > > > Sakari Ailus
> >



--=20
Ricardo Ribalda
