Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D07764875
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjG0HXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjG0HVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B6E5FFA;
        Thu, 27 Jul 2023 00:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D17861D76;
        Thu, 27 Jul 2023 07:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FB5C433C7;
        Thu, 27 Jul 2023 07:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690442043;
        bh=qBUQlopQqKezc5ZgFaLjUYKhJAIhQJyl1dCkH9RHk4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/UpCbZZi56Zh1F2/kRLgl1M/8v3/alz0EcssONko5Ds+vCBM2rQE2LJiCr7iEBoL
         kDbXXqSOb9WezE72G3if2vUksdXnsZJ8emRx7A56kzI3ZfHc1vMDgkzDtPawVpPbE8
         xPP7ivzQweSUJUYvECZ5gqt5CwK405BuMLHPZrZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.42
Date:   Thu, 27 Jul 2023 09:13:49 +0200
Message-ID: <2023072749-reuse-handmade-95fb@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023072749-gumming-selector-a081@gregkh>
References: <2023072749-gumming-selector-a081@gregkh>
MIME-Version: 1.0
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

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index 5e40b3f437f9..df6062eb3abb 100644
--- a/Documentation/accounting/psi.rst
+++ b/Documentation/accounting/psi.rst
@@ -105,6 +105,10 @@ prevent overly frequent polling. Max limit is chosen as a high enough number
 after which monitors are most likely not needed and psi averages can be used
 instead.
 
+Unprivileged users can also create monitors, with the only limitation that the
+window size must be a multiple of 2s, in order to prevent excessive resource
+usage.
+
 When activated, psi monitor stays active for at least the duration of one
 tracking window to avoid repeated activations/deactivations when system is
 bouncing in and out of the stall state.
diff --git a/Makefile b/Makefile
index 6c940cce3656..b569bed80052 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 41
+SUBLEVEL = 42
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 23834d96d1e7..656f613bacf7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -803,6 +803,8 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
 int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 			  unsigned long vl, unsigned long flags)
 {
+	bool free_sme = false;
+
 	if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |
 				     PR_SVE_SET_VL_ONEXEC))
 		return -EINVAL;
@@ -851,21 +853,36 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	    thread_sm_enabled(&task->thread))
 		sve_to_fpsimd(task);
 
-	if (system_supports_sme() && type == ARM64_VEC_SME) {
-		task->thread.svcr &= ~(SVCR_SM_MASK |
-				       SVCR_ZA_MASK);
-		clear_thread_flag(TIF_SME);
+	if (system_supports_sme()) {
+		if (type == ARM64_VEC_SME ||
+		    !(task->thread.svcr & (SVCR_SM_MASK | SVCR_ZA_MASK))) {
+			/*
+			 * We are changing the SME VL or weren't using
+			 * SME anyway, discard the state and force a
+			 * reallocation.
+			 */
+			task->thread.svcr &= ~(SVCR_SM_MASK |
+					       SVCR_ZA_MASK);
+			clear_thread_flag(TIF_SME);
+			free_sme = true;
+		}
 	}
 
 	if (task == current)
 		put_cpu_fpsimd_context();
 
 	/*
-	 * Force reallocation of task SVE and SME state to the correct
-	 * size on next use:
+	 * Free the changed states if they are not in use, SME will be
+	 * reallocated to the correct size on next use and we just
+	 * allocate SVE now in case it is needed for use in streaming
+	 * mode.
 	 */
-	sve_free(task);
-	if (system_supports_sme() && type == ARM64_VEC_SME)
+	if (system_supports_sve()) {
+		sve_free(task);
+		sve_alloc(task, true);
+	}
+
+	if (free_sme)
 		sme_free(task);
 
 	task_set_vl(task, type, vl);
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8f16217c111c..14134fd34ff7 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -322,7 +322,13 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *
 	 */
 
-	emit_bti(A64_BTI_C, ctx);
+	/* bpf function may be invoked by 3 instruction types:
+	 * 1. bl, attached via freplace to bpf prog via short jump
+	 * 2. br, attached via freplace to bpf prog via long jump
+	 * 3. blr, working as a function pointer, used by emit_call.
+	 * So BTI_JC should used here to support both br and blr.
+	 */
+	emit_bti(A64_BTI_JC, ctx);
 
 	emit(A64_MOV(1, A64_R(9), A64_LR), ctx);
 	emit(A64_NOP, ctx);
diff --git a/arch/mips/include/asm/dec/prom.h b/arch/mips/include/asm/dec/prom.h
index 1e1247add1cf..908e96e3a311 100644
--- a/arch/mips/include/asm/dec/prom.h
+++ b/arch/mips/include/asm/dec/prom.h
@@ -70,7 +70,7 @@ static inline bool prom_is_rex(u32 magic)
  */
 typedef struct {
 	int pagesize;
-	unsigned char bitmap[0];
+	unsigned char bitmap[];
 } memmap;
 
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b6d429a2bcb6..707d6811615b 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -510,6 +510,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell Studio 1569 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Studio 1569"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Acer Aspire 3830TG */
diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 980e5ce6a3a3..3ec611dc0c09 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -242,8 +242,8 @@ static int regmap_i2c_smbus_i2c_read(void *context, const void *reg,
 static const struct regmap_bus regmap_i2c_smbus_i2c_block = {
 	.write = regmap_i2c_smbus_i2c_write,
 	.read = regmap_i2c_smbus_i2c_read,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 1,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 1,
 };
 
 static int regmap_i2c_smbus_i2c_write_reg16(void *context, const void *data,
@@ -299,8 +299,8 @@ static int regmap_i2c_smbus_i2c_read_reg16(void *context, const void *reg,
 static const struct regmap_bus regmap_i2c_smbus_i2c_block_reg16 = {
 	.write = regmap_i2c_smbus_i2c_write_reg16,
 	.read = regmap_i2c_smbus_i2c_read_reg16,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 2,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 2,
 };
 
 static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index 6af692844c19..4c2b94b3e30b 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -660,7 +660,7 @@ static const struct regmap_bus regmap_spi_avmm_bus = {
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
-	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
+	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
 	.free_context = spi_avmm_bridge_ctx_free,
 };
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8359164bff90..7de1f27d0323 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2064,8 +2064,6 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
-	size_t max_data = map->max_raw_write - map->format.reg_bytes -
-			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2073,8 +2071,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > max_data)
-		chunk_regs = max_data / val_bytes;
+	else if (map->max_raw_write && val_len > map->max_raw_write)
+		chunk_regs = map->max_raw_write / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index e3885c90a3ac..f1ba71aed33c 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -566,6 +566,7 @@ int dma_resv_get_fences(struct dma_resv *obj, enum dma_resv_usage usage,
 	dma_resv_for_each_fence_unlocked(&cursor, fence) {
 
 		if (dma_resv_iter_is_restarted(&cursor)) {
+			struct dma_fence **new_fences;
 			unsigned int count;
 
 			while (*num_fences)
@@ -574,13 +575,17 @@ int dma_resv_get_fences(struct dma_resv *obj, enum dma_resv_usage usage,
 			count = cursor.num_fences + 1;
 
 			/* Eventually re-allocate the array */
-			*fences = krealloc_array(*fences, count,
-						 sizeof(void *),
-						 GFP_KERNEL);
-			if (count && !*fences) {
+			new_fences = krealloc_array(*fences, count,
+						    sizeof(void *),
+						    GFP_KERNEL);
+			if (count && !new_fences) {
+				kfree(*fences);
+				*fences = NULL;
+				*num_fences = 0;
 				dma_resv_iter_end(&cursor);
 				return -ENOMEM;
 			}
+			*fences = new_fences;
 		}
 
 		(*fences)[(*num_fences)++] = dma_fence_get(fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 500a1dc4fe02..d60c4a2eeb0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -55,8 +55,9 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 		DRM_WARN("%s: vblank timer overrun\n", __func__);
 
 	ret = drm_crtc_handle_vblank(crtc);
+	/* Don't queue timer again when vblank is disabled. */
 	if (!ret)
-		DRM_ERROR("amdgpu_vkms failure on handling vblank");
+		return HRTIMER_NORESTART;
 
 	return HRTIMER_RESTART;
 }
@@ -81,7 +82,7 @@ static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
+	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b854eec2787e..ce5df7927c21 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -40,6 +40,9 @@
 #include "dc/dc_stat.h"
 #include "amdgpu_dm_trace.h"
 #include "dc/inc/dc_link_ddc.h"
+#include "dpcd_defs.h"
+#include "dc/inc/link_dpcd.h"
+#include "link_service_types.h"
 
 #include "vid.h"
 #include "amdgpu.h"
@@ -211,7 +214,7 @@ static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
 
 static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 				    struct amdgpu_dm_connector *amdgpu_dm_connector,
-				    uint32_t link_index,
+				    u32 link_index,
 				    struct amdgpu_encoder *amdgpu_encoder);
 static int amdgpu_dm_encoder_init(struct drm_device *dev,
 				  struct amdgpu_encoder *aencoder,
@@ -263,7 +266,7 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 				  u32 *vbl, u32 *position)
 {
-	uint32_t v_blank_start, v_blank_end, h_position, v_position;
+	u32 v_blank_start, v_blank_end, h_position, v_position;
 
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
@@ -391,7 +394,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	struct amdgpu_device *adev = irq_params->adev;
 	unsigned long flags;
 	struct drm_pending_vblank_event *e;
-	uint32_t vpos, hpos, v_blank_start, v_blank_end;
+	u32 vpos, hpos, v_blank_start, v_blank_end;
 	bool vrr_active;
 
 	amdgpu_crtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_PFLIP);
@@ -405,12 +408,12 @@ static void dm_pflip_high_irq(void *interrupt_params)
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
-	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
-		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
-						 amdgpu_crtc->pflip_status,
-						 AMDGPU_FLIP_SUBMITTED,
-						 amdgpu_crtc->crtc_id,
-						 amdgpu_crtc);
+	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
+		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p]\n",
+			     amdgpu_crtc->pflip_status,
+			     AMDGPU_FLIP_SUBMITTED,
+			     amdgpu_crtc->crtc_id,
+			     amdgpu_crtc);
 		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 		return;
 	}
@@ -678,7 +681,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct dc_link *link;
-	uint8_t link_index = 0;
+	u8 link_index = 0;
 	struct drm_device *dev;
 
 	if (adev == NULL)
@@ -779,7 +782,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dmcub_trace_buf_entry entry = { 0 };
-	uint32_t count = 0;
+	u32 count = 0;
 	struct dmub_hpd_work *dmub_hpd_wrk;
 	struct dc_link *plink = NULL;
 
@@ -858,7 +861,7 @@ static int dm_set_powergating_state(void *handle,
 }
 
 /* Prototypes of private functions */
-static int dm_early_init(void* handle);
+static int dm_early_init(void *handle);
 
 /* Allocate memory for FBC compressed data  */
 static void amdgpu_dm_fbc_init(struct drm_connector *connector)
@@ -1045,7 +1048,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	struct dmub_srv_hw_params hw_params;
 	enum dmub_status status;
 	const unsigned char *fw_inst_const, *fw_bss_data;
-	uint32_t i, fw_inst_const_size, fw_bss_data_size;
+	u32 i, fw_inst_const_size, fw_bss_data_size;
 	bool has_hw_support;
 
 	if (!dmub_srv)
@@ -1206,10 +1209,10 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
 {
-	uint64_t pt_base;
-	uint32_t logical_addr_low;
-	uint32_t logical_addr_high;
-	uint32_t agp_base, agp_bot, agp_top;
+	u64 pt_base;
+	u32 logical_addr_low;
+	u32 logical_addr_high;
+	u32 agp_base, agp_bot, agp_top;
 	PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
 
 	memset(pa_config, 0, sizeof(*pa_config));
@@ -1257,7 +1260,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;
 	pa_config->system_aperture.end_addr = (uint64_t)logical_addr_high << 18;
 
-	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24 ;
+	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24;
 	pa_config->system_aperture.agp_bot = (uint64_t)agp_bot << 24;
 	pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
 
@@ -1273,6 +1276,21 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 }
 
+static void force_connector_state(
+	struct amdgpu_dm_connector *aconnector,
+	enum drm_connector_force force_state)
+{
+	struct drm_connector *connector = &aconnector->base;
+
+	mutex_lock(&connector->dev->mode_config.mutex);
+	aconnector->base.force = force_state;
+	mutex_unlock(&connector->dev->mode_config.mutex);
+
+	mutex_lock(&aconnector->hpd_lock);
+	drm_kms_helper_connector_hotplug_event(connector);
+	mutex_unlock(&aconnector->hpd_lock);
+}
+
 static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 {
 	struct hpd_rx_irq_offload_work *offload_work;
@@ -1281,6 +1299,9 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 	struct amdgpu_device *adev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	unsigned long flags;
+	union test_response test_response;
+
+	memset(&test_response, 0, sizeof(test_response));
 
 	offload_work = container_of(work, struct hpd_rx_irq_offload_work, work);
 	aconnector = offload_work->offload_wq->aconnector;
@@ -1304,16 +1325,58 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 	if (amdgpu_in_reset(adev))
 		goto skip;
 
+	if (offload_work->data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
+		offload_work->data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
+		dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr, DOWN_OR_UP_MSG_RDY_EVENT);
+		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
+		offload_work->offload_wq->is_handling_mst_msg_rdy_event = false;
+		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
+		goto skip;
+	}
+
 	mutex_lock(&adev->dm.dc_lock);
-	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST)
+	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
 		dc_link_dp_handle_automated_test(dc_link);
-	else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
+
+		if (aconnector->timing_changed) {
+			/* force connector disconnect and reconnect */
+			force_connector_state(aconnector, DRM_FORCE_OFF);
+			msleep(100);
+			force_connector_state(aconnector, DRM_FORCE_UNSPECIFIED);
+		}
+
+		test_response.bits.ACK = 1;
+
+		core_link_write_dpcd(
+		dc_link,
+		DP_TEST_RESPONSE,
+		&test_response.raw,
+		sizeof(test_response));
+	} else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
 			hpd_rx_irq_check_link_loss_status(dc_link, &offload_work->data) &&
 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
-		dc_link_dp_handle_link_loss(dc_link);
+		/* offload_work->data is from handle_hpd_rx_irq->
+		 * schedule_hpd_rx_offload_work.this is defer handle
+		 * for hpd short pulse. upon here, link status may be
+		 * changed, need get latest link status from dpcd
+		 * registers. if link status is good, skip run link
+		 * training again.
+		 */
+		union hpd_irq_data irq_data;
+
+		memset(&irq_data, 0, sizeof(irq_data));
+
+		/* before dc_link_dp_handle_link_loss, allow new link lost handle
+		 * request be added to work queue if link lost at end of dc_link_
+		 * dp_handle_link_loss
+		 */
 		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
 		offload_work->offload_wq->is_handling_link_loss = false;
 		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
+
+		if ((read_hpd_rx_irq_data(dc_link, &irq_data) == DC_OK) &&
+			hpd_rx_irq_check_link_loss_status(dc_link, &irq_data))
+			dc_link_dp_handle_link_loss(dc_link);
 	}
 	mutex_unlock(&adev->dm.dc_lock);
 
@@ -1482,7 +1545,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->dm.audio_lock);
 	spin_lock_init(&adev->dm.vblank_lock);
 
-	if(amdgpu_dm_irq_init(adev)) {
+	if (amdgpu_dm_irq_init(adev)) {
 		DRM_ERROR("amdgpu: failed to initialize DM IRQ support.\n");
 		goto error;
 	}
@@ -1617,9 +1680,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
 		adev->dm.dc->debug.disable_stutter = true;
 
-	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
+	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
 		adev->dm.dc->debug.disable_dsc = true;
-	}
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
 		adev->dm.dc->debug.disable_clock_gate = true;
@@ -1840,8 +1902,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->dm.audio_lock);
 	mutex_destroy(&adev->dm.dc_lock);
 	mutex_destroy(&adev->dm.dpia_aux_lock);
-
-	return;
 }
 
 static int load_dmcu_fw(struct amdgpu_device *adev)
@@ -1850,7 +1910,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	int r;
 	const struct dmcu_firmware_header_v1_0 *hdr;
 
-	switch(adev->asic_type) {
+	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
@@ -2536,7 +2596,7 @@ struct amdgpu_dm_connector *
 amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc)
 {
-	uint32_t i;
+	u32 i;
 	struct drm_connector_state *new_con_state;
 	struct drm_connector *connector;
 	struct drm_crtc *crtc_from_state;
@@ -2642,7 +2702,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 		struct dc_scaling_info scaling_infos[MAX_SURFACES];
 		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
 		struct dc_stream_update stream_update;
-	} * bundle;
+	} *bundle;
 	int k, m;
 
 	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
@@ -2672,8 +2732,6 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 
 cleanup:
 	kfree(bundle);
-
-	return;
 }
 
 static int dm_resume(void *handle)
@@ -2887,8 +2945,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.set_powergating_state = dm_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version dm_ip_block =
-{
+const struct amdgpu_ip_block_version dm_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 1,
 	.minor = 0,
@@ -2945,9 +3002,12 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
 	caps->aux_support = false;
 
-	if (caps->ext_caps->bits.oled == 1 /*||
-	    caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
-	    caps->ext_caps->bits.hdr_aux_backlight_control == 1*/)
+	if (caps->ext_caps->bits.oled == 1
+	    /*
+	     * ||
+	     * caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
+	     * caps->ext_caps->bits.hdr_aux_backlight_control == 1
+	     */)
 		caps->aux_support = true;
 
 	if (amdgpu_backlight == 0)
@@ -3076,6 +3136,10 @@ void amdgpu_dm_update_connector_after_detect(
 						    aconnector->edid);
 		}
 
+		aconnector->timing_requested = kzalloc(sizeof(struct dc_crtc_timing), GFP_KERNEL);
+		if (!aconnector->timing_requested)
+			dm_error("%s: failed to create aconnector->requested_timing\n", __func__);
+
 		drm_connector_update_edid_property(connector, aconnector->edid);
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
 		update_connector_ext_caps(aconnector);
@@ -3087,6 +3151,8 @@ void amdgpu_dm_update_connector_after_detect(
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
+		kfree(aconnector->timing_requested);
+		aconnector->timing_requested = NULL;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 		/* Set CP to DESIRED if it was ENABLED, so we can re-enable it again on hotplug */
 		if (connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
@@ -3131,6 +3197,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	if (aconnector->fake_enable)
 		aconnector->fake_enable = false;
 
+	aconnector->timing_changed = false;
+
 	if (!dc_link_detect_sink(aconnector->dc_link, &new_connection_type))
 		DRM_ERROR("KMS: Failed to detect connector\n");
 
@@ -3170,84 +3238,6 @@ static void handle_hpd_irq(void *param)
 
 }
 
-static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
-{
-	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
-	uint8_t dret;
-	bool new_irq_handled = false;
-	int dpcd_addr;
-	int dpcd_bytes_to_read;
-
-	const int max_process_count = 30;
-	int process_count = 0;
-
-	const struct dc_link_status *link_status = dc_link_get_status(aconnector->dc_link);
-
-	if (link_status->dpcd_caps->dpcd_rev.raw < 0x12) {
-		dpcd_bytes_to_read = DP_LANE0_1_STATUS - DP_SINK_COUNT;
-		/* DPCD 0x200 - 0x201 for downstream IRQ */
-		dpcd_addr = DP_SINK_COUNT;
-	} else {
-		dpcd_bytes_to_read = DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI;
-		/* DPCD 0x2002 - 0x2005 for downstream IRQ */
-		dpcd_addr = DP_SINK_COUNT_ESI;
-	}
-
-	dret = drm_dp_dpcd_read(
-		&aconnector->dm_dp_aux.aux,
-		dpcd_addr,
-		esi,
-		dpcd_bytes_to_read);
-
-	while (dret == dpcd_bytes_to_read &&
-		process_count < max_process_count) {
-		uint8_t retry;
-		dret = 0;
-
-		process_count++;
-
-		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
-		/* handle HPD short pulse irq */
-		if (aconnector->mst_mgr.mst_state)
-			drm_dp_mst_hpd_irq(
-				&aconnector->mst_mgr,
-				esi,
-				&new_irq_handled);
-
-		if (new_irq_handled) {
-			/* ACK at DPCD to notify down stream */
-			const int ack_dpcd_bytes_to_write =
-				dpcd_bytes_to_read - 1;
-
-			for (retry = 0; retry < 3; retry++) {
-				uint8_t wret;
-
-				wret = drm_dp_dpcd_write(
-					&aconnector->dm_dp_aux.aux,
-					dpcd_addr + 1,
-					&esi[1],
-					ack_dpcd_bytes_to_write);
-				if (wret == ack_dpcd_bytes_to_write)
-					break;
-			}
-
-			/* check if there is new irq to be handled */
-			dret = drm_dp_dpcd_read(
-				&aconnector->dm_dp_aux.aux,
-				dpcd_addr,
-				esi,
-				dpcd_bytes_to_read);
-
-			new_irq_handled = false;
-		} else {
-			break;
-		}
-	}
-
-	if (process_count == max_process_count)
-		DRM_DEBUG_DRIVER("Loop exceeded max iterations\n");
-}
-
 static void schedule_hpd_rx_offload_work(struct hpd_rx_irq_offload_work_queue *offload_wq,
 							union hpd_irq_data hpd_irq_data)
 {
@@ -3280,7 +3270,7 @@ static void handle_hpd_rx_irq(void *param)
 	union hpd_irq_data hpd_irq_data;
 	bool link_loss = false;
 	bool has_left_work = false;
-	int idx = aconnector->base.index;
+	int idx = dc_link->link_index;
 	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
@@ -3309,7 +3299,23 @@ static void handle_hpd_rx_irq(void *param)
 	if (dc_link_dp_allow_hpd_rx_irq(dc_link)) {
 		if (hpd_irq_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
 			hpd_irq_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
-			dm_handle_mst_sideband_msg(aconnector);
+			bool skip = false;
+
+			/*
+			 * DOWN_REP_MSG_RDY is also handled by polling method
+			 * mgr->cbs->poll_hpd_irq()
+			 */
+			spin_lock(&offload_wq->offload_lock);
+			skip = offload_wq->is_handling_mst_msg_rdy_event;
+
+			if (!skip)
+				offload_wq->is_handling_mst_msg_rdy_event = true;
+
+			spin_unlock(&offload_wq->offload_lock);
+
+			if (!skip)
+				schedule_hpd_rx_offload_work(offload_wq, hpd_irq_data);
+
 			goto out;
 		}
 
@@ -3402,7 +3408,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 		aconnector = to_amdgpu_dm_connector(connector);
 		dc_link = aconnector->dc_link;
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
+		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
 			int_params.irq_source = dc_link->irq_source_hpd;
 
@@ -3411,7 +3417,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 					(void *) aconnector);
 		}
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
+		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
 
 			/* Also register for DP short pulse (hpd_rx). */
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
@@ -3420,11 +3426,11 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 			amdgpu_dm_irq_register_interrupt(adev, &int_params,
 					handle_hpd_rx_irq,
 					(void *) aconnector);
-
-			if (adev->dm.hpd_rx_offload_wq)
-				adev->dm.hpd_rx_offload_wq[connector->index].aconnector =
-					aconnector;
 		}
+
+		if (adev->dm.hpd_rx_offload_wq)
+			adev->dm.hpd_rx_offload_wq[connector->index].aconnector =
+				aconnector;
 	}
 }
 
@@ -3437,7 +3443,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 	struct dc_interrupt_params int_params = {0};
 	int r;
 	int i;
-	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
@@ -3451,11 +3457,12 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
 	 *    coming from DC hardware.
 	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling. */
+	 *    for acknowledging and handling.
+	 */
 
 	/* Use VBLANK interrupt */
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		r = amdgpu_irq_add_id(adev, client_id, i+1 , &adev->crtc_irq);
+		r = amdgpu_irq_add_id(adev, client_id, i + 1, &adev->crtc_irq);
 		if (r) {
 			DRM_ERROR("Failed to add crtc irq id!\n");
 			return r;
@@ -3463,7 +3470,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 
 		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
 		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i+1 , 0);
+			dc_interrupt_to_irq_source(dc, i + 1, 0);
 
 		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
 
@@ -3519,7 +3526,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	struct dc_interrupt_params int_params = {0};
 	int r;
 	int i;
-	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
 	if (adev->family >= AMDGPU_FAMILY_AI)
 		client_id = SOC15_IH_CLIENTID_DCE;
@@ -3536,7 +3543,8 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
 	 *    coming from DC hardware.
 	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling. */
+	 *    for acknowledging and handling.
+	 */
 
 	/* Use VBLANK interrupt */
 	for (i = VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0; i <= VISLANDS30_IV_SRCID_D6_VERTICAL_INTERRUPT0; i++) {
@@ -3985,7 +3993,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 }
 
 static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
