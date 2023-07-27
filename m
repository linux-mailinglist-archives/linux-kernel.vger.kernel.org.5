Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A4F76494B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjG0HuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjG0HuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:50:02 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0977D4C04
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:43:41 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7679ea01e16so52515185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690443819; x=1691048619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn8sesRltxTsvGZPwjqFOVYdqOt+0ePbjNVrO+NvsVI=;
        b=R2VjX1bEkK/wSa0IZkJIxTRe3q9R5KoePY/bouYE39NsO0oIGVw47WASgbslll3YBc
         Pp1ORtFOCrvjgNLDBe6bi/b8i1HxWSI9TKHc74lvCjSKoSvKX6D2P2Ek3vlwRwdXlNXZ
         sksdyNpKupk8vAKa/03ovrzw66ttGol74EXos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443819; x=1691048619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn8sesRltxTsvGZPwjqFOVYdqOt+0ePbjNVrO+NvsVI=;
        b=JslKCE7E9HvT59SLEyCbQF5Q/nx58lLbjwLLXcuRbwBBM+Z3Q2GGcMkAr9CWOdmkMg
         fOV6ArwFFNP49yG3Zetz5HPCy4JbsN8KRy3Foc9MMWUcrtoTeVV2YJj5NQtkNl6PNMl9
         9tbfhIgY1YJaMSvENaUe8/qWryFFTeexdJo6q0+Navm6beMTGw77IASkcTBjvEL9vea6
         Y0UPiCATd4rZkLYFSSo/8EhH4UierA0MbgnrNUflbIWWPgmAxOwMimHhwYAymATzei2d
         7BOuYkxp65KM9GsSJyHjeqPlNH2HkbCaVyO9NDiisJhPG2pkts4ZuXzJA22VrqQoowSF
         C+jw==
X-Gm-Message-State: ABy/qLaOSzZ1GnI60gG4gJ5YeHf5Va7I/CKZWKeO5e11G3C9mrG2F7Do
        4AkeeCfunTIOgvkeWYC2KkxeFe7vUIx44G2GW5UoEA==
X-Google-Smtp-Source: APBJJlG2GK1hCQDdCWcahWUhX0BxnZVjDA7wEZnExpvwR+i4/5tCmh23NmF3WjCMvTbrtSsb+g8b7Q==
X-Received: by 2002:a05:620a:c50:b0:767:596f:a9e2 with SMTP id u16-20020a05620a0c5000b00767596fa9e2mr5345285qki.15.1690443819424;
        Thu, 27 Jul 2023 00:43:39 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id x8-20020ae9f808000000b0076745f352adsm235130qkh.59.2023.07.27.00.43.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 00:43:38 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-63d09d886a3so4830906d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:43:38 -0700 (PDT)
X-Received: by 2002:ad4:438f:0:b0:63d:d83:8808 with SMTP id
 s15-20020ad4438f000000b0063d0d838808mr3291222qvr.63.1690443818431; Thu, 27
 Jul 2023 00:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-3-randy.li@synaptics.com> <20230712093301.nkj2vok2x7esdhb3@chromium.org>
 <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
In-Reply-To: <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 27 Jul 2023 16:43:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CO4TS6wMsnaL7ob4CXogj5KT52x85YUUN1ZwDkOxW0oQ@mail.gmail.com>
Message-ID: <CAAFQd5CO4TS6wMsnaL7ob4CXogj5KT52x85YUUN1ZwDkOxW0oQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org,
        ayaka@soulik.info, hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 11:07=E2=80=AFPM Nicolas Dufresne <nicolas@ndufresn=
e.ca> wrote:
>
> Le mercredi 12 juillet 2023 =C3=A0 09:33 +0000, Tomasz Figa a =C3=A9crit =
:
> > On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
> > > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > >
> > > Many drivers have to create its own buf_struct for a
> > > vb2_queue to track such a state. Also driver has to
> > > iterate over rdy_queue every times to find out a buffer
> > > which is not sent to hardware(or firmware), this new
> > > list just offers the driver a place to store the buffer
> > > that hardware(firmware) has acknowledged.
> > >
> > > One important advance about this list, it doesn't like
> > > rdy_queue which both bottom half of the user calling
> > > could operate it, while the v4l2 worker would as well.
> > > The v4l2 core could only operate this queue when its
> > > v4l2_context is not running, the driver would only
> > > access this new hw_queue in its own worker.
> >
> > Could you describe in what case such a list would be useful for a
> > mem2mem driver?
>
> Today all driver must track buffers that are "owned by the hardware". Thi=
s is a
> concept dictated by the m2m framework and enforced through the ACTIVE fla=
g. All
> buffers from this list must be mark as done/error/queued after streamoff =
of the
> respective queue in order to acknowledge that they are no longer in use b=
y the
> HW. Not doing so will warn:
>
>   videobuf2_common: driver bug: stop_streaming operation is leaving buf .=
..
>
> Though, there is no queue to easily iterate them. All driver endup having=
 their
