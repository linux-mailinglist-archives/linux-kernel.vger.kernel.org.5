Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433147A1BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjIOKMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjIOKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:11:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF7269D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:11:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6E2C433C8;
        Fri, 15 Sep 2023 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694772707;
        bh=K0S1/7rjMJZap+e2ud7JWlak5LJu8FuoEdX+Kx2fq1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hwc3sq4NUs6XsWymG3LHd+7pjFr2rCrrVAW6fRTVYsXCUWZihNz2fagsUbBPPR6+r
         xmnsnL+uXsGhZ5DhWv4A+bQKBmgwOjOnZtof3qNqZsVe/GPBWAuD2O5bZ67v9mnA3s
         S10h0DVF6lLG4l0wWOfq43wu9Zi7Ybsdtgpcrahe71URAqCvr8QlYfGKyFs+LlH88M
         z8q/MTuLNGhy66aNB7vp/Fd3l6XiV3zAqcTpeg0rH7TTcyoM9Hv39wHMQM5+Vegz98
         2FJHbYcS7KjNcMglWhNKyeSMspE5PZyw3UNxQm770ZuL/j6c6kGha3nxRQ7Dp1PUTK
         +zjI85AJuHWFA==
From:   Michael Walle <mwalle@kernel.org>
To:     angelogioacchino.delregno@collabora.com
Cc:     airlied@gmail.com, chunkuang.hu@kernel.org, ck.hu@mediatek.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        jitao.shi@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        shaoming.chen@mediatek.com, yt.shen@mediatek.com,
        Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH] drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET settings/handling
Date:   Fri, 15 Sep 2023 12:11:24 +0200
Message-Id: <20230915101124.283232-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523104234.7849-1-angelogioacchino.delregno@collabora.com>
References: <20230523104234.7849-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> Fixes: 8b2b99fd7931 ("drm/mediatek: dsi: Fine tune the line time caused by EOTp")
> Fixes: 2d52bfba09d1 ("drm/mediatek: add non-continuous clock mode and EOT packet control")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Tested-by: Michael Walle <mwalle@kernel.org>

Thanks,
-michael
