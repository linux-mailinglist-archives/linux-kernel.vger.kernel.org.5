Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43AF798F41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbjIHTbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbjIHTbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:31:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F4E10FA;
        Fri,  8 Sep 2023 12:30:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88AEC433D9;
        Fri,  8 Sep 2023 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201417;
        bh=3guV2qw9uLSmVFIg0JKu/Wkp38Lz3G+YqDMLlGU9UDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPtPJ3jfYpyqDAhvyDUp7sQQ3ZfdxACSsscUv/j9ujR83JmvGpdSfvxp3R7yPmdMV
         L5X4smkmhjeiR/UHN2UCeN7FYp/u0DZ3lUjo1JcJIIrgwO4MMQcT7XA8cweb4feYE+
         M816/qePH4+qwOGPfMDU51qloTnyEBw6nflBE9WW8glpAQWJKGQexYjFIp/wTKGU/Y
         H0IIYfvoyDR2qcpv7dBxHn+6Pp76hdBYJTxpmLFKQNG7AN4os9iDiFCg7dk4qTFt++
         YLeDCD7+SWOiqX8adfWuCx+m1wDdq8MtqyOg0vNh096sTUF19hyljcfy7sC3HztBoM
         djgma2yd/f8/w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Tsai <martin.tsai@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, wayne.lin@amd.com, Jun.Lei@amd.com,
        qingqing.zhuo@amd.com, meenakshikumar.somasundaram@amd.com,
        Daniel.Miess@amd.com, duncan.ma@amd.com, sancchen@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 14/36] drm/amd/display: Read down-spread percentage from lut to adjust dprefclk.
Date:   Fri,  8 Sep 2023 15:28:25 -0400
Message-Id: <20230908192848.3462476-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Tsai <martin.tsai@amd.com>

[ Upstream commit 6917b0b711713b9d84d7e0844e9aa613997a51b2 ]

[Why]
Panels show corruption with high refresh rate timings when
ss is enabled.

[How]
Read down-spread percentage from lut to adjust dprefclk.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 33 +++++++++++++++++--
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |  7 ++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 2f7c8996b19d3..3ba2e13d691d9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -87,6 +87,14 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
 #define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
 
+#define regCLK1_CLK2_BYPASS_CNTL			0x029c
+#define regCLK1_CLK2_BYPASS_CNTL_BASE_IDX	0
+
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
+#define CLK1_CLK2_BYPASS_CNTL__LK2_BYPASS_DIV__SHIFT	0x10
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
+#define CLK1_CLK2_BYPASS_CNTL__LK2_BYPASS_DIV_MASK		0x000F0000L
+
 #define REG(reg_name) \
 	(CLK_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
 
@@ -436,6 +444,11 @@ static DpmClocks314_t dummy_clocks;
 
 static struct dcn314_watermarks dummy_wms = { 0 };
 
+static struct dcn314_ss_info_table ss_info_table = {
+	.ss_divider = 1000,
+	.ss_percentage = {0, 0, 375, 375, 375}
+};
+
 static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn314_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -715,6 +728,20 @@ static struct clk_mgr_funcs dcn314_funcs = {
 };
 extern struct clk_mgr_funcs dcn3_fpga_funcs;
 
+static void dcn314_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
+{
+	uint32_t clock_source;
+
+	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
+
+	clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
+
+	if (clk_mgr->dprefclk_ss_percentage != 0) {
+		clk_mgr->ss_on_dprefclk = true;
+		clk_mgr->dprefclk_ss_divider = ss_info_table.ss_divider;
+	}
+}
+
 void dcn314_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn314 *clk_mgr,
@@ -781,9 +808,11 @@ void dcn314_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
-	dce_clock_read_ss_info(&clk_mgr->base);
+
+	dcn314_read_ss_info_from_lut(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
-	//clk_mgr->base.dccg->ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(clk_mgr_internal, clk_mgr->base.base.dprefclk_khz);
+	clk_mgr->base.base.dprefclk_khz =
+		dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn314_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
index 171f84340eb2f..e0670dafe2600 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
@@ -28,6 +28,8 @@
 #define __DCN314_CLK_MGR_H__
 #include "clk_mgr_internal.h"
 
+#define NUM_CLOCK_SOURCES   5
+
 struct dcn314_watermarks;
 
 struct dcn314_smu_watermark_set {
@@ -40,6 +42,11 @@ struct clk_mgr_dcn314 {
 	struct dcn314_smu_watermark_set smu_wm_set;
 };
 
+struct dcn314_ss_info_table {
+	uint32_t ss_divider;
+	uint32_t ss_percentage[NUM_CLOCK_SOURCES];
+};
+
 bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b);
 
-- 
2.40.1

