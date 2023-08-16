Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05977E684
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbjHPQf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344749AbjHPQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267DF199B;
        Wed, 16 Aug 2023 09:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A65610A1;
        Wed, 16 Aug 2023 16:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7484BC433C7;
        Wed, 16 Aug 2023 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692203730;
        bh=32R7nAMUkmHdRK+FGMi1ef+OQplfPgy72AmLNcx0z+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qar/Vb8JvMi4BD2FJ/+4WCHuVTYTTl3Q52UXfLPh6v5Ps1tKi7n9cnG6fQ6N9EbeL
         KByl9CRVMtGc/4NdKQzGL85UTHPA0lRABV1JMGX+1gGjTBqzUMkt6LwYdLAbXteIcy
         MwYrF6Y6ttJ0m5CBbPzoo4OF4C1BEbOxjskpT32A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.292
Date:   Wed, 16 Aug 2023 18:35:18 +0200
Message-ID: <2023081617-freeing-trough-d033@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081617-dwindle-justifier-8ca9@gregkh>
References: <2023081617-dwindle-justifier-8ca9@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index f110fc4f127f..fcd6a9b17301 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 291
+SUBLEVEL = 292
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 5576f7646fb6..60f7e45d3aa8 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -469,8 +469,7 @@ setup_memory(void *kernel_end)
 extern void setup_memory(void *);
 #endif /* !CONFIG_DISCONTIGMEM */
 
-int __init
-page_is_ram(unsigned long pfn)
+int page_is_ram(unsigned long pfn)
 {
 	struct memclust_struct * cluster;
 	struct memdesc_struct * memdesc;
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e231779928dd..8a0bb7c48e9a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -12,7 +12,6 @@ config 64BIT
 config SPARC
 	bool
 	default y
-	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select OF
@@ -51,6 +50,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select DMA_NONCOHERENT_OPS
 	select GENERIC_ATOMIC64
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index a1c31bb23170..a3cd828359f8 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -228,8 +228,8 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 
 	/* Round the lowest possible end address up to a PMD boundary. */
 	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= TASK_SIZE_MAX)
-		end = TASK_SIZE_MAX;
+	if (end >= DEFAULT_MAP_WINDOW)
+		end = DEFAULT_MAP_WINDOW;
 	end -= len;
 
 	if (end > start) {
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cc4bb218f1c6..f3049d55c522 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -1001,4 +1001,6 @@ enum taa_mitigations {
 	TAA_MITIGATION_TSX_DISABLED,
 };
 
+extern bool gds_ucode_mitigated(void);
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 256f2c6120ec..69eb6a804d1d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -69,6 +69,7 @@ static const int amd_erratum_1054[] =
 static const int amd_zenbleed[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
+			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
 
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cdf2cb1eb923..d7a9b07ce0b8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -217,8 +217,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 
 u64 __read_mostly host_xcr0;
 
-extern bool gds_ucode_mitigated(void);
-
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
 
 static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 3e57d5682b69..c5cf4f651ab4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5742,6 +5742,7 @@ static int __init binder_init(void)
 
 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	binder_alloc_shrinker_exit();
 
 	return ret;
 }
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index cd845afc4880..a6e4f4858ca2 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1033,6 +1033,12 @@ static struct shrinker binder_shrinker = {
 	.seeks = DEFAULT_SEEKS,
 };
 
+void binder_alloc_shrinker_exit(void)
+{
+	unregister_shrinker(&binder_shrinker);
+	list_lru_destroy(&binder_alloc_lru);
+}
+
 /**
  * binder_alloc_init() - called by binder_open() for per-proc initialization
  * @alloc: binder_alloc for this proc
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index fb3238c74c8a..78bb12eea634 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -130,6 +130,7 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 						  int is_async);
 extern void binder_alloc_init(struct binder_alloc *alloc);
 extern int binder_alloc_shrinker_init(void);
+extern void binder_alloc_shrinker_exit(void);
 extern void binder_alloc_vma_close(struct binder_alloc *alloc);
 extern struct binder_buffer *
 binder_alloc_prepare_to_free(struct binder_alloc *alloc,
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 5afdb9e31c88..1bba1fa3a809 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -404,6 +404,12 @@ enum desc_status {
 	 * of a channel can be BUSY at any time.
 	 */
 	BUSY,
+	/*
+	 * Pause was called while descriptor was BUSY. Due to hardware
+	 * limitations, only termination is possible for descriptors
+	 * that have been paused.
+	 */
+	PAUSED,
 	/*
 	 * Sitting on the channel work_list but xfer done
 	 * by PL330 core
@@ -2028,7 +2034,7 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 	list_for_each_entry(desc, &pch->work_list, node) {
 
 		/* If already submitted */
-		if (desc->status == BUSY)
+		if (desc->status == BUSY || desc->status == PAUSED)
 			continue;
 
 		ret = pl330_submit_req(pch->thread, desc);
@@ -2305,6 +2311,7 @@ static int pl330_pause(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct pl330_dmac *pl330 = pch->dmac;
+	struct dma_pl330_desc *desc;
 	unsigned long flags;
 
 	pm_runtime_get_sync(pl330->ddma.dev);
@@ -2314,6 +2321,10 @@ static int pl330_pause(struct dma_chan *chan)
 	_stop(pch->thread);
 	spin_unlock(&pl330->lock);
 
+	list_for_each_entry(desc, &pch->work_list, node) {
+		if (desc->status == BUSY)
+			desc->status = PAUSED;
+	}
 	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_mark_last_busy(pl330->ddma.dev);
 	pm_runtime_put_autosuspend(pl330->ddma.dev);
@@ -2404,7 +2415,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		else if (running && desc == running)
 			transferred =
 				pl330_get_current_xferred_count(pch, desc);
-		else if (desc->status == BUSY)
+		else if (desc->status == BUSY || desc->status == PAUSED)
 			/*
 			 * Busy but not running means either just enqueued,
 			 * or finished and not yet marked done
@@ -2421,6 +2432,9 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 			case DONE:
 				ret = DMA_COMPLETE;
 				break;
+			case PAUSED:
+				ret = DMA_PAUSED;
+				break;
 			case PREP:
 			case BUSY:
 				ret = DMA_IN_PROGRESS;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 905ab615c7c8..6e6568101963 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -921,7 +921,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	/* Determine display colour depth for everything except LVDS now,
 	 * DP requires this before mode_valid() is called.
 	 */
-	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
+	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
 		nouveau_connector_detect_depth(connector);
 
 	/* Find the native mode if this is a digital panel, if we didn't
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
index 33e932bd73b1..378635e6e87a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
@@ -121,6 +121,7 @@ void gk104_grctx_generate_r418800(struct gf100_gr *);
 
 extern const struct gf100_grctx_func gk110_grctx;
 void gk110_grctx_generate_r419eb0(struct gf100_gr *);
+void gk110_grctx_generate_r419f78(struct gf100_gr *);
 
 extern const struct gf100_grctx_func gk110b_grctx;
 extern const struct gf100_grctx_func gk208_grctx;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
index 304e9d268bad..f894f8254824 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
@@ -916,7 +916,9 @@ static void
 gk104_grctx_generate_r419f78(struct gf100_gr *gr)
 {
 	struct nvkm_device *device = gr->base.engine.subdev.device;
-	nvkm_mask(device, 0x419f78, 0x00000001, 0x00000000);
+
+	/* bit 3 set disables loads in fp helper invocations, we need it enabled */
+	nvkm_mask(device, 0x419f78, 0x00000009, 0x00000000);
 }
 
 void
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
index 86547cfc38dc..e88740d4e54d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
@@ -820,6 +820,15 @@ gk110_grctx_generate_r419eb0(struct gf100_gr *gr)
 	nvkm_mask(device, 0x419eb0, 0x00001000, 0x00001000);
 }
 
