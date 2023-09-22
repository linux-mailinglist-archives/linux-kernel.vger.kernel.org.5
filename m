Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F309E7ABA74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjIVUUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:20:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AD6CA;
        Fri, 22 Sep 2023 13:20:37 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A5F6C66072E7;
        Fri, 22 Sep 2023 21:20:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695414035;
        bh=GEcta38pSsvG43P/8xSgcmSYWmf1kc3dwfuZHTL07Fs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mYGkC07DhFsqSF+lLJe8pwxg+jP9NguSy0x7MdaZRsSXzw+KO37Egqb0sjTc32zWW
         1X4YLR0+ii4Vk1E1aPYLY/8yq3rKp9RQKf5CHFgbv2zg00eqRNVzqiClUtKjVucuzp
         /GIQym5+VR5uYJRwZtUIJL1qqFDsUoMjPAXRg69XUuVyWQFQsGeopWdY2mQEA5fzfI
         zo49y3CqZU+76e33SaATv2VjHKLe/eJeWtfBG7pfLB1zqnGhcO/qAxcVBD6YikNkUb
         WtNwyjylQ+aDlRN5Hd9qCLRJEcT+KfLQOCf8qtfrOQZbGpuAkr3H2JDtaGOYJozwPo
         MwUDpqTH2IUTA==
Message-ID: <27bcd2cf21688b1120fcc75c38981f8585e8f9bd.camel@collabora.com>
Subject: Re: [PATCH v12 1/7] media: v4l2: Add ignore_streaming flag
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 22 Sep 2023 16:20:24 -0400
In-Reply-To: <2ada3256-2aa0-41e0-bac6-989a20131309@xs4all.nl>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
         <20230915-wave5_v12_on_media_master-v12-1-92fc66cd685d@collabora.com>
         <a3c61e5a-e5cb-43d5-a3dc-80806f8da672@xs4all.nl>
         <179e88f04257f21b6b723e935231de70415b3301.camel@collabora.com>
         <f50a8fe3-b42f-41a9-918d-825e1110a5ac@xs4all.nl>
         <522e5f3bd4f43a5718ae88133b8d5d187c470f74.camel@collabora.com>
         <2ada3256-2aa0-41e0-bac6-989a20131309@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 22 septembre 2023 =C3=A0 10:28 +0200, Hans Verkuil a =C3=A9crit=
=C2=A0:
> On 21/09/2023 20:39, Nicolas Dufresne wrote:
> > Le mercredi 20 septembre 2023 =C3=A0 16:49 +0200, Hans Verkuil a =C3=A9=
crit=C2=A0:
> > > On 20/09/2023 16:08, Nicolas Dufresne wrote:
> > > > cc Tomasz Figa
> > > >=20
> > > > Le mercredi 20 septembre 2023 =C3=A0 14:59 +0200, Hans Verkuil a =
=C3=A9crit=C2=A0:
> > > > > On 15/09/2023 23:11, Sebastian Fricke wrote:
> > > > > > Add a new flag to the `struct v4l2_m2m_dev` to toggle whether a=
 queue
> > > > > > must be streaming in order to allow queuing jobs to the ready q=
ueue.
> > > > > > Currently, both queues (CAPTURE & OUTPUT) must be streaming in =
order to
> > > > > > allow adding new jobs. This behavior limits the usability of M2=
M for
> > > > > > some drivers, as these have to be able, to perform analysis of =
the
> > > > >=20
> > > > > able, to -> able to
> > > > >=20
> > > > > > sequence to ensure, that userspace prepares the CAPTURE queue c=
orrectly.
> > > > >=20
> > > > > ensure, that -> ensure that
> > > > >=20
> > > > > >=20
> > > > > > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com=
>
> > > > > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com=
>
> > > > > > ---
> > > > > >  include/media/v4l2-mem2mem.h | 17 +++++++++++++++++
> > > > > >  1 file changed, 17 insertions(+)
> > > > > >=20
> > > > > > diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-=
mem2mem.h
> > > > > > index d6c8eb2b5201..97a48e61e358 100644
> > > > > > --- a/include/media/v4l2-mem2mem.h
> > > > > > +++ b/include/media/v4l2-mem2mem.h
> > > > > > @@ -57,6 +57,16 @@ struct v4l2_m2m_dev;
> > > > > >   * @rdy_spinlock: spin lock to protect the struct usage
> > > > > >   * @num_rdy:	number of buffers ready to be processed
> > > > > >   * @buffered:	is the queue buffered?
> > > > > > + * @ignore_streaming: Dictates whether the queue must be strea=
ming for a job to
> > > > > > + *		      be queued.
> > > > > > + *		      This is useful, for example, when the driver require=
s to
> > > > > > + *		      initialize the sequence with a firmware, where only =
a
> > > > > > + *		      queued OUTPUT queue buffer and STREAMON on the OUTPU=
T
> > > > > > + *		      queue is required to perform the anlysis of the bits=
tream
> > > > > > + *		      header.
> > > > > > + *		      This means the driver is responsible for implementin=
g the
> > > > > > + *		      job_ready callback correctly to make sure that requi=
rements
> > > > > > + *		      for actual decoding are met.
> > > > >=20
> > > > > This is a bad description and field name.
> > > >=20
> > > > I wonder what's your opinion about the buffered one then :-D
> > >=20
> > > Even worse :-)
> > >=20
> > > I still don't really understand what that does. Patches welcome.
> > >=20
> > > >=20
> > > > >=20
> > > > > Basically what this field does is that, if true, the streaming st=
ate of the
> > > > > capture queue is ignored. So just call it that: ignore_cap_stream=
ing.
> > > > >=20
> > > > > And explain that, if true, job_ready() will be called even if the=
 capture