-				unsigned *min, unsigned *max)
+				unsigned int *min, unsigned int *max)
 {
 	if (!caps)
 		return 0;
@@ -4005,7 +4013,7 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 					uint32_t brightness)
 {
-	unsigned min, max;
+	unsigned int min, max;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
@@ -4018,7 +4026,7 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 				      uint32_t brightness)
 {
-	unsigned min, max;
+	unsigned int min, max;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
@@ -4236,12 +4244,12 @@ static void amdgpu_set_panel_orientation(struct drm_connector *connector);
 static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 {
 	struct amdgpu_display_manager *dm = &adev->dm;
-	int32_t i;
+	s32 i;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct amdgpu_encoder *aencoder = NULL;
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
-	uint32_t link_cnt;
-	int32_t primary_planes;
+	u32 link_cnt;
+	s32 primary_planes;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
@@ -4499,7 +4507,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
 {
 	drm_atomic_private_obj_fini(&dm->atomic_obj);
-	return;
 }
 
 /******************************************************************************
@@ -4768,7 +4775,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const struct drm_plane_state *plane_state,
-			    const uint64_t tiling_flags,
+			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
 			    bool tmz_surface,
@@ -4977,7 +4984,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	uint32_t num_clips;
 	bool bb_changed;
 	bool fb_changed;
-	uint32_t i = 0;
+	u32 i = 0;
 
 	flip_addrs->dirty_rect_count = 0;
 
@@ -5111,7 +5118,7 @@ static enum dc_color_depth
 convert_color_depth_from_display_info(const struct drm_connector *connector,
 				      bool is_y420, int requested_bpc)
 {
-	uint8_t bpc;
+	u8 bpc;
 
 	if (is_y420) {
 		bpc = 8;
@@ -5225,6 +5232,7 @@ static bool adjust_colour_depth_from_display_info(
 {
 	enum dc_color_depth depth = timing_out->display_color_depth;
 	int normalized_clk;
+
 	do {
 		normalized_clk = timing_out->pix_clk_100hz / 10;
 		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
@@ -5440,6 +5448,7 @@ create_fake_sink(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct dc_sink *sink = NULL;
+
 	sink_init_data.link = aconnector->dc_link;
 	sink_init_data.sink_signal = aconnector->dc_link->connector_signal;
 
@@ -5563,7 +5572,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		return &aconnector->freesync_vid_base;
 
 	/* Find the preferred mode */
-	list_for_each_entry (m, list_head, head) {
+	list_for_each_entry(m, list_head, head) {
 		if (m->type & DRM_MODE_TYPE_PREFERRED) {
 			m_pref = m;
 			break;
@@ -5587,7 +5596,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 	 * For some monitors, preferred mode is not the mode with highest
 	 * supported refresh rate.
 	 */
-	list_for_each_entry (m, list_head, head) {
+	list_for_each_entry(m, list_head, head) {
 		current_refresh  = drm_mode_vrefresh(m);
 
 		if (m->hdisplay == m_pref->hdisplay &&
@@ -5655,8 +5664,8 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 				    uint32_t max_dsc_target_bpp_limit_override)
 {
 	const struct dc_link_settings *verified_link_cap = NULL;
-	uint32_t link_bw_in_kbps;
-	uint32_t edp_min_bpp_x16, edp_max_bpp_x16;
+	u32 link_bw_in_kbps;
+	u32 edp_min_bpp_x16, edp_max_bpp_x16;
 	struct dc *dc = sink->ctx->dc;
 	struct dc_dsc_bw_range bw_range = {0};
 	struct dc_dsc_config dsc_cfg = {0};
@@ -5713,17 +5722,15 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 					struct dsc_dec_dpcd_caps *dsc_caps)
 {
 	struct drm_connector *drm_connector = &aconnector->base;
-	uint32_t link_bandwidth_kbps;
-	uint32_t max_dsc_target_bpp_limit_override = 0;
+	u32 link_bandwidth_kbps;
 	struct dc *dc = sink->ctx->dc;
-	uint32_t max_supported_bw_in_kbps, timing_bw_in_kbps;
-	uint32_t dsc_max_supported_bw_in_kbps;
+	u32 max_supported_bw_in_kbps, timing_bw_in_kbps;
+	u32 dsc_max_supported_bw_in_kbps;
+	u32 max_dsc_target_bpp_limit_override =
+		drm_connector->display_info.max_dsc_bpp;
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
-	if (stream->link && stream->link->local_sink)
-		max_dsc_target_bpp_limit_override =
-			stream->link->local_sink->edid_caps.panel_patch.max_dsc_target_bpp_limit;
 
 	/* Set DSC policy according to dsc_clock_en */
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
@@ -5860,7 +5867,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 * This may not be an error, the use case is when we have no
 		 * usermode calls to reset and set mode upon hotplug. In this
 		 * case, we call set mode ourselves to restore the previous mode
-		 * and the modelist may not be filled in in time.
+		 * and the modelist may not be filled in time.
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
@@ -5884,9 +5891,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		drm_mode_set_crtcinfo(&mode, 0);
 
 	/*
-	* If scaling is enabled and refresh rate didn't change
-	* we copy the vic and polarities of the old timings
-	*/
+	 * If scaling is enabled and refresh rate didn't change
+	 * we copy the vic and polarities of the old timings
+	 */
 	if (!scale || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(
 			stream, &mode, &aconnector->base, con_state, NULL,
@@ -5896,6 +5903,14 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			stream, &mode, &aconnector->base, con_state, old_stream,
 			requested_bpc);
 
+	if (aconnector->timing_changed) {
+		DC_LOG_DEBUG("%s: overriding timing for automated test, bpc %d, changing to %d\n",
+				__func__,
+				stream->timing.display_color_depth,
+				aconnector->timing_requested->display_color_depth);
+		stream->timing = *aconnector->timing_requested;
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* SST DSC determination policy */
 	update_dsc_caps(aconnector, sink, stream, &dsc_caps);
@@ -6540,6 +6555,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 
 	if (!state->duplicated) {
 		int max_bpc = conn_state->max_requested_bpc;
+
 		is_y420 = drm_mode_is_420_also(&connector->display_info, adjusted_mode) &&
 			  aconnector->force_yuv420_output;
 		color_depth = convert_color_depth_from_display_info(connector,
@@ -6860,7 +6876,7 @@ static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 {
 	struct drm_display_mode *m;
 
-	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
+	list_for_each_entry(m, &aconnector->base.probed_modes, head) {
 		if (drm_mode_equal(m, mode))
 			return true;
 	}
@@ -6873,7 +6889,7 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 	const struct drm_display_mode *m;
 	struct drm_display_mode *new_mode;
 	uint i;
-	uint32_t new_modes_count = 0;
+	u32 new_modes_count = 0;
 
 	/* Standard FPS values
 	 *
@@ -6887,7 +6903,7 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 	 * 60 	        - Commonly used
 	 * 48,72,96,120 - Multiples of 24
 	 */
-	static const uint32_t common_rates[] = {
+	static const u32 common_rates[] = {
 		23976, 24000, 25000, 29970, 30000,
 		48000, 50000, 60000, 72000, 96000, 120000
 	};
@@ -6903,8 +6919,8 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(common_rates); i++) {
-		uint64_t target_vtotal, target_vtotal_diff;
-		uint64_t num, den;
+		u64 target_vtotal, target_vtotal_diff;
+		u64 num, den;
 
 		if (drm_mode_vrefresh(m) * 1000 < common_rates[i])
 			continue;
@@ -6972,13 +6988,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 640, 480);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		/* most eDP supports only timings from its edid,
-		 * usually only detailed timings are available
-		 * from eDP edid. timings which are not from edid
-		 * may damage eDP
-		 */
-		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
-			amdgpu_dm_connector_add_common_modes(encoder, connector);
+		amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
@@ -7010,6 +7020,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->hpd.hpd = AMDGPU_HPD_NONE; /* not used */
 	aconnector->audio_inst = -1;
 	mutex_init(&aconnector->hpd_lock);
+	mutex_init(&aconnector->handle_mst_msg_ready);
 
 	/*
 	 * configure support HPD hot plug connector_>polled default value is 0
@@ -7152,7 +7163,7 @@ create_i2c(struct ddc_service *ddc_service,
  */
 static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 				    struct amdgpu_dm_connector *aconnector,
-				    uint32_t link_index,
+				    u32 link_index,
 				    struct amdgpu_encoder *aencoder)
 {
 	int res = 0;
@@ -7163,7 +7174,6 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 
 	link->priv = aconnector;
 
-	DRM_DEBUG_DRIVER("%s()\n", __func__);
 
 	i2c = create_i2c(link->ddc, link->link_index, &res);
 	if (!i2c) {
@@ -7643,8 +7653,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct drm_crtc *pcrtc,
 				    bool wait_for_vblank)
 {
-	uint32_t i;
-	uint64_t timestamp_ns;
+	u32 i;
+	u64 timestamp_ns;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct amdgpu_crtc *acrtc_attach = to_amdgpu_crtc(pcrtc);
@@ -7655,7 +7665,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
 	int planes_count = 0, vpos, hpos;
 	unsigned long flags;
-	uint32_t target_vblank, last_flip_vblank;
+	u32 target_vblank, last_flip_vblank;
 	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
 	bool cursor_update = false;
 	bool pflip_present = false;
@@ -7757,7 +7767,15 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * Only allow immediate flips for fast updates that don't
 		 * change memory domain, FB pitch, DCC state, rotation or
 		 * mirroring.
+		 *
+		 * dm_crtc_helper_atomic_check() only accepts async flips with
+		 * fast updates.
 		 */
+		if (crtc->state->async_flip &&
+		    acrtc_state->update_type != UPDATE_TYPE_FAST)
+			drm_warn_once(state->dev,
+				      "[PLANE:%d:%s] async flip with non-fast update\n",
+				      plane->base.id, plane->name);
 		bundle->flip_addrs[planes_count].flip_immediate =
 			crtc->state->async_flip &&
 			acrtc_state->update_type == UPDATE_TYPE_FAST &&
@@ -7800,8 +7818,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			 * DRI3/Present extension with defined target_msc.
 			 */
 			last_flip_vblank = amdgpu_get_vblank_counter_kms(pcrtc);
-		}
-		else {
+		} else {
 			/* For variable refresh rate mode only:
 			 * Get vblank of last completed flip to avoid > 1 vrr
 			 * flips per video frame by use of throttling, but allow
@@ -8096,7 +8113,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dm_atomic_state *dm_state;
 	struct dc_state *dc_state = NULL, *dc_state_temp = NULL;
-	uint32_t i, j;
+	u32 i, j;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	unsigned long flags;
@@ -8128,8 +8145,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dc_resource_state_copy_construct_current(dm->dc, dc_state);
 	}
 
-	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
-				       new_crtc_state, i) {
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
+				      new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
@@ -8152,9 +8169,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
 		drm_dbg_state(state->dev,
-			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
-			"planes_changed:%d, mode_changed:%d,active_changed:%d,"
-			"connectors_changed:%d\n",
+			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
 			acrtc->crtc_id,
 			new_crtc_state->enable,
 			new_crtc_state->active,
@@ -8639,8 +8654,8 @@ static int do_aquire_global_lock(struct drm_device *dev,
 					&commit->flip_done, 10*HZ);
 
 		if (ret == 0)
-			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done "
-				  "timed out\n", crtc->base.id, crtc->name);
+			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done timed out\n",
+				  crtc->base.id, crtc->name);
 
 		drm_crtc_commit_put(commit);
 	}
@@ -8725,8 +8740,9 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 	return false;
 }
 
-static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
-	uint64_t num, den, res;
+static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
+{
+	u64 num, den, res;
 	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
 
 	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
@@ -8848,9 +8864,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		goto skip_modeset;
 
 	drm_dbg_state(state->dev,
-		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
-		"planes_changed:%d, mode_changed:%d,active_changed:%d,"
-		"connectors_changed:%d\n",
+		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
 		acrtc->crtc_id,
 		new_crtc_state->enable,
 		new_crtc_state->active,
@@ -8879,8 +8893,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
 			DRM_DEBUG_DRIVER(
-				"Mode change not required for front porch change, "
-				"setting mode_changed to %d",
+				"Mode change not required for front porch change, setting mode_changed to %d",
 				new_crtc_state->mode_changed);
 
 			set_freesync_fixed_config(dm_new_crtc_state);
@@ -8892,9 +8905,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			struct drm_display_mode *high_mode;
 
 			high_mode = get_highest_refresh_rate_mode(aconnector, false);
-			if (!drm_mode_equal(&new_crtc_state->mode, high_mode)) {
+			if (!drm_mode_equal(&new_crtc_state->mode, high_mode))
 				set_freesync_fixed_config(dm_new_crtc_state);
-			}
 		}
 
 		ret = dm_atomic_get_state(state, &dm_state);
@@ -9062,6 +9074,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	 */
 	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_state, i) {
 		struct amdgpu_framebuffer *old_afb, *new_afb;
+
 		if (other->type == DRM_PLANE_TYPE_CURSOR)
 			continue;
 
@@ -9160,11 +9173,12 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 	}
 
 	/* Core DRM takes care of checking FB modifiers, so we only need to
-	 * check tiling flags when the FB doesn't have a modifier. */
+	 * check tiling flags when the FB doesn't have a modifier.
+	 */
 	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
 		if (adev->family < AMDGPU_FAMILY_AI) {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
-			         AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
+				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
 				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
 		} else {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
@@ -9377,12 +9391,12 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 	 * cursor per pipe but it's going to inherit the scaling and
 	 * positioning from the underlying pipe. Check the cursor plane's
-	 * blending properties match the underlying planes'. */
+	 * blending properties match the underlying planes'.
+	 */
 
 	new_cursor_state = drm_atomic_get_new_plane_state(state, cursor);
-	if (!new_cursor_state || !new_cursor_state->fb) {
+	if (!new_cursor_state || !new_cursor_state->fb)
 		return 0;
-	}
 
 	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
 	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
@@ -9428,6 +9442,7 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 	struct drm_connector_state *conn_state, *old_conn_state;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	int i;
+
 	for_each_oldnew_connector_in_state(state, connector, old_conn_state, conn_state, i) {
 		if (!conn_state->crtc)
 			conn_state = old_conn_state;
@@ -9870,7 +9885,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	}
 
 	/* Store the overall update type for use later in atomic check. */
-	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct dm_crtc_state *dm_new_crtc_state =
 			to_dm_crtc_state(new_crtc_state);
 
@@ -9892,7 +9907,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	else if (ret == -EINTR || ret == -EAGAIN || ret == -ERESTARTSYS)
 		DRM_DEBUG_DRIVER("Atomic check stopped due to signal.\n");
 	else
-		DRM_DEBUG_DRIVER("Atomic check failed with err: %d \n", ret);
+		DRM_DEBUG_DRIVER("Atomic check failed with err: %d\n", ret);
 
 	trace_amdgpu_dm_atomic_check_finish(state, ret);
 
@@ -9902,7 +9917,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 static bool is_dp_capable_without_timing_msa(struct dc *dc,
 					     struct amdgpu_dm_connector *amdgpu_dm_connector)
 {
-	uint8_t dpcd_data;
+	u8 dpcd_data;
 	bool capable = false;
 
 	if (amdgpu_dm_connector->dc_link &&
@@ -9921,7 +9936,7 @@ static bool is_dp_capable_without_timing_msa(struct dc *dc,
 static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		unsigned int offset,
 		unsigned int total_length,
-		uint8_t *data,
+		u8 *data,
 		unsigned int length,
 		struct amdgpu_hdmi_vsdb_info *vsdb)
 {
@@ -9976,7 +9991,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 }
 
 static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	int i;
@@ -10017,7 +10032,7 @@ static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
 }
 
 static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	int i;
@@ -10033,7 +10048,7 @@ static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
 }
 
 static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
@@ -10047,7 +10062,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
-	uint8_t *edid_ext = NULL;
+	u8 *edid_ext = NULL;
 	int i;
 	bool valid_vsdb_found = false;
 
@@ -10223,7 +10238,7 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 }
 
 void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
-		       uint32_t value, const char *func_name)
+		       u32 value, const char *func_name)
 {
 #ifdef DM_CHECK_ADDR_0
 	if (address == 0) {
@@ -10238,7 +10253,7 @@ void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
 uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 			  const char *func_name)
 {
-	uint32_t value;
+	u32 value;
 #ifdef DM_CHECK_ADDR_0
 	if (address == 0) {
 		DC_ERR("invalid register read; address = 0\n");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ac26e917240b..2c9a33c80c81 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -31,6 +31,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_plane.h>
+#include "link_service_types.h"
 
 /*
  * This file contains the definition for amdgpu_display_manager
@@ -192,6 +193,11 @@ struct hpd_rx_irq_offload_work_queue {
 	 * we're handling link loss
 	 */
 	bool is_handling_link_loss;
+	/**
+	 * @is_handling_mst_msg_rdy_event: Used to prevent inserting mst message
+	 * ready event when we're already handling mst message ready event
+	 */
+	bool is_handling_mst_msg_rdy_event;
 	/**
 	 * @aconnector: The aconnector that this work queue is attached to
 	 */
@@ -613,6 +619,8 @@ struct amdgpu_dm_connector {
 	struct drm_dp_mst_port *port;
 	struct amdgpu_dm_connector *mst_port;
 	struct drm_dp_aux *dsc_aux;
+	struct mutex handle_mst_msg_ready;
+
 	/* TODO see if we can merge with ddc_bus or make a dm_connector */
 	struct amdgpu_i2c_adapter *i2c;
 
@@ -650,6 +658,10 @@ struct amdgpu_dm_connector {
 
 	/* Record progress status of mst*/
 	uint8_t mst_status;
+
+	/* Automated testing */
+	bool timing_changed;
+	struct dc_crtc_timing *timing_requested;
 };
 
 static inline void amdgpu_dm_set_mst_status(uint8_t *status,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 1ec643a0d00d..b9b70f4562c7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -406,6 +406,18 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 		return -EINVAL;
 	}
 
+	/*
+	 * Only allow async flips for fast updates that don't change the FB
+	 * pitch, the DCC state, rotation, etc.
+	 */
+	if (crtc_state->async_flip &&
+	    dm_crtc_state->update_type != UPDATE_TYPE_FAST) {
+		drm_dbg_atomic(crtc->dev,
+			       "[CRTC:%d:%s] async flips are only supported for fast updates\n",
+			       crtc->base.id, crtc->name);
+		return -EINVAL;
+	}
+
 	/* In some use cases, like reset, no stream is attached */
 	if (!dm_crtc_state->stream)
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index db7744beed5f..9dc41f569a76 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -38,6 +38,9 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_dm_mst_types.h"
+#include "dpcd_defs.h"
+#include "dc/inc/core_types.h"
+#include "dc_link_dp.h"
 
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
@@ -1056,6 +1059,128 @@ void dm_helpers_mst_enable_stream_features(const struct dc_stream_state *stream)
 					 sizeof(new_downspread));
 }
 
+bool dm_helpers_dp_handle_test_pattern_request(
+		struct dc_context *ctx,
+		const struct dc_link *link,
+		union link_test_pattern dpcd_test_pattern,
+		union test_misc dpcd_test_params)
+{
+	enum dp_test_pattern test_pattern;
+	enum dp_test_pattern_color_space test_pattern_color_space =
+			DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED;
+	enum dc_color_depth requestColorDepth = COLOR_DEPTH_UNDEFINED;
+	enum dc_pixel_encoding requestPixelEncoding = PIXEL_ENCODING_UNDEFINED;
+	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (pipes[i].stream == NULL)
+			continue;
+
+		if (pipes[i].stream->link == link && !pipes[i].top_pipe &&
+			!pipes[i].prev_odm_pipe) {
+			pipe_ctx = &pipes[i];
+			break;
+		}
+	}
+
+	if (pipe_ctx == NULL)
+		return false;
+
+	switch (dpcd_test_pattern.bits.PATTERN) {
+	case LINK_TEST_PATTERN_COLOR_RAMP:
+		test_pattern = DP_TEST_PATTERN_COLOR_RAMP;
+	break;
+	case LINK_TEST_PATTERN_VERTICAL_BARS:
+		test_pattern = DP_TEST_PATTERN_VERTICAL_BARS;
+	break; /* black and white */
+	case LINK_TEST_PATTERN_COLOR_SQUARES:
+		test_pattern = (dpcd_test_params.bits.DYN_RANGE ==
+				TEST_DYN_RANGE_VESA ?
+				DP_TEST_PATTERN_COLOR_SQUARES :
+				DP_TEST_PATTERN_COLOR_SQUARES_CEA);
+	break;
+	default:
+		test_pattern = DP_TEST_PATTERN_VIDEO_MODE;
+	break;
+	}
+
+	if (dpcd_test_params.bits.CLR_FORMAT == 0)
+		test_pattern_color_space = DP_TEST_PATTERN_COLOR_SPACE_RGB;
+	else
+		test_pattern_color_space = dpcd_test_params.bits.YCBCR_COEFS ?
+				DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 :
+				DP_TEST_PATTERN_COLOR_SPACE_YCBCR601;
+
+	switch (dpcd_test_params.bits.BPC) {
+	case 0: // 6 bits
+		requestColorDepth = COLOR_DEPTH_666;
+		break;
+	case 1: // 8 bits
+		requestColorDepth = COLOR_DEPTH_888;
+		break;
+	case 2: // 10 bits
+		requestColorDepth = COLOR_DEPTH_101010;
+		break;
+	case 3: // 12 bits
+		requestColorDepth = COLOR_DEPTH_121212;
+		break;
+	default:
+		break;
+	}
+
+	switch (dpcd_test_params.bits.CLR_FORMAT) {
+	case 0:
+		requestPixelEncoding = PIXEL_ENCODING_RGB;
+		break;
+	case 1:
+		requestPixelEncoding = PIXEL_ENCODING_YCBCR422;
+		break;
+	case 2:
+		requestPixelEncoding = PIXEL_ENCODING_YCBCR444;
+		break;
+	default:
+		requestPixelEncoding = PIXEL_ENCODING_RGB;
+		break;
+	}
+
+	if ((requestColorDepth != COLOR_DEPTH_UNDEFINED
+		&& pipe_ctx->stream->timing.display_color_depth != requestColorDepth)
+		|| (requestPixelEncoding != PIXEL_ENCODING_UNDEFINED
+		&& pipe_ctx->stream->timing.pixel_encoding != requestPixelEncoding)) {
+		DC_LOG_DEBUG("%s: original bpc %d pix encoding %d, changing to %d  %d\n",
+				__func__,
+				pipe_ctx->stream->timing.display_color_depth,
+				pipe_ctx->stream->timing.pixel_encoding,
+				requestColorDepth,
+				requestPixelEncoding);
+		pipe_ctx->stream->timing.display_color_depth = requestColorDepth;
+		pipe_ctx->stream->timing.pixel_encoding = requestPixelEncoding;
+
+		dp_update_dsc_config(pipe_ctx);
+
+		aconnector->timing_changed = true;
+		/* store current timing */
+		if (aconnector->timing_requested)
+			*aconnector->timing_requested = pipe_ctx->stream->timing;
+		else
+			DC_LOG_ERROR("%s: timing storage failed\n", __func__);
+
+	}
+
+	dc_link_dp_set_test_pattern(
+		(struct dc_link *) link,
+		test_pattern,
+		test_pattern_color_space,
+		NULL,
+		NULL,
+		0);
+
+	return false;
+}
+
 void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
 {
        // TODO
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e2f9141d6d93..05708684c9f5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -590,8 +590,118 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	return connector;
 }
 
+void dm_handle_mst_sideband_msg_ready_event(
+	struct drm_dp_mst_topology_mgr *mgr,
+	enum mst_msg_ready_type msg_rdy_type)
+{
+	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
+	uint8_t dret;
+	bool new_irq_handled = false;
+	int dpcd_addr;
+	uint8_t dpcd_bytes_to_read;
+	const uint8_t max_process_count = 30;
+	uint8_t process_count = 0;
+	u8 retry;
+	struct amdgpu_dm_connector *aconnector =
+			container_of(mgr, struct amdgpu_dm_connector, mst_mgr);
+
+
+	const struct dc_link_status *link_status = dc_link_get_status(aconnector->dc_link);
+
+	if (link_status->dpcd_caps->dpcd_rev.raw < 0x12) {
+		dpcd_bytes_to_read = DP_LANE0_1_STATUS - DP_SINK_COUNT;
+		/* DPCD 0x200 - 0x201 for downstream IRQ */
+		dpcd_addr = DP_SINK_COUNT;
+	} else {
+		dpcd_bytes_to_read = DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI;
+		/* DPCD 0x2002 - 0x2005 for downstream IRQ */
+		dpcd_addr = DP_SINK_COUNT_ESI;
+	}
+
+	mutex_lock(&aconnector->handle_mst_msg_ready);
+
+	while (process_count < max_process_count) {
+		u8 ack[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = {};
+
+		process_count++;
+
+		dret = drm_dp_dpcd_read(
+			&aconnector->dm_dp_aux.aux,
+			dpcd_addr,
+			esi,
+			dpcd_bytes_to_read);
+
+		if (dret != dpcd_bytes_to_read) {
+			DRM_DEBUG_KMS("DPCD read and acked number is not as expected!");
+			break;
+		}
+
+		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
+
+		switch (msg_rdy_type) {
+		case DOWN_REP_MSG_RDY_EVENT:
+			/* Only handle DOWN_REP_MSG_RDY case*/
+			esi[1] &= DP_DOWN_REP_MSG_RDY;
+			break;
+		case UP_REQ_MSG_RDY_EVENT:
+			/* Only handle UP_REQ_MSG_RDY case*/
+			esi[1] &= DP_UP_REQ_MSG_RDY;
+			break;
+		default:
+			/* Handle both cases*/
+			esi[1] &= (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY);
+			break;
+		}
+
+		if (!esi[1])
+			break;
+
+		/* handle MST irq */
+		if (aconnector->mst_mgr.mst_state)
+			drm_dp_mst_hpd_irq_handle_event(&aconnector->mst_mgr,
+						 esi,
+						 ack,
+						 &new_irq_handled);
+
+		if (new_irq_handled) {
+			/* ACK at DPCD to notify down stream */
+			for (retry = 0; retry < 3; retry++) {
+				ssize_t wret;
+
+				wret = drm_dp_dpcd_writeb(&aconnector->dm_dp_aux.aux,
+							  dpcd_addr + 1,
+							  ack[1]);
+				if (wret == 1)
+					break;
+			}
+
+			if (retry == 3) {
+				DRM_ERROR("Failed to ack MST event.\n");
+				return;
+			}
+
+			drm_dp_mst_hpd_irq_send_new_request(&aconnector->mst_mgr);
+
+			new_irq_handled = false;
+		} else {
+			break;
+		}
+	}
+
+	mutex_unlock(&aconnector->handle_mst_msg_ready);
+
+	if (process_count == max_process_count)
+		DRM_DEBUG_DRIVER("Loop exceeded max iterations\n");
+}
+
+static void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
+{
+	dm_handle_mst_sideband_msg_ready_event(mgr, DOWN_REP_MSG_RDY_EVENT);
+}
+
 static const struct drm_dp_mst_topology_cbs dm_mst_cbs = {
 	.add_connector = dm_dp_add_mst_connector,
+	.poll_hpd_irq = dm_handle_mst_down_rep_msg_ready,
 };
 
 void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
@@ -673,15 +783,18 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 		int count,
 		int k)
 {
+	struct drm_connector *drm_connector;
 	int i;
 
 	for (i = 0; i < count; i++) {
+		drm_connector = &params[i].aconnector->base;
+
 		memset(&params[i].timing->dsc_cfg, 0, sizeof(params[i].timing->dsc_cfg));
 		if (vars[i + k].dsc_enabled && dc_dsc_compute_config(
 					params[i].sink->ctx->dc->res_pool->dscs[0],
 					&params[i].sink->dsc_caps.dsc_dec_caps,
 					params[i].sink->ctx->dc->debug.dsc_min_slice_height_override,
-					params[i].sink->edid_caps.panel_patch.max_dsc_target_bpp_limit,
+					drm_connector->display_info.max_dsc_bpp,
 					0,
 					params[i].timing,
 					&params[i].timing->dsc_cfg)) {
@@ -723,12 +836,16 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 	struct dc_dsc_config dsc_config;
 	u64 kbps;
 
+	struct drm_connector *drm_connector = &param.aconnector->base;
+	uint32_t max_dsc_target_bpp_limit_override =
+		drm_connector->display_info.max_dsc_bpp;
+
 	kbps = div_u64((u64)pbn * 994 * 8 * 54, 64);
 	dc_dsc_compute_config(
 			param.sink->ctx->dc->res_pool->dscs[0],
 			&param.sink->dsc_caps.dsc_dec_caps,
 			param.sink->ctx->dc->debug.dsc_min_slice_height_override,
-			param.sink->edid_caps.panel_patch.max_dsc_target_bpp_limit,
+			max_dsc_target_bpp_limit_override,
 			(int) kbps, param.timing, &dsc_config);
 
 	return dsc_config.bits_per_pixel;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 1e4ede1e57ab..37c820ab0fdb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -49,6 +49,13 @@
 #define PBN_FEC_OVERHEAD_MULTIPLIER_8B_10B	1031
 #define PBN_FEC_OVERHEAD_MULTIPLIER_128B_132B	1000
 
+enum mst_msg_ready_type {
+	NONE_MSG_RDY_EVENT = 0,
+	DOWN_REP_MSG_RDY_EVENT = 1,
+	UP_REQ_MSG_RDY_EVENT = 2,
+	DOWN_OR_UP_MSG_RDY_EVENT = 3
+};
+
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
 
@@ -61,6 +68,10 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 void
 dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev);
 
+void dm_handle_mst_sideband_msg_ready_event(
+	struct drm_dp_mst_topology_mgr *mgr,
+	enum mst_msg_ready_type msg_rdy_type);
+
 struct dsc_mst_fairness_vars {
 	int pbn;
 	bool dsc_enabled;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index c1eaf571407a..9f593eddb6b7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -86,6 +86,11 @@ static int dcn31_get_active_display_cnt_wa(
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
 				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
 			tmds_present = true;
+
+		/* Checking stream / link detection ensuring that PHY is active*/
+		if (dc_is_dp_signal(stream->signal) && !stream->dpms_off)
+			display_count++;
+
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 24f1aba4ae13..82b747c0ed69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3115,7 +3115,7 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	return max_link_cap;
 }
 
-static enum dc_status read_hpd_rx_irq_data(
+enum dc_status read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data)
 {
@@ -4264,124 +4264,6 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 		test_pattern_size);
 }
 
-static void dp_test_send_link_test_pattern(struct dc_link *link)
-{
-	union link_test_pattern dpcd_test_pattern;
-	union test_misc dpcd_test_params;
-	enum dp_test_pattern test_pattern;
-	enum dp_test_pattern_color_space test_pattern_color_space =
-			DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED;
-	enum dc_color_depth requestColorDepth = COLOR_DEPTH_UNDEFINED;
-	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
-	struct pipe_ctx *pipe_ctx = NULL;
-	int i;
-
-	memset(&dpcd_test_pattern, 0, sizeof(dpcd_test_pattern));
-	memset(&dpcd_test_params, 0, sizeof(dpcd_test_params));
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (pipes[i].stream == NULL)
-			continue;
-
-		if (pipes[i].stream->link == link && !pipes[i].top_pipe && !pipes[i].prev_odm_pipe) {
-			pipe_ctx = &pipes[i];
-			break;
-		}
-	}
-
-	if (pipe_ctx == NULL)
-		return;
-
-	/* get link test pattern and pattern parameters */
-	core_link_read_dpcd(
-			link,
-			DP_TEST_PATTERN,
-			&dpcd_test_pattern.raw,
-			sizeof(dpcd_test_pattern));
-	core_link_read_dpcd(
-			link,
-			DP_TEST_MISC0,
-			&dpcd_test_params.raw,
-			sizeof(dpcd_test_params));
-
-	switch (dpcd_test_pattern.bits.PATTERN) {
-	case LINK_TEST_PATTERN_COLOR_RAMP:
-		test_pattern = DP_TEST_PATTERN_COLOR_RAMP;
-	break;
-	case LINK_TEST_PATTERN_VERTICAL_BARS:
-		test_pattern = DP_TEST_PATTERN_VERTICAL_BARS;
-	break; /* black and white */
-	case LINK_TEST_PATTERN_COLOR_SQUARES:
-		test_pattern = (dpcd_test_params.bits.DYN_RANGE ==
-				TEST_DYN_RANGE_VESA ?
-				DP_TEST_PATTERN_COLOR_SQUARES :
-				DP_TEST_PATTERN_COLOR_SQUARES_CEA);
-	break;
-	default:
-		test_pattern = DP_TEST_PATTERN_VIDEO_MODE;
-	break;
-	}
-
-	if (dpcd_test_params.bits.CLR_FORMAT == 0)
-		test_pattern_color_space = DP_TEST_PATTERN_COLOR_SPACE_RGB;
-	else
-		test_pattern_color_space = dpcd_test_params.bits.YCBCR_COEFS ?
-				DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 :
-				DP_TEST_PATTERN_COLOR_SPACE_YCBCR601;
-
-	switch (dpcd_test_params.bits.BPC) {
-	case 0: // 6 bits
-		requestColorDepth = COLOR_DEPTH_666;
-		break;
-	case 1: // 8 bits
-		requestColorDepth = COLOR_DEPTH_888;
-		break;
-	case 2: // 10 bits
-		requestColorDepth = COLOR_DEPTH_101010;
-		break;
-	case 3: // 12 bits
-		requestColorDepth = COLOR_DEPTH_121212;
-		break;
-	default:
-		break;
-	}
-
-	switch (dpcd_test_params.bits.CLR_FORMAT) {
-	case 0:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_RGB;
-		break;
-	case 1:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_YCBCR422;
-		break;
-	case 2:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_YCBCR444;
-		break;
-	default:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_RGB;
-		break;
-	}
-
-
-	if (requestColorDepth != COLOR_DEPTH_UNDEFINED
-			&& pipe_ctx->stream->timing.display_color_depth != requestColorDepth) {
-		DC_LOG_DEBUG("%s: original bpc %d, changing to %d\n",
-				__func__,
-				pipe_ctx->stream->timing.display_color_depth,
-				requestColorDepth);
-		pipe_ctx->stream->timing.display_color_depth = requestColorDepth;
-	}
-
-	dp_update_dsc_config(pipe_ctx);
-
-	dc_link_dp_set_test_pattern(
-			link,
-			test_pattern,
-			test_pattern_color_space,
-			NULL,
-			NULL,
-			0);
-}
-
 static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video)
 {
 	union audio_test_mode            dpcd_test_mode = {0};
@@ -4494,8 +4376,25 @@ void dc_link_dp_handle_automated_test(struct dc_link *link)
 		test_response.bits.ACK = 0;
 	}
 	if (test_request.bits.LINK_TEST_PATTRN) {
-		dp_test_send_link_test_pattern(link);
-		test_response.bits.ACK = 1;
+		union test_misc dpcd_test_params;
+		union link_test_pattern dpcd_test_pattern;
+
+		memset(&dpcd_test_pattern, 0, sizeof(dpcd_test_pattern));
+		memset(&dpcd_test_params, 0, sizeof(dpcd_test_params));
+
+		/* get link test pattern and pattern parameters */
+		core_link_read_dpcd(
+				link,
+				DP_TEST_PATTERN,
+				&dpcd_test_pattern.raw,
+				sizeof(dpcd_test_pattern));
+		core_link_read_dpcd(
+				link,
+				DP_TEST_MISC0,
+				&dpcd_test_params.raw,
+				sizeof(dpcd_test_params));
+		test_response.bits.ACK = dm_helpers_dp_handle_test_pattern_request(link->ctx, link,
+				dpcd_test_pattern, dpcd_test_params) ? 1 : 0;
 	}
 
 	if (test_request.bits.AUDIO_TEST_PATTERN) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 0dcd9fea122d..a6fde27d1347 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3293,7 +3293,8 @@ void dcn10_wait_for_mpcc_disconnect(
 		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
 			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
 
-			if (pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg))
+			if (pipe_ctx->stream_res.tg &&
+				pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg))
 				res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
 			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
 			hubp->funcs->set_blank(hubp, true);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 7e7f18bef098..1f263326cdf9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -65,7 +65,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index e3e5c39895a3..d0ad682fdde8 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -156,6 +156,12 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		struct dc_link *link,
 		struct dc_sink *sink);
 
+bool dm_helpers_dp_handle_test_pattern_request(
+		struct dc_context *ctx,
+		const struct dc_link *link,
+		union link_test_pattern dpcd_test_pattern,
+		union test_misc dpcd_test_params);
+
 void dm_set_dcn_clocks(
 		struct dc_context *ctx,
 		struct dc_clocks *clks);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index b304d450b038..d60d93ed7df0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -82,6 +82,10 @@ bool perform_link_training_with_retries(
 	enum signal_type signal,
 	bool do_fallback);
 
+enum dc_status read_hpd_rx_irq_data(
+	struct dc_link *link,
+	union hpd_irq_data *irq_data);
+
 bool hpd_rx_irq_check_link_loss_status(
 	struct dc_link *link,
 	union hpd_irq_data *hpd_irq_dpcd_data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f7ed3e655e39..1b7d93709a35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1927,12 +1927,16 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_CURR_UCLK,
+							  (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_AVERAGE_GFXCLK,
+							  (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d980eff2b616..bf24850027da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -940,7 +940,7 @@ static int smu_v13_0_7_read_sensor(struct smu_context *smu,
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
 		ret = smu_v13_0_7_get_smu_metrics_data(smu,
-						       METRICS_AVERAGE_UCLK,
+						       METRICS_CURR_UCLK,
 						       (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index e2e21ce79510..f854cb5eafbe 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4053,17 +4053,28 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 }
 
 /**
- * drm_dp_mst_hpd_irq() - MST hotplug IRQ notify
+ * drm_dp_mst_hpd_irq_handle_event() - MST hotplug IRQ handle MST event
  * @mgr: manager to notify irq for.
  * @esi: 4 bytes from SINK_COUNT_ESI
+ * @ack: 4 bytes used to ack events starting from SINK_COUNT_ESI
  * @handled: whether the hpd interrupt was consumed or not
  *
- * This should be called from the driver when it detects a short IRQ,
+ * This should be called from the driver when it detects a HPD IRQ,
  * along with the value of the DEVICE_SERVICE_IRQ_VECTOR_ESI0. The
- * topology manager will process the sideband messages received as a result
- * of this.
+ * topology manager will process the sideband messages received
+ * as indicated in the DEVICE_SERVICE_IRQ_VECTOR_ESI0 and set the
+ * corresponding flags that Driver has to ack the DP receiver later.
+ *
+ * Note that driver shall also call
+ * drm_dp_mst_hpd_irq_send_new_request() if the 'handled' is set
+ * after calling this function, to try to kick off a new request in
+ * the queue if the previous message transaction is completed.
+ *
+ * See also:
+ * drm_dp_mst_hpd_irq_send_new_request()
  */
-int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled)
+int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr, const u8 *esi,
+				    u8 *ack, bool *handled)
 {
 	int ret = 0;
 	int sc;
@@ -4078,18 +4089,47 @@ int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handl
 	if (esi[1] & DP_DOWN_REP_MSG_RDY) {
 		ret = drm_dp_mst_handle_down_rep(mgr);
 		*handled = true;
+		ack[1] |= DP_DOWN_REP_MSG_RDY;
 	}
 
 	if (esi[1] & DP_UP_REQ_MSG_RDY) {
 		ret |= drm_dp_mst_handle_up_req(mgr);
 		*handled = true;
+		ack[1] |= DP_UP_REQ_MSG_RDY;
 	}
 
-	drm_dp_mst_kick_tx(mgr);
 	return ret;
 }
-EXPORT_SYMBOL(drm_dp_mst_hpd_irq);
+EXPORT_SYMBOL(drm_dp_mst_hpd_irq_handle_event);
 
+/**
+ * drm_dp_mst_hpd_irq_send_new_request() - MST hotplug IRQ kick off new request
+ * @mgr: manager to notify irq for.
+ *
+ * This should be called from the driver when mst irq event is handled
+ * and acked. Note that new down request should only be sent when
+ * previous message transaction is completed. Source is not supposed to generate
+ * interleaved message transactions.
+ */
+void drm_dp_mst_hpd_irq_send_new_request(struct drm_dp_mst_topology_mgr *mgr)
+{
+	struct drm_dp_sideband_msg_tx *txmsg;
+	bool kick = true;
+
+	mutex_lock(&mgr->qlock);
+	txmsg = list_first_entry_or_null(&mgr->tx_msg_downq,
+					 struct drm_dp_sideband_msg_tx, next);
+	/* If last transaction is not completed yet*/
+	if (!txmsg ||
+	    txmsg->state == DRM_DP_SIDEBAND_TX_START_SEND ||
+	    txmsg->state == DRM_DP_SIDEBAND_TX_SENT)
+		kick = false;
+	mutex_unlock(&mgr->qlock);
+
+	if (kick)
+		drm_dp_mst_kick_tx(mgr);
+}
+EXPORT_SYMBOL(drm_dp_mst_hpd_irq_send_new_request);
 /**
  * drm_dp_mst_detect_port() - get connection status for an MST port
  * @connector: DRM connector for this port
diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index bbc535cc50dd..7847020de0a4 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -315,6 +315,9 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 	can_clone = true;
 	dmt_mode = drm_mode_find_dmt(dev, 1024, 768, 60, false);
 
+	if (!dmt_mode)
+		goto fail;
+
 	for (i = 0; i < connector_count; i++) {
 		if (!enabled[i])
 			continue;
@@ -330,11 +333,13 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 		if (!modes[i])
 			can_clone = false;
 	}
+	kfree(dmt_mode);
 
 	if (can_clone) {
 		DRM_DEBUG_KMS("can clone using 1024x768\n");
 		return true;
 	}
+fail:
 	DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
 	return false;
 }
@@ -866,6 +871,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 				break;
 			}
 
+			kfree(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index b1653308f145..594ea037050a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3804,9 +3804,7 @@ intel_dp_mst_hpd_irq(struct intel_dp *intel_dp, u8 *esi, u8 *ack)
 {
 	bool handled = false;
 
-	drm_dp_mst_hpd_irq(&intel_dp->mst_mgr, esi, &handled);
-	if (handled)
-		ack[1] |= esi[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY);
+	drm_dp_mst_hpd_irq_handle_event(&intel_dp->mst_mgr, esi, ack, &handled);
 
 	if (esi[1] & DP_CP_IRQ) {
 		intel_hdcp_handle_cp_irq(intel_dp->attached_connector);
@@ -3881,6 +3879,9 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 
 		if (!intel_dp_ack_sink_irq_esi(intel_dp, ack))
 			drm_dbg_kms(&i915->drm, "Failed to ack ESI\n");
+
+		if (ack[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY))
+			drm_dp_mst_hpd_irq_send_new_request(&intel_dp->mst_mgr);
 	}
 
 	return link_ok;
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 006cb76adaa9..a851354c0c5f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1473,22 +1473,26 @@ nv50_mstm_service(struct nouveau_drm *drm,
 	u8 esi[8] = {};
 
 	while (handled) {
+		u8 ack[8] = {};
+
 		rc = drm_dp_dpcd_read(aux, DP_SINK_COUNT_ESI, esi, 8);
 		if (rc != 8) {
 			ret = false;
 			break;
 		}
 
-		drm_dp_mst_hpd_irq(&mstm->mgr, esi, &handled);
+		drm_dp_mst_hpd_irq_handle_event(&mstm->mgr, esi, ack, &handled);
 		if (!handled)
 			break;
 
-		rc = drm_dp_dpcd_write(aux, DP_SINK_COUNT_ESI + 1, &esi[1],
-				       3);
-		if (rc != 3) {
+		rc = drm_dp_dpcd_writeb(aux, DP_SINK_COUNT_ESI + 1, ack[1]);
+
+		if (rc != 1) {
 			ret = false;
 			break;
 		}
+
+		drm_dp_mst_hpd_irq_send_new_request(&mstm->mgr);
 	}
 
 	if (!ret)
diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 446f7bae54c4..e3664f65d1a9 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -270,7 +270,8 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 {
 	struct drm_radeon_cs *cs = data;
 	uint64_t *chunk_array_ptr;
-	unsigned size, i;
+	u64 size;
+	unsigned i;
 	u32 ring = RADEON_CS_RING_GFX;
 	s32 priority = 0;
 
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index a729c32a1e48..3287032a2f8e 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -85,6 +85,8 @@ static void ttm_lru_bulk_move_pos_tail(struct ttm_lru_bulk_move_pos *pos,
 				       struct ttm_resource *res)
 {
 	if (pos->last != res) {
+		if (pos->first == res)
+			pos->first = list_next_entry(res, lru);
 		list_move(&res->lru, &pos->last->lru);
 		pos->last = res;
 	}
@@ -110,7 +112,8 @@ static void ttm_lru_bulk_move_del(struct ttm_lru_bulk_move *bulk,
 {
 	struct ttm_lru_bulk_move_pos *pos = ttm_lru_bulk_move_pos(bulk, res);
 
-	if (unlikely(pos->first == res && pos->last == res)) {
+	if (unlikely(WARN_ON(!pos->first || !pos->last) ||
+		     (pos->first == res && pos->last == res))) {
 		pos->first = NULL;
 		pos->last = NULL;
 	} else if (pos->first == res) {
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 653db6cdab57..9a17e5cc3539 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -614,6 +614,7 @@
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
 
 #define USB_VENDOR_ID_HP		0x03f0
+#define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE		0x134a
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 66e64350f138..f8f20a7c24b1 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -96,6 +96,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A293), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A), HID_QUIRK_ALWAYS_POLL },
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 68df6d4641b5..eebf967f4711 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -227,6 +227,8 @@ static int
 __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 			  const u8 mode_req, bool nowait)
 {
+	const struct can_bittiming *bt = &priv->can.bittiming;
+	unsigned long timeout_us = MCP251XFD_POLL_TIMEOUT_US;
 	u32 con = 0, con_reqop, osc = 0;
 	u8 mode;
 	int err;
@@ -246,12 +248,16 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 	if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP || nowait)
 		return 0;
 
+	if (bt->bitrate)
+		timeout_us = max_t(unsigned long, timeout_us,
+				   MCP251XFD_FRAME_LEN_MAX_BITS * USEC_PER_SEC /
+				   bt->bitrate);
+
 	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_CON, con,
 				       !mcp251xfd_reg_invalid(con) &&
 				       FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
 						 con) == mode_req,
-				       MCP251XFD_POLL_SLEEP_US,
-				       MCP251XFD_POLL_TIMEOUT_US);
+				       MCP251XFD_POLL_SLEEP_US, timeout_us);
 	if (err != -ETIMEDOUT && err != -EBADMSG)
 		return err;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 2b0309fedfac..ba0fd2b95a52 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -387,6 +387,7 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 #define MCP251XFD_OSC_STAB_TIMEOUT_US (10 * MCP251XFD_OSC_STAB_SLEEP_US)
 #define MCP251XFD_POLL_SLEEP_US (10)
 #define MCP251XFD_POLL_TIMEOUT_US (USEC_PER_MSEC)
+#define MCP251XFD_FRAME_LEN_MAX_BITS (736)
 
 /* Misc */
 #define MCP251XFD_NAPI_WEIGHT 32
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 9c2c25fde3d1..fe532d504889 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -833,6 +833,7 @@ static int gs_can_open(struct net_device *netdev)
 		.mode = cpu_to_le32(GS_CAN_MODE_START),
 	};
 	struct gs_host_frame *hf;
+	struct urb *urb = NULL;
 	u32 ctrlmode;
 	u32 flags = 0;
 	int rc, i;
@@ -858,13 +859,14 @@ static int gs_can_open(struct net_device *netdev)
 
 	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
-			struct urb *urb;
 			u8 *buf;
 
 			/* alloc rx urb */
 			urb = usb_alloc_urb(0, GFP_KERNEL);
-			if (!urb)
-				return -ENOMEM;
+			if (!urb) {
+				rc = -ENOMEM;
+				goto out_usb_kill_anchored_urbs;
+			}
 
 			/* alloc rx buffer */
 			buf = kmalloc(dev->parent->hf_size_rx,
@@ -872,8 +874,8 @@ static int gs_can_open(struct net_device *netdev)
 			if (!buf) {
 				netdev_err(netdev,
 					   "No memory left for USB buffer\n");
-				usb_free_urb(urb);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto out_usb_free_urb;
 			}
 
 			/* fill, anchor, and submit rx urb */
@@ -896,9 +898,7 @@ static int gs_can_open(struct net_device *netdev)
 				netdev_err(netdev,
 					   "usb_submit failed (err=%d)\n", rc);
 
-				usb_unanchor_urb(urb);
-				usb_free_urb(urb);
-				break;
+				goto out_usb_unanchor_urb;
 			}
 
 			/* Drop reference,
@@ -944,7 +944,8 @@ static int gs_can_open(struct net_device *netdev)
 		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 			gs_usb_timestamp_stop(dev);
 		dev->can.state = CAN_STATE_STOPPED;
-		return rc;
+
+		goto out_usb_kill_anchored_urbs;
 	}
 
 	parent->active_channels++;
@@ -952,6 +953,18 @@ static int gs_can_open(struct net_device *netdev)
 		netif_start_queue(netdev);
 
 	return 0;
+
+out_usb_unanchor_urb:
+	usb_unanchor_urb(urb);
+out_usb_free_urb:
+	usb_free_urb(urb);
+out_usb_kill_anchored_urbs:
+	if (!parent->active_channels)
+		usb_kill_anchored_urbs(&dev->tx_submitted);
+
+	close_candev(netdev);
+
+	return rc;
 }
 
 static int gs_can_close(struct net_device *netdev)
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 8582b4b67d98..28137c4bf292 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -21,8 +21,6 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
 int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
 int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 			 u8 *fid, u8 *src_port, u8 *timestamp, u16 *entries);
-int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
-			 struct alu_struct *alu);
 void ksz8_w_sta_mac_table(struct ksz_device *dev, u16 addr,
 			  struct alu_struct *alu);
 void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt);
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 22250ae222b5..c63e082dc57d 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -406,8 +406,8 @@ int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	return rc;
 }
 
-int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
-			 struct alu_struct *alu)
+static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
+				struct alu_struct *alu, bool *valid)
 {
 	u32 data_hi, data_lo;
 	const u8 *shifts;
@@ -420,28 +420,38 @@ int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
 	ksz8_r_table(dev, TABLE_STATIC_MAC, addr, &data);
 	data_hi = data >> 32;
 	data_lo = (u32)data;
-	if (data_hi & (masks[STATIC_MAC_TABLE_VALID] |
-			masks[STATIC_MAC_TABLE_OVERRIDE])) {
-		alu->mac[5] = (u8)data_lo;
-		alu->mac[4] = (u8)(data_lo >> 8);
-		alu->mac[3] = (u8)(data_lo >> 16);
-		alu->mac[2] = (u8)(data_lo >> 24);
-		alu->mac[1] = (u8)data_hi;
-		alu->mac[0] = (u8)(data_hi >> 8);
-		alu->port_forward =
-			(data_hi & masks[STATIC_MAC_TABLE_FWD_PORTS]) >>
-				shifts[STATIC_MAC_FWD_PORTS];
-		alu->is_override =
-			(data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
-		data_hi >>= 1;
-		alu->is_static = true;
-		alu->is_use_fid =
-			(data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
-		alu->fid = (data_hi & masks[STATIC_MAC_TABLE_FID]) >>
-				shifts[STATIC_MAC_FID];
+
+	if (!(data_hi & (masks[STATIC_MAC_TABLE_VALID] |
+			 masks[STATIC_MAC_TABLE_OVERRIDE]))) {
+		*valid = false;
 		return 0;
 	}
-	return -ENXIO;
+
+	alu->mac[5] = (u8)data_lo;
+	alu->mac[4] = (u8)(data_lo >> 8);
+	alu->mac[3] = (u8)(data_lo >> 16);
+	alu->mac[2] = (u8)(data_lo >> 24);
+	alu->mac[1] = (u8)data_hi;
+	alu->mac[0] = (u8)(data_hi >> 8);
+	alu->port_forward =
+		(data_hi & masks[STATIC_MAC_TABLE_FWD_PORTS]) >>
+			shifts[STATIC_MAC_FWD_PORTS];
+	alu->is_override = (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
+
+	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
+	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
+	 * static MAC table compared to doing write.
+	 */
+	if (ksz_is_ksz87xx(dev))
+		data_hi >>= 1;
+	alu->is_static = true;
+	alu->is_use_fid = (data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
+	alu->fid = (data_hi & masks[STATIC_MAC_TABLE_FID]) >>
+		shifts[STATIC_MAC_FID];
+
+	*valid = true;
+
+	return 0;
 }
 
 void ksz8_w_sta_mac_table(struct ksz_device *dev, u16 addr,
@@ -926,24 +936,29 @@ int ksz8_fdb_dump(struct ksz_device *dev, int port,
 	return ret;
 }
 
-int ksz8_mdb_add(struct ksz_device *dev, int port,
-		 const struct switchdev_obj_port_mdb *mdb, struct dsa_db db)
+static int ksz8_add_sta_mac(struct ksz_device *dev, int port,
+			    const unsigned char *addr, u16 vid)
 {
 	struct alu_struct alu;
-	int index;
+	int index, ret;
 	int empty = 0;
 
 	alu.port_forward = 0;
 	for (index = 0; index < dev->info->num_statics; index++) {
-		if (!ksz8_r_sta_mac_table(dev, index, &alu)) {
-			/* Found one already in static MAC table. */
-			if (!memcmp(alu.mac, mdb->addr, ETH_ALEN) &&
-			    alu.fid == mdb->vid)
-				break;
-		/* Remember the first empty entry. */
-		} else if (!empty) {
-			empty = index + 1;
+		bool valid;
+
+		ret = ksz8_r_sta_mac_table(dev, index, &alu, &valid);
+		if (ret)
+			return ret;
+		if (!valid) {
+			/* Remember the first empty entry. */
+			if (!empty)
+				empty = index + 1;
+			continue;
 		}
+
+		if (!memcmp(alu.mac, addr, ETH_ALEN) && alu.fid == vid)
+			break;
 	}
 
 	/* no available entry */
@@ -954,34 +969,38 @@ int ksz8_mdb_add(struct ksz_device *dev, int port,
 	if (index == dev->info->num_statics) {
 		index = empty - 1;
 		memset(&alu, 0, sizeof(alu));
-		memcpy(alu.mac, mdb->addr, ETH_ALEN);
+		memcpy(alu.mac, addr, ETH_ALEN);
 		alu.is_static = true;
 	}
 	alu.port_forward |= BIT(port);
-	if (mdb->vid) {
+	if (vid) {
 		alu.is_use_fid = true;
 
 		/* Need a way to map VID to FID. */
-		alu.fid = mdb->vid;
+		alu.fid = vid;
 	}
 	ksz8_w_sta_mac_table(dev, index, &alu);
 
 	return 0;
 }
 
-int ksz8_mdb_del(struct ksz_device *dev, int port,
-		 const struct switchdev_obj_port_mdb *mdb, struct dsa_db db)
+static int ksz8_del_sta_mac(struct ksz_device *dev, int port,
+			    const unsigned char *addr, u16 vid)
 {
 	struct alu_struct alu;
-	int index;
+	int index, ret;
 
 	for (index = 0; index < dev->info->num_statics; index++) {
-		if (!ksz8_r_sta_mac_table(dev, index, &alu)) {
-			/* Found one already in static MAC table. */
-			if (!memcmp(alu.mac, mdb->addr, ETH_ALEN) &&
-			    alu.fid == mdb->vid)
-				break;
-		}
+		bool valid;
+
+		ret = ksz8_r_sta_mac_table(dev, index, &alu, &valid);
+		if (ret)
+			return ret;
+		if (!valid)
+			continue;
+
+		if (!memcmp(alu.mac, addr, ETH_ALEN) && alu.fid == vid)
+			break;
 	}
 
 	/* no available entry */
@@ -998,6 +1017,18 @@ int ksz8_mdb_del(struct ksz_device *dev, int port,
 	return 0;
 }
 
+int ksz8_mdb_add(struct ksz_device *dev, int port,
+		 const struct switchdev_obj_port_mdb *mdb, struct dsa_db db)
+{
+	return ksz8_add_sta_mac(dev, port, mdb->addr, mdb->vid);
+}
+
+int ksz8_mdb_del(struct ksz_device *dev, int port,
+		 const struct switchdev_obj_port_mdb *mdb, struct dsa_db db)
+{
+	return ksz8_del_sta_mac(dev, port, mdb->addr, mdb->vid);
+}
+
 int ksz8_port_vlan_filtering(struct ksz_device *dev, int port, bool flag,
 			     struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 3d59298eaa5c..8c492d56d2c3 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -286,13 +286,13 @@ static const u32 ksz8795_masks[] = {
 	[STATIC_MAC_TABLE_VALID]	= BIT(21),
 	[STATIC_MAC_TABLE_USE_FID]	= BIT(23),
 	[STATIC_MAC_TABLE_FID]		= GENMASK(30, 24),
-	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(26),
-	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(24, 20),
+	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(22),
+	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(20, 16),
 	[DYNAMIC_MAC_TABLE_ENTRIES_H]	= GENMASK(6, 0),
-	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(8),
+	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(7),
 	[DYNAMIC_MAC_TABLE_NOT_READY]	= BIT(7),
 	[DYNAMIC_MAC_TABLE_ENTRIES]	= GENMASK(31, 29),
-	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(26, 20),
+	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(22, 16),
 	[DYNAMIC_MAC_TABLE_SRC_PORT]	= GENMASK(26, 24),
 	[DYNAMIC_MAC_TABLE_TIMESTAMP]	= GENMASK(28, 27),
 	[P_MII_TX_FLOW_CTRL]		= BIT(5),
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 9cfa179575ce..d1b2db8e6533 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -512,6 +512,13 @@ static inline void ksz_regmap_unlock(void *__mtx)
 	mutex_unlock(mtx);
 }
 
+static inline bool ksz_is_ksz87xx(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8795_CHIP_ID ||
+	       dev->chip_id == KSZ8794_CHIP_ID ||
+	       dev->chip_id == KSZ8765_CHIP_ID;
+}
+
 static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 {
 	return dev->chip_id == KSZ8830_CHIP_ID;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 4db1652015d1..b69bd44ada1f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -109,6 +109,13 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 			usleep_range(1000, 2000);
 	}
 
+	err = mv88e6xxx_read(chip, addr, reg, &data);
+	if (err)
+		return err;
+
+	if ((data & mask) == val)
+		return 0;
+
 	dev_err(chip->dev, "Timeout while waiting for switch\n");
 	return -ETIMEDOUT;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index bcccd82a2620..f6ededec5a4f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -435,19 +435,36 @@ static void hns3_dbg_fill_content(char *content, u16 len,
 				  const struct hns3_dbg_item *items,
 				  const char **result, u16 size)
 {
+#define HNS3_DBG_LINE_END_LEN	2
 	char *pos = content;
+	u16 item_len;
 	u16 i;
 
+	if (!len) {
+		return;
+	} else if (len <= HNS3_DBG_LINE_END_LEN) {
+		*pos++ = '\0';
+		return;
+	}
+
 	memset(content, ' ', len);
-	for (i = 0; i < size; i++) {
-		if (result)
-			strncpy(pos, result[i], strlen(result[i]));
-		else
-			strncpy(pos, items[i].name, strlen(items[i].name));
+	len -= HNS3_DBG_LINE_END_LEN;
 
-		pos += strlen(items[i].name) + items[i].interval;
+	for (i = 0; i < size; i++) {
+		item_len = strlen(items[i].name) + items[i].interval;
+		if (len < item_len)
+			break;
+
+		if (result) {
+			if (item_len < strlen(result[i]))
+				break;
+			strscpy(pos, result[i], strlen(result[i]));
+		} else {
+			strscpy(pos, items[i].name, strlen(items[i].name));
+		}
+		pos += item_len;
+		len -= item_len;
 	}
-
 	*pos++ = '\n';
 	*pos++ = '\0';
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 142415c84c6b..0ebc21401b7c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -87,16 +87,35 @@ static void hclge_dbg_fill_content(char *content, u16 len,
 				   const struct hclge_dbg_item *items,
 				   const char **result, u16 size)
 {
+#define HCLGE_DBG_LINE_END_LEN	2
 	char *pos = content;
+	u16 item_len;
 	u16 i;
 
+	if (!len) {
+		return;
+	} else if (len <= HCLGE_DBG_LINE_END_LEN) {
+		*pos++ = '\0';
+		return;
+	}
+
 	memset(content, ' ', len);
+	len -= HCLGE_DBG_LINE_END_LEN;
+
 	for (i = 0; i < size; i++) {
-		if (result)
-			strncpy(pos, result[i], strlen(result[i]));
-		else
-			strncpy(pos, items[i].name, strlen(items[i].name));
-		pos += strlen(items[i].name) + items[i].interval;
+		item_len = strlen(items[i].name) + items[i].interval;
+		if (len < item_len)
+			break;
+
+		if (result) {
+			if (item_len < strlen(result[i]))
+				break;
+			strscpy(pos, result[i], strlen(result[i]));
+		} else {
+			strscpy(pos, items[i].name, strlen(items[i].name));
+		}
+		pos += item_len;
+		len -= item_len;
 	}
 	*pos++ = '\n';
 	*pos++ = '\0';
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 6625625f91e4..543931c06bb1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -255,8 +255,10 @@ struct iavf_adapter {
 	struct workqueue_struct *wq;
 	struct work_struct reset_task;
 	struct work_struct adminq_task;
+	struct work_struct finish_config;
 	struct delayed_work client_task;
 	wait_queue_head_t down_waitqueue;
+	wait_queue_head_t reset_waitqueue;
 	wait_queue_head_t vc_waitqueue;
 	struct iavf_q_vector *q_vectors;
 	struct list_head vlan_filter_list;
@@ -518,14 +520,12 @@ int iavf_up(struct iavf_adapter *adapter);
 void iavf_down(struct iavf_adapter *adapter);
 int iavf_process_config(struct iavf_adapter *adapter);
 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
-void iavf_schedule_reset(struct iavf_adapter *adapter);
+void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags);
 void iavf_schedule_request_stats(struct iavf_adapter *adapter);
+void iavf_schedule_finish_config(struct iavf_adapter *adapter);
 void iavf_reset(struct iavf_adapter *adapter);
 void iavf_set_ethtool_ops(struct net_device *netdev);
 void iavf_update_stats(struct iavf_adapter *adapter);
-void iavf_reset_interrupt_capability(struct iavf_adapter *adapter);
-int iavf_init_interrupt_scheme(struct iavf_adapter *adapter);
-void iavf_irq_enable_queues(struct iavf_adapter *adapter);
 void iavf_free_all_tx_resources(struct iavf_adapter *adapter);
 void iavf_free_all_rx_resources(struct iavf_adapter *adapter);
 
@@ -579,17 +579,11 @@ void iavf_enable_vlan_stripping_v2(struct iavf_adapter *adapter, u16 tpid);
 void iavf_disable_vlan_stripping_v2(struct iavf_adapter *adapter, u16 tpid);
 void iavf_enable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid);
 void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid);
-int iavf_replace_primary_mac(struct iavf_adapter *adapter,
-			     const u8 *new_mac);
-void
-iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
-			       netdev_features_t prev_features,
-			       netdev_features_t features);
 void iavf_add_fdir_filter(struct iavf_adapter *adapter);
 void iavf_del_fdir_filter(struct iavf_adapter *adapter);
 void iavf_add_adv_rss_cfg(struct iavf_adapter *adapter);
 void iavf_del_adv_rss_cfg(struct iavf_adapter *adapter);
 struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
 					const u8 *macaddr);
-int iavf_lock_timeout(struct mutex *lock, unsigned int msecs);
+int iavf_wait_for_reset(struct iavf_adapter *adapter);
 #endif /* _IAVF_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 83cfc54a4706..fd6d6f6263f6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -484,6 +484,7 @@ static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 orig_flags, new_flags, changed_flags;
+	int ret = 0;
 	u32 i;
 
 	orig_flags = READ_ONCE(adapter->flags);
@@ -531,12 +532,14 @@ static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 	/* issue a reset to force legacy-rx change to take effect */
 	if (changed_flags & IAVF_FLAG_LEGACY_RX) {
 		if (netif_running(netdev)) {
-			adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-			queue_work(adapter->wq, &adapter->reset_task);
+			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+			ret = iavf_wait_for_reset(adapter);
+			if (ret)
+				netdev_warn(netdev, "Changing private flags timeout or interrupted waiting for reset");
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -627,6 +630,7 @@ static int iavf_set_ringparam(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
+	int ret = 0;
 
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
@@ -671,11 +675,13 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	}
 
 	if (netif_running(netdev)) {
-		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-		queue_work(adapter->wq, &adapter->reset_task);
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+		ret = iavf_wait_for_reset(adapter);
+		if (ret)
+			netdev_warn(netdev, "Changing ring parameters timeout or interrupted waiting for reset");
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1830,7 +1836,7 @@ static int iavf_set_channels(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 num_req = ch->combined_count;
-	int i;
+	int ret = 0;
 
 	if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
 	    adapter->num_tc) {
@@ -1852,22 +1858,13 @@ static int iavf_set_channels(struct net_device *netdev,
 
 	adapter->num_req_queues = num_req;
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
-	iavf_schedule_reset(adapter);
+	iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 
-	/* wait for the reset is done */
-	for (i = 0; i < IAVF_RESET_WAIT_COMPLETE_COUNT; i++) {
-		msleep(IAVF_RESET_WAIT_MS);
-		if (adapter->flags & IAVF_FLAG_RESET_PENDING)
-			continue;
-		break;
-	}
-	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
-		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
-		adapter->num_active_queues = num_req;
-		return -EOPNOTSUPP;
-	}
+	ret = iavf_wait_for_reset(adapter);
+	if (ret)
+		netdev_warn(netdev, "Changing channel count timeout or interrupted waiting for reset");
 
-	return 0;
+	return ret;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 965d02d7ff80..c1f91c55e1ca 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -166,6 +166,45 @@ static struct iavf_adapter *iavf_pdev_to_adapter(struct pci_dev *pdev)
 	return netdev_priv(pci_get_drvdata(pdev));
 }
 
+/**
+ * iavf_is_reset_in_progress - Check if a reset is in progress
+ * @adapter: board private structure
+ */
+static bool iavf_is_reset_in_progress(struct iavf_adapter *adapter)
+{
+	if (adapter->state == __IAVF_RESETTING ||
+	    adapter->flags & (IAVF_FLAG_RESET_PENDING |
+			      IAVF_FLAG_RESET_NEEDED))
+		return true;
+
+	return false;
+}
+
+/**
+ * iavf_wait_for_reset - Wait for reset to finish.
+ * @adapter: board private structure
+ *
+ * Returns 0 if reset finished successfully, negative on timeout or interrupt.
+ */
+int iavf_wait_for_reset(struct iavf_adapter *adapter)
+{
+	int ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
+					!iavf_is_reset_in_progress(adapter),
+					msecs_to_jiffies(5000));
+
+	/* If ret < 0 then it means wait was interrupted.
+	 * If ret == 0 then it means we got a timeout while waiting
+	 * for reset to finish.
+	 * If ret > 0 it means reset has finished.
+	 */
+	if (ret > 0)
+		return 0;
+	else if (ret < 0)
+		return -EINTR;
+	else
+		return -EBUSY;
+}
+
 /**
  * iavf_allocate_dma_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
@@ -253,7 +292,7 @@ enum iavf_status iavf_free_virt_mem_d(struct iavf_hw *hw,
  *
  * Returns 0 on success, negative on failure
  **/
-int iavf_lock_timeout(struct mutex *lock, unsigned int msecs)
+static int iavf_lock_timeout(struct mutex *lock, unsigned int msecs)
 {
 	unsigned int wait, delay = 10;
 
@@ -270,12 +309,14 @@ int iavf_lock_timeout(struct mutex *lock, unsigned int msecs)
 /**
  * iavf_schedule_reset - Set the flags and schedule a reset event
  * @adapter: board private structure
+ * @flags: IAVF_FLAG_RESET_PENDING or IAVF_FLAG_RESET_NEEDED
  **/
-void iavf_schedule_reset(struct iavf_adapter *adapter)
+void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags)
 {
-	if (!(adapter->flags &
-	      (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED))) {
-		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section) &&
+	    !(adapter->flags &
+	    (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED))) {
+		adapter->flags |= flags;
 		queue_work(adapter->wq, &adapter->reset_task);
 	}
 }
@@ -303,7 +344,7 @@ static void iavf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	adapter->tx_timeout_count++;
-	iavf_schedule_reset(adapter);
+	iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 }
 
 /**
@@ -362,7 +403,7 @@ static void iavf_irq_disable(struct iavf_adapter *adapter)
  * iavf_irq_enable_queues - Enable interrupt for all queues
  * @adapter: board private structure
  **/
-void iavf_irq_enable_queues(struct iavf_adapter *adapter)
+static void iavf_irq_enable_queues(struct iavf_adapter *adapter)
 {
 	struct iavf_hw *hw = &adapter->hw;
 	int i;
@@ -1003,8 +1044,8 @@ struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
  *
  * Do not call this with mac_vlan_list_lock!
  **/
-int iavf_replace_primary_mac(struct iavf_adapter *adapter,
-			     const u8 *new_mac)
+static int iavf_replace_primary_mac(struct iavf_adapter *adapter,
+				    const u8 *new_mac)
 {
 	struct iavf_hw *hw = &adapter->hw;
 	struct iavf_mac_filter *f;
@@ -1663,10 +1704,10 @@ static int iavf_set_interrupt_capability(struct iavf_adapter *adapter)
 		adapter->msix_entries[vector].entry = vector;
 
 	err = iavf_acquire_msix_vectors(adapter, v_budget);
+	if (!err)
+		iavf_schedule_finish_config(adapter);
 
 out:
-	netif_set_real_num_rx_queues(adapter->netdev, pairs);
-	netif_set_real_num_tx_queues(adapter->netdev, pairs);
 	return err;
 }
 
@@ -1840,19 +1881,16 @@ static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 static void iavf_free_q_vectors(struct iavf_adapter *adapter)
 {
 	int q_idx, num_q_vectors;
-	int napi_vectors;
 
 	if (!adapter->q_vectors)
 		return;
 
 	num_q_vectors = adapter->num_msix_vectors - NONQ_VECS;
-	napi_vectors = adapter->num_active_queues;
 
 	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
 		struct iavf_q_vector *q_vector = &adapter->q_vectors[q_idx];
 
-		if (q_idx < napi_vectors)
-			netif_napi_del(&q_vector->napi);
+		netif_napi_del(&q_vector->napi);
 	}
 	kfree(adapter->q_vectors);
 	adapter->q_vectors = NULL;
@@ -1863,7 +1901,7 @@ static void iavf_free_q_vectors(struct iavf_adapter *adapter)
  * @adapter: board private structure
  *
  **/
-void iavf_reset_interrupt_capability(struct iavf_adapter *adapter)
+static void iavf_reset_interrupt_capability(struct iavf_adapter *adapter)
 {
 	if (!adapter->msix_entries)
 		return;
@@ -1878,7 +1916,7 @@ void iavf_reset_interrupt_capability(struct iavf_adapter *adapter)
  * @adapter: board private structure to initialize
  *
  **/
-int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
+static int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
 {
 	int err;
 
@@ -1889,9 +1927,7 @@ int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
 		goto err_alloc_queues;
 	}
 
-	rtnl_lock();
 	err = iavf_set_interrupt_capability(adapter);
-	rtnl_unlock();
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"Unable to setup interrupt capabilities\n");
@@ -1944,15 +1980,16 @@ static void iavf_free_rss(struct iavf_adapter *adapter)
 /**
  * iavf_reinit_interrupt_scheme - Reallocate queues and vectors
  * @adapter: board private structure
+ * @running: true if adapter->state == __IAVF_RUNNING
  *
  * Returns 0 on success, negative on failure
  **/
-static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter)
+static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool running)
 {
 	struct net_device *netdev = adapter->netdev;
 	int err;
 
-	if (netif_running(netdev))
+	if (running)
 		iavf_free_traffic_irqs(adapter);
 	iavf_free_misc_irq(adapter);
 	iavf_reset_interrupt_capability(adapter);
@@ -1976,6 +2013,78 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter)
 	return err;
 }
 
+/**
+ * iavf_finish_config - do all netdev work that needs RTNL
+ * @work: our work_struct
+ *
+ * Do work that needs both RTNL and crit_lock.
+ **/
+static void iavf_finish_config(struct work_struct *work)
+{
+	struct iavf_adapter *adapter;
+	int pairs, err;
+
+	adapter = container_of(work, struct iavf_adapter, finish_config);
+
+	/* Always take RTNL first to prevent circular lock dependency */
+	rtnl_lock();
+	mutex_lock(&adapter->crit_lock);
+
+	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES) &&
+	    adapter->netdev_registered &&
+	    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
+		netdev_update_features(adapter->netdev);
+		adapter->flags &= ~IAVF_FLAG_SETUP_NETDEV_FEATURES;
+	}
+
+	switch (adapter->state) {
+	case __IAVF_DOWN:
+		if (!adapter->netdev_registered) {
+			err = register_netdevice(adapter->netdev);
+			if (err) {
+				dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
+					err);
+
+				/* go back and try again.*/
+				iavf_free_rss(adapter);
+				iavf_free_misc_irq(adapter);
+				iavf_reset_interrupt_capability(adapter);
+				iavf_change_state(adapter,
+						  __IAVF_INIT_CONFIG_ADAPTER);
+				goto out;
+			}
+			adapter->netdev_registered = true;
+		}
+
+		/* Set the real number of queues when reset occurs while
+		 * state == __IAVF_DOWN
+		 */
+		fallthrough;
+	case __IAVF_RUNNING:
+		pairs = adapter->num_active_queues;
+		netif_set_real_num_rx_queues(adapter->netdev, pairs);
+		netif_set_real_num_tx_queues(adapter->netdev, pairs);
+		break;
+
+	default:
+		break;
+	}
+
+out:
+	mutex_unlock(&adapter->crit_lock);
+	rtnl_unlock();
+}
+
+/**
+ * iavf_schedule_finish_config - Set the flags and schedule a reset event
+ * @adapter: board private structure
+ **/
+void iavf_schedule_finish_config(struct iavf_adapter *adapter)
+{
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+		queue_work(adapter->wq, &adapter->finish_config);
+}
+
 /**
  * iavf_process_aq_command - process aq_required flags
  * and sends aq command
@@ -2176,7 +2285,7 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
  * the watchdog if any changes are requested to expedite the request via
  * virtchnl.
  **/
-void
+static void
 iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
 			       netdev_features_t prev_features,
 			       netdev_features_t features)
@@ -2383,7 +2492,7 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
 			adapter->vsi_res->num_queue_pairs);
 		adapter->flags |= IAVF_FLAG_REINIT_MSIX_NEEDED;
 		adapter->num_req_queues = adapter->vsi_res->num_queue_pairs;
-		iavf_schedule_reset(adapter);
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 
 		return -EAGAIN;
 	}
@@ -2613,22 +2722,8 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 
 	netif_carrier_off(netdev);
 	adapter->link_up = false;
-
-	/* set the semaphore to prevent any callbacks after device registration
-	 * up to time when state of driver will be set to __IAVF_DOWN
-	 */
-	rtnl_lock();
-	if (!adapter->netdev_registered) {
-		err = register_netdevice(netdev);
-		if (err) {
-			rtnl_unlock();
-			goto err_register;
-		}
-	}
-
-	adapter->netdev_registered = true;
-
 	netif_tx_stop_all_queues(netdev);
+
 	if (CLIENT_ALLOWED(adapter)) {
 		err = iavf_lan_add_device(adapter);
 		if (err)
@@ -2641,7 +2736,6 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 
 	iavf_change_state(adapter, __IAVF_DOWN);
 	set_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
-	rtnl_unlock();
 
 	iavf_misc_irq_enable(adapter);
 	wake_up(&adapter->down_waitqueue);
@@ -2661,10 +2755,11 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 		/* request initial VLAN offload settings */
 		iavf_set_vlan_offload_features(adapter, 0, netdev->features);
 
+	iavf_schedule_finish_config(adapter);
 	return;
+
 err_mem:
 	iavf_free_rss(adapter);
-err_register:
 	iavf_free_misc_irq(adapter);
 err_sw_init:
 	iavf_reset_interrupt_capability(adapter);
@@ -2694,14 +2789,6 @@ static void iavf_watchdog_task(struct work_struct *work)
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		iavf_change_state(adapter, __IAVF_COMM_FAILED);
 
-	if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
-		adapter->aq_required = 0;
-		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-		mutex_unlock(&adapter->crit_lock);
-		queue_work(adapter->wq, &adapter->reset_task);
-		return;
-	}
-
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
 		iavf_startup(adapter);
@@ -2829,11 +2916,10 @@ static void iavf_watchdog_task(struct work_struct *work)
 	/* check for hw reset */
 	reg_val = rd32(hw, IAVF_VF_ARQLEN1) & IAVF_VF_ARQLEN1_ARQENABLE_MASK;
 	if (!reg_val) {
-		adapter->flags |= IAVF_FLAG_RESET_PENDING;
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
-		queue_work(adapter->wq, &adapter->reset_task);
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
 		mutex_unlock(&adapter->crit_lock);
 		queue_delayed_work(adapter->wq,
 				   &adapter->watchdog_task, HZ * 2);
@@ -3059,7 +3145,7 @@ static void iavf_reset_task(struct work_struct *work)
 
 	if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
 	    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
-		err = iavf_reinit_interrupt_scheme(adapter);
+		err = iavf_reinit_interrupt_scheme(adapter, running);
 		if (err)
 			goto reset_err;
 	}
@@ -3154,6 +3240,7 @@ static void iavf_reset_task(struct work_struct *work)
 
 	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 
+	wake_up(&adapter->reset_waitqueue);
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
 
@@ -3230,27 +3317,7 @@ static void iavf_adminq_task(struct work_struct *work)
 	} while (pending);
 	mutex_unlock(&adapter->crit_lock);
 
-	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES)) {
-		if (adapter->netdev_registered ||
-		    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
-			struct net_device *netdev = adapter->netdev;
-
-			rtnl_lock();
-			netdev_update_features(netdev);
-			rtnl_unlock();
-			/* Request VLAN offload settings */
-			if (VLAN_V2_ALLOWED(adapter))
-				iavf_set_vlan_offload_features
-					(adapter, 0, netdev->features);
-
-			iavf_set_queue_vlan_tag_loc(adapter);
-		}
-
-		adapter->flags &= ~IAVF_FLAG_SETUP_NETDEV_FEATURES;
-	}
-	if ((adapter->flags &
-	     (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED)) ||
-	    adapter->state == __IAVF_RESETTING)
+	if (iavf_is_reset_in_progress(adapter))
 		goto freedom;
 
 	/* check for error indications */
@@ -4336,6 +4403,7 @@ static int iavf_close(struct net_device *netdev)
 static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
+	int ret = 0;
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
@@ -4346,11 +4414,15 @@ static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 	}
 
 	if (netif_running(netdev)) {
-		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-		queue_work(adapter->wq, &adapter->reset_task);
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+		ret = iavf_wait_for_reset(adapter);
+		if (ret < 0)
+			netdev_warn(netdev, "MTU change interrupted waiting for reset");
+		else if (ret)
+			netdev_warn(netdev, "MTU change timed out waiting for reset");
 	}
 
-	return 0;
+	return ret;
 }
 
 #define NETIF_VLAN_OFFLOAD_FEATURES	(NETIF_F_HW_VLAN_CTAG_RX | \
@@ -4945,6 +5017,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&adapter->reset_task, iavf_reset_task);
 	INIT_WORK(&adapter->adminq_task, iavf_adminq_task);
+	INIT_WORK(&adapter->finish_config, iavf_finish_config);
 	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
 	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
@@ -4953,6 +5026,9 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
 
+	/* Setup the wait queue for indicating transition to running state */
+	init_waitqueue_head(&adapter->reset_waitqueue);
+
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
@@ -5085,13 +5161,15 @@ static void iavf_remove(struct pci_dev *pdev)
 		usleep_range(500, 1000);
 	}
 	cancel_delayed_work_sync(&adapter->watchdog_task);
+	cancel_work_sync(&adapter->finish_config);
 
+	rtnl_lock();
 	if (adapter->netdev_registered) {
-		rtnl_lock();
 		unregister_netdevice(netdev);
 		adapter->netdev_registered = false;
-		rtnl_unlock();
 	}
+	rtnl_unlock();
+
 	if (CLIENT_ALLOWED(adapter)) {
 		err = iavf_lan_del_device(adapter);
 		if (err)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index e989feda133c..8c5f6096b002 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -54,7 +54,7 @@ static void iavf_unmap_and_free_tx_resource(struct iavf_ring *ring,
  * iavf_clean_tx_ring - Free any empty Tx buffers
  * @tx_ring: ring to be cleaned
  **/
-void iavf_clean_tx_ring(struct iavf_ring *tx_ring)
+static void iavf_clean_tx_ring(struct iavf_ring *tx_ring)
 {
 	unsigned long bi_size;
 	u16 i;
@@ -110,7 +110,7 @@ void iavf_free_tx_resources(struct iavf_ring *tx_ring)
  * Since there is no access to the ring head register
  * in XL710, we need to use our local copies
  **/
-u32 iavf_get_tx_pending(struct iavf_ring *ring, bool in_sw)
+static u32 iavf_get_tx_pending(struct iavf_ring *ring, bool in_sw)
 {
 	u32 head, tail;
 
@@ -127,6 +127,24 @@ u32 iavf_get_tx_pending(struct iavf_ring *ring, bool in_sw)
 	return 0;
 }
 
+/**
+ * iavf_force_wb - Issue SW Interrupt so HW does a wb
+ * @vsi: the VSI we care about
+ * @q_vector: the vector on which to force writeback
+ **/
+static void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector)
+{
+	u32 val = IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
+		  IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK | /* set noitr */
+		  IAVF_VFINT_DYN_CTLN1_SWINT_TRIG_MASK |
+		  IAVF_VFINT_DYN_CTLN1_SW_ITR_INDX_ENA_MASK
+		  /* allow 00 to be written to the index */;
+
+	wr32(&vsi->back->hw,
+	     IAVF_VFINT_DYN_CTLN1(q_vector->reg_idx),
+	     val);
+}
+
 /**
  * iavf_detect_recover_hung - Function to detect and recover hung_queues
  * @vsi:  pointer to vsi struct with tx queues
@@ -352,25 +370,6 @@ static void iavf_enable_wb_on_itr(struct iavf_vsi *vsi,
 	q_vector->arm_wb_state = true;
 }
 
-/**
- * iavf_force_wb - Issue SW Interrupt so HW does a wb
- * @vsi: the VSI we care about
- * @q_vector: the vector  on which to force writeback
- *
- **/
-void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector)
-{
-	u32 val = IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
-		  IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK | /* set noitr */
-		  IAVF_VFINT_DYN_CTLN1_SWINT_TRIG_MASK |
-		  IAVF_VFINT_DYN_CTLN1_SW_ITR_INDX_ENA_MASK
-		  /* allow 00 to be written to the index */;
-
-	wr32(&vsi->back->hw,
-	     IAVF_VFINT_DYN_CTLN1(q_vector->reg_idx),
-	     val);
-}
-
 static inline bool iavf_container_is_rx(struct iavf_q_vector *q_vector,
 					struct iavf_ring_container *rc)
 {
@@ -687,7 +686,7 @@ int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring)
  * iavf_clean_rx_ring - Free Rx buffers
  * @rx_ring: ring to be cleaned
  **/
-void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
+static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
 {
 	unsigned long bi_size;
 	u16 i;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 2624bf6d009e..7e6ee32d19b6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -442,15 +442,11 @@ static inline unsigned int iavf_rx_pg_order(struct iavf_ring *ring)
 
 bool iavf_alloc_rx_buffers(struct iavf_ring *rxr, u16 cleaned_count);
 netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
-void iavf_clean_tx_ring(struct iavf_ring *tx_ring);
-void iavf_clean_rx_ring(struct iavf_ring *rx_ring);
 int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring);
 int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring);
 void iavf_free_tx_resources(struct iavf_ring *tx_ring);
 void iavf_free_rx_resources(struct iavf_ring *rx_ring);
 int iavf_napi_poll(struct napi_struct *napi, int budget);
-void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector);
-u32 iavf_get_tx_pending(struct iavf_ring *ring, bool in_sw);
 void iavf_detect_recover_hung(struct iavf_vsi *vsi);
 int __iavf_maybe_stop_tx(struct iavf_ring *tx_ring, int size);
 bool __iavf_chk_linearize(struct sk_buff *skb);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 00dccdd290dc..2fc8e60ef6af 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1961,9 +1961,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
 			dev_info(&adapter->pdev->dev, "Reset indication received from the PF\n");
 			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING)) {
-				adapter->flags |= IAVF_FLAG_RESET_PENDING;
 				dev_info(&adapter->pdev->dev, "Scheduling reset task\n");
-				queue_work(adapter->wq, &adapter->reset_task);
+				iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
 			}
 			break;
 		default:
