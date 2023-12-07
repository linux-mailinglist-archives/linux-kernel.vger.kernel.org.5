Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01A809044
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjLGSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjLGSlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:41:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D46171F;
        Thu,  7 Dec 2023 10:41:08 -0800 (PST)
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 731886601F0A;
        Thu,  7 Dec 2023 18:41:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701974466;
        bh=WcT7DiTTNQxZhHjWft90cTmZ9KR+kldp0Vqu91bJDwg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K22n2qR2PEZXpMPa0J1s535f4oylKH2qEDoXEc912HbKGwA0JRiyJwoAGS8WRVv/m
         cOZ02Gw8sW0UKZz4mPJFUpYM+orhr+J4sriwvAdQTZyctYc2R6rmyVu1QbQfGDgpAR
         NxKIZf60oC0yPrjdbA8tF4AzAXR9D6/utFylQD1SC7Bwff4o1NMD0vr+gMRm7lQQXf
         bn7kAjFRsPDBcnkgb/rCGeEhv2kfI93LQR2/IgtZhNTKaqqfOrbYuLtwdrIYPoEcJE
         zksYO95i08ihxbUUbDsNsgbwu1V9LpD6FFOZuPgNs/rBH/Zpa0ljCFIDdsay+/Tv2b
         yN4Tw1eWyVo+g==
Message-ID: <64d946710b3f3e14bfeb3fa95db01a99e244f264.camel@collabora.com>
Subject: Re: [PATCH] Fix memory leaks in wave5_vpu_open_enc() and
 wave5_vpu_open_dec()
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Robert Beckett <bob.beckett@collabora.com>,
        Zeng Chi <zengchi@kylinos.cn>, nas.chung@chipsnmedia.com,
        jackson.lee@chipsnmedia.com, mchehab@kernel.org,
        sebastian.fricke@collabora.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Dec 2023 13:40:56 -0500
In-Reply-To: <e891ae21-2b3a-4d99-9f5c-fb387438ffef@collabora.com>
References: <20231204091649.3418987-1-zengchi@kylinos.cn>
         <a4c47b282d9e3bc5c2891ac1b9cafb9c9970975c.camel@collabora.com>
         <e891ae21-2b3a-4d99-9f5c-fb387438ffef@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 d=C3=A9cembre 2023 =C3=A0 17:36 +0000, Robert Beckett a =C3=A9c=
rit=C2=A0:
> On 04/12/2023 13:55, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le lundi 04 d=C3=A9cembre 2023 =C3=A0 17:16 +0800, Zeng Chi a =C3=A9cri=
t=C2=A0:
> > > This patch fixes memory leaks on error escapes in wave5_vpu_open_enc(=
)
> > > and wave5_vpu_open_dec().
> > Please avoid sending twice the same patch. This is still a NAK.
>=20
> tbf, this is a different patch, concerning the allocation of the=20
> codec_info within inst, not inst itself.

I've stopped after reading an identical subject line. I can apology for not
noticing the difference, but I think an effort from the submitter could
certainly help in the future.

Nicolas

>=20
> > regards,
> > Nicolas
> >=20
> > > Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> > > Signed-off-by: Zeng Chi<zengchi@kylinos.cn>
> > > ---
> > >   drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 5 +++--
> > >   drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 5 +++--
> > >   2 files changed, 6 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c=
 b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > index 8b1417ece96e..b0a045346bb7 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > @@ -1802,9 +1802,10 @@ static int wave5_vpu_open_dec(struct file *fil=
p)
> > >   	spin_lock_init(&inst->state_spinlock);
> > >  =20
> > >   	inst->codec_info =3D kzalloc(sizeof(*inst->codec_info), GFP_KERNEL=
);
> > > -	if (!inst->codec_info)
> > > +	if (!inst->codec_info) {
> > > +		kfree(inst);
>=20
> for consistency, would be better to jump to cleanup_inst.
>=20
> Also, maybe consider embedding codec_info=C2=A0 in to struct vpu_instance=
 to=20
> avoid the double alloc. I've not checked whether this is viable=20
> throughout the code, but from a quick scan of the original patch, it=20
> looks like it is always allocated and freed alongside inst.
>=20
> > >   		return -ENOMEM;
> > > -
> > > +	}
> > >   	v4l2_fh_init(&inst->v4l2_fh, vdev);
> > >   	filp->private_data =3D &inst->v4l2_fh;
> > >   	v4l2_fh_add(&inst->v4l2_fh);
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c=
 b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > index f29cfa3af94a..bc94de9ea546 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > @@ -1546,9 +1546,10 @@ static int wave5_vpu_open_enc(struct file *fil=
p)
> > >   	inst->ops =3D &wave5_vpu_enc_inst_ops;
> > >  =20
> > >   	inst->codec_info =3D kzalloc(sizeof(*inst->codec_info), GFP_KERNEL=
);
> > > -	if (!inst->codec_info)
> > > +	if (!inst->codec_info) {
> > > +		kfree(inst);
> > >   		return -ENOMEM;
> > > -
> > > +	}
> > >   	v4l2_fh_init(&inst->v4l2_fh, vdev);
> > >   	filp->private_data =3D &inst->v4l2_fh;
> > >   	v4l2_fh_add(&inst->v4l2_fh);
>=20

