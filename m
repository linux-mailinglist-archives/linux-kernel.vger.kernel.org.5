Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D3B7E3E43
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjKGMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjKGMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:35:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B17819AB;
        Tue,  7 Nov 2023 04:24:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562F9C433C7;
        Tue,  7 Nov 2023 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359879;
        bh=8bo9nTxEKIghzP26Wv5iUqa/qTN7TO8/CCvRxsg2xHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9kJoAikAWeQW3OqWbBjTN5LwzUuWuD2bNLexVtdUPNL19R2By8sB3uoNfthsiY8Q
         k1edBG5Ce2xEjaM9kQ49oIVckVrHh05RgjsYOukR6Kq7IM34BPM75+ZIWTebe5RER4
         piwzOGGKHkfCIwOR86Nxbz0Td4mw2bepi7GDamIhPKkrMlOTmGB1ckez3bJSjbd7v4
         ePgi8IIIalhlt/zfLBKM8yLnD9cFXywKXMmqvnHCLwhgYOsg6XBd7zbhgqlR9RA/FB
         aPLIyzaa9C/UQZ8G7unhiZfEVqbXEJUliz+kfiwn6YkbNnB/E0UbnqogTktAOQZLRM
         GUnOIYBjZCtbg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alvin Lee <Alvin.Lee2@amd.com>, Samson Tam <samson.tam@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, alvin.lee2@amd.com, jun.lei@amd.com,
        Qingqing.Zhuo@amd.com, wenjing.liu@amd.com, aric.cyr@amd.com,
        chiawen.huang@amd.com, hamza.mahfooz@amd.com,
        Wesley.Chalmers@amd.com, mdaenzer@redhat.com,
        Ilya.Bakoulin@amd.com, moadhuri@amd.com, syedsaaem.rizvi@amd.com,
        dillon.varone@amd.com, dmytro.laktyushkin@amd.com,
        chiahsuan.chung@amd.com, george.shen@amd.com, danny.wang@amd.com,
        mwen@igalia.com, hanghong.ma@amd.com, arthurgrillo@riseup.net,
        aurabindo.pillai@amd.com, duncan.ma@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 04/37] drm/amd/display: Blank phantom OTG before enabling
Date:   Tue,  7 Nov 2023 07:21:15 -0500
Message-ID: <20231107122407.3760584-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Lee <Alvin.Lee2@amd.com>

[ Upstream commit e87a6c5b7780b5f423797351eb586ed96cc6d151 ]

[Description]
Before enabling the phantom OTG for an update we
must enable DPG to avoid underflow.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 50 +------------------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 10 +++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 46 +++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  5 ++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  5 ++
 6 files changed, 68 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 609048160aa20..ab79bcd264164 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1070,53 +1070,6 @@ static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *contex
 	}
 }
 