@@ -2237,6 +2236,10 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 
 		iavf_process_config(adapter);
 		adapter->flags |= IAVF_FLAG_SETUP_NETDEV_FEATURES;
+		iavf_schedule_finish_config(adapter);
+
+		iavf_set_queue_vlan_tag_loc(adapter);
+
 		was_mac_changed = !ether_addr_equal(netdev->dev_addr,
 						    adapter->hw.mac.addr);
 
@@ -2282,6 +2285,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
 		iavf_irq_enable(adapter, true);
+		wake_up(&adapter->reset_waitqueue);
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 18ffbc892f86..3e0444354632 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9585,6 +9585,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (state == pci_channel_io_normal) {
+		dev_warn(&pdev->dev, "Non-correctable non-fatal error reported.\n");
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	}
+
 	netif_device_detach(netdev);
 
 	if (state == pci_channel_io_perm_failure)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 273941f90f06..2e091a4a065e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2402,6 +2402,8 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
 	nq = txring_txq(ring);
 
 	__netif_tx_lock(nq, cpu);
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	txq_trans_cond_update(nq);
 	res = igc_xdp_init_tx_descriptor(ring, xdpf);
 	__netif_tx_unlock(nq);
 	return res;
@@ -2795,15 +2797,18 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
 	int cpu = smp_processor_id();
-	u16 ntu = ring->next_to_use;
 	struct xdp_desc xdp_desc;
