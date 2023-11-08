Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EC17E4EFE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjKHCjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKHCjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:39:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B5184;
        Tue,  7 Nov 2023 18:39:40 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86D4C66074D3;
        Wed,  8 Nov 2023 02:39:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699411179;
        bh=zYUxwIVC181tVu7mNwksNSP41rm0sl9mrVBWCUqnO6I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PFw0auo1y+h+7KgUS5KUqWWaOxKO/LcWyvSCeyu2dmyN7gal+rv3bukc0ucp85LBU
         QnC7QTSxbVYLJO4PF0c9AtJon8R47f5kPcw9Tkf5KLmcEQVd5XO1wteXvvHxkiC6mx
         mkzwOz55QEhHqvjC4R6ZZmTUmBNMN6h1mgC5xCPzIKb4iFOufjTcsmJjWiPfY0Jesn
         RT8TCO31wtDdyg3Cjm5jY4FMSYOIUwfptgLdtIvclJgR1AGDP0956LnF0UNAckRCf3
         6eMPjIG85Q92oCmwpZ966hH/n6uoMhnP8mRlA0m7DCINB1vKfyey+6zwM9yKDsWDDv
         6BW4W9PNuzKDg==
Message-ID: <f69345217c21af63cf873bfb4a16ae1363b05875.camel@collabora.com>
Subject: Re: [PATCH v4 05/11] media: rkvdec: h264: Remove SPS validation at
 streaming start
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 07 Nov 2023 21:39:27 -0500
In-Reply-To: <bfabc182-4113-46fb-85e9-8550c97d132b@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-6-jonas@kwiboo.se>
         <c75c894a09292775773ad338121ee81924337cf0.camel@collabora.com>
         <bfabc182-4113-46fb-85e9-8550c97d132b@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 07 novembre 2023 =C3=A0 23:56 +0100, Jonas Karlman a =C3=A9crit=C2=
=A0:
> On 2023-11-07 23:01, Nicolas Dufresne wrote:
> > Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9=
crit=C2=A0:
> > > SPS parameters is validated in try_ctrl() ops so there is no need to
> >=20
> >                  are
> >=20
> > > re-validate when streaming starts.
> > >=20
> > > Remove the unnecessary call to validate sps at streaming start.
> >=20
> > This patch is not working since user may change the format after the
> > control have been set. The proper fix should actually reset the SPS
> > (well all header controls) to match the the newly set format. Then this
> > validation won't be needed anymore.
> >=20
> > The sequence that is problematic after this patch is:
> >=20
> > S_FMT (OUTPUT, width, height);
> > S_CTRL (SPS) // valid
> > S_FMT(OUTPUT, width', height'); // SPS is no longer valid
> >=20
> > One suggestion I may make is to add a ops so that each codec
> > implementation can reset their header controls to make it valid against
> > the new resolution. With that in place you'll be able drop the check.
>=20
> According to the Initialization section of the V4L2 stateless
> documentation a client is supposed to S_CTRL(SPS) after S_FMT(OUTPUT).

Yes, but other part of the spec prevents us from failing if the
userspace restart in the middle of the process.

>=20
> https://docs.kernel.org/userspace-api/media/v4l/dev-stateless-decoder.htm=
l#initialization
>=20
> I guess that all stateless decoders probably should reset all ctrls to
> default value on S_FMT(OUTPUT) or decoders may end up in an unexpected
> state?
>=20
> Is resetting a ctrl value back to default something that is supported by
> v4l2 ctrl core? Did not find any obvious way to reset a ctrl value.

In order to avoid having to do this, Hantro driver just ignores these
values from SPS control and do the following:

	reg =3D G1_REG_DEC_CTRL1_PIC_MB_WIDTH(MB_WIDTH(ctx->src_fmt.width)) |
	      G1_REG_DEC_CTRL1_PIC_MB_HEIGHT_P(MB_HEIGHT(ctx->src_fmt.height)) |
	      G1_REG_DEC_CTRL1_REF_FRAMES(sps->max_num_ref_frames);

Then all they do is reset the CAPTURE format whenever needed, matching
the bit depth that was previously set. The SPS is unfortunatly not
guarantied to be valid, but at first sight its safe in regard to
picture dimensions.

>=20
> Will probably just drop this patch in v5.

That or do like in Hantro driver. What is scary though is that some of
the feature enabled by SPS may requires an auxiliary chunk of memory to
be allocated, and then this method falls appart. I think it would be
nice to fix that properly in all drivers in a future patchset.

>=20
> Regards,
> Jonas
>=20
> >=20
> > Nicolas
> >=20
> > p.s. you can also just drop this patch from the series and revisit it
> > later, though I think its worth fixing.
> >=20
> > >=20
> > > Suggested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > ---
> > > v4:
> > > - No change
> > >=20
> > > v3:
> > > - New patch
> > >=20
> > >  drivers/staging/media/rkvdec/rkvdec-h264.c | 19 ++-----------------
> > >  1 file changed, 2 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/sta=
ging/media/rkvdec/rkvdec-h264.c
> > > index 8bce8902b8dd..815d5359ddd5 100644
> > > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > > @@ -1070,17 +1070,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx=
 *ctx)
> > >  	struct rkvdec_dev *rkvdec =3D ctx->dev;
> > >  	struct rkvdec_h264_priv_tbl *priv_tbl;
> > >  	struct rkvdec_h264_ctx *h264_ctx;
> > > -	struct v4l2_ctrl *ctrl;
> > > -	int ret;
> > > -
> > > -	ctrl =3D v4l2_ctrl_find(&ctx->ctrl_hdl,
> > > -			      V4L2_CID_STATELESS_H264_SPS);
> > > -	if (!ctrl)
> > > -		return -EINVAL;
> > > -
> > > -	ret =3D rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
> > > -	if (ret)
> > > -		return ret;
> > > =20
> > >  	h264_ctx =3D kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
> > >  	if (!h264_ctx)
> > > @@ -1089,8 +1078,8 @@ static int rkvdec_h264_start(struct rkvdec_ctx =
*ctx)
> > >  	priv_tbl =3D dma_alloc_coherent(rkvdec->dev, sizeof(*priv_tbl),
> > >  				      &h264_ctx->priv_tbl.dma, GFP_KERNEL);
> > >  	if (!priv_tbl) {
> > > -		ret =3D -ENOMEM;
> > > -		goto err_free_ctx;
> > > +		kfree(h264_ctx);
> > > +		return -ENOMEM;
> > >  	}
> > > =20
> > >  	h264_ctx->priv_tbl.size =3D sizeof(*priv_tbl);
> > > @@ -1100,10 +1089,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx=
 *ctx)
> > > =20
> > >  	ctx->priv =3D h264_ctx;
> > >  	return 0;
> > > -
> > > -err_free_ctx:
> > > -	kfree(h264_ctx);
> > > -	return ret;
> > >  }
> > > =20
> > >  static void rkvdec_h264_stop(struct rkvdec_ctx *ctx)
> >=20
>=20

