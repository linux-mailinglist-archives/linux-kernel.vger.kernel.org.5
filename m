Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B517E8066
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjKJSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjKJSH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:07:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB131E7D;
        Fri, 10 Nov 2023 03:57:19 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4221E66073D6;
        Fri, 10 Nov 2023 11:57:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699617438;
        bh=yxdMDAZYCs0R8XzpVH/gErPFhSqVtu/4cjaOro2h2b4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WO3nx56UqM87HIFLLfwM2R/w0GJjvdvHpUw6z00XcHu2y+woW1xgDbCtxrNmbLnbJ
         etYOhBicHSRnRFOrs2OtpBKDwUUt9BfIC3SdbIFpOsOY4xeruQuEjin51sL+msfcei
         YBN3so3JS8iJzJFVY+/AApKOYN90tP2IjNQqKDQEWW2QDN9BMANB9IYjCTtcRL3pnd
         WoI/wxS/kE1UcePbmj8LvrfvAQRYxzvvExRX/UMuIATNSVY5Ros/TWFcBGBnIfYLWD
         JqSK3iHF+sNyUgbFzfiPuY4mwZYYtZjL7xfp6qqLvVs3XA4C6in3jGgh9NvlYbCwze
         jbVQZPB/+a2jg==
Message-ID: <b56b155c-25c0-4958-9f59-20669ee2ea01@collabora.com>
Date:   Fri, 10 Nov 2023 12:57:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/mediatek: Fix access violation in
 mtk_drm_crtc_dma_dev_get
Content-Language: en-US
To:     Stuart Lee <stuart.lee@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
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
References: <20231110012914.14884-1-stuart.lee@mediatek.com>
 <20231110012914.14884-2-stuart.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231110012914.14884-2-stuart.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/11/23 02:29, Stuart Lee ha scritto:
> Add error handling to check NULL input in
> mtk_drm_crtc_dma_dev_get function.
> 
> While display path is not configured correctly, none of crtc is
> established. So the caller of mtk_drm_crtc_dma_dev_get may pass
> input parameter *crtc as NULL, Which may cause coredump when
> we try to get the container of NULL pointer.
> 
> Fixes: cb1d6bcca542 ("drm/mediatek: Add dma dev get function")
> Signed-off-by: Stuart Lee <stuart.lee@mediatek.com>
> Cc: stable@vger.kernel.org

Reviewed-by: AngeloGioacchino DEl Regno <angelogioacchino.delregno@collabora.com>