-	u16 budget;
+	u16 budget, ntu;
 
 	if (!netif_carrier_ok(ring->netdev))
 		return;
 
 	__netif_tx_lock(nq, cpu);
 
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	txq_trans_cond_update(nq);
+
+	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
@@ -6297,6 +6302,9 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 
 	__netif_tx_lock(nq, cpu);
 
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	txq_trans_cond_update(nq);
+
 	drops = 0;
 	for (i = 0; i < num_frames; i++) {
 		int err;
diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 35f24e0f0934..ffa96059079c 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -78,8 +78,7 @@ static int liteeth_rx(struct net_device *netdev)
 	memcpy_fromio(data, priv->rx_base + rx_slot * priv->slot_size, len);
 	skb->protocol = eth_type_trans(skb, netdev);
 
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += len;
+	dev_sw_netstats_rx_add(netdev, len);
 
 	return netif_rx(skb);
 
@@ -185,8 +184,7 @@ static netdev_tx_t liteeth_start_xmit(struct sk_buff *skb,
 	litex_write16(priv->base + LITEETH_READER_LENGTH, skb->len);
 	litex_write8(priv->base + LITEETH_READER_START, 1);
 
-	netdev->stats.tx_bytes += skb->len;
-	netdev->stats.tx_packets++;
+	dev_sw_netstats_tx_add(netdev, 1, skb->len);
 
 	priv->tx_slot = (priv->tx_slot + 1) % priv->num_tx_slots;
 	dev_kfree_skb_any(skb);
@@ -194,9 +192,17 @@ static netdev_tx_t liteeth_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static void
+liteeth_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+{
+	netdev_stats_to_stats64(stats, &netdev->stats);
+	dev_fetch_sw_netstats(stats, netdev->tstats);
+}
+
 static const struct net_device_ops liteeth_netdev_ops = {
 	.ndo_open		= liteeth_open,
 	.ndo_stop		= liteeth_stop,
+	.ndo_get_stats64	= liteeth_get_stats64,
 	.ndo_start_xmit         = liteeth_start_xmit,
 };
 
@@ -242,6 +248,11 @@ static int liteeth_probe(struct platform_device *pdev)
 	priv->netdev = netdev;
 	priv->dev = &pdev->dev;
 
+	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
+						      struct pcpu_sw_netstats);
+	if (!netdev->tstats)
+		return -ENOMEM;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ed911d994627..c236dba80ff1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1452,8 +1452,9 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	if (err)
 		goto err_free_npa_lf;
 
-	/* Enable backpressure */
-	otx2_nix_config_bp(pf, true);
+	/* Enable backpressure for CGX mapped PF/VFs */
+	if (!is_otx2_lbkvf(pf->pdev))
+		otx2_nix_config_bp(pf, true);
 
 	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
 	err = otx2_rq_aura_pool_init(pf);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 49975924e242..7e318133423a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3425,23 +3425,6 @@ static int mtk_hw_deinit(struct mtk_eth *eth)
 	return 0;
 }
 
-static int __init mtk_init(struct net_device *dev)
-{
-	struct mtk_mac *mac = netdev_priv(dev);
-	struct mtk_eth *eth = mac->hw;
-	int ret;
-
-	ret = of_get_ethdev_address(mac->of_node, dev);
-	if (ret) {
-		/* If the mac address is invalid, use random mac address */
-		eth_hw_addr_random(dev);
-		dev_err(eth->dev, "generated random MAC address %pM\n",
-			dev->dev_addr);
-	}
-
-	return 0;
-}
-
 static void mtk_uninit(struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
@@ -3789,7 +3772,6 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 };
 
 static const struct net_device_ops mtk_netdev_ops = {
-	.ndo_init		= mtk_init,
 	.ndo_uninit		= mtk_uninit,
 	.ndo_open		= mtk_open,
 	.ndo_stop		= mtk_stop,
@@ -3845,6 +3827,17 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	mac->hw = eth;
 	mac->of_node = np;
 
+	err = of_get_ethdev_address(mac->of_node, eth->netdev[id]);
+	if (err == -EPROBE_DEFER)
+		return err;
+
+	if (err) {
+		/* If the mac address is invalid, use random mac address */
+		eth_hw_addr_random(eth->netdev[id]);
+		dev_err(eth->dev, "generated random MAC address %pM\n",
+			eth->netdev[id]->dev_addr);
+	}
+
 	memset(mac->hwlro_ip, 0, sizeof(mac->hwlro_ip));
 	mac->hwlro_ip_cnt = 0;
 
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 231370e9a801..2647c18d40d9 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -106,23 +106,37 @@ struct cpsw_ale_dev_id {
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx;
+	int idx, idx2;
+	u32 hi_val = 0;
 
 	idx    = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be fetched exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
-	return (ale_entry[idx] >> start) & BITMASK(bits);
+	return (hi_val + (ale_entry[idx] >> start)) & BITMASK(bits);
 }
 
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx;
+	int idx, idx2;
 
 	value &= BITMASK(bits);
-	idx    = start / 32;
+	idx = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be set exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+	}
 	start -= idx * 32;
-	idx    = 2 - idx; /* flip */
+	idx = 2 - idx; /* flip */
 	ale_entry[idx] &= ~(BITMASK(bits) << start);
 	ale_entry[idx] |=  (value << start);
 }
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7fbb0904b3c0..82f74f96eba2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3252,23 +3252,30 @@ static int __init phy_init(void)
 {
 	int rc;
 
+	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
+
 	rc = mdio_bus_init();
 	if (rc)
-		return rc;
+		goto err_ethtool_phy_ops;
 
-	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
 	if (rc)
-		goto err_c45;
+		goto err_mdio_bus;
 
 	rc = phy_driver_register(&genphy_driver, THIS_MODULE);
-	if (rc) {
-		phy_driver_unregister(&genphy_c45_driver);
+	if (rc)
+		goto err_c45;
+
+	return 0;
+
 err_c45:
-		mdio_bus_exit();
-	}
+	phy_driver_unregister(&genphy_c45_driver);
+err_mdio_bus:
+	mdio_bus_exit();
+err_ethtool_phy_ops:
+	ethtool_set_ethtool_phy_ops(NULL);
 
 	return rc;
 }
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b99180bc8172..893fefadbba9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -870,7 +870,8 @@ int ath11k_core_check_dt(struct ath11k_base *ab)
 }
 
 static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
-					   size_t name_len, bool with_variant)
+					   size_t name_len, bool with_variant,
+					   bool bus_type_mode)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH11K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
@@ -881,15 +882,20 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 
 	switch (ab->id.bdf_search) {
 	case ATH11K_BDF_SEARCH_BUS_AND_BOARD:
-		scnprintf(name, name_len,
-			  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
-			  ath11k_bus_str(ab->hif.bus),
-			  ab->id.vendor, ab->id.device,
-			  ab->id.subsystem_vendor,
-			  ab->id.subsystem_device,
-			  ab->qmi.target.chip_id,
-			  ab->qmi.target.board_id,
-			  variant);
+		if (bus_type_mode)
+			scnprintf(name, name_len,
+				  "bus=%s",
+				  ath11k_bus_str(ab->hif.bus));
+		else
+			scnprintf(name, name_len,
+				  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
+				  ath11k_bus_str(ab->hif.bus),
+				  ab->id.vendor, ab->id.device,
+				  ab->id.subsystem_vendor,
+				  ab->id.subsystem_device,
+				  ab->qmi.target.chip_id,
+				  ab->qmi.target.board_id,
+				  variant);
 		break;
 	default:
 		scnprintf(name, name_len,
@@ -908,13 +914,19 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					 size_t name_len)
 {
-	return __ath11k_core_create_board_name(ab, name, name_len, true);
+	return __ath11k_core_create_board_name(ab, name, name_len, true, false);
 }
 
 static int ath11k_core_create_fallback_board_name(struct ath11k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath11k_core_create_board_name(ab, name, name_len, false);
+	return __ath11k_core_create_board_name(ab, name, name_len, false, false);
+}
+
+static int ath11k_core_create_bus_type_board_name(struct ath11k_base *ab, char *name,
+						  size_t name_len)
+{
+	return __ath11k_core_create_board_name(ab, name, name_len, false, true);
 }
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
@@ -1218,7 +1230,7 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 
 int ath11k_core_fetch_regdb(struct ath11k_base *ab, struct ath11k_board_data *bd)
 {
-	char boardname[BOARD_NAME_SIZE];
+	char boardname[BOARD_NAME_SIZE], default_boardname[BOARD_NAME_SIZE];
 	int ret;
 
 	ret = ath11k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
@@ -1235,6 +1247,21 @@ int ath11k_core_fetch_regdb(struct ath11k_base *ab, struct ath11k_board_data *bd
 	if (!ret)
 		goto exit;
 
+	ret = ath11k_core_create_bus_type_board_name(ab, default_boardname,
+						     BOARD_NAME_SIZE);
+	if (ret) {
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
+			   "failed to create default board name for regdb: %d", ret);
+		goto exit;
+	}
+
+	ret = ath11k_core_fetch_board_data_api_n(ab, bd, default_boardname,
+						 ATH11K_BD_IE_REGDB,
+						 ATH11K_BD_IE_REGDB_NAME,
+						 ATH11K_BD_IE_REGDB_DATA);
+	if (!ret)
+		goto exit;
+
 	ret = ath11k_core_fetch_board_data_api_1(ab, bd, ATH11K_REGDB_FILE_NAME);
 	if (ret)
 		ath11k_dbg(ab, ATH11K_DBG_BOOT, "failed to fetch %s from %s\n",
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ef7617802491..cb77dd6ce966 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8715,7 +8715,7 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
-		if (reg_cap->high_5ghz_chan >= ATH11K_MAX_6G_FREQ) {
+		if (reg_cap->high_5ghz_chan >= ATH11K_MIN_6G_FREQ) {
 			channels = kmemdup(ath11k_6ghz_channels,
 					   sizeof(ath11k_6ghz_channels), GFP_KERNEL);
 			if (!channels) {
@@ -9279,6 +9279,7 @@ void ath11k_mac_destroy(struct ath11k_base *ab)
 		if (!ar)
 			continue;
 
+		ath11k_fw_stats_free(&ar->fw_stats);
 		ieee80211_free_hw(ar->hw);
 		pdev->ar = NULL;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index fad9f8d308a2..3e0a47f4a3eb 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7590,6 +7590,11 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 	rcu_read_unlock();
 	spin_unlock_bh(&ar->data_lock);
 
+	/* Since the stats's pdev, vdev and beacon list are spliced and reinitialised
+	 * at this point, no need to free the individual list.
+	 */
+	return;
+
 free:
 	ath11k_fw_stats_free(&stats);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 013aca70c3d3..6b52afcf0272 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2738,7 +2738,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	if (iwl_mvm_has_new_rx_api(mvm) && start) {
-		u16 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
+		u32 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
 
 		/* sparse doesn't like the __align() so don't check */
 #ifndef __CHECKER__
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index f6872b2a0d9d..4d4db5f6836b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -495,6 +495,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x7AF0, PCI_ANY_ID, iwl_so_trans_cfg)},
 	{IWL_PCI_DEVICE(0x51F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0x51F1, PCI_ANY_ID, iwl_so_long_latency_imr_trans_cfg)},
+	{IWL_PCI_DEVICE(0x51F1, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0x54F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7F70, PCI_ANY_ID, iwl_so_trans_cfg)},
 
@@ -543,6 +544,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x51F0, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name),
 	IWL_DEV_INFO(0x51F0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x51F0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x51F1, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x54F0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x54F0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x7A70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
@@ -681,6 +683,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2726, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x51F0, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
 	IWL_DEV_INFO(0x51F0, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
+	IWL_DEV_INFO(0x51F1, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
+	IWL_DEV_INFO(0x51F1, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x54F0, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
 	IWL_DEV_INFO(0x54F0, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x7A70, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 0d81098c7b45..da5c355405f6 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  */
 
 /*
@@ -1753,7 +1753,7 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 
 	WARN_ON(is_multicast_ether_addr(hdr->addr1));
 
-	if (WARN_ON_ONCE(!sta->valid_links))
+	if (WARN_ON_ONCE(!sta || !sta->valid_links))
 		return &vif->bss_conf;
 
 	for (i = 0; i < ARRAY_SIZE(vif->link_conf); i++) {
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 6e93fd37ccd1..e181c3f50f1d 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -557,7 +557,7 @@ static int __init of_platform_default_populate_init(void)
 			if (!of_get_property(node, "linux,opened", NULL) ||
 			    !of_get_property(node, "linux,boot-display", NULL))
 				continue;
-			dev = of_platform_device_create(node, "of-display.0", NULL);
+			dev = of_platform_device_create(node, "of-display", NULL);
 			of_node_put(node);
 			if (WARN_ON(!dev))
 				return -ENOMEM;
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index ca6303fc41f9..fd11d28e5a1e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -246,6 +246,7 @@ static int rzg2l_map_add_config(struct pinctrl_map *map,
 
 static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 				   struct device_node *np,
+				   struct device_node *parent,
 				   struct pinctrl_map **map,
 				   unsigned int *num_maps,
 				   unsigned int *index)
@@ -263,6 +264,7 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	struct property *prop;
 	int ret, gsel, fsel;
 	const char **pin_fn;
+	const char *name;
 	const char *pin;
 
 	pinmux = of_find_property(np, "pinmux", NULL);
@@ -346,8 +348,19 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		psel_val[i] = MUX_FUNC(value);
 	}
 
+	if (parent) {
+		name = devm_kasprintf(pctrl->dev, GFP_KERNEL, "%pOFn.%pOFn",
+				      parent, np);
+		if (!name) {
+			ret = -ENOMEM;
+			goto done;
+		}
+	} else {
+		name = np->name;
+	}
+
 	/* Register a single pin group listing all the pins we read from DT */
-	gsel = pinctrl_generic_add_group(pctldev, np->name, pins, num_pinmux, NULL);
+	gsel = pinctrl_generic_add_group(pctldev, name, pins, num_pinmux, NULL);
 	if (gsel < 0) {
 		ret = gsel;
 		goto done;
@@ -357,17 +370,16 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	 * Register a single group function where the 'data' is an array PSEL
 	 * register values read from DT.
 	 */
-	pin_fn[0] = np->name;
-	fsel = pinmux_generic_add_function(pctldev, np->name, pin_fn, 1,
-					   psel_val);
+	pin_fn[0] = name;
+	fsel = pinmux_generic_add_function(pctldev, name, pin_fn, 1, psel_val);
 	if (fsel < 0) {
 		ret = fsel;
 		goto remove_group;
 	}
 
 	maps[idx].type = PIN_MAP_TYPE_MUX_GROUP;
-	maps[idx].data.mux.group = np->name;
-	maps[idx].data.mux.function = np->name;
+	maps[idx].data.mux.group = name;
+	maps[idx].data.mux.function = name;
 	idx++;
 
 	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np, num_pinmux);
@@ -414,7 +426,7 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	index = 0;
 
 	for_each_child_of_node(np, child) {
-		ret = rzg2l_dt_subnode_to_map(pctldev, child, map,
+		ret = rzg2l_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
 		if (ret < 0) {
 			of_node_put(child);
@@ -423,7 +435,7 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	}
 
 	if (*num_maps == 0) {
-		ret = rzg2l_dt_subnode_to_map(pctldev, np, map,
+		ret = rzg2l_dt_subnode_to_map(pctldev, np, NULL, map,
 					      num_maps, &index);
 		if (ret < 0)
 			goto done;
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index e8c18198bebd..35f382b055e8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -207,6 +207,7 @@ static int rzv2m_map_add_config(struct pinctrl_map *map,
 
 static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 				   struct device_node *np,
+				   struct device_node *parent,
 				   struct pinctrl_map **map,
 				   unsigned int *num_maps,
 				   unsigned int *index)
@@ -224,6 +225,7 @@ static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	struct property *prop;
 	int ret, gsel, fsel;
 	const char **pin_fn;
+	const char *name;
 	const char *pin;
 
 	pinmux = of_find_property(np, "pinmux", NULL);
@@ -307,8 +309,19 @@ static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		psel_val[i] = MUX_FUNC(value);
 	}
 
+	if (parent) {
+		name = devm_kasprintf(pctrl->dev, GFP_KERNEL, "%pOFn.%pOFn",
+				      parent, np);
+		if (!name) {
+			ret = -ENOMEM;
+			goto done;
+		}
+	} else {
+		name = np->name;
+	}
+
 	/* Register a single pin group listing all the pins we read from DT */
-	gsel = pinctrl_generic_add_group(pctldev, np->name, pins, num_pinmux, NULL);
+	gsel = pinctrl_generic_add_group(pctldev, name, pins, num_pinmux, NULL);
 	if (gsel < 0) {
 		ret = gsel;
 		goto done;
@@ -318,17 +331,16 @@ static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	 * Register a single group function where the 'data' is an array PSEL
 	 * register values read from DT.
 	 */
-	pin_fn[0] = np->name;
-	fsel = pinmux_generic_add_function(pctldev, np->name, pin_fn, 1,
-					   psel_val);
+	pin_fn[0] = name;
+	fsel = pinmux_generic_add_function(pctldev, name, pin_fn, 1, psel_val);
 	if (fsel < 0) {
 		ret = fsel;
 		goto remove_group;
 	}
 
 	maps[idx].type = PIN_MAP_TYPE_MUX_GROUP;
-	maps[idx].data.mux.group = np->name;
-	maps[idx].data.mux.function = np->name;
+	maps[idx].data.mux.group = name;
+	maps[idx].data.mux.function = name;
 	idx++;
 
 	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np, num_pinmux);
@@ -375,7 +387,7 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev *pctldev,
 	index = 0;
 
 	for_each_child_of_node(np, child) {
-		ret = rzv2m_dt_subnode_to_map(pctldev, child, map,
+		ret = rzv2m_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
 		if (ret < 0) {
 			of_node_put(child);
@@ -384,7 +396,7 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev *pctldev,
 	}
 
 	if (*num_maps == 0) {
-		ret = rzv2m_dt_subnode_to_map(pctldev, np, map,
+		ret = rzv2m_dt_subnode_to_map(pctldev, np, NULL, map,
 					      num_maps, &index);
 		if (ret < 0)
 			goto done;
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 80fa0ef8909c..147199002df1 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -126,7 +126,7 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_DATA_SIZE,
 };
 
-#define BCM63XX_SPI_MAX_PREPEND		15
+#define BCM63XX_SPI_MAX_PREPEND		7
 
 #define BCM63XX_SPI_MAX_CS		8
 #define BCM63XX_SPI_BUS_NUM		0
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 26c40ea6dd12..8046e9138881 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -222,6 +222,24 @@ static int dw_spi_intel_init(struct platform_device *pdev,
 	return 0;
 }
 
+/*
+ * DMA-based mem ops are not configured for this device and are not tested.
+ */
+static int dw_spi_mountevans_imc_init(struct platform_device *pdev,
+				      struct dw_spi_mmio *dwsmmio)
+{
+	/*
+	 * The Intel Mount Evans SoC's Integrated Management Complex DW
+	 * apb_ssi_v4.02a controller has an errata where a full TX FIFO can
+	 * result in data corruption. The suggested workaround is to never
+	 * completely fill the FIFO. The TX FIFO has a size of 32 so the
+	 * fifo_len is set to 31.
+	 */
+	dwsmmio->dws.fifo_len = 31;
+
+	return 0;
+}
+
 static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 				   struct dw_spi_mmio *dwsmmio)
 {
@@ -350,6 +368,10 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_hssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
+	{
+		.compatible = "intel,mountevans-imc-ssi",
+		.data = dw_spi_mountevans_imc_init,
+	},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ /* end of table */}
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 71d324ec9a70..1480df7b43b3 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -668,6 +668,8 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	if ((sdd->cur_mode & SPI_LOOP) && sdd->port_conf->has_loopback)
 		val |= S3C64XX_SPI_MODE_SELF_LOOPBACK;
+	else
+		val &= ~S3C64XX_SPI_MODE_SELF_LOOPBACK;
 
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index b6b22fa4a8a0..fd3ff398d234 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1732,6 +1732,9 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 	/* Now hook interrupt too */
 	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = request_irq(irq, au1200fb_handle_irq,
 			  IRQF_SHARED, "lcd", (void *)dev);
 	if (ret) {
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 51fde1b2a793..36ada87b49a4 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -613,10 +613,10 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
-	if (var->left_margin > 255)
+	if (var->left_margin < 3  || var->left_margin > 255)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
-	if (var->right_margin > 255)
+	if (var->right_margin < 1 || var->right_margin > 255)
 		printk(KERN_ERR "%s: invalid right_margin %d\n",
 			info->fix.id, var->right_margin);
 	if (var->yres < 1 || var->yres > ymax_mask)
@@ -1043,7 +1043,6 @@ static int imxfb_probe(struct platform_device *pdev)
 failed_map:
 failed_ioremap:
 failed_getclock:
-	release_mem_region(res->start, resource_size(res));
 failed_of_parse:
 	kfree(info->pseudo_palette);
 failed_init:
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 30b264eb9d20..d93e8735ab1f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1894,6 +1894,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
 		/* Shouldn't have super stripes in sequential zones */
 		if (zoned && nr) {
+			kfree(logical);
 			btrfs_err(fs_info,
 			"zoned: block group %llu must not contain super block",
 				  cache->start);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c5583fc2a585..3c48273cd7a5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4913,9 +4913,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = set_page_extent_mapped(page);
-	if (ret < 0)
-		goto out_unlock;
 
 	if (!PageUptodate(page)) {
 		ret = btrfs_read_folio(NULL, page_folio(page));
@@ -4930,6 +4927,17 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out_unlock;
 		}
 	}
+
+	/*
+	 * We unlock the page after the io is completed and then re-lock it
+	 * above.  release_folio() could have come in between that and cleared
+	 * PagePrivate(), but left the page in the mapping.  Set the page mapped
+	 * here to make sure it's properly set for the subpage stuff.
+	 */
+	ret = set_page_extent_mapped(page);
+	if (ret < 0)
+		goto out_unlock;
+
 	wait_on_page_writeback(page);
 
 	lock_extent(io_tree, block_start, block_end, &cached_state);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 04ca0a4075b6..cacdb2c5d152 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4410,4 +4410,5 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 		ulist_free(entry->old_roots);
 		kfree(entry);
 	}
+	*root = RB_ROOT;
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 099af8ba6fe5..2e0832d70406 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4092,14 +4092,6 @@ static int alloc_profile_is_valid(u64 flags, int extended)
 	return has_single_bit_set(flags);
 }
 
-static inline int balance_need_close(struct btrfs_fs_info *fs_info)
-{
-	/* cancel requested || normal exit path */
-	return atomic_read(&fs_info->balance_cancel_req) ||
-		(atomic_read(&fs_info->balance_pause_req) == 0 &&
-		 atomic_read(&fs_info->balance_cancel_req) == 0);
-}
-
 /*
  * Validate target profile against allowed profiles and return true if it's OK.
  * Otherwise print the error message and return false.
@@ -4289,6 +4281,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	u64 num_devices;
 	unsigned seq;
 	bool reducing_redundancy;
+	bool paused = false;
 	int i;
 
 	if (btrfs_fs_closing(fs_info) ||
@@ -4419,6 +4412,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
 		btrfs_info(fs_info, "balance: paused");
 		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
+		paused = true;
 	}
 	/*
 	 * Balance can be canceled by:
@@ -4447,8 +4441,8 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		btrfs_update_ioctl_balance_args(fs_info, bargs);
 	}
 
-	if ((ret && ret != -ECANCELED && ret != -ENOSPC) ||
-	    balance_need_close(fs_info)) {
+	/* We didn't pause, we can clean everything up. */
+	if (!paused) {
 		reset_balance_state(fs_info);
 		btrfs_exclop_finish(fs_info);
 	}
@@ -6601,11 +6595,13 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		if (patch_the_first_stripe_for_dev_replace) {
 			smap->dev = dev_replace->tgtdev;
 			smap->physical = physical_to_patch_in_first_stripe;
-			*mirror_num_ret = map->num_stripes + 1;
+			if (mirror_num_ret)
+				*mirror_num_ret = map->num_stripes + 1;
 		} else {
 			set_io_stripe(smap, map, stripe_index, stripe_offset,
 				      stripe_nr);
-			*mirror_num_ret = mirror_num;
+			if (mirror_num_ret)
+				*mirror_num_ret = mirror_num;
 		}
 		*bioc_ret = NULL;
 		ret = 0;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 51d642a95bd2..eaed9fd2f890 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1732,6 +1732,20 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		memmove(here, (void *)here + size,
 			(void *)last - (void *)here + sizeof(__u32));
 		memset(last, 0, size);
+
+		/*
+		 * Update i_inline_off - moved ibody region might contain
+		 * system.data attribute.  Handling a failure here won't
+		 * cause other complications for setting an xattr.
+		 */
+		if (!is_block && ext4_has_inline_data(inode)) {
+			ret = ext4_find_inline_data_nolock(inode);
+			if (ret) {
+				ext4_warning_inode(inode,
+					"unable to update i_inline_off");
+				goto out;
+			}
+		}
 	} else if (s->not_found) {
 		/* Insert new name. */
 		size_t size = EXT4_XATTR_LEN(name_len);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 904673a4f690..5e408e7ec4c6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -258,7 +258,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			spin_unlock(&fi->lock);
 		}
 		kfree(forget);
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
 		if (ret || fuse_invalid_attr(&outarg.attr) ||
 		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6b3beda16c1b..bc3c3e76c646 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1127,7 +1127,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		process_init_limits(fc, arg);
 
 		if (arg->minor >= 6) {
-			u64 flags = arg->flags | (u64) arg->flags2 << 32;
+			u64 flags = arg->flags;
+
+			if (flags & FUSE_INIT_EXT)
+				flags |= (u64) arg->flags2 << 32;
 
 			ra_pages = arg->max_readahead / PAGE_SIZE;
 			if (flags & FUSE_ASYNC_READ)
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 8ba1545e01f9..5a6c715b9a70 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -9,14 +9,23 @@
 #include <linux/compat.h>
 #include <linux/fileattr.h>
 
-static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args)
+static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args,
+			       struct fuse_ioctl_out *outarg)
 {
-	ssize_t ret = fuse_simple_request(fm, args);
+	ssize_t ret;
+
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+
+	ret = fuse_simple_request(fm, args);
 
 	/* Translate ENOSYS, which shouldn't be returned from fs */
 	if (ret == -ENOSYS)
 		ret = -ENOTTY;
 
+	if (ret >= 0 && outarg->result == -ENOSYS)
+		outarg->result = -ENOTTY;
+
 	return ret;
 }
 
@@ -264,13 +273,11 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 	}
 
 	ap.args.out_numargs = 2;
-	ap.args.out_args[0].size = sizeof(outarg);
-	ap.args.out_args[0].value = &outarg;
 	ap.args.out_args[1].size = out_size;
 	ap.args.out_pages = true;
 	ap.args.out_argvar = true;
 
-	transferred = fuse_send_ioctl(fm, &ap.args);
+	transferred = fuse_send_ioctl(fm, &ap.args, &outarg);
 	err = transferred;
 	if (transferred < 0)
 		goto out;
@@ -399,12 +406,10 @@ static int fuse_priv_ioctl(struct inode *inode, struct fuse_file *ff,
 	args.in_args[1].size = inarg.in_size;
 	args.in_args[1].value = ptr;
 	args.out_numargs = 2;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
 	args.out_args[1].size = inarg.out_size;
 	args.out_args[1].value = ptr;
 
-	err = fuse_send_ioctl(fm, &args);
+	err = fuse_send_ioctl(fm, &args, &outarg);
 	if (!err) {
 		if (outarg.result < 0)
 			err = outarg.result;
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 51bd38da21cd..25e3c20eb19f 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -57,28 +57,6 @@ static inline void __buffer_unlink(struct journal_head *jh)
 	}
 }
 
-/*
- * Move a buffer from the checkpoint list to the checkpoint io list
- *
- * Called with j_list_lock held
- */
-static inline void __buffer_relink_io(struct journal_head *jh)
-{
-	transaction_t *transaction = jh->b_cp_transaction;
-
-	__buffer_unlink_first(jh);
-
-	if (!transaction->t_checkpoint_io_list) {
-		jh->b_cpnext = jh->b_cpprev = jh;
-	} else {
-		jh->b_cpnext = transaction->t_checkpoint_io_list;
-		jh->b_cpprev = transaction->t_checkpoint_io_list->b_cpprev;
-		jh->b_cpprev->b_cpnext = jh;
-		jh->b_cpnext->b_cpprev = jh;
-	}
-	transaction->t_checkpoint_io_list = jh;
-}
-
 /*
  * Check a checkpoint buffer could be release or not.
  *
@@ -183,6 +161,7 @@ __flush_batch(journal_t *journal, int *batch_count)
 		struct buffer_head *bh = journal->j_chkpt_bhs[i];
 		BUFFER_TRACE(bh, "brelse");
 		__brelse(bh);
+		journal->j_chkpt_bhs[i] = NULL;
 	}
 	*batch_count = 0;
 }
@@ -242,6 +221,11 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		jh = transaction->t_checkpoint_list;
 		bh = jh2bh(jh);
 
+		/*
+		 * The buffer may be writing back, or flushing out in the
+		 * last couple of cycles, or re-adding into a new transaction,
+		 * need to check it again until it's unlocked.
+		 */
 		if (buffer_locked(bh)) {
 			get_bh(bh);
 			spin_unlock(&journal->j_list_lock);
@@ -287,28 +271,32 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		}
 		if (!buffer_dirty(bh)) {
 			BUFFER_TRACE(bh, "remove from checkpoint");
-			if (__jbd2_journal_remove_checkpoint(jh))
-				/* The transaction was released; we're done */
+			/*
+			 * If the transaction was released or the checkpoint
+			 * list was empty, we're done.
+			 */
+			if (__jbd2_journal_remove_checkpoint(jh) ||
+			    !transaction->t_checkpoint_list)
 				goto out;
-			continue;
+		} else {
+			/*
+			 * We are about to write the buffer, it could be
+			 * raced by some other transaction shrink or buffer
+			 * re-log logic once we release the j_list_lock,
+			 * leave it on the checkpoint list and check status
+			 * again to make sure it's clean.
+			 */
+			BUFFER_TRACE(bh, "queue");
+			get_bh(bh);
+			J_ASSERT_BH(bh, !buffer_jwrite(bh));
+			journal->j_chkpt_bhs[batch_count++] = bh;
+			transaction->t_chp_stats.cs_written++;
+			transaction->t_checkpoint_list = jh->b_cpnext;
 		}
-		/*
-		 * Important: we are about to write the buffer, and
-		 * possibly block, while still holding the journal
-		 * lock.  We cannot afford to let the transaction
-		 * logic start messing around with this buffer before
-		 * we write it to disk, as that would break
-		 * recoverability.
-		 */
-		BUFFER_TRACE(bh, "queue");
-		get_bh(bh);
-		J_ASSERT_BH(bh, !buffer_jwrite(bh));
-		journal->j_chkpt_bhs[batch_count++] = bh;
-		__buffer_relink_io(jh);
-		transaction->t_chp_stats.cs_written++;
+
 		if ((batch_count == JBD2_NR_BATCH) ||
-		    need_resched() ||
-		    spin_needbreak(&journal->j_list_lock))
+		    need_resched() || spin_needbreak(&journal->j_list_lock) ||
+		    jh2bh(transaction->t_checkpoint_list) == journal->j_chkpt_bhs[0])
 			goto unlock_and_flush;
 	}
 
@@ -322,38 +310,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			goto restart;
 	}
 
-	/*
-	 * Now we issued all of the transaction's buffers, let's deal
-	 * with the buffers that are out for I/O.
-	 */
-restart2:
-	/* Did somebody clean up the transaction in the meanwhile? */
-	if (journal->j_checkpoint_transactions != transaction ||
-	    transaction->t_tid != this_tid)
-		goto out;
-
-	while (transaction->t_checkpoint_io_list) {
-		jh = transaction->t_checkpoint_io_list;
-		bh = jh2bh(jh);
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			/* the journal_head may have gone by now */
-			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
-			spin_lock(&journal->j_list_lock);
-			goto restart2;
-		}
-
-		/*
-		 * Now in whatever state the buffer currently is, we
-		 * know that it has been written out and so we can
-		 * drop it from the list
-		 */
-		if (__jbd2_journal_remove_checkpoint(jh))
-			break;
-	}
 out:
 	spin_unlock(&journal->j_list_lock);
 	result = jbd2_cleanup_journal_tail(journal);
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index da6a2bc6bf02..bd4ef43b0203 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1959,6 +1959,9 @@ dbAllocDmapLev(struct bmap * bmp,
 	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
 		return -ENOSPC;
 
+	if (leafidx < 0)
+		return -EIO;
+
 	/* determine the block number within the file system corresponding
 	 * to the leaf at which free space was found.
 	 */
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index ffd4feece078..ce4b4760fcb1 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -354,6 +354,11 @@ tid_t txBegin(struct super_block *sb, int flag)
 	jfs_info("txBegin: flag = 0x%x", flag);
 	log = JFS_SBI(sb)->log;
 
+	if (!log) {
+		jfs_error(sb, "read-only filesystem\n");
+		return 0;
+	}
+
 	TXN_LOCK();
 
 	INCREMENT(TxStat.txBegin);
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 4fbbf88435e6..b3a0fe0649c4 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -799,6 +799,11 @@ static int jfs_link(struct dentry *old_dentry,
 	if (rc)
 		goto out;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EROFS;
+	}
+
 	tid = txBegin(ip->i_sb, 0);
 
 	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index e1af8f660698..a479680a5ccd 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -32,6 +32,7 @@ struct ovl_sb {
 };
 
 struct ovl_layer {
+	/* ovl_free_fs() relies on @mnt being the first member! */
 	struct vfsmount *mnt;
 	/* Trap in ovl inode cache */
 	struct inode *trap;
@@ -42,6 +43,14 @@ struct ovl_layer {
 	int fsid;
 };
 
+/*
+ * ovl_free_fs() relies on @mnt being the first member when unmounting
+ * the private mounts created for each layer. Let's check both the
+ * offset and type.
+ */
+static_assert(offsetof(struct ovl_layer, mnt) == 0);
+static_assert(__same_type(typeof_member(struct ovl_layer, mnt), struct vfsmount *));
+
 struct ovl_path {
 	const struct ovl_layer *layer;
 	struct dentry *dentry;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index f27faf5db554..46dca88d89c3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -555,7 +555,7 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			dqgrab(dquot);
+			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
 			 * Once dqput() wakes us up, we know it's time to free
@@ -2420,7 +2420,8 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	error = add_dquot_ref(sb, type);
 	if (error)
-		dquot_disable(sb, type, flags);
+		dquot_disable(sb, type,
+			      DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
 	return error;
 out_fmt:
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 935fe198a4ba..cbe08948baf4 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -59,7 +59,7 @@ extern bool disable_legacy_dialects;
 #define TLINK_IDLE_EXPIRE	(600 * HZ)
 
 /* Drop the connection to not overload the server */
-#define NUM_STATUS_IO_TIMEOUT   5
+#define MAX_STATUS_IO_TIMEOUT   5
 
 struct mount_ctx {
 	struct cifs_sb_info *cifs_sb;
@@ -1162,6 +1162,7 @@ cifs_demultiplex_thread(void *p)
 	struct mid_q_entry *mids[MAX_COMPOUND];
 	char *bufs[MAX_COMPOUND];
 	unsigned int noreclaim_flag, num_io_timeout = 0;
+	bool pending_reconnect = false;
 
 	noreclaim_flag = memalloc_noreclaim_save();
 	cifs_dbg(FYI, "Demultiplex PID: %d\n", task_pid_nr(current));
@@ -1201,6 +1202,8 @@ cifs_demultiplex_thread(void *p)
 		cifs_dbg(FYI, "RFC1002 header 0x%x\n", pdu_length);
 		if (!is_smb_response(server, buf[0]))
 			continue;
+
+		pending_reconnect = false;
 next_pdu:
 		server->pdu_size = pdu_length;
 
@@ -1258,10 +1261,13 @@ cifs_demultiplex_thread(void *p)
 		if (server->ops->is_status_io_timeout &&
 		    server->ops->is_status_io_timeout(buf)) {
 			num_io_timeout++;
-			if (num_io_timeout > NUM_STATUS_IO_TIMEOUT) {
-				cifs_reconnect(server, false);
+			if (num_io_timeout > MAX_STATUS_IO_TIMEOUT) {
+				cifs_server_dbg(VFS,
+						"Number of request timeouts exceeded %d. Reconnecting",
+						MAX_STATUS_IO_TIMEOUT);
+
+				pending_reconnect = true;
 				num_io_timeout = 0;
-				continue;
 			}
 		}
 
@@ -1308,6 +1314,11 @@ cifs_demultiplex_thread(void *p)
 			buf = server->smallbuf;
 			goto next_pdu;
 		}
+
+		/* do this reconnect at the very end after processing all MIDs */
+		if (pending_reconnect)
+			cifs_reconnect(server, true);
+
 	} /* end while !EXITING */
 
 	/* buffer usually freed in free_mid - need to free it here on exit */
diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 622569007b53..2142cbd1dde2 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -247,7 +247,7 @@ static int udf_name_from_CS0(struct super_block *sb,
 	}
 
 	if (translate) {
-		if (str_o_len <= 2 && str_o[0] == '.' &&
+		if (str_o_len > 0 && str_o_len <= 2 && str_o[0] == '.' &&
 		    (str_o_len == 1 || str_o[1] == '.'))
 			needsCRC = 1;
 		if (needsCRC) {
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 32c764fb9cb5..40e855c8407c 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -815,8 +815,11 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr);
 bool drm_dp_read_mst_cap(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool mst_state);
 
-int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled);
-
+int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr,
+				    const u8 *esi,
+				    u8 *ack,
+				    bool *handled);
+void drm_dp_mst_hpd_irq_send_new_request(struct drm_dp_mst_topology_mgr *mgr);
 
 int
 drm_dp_mst_detect_port(struct drm_connector *connector,
diff --git a/include/linux/psi.h b/include/linux/psi.h
index b029a847def1..e0745873e3f2 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -23,8 +23,9 @@ void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
-struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res);
+struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
+				       enum psi_res res, struct file *file,
+				       struct kernfs_open_file *of);
 void psi_trigger_destroy(struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 14a1ebb74e11..f1fd3a8044e0 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -72,6 +72,9 @@ enum psi_states {
 /* Use one bit in the state mask to track TSK_ONCPU */
 #define PSI_ONCPU	(1 << NR_PSI_STATES)
 
+/* Flag whether to re-arm avgs_work, see details in get_recent_times() */
+#define PSI_STATE_RESCHEDULE	(1 << (NR_PSI_STATES + 1))
+
 enum psi_aggregators {
 	PSI_AVGS = 0,
 	PSI_POLL,
@@ -134,6 +137,9 @@ struct psi_trigger {
 	/* Wait queue for polling */
 	wait_queue_head_t event_wait;
 
+	/* Kernfs file for cgroup triggers */
+	struct kernfs_open_file *of;
+
 	/* Pending event flag */
 	int event;
 
@@ -148,6 +154,9 @@ struct psi_trigger {
 
 	/* Deferred event(s) from previous ratelimit window */
 	bool pending_event;
+
+	/* Trigger type - PSI_AVGS for unprivileged, PSI_POLL for RT */
+	enum psi_aggregators aggregator;
 };
 
 struct psi_group {
@@ -168,30 +177,34 @@ struct psi_group {
 	/* Aggregator work control */
 	struct delayed_work avgs_work;
 
+	/* Unprivileged triggers against N*PSI_FREQ windows */
+	struct list_head avg_triggers;
+	u32 avg_nr_triggers[NR_PSI_STATES - 1];
+
 	/* Total stall times and sampled pressure averages */
 	u64 total[NR_PSI_AGGREGATORS][NR_PSI_STATES - 1];
 	unsigned long avg[NR_PSI_STATES - 1][3];
 
-	/* Monitor work control */
-	struct task_struct __rcu *poll_task;
-	struct timer_list poll_timer;
-	wait_queue_head_t poll_wait;
-	atomic_t poll_wakeup;
-	atomic_t poll_scheduled;
+	/* Monitor RT polling work control */
+	struct task_struct __rcu *rtpoll_task;
+	struct timer_list rtpoll_timer;
+	wait_queue_head_t rtpoll_wait;
+	atomic_t rtpoll_wakeup;
+	atomic_t rtpoll_scheduled;
 
 	/* Protects data used by the monitor */
-	struct mutex trigger_lock;
-
-	/* Configured polling triggers */
-	struct list_head triggers;
-	u32 nr_triggers[NR_PSI_STATES - 1];
-	u32 poll_states;
-	u64 poll_min_period;
-
-	/* Total stall times at the start of monitor activation */
-	u64 polling_total[NR_PSI_STATES - 1];
-	u64 polling_next_update;
-	u64 polling_until;
+	struct mutex rtpoll_trigger_lock;
+
+	/* Configured RT polling triggers */
+	struct list_head rtpoll_triggers;
+	u32 rtpoll_nr_triggers[NR_PSI_STATES - 1];
+	u32 rtpoll_states;
+	u64 rtpoll_min_period;
+
+	/* Total stall times at the start of RT polling monitor activation */
+	u64 rtpoll_total[NR_PSI_STATES - 1];
+	u64 rtpoll_next_update;
+	u64 rtpoll_until;
 };
 
 #else /* CONFIG_PSI */
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 41b1da621a45..9cd289ad3f5b 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -510,7 +510,7 @@ static inline void fastopen_queue_tune(struct sock *sk, int backlog)
 	struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
 	int somaxconn = READ_ONCE(sock_net(sk)->core.sysctl_somaxconn);
 
-	queue->fastopenq.max_qlen = min_t(unsigned int, backlog, somaxconn);
+	WRITE_ONCE(queue->fastopenq.max_qlen, min_t(unsigned int, backlog, somaxconn));
 }
 
 static inline void tcp_move_syn(struct tcp_sock *tp,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 84c5ce57eab6..ddbcbf9ccb2c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -807,6 +807,7 @@ struct hci_conn_params {
 
 	struct hci_conn *conn;
 	bool explicit_connect;
+	/* Accessed without hdev->lock: */
 	hci_conn_flags_t flags;
 	u8  privacy_mode;
 };
@@ -1536,7 +1537,11 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear_disabled(struct hci_dev *hdev);
+void hci_conn_params_free(struct hci_conn_params *param);
 
+void hci_pend_le_list_del_init(struct hci_conn_params *param);
+void hci_pend_le_list_add(struct hci_conn_params *param,
+			  struct list_head *list);
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr,
 						  u8 addr_type);
diff --git a/include/net/ip.h b/include/net/ip.h
index acec504c469a..83a1a9bc3ceb 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -282,7 +282,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			   const struct ip_options *sopt,
 			   __be32 daddr, __be32 saddr,
 			   const struct ip_reply_arg *arg,
-			   unsigned int len, u64 transmit_time);
+			   unsigned int len, u64 transmit_time, u32 txhash);
 
 #define IP_INC_STATS(net, field)	SNMP_INC_STATS64((net)->mib.ip_statistics, field)
 #define __IP_INC_STATS(net, field)	__SNMP_INC_STATS64((net)->mib.ip_statistics, field)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5eedd476a38d..e9c8f88f4769 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1511,25 +1511,38 @@ void tcp_leave_memory_pressure(struct sock *sk);
 static inline int keepalive_intvl_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_intvl ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepintvl()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_intvl);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
 }
 
 static inline int keepalive_time_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_time ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepidle_locked() */
+	val = READ_ONCE(tp->keepalive_time);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
 }
 
 static inline int keepalive_probes(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_probes ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepcnt()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_probes);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
 }
 
 static inline u32 keepalive_time_elapsed(const struct tcp_sock *tp)
@@ -2046,7 +2059,11 @@ void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
 static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
-	return tp->notsent_lowat ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+	u32 val;
+
+	val = READ_ONCE(tp->notsent_lowat);
+
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
 }
 
 bool tcp_stream_memory_free(const struct sock *sk, int wake);
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 38bc0073a7d4..bd7b8cf8bc67 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1803,6 +1803,14 @@ void io_wq_submit_work(struct io_wq_work *work)
 		ret = io_issue_sqe(req, issue_flags);
 		if (ret != -EAGAIN)
 			break;
+
+		/*
+		 * If REQ_F_NOWAIT is set, then don't wait or retry with
+		 * poll. -EAGAIN is final for that case.
+		 */
+		if (req->flags & REQ_F_NOWAIT)
+			break;
+
 		/*
 		 * We can get EAGAIN for iopolled IO even though we're
 		 * forcing a sync submission from here, since we can't
diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index d99e89f113c4..3dabdd137d10 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -41,7 +41,12 @@ static struct list_head *local_pending_list(struct bpf_lru_locallist *loc_l)
 /* bpf_lru_node helpers */
 static bool bpf_lru_node_is_ref(const struct bpf_lru_node *node)
 {
-	return node->ref;
+	return READ_ONCE(node->ref);
+}
+
+static void bpf_lru_node_clear_ref(struct bpf_lru_node *node)
+{
+	WRITE_ONCE(node->ref, 0);
 }
 
 static void bpf_lru_list_count_inc(struct bpf_lru_list *l,
@@ -89,7 +94,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 
 	bpf_lru_list_count_inc(l, tgt_type);
 	node->type = tgt_type;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -110,7 +115,7 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 		bpf_lru_list_count_inc(l, tgt_type);
 		node->type = tgt_type;
 	}
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 
 	/* If the moving node is the next_inactive_rotation candidate,
 	 * move the next_inactive_rotation pointer also.
@@ -353,7 +358,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_add(&node->list, local_pending_list(loc_l));
 }
 
@@ -419,7 +424,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 	if (!list_empty(free_list)) {
 		node = list_first_entry(free_list, struct bpf_lru_node, list);
 		*(u32 *)((void *)node + lru->hash_offset) = hash;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
@@ -522,7 +527,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		}
 
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_move(&node->list, local_free_list(loc_l));
 
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
@@ -568,7 +573,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
@@ -594,7 +599,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
 		buf += elem_size;
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 4ea227c9c1ad..8f3c8b2b4490 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -64,11 +64,8 @@ struct bpf_lru {
 
 static inline void bpf_lru_node_set_ref(struct bpf_lru_node *node)
 {
-	/* ref is an approximation on access frequency.  It does not
-	 * have to be very accurate.  Hence, no protection is used.
-	 */
-	if (!node->ref)
-		node->ref = 1;
+	if (!READ_ONCE(node->ref))
+		WRITE_ONCE(node->ref, 1);
 }
 
 int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8633ec4f92df..0c44a716f0a2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5289,7 +5289,8 @@ static int bpf_unpriv_handler(struct ctl_table *table, int write,
 		*(int *)table->data = unpriv_enable;
 	}
 
-	unpriv_ebpf_notify(unpriv_enable);
+	if (write)
+		unpriv_ebpf_notify(unpriv_enable);
 
 	return ret;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c3ededef317..3c414e0ac819 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -511,6 +511,15 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 	return func_id == BPF_FUNC_dynptr_data;
 }
 
+static bool is_callback_calling_function(enum bpf_func_id func_id)
+{
+	return func_id == BPF_FUNC_for_each_map_elem ||
+	       func_id == BPF_FUNC_timer_set_callback ||
+	       func_id == BPF_FUNC_find_vma ||
+	       func_id == BPF_FUNC_loop ||
+	       func_id == BPF_FUNC_user_ringbuf_drain;
+}
+
 static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 					const struct bpf_map *map)
 {
@@ -1693,7 +1702,7 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
-	reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;
+	reg->precise = !env->bpf_capable;
 	__mark_reg_unbounded(reg);
 }
 
@@ -2670,6 +2679,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 			 */
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
 				return -ENOTSUPP;
+			/* BPF helpers that invoke callback subprogs are
+			 * equivalent to BPF_PSEUDO_CALL above
+			 */
+			if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
+				return -ENOTSUPP;
 			/* regular helper call sets R0 */
 			*reg_mask &= ~1;
 			if (*reg_mask & 0x3f) {
@@ -2774,8 +2788,11 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 
 	/* big hammer: mark all scalars precise in this path.
 	 * pop_stack may still get !precise scalars.
+	 * We also skip current state and go straight to first parent state,
+	 * because precision markings in current non-checkpointed state are
+	 * not needed. See why in the comment in __mark_chain_precision below.
 	 */
-	for (; st; st = st->parent)
+	for (st = st->parent; st; st = st->parent) {
 		for (i = 0; i <= st->curframe; i++) {
 			func = st->frame[i];
 			for (j = 0; j < BPF_REG_FP; j++) {
@@ -2793,8 +2810,121 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				reg->precise = true;
 			}
 		}
+	}
+}
+
+static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+	int i, j;
+
+	for (i = 0; i <= st->curframe; i++) {
+		func = st->frame[i];
+		for (j = 0; j < BPF_REG_FP; j++) {
+			reg = &func->regs[j];
+			if (reg->type != SCALAR_VALUE)
+				continue;
+			reg->precise = false;
+		}
+		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
+			if (!is_spilled_reg(&func->stack[j]))
+				continue;
+			reg = &func->stack[j].spilled_ptr;
+			if (reg->type != SCALAR_VALUE)
+				continue;
+			reg->precise = false;
+		}
+	}
 }
 
+/*
+ * __mark_chain_precision() backtracks BPF program instruction sequence and
+ * chain of verifier states making sure that register *regno* (if regno >= 0)
+ * and/or stack slot *spi* (if spi >= 0) are marked as precisely tracked
+ * SCALARS, as well as any other registers and slots that contribute to
+ * a tracked state of given registers/stack slots, depending on specific BPF
+ * assembly instructions (see backtrack_insns() for exact instruction handling
+ * logic). This backtracking relies on recorded jmp_history and is able to
+ * traverse entire chain of parent states. This process ends only when all the
+ * necessary registers/slots and their transitive dependencies are marked as
+ * precise.
+ *
+ * One important and subtle aspect is that precise marks *do not matter* in
+ * the currently verified state (current state). It is important to understand
+ * why this is the case.
+ *
+ * First, note that current state is the state that is not yet "checkpointed",
+ * i.e., it is not yet put into env->explored_states, and it has no children
+ * states as well. It's ephemeral, and can end up either a) being discarded if
+ * compatible explored state is found at some point or BPF_EXIT instruction is
+ * reached or b) checkpointed and put into env->explored_states, branching out
+ * into one or more children states.
+ *
+ * In the former case, precise markings in current state are completely
+ * ignored by state comparison code (see regsafe() for details). Only
+ * checkpointed ("old") state precise markings are important, and if old
+ * state's register/slot is precise, regsafe() assumes current state's
+ * register/slot as precise and checks value ranges exactly and precisely. If
+ * states turn out to be compatible, current state's necessary precise
+ * markings and any required parent states' precise markings are enforced
+ * after the fact with propagate_precision() logic, after the fact. But it's
+ * important to realize that in this case, even after marking current state
+ * registers/slots as precise, we immediately discard current state. So what
+ * actually matters is any of the precise markings propagated into current
+ * state's parent states, which are always checkpointed (due to b) case above).
+ * As such, for scenario a) it doesn't matter if current state has precise
+ * markings set or not.
+ *
+ * Now, for the scenario b), checkpointing and forking into child(ren)
+ * state(s). Note that before current state gets to checkpointing step, any
+ * processed instruction always assumes precise SCALAR register/slot
+ * knowledge: if precise value or range is useful to prune jump branch, BPF
+ * verifier takes this opportunity enthusiastically. Similarly, when
+ * register's value is used to calculate offset or memory address, exact
+ * knowledge of SCALAR range is assumed, checked, and enforced. So, similar to
+ * what we mentioned above about state comparison ignoring precise markings
+ * during state comparison, BPF verifier ignores and also assumes precise
+ * markings *at will* during instruction verification process. But as verifier
+ * assumes precision, it also propagates any precision dependencies across
+ * parent states, which are not yet finalized, so can be further restricted
+ * based on new knowledge gained from restrictions enforced by their children
+ * states. This is so that once those parent states are finalized, i.e., when
+ * they have no more active children state, state comparison logic in
+ * is_state_visited() would enforce strict and precise SCALAR ranges, if
+ * required for correctness.
+ *
+ * To build a bit more intuition, note also that once a state is checkpointed,
+ * the path we took to get to that state is not important. This is crucial
+ * property for state pruning. When state is checkpointed and finalized at
+ * some instruction index, it can be correctly and safely used to "short
+ * circuit" any *compatible* state that reaches exactly the same instruction
+ * index. I.e., if we jumped to that instruction from a completely different
+ * code path than original finalized state was derived from, it doesn't
+ * matter, current state can be discarded because from that instruction
+ * forward having a compatible state will ensure we will safely reach the
+ * exit. States describe preconditions for further exploration, but completely
+ * forget the history of how we got here.
+ *
+ * This also means that even if we needed precise SCALAR range to get to
+ * finalized state, but from that point forward *that same* SCALAR register is
+ * never used in a precise context (i.e., it's precise value is not needed for
+ * correctness), it's correct and safe to mark such register as "imprecise"
+ * (i.e., precise marking set to false). This is what we rely on when we do
+ * not set precise marking in current state. If no child state requires
+ * precision for any given SCALAR register, it's safe to dictate that it can
+ * be imprecise. If any child state does require this register to be precise,
+ * we'll mark it precise later retroactively during precise markings
+ * propagation from child state to parent states.
+ *
+ * Skipping precise marking setting in current state is a mild version of
+ * relying on the above observation. But we can utilize this property even
+ * more aggressively by proactively forgetting any precise marking in the
+ * current state (which we inherited from the parent state), right before we
+ * checkpoint it and branch off into new child state. This is done by
+ * mark_all_scalars_imprecise() to hopefully get more permissive and generic
+ * finalized states which help in short circuiting more future states.
+ */
 static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
 				  int spi)
 {
@@ -2812,6 +2942,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 	if (!env->bpf_capable)
 		return 0;
 
+	/* Do sanity checks against current state of register and/or stack
+	 * slot, but don't set precise flag in current state, as precision
+	 * tracking in the current state is unnecessary.
+	 */
 	func = st->frame[frame];
 	if (regno >= 0) {
 		reg = &func->regs[regno];
@@ -2819,11 +2953,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			WARN_ONCE(1, "backtracing misuse");
 			return -EFAULT;
 		}
-		if (!reg->precise)
-			new_marks = true;
-		else
-			reg_mask = 0;
-		reg->precise = true;
+		new_marks = true;
 	}
 
 	while (spi >= 0) {
@@ -2836,11 +2966,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			stack_mask = 0;
 			break;
 		}
-		if (!reg->precise)
-			new_marks = true;
-		else
-			stack_mask = 0;
-		reg->precise = true;
+		new_marks = true;
 		break;
 	}
 
