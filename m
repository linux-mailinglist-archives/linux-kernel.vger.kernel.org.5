Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891D478B490
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjH1Pf4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjH1Pfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:35:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE00312A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:35:39 -0700 (PDT)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id 033C0660716E;
        Mon, 28 Aug 2023 16:35:36 +0100 (BST)
From:   "Helen Mae Koike Fornazier" <helen.koike@collabora.com>
In-Reply-To: <20230825-it66121_edid-v1-1-3ab54923e472@ti.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Mon, 28 Aug 2023 16:35:36 +0100
Cc:     "Phong LE" <ple@baylibre.com>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Andrzej Hajda" <andrzej.hajda@intel.com>,
        "Robert Foss" <rfoss@kernel.org>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        "Jonas Karlman" <jonas@kwiboo.se>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Nicolas Belin" <nbelin@baylibre.com>,
        =?utf-8?q?Andy=2EHsieh?= <Andy.Hsieh@mediatek.com>, nm@ti.com,
        "Aradhya Bhatia" <a-bhatia1@ti.com>, devarsht@ti.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
To:     "Jai Luthra" <j-luthra@ti.com>
MIME-Version: 1.0
Message-ID: <6fd4-64ecbf00-7-213b7840@157890373>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?drm=3A?==?utf-8?q?_bridge=3A?=
 =?utf-8?q?_it66121=3A?= Fix invalid connector dereference
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 25, 2023 08:02 -03, Jai Luthra <j-luthra@ti.com> wrote:

> Fix the NULL pointer dereference when no monitor is connected, and the
> sound card is opened from userspace.
> 
> Instead return an error as EDID information cannot be provided to
> the sound framework if there is no connector attached.
> 
> Fixes: e0fd83dbe924 ("drm: bridge: it66121: Add audio support")
> Reported-by: Nishanth Menon <nm@ti.com>
> Closes: https://lore.kernel.org/all/20230825105849.crhon42qndxqif4i@gondola/
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Reviewed-by: Helen Koike <helen.koike@collabora.com>

> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 466641c77fe9..d6fa00dea464 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -1446,6 +1446,11 @@ static int it66121_audio_get_eld(struct device *dev, void *data,
>  {
>  	struct it66121_ctx *ctx = dev_get_drvdata(dev);
>  
> +	if (!ctx->connector) {
> +		dev_dbg(dev, "No connector present, cannot provide EDID data");
> +		return -EINVAL;
> +	}
> +
>  	mutex_lock(&ctx->lock);
>  
>  	memcpy(buf, ctx->connector->eld,
> 
> ---
> base-commit: 6269320850097903b30be8f07a5c61d9f7592393
> change-id: 20230825-it66121_edid-6ee98517808b
> 
> Best regards,
> -- 
> Jai Luthra <j-luthra@ti.com>
>