> > > > > queue is not streaming, and that that can be used to allow hardwa=
re to
> > > > > analyze the bitstream header that arrives on the OUTPUT queue.
> > > >=20
> > > > Ack.
> > > >=20
> > > > >=20
> > > > > Also, doesn't this field belong to struct v4l2_m2m_ctx? It makes =
no sense
> > > > > for the output queue, this is really a configuration for the m2m =
context as
> > > > > a whole.
> > > >=20
> > > > Unless we come up with a completely new type of M2M that can behave=
 like a gap
> > > > filler (like a video rate m2m), it indeed makes no sense for output=
. I'm just
> > > > illustrating that this is true "now" but someone can come up with v=
alid
> > > > expectation. So I agree with you, we can move it up in the hierarch=
y.
> > > >=20
> > > > Recently over IRC and other threads, Tomasz raised a concern that C=
ODECs where
> > > > introducing too much complexity into M2M. And I believe buffered (w=
hich is
> > > > barely documented) and this mechanism was being pointed.
> > > >=20
> > > > My take on that is that adding boolean configuration is what introd=
uce
> > > > complexity, and we can fix it by doing less in the m2m. After this =
discussion, I
> > > > came with the idea that we should remove buffered and ignore_stream=
ing. For
> > > > drivers that don't implement job_ready, this logic would be moved i=
nside the
> > > > default implementation. We can then add a helper to check the commo=
n conditions.
> > > >=20
> > > > The alternative suggested by Tomasz, was to layer two ops. We'd hav=
e a
> > > > device_ready() ops and its default implementation would include the=
 check we
> > > > have and would call job_ready(). Personally, I'd rather remove then=
 add, but I
> > > > understadt the reasoning and would be fine committing to that inste=
ad.
> > > >=20
> > > > I'd like your feedback on this proposal. If this is something we wa=
nt, I'll do
> > > > this prior to V13, otherwise we will address your comments and fix =
the added
> > > > mechanism. I think though that we agree that for decoders, this is =
nice addition
> > > > to not have to trigger work manually from vb2 ops.
> > >=20
> > > It comes down to a matter of taste, I guess. I personally think that =
using bools
> > > to tweak the behavior of a framework does not necessarily increase co=
mplexity,
> > > provided it is clearly documented what it does and why it is needed.
> > >=20
> > > I think an ignore_cap_streaming bool is pretty straightforward and ha=
s minimal
> > > impact in the code. As long as there are good comments.
> >=20
> > So for wave5 we will opt for this and apply your suggested changes. And=
 I may
> > come back later on the subject.
> >=20
> > >=20
> > > The 'buffered' flag is were this clearly failed completely, since I c=
ouldn't figure
> > > out what it is supposed to do. But that is not because it makes the c=
ode more
> > > complex, it is just because of shoddy documentation and naming.
> > >=20
> > > Quite often implementing tweaks like that are quite easy in a framewo=
rk, since
> > > you have all the information readily available. In a driver it can qu=
ickly become
> > > messy.
> >=20
> > In this case, "buffered" is used to disable the checks for having at le=
ast one
> > buffer in the ready queues. In most cases, if you don't have at least 1=
 pending
> > capture and 1 pending output buffer, there is no point in calling devic=
e_run.
>=20
> So it is really similar to ignore_cap_streaming: that relaxes the streami=
ng test,
> and 'buffered' relaxes the 'must have at least one capture and output buf=
fer ready'
> test.
>=20
> So this should be renamed to: allow_empty_queues
>=20
> Although I would prefer to split this into two bools: allow_empty_capture=
_queue and
> allow_empty_output_queue. It is more flexible that way and I actually thi=
nk it is
> easier to understand.

Its on the queue ctx, so it does not have to be typed. It would have to be =
typed
if moved to m2m ctx.

>=20
> I see also see in the v4l2-mem2mem.c source that the debug messages are v=
ery poorly
> worded:
> 	src =3D v4l2_m2m_next_src_buf(m2m_ctx);
>=20
>         if (!src && !m2m_ctx->out_q_ctx.buffered) {
>                 dprintk("No input buffers available\n");
>                 goto job_unlock;
>         }
>=20
> This should be either "source buffers" or "output buffers", but definitel=
y not
> "input buffers".
>=20
> Ditto for the dst part.