@@ -2848,12 +2974,42 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		return 0;
 	if (!reg_mask && !stack_mask)
 		return 0;
+
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
 		u32 history = st->jmp_history_cnt;
 
 		if (env->log.level & BPF_LOG_LEVEL2)
 			verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
+
+		if (last_idx < 0) {
+			/* we are at the entry into subprog, which
+			 * is expected for global funcs, but only if
+			 * requested precise registers are R1-R5
+			 * (which are global func's input arguments)
+			 */
+			if (st->curframe == 0 &&
+			    st->frame[0]->subprogno > 0 &&
+			    st->frame[0]->callsite == BPF_MAIN_FUNC &&
+			    stack_mask == 0 && (reg_mask & ~0x3e) == 0) {
+				bitmap_from_u64(mask, reg_mask);
+				for_each_set_bit(i, mask, 32) {
+					reg = &st->frame[0]->regs[i];
+					if (reg->type != SCALAR_VALUE) {
+						reg_mask &= ~(1u << i);
+						continue;
+					}
+					reg->precise = true;
+				}
+				return 0;
+			}
+
+			verbose(env, "BUG backtracing func entry subprog %d reg_mask %x stack_mask %llx\n",
+				st->frame[0]->subprogno, reg_mask, stack_mask);
+			WARN_ONCE(1, "verifier backtracking bug");
+			return -EFAULT;
+		}
+
 		for (i = last_idx;;) {
 			if (skip_first) {
 				err = 0;
@@ -4288,16 +4444,17 @@ static int update_stack_depth(struct bpf_verifier_env *env,
  * Since recursion is prevented by check_cfg() this algorithm
  * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
-static int check_max_stack_depth(struct bpf_verifier_env *env)
+static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 {
-	int depth = 0, frame = 0, idx = 0, i = 0, subprog_end;
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
+	int depth = 0, frame = 0, i, subprog_end;
 	bool tail_call_reachable = false;
 	int ret_insn[MAX_CALL_FRAMES];
 	int ret_prog[MAX_CALL_FRAMES];
 	int j;
 
+	i = subprog[idx].start;
 process_func:
 	/* protect against potential stack overflow that might happen when
 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
@@ -4336,7 +4493,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 continue_func:
 	subprog_end = subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
-		int next_insn;
+		int next_insn, sidx;
 
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
@@ -4346,14 +4503,14 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
-		idx = find_subprog(env, next_insn);
-		if (idx < 0) {
+		sidx = find_subprog(env, next_insn);
+		if (sidx < 0) {
 			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
 				  next_insn);
 			return -EFAULT;
 		}
-		if (subprog[idx].is_async_cb) {
-			if (subprog[idx].has_tail_call) {
+		if (subprog[sidx].is_async_cb) {
+			if (subprog[sidx].has_tail_call) {
 				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
 				return -EFAULT;
 			}
@@ -4362,6 +4519,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 				continue;
 		}
 		i = next_insn;
+		idx = sidx;
 
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable = true;
@@ -4397,6 +4555,22 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	goto continue_func;
 }
 
+static int check_max_stack_depth(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	int ret;
+
+	for (int i = 0; i < env->subprog_cnt; i++) {
+		if (!i || si[i].is_async_cb) {
+			ret = check_max_stack_depth_subprog(env, i);
+			if (ret < 0)
+				return ret;
+		}
+		continue;
+	}
+	return 0;
+}
+
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 static int get_callee_stack_depth(struct bpf_verifier_env *env,
 				  const struct bpf_insn *insn, int idx)
@@ -6714,6 +6888,10 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
+static int set_callee_state(struct bpf_verifier_env *env,
+			    struct bpf_func_state *caller,
+			    struct bpf_func_state *callee, int insn_idx);
+
 static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx, int subprog,
 			     set_callee_state_fn set_callee_state_cb)
@@ -6764,6 +6942,16 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 	}
 
+	/* set_callee_state is used for direct subprog calls, but we are
+	 * interested in validating only BPF helpers that can call subprogs as
+	 * callbacks
+	 */
+	if (set_callee_state_cb != set_callee_state && !is_callback_calling_function(insn->imm)) {
+		verbose(env, "verifier bug: helper %s#%d is not marked as callback-calling\n",
+			func_id_name(insn->imm), insn->imm);
+		return -EFAULT;
+	}
+
 	if (insn->code == (BPF_JMP | BPF_CALL) &&
 	    insn->src_reg == 0 &&
 	    insn->imm == BPF_FUNC_timer_set_callback) {
@@ -11592,7 +11780,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (env->explore_alu_limits)
 			return false;
 		if (rcur->type == SCALAR_VALUE) {
-			if (!rold->precise && !rcur->precise)
+			if (!rold->precise)
 				return true;
 			/* new val must satisfy old val knowledge */
 			return range_within(rold, rcur) &&
@@ -12141,6 +12329,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	env->prev_jmps_processed = env->jmps_processed;
 	env->prev_insn_processed = env->insn_processed;
 
+	/* forget precise markings we inherited, see __mark_chain_precision */
+	if (env->bpf_capable)
+		mark_all_scalars_imprecise(env, cur);
+
 	/* add new state to the head of linked list */
 	new = &new_sl->state;
 	err = copy_verifier_state(new, cur);
@@ -14695,6 +14887,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno */,
 			subprog);
+	state->first_insn_idx = env->subprog_info[subprog].start;
+	state->last_insn_idx = -1;
 
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2380c4daef33..73f11e4db3a4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3771,7 +3771,7 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 	}
 
 	psi = cgroup_psi(cgrp);
-	new = psi_trigger_create(psi, buf, res);
+	new = psi_trigger_create(psi, buf, res, of->file, of);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
 		return PTR_ERR(new);
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 60c20f301a6b..676328a7c8c7 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -174,11 +174,10 @@ static bool cleanup_symbol_name(char *s)
 	 * LLVM appends various suffixes for local functions and variables that
 	 * must be promoted to global scope as part of LTO.  This can break
 	 * hooking of static functions with kprobes. '.' is not a valid
-	 * character in an identifier in C. Suffixes observed:
+	 * character in an identifier in C. Suffixes only in LLVM LTO observed:
 	 * - foo.llvm.[0-9a-f]+
-	 * - foo.[0-9a-f]+
 	 */
-	res = strchr(s, '.');
+	res = strstr(s, ".llvm.");
 	if (res) {
 		*res = '\0';
 		return true;
@@ -187,26 +186,90 @@ static bool cleanup_symbol_name(char *s)
 	return false;
 }
 
+static int compare_symbol_name(const char *name, char *namebuf)
+{
+	int ret;
+
+	ret = strcmp(name, namebuf);
+	if (!ret)
+		return ret;
+
+	if (cleanup_symbol_name(namebuf) && !strcmp(name, namebuf))
+		return 0;
+
+	return ret;
+}
+
+static int kallsyms_lookup_names(const char *name,
+				 unsigned int *start,
+				 unsigned int *end)
+{
+	int ret;
+	int low, mid, high;
+	unsigned int seq, off;
+	char namebuf[KSYM_NAME_LEN];
+
+	low = 0;
+	high = kallsyms_num_syms - 1;
+
+	while (low <= high) {
+		mid = low + (high - low) / 2;
+		seq = kallsyms_seqs_of_names[mid];
+		off = get_symbol_offset(seq);
+		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
+		ret = compare_symbol_name(name, namebuf);
+		if (ret > 0)
+			low = mid + 1;
+		else if (ret < 0)
+			high = mid - 1;
+		else
+			break;
+	}
+
+	if (low > high)
+		return -ESRCH;
+
+	low = mid;
+	while (low) {
+		seq = kallsyms_seqs_of_names[low - 1];
+		off = get_symbol_offset(seq);
+		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
+		if (compare_symbol_name(name, namebuf))
+			break;
+		low--;
+	}
+	*start = low;
+
+	if (end) {
+		high = mid;
+		while (high < kallsyms_num_syms - 1) {
+			seq = kallsyms_seqs_of_names[high + 1];
+			off = get_symbol_offset(seq);
+			kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
+			if (compare_symbol_name(name, namebuf))
+				break;
+			high++;
+		}
+		*end = high;
+	}
+
+	return 0;
+}
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
-	char namebuf[KSYM_NAME_LEN];
-	unsigned long i;
-	unsigned int off;
+	int ret;
+	unsigned int i;
 
 	/* Skip the search for empty string. */
 	if (!*name)
 		return 0;
 
-	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
-		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-
-		if (strcmp(namebuf, name) == 0)
-			return kallsyms_sym_address(i);
+	ret = kallsyms_lookup_names(name, &i, NULL);
+	if (!ret)
+		return kallsyms_sym_address(kallsyms_seqs_of_names[i]);
 
-		if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
-			return kallsyms_sym_address(i);
-	}
 	return module_kallsyms_lookup_name(name);
 }
 
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 2d0c6f2f0243..a04b7a5cb1e3 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -26,5 +26,6 @@ extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
+extern const unsigned int kallsyms_seqs_of_names[] __weak;
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index df968321fead..c1f18c63b9b1 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -233,7 +233,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	if (rcu_task_enqueue_lim < 0) {
 		rcu_task_enqueue_lim = 1;
 		rcu_task_cb_adjust = true;
-		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
 	} else if (rcu_task_enqueue_lim == 0) {
 		rcu_task_enqueue_lim = 1;
 	}
@@ -264,6 +263,10 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+
+	if (rcu_task_cb_adjust)
+		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
+
 	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
 }
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index e25321dbb068..aa3ec3c3b9f7 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -641,7 +641,7 @@ static void synchronize_rcu_expedited_wait(void)
 					"O."[!!cpu_online(cpu)],
 					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
 					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
-					"D."[!!(rdp->cpu_no_qs.b.exp)]);
+					"D."[!!data_race(rdp->cpu_no_qs.b.exp)]);
 			}
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e3142ee35fc6..044026abfdd7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -257,6 +257,8 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * GP should not be able to end until we report, so there should be
 	 * no need to check for a subsequent expedited GP.  (Though we are
 	 * still in a quiescent state in any case.)
+	 *
+	 * Interrupts are disabled, so ->cpu_no_qs.b.exp cannot change.
 	 */
 	if (blkd_state & RCU_EXP_BLKD && rdp->cpu_no_qs.b.exp)
 		rcu_report_exp_rdp(rdp);
@@ -941,7 +943,7 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (rdp->cpu_no_qs.b.exp)
+	if (READ_ONCE(rdp->cpu_no_qs.b.exp))
 		rcu_report_exp_rdp(rdp);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fa33c441ae86..5e5aea2360a8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6935,7 +6935,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
+	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
 		return recent_used_cpu;
 	}
@@ -10556,7 +10556,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.sd		= sd,
 		.dst_cpu	= this_cpu,
 		.dst_rq		= this_rq,
-		.dst_grpmask    = sched_group_span(sd->groups),
+		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
 		.loop_break	= SCHED_NR_MIGRATE_BREAK,
 		.cpus		= cpus,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index e83c321461cf..80d8c10e9363 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -186,17 +186,22 @@ static void group_init(struct psi_group *group)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
 	group->avg_next_update = group->avg_last_update + psi_period;
-	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
-	/* Init trigger-related members */
-	atomic_set(&group->poll_scheduled, 0);
-	mutex_init(&group->trigger_lock);
-	INIT_LIST_HEAD(&group->triggers);
-	group->poll_min_period = U32_MAX;
-	group->polling_next_update = ULLONG_MAX;
-	init_waitqueue_head(&group->poll_wait);
-	timer_setup(&group->poll_timer, poll_timer_fn, 0);
-	rcu_assign_pointer(group->poll_task, NULL);
+
+	/* Init avg trigger-related members */
+	INIT_LIST_HEAD(&group->avg_triggers);
+	memset(group->avg_nr_triggers, 0, sizeof(group->avg_nr_triggers));
+	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
+
+	/* Init rtpoll trigger-related members */
+	atomic_set(&group->rtpoll_scheduled, 0);
+	mutex_init(&group->rtpoll_trigger_lock);
+	INIT_LIST_HEAD(&group->rtpoll_triggers);
+	group->rtpoll_min_period = U32_MAX;
+	group->rtpoll_next_update = ULLONG_MAX;
+	init_waitqueue_head(&group->rtpoll_wait);
+	timer_setup(&group->rtpoll_timer, poll_timer_fn, 0);
+	rcu_assign_pointer(group->rtpoll_task, NULL);
 }
 
 void __init psi_init(void)
@@ -243,6 +248,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 			     u32 *pchanged_states)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+	int current_cpu = raw_smp_processor_id();
+	unsigned int tasks[NR_PSI_TASK_COUNTS];
 	u64 now, state_start;
 	enum psi_states s;
 	unsigned int seq;
@@ -257,6 +264,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		memcpy(times, groupc->times, sizeof(groupc->times));
 		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
+		if (cpu == current_cpu)
+			memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
 	} while (read_seqcount_retry(&groupc->seq, seq));
 
 	/* Calculate state time deltas against the previous snapshot */
@@ -281,6 +290,28 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		if (delta)
 			*pchanged_states |= (1 << s);
 	}
