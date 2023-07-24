Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9412775E5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGXBNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGXBNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:13:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295AE1B3;
        Sun, 23 Jul 2023 18:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CFC160EFC;
        Mon, 24 Jul 2023 01:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C281CC433C8;
        Mon, 24 Jul 2023 01:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161228;
        bh=+TJGO4/ZmIlOp7lWICardyjuXbS+sdzOoTX6AM8rstw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZaBemvMt+MONrryRz2F/+IQqwjJ9ot4/vNq0sQc2yJ0ayEG/YLSSD0jmZYb25mjQ
         JYHZPD8b6vxz0UEWyLXQyKDk80sDZlydkG8JHSGuKtMYN4WDCS0k1buMf+ko4+i2Nq
         Z8R1P8M7zuzGKSehNuTSOBUu+cvKZjC15KKH+LZ4pmdrtEq7cEIKPT+V4NSnRHe7NK
         +Bm2dRD24QWNdQr5d029A46Z8tUZk73GJFVpjfS+1C1S8DXKry1h6V+yPqPwzCKwWK
         vdq89+MSXpmaJroHZw5yn4XLLJbIraqAEBmrmCpCkgL4tDoCZPjgmV7xuzyrEUSS8/
         S2wchO3tsGX+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alvin Lee <Alvin.Lee2@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, alvin.lee2@amd.com, jun.lei@amd.com,
        qingqing.zhuo@amd.com, Dillon.Varone@amd.com, samson.tam@amd.com,
        wenjing.liu@amd.com, Chris.Park@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 02/58] drm/amd/display: Update DTBCLK for DCN32
Date:   Sun, 23 Jul 2023 21:12:30 -0400
Message-Id: <20230724011338.2298062-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Lee <Alvin.Lee2@amd.com>

[ Upstream commit 128c1ca0303fe764a4cde5f761e72810d9e40b6e ]

[Why&How]
- Implement interface to program DTBCLK DTO’s
  according to reference DTBCLK returned by PMFW
- This is required because DTO programming
  requires exact DTBCLK reference freq or it could
  result in underflow

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 8d9444db092ab..eea103908b09f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -233,6 +233,32 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	DC_FP_END();
 }
 
+static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
+			struct dc_state *context,
+			int ref_dtbclk_khz)
+{
+	struct dccg *dccg = clk_mgr->dccg;
+	uint32_t tg_mask = 0;
+	int i;
+
+	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+		struct dtbclk_dto_params dto_params = {0};
+
+		/* use mask to program DTO once per tg */
+		if (pipe_ctx->stream_res.tg &&
+				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
+			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
+
+			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
+			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
+
+			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
+			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
+		}
+	}
+}
+
 /* Since DPPCLK request to PMFW needs to be exact (due to DPP DTO programming),
  * update DPPCLK to be the exact frequency that will be set after the DPPCLK
  * divider is updated. This will prevent rounding issues that could cause DPP
@@ -570,6 +596,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* DCCG requires KHz precision for DTBCLK */
 		clk_mgr_base->clks.ref_dtbclk_khz =
 				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DTBCLK, khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz));
+		dcn32_update_clocks_update_dtb_dto(clk_mgr, context, clk_mgr_base->clks.ref_dtbclk_khz);
 	}
 
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
-- 
2.39.2

