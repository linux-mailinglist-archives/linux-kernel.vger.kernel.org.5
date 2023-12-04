Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36F8035A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjLDN4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344854AbjLDNzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:55:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F690;
        Mon,  4 Dec 2023 05:55:57 -0800 (PST)
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 777066607090;
        Mon,  4 Dec 2023 13:55:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701698156;
        bh=wD2ubbvS7eFYc7JS8cp6iuoHY5//3jKYOuC554SErTw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ih34D7OwsXYpv77xCCo/dPALgCqYbEPj+mvJ/SdCmiumsp/i5nb9igiwVegqZ0xum
         2GdCaNWzog/m9VJ/zN+fJeQWMUz7eJXkgRHxcdDZQvKOgvlnLCHujRQJTco5BRGKma
         i2gHd0Fws8FMh6FPqJ1yR6LWqQGCzOZwuseF5uQBhiM0RTQCbLAtxx7hx038qFyfXn
         KF0ip8xvG44l9c2yfimihZXy6oL6p19rDtBNlO5jqIHZZYqrs30yWInqhAFCidRMBM
         ZKDRpqViPpkzDNOnCuJfJihHclTzCYyt0UhXAsHH57EGtKD57kYc93cp2Nx+w7JzLC
         kT7/2wOxIWr1g==
Message-ID: <a4c47b282d9e3bc5c2891ac1b9cafb9c9970975c.camel@collabora.com>
Subject: Re: [PATCH] Fix memory leaks in wave5_vpu_open_enc() and
 wave5_vpu_open_dec()
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Zeng Chi <zengchi@kylinos.cn>, nas.chung@chipsnmedia.com,
        jackson.lee@chipsnmedia.com, mchehab@kernel.org,
        sebastian.fricke@collabora.com, hverkuil-cisco@xs4all.nl,
        bob.beckett@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Dec 2023 08:55:46 -0500
In-Reply-To: <20231204091649.3418987-1-zengchi@kylinos.cn>
References: <20231204091649.3418987-1-zengchi@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lundi 04 d=C3=A9cembre 2023 =C3=A0 17:16 +0800, Zeng Chi a =C3=A9crit=C2=
=A0:
> This patch fixes memory leaks on error escapes in wave5_vpu_open_enc()
> and wave5_vpu_open_dec().

Please avoid sending twice the same patch. This is still a NAK.

regards,
Nicolas

>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>  drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 5 +++--
>  drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 8b1417ece96e..b0a045346bb7 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1802,9 +1802,10 @@ static int wave5_vpu_open_dec(struct file *filp)
>  	spin_lock_init(&inst->state_spinlock);
> =20
>  	inst->codec_info =3D kzalloc(sizeof(*inst->codec_info), GFP_KERNEL);
> -	if (!inst->codec_info)
> +	if (!inst->codec_info) {
> +		kfree(inst);
>  		return -ENOMEM;
> -
> +	}
>  	v4l2_fh_init(&inst->v4l2_fh, vdev);
>  	filp->private_data =3D &inst->v4l2_fh;
>  	v4l2_fh_add(&inst->v4l2_fh);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index f29cfa3af94a..bc94de9ea546 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -1546,9 +1546,10 @@ static int wave5_vpu_open_enc(struct file *filp)
>  	inst->ops =3D &wave5_vpu_enc_inst_ops;
> =20
>  	inst->codec_info =3D kzalloc(sizeof(*inst->codec_info), GFP_KERNEL);
> -	if (!inst->codec_info)
> +	if (!inst->codec_info) {
> +		kfree(inst);
>  		return -ENOMEM;
> -
> +	}
>  	v4l2_fh_init(&inst->v4l2_fh, vdev);
>  	filp->private_data =3D &inst->v4l2_fh;
>  	v4l2_fh_add(&inst->v4l2_fh);

