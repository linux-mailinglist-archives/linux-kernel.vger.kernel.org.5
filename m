Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C8779E234
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjIMIfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjIMIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:35:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB35EC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:35:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5251D660732B;
        Wed, 13 Sep 2023 09:35:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694594105;
        bh=b1+U2pGflwc/V1Z4xgUhLMPjPG7gNXIcxF/u4aJVNLw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HIt2c3/+tufCzvGPr6PR1hR57aag53jqn1I5ql+1dQscZQAyXpGYCsLgTUuEJ9nDM
         yVYqUD7YtKlFfXn4vrkeKKBSVsgPsGsX2jxEIU+NoxwY38Q5I98qWrbYqxROUcm4MM
         pCp0Q1vqc8ICoTFYzmUCNJu9IsglY8B9QQv6zSJGZyHqL+tmhHqZiUovsu+hIyd5kJ
         cJEPdxyhYZyIgZIBg2qU5Qn/Htrv9I8OKECZr+psUWMXjqjoCY/6dCG4KJyjKGgmqg
         Jbtq0fjIVYDIa5SKatpvytljZluz9rXCE9vswZWrb5018EtXV/vCsQ5dFoUiPaaEjS
         SNPvtrFk6Hykg==
Message-ID: <5a4a0d12-d16a-0836-f6c5-6e6c2f3a9097@collabora.com>
Date:   Wed, 13 Sep 2023 10:35:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/mediatek: Add spinlock for setting vblank event in
 atomic_begin
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Fei Shao <fshao@chromium.org>
References: <20230822132646.9811-1-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230822132646.9811-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/08/23 15:26, Jason-JH.Lin ha scritto:
> Add spinlock protection to avoid race condition on vblank event
> between mtk_drm_crtc_atomic_begin() and mtk_drm_finish_page_flip().
> 

Hello Jason,

Can you please provide more information about this race condition?
(check below)

> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index d40142842f85..128a672fe3c9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -746,6 +746,9 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
>   									  crtc);
>   	struct mtk_crtc_state *mtk_crtc_state = to_mtk_crtc_state(crtc_state);
>   	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&crtc->dev->event_lock, flags);
>   
>   	if (mtk_crtc->event && mtk_crtc_state->base.event)
>   		DRM_ERROR("new event while there is still a pending event\n");
> @@ -756,6 +759,8 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,

...because my suspect is that what creates the race condition in this function is
the unlocked *assignment* to mtk_crtc->event, not the rest.

If I'm right, you don't need to unconditionally spinlock at the beginning of this
function hence ever-so-slightly improving performance compared to this version.

Can you please try this one and check if this *also* solves the issue?

	if (mtk_crtc_state->base.event) {
		mtk_crtc_state->base.event->pipe = drm_crtc_index(crtc);
		WARN_ON(drm_crtc_vblank_get(crtc) != 0);

		spin_lock_irqsave(&crtc->dev->event_lock, flags);
		mtk_crtc->event = mtk_crtc_state->base.event;
		spin_lock_irqrestore(&crtc->dev->event_lock, flags);

		mtk_crtc_state->base.event = NULL;
	}

P.S.: I'd try that myself, but I can't seem to reproduce the issue.

Regards,
Angelo

