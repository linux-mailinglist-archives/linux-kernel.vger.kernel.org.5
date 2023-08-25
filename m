Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817C278868A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbjHYMBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbjHYMB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAAB198E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEDBD635D4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043B1C433C8;
        Fri, 25 Aug 2023 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692964886;
        bh=DkaQY49NCfEp3URelzQqFMcnMc9cI/W/Kd4KxUDsdP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kpxFzYXNwWgfxY8NNYJlMX4BJy36WR3HvNPFBufzFvuc+1G+3dkUXzrHL7ecq6mrA
         S+KFw5hGxzStAZDEnRnBk4WifvWMZuoZBBrcmgn/Dn9+zQa078bUaJyvGrejf9V6X5
         RWyFIhHXbppXCO/spDu7kvAEYcLk29nfQ88Rm6z74iJbixllna1t3ik3LHDEt+IONO
         iesMsfH9UMEvHZ6Z21UZ1aTtRRKDc85QPw8bHHYeUViA3BA3OwHDK67vDf5tgiYaUx
         0I7ShYr0Jd6zDxGifpdP/+pP3ynXQg+ReQY+kywslBe73Q49XNTLzNZqZDjulJNQ1w
         NBTKCDVjyc/KQ==
From:   Michael Walle <mwalle@kernel.org>
To:     angelogioacchino.delregno@collabora.com
Cc:     airlied@gmail.com, amergnat@baylibre.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, ehristev@collabora.com,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, nfraprado@collabora.com,
        p.zabel@pengutronix.de, wenst@chromium.org,
        Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH v7 09/11] drm/mediatek: dp: Add support for embedded DisplayPort aux-bus
Date:   Fri, 25 Aug 2023 14:01:09 +0200
Message-Id: <20230825120109.3132209-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725073234.55892-10-angelogioacchino.delregno@collabora.com>
References: <20230725073234.55892-10-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

> For the eDP case we can support using aux-bus on MediaTek DP: this
> gives us the possibility to declare our panel as generic "panel-edp"
> which will automatically configure the timings and available modes
> via the EDID that we read from it.
> 
> To do this, move the panel parsing at the end of the probe function
> so that the hardware is initialized beforehand and also initialize
> the DPTX AUX block and power both on as, when we populate the
> aux-bus, the panel driver will trigger an EDID read to perform
> panel detection.
> 
> Last but not least, since now the AUX transfers can happen in the
> separated aux-bus, it was necessary to add an exclusion for the
> cable_plugged_in check in `mtk_dp_aux_transfer()` and the easiest
> way to do this is to simply ignore checking that when the bridge
> type is eDP.

This patch breaks my board based on the MT8195 which only has one
DisplayPort output port. I suspect it might also break the mt8195-cherry
board.

While the mediatek-dpi driver finds the DP port:
[    3.131645] mediatek-dpi 1c113000.dp-intf: Found bridge node: /soc/dp-tx@1c600000

The probing of the eDP is deferred:
[   13.289009] platform 1c015000.dp-intf: deferred probe pending

So I don't know why, but to make dp_intf1 work, it seems that dp_intf0
must be probed successfully. After this patch, the edp (which is
connected to the dp_intf1) probe will return with an -ENODEV and
the previous call to devm_drm_bridge_add() will be rolled back.

Before this patch, bridge_add() was called in any case (in the
error case with next_bridge = NULL) and the mediatek-dpi probed
like that:

[    3.121011] mediatek-dpi 1c015000.dp-intf: Found bridge node: /soc/edp-tx@1c500000
[    3.122111] mediatek-dpi 1c113000.dp-intf: Found bridge node: /soc/dp-tx@1c600000

Eventually resulting in a framebuffer device:
[    4.451081] mediatek-drm mediatek-drm.8.auto: [drm] fb0: mediatekdrmfb frame buffer device


NB, somehow this series broke the initial display output. I always have
to replug the DisplayPort to get some output. I'll dig deeper into that
later.

..

> @@ -2519,21 +2553,14 @@ static int mtk_dp_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, mtk_dp->irq,
>  				     "failed to request dp irq resource\n");
>  
> -	mtk_dp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
> -	if (IS_ERR(mtk_dp->next_bridge) &&
> -	    PTR_ERR(mtk_dp->next_bridge) == -ENODEV)
> -		mtk_dp->next_bridge = NULL;

In my case, this branch was taken.

-michael

> -	else if (IS_ERR(mtk_dp->next_bridge))
> -		return dev_err_probe(dev, PTR_ERR(mtk_dp->next_bridge),
> -				     "Failed to get bridge\n");
> -
>  	ret = mtk_dp_dt_parse(mtk_dp, pdev);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to parse dt\n");
>  
> -	drm_dp_aux_init(&mtk_dp->aux);
>  	mtk_dp->aux.name = "aux_mtk_dp";
> +	mtk_dp->aux.dev = dev;
>  	mtk_dp->aux.transfer = mtk_dp_aux_transfer;
> +	drm_dp_aux_init(&mtk_dp->aux);
>  
>  	spin_lock_init(&mtk_dp->irq_thread_lock);
>  
