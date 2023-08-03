Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354D76E9FC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjHCNWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjHCNWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:22:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E6510EA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:22:50 -0700 (PDT)
Received: from [192.168.0.125] (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 932BA66003AA;
        Thu,  3 Aug 2023 14:22:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691068969;
        bh=QjOypgF2tjYzN7SWK9FWCkeF0m/mCGr8viJpxU+QpfU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QRhY6RjuYvQYrtIjk7tguUaphwsxhkMgvaV5aXqsta5ceFPkEv3CpeM5u+E+MyWQC
         2q4o3TYK6QQUY4SbYMwEkO+d6Y0k3JmwehKBKEKqDZdHm5JHPl+BhAuYYVY5cNc9mF
         qF3u/ztJjpNcnzfOjDVqsQ3y9Tf5NEgWUeEAk/t5OocMl1tZS2u1PRETUzd39cm+vq
         E9SBCEZMkNKmJHuCleyHVAMoAbwb5PA6YIxrGFVWHElaLpFHbUGVuFo7Z6+3A8p23a
         tztmQQhw5Rsxno+eL4PQbNJstMoaAX+auT90i6P+GF71g7g7ci3hZGrwIDGWCyMTxf
         hu7c45LAT5jQA==
Message-ID: <3d5de892-8311-86e8-b962-0e564903b0e6@collabora.com>
Date:   Thu, 3 Aug 2023 16:22:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 3/8] drm/mediatek: Fix using wrong drm private data to
 bind mediatek-drm
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230802144802.751-1-jason-jh.lin@mediatek.com>
 <20230802144802.751-4-jason-jh.lin@mediatek.com>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230802144802.751-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 17:47, Jason-JH.Lin wrote:
> In mtk_drm_kms_init(), each element in all_drm_priv should has one
> display path private data only, such as:
> all_drm_priv[CRTC_MAIN] should has main_path data only
> all_drm_priv[CRTC_EXT] should has ext_path data only
> all_drm_priv[CRTC_THIRD] should has third_path data only

s/should has/should have/ ?

> 
> So we need to add the length checking for each display path before
> assigning their drm private data into all_drm_priv array.
> 
> Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 89a38561ba27..c12886f31e54 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -351,6 +351,7 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
>   {
>   	struct mtk_drm_private *drm_priv = dev_get_drvdata(dev);
>   	struct mtk_drm_private *all_drm_priv[MAX_CRTC];
> +	struct mtk_drm_private *temp_drm_priv;
>   	struct device_node *phandle = dev->parent->of_node;
>   	const struct of_device_id *of_id;
>   	struct device_node *node;
> @@ -373,9 +374,18 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
>   		if (!drm_dev || !dev_get_drvdata(drm_dev))
>   			continue;
>   
> -		all_drm_priv[cnt] = dev_get_drvdata(drm_dev);
> -		if (all_drm_priv[cnt] && all_drm_priv[cnt]->mtk_drm_bound)
> -			cnt++;
> +		temp_drm_priv = dev_get_drvdata(drm_dev);
> +		if (temp_drm_priv) {

This is inside a 'for' loop right ?
Why don't you just 'continue' if temp_drm_priv is null ?


> +			if (temp_drm_priv->mtk_drm_bound)
> +				cnt++;
> +
> +			if (temp_drm_priv->data->main_len)
> +				all_drm_priv[CRTC_MAIN] = temp_drm_priv;
> +			else if (temp_drm_priv->data->ext_len)
> +				all_drm_priv[CRTC_EXT] = temp_drm_priv;
> +			else if (temp_drm_priv->data->third_len)
> +				all_drm_priv[CRTC_THIRD] = temp_drm_priv;
> +		}
>   	}
>   
>   	if (drm_priv->data->mmsys_dev_num == cnt) {

