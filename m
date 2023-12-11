Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC980CEDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbjLKOoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbjLKOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:44:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F09F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:44:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2690AC433D9;
        Mon, 11 Dec 2023 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702305861;
        bh=IExdtmWmPMyY8Pay6KZb0S6W8wKmO6J3E3GfBIV1Cio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LeXVj4Bu+T7n50b8HfpbHRiQwZNCwPXA3r/XqcRRjZbXn45jFPYhiFzfyIrn7RDyv
         yBQAEgO8Z005TEuQnXqrs/oWoSAhSfX3otjLedh0fatrxHkPWPZpH1X2tyfOr7w56f
         fBZ0QjFfZgUGSx5kYqpACVfKdtXLQ6H3Ssci02dxVpLJVr6fZjXMNfhkOW5qJSkpdR
         /Iz8ZCH7P+yMD+RNonu2mXg/WDDc8xLlYFtgWrcPBZ1zA+XVUzIyL2G8ARXG1vZwDU
         aZWaqO5PSB9MooT0ex4Pj7BGne+26lm+9OjjsQCi8AxiOzgDjmwb4L/ZvnCeKAA5Wo
         KlRwDjdToXXJg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso1540075e87.2;
        Mon, 11 Dec 2023 06:44:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yyg47oUcdJp426hUi0ScHNbWZntcCgQMuhUgRzk/flLTKiBRs16
        3Hwrcd2WzmaHh2dBlSqKiRaUKVnwHrMwf8j+Eg==
X-Google-Smtp-Source: AGHT+IHbV4puB5U8GlwIN/BZWBEsAsegaKynxZaOnbkAQ6wtk5UHRy14LSHQMn757papUqYJTbpaelmS3QylqrwmPx0=
X-Received: by 2002:a05:651c:807:b0:2cc:2120:81b3 with SMTP id
 r7-20020a05651c080700b002cc212081b3mr758630ljb.3.1702305859144; Mon, 11 Dec
 2023 06:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20231110012914.14884-1-stuart.lee@mediatek.com> <20231110012914.14884-2-stuart.lee@mediatek.com>
In-Reply-To: <20231110012914.14884-2-stuart.lee@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 11 Dec 2023 22:44:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY__NgTPDedbuRQLZSS-0AC2rTW7Jfbm-e42sTU+-czzvew@mail.gmail.com>
Message-ID: <CAAOTY__NgTPDedbuRQLZSS-0AC2rTW7Jfbm-e42sTU+-czzvew@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/mediatek: Fix access violation in mtk_drm_crtc_dma_dev_get
To:     Stuart Lee <stuart.lee@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lancelot Wu <lancelot.wu@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stuart:

Stuart Lee <stuart.lee@mediatek.com> =E6=96=BC 2023=E5=B9=B411=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add error handling to check NULL input in
> mtk_drm_crtc_dma_dev_get function.
>
> While display path is not configured correctly, none of crtc is
> established. So the caller of mtk_drm_crtc_dma_dev_get may pass
> input parameter *crtc as NULL, Which may cause coredump when
> we try to get the container of NULL pointer.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: cb1d6bcca542 ("drm/mediatek: Add dma dev get function")
> Signed-off-by: Stuart Lee <stuart.lee@mediatek.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index c277b9fae950..047c9a31d306 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -921,7 +921,14 @@ static int mtk_drm_crtc_init_comp_planes(struct drm_=
device *drm_dev,
>
>  struct device *mtk_drm_crtc_dma_dev_get(struct drm_crtc *crtc)
>  {
> -       struct mtk_drm_crtc *mtk_crtc =3D to_mtk_crtc(crtc);
> +       struct mtk_drm_crtc *mtk_crtc =3D NULL;
> +
> +       if (!crtc)
> +               return NULL;
> +
> +       mtk_crtc =3D to_mtk_crtc(crtc);
> +       if (!mtk_crtc)
> +               return NULL;
>
>         return mtk_crtc->dma_dev;
>  }
> --
> 2.18.0
>
