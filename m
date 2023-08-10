Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7174B7779FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjHJN6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjHJN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:58:20 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F5D1B4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:58:19 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63d0d38ff97so4186836d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1691675899; x=1692280699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1rJTz5bg4rzwnI3ff4rWN2qUwfmBH27c5Qh2BAvyn5w=;
        b=ndjuLFarKWmxp0QE3j1BO1vhYb4/6pLnad8C4kQcrHaNNL88TKuLQ2SHjDEgt7l443
         aI5Krkq3C5BHh/B/BhChf+P5jqieFmbgL0r75qd30KDOFJGLBdXoFPnGKQ7/5XyBPaWd
         KgkF3cIkg6+HlWTUvoCLuhb2GSjAY2SffLX2d+8bbCy1aLKL7h93+OGBseelXC26cO0V
         90vgtnJ+OqIZI1kHXmFraAd510MMGIf/X7wG/q8v7g6StOnSATFU6/IqUcSHMvqmgJma
         r8E9ge5QwC45LQawKQbILJIoaKFnQmkDB4dmz6UnFLf+1EDLH1x/VIHX3XsCj6eLVWkt
         NYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691675899; x=1692280699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rJTz5bg4rzwnI3ff4rWN2qUwfmBH27c5Qh2BAvyn5w=;
        b=VfnxhiwBCad/AuCIhtGOFNzm0PKcVhS03AnPbJuB4gkF50r4cJv+4456mAlMedA2aZ
         e2d3oX0w7+NQr0nLqN376PpzIpf6XzcDy3D/7d9zyMXoprV6lDMCeQxtrTnSgnHQHeTy
         qZZCoZQ6/eK+tbiiqU2Nq4yDmo5CBgW0Au2nV7It76erlcZIRl92tGuJAdqnKsZDvTGi
         ohFmbXw4DR9xpOu3rvJ4UDlizGh8vctdCwzXyjE1HVtweR608SYnLJPXGm6h68TFk+pb
         cg0Sc3M4Aif1vrit1wEIQpLaCYijz806PX5cX4e/oIPqJ2kGTdPVp6SXY5JOrfU23uLS
         F//g==
X-Gm-Message-State: AOJu0YwRDpDAKMf5qkDChFtxpqPSsjeQspLQAHX/ZmRA8jpRAboeAUoR
        KLkbQ13HivEFyEMFhmLKCC7LIQ==
X-Google-Smtp-Source: AGHT+IGy90htbxaGVBLfMsqw9TjY9f1KySdKUMqiW6L1VOLB4Zx6hUjqKjFiwiogcvkiBUNYIqIvVg==
X-Received: by 2002:a0c:e54f:0:b0:63f:c070:492f with SMTP id n15-20020a0ce54f000000b0063fc070492fmr1963509qvm.8.1691675898960;
        Thu, 10 Aug 2023 06:58:18 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id y3-20020a0cf143000000b0063d4631d1e4sm173766qvl.68.2023.08.10.06.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:58:18 -0700 (PDT)
Message-ID: <5a70c141736e91f635f71d9922a3bbe993a76c69.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: vcodec: Fix potential array out-of-bounds in
 encoder queue_setup
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Wei Chen <harperchen1110@gmail.com>, tiffany.lin@mediatek.com
Cc:     andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Date:   Thu, 10 Aug 2023 09:58:17 -0400
In-Reply-To: <20230810082333.972165-1-harperchen1110@gmail.com>
References: <20230810082333.972165-1-harperchen1110@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 10 ao=C3=BBt 2023 =C3=A0 08:23 +0000, Wei Chen a =C3=A9crit=C2=A0:
> variable *nplanes is provided by user via system call argument. The
> possible value of q_data->fmt->num_planes is 1-3, while the value
> of *nplanes can be 1-8. The array access by index i can cause array
> out-of-bounds.
>=20
> Fix this bug by checking *nplanes against the array size.
>=20
> Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video E=
ncoder Driver")
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - Add Fixes tag and CC stable email address
> - Change the title to be more expressive
>=20
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> index 9ff439a50f53..9e8817863cb8 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> @@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *=
vq,
>  		return -EINVAL;
> =20
>  	if (*nplanes) {
> +		if (*nplanes !=3D q_data->fmt->num_planes)
> +			return -EINVAL;

I don't think the claim really exists. 	For this driver, when *nplane is se=
t,
it will be:


        case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
                requested_planes =3D f->fmt.pix_mp.num_planes;
                if (requested_planes =3D=3D 0 ||
                    requested_planes > VIDEO_MAX_PLANES)
                        return -EINVAL;
                for (i =3D 0; i < requested_planes; i++)
                        requested_sizes[i] =3D
                                f->fmt.pix_mp.plane_fmt[i].sizeimage;
                break;

Or the value the driver have set it in the previous call with *nplane =3D=
=3D 0. So
unless there is a bug, this should not happen, and more importantly, the co=
re
should not let that happen, meaning it should not be driver jobs to validat=
e
this.

my 2 cents,
Nicolas


>  		for (i =3D 0; i < *nplanes; i++)
>  			if (sizes[i] < q_data->sizeimage[i])
>  				return -EINVAL;

