Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4224A7A9A79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjIUSkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIUSkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:40:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3816BB0590;
        Thu, 21 Sep 2023 11:39:29 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E39766607298;
        Thu, 21 Sep 2023 19:39:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695321564;
        bh=a9w6Nq4Jq+CiIItmdQmNdUTXQeCnQw026LO9PbyOm2A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UWr1uXRIecF5pkPQgoLvo9uiTqB5Rf/c/15gZVFjfENO36zN2wBi8dZIvEnb0GP8g
         F01s+6Hl19OpxLVnlEq+nOj3vKonSJpOmMHCq3p83fcb7oGZa6hDlOMcNXvM1aZf2p
         DqKWyd6xD55q3sEoxzznAhbnETEgQLmD/f1UbQ6JMuNIJu8GhJBBlPUd/pTLsD42xS
         92OrXlN9ixFvMWU/9CNq9bIH2YDciPx1zHDsjyiB0wjy0V3r2ClS4pRczkyJ0C4Oct
         tMGY5CO78/nH0fyu30dgIfzMv9yPy7kWq2L4Rp5vHt9vM8AhRyhsHBz0CKWVaSteCX
         4kgZvBYVZk3Fw==
Message-ID: <522e5f3bd4f43a5718ae88133b8d5d187c470f74.camel@collabora.com>
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
Date:   Thu, 21 Sep 2023 14:39:13 -0400
In-Reply-To: <f50a8fe3-b42f-41a9-918d-825e1110a5ac@xs4all.nl>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
         <20230915-wave5_v12_on_media_master-v12-1-92fc66cd685d@collabora.com>
         <a3c61e5a-e5cb-43d5-a3dc-80806f8da672@xs4all.nl>
         <179e88f04257f21b6b723e935231de70415b3301.camel@collabora.com>
         <f50a8fe3-b42f-41a9-918d-825e1110a5ac@xs4all.nl>
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

Le mercredi 20 septembre 2023 =C3=A0 16:49 +0200, Hans Verkuil a =C3=A9crit=
=C2=A0:
> On 20/09/2023 16:08, Nicolas Dufresne wrote:
> > cc Tomasz Figa
> >=20
> > Le mercredi 20 septembre 2023 =C3=A0 14:59 +0200, Hans Verkuil a =C3=A9=
crit=C2=A0:
> > > On 15/09/2023 23:11, Sebastian Fricke wrote:
> > > > Add a new flag to the `struct v4l2_m2m_dev` to toggle whether a que=
ue
> > > > must be streaming in order to allow queuing jobs to the ready queue=
.
> > > > Currently, both queues (CAPTURE & OUTPUT) must be streaming in orde=
r to
> > > > allow adding new jobs. This behavior limits the usability of M2M fo=
r
> > > > some drivers, as these have to be able, to perform analysis of the
> > >=20
> > > able, to -> able to
> > >=20
> > > > sequence to ensure, that userspace prepares the CAPTURE queue corre=
ctly.
> > >=20
> > > ensure, that -> ensure that
> > >=20
> > > >=20
> > > > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > > ---
> > > >  include/media/v4l2-mem2mem.h | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > >=20
> > > > diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2=
mem.h
> > > > index d6c8eb2b5201..97a48e61e358 100644
> > > > --- a/include/media/v4l2-mem2mem.h
> > > > +++ b/include/media/v4l2-mem2mem.h
> > > > @@ -57,6 +57,16 @@ struct v4l2_m2m_dev;
> > > >   * @rdy_spinlock: spin lock to protect the struct usage
> > > >   * @num_rdy:	number of buffers ready to be processed
> > > >   * @buffered:	is the queue buffered?
> > > > + * @ignore_streaming: Dictates whether the queue must be streaming=
 for a job to
