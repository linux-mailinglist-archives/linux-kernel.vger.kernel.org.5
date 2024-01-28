Return-Path: <linux-kernel+bounces-41708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79983F6DA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8362D1F26BC8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225AA25635;
	Sun, 28 Jan 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gffMLRkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB512E856;
	Sun, 28 Jan 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458350; cv=none; b=AvdoSUam7M5p4VAzmZod4h3DzJtRJBQW9D3nqDxKbDOeyBjp8Ytf+glbPhPtgAxyc2CeWaqmpvB394qcH7XNocVpR2odXc48vvnUWzpht20CllbRTcrdYYA9NAULNN9XdckBZykJ8CFHYBnRj1n5NR31JILHYpsJN8ieU9Wdlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458350; c=relaxed/simple;
	bh=no2z4rduGxH4gyeTCpjDnE9ao3OZMDwNALycK86X20Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxRQajlRPmoEjWShJiBcxCIMDZ5nMB2EHR0olsBn0vdxuf5J8Qxd4CQT0NksezlltnyrViW9+9DByo6tpOApKUJ7m7re7B1qmImYTVwkTHtIECPcC/dlmXB0n8YkUJD3hAaz35qekfZBMwfNby2BbH2ugZy7i65bBptROB1a7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gffMLRkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B363C433F1;
	Sun, 28 Jan 2024 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458349;
	bh=no2z4rduGxH4gyeTCpjDnE9ao3OZMDwNALycK86X20Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gffMLRkK9MpYmiNq/SYA5KRJo6D4+5PFalMdFolnYzkTH57YNFnLtrkxwMy5Jo7Lu
	 VfcGyfQC6Vnw/hbVo8kVmeP/sARPwzeM/hkpRYU73YgNrf7XoO64IF52bZF9xEL0Mt
	 vwv9uY7BgsqXzxvf+EQ1fmDNwG+aBJOghNx/F3rwDq3ZDZMLICds0klxP7AuHu9ity
	 vwRTeNVDrd9LT3Szhn4t1HxP2qL/2186nii1XXHVEmn9lDnr1sj0HmbsS39dtwtlV0
	 iJ8itDKTOWQdyABap/vczRdLzw9613LdXfmV8xWWAFVcWf8ONGWqWRjRSv7/nkh3Sk
	 gvDlU+iEPLoZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Tsai <martin.tsai@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
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
	qingqing.zhuo@amd.com,
	alex.hung@amd.com,
	chiahsuan.chung@amd.com,
	Daniel.Miess@amd.com,
	Josip.Pavic@amd.com,
	agustin.gutierrez@amd.com,
	sancchen@amd.com,
	wayne.lin@amd.com,
	hamza.mahfooz@amd.com,
	Syed.Hassan@amd.com,
	charlene.liu@amd.com,
	wenjing.liu@amd.com,
	ahmed.ahmed@amd.com,
	dillon.varone@amd.com,
	ian.chen@amd.com,
	alvin.lee2@amd.com,
	duncan.ma@amd.com,
	sungkim@amd.com,
	johnson.chen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 26/39] drm/amd/display: To adjust dprefclk by down spread percentage
Date: Sun, 28 Jan 2024 11:10:46 -0500
Message-ID: <20240128161130.200783-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Martin Tsai <martin.tsai@amd.com>

[ Upstream commit 17e74e11ac2b46e7514705ae7abfb93ac0e20bd6 ]

[Why]
Panels show corruption with high refresh rate timings when ssc is
enabled.

[How]
Read down-spread percentage from lut to adjust dprefclk. Issues come
from S0i3 with this commit has been fixed by SMU.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 71 ++++++++++++++++++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        | 11 +++
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  2 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  9 ++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  1 +
 .../gpu/drm/amd/display/include/audio_types.h |  2 +-
 7 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 7326b7565846..bf17e78a0ae1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -87,6 +87,20 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
 #define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
 
+#define regCLK1_CLK2_BYPASS_CNTL			0x029c
+#define regCLK1_CLK2_BYPASS_CNTL_BASE_IDX	0
+
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV__SHIFT	0x10
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK		0x000F0000L
+
+#define regCLK6_0_CLK6_spll_field_8				0x464b
+#define regCLK6_0_CLK6_spll_field_8_BASE_IDX	0
+
+#define CLK6_0_CLK6_spll_field_8__spll_ssc_en__SHIFT	0xd
+#define CLK6_0_CLK6_spll_field_8__spll_ssc_en_MASK		0x00002000L
+
 #define REG(reg_name) \
 	(CLK_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
 
@@ -160,6 +174,37 @@ static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state
 	}
 }
 
+bool dcn314_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint32_t ssc_enable;
+
+	REG_GET(CLK6_0_CLK6_spll_field_8, spll_ssc_en, &ssc_enable);
+
+	return ssc_enable == 1;
+}
+
+void dcn314_init_clocks(struct clk_mgr *clk_mgr)
+{
+	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
+	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
+
+	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
+	// Assumption is that boot state always supports pstate
+	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
+	clk_mgr->clks.p_state_change_support = true;
+	clk_mgr->clks.prev_p_state_change_support = true;
+	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
+	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
+
+	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
+	if (dcn314_is_spll_ssc_enabled(clk_mgr))
+		clk_mgr->dp_dto_source_clock_in_khz =
+			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
+	else
+		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
+}
+
 void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -436,6 +481,11 @@ static DpmClocks314_t dummy_clocks;
 
 static struct dcn314_watermarks dummy_wms = { 0 };
 
+static struct dcn314_ss_info_table ss_info_table = {
+	.ss_divider = 1000,
+	.ss_percentage = {0, 0, 375, 375, 375}
+};
+
 static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn314_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -708,13 +758,31 @@ static struct clk_mgr_funcs dcn314_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn314_update_clocks,
