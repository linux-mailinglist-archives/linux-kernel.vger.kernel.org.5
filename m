Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C163B777DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbjHJQNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbjHJQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:13:12 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB54216
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oaPPgI4MashoQdDxkkKwWaQcDqhEIAnnmpGRJpRzwzI=; b=QXkGrPaQKwo1SsNQ9e0LLubWkg
        OlghZ1URClqKPyPJyg0h73Rxp6PLiVmIfRASw3DHovCPuli6+33SLv43XcLj49L3YctvIBUZasiuT
        dM82KFLKypPcg78P7z/x/XR3yfINSYFfu7x7YrWC+RsxpnPRN79iApfFDvTBwRAYnhiqCWehp9dRw
        GW69NX1oLOIshRFy7eQbm6Z+eu0PhdglorRYAkqhgG9rw6ZWbTPNI3TPPgpenzZIuU41O8/QH6nxk
        mtNtwj0Z3l7Cexltmvt4zbHz9nZmVl62zxtzkIyxxEFwF3ZzAbqbTi+7VzOuUZTSWdmUnu03ffxBa
        9drFb0Gg==;
Received: from [38.44.68.151] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qU89B-00GjYD-8X; Thu, 10 Aug 2023 18:04:25 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Simon Ser <contact@emersion.fr>, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/34] drm/amd/display: set stream gamut remap matrix to MPC for DCN301
Date:   Thu, 10 Aug 2023 15:03:11 -0100
Message-Id: <20230810160314.48225-32-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810160314.48225-1-mwen@igalia.com>
References: <20230810160314.48225-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dc->caps.color.mpc.gamut_remap says there is a post-blending color block
for gamut remap matrix for DCN3 HW family and newer versions. However,
those drivers still follow DCN10 programming that remap stream
gamut_remap_matrix to DPP (pre-blending).

To enable pre-blending and post-blending gamut_remap matrix supports at
the same time, set stream gamut_remap to MPC and plane gamut_remap to
DPP for DCN301 that support both.

It was tested using IGT KMS color tests for DRM CRTC CTM property and it
preserves test results.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 37 +++++++++++++++++++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  3 ++
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 4cd4ae07d73d..4fb4e9ec03f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -186,6 +186,43 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
 	return result;
 }
 
+void dcn30_program_gamut_remap(struct pipe_ctx *pipe_ctx)
+{
+	int i = 0;
+	struct dpp_grph_csc_adjustment dpp_adjust;
+	struct mpc_grph_gamut_adjustment mpc_adjust;
+	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
+	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
+
+	memset(&dpp_adjust, 0, sizeof(dpp_adjust));
+	dpp_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
+
+	if (pipe_ctx->plane_state &&
+	    pipe_ctx->plane_state->gamut_remap_matrix.enable_remap == true) {
+		dpp_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
+		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
+			dpp_adjust.temperature_matrix[i] =
+				pipe_ctx->plane_state->gamut_remap_matrix.matrix[i];
+	}
+
+	pipe_ctx->plane_res.dpp->funcs->dpp_set_gamut_remap(pipe_ctx->plane_res.dpp,
+							    &dpp_adjust);
+
+	memset(&mpc_adjust, 0, sizeof(mpc_adjust));
+	mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
+
+	if (pipe_ctx->top_pipe == NULL) {
+		if (pipe_ctx->stream->gamut_remap_matrix.enable_remap == true) {
+			mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
+			for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
+				mpc_adjust.temperature_matrix[i] =
+					pipe_ctx->stream->gamut_remap_matrix.matrix[i];
+		}
+	}
+
+	mpc->funcs->set_gamut_remap(mpc, mpcc_id, &mpc_adjust);
+}
+
 bool dcn30_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index a24a8e33a3d2..cb34ca932a5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -58,6 +58,9 @@ bool dcn30_set_blend_lut(struct pipe_ctx *pipe_ctx,
 bool dcn30_set_input_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state);
+
+void dcn30_program_gamut_remap(struct pipe_ctx *pipe_ctx);
+
 bool dcn30_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 257df8660b4c..81fd50ee97c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -33,7 +33,7 @@
 #include "dcn301_init.h"
 
 static const struct hw_sequencer_funcs dcn301_funcs = {
-	.program_gamut_remap = dcn10_program_gamut_remap,
+	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
 	.power_down_on_boot = dcn10_power_down_on_boot,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
-- 
2.40.1

