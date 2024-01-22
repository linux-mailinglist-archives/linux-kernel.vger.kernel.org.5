Return-Path: <linux-kernel+bounces-33239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A588A83670A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A5428D318
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0150D3EA73;
	Mon, 22 Jan 2024 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY8rgJkl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE564D58D;
	Mon, 22 Jan 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935468; cv=none; b=KAWWxpyvj2WeSIRdvU1N3jCCuHnvJ7z5VLt44G3JAdTYC81dNrPLgKFTaIkZq+Q6r4ds8Vz8KJsTqdmdRMSJ046Rmi8WIz7WBmEEwLo+X/+2ZvTDBcN/7XzEEAmvebX5QaaPxb6lAWx2gijNG9lx1R9tZ/5ACVugQJXl82AwkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935468; c=relaxed/simple;
	bh=oTlEJQ6n1BAEPHYa7YZQPzuF1/U2beYBgdTRAQx4Sqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKWp/mO1x0YNrV3v9L3xGBvB9SBsN7poIDRV8k8g1TcNWjUYlcb4N9VpVan5bFHbbuTGLuB0HS/Cf3dhahD/oHKQhK86MTotmKO8XABSMbIFGQtQuRdNAB6/S93gY6GF2AKhv+8vBx+fJk/cMJVEV8EEPBflWfxJ2sUZm+f9F8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY8rgJkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196C7C433F1;
	Mon, 22 Jan 2024 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935467;
	bh=oTlEJQ6n1BAEPHYa7YZQPzuF1/U2beYBgdTRAQx4Sqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eY8rgJklG7hTVDT2Rq+s65NPw0re6kVQorJzUI5US4vJuvIlA0vQYTNmTG1w7rTF8
	 ixfYzx1tL3sX7py5T6mLyomx1v7N0n6QrnkvnFQ2nQGWk8Ig1n9Ctpru4mtNoWjb6S
	 G4YI0IgyQ6s41dp/X/nYu5Z/FFa5PFzE4GvCXSgkifqXcGx9D0otd+s0iECTAqSjkT
	 3SQa2bRzFE9Vy/5ePoiiMXt7c4MYLQzUlevIhy9mM6XEeD1TDlRn+lPrd6RuArwUAb
	 LKzoRud92mJzJp7MWFLhijtP7f2BUrpOQXJDFixHl2YJ5idY5kV1RTuXoxY2u0feh+
	 tHpW4QLOxnH0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wenjing Liu <wenjing.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	qingqing.zhuo@amd.com,
	jun.lei@amd.com,
	syedsaaem.rizvi@amd.com,
	dillon.varone@amd.com,
	hamza.mahfooz@amd.com,
	nicholas.kazlauskas@amd.com,
	aurabindo.pillai@amd.com,
	syed.hassan@amd.com,
	daniel.miess@amd.com,
	ilya.bakoulin@amd.com,
	Jingwen.Zhu@amd.com,
	peichen.huang@amd.com,
	jiapeng.chong@linux.alibaba.com,
	wayne.lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 21/88] drm/amd/display: add support for DTO genarated dscclk
Date: Mon, 22 Jan 2024 09:50:54 -0500
Message-ID: <20240122145608.990137-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Wenjing Liu <wenjing.liu@amd.com>

[ Upstream commit 08a32addf17317b9fac55be9b31275cbf6e41fb7 ]

Current implementation will choose to use refclk as dscclk. This is not
recommended by hardware team as refclk is a fixed value which could
cause unnecessary power consumption or it could be not enough for large
DSC timings. So we are adding new interfaces so we could switch to use
dynamically generated DSCCLK by DTO. So DSCCLK is programmable based on
current pixel clock and dispclk.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 25 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 +++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 27 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index c1a9b746c43f..0f0972ad441a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -995,9 +995,22 @@ static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
 static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