-static void phantom_pipe_blank(
-		struct dc *dc,
-		struct timing_generator *tg,
-		int width,
-		int height)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	enum dc_color_space color_space;
-	struct tg_color black_color = {0};
-	struct output_pixel_processor *opp = NULL;
-	uint32_t num_opps, opp_id_src0, opp_id_src1;
-	uint32_t otg_active_width, otg_active_height;
-	uint32_t i;
-
-	/* program opp dpg blank color */
-	color_space = COLOR_SPACE_SRGB;
-	color_space_to_black_color(dc, color_space, &black_color);
-
-	otg_active_width = width;
-	otg_active_height = height;
-
-	/* get the OPTC source */
-	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
-	ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
-
-	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
-		if (dc->res_pool->opps[i] != NULL && dc->res_pool->opps[i]->inst == opp_id_src0) {
-			opp = dc->res_pool->opps[i];
-			break;
-		}
-	}
-
-	if (opp && opp->funcs->opp_set_disp_pattern_generator)
-		opp->funcs->opp_set_disp_pattern_generator(
-				opp,
-				CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
-				CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-				COLOR_DEPTH_UNDEFINED,
-				&black_color,
-				otg_active_width,
-				otg_active_height,
-				0);
-
-	if (tg->funcs->is_tg_enabled(tg))
-		hws->funcs.wait_for_blank_complete(opp);
-}
-
 static void dc_update_viusal_confirm_color(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
 {
 	if (dc->ctx->dce_version >= DCN_VERSION_1_0) {
@@ -1207,7 +1160,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 
 					main_pipe_width = old_stream->mall_stream_config.paired_stream->dst.width;
 					main_pipe_height = old_stream->mall_stream_config.paired_stream->dst.height;
-					phantom_pipe_blank(dc, tg, main_pipe_width, main_pipe_height);
+					if (dc->hwss.blank_phantom)
+						dc->hwss.blank_phantom(dc, tg, main_pipe_width, main_pipe_height);
 					tg->funcs->enable_crtc(tg);
 				}
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 62a077adcdbfa..84fe449a2c7ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1846,8 +1846,16 @@ void dcn20_program_front_end_for_ctx(
 			dc->current_state->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			struct timing_generator *tg = dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg;
 
-			if (tg->funcs->enable_crtc)
+			if (tg->funcs->enable_crtc) {
+				if (dc->hwss.blank_phantom) {
+					int main_pipe_width, main_pipe_height;
+
+					main_pipe_width = dc->current_state->res_ctx.pipe_ctx[i].stream->mall_stream_config.paired_stream->dst.width;
+					main_pipe_height = dc->current_state->res_ctx.pipe_ctx[i].stream->mall_stream_config.paired_stream->dst.height;
+					dc->hwss.blank_phantom(dc, tg, main_pipe_width, main_pipe_height);
+				}
 				tg->funcs->enable_crtc(tg);
+			}
 		}
 	}
 	/* OTG blank before disabling all front ends */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index d52d5feeb311b..b6608d7ab4450 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1575,3 +1575,49 @@ void dcn32_init_blank(
 	if (opp)
 		hws->funcs.wait_for_blank_complete(opp);
 }
+
+void dcn32_blank_phantom(struct dc *dc,
+		struct timing_generator *tg,
+		int width,
+		int height)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	enum dc_color_space color_space;
+	struct tg_color black_color = {0};
+	struct output_pixel_processor *opp = NULL;
+	uint32_t num_opps, opp_id_src0, opp_id_src1;
+	uint32_t otg_active_width, otg_active_height;
+	uint32_t i;
+
+	/* program opp dpg blank color */
+	color_space = COLOR_SPACE_SRGB;
+	color_space_to_black_color(dc, color_space, &black_color);
+
+	otg_active_width = width;
+	otg_active_height = height;
+
+	/* get the OPTC source */
+	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
+	ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
+
+	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
+		if (dc->res_pool->opps[i] != NULL && dc->res_pool->opps[i]->inst == opp_id_src0) {
+			opp = dc->res_pool->opps[i];
+			break;
+		}
+	}
+
+	if (opp && opp->funcs->opp_set_disp_pattern_generator)
+		opp->funcs->opp_set_disp_pattern_generator(
+				opp,
+				CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
+				CONTROLLER_DP_COLOR_SPACE_UDEFINED,
+				COLOR_DEPTH_UNDEFINED,
+				&black_color,
+				otg_active_width,
+				otg_active_height,
+				0);
+
+	if (tg->funcs->is_tg_enabled(tg))
+		hws->funcs.wait_for_blank_complete(opp);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 2d2628f31bed7..616d5219119e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -115,4 +115,9 @@ void dcn32_init_blank(
 		struct dc *dc,
 		struct timing_generator *tg);
 
+void dcn32_blank_phantom(struct dc *dc,
+		struct timing_generator *tg,
+		int width,
+		int height);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 777b2fac20c4e..279f312f74076 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -115,6 +115,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
 	.update_dsc_pg = dcn32_update_dsc_pg,
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
+	.blank_phantom = dcn32_blank_phantom,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 02ff99f7bec2b..7a702e216e530 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -388,6 +388,11 @@ struct hw_sequencer_funcs {
 	void (*z10_restore)(const struct dc *dc);
 	void (*z10_save_init)(struct dc *dc);
 
+	void (*blank_phantom)(struct dc *dc,
+			struct timing_generator *tg,
+			int width,
+			int height);
+
 	void (*update_visual_confirm_color)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			int mpcc_id);
-- 
2.42.0

