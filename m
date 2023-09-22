Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FA7AB4AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjIVPVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjIVPVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:21:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10408A3;
        Fri, 22 Sep 2023 08:21:27 -0700 (PDT)
Date:   Fri, 22 Sep 2023 17:21:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695396085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=giv5GthGmSzPfmD5eP8G9h2KnjXUevF2nuFoLaUAjYI=;
        b=uMXLCNQ2f9gu8fKDtazlwo2vAYY2Biog0f2symzkEqSXg54Uo8X/OQivLgzaDtwzSx6x1T
        GDwjIJeDieeXeq6NwQFe0nzPHqLvnHitlaIbvcI95/Vv8G2A9yuzycF8qGmChoYDOvzv3V
        FplkTSXiTYqNJULYOS9a3Xc+6kiIIJU4j8ysFO2dqYdHjHI9vRov9Jq86+B/PUJK5K+Rkv
        gI6G3LEKJIa+fbafGVTTEnHSoHXg1s2eTyEa1aFbf+w8iu/TryT0CBU/ukcU69Izb2OOKa
        bIzXMLOpigZNr3Az1XxlIjIbN0RpAWej1x18yCxtuvfEFCi067NYGX8vbptwow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695396085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=giv5GthGmSzPfmD5eP8G9h2KnjXUevF2nuFoLaUAjYI=;
        b=a3lI0ZB1goRal4awrdOjFRe5fRjvfZ1EJvJrWIlAN9aj/RN4O3+9/yopxHBxLG5RfI4wMi
        KFZq6fDUXgYCDwCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rc2-rt4
Message-ID: <20230922152122.WTxQdDyw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rc2-rt4 patch set. 

Changes since v6.6-rc2-rt3:

  - "sander44" reported a warning originating from amdgpu driver.

Known issues
     None

The delta patch against v6.6-rc2-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rc2-rt3-rt4.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rc2-rt4

The RT patch against v6.6-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rc2-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rc2-rt4.tar.xz

Sebastian

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 172aa10a8800f..4ae4720535a56 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -60,11 +60,9 @@ static DEFINE_PER_CPU(int, fpu_recursion_depth);
  */
 inline void dc_assert_fp_enabled(void)
 {
-	int *pcpu, depth = 0;
+	int depth;
 
-	pcpu = get_cpu_ptr(&fpu_recursion_depth);
-	depth = *pcpu;
-	put_cpu_ptr(&fpu_recursion_depth);
+	depth = __this_cpu_read(fpu_recursion_depth);
 
 	ASSERT(depth >= 1);
 }
@@ -84,33 +82,28 @@ inline void dc_assert_fp_enabled(void)
  */
 void dc_fpu_begin(const char *function_name, const int line)
 {
-	int *pcpu;
+	int depth;
 
-	pcpu = get_cpu_ptr(&fpu_recursion_depth);
-	*pcpu += 1;
+	WARN_ON_ONCE(!in_task());
+	preempt_disable();
+	depth = __this_cpu_inc_return(fpu_recursion_depth);
 
-	if (*pcpu == 1) {
+	if (depth == 1) {
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
-		migrate_disable();
 		kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
-			preempt_disable();
+		if (cpu_has_feature(CPU_FTR_VSX_COMP))
 			enable_kernel_vsx();
-		} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
-			preempt_disable();
+		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
 			enable_kernel_altivec();
-		} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) {
-			preempt_disable();
+		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			enable_kernel_fp();
-		}
 #elif defined(CONFIG_ARM64)
 		kernel_neon_begin();
 #endif
 	}
 
-	TRACE_DCN_FPU(true, function_name, line, *pcpu);
-	put_cpu_ptr(&fpu_recursion_depth);
+	TRACE_DCN_FPU(true, function_name, line, depth);
 }
 
 /**
@@ -125,30 +118,26 @@ void dc_fpu_begin(const char *function_name, const int line)
  */
 void dc_fpu_end(const char *function_name, const int line)
 {
-	int *pcpu;
+	int depth;
 
-	pcpu = get_cpu_ptr(&fpu_recursion_depth);
-	*pcpu -= 1;
-	if (*pcpu <= 0) {
+	depth = __this_cpu_dec_return(fpu_recursion_depth);
+	if (depth == 0) {
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_end();
-		migrate_enable();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
+		if (cpu_has_feature(CPU_FTR_VSX_COMP))
 			disable_kernel_vsx();
-			preempt_enable();
-		} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
+		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
 			disable_kernel_altivec();
-			preempt_enable();
-		} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) {
+		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			disable_kernel_fp();
-			preempt_enable();
-		}
 #elif defined(CONFIG_ARM64)
 		kernel_neon_end();
 #endif
+	} else {
+		WARN_ON_ONCE(depth < 0);
 	}
 
