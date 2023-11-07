Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD937E3D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjKGM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjKGM2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:28:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69E262CA;
        Tue,  7 Nov 2023 04:19:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DF4C433C8;
        Tue,  7 Nov 2023 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359566;
        bh=uQ9NtKoixX1kZI3/vE3JH4NF9hW7VI/vaRKE9imZ5AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbmIpGbPV+R7/D7GWG/1eu5ACWX75DkBnwMmHqV367Ey6ko36HxD596DJU2JB7MS8
         dd7pyS/Lr/0DEvsnbEMEpupfT2nQaMHMLVO6dh3Q1pRL64uxnzT1VCnyjaOZaOmDkA
         Sig/EPNIN1Kq51oO1rfS+fehLUk3RzpfzzFqzhavtLBC1trvBWM8kfa5MuL/1EZ+0I
         OsNUN9N4Ongx+5Spc5XJYpH4bJGA0S6OZEWaSAAEE2dqyQRefPo0i99zJdlEkRslJ0
         pKuOQTi90l05w+LU8c1LFhrq966xqZynqzGVzHLUYnAxgzKjqo2aTdK9drY9aLqtiK
         iJGZ/LtVgot3g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenjing Liu <wenjing.liu@amd.com>,
        Dillon Varone <dillon.varone@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, alvin.lee2@amd.com, jun.lei@amd.com,
        Qingqing.Zhuo@amd.com, samson.tam@amd.com, aric.cyr@amd.com,
        chiawen.huang@amd.com, syedsaaem.rizvi@amd.com, moadhuri@amd.com,
        dmytro.laktyushkin@amd.com, Wesley.Chalmers@amd.com,
        chiahsuan.chung@amd.com, danny.wang@amd.com, george.shen@amd.com,
        aurabindo.pillai@amd.com, hanghong.ma@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 06/40] drm/amd/display: add seamless pipe topology transition check
Date:   Tue,  7 Nov 2023 07:16:08 -0500
Message-ID: <20231107121837.3759358-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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

From: Wenjing Liu <wenjing.liu@amd.com>

[ Upstream commit 15c6798ae26d5c7a7776f4f7d0c1fa8c462688a2 ]

[why]
We have a few cases where we need to perform update topology update
in dc update interface. However some of the updates are not seamless
This could cause user noticible glitches. To enforce seamless transition
we are adding a checking condition and error logging so the corruption
as result of non seamless transition can be easily spotted.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 +++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 52 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  4 ++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  3 ++
 5 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3b9d6fa50d170..14c3c1907b953 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4328,6 +4328,14 @@ bool dc_update_planes_and_stream(struct dc *dc,
 				update_type,
 				context);
 	} else {
+		if (!stream_update &&
+				dc->hwss.is_pipe_topology_transition_seamless &&
+				!dc->hwss.is_pipe_topology_transition_seamless(
+						dc, dc->current_state, context)) {
+
+			DC_LOG_ERROR("performing non-seamless pipe topology transition with surface only update!\n");
+			BREAK_TO_DEBUGGER();
+		}
 		commit_planes_for_stream(
 				dc,
 				srf_updates,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index cae5e1e68c860..018376146d977 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1619,3 +1619,55 @@ void dcn32_blank_phantom(struct dc *dc,
 	if (tg->funcs->is_tg_enabled(tg))
 		hws->funcs.wait_for_blank_complete(opp);
 }
+
+bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
+		const struct dc_state *cur_ctx,
+		const struct dc_state *new_ctx)
+{
+	int i;
+	const struct pipe_ctx *cur_pipe, *new_pipe;
+	bool is_seamless = true;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		cur_pipe = &cur_ctx->res_ctx.pipe_ctx[i];
+		new_pipe = &new_ctx->res_ctx.pipe_ctx[i];
+
+		if (resource_is_pipe_type(cur_pipe, FREE_PIPE) ||
+				resource_is_pipe_type(new_pipe, FREE_PIPE))
+			/* adding or removing free pipes is always seamless */
+			continue;
+		else if (resource_is_pipe_type(cur_pipe, OTG_MASTER)) {
+			if (resource_is_pipe_type(new_pipe, OTG_MASTER))
+				if (cur_pipe->stream->stream_id == new_pipe->stream->stream_id)
+				/* OTG master with the same stream is seamless */
+					continue;
+		} else if (resource_is_pipe_type(cur_pipe, OPP_HEAD)) {
+			if (resource_is_pipe_type(new_pipe, OPP_HEAD)) {
+				if (cur_pipe->stream_res.tg == new_pipe->stream_res.tg)
+					/*
+					 * OPP heads sharing the same timing
+					 * generator is seamless
+					 */
+					continue;
+			}
+		} else if (resource_is_pipe_type(cur_pipe, DPP_PIPE)) {
+			if (resource_is_pipe_type(new_pipe, DPP_PIPE)) {
+				if (cur_pipe->stream_res.opp == new_pipe->stream_res.opp)
+					/*
+					 * DPP pipes sharing the same OPP head is
+					 * seamless
+					 */
+					continue;
+			}
+		}
+
+		/*
+		 * This pipe's transition doesn't fall under any seamless
+		 * conditions
+		 */
+		is_seamless = false;
+		break;
+	}
+
+	return is_seamless;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 616d5219119e9..9992e40acd217 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -120,4 +120,8 @@ void dcn32_blank_phantom(struct dc *dc,
 		int width,
 		int height);
 
+bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
+		const struct dc_state *cur_ctx,
+		const struct dc_state *new_ctx);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index eb4227926006a..1edadff39a5ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -116,6 +116,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.update_dsc_pg = dcn32_update_dsc_pg,
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
 	.blank_phantom = dcn32_blank_phantom,
+	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 7a702e216e530..66e680902c95c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -401,6 +401,9 @@ struct hw_sequencer_funcs {
 			struct dc_state *context,
 			struct pipe_ctx *phantom_pipe);
 	void (*apply_update_flags_for_phantom)(struct pipe_ctx *phantom_pipe);
+	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
+			const struct dc_state *cur_ctx,
+			const struct dc_state *new_ctx);
 
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
-- 
2.42.0

