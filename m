Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4012C7900A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbjIAQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjIAQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:17:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE55E5F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:17:13 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C161366072AF;
        Fri,  1 Sep 2023 17:17:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693585031;
        bh=GZNm9uK/LuvaLRH8Ea7cb9C+rcBADVhiASYD1HmWLvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OokT13Pp/H/iVSZTzVCIH3EJm1NXFjCFPKjLfQvFpvyqcuhphc5AMx+CPi6J78t/I
         xHJZQCMjzhHWMzG6T9y46WBPwBA5QXxx+FrRPByPFPpsvZppexZAVfNnPuTLwx8nbg
         XFgnUcRCVGV+i4A/Iqv2DO9LHHfwEHn03AvE9ERH6YciBNJNkRYSOq7+frmV6DNCkc
         NsvWyhP2QysyospUrnNVciuW4+YDsd4FcqhyijlMXA8xiF/muCDi5nxwini9ZOjUCK
         A4cb6/9OURdptII7hyHYJUIpcGndPW0/S6+7DQo3SOec0Iv4qQyIovBVe4sXKHfITS
         boKs7Qvlo4Zrg==
Date:   Fri, 1 Sep 2023 12:17:05 -0400
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
Subject: Re: [PATCH v2 2/2] drm/mediatek: dpi/dsi: fix possible_crtcs
 calculation
Message-ID: <19cac03b-5c3a-43d0-9043-0bf003ce2722@notapiano>
References: <20230901095916.3599320-1-mwalle@kernel.org>
 <20230901095916.3599320-2-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230901095916.3599320-2-mwalle@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 11:59:16AM +0200, Michael Walle wrote:
> mtk_drm_find_possible_crtc_by_comp() assumed that the main path will
> always have the CRTC with id 0, the ext id 1 and the third id 2. This
> is only true if the paths are all available. But paths are optional (see
> also comment in mtk_drm_kms_init()), e.g. the main path might not be
> enabled or available at all. Then the CRTC IDs will shift one up, e.g.
> ext will be 1 and the third path will be 2.

ext will be 0 and third will be 1.

> 
> To fix that, dynamically calculate the IDs by the precence of the paths.

precence -> presence

> 
[..]
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -507,6 +507,27 @@ static bool mtk_drm_find_comp_in_ddp(struct device *dev,
[..]
> @@ -526,21 +547,44 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
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
> +	const struct mtk_mmsys_driver_data *data;
> +	struct mtk_drm_private *priv_n;
> +	int i = 0, j;
> +
> +	for (j = 0; j < private->data->mmsys_dev_num; j++) {
> +		priv_n = private->all_drm_private[j];
> +		data = priv_n->data;
> +
> +		if (mtk_ddp_path_available(data->main_path, data->main_len,
> +					   priv_n->comp_node)) {
> +			if (mtk_drm_find_comp_in_ddp(dev, priv_n->data->main_path,
> +						     priv_n->data->main_len,
> +						     priv_n->ddp_comp))

My only nit is that you're sometimes using data, sometimes using priv_n->data.
Just use data everywhere.

Otherwise,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Tested on both mt8192-asurada-spherion and mt8195-cherry-tomato. Confirmed that
all configurations work on both machines: internal+external, only internal and
only external display.

(Like you mentioned, I also noticed that when only the external display is
enabled, it works during early boot, but then it stops working, and only after 
reconnecting it does it work again, but that's a separate issue)

Thanks,
Nícolas