> > > > + *		      be queued.
> > > > + *		      This is useful, for example, when the driver requires to
> > > > + *		      initialize the sequence with a firmware, where only a
> > > > + *		      queued OUTPUT queue buffer and STREAMON on the OUTPUT
> > > > + *		      queue is required to perform the anlysis of the bitstrea=
m
> > > > + *		      header.
> > > > + *		      This means the driver is responsible for implementing th=
e
> > > > + *		      job_ready callback correctly to make sure that requireme=
nts
> > > > + *		      for actual decoding are met.
> > >=20
> > > This is a bad description and field name.
> >=20
> > I wonder what's your opinion about the buffered one then :-D
>=20
> Even worse :-)
>=20
> I still don't really understand what that does. Patches welcome.
>=20
> >=20
> > >=20
> > > Basically what this field does is that, if true, the streaming state =
of the
> > > capture queue is ignored. So just call it that: ignore_cap_streaming.
> > >=20
> > > And explain that, if true, job_ready() will be called even if the cap=
ture
> > > queue is not streaming, and that that can be used to allow hardware t=
o
> > > analyze the bitstream header that arrives on the OUTPUT queue.
> >=20
> > Ack.
> >=20
> > >=20
> > > Also, doesn't this field belong to struct v4l2_m2m_ctx? It makes no s=
ense
> > > for the output queue, this is really a configuration for the m2m cont=
ext as
> > > a whole.
> >=20
> > Unless we come up with a completely new type of M2M that can behave lik=
e a gap
> > filler (like a video rate m2m), it indeed makes no sense for output. I'=
m just
> > illustrating that this is true "now" but someone can come up with valid
> > expectation. So I agree with you, we can move it up in the hierarchy.
> >=20
> > Recently over IRC and other threads, Tomasz raised a concern that CODEC=
s where
> > introducing too much complexity into M2M. And I believe buffered (which=
 is
> > barely documented) and this mechanism was being pointed.
> >=20
> > My take on that is that adding boolean configuration is what introduce
> > complexity, and we can fix it by doing less in the m2m. After this disc=
ussion, I
> > came with the idea that we should remove buffered and ignore_streaming.=
 For
> > drivers that don't implement job_ready, this logic would be moved insid=
e the
> > default implementation. We can then add a helper to check the common co=
nditions.
> >=20
> > The alternative suggested by Tomasz, was to layer two ops. We'd have a
> > device_ready() ops and its default implementation would include the che=
ck we
> > have and would call job_ready(). Personally, I'd rather remove then add=
, but I
> > understadt the reasoning and would be fine committing to that instead.
> >=20
> > I'd like your feedback on this proposal. If this is something we want, =
I'll do
> > this prior to V13, otherwise we will address your comments and fix the =
added
> > mechanism. I think though that we agree that for decoders, this is nice=
 addition
> > to not have to trigger work manually from vb2 ops.
>=20
> It comes down to a matter of taste, I guess. I personally think that usin=
g bools
> to tweak the behavior of a framework does not necessarily increase comple=
xity,
> provided it is clearly documented what it does and why it is needed.
>=20
> I think an ignore_cap_streaming bool is pretty straightforward and has mi=
nimal
> impact in the code. As long as there are good comments.

So for wave5 we will opt for this and apply your suggested changes. And I m=
ay
come back later on the subject.

>=20
> The 'buffered' flag is were this clearly failed completely, since I could=
n't figure
> out what it is supposed to do. But that is not because it makes the code =
more
> complex, it is just because of shoddy documentation and naming.
>=20
> Quite often implementing tweaks like that are quite easy in a framework, =
since
> you have all the information readily available. In a driver it can quickl=
y become
> messy.

In this case, "buffered" is used to disable the checks for having at least =
one
buffer in the ready queues. In most cases, if you don't have at least 1 pen=
ding
capture and 1 pending output buffer, there is no point in calling device_ru=
n.

In reality, drivers will add use case specific checks in their job_ready()
implementation. For decoders, the cases I can think of are:

- On capture if you haven't parsed the stream header
- On capture if the driver removes them from ready queue as a way to track =
which
one are considered free and may be used at any time by the firmware
- On output queue, if you need device_run() to be called to complete the dr=
ain
the reorder queue

Yet, you want this check after stream headers are parsed, or whenever a new
bitstream decode operation is to be queued in the firmware. So this check g=
ets
re-implemented, but dynamically, in all decoders.

Deinterlacers may needs this too with some algorithms (the one that introdu=
ce
delays at least). Its not clear to me why it was called buffered,
ignore_rdy_queue might have been an option, though I'm not fully confident.=
 Note
that M2M can be confusing, since whenever you ask for last something, its a=
lways
relative to the ready queue, and may not make a lot of sense in the context=
 it
is used.

>=20
> For codec support there are a number of issues that increase complexity:
> implementing support for the LAST flag and events, and supporting buffers
> that can be held. Especially since driver implementations tend to vary.
>=20
> I've been experimenting with some cleanups and changes in v4l2-mem2mem.c
> (https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=3Denc-dec-cmd), m=
ainly
> surrounding the handling of the LAST flag. Note: this is failing the comp=
liance
> tests, I haven't had the time to pursue this further.
>=20
> I'm not sure whether the best approach is to move things out of the m2m f=
ramework,
> or move things into the m2m framework, or add a more codec-specific layer=
 on top
> of the m2m framework, or a combination of all of these.
>=20
> It is something that needs experimentation, just see what works.

I can see you have omitted mark_stopped() calles when refactoring, which ma=
kes
these patches change the behaviour. Could be related.

This is no longer strictly related to this patch, but I think cmd_stop()
implementation (even after your changes) are miss-fit for driver that speak=
s to
firmware. As the firmware is being made aware of the free buffers, you can'=
t
just cherry-pick from the capture queue, you have to synchronise your state=
 with
the firmware while draining. The helper should be split in two parts I supp=
ose,
but cutting the line isn't easy.

Thread safe usage of the numerous boolean implicated in the draining state =
is
also difficult. There is no other option then introduce a mutex or spinlock=
 (if
the state is needed in job_ready() implementation) to make this thread safe=
 and
reliable.

>=20
> But for this specific flag: I think it is fine to put that in the m2m fra=
mework,
> just document and name it well.

Ack.

>=20
> Regards,
>=20
> 	Hans
>=20
> >=20
> > regards,
> > Nicolas
> >=20
> > >=20
> > > >   *
> > > >   * Queue for buffers ready to be processed as soon as this
> > > >   * instance receives access to the device.
> > > > @@ -69,6 +79,7 @@ struct v4l2_m2m_queue_ctx {
> > > >  	spinlock_t		rdy_spinlock;
> > > >  	u8			num_rdy;
> > > >  	bool			buffered;
> > > > +	bool			ignore_streaming;
> > > >  };
> > > > =20
> > > >  /**
> > > > @@ -564,6 +575,12 @@ static inline void v4l2_m2m_set_dst_buffered(s=
truct v4l2_m2m_ctx *m2m_ctx,
> > > >  	m2m_ctx->cap_q_ctx.buffered =3D buffered;
> > > >  }
> > > > =20
> > > > +static inline void v4l2_m2m_set_dst_ignore_streaming(struct v4l2_m=
2m_ctx *m2m_ctx,
> > > > +						     bool ignore_streaming)
> > > > +{
> > > > +	m2m_ctx->cap_q_ctx.ignore_streaming =3D ignore_streaming;
> > > > +}
> > > > +
> > >=20
> > > I think this is overkill, esp. when the field is moved to m2m_ctx. Ju=
st clearly
> > > document that drivers can set this.
> > >=20
> > > Regards,
> > >=20
> > > 	Hans
> > >=20
> > > >  /**
> > > >   * v4l2_m2m_ctx_release() - release m2m context
> > > >   *
> > > >=20
> > >=20
> >=20
>=20