-	TRACE_DCN_FPU(false, function_name, line, *pcpu);
-	put_cpu_ptr(&fpu_recursion_depth);
+	TRACE_DCN_FPU(false, function_name, line, depth);
+	preempt_enable();
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d587f807dfd7c..5036a3e608324 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2141,9 +2141,17 @@ bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate)
 {
 	bool voltage_supported;
+	display_e2e_pipe_params_st *pipes;
+
+	pipes = kcalloc(dc->res_pool->pipe_count, sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	if (!pipes)
+		return false;
+
 	DC_FP_START();
-	voltage_supported = dcn20_validate_bandwidth_fp(dc, context, fast_validate);
+	voltage_supported = dcn20_validate_bandwidth_fp(dc, context, fast_validate, pipes);
 	DC_FP_END();
+
+	kfree(pipes);
 	return voltage_supported;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index d1a25fe6c44fa..5674c3450fc36 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -953,9 +953,17 @@ static bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate)
 {
 	bool voltage_supported;
+	display_e2e_pipe_params_st *pipes;
+
+	pipes = kcalloc(dc->res_pool->pipe_count, sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	if (!pipes)
+		return false;
+
 	DC_FP_START();
-	voltage_supported = dcn21_validate_bandwidth_fp(dc, context, fast_validate);
+	voltage_supported = dcn21_validate_bandwidth_fp(dc, context, fast_validate, pipes);
 	DC_FP_END();
+
+	kfree(pipes);
 	return voltage_supported;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 5805fb02af14e..2ad92497b9bf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1923,7 +1923,7 @@ void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st
 }
 
 static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *context,
-		bool fast_validate)
+		bool fast_validate, display_e2e_pipe_params_st *pipes)
 {
 	bool out = false;
 
@@ -1932,7 +1932,6 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
-	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	BW_VAL_TRACE_COUNT();
@@ -1967,16 +1966,14 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	out = false;
 
 validate_out:
-	kfree(pipes);
 
 	BW_VAL_TRACE_FINISH();
 
 	return out;
 }
 
-bool dcn20_validate_bandwidth_fp(struct dc *dc,
-				 struct dc_state *context,
-				 bool fast_validate)
+bool dcn20_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
+				 bool fast_validate, display_e2e_pipe_params_st *pipes)
 {
 	bool voltage_supported = false;
 	bool full_pstate_supported = false;
@@ -1995,11 +1992,11 @@ bool dcn20_validate_bandwidth_fp(struct dc *dc,
 	ASSERT(context != dc->current_state);
 
 	if (fast_validate) {
-		return dcn20_validate_bandwidth_internal(dc, context, true);
+		return dcn20_validate_bandwidth_internal(dc, context, true, pipes);
 	}
 
 	// Best case, we support full UCLK switch latency
-	voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false);
+	voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false, pipes);
 	full_pstate_supported = context->bw_ctx.bw.dcn.clk.p_state_change_support;
 
 	if (context->bw_ctx.dml.soc.dummy_pstate_latency_us == 0 ||
@@ -2011,7 +2008,8 @@ bool dcn20_validate_bandwidth_fp(struct dc *dc,
 	// Fallback: Try to only support G6 temperature read latency
 	context->bw_ctx.dml.soc.dram_clock_change_latency_us = context->bw_ctx.dml.soc.dummy_pstate_latency_us;
 
-	voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false);
+	memset(pipes, 0, dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st));
+	voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false, pipes);
 	dummy_pstate_supported = context->bw_ctx.bw.dcn.clk.p_state_change_support;
 
 	if (voltage_supported && (dummy_pstate_supported || !(context->stream_count))) {
@@ -2216,9 +2214,8 @@ static void dcn21_calculate_wm(struct dc *dc, struct dc_state *context,
 						&context->bw_ctx.dml, pipes, pipe_cnt);
 }
 
-bool dcn21_validate_bandwidth_fp(struct dc *dc,
-				 struct dc_state *context,
-				 bool fast_validate)
+bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
+				 bool fast_validate, display_e2e_pipe_params_st *pipes)
 {
 	bool out = false;
 
@@ -2227,7 +2224,6 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
-	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	BW_VAL_TRACE_COUNT();
@@ -2267,7 +2263,6 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	out = false;
 
 validate_out:
-	kfree(pipes);
 
 	BW_VAL_TRACE_FINISH();
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
index c51badf7b68a9..b6c34198ddc86 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
@@ -61,9 +61,8 @@ void dcn20_update_bounding_box(struct dc *dc,
 			       unsigned int num_states);
 void dcn20_patch_bounding_box(struct dc *dc,
 			      struct _vcs_dpi_soc_bounding_box_st *bb);
-bool dcn20_validate_bandwidth_fp(struct dc *dc,
-				 struct dc_state *context,
-				 bool fast_validate);
+bool dcn20_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
+				 bool fast_validate, display_e2e_pipe_params_st *pipes);
 void dcn20_fpu_set_wm_ranges(int i,
 			     struct pp_smu_wm_range_sets *ranges,
 			     struct _vcs_dpi_soc_bounding_box_st *loaded_bb);
@@ -77,9 +76,8 @@ int dcn21_populate_dml_pipes_from_context(struct dc *dc,
 					  struct dc_state *context,
 					  display_e2e_pipe_params_st *pipes,
 					  bool fast_validate);
-bool dcn21_validate_bandwidth_fp(struct dc *dc,
-				 struct dc_state *context,
-				 bool fast_validate);
+bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context, bool
+				 fast_validate, display_e2e_pipe_params_st *pipes);
 void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 
 void dcn21_clk_mgr_set_bw_params_wm_table(struct clk_bw_params *bw_params);
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
