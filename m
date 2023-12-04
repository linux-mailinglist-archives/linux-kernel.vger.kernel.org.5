Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70FA803599
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbjLDNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbjLDNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:54:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA0C102;
        Mon,  4 Dec 2023 05:54:49 -0800 (PST)
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62C2E660711D;
        Mon,  4 Dec 2023 13:54:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701698088;
        bh=PVA41weTM/0r0G0fLxhp7nE8jfHRfSplJAtdMTUdgZ4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eZ08aZ5MePVxoXFWfBYnB3A5i11+zswsy2wL/1AOb+9/8NCNEEMAUaKS4Go3Z3469
         HANX77Z6NZr0nuyGou6b3HGJOVvpc/JgdOrWBNj2GumIRSRfiGiO4jOJuolJ41rU4i
         ut1ks1YTprC9BxLz6Sap8zzObnYVM3xMEk9vtBIK8oY8APIH0970GFGxMqde+/+kGh
         ZMRDzUmUX5ndB199DPB5S5KZ5c0OJT8cRb7gZpTIrv0wh5xl7CVRmMNGAkXoVxhKSd
         4sN1MArsB6j/s1aSHC3TvrN3jbExGgxp5fCNRZ9ojMZdSfuT5ecUAMvcGNJkyPtt3w
         b299/RnvKgJ4w==
Message-ID: <a097944d068ecc8e1121350bb7dffb058859f032.camel@collabora.com>
Subject: Re: [PATCH] Fix memory leaks in wave5_vpu_open_enc() and
 wave5_vpu_open_dec()
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Zeng Chi <zengchi@kylinos.cn>, nas.chung@chipsnmedia.com,
        jackson.lee@chipsnmedia.com, mchehab@kernel.org,
        sebastian.fricke@collabora.com, hverkuil-cisco@xs4all.nl,
        bob.beckett@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Dec 2023 08:54:37 -0500
In-Reply-To: <20231204083957.2835095-1-zengchi@kylinos.cn>
References: <20231204083957.2835095-1-zengchi@kylinos.cn>
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

Le lundi 04 d=C3=A9cembre 2023 =C3=A0 16:39 +0800, Zeng Chi a =C3=A9crit=C2=
=A0:
> This patch fixes memory leaks on error escapes in wave5_vpu_open_enc()
> and wave5_vpu_open_dec().
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>  drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 4 +++-
>  drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 8b1417ece96e..2d3e8a184f93 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1792,8 +1792,10 @@ static int wave5_vpu_open_dec(struct file *filp)
>  	int ret =3D 0;
> =20
>  	inst =3D kzalloc(sizeof(*inst), GFP_KERNEL);
> -	if (!inst)
> +	if (!inst) {
> +		kfree(inst);

The allocation failed, there is nothing to free here (kfree(null) is a no-o=
p).
This patch does not do what it pretends to do.

Nicolas

>  		return -ENOMEM;
> +	}
> =20
>  	inst->dev =3D dev;
>  	inst->type =3D VPU_INST_TYPE_DEC;
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index f29cfa3af94a..cbf6cb6e07aa 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -1537,8 +1537,10 @@ static int wave5_vpu_open_enc(struct file *filp)
>  	int ret =3D 0;
> =20
>  	inst =3D kzalloc(sizeof(*inst), GFP_KERNEL);
> -	if (!inst)
> +	if (!inst) {
> +		kfree(inst);
>  		return -ENOMEM;
> +	}
>  	v4l2_ctrl_hdl =3D &inst->v4l2_ctrl_hdl;
> =20
>  	inst->dev =3D dev;