-	.init_clocks = dcn31_init_clocks,
+	.init_clocks = dcn314_init_clocks,
 	.enable_pme_wa = dcn314_enable_pme_wa,
 	.are_clock_states_equal = dcn314_are_clock_states_equal,
 	.notify_wm_ranges = dcn314_notify_wm_ranges
 };
 extern struct clk_mgr_funcs dcn3_fpga_funcs;
 
+static void dcn314_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
+{
+	uint32_t clock_source;
+	//uint32_t ssc_enable;
+
+	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
+	//REG_GET(CLK6_0_CLK6_spll_field_8, spll_ssc_en, &ssc_enable);
+
+	if (dcn314_is_spll_ssc_enabled(&clk_mgr->base) && (clock_source < ARRAY_SIZE(ss_info_table.ss_percentage))) {
+		clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
+
+		if (clk_mgr->dprefclk_ss_percentage != 0) {
+			clk_mgr->ss_on_dprefclk = true;
+			clk_mgr->dprefclk_ss_divider = ss_info_table.ss_divider;
+		}
+	}
+}
+
 void dcn314_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn314 *clk_mgr,
@@ -782,6 +850,7 @@ void dcn314_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn314_read_ss_info_from_lut(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
 
 	clk_mgr->base.base.bw_params = &dcn314_bw_params;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
index 171f84340eb2..002c28e80720 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
@@ -28,6 +28,8 @@
 #define __DCN314_CLK_MGR_H__
 #include "clk_mgr_internal.h"
 
+#define DCN314_NUM_CLOCK_SOURCES   5
+
 struct dcn314_watermarks;
 
 struct dcn314_smu_watermark_set {
@@ -40,9 +42,18 @@ struct clk_mgr_dcn314 {
 	struct dcn314_smu_watermark_set smu_wm_set;
 };
 
+struct dcn314_ss_info_table {
+	uint32_t ss_divider;
+	uint32_t ss_percentage[DCN314_NUM_CLOCK_SOURCES];
+};
+
 bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b);
 
+bool dcn314_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base);
+
+void dcn314_init_clocks(struct clk_mgr *clk_mgr);
+
 void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 140598f18bbd..f0458b8f00af 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -782,7 +782,7 @@ static void get_azalia_clock_info_dp(
 	/*audio_dto_module = dpDtoSourceClockInkhz * 10,000;
 	 *  [khz] ->[100Hz] */
 	azalia_clock_info->audio_dto_module =
-		pll_info->dp_dto_source_clock_in_khz * 10;
+		pll_info->audio_dto_source_clock_in_khz * 10;
 }
 
 void dce_aud_wall_dto_setup(
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 5d3f6fa1011e..970644b695cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -975,6 +975,9 @@ static bool dcn31_program_pix_clk(
 			look_up_in_video_optimized_rate_tlb(pix_clk_params->requested_pix_clk_100hz / 10);
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
+
+	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0)
+		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
 	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
 	if (dc_is_dp_signal(pix_clk_params->signal_type) || dc_is_virtual_signal(pix_clk_params->signal_type)) {
 		if (e) {
@@ -1088,6 +1091,10 @@ static bool get_pixel_clk_frequency_100hz(
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	unsigned int clock_hz = 0;
 	unsigned int modulo_hz = 0;
+	unsigned int dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
+
+	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0)
+		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
 
 	if (clock_source->id == CLOCK_SOURCE_ID_DP_DTO) {
 		clock_hz = REG_READ(PHASE[inst]);
@@ -1100,7 +1107,7 @@ static bool get_pixel_clk_frequency_100hz(
 			modulo_hz = REG_READ(MODULO[inst]);
 			if (modulo_hz)
 				*pixel_clk_khz = div_u64((uint64_t)clock_hz*
-					clock_source->ctx->dc->clk_mgr->dprefclk_khz*10,
+					dp_dto_ref_khz*10,
 					modulo_hz);
 			else
 				*pixel_clk_khz = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 9b8299d97e40..a82cdae70aee 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1353,7 +1353,7 @@ static void build_audio_output(
 	if (state->clk_mgr &&
 		(pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
 			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)) {
-		audio_output->pll_info.dp_dto_source_clock_in_khz =
+		audio_output->pll_info.audio_dto_source_clock_in_khz =
 				state->clk_mgr->funcs->get_dp_ref_clk_frequency(
 						state->clk_mgr);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index fa9614bcb160..55ded5fb8a38 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -314,6 +314,7 @@ struct clk_mgr {
 	bool force_smu_not_present;
 	bool dc_mode_softmax_enabled;
 	int dprefclk_khz; // Used by program pixel clock in clock source funcs, need to figureout where this goes
+	int dp_dto_source_clock_in_khz; // Used to program DP DTO with ss adjustment on DCN314
 	int dentist_vco_freq_khz;
 	struct clk_state_registers_and_bypass boot_snapshot;
 	struct clk_bw_params *bw_params;
diff --git a/drivers/gpu/drm/amd/display/include/audio_types.h b/drivers/gpu/drm/amd/display/include/audio_types.h
index 66a54da0641c..915a031a43cb 100644
--- a/drivers/gpu/drm/amd/display/include/audio_types.h
+++ b/drivers/gpu/drm/amd/display/include/audio_types.h
@@ -64,7 +64,7 @@ enum audio_dto_source {
 /* PLL information required for AZALIA DTO calculation */
 
 struct audio_pll_info {
-	uint32_t dp_dto_source_clock_in_khz;
+	uint32_t audio_dto_source_clock_in_khz;
 	uint32_t feed_back_divider;
 	enum audio_dto_source dto_source;
 	bool ss_enabled;
-- 
2.43.0


