Return-Path: <linux-kernel+bounces-33291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84758836803
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AAF1C20B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74040BF0;
	Mon, 22 Jan 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIOZHMIA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5A41234;
	Mon, 22 Jan 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935666; cv=none; b=B+iM0akCeebgOe12X/gQOxLcIIUVjXEXE8/ZtW/FuL4W7AzWGy1OpYmJfCyQzsHCyJFeTrRYbpTBIQJ55sAroGgkAWCe3CoYaPSnitPJhrDVgQl3+iokkZaiQJi/NdbhHqJG6x6orwXExUSyRBMe6Fbrv9sVAKr1MDhDB3EbxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935666; c=relaxed/simple;
	bh=vSXH9S5fPCcb5miNeZI3+Bfvyh+vxHE6G/x7Q/8vLL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcA6wVKVpUjNwGUTYbHl5TdFA6NRFE6/RyeL++h8OudBqQcvrRR8XYFEzAanuAbHJ169VI0rKRzZv1NytwWFwE7e/I7r08LIkmi1sEIYb9dpsjpf5R8fOybbsnCvJbkYuzJohxIE1dZnSn8To8OWgiLvlMGhvZqyla263JW9UFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIOZHMIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A524CC433F1;
	Mon, 22 Jan 2024 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935666;
	bh=vSXH9S5fPCcb5miNeZI3+Bfvyh+vxHE6G/x7Q/8vLL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIOZHMIA5en9DO82eJNbIubKUoYr11WYWQ++7jt/BdwFJhhrVrIhBJI9jK4R0Ww/V
	 SyspSHvpXULSR+FblN8+qdI9te+/L81+lnylNkjdKkMeut/RCTyqHmLITgjhJpF+Do
	 36zzq7QpSd6cdInsL5waY4G5wx1GRjSw9rd/PqtZHRAZiPt/uKx0atzlBqWyXeusPq
	 +gbikKIKKN90OUzdKNvG150NJshaxLN73WtDeF2LwZ5/kD5XC4npSo2qbDrdqBNvEm
	 3gIh6AuU00jzuTLyeryrPGOyPgCcLkz+GzyctXys+A1IcKwhSkYYILeNfZbIe4Udyl
	 XDGoCobpgBxtA==
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
	jun.lei@amd.com,
	hamza.mahfooz@amd.com,
	charlene.liu@amd.com,
	ian.chen@amd.com,
	sancchen@amd.com,
	Jingwen.Zhu@amd.com,
	swapnil.patel@amd.com,
	qingqing.zhuo@amd.com,
	nicholas.kazlauskas@amd.com,
	dillon.varone@amd.com,
	syed.hassan@amd.com,
	mwen@igalia.com,
	Wesley.Chalmers@amd.com,
	mdaenzer@redhat.com,
	alex.hung@amd.com,
	Josip.Pavic@amd.com,
	sungjoon.kim@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 69/88] drm/amd/display: Only clear symclk otg flag for HDMI
Date: Mon, 22 Jan 2024 09:51:42 -0500
Message-ID: <20240122145608.990137-69-sashal@kernel.org>
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
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 960a55e06375..c0d2e8454efc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -2124,7 +2124,8 @@ static void dce110_reset_hw_ctx_wrap(
 				BREAK_TO_DEBUGGER();
 			}
 			pipe_ctx_old->stream_res.tg->funcs->disable_crtc(pipe_ctx_old->stream_res.tg);
-			pipe_ctx_old->stream->link->phy_state.symclk_ref_cnts.otg = 0;
+			if (dc_is_hdmi_tmds_signal(pipe_ctx_old->stream->signal))
+				pipe_ctx_old->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 			pipe_ctx_old->plane_res.mi->funcs->free_mem_input(
 					pipe_ctx_old->plane_res.mi, dc->current_state->stream_count);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index cdb903116eb7..1fc8436c8130 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1057,7 +1057,8 @@ static void dcn10_reset_back_end_for_pipe(
 		if (pipe_ctx->stream_res.tg->funcs->set_drr)
 			pipe_ctx->stream_res.tg->funcs->set_drr(
 					pipe_ctx->stream_res.tg, NULL);
-		pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
+		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+			pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c3c83178eb1e..da0181fef411 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2610,7 +2610,8 @@ static void dcn20_reset_back_end_for_pipe(
 		 * the case where the same symclk is shared across multiple otg
 		 * instances
 		 */
-		link->phy_state.symclk_ref_cnts.otg = 0;
+		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+			link->phy_state.symclk_ref_cnts.otg = 0;
 		if (link->phy_state.symclk_state == SYMCLK_ON_TX_OFF) {
 			link_hwss->disable_link_output(link,
 					&pipe_ctx->link_res, pipe_ctx->stream->signal);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 97798cee876e..3a40b7359a30 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
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