+
+	/*
+	 * When collect_percpu_times() from the avgs_work, we don't want to
+	 * re-arm avgs_work when all CPUs are IDLE. But the current CPU running
+	 * this avgs_work is never IDLE, cause avgs_work can't be shut off.
+	 * So for the current CPU, we need to re-arm avgs_work only when
+	 * (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0), for other CPUs
+	 * we can just check PSI_NONIDLE delta.
+	 */
+	if (current_work() == &group->avgs_work.work) {
+		bool reschedule;
+
+		if (cpu == current_cpu)
+			reschedule = tasks[NR_RUNNING] +
+				     tasks[NR_IOWAIT] +
+				     tasks[NR_MEMSTALL] > 1;
+		else
+			reschedule = *pchanged_states & (1 << PSI_NONIDLE);
+
+		if (reschedule)
+			*pchanged_states |= PSI_STATE_RESCHEDULE;
+	}
 }
 
 static void calc_avgs(unsigned long avg[3], int missed_periods,
@@ -358,94 +389,6 @@ static void collect_percpu_times(struct psi_group *group,
 		*pchanged_states = changed_states;
 }
 
-static u64 update_averages(struct psi_group *group, u64 now)
-{
-	unsigned long missed_periods = 0;
-	u64 expires, period;
-	u64 avg_next_update;
-	int s;
-
-	/* avgX= */
-	expires = group->avg_next_update;
-	if (now - expires >= psi_period)
-		missed_periods = div_u64(now - expires, psi_period);
-
-	/*
-	 * The periodic clock tick can get delayed for various
-	 * reasons, especially on loaded systems. To avoid clock
-	 * drift, we schedule the clock in fixed psi_period intervals.
-	 * But the deltas we sample out of the per-cpu buckets above
-	 * are based on the actual time elapsing between clock ticks.
-	 */
-	avg_next_update = expires + ((1 + missed_periods) * psi_period);
-	period = now - (group->avg_last_update + (missed_periods * psi_period));
-	group->avg_last_update = now;
-
-	for (s = 0; s < NR_PSI_STATES - 1; s++) {
-		u32 sample;
-
-		sample = group->total[PSI_AVGS][s] - group->avg_total[s];
-		/*
-		 * Due to the lockless sampling of the time buckets,
-		 * recorded time deltas can slip into the next period,
-		 * which under full pressure can result in samples in
-		 * excess of the period length.
-		 *
-		 * We don't want to report non-sensical pressures in
-		 * excess of 100%, nor do we want to drop such events
-		 * on the floor. Instead we punt any overage into the
-		 * future until pressure subsides. By doing this we
-		 * don't underreport the occurring pressure curve, we
-		 * just report it delayed by one period length.
-		 *
-		 * The error isn't cumulative. As soon as another
-		 * delta slips from a period P to P+1, by definition
-		 * it frees up its time T in P.
-		 */
-		if (sample > period)
-			sample = period;
-		group->avg_total[s] += sample;
-		calc_avgs(group->avg[s], missed_periods, sample, period);
-	}
-
-	return avg_next_update;
-}
-
-static void psi_avgs_work(struct work_struct *work)
-{
-	struct delayed_work *dwork;
-	struct psi_group *group;
-	u32 changed_states;
-	bool nonidle;
-	u64 now;
-
-	dwork = to_delayed_work(work);
-	group = container_of(dwork, struct psi_group, avgs_work);
-
-	mutex_lock(&group->avgs_lock);
-
-	now = sched_clock();
-
-	collect_percpu_times(group, PSI_AVGS, &changed_states);
-	nonidle = changed_states & (1 << PSI_NONIDLE);
-	/*
-	 * If there is task activity, periodically fold the per-cpu
-	 * times and feed samples into the running averages. If things
-	 * are idle and there is no data to process, stop the clock.
-	 * Once restarted, we'll catch up the running averages in one
-	 * go - see calc_avgs() and missed_periods.
-	 */
-	if (now >= group->avg_next_update)
-		group->avg_next_update = update_averages(group, now);
-
-	if (nonidle) {
-		schedule_delayed_work(dwork, nsecs_to_jiffies(
-				group->avg_next_update - now) + 1);
-	}
-
-	mutex_unlock(&group->avgs_lock);
-}
-
 /* Trigger tracking window manipulations */
 static void window_reset(struct psi_window *win, u64 now, u64 value,
 			 u64 prev_growth)
@@ -492,33 +435,32 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
-static void init_triggers(struct psi_group *group, u64 now)
+static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
+						   enum psi_aggregators aggregator)
 {
 	struct psi_trigger *t;
-
-	list_for_each_entry(t, &group->triggers, node)
-		window_reset(&t->win, now,
-				group->total[PSI_POLL][t->state], 0);
-	memcpy(group->polling_total, group->total[PSI_POLL],
-		   sizeof(group->polling_total));
-	group->polling_next_update = now + group->poll_min_period;
-}
-
-static u64 update_triggers(struct psi_group *group, u64 now)
-{
-	struct psi_trigger *t;
-	bool update_total = false;
-	u64 *total = group->total[PSI_POLL];
+	u64 *total = group->total[aggregator];
+	struct list_head *triggers;
+	u64 *aggregator_total;
+	*update_total = false;
+
+	if (aggregator == PSI_AVGS) {
+		triggers = &group->avg_triggers;
+		aggregator_total = group->avg_total;
+	} else {
+		triggers = &group->rtpoll_triggers;
+		aggregator_total = group->rtpoll_total;
+	}
 
 	/*
 	 * On subsequent updates, calculate growth deltas and let
 	 * watchers know when their specified thresholds are exceeded.
 	 */
-	list_for_each_entry(t, &group->triggers, node) {
+	list_for_each_entry(t, triggers, node) {
 		u64 growth;
 		bool new_stall;
 
-		new_stall = group->polling_total[t->state] != total[t->state];
+		new_stall = aggregator_total[t->state] != total[t->state];
 
 		/* Check for stall activity or a previous threshold breach */
 		if (!new_stall && !t->pending_event)
@@ -536,7 +478,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 			 * been through all of them. Also remember to extend the
 			 * polling time if we see new stall activity.
 			 */
-			update_total = true;
+			*update_total = true;
 
 			/* Calculate growth since last update */
 			growth = window_update(&t->win, now, total[t->state]);
@@ -552,59 +494,161 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 			continue;
 
 		/* Generate an event */
-		if (cmpxchg(&t->event, 0, 1) == 0)
-			wake_up_interruptible(&t->event_wait);
+		if (cmpxchg(&t->event, 0, 1) == 0) {
+			if (t->of)
+				kernfs_notify(t->of->kn);
+			else
+				wake_up_interruptible(&t->event_wait);
+		}
 		t->last_event_time = now;
 		/* Reset threshold breach flag once event got generated */
 		t->pending_event = false;
 	}
 
-	if (update_total)
-		memcpy(group->polling_total, total,
-				sizeof(group->polling_total));
+	return now + group->rtpoll_min_period;
+}
+
+static u64 update_averages(struct psi_group *group, u64 now)
+{
+	unsigned long missed_periods = 0;
+	u64 expires, period;
+	u64 avg_next_update;
+	int s;
+
+	/* avgX= */
+	expires = group->avg_next_update;
+	if (now - expires >= psi_period)
+		missed_periods = div_u64(now - expires, psi_period);
+
+	/*
+	 * The periodic clock tick can get delayed for various
+	 * reasons, especially on loaded systems. To avoid clock
+	 * drift, we schedule the clock in fixed psi_period intervals.
+	 * But the deltas we sample out of the per-cpu buckets above
+	 * are based on the actual time elapsing between clock ticks.
+	 */
+	avg_next_update = expires + ((1 + missed_periods) * psi_period);
+	period = now - (group->avg_last_update + (missed_periods * psi_period));
+	group->avg_last_update = now;
+
+	for (s = 0; s < NR_PSI_STATES - 1; s++) {
+		u32 sample;
+
+		sample = group->total[PSI_AVGS][s] - group->avg_total[s];
+		/*
+		 * Due to the lockless sampling of the time buckets,
+		 * recorded time deltas can slip into the next period,
+		 * which under full pressure can result in samples in
+		 * excess of the period length.
+		 *
+		 * We don't want to report non-sensical pressures in
+		 * excess of 100%, nor do we want to drop such events
+		 * on the floor. Instead we punt any overage into the
+		 * future until pressure subsides. By doing this we
+		 * don't underreport the occurring pressure curve, we
+		 * just report it delayed by one period length.
+		 *
+		 * The error isn't cumulative. As soon as another
+		 * delta slips from a period P to P+1, by definition
+		 * it frees up its time T in P.
+		 */
+		if (sample > period)
+			sample = period;
+		group->avg_total[s] += sample;
+		calc_avgs(group->avg[s], missed_periods, sample, period);
+	}
+
+	return avg_next_update;
+}
+
+static void psi_avgs_work(struct work_struct *work)
+{
+	struct delayed_work *dwork;
+	struct psi_group *group;
+	u32 changed_states;
+	bool update_total;
+	u64 now;
 
-	return now + group->poll_min_period;
+	dwork = to_delayed_work(work);
+	group = container_of(dwork, struct psi_group, avgs_work);
+
+	mutex_lock(&group->avgs_lock);
+
+	now = sched_clock();
+
+	collect_percpu_times(group, PSI_AVGS, &changed_states);
+	/*
+	 * If there is task activity, periodically fold the per-cpu
+	 * times and feed samples into the running averages. If things
+	 * are idle and there is no data to process, stop the clock.
+	 * Once restarted, we'll catch up the running averages in one
+	 * go - see calc_avgs() and missed_periods.
+	 */
+	if (now >= group->avg_next_update) {
+		update_triggers(group, now, &update_total, PSI_AVGS);
+		group->avg_next_update = update_averages(group, now);
+	}
+
+	if (changed_states & PSI_STATE_RESCHEDULE) {
+		schedule_delayed_work(dwork, nsecs_to_jiffies(
+				group->avg_next_update - now) + 1);
+	}
+
+	mutex_unlock(&group->avgs_lock);
+}
+
+static void init_rtpoll_triggers(struct psi_group *group, u64 now)
+{
+	struct psi_trigger *t;
+
+	list_for_each_entry(t, &group->rtpoll_triggers, node)
+		window_reset(&t->win, now,
+				group->total[PSI_POLL][t->state], 0);
+	memcpy(group->rtpoll_total, group->total[PSI_POLL],
+		   sizeof(group->rtpoll_total));
+	group->rtpoll_next_update = now + group->rtpoll_min_period;
 }
 
 /* Schedule polling if it's not already scheduled or forced. */
-static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
+static void psi_schedule_rtpoll_work(struct psi_group *group, unsigned long delay,
 				   bool force)
 {
 	struct task_struct *task;
 
 	/*
 	 * atomic_xchg should be called even when !force to provide a
-	 * full memory barrier (see the comment inside psi_poll_work).
+	 * full memory barrier (see the comment inside psi_rtpoll_work).
 	 */
-	if (atomic_xchg(&group->poll_scheduled, 1) && !force)
+	if (atomic_xchg(&group->rtpoll_scheduled, 1) && !force)
 		return;
 
 	rcu_read_lock();
 
-	task = rcu_dereference(group->poll_task);
+	task = rcu_dereference(group->rtpoll_task);
 	/*
 	 * kworker might be NULL in case psi_trigger_destroy races with
 	 * psi_task_change (hotpath) which can't use locks
 	 */
 	if (likely(task))
-		mod_timer(&group->poll_timer, jiffies + delay);
+		mod_timer(&group->rtpoll_timer, jiffies + delay);
 	else
-		atomic_set(&group->poll_scheduled, 0);
+		atomic_set(&group->rtpoll_scheduled, 0);
 
 	rcu_read_unlock();
 }
 
-static void psi_poll_work(struct psi_group *group)
+static void psi_rtpoll_work(struct psi_group *group)
 {
 	bool force_reschedule = false;
 	u32 changed_states;
+	bool update_total;
 	u64 now;
 
-	mutex_lock(&group->trigger_lock);
+	mutex_lock(&group->rtpoll_trigger_lock);
 
 	now = sched_clock();
 
-	if (now > group->polling_until) {
+	if (now > group->rtpoll_until) {
 		/*
 		 * We are either about to start or might stop polling if no
 		 * state change was recorded. Resetting poll_scheduled leaves
@@ -614,7 +658,7 @@ static void psi_poll_work(struct psi_group *group)
 		 * should be negligible and polling_next_update still keeps
 		 * updates correctly on schedule.
 		 */
-		atomic_set(&group->poll_scheduled, 0);
+		atomic_set(&group->rtpoll_scheduled, 0);
 		/*
 		 * A task change can race with the poll worker that is supposed to
 		 * report on it. To avoid missing events, ensure ordering between
@@ -643,60 +687,64 @@ static void psi_poll_work(struct psi_group *group)
 
 	collect_percpu_times(group, PSI_POLL, &changed_states);
 
-	if (changed_states & group->poll_states) {
+	if (changed_states & group->rtpoll_states) {
 		/* Initialize trigger windows when entering polling mode */
-		if (now > group->polling_until)
-			init_triggers(group, now);
+		if (now > group->rtpoll_until)
+			init_rtpoll_triggers(group, now);
 
 		/*
 		 * Keep the monitor active for at least the duration of the
 		 * minimum tracking window as long as monitor states are
 		 * changing.
 		 */
-		group->polling_until = now +
-			group->poll_min_period * UPDATES_PER_WINDOW;
+		group->rtpoll_until = now +
+			group->rtpoll_min_period * UPDATES_PER_WINDOW;
 	}
 
-	if (now > group->polling_until) {
-		group->polling_next_update = ULLONG_MAX;
+	if (now > group->rtpoll_until) {
+		group->rtpoll_next_update = ULLONG_MAX;
 		goto out;
 	}
 
-	if (now >= group->polling_next_update)
-		group->polling_next_update = update_triggers(group, now);
+	if (now >= group->rtpoll_next_update) {
+		group->rtpoll_next_update = update_triggers(group, now, &update_total, PSI_POLL);
+		if (update_total)
+			memcpy(group->rtpoll_total, group->total[PSI_POLL],
+				   sizeof(group->rtpoll_total));
+	}
 
-	psi_schedule_poll_work(group,
-		nsecs_to_jiffies(group->polling_next_update - now) + 1,
+	psi_schedule_rtpoll_work(group,
+		nsecs_to_jiffies(group->rtpoll_next_update - now) + 1,
 		force_reschedule);
 
 out:
-	mutex_unlock(&group->trigger_lock);
+	mutex_unlock(&group->rtpoll_trigger_lock);
 }
 
-static int psi_poll_worker(void *data)
+static int psi_rtpoll_worker(void *data)
 {
 	struct psi_group *group = (struct psi_group *)data;
 
 	sched_set_fifo_low(current);
 
 	while (true) {
-		wait_event_interruptible(group->poll_wait,
-				atomic_cmpxchg(&group->poll_wakeup, 1, 0) ||
+		wait_event_interruptible(group->rtpoll_wait,
+				atomic_cmpxchg(&group->rtpoll_wakeup, 1, 0) ||
 				kthread_should_stop());
 		if (kthread_should_stop())
 			break;
 
-		psi_poll_work(group);
+		psi_rtpoll_work(group);
 	}
 	return 0;
 }
 
 static void poll_timer_fn(struct timer_list *t)
 {
-	struct psi_group *group = from_timer(group, t, poll_timer);
+	struct psi_group *group = from_timer(group, t, rtpoll_timer);
 
-	atomic_set(&group->poll_wakeup, 1);
-	wake_up_interruptible(&group->poll_wait);
+	atomic_set(&group->rtpoll_wakeup, 1);
+	wake_up_interruptible(&group->rtpoll_wait);
 }
 
 static void record_times(struct psi_group_cpu *groupc, u64 now)
@@ -827,8 +875,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 	write_seqcount_end(&groupc->seq);
 
-	if (state_mask & group->poll_states)
-		psi_schedule_poll_work(group, 1, false);
+	if (state_mask & group->rtpoll_states)
+		psi_schedule_rtpoll_work(group, 1, false);
 
 	if (wake_clock && !delayed_work_pending(&group->avgs_work))
 		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
@@ -981,8 +1029,8 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 
 		write_seqcount_end(&groupc->seq);
 
-		if (group->poll_states & (1 << PSI_IRQ_FULL))
-			psi_schedule_poll_work(group, 1, false);
+		if (group->rtpoll_states & (1 << PSI_IRQ_FULL))
+			psi_schedule_rtpoll_work(group, 1, false);
 	} while ((group = group->parent));
 }
 #endif
@@ -1077,7 +1125,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
 	cancel_delayed_work_sync(&cgroup->psi->avgs_work);
 	free_percpu(cgroup->psi->pcpu);
 	/* All triggers must be removed by now */
-	WARN_ONCE(cgroup->psi->poll_states, "psi: trigger leak\n");
+	WARN_ONCE(cgroup->psi->rtpoll_states, "psi: trigger leak\n");
 	kfree(cgroup->psi);
 }
 
@@ -1228,17 +1276,25 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	return 0;
 }
 
-struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res)
+struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
+				       enum psi_res res, struct file *file,
+				       struct kernfs_open_file *of)
 {
 	struct psi_trigger *t;
 	enum psi_states state;
 	u32 threshold_us;
+	bool privileged;
 	u32 window_us;
 
 	if (static_branch_likely(&psi_disabled))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/*
+	 * Checking the privilege here on file->f_cred implies that a privileged user
+	 * could open the file and delegate the write to an unprivileged one.
+	 */
+	privileged = cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
+
 	if (sscanf(buf, "some %u %u", &threshold_us, &window_us) == 2)
 		state = PSI_IO_SOME + res * 2;
 	else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) == 2)
@@ -1258,6 +1314,13 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 		window_us > WINDOW_MAX_US)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Unprivileged users can only use 2s windows so that averages aggregation
+	 * work is used, and no RT threads need to be spawned.
+	 */
+	if (!privileged && window_us % 2000000)
+		return ERR_PTR(-EINVAL);
+
 	/* Check threshold */
 	if (threshold_us == 0 || threshold_us > window_us)
 		return ERR_PTR(-EINVAL);
@@ -1275,33 +1338,44 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 
 	t->event = 0;
 	t->last_event_time = 0;
-	init_waitqueue_head(&t->event_wait);
+	t->of = of;
+	if (!of)
+		init_waitqueue_head(&t->event_wait);
 	t->pending_event = false;
+	t->aggregator = privileged ? PSI_POLL : PSI_AVGS;
 
-	mutex_lock(&group->trigger_lock);
+	if (privileged) {
+		mutex_lock(&group->rtpoll_trigger_lock);
 
-	if (!rcu_access_pointer(group->poll_task)) {
-		struct task_struct *task;
+		if (!rcu_access_pointer(group->rtpoll_task)) {
+			struct task_struct *task;
 
-		task = kthread_create(psi_poll_worker, group, "psimon");
-		if (IS_ERR(task)) {
-			kfree(t);
-			mutex_unlock(&group->trigger_lock);
-			return ERR_CAST(task);
+			task = kthread_create(psi_rtpoll_worker, group, "psimon");
+			if (IS_ERR(task)) {
+				kfree(t);
+				mutex_unlock(&group->rtpoll_trigger_lock);
+				return ERR_CAST(task);
+			}
+			atomic_set(&group->rtpoll_wakeup, 0);
+			wake_up_process(task);
+			rcu_assign_pointer(group->rtpoll_task, task);
 		}
-		atomic_set(&group->poll_wakeup, 0);
-		wake_up_process(task);
-		rcu_assign_pointer(group->poll_task, task);
-	}
 
-	list_add(&t->node, &group->triggers);
-	group->poll_min_period = min(group->poll_min_period,
-		div_u64(t->win.size, UPDATES_PER_WINDOW));
-	group->nr_triggers[t->state]++;
-	group->poll_states |= (1 << t->state);
+		list_add(&t->node, &group->rtpoll_triggers);
+		group->rtpoll_min_period = min(group->rtpoll_min_period,
+			div_u64(t->win.size, UPDATES_PER_WINDOW));
+		group->rtpoll_nr_triggers[t->state]++;
+		group->rtpoll_states |= (1 << t->state);
 
-	mutex_unlock(&group->trigger_lock);
+		mutex_unlock(&group->rtpoll_trigger_lock);
+	} else {
+		mutex_lock(&group->avgs_lock);
 
+		list_add(&t->node, &group->avg_triggers);
+		group->avg_nr_triggers[t->state]++;
+
+		mutex_unlock(&group->avgs_lock);
+	}
 	return t;
 }
 
@@ -1323,53 +1397,64 @@ void psi_trigger_destroy(struct psi_trigger *t)
 	 * being accessed later. Can happen if cgroup is deleted from under a
 	 * polling process.
 	 */
-	wake_up_pollfree(&t->event_wait);
-
-	mutex_lock(&group->trigger_lock);
-
-	if (!list_empty(&t->node)) {
-		struct psi_trigger *tmp;
-		u64 period = ULLONG_MAX;
-
-		list_del(&t->node);
-		group->nr_triggers[t->state]--;
-		if (!group->nr_triggers[t->state])
-			group->poll_states &= ~(1 << t->state);
-		/* reset min update period for the remaining triggers */
-		list_for_each_entry(tmp, &group->triggers, node)
-			period = min(period, div_u64(tmp->win.size,
-					UPDATES_PER_WINDOW));
-		group->poll_min_period = period;
-		/* Destroy poll_task when the last trigger is destroyed */
-		if (group->poll_states == 0) {
-			group->polling_until = 0;
-			task_to_destroy = rcu_dereference_protected(
-					group->poll_task,
-					lockdep_is_held(&group->trigger_lock));
-			rcu_assign_pointer(group->poll_task, NULL);
-			del_timer(&group->poll_timer);
+	if (t->of)
+		kernfs_notify(t->of->kn);
+	else
+		wake_up_interruptible(&t->event_wait);
+
+	if (t->aggregator == PSI_AVGS) {
+		mutex_lock(&group->avgs_lock);
+		if (!list_empty(&t->node)) {
+			list_del(&t->node);
+			group->avg_nr_triggers[t->state]--;
+		}
+		mutex_unlock(&group->avgs_lock);
+	} else {
+		mutex_lock(&group->rtpoll_trigger_lock);
+		if (!list_empty(&t->node)) {
+			struct psi_trigger *tmp;
+			u64 period = ULLONG_MAX;
+
+			list_del(&t->node);
+			group->rtpoll_nr_triggers[t->state]--;
+			if (!group->rtpoll_nr_triggers[t->state])
+				group->rtpoll_states &= ~(1 << t->state);
+			/* reset min update period for the remaining triggers */
+			list_for_each_entry(tmp, &group->rtpoll_triggers, node)
+				period = min(period, div_u64(tmp->win.size,
+						UPDATES_PER_WINDOW));
+			group->rtpoll_min_period = period;
+			/* Destroy rtpoll_task when the last trigger is destroyed */
+			if (group->rtpoll_states == 0) {
+				group->rtpoll_until = 0;
+				task_to_destroy = rcu_dereference_protected(
+						group->rtpoll_task,
+						lockdep_is_held(&group->rtpoll_trigger_lock));
+				rcu_assign_pointer(group->rtpoll_task, NULL);
+				del_timer(&group->rtpoll_timer);
+			}
 		}
+		mutex_unlock(&group->rtpoll_trigger_lock);
 	}
 
-	mutex_unlock(&group->trigger_lock);
-
 	/*
-	 * Wait for psi_schedule_poll_work RCU to complete its read-side
+	 * Wait for psi_schedule_rtpoll_work RCU to complete its read-side
 	 * critical section before destroying the trigger and optionally the
-	 * poll_task.
+	 * rtpoll_task.
 	 */
 	synchronize_rcu();
 	/*
-	 * Stop kthread 'psimon' after releasing trigger_lock to prevent a
-	 * deadlock while waiting for psi_poll_work to acquire trigger_lock
+	 * Stop kthread 'psimon' after releasing rtpoll_trigger_lock to prevent
+	 * a deadlock while waiting for psi_rtpoll_work to acquire
+	 * rtpoll_trigger_lock
 	 */
 	if (task_to_destroy) {
 		/*
 		 * After the RCU grace period has expired, the worker
-		 * can no longer be found through group->poll_task.
+		 * can no longer be found through group->rtpoll_task.
 		 */
 		kthread_stop(task_to_destroy);
-		atomic_set(&group->poll_scheduled, 0);
+		atomic_set(&group->rtpoll_scheduled, 0);
 	}
 	kfree(t);
 }
@@ -1387,7 +1472,10 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
-	poll_wait(file, &t->event_wait, wait);
+	if (t->of)
+		kernfs_generic_poll(t->of, wait);
+	else
+		poll_wait(file, &t->event_wait, wait);
 
 	if (cmpxchg(&t->event, 1, 0) == 1)
 		ret |= EPOLLPRI;
@@ -1411,27 +1499,19 @@ static int psi_cpu_show(struct seq_file *m, void *v)
 	return psi_show(m, &psi_system, PSI_CPU);
 }
 
-static int psi_open(struct file *file, int (*psi_show)(struct seq_file *, void *))
-{
-	if (file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
-		return -EPERM;
-
-	return single_open(file, psi_show, NULL);
-}
-
 static int psi_io_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_io_show);
+	return single_open(file, psi_io_show, NULL);
 }
 
 static int psi_memory_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_memory_show);
+	return single_open(file, psi_memory_show, NULL);
 }
 
 static int psi_cpu_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_cpu_show);
+	return single_open(file, psi_cpu_show, NULL);
 }
 
 static ssize_t psi_write(struct file *file, const char __user *user_buf,
@@ -1465,7 +1545,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, res);
+	new = psi_trigger_create(&psi_system, buf, res, file, NULL);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);
@@ -1545,7 +1625,7 @@ static int psi_irq_show(struct seq_file *m, void *v)
 
 static int psi_irq_open(struct inode *inode, struct file *file)
 {
-	return psi_open(file, psi_irq_show);
+	return single_open(file, psi_irq_show, NULL);
 }
 
 static ssize_t psi_irq_write(struct file *file, const char __user *user_buf,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 105253b9bc31..0f5d16eabd3b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6560,7 +6560,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		goto out_unreg;
 
 	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		if (save_hist_vars(hist_data))
+		ret = save_hist_vars(hist_data);
+		if (ret)
 			goto out_unreg;
 	}
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2f1f661157c9..47d0c95b9a01 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3711,7 +3711,8 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	mas->offset = slot;
 	pivots[slot] = mas->last;
 	if (mas->last != ULONG_MAX)
-		slot++;
+		pivots[++slot] = ULONG_MAX;
+
 	mas->depth = 1;
 	mas_set_height(mas);
 	ma_set_meta(node, maple_leaf_64, 0, slot);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fef09d212138..61059571c877 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -117,7 +117,7 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 	 */
 	params->explicit_connect = false;
 
-	list_del_init(&params->action);
+	hci_pend_le_list_del_init(params);
 
 	switch (params->auto_connect) {
 	case HCI_AUTO_CONN_EXPLICIT:
@@ -126,10 +126,10 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 		return;
 	case HCI_AUTO_CONN_DIRECT:
 	case HCI_AUTO_CONN_ALWAYS:
-		list_add(&params->action, &hdev->pend_le_conns);
+		hci_pend_le_list_add(params, &hdev->pend_le_conns);
 		break;
 	case HCI_AUTO_CONN_REPORT:
-		list_add(&params->action, &hdev->pend_le_reports);
+		hci_pend_le_list_add(params, &hdev->pend_le_reports);
 		break;
 	default:
 		break;
@@ -1398,8 +1398,8 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 	if (params->auto_connect == HCI_AUTO_CONN_DISABLED ||
 	    params->auto_connect == HCI_AUTO_CONN_REPORT ||
 	    params->auto_connect == HCI_AUTO_CONN_EXPLICIT) {
-		list_del_init(&params->action);
-		list_add(&params->action, &hdev->pend_le_conns);
+		hci_pend_le_list_del_init(params);
+		hci_pend_le_list_add(params, &hdev->pend_le_conns);
 	}
 
 	params->explicit_connect = true;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ca42129f8f91..d034bf2a999e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1972,6 +1972,7 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 				  struct adv_monitor *monitor)
 {
 	int status = 0;
+	int handle;
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered off */
@@ -1980,9 +1981,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 		goto free_monitor;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
+		handle = monitor->handle;
 		status = msft_remove_monitor(hdev, monitor);
 		bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
-			   hdev->name, monitor->handle, status);
+			   hdev->name, handle, status);
 		break;
 	}
 
@@ -2249,21 +2251,45 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 	return NULL;
 }
 
-/* This function requires the caller holds hdev->lock */
+/* This function requires the caller holds hdev->lock or rcu_read_lock */
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *param;
 
-	list_for_each_entry(param, list, action) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(param, list, action) {
 		if (bacmp(&param->addr, addr) == 0 &&
-		    param->addr_type == addr_type)
+		    param->addr_type == addr_type) {
+			rcu_read_unlock();
 			return param;
+		}
 	}
 
+	rcu_read_unlock();
+
 	return NULL;
 }
 
+/* This function requires the caller holds hdev->lock */
+void hci_pend_le_list_del_init(struct hci_conn_params *param)
+{
+	if (list_empty(&param->action))
+		return;
+
+	list_del_rcu(&param->action);
+	synchronize_rcu();
+	INIT_LIST_HEAD(&param->action);
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_pend_le_list_add(struct hci_conn_params *param,
+			  struct list_head *list)
+{
+	list_add_rcu(&param->action, list);
+}
+
 /* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type)
@@ -2297,14 +2323,15 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 	return params;
 }
 
-static void hci_conn_params_free(struct hci_conn_params *params)
+void hci_conn_params_free(struct hci_conn_params *params)
 {
+	hci_pend_le_list_del_init(params);
+
 	if (params->conn) {
 		hci_conn_drop(params->conn);
 		hci_conn_put(params->conn);
 	}
 
-	list_del(&params->action);
 	list_del(&params->list);
 	kfree(params);
 }
@@ -2342,8 +2369,7 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
 			continue;
 		}
 
-		list_del(&params->list);
-		kfree(params);
+		hci_conn_params_free(params);
 	}
 
 	BT_DBG("All LE disabled connection parameters were removed");
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b272cc1f3648..83eaf25ece46 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1558,7 +1558,7 @@ static u8 hci_cc_le_set_privacy_mode(struct hci_dev *hdev, void *data,
 
 	params = hci_conn_params_lookup(hdev, &cp->bdaddr, cp->bdaddr_type);
 	if (params)
-		params->privacy_mode = cp->mode;
+		WRITE_ONCE(params->privacy_mode, cp->mode);
 
 	hci_dev_unlock(hdev);
 
@@ -2789,6 +2789,9 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 			hci_enable_advertising(hdev);
 		}
 
+		/* Inform sockets conn is gone before we delete it */
+		hci_disconn_cfm(conn, HCI_ERROR_UNSPECIFIED);
+
 		goto done;
 	}
 
@@ -2809,8 +2812,8 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 
 		case HCI_AUTO_CONN_DIRECT:
 		case HCI_AUTO_CONN_ALWAYS:
-			list_del_init(&params->action);
-			list_add(&params->action, &hdev->pend_le_conns);
+			hci_pend_le_list_del_init(params);
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
 			break;
 
 		default:
@@ -3428,8 +3431,8 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 
 		case HCI_AUTO_CONN_DIRECT:
 		case HCI_AUTO_CONN_ALWAYS:
-			list_del_init(&params->action);
-			list_add(&params->action, &hdev->pend_le_conns);
+			hci_pend_le_list_del_init(params);
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
 			hci_update_passive_scan(hdev);
 			break;
 
@@ -5952,7 +5955,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
 					   conn->dst_type);
 	if (params) {
-		list_del_init(&params->action);
+		hci_pend_le_list_del_init(params);
 		if (params->conn) {
 			hci_conn_drop(params->conn);
 			hci_conn_put(params->conn);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 37131a36700a..2ae038dfc39f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2139,15 +2139,23 @@ static int hci_le_del_accept_list_sync(struct hci_dev *hdev,
 	return 0;
 }
 
+struct conn_params {
+	bdaddr_t addr;
+	u8 addr_type;
+	hci_conn_flags_t flags;
+	u8 privacy_mode;
+};
+
 /* Adds connection to resolve list if needed.
  * Setting params to NULL programs local hdev->irk
  */
 static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
-					struct hci_conn_params *params)
+					struct conn_params *params)
 {
 	struct hci_cp_le_add_to_resolv_list cp;
 	struct smp_irk *irk;
 	struct bdaddr_list_with_irk *entry;
+	struct hci_conn_params *p;
 
 	if (!use_ll_privacy(hdev))
 		return 0;
@@ -2182,6 +2190,16 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 	/* Default privacy mode is always Network */
 	params->privacy_mode = HCI_NETWORK_PRIVACY;
 
+	rcu_read_lock();
+	p = hci_pend_le_action_lookup(&hdev->pend_le_conns,
+				      &params->addr, params->addr_type);
+	if (!p)
+		p = hci_pend_le_action_lookup(&hdev->pend_le_reports,
+					      &params->addr, params->addr_type);
+	if (p)
+		WRITE_ONCE(p->privacy_mode, HCI_NETWORK_PRIVACY);
+	rcu_read_unlock();
+
 done:
 	if (hci_dev_test_flag(hdev, HCI_PRIVACY))
 		memcpy(cp.local_irk, hdev->irk, 16);
@@ -2194,7 +2212,7 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 
 /* Set Device Privacy Mode. */
 static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
-					struct hci_conn_params *params)
+					struct conn_params *params)
 {
 	struct hci_cp_le_set_privacy_mode cp;
 	struct smp_irk *irk;
@@ -2219,6 +2237,8 @@ static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
 	bacpy(&cp.bdaddr, &irk->bdaddr);
 	cp.mode = HCI_DEVICE_PRIVACY;
 
+	/* Note: params->privacy_mode is not updated since it is a copy */
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PRIVACY_MODE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
@@ -2228,7 +2248,7 @@ static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
  * properly set the privacy mode.
  */
 static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
-				       struct hci_conn_params *params,
+				       struct conn_params *params,
 				       u8 *num_entries)
 {
 	struct hci_cp_le_add_to_accept_list cp;
@@ -2426,6 +2446,52 @@ struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev,
 	return __hci_cmd_sync_sk(hdev, opcode, 0, NULL, 0, HCI_CMD_TIMEOUT, sk);
 }
 
+static struct conn_params *conn_params_copy(struct list_head *list, size_t *n)
+{
+	struct hci_conn_params *params;
+	struct conn_params *p;
+	size_t i;
+
+	rcu_read_lock();
+
+	i = 0;
+	list_for_each_entry_rcu(params, list, action)
+		++i;
+	*n = i;
+
+	rcu_read_unlock();
+
+	p = kvcalloc(*n, sizeof(struct conn_params), GFP_KERNEL);
+	if (!p)
+		return NULL;
+
+	rcu_read_lock();
+
+	i = 0;
+	list_for_each_entry_rcu(params, list, action) {
+		/* Racing adds are handled in next scan update */
+		if (i >= *n)
+			break;
+
+		/* No hdev->lock, but: addr, addr_type are immutable.
+		 * privacy_mode is only written by us or in
+		 * hci_cc_le_set_privacy_mode that we wait for.
+		 * We should be idempotent so MGMT updating flags
+		 * while we are processing is OK.
+		 */
+		bacpy(&p[i].addr, &params->addr);
+		p[i].addr_type = params->addr_type;
+		p[i].flags = READ_ONCE(params->flags);
+		p[i].privacy_mode = READ_ONCE(params->privacy_mode);
+		++i;
+	}
+
+	rcu_read_unlock();
+
+	*n = i;
+	return p;
+}
+
 /* Device must not be scanning when updating the accept list.
  *
  * Update is done using the following sequence:
@@ -2445,11 +2511,12 @@ struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev,
  */
 static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 {
-	struct hci_conn_params *params;
+	struct conn_params *params;
 	struct bdaddr_list *b, *t;
 	u8 num_entries = 0;
 	bool pend_conn, pend_report;
 	u8 filter_policy;
+	size_t i, n;
 	int err;
 
 	/* Pause advertising if resolving list can be used as controllers
@@ -2483,6 +2550,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		if (hci_conn_hash_lookup_le(hdev, &b->bdaddr, b->bdaddr_type))
 			continue;
 
+		/* Pointers not dereferenced, no locks needed */
 		pend_conn = hci_pend_le_action_lookup(&hdev->pend_le_conns,
 						      &b->bdaddr,
 						      b->bdaddr_type);
@@ -2511,23 +2579,50 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	 * available accept list entries in the controller, then
 	 * just abort and return filer policy value to not use the
 	 * accept list.
+	 *
+	 * The list and params may be mutated while we wait for events,
+	 * so make a copy and iterate it.
 	 */
-	list_for_each_entry(params, &hdev->pend_le_conns, action) {
-		err = hci_le_add_accept_list_sync(hdev, params, &num_entries);
-		if (err)
+
+	params = conn_params_copy(&hdev->pend_le_conns, &n);
+	if (!params) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	for (i = 0; i < n; ++i) {
+		err = hci_le_add_accept_list_sync(hdev, &params[i],
+						  &num_entries);
+		if (err) {
+			kvfree(params);
 			goto done;
+		}
 	}
 
+	kvfree(params);
+
 	/* After adding all new pending connections, walk through
 	 * the list of pending reports and also add these to the
 	 * accept list if there is still space. Abort if space runs out.
 	 */
-	list_for_each_entry(params, &hdev->pend_le_reports, action) {
-		err = hci_le_add_accept_list_sync(hdev, params, &num_entries);
-		if (err)
+
+	params = conn_params_copy(&hdev->pend_le_reports, &n);
+	if (!params) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	for (i = 0; i < n; ++i) {
+		err = hci_le_add_accept_list_sync(hdev, &params[i],
+						  &num_entries);
+		if (err) {
+			kvfree(params);
 			goto done;
+		}
 	}
 
+	kvfree(params);
+
 	/* Use the allowlist unless the following conditions are all true:
 	 * - We are not currently suspending
 	 * - There are 1 or more ADV monitors registered and it's not offloaded
@@ -4778,12 +4873,12 @@ static void hci_pend_le_actions_clear(struct hci_dev *hdev)
 	struct hci_conn_params *p;
 
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
+		hci_pend_le_list_del_init(p);
 		if (p->conn) {
 			hci_conn_drop(p->conn);
 			hci_conn_put(p->conn);
 			p->conn = NULL;
 		}
-		list_del_init(&p->action);
 	}
 
 	BT_DBG("All LE pending actions cleared");
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index cb959e8eac18..699e4f400df2 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -116,8 +116,11 @@ static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
 {
 	struct iso_conn *conn = hcon->iso_data;
 
-	if (conn)
+	if (conn) {
+		if (!conn->hcon)
+			conn->hcon = hcon;
 		return conn;
+	}
 
 	conn = kzalloc(sizeof(*conn), GFP_KERNEL);
 	if (!conn)
@@ -285,14 +288,13 @@ static int iso_connect_bis(struct sock *sk)
 		goto unlock;
 	}
 
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	lock_sock(sk);
 
 	err = iso_chan_add(conn, sk, NULL);
-	if (err)
-		return err;
-
-	lock_sock(sk);
+	if (err) {
+		release_sock(sk);
+		goto unlock;
+	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -306,7 +308,6 @@ static int iso_connect_bis(struct sock *sk)
 	}
 
 	release_sock(sk);
-	return err;
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -367,14 +368,13 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	lock_sock(sk);
 
 	err = iso_chan_add(conn, sk, NULL);
-	if (err)
-		return err;
-
-	lock_sock(sk);
+	if (err) {
+		release_sock(sk);
+		goto unlock;
+	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -391,7 +391,6 @@ static int iso_connect_cis(struct sock *sk)
 	}
 
 	release_sock(sk);
-	return err;
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -1036,8 +1035,8 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len)
 {
 	struct sock *sk = sock->sk;
-	struct iso_conn *conn = iso_pi(sk)->conn;
 	struct sk_buff *skb, **frag;
+	size_t mtu;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -1049,11 +1048,18 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	if (sk->sk_state != BT_CONNECTED)
+	lock_sock(sk);
+
+	if (sk->sk_state != BT_CONNECTED) {
+		release_sock(sk);
 		return -ENOTCONN;
+	}
+
+	mtu = iso_pi(sk)->conn->hcon->hdev->iso_mtu;
+
+	release_sock(sk);
 
-	skb = bt_skb_sendmsg(sk, msg, len, conn->hcon->hdev->iso_mtu,
-			     HCI_ISO_DATA_HDR_SIZE, 0);
+	skb = bt_skb_sendmsg(sk, msg, len, mtu, HCI_ISO_DATA_HDR_SIZE, 0);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1066,8 +1072,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	while (len) {
 		struct sk_buff *tmp;
 
-		tmp = bt_skb_sendmsg(sk, msg, len, conn->hcon->hdev->iso_mtu,
-				     0, 0);
+		tmp = bt_skb_sendmsg(sk, msg, len, mtu, 0, 0);
 		if (IS_ERR(tmp)) {
 			kfree_skb(skb);
 			return PTR_ERR(tmp);
@@ -1122,15 +1127,19 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	BT_DBG("sk %p", sk);
 
 	if (test_and_clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
+		lock_sock(sk);
 		switch (sk->sk_state) {
 		case BT_CONNECT2:
-			lock_sock(sk);
 			iso_conn_defer_accept(pi->conn->hcon);
 			sk->sk_state = BT_CONFIG;
 			release_sock(sk);
 			return 0;
 		case BT_CONNECT:
+			release_sock(sk);
 			return iso_connect_cis(sk);
+		default:
+			release_sock(sk);
+			break;
 		}
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 815f2abe918e..89c94f3e96bc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1297,15 +1297,15 @@ static void restart_le_actions(struct hci_dev *hdev)
 		/* Needed for AUTO_OFF case where might not "really"
 		 * have been powered off.
 		 */
-		list_del_init(&p->action);
+		hci_pend_le_list_del_init(p);
 
 		switch (p->auto_connect) {
 		case HCI_AUTO_CONN_DIRECT:
 		case HCI_AUTO_CONN_ALWAYS:
-			list_add(&p->action, &hdev->pend_le_conns);
+			hci_pend_le_list_add(p, &hdev->pend_le_conns);
 			break;
 		case HCI_AUTO_CONN_REPORT:
-			list_add(&p->action, &hdev->pend_le_reports);
+			hci_pend_le_list_add(p, &hdev->pend_le_reports);
 			break;
 		default:
 			break;
@@ -5161,7 +5161,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	params->flags = current_flags;
+	WRITE_ONCE(params->flags, current_flags);
 	status = MGMT_STATUS_SUCCESS;
 
 	/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
@@ -7573,7 +7573,7 @@ static int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr,
 	if (params->auto_connect == auto_connect)
 		return 0;
 
-	list_del_init(&params->action);
+	hci_pend_le_list_del_init(params);
 
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
@@ -7582,18 +7582,18 @@ static int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr,
 		 * connect to device, keep connecting.
 		 */
 		if (params->explicit_connect)
-			list_add(&params->action, &hdev->pend_le_conns);
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
 		break;
 	case HCI_AUTO_CONN_REPORT:
 		if (params->explicit_connect)
-			list_add(&params->action, &hdev->pend_le_conns);
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
 		else
-			list_add(&params->action, &hdev->pend_le_reports);
+			hci_pend_le_list_add(params, &hdev->pend_le_reports);
 		break;
 	case HCI_AUTO_CONN_DIRECT:
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type))
-			list_add(&params->action, &hdev->pend_le_conns);
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
 		break;
 	}
 
@@ -7816,9 +7816,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		list_del(&params->action);
-		list_del(&params->list);
-		kfree(params);
+		hci_conn_params_free(params);
 
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
@@ -7849,9 +7847,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 				p->auto_connect = HCI_AUTO_CONN_EXPLICIT;
 				continue;
 			}
-			list_del(&p->action);
-			list_del(&p->list);
-			kfree(p);
+			hci_conn_params_free(p);
 		}
 
 		bt_dev_dbg(hdev, "All LE connection parameters were removed");
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 75204d36d7f9..b65962682771 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,6 +201,9 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
 	ASSERT_RTNL();
 
