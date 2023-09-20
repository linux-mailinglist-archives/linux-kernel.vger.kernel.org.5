Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B627A8632
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjITOIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjITOIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:08:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD9AD;
        Wed, 20 Sep 2023 07:08:32 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D08F06607243;
        Wed, 20 Sep 2023 15:08:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695218910;
        bh=OVi2+NsVBKyZ5/S8nnWLJaBO7/r+oTXhkjecJHc4TdE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O7mf/pBo5KBvGr41uVDtoSVde30LviXmg2OwLYTI966fmx8yLst7NW4unL0LAqFQr
         Qo+9qHZUeXyawoL4r2lD53Cyiye09l0h0/+KPuGqHf2jfli5v6tDXTd4y884QRuweP
         4fZ1RouBK0HNDbp/X+g/ydBDEnAbdjxzTAnVcxVpmjCtujPg578aHzkfhFOGTX4AGH
         Kn70ONzZdtsYzKisSn33PGHuNWvfeENlntWWVqirso0eWOU9Jdmzoc0iS/dvvJgvi3
         I7+RLwHT2/NA3My2rDlP9yxTv55huscJNI2XXXpOAwcxUogh1VMZ3uDegirF8SX+US
         8Jj4MxO9gq5Tw==
Message-ID: <179e88f04257f21b6b723e935231de70415b3301.camel@collabora.com>
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
Date:   Wed, 20 Sep 2023 10:08:19 -0400
In-Reply-To: <a3c61e5a-e5cb-43d5-a3dc-80806f8da672@xs4all.nl>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
         <20230915-wave5_v12_on_media_master-v12-1-92fc66cd685d@collabora.com>
         <a3c61e5a-e5cb-43d5-a3dc-80806f8da672@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc Tomasz Figa

Le mercredi 20 septembre 2023 =C3=A0 14:59 +0200, Hans Verkuil a =C3=A9crit=
=C2=A0:
> On 15/09/2023 23:11, Sebastian Fricke wrote:
> > Add a new flag to the `struct v4l2_m2m_dev` to toggle whether a queue
> > must be streaming in order to allow queuing jobs to the ready queue.
> > Currently, both queues (CAPTURE & OUTPUT) must be streaming in order to
> > allow adding new jobs. This behavior limits the usability of M2M for
> > some drivers, as these have to be able, to perform analysis of the
>=20
> able, to -> able to
>=20
> > sequence to ensure, that userspace prepares the CAPTURE queue correctly=
.
>=20
> ensure, that -> ensure that
>=20
> >=20
> > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> >  include/media/v4l2-mem2mem.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >=20
> > diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.=
h
> > index d6c8eb2b5201..97a48e61e358 100644
> > --- a/include/media/v4l2-mem2mem.h
> > +++ b/include/media/v4l2-mem2mem.h
> > @@ -57,6 +57,16 @@ struct v4l2_m2m_dev;
> >   * @rdy_spinlock: spin lock to protect the struct usage
> >   * @num_rdy:	number of buffers ready to be processed
> >   * @buffered:	is the queue buffered?
> > + * @ignore_streaming: Dictates whether the queue must be streaming for=
 a job to
> > + *		      be queued.
> > + *		      This is useful, for example, when the driver requires to
> > + *		      initialize the sequence with a firmware, where only a
> > + *		      queued OUTPUT queue buffer and STREAMON on the OUTPUT
> > + *		      queue is required to perform the anlysis of the bitstream
> > + *		      header.
> > + *		      This means the driver is responsible for implementing the
> > + *		      job_ready callback correctly to make sure that requirements
> > + *		      for actual decoding are met.
>=20
> This is a bad description and field name.

I wonder what's your opinion about the buffered one then :-D

>=20
> Basically what this field does is that, if true, the streaming state of t=
he
> capture queue is ignored. So just call it that: ignore_cap_streaming.
>=20
> And explain that, if true, job_ready() will be called even if the capture
> queue is not streaming, and that that can be used to allow hardware to
> analyze the bitstream header that arrives on the OUTPUT queue.

Ack.

>=20
> Also, doesn't this field belong to struct v4l2_m2m_ctx? It makes no sense
> for the output queue, this is really a configuration for the m2m context =
as
> a whole.

Unless we come up with a completely new type of M2M that can behave like a =
gap
filler (like a video rate m2m), it indeed makes no sense for output. I'm ju=
st
illustrating that this is true "now" but someone can come up with valid
expectation. So I agree with you, we can move it up in the hierarchy.

Recently over IRC and other threads, Tomasz raised a concern that CODECs wh=
ere
introducing too much complexity into M2M. And I believe buffered (which is
barely documented) and this mechanism was being pointed.

My take on that is that adding boolean configuration is what introduce
complexity, and we can fix it by doing less in the m2m. After this discussi=
on, I
came with the idea that we should remove buffered and ignore_streaming. For
drivers that don't implement job_ready, this logic would be moved inside th=
e
default implementation. We can then add a helper to check the common condit=
ions.

The alternative suggested by Tomasz, was to layer two ops. We'd have a
device_ready() ops and its default implementation would include the check w=
e
have and would call job_ready(). Personally, I'd rather remove then add, bu=
t I
understadt the reasoning and would be fine committing to that instead.

I'd like your feedback on this proposal. If this is something we want, I'll=
 do
this prior to V13, otherwise we will address your comments and fix the adde=
d
mechanism. I think though that we agree that for decoders, this is nice add=
ition
to not have to trigger work manually from vb2 ops.

regards,
Nicolas

>=20
> >   *
> >   * Queue for buffers ready to be processed as soon as this
> >   * instance receives access to the device.
> > @@ -69,6 +79,7 @@ struct v4l2_m2m_queue_ctx {
> >  	spinlock_t		rdy_spinlock;
> >  	u8			num_rdy;
> >  	bool			buffered;
> > +	bool			ignore_streaming;
> >  };
> > =20
> >  /**
> > @@ -564,6 +575,12 @@ static inline void v4l2_m2m_set_dst_buffered(struc=
t v4l2_m2m_ctx *m2m_ctx,
> >  	m2m_ctx->cap_q_ctx.buffered =3D buffered;
> >  }
> > =20
> > +static inline void v4l2_m2m_set_dst_ignore_streaming(struct v4l2_m2m_c=
tx *m2m_ctx,
> > +						     bool ignore_streaming)
> > +{
> > +	m2m_ctx->cap_q_ctx.ignore_streaming =3D ignore_streaming;
> > +}
> > +
>=20
> I think this is overkill, esp. when the field is moved to m2m_ctx. Just c=
learly
> document that drivers can set this.
>=20
> Regards,
>=20
> 	Hans
>=20
> >  /**
> >   * v4l2_m2m_ctx_release() - release m2m context
> >   *
> >=20
>=20

