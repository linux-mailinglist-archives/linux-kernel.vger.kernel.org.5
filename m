Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833807599A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGSP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjGSP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E953210E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FAD61730
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07F8C43395
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689780370;
        bh=nXOLt+Ru1599YLHogJZDfcCqEFtOC1MXpEQo8Utf5+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X5Ur6GtOca0SFfi+2pqbWqAT2zyHEBEDsVDrSunDo62xwbrVst2eiLVPhX8LugXjg
         VPDH89Nwmdq4z7T9tXZJcSsK5UZhxGjzsbMhwc+3YELx3nwxBr1uyAy1BrUVxflDnd
         gyS0lvCBVAN2uYJptRT+6wrKD8KOMVvcMLSUG2djW8YJNayqmxBPBlCnPIAgZCKqTq
         wSM2U3r2QwqV5nZxt97CKc0wcpwHvgcrpZuPAt3ga2aXnTdPEdV8HKUrn5wAKeIbl1
         HoVdUdR4ReF/1XyB6SYMJeCbie8OcWHaMfG0FKlpRhKaKn4Q6EGaaNhS6ge9z7gPkB
         7MNDCW+sYBPRw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso111183801fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:26:10 -0700 (PDT)
X-Gm-Message-State: ABy/qLaQNt8CAQDneH3uSCkgOuAjucOMJijwa5UgP4Zwwuf6rAcJUNrE
        QqGQSzcbBSGjQt9Vjt/tUcBYvE7BdgnVAoKpDQ==
X-Google-Smtp-Source: APBJJlFD292w7Q5p4ODutCfH9ve7dS7RcKMi1F2heH6iTUGn+9PvFn4FmEnqaV09PWhCD4P6dYl3jZJjD/GC9Da5Kbg=
X-Received: by 2002:a2e:985a:0:b0:2b6:a057:8098 with SMTP id
 e26-20020a2e985a000000b002b6a0578098mr249343ljj.0.1689780368825; Wed, 19 Jul
 2023 08:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230523104234.7849-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230523104234.7849-1-angelogioacchino.delregno@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 19 Jul 2023 23:25:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY__oDNUx+_c=5u6TqX6vx-AG1r1xVzE-UWe+LaqQQEaaSw@mail.gmail.com>
Message-ID: <CAAOTY__oDNUx+_c=5u6TqX6vx-AG1r1xVzE-UWe+LaqQQEaaSw@mail.gmail.com>
Subject: Re: [PATCH] drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET settings/handling
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, jitao.shi@mediatek.com
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com, ck.hu@mediatek.com,
        shaoming.chen@mediatek.com, yt.shen@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

Hi, Jitao:

Do you have any comment?
If you have no comment, I would apply this patch.

Regards,
Chun-Kuang.

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2023=E5=B9=B45=E6=9C=8823=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:4=
2=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Due to the initial confusion about MIPI_DSI_MODE_EOT_PACKET, properly
> renamed to MIPI_DSI_MODE_NO_EOT_PACKET, reflecting its actual meaning,
> both the DSI_TXRX_CON register setting for bit (HSTX_)DIS_EOT and the
> later calculation for horizontal sync-active (HSA), back (HBP) and
> front (HFP) porches got incorrect due to the logic being inverted.
>
> This means that a number of settings were wrong because....:
>  - DSI_TXRX_CON register setting: bit (HSTX_)DIS_EOT should be
>    set in order to disable the End of Transmission packet;
>  - Horizontal Sync and Back/Front porches: The delta used to
>    calculate all of HSA, HBP and HFP should account for the
>    additional EOT packet.
>
> Before this change...
>  - Bit (HSTX_)DIS_EOT was being set when EOT packet was enabled;
>  - For HSA/HBP/HFP delta... all three were wrong, as words were
>    added when EOT disabled, instead of when EOT packet enabled!
>
> Invert the logic around flag MIPI_DSI_MODE_NO_EOT_PACKET in the
> MediaTek DSI driver to fix the aforementioned issues.
>
> Fixes: 8b2b99fd7931 ("drm/mediatek: dsi: Fine tune the line time caused b=
y EOTp")
> Fixes: 2d52bfba09d1 ("drm/mediatek: add non-continuous clock mode and EOT=
 packet control")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 7d5250351193..b0ab38e59db9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -407,7 +407,7 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
>         if (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
>                 tmp_reg |=3D HSTX_CKLP_EN;
>
> -       if (!(dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET))
> +       if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
>                 tmp_reg |=3D DIS_EOT;
>
>         writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
> @@ -484,7 +484,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi =
*dsi)
>                           timing->da_hs_zero + timing->da_hs_exit + 3;
>
>         delta =3D dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12;
> -       delta +=3D dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 2 : 0;
> +       delta +=3D dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 0 : 2;
>
>         horizontal_frontporch_byte =3D vm->hfront_porch * dsi_tmp_buf_bpp=
;
>         horizontal_front_back_byte =3D horizontal_frontporch_byte + horiz=
ontal_backporch_byte;
> --
> 2.40.1
>