+	if (!net_eq(dev_net(br->dev), &init_net))
+		NL_SET_ERR_MSG_MOD(extack, "STP does not work in non-root netns");
+
 	if (br_mrp_enabled(br)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "STP can't be enabled if MRP is already enabled");
diff --git a/net/can/bcm.c b/net/can/bcm.c
index a962ec2b8ba5..925d48cc50f8 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1526,6 +1526,12 @@ static int bcm_release(struct socket *sock)
 
 	lock_sock(sk);
 
+#if IS_ENABLED(CONFIG_PROC_FS)
+	/* remove procfs entry */
+	if (net->can.bcmproc_dir && bo->bcm_proc_read)
+		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+#endif /* CONFIG_PROC_FS */
+
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
 		bcm_remove_op(op);
 
@@ -1561,12 +1567,6 @@ static int bcm_release(struct socket *sock)
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
 		bcm_remove_op(op);
 
-#if IS_ENABLED(CONFIG_PROC_FS)
-	/* remove procfs entry */
-	if (net->can.bcmproc_dir && bo->bcm_proc_read)
-		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
-#endif /* CONFIG_PROC_FS */
-
 	/* remove device reference */
 	if (bo->bound) {
 		bo->bound   = 0;
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 2aa77d4b80d0..5a4a4b34ac15 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -9826,7 +9826,10 @@ EXPORT_SYMBOL_GPL(devlink_free);
 
 static void devlink_port_type_warn(struct work_struct *work)
 {
-	WARN(true, "Type was not set for devlink port.");
+	struct devlink_port *port = container_of(to_delayed_work(work),
+						 struct devlink_port,
+						 type_warn_dw);
+	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 52c8047efedb..2d094d417eca 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -1132,7 +1132,7 @@ static int esp_init_authenc(struct xfrm_state *x,
 	err = crypto_aead_setkey(aead, key, keylen);
 
 free_key:
-	kfree(key);
+	kfree_sensitive(key);
 
 error:
 	return err;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 8e35ea66d930..62a3b103f258 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1016,7 +1016,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 	icsk = inet_csk(sk_listener);
 	net = sock_net(sk_listener);
-	max_syn_ack_retries = icsk->icsk_syn_retries ? :
+	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index e8734ffca85a..c19b462662ad 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -650,20 +650,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
-		ret = sk_hashed(osk);
-		if (ret) {
-			/* Before deleting the node, we insert a new one to make
-			 * sure that the look-up-sk process would not miss either
-			 * of them and that at least one node would exist in ehash
-			 * table all the time. Otherwise there's a tiny chance
-			 * that lookup process could find nothing in ehash table.
-			 */
-			__sk_nulls_add_node_tail_rcu(sk, list);
-			sk_nulls_del_node_init_rcu(osk);
-		}
-		goto unlock;
-	}
-	if (found_dup_sk) {
+		ret = sk_nulls_del_node_init_rcu(osk);
+	} else if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
 		if (*found_dup_sk)
 			ret = false;
@@ -672,7 +660,6 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
-unlock:
 	spin_unlock(lock);
 
 	return ret;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index beed32fff484..1d77d992e6e7 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -91,10 +91,10 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
 }
 EXPORT_SYMBOL_GPL(inet_twsk_put);
 
-static void inet_twsk_add_node_tail_rcu(struct inet_timewait_sock *tw,
-					struct hlist_nulls_head *list)
+static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
+				   struct hlist_nulls_head *list)
 {
-	hlist_nulls_add_tail_rcu(&tw->tw_node, list);
+	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
 static void inet_twsk_add_bind_node(struct inet_timewait_sock *tw,
@@ -147,7 +147,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
-	inet_twsk_add_node_tail_rcu(tw, &ehead->chain);
+	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 2a07588265c7..7b4ab545c06e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1691,7 +1691,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			   const struct ip_options *sopt,
 			   __be32 daddr, __be32 saddr,
 			   const struct ip_reply_arg *arg,
-			   unsigned int len, u64 transmit_time)
+			   unsigned int len, u64 transmit_time, u32 txhash)
 {
 	struct ip_options_data replyopts;
 	struct ipcm_cookie ipc;
@@ -1754,6 +1754,8 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
 		nskb->mono_delivery_time = !!transmit_time;
+		if (txhash)
+			skb_set_hash(nskb, txhash, PKT_HASH_TYPE_L4);
 		ip_push_pending_frames(sk, &fl4);
 	}
 out:
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0bd0be3c63d2..fab25d4f3a6f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3397,7 +3397,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	inet_csk(sk)->icsk_syn_retries = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_syn_retries, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3406,7 +3406,7 @@ EXPORT_SYMBOL(tcp_sock_set_syncnt);
 void tcp_sock_set_user_timeout(struct sock *sk, u32 val)
 {
 	lock_sock(sk);
-	inet_csk(sk)->icsk_user_timeout = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_user_timeout, val);
 	release_sock(sk);
 }
 EXPORT_SYMBOL(tcp_sock_set_user_timeout);
@@ -3418,7 +3418,8 @@ int tcp_sock_set_keepidle_locked(struct sock *sk, int val)
 	if (val < 1 || val > MAX_TCP_KEEPIDLE)
 		return -EINVAL;
 
-	tp->keepalive_time = val * HZ;
+	/* Paired with WRITE_ONCE() in keepalive_time_when() */
+	WRITE_ONCE(tp->keepalive_time, val * HZ);
 	if (sock_flag(sk, SOCK_KEEPOPEN) &&
 	    !((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
 		u32 elapsed = keepalive_time_elapsed(tp);
@@ -3450,7 +3451,7 @@ int tcp_sock_set_keepintvl(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_intvl = val * HZ;
+	WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
 	release_sock(sk);
 	return 0;
 }
@@ -3462,7 +3463,8 @@ int tcp_sock_set_keepcnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_probes = val;
+	/* Paired with READ_ONCE() in keepalive_probes() */
+	WRITE_ONCE(tcp_sk(sk)->keepalive_probes, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3664,19 +3666,19 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 1 || val > MAX_TCP_KEEPINTVL)
 			err = -EINVAL;
 		else
-			tp->keepalive_intvl = val * HZ;
+			WRITE_ONCE(tp->keepalive_intvl, val * HZ);
 		break;
 	case TCP_KEEPCNT:
 		if (val < 1 || val > MAX_TCP_KEEPCNT)
 			err = -EINVAL;
 		else
-			tp->keepalive_probes = val;
+			WRITE_ONCE(tp->keepalive_probes, val);
 		break;
 	case TCP_SYNCNT:
 		if (val < 1 || val > MAX_TCP_SYNCNT)
 			err = -EINVAL;
 		else
-			icsk->icsk_syn_retries = val;
+			WRITE_ONCE(icsk->icsk_syn_retries, val);
 		break;
 
 	case TCP_SAVE_SYN:
@@ -3689,18 +3691,18 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	case TCP_LINGER2:
 		if (val < 0)
-			tp->linger2 = -1;
+			WRITE_ONCE(tp->linger2, -1);
 		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
-			tp->linger2 = TCP_FIN_TIMEOUT_MAX;
+			WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
 		else
-			tp->linger2 = val * HZ;
+			WRITE_ONCE(tp->linger2, val * HZ);
 		break;
 
 	case TCP_DEFER_ACCEPT:
 		/* Translate value in seconds to number of retransmits */
-		icsk->icsk_accept_queue.rskq_defer_accept =
-			secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
-					TCP_RTO_MAX / HZ);
+		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
+			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
+					   TCP_RTO_MAX / HZ));
 		break;
 
 	case TCP_WINDOW_CLAMP:
@@ -3724,7 +3726,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 0)
 			err = -EINVAL;
 		else
-			icsk->icsk_user_timeout = val;
+			WRITE_ONCE(icsk->icsk_user_timeout, val);
 		break;
 
 	case TCP_FASTOPEN:
@@ -3762,13 +3764,13 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (!tp->repair)
 			err = -EPERM;
 		else
-			tp->tsoffset = val - tcp_time_stamp_raw();
+			WRITE_ONCE(tp->tsoffset, val - tcp_time_stamp_raw());
 		break;
 	case TCP_REPAIR_WINDOW:
 		err = tcp_repair_set_window(tp, optval, optlen);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		tp->notsent_lowat = val;
+		WRITE_ONCE(tp->notsent_lowat, val);
 		sk->sk_write_space(sk);
 		break;
 	case TCP_INQ:
@@ -3780,7 +3782,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	case TCP_TX_DELAY:
 		if (val)
 			tcp_enable_tx_delay();
-		tp->tcp_tx_delay = val;
+		WRITE_ONCE(tp->tcp_tx_delay, val);
 		break;
 	default:
 		err = -ENOPROTOOPT;
@@ -4093,17 +4095,18 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = keepalive_probes(tp);
 		break;
 	case TCP_SYNCNT:
-		val = icsk->icsk_syn_retries ? :
+		val = READ_ONCE(icsk->icsk_syn_retries) ? :
 			READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
 		break;
 	case TCP_LINGER2:
-		val = tp->linger2;
+		val = READ_ONCE(tp->linger2);
 		if (val >= 0)
 			val = (val ? : READ_ONCE(net->ipv4.sysctl_tcp_fin_timeout)) / HZ;
 		break;
 	case TCP_DEFER_ACCEPT:
-		val = retrans_to_secs(icsk->icsk_accept_queue.rskq_defer_accept,
-				      TCP_TIMEOUT_INIT / HZ, TCP_RTO_MAX / HZ);
+		val = READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept);
+		val = retrans_to_secs(val, TCP_TIMEOUT_INIT / HZ,
+				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
 		val = tp->window_clamp;
@@ -4240,11 +4243,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_USER_TIMEOUT:
-		val = icsk->icsk_user_timeout;
+		val = READ_ONCE(icsk->icsk_user_timeout);
 		break;
 
 	case TCP_FASTOPEN:
-		val = icsk->icsk_accept_queue.fastopenq.max_qlen;
+		val = READ_ONCE(icsk->icsk_accept_queue.fastopenq.max_qlen);
 		break;
 
 	case TCP_FASTOPEN_CONNECT:
@@ -4256,14 +4259,14 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_TX_DELAY:
-		val = tp->tcp_tx_delay;
+		val = READ_ONCE(tp->tcp_tx_delay);
 		break;
 
 	case TCP_TIMESTAMP:
-		val = tcp_time_stamp_raw() + tp->tsoffset;
+		val = tcp_time_stamp_raw() + READ_ONCE(tp->tsoffset);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		val = tp->notsent_lowat;
+		val = READ_ONCE(tp->notsent_lowat);
 		break;
 	case TCP_INQ:
 		val = tp->recvmsg_inq;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 45cc7f1ca296..85e4953f1182 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -296,6 +296,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 static bool tcp_fastopen_queue_check(struct sock *sk)
 {
 	struct fastopen_queue *fastopenq;
+	int max_qlen;
 
 	/* Make sure the listener has enabled fastopen, and we don't
 	 * exceed the max # of pending TFO requests allowed before trying
@@ -308,10 +309,11 @@ static bool tcp_fastopen_queue_check(struct sock *sk)
 	 * temporarily vs a server not supporting Fast Open at all.
 	 */
 	fastopenq = &inet_csk(sk)->icsk_accept_queue.fastopenq;
-	if (fastopenq->max_qlen == 0)
+	max_qlen = READ_ONCE(fastopenq->max_qlen);
+	if (max_qlen == 0)
 		return false;
 
-	if (fastopenq->qlen >= fastopenq->max_qlen) {
+	if (fastopenq->qlen >= max_qlen) {
 		struct request_sock *req1;
 		spin_lock(&fastopenq->lock);
 		req1 = fastopenq->rskq_rst_head;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b37c1bcb1509..9a8d59e9303a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -307,8 +307,9 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 						  inet->inet_daddr,
 						  inet->inet_sport,
 						  usin->sin_port));
-		tp->tsoffset = secure_tcp_ts_off(net, inet->inet_saddr,
-						 inet->inet_daddr);
+		WRITE_ONCE(tp->tsoffset,
+			   secure_tcp_ts_off(net, inet->inet_saddr,
+					     inet->inet_daddr));
 	}
 
 	inet->inet_id = get_random_u16();
@@ -692,6 +693,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	u64 transmit_time = 0;
 	struct sock *ctl_sk;
 	struct net *net;
+	u32 txhash = 0;
 
 	/* Never send a reset in response to a reset. */
 	if (th->rst)
@@ -829,6 +831,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 				   inet_twsk(sk)->tw_priority : sk->sk_priority;
 		transmit_time = tcp_transmit_time(sk);
 		xfrm_sk_clone_policy(ctl_sk, sk);
+		txhash = (sk->sk_state == TCP_TIME_WAIT) ?
+			 inet_twsk(sk)->tw_txhash : sk->sk_txhash;
 	} else {
 		ctl_sk->sk_mark = 0;
 		ctl_sk->sk_priority = 0;
@@ -837,7 +841,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len,
-			      transmit_time);
+			      transmit_time, txhash);
 
 	xfrm_sk_free_policy(ctl_sk);
 	sock_net_set(ctl_sk, &init_net);
@@ -859,7 +863,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 			    struct sk_buff *skb, u32 seq, u32 ack,
 			    u32 win, u32 tsval, u32 tsecr, int oif,
 			    struct tcp_md5sig_key *key,
-			    int reply_flags, u8 tos)
+			    int reply_flags, u8 tos, u32 txhash)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct {
@@ -935,7 +939,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len,
-			      transmit_time);
+			      transmit_time, txhash);
 
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
@@ -955,7 +959,8 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			tw->tw_bound_dev_if,
 			tcp_twsk_md5_key(tcptw),
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			tw->tw_tos
+			tw->tw_tos,
+			tw->tw_txhash
 			);
 
 	inet_twsk_put(tw);
@@ -984,11 +989,12 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
-			req->ts_recent,
+			READ_ONCE(req->ts_recent),
 			0,
 			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			ip_hdr(skb)->tos);
+			ip_hdr(skb)->tos,
+			READ_ONCE(tcp_rsk(req)->txhash));
 }
 
 /*
@@ -2911,7 +2917,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	struct sock *sk = v;
-	bool slow;
 	uid_t uid;
 	int ret;
 
@@ -2919,7 +2924,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	if (sk_fullsock(sk))
-		slow = lock_sock_fast(sk);
+		lock_sock(sk);
 
 	if (unlikely(sk_unhashed(sk))) {
 		ret = SEQ_SKIP;
@@ -2943,7 +2948,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 
 unlock:
 	if (sk_fullsock(sk))
-		unlock_sock_fast(sk, slow);
+		release_sock(sk);
 	return ret;
 
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7f37e7da6467..42844d20da02 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -510,7 +510,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newicsk->icsk_ack.lrcvtime = tcp_jiffies32;
 
 	newtp->lsndtime = tcp_jiffies32;
-	newsk->sk_txhash = treq->txhash;
+	newsk->sk_txhash = READ_ONCE(treq->txhash);
 	newtp->total_retrans = req->num_retrans;
 
 	tcp_init_xmit_timers(newsk);
@@ -537,7 +537,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->max_window = newtp->snd_wnd;
 
 	if (newtp->rx_opt.tstamp_ok) {
-		newtp->rx_opt.ts_recent = req->ts_recent;
+		newtp->rx_opt.ts_recent = READ_ONCE(req->ts_recent);
 		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
 	} else {
@@ -601,7 +601,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
 		if (tmp_opt.saw_tstamp) {
-			tmp_opt.ts_recent = req->ts_recent;
+			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
 			if (tmp_opt.rcv_tsecr)
 				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
 			/* We do not store true stamp, but it is not required,
@@ -740,8 +740,11 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	/* In sequence, PAWS is OK. */
 
+	/* TODO: We probably should defer ts_recent change once
+	 * we take ownership of @req.
+	 */
 	if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
-		req->ts_recent = tmp_opt.rcv_tsval;
+		WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
 
 	if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
 		/* Truncate SYN, it is out of window starting
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 925594dbeb92..26bd039f9296 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -876,7 +876,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	if (likely(ireq->tstamp_ok)) {
 		opts->options |= OPTION_TS;
 		opts->tsval = tcp_skb_timestamp(skb) + tcp_rsk(req)->ts_off;
-		opts->tsecr = req->ts_recent;
+		opts->tsecr = READ_ONCE(req->ts_recent);
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
 	if (likely(ireq->sack_ok)) {
@@ -3581,7 +3581,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	rcu_read_lock();
 	md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
 #endif
-	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
+	skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash), PKT_HASH_TYPE_L4);
 	/* bpf program will be interested in the tcp_flags */
 	TCP_SKB_CB(skb)->tcp_flags = TCPHDR_SYN | TCPHDR_ACK;
 	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts, md5,
@@ -4124,7 +4124,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
-		tcp_rsk(req)->txhash = net_tx_rndhash();
+		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
 				  NULL);
 	if (!res) {
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 216b40ccadae..d3fba7d8dec4 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -977,7 +977,8 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 		goto tx_err;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		pskb_trim(skb, dev->mtu + dev->hard_header_len);
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+			goto tx_err;
 		truncate = true;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8d61efeab9c9..d9253aa764fa 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1130,10 +1130,10 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
-			req->ts_recent, sk->sk_bound_dev_if,
+			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
 			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
 			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority,
-			tcp_rsk(req)->txhash);
+			READ_ONCE(tcp_rsk(req)->txhash));
 }
 
 
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index c309b72a5877..7cac441862e2 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -163,9 +163,6 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	void (*sta_handler)(struct sk_buff *skb);
 	void (*sap_handler)(struct llc_sap *sap, struct sk_buff *skb);
 
-	if (!net_eq(dev_net(dev), &init_net))
-		goto drop;
-
 	/*
 	 * When the interface is in promisc. mode, drop all the crap that it
 	 * receives, do not try to analyse it.
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 938cfa9a3adb..ecde497368ec 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3500,8 +3500,6 @@ int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 			if (err < 0)
 				return err;
 		}
-
-		cond_resched();
 	}
 
 	return 0;
@@ -3525,6 +3523,8 @@ static int nft_table_validate(struct net *net, const struct nft_table *table)
 		err = nft_chain_validate(&ctx, chain);
 		if (err < 0)
 			return err;
+
+		cond_resched();
 	}
 
 	return 0;
@@ -3892,6 +3892,8 @@ static int nf_tables_delrule(struct sk_buff *skb, const struct nfnl_info *info,
 		list_for_each_entry(chain, &table->chains, list) {
 			if (!nft_is_active_next(net, chain))
 				continue;
+			if (nft_chain_is_bound(chain))
+				continue;
 
 			ctx.chain = chain;
 			err = nft_delrule_by_chain(&ctx);
@@ -10114,6 +10116,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 	if (!tb[NFTA_VERDICT_CODE])
 		return -EINVAL;
+
+	/* zero padding hole for memcmp */
+	memset(data, 0, sizeof(*data));
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
@@ -10395,6 +10400,9 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	ctx.family = table->family;
 	ctx.table = table;
 	list_for_each_entry(chain, &table->chains, list) {
+		if (nft_chain_is_bound(chain))
+			continue;
+
 		ctx.chain = chain;
 		list_for_each_entry_safe(rule, nr, &chain->rules, list) {
 			list_del(&rule->list);
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 0452ee586c1c..a81829c10fea 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1930,7 +1930,11 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 		int i, start, rules_fx;
 
 		match_start = data;
-		match_end = (const u8 *)nft_set_ext_key_end(&e->ext)->data;
+
+		if (nft_set_ext_exists(&e->ext, NFT_SET_EXT_KEY_END))
+			match_end = (const u8 *)nft_set_ext_key_end(&e->ext)->data;
+		else
+			match_end = data;
 
 		start = first_rule;
 		rules_fx = rules_f0;
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index bc317b3eac12..0320e11eb248 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -404,56 +404,6 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 	return 0;
 }
 
-static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
-			     struct cls_bpf_prog *prog, unsigned long base,
-			     struct nlattr **tb, struct nlattr *est, u32 flags,
-			     struct netlink_ext_ack *extack)
-{
-	bool is_bpf, is_ebpf, have_exts = false;
-	u32 gen_flags = 0;
-	int ret;
-
-	is_bpf = tb[TCA_BPF_OPS_LEN] && tb[TCA_BPF_OPS];
-	is_ebpf = tb[TCA_BPF_FD];
-	if ((!is_bpf && !is_ebpf) || (is_bpf && is_ebpf))
-		return -EINVAL;
-
-	ret = tcf_exts_validate(net, tp, tb, est, &prog->exts, flags,
-				extack);
-	if (ret < 0)
-		return ret;
-
-	if (tb[TCA_BPF_FLAGS]) {
-		u32 bpf_flags = nla_get_u32(tb[TCA_BPF_FLAGS]);
-
-		if (bpf_flags & ~TCA_BPF_FLAG_ACT_DIRECT)
-			return -EINVAL;
-
-		have_exts = bpf_flags & TCA_BPF_FLAG_ACT_DIRECT;
-	}
-	if (tb[TCA_BPF_FLAGS_GEN]) {
-		gen_flags = nla_get_u32(tb[TCA_BPF_FLAGS_GEN]);
-		if (gen_flags & ~CLS_BPF_SUPPORTED_GEN_FLAGS ||
-		    !tc_flags_valid(gen_flags))
-			return -EINVAL;
-	}
-
-	prog->exts_integrated = have_exts;
-	prog->gen_flags = gen_flags;
-
-	ret = is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
-		       cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
-	if (ret < 0)
-		return ret;
-
-	if (tb[TCA_BPF_CLASSID]) {
-		prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
-		tcf_bind_filter(tp, &prog->res, base);
-	}
-
-	return 0;
-}
-
 static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 			  struct tcf_proto *tp, unsigned long base,
 			  u32 handle, struct nlattr **tca,
@@ -461,9 +411,12 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 			  struct netlink_ext_ack *extack)
 {
 	struct cls_bpf_head *head = rtnl_dereference(tp->root);
+	bool is_bpf, is_ebpf, have_exts = false;
 	struct cls_bpf_prog *oldprog = *arg;
 	struct nlattr *tb[TCA_BPF_MAX + 1];
+	bool bound_to_filter = false;
 	struct cls_bpf_prog *prog;
+	u32 gen_flags = 0;
 	int ret;
 
 	if (tca[TCA_OPTIONS] == NULL)
@@ -502,11 +455,51 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 		goto errout;
 	prog->handle = handle;
 
-	ret = cls_bpf_set_parms(net, tp, prog, base, tb, tca[TCA_RATE], flags,
-				extack);
+	is_bpf = tb[TCA_BPF_OPS_LEN] && tb[TCA_BPF_OPS];
+	is_ebpf = tb[TCA_BPF_FD];
+	if ((!is_bpf && !is_ebpf) || (is_bpf && is_ebpf)) {
+		ret = -EINVAL;
+		goto errout_idr;
+	}
+
+	ret = tcf_exts_validate(net, tp, tb, tca[TCA_RATE], &prog->exts,
+				flags, extack);
+	if (ret < 0)
+		goto errout_idr;
+
+	if (tb[TCA_BPF_FLAGS]) {
+		u32 bpf_flags = nla_get_u32(tb[TCA_BPF_FLAGS]);
+
+		if (bpf_flags & ~TCA_BPF_FLAG_ACT_DIRECT) {
+			ret = -EINVAL;
+			goto errout_idr;
+		}
+
+		have_exts = bpf_flags & TCA_BPF_FLAG_ACT_DIRECT;
+	}
+	if (tb[TCA_BPF_FLAGS_GEN]) {
+		gen_flags = nla_get_u32(tb[TCA_BPF_FLAGS_GEN]);
+		if (gen_flags & ~CLS_BPF_SUPPORTED_GEN_FLAGS ||
+		    !tc_flags_valid(gen_flags)) {
+			ret = -EINVAL;
+			goto errout_idr;
+		}
+	}
+
+	prog->exts_integrated = have_exts;
+	prog->gen_flags = gen_flags;
+
+	ret = is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
+		cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
 	if (ret < 0)
 		goto errout_idr;
 
+	if (tb[TCA_BPF_CLASSID]) {
+		prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
+		tcf_bind_filter(tp, &prog->res, base);
+		bound_to_filter = true;
+	}
+
 	ret = cls_bpf_offload(tp, prog, oldprog, extack);
 	if (ret)
 		goto errout_parms;
@@ -528,6 +521,8 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	return 0;
 
 errout_parms:
+	if (bound_to_filter)
+		tcf_unbind_filter(tp, &prog->res);
 	cls_bpf_free_parms(prog);
 errout_idr:
 	if (!oldprog)
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index 39a5d9c170de..43f8df584741 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -157,26 +157,6 @@ static const struct nla_policy mall_policy[TCA_MATCHALL_MAX + 1] = {
 	[TCA_MATCHALL_FLAGS]		= { .type = NLA_U32 },
 };
 
-static int mall_set_parms(struct net *net, struct tcf_proto *tp,
-			  struct cls_mall_head *head,
-			  unsigned long base, struct nlattr **tb,
-			  struct nlattr *est, u32 flags, u32 fl_flags,
-			  struct netlink_ext_ack *extack)
-{
-	int err;
-
-	err = tcf_exts_validate_ex(net, tp, tb, est, &head->exts, flags,
-				   fl_flags, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_MATCHALL_CLASSID]) {
-		head->res.classid = nla_get_u32(tb[TCA_MATCHALL_CLASSID]);
-		tcf_bind_filter(tp, &head->res, base);
-	}
-	return 0;
-}
-
 static int mall_change(struct net *net, struct sk_buff *in_skb,
 		       struct tcf_proto *tp, unsigned long base,
 		       u32 handle, struct nlattr **tca,
@@ -185,6 +165,7 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 {
 	struct cls_mall_head *head = rtnl_dereference(tp->root);
 	struct nlattr *tb[TCA_MATCHALL_MAX + 1];
+	bool bound_to_filter = false;
 	struct cls_mall_head *new;
 	u32 userflags = 0;
 	int err;
@@ -224,11 +205,17 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 		goto err_alloc_percpu;
 	}
 
-	err = mall_set_parms(net, tp, new, base, tb, tca[TCA_RATE],
-			     flags, new->flags, extack);
-	if (err)
+	err = tcf_exts_validate_ex(net, tp, tb, tca[TCA_RATE],
+				   &new->exts, flags, new->flags, extack);
+	if (err < 0)
 		goto err_set_parms;
 
+	if (tb[TCA_MATCHALL_CLASSID]) {
+		new->res.classid = nla_get_u32(tb[TCA_MATCHALL_CLASSID]);
+		tcf_bind_filter(tp, &new->res, base);
+		bound_to_filter = true;
+	}
+
 	if (!tc_skip_hw(new->flags)) {
 		err = mall_replace_hw_filter(tp, new, (unsigned long)new,
 					     extack);
@@ -244,6 +231,8 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	return 0;
 
 err_replace_hw_filter:
+	if (bound_to_filter)
+		tcf_unbind_filter(tp, &new->res);
 err_set_parms:
 	free_percpu(new->pf);
 err_alloc_percpu:
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index a3477537c102..1280736a7b92 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -710,8 +710,23 @@ static const struct nla_policy u32_policy[TCA_U32_MAX + 1] = {
 	[TCA_U32_FLAGS]		= { .type = NLA_U32 },
 };
 
+static void u32_unbind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			      struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID])
+		tcf_unbind_filter(tp, &n->res);
+}
+
+static void u32_bind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			    unsigned long base, struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID]) {
+		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
+		tcf_bind_filter(tp, &n->res, base);
+	}
+}
+
 static int u32_set_parms(struct net *net, struct tcf_proto *tp,
-			 unsigned long base,
 			 struct tc_u_knode *n, struct nlattr **tb,
 			 struct nlattr *est, u32 flags, u32 fl_flags,
 			 struct netlink_ext_ack *extack)
@@ -758,10 +773,6 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 		if (ht_old)
 			ht_old->refcnt--;
 	}
-	if (tb[TCA_U32_CLASSID]) {
-		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
-		tcf_bind_filter(tp, &n->res, base);
-	}
 
 	if (ifindex >= 0)
 		n->ifindex = ifindex;
@@ -901,17 +912,27 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!new)
 			return -ENOMEM;
 
-		err = u32_set_parms(net, tp, base, new, tb,
-				    tca[TCA_RATE], flags, new->flags,
-				    extack);
+		err = u32_set_parms(net, tp, new, tb, tca[TCA_RATE],
+				    flags, new->flags, extack);
 
 		if (err) {
 			__u32_destroy_key(new);
 			return err;
 		}
 
+		u32_bind_filter(tp, new, base, tb);
+
 		err = u32_replace_hw_knode(tp, new, flags, extack);
 		if (err) {
+			u32_unbind_filter(tp, new, tb);
+
+			if (tb[TCA_U32_LINK]) {
+				struct tc_u_hnode *ht_old;
+
+				ht_old = rtnl_dereference(n->ht_down);
+				if (ht_old)
+					ht_old->refcnt++;
+			}
 			__u32_destroy_key(new);
 			return err;
 		}
@@ -1072,15 +1093,18 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	}
 #endif
 
-	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE],
+	err = u32_set_parms(net, tp, n, tb, tca[TCA_RATE],
 			    flags, n->flags, extack);
+
+	u32_bind_filter(tp, n, base, tb);
+
 	if (err == 0) {
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;
 
 		err = u32_replace_hw_knode(tp, n, flags, extack);
 		if (err)
-			goto errhw;
+			goto errunbind;
 
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
@@ -1098,7 +1122,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return 0;
 	}
 
-errhw:
+errunbind:
+	u32_unbind_filter(tp, n, tb);
+
 #ifdef CONFIG_CLS_U32_MARK
 	free_percpu(n->pcpu_success);
 #endif
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index fe8765c4075d..8a4b85f96a13 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -799,6 +799,12 @@ static int ioctl_standard_iw_point(struct iw_point *iwp, unsigned int cmd,
 		}
 	}
 
+	/* Sanity-check to ensure we never end up _allocating_ zero
+	 * bytes of data for extra.
+	 */
+	if (extra_size <= 0)
+		return -EFAULT;
+
 	/* kzalloc() ensures NULL-termination for essid_compat. */
 	extra = kzalloc(extra_size, GFP_KERNEL);
 	if (!extra)
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03fa07ad45d9..80aab2aa7224 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,8 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ * Usage: kallsyms [--all-symbols] [--absolute-percpu]
+ *                         [--base-relative] [--lto-clang] in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -49,6 +50,7 @@ _Static_assert(
 struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
+	unsigned int seq;
 	unsigned int start_pos;
 	unsigned int percpu_absolute;
 	unsigned char sym[];
@@ -77,6 +79,7 @@ static unsigned int table_size, table_cnt;
 static int all_symbols;
 static int absolute_percpu;
 static int base_relative;
+static int lto_clang;
 
 static int token_profit[0x10000];
 
@@ -88,7 +91,7 @@ static unsigned char best_table_len[256];
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
-			"[--base-relative] in.map > out.S\n");
+			"[--base-relative] [--lto-clang] in.map > out.S\n");
 	exit(1);
 }
 
@@ -116,6 +119,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_markers",
 		"kallsyms_token_table",
 		"kallsyms_token_index",
+		"kallsyms_seqs_of_names",
 		/* Exclude linker generated symbols which vary between passes */
 		"_SDA_BASE_",		/* ppc */
 		"_SDA2_BASE_",		/* ppc */
@@ -410,6 +414,65 @@ static int symbol_absolute(const struct sym_entry *s)
 	return s->percpu_absolute;
 }
 
+static char * s_name(char *buf)
+{
+	/* Skip the symbol type */
+	return buf + 1;
+}
+
+static void cleanup_symbol_name(char *s)
+{
+	char *p;
+
+	if (!lto_clang)
+		return;
+
+	/*
+	 * ASCII[.]   = 2e
+	 * ASCII[0-9] = 30,39
+	 * ASCII[A-Z] = 41,5a
+	 * ASCII[_]   = 5f
+	 * ASCII[a-z] = 61,7a
+	 *
+	 * As above, replacing the first '.' in ".llvm." with '\0' does not
+	 * affect the main sorting, but it helps us with subsorting.
+	 */
+	p = strstr(s, ".llvm.");
+	if (p)
+		*p = '\0';
+}
+
+static int compare_names(const void *a, const void *b)
+{
+	int ret;
+	char sa_namebuf[KSYM_NAME_LEN];
+	char sb_namebuf[KSYM_NAME_LEN];
+	const struct sym_entry *sa = *(const struct sym_entry **)a;
+	const struct sym_entry *sb = *(const struct sym_entry **)b;
+
+	expand_symbol(sa->sym, sa->len, sa_namebuf);
+	expand_symbol(sb->sym, sb->len, sb_namebuf);
+	cleanup_symbol_name(s_name(sa_namebuf));
+	cleanup_symbol_name(s_name(sb_namebuf));
+	ret = strcmp(s_name(sa_namebuf), s_name(sb_namebuf));
+	if (!ret) {
+		if (sa->addr > sb->addr)
+			return 1;
+		else if (sa->addr < sb->addr)
+			return -1;
+
+		/* keep old order */
+		return (int)(sa->seq - sb->seq);
+	}
+
+	return ret;
+}
+
+static void sort_symbols_by_name(void)
+{
+	qsort(table, table_cnt, sizeof(table[0]), compare_names);
+}
+
 static void write_src(void)
 {
 	unsigned int i, k, off;
@@ -495,6 +558,7 @@ static void write_src(void)
 	for (i = 0; i < table_cnt; i++) {
 		if ((i & 0xFF) == 0)
 			markers[i >> 8] = off;
+		table[i]->seq = i;
 
 		/* There cannot be any symbol of length zero. */
 		if (table[i]->len == 0) {
@@ -535,6 +599,12 @@ static void write_src(void)
 
 	free(markers);
 
+	sort_symbols_by_name();
+	output_label("kallsyms_seqs_of_names");
+	for (i = 0; i < table_cnt; i++)
+		printf("\t.long\t%u\n", table[i]->seq);
+	printf("\n");
+
 	output_label("kallsyms_token_table");
 	off = 0;
 	for (i = 0; i < 256; i++) {
@@ -818,6 +888,7 @@ int main(int argc, char **argv)
 			{"all-symbols",     no_argument, &all_symbols,     1},
 			{"absolute-percpu", no_argument, &absolute_percpu, 1},
 			{"base-relative",   no_argument, &base_relative,   1},
+			{"lto-clang",       no_argument, &lto_clang,       1},
 			{},
 		};
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 918470d768e9..32e573943cf0 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -156,6 +156,10 @@ kallsyms()
 		kallsymopt="${kallsymopt} --base-relative"
 	fi
 
+	if is_enabled CONFIG_LTO_CLANG; then
+		kallsymopt="${kallsymopt} --lto-clang"
+	fi
+
 	info KSYMS ${2}
 	scripts/kallsyms ${kallsymopt} ${1} > ${2}
 }
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 07a0ef2baacd..a7673ad86d18 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -401,17 +401,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	set_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags);
 
 	if (dest_keyring) {
-		ret = __key_link_lock(dest_keyring, &ctx->index_key);
+		ret = __key_link_lock(dest_keyring, &key->index_key);
 		if (ret < 0)
 			goto link_lock_failed;
-		ret = __key_link_begin(dest_keyring, &ctx->index_key, &edit);
-		if (ret < 0)
-			goto link_prealloc_failed;
 	}
 
-	/* attach the key to the destination keyring under lock, but we do need
+	/*
+	 * Attach the key to the destination keyring under lock, but we do need
 	 * to do another check just in case someone beat us to it whilst we
-	 * waited for locks */
+	 * waited for locks.
+	 *
+	 * The caller might specify a comparison function which looks for keys
+	 * that do not exactly match but are still equivalent from the caller's
+	 * perspective. The __key_link_begin() operation must be done only after
+	 * an actual key is determined.
+	 */
 	mutex_lock(&key_construction_mutex);
 
 	rcu_read_lock();
@@ -420,12 +424,16 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	if (!IS_ERR(key_ref))
 		goto key_already_present;
 
-	if (dest_keyring)
+	if (dest_keyring) {
+		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		if (ret < 0)
+			goto link_alloc_failed;
 		__key_link(dest_keyring, key, &edit);
+	}
 
 	mutex_unlock(&key_construction_mutex);
 	if (dest_keyring)
-		__key_link_end(dest_keyring, &ctx->index_key, edit);
+		__key_link_end(dest_keyring, &key->index_key, edit);
 	mutex_unlock(&user->cons_lock);
 	*_key = key;
 	kleave(" = 0 [%d]", key_serial(key));
@@ -438,10 +446,13 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	mutex_unlock(&key_construction_mutex);
 	key = key_ref_to_ptr(key_ref);
 	if (dest_keyring) {
+		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		if (ret < 0)
+			goto link_alloc_failed_unlocked;
 		ret = __key_link_check_live_key(dest_keyring, key);
 		if (ret == 0)
 			__key_link(dest_keyring, key, &edit);
-		__key_link_end(dest_keyring, &ctx->index_key, edit);
+		__key_link_end(dest_keyring, &key->index_key, edit);
 		if (ret < 0)
 			goto link_check_failed;
 	}
@@ -456,8 +467,10 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	kleave(" = %d [linkcheck]", ret);
 	return ret;
 
-link_prealloc_failed:
-	__key_link_end(dest_keyring, &ctx->index_key, edit);
+link_alloc_failed:
+	mutex_unlock(&key_construction_mutex);
+link_alloc_failed_unlocked:
+	__key_link_end(dest_keyring, &key->index_key, edit);
 link_lock_failed:
 	mutex_unlock(&user->cons_lock);
 	key_put(key);
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 2b2c8eb258d5..bc700f85f80b 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -186,7 +186,7 @@ int tpm2_key_priv(void *context, size_t hdrlen,
 }
 
 /**
- * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
+ * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
  * @buf: an allocated tpm_buf instance
  * @session_handle: session handle
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 6cf7c8b1de47..4ca65f425f39 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1563,14 +1563,8 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	gpr += 2;
 
 	/* Master volume (will be renamed later) */
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS));
+	for (z = 0; z < 8; z++)
+		A_OP(icode, &ptr, iMAC0, A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS));
 	snd_emu10k1_init_mono_control(&controls[nctl++], "Wave Master Playback Volume", gpr, 0);
 	gpr += 2;
 
