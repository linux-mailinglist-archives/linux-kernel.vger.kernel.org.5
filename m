Return-Path: <linux-kernel+bounces-58065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE9984E0C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DC21C2277F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9273182;
	Thu,  8 Feb 2024 12:37:29 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C46F079
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395848; cv=none; b=X4nD47W8WQ/J+AKEit/CfZCtJ6Hy2UHxar7Z5roBF5v+tuVD2mYdR9MheeIgYinPeBvL2Z0OGkaltrUcPDmnL94Q6tP0K0dNuRghtBur1gm7drwd1i47mG1idE4rPz8SG+W4zp3DqtYWToxL5YKhp+92cdrhUKp4U4cJfZlY4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395848; c=relaxed/simple;
	bh=SMxSSIouZobaeMXDonh6APoF96Mk6tvwC3mgcseiygE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q8hJkcjFhGc9AnINL+KrQ1nJY7OTRd15ZD7eJelPSQ88nwEu0GMfpccHHCm00baeNtzVS3LI0dOa4j7WXaGLpAj6yua68GV/lLwDJ9opRYKyrOZbYZKVUYkyHTK+/lD9U6cfLZaXVfQ5zPCE06lPCDnuxE8gdGmntRMHIuk2oeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 8 Feb
 2024 15:37:15 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 8 Feb 2024
 15:37:15 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Harry Wentland <harry.wentland@amd.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Leo Li
	<sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Leon Huang
	<Leon.Huang1@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm/amd/display: Fix missing NULL check in dcn21_set_backlight_level()
Date: Thu, 8 Feb 2024 04:37:11 -0800
Message-ID: <20240208123711.52333-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

On the off chance 'panel_cntl' ends up being not properly initialized,
dcn21_set_backlight_level() may hit NULL pointer dereference while
changing embedded panel backlight levels.

Prevent this issue by using some of the existing checks for the
similar purpose. At the same time clean up redundant tests for
NULL in 'abm'.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 6f0ef80a00ad ("drm/amd/display: Fix ABM pipe/backlight issues when change backlight")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 8e88dcaf88f5..2b1b580541a8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -247,7 +247,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	if (abm != NULL) {
 		uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 
-		if (abm && panel_cntl) {
+		if (panel_cntl) {
 			if (abm->funcs && abm->funcs->set_pipe_ex) {
 				abm->funcs->set_pipe_ex(abm,
 						otg_inst,
@@ -261,15 +261,16 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 							panel_cntl->inst,
 							panel_cntl->pwrseq_inst);
 			}
+
+			if (abm->funcs && abm->funcs->set_backlight_level_pwm)
+				abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
+					frame_ramp, 0, panel_cntl->inst);
+			else
+				dmub_abm_set_backlight(dc, backlight_pwm_u16_16, frame_ramp,
+					panel_cntl->inst);
 		}
 	}
 
-	if (abm && abm->funcs && abm->funcs->set_backlight_level_pwm)
-		abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
-			frame_ramp, 0, panel_cntl->inst);
-	else
-		dmub_abm_set_backlight(dc, backlight_pwm_u16_16, frame_ramp, panel_cntl->inst);
-
 	return true;
 }
 

