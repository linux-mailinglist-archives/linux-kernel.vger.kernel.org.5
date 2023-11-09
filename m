Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C347E73C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbjKIVjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345372AbjKIVjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:39:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCB4211;
        Thu,  9 Nov 2023 13:38:49 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52CF66607413;
        Thu,  9 Nov 2023 21:38:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699565927;
        bh=iOlbhHLosbanbJteZZRBksDsgyI0sGawtDPHWA7bX8g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HruUzFIZsc9c/Sc91mVwLrxyAlcFzwo9DMLwfv1x5JUxYqBgykIXC5uptr/pe7KI6
         vIfketUq1GCs3LzHUuvzAcQq+sO22ahvAH1cX30bt7u7bY2THBnB22IX9nE7jvBtWc
         /iDKOnahxhXJV/xWD31a9a/Q2/DIHmPaiUnKQjLMReEUJqweLFvFilS2evsKOBTAPV
         7hAWaxjdGmDKuaRSiJWpvNEAiWez9btLOb+ST4O4KmAk3h/zEWAf+/TC0LUJEZMZjm
         d+HDm6SyFdFJU2FtJWjaoxz13EJfHyUclg/HcF3sdal9JB/m2/QPUTGFjJwr85+c/P
         Cs8eDpqqrKFDw==
Message-ID: <fd9ca918dcbc892169b9f0dae7d0de537f4035ed.camel@collabora.com>
Subject: Re: [PATCH 3/4] media: verisilicon: Hook the (TRY_)DECODER_CMD
 stateless ioctls
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Thu, 09 Nov 2023 16:38:36 -0500
In-Reply-To: <20231109201640.340556-3-paul.kocialkowski@bootlin.com>
References: <20231109201640.340556-1-paul.kocialkowski@bootlin.com>
         <20231109201640.340556-3-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,


Le jeudi 09 novembre 2023 =C3=A0 21:16 +0100, Paul Kocialkowski a =C3=A9cri=
t=C2=A0:
> The (TRY_)DECODER_CMD ioctls are used to support flushing when holding ca=
pture
> buffers is supported. This is the case of this driver but the ioctls were=
 never
> hooked to the ioctl ops.
>=20
> Add them to correctly support flushing.

While this CMD looks useful on paper, we have had no use for it in any
open source user space. So with this in mind, shall we really enable it
? How can we be sure that its actually working as intended ?

Nicolas

>=20
> Fixes: 340ce50f75a6 ("media: hantro: Enable HOLD_CAPTURE_BUF for H.264")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c  | 2 ++
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 3 +++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index a9fa05ac56a9..3a2a0f28cbfe 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -905,6 +905,8 @@ static int hantro_add_func(struct hantro_dev *vpu, un=
signed int funcid)
> =20
>  	if (funcid =3D=3D MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
>  		vpu->encoder =3D func;
> +		v4l2_disable_ioctl(vfd, VIDIOC_TRY_DECODER_CMD);
> +		v4l2_disable_ioctl(vfd, VIDIOC_DECODER_CMD);
>  	} else {
>  		vpu->decoder =3D func;
>  		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index b3ae037a50f6..db145519fc5d 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -785,6 +785,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops =3D {
>  	.vidioc_g_selection =3D vidioc_g_selection,
>  	.vidioc_s_selection =3D vidioc_s_selection,
> =20
> +	.vidioc_decoder_cmd =3D v4l2_m2m_ioctl_stateless_decoder_cmd,
> +	.vidioc_try_decoder_cmd =3D v4l2_m2m_ioctl_stateless_try_decoder_cmd,
> +
>  	.vidioc_try_encoder_cmd =3D v4l2_m2m_ioctl_try_encoder_cmd,
>  	.vidioc_encoder_cmd =3D vidioc_encoder_cmd,
>  };

