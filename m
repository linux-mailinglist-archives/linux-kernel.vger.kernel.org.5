Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEE77E3ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjKGMmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjKGMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:41:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C617128FC3;
        Tue,  7 Nov 2023 04:29:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299C4C433C7;
        Tue,  7 Nov 2023 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360193;
        bh=TopocSPAbf/BcmnmzvBXwJfFDgTQn2jt4LUo57c7e3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLAlNoDSj0G0Z5kht+Y1Rcxf+ssuAQeBfQBkGs6F9lGsEAYnW5F0eh3wqOfeB69cN
         Q/iX/nEz0C/KJRucoN/SY75e+VgNYQnyX+VTAcexagWyus+9afVJOTqzDIE8Bf9SX6
         e65mryoDClDNzlxpSUa4vap85eDm/XmPU/9/ddMiO55tNEOuIcvOFkM3filQyii8xr
         hJGy2wcmIUyBJthvdkApTF568vIwEFLe5eYoY8wJDngCLRHtnBKvdsmfuDm/B/idum
         B2mR2YxNuVFRNrQN+HeuMhsx2IOIkq3LUMv/IeTCJJqXoZA+0u+VyKNJws7lbkzh+f
         Jlp3mQ4R6dekQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenjing Liu <wenjing.liu@amd.com>, Jun Lei <jun.lei@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, alvin.lee2@amd.com, Qingqing.Zhuo@amd.com,
        samson.tam@amd.com, aric.cyr@amd.com, chiawen.huang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 03/20] drm/amd/display: use full update for clip size increase of large plane source
Date:   Tue,  7 Nov 2023 07:28:57 -0500
Message-ID: <20231107122940.3762228-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122940.3762228-1-sashal@kernel.org>
References: <20231107122940.3762228-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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

[ Upstream commit 05b78277ef0efc1deebc8a22384fffec29a3676e ]

[why]
Clip size increase will increase viewport, which could cause us to
switch  to MPC combine.
If we skip full update, we are not able to change to MPC combine in
fast update. This will cause corruption showing on the video plane.

[how]
treat clip size increase of a surface larger than 5k as a full update.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 ++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h      |  5 +++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ffe7479a047d8..3919e75fec16d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -886,7 +886,8 @@ static bool dc_construct(struct dc *dc,
 	/* set i2c speed if not done by the respective dcnxxx__resource.c */
 	if (dc->caps.i2c_speed_in_khz_hdcp == 0)
 		dc->caps.i2c_speed_in_khz_hdcp = dc->caps.i2c_speed_in_khz;
-
+	if (dc->caps.max_optimizable_video_width == 0)
+		dc->caps.max_optimizable_video_width = 5120;
 	dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc->res_pool->dccg);
 	if (!dc->clk_mgr)
 		goto fail;
@@ -2053,6 +2054,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 }
 
 static enum surface_update_type get_scaling_info_update_type(
+		const struct dc *dc,
 		const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
@@ -2087,6 +2089,12 @@ static enum surface_update_type get_scaling_info_update_type(
 			update_flags->bits.clock_change = 1;
 	}
 
+	if (u->scaling_info->src_rect.width > dc->caps.max_optimizable_video_width &&
+		(u->scaling_info->clip_rect.width > u->surface->clip_rect.width ||
+		 u->scaling_info->clip_rect.height > u->surface->clip_rect.height))
+		 /* Changing clip size of a large surface may result in MPC slice count change */
+		update_flags->bits.bandwidth_change = 1;
+
 	if (u->scaling_info->src_rect.x != u->surface->src_rect.x
 			|| u->scaling_info->src_rect.y != u->surface->src_rect.y
 			|| u->scaling_info->clip_rect.x != u->surface->clip_rect.x
@@ -2124,7 +2132,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	type = get_plane_info_update_type(u);
 	elevate_update_type(&overall_type, type);
 
-	type = get_scaling_info_update_type(u);
+	type = get_scaling_info_update_type(dc, u);
 	elevate_update_type(&overall_type, type);
 
 	if (u->flip_addr)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e0f58fab5e8ed..09a8726c26399 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -164,6 +164,11 @@ struct dc_caps {
 	uint32_t dmdata_alloc_size;
 	unsigned int max_cursor_size;
 	unsigned int max_video_width;
+	/*
+	 * max video plane width that can be safely assumed to be always
+	 * supported by single DPP pipe.
+	 */
+	unsigned int max_optimizable_video_width;
 	unsigned int min_horizontal_blanking_period;
 	int linear_pitch_alignment;
 	bool dcc_const_color;
-- 
2.42.0

