Return-Path: <linux-kernel+bounces-149727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1014B8A9510
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AED1F218FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD01E489;
	Thu, 18 Apr 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpk2Fa2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03899154BFA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429270; cv=none; b=aedqheuNQ7t0mvRE7/9o9EeSCk4zcUioZJVqgWZYfPFzdxV5omuTuVtDAc4tpQDMxNtb1tTPDg0DjR/mdhFm3AP3vCmIyCJclxcRrOOPhw6Zxq1hyGuAOZSokljfKe1TXWcSIBH59Zx/VdcRFzDilo23cfhrSC7vfGpL7M2KwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429270; c=relaxed/simple;
	bh=foTuupios4Tf2RFReAr+18DI+jVKcX1qxJXzRW7VmzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iwAJGWIEQlkIjOhC/++twBZzdvl8gi8tnJJ7Z3oOoCfxf+6mkErXXMr5358ZOkVM2hsruMzP6hRi/T9B1JHuaTrm/Wxw+xxqCOtzNylv5ex3i0K+DAG3yLBk+VD+d7iBfNZhCUfoWIF0fZG0frnF771yzimsu0DMUumjFvNhvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpk2Fa2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198FBC113CC;
	Thu, 18 Apr 2024 08:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713429269;
	bh=foTuupios4Tf2RFReAr+18DI+jVKcX1qxJXzRW7VmzA=;
	h=From:To:Cc:Subject:Date:From;
	b=gpk2Fa2WhrJS/XHTk0xJX4e/AB2edk0Rev0P8fLFaA07EOUUxNIIjgW5mw4ucF0kA
	 2mA7wog3Kwh07RqwUso84ur5Gv48FRy/bF0IjyeAXRExODqVr3R3mRynqaIPdDLWNZ
	 0BsgEl751JT5/QTDC8to6OoPMP824P57Cwq4dX6dygrmTSpaeeOxZ0oSQ2pmph3So+
	 heG2eWv6stEPXU0R/FCmgazYyiYBVWqjH9VS7jravHSHk5vn2Otf2r5reUshF/DyQc
	 9FyNMhjP/NbVg1uck/EMbRbAkPo4ZDLJ5CPg8+OvhmZe9wAmGcs08lRnSfSI7uiVwr
	 ftAlhjyLpR8hg==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Jun Lei <jun.lei@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Samson Tam <samson.tam@amd.com>,
	Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
	Roman Li <roman.li@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Joshua Aberback <joshua.aberback@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: dynamically allocate dml2_configuration_options structures
Date: Thu, 18 Apr 2024 10:34:02 +0200
Message-Id: <20240418083421.3956461-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This structure is too large to fit on a stack, as shown by the
newly introduced warnings from a recent code change:

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c: In function 'dcn32_update_bw_bounding_box':
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:2019:1: error: the frame size of 1180 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn321/dcn321_resource.c: In function 'dcn321_update_bw_bounding_box':
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn321/dcn321_resource.c:1597:1: error: the frame size of 1180 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c: In function 'dc_state_create':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:219:1: error: the frame size of 1184 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Instead of open-coding the assignment of a large structure to a stack
variable, use an explicit kmemdup() in each case to move it off the stack.

Fixes: e779f4587f61 ("drm/amd/display: Add handling for DC power mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../display/dc/resource/dcn32/dcn32_resource.c   | 16 +++++++++++-----
 .../display/dc/resource/dcn321/dcn321_resource.c | 16 +++++++++++-----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index c16e915686fc..b2b95f5abb09 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2001,21 +2001,27 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 
 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+	struct dml2_configuration_options *dml2_opt;
+
+	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
+	if (!dml2_opt)
+		return;
 
 	DC_FP_START();
 
 	dcn32_update_bw_bounding_box_fpu(dc, bw_params);
 
-	dml2_opt.use_clock_dc_limits = false;
+	dml2_opt->use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
 
-	dml2_opt.use_clock_dc_limits = true;
+	dml2_opt->use_clock_dc_limits = true;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
-		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
+
+	kfree(dml2_opt);
 }
 
 static struct resource_funcs dcn32_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 3816678b044f..ea5768f57138 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1579,21 +1579,27 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+	struct dml2_configuration_options *dml2_opt;
+
+	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
+	if (!dml2_opt)
+		return;
 
 	DC_FP_START();
 
 	dcn321_update_bw_bounding_box_fpu(dc, bw_params);
 
-	dml2_opt.use_clock_dc_limits = false;
+	dml2_opt->use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
 
-	dml2_opt.use_clock_dc_limits = true;
+	dml2_opt->use_clock_dc_limits = true;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
-		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
+
+	kfree(dml2_opt);
 }
 
 static struct resource_funcs dcn321_res_pool_funcs = {
-- 
2.39.2


