Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A9679D4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbjILP1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjILP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:27:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E9D10D9;
        Tue, 12 Sep 2023 08:27:10 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 24B3E660731E;
        Tue, 12 Sep 2023 16:27:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694532428;
        bh=Kiv47ua9LlleunOuYTbsf64o2QsgVZ5hZeZL4I6VnQc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vwd9Tg2kSYQbKfvPRPM9RG5wiNTxJyarMuQzLP5VL7rPQaMMkIWdy2FLMGYQUGOfa
         7aw5itKMoR7lsAbGqjUzMuXmn1601+9TRD/sR9m6/3odZ1K4HHdFBAENNyxdwmyBHu
         X98PfciRE2Zqpptw4kflXwOUaposKu1epf0F2RMcD/KzijCfPCo4eQxYrmaAZAG2gu
         0KcWtfRKi5LoesmP46KbaErH5dafd0ii8TLf3P+ddlSwghBWUF4GeHa5SZ0UDF2iso
         3CwvcQWZCFNPPILSuksZVAe77C/e/mpn5NFOC+a/EW/fu5qVzMhfquCDeK4utHlgrx
         nIbOE41i1kM2g==
Message-ID: <ea5c4cb3e2dab449a2b13e0e3582dbdb2a6561ee.camel@collabora.com>
Subject: Re: [PATCH v6 14/18] media: verisilicon: vp9: Use destination
 buffer height to compute chroma offset
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Date:   Tue, 12 Sep 2023 11:26:57 -0400
In-Reply-To: <40329795-a57d-d0f3-adb4-0720dd20f6e2@collabora.com>
References: <20230901124414.48497-1-benjamin.gaignard@collabora.com>
         <4856958.31r3eYUQgx@jernej-laptop>
         <7da0a2ab-032a-9de9-e136-58f973238c5b@collabora.com>
         <3248154.aeNJFYEL58@jernej-laptop>
         <40329795-a57d-d0f3-adb4-0720dd20f6e2@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 12 septembre 2023 =C3=A0 10:41 +0200, Benjamin Gaignard a =C3=A9cr=
it=C2=A0:
> Le 11/09/2023 =C3=A0 18:36, Jernej =C5=A0krabec a =C3=A9crit=C2=A0:
> > Dne ponedeljek, 11. september 2023 ob 10:55:02 CEST je Benjamin Gaignar=
d
> > napisal(a):
> > > Le 10/09/2023 =C3=A0 15:21, Jernej =C5=A0krabec a =C3=A9crit :
> > > > Hi Benjamin!
> > > >=20
> > > > Dne petek, 01. september 2023 ob 14:44:10 CEST je Benjamin Gaignard
> > > >=20
> > > > napisal(a):
> > > > > Source and destination buffer height may not be the same because
> > > > > alignment constraint are different.
> > > > > Use destination height to compute chroma offset because we target
> > > > > this buffer as hardware output.
> > > > >=20
> > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com=
>
> > > > > Fixes: e2da465455ce ("media: hantro: Support VP9 on the G2 core")
> > > > > ---
> > > > >=20
> > > > >    drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c | 4 +--=
-
> > > > >    1 file changed, 1 insertion(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec=
.c
> > > > > b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c index
> > > > > 6db1c32fce4d..1f3f5e7ce978 100644
> > > > > --- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> > > > > +++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> > > > > @@ -93,9 +93,7 @@ static int start_prepare_run(struct hantro_ctx =
*ctx,
> > > > > const struct v4l2_ctrl_vp9_ static size_t chroma_offset(const str=
uct
> > > > > hantro_ctx *ctx,
> > > > >=20
> > > > >    			    const struct v4l2_ctrl_vp9_frame
> > > > *dec_params)
> > > >=20
> > > > >    {
> > > > >=20
> > > > > -	int bytes_per_pixel =3D dec_params->bit_depth =3D=3D 8 ? 1 : 2;
> > > > > -
> > > > > -	return ctx->src_fmt.width * ctx->src_fmt.height * bytes_per_pix=
el;
> > > > > +	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_dept=
h /
> > > > 8;
> > > >=20
> > > > Commit message doesn't mention bit_depth change at all. While I thi=
nk
> > > > there is no difference between dec_params->bit_depth and ctx->bit_d=
epth,
> > > > you shouldn't just use ordinary division. If bit_depth is 10, it wi=
ll be
> > > > rounded down. And if you decide to use bit_depth from context, plea=
se
> > > > remove dec_params argument.
> > > I will change this patch and create a helpers function for chroma and=
 motion
> > > vectors offsets that VP9 and HEVC code will use since they are identi=
cal.
> > > I don't see issue with the division. If you have in mind a solution p=
lease
> > > write it so I could test it.
> > Solution is same as the code that you removed:
> > int bytes_per_pixel =3D dec_params->bit_depth =3D=3D 8 ? 1 : 2;
> >=20
> > Or alternatively:
> > int bytes_per_pixel =3D DIV_ROUND_UP(dec_params->bit_depth, 8);
> >=20
> > Consider bit_depth being 10. With old code you get 2, with yours you ge=
t 1.
>=20
> The old code is wrong ;-)
> If the format depth is 10 bits per pixel then chroma offset (in bytes) fo=
rmula is
> width * height * 10 / 8 not width * height * 16 / 8.
>=20
> I have already confirm that with HEVC on the same hardware.

Just for general interest, this is related to the fact that the reference f=
rame
are not P010 tiled (upstreamed but untested code), but NV15 (packed) tiled.=
 I'm
effectively missing a log of context around this patch though to comment, b=
ut
I'd like to underline that v4l2-common have all the information now to deal=
 with
fractional pixel sizes, which gives me the impression this code is duplicat=
ing.

Nicolas

>=20
> Regards,
> Benjamin
>=20
> >=20
> > Best regards,
> > Jernej
> >=20
> > > Regards,
> > > Benjamin
> > >=20
> > > > Best regards,
> > > > Jernej
> > > >=20
> > > > >    }
> > > > >   =20
> > > > >    static size_t mv_offset(const struct hantro_ctx *ctx,
> >=20
> >=20
> >=20
> >=20