+	struct dccg *dccg = dc->res_pool->dccg;
+	/* It has been found that when DSCCLK is lower than 16Mhz, we will get DCN
+	 * register access hung. When DSCCLk is based on refclk, DSCCLk is always a
+	 * fixed value higher than 16Mhz so the issue doesn't occur. When DSCCLK is
+	 * generated by DTO, DSCCLK would be based on 1/3 dispclk. For small timings
+	 * with DSC such as 480p60Hz, the dispclk could be low enough to trigger
+	 * this problem. We are implementing a workaround here to keep using dscclk
+	 * based on fixed value refclk when timing is smaller than 3x16Mhz (i.e
+	 * 48Mhz) pixel clock to avoid hitting this problem.
+	 */
+	bool should_use_dto_dscclk = (dccg->funcs->set_dto_dscclk != NULL) &&
+			stream->timing.pix_clk_100hz > 480000;
 
 	ASSERT(dsc);
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
@@ -1020,12 +1033,16 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
+		if (should_use_dto_dscclk)
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			ASSERT(odm_dsc);
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
+			if (should_use_dto_dscclk)
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
 		dsc_cfg.pic_width *= opp_cnt;
@@ -1045,9 +1062,13 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 				OPTC_DSC_DISABLED, 0, 0);
 
 		/* disable DSC block */
+		if (dccg->funcs->set_ref_dscclk)
+			dccg->funcs->set_ref_dscclk(dccg, pipe_ctx->stream_res.dsc->inst);
 		dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			ASSERT(odm_pipe->stream_res.dsc);
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
 			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
 		}
 	}
@@ -1130,6 +1151,10 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		if (!pipe_ctx->next_odm_pipe && current_pipe_ctx->next_odm_pipe &&
 				current_pipe_ctx->next_odm_pipe->stream_res.dsc) {
 			struct display_stream_compressor *dsc = current_pipe_ctx->next_odm_pipe->stream_res.dsc;
+			struct dccg *dccg = dc->res_pool->dccg;
+
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
 			/* disconnect DSC block from stream */
 			dsc->funcs->dsc_disconnect(dsc);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index ce2f0c0e82bd..6b44557fcb1a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -201,6 +201,10 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			enum streamclk_source src,
 			uint32_t otg_inst);
+	void (*set_dto_dscclk)(
+			struct dccg *dccg,
+			uint32_t dsc_inst);
+	void (*set_ref_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
 };
 
 #endif //__DAL_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index a3b3aec05d6b..fc08ff8bebc3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -776,10 +776,26 @@ static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
  */
 void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
+	/* TODO: Move this to HWSS as this is hardware programming sequence not a
+	 * link layer sequence
+	 */
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
+	struct dccg *dccg = dc->res_pool->dccg;
+	/* It has been found that when DSCCLK is lower than 16Mhz, we will get DCN
+	 * register access hung. When DSCCLk is based on refclk, DSCCLk is always a
+	 * fixed value higher than 16Mhz so the issue doesn't occur. When DSCCLK is
+	 * generated by DTO, DSCCLK would be based on 1/3 dispclk. For small timings
+	 * with DSC such as 480p60Hz, the dispclk could be low enough to trigger
+	 * this problem. We are implementing a workaround here to keep using dscclk
+	 * based on fixed value refclk when timing is smaller than 3x16Mhz (i.e
+	 * 48Mhz) pixel clock to avoid hitting this problem.
+	 */
+	bool should_use_dto_dscclk = (dccg->funcs->set_dto_dscclk != NULL) &&
+			stream->timing.pix_clk_100hz > 480000;
 	DC_LOGGER_INIT(dsc->ctx->logger);
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
@@ -802,11 +818,15 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
+		if (should_use_dto_dscclk)
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
+			if (should_use_dto_dscclk)
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
 		dsc_cfg.pic_width *= opp_cnt;
@@ -856,9 +876,14 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 
 		/* disable DSC block */
+		if (dccg->funcs->set_ref_dscclk)
+			dccg->funcs->set_ref_dscclk(dccg, pipe_ctx->stream_res.dsc->inst);
 		pipe_ctx->stream_res.dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
-		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
 			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
+		}
 	}
 }
 
-- 
2.43.0


