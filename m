Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A6B7565D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjGQOHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjGQOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:07:27 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C0194
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:07:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-763a2e39b88so475786085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1689602838; x=1692194838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g845tNVV3cp9c1Gh8ayXapTBS4zr7NqtwAd6G/kO3uk=;
        b=pL7JNImg5dQEV9Nmyf415PukLe9HJZbeGMSDcI1xK8A1GhcwP69uNs33E70qu44v2p
         mU3zZHtJPooZPBV+lXBUoOy1ettetQ+h9XI6ya3yARWw1sFTGwJYdXjdS/AdspS1BChR
         KnBLZNSbd/B9d6xRjF/ZPOf1F9kprtWYgJB/MtaoM13lDr3M4k7uuoF/GEnMiS2LJuOk
         aswh6t16aISqU+QSwxVQOo0wuMaOt2sUH8Ig1V83g/b/nw36Eg0I5I1qBk2L4lkIFnvo
         QspeskZtCakoItNbqtV1YGIRZaBXkcgkkp4y1b+0Tl2+UJo1nA3U4ziW0UNCc47r9HCG
         pltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602838; x=1692194838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g845tNVV3cp9c1Gh8ayXapTBS4zr7NqtwAd6G/kO3uk=;
        b=gGaGGcCm84+pNdzAS0jqosXdXe7j8iwLzxV/X/lvRM9TG2pbRXG4s/W9byTaJtq0dD
         TJ6dqTr1vco1HNjZzlIlGG5fS6XdwIp63Q9IZNYaN7j1y8ktC+2WA95hgGOOexliBUIP
         ptgHAKvnqMQnUVzhgYA6YW9zx8Pj3OjWLMh2Pjy14Eu1afPBf/1XkRzH2PhrGMbybJqM
         0UvASSd5xJPLApdTZDwZD42a3PEOLBjnCWxEVTcQBJk6dw4Yvj5ufpVtezwAYjvziDXw
         /GiIzZv+DT7K/MjoDU2oi8zi5UAuqju5DksLOFs69+5S+DLA/vwY8bGqlOMpEg/9cSLK
         hPGg==
X-Gm-Message-State: ABy/qLb6m+0GZ4dXhMWst8vvhygjEizn7qHHaA4VdlqHiyyAMHYYyh+B
        YsFkiHCgDyaAh7/Ck0QBTiRIbA==
X-Google-Smtp-Source: APBJJlGDjvgQML5x27Ui6nMFAPN9v9qJ+Dc9HBnv9qT0P0ckcIJTA04h2iwUTKff/PksF05BRJ4b1w==
X-Received: by 2002:a0c:8f11:0:b0:632:80f:4728 with SMTP id z17-20020a0c8f11000000b00632080f4728mr10829416qvd.27.1689602838269;
        Mon, 17 Jul 2023 07:07:18 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:83d4::7a9])
        by smtp.gmail.com with ESMTPSA id j8-20020a0ce008000000b0063645f62bdasm6412426qvk.80.2023.07.17.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:07:17 -0700 (PDT)
Message-ID: <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>,
        Hsia-Jun Li <randy.li@synaptics.com>
Cc:     linux-media@vger.kernel.org, ayaka@soulik.info,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jul 2023 10:07:17 -0400
In-Reply-To: <20230712093301.nkj2vok2x7esdhb3@chromium.org>
References: <20230704040044.681850-1-randy.li@synaptics.com>
         <20230704040044.681850-3-randy.li@synaptics.com>
         <20230712093301.nkj2vok2x7esdhb3@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 12 juillet 2023 =C3=A0 09:33 +0000, Tomasz Figa a =C3=A9crit=C2=
=A0:
> On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
> > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> >=20
> > Many drivers have to create its own buf_struct for a
> > vb2_queue to track such a state. Also driver has to
> > iterate over rdy_queue every times to find out a buffer
> > which is not sent to hardware(or firmware), this new
> > list just offers the driver a place to store the buffer
> > that hardware(firmware) has acknowledged.
> >=20
> > One important advance about this list, it doesn't like
> > rdy_queue which both bottom half of the user calling
> > could operate it, while the v4l2 worker would as well.
> > The v4l2 core could only operate this queue when its
> > v4l2_context is not running, the driver would only
> > access this new hw_queue in its own worker.
>=20
> Could you describe in what case such a list would be useful for a
> mem2mem driver?

