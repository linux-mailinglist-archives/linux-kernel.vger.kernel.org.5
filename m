Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2EC75E6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGXBWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGXBWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE71199B;
        Sun, 23 Jul 2023 18:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FF2B60F0B;
        Mon, 24 Jul 2023 01:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093C8C433C9;
        Mon, 24 Jul 2023 01:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161684;
        bh=q9wXs2vdlQqBAwU/WOt0Yv2LIN7QrO+UwP36iStkdO0=;
        h=From:To:Cc:Subject:Date:From;
        b=oLNLQ3Gsr2XkKoMkbCaefV5faDZ0ni1zdX84sMbOtZuUebmUimCQT0JkEzHW1w2vv
         R5N/68Waqc4vmlINNcLYfuL7uSP+w1nkKzYs6Oc2k41CuKu1U912AnssigcTBMLI1W
         /Lse4PouFvfK2dDSYMRntEPthcv7rd+HpG9HOL1fdrPTxaCKVXQkLHmdv+Nzk2raMv
         b4XJRr0YXTO3zfqzs4QyyXMDV0Y0JLeK/Hv/IhCFUK66kS1ZFido5Z46Bm5m8M7rxe
         ZkfFqktQnNbc7w5FapugUc1+5q3o+iCbdxnxKm7t2vyxd5hlWCcnmT99hDQsKWi/Z2
         yxOldFaEn/BKw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, Alvin.Lee2@amd.com,
        Jun.Lei@amd.com, qingqing.zhuo@amd.com, wenjing.liu@amd.com,
        Dillon.Varone@amd.com, mdaenzer@redhat.com,
        jiapeng.chong@linux.alibaba.com, Aric.Cyr@amd.com, mwen@igalia.com,
        sungjoon.kim@amd.com, hersenxs.wu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 01/41] drm/amd/display: Do not set drr on pipe commit
Date:   Sun, 23 Jul 2023 21:20:34 -0400
Message-Id: <20230724012118.2316073-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[ Upstream commit e101bf95ea87ccc03ac2f48dfc0757c6364ff3c7 ]

[WHY]
Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
pipe commit can cause underflow.

[HOW]
Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
optimized_required.

This change expects that Freesync requests are blocked when
optimized_required is true.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 2d49e99a152c4..7ff4a308152a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2021,6 +2021,12 @@ void dcn20_optimize_bandwidth(
 	if (hubbub->funcs->program_compbuf_size)
 		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
 
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		dc_dmub_srv_p_state_delegate(dc,
+			true, context);
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
+
 	dc->clk_mgr->funcs->update_clocks(
 			dc->clk_mgr,
 			context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index a1b312483d7f1..c97d3e81a83d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -987,11 +987,18 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
  	struct dc_state *context)
 {
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		dc->optimized_required = true;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
+	}
+
 	if (dc->clk_mgr->dc_mode_softmax_enabled)
 		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
 				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
+
+	dc_dmub_srv_p_state_delegate(dc, false, context);
 }
 
-- 
2.39.2

