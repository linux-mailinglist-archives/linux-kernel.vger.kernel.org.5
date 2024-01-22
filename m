Return-Path: <linux-kernel+bounces-33381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB68836909
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DC21F21CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9764B5A6;
	Mon, 22 Jan 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f26+BTBD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B24A9B2;
	Mon, 22 Jan 2024 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936065; cv=none; b=YF96gMTo9REQRCntvxnPJArNmrxBhNSB7QmMinzgovrfvq00H0UxDt7P2spxhWK5gcTWoGPKsMss/5KgoVWDk2uvFqjcd6UcHdA9vVvyKiSN0bWEr8VrXUzZqNjWIOZj/tA2c0uuzSR/sBxf+m+XtFGbbM/h1EZLS57Csj7fSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936065; c=relaxed/simple;
	bh=NxY2BJfXCJWy69+PBMPqNu99DBm4MXohyICZzcRcjo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2h+8oCOPFmX+b5mL8roZGG/LZdSy9HWcGz8acL0BoBwEWLeMjO8EdeN21eU4shEBD2XzQskVHTy4bDt76vPZdQpyl+2wVCD6dcnH+OUHDdXR+Kcf7uNAdA4Tv0U2m1u10muCqNDBX3sYxAFbo9W+A4+WaazisXPEJFtyILR2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f26+BTBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10A1C433F1;
	Mon, 22 Jan 2024 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936064;
	bh=NxY2BJfXCJWy69+PBMPqNu99DBm4MXohyICZzcRcjo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f26+BTBDs2JDftTHng7LsyKbxG8hxvkqw0OeIlPVr8habKL9sUnG9LqH3HpwnGue1
	 9ukhwtUPDwyhoQ63J660yb5hVM+/YjpmrhlcmVmYmNjC7+rHQUIyMJHqNbFVBA1k5S
	 ws5O8AfTVckGYfI1m2qdU/xslICMe8ooIFpZbkhRNNCDSlr7J9pvzYseK9ZRu38sYL
	 1y2K8PUPgcHde2RGaqybWNndMkbBsY88V3vr3ab+32ICHZkrivIf5bNuTGm/pTV9vv
	 Tl1mp7mBNITY0LRC/rKuSy/do4LPAqrW80NvQ1CZ9EmhQbObcOznG+4V0r+F08D1L0
	 l0EezpcH2VtMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alvin Lee <alvin.lee2@amd.com>,
	Samson Tam <samson.tam@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	charlene.liu@amd.com,
	hamza.mahfooz@amd.com,
	qingqing.zhuo@amd.com,
	syed.hassan@amd.com,
	ahmed.ahmed@amd.com,
	mario.limonciello@amd.com,
	Jingwen.Zhu@amd.com,
	moadhuri@amd.com,
	jun.lei@amd.com,
	nicholas.kazlauskas@amd.com,
	mwen@igalia.com,
	hanghong.ma@amd.com,
	Wesley.Chalmers@amd.com,
	mdaenzer@redhat.com,
	gabe.teeger@amd.com,
	ilya.bakoulin@amd.com,
	Josip.Pavic@amd.com,
	sungjoon.kim@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 57/73] drm/amd/display: Only clear symclk otg flag for HDMI
Date: Mon, 22 Jan 2024 10:02:11 -0500
Message-ID: <20240122150432.992458-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit dff45f03f508c92cd8eb2050e27b726726b8ae0b ]

[Description]
There is a corner case where the symclk otg flag is cleared
when disabling the phantom pipe for subvp (because the phantom
and main pipe share the same link). This is undesired because
we need the maintain the correct symclk otg flag state for
the main pipe.

For now only clear the flag only for HDMI signal type, since
it's only set for HDMI signal type (phantom is virtual). The
ideal solution is to not clear it if the stream is phantom but
currently there's a bug that doesn't allow us to do this. Once
this issue is fixed the proper fix can be implemented.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c          | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c          | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 9c78e42418f3..93699176a7e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2124,7 +2124,8 @@ static void dce110_reset_hw_ctx_wrap(
 				BREAK_TO_DEBUGGER();
 			}
 			pipe_ctx_old->stream_res.tg->funcs->disable_crtc(pipe_ctx_old->stream_res.tg);
-			pipe_ctx_old->stream->link->phy_state.symclk_ref_cnts.otg = 0;
+			if (dc_is_hdmi_tmds_signal(pipe_ctx_old->stream->signal))
+				pipe_ctx_old->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 			pipe_ctx_old->plane_res.mi->funcs->free_mem_input(
 					pipe_ctx_old->plane_res.mi, dc->current_state->stream_count);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 13ccb57379c7..db1d7be7fda3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1054,7 +1054,8 @@ static void dcn10_reset_back_end_for_pipe(
 		if (pipe_ctx->stream_res.tg->funcs->set_drr)
 			pipe_ctx->stream_res.tg->funcs->set_drr(
 					pipe_ctx->stream_res.tg, NULL);
-		pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
+		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+			pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 2c4bcbca8bb8..1e3803739ae6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2533,7 +2533,8 @@ static void dcn20_reset_back_end_for_pipe(
 		 * the case where the same symclk is shared across multiple otg
 		 * instances
 		 */
-		link->phy_state.symclk_ref_cnts.otg = 0;
+		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+			link->phy_state.symclk_ref_cnts.otg = 0;
 		if (link->phy_state.symclk_state == SYMCLK_ON_TX_OFF) {
 			link_hwss->disable_link_output(link,
 					&pipe_ctx->link_res, pipe_ctx->stream->signal);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 2a7f47642a44..22da2007601e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -523,7 +523,8 @@ static void dcn31_reset_back_end_for_pipe(
 	if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
-	pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
+	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+		pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 
 	if (pipe_ctx->stream_res.tg->funcs->set_drr)
 		pipe_ctx->stream_res.tg->funcs->set_drr(
-- 
2.43.0