> own queue, or just leaving the buffers in the rdy_queue (which isn't bett=
er).
>

Thanks for the explanation. I see how it could be useful now.

Although I guess this is a problem specifically for hardware (or
firmware) which can internally queue more than 1 buffer, right?
Otherwise the current buffer could just stay at the top of the
rdy_queue until it's removed by the driver's completion handler,
timeout/error handler or context destruction.

Best regards,
Tomasz

> Nicolas
> >
> > >
> > > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++-------=
-
> > >  include/media/v4l2-mem2mem.h           | 10 +++++++++-
> > >  2 files changed, 26 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v=
4l2-core/v4l2-mem2mem.c
> > > index c771aba42015..b4151147d5bd 100644
> > > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2=
m_dev *m2m_dev,
> > >             goto job_unlock;
> > >     }
> > >
> > > -   src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> > > -   dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> > > -   if (!src && !m2m_ctx->out_q_ctx.buffered) {
> > > -           dprintk("No input buffers available\n");
> > > -           goto job_unlock;
> > > +   if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
> > > +           src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> > > +
> > > +           if (!src && !m2m_ctx->out_q_ctx.buffered) {
> > > +                   dprintk("No input buffers available\n");
> > > +                   goto job_unlock;
> > > +           }
> > >     }
> > > -   if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> > > -           dprintk("No output buffers available\n");
> > > -           goto job_unlock;
> > > +
> > > +   if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
> > > +           dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> > > +           if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> > > +                   dprintk("No output buffers available\n");
> > > +                   goto job_unlock;
> > > +           }
> > >     }
> >
> > src and dst would be referenced unitialized below if neither of the
> > above ifs hits...
> >
> > Best regards,
> > Tomasz
> >
> > >
> > >     m2m_ctx->new_frame =3D true;
> > > @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct =
v4l2_m2m_ctx *m2m_ctx,
> > >     INIT_LIST_HEAD(&q_ctx->rdy_queue);
> > >     q_ctx->num_rdy =3D 0;
> > >     spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
> > > +   INIT_LIST_HEAD(&q_ctx->hw_queue);
> > >
> > >     if (m2m_dev->curr_ctx =3D=3D m2m_ctx) {
> > >             m2m_dev->curr_ctx =3D NULL;
> > > @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v=
4l2_m2m_dev *m2m_dev,
> > >
> > >     INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
> > >     INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
> > > +   INIT_LIST_HEAD(&out_q_ctx->hw_queue);
> > > +   INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
> > >     spin_lock_init(&out_q_ctx->rdy_spinlock);
> > >     spin_lock_init(&cap_q_ctx->rdy_spinlock);
> > >
> > > diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2me=
m.h
> > > index d6c8eb2b5201..2342656e582d 100644
> > > --- a/include/media/v4l2-mem2mem.h
> > > +++ b/include/media/v4l2-mem2mem.h
> > > @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
> > >   * processed
> > >   *
> > >   * @q:             pointer to struct &vb2_queue
> > > - * @rdy_queue:     List of V4L2 mem-to-mem queues
> > > + * @rdy_queue:     List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_q=
ueue() is
> > > + *         called in struct vb2_ops->buf_queue(), the buffer enqueue=
d
> > > + *         by user would be added to this list.
> > >   * @rdy_spinlock: spin lock to protect the struct usage
> > >   * @num_rdy:       number of buffers ready to be processed
> > > + * @hw_queue:      A list for tracking the buffer is occupied by the=
 hardware
> > > + *                 (or device's firmware). A buffer could only be in=
 either
> > > + *                 this list or @rdy_queue.
> > > + *                 Driver may choose not to use this list while uses=
 its own
> > > + *                 private data to do this work.
> > >   * @buffered:      is the queue buffered?
> > >   *
> > >   * Queue for buffers ready to be processed as soon as this
> > > @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
> > >     struct list_head        rdy_queue;
> > >     spinlock_t              rdy_spinlock;
> > >     u8                      num_rdy;
> > > +   struct list_head        hw_queue;
> > >     bool                    buffered;
> > >  };
> > >
> > > --
> > > 2.17.1
> > >
>