Today all driver must track buffers that are "owned by the hardware". This =
is a
concept dictated by the m2m framework and enforced through the ACTIVE flag.=
 All
buffers from this list must be mark as done/error/queued after streamoff of=
 the
respective queue in order to acknowledge that they are no longer in use by =
the
HW. Not doing so will warn:

  videobuf2_common: driver bug: stop_streaming operation is leaving buf ...

Though, there is no queue to easily iterate them. All driver endup having t=
heir
own queue, or just leaving the buffers in the rdy_queue (which isn't better=
).

Nicolas
>=20
> >=20
> > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++--------
> >  include/media/v4l2-mem2mem.h           | 10 +++++++++-
> >  2 files changed, 26 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l=
2-core/v4l2-mem2mem.c
> > index c771aba42015..b4151147d5bd 100644
> > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_=
dev *m2m_dev,
> >  		goto job_unlock;
> >  	}
> > =20
> > -	src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> > -	dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> > -	if (!src && !m2m_ctx->out_q_ctx.buffered) {
> > -		dprintk("No input buffers available\n");
> > -		goto job_unlock;
> > +	if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
> > +		src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> > +
> > +		if (!src && !m2m_ctx->out_q_ctx.buffered) {
> > +			dprintk("No input buffers available\n");
> > +			goto job_unlock;
> > +		}
> >  	}
> > -	if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> > -		dprintk("No output buffers available\n");
> > -		goto job_unlock;
> > +
> > +	if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
> > +		dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> > +		if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> > +			dprintk("No output buffers available\n");
> > +			goto job_unlock;
> > +		}
> >  	}
>=20
> src and dst would be referenced unitialized below if neither of the
> above ifs hits...
>=20
> Best regards,
> Tomasz
>=20
> > =20
> >  	m2m_ctx->new_frame =3D true;
> > @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v4=
l2_m2m_ctx *m2m_ctx,
> >  	INIT_LIST_HEAD(&q_ctx->rdy_queue);
> >  	q_ctx->num_rdy =3D 0;
> >  	spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
> > +	INIT_LIST_HEAD(&q_ctx->hw_queue);
> > =20
> >  	if (m2m_dev->curr_ctx =3D=3D m2m_ctx) {
> >  		m2m_dev->curr_ctx =3D NULL;
> > @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l=
2_m2m_dev *m2m_dev,
> > =20
> >  	INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
> >  	INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
> > +	INIT_LIST_HEAD(&out_q_ctx->hw_queue);
> > +	INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
> >  	spin_lock_init(&out_q_ctx->rdy_spinlock);
> >  	spin_lock_init(&cap_q_ctx->rdy_spinlock);
> > =20
> > diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.=
h
> > index d6c8eb2b5201..2342656e582d 100644
> > --- a/include/media/v4l2-mem2mem.h
> > +++ b/include/media/v4l2-mem2mem.h
> > @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
> >   *	processed
> >   *
> >   * @q:		pointer to struct &vb2_queue
> > - * @rdy_queue:	List of V4L2 mem-to-mem queues
> > + * @rdy_queue:	List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_queue()=
 is
> > + *		called in struct vb2_ops->buf_queue(), the buffer enqueued
> > + *		by user would be added to this list.
> >   * @rdy_spinlock: spin lock to protect the struct usage
> >   * @num_rdy:	number of buffers ready to be processed
> > + * @hw_queue:	A list for tracking the buffer is occupied by the hardwa=
re
> > + * 		(or device's firmware). A buffer could only be in either
> > + * 		this list or @rdy_queue.
> > + * 		Driver may choose not to use this list while uses its own
> > + * 		private data to do this work.
> >   * @buffered:	is the queue buffered?
> >   *
> >   * Queue for buffers ready to be processed as soon as this
> > @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
> >  	struct list_head	rdy_queue;
> >  	spinlock_t		rdy_spinlock;
> >  	u8			num_rdy;
> > +	struct list_head	hw_queue;
> >  	bool			buffered;
> >  };
> > =20
> > --=20
> > 2.17.1
> >=20