Indeed, I'll store this node somewhere for future work on the framework, th=
is is
not strictly related to wave5 anymore.

>=20
> >=20
> > In reality, drivers will add use case specific checks in their job_read=
y()
> > implementation. For decoders, the cases I can think of are:
> >=20
> > - On capture if you haven't parsed the stream header
> > - On capture if the driver removes them from ready queue as a way to tr=
ack which
> > one are considered free and may be used at any time by the firmware
> > - On output queue, if you need device_run() to be called to complete th=
e drain
> > the reorder queue
> >=20
> > Yet, you want this check after stream headers are parsed, or whenever a=
 new
> > bitstream decode operation is to be queued in the firmware. So this che=
ck gets
> > re-implemented, but dynamically, in all decoders.
> >=20
> > Deinterlacers may needs this too with some algorithms (the one that int=
roduce
> > delays at least). Its not clear to me why it was called buffered,
> > ignore_rdy_queue might have been an option, though I'm not fully confid=
ent. Note
> > that M2M can be confusing, since whenever you ask for last something, i=
ts always
> > relative to the ready queue, and may not make a lot of sense in the con=
text it
> > is used.
> >=20
> > >=20
> > > For codec support there are a number of issues that increase complexi=
ty:
> > > implementing support for the LAST flag and events, and supporting buf=
fers
> > > that can be held. Especially since driver implementations tend to var=
y.
> > >=20
> > > I've been experimenting with some cleanups and changes in v4l2-mem2me=
m.c
> > > (https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=3Denc-dec-cmd=
), mainly
> > > surrounding the handling of the LAST flag. Note: this is failing the =
compliance
> > > tests, I haven't had the time to pursue this further.
> > >=20
> > > I'm not sure whether the best approach is to move things out of the m=
2m framework,
> > > or move things into the m2m framework, or add a more codec-specific l=
ayer on top
> > > of the m2m framework, or a combination of all of these.
> > >=20
> > > It is something that needs experimentation, just see what works.
> >=20
> > I can see you have omitted mark_stopped() calles when refactoring, whic=
h makes
> > these patches change the behaviour. Could be related.
>=20
> Could be. I hope to be able to spend a bit of time on this today.
>=20
> >=20
> > This is no longer strictly related to this patch, but I think cmd_stop(=
)
> > implementation (even after your changes) are miss-fit for driver that s=
peaks to
> > firmware. As the firmware is being made aware of the free buffers, you =
can't
> > just cherry-pick from the capture queue, you have to synchronise your s=
tate with
> > the firmware while draining. The helper should be split in two parts I =
suppose,
> > but cutting the line isn't easy.
> >=20
> > Thread safe usage of the numerous boolean implicated in the draining st=
ate is
> > also difficult. There is no other option then introduce a mutex or spin=
lock (if
> > the state is needed in job_ready() implementation) to make this thread =
safe and
> > reliable.
>=20
> Regards,
>=20
> 	Hans
>=20
> >=20
> > >=20
> > > But for this specific flag: I think it is fine to put that in the m2m=
 framework,
> > > just document and name it well.
> >=20
> > Ack.
> >=20
> > >=20
> > > Regards,
> > >=20
> > > 	Hans
> > >=20
> > > >=20
> > > > regards,
> > > > Nicolas
> > > >=20
> > > > >=20
> > > > > >   *
> > > > > >   * Queue for buffers ready to be processed as soon as this
> > > > > >   * instance receives access to the device.
> > > > > > @@ -69,6 +79,7 @@ struct v4l2_m2m_queue_ctx {
> > > > > >  	spinlock_t		rdy_spinlock;
> > > > > >  	u8			num_rdy;
> > > > > >  	bool			buffered;
> > > > > > +	bool			ignore_streaming;
> > > > > >  };
> > > > > > =20
> > > > > >  /**
> > > > > > @@ -564,6 +575,12 @@ static inline void v4l2_m2m_set_dst_buffer=
ed(struct v4l2_m2m_ctx *m2m_ctx,
> > > > > >  	m2m_ctx->cap_q_ctx.buffered =3D buffered;
> > > > > >  }
> > > > > > =20
> > > > > > +static inline void v4l2_m2m_set_dst_ignore_streaming(struct v4=
l2_m2m_ctx *m2m_ctx,
> > > > > > +						     bool ignore_streaming)
> > > > > > +{
> > > > > > +	m2m_ctx->cap_q_ctx.ignore_streaming =3D ignore_streaming;
> > > > > > +}
> > > > > > +
> > > > >=20
> > > > > I think this is overkill, esp. when the field is moved to m2m_ctx=
. Just clearly
> > > > > document that drivers can set this.
> > > > >=20
> > > > > Regards,
> > > > >=20
> > > > > 	Hans
> > > > >=20
> > > > > >  /**
> > > > > >   * v4l2_m2m_ctx_release() - release m2m context
> > > > > >   *
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20
>=20