@@ -1654,102 +1648,14 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 			dev_dbg(emu->card->dev, "emufx.c: gpr=0x%x, tmp=0x%x\n",
 			       gpr, tmp);
 			*/
-			/* For the EMU1010: How to get 32bit values from the DSP. High 16bits into L, low 16bits into R. */
-			/* A_P16VIN(0) is delayed by one sample,
-			 * so all other A_P16VIN channels will need to also be delayed
-			 */
-			/* Left ADC in. 1 of 2 */
 			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_P16VIN(0x0), A_FXBUS2(0) );
-			/* Right ADC in 1 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			/* Delaying by one sample: instead of copying the input
-			 * value A_P16VIN to output A_FXBUS2 as in the first channel,
-			 * we use an auxiliary register, delaying the value by one
-			 * sample
-			 */
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(2) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x1), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(4) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x2), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(6) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x3), A_C_00000000, A_C_00000000);
-			/* For 96kHz mode */
-			/* Left ADC in. 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0x8) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x4), A_C_00000000, A_C_00000000);
-			/* Right ADC in 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xa) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x5), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xc) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x6), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xe) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x7), A_C_00000000, A_C_00000000);
-			/* Pavel Hofman - we still have voices, A_FXBUS2s, and
-			 * A_P16VINs available -
-			 * let's add 8 more capture channels - total of 16
-			 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x10));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x8),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x12));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x9),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x14));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xa),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x16));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xb),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x18));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xc),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1a));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xd),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1c));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xe),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1e));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xf),
-			     A_C_00000000, A_C_00000000);
+			/* A_P16VIN(0) is delayed by one sample, so all other A_P16VIN channels
+			 * will need to also be delayed; we use an auxiliary register for that. */
+			for (z = 1; z < 0x10; z++) {
+				snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr), A_FXBUS2(z * 2) );
+				A_OP(icode, &ptr, iACC3, A_GPR(gpr), A_P16VIN(z), A_C_00000000, A_C_00000000);
+				gpr_map[gpr++] = 0x00000000;
+			}
 		}
 
 #if 0
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 72fa1509cc4b..cb34a62075b1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -122,6 +122,7 @@ struct alc_spec {
 	unsigned int ultra_low_power:1;
 	unsigned int has_hs_key:1;
 	unsigned int no_internal_mic_pin:1;
+	unsigned int en_3kpull_low:1;
 
 	/* for PLL fix */
 	hda_nid_t pll_nid;
@@ -3622,6 +3623,7 @@ static void alc256_shutup(struct hda_codec *codec)
 	if (!hp_pin)
 		hp_pin = 0x21;
 
+	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x1); /* Low power */
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
 	if (hp_pin_sense)
@@ -3638,8 +3640,7 @@ static void alc256_shutup(struct hda_codec *codec)
 	/* If disable 3k pulldown control for alc257, the Mic detection will not work correctly
 	 * when booting with headset plugged. So skip setting it for the codec alc257
 	 */
-	if (codec->core.vendor_id != 0x10ec0236 &&
-	    codec->core.vendor_id != 0x10ec0257)
+	if (spec->en_3kpull_low)
 		alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
 
 	if (!spec->no_shutup_pins)
@@ -4623,6 +4624,21 @@ static void alc236_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
 	}
 }
 
+static void alc236_fixup_hp_mute_led_coefbit2(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x07;
+		spec->mute_led_coef.mask = 1;
+		spec->mute_led_coef.on = 1;
+		spec->mute_led_coef.off = 0;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -7133,6 +7149,7 @@ enum {
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED,
+	ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
@@ -7203,6 +7220,7 @@ enum {
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
+	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -8556,6 +8574,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360_mute_led,
 	},
+	[ALC236_FIXUP_HP_MUTE_LED_COEFBIT2] = {
+	    .type = HDA_FIXUP_FUNC,
+	    .v.func = alc236_fixup_hp_mute_led_coefbit2,
+	},
 	[ALC236_FIXUP_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_gpio_led,
@@ -9069,8 +9091,6 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC287_FIXUP_CS35L41_I2C_2] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_i2c_two,
-		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
 	[ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9207,6 +9227,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 	},
+	[ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9440,6 +9466,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
+	SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
@@ -9644,6 +9671,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x5157, "Clevo W517GU1", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x51a1, "Clevo NS50MU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x51b1, "Clevo NS50AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x51b3, "Clevo NS70AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5630, "Clevo NP50RNJS", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70a1, "Clevo NB70T[HJK]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70b3, "Clevo NK70SB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -9727,14 +9755,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x22be, "Thinkpad X1 Carbon 8th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c1, "Thinkpad P1 Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c2, "Thinkpad X1 Extreme Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
-	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
@@ -10599,6 +10627,8 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
+		if (codec->bus->pci->vendor == PCI_VENDOR_ID_AMD)
+			spec->en_3kpull_low = true;
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 5f2119f42271..12a176a50fd6 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -173,7 +173,7 @@ int snd_amd_acp_find_config(struct pci_dev *pci);
 
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
-	u64 byte_count, low = 0, high = 0;
+	u64 byte_count = 0, low = 0, high = 0;
 
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		switch (dai_id) {
@@ -191,7 +191,7 @@ static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int
 			break;
 		default:
 			dev_err(adata->dev, "Invalid dai id %x\n", dai_id);
-			return -EINVAL;
+			goto POINTER_RETURN_BYTES;
 		}
 	} else {
 		switch (dai_id) {
@@ -213,12 +213,13 @@ static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int
 			break;
 		default:
 			dev_err(adata->dev, "Invalid dai id %x\n", dai_id);
-			return -EINVAL;
+			goto POINTER_RETURN_BYTES;
 		}
 	}
 	/* Get 64 bit value from two 32 bit registers */
 	byte_count = (high << 32) | low;
 
+POINTER_RETURN_BYTES:
 	return byte_count;
 }
 
diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 85238339fbca..b2085ff4b322 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -19,6 +19,12 @@ static struct i2c_device_id cs42l51_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
 
+const struct of_device_id cs42l51_of_match[] = {
+	{ .compatible = "cirrus,cs42l51", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs42l51_of_match);
+
 static int cs42l51_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_config config;
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index e88d9ff95cdf..4b832d52f643 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -826,13 +826,6 @@ int __maybe_unused cs42l51_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cs42l51_resume);
 
-const struct of_device_id cs42l51_of_match[] = {
-	{ .compatible = "cirrus,cs42l51", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, cs42l51_of_match);
-EXPORT_SYMBOL_GPL(cs42l51_of_match);
-
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index a79343e8a54e..125703ede113 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -16,7 +16,6 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap);
 void cs42l51_remove(struct device *dev);
 int __maybe_unused cs42l51_suspend(struct device *dev);
 int __maybe_unused cs42l51_resume(struct device *dev);
-extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0f8e6dd214b0..a7071d0a2562 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2562,9 +2562,10 @@ static void rt5640_enable_jack_detect(struct snd_soc_component *component,
 	if (jack_data && jack_data->use_platform_clock)
 		rt5640->use_platform_clock = jack_data->use_platform_clock;
 
-	ret = request_irq(rt5640->irq, rt5640_irq,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-			  "rt5640", rt5640);
+	ret = devm_request_threaded_irq(component->dev, rt5640->irq,
+					NULL, rt5640_irq,
+					IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"rt5640", rt5640);
 	if (ret) {
 		dev_warn(component->dev, "Failed to reguest IRQ %d: %d\n", rt5640->irq, ret);
 		rt5640_disable_jack_detect(component);
@@ -2617,8 +2618,9 @@ static void rt5640_enable_hda_jack_detect(
 
 	rt5640->jack = jack;
 
-	ret = request_irq(rt5640->irq, rt5640_irq,
-			  IRQF_TRIGGER_RISING | IRQF_ONESHOT, "rt5640", rt5640);
+	ret = devm_request_threaded_irq(component->dev, rt5640->irq,
+					NULL, rt5640_irq, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"rt5640", rt5640);
 	if (ret) {
 		dev_warn(component->dev, "Failed to reguest IRQ %d: %d\n", rt5640->irq, ret);
 		rt5640->irq = -ENXIO;
diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 1911750f7445..5da1934527f3 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1454,7 +1454,7 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 		return ERR_PTR(-EINVAL);
 	}
 
-	mbhc = devm_kzalloc(dev, sizeof(*mbhc), GFP_KERNEL);
+	mbhc = kzalloc(sizeof(*mbhc), GFP_KERNEL);
 	if (!mbhc)
 		return ERR_PTR(-ENOMEM);
 
@@ -1474,61 +1474,76 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 
 	INIT_WORK(&mbhc->correct_plug_swch, wcd_correct_swch_plug);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_sw_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_sw_intr, NULL,
 					wcd_mbhc_mech_plug_detect_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"mbhc sw intr", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_mbhc;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_press_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_press_intr, NULL,
 					wcd_mbhc_btn_press_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Button Press detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_sw_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_release_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_release_intr, NULL,
 					wcd_mbhc_btn_release_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Button Release detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_btn_press_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
 					wcd_mbhc_adc_hs_ins_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Elect Insert", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_btn_release_intr;
 
 	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_ins_intr);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
 					wcd_mbhc_adc_hs_rem_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Elect Remove", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hs_ins_intr;
 
 	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_rem_intr);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_left_ocp, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->hph_left_ocp, NULL,
 					wcd_mbhc_hphl_ocp_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"HPH_L OCP detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hs_rem_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_right_ocp, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->hph_right_ocp, NULL,
 					wcd_mbhc_hphr_ocp_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"HPH_R OCP detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hph_left_ocp;
 
 	return mbhc;
-err:
+
+err_free_hph_left_ocp:
+	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
+err_free_hs_rem_intr:
+	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
+err_free_hs_ins_intr:
+	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
+err_free_btn_release_intr:
+	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
+err_free_btn_press_intr:
+	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
+err_free_sw_intr:
+	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
+err_free_mbhc:
+	kfree(mbhc);
+
 	dev_err(dev, "Failed to request mbhc interrupts %d\n", ret);
 
 	return ERR_PTR(ret);
@@ -1537,9 +1552,19 @@ EXPORT_SYMBOL(wcd_mbhc_init);
 
 void wcd_mbhc_deinit(struct wcd_mbhc *mbhc)
 {
+	free_irq(mbhc->intr_ids->hph_right_ocp, mbhc);
+	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
+
 	mutex_lock(&mbhc->lock);
 	wcd_cancel_hs_detect_plug(mbhc,	&mbhc->correct_plug_swch);
 	mutex_unlock(&mbhc->lock);
+
+	kfree(mbhc);
 }
 EXPORT_SYMBOL(wcd_mbhc_deinit);
 
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 28175c746b9a..0b5999c819db 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3044,6 +3044,17 @@ static int wcd934x_mbhc_init(struct snd_soc_component *component)
 
 	return 0;
 }
+
+static void wcd934x_mbhc_deinit(struct snd_soc_component *component)
+{
+	struct wcd934x_codec *wcd = snd_soc_component_get_drvdata(component);
+
+	if (!wcd->mbhc)
+		return;
+
+	wcd_mbhc_deinit(wcd->mbhc);
+}
+
 static int wcd934x_comp_probe(struct snd_soc_component *component)
 {
 	struct wcd934x_codec *wcd = dev_get_drvdata(component->dev);
@@ -3077,6 +3088,7 @@ static void wcd934x_comp_remove(struct snd_soc_component *comp)
 {
 	struct wcd934x_codec *wcd = dev_get_drvdata(comp->dev);
 
+	wcd934x_mbhc_deinit(comp);
 	wcd_clsh_ctrl_free(wcd->clsh_ctrl);
 }
 
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 1d801a7b1469..2316481c2541 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -210,7 +210,7 @@ struct wcd938x_priv {
 };
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
-static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(line_gain, 600, -3000);
+static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, -3000);
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(analog_gain, 0, 3000);
 
 struct wcd938x_mbhc_zdet_param {
@@ -2165,8 +2165,8 @@ static inline void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
 	else if (x1 < minCode_param[noff])
 		*zdet = WCD938X_ZDET_FLOATING_IMPEDANCE;
 
-	pr_err("%s: d1=%d, c1=%d, x1=0x%x, z_val=%d(milliOhm)\n",
-		__func__, d1, c1, x1, *zdet);
+	pr_debug("%s: d1=%d, c1=%d, x1=0x%x, z_val=%d (milliohm)\n",
+		 __func__, d1, c1, x1, *zdet);
 ramp_down:
 	i = 0;
 	while (x1) {
@@ -2625,6 +2625,8 @@ static int wcd938x_mbhc_init(struct snd_soc_component *component)
 						     WCD938X_IRQ_HPHR_OCP_INT);
 
 	wcd938x->wcd_mbhc = wcd_mbhc_init(component, &mbhc_cb, intr_ids, wcd_mbhc_fields, true);
+	if (IS_ERR(wcd938x->wcd_mbhc))
+		return PTR_ERR(wcd938x->wcd_mbhc);
 
 	snd_soc_add_component_controls(component, impedance_detect_controls,
 				       ARRAY_SIZE(impedance_detect_controls));
@@ -2633,6 +2635,14 @@ static int wcd938x_mbhc_init(struct snd_soc_component *component)
 
 	return 0;
 }
+
+static void wcd938x_mbhc_deinit(struct snd_soc_component *component)
+{
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd_mbhc_deinit(wcd938x->wcd_mbhc);
+}
+
 /* END MBHC */
 
 static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
@@ -2652,8 +2662,8 @@ static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
 		       wcd938x_get_swr_port, wcd938x_set_swr_port),
 	SOC_SINGLE_EXT("DSD_R Switch", WCD938X_DSD_R, 0, 1, 0,
 		       wcd938x_get_swr_port, wcd938x_set_swr_port),
-	SOC_SINGLE_TLV("HPHL Volume", WCD938X_HPH_L_EN, 0, 0x18, 0, line_gain),
-	SOC_SINGLE_TLV("HPHR Volume", WCD938X_HPH_R_EN, 0, 0x18, 0, line_gain),
+	SOC_SINGLE_TLV("HPHL Volume", WCD938X_HPH_L_EN, 0, 0x18, 1, line_gain),
+	SOC_SINGLE_TLV("HPHR Volume", WCD938X_HPH_R_EN, 0, 0x18, 1, line_gain),
 	WCD938X_EAR_PA_GAIN_TLV("EAR_PA Volume", WCD938X_ANA_EAR_COMPANDER_CTL,
 				2, 0x10, 0, ear_pa_gain),
 	SOC_SINGLE_EXT("ADC1 Switch", WCD938X_ADC1, 1, 1, 0,
@@ -3080,16 +3090,33 @@ static int wcd938x_irq_init(struct wcd938x_priv *wcd, struct device *dev)
 static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 {
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	struct sdw_slave *tx_sdw_dev = wcd938x->tx_sdw_dev;
 	struct device *dev = component->dev;
+	unsigned long time_left;
 	int ret, i;
 
+	time_left = wait_for_completion_timeout(&tx_sdw_dev->initialization_complete,
+						msecs_to_jiffies(2000));
+	if (!time_left) {
+		dev_err(dev, "soundwire device init timeout\n");
+		return -ETIMEDOUT;
+	}
+
 	snd_soc_component_init_regmap(component, wcd938x->regmap);
 
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
 	wcd938x->variant = snd_soc_component_read_field(component,
 						 WCD938X_DIGITAL_EFUSE_REG_0,
 						 WCD938X_ID_MASK);
 
 	wcd938x->clsh_info = wcd_clsh_ctrl_alloc(component, WCD938X);
+	if (IS_ERR(wcd938x->clsh_info)) {
+		pm_runtime_put(dev);
+		return PTR_ERR(wcd938x->clsh_info);
+	}
 
 	wcd938x_io_init(wcd938x);
 	/* Set all interrupts as edge triggered */
@@ -3098,6 +3125,8 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			     (WCD938X_DIGITAL_INTR_LEVEL_0 + i), 0);
 	}
 
+	pm_runtime_put(dev);
+
 	wcd938x->hphr_pdm_wd_int = regmap_irq_get_virq(wcd938x->irq_chip,
 						       WCD938X_IRQ_HPHR_PDM_WD_INT);
 	wcd938x->hphl_pdm_wd_int = regmap_irq_get_virq(wcd938x->irq_chip,
@@ -3109,20 +3138,26 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	ret = request_threaded_irq(wcd938x->hphr_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "HPHR PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request HPHR WD interrupt (%d)\n", ret);
+		goto err_free_clsh_ctrl;
+	}
 
 	ret = request_threaded_irq(wcd938x->hphl_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "HPHL PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request HPHL WD interrupt (%d)\n", ret);
+		goto err_free_hphr_pdm_wd_int;
+	}
 
 	ret = request_threaded_irq(wcd938x->aux_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "AUX PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request Aux WD interrupt (%d)\n", ret);
+		goto err_free_hphl_pdm_wd_int;
+	}
 
 	/* Disable watchdog interrupt for HPH and AUX */
 	disable_irq_nosync(wcd938x->hphr_pdm_wd_int);
@@ -3137,7 +3172,7 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
 				__func__, wcd938x->variant);
-			goto err;
+			goto err_free_aux_pdm_wd_int;
 		}
 		break;
 	case WCD9385:
@@ -3147,7 +3182,7 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
 				__func__, wcd938x->variant);
-			goto err;
+			goto err_free_aux_pdm_wd_int;
 		}
 		break;
 	default:
@@ -3155,12 +3190,38 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	}
 
 	ret = wcd938x_mbhc_init(component);
-	if (ret)
+	if (ret) {
 		dev_err(component->dev,  "mbhc initialization failed\n");
-err:
+		goto err_free_aux_pdm_wd_int;
+	}
+
+	return 0;
+
+err_free_aux_pdm_wd_int:
+	free_irq(wcd938x->aux_pdm_wd_int, wcd938x);
+err_free_hphl_pdm_wd_int:
+	free_irq(wcd938x->hphl_pdm_wd_int, wcd938x);
+err_free_hphr_pdm_wd_int:
+	free_irq(wcd938x->hphr_pdm_wd_int, wcd938x);
+err_free_clsh_ctrl:
+	wcd_clsh_ctrl_free(wcd938x->clsh_info);
+
 	return ret;
 }
 
+static void wcd938x_soc_codec_remove(struct snd_soc_component *component)
+{
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd938x_mbhc_deinit(component);
+
+	free_irq(wcd938x->aux_pdm_wd_int, wcd938x);
+	free_irq(wcd938x->hphl_pdm_wd_int, wcd938x);
+	free_irq(wcd938x->hphr_pdm_wd_int, wcd938x);
+
+	wcd_clsh_ctrl_free(wcd938x->clsh_info);
+}
+
 static int wcd938x_codec_set_jack(struct snd_soc_component *comp,
 				  struct snd_soc_jack *jack, void *data)
 {
@@ -3177,6 +3238,7 @@ static int wcd938x_codec_set_jack(struct snd_soc_component *comp,
 static const struct snd_soc_component_driver soc_codec_dev_wcd938x = {
 	.name = "wcd938x_codec",
 	.probe = wcd938x_soc_codec_probe,
+	.remove = wcd938x_soc_codec_remove,
 	.controls = wcd938x_snd_controls,
 	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
 	.dapm_widgets = wcd938x_dapm_widgets,
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index b33104715c7b..b7552b0df7c3 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -507,12 +507,6 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 				   savediv / 2 - 1);
 	}
 
-	if (sai->soc_data->max_register >= FSL_SAI_MCTL) {
-		/* SAI is in master mode at this point, so enable MCLK */
-		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
-				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
-	}
-
 	return 0;
 }
 
@@ -719,7 +713,7 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	u32 xcsr, count = 100;
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
-			   FSL_SAI_CSR_TERE, 0);
+			   FSL_SAI_CSR_TERE | FSL_SAI_CSR_BCE, 0);
 
 	/* TERE will remain set till the end of current frame */
 	do {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index c5423f81e456..caad5b0ac4ff 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -91,6 +91,7 @@
 /* SAI Transmit/Receive Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
 #define FSL_SAI_CSR_SE		BIT(30)
+#define FSL_SAI_CSR_BCE		BIT(28)
 #define FSL_SAI_CSR_FR		BIT(25)
 #define FSL_SAI_CSR_SR		BIT(24)
 #define FSL_SAI_CSR_xF_SHIFT	16
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 794019286c70..16acdf3a99e1 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -515,6 +515,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 
 	switch (hdr->opcode) {
 	case DATA_CMD_RSP_WR_SH_MEM_EP_DATA_BUFFER_DONE_V2:
+		if (!graph->ar_graph)
+			break;
 		client_event = APM_CLIENT_EVENT_DATA_WRITE_DONE;
 		mutex_lock(&graph->lock);
 		token = hdr->token & APM_WRITE_TOKEN_MASK;
@@ -548,6 +550,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		wake_up(&graph->cmd_wait);
 		break;
 	case DATA_CMD_RSP_RD_SH_MEM_EP_DATA_BUFFER_V2:
+		if (!graph->ar_graph)
+			break;
 		client_event = APM_CLIENT_EVENT_DATA_READ_DONE;
 		mutex_lock(&graph->lock);
 		rd_done = data->payload;
@@ -650,8 +654,9 @@ int q6apm_graph_close(struct q6apm_graph *graph)
 {
 	struct audioreach_graph *ar_graph = graph->ar_graph;
 
-	gpr_free_port(graph->port);
+	graph->ar_graph = NULL;
 	kref_put(&ar_graph->refcount, q6apm_put_audioreach_graph);
+	gpr_free_port(graph->port);
 	kfree(graph);
 
 	return 0;
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index bd649c232a06..98b4d90a994a 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -1100,8 +1100,8 @@ int audioreach_tplg_init(struct snd_soc_component *component)
 
 	ret = snd_soc_tplg_component_load(component, &audioreach_tplg_ops, fw);
 	if (ret < 0) {
-		dev_err(dev, "tplg component load failed%d\n", ret);
-		ret = -EINVAL;
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "tplg component load failed: %d\n", ret);
 	}
 
 	release_firmware(fw);
diff --git a/sound/soc/sof/ipc3-dtrace.c b/sound/soc/sof/ipc3-dtrace.c
index b815b0244d9e..8cf421577378 100644
--- a/sound/soc/sof/ipc3-dtrace.c
+++ b/sound/soc/sof/ipc3-dtrace.c
@@ -187,7 +187,6 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
 	struct snd_sof_dfsentry *dfse = file->private_data;
 	struct sof_ipc_trace_filter_elem *elems = NULL;
 	struct snd_sof_dev *sdev = dfse->sdev;
-	loff_t pos = 0;
 	int num_elems;
 	char *string;
 	int ret;
@@ -202,11 +201,11 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
 	if (!string)
 		return -ENOMEM;
 
-	/* assert null termination */
-	string[count] = 0;
-	ret = simple_write_to_buffer(string, count, &pos, from, count);
-	if (ret < 0)
+	if (copy_from_user(string, from, count)) {
+		ret = -EFAULT;
 		goto error;
+	}
+	string[count] = '\0';
 
 	ret = trace_filter_parse(sdev, string, &num_elems, &elems);
 	if (ret < 0)
diff --git a/sound/soc/tegra/tegra210_adx.c b/sound/soc/tegra/tegra210_adx.c
index 49691d2cce50..dd3a2717f00d 100644
--- a/sound/soc/tegra/tegra210_adx.c
+++ b/sound/soc/tegra/tegra210_adx.c
@@ -2,7 +2,7 @@
 //
 // tegra210_adx.c - Tegra210 ADX driver
 //
-// Copyright (c) 2021 NVIDIA CORPORATION.  All rights reserved.
+// Copyright (c) 2021-2023 NVIDIA CORPORATION.  All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -175,10 +175,20 @@ static int tegra210_adx_get_byte_map(struct snd_kcontrol *kcontrol,
 	mc = (struct soc_mixer_control *)kcontrol->private_value;
 	enabled = adx->byte_mask[mc->reg / 32] & (1 << (mc->reg % 32));
 
+	/*
+	 * TODO: Simplify this logic to just return from bytes_map[]
+	 *
+	 * Presently below is required since bytes_map[] is
+	 * tightly packed and cannot store the control value of 256.
+	 * Byte mask state is used to know if 256 needs to be returned.
+	 * Note that for control value of 256, the put() call stores 0
+	 * in the bytes_map[] and disables the corresponding bit in
+	 * byte_mask[].
+	 */
 	if (enabled)
 		ucontrol->value.integer.value[0] = bytes_map[mc->reg];
 	else
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.integer.value[0] = 256;
 
 	return 0;
 }
@@ -192,19 +202,19 @@ static int tegra210_adx_put_byte_map(struct snd_kcontrol *kcontrol,
 	int value = ucontrol->value.integer.value[0];
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int mask_val = adx->byte_mask[mc->reg / 32];
 
-	if (value == bytes_map[mc->reg])
+	if (value >= 0 && value <= 255)
+		mask_val |= (1 << (mc->reg % 32));
+	else
+		mask_val &= ~(1 << (mc->reg % 32));
+
+	if (mask_val == adx->byte_mask[mc->reg / 32])
 		return 0;
 
-	if (value >= 0 && value <= 255) {
-		/* update byte map and enable slot */
-		bytes_map[mc->reg] = value;
-		adx->byte_mask[mc->reg / 32] |= (1 << (mc->reg % 32));
-	} else {
-		/* reset byte map and disable slot */
-		bytes_map[mc->reg] = 0;
-		adx->byte_mask[mc->reg / 32] &= ~(1 << (mc->reg % 32));
-	}
+	/* Update byte map and slot */
+	bytes_map[mc->reg] = value % 256;
+	adx->byte_mask[mc->reg / 32] = mask_val;
 
 	return 1;
 }
diff --git a/sound/soc/tegra/tegra210_amx.c b/sound/soc/tegra/tegra210_amx.c
index d064cc67fea6..a71c5916da79 100644
--- a/sound/soc/tegra/tegra210_amx.c
+++ b/sound/soc/tegra/tegra210_amx.c
@@ -2,7 +2,7 @@
 //
 // tegra210_amx.c - Tegra210 AMX driver
 //
-// Copyright (c) 2021 NVIDIA CORPORATION.  All rights reserved.
+// Copyright (c) 2021-2023 NVIDIA CORPORATION.  All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -203,10 +203,20 @@ static int tegra210_amx_get_byte_map(struct snd_kcontrol *kcontrol,
 	else
 		enabled = amx->byte_mask[0] & (1 << reg);
 
+	/*
+	 * TODO: Simplify this logic to just return from bytes_map[]
+	 *
+	 * Presently below is required since bytes_map[] is
+	 * tightly packed and cannot store the control value of 256.
+	 * Byte mask state is used to know if 256 needs to be returned.
+	 * Note that for control value of 256, the put() call stores 0
+	 * in the bytes_map[] and disables the corresponding bit in
+	 * byte_mask[].
+	 */
 	if (enabled)
 		ucontrol->value.integer.value[0] = bytes_map[reg];
 	else
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.integer.value[0] = 256;
 
 	return 0;
 }
@@ -221,25 +231,19 @@ static int tegra210_amx_put_byte_map(struct snd_kcontrol *kcontrol,
 	unsigned char *bytes_map = (unsigned char *)&amx->map;
 	int reg = mc->reg;
 	int value = ucontrol->value.integer.value[0];
+	unsigned int mask_val = amx->byte_mask[reg / 32];
 
-	if (value == bytes_map[reg])
+	if (value >= 0 && value <= 255)
+		mask_val |= (1 << (reg % 32));
+	else
+		mask_val &= ~(1 << (reg % 32));
+
+	if (mask_val == amx->byte_mask[reg / 32])
 		return 0;
 
-	if (value >= 0 && value <= 255) {
-		/* Update byte map and enable slot */
-		bytes_map[reg] = value;
-		if (reg > 31)
-			amx->byte_mask[1] |= (1 << (reg - 32));
-		else
-			amx->byte_mask[0] |= (1 << reg);
-	} else {
-		/* Reset byte map and disable slot */
-		bytes_map[reg] = 0;
-		if (reg > 31)
-			amx->byte_mask[1] &= ~(1 << (reg - 32));
-		else
-			amx->byte_mask[0] &= ~(1 << reg);
-	}
+	/* Update byte map and slot */
+	bytes_map[reg] = value % 256;
+	amx->byte_mask[reg / 32] = mask_val;
 
 	return 1;
 }
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 898226ea8cad..fac6ba07eacd 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -149,9 +149,9 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
-OPENCSDLIBS := -lopencsd_c_api
+OPENCSDLIBS := -lopencsd_c_api -lopencsd
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  OPENCSDLIBS += -lopencsd -lstdc++
+  OPENCSDLIBS += -lstdc++
 endif
 ifdef CSLIBS
   LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
new file mode 100644
index 000000000000..00d2e0e2e0c2
--- /dev/null
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# test perf probe of function from different CU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
+		echo "--- Cleaning up ---"
+		perf probe -x ${temp_dir}/testfile -d foo
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+        cleanup
+        exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+cat > ${temp_dir}/testfile-foo.h << EOF
+struct t
+{
+  int *p;
+  int c;
+};
+
+extern int foo (int i, struct t *t);
+EOF
+
+cat > ${temp_dir}/testfile-foo.c << EOF
+#include "testfile-foo.h"
+
+int
+foo (int i, struct t *t)
+{
+  int j, res = 0;
+  for (j = 0; j < i && j < t->c; j++)
+    res += t->p[j];
+
+  return res;
+}
+EOF
+
+cat > ${temp_dir}/testfile-main.c << EOF
+#include "testfile-foo.h"
+
+static struct t g;
+
+int
+main (int argc, char **argv)
+{
+  int i;
+  int j[argc];
+  g.c = argc;
+  g.p = j;
+  for (i = 0; i < argc; i++)
+    j[i] = (int) argv[i][0];
+  return foo (3, &g);
+}
+EOF
+
+gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
+gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
+gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
+
+perf probe -x ${temp_dir}/testfile --funcs foo
+perf probe -x ${temp_dir}/testfile foo
+
+cleanup
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 18e319e6ce33..d1ab5f23f4e4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -181,9 +181,9 @@ static noinline void check_new_node(struct maple_tree *mt)
 				e = i - 1;
 		} else {
 			if (i >= 4)
-				e = i - 4;
-			else if (i == 3)
-				e = i - 2;
+				e = i - 3;
+			else if (i >= 1)
+				e = i - 1;
 			else
 				e = 0;
 		}
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index de27a29af270..8baebb41541d 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 
 #define MAX_INSNS	512
-#define MAX_MATCHES	16
+#define MAX_MATCHES	24
 
 struct bpf_reg_match {
 	unsigned int line;
@@ -267,6 +267,7 @@ static struct bpf_align_test tests[] = {
 			 */
 			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
@@ -280,6 +281,7 @@ static struct bpf_align_test tests[] = {
 			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 4),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
@@ -311,44 +313,52 @@ static struct bpf_align_test tests[] = {
 			{15, "R4=pkt(id=1,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
 			{15, "R5=pkt(id=1,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Variable offset is added to R5 packet pointer,
-			 * resulting in auxiliary alignment of 4.
+			 * resulting in auxiliary alignment of 4. To avoid BPF
+			 * verifier's precision backtracking logging
+			 * interfering we also have a no-op R4 = R5
+			 * instruction to validate R5 state. We also check
+			 * that R4 is what it should be in such case.
 			 */
-			{17, "R5_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{18, "R4_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{18, "R5_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{18, "R5_w=pkt(id=2,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{19, "R5_w=pkt(id=2,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
 			 * aligned, so the total offset is 4-byte aligned and
 			 * meets the load's requirements.
 			 */
-			{23, "R4=pkt(id=2,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
-			{23, "R5=pkt(id=2,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R4=pkt(id=2,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R5=pkt(id=2,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{25, "R5_w=pkt(off=14,r=8"},
+			{26, "R5_w=pkt(off=14,r=8"},
 			/* Variable offset is added to R5, resulting in a
-			 * variable offset of (4n).
+			 * variable offset of (4n). See comment for insn #18
+			 * for R4 = R5 trick.
 			 */
-			{26, "R5_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{28, "R4_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{28, "R5_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{27, "R5_w=pkt(id=3,off=18,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{29, "R5_w=pkt(id=3,off=18,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{28, "R5_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
+			{31, "R4_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
+			{31, "R5_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{33, "R4=pkt(id=4,off=22,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
-			{33, "R5=pkt(id=4,off=18,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R4=pkt(id=4,off=22,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R5=pkt(id=4,off=18,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
 		},
 	},
 	{
@@ -681,6 +691,6 @@ void test_align(void)
 		if (!test__start_subtest(test->descr))
 			continue;
 
-		CHECK_FAIL(do_test_single(test));
+		ASSERT_OK(do_test_single(test), test->descr);
 	}
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 3e190ed63976..1374b626a985 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -29,7 +29,23 @@ static int stop, duration;
 static bool
 configure_stack(void)
 {
+	char tc_version[128];
 	char tc_cmd[BUFSIZ];
+	char *prog;
+	FILE *tc;
+
+	/* Check whether tc is built with libbpf. */
+	tc = popen("tc -V", "r");
+	if (CHECK_FAIL(!tc))
+		return false;
+	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
+		return false;
+	if (strstr(tc_version, ", libbpf "))
+		prog = "test_sk_assign_libbpf.bpf.o";
+	else
+		prog = "test_sk_assign.bpf.o";
+	if (CHECK_FAIL(pclose(tc)))
+		return false;
 
 	/* Move to a new networking namespace */
 	if (CHECK_FAIL(unshare(CLONE_NEWNET)))
@@ -46,8 +62,8 @@ configure_stack(void)
 	/* Load qdisc, BPF program */
 	if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
 		return false;
-	sprintf(tc_cmd, "%s %s %s %s", "tc filter add dev lo ingress bpf",
-		       "direct-action object-file ./test_sk_assign.bpf.o",
+	sprintf(tc_cmd, "%s %s %s %s %s", "tc filter add dev lo ingress bpf",
+		       "direct-action object-file", prog,
 		       "section tc",
 		       (env.verbosity < VERBOSE_VERY) ? " 2>/dev/null" : "verbose");
 	if (CHECK(system(tc_cmd), "BPF load failed;",
@@ -129,15 +145,12 @@ get_port(int fd)
 static ssize_t
 rcv_msg(int srv_client, int type)
 {
-	struct sockaddr_storage ss;
 	char buf[BUFSIZ];
-	socklen_t slen;
 
 	if (type == SOCK_STREAM)
 		return read(srv_client, &buf, sizeof(buf));
 	else
-		return recvfrom(srv_client, &buf, sizeof(buf), 0,
-				(struct sockaddr *)&ss, &slen);
+		return recvfrom(srv_client, &buf, sizeof(buf), 0, NULL, NULL);
 }
 
 static int
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index ec25371de789..7ef49ec04838 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -32,7 +32,7 @@
 #define IFNAMSIZ 16
 #endif
 
-__attribute__ ((noinline))
+__attribute__ ((noinline)) __weak
 int do_bind(struct bpf_sock_addr *ctx)
 {
 	struct sockaddr_in sa = {};
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 98c6493d9b91..21b19b758c4e 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -16,6 +16,16 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#if defined(IPROUTE2_HAVE_LIBBPF)
+/* Use a new-style map definition. */
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__type(key, int);
+	__type(value, __u64);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+	__uint(max_entries, 1);
+} server_map SEC(".maps");
+#else
 /* Pin map under /sys/fs/bpf/tc/globals/<map name> */
 #define PIN_GLOBAL_NS 2
 
@@ -35,6 +45,7 @@ struct {
 	.max_elem = 1,
 	.pinning = PIN_GLOBAL_NS,
 };
+#endif
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c b/tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
new file mode 100644
index 000000000000..dcf46adfda04
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+#define IPROUTE2_HAVE_LIBBPF
+#include "test_sk_assign.c"
diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index aec4de8bea78..0c3978fd6bcc 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -5,6 +5,8 @@ CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_LABELS=y
+CONFIG_NF_CONNTRACK_PROCFS=y
+CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_NAT=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m
 
diff --git a/tools/testing/selftests/tc-testing/settings b/tools/testing/selftests/tc-testing/settings
new file mode 100644
index 000000000000..e2206265f67c
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/settings
@@ -0,0 +1 @@
+timeout=900
