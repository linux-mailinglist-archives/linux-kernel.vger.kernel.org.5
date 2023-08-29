Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3773C78CB93
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbjH2Rv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbjH2Ru5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:50:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90169FD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:50:54 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0191466071FD;
        Tue, 29 Aug 2023 18:50:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693331453;
        bh=8DcTnMbWDXxwqColZlQlOY7oUF8gVbQDDNW2xabsrNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3R+QoB9Kw2lSCg6+NXqE1Eq6rtXbsdm3PjqUjH3EavQBFElFDJIS+fnaM/I/NsoG
         kwuL90cxyuNRlGaO1oVhWxUZ09hYXON51/eN1wnpaLhL6W0GDX4B0NFb3uGhDDYEyN
         ikuK5dpSltaVRUKYrvJCK3ByjsTqJBNhCdJCFkk4itrZc4oHDJu+wi1bZ5fgLgMOMj
         YbPj6OPVbjwdQDuXqyxIShCcoc20KP9uf961mrDPwlxJg2iGlP3nX3JbArffDR9mXL
         TPhJ2IDmaRLuwQ84hTZGI2k03KvpzODTVgEuUEkalLauPr35eU6sMpN4MPosBw+3Fj
         ppWx17RC2WQSQ==
Date:   Tue, 29 Aug 2023 13:50:46 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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
Subject: Re: [PATCH 2/2] drm/mediatek: dpi/dsi: fix possible_crtcs calculation
Message-ID: <fca464b9-9f32-4420-90fd-05e851871c25@notapiano>
References: <20230829131941.3353439-1-mwalle@kernel.org>
 <20230829131941.3353439-2-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829131941.3353439-2-mwalle@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:19:41PM +0200, Michael Walle wrote:
> mtk_drm_find_possible_crtc_by_comp() assumed that the main path will
> always have the CRTC with id 0, the ext id 1 and the third id 2. This
> is only true if the paths are all available. But paths are optional (see
> also comment in mtk_drm_kms_init()), e.g. the main path might not be
> enabled or available at all. Then the CRTC IDs will shift one up, e.g.
> ext will be 1 and the third path will be 2.
> 
> To fix that, dynamically calculate the IDs by the precence of the paths.
> 
> Fixes: 5aa8e7647676 ("drm/mediatek: dpi/dsi: Change the getting possible_crtc way")
> Suggested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 41 ++++++++++++++-------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 771f4e173353..f3064bff64e8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -526,21 +526,34 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
>  						struct device *dev)
>  {
>  	struct mtk_drm_private *private = drm->dev_private;
> -	unsigned int ret = 0;
> -
> -	if (mtk_drm_find_comp_in_ddp(dev, private->data->main_path, private->data->main_len,
> -				     private->ddp_comp))
> -		ret = BIT(0);
> -	else if (mtk_drm_find_comp_in_ddp(dev, private->data->ext_path,
> -					  private->data->ext_len, private->ddp_comp))
> -		ret = BIT(1);
> -	else if (mtk_drm_find_comp_in_ddp(dev, private->data->third_path,
> -					  private->data->third_len, private->ddp_comp))
> -		ret = BIT(2);
> -	else
> -		DRM_INFO("Failed to find comp in ddp table\n");
> +	int i = 0;
> +
> +	if (private->data->main_path) {
> +		if (mtk_drm_find_comp_in_ddp(dev, private->data->main_path,
> +					     private->data->main_len,
> +					     private->ddp_comp))
> +			return BIT(i);
> +		i++;
> +	}
> +
> +	if (private->data->ext_path) {
> +		if (mtk_drm_find_comp_in_ddp(dev, private->data->ext_path,
> +					     private->data->ext_len,
> +					     private->ddp_comp))
> +			return BIT(i);
> +		i++;

This won't work. On MT8195 there are two display IPs, vdosys0 and vdosys1,
vdosys0 only has the main path while vdosys1 only has the external path. So you
need to loop over each one in all_drm_private[j] to get the right crtc ID for
MT8195.

Thanks,
Nícolas
