Return-Path: <linux-kernel+bounces-33299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A6C836820
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1861C23024
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358A4643F;
	Mon, 22 Jan 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTJDfLjx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341EB5EE87;
	Mon, 22 Jan 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935707; cv=none; b=mrN7A1NAldHCcCTWqO+ik+LLjxIR3YpNNfrQ9z/3dTabGiBZ4xSpUxtaA23AvOXVrX6C58Gwqtb7iR3xfktJhStAN/UXlfovOUmCMas1bH4w91TVUuYVFpehQSfNV9SjbRd8qS+BdzoU7WpjByNoFe2JDctFp6SJacI+caupyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935707; c=relaxed/simple;
	bh=/8AO20DIpVDP6VzxYTnZffLbt3oHDKbZIwiAMnZot9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRluj7xmkVAG6OL8tJKXMTtYs/qH10/M6cFx9FSxtDOiFJ4xIld1i4F+rEuB06/QHLz6zH3SY/Jw4nCm3xZgoMaaano2FB7LqavQQqQ2wowBXQqmXjImJ3Tpu/y4S8PO6dX9cznIGOsTXzBhnZnPWI7K945kqkSJMPLY9I81kDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTJDfLjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C8DC433A6;
	Mon, 22 Jan 2024 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935706;
	bh=/8AO20DIpVDP6VzxYTnZffLbt3oHDKbZIwiAMnZot9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTJDfLjx6BE3WQpRqzw2Sy1pTPrwXztPgIdeeeVLeRiJlMMZqJ8pLFNLyI37lO4az
	 WXywU/M9HRZ+5yk+jpcq7kd+1fcKnEMm8AZ/3v5SKQQiAvCeC+6yq2RIC0VgeZIBUy
	 WAsnl7xGYqv9nbhscxlej5+RWQGHzboTr5KgO7MARJLuUVZSc1zPfpCnYG68G5Tl+o
	 DtfzCnbqBo3xSg0rzozRCNSj4X1q3XXb2TV/r/Dy7x7qjSwLqrYA+QsbAHaXzGB+E8
	 MY4Oj1o6kjaw3iKcjBQkAvKWv+A0o+Z1eIB/j+rZSr36vw4jiEeh7HTPt2tZbEqZ4W
	 C2mI7cfVCKk1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ivan Lipski <ivlipski@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	Qingqing.Zhuo@amd.com,
	wayne.lin@amd.com,
	srinivasan.shanmugam@amd.com,
	andrealmeid@igalia.com,
	bhawanpreet.lakha@amd.com,
	haoping.liu@amd.com,
	contact@emersion.fr,
	mwen@igalia.com,
	davidbtadokoro@usp.br,
	aurabindo.pillai@amd.com,
	mario.limonciello@amd.com,
	shiwu.zhang@amd.com,
	Lang.Yu@amd.com,
	chiahsuan.chung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 77/88] Re-revert "drm/amd/display: Enable Replay for static screen use cases"
Date: Mon, 22 Jan 2024 09:51:50 -0500
Message-ID: <20240122145608.990137-77-sashal@kernel.org>
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

From: Ivan Lipski <ivlipski@amd.com>

[ Upstream commit d6398866a6b47e92319ef6efdb0126a4fbb7796a ]

This reverts commit 44e60b14d5a72f91fd0bdeae8da59ae37a3ca8e5.

Since, it causes a regression in which eDP displays with PSR support,
but no Replay support (Sink support <= 0x03), fail to enable PSR and
consequently all IGT amd_psr tests fail. So, revert this until a more
suitable fix can be found.

This got brought back accidently with the backmerge.

Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 -------------------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
 3 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4e82ee4d74ac..cf32502d669f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -65,7 +65,6 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 #include "amdgpu_dm_psr.h"
-#include "amdgpu_dm_replay.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -4345,7 +4344,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
-	bool replay_feature_enabled = false;
 	int max_overlay = dm->dc->caps.max_slave_planes;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
@@ -4457,20 +4455,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
-		switch (adev->ip_versions[DCE_HWIP][0]) {
-		case IP_VERSION(3, 1, 4):
-		case IP_VERSION(3, 1, 5):
-		case IP_VERSION(3, 1, 6):
-		case IP_VERSION(3, 2, 0):
-		case IP_VERSION(3, 2, 1):
-			replay_feature_enabled = true;
-			break;
-		default:
-			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
-			break;
-		}
-	}
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
@@ -4519,12 +4503,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				amdgpu_dm_update_connector_after_detect(aconnector);
 				setup_backlight_device(dm, aconnector);
 
-				/*
-				 * Disable psr if replay can be enabled
-				 */
-				if (replay_feature_enabled && amdgpu_dm_setup_replay(link, aconnector))
-					psr_feature_enabled = false;
-
 				if (psr_feature_enabled)
 					amdgpu_dm_set_psr_caps(link);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index cb0b48bb2a7d..d2834ad85a54 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -29,7 +29,6 @@
 #include "dc.h"
 #include "amdgpu.h"
 #include "amdgpu_dm_psr.h"
-#include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
@@ -124,12 +123,7 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	 * fill_dc_dirty_rects().
 	 */
 	if (vblank_work->stream && vblank_work->stream->link) {
-		/*
-		 * Prioritize replay, instead of psr
-		 */
-		if (vblank_work->stream->link->replay_settings.replay_feature_enabled)
-			amdgpu_dm_replay_enable(vblank_work->stream, false);
-		else if (vblank_work->enable) {
+		if (vblank_work->enable) {
 			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
 			    vblank_work->stream->link->psr_settings.psr_allow_active)
 				amdgpu_dm_psr_disable(vblank_work->stream);
@@ -138,7 +132,6 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 			   !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
 #endif
-			   vblank_work->stream->link->panel_config.psr.disallow_replay &&
 			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
 			amdgpu_dm_psr_enable(vblank_work->stream);
 		}
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 7f98394338c2..579977f6ad52 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
 	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
 	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
-	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
 };
 
 enum DC_DEBUG_MASK {
@@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PSR = 0x10,
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 	DC_DISABLE_MPO = 0x40,
-	DC_DISABLE_REPLAY = 0x50,
 	DC_ENABLE_DPIA_TRACE = 0x80,
 };
 
-- 
2.43.0