+void
+gk110_grctx_generate_r419f78(struct gf100_gr *gr)
+{
+	struct nvkm_device *device = gr->base.engine.subdev.device;
+
+	/* bit 3 set disables loads in fp helper invocations, we need it enabled */
+	nvkm_mask(device, 0x419f78, 0x00000008, 0x00000000);
+}
+
 const struct gf100_grctx_func
 gk110_grctx = {
 	.main  = gf100_grctx_generate_main,
@@ -852,4 +861,5 @@ gk110_grctx = {
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
 	.r419eb0 = gk110_grctx_generate_r419eb0,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
index ebb947bd1446..086e4d49e112 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
@@ -101,4 +101,5 @@ gk110b_grctx = {
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
 	.r419eb0 = gk110_grctx_generate_r419eb0,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
index 4d40512b5c99..0bf438c3f7cb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
@@ -566,4 +566,5 @@ gk208_grctx = {
 	.dist_skip_table = gf117_grctx_generate_dist_skip_table,
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
index 0b3964e6b36e..acdf0932a99e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
@@ -991,4 +991,5 @@ gm107_grctx = {
 	.r406500 = gm107_grctx_generate_r406500,
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r419e00 = gm107_grctx_generate_r419e00,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 414cc43c287e..66991fd4b10a 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -46,7 +46,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	platform_set_drvdata(pdev, indio_dev);
 
 	state->ec = ec->ec_dev;
-	state->msg = devm_kzalloc(&pdev->dev,
+	state->msg = devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
 				max((u16)sizeof(struct ec_params_motion_sense),
 				state->ec->max_response), GFP_KERNEL);
 	if (!state->msg)
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 1221faea75a6..54a65db2443e 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -12178,6 +12178,7 @@ static void free_cntrs(struct hfi1_devdata *dd)
 
 	if (dd->synth_stats_timer.function)
 		del_timer_sync(&dd->synth_stats_timer);
+	cancel_work_sync(&dd->update_cntr_work);
 	ppd = (struct hfi1_pportdata *)(dd + 1);
 	for (i = 0; i < dd->num_pports; i++, ppd++) {
 		kfree(ppd->cntrs);
diff --git a/drivers/isdn/mISDN/dsp.h b/drivers/isdn/mISDN/dsp.h
index fa09d511a8ed..baf31258f5c9 100644
--- a/drivers/isdn/mISDN/dsp.h
+++ b/drivers/isdn/mISDN/dsp.h
@@ -247,7 +247,7 @@ extern void dsp_cmx_hardware(struct dsp_conf *conf, struct dsp *dsp);
 extern int dsp_cmx_conf(struct dsp *dsp, u32 conf_id);
 extern void dsp_cmx_receive(struct dsp *dsp, struct sk_buff *skb);
 extern void dsp_cmx_hdlc(struct dsp *dsp, struct sk_buff *skb);
-extern void dsp_cmx_send(void *arg);
+extern void dsp_cmx_send(struct timer_list *arg);
 extern void dsp_cmx_transmit(struct dsp *dsp, struct sk_buff *skb);
 extern int dsp_cmx_del_conf_member(struct dsp *dsp);
 extern int dsp_cmx_del_conf(struct dsp_conf *conf);
diff --git a/drivers/isdn/mISDN/dsp_cmx.c b/drivers/isdn/mISDN/dsp_cmx.c
index d4b6f01a3f0e..23a8e93d26c0 100644
--- a/drivers/isdn/mISDN/dsp_cmx.c
+++ b/drivers/isdn/mISDN/dsp_cmx.c
@@ -1625,7 +1625,7 @@ static u16	dsp_count; /* last sample count */
 static int	dsp_count_valid; /* if we have last sample count */
 
 void
-dsp_cmx_send(void *arg)
+dsp_cmx_send(struct timer_list *arg)
 {
 	struct dsp_conf *conf;
 	struct dsp_conf_member *member;
diff --git a/drivers/isdn/mISDN/dsp_core.c b/drivers/isdn/mISDN/dsp_core.c
index cd036e87335a..c3f8bf82f78e 100644
--- a/drivers/isdn/mISDN/dsp_core.c
+++ b/drivers/isdn/mISDN/dsp_core.c
@@ -1202,7 +1202,7 @@ static int __init dsp_init(void)
 	}
 
 	/* set sample timer */
-	timer_setup(&dsp_spl_tl, (void *)dsp_cmx_send, 0);
+	timer_setup(&dsp_spl_tl, dsp_cmx_send, 0);
 	dsp_spl_tl.expires = jiffies + dsp_tics;
 	dsp_spl_jiffies = dsp_spl_tl.expires;
 	add_timer(&dsp_spl_tl);
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 52307dce08ba..0c392b41a858 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -339,13 +339,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 				return;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
-				/* SCR data must be read in big endian. */
-				if (data->mrq->cmd->opcode == SD_APP_SEND_SCR)
-					*sgp = ioread32be(host->base +
-							  REG_DATA_WINDOW);
-				else
-					*sgp = ioread32(host->base +
-							REG_DATA_WINDOW);
+				*sgp = ioread32(host->base + REG_DATA_WINDOW);
 				sgp++;
 				len += 4;
 			}
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 47e02c5342b2..79b36f1c50ae 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4395,7 +4395,9 @@ void bond_setup(struct net_device *bond_dev)
 
 	bond_dev->hw_features = BOND_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
-				NETIF_F_HW_VLAN_CTAG_FILTER;
+				NETIF_F_HW_VLAN_CTAG_FILTER |
+				NETIF_F_HW_VLAN_STAG_RX |
+				NETIF_F_HW_VLAN_STAG_FILTER;
 
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
 	bond_dev->features |= bond_dev->hw_features;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 1463cf4321a8..646f14a9bd96 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -884,12 +884,22 @@ static int ibmvnic_login(struct net_device *netdev)
 
 static void release_login_buffer(struct ibmvnic_adapter *adapter)
 {
+	if (!adapter->login_buf)
+		return;
+
+	dma_unmap_single(&adapter->vdev->dev, adapter->login_buf_token,
+			 adapter->login_buf_sz, DMA_TO_DEVICE);
 	kfree(adapter->login_buf);
 	adapter->login_buf = NULL;
 }
 
 static void release_login_rsp_buffer(struct ibmvnic_adapter *adapter)
 {
+	if (!adapter->login_rsp_buf)
+		return;
+
+	dma_unmap_single(&adapter->vdev->dev, adapter->login_rsp_buf_token,
+			 adapter->login_rsp_buf_sz, DMA_FROM_DEVICE);
 	kfree(adapter->login_rsp_buf);
 	adapter->login_rsp_buf = NULL;
 }
@@ -4061,11 +4071,6 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	struct ibmvnic_login_buffer *login = adapter->login_buf;
 	int i;
 
-	dma_unmap_single(dev, adapter->login_buf_token, adapter->login_buf_sz,
-			 DMA_TO_DEVICE);
-	dma_unmap_single(dev, adapter->login_rsp_buf_token,
-			 adapter->login_rsp_buf_sz, DMA_FROM_DEVICE);
-
 	/* If the number of queues requested can't be allocated by the
 	 * server, the login response will return with code 1. We will need
 	 * to resend the login buffer with fewer queues requested.
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e61f02f7642c..055664a26f7a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1654,7 +1654,7 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	if (zerocopy)
 		return false;
 
-	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
+	if (SKB_DATA_ALIGN(len + TUN_RX_PAD + XDP_PACKET_HEADROOM) +
 	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
 		return false;
 
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index ac79f2088b31..480fc9bb4c90 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1594,7 +1594,7 @@ NCR_700_intr(int irq, void *dev_id)
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
-			} else if(dsp >= to32bit(&slot->pSG[0].ins) &&
+			} else if (slot && dsp >= to32bit(&slot->pSG[0].ins) &&
 				  dsp <= to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer = NCR_700_readl(host, DBC_REG) & 0xffffff;
 				int SGcount = (dsp - to32bit(&slot->pSG[0].ins))/sizeof(struct NCR_700_SG_List);
diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 5c3d6e1e0145..cd0aba0d58b2 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -249,6 +249,7 @@ int raid_component_add(struct raid_template *r,struct device *raid_dev,
 	return 0;
 
 err_out:
+	put_device(&rc->dev);
 	list_del(&rc->node);
 	rd->component_count--;
 	put_device(component_dev);
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 7f0ceb65c3f3..99f472bb9f7e 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -311,7 +311,7 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 			       size_t length, loff_t *ppos)
 {
 	int host, channel, id, lun;
-	char *buffer, *p;
+	char *buffer, *end, *p;
 	int err;
 
 	if (!buf || length > PAGE_SIZE)
@@ -326,10 +326,14 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 		goto out;
 
 	err = -EINVAL;
-	if (length < PAGE_SIZE)
-		buffer[length] = '\0';
-	else if (buffer[PAGE_SIZE-1])
-		goto out;
+	if (length < PAGE_SIZE) {
+		end = buffer + length;
+		*end = '\0';
+	} else {
+		end = buffer + PAGE_SIZE - 1;
+		if (*end)
+			goto out;
+	}
 
 	/*
 	 * Usage: echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
@@ -338,10 +342,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	if (!strncmp("scsi add-single-device", buffer, 22)) {
 		p = buffer + 23;
 
-		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		host    = (p     < end) ? simple_strtoul(p, &p, 0) : 0;
+		channel = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		id      = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		lun     = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
 
 		err = scsi_add_single_device(host, channel, id, lun);
 
@@ -352,10 +356,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	} else if (!strncmp("scsi remove-single-device", buffer, 25)) {
 		p = buffer + 26;
 
-		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		host    = (p     < end) ? simple_strtoul(p, &p, 0) : 0;
+		channel = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		id      = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		lun     = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
 
 		err = scsi_remove_single_device(host, channel, id, lun);
 	}
diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
index 69c5e26a9d5b..388ba2ebcce5 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -316,6 +316,7 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
+		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index f3701b4e374b..a28eb91dc2f3 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1540,10 +1540,6 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
  */
 static enum blk_eh_timer_return storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 {
-#if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-	if (scmnd->device->host->transportt == fc_transport_template)
-		return fc_eh_timed_out(scmnd);
-#endif
 	return BLK_EH_RESET_TIMER;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4528852fd990..e617a28aca43 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3234,9 +3234,14 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	u32 reg;
 
 	if (pm_runtime_suspended(dwc->dev)) {
+		dwc->pending_events = true;
+		/*
+		 * Trigger runtime resume. The get() function will be balanced
+		 * after processing the pending events in dwc3_process_pending
+		 * events().
+		 */
 		pm_runtime_get(dwc->dev);
 		disable_irq_nosync(dwc->irq_gadget);
-		dwc->pending_events = true;
 		return IRQ_HANDLED;
 	}
 
@@ -3474,6 +3479,8 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
 {
 	if (dwc->pending_events) {
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		pm_runtime_put(dwc->dev);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
 	}
diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 6fcf5fd2ff98..50c8bd7cbfdd 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -317,7 +317,8 @@ static int alauda_get_media_status(struct us_data *us, unsigned char *data)
 	rc = usb_stor_ctrl_transfer(us, us->recv_ctrl_pipe,
 		command, 0xc0, 0, 1, data, 2);
 
-	usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
+	if (rc == USB_STOR_XFER_GOOD)
+		usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
 
 	return rc;
 }
@@ -453,10 +454,14 @@ static int alauda_init_media(struct us_data *us)
 static int alauda_check_media(struct us_data *us)
 {
 	struct alauda_info *info = (struct alauda_info *) us->extra;
-	unsigned char status[2];
+	unsigned char *status = us->iobuf;
 	int rc;
 
 	rc = alauda_get_media_status(us, status);
+	if (rc != USB_STOR_XFER_GOOD) {
+		status[0] = 0xF0;	/* Pretend there's no media */
+		status[1] = 0;
+	}
 
 	/* Check for no media or door open */
 	if ((status[0] & 0x80) || ((status[0] & 0x1F) == 0x10)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dabf153843e9..504d63fb81fa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3928,11 +3928,12 @@ int btree_write_cache_pages(struct address_space *mapping,
 			free_extent_buffer(eb);
 
 			/*
-			 * the filesystem may choose to bump up nr_to_write.
+			 * The filesystem may choose to bump up nr_to_write.
 			 * We have to make sure to honor the new nr_to_write
-			 * at any time
+			 * at any time.
 			 */
-			nr_to_write_done = wbc->nr_to_write <= 0;
+			nr_to_write_done = (wbc->sync_mode == WB_SYNC_NONE &&
+					    wbc->nr_to_write <= 0);
 		}
 		pagevec_release(&pvec);
 		cond_resched();
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 53ec342eb787..4eed9500f33a 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1112,9 +1112,17 @@ int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
 
 int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 {
+	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 	struct buffer_head *ibh;
 	int err;
 
+	/*
+	 * Do not dirty inodes after the log writer has been detached
+	 * and its nilfs_root struct has been freed.
+	 */
+	if (unlikely(nilfs_purging(nilfs)))
+		return 0;
+
 	err = nilfs_load_inode_block(inode, &ibh);
 	if (unlikely(err)) {
 		nilfs_msg(inode->i_sb, KERN_WARNING,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index d9e0b2b2b555..04e1e671b613 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2845,6 +2845,7 @@ void nilfs_detach_log_writer(struct super_block *sb)
 		nilfs_segctor_destroy(nilfs->ns_writer);
 		nilfs->ns_writer = NULL;
 	}
+	set_nilfs_purging(nilfs);
 
 	/* Force to free the list of dirty files */
 	spin_lock(&nilfs->ns_inode_lock);
@@ -2857,4 +2858,5 @@ void nilfs_detach_log_writer(struct super_block *sb)
 	up_write(&nilfs->ns_segctor_sem);
 
 	nilfs_dispose_list(nilfs, &garbage_list, 1);
+	clear_nilfs_purging(nilfs);
 }
diff --git a/fs/nilfs2/the_nilfs.h b/fs/nilfs2/the_nilfs.h
index 380a543c5b19..de6e24d80eb6 100644
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -29,6 +29,7 @@ enum {
 	THE_NILFS_DISCONTINUED,	/* 'next' pointer chain has broken */
 	THE_NILFS_GC_RUNNING,	/* gc process is running */
 	THE_NILFS_SB_DIRTY,	/* super block is dirty */
+	THE_NILFS_PURGING,	/* disposing dirty files for cleanup */
 };
 
 /**
@@ -208,6 +209,7 @@ THE_NILFS_FNS(INIT, init)
 THE_NILFS_FNS(DISCONTINUED, discontinued)
 THE_NILFS_FNS(GC_RUNNING, gc_running)
 THE_NILFS_FNS(SB_DIRTY, sb_dirty)
+THE_NILFS_FNS(PURGING, purging)
 
 /*
  * Mount option operations
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b96debd18e14..157b74fab898 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -370,6 +370,9 @@ ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 	if (WARN_ON(iftype >= NL80211_IFTYPE_MAX))
 		return NULL;
 
+	if (iftype == NL80211_IFTYPE_AP_VLAN)
+		iftype = NL80211_IFTYPE_AP;
+
 	for (i = 0; i < sband->n_iftype_data; i++)  {
 		const struct ieee80211_sband_iftype_data *data =
 			&sband->iftype_data[i];
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 471944087372..fd85286482c1 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -992,6 +992,29 @@ int __nft_release_basechain(struct nft_ctx *ctx);
 
 unsigned int nft_do_chain(struct nft_pktinfo *pkt, void *priv);
 
+static inline bool nft_use_inc(u32 *use)
+{
+	if (*use == UINT_MAX)
+		return false;
+
+	(*use)++;
+
+	return true;
+}
+
+static inline void nft_use_dec(u32 *use)
+{
+	WARN_ON_ONCE((*use)-- == 0);
+}
+
+/* For error and abort path: restore use counter to previous state. */
+static inline void nft_use_inc_restore(u32 *use)
+{
+	WARN_ON_ONCE(!nft_use_inc(use));
+}
+
+#define nft_use_dec_restore	nft_use_dec
+
 /**
  *	struct nft_table - nf_tables table
  *
@@ -1050,8 +1073,8 @@ struct nft_object {
 	struct list_head		list;
 	char				*name;
 	struct nft_table		*table;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	u64				handle;
 	/* runtime data below here */
 	const struct nft_object_ops	*ops ____cacheline_aligned;
@@ -1149,8 +1172,8 @@ struct nft_flowtable {
 	int				hooknum;
 	int				priority;
 	int				ops_len;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	u64				handle;
 	/* runtime data below here */
 	struct nf_hook_ops		*ops ____cacheline_aligned;
@@ -1161,6 +1184,10 @@ struct nft_flowtable *nft_flowtable_lookup(const struct nft_table *table,
 					   const struct nlattr *nla,
 					   u8 genmask);
 
+void nf_tables_deactivate_flowtable(const struct nft_ctx *ctx,
+				    struct nft_flowtable *flowtable,
+				    enum nft_trans_phase phase);
+
 void nft_register_flowtable_type(struct nf_flowtable_type *type);
 void nft_unregister_flowtable_type(struct nf_flowtable_type *type);
 
diff --git a/net/dccp/output.c b/net/dccp/output.c
index 91a15b3c4915..d872dd1cfb5e 100644
--- a/net/dccp/output.c
+++ b/net/dccp/output.c
@@ -189,7 +189,7 @@ unsigned int dccp_sync_mss(struct sock *sk, u32 pmtu)
 
 	/* And store cached results */
 	icsk->icsk_pmtu_cookie = pmtu;
-	dp->dccps_mss_cache = cur_mps;
+	WRITE_ONCE(dp->dccps_mss_cache, cur_mps);
 
 	return cur_mps;
 }
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 673502779933..27de4dc1ff51 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -648,7 +648,7 @@ static int do_dccp_getsockopt(struct sock *sk, int level, int optname,
 		return dccp_getsockopt_service(sk, len,
 					       (__be32 __user *)optval, optlen);
 	case DCCP_SOCKOPT_GET_CUR_MPS:
-		val = dp->dccps_mss_cache;
+		val = READ_ONCE(dp->dccps_mss_cache);
 		break;
 	case DCCP_SOCKOPT_AVAILABLE_CCIDS:
 		return ccid_getsockopt_builtin_ccids(sk, len, optval, optlen);
@@ -770,7 +770,7 @@ int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	trace_dccp_probe(sk, len);
 
-	if (len > dp->dccps_mss_cache)
+	if (len > READ_ONCE(dp->dccps_mss_cache))
 		return -EMSGSIZE;
 
 	lock_sock(sk);
@@ -803,6 +803,12 @@ int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		goto out_discard;
 	}
 
+	/* We need to check dccps_mss_cache after socket is locked. */
+	if (len > dp->dccps_mss_cache) {
+		rc = -EMSGSIZE;
+		goto out_discard;
+	}
+
 	skb_reserve(skb, sk->sk_prot->max_header);
 	rc = memcpy_from_msg(skb_put(skb, len), msg, len);
 	if (rc != 0)
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 673a4a932f2a..a640deb9ab14 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -195,7 +195,8 @@ static struct nd_opt_hdr *ndisc_next_option(struct nd_opt_hdr *cur,
 static inline int ndisc_is_useropt(const struct net_device *dev,
 				   struct nd_opt_hdr *opt)
 {
-	return opt->nd_opt_type == ND_OPT_RDNSS ||
+	return opt->nd_opt_type == ND_OPT_PREFIX_INFO ||
+		opt->nd_opt_type == ND_OPT_RDNSS ||
 		opt->nd_opt_type == ND_OPT_DNSSL ||
 		ndisc_ops_is_useropt(dev, opt->nd_opt_type);
 }
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 115bc79ec905..eeadb638f448 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -266,7 +266,7 @@ static int nft_delchain(struct nft_ctx *ctx)
 	if (err < 0)
 		return err;
 
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nft_deactivate_next(ctx->net, ctx->chain);
 
 	return err;
@@ -307,7 +307,7 @@ nf_tables_delrule_deactivate(struct nft_ctx *ctx, struct nft_rule *rule)
 	/* You cannot delete the same rule twice */
 	if (nft_is_active_next(ctx->net, rule)) {
 		nft_deactivate_next(ctx->net, rule);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		return 0;
 	}
 	return -ENOENT;
@@ -396,7 +396,7 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 		return err;
 
 	nft_deactivate_next(ctx->net, set);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -428,7 +428,7 @@ static int nft_delobj(struct nft_ctx *ctx, struct nft_object *obj)
 		return err;
 
 	nft_deactivate_next(ctx->net, obj);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -462,7 +462,7 @@ static int nft_delflowtable(struct nft_ctx *ctx,
 		return err;
 
 	nft_deactivate_next(ctx->net, flowtable);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -1660,9 +1660,6 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	struct nft_rule **rules;
 	int err;
 
-	if (table->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (nla[NFTA_CHAIN_HOOK]) {
 		struct nft_chain_hook hook;
 		struct nf_hook_ops *ops;
@@ -1734,6 +1731,11 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	if (err < 0)
 		goto err1;
 
+	if (!nft_use_inc(&table->use)) {
+		err = -EMFILE;
+		goto err_use;
+	}
+
 	err = rhltable_insert_key(&table->chains_ht, chain->name,
 				  &chain->rhlhead, nft_chain_ht_params);
 	if (err)
@@ -1746,11 +1748,12 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		goto err2;
 	}
 
-	table->use++;
 	list_add_tail_rcu(&chain->list, &table->chains);
 
 	return 0;
 err2:
+	nft_use_dec_restore(&table->use);
+err_use:
 	nf_tables_unregister_hook(net, table, chain);
 err1:
 	nf_tables_chain_destroy(ctx);
@@ -2692,9 +2695,6 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 			return -EINVAL;
 		handle = nf_tables_alloc_handle(table);
 
-		if (chain->use == UINT_MAX)
-			return -EOVERFLOW;
-
 		if (nla[NFTA_RULE_POSITION]) {
 			pos_handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_POSITION]));
 			old_rule = __nft_rule_lookup(chain, pos_handle);
@@ -2770,23 +2770,28 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 		expr = nft_expr_next(expr);
 	}
 
+	if (!nft_use_inc(&chain->use)) {
+		err = -EMFILE;
+		goto err2;
+	}
+
 	if (nlh->nlmsg_flags & NLM_F_REPLACE) {
 		trans = nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule);
 		if (trans == NULL) {
 			err = -ENOMEM;
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 		err = nft_delrule(&ctx, old_rule);
 		if (err < 0) {
 			nft_trans_destroy(trans);
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 
 		list_add_tail_rcu(&rule->list, &old_rule->list);
 	} else {
 		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
 			err = -ENOMEM;
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 
 		if (nlh->nlmsg_flags & NLM_F_APPEND) {
@@ -2802,12 +2807,14 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 		}
 	}
 	kvfree(info);
-	chain->use++;
 
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, table);
 
 	return 0;
+
+err_destroy_flow_rule:
+	nft_use_dec_restore(&chain->use);
 err2:
 	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
 	nf_tables_rule_destroy(&ctx, rule);
@@ -3625,10 +3632,15 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	if (ops->privsize != NULL)
 		size = ops->privsize(nla, &desc);
 
+	if (!nft_use_inc(&table->use)) {
+		err = -EMFILE;
+		goto err1;
+	}
+
 	set = kvzalloc(sizeof(*set) + size + udlen, GFP_KERNEL);
 	if (!set) {
 		err = -ENOMEM;
-		goto err1;
+		goto err_alloc;
 	}
 
 	name = nla_strdup(nla[NFTA_SET_NAME], GFP_KERNEL);
@@ -3675,7 +3687,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		goto err4;
 
 	list_add_tail_rcu(&set->list, &table->sets);
-	table->use++;
+
 	return 0;
 
 err4:
@@ -3684,6 +3696,8 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	kfree(set->name);
 err2:
 	kvfree(set);
+err_alloc:
+	nft_use_dec_restore(&table->use);
 err1:
 	module_put(to_set_type(ops)->owner);
 	return err;
@@ -3770,9 +3784,6 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_set_binding *i;
 	struct nft_set_iter iter;
 
-	if (set->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (!list_empty(&set->bindings) && nft_set_is_anonymous(set))
 		return -EBUSY;
 
@@ -3797,10 +3808,12 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 			return iter.err;
 	}
 bind:
+	if (!nft_use_inc(&set->use))
+		return -EMFILE;
+
 	binding->chain = ctx->chain;
 	list_add_tail_rcu(&binding->list, &set->bindings);
 	nft_set_trans_bind(ctx, set);
-	set->use++;
 
 	return 0;
 }
@@ -3825,7 +3838,7 @@ void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 	if (nft_set_is_anonymous(set))
 		nft_clear(ctx->net, set);
 
-	set->use++;
+	nft_use_inc_restore(&set->use);
 }
 EXPORT_SYMBOL_GPL(nf_tables_activate_set);
 
@@ -3841,17 +3854,17 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		else
 			list_del_rcu(&binding->list);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		break;
 	case NFT_TRANS_PREPARE:
 		if (nft_set_is_anonymous(set))
 			nft_deactivate_next(ctx->net, set);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		return;
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
-		set->use--;
+		nft_use_dec(&set->use);
 		/* fall through */
 	default:
 		nf_tables_unbind_set(ctx, set, binding,
@@ -4433,7 +4446,7 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 		}
 	}
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 	kfree(elem);
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
@@ -4542,8 +4555,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 				     set->objtype, genmask);
 		if (IS_ERR(obj)) {
 			err = PTR_ERR(obj);
+			obj = NULL;
+			goto err2;
+		}
+
+		if (!nft_use_inc(&obj->use)) {
+			err = -EMFILE;
+			obj = NULL;
 			goto err2;
 		}
+
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_OBJREF);
 	}
 
@@ -4608,10 +4629,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		udata->len = ulen - 1;
 		nla_memcpy(&udata->data, nla[NFTA_SET_ELEM_USERDATA], ulen);
 	}
-	if (obj) {
+	if (obj)
 		*nft_set_ext_obj(ext) = obj;
-		obj->use++;
-	}
 
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
 	if (trans == NULL)
@@ -4657,13 +4676,14 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 err5:
 	kfree(trans);
 err4:
-	if (obj)
-		obj->use--;
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
 		nft_data_release(&elem.data.val, desc.type);
 err2:
+	if (obj)
+		nft_use_dec_restore(&obj->use);
+
 	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 err1:
 	return err;
@@ -4723,11 +4743,14 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
  */
 void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 {
+	struct nft_chain *chain;
+
 	if (type == NFT_DATA_VERDICT) {
 		switch (data->verdict.code) {
 		case NFT_JUMP:
 		case NFT_GOTO:
-			data->verdict.chain->use++;
+			chain = data->verdict.chain;
+			nft_use_inc_restore(&chain->use);
 			break;
 		}
 	}
@@ -4742,7 +4765,7 @@ static void nft_set_elem_activate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_hold(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use++;
+		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
 static void nft_set_elem_deactivate(const struct net *net,
@@ -4754,7 +4777,7 @@ static void nft_set_elem_deactivate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_release(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 }
 
 static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
@@ -5151,9 +5174,14 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 
 	nft_ctx_init(&ctx, net, skb, nlh, family, table, NULL, nla);
 
+	if (!nft_use_inc(&table->use))
+		return -EMFILE;
+
 	type = nft_obj_type_get(net, objtype);
-	if (IS_ERR(type))
-		return PTR_ERR(type);
+	if (IS_ERR(type)) {
+		err = PTR_ERR(type);
+		goto err_type;
+	}
 
 	obj = nft_obj_init(&ctx, type, nla[NFTA_OBJ_DATA]);
 	if (IS_ERR(obj)) {
@@ -5174,7 +5202,7 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 		goto err3;
 
 	list_add_tail_rcu(&obj->list, &table->objects);
-	table->use++;
+
 	return 0;
 err3:
 	kfree(obj->name);
@@ -5184,6 +5212,9 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 	kfree(obj);
 err1:
 	module_put(type->owner);
+err_type:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -5519,6 +5550,22 @@ struct nft_flowtable *nft_flowtable_lookup(const struct nft_table *table,
 }
 EXPORT_SYMBOL_GPL(nft_flowtable_lookup);
 
+void nf_tables_deactivate_flowtable(const struct nft_ctx *ctx,
+				    struct nft_flowtable *flowtable,
+				    enum nft_trans_phase phase)
+{
+	switch (phase) {
+	case NFT_TRANS_PREPARE:
+	case NFT_TRANS_ABORT:
+	case NFT_TRANS_RELEASE:
+		nft_use_dec(&flowtable->use);
+		/* fall through */
+	default:
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(nf_tables_deactivate_flowtable);
+
 static struct nft_flowtable *
 nft_flowtable_lookup_byhandle(const struct nft_table *table,
 			      const struct nlattr *nla, u8 genmask)
@@ -5718,9 +5765,14 @@ static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 
 	nft_ctx_init(&ctx, net, skb, nlh, family, table, NULL, nla);
 
+	if (!nft_use_inc(&table->use))
+		return -EMFILE;
+
 	flowtable = kzalloc(sizeof(*flowtable), GFP_KERNEL);
-	if (!flowtable)
-		return -ENOMEM;
+	if (!flowtable) {
+		err = -ENOMEM;
+		goto flowtable_alloc;
+	}
 
 	flowtable->table = table;
 	flowtable->handle = nf_tables_alloc_handle(table);
@@ -5774,7 +5826,6 @@ static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 		goto err6;
 
 	list_add_tail_rcu(&flowtable->list, &table->flowtables);
-	table->use++;
 
 	return 0;
 err6:
@@ -5792,6 +5843,9 @@ static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 	kfree(flowtable->name);
 err1:
 	kfree(flowtable);
+flowtable_alloc:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -6666,7 +6720,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			 */
 			if (nft_set_is_anonymous(nft_trans_set(trans)) &&
 			    !list_empty(&nft_trans_set(trans)->bindings))
-				trans->ctx.table->use--;
+				nft_use_dec(&trans->ctx.table->use);
 
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_NEWSET, GFP_KERNEL);
@@ -6792,7 +6846,7 @@ static int __nf_tables_abort(struct net *net)
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				nft_chain_del(trans->ctx.chain);
 				nf_tables_unregister_hook(trans->ctx.net,
 							  trans->ctx.table,
@@ -6800,25 +6854,25 @@ static int __nf_tables_abort(struct net *net)
 			}
 			break;
 		case NFT_MSG_DELCHAIN:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, trans->ctx.chain);
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWRULE:
-			trans->ctx.chain->use--;
+			nft_use_dec_restore(&trans->ctx.chain->use);
 			list_del_rcu(&nft_trans_rule(trans)->list);
 			nft_rule_expr_deactivate(&trans->ctx,
 						 nft_trans_rule(trans),
 						 NFT_TRANS_ABORT);
 			break;
 		case NFT_MSG_DELRULE:
-			trans->ctx.chain->use++;
+			nft_use_inc_restore(&trans->ctx.chain->use);
 			nft_clear(trans->ctx.net, nft_trans_rule(trans));
 			nft_rule_expr_activate(&trans->ctx, nft_trans_rule(trans));
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSET:
-			trans->ctx.table->use--;
+			nft_use_dec_restore(&trans->ctx.table->use);
 			if (nft_trans_set_bound(trans)) {
 				nft_trans_destroy(trans);
 				break;
@@ -6826,7 +6880,7 @@ static int __nf_tables_abort(struct net *net)
 			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -6849,22 +6903,22 @@ static int __nf_tables_abort(struct net *net)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWOBJ:
-			trans->ctx.table->use--;
+			nft_use_dec_restore(&trans->ctx.table->use);
 			list_del_rcu(&nft_trans_obj(trans)->list);
 			break;
 		case NFT_MSG_DELOBJ:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_obj(trans));
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWFLOWTABLE:
-			trans->ctx.table->use--;
+			nft_use_dec_restore(&trans->ctx.table->use);
 			list_del_rcu(&nft_trans_flowtable(trans)->list);
 			nft_unregister_flowtable_net_hooks(net,
 					nft_trans_flowtable(trans));
 			break;
 		case NFT_MSG_DELFLOWTABLE:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_flowtable(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -7278,8 +7332,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 			return PTR_ERR(chain);
 		if (nft_is_base_chain(chain))
 			return -EOPNOTSUPP;
+		if (!nft_use_inc(&chain->use))
+			return -EMFILE;
 
-		chain->use++;
 		data->verdict.chain = chain;
 		break;
 	}
@@ -7291,10 +7346,13 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 static void nft_verdict_uninit(const struct nft_data *data)
 {
+	struct nft_chain *chain;
+
 	switch (data->verdict.code) {
 	case NFT_JUMP:
 	case NFT_GOTO:
-		data->verdict.chain->use--;
+		chain = data->verdict.chain;
+		nft_use_dec(&chain->use);
 		break;
 	}
 }
@@ -7447,11 +7505,11 @@ int __nft_release_basechain(struct nft_ctx *ctx)
 	nf_tables_unregister_hook(ctx->net, ctx->chain->table, ctx->chain);
 	list_for_each_entry_safe(rule, nr, &ctx->chain->rules, list) {
 		list_del(&rule->list);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		nf_tables_rule_release(ctx, rule);
 	}
 	nft_chain_del(ctx->chain);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nf_tables_chain_destroy(ctx);
 
 	return 0;
@@ -7480,29 +7538,29 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 		ctx.chain = chain;
 		list_for_each_entry_safe(rule, nr, &chain->rules, list) {
 			list_del(&rule->list);
-			chain->use--;
+			nft_use_dec(&chain->use);
 			nf_tables_rule_release(&ctx, rule);
 		}
 	}
 	list_for_each_entry_safe(flowtable, nf, &table->flowtables, list) {
 		list_del(&flowtable->list);
-		table->use--;
+		nft_use_dec(&table->use);
 		nf_tables_flowtable_destroy(flowtable);
 	}
 	list_for_each_entry_safe(set, ns, &table->sets, list) {
 		list_del(&set->list);
-		table->use--;
+		nft_use_dec(&table->use);
 		nft_set_destroy(set);
 	}
 	list_for_each_entry_safe(obj, ne, &table->objects, list) {
 		list_del(&obj->list);
-		table->use--;
+		nft_use_dec(&table->use);
 		nft_obj_destroy(&ctx, obj);
 	}
 	list_for_each_entry_safe(chain, nc, &table->chains, list) {
 		ctx.chain = chain;
 		nft_chain_del(chain);
-		table->use--;
+		nft_use_dec(&table->use);
 		nf_tables_chain_destroy(&ctx);
 	}
 	list_del(&table->list);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 166edea0e452..7055088e91c2 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -169,12 +169,31 @@ static int nft_flow_offload_init(const struct nft_ctx *ctx,
 	if (IS_ERR(flowtable))
 		return PTR_ERR(flowtable);
 
+	if (!nft_use_inc(&flowtable->use))
+		return -EMFILE;
+
 	priv->flowtable = flowtable;
-	flowtable->use++;
 
 	return nf_ct_netns_get(ctx->net, ctx->family);
 }
 
+static void nft_flow_offload_deactivate(const struct nft_ctx *ctx,
+					const struct nft_expr *expr,
+					enum nft_trans_phase phase)
+{
+	struct nft_flow_offload *priv = nft_expr_priv(expr);
+
+	nf_tables_deactivate_flowtable(ctx, priv->flowtable, phase);
+}
+
+static void nft_flow_offload_activate(const struct nft_ctx *ctx,
+				      const struct nft_expr *expr)
+{
+	struct nft_flow_offload *priv = nft_expr_priv(expr);
+
+	nft_use_inc_restore(&priv->flowtable->use);
+}
+
 static void nft_flow_offload_destroy(const struct nft_ctx *ctx,
 				     const struct nft_expr *expr)
 {
@@ -203,6 +222,8 @@ static const struct nft_expr_ops nft_flow_offload_ops = {
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_flow_offload)),
 	.eval		= nft_flow_offload_eval,
 	.init		= nft_flow_offload_init,
+	.activate	= nft_flow_offload_activate,
+	.deactivate	= nft_flow_offload_deactivate,
 	.destroy	= nft_flow_offload_destroy,
 	.validate	= nft_flow_offload_validate,
 	.dump		= nft_flow_offload_dump,
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 615f0fcf711c..2401e9fa17c4 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -43,8 +43,10 @@ static int nft_objref_init(const struct nft_ctx *ctx,
 	if (IS_ERR(obj))
 		return -ENOENT;
 
+	if (!nft_use_inc(&obj->use))
+		return -EMFILE;
+
 	nft_objref_priv(expr) = obj;
-	obj->use++;
 
 	return 0;
 }
@@ -73,7 +75,7 @@ static void nft_objref_deactivate(const struct nft_ctx *ctx,
 	if (phase == NFT_TRANS_COMMIT)
 		return;
 
-	obj->use--;
+	nft_use_dec(&obj->use);
 }
 
 static void nft_objref_activate(const struct nft_ctx *ctx,
@@ -81,7 +83,7 @@ static void nft_objref_activate(const struct nft_ctx *ctx,
 {
 	struct nft_object *obj = nft_objref_priv(expr);
 
-	obj->use++;
+	nft_use_inc_restore(&obj->use);
 }
 
 static struct nft_expr_type nft_objref_type;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index fb165286e76d..39ddfbda804e 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -370,18 +370,20 @@ static void __packet_set_status(struct packet_sock *po, void *frame, int status)
 {
 	union tpacket_uhdr h;
 
+	/* WRITE_ONCE() are paired with READ_ONCE() in __packet_get_status */
+
 	h.raw = frame;
 	switch (po->tp_version) {
 	case TPACKET_V1:
-		h.h1->tp_status = status;
+		WRITE_ONCE(h.h1->tp_status, status);
 		flush_dcache_page(pgv_to_page(&h.h1->tp_status));
 		break;
 	case TPACKET_V2:
-		h.h2->tp_status = status;
+		WRITE_ONCE(h.h2->tp_status, status);
 		flush_dcache_page(pgv_to_page(&h.h2->tp_status));
 		break;
 	case TPACKET_V3:
-		h.h3->tp_status = status;
+		WRITE_ONCE(h.h3->tp_status, status);
 		flush_dcache_page(pgv_to_page(&h.h3->tp_status));
 		break;
 	default:
@@ -398,17 +400,19 @@ static int __packet_get_status(struct packet_sock *po, void *frame)
 
 	smp_rmb();
 
+	/* READ_ONCE() are paired with WRITE_ONCE() in __packet_set_status */
+
 	h.raw = frame;
 	switch (po->tp_version) {
 	case TPACKET_V1:
 		flush_dcache_page(pgv_to_page(&h.h1->tp_status));
-		return h.h1->tp_status;
+		return READ_ONCE(h.h1->tp_status);
 	case TPACKET_V2:
 		flush_dcache_page(pgv_to_page(&h.h2->tp_status));
-		return h.h2->tp_status;
+		return READ_ONCE(h.h2->tp_status);
 	case TPACKET_V3:
 		flush_dcache_page(pgv_to_page(&h.h3->tp_status));
-		return h.h3->tp_status;
+		return READ_ONCE(h.h3->tp_status);
 	default:
 		WARN(1, "TPACKET version not supported.\n");
 		BUG();
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 93548b9e07cf..cf93dbe3d040 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -748,12 +748,10 @@ static void dist_free(struct disttable *d)
  * signed 16 bit values.
  */
 
-static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
-			  const struct nlattr *attr)
+static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 {
 	size_t n = nla_len(attr)/sizeof(__s16);
 	const __s16 *data = nla_data(attr);
-	spinlock_t *root_lock;
 	struct disttable *d;
 	int i;
 
@@ -768,13 +766,7 @@ static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
 	for (i = 0; i < n; i++)
 		d->table[i] = data[i];
 
-	root_lock = qdisc_root_sleeping_lock(sch);
-
-	spin_lock_bh(root_lock);
-	swap(*tbl, d);
-	spin_unlock_bh(root_lock);
-
-	dist_free(d);
+	*tbl = d;
 	return 0;
 }
 
@@ -930,6 +922,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_NETEM_MAX + 1];
+	struct disttable *delay_dist = NULL;
+	struct disttable *slot_dist = NULL;
 	struct tc_netem_qopt *qopt;
 	struct clgstate old_clg;
 	int old_loss_model = CLG_RANDOM;
@@ -943,6 +937,18 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	if (ret < 0)
 		return ret;
 
+	if (tb[TCA_NETEM_DELAY_DIST]) {
+		ret = get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DIST]);
+		if (ret)
+			goto table_free;
+	}
+
+	if (tb[TCA_NETEM_SLOT_DIST]) {
+		ret = get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST]);
+		if (ret)
+			goto table_free;
+	}
+
 	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
@@ -952,26 +958,17 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
 		if (ret) {
 			q->loss_model = old_loss_model;
+			q->clg = old_clg;
 			goto unlock;
 		}
 	} else {
 		q->loss_model = CLG_RANDOM;
 	}
 
-	if (tb[TCA_NETEM_DELAY_DIST]) {
-		ret = get_dist_table(sch, &q->delay_dist,
-				     tb[TCA_NETEM_DELAY_DIST]);
-		if (ret)
-			goto get_table_failure;
-	}
-
-	if (tb[TCA_NETEM_SLOT_DIST]) {
-		ret = get_dist_table(sch, &q->slot_dist,
-				     tb[TCA_NETEM_SLOT_DIST]);
-		if (ret)
-			goto get_table_failure;
-	}
-
+	if (delay_dist)
+		swap(q->delay_dist, delay_dist);
+	if (slot_dist)
+		swap(q->slot_dist, slot_dist);
 	sch->limit = qopt->limit;
 
 	q->latency = PSCHED_TICKS2NS(qopt->latency);
@@ -1021,17 +1018,11 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 
 unlock:
 	sch_tree_unlock(sch);
-	return ret;
 
-get_table_failure:
-	/* recover clg and loss_model, in case of
-	 * q->clg and q->loss_model were modified
-	 * in get_loss_clg()
-	 */
-	q->clg = old_clg;
-	q->loss_model = old_loss_model;
-
-	goto unlock;
+table_free:
+	dist_free(delay_dist);
+	dist_free(slot_dist);
+	return ret;
 }
 
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/tools/testing/radix-tree/regression1.c b/tools/testing/radix-tree/regression1.c
index 0aece092f40e..a247026042d4 100644
--- a/tools/testing/radix-tree/regression1.c
+++ b/tools/testing/radix-tree/regression1.c
@@ -198,7 +198,7 @@ void regression1_test(void)
 	nr_threads = 2;
 	pthread_barrier_init(&worker_barrier, NULL, nr_threads);
 
-	threads = malloc(nr_threads * sizeof(pthread_t *));
+	threads = malloc(nr_threads * sizeof(*threads));
 
 	for (i = 0; i < nr_threads; i++) {
 		arg = i;
