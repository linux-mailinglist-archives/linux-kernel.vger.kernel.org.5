Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A971E8096CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjLGXyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjLGXyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:54:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43510FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:54:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFACDC433D9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701993253;
        bh=126f2FINqt2NzWMdkeMGSXx7WFzHGP22zRHVVvtlMF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XnIp6TPoRpB+tTuSRCkWDYVjXYYCb2ToRcsX08HDu4Y9thS+rx4r2QBAhlCTZnoam
         jQckTNwxUoBLM0rNUVAz1q6J8/dwpMIZp1bw2Aga/fudIHn64PqlJuHLgeJAkauAk4
         XqkPfddSNM202KFCBCNg0qY1dNzFll5sliKwGBRLApuMN32bcVdYlRvokQrEI2R8DP
         QG1L7CcdTaTxYXkjfTkAC3xeZ1M6/jRHfTst78FWyzzC+ZVRp3GtM+T9hDG8Icr8Dw
         IzgxvG0L4bH69FW2V/CepoXeEhNYg4TWnwfC5GslkgUZxsv7F3FTotLWL+koujZhB5
         OiQLDb5rp4J1g==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cb20c82a79so2557181fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 15:54:13 -0800 (PST)
X-Gm-Message-State: AOJu0YyQ42JkI52PhFrTQc6SftqkznBJ0K+UzLoyDqoauhVRdRjtq9bq
        Y7jXdFpdunMnVZyEypQ/LiUAomCVKa/kw7JZzQ==
X-Google-Smtp-Source: AGHT+IFG1YJnNx0pOc8S7TKFLRo4jr/uqeafdNxD4kyWaFE3oQZnuq4vicxphBN5NfQQmfMRMfbvWf4LsTLiiniVQFg=
X-Received: by 2002:a2e:8ec6:0:b0:2ca:12f5:c5d3 with SMTP id
 e6-20020a2e8ec6000000b002ca12f5c5d3mr2081298ljl.33.1701993251999; Thu, 07 Dec
 2023 15:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20230905084922.3908121-1-mwalle@kernel.org>
In-Reply-To: <20230905084922.3908121-1-mwalle@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 8 Dec 2023 07:54:00 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9xrt_ku-fZotJAnPa2ns-2PCGken4TepMrQYG9KEJcFA@mail.gmail.com>
Message-ID: <CAAOTY_9xrt_ku-fZotJAnPa2ns-2PCGken4TepMrQYG9KEJcFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/mediatek: fix kernel oops if no crtc is found
To:     Michael Walle <mwalle@kernel.org>
Cc:     =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael:

Michael Walle <mwalle@kernel.org> =E6=96=BC 2023=E5=B9=B49=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> drm_crtc_from_index(0) might return NULL if there are no CRTCs
> registered at all which will lead to a kernel oops in
> mtk_drm_crtc_dma_dev_get(). Add the missing return value check.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT=
8195")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
> v4:
>  - collected tags
> v3:
>  - none
> v2:
>  - collected tags
>  - fixed typos
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 93552d76b6e7..2c582498817e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -420,6 +420,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>         struct mtk_drm_private *private =3D drm->dev_private;
>         struct mtk_drm_private *priv_n;
>         struct device *dma_dev =3D NULL;
> +       struct drm_crtc *crtc;
>         int ret, i, j;
>
>         if (drm_firmware_drivers_only())
> @@ -494,7 +495,9 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>         }
>
>         /* Use OVL device for all DMA memory allocations */
> -       dma_dev =3D mtk_drm_crtc_dma_dev_get(drm_crtc_from_index(drm, 0))=
;
> +       crtc =3D drm_crtc_from_index(drm, 0);
> +       if (crtc)
> +               dma_dev =3D mtk_drm_crtc_dma_dev_get(crtc);
>         if (!dma_dev) {
>                 ret =3D -ENODEV;
>                 dev_err(drm->dev, "Need at least one OVL device\n");
> --
> 2.39.2
>
