Return-Path: <linux-kernel+bounces-124733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AB4891BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B59A289F11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792413280D;
	Fri, 29 Mar 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUQ7IkyH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D689146A98;
	Fri, 29 Mar 2024 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716041; cv=none; b=Fr4xDdinthcbs9k2j/cpHucaRDJCpXdlS1WhYafd2G2YVCbgFzuWvCY+KB6sPKA0RANj2KuAfodIkrR5cX9dEogrH2YykqH3Mwyjm0eSakbi6l7NhV95+LXd89ETGQomWvKQrjEKiWWQAD3oVEPHnDE3y1+9v7+wMwpe4ebqGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716041; c=relaxed/simple;
	bh=wezMdMVsg0c5lGGsH+bSRvYDmZOD2+E4d+LTpbyaKf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhYGqMm6caCX8fdu/S9FPmfTUTat6IH+TbJx8SmCR/4GRAqMSoT1cDbT/L0AX1T4DiNxldboFvobK6bT3WYVO7w30A2g8MG1/hNzGIAQUbqoP+H/vDGR4WPrbm1CV4NLtItXwMibBl5XcuagOkFYSLZegmE0g4HgtyCYbru285k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUQ7IkyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A00EC433F1;
	Fri, 29 Mar 2024 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716041;
	bh=wezMdMVsg0c5lGGsH+bSRvYDmZOD2+E4d+LTpbyaKf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUQ7IkyHKg8Ia6K4Bp2Oqos2yi0MnJJo5fb87cNABMyoIeewkdg/4Hj5LQ7dbdCmR
	 p9PY4l5qJqQYBgx5BO0PwqRqFXdUBGiFTXfDFGztcnEPOu3gwlh4i3ozmytWyP/X2i
	 yANaIgJGpXExWRxMni4Kme+DRjg/I6EjQ5hZTlovhqU1Mn7EanX3aCPtMLqm9oYpvW
	 IG+pp8EhlQom6EFz0mHFbgsHU9957/BPq5x18YSVtqn7LXHQvLA11hTZBqvOsgzLBt
	 3UhQWCBgtcyxHvwCo2B4jhlBNKjfDqKh4Xd/g/npGSD6LlUZh2IatI/R5BrAlJPQ8R
	 CVz6GtkHOzagQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	aric.cyr@amd.com,
	jun.lei@amd.com,
	alvin.lee2@amd.com,
	Qingqing.Zhuo@amd.com,
	chiahsuan.chung@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	wayne.lin@amd.com,
	duncan.ma@amd.com,
	samson.tam@amd.com,
	srinivasan.shanmugam@amd.com,
	jinze.xu@amd.com,
	Josip.Pavic@amd.com,
	cruise.hung@amd.com,
	charlene.liu@amd.com,
	ahmed.ahmed@amd.com,
	wenjing.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 24/98] drm/amd/display: Disable idle reallow as part of command/gpint execution
Date: Fri, 29 Mar 2024 08:36:55 -0400
Message-ID: <20240329123919.3087149-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 6226a5aa77370329e01ee8abe50a95e60618ce97 ]

[Why]
Workaroud for a race condition where DMCUB is in the process of
committing to IPS1 during the handshake causing us to miss the
transition into IPS2 and touch the INBOX1 RPTR causing a HW hang.

[How]
Disable the reallow to ensure that we have enough of a gap between entry
and exit and we're not seeing back-to-back wake_and_executes.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h                           | 1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                  | 4 ++--
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c9317ea0258ea..b46c894672b60 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -987,6 +987,7 @@ struct dc_debug_options {
 	bool psp_disabled_wa;
 	unsigned int ips2_eval_delay_us;
 	unsigned int ips2_entry_delay_us;
+	bool disable_dmub_reallow_idle;
 	bool disable_timeout;
 	bool disable_extblankadj;
 	unsigned int static_screen_wait_frames;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 363d522603a21..9084b320849a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1364,7 +1364,7 @@ bool dc_wake_and_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned in
 	else
 		result = dm_execute_dmub_cmd(ctx, cmd, wait_type);
 
-	if (result && reallow_idle)
+	if (result && reallow_idle && !ctx->dc->debug.disable_dmub_reallow_idle)
 		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, true);
 
 	return result;
@@ -1413,7 +1413,7 @@ bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_com
 
 	result = dc_dmub_execute_gpint(ctx, command_code, param, response, wait_type);
 
-	if (result && reallow_idle)
+	if (result && reallow_idle && !ctx->dc->debug.disable_dmub_reallow_idle)
 		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, true);
 
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 5fdcda8f86026..ff17fce44eb1d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -782,6 +782,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.psp_disabled_wa = true,
 	.ips2_eval_delay_us = 2000,
 	.ips2_entry_delay_us = 800,
+	.disable_dmub_reallow_idle = true,
 	.static_screen_wait_frames = 2,
 };
 
-- 
2.43.0


