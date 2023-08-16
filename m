Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381E977E6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbjHPQlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344464AbjHPQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:41:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588719A4;
        Wed, 16 Aug 2023 09:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2967C66C26;
        Wed, 16 Aug 2023 16:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC04C433C7;
        Wed, 16 Aug 2023 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692204074;
        bh=UWkcWiF+vk1CYexZ1claScfidpdgtFSuW7UBfOTBWAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRgvuEG9h0r26OJEqe92gKLOGPKgYV7VEcXzRgdTOCztv/MNFxwVg1BW2EMCWoeBF
         +SSLUlB2GhBDR7khgCbX5xWGuO+AnXPSIRzRhBfFMg9HJ+sqrvaXs/rH9dVU2VEijY
         CisHK7KI+unBCywgFbOwi1PNj59rUOemCGzda+go=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.127
Date:   Wed, 16 Aug 2023 18:41:04 +0200
Message-ID: <2023081604-legibly-chase-253c@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081604-spinning-bulk-9730@gregkh>
References: <2023081604-spinning-bulk-9730@gregkh>
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
index 42993220a57a..f5e69631ca58 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 126
+SUBLEVEL = 127
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index b4fbbba30aa2..8c4c14a171e2 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -385,8 +385,7 @@ setup_memory(void *kernel_end)
 #endif /* CONFIG_BLK_DEV_INITRD */
 }
 
-int __init
-page_is_ram(unsigned long pfn)
+int page_is_ram(unsigned long pfn)
 {
 	struct memclust_struct * cluster;
 	struct memdesc_struct * memdesc;
diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index aff6c33ab0c0..4c58ee7f95ec 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -101,9 +101,9 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * Relaxed I/O memory access primitives. These follow the Device memory
  * ordering rules but do not guarantee any ordering relative to Normal memory
  * accesses.  These are defined to order the indicated access (either a read or
- * write) with all other I/O memory accesses. Since the platform specification
- * defines that all I/O regions are strongly ordered on channel 2, no explicit
- * fences are required to enforce this ordering.
+ * write) with all other I/O memory accesses to the same peripheral. Since the
+ * platform specification defines that all I/O regions are strongly ordered on
+ * channel 0, no explicit fences are required to enforce this ordering.
  */
 /* FIXME: These are now the same as asm-generic */
 #define __io_rbr()		do {} while (0)
@@ -125,14 +125,14 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #endif
 
 /*
- * I/O memory access primitives. Reads are ordered relative to any
- * following Normal memory access. Writes are ordered relative to any prior
- * Normal memory access.  The memory barriers here are necessary as RISC-V
+ * I/O memory access primitives.  Reads are ordered relative to any following
+ * Normal memory read and delay() loop.  Writes are ordered relative to any
+ * prior Normal memory write.  The memory barriers here are necessary as RISC-V
  * doesn't define any ordering between the memory space and the I/O space.
  */
 #define __io_br()	do {} while (0)
-#define __io_ar(v)	__asm__ __volatile__ ("fence i,r" : : : "memory")
-#define __io_bw()	__asm__ __volatile__ ("fence w,o" : : : "memory")
+#define __io_ar(v)	({ __asm__ __volatile__ ("fence i,ir" : : : "memory"); })
+#define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); })
 #define __io_aw()	mmiowb_set_pending()
 
 #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 1000d457c332..a380f7ecdd54 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -322,8 +322,8 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 
 	/* Round the lowest possible end address up to a PMD boundary. */
 	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= TASK_SIZE_MAX)
-		end = TASK_SIZE_MAX;
+	if (end >= DEFAULT_MAP_WINDOW)
+		end = DEFAULT_MAP_WINDOW;
 	end -= len;
 
 	if (end > start) {
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index aec714ea8230..bbbf27cfe701 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -859,4 +859,6 @@ enum mds_mitigations {
 	MDS_MITIGATION_VMWERV,
 };
 
+extern bool gds_ucode_mitigated(void);
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 77f4dfb0662e..0ca7123417ab 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -73,6 +73,7 @@ static const int amd_erratum_1054[] =
 static const int amd_zenbleed[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
+			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
 
 static const int amd_div0[] =
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 50aaf0cd8f46..7f3fa72a236a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -518,11 +518,17 @@ INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_CPU_SRSO
 /*
- * GNU ld cannot do XOR so do: (A | B) - (A & B) in order to compute the XOR
+ * GNU ld cannot do XOR until 2.41.
+ * https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f6f78318fca803c4907fb8d7f6ded8295f1947b1
+ *
+ * LLVM lld cannot do XOR until lld-17.
+ * https://github.com/llvm/llvm-project/commit/fae96104d4378166cbe5c875ef8ed808a356f3fb
+ *
+ * Instead do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((srso_untrain_ret_alias | srso_safe_ret_alias) -
-		(srso_untrain_ret_alias & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_untrain_ret_alias) | srso_safe_ret_alias) -
+		(ABSOLUTE(srso_untrain_ret_alias) & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2686c4dcdb1a..a26200c3e82b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -303,8 +303,6 @@ static struct kmem_cache *x86_fpu_cache;
 
 static struct kmem_cache *x86_emulator_cache;
 
-extern bool gds_ucode_mitigated(void);
-
 /*
  * When called, it means the previous get/set msr reached an invalid msr.
  * Return true if we want to ignore/silent this failed msr access.
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index a4749b6c3d73..cbbed43baf05 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6412,6 +6412,7 @@ static int __init binder_init(void)
 
 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	binder_alloc_shrinker_exit();
 
 	return ret;
 }
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index db01c5d423e6..54cee2b31c8e 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1091,6 +1091,12 @@ int binder_alloc_shrinker_init(void)
 	return ret;
 }
 
+void binder_alloc_shrinker_exit(void)
+{
+	unregister_shrinker(&binder_shrinker);
+	list_lru_destroy(&binder_alloc_lru);
+}
+
 /**
  * check_buffer() - verify that buffer/offset is safe to access
  * @alloc: binder_alloc for this proc
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 7dea57a84c79..399f2b269f2c 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -131,6 +131,7 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 						  int pid);
 extern void binder_alloc_init(struct binder_alloc *alloc);
 extern int binder_alloc_shrinker_init(void);
+extern void binder_alloc_shrinker_exit(void);
 extern void binder_alloc_vma_close(struct binder_alloc *alloc);
 extern struct binder_buffer *
 binder_alloc_prepare_to_free(struct binder_alloc *alloc,
diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
index e12b754e6398..60d3c5f09ad6 100644
--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@ -191,7 +191,13 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	chans = pdata->dma_channels;
+	if (!pdata->dma_channels) {
+		dev_info(&pdev->dev, "setting default channel number to 64");
+		chans = 64;
+	} else {
+		chans = pdata->dma_channels;
+	}
+
 	len = sizeof(*mcf_edma) + sizeof(*mcf_chan) * chans;
 	mcf_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
 	if (!mcf_edma)
@@ -203,11 +209,6 @@ static int mcf_edma_probe(struct platform_device *pdev)
 	mcf_edma->drvdata = &mcf_data;
 	mcf_edma->big_endian = 1;
 
-	if (!mcf_edma->n_chans) {
-		dev_info(&pdev->dev, "setting default channel number to 64");
-		mcf_edma->n_chans = 64;
-	}
-
 	mutex_init(&mcf_edma->fsl_edma_mutex);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index b9bc82d6a162..ec8a1565630b 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -403,6 +403,12 @@ enum desc_status {
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
@@ -2041,7 +2047,7 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 	list_for_each_entry(desc, &pch->work_list, node) {
 
 		/* If already submitted */
-		if (desc->status == BUSY)
+		if (desc->status == BUSY || desc->status == PAUSED)
 			continue;
 
 		ret = pl330_submit_req(pch->thread, desc);
@@ -2326,6 +2332,7 @@ static int pl330_pause(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct pl330_dmac *pl330 = pch->dmac;
+	struct dma_pl330_desc *desc;
 	unsigned long flags;
 
 	pm_runtime_get_sync(pl330->ddma.dev);
@@ -2335,6 +2342,10 @@ static int pl330_pause(struct dma_chan *chan)
 	_stop(pch->thread);
 	spin_unlock(&pl330->lock);
 
+	list_for_each_entry(desc, &pch->work_list, node) {
+		if (desc->status == BUSY)
+			desc->status = PAUSED;
+	}
 	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_mark_last_busy(pl330->ddma.dev);
 	pm_runtime_put_autosuspend(pl330->ddma.dev);
@@ -2425,7 +2436,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		else if (running && desc == running)
 			transferred =
 				pl330_get_current_xferred_count(pch, desc);
-		else if (desc->status == BUSY)
+		else if (desc->status == BUSY || desc->status == PAUSED)
 			/*
 			 * Busy but not running means either just enqueued,
 			 * or finished and not yet marked done
@@ -2442,6 +2453,9 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 			case DONE:
 				ret = DMA_COMPLETE;
 				break;
+			case PAUSED:
+				ret = DMA_PAUSED;
+				break;
 			case PREP:
 			case BUSY:
 				ret = DMA_IN_PROGRESS;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 23a52d47e61c..0601c17426af 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -355,8 +355,11 @@ void dpp3_set_cursor_attributes(
 	int cur_rom_en = 0;
 
 	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
-		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA)
-		cur_rom_en = 1;
+		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
+		if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
+			cur_rom_en = 1;
+		}
+	}
 
 	REG_UPDATE_3(CURSOR0_CONTROL,
 			CUR0_MODE, color_format,
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 0c2968052b66..54f1ab3071f9 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -591,7 +591,13 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 	int ret;
 
 	if (obj->import_attach) {
+		/* Reset both vm_ops and vm_private_data, so we don't end up with
+		 * vm_ops pointing to our implementation if the dma-buf backend
+		 * doesn't set those fields.
+		 */
 		vma->vm_private_data = NULL;
+		vma->vm_ops = NULL;
+
 		ret = dma_buf_mmap(obj->dma_buf, vma, 0);
 
 		/* Drop the reference drm_gem_mmap_obj() acquired.*/
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 7f8607b97707..fe6c650d23ce 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -966,7 +966,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	/* Determine display colour depth for everything except LVDS now,
 	 * DP requires this before mode_valid() is called.
 	 */
-	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
+	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
 		nouveau_connector_detect_depth(connector);
 
 	/* Find the native mode if this is a digital panel, if we didn't
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
index 32bbddc0993e..679aff79f4d6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
@@ -123,6 +123,7 @@ void gk104_grctx_generate_r418800(struct gf100_gr *);
 
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
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 26a3ed142b6b..cfe13b203b89 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -820,12 +820,12 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	 * need align with 2 pixel.
 	 */
 	if (fb->format->is_yuv && ((new_plane_state->src.x1 >> 16) % 2)) {
-		DRM_ERROR("Invalid Source: Yuv format not support odd xpos\n");
+		DRM_DEBUG_KMS("Invalid Source: Yuv format not support odd xpos\n");
 		return -EINVAL;
 	}
 
 	if (fb->format->is_yuv && new_plane_state->rotation & DRM_MODE_REFLECT_Y) {
-		DRM_ERROR("Invalid Source: Yuv format does not support this rotation\n");
+		DRM_DEBUG_KMS("Invalid Source: Yuv format does not support this rotation\n");
 		return -EINVAL;
 	}
 
@@ -833,7 +833,7 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 		struct vop *vop = to_vop(crtc);
 
 		if (!vop->data->afbc) {
-			DRM_ERROR("vop does not support AFBC\n");
+			DRM_DEBUG_KMS("vop does not support AFBC\n");
 			return -EINVAL;
 		}
 
@@ -842,15 +842,16 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 			return ret;
 
 		if (new_plane_state->src.x1 || new_plane_state->src.y1) {
-			DRM_ERROR("AFBC does not support offset display, xpos=%d, ypos=%d, offset=%d\n",
-				  new_plane_state->src.x1,
-				  new_plane_state->src.y1, fb->offsets[0]);
+			DRM_DEBUG_KMS("AFBC does not support offset display, " \
+				      "xpos=%d, ypos=%d, offset=%d\n",
+				      new_plane_state->src.x1, new_plane_state->src.y1,
+				      fb->offsets[0]);
 			return -EINVAL;
 		}
 
 		if (new_plane_state->rotation && new_plane_state->rotation != DRM_MODE_ROTATE_0) {
-			DRM_ERROR("No rotation support in AFBC, rotation=%d\n",
-				  new_plane_state->rotation);
+			DRM_DEBUG_KMS("No rotation support in AFBC, rotation=%d\n",
+				      new_plane_state->rotation);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
index 4100eefb7ac3..61c195f8fd3b 100644
--- a/drivers/hwmon/pmbus/bel-pfe.c
+++ b/drivers/hwmon/pmbus/bel-pfe.c
@@ -17,12 +17,13 @@
 enum chips {pfe1100, pfe3000};
 
 /*
- * Disable status check for pfe3000 devices, because some devices report
- * communication error (invalid command) for VOUT_MODE command (0x20)
- * although correct VOUT_MODE (0x16) is returned: it leads to incorrect
- * exponent in linear mode.
+ * Disable status check because some devices report communication error
+ * (invalid command) for VOUT_MODE command (0x20) although the correct
+ * VOUT_MODE (0x16) is returned: it leads to incorrect exponent in linear
+ * mode.
+ * This affects both pfe3000 and pfe1100.
  */
-static struct pmbus_platform_data pfe3000_plat_data = {
+static struct pmbus_platform_data pfe_plat_data = {
 	.flags = PMBUS_SKIP_STATUS_CHECK,
 };
 
@@ -94,16 +95,15 @@ static int pfe_pmbus_probe(struct i2c_client *client)
 	int model;
 
 	model = (int)i2c_match_id(pfe_device_id, client)->driver_data;
+	client->dev.platform_data = &pfe_plat_data;
 
 	/*
 	 * PFE3000-12-069RA devices may not stay in page 0 during device
 	 * probe which leads to probe failure (read status word failed).
 	 * So let's set the device to page 0 at the beginning.
 	 */
-	if (model == pfe3000) {
-		client->dev.platform_data = &pfe3000_plat_data;
+	if (model == pfe3000)
 		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
-	}
 
 	return pmbus_do_probe(client, &pfe_driver_info[model]);
 }
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index a4b2ff9e0dd5..9403c2604066 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -124,6 +124,7 @@ static const struct regmap_config ina2xx_regmap_config = {
 enum ina2xx_ids { ina219, ina226 };
 
 struct ina2xx_config {
+	const char *name;
 	u16 config_default;
 	int calibration_value;
 	int shunt_voltage_lsb;	/* nV */
@@ -155,6 +156,7 @@ struct ina2xx_chip_info {
 
 static const struct ina2xx_config ina2xx_config[] = {
 	[ina219] = {
+		.name = "ina219",
 		.config_default = INA219_CONFIG_DEFAULT,
 		.calibration_value = 4096,
 		.shunt_voltage_lsb = 10000,
@@ -164,6 +166,7 @@ static const struct ina2xx_config ina2xx_config[] = {
 		.chip_id = ina219,
 	},
 	[ina226] = {
+		.name = "ina226",
 		.config_default = INA226_CONFIG_DEFAULT,
 		.calibration_value = 2048,
 		.shunt_voltage_lsb = 2500,
@@ -999,7 +1002,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	/* Patch the current config register with default. */
 	val = chip->config->config_default;
 
-	if (id->driver_data == ina226) {
+	if (type == ina226) {
 		ina226_set_average(chip, INA226_DEFAULT_AVG, &val);
 		ina226_set_int_time_vbus(chip, INA226_DEFAULT_IT, &val);
 		ina226_set_int_time_vshunt(chip, INA226_DEFAULT_IT, &val);
@@ -1018,7 +1021,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	}
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (id->driver_data == ina226) {
+	if (type == ina226) {
 		indio_dev->channels = ina226_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ina226_channels);
 		indio_dev->info = &ina226_info;
@@ -1027,7 +1030,7 @@ static int ina2xx_probe(struct i2c_client *client,
 		indio_dev->num_channels = ARRAY_SIZE(ina219_channels);
 		indio_dev->info = &ina219_info;
 	}
-	indio_dev->name = id->name;
+	indio_dev->name = id ? id->name : chip->config->name;
 
 	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
 					  INDIO_BUFFER_SOFTWARE,
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b0c1dc8cc4c5..f529c01ac66b 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -259,7 +259,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	platform_set_drvdata(pdev, indio_dev);
 
 	state->ec = ec->ec_dev;
-	state->msg = devm_kzalloc(&pdev->dev,
+	state->msg = devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
 				max((u16)sizeof(struct ec_params_motion_sense),
 				state->ec->max_response), GFP_KERNEL);
 	if (!state->msg)
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 86d479772fbc..957634eceba8 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -85,6 +85,8 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	dma_addr_t mask;
 	int i;
 
+	umem->iova = va = virt;
+
 	if (umem->is_odp) {
 		unsigned int page_size = BIT(to_ib_umem_odp(umem)->page_shift);
 
@@ -100,7 +102,6 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	 */
 	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
 
-	umem->iova = va = virt;
 	/* The best result is the smallest page size that results in the minimum
 	 * number of required pages. Compute the largest page size that could
 	 * work based on VA address bits that don't change.
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 689921dc3d4a..b69dd618146e 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -12306,6 +12306,7 @@ static void free_cntrs(struct hfi1_devdata *dd)
 
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
index 6d2088fbaf69..1b73af501397 100644
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
index 386084530c2f..fae95f166688 100644
--- a/drivers/isdn/mISDN/dsp_core.c
+++ b/drivers/isdn/mISDN/dsp_core.c
@@ -1195,7 +1195,7 @@ static int __init dsp_init(void)
 	}
 
 	/* set sample timer */
-	timer_setup(&dsp_spl_tl, (void *)dsp_cmx_send, 0);
+	timer_setup(&dsp_spl_tl, dsp_cmx_send, 0);
 	dsp_spl_tl.expires = jiffies + dsp_tics;
 	dsp_spl_jiffies = dsp_spl_tl.expires;
 	add_timer(&dsp_spl_tl);
diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 4bcfbc9afbac..0f106d700625 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -171,7 +171,7 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x00);
 
-	if (option->force_clkreq_0)
+	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
 				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index ffc128278613..282a03520cf5 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -427,17 +427,10 @@ static void rts5228_init_from_cfg(struct rtsx_pcr *pcr)
 			option->ltr_enabled = false;
 		}
 	}
-
-	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
-				| PM_L1_1_EN | PM_L1_2_EN))
-		option->force_clkreq_0 = false;
-	else
-		option->force_clkreq_0 = true;
 }
 
 static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 
 	rtsx_pci_write_register(pcr, RTS5228_AUTOLOAD_CFG1,
 			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
@@ -468,17 +461,6 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
-	/*
-	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
-	 * to drive low, and we forcibly request clock.
-	 */
-	if (option->force_clkreq_0)
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
-	else
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
-
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 	rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 53f3a1f45c4a..6b5e4bdf209d 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -302,12 +302,11 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
 		}
 	}
 
-
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
 	 * to drive low, and we forcibly request clock.
 	 */
-	if (option->force_clkreq_0)
+	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
 		rtsx_pci_write_register(pcr, PETXCFG,
 			FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 9b42b20a3e5a..79b18f6f73a8 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -517,17 +517,10 @@ static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 			option->ltr_enabled = false;
 		}
 	}
-
-	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
-				| PM_L1_1_EN | PM_L1_2_EN))
-		option->force_clkreq_0 = false;
-	else
-		option->force_clkreq_0 = true;
 }
 
 static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 
 	/* Set mcu_cnt to 7 to ensure data can be sampled properly */
 	rtsx_pci_write_register(pcr, 0xFC03, 0x7F, 0x07);
@@ -546,17 +539,6 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 
 	rts5260_init_hw(pcr);
 
-	/*
-	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
-	 * to drive low, and we forcibly request clock.
-	 */
-	if (option->force_clkreq_0)
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
-	else
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
-
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 
 	return 0;
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 1fd4e0e50730..2a97eeb0e509 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -468,17 +468,10 @@ static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 			option->ltr_enabled = false;
 		}
 	}
-
-	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
-				| PM_L1_1_EN | PM_L1_2_EN))
-		option->force_clkreq_0 = false;
-	else
-		option->force_clkreq_0 = true;
 }
 
 static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 	u32 val;
 
 	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG1,
@@ -524,17 +517,6 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
-	/*
-	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
-	 * to drive low, and we forcibly request clock.
-	 */
-	if (option->force_clkreq_0)
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
-	else
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
-
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 	rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 62fdbbd55e74..c0bf747305e2 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1400,8 +1400,11 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 			return err;
 	}
 
-	if (pcr->aspm_mode == ASPM_MODE_REG)
+	if (pcr->aspm_mode == ASPM_MODE_REG) {
 		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
+		rtsx_pci_write_register(pcr, PETXCFG,
+				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+	}
 
 	/* No CD interrupt if probing driver with card inserted.
 	 * So we need to initialize pcr->card_exist here.
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 52ed30f2d9f4..94e9a08bc90e 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -338,13 +338,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
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
index 69cc36c0840f..e64c652b78f0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5491,7 +5491,9 @@ void bond_setup(struct net_device *bond_dev)
 
 	bond_dev->hw_features = BOND_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
-				NETIF_F_HW_VLAN_CTAG_FILTER;
+				NETIF_F_HW_VLAN_CTAG_FILTER |
+				NETIF_F_HW_VLAN_STAG_RX |
+				NETIF_F_HW_VLAN_STAG_FILTER;
 
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	bond_dev->features |= bond_dev->hw_features;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index bfdc021f4a19..847ebb31d470 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -70,6 +70,8 @@ static void hclge_sync_mac_table(struct hclge_dev *hdev);
 static void hclge_restore_hw_table(struct hclge_dev *hdev);
 static void hclge_sync_promisc_mode(struct hclge_dev *hdev);
 static void hclge_sync_fd_table(struct hclge_dev *hdev);
+static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret,
+				      int wait_cnt);
 
 static struct hnae3_ae_algo ae_algo;
 
@@ -7656,6 +7658,8 @@ static void hclge_enable_fd(struct hnae3_handle *handle, bool enable)
 
 static void hclge_cfg_mac_mode(struct hclge_dev *hdev, bool enable)
 {
+#define HCLGE_LINK_STATUS_WAIT_CNT  3
+
 	struct hclge_desc desc;
 	struct hclge_config_mac_mode_cmd *req =
 		(struct hclge_config_mac_mode_cmd *)desc.data;
@@ -7680,9 +7684,15 @@ static void hclge_cfg_mac_mode(struct hclge_dev *hdev, bool enable)
 	req->txrx_pad_fcs_loop_en = cpu_to_le32(loop_en);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret)
+	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"mac enable fail, ret =%d.\n", ret);
+		return;
+	}
+
+	if (!enable)
+		hclge_mac_link_status_wait(hdev, HCLGE_LINK_STATUS_DOWN,
+					   HCLGE_LINK_STATUS_WAIT_CNT);
 }
 
 static int hclge_config_switch_param(struct hclge_dev *hdev, int vfid,
@@ -7745,10 +7755,9 @@ static void hclge_phy_link_status_wait(struct hclge_dev *hdev,
 	} while (++i < HCLGE_PHY_LINK_STATUS_NUM);
 }
 
-static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret)
+static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret,
+				      int wait_cnt)
 {
-#define HCLGE_MAC_LINK_STATUS_NUM  100
-
 	int link_status;
 	int i = 0;
 	int ret;
@@ -7761,13 +7770,15 @@ static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret)
 			return 0;
 
 		msleep(HCLGE_LINK_STATUS_MS);
-	} while (++i < HCLGE_MAC_LINK_STATUS_NUM);
+	} while (++i < wait_cnt);
 	return -EBUSY;
 }
 
 static int hclge_mac_phy_link_status_wait(struct hclge_dev *hdev, bool en,
 					  bool is_phy)
 {
+#define HCLGE_MAC_LINK_STATUS_NUM  100
+
 	int link_ret;
 
 	link_ret = en ? HCLGE_LINK_STATUS_UP : HCLGE_LINK_STATUS_DOWN;
@@ -7775,7 +7786,8 @@ static int hclge_mac_phy_link_status_wait(struct hclge_dev *hdev, bool en,
 	if (is_phy)
 		hclge_phy_link_status_wait(hdev, link_ret);
 
-	return hclge_mac_link_status_wait(hdev, link_ret);
+	return hclge_mac_link_status_wait(hdev, link_ret,
+					  HCLGE_MAC_LINK_STATUS_NUM);
 }
 
 static int hclge_set_app_loopback(struct hclge_dev *hdev, bool en)
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 450b4fd9aa7f..890e27b986e2 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1007,12 +1007,22 @@ static int ibmvnic_login(struct net_device *netdev)
 
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
@@ -4220,11 +4230,14 @@ static int send_login(struct ibmvnic_adapter *adapter)
 	if (rc) {
 		adapter->login_pending = false;
 		netdev_err(adapter->netdev, "Failed to send login, rc=%d\n", rc);
-		goto buf_rsp_map_failed;
+		goto buf_send_failed;
 	}
 
 	return 0;
 
+buf_send_failed:
+	dma_unmap_single(dev, rsp_buffer_token, rsp_buffer_size,
+			 DMA_FROM_DEVICE);
 buf_rsp_map_failed:
 	kfree(login_rsp_buffer);
 	adapter->login_rsp_buf = NULL;
@@ -4788,6 +4801,7 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	int num_tx_pools;
 	int num_rx_pools;
 	u64 *size_array;
+	u32 rsp_len;
 	int i;
 
 	/* CHECK: Test/set of login_pending does not need to be atomic
@@ -4799,11 +4813,6 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	}
 	adapter->login_pending = false;
 
-	dma_unmap_single(dev, adapter->login_buf_token, adapter->login_buf_sz,
-			 DMA_TO_DEVICE);
-	dma_unmap_single(dev, adapter->login_rsp_buf_token,
-			 adapter->login_rsp_buf_sz, DMA_FROM_DEVICE);
-
 	/* If the number of queues requested can't be allocated by the
 	 * server, the login response will return with code 1. We will need
 	 * to resend the login buffer with fewer queues requested.
@@ -4839,6 +4848,23 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 		ibmvnic_reset(adapter, VNIC_RESET_FATAL);
 		return -EIO;
 	}
+
+	rsp_len = be32_to_cpu(login_rsp->len);
+	if (be32_to_cpu(login->login_rsp_len) < rsp_len ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_txsubm_subcrqs) ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_rxadd_subcrqs) ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_rxadd_buff_size) ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_supp_tx_desc)) {
+		/* This can happen if a login request times out and there are
+		 * 2 outstanding login requests sent, the LOGIN_RSP crq
+		 * could have been for the older login request. So we are
+		 * parsing the newer response buffer which may be incomplete
+		 */
+		dev_err(dev, "FATAL: Login rsp offsets/lengths invalid\n");
+		ibmvnic_reset(adapter, VNIC_RESET_FATAL);
+		return -EIO;
+	}
+
 	size_array = (u64 *)((u8 *)(adapter->login_rsp_buf) +
 		be32_to_cpu(adapter->login_rsp_buf->off_rxadd_buff_size));
 	/* variable buffer sizes are not supported, so just read the
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 5af3ae68b7a1..e622b6e6ac2b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1387,14 +1387,15 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	if (fsp->flow_type & FLOW_MAC_EXT)
 		return -EINVAL;
 
+	spin_lock_bh(&adapter->fdir_fltr_lock);
 	if (adapter->fdir_active_fltr >= IAVF_MAX_FDIR_FILTERS) {
+		spin_unlock_bh(&adapter->fdir_fltr_lock);
 		dev_err(&adapter->pdev->dev,
 			"Unable to add Flow Director filter because VF reached the limit of max allowed filters (%u)\n",
 			IAVF_MAX_FDIR_FILTERS);
 		return -ENOSPC;
 	}
 
-	spin_lock_bh(&adapter->fdir_fltr_lock);
 	if (iavf_find_fdir_fltr_by_loc(adapter, fsp->location)) {
 		dev_err(&adapter->pdev->dev, "Failed to add Flow Director filter, it already exists\n");
 		spin_unlock_bh(&adapter->fdir_fltr_lock);
@@ -1767,7 +1768,9 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	case ETHTOOL_GRXCLSRLCNT:
 		if (!FDIR_FLTR_SUPPORT(adapter))
 			break;
+		spin_lock_bh(&adapter->fdir_fltr_lock);
 		cmd->rule_cnt = adapter->fdir_active_fltr;
+		spin_unlock_bh(&adapter->fdir_fltr_lock);
 		cmd->data = IAVF_MAX_FDIR_FILTERS;
 		ret = 0;
 		break;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index 6146203efd84..505e82ebafe4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -722,7 +722,9 @@ void iavf_print_fdir_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *f
 bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr)
 {
 	struct iavf_fdir_fltr *tmp;
+	bool ret = false;
 
+	spin_lock_bh(&adapter->fdir_fltr_lock);
 	list_for_each_entry(tmp, &adapter->fdir_list_head, list) {
 		if (tmp->flow_type != fltr->flow_type)
 			continue;
@@ -732,11 +734,14 @@ bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *
 		    !memcmp(&tmp->ip_data, &fltr->ip_data,
 			    sizeof(fltr->ip_data)) &&
 		    !memcmp(&tmp->ext_data, &fltr->ext_data,
-			    sizeof(fltr->ext_data)))
-			return true;
+			    sizeof(fltr->ext_data))) {
+			ret = true;
+			break;
+		}
 	}
+	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
-	return false;
+	return ret;
 }
 
 /**
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 8490c0cf80a8..6fece284de0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -189,10 +189,15 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
 	clock = container_of(timer, struct mlx5_clock, timer);
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 
+	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		goto out;
+
 	write_seqlock_irqsave(&clock->lock, flags);
 	timecounter_read(&timer->tc);
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
+
+out:
 	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index e8185b69ac6c..373d3d4bf3a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -256,8 +256,7 @@ static u16 mlx5_get_max_vfs(struct mlx5_core_dev *dev)
 		host_total_vfs = MLX5_GET(query_esw_functions_out, out,
 					  host_params_context.host_total_vfs);
 		kvfree(out);
-		if (host_total_vfs)
-			return host_total_vfs;
+		return host_total_vfs;
 	}
 
 done:
diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 5ae39d236b30..ba61007bfc49 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1375,8 +1375,6 @@ static struct phy_driver at803x_driver[] = {
 	.flags			= PHY_POLL_CABLE_TEST,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
-	.set_wol		= at803x_set_wol,
-	.get_wol		= at803x_get_wol,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	/* PHY_BASIC_FEATURES */
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 924bdae314c8..e685c84ebe3a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1574,7 +1574,7 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	if (zerocopy)
 		return false;
 
-	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
+	if (SKB_DATA_ALIGN(len + TUN_RX_PAD + XDP_PACKET_HEADROOM) +
 	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
 		return false;
 
diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 5bf7822c53f1..0ba714ca5185 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -6,7 +6,7 @@
 #include "allowedips.h"
 #include "peer.h"
 
-enum { MAX_ALLOWEDIPS_BITS = 128 };
+enum { MAX_ALLOWEDIPS_DEPTH = 129 };
 
 static struct kmem_cache *node_cache;
 
@@ -42,7 +42,7 @@ static void push_rcu(struct allowedips_node **stack,
 		     struct allowedips_node __rcu *p, unsigned int *len)
 {
 	if (rcu_access_pointer(p)) {
-		if (WARN_ON(IS_ENABLED(DEBUG) && *len >= MAX_ALLOWEDIPS_BITS))
+		if (WARN_ON(IS_ENABLED(DEBUG) && *len >= MAX_ALLOWEDIPS_DEPTH))
 			return;
 		stack[(*len)++] = rcu_dereference_raw(p);
 	}
@@ -55,7 +55,7 @@ static void node_free_rcu(struct rcu_head *rcu)
 
 static void root_free_rcu(struct rcu_head *rcu)
 {
-	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_BITS] = {
+	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
 		container_of(rcu, struct allowedips_node, rcu) };
 	unsigned int len = 1;
 
@@ -68,7 +68,7 @@ static void root_free_rcu(struct rcu_head *rcu)
 
 static void root_remove_peer_lists(struct allowedips_node *root)
 {
-	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_BITS] = { root };
+	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = { root };
 	unsigned int len = 1;
 
 	while (len > 0 && (node = stack[--len])) {
diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index 41db10f9be49..2c9eec24eec4 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -593,16 +593,20 @@ bool __init wg_allowedips_selftest(void)
 	wg_allowedips_remove_by_peer(&t, a, &mutex);
 	test_negative(4, a, 192, 168, 0, 1);
 
-	/* These will hit the WARN_ON(len >= MAX_ALLOWEDIPS_BITS) in free_node
+	/* These will hit the WARN_ON(len >= MAX_ALLOWEDIPS_DEPTH) in free_node
 	 * if something goes wrong.
 	 */
-	for (i = 0; i < MAX_ALLOWEDIPS_BITS; ++i) {
-		part = cpu_to_be64(~(1LLU << (i % 64)));
-		memset(&ip, 0xff, 16);
-		memcpy((u8 *)&ip + (i < 64) * 8, &part, 8);
+	for (i = 0; i < 64; ++i) {
+		part = cpu_to_be64(~0LLU << i);
+		memset(&ip, 0xff, 8);
+		memcpy((u8 *)&ip + 8, &part, 8);
+		wg_allowedips_insert_v6(&t, &ip, 128, a, &mutex);
+		memcpy(&ip, &part, 8);
+		memset((u8 *)&ip + 8, 0, 8);
 		wg_allowedips_insert_v6(&t, &ip, 128, a, &mutex);
 	}
-
+	memset(&ip, 0, 16);
+	wg_allowedips_insert_v6(&t, &ip, 128, a, &mutex);
 	wg_allowedips_free(&t, &mutex);
 
 	wg_allowedips_init(&t);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2db9c166a1b7..b76e1d4adcc7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -989,6 +989,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_start_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -997,6 +998,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -1038,7 +1040,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fb47d0603e05..4ca7ef941600 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1888,6 +1888,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_start_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1896,6 +1897,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -2014,7 +2016,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (ctrl->queue_count <= 1)
 		return;
 	blk_mq_quiesce_queue(ctrl->admin_q);
-	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index a12e3525977d..2f810dac7b8b 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1599,7 +1599,7 @@ NCR_700_intr(int irq, void *dev_id)
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
-			} else if(dsp >= to32bit(&slot->pSG[0].ins) &&
+			} else if (slot && dsp >= to32bit(&slot->pSG[0].ins) &&
 				  dsp <= to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer = NCR_700_readl(host, DBC_REG) & 0xffffff;
 				int SGcount = (dsp - to32bit(&slot->pSG[0].ins))/sizeof(struct NCR_700_SG_List);
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index d084a7db3925..e6c36b5b0739 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -2172,7 +2172,7 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 				     bool new_sc)
 
 {
-	int ret = SUCCESS;
+	int ret = 0;
 	struct fnic_pending_aborts_iter_data iter_data = {
 		.fnic = fnic,
 		.lun_dev = lr_sc->device,
@@ -2192,9 +2192,11 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 
 	/* walk again to check, if IOs are still pending in fw */
 	if (fnic_is_abts_pending(fnic, lr_sc))
-		ret = FAILED;
+		ret = 1;
 
 clean_pending_aborts_end:
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			"%s: exit status: %d\n", __func__, ret);
 	return ret;
 }
 
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index cf10c1a60399..61959dd2237f 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -31,6 +31,7 @@ static void qedf_remove(struct pci_dev *pdev);
 static void qedf_shutdown(struct pci_dev *pdev);
 static void qedf_schedule_recovery_handler(void *dev);
 static void qedf_recovery_handler(struct work_struct *work);
+static int qedf_suspend(struct pci_dev *pdev, pm_message_t state);
 
 /*
  * Driver module parameters.
@@ -3276,6 +3277,7 @@ static struct pci_driver qedf_pci_driver = {
 	.probe = qedf_probe,
 	.remove = qedf_remove,
 	.shutdown = qedf_shutdown,
+	.suspend = qedf_suspend,
 };
 
 static int __qedf_probe(struct pci_dev *pdev, int mode)
@@ -4005,6 +4007,22 @@ static void qedf_shutdown(struct pci_dev *pdev)
 	__qedf_remove(pdev, QEDF_MODE_NORMAL);
 }
 
+static int qedf_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct qedf_ctx *qedf;
+
+	if (!pdev) {
+		QEDF_ERR(NULL, "pdev is NULL.\n");
+		return -ENODEV;
+	}
+
+	qedf = pci_get_drvdata(pdev);
+
+	QEDF_ERR(&qedf->dbg_ctx, "%s: Device does not support suspend operation\n", __func__);
+
+	return -EPERM;
+}
+
 /*
  * Recovery handler code
  */
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index e0096fc5927e..d2fe8ae97abc 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -69,6 +69,7 @@ static struct nvm_iscsi_block *qedi_get_nvram_block(struct qedi_ctx *qedi);
 static void qedi_recovery_handler(struct work_struct *work);
 static void qedi_schedule_hw_err_handler(void *dev,
 					 enum qed_hw_err_type err_type);
+static int qedi_suspend(struct pci_dev *pdev, pm_message_t state);
 
 static int qedi_iscsi_event_cb(void *context, u8 fw_event_code, void *fw_handle)
 {
@@ -2515,6 +2516,22 @@ static void qedi_shutdown(struct pci_dev *pdev)
 	__qedi_remove(pdev, QEDI_MODE_SHUTDOWN);
 }
 
+static int qedi_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct qedi_ctx *qedi;
+
+	if (!pdev) {
+		QEDI_ERR(NULL, "pdev is NULL.\n");
+		return -ENODEV;
+	}
+
+	qedi = pci_get_drvdata(pdev);
+
+	QEDI_ERR(&qedi->dbg_ctx, "%s: Device does not support suspend operation\n", __func__);
+
+	return -EPERM;
+}
+
 static int __qedi_probe(struct pci_dev *pdev, int mode)
 {
 	struct qedi_ctx *qedi;
@@ -2873,6 +2890,7 @@ static struct pci_driver qedi_pci_driver = {
 	.remove = qedi_remove,
 	.shutdown = qedi_shutdown,
 	.err_handler = &qedi_err_handler,
+	.suspend = qedi_suspend,
 };
 
 static int __init qedi_init(void)
diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 898a0bdf8df6..711252e52d8e 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -248,6 +248,7 @@ int raid_component_add(struct raid_template *r,struct device *raid_dev,
 	return 0;
 
 err_out:
+	put_device(&rc->dev);
 	list_del(&rc->node);
 	rd->component_count--;
 	put_device(component_dev);
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index d6982d355739..94603e64cc6b 100644
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
index 7cf871323b2c..c445853c623e 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -317,6 +317,7 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
+		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index e78cfda035a1..9f8ebbec7bc3 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1730,10 +1730,6 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
  */
 static enum blk_eh_timer_return storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 {
-#if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-	if (scmnd->device->host->transportt == fc_transport_template)
-		return fc_eh_timed_out(scmnd);
-#endif
 	return BLK_EH_RESET_TIMER;
 }
 
diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 0158148cb054..521c95935d4c 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -42,6 +42,7 @@ struct usb_conn_info {
 
 	struct power_supply_desc desc;
 	struct power_supply *charger;
+	bool initial_detection;
 };
 
 /*
@@ -86,11 +87,13 @@ static void usb_conn_detect_cable(struct work_struct *work)
 	dev_dbg(info->dev, "role %s -> %s, gpios: id %d, vbus %d\n",
 		usb_role_string(info->last_role), usb_role_string(role), id, vbus);
 
-	if (info->last_role == role) {
+	if (!info->initial_detection && info->last_role == role) {
 		dev_warn(info->dev, "repeated role: %s\n", usb_role_string(role));
 		return;
 	}
 
+	info->initial_detection = false;
+
 	if (info->last_role == USB_ROLE_HOST && info->vbus)
 		regulator_disable(info->vbus);
 
@@ -273,6 +276,7 @@ static int usb_conn_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 
 	/* Perform initial detection */
+	info->initial_detection = true;
 	usb_conn_queue_dwork(info, 0);
 
 	return 0;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 845c6041b385..d76a4837615d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4204,9 +4204,14 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
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
 
@@ -4470,6 +4475,8 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
 {
 	if (dwc->pending_events) {
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		pm_runtime_put(dwc->dev);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
 	}
diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 7e4ce0e7e05a..dcc4778d1ae9 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -318,7 +318,8 @@ static int alauda_get_media_status(struct us_data *us, unsigned char *data)
 	rc = usb_stor_ctrl_transfer(us, us->recv_ctrl_pipe,
 		command, 0xc0, 0, 1, data, 2);
 
-	usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
+	if (rc == USB_STOR_XFER_GOOD)
+		usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
 
 	return rc;
 }
@@ -454,9 +455,14 @@ static int alauda_init_media(struct us_data *us)
 static int alauda_check_media(struct us_data *us)
 {
 	struct alauda_info *info = (struct alauda_info *) us->extra;
-	unsigned char status[2];
+	unsigned char *status = us->iobuf;
+	int rc;
 
-	alauda_get_media_status(us, status);
+	rc = alauda_get_media_status(us, status);
+	if (rc != USB_STOR_XFER_GOOD) {
+		status[0] = 0xF0;	/* Pretend there's no media */
+		status[1] = 0;
+	}
 
 	/* Check for no media or door open */
 	if ((status[0] & 0x80) || ((status[0] & 0x1F) == 0x10)
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c6e5991b3868..f7e99757a50e 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5246,6 +5246,10 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 		/* Do nothing, vbus drop expected */
 		break;
 
+	case SNK_HARD_RESET_WAIT_VBUS:
+		/* Do nothing, its OK to receive vbus off events */
+		break;
+
 	default:
 		if (port->pwr_role == TYPEC_SINK && port->attached)
 			tcpm_set_state(port, SNK_UNATTACHED, tcpm_wait_for_discharge(port));
@@ -5292,6 +5296,9 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
 	case SNK_DEBOUNCED:
 		/*Do nothing, still waiting for VSAFE5V for connect */
 		break;
+	case SNK_HARD_RESET_WAIT_VBUS:
+		/* Do nothing, its OK to receive vbus off events */
+		break;
 	default:
 		if (port->pwr_role == TYPEC_SINK && port->auto_vbus_discharge_enabled)
 			tcpm_set_state(port, SNK_UNATTACHED, 0);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3c0b3b4ec5ad..4e35c6fb7be7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1437,7 +1437,8 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 		goto fail;
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
-	    !btrfs_is_data_reloc_root(root)) {
+	    !btrfs_is_data_reloc_root(root) &&
+	    is_fstree(root->root_key.objectid)) {
 		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
 		btrfs_check_and_init_root_item(&root->root_item);
 	}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 750c1ff9947d..597cc2607481 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4334,8 +4334,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			ret = 0;
 		}
 
-		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
+		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR)) {
+			if (!cache_block_group_error)
+				cache_block_group_error = -EIO;
 			goto loop;
+		}
 
 		bg_ret = NULL;
 		ret = do_allocation(block_group, &ffe_ctl, &bg_ret);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7bd704779a99..f9f6dfbc86bc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4844,11 +4844,12 @@ int btree_write_cache_pages(struct address_space *mapping,
 			}
 
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
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index becf3396d533..dd8d47958a81 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1905,7 +1905,39 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 				err = PTR_ERR(root);
 			break;
 		}
-		ASSERT(root->reloc_root == reloc_root);
+
+		if (unlikely(root->reloc_root != reloc_root)) {
+			if (root->reloc_root) {
+				btrfs_err(fs_info,
+"reloc tree mismatch, root %lld has reloc root key (%lld %u %llu) gen %llu, expect reloc root key (%lld %u %llu) gen %llu",
+					  root->root_key.objectid,
+					  root->reloc_root->root_key.objectid,
+					  root->reloc_root->root_key.type,
+					  root->reloc_root->root_key.offset,
+					  btrfs_root_generation(
+						  &root->reloc_root->root_item),
+					  reloc_root->root_key.objectid,
+					  reloc_root->root_key.type,
+					  reloc_root->root_key.offset,
+					  btrfs_root_generation(
+						  &reloc_root->root_item));
+			} else {
+				btrfs_err(fs_info,
+"reloc tree mismatch, root %lld has no reloc root, expect reloc root key (%lld %u %llu) gen %llu",
+					  root->root_key.objectid,
+					  reloc_root->root_key.objectid,
+					  reloc_root->root_key.type,
+					  reloc_root->root_key.offset,
+					  btrfs_root_generation(
+						  &reloc_root->root_item));
+			}
+			list_add(&reloc_root->root_list, &reloc_roots);
+			btrfs_put_root(root);
+			btrfs_abort_transaction(trans, -EUCLEAN);
+			if (!err)
+				err = -EUCLEAN;
+			break;
+		}
 
 		/*
 		 * set reference count to 1, so btrfs_recover_relocation
@@ -1978,7 +2010,7 @@ void merge_reloc_roots(struct reloc_control *rc)
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			if (IS_ERR(root)) {
+			if (WARN_ON(IS_ERR(root))) {
 				/*
 				 * For recovery we read the fs roots on mount,
 				 * and if we didn't find the root then we marked
@@ -1987,17 +2019,14 @@ void merge_reloc_roots(struct reloc_control *rc)
 				 * memory.  However there's no reason we can't
 				 * handle the error properly here just in case.
 				 */
-				ASSERT(0);
 				ret = PTR_ERR(root);
 				goto out;
 			}
-			if (root->reloc_root != reloc_root) {
+			if (WARN_ON(root->reloc_root != reloc_root)) {
 				/*
-				 * This is actually impossible without something
-				 * going really wrong (like weird race condition
-				 * or cosmic rays).
+				 * This can happen if on-disk metadata has some
+				 * corruption, e.g. bad reloc tree key offset.
 				 */
-				ASSERT(0);
 				ret = -EINVAL;
 				goto out;
 			}
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a84d2d489510..bd71c7369794 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -442,6 +442,20 @@ static int check_root_key(struct extent_buffer *leaf, struct btrfs_key *key,
 	btrfs_item_key_to_cpu(leaf, &item_key, slot);
 	is_root_item = (item_key.type == BTRFS_ROOT_ITEM_KEY);
 
+	/*
+	 * Bad rootid for reloc trees.
+	 *
+	 * Reloc trees are only for subvolume trees, other trees only need
+	 * to be COWed to be relocated.
+	 */
+	if (unlikely(is_root_item && key->objectid == BTRFS_TREE_RELOC_OBJECTID &&
+		     !is_fstree(key->offset))) {
+		generic_err(leaf, slot,
+		"invalid reloc tree for root %lld, root id is not a subvolume tree",
+			    key->offset);
+		return -EUCLEAN;
+	}
+
 	/* No such tree id */
 	if (unlikely(key->objectid == 0)) {
 		if (is_root_item)
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index c24674fc1904..8ef9503c4ab9 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -381,13 +381,13 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	}
 
 	if (smb2_req_struct_sizes[command] != pdu->StructureSize2) {
-		if (command == SMB2_OPLOCK_BREAK_HE &&
-		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_20 &&
-		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_21) {
+		if (!(command == SMB2_OPLOCK_BREAK_HE &&
+		    (le16_to_cpu(pdu->StructureSize2) == OP_BREAK_STRUCT_SIZE_20 ||
+		    le16_to_cpu(pdu->StructureSize2) == OP_BREAK_STRUCT_SIZE_21))) {
 			/* special case for SMB2.1 lease break message */
 			ksmbd_debug(SMB,
-				    "Illegal request size %d for oplock break\n",
-				    le16_to_cpu(pdu->StructureSize2));
+				"Illegal request size %u for command %d\n",
+				le16_to_cpu(pdu->StructureSize2), command);
 			return 1;
 		}
 	}
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 9f9d07caa57e..0fde3d12b346 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2309,9 +2309,16 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			break;
 		buf_len -= next;
 		eabuf = (struct smb2_ea_info *)((char *)eabuf + next);
-		if (next < (u32)eabuf->EaNameLength + le16_to_cpu(eabuf->EaValueLength))
+		if (buf_len < sizeof(struct smb2_ea_info)) {
+			rc = -EINVAL;
 			break;
+		}
 
+		if (buf_len < sizeof(struct smb2_ea_info) + eabuf->EaNameLength +
+				le16_to_cpu(eabuf->EaValueLength)) {
+			rc = -EINVAL;
+			break;
+		}
 	} while (next != 0);
 
 	kfree(attr_name);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index c1ab0bfc3ed5..b908216f306d 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1105,9 +1105,17 @@ int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
 
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
 		nilfs_warn(inode->i_sb,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 5c310eb7dd0c..9e865732d352 100644
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
index 987c8ab02aee..b36ba588ee69 100644
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
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d4c860de9a6a..caf3b95017bf 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -72,6 +72,8 @@ extern ssize_t cpu_show_retbleed(struct device *dev,
 				 struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
 					     struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_gds(struct device *dev,
+			    struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 6e18ca234f81..4273505d309a 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -63,6 +63,7 @@ struct sk_psock_progs {
 
 enum sk_psock_state_bits {
 	SK_PSOCK_TX_ENABLED,
+	SK_PSOCK_RX_STRP_ENABLED,
 };
 
 struct sk_psock_link {
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 27336fc70467..963a810ed70d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -510,6 +510,9 @@ ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 	if (WARN_ON(iftype >= NL80211_IFTYPE_MAX))
 		return NULL;
 
+	if (iftype == NL80211_IFTYPE_AP_VLAN)
+		iftype = NL80211_IFTYPE_AP;
+
 	for (i = 0; i < sband->n_iftype_data; i++)  {
 		const struct ieee80211_sband_iftype_data *data =
 			&sband->iftype_data[i];
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index d486bddda15d..1458b3eae8ad 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1144,6 +1144,29 @@ int __nft_release_basechain(struct nft_ctx *ctx);
 
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
@@ -1227,8 +1250,8 @@ struct nft_object {
 	struct list_head		list;
 	struct rhlist_head		rhlhead;
 	struct nft_object_hash_key	key;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	u64				handle;
 	u16				udlen;
 	u8				*udata;
@@ -1330,8 +1353,8 @@ struct nft_flowtable {
 	char				*name;
 	int				hooknum;
 	int				ops_len;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	u64				handle;
 	/* runtime data below here */
 	struct list_head		hook_list ____cacheline_aligned;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 6f1d88bfd690..7c98a820c8dd 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4375,9 +4375,11 @@ static int io_openat2(struct io_kiocb *req, unsigned int issue_flags)
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		/*
 		 * Don't bother trying for O_TRUNC, O_CREAT, or O_TMPFILE open,
-		 * it'll always -EAGAIN
+		 * it'll always -EAGAIN. Note that we test for __O_TMPFILE
+		 * because O_TMPFILE includes O_DIRECTORY, which isn't a flag
+		 * we need to force async for.
 		 */
-		if (req->open.how.flags & (O_TRUNC | O_CREAT | O_TMPFILE))
+		if (req->open.how.flags & (O_TRUNC | O_CREAT | __O_TMPFILE))
 			return -EAGAIN;
 		op.lookup_flags |= LOOKUP_CACHED;
 		op.open_flag |= O_NONBLOCK;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e1848a2a7230..ecf4332ff312 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -517,6 +517,12 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
 		func_id == BPF_FUNC_skc_to_tcp_request_sock;
 }
 
+static bool is_callback_calling_function(enum bpf_func_id func_id)
+{
+	return func_id == BPF_FUNC_for_each_map_elem ||
+	       func_id == BPF_FUNC_timer_set_callback;
+}
+
 static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 {
 	return BPF_CLASS(insn->code) == BPF_STX &&
@@ -1446,7 +1452,7 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
-	reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;
+	reg->precise = !env->bpf_capable;
 	__mark_reg_unbounded(reg);
 }
 
@@ -2267,6 +2273,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
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
@@ -2371,8 +2382,11 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 
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
@@ -2390,8 +2404,121 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
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
@@ -2409,6 +2536,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 	if (!env->bpf_capable)
 		return 0;
 
+	/* Do sanity checks against current state of register and/or stack
+	 * slot, but don't set precise flag in current state, as precision
+	 * tracking in the current state is unnecessary.
+	 */
 	func = st->frame[frame];
 	if (regno >= 0) {
 		reg = &func->regs[regno];
@@ -2416,11 +2547,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
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
@@ -2433,11 +2560,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
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
 
@@ -2445,12 +2568,42 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		return 0;
 	if (!reg_mask && !stack_mask)
 		return 0;
+
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
 		u32 history = st->jmp_history_cnt;
 
 		if (env->log.level & BPF_LOG_LEVEL)
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
@@ -5806,6 +5959,10 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
+static int set_callee_state(struct bpf_verifier_env *env,
+			    struct bpf_func_state *caller,
+			    struct bpf_func_state *callee, int insn_idx);
+
 static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx, int subprog,
 			     set_callee_state_fn set_callee_state_cb)
@@ -5856,6 +6013,16 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -10301,7 +10468,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (env->explore_alu_limits)
 			return false;
 		if (rcur->type == SCALAR_VALUE) {
-			if (!rold->precise && !rcur->precise)
+			if (!rold->precise)
 				return true;
 			/* new val must satisfy old val knowledge */
 			return range_within(rold, rcur) &&
@@ -10850,6 +11017,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	env->prev_jmps_processed = env->jmps_processed;
 	env->prev_insn_processed = env->insn_processed;
 
+	/* forget precise markings we inherited, see __mark_chain_precision */
+	if (env->bpf_capable)
+		mark_all_scalars_imprecise(env, cur);
+
 	/* add new state to the head of linked list */
 	new = &new_sl->state;
 	err = copy_verifier_state(new, cur);
@@ -13209,6 +13380,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno */,
 			subprog);
+	state->first_insn_idx = env->subprog_info[subprog].start;
+	state->last_insn_idx = -1;
 
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 322b65d45676..41f470929e99 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -595,7 +595,8 @@ void irq_enter_rcu(void)
 {
 	__irq_enter_raw();
 
-	if (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET))
+	if (tick_nohz_full_cpu(smp_processor_id()) ||
+	    (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET)))
 		tick_irq_enter();
 
 	account_hardirq_enter(current);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f42d0776bc84..7f5310d1a4d6 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -180,6 +180,8 @@ static ktime_t tick_init_jiffy_update(void)
 	return period;
 }
 
+#define MAX_STALLED_JIFFIES 5
+
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
@@ -207,6 +209,21 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	if (tick_do_timer_cpu == cpu)
 		tick_do_update_jiffies64(now);
 
+	/*
+	 * If jiffies update stalled for too long (timekeeper in stop_machine()
+	 * or VMEXIT'ed for several msecs), force an update.
+	 */
+	if (ts->last_tick_jiffies != jiffies) {
+		ts->stalled_jiffies = 0;
+		ts->last_tick_jiffies = READ_ONCE(jiffies);
+	} else {
+		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
+			tick_do_update_jiffies64(now);
+			ts->stalled_jiffies = 0;
+			ts->last_tick_jiffies = READ_ONCE(jiffies);
+		}
+	}
+
 	if (ts->inidle)
 		ts->got_idle_tick = 1;
 }
@@ -933,6 +950,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	if (unlikely(expires == KTIME_MAX)) {
 		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
 			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
@@ -1339,9 +1358,15 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
 
-	/* No need to reprogram if we are running tickless  */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		/*
+		 * The clockevent device is not reprogrammed, so change the
+		 * clock event device to ONESHOT_STOPPED to avoid spurious
+		 * interrupts on devices which might not be truly one shot.
+		 */
+		tick_program_event(KTIME_MAX, 1);
 		return;
+	}
 
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
@@ -1395,6 +1420,13 @@ static inline void tick_nohz_irq_enter(void)
 	now = ktime_get();
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
+	/*
+	 * If all CPUs are idle. We may need to update a stale jiffies value.
+	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
+	 * alive but it might be busy looping with interrupts disabled in some
+	 * rare case (typically stop machine). So we must make sure we have a
+	 * last resort.
+	 */
 	if (ts->tick_stopped)
 		tick_nohz_update_jiffies(now);
 }
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index d952ae393423..504649513399 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -49,6 +49,8 @@ enum tick_nohz_mode {
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @next_timer:		Expiry time of next expiring timer for debugging purpose only
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
+ * @last_tick_jiffies:	Value of jiffies seen on last tick
+ * @stalled_jiffies:	Number of stalled jiffies detected across ticks
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
@@ -77,6 +79,8 @@ struct tick_sched {
 	u64				next_timer;
 	ktime_t				idle_expires;
 	atomic_t			tick_dep_mask;
+	unsigned long			last_tick_jiffies;
+	unsigned int			stalled_jiffies;
 };
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
diff --git a/net/core/filter.c b/net/core/filter.c
index 18eb8049c795..458756334c4f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3843,12 +3843,6 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
 	if (unlikely(data_end > data_hard_end))
 		return -EINVAL;
 
-	/* ALL drivers MUST init xdp->frame_sz, chicken check below */
-	if (unlikely(xdp->frame_sz > PAGE_SIZE)) {
-		WARN_ONCE(1, "Too BIG xdp->frame_sz = %d\n", xdp->frame_sz);
-		return -EINVAL;
-	}
-
 	if (unlikely(data_end < xdp->data + ETH_HLEN))
 		return -EINVAL;
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index dc9b93d8f0d3..9cd14212dcd0 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1124,13 +1124,19 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 
 int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 {
+	int ret;
+
 	static const struct strp_callbacks cb = {
 		.rcv_msg	= sk_psock_strp_read,
 		.read_sock_done	= sk_psock_strp_read_done,
 		.parse_msg	= sk_psock_strp_parse,
 	};
 
-	return strp_init(&psock->strp, sk, &cb);
+	ret = strp_init(&psock->strp, sk, &cb);
+	if (!ret)
+		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
+
+	return ret;
 }
 
 void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
@@ -1158,7 +1164,7 @@ void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
 static void sk_psock_done_strp(struct sk_psock *psock)
 {
 	/* Parser has been stopped */
-	if (psock->progs.stream_parser)
+	if (sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED))
 		strp_done(&psock->strp);
 }
 #else
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 85d3c62bdfa6..caae43e66353 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -148,13 +148,13 @@ static void sock_map_del_link(struct sock *sk,
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		if (link->link_raw == link_raw) {
 			struct bpf_map *map = link->map;
-			struct bpf_stab *stab = container_of(map, struct bpf_stab,
-							     map);
-			if (psock->saved_data_ready && stab->progs.stream_parser)
+			struct sk_psock_progs *progs = sock_map_progs(map);
+
+			if (psock->saved_data_ready && progs->stream_parser)
 				strp_stop = true;
-			if (psock->saved_data_ready && stab->progs.stream_verdict)
+			if (psock->saved_data_ready && progs->stream_verdict)
 				verdict_stop = true;
-			if (psock->saved_data_ready && stab->progs.skb_verdict)
+			if (psock->saved_data_ready && progs->skb_verdict)
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);
diff --git a/net/dccp/output.c b/net/dccp/output.c
index b8a24734385e..fd2eb148d24d 100644
--- a/net/dccp/output.c
+++ b/net/dccp/output.c
@@ -187,7 +187,7 @@ unsigned int dccp_sync_mss(struct sock *sk, u32 pmtu)
 
 	/* And store cached results */
 	icsk->icsk_pmtu_cookie = pmtu;
-	dp->dccps_mss_cache = cur_mps;
+	WRITE_ONCE(dp->dccps_mss_cache, cur_mps);
 
 	return cur_mps;
 }
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index a23b19663601..5422d64af246 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -639,7 +639,7 @@ static int do_dccp_getsockopt(struct sock *sk, int level, int optname,
 		return dccp_getsockopt_service(sk, len,
 					       (__be32 __user *)optval, optlen);
 	case DCCP_SOCKOPT_GET_CUR_MPS:
-		val = dp->dccps_mss_cache;
+		val = READ_ONCE(dp->dccps_mss_cache);
 		break;
 	case DCCP_SOCKOPT_AVAILABLE_CCIDS:
 		return ccid_getsockopt_builtin_ccids(sk, len, optval, optlen);
@@ -748,7 +748,7 @@ int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	trace_dccp_probe(sk, len);
 
-	if (len > dp->dccps_mss_cache)
+	if (len > READ_ONCE(dp->dccps_mss_cache))
 		return -EMSGSIZE;
 
 	lock_sock(sk);
@@ -781,6 +781,12 @@ int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index cc1caab4a654..d3275d1ed260 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -224,7 +224,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 		.un.frag.__unused	= 0,
 		.un.frag.mtu		= htons(mtu),
 	};
-	icmph->checksum = ip_compute_csum(icmph, len);
+	icmph->checksum = csum_fold(skb_checksum(skb, 0, len, 0));
 	skb_reset_transport_header(skb);
 
 	niph = skb_push(skb, sizeof(*niph));
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6cc7d347ec0a..c140a36bd1e6 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3222,13 +3222,9 @@ static int rtm_dump_nexthop(struct sk_buff *skb, struct netlink_callback *cb)
 				     &rtm_dump_nexthop_cb, &filter);
 	if (err < 0) {
 		if (likely(skb->len))
-			goto out;
-		goto out_err;
+			err = skb->len;
 	}
 
-out:
-	err = skb->len;
-out_err:
 	cb->seq = net->nexthop.seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	return err;
@@ -3368,25 +3364,19 @@ static int rtm_dump_nexthop_bucket_nh(struct sk_buff *skb,
 		    dd->filter.res_bucket_nh_id != nhge->nh->id)
 			continue;
 
+		dd->ctx->bucket_index = bucket_index;
 		err = nh_fill_res_bucket(skb, nh, bucket, bucket_index,
 					 RTM_NEWNEXTHOPBUCKET, portid,
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					 cb->extack);
-		if (err < 0) {
-			if (likely(skb->len))
-				goto out;
-			goto out_err;
-		}
+		if (err)
+			return err;
 	}
 
 	dd->ctx->done_nh_idx = dd->ctx->nh.idx + 1;
-	bucket_index = 0;
+	dd->ctx->bucket_index = 0;
 
-out:
-	err = skb->len;
-out_err:
-	dd->ctx->bucket_index = bucket_index;
-	return err;
+	return 0;
 }
 
 static int rtm_dump_nexthop_bucket_cb(struct sk_buff *skb,
@@ -3435,13 +3425,9 @@ static int rtm_dump_nexthop_bucket(struct sk_buff *skb,
 
 	if (err < 0) {
 		if (likely(skb->len))
-			goto out;
-		goto out_err;
+			err = skb->len;
 	}
 
-out:
-	err = skb->len;
-out_err:
 	cb->seq = net->nexthop.seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	return err;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 8108e9a941d0..3ab903f7e0f8 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -196,7 +196,8 @@ static struct nd_opt_hdr *ndisc_next_option(struct nd_opt_hdr *cur,
 static inline int ndisc_is_useropt(const struct net_device *dev,
 				   struct nd_opt_hdr *opt)
 {
-	return opt->nd_opt_type == ND_OPT_RDNSS ||
+	return opt->nd_opt_type == ND_OPT_PREFIX_INFO ||
+		opt->nd_opt_type == ND_OPT_RDNSS ||
 		opt->nd_opt_type == ND_OPT_DNSSL ||
 		opt->nd_opt_type == ND_OPT_CAPTIVE_PORTAL ||
 		opt->nd_opt_type == ND_OPT_PREF64 ||
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ce9f962380b7..1e84314fe334 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -255,8 +255,10 @@ int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain)
 	if (chain->bound)
 		return -EBUSY;
 
+	if (!nft_use_inc(&chain->use))
+		return -EMFILE;
+
 	chain->bound = true;
-	chain->use++;
 	nft_chain_trans_bind(ctx, chain);
 
 	return 0;
@@ -439,7 +441,7 @@ static int nft_delchain(struct nft_ctx *ctx)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nft_deactivate_next(ctx->net, ctx->chain);
 
 	return 0;
@@ -478,7 +480,7 @@ nf_tables_delrule_deactivate(struct nft_ctx *ctx, struct nft_rule *rule)
 	/* You cannot delete the same rule twice */
 	if (nft_is_active_next(ctx->net, rule)) {
 		nft_deactivate_next(ctx->net, rule);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		return 0;
 	}
 	return -ENOENT;
@@ -645,7 +647,7 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 		nft_map_deactivate(ctx, set);
 
 	nft_deactivate_next(ctx->net, set);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -677,7 +679,7 @@ static int nft_delobj(struct nft_ctx *ctx, struct nft_object *obj)
 		return err;
 
 	nft_deactivate_next(ctx->net, obj);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -712,7 +714,7 @@ static int nft_delflowtable(struct nft_ctx *ctx,
 		return err;
 
 	nft_deactivate_next(ctx->net, flowtable);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -2263,9 +2265,6 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	struct nft_rule **rules;
 	int err;
 
-	if (table->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (nla[NFTA_CHAIN_HOOK]) {
 		struct nft_stats __percpu *stats = NULL;
 		struct nft_chain_hook hook;
@@ -2362,6 +2361,11 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	if (err < 0)
 		goto err_destroy_chain;
 
+	if (!nft_use_inc(&table->use)) {
+		err = -EMFILE;
+		goto err_use;
+	}
+
 	trans = nft_trans_chain_add(ctx, NFT_MSG_NEWCHAIN);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
@@ -2378,10 +2382,11 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		goto err_unregister_hook;
 	}
 
-	table->use++;
-
 	return 0;
+
 err_unregister_hook:
+	nft_use_dec_restore(&table->use);
+err_use:
 	nf_tables_unregister_hook(net, table, chain);
 err_destroy_chain:
 	nf_tables_chain_destroy(ctx);
@@ -3566,9 +3571,6 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			return -EINVAL;
 		handle = nf_tables_alloc_handle(table);
 
-		if (chain->use == UINT_MAX)
-			return -EOVERFLOW;
-
 		if (nla[NFTA_RULE_POSITION]) {
 			pos_handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_POSITION]));
 			old_rule = __nft_rule_lookup(chain, pos_handle);
@@ -3662,6 +3664,11 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		}
 	}
 
+	if (!nft_use_inc(&chain->use)) {
+		err = -EMFILE;
+		goto err_release_rule;
+	}
+
 	if (info->nlh->nlmsg_flags & NLM_F_REPLACE) {
 		err = nft_delrule(&ctx, old_rule);
 		if (err < 0)
@@ -3693,7 +3700,6 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		}
 	}
 	kvfree(expr_info);
-	chain->use++;
 
 	if (flow)
 		nft_trans_flow_rule(trans) = flow;
@@ -3704,6 +3710,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	return 0;
 
 err_destroy_flow_rule:
+	nft_use_dec_restore(&chain->use);
 	if (flow)
 		nft_flow_rule_destroy(flow);
 err_release_rule:
@@ -4721,9 +4728,15 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 	alloc_size = sizeof(*set) + size + udlen;
 	if (alloc_size < size || alloc_size > INT_MAX)
 		return -ENOMEM;
+
+	if (!nft_use_inc(&table->use))
+		return -EMFILE;
+
 	set = kvzalloc(alloc_size, GFP_KERNEL);
-	if (!set)
-		return -ENOMEM;
+	if (!set) {
+		err = -ENOMEM;
+		goto err_alloc;
+	}
 
 	name = nla_strdup(nla[NFTA_SET_NAME], GFP_KERNEL);
 	if (!name) {
@@ -4781,7 +4794,7 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		goto err_set_expr_alloc;
 
 	list_add_tail_rcu(&set->list, &table->sets);
-	table->use++;
+
 	return 0;
 
 err_set_expr_alloc:
@@ -4793,6 +4806,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 	kfree(set->name);
 err_set_name:
 	kvfree(set);
+err_alloc:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -4927,9 +4943,6 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_set_binding *i;
 	struct nft_set_iter iter;
 
-	if (set->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (!list_empty(&set->bindings) && nft_set_is_anonymous(set))
 		return -EBUSY;
 
@@ -4957,10 +4970,12 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
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
@@ -5034,7 +5049,7 @@ void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 		nft_clear(ctx->net, set);
 	}
 
-	set->use++;
+	nft_use_inc_restore(&set->use);
 }
 EXPORT_SYMBOL_GPL(nf_tables_activate_set);
 
@@ -5050,7 +5065,7 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		else
 			list_del_rcu(&binding->list);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		break;
 	case NFT_TRANS_PREPARE:
 		if (nft_set_is_anonymous(set)) {
@@ -5059,7 +5074,7 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 
 			nft_deactivate_next(ctx->net, set);
 		}
-		set->use--;
+		nft_use_dec(&set->use);
 		return;
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
@@ -5067,7 +5082,7 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		    set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
 			nft_map_deactivate(ctx, set);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		fallthrough;
 	default:
 		nf_tables_unbind_set(ctx, set, binding,
@@ -5799,7 +5814,7 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 		nft_set_elem_expr_destroy(&ctx, nft_set_ext_expr(ext));
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 	kfree(elem);
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
@@ -6290,8 +6305,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 				     set->objtype, genmask);
 		if (IS_ERR(obj)) {
 			err = PTR_ERR(obj);
+			obj = NULL;
+			goto err_parse_key_end;
+		}
+
+		if (!nft_use_inc(&obj->use)) {
+			err = -EMFILE;
+			obj = NULL;
 			goto err_parse_key_end;
 		}
+
 		err = nft_set_ext_add(&tmpl, NFT_SET_EXT_OBJREF);
 		if (err < 0)
 			goto err_parse_key_end;
@@ -6363,10 +6386,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		udata->len = ulen - 1;
 		nla_memcpy(&udata->data, nla[NFTA_SET_ELEM_USERDATA], ulen);
 	}
-	if (obj) {
+	if (obj)
 		*nft_set_ext_obj(ext) = obj;
-		obj->use++;
-	}
+
 	err = nft_set_elem_expr_setup(ctx, ext, expr_array, num_exprs);
 	if (err < 0)
 		goto err_elem_expr;
@@ -6421,14 +6443,14 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 err_element_clash:
 	kfree(trans);
 err_elem_expr:
-	if (obj)
-		obj->use--;
-
 	nf_tables_set_elem_destroy(ctx, set, elem.priv);
 err_parse_data:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
 		nft_data_release(&elem.data.val, desc.type);
 err_parse_key_end:
+	if (obj)
+		nft_use_dec_restore(&obj->use);
+
 	nft_data_release(&elem.key_end.val, NFT_DATA_VALUE);
 err_parse_key:
 	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
@@ -6507,7 +6529,7 @@ void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 		case NFT_JUMP:
 		case NFT_GOTO:
 			chain = data->verdict.chain;
-			chain->use++;
+			nft_use_inc_restore(&chain->use);
 			break;
 		}
 	}
@@ -6522,7 +6544,7 @@ static void nft_setelem_data_activate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_hold(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use++;
+		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
 static void nft_setelem_data_deactivate(const struct net *net,
@@ -6534,7 +6556,7 @@ static void nft_setelem_data_deactivate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_release(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 }
 
 static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
@@ -7069,9 +7091,14 @@ static int nf_tables_newobj(struct sk_buff *skb, const struct nfnl_info *info,
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
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
@@ -7105,7 +7132,7 @@ static int nf_tables_newobj(struct sk_buff *skb, const struct nfnl_info *info,
 		goto err_obj_ht;
 
 	list_add_tail_rcu(&obj->list, &table->objects);
-	table->use++;
+
 	return 0;
 err_obj_ht:
 	/* queued in transaction log */
@@ -7121,6 +7148,9 @@ static int nf_tables_newobj(struct sk_buff *skb, const struct nfnl_info *info,
 	kfree(obj);
 err_init:
 	module_put(type->owner);
+err_type:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -7511,7 +7541,7 @@ void nf_tables_deactivate_flowtable(const struct nft_ctx *ctx,
 	case NFT_TRANS_PREPARE:
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
-		flowtable->use--;
+		nft_use_dec(&flowtable->use);
 		fallthrough;
 	default:
 		return;
@@ -7859,9 +7889,14 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
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
@@ -7916,7 +7951,6 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 		goto err5;
 
 	list_add_tail_rcu(&flowtable->list, &table->flowtables);
-	table->use++;
 
 	return 0;
 err5:
@@ -7933,6 +7967,9 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 	kfree(flowtable->name);
 err1:
 	kfree(flowtable);
+flowtable_alloc:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -9169,7 +9206,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 				 */
 				if (nft_set_is_anonymous(nft_trans_set(trans)) &&
 				    !list_empty(&nft_trans_set(trans)->bindings))
-					trans->ctx.table->use--;
+					nft_use_dec(&trans->ctx.table->use);
 			}
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_NEWSET, GFP_KERNEL);
@@ -9388,7 +9425,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 					nft_trans_destroy(trans);
 					break;
 				}
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				nft_chain_del(trans->ctx.chain);
 				nf_tables_unregister_hook(trans->ctx.net,
 							  trans->ctx.table,
@@ -9396,7 +9433,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			}
 			break;
 		case NFT_MSG_DELCHAIN:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, trans->ctx.chain);
 			nft_trans_destroy(trans);
 			break;
@@ -9405,7 +9442,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				nft_trans_destroy(trans);
 				break;
 			}
-			trans->ctx.chain->use--;
+			nft_use_dec_restore(&trans->ctx.chain->use);
 			list_del_rcu(&nft_trans_rule(trans)->list);
 			nft_rule_expr_deactivate(&trans->ctx,
 						 nft_trans_rule(trans),
@@ -9414,7 +9451,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				nft_flow_rule_destroy(nft_trans_flow_rule(trans));
 			break;
 		case NFT_MSG_DELRULE:
-			trans->ctx.chain->use++;
+			nft_use_inc_restore(&trans->ctx.chain->use);
 			nft_clear(trans->ctx.net, nft_trans_rule(trans));
 			nft_rule_expr_activate(&trans->ctx, nft_trans_rule(trans));
 			if (trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD)
@@ -9427,7 +9464,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				nft_trans_destroy(trans);
 				break;
 			}
-			trans->ctx.table->use--;
+			nft_use_dec_restore(&trans->ctx.table->use);
 			if (nft_trans_set_bound(trans)) {
 				nft_trans_destroy(trans);
 				break;
@@ -9435,7 +9472,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
 			if (nft_trans_set(trans)->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
 				nft_map_activate(&trans->ctx, nft_trans_set(trans));
@@ -9478,12 +9515,12 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				nft_obj_destroy(&trans->ctx, nft_trans_obj_newobj(trans));
 				nft_trans_destroy(trans);
 			} else {
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				nft_obj_del(nft_trans_obj(trans));
 			}
 			break;
 		case NFT_MSG_DELOBJ:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_obj(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -9492,7 +9529,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				nft_unregister_flowtable_net_hooks(net,
 						&nft_trans_flowtable_hooks(trans));
 			} else {
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				list_del_rcu(&nft_trans_flowtable(trans)->list);
 				nft_unregister_flowtable_net_hooks(net,
 						&nft_trans_flowtable(trans)->hook_list);
@@ -9503,7 +9540,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				list_splice(&nft_trans_flowtable_hooks(trans),
 					    &nft_trans_flowtable(trans)->hook_list);
 			} else {
-				trans->ctx.table->use++;
+				nft_use_inc_restore(&trans->ctx.table->use);
 				nft_clear(trans->ctx.net, nft_trans_flowtable(trans));
 			}
 			nft_trans_destroy(trans);
@@ -9956,8 +9993,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 		if (desc->flags & NFT_DATA_DESC_SETELEM &&
 		    chain->flags & NFT_CHAIN_BINDING)
 			return -EINVAL;
+		if (!nft_use_inc(&chain->use))
+			return -EMFILE;
 
-		chain->use++;
 		data->verdict.chain = chain;
 		break;
 	}
@@ -9975,7 +10013,7 @@ static void nft_verdict_uninit(const struct nft_data *data)
 	case NFT_JUMP:
 	case NFT_GOTO:
 		chain = data->verdict.chain;
-		chain->use--;
+		nft_use_dec(&chain->use);
 		break;
 	}
 }
@@ -10144,11 +10182,11 @@ int __nft_release_basechain(struct nft_ctx *ctx)
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
@@ -10201,18 +10239,18 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
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
 		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
 			nft_map_deactivate(&ctx, set);
 
@@ -10220,13 +10258,13 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	}
 	list_for_each_entry_safe(obj, ne, &table->objects, list) {
 		nft_obj_del(obj);
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
 	nf_tables_table_destroy(&ctx);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index aac6db8680d4..a5fc7213be3e 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -381,8 +381,10 @@ static int nft_flow_offload_init(const struct nft_ctx *ctx,
 	if (IS_ERR(flowtable))
 		return PTR_ERR(flowtable);
 
+	if (!nft_use_inc(&flowtable->use))
+		return -EMFILE;
+
 	priv->flowtable = flowtable;
-	flowtable->use++;
 
 	return nf_ct_netns_get(ctx->net, ctx->family);
 }
@@ -401,7 +403,7 @@ static void nft_flow_offload_activate(const struct nft_ctx *ctx,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 
-	priv->flowtable->use++;
+	nft_use_inc_restore(&priv->flowtable->use);
 }
 
 static void nft_flow_offload_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 6bf1c852e8ea..7d5b63c5a30a 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -168,7 +168,7 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_chain_del(chain);
 				chain->bound = false;
-				chain->table->use--;
+				nft_use_dec(&chain->table->use);
 				break;
 			}
 			break;
@@ -207,7 +207,7 @@ static void nft_immediate_destroy(const struct nft_ctx *ctx,
 		 * let the transaction records release this chain and its rules.
 		 */
 		if (chain->bound) {
-			chain->use--;
+			nft_use_dec(&chain->use);
 			break;
 		}
 
@@ -215,9 +215,9 @@ static void nft_immediate_destroy(const struct nft_ctx *ctx,
 		chain_ctx = *ctx;
 		chain_ctx.chain = chain;
 
-		chain->use--;
+		nft_use_dec(&chain->use);
 		list_for_each_entry_safe(rule, n, &chain->rules, list) {
-			chain->use--;
+			nft_use_dec(&chain->use);
 			list_del(&rule->list);
 			nf_tables_rule_destroy(&chain_ctx, rule);
 		}
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 3ff91bcaa5f2..156787b76667 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -41,8 +41,10 @@ static int nft_objref_init(const struct nft_ctx *ctx,
 	if (IS_ERR(obj))
 		return -ENOENT;
 
+	if (!nft_use_inc(&obj->use))
+		return -EMFILE;
+
 	nft_objref_priv(expr) = obj;
-	obj->use++;
 
 	return 0;
 }
@@ -71,7 +73,7 @@ static void nft_objref_deactivate(const struct nft_ctx *ctx,
 	if (phase == NFT_TRANS_COMMIT)
 		return;
 
-	obj->use--;
+	nft_use_dec(&obj->use);
 }
 
 static void nft_objref_activate(const struct nft_ctx *ctx,
@@ -79,7 +81,7 @@ static void nft_objref_activate(const struct nft_ctx *ctx,
 {
 	struct nft_object *obj = nft_objref_priv(expr);
 
-	obj->use++;
+	nft_use_inc_restore(&obj->use);
 }
 
 static struct nft_expr_type nft_objref_type;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ccf84ce41fd7..62c0fbb9de81 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -368,18 +368,20 @@ static void __packet_set_status(struct packet_sock *po, void *frame, int status)
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
@@ -396,17 +398,19 @@ static int __packet_get_status(const struct packet_sock *po, void *frame)
 
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
index be42b1196786..08aaa6efc62c 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -773,12 +773,10 @@ static void dist_free(struct disttable *d)
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
 
@@ -793,13 +791,7 @@ static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
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
 
@@ -956,6 +948,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_NETEM_MAX + 1];
+	struct disttable *delay_dist = NULL;
+	struct disttable *slot_dist = NULL;
 	struct tc_netem_qopt *qopt;
 	struct clgstate old_clg;
 	int old_loss_model = CLG_RANDOM;
@@ -969,6 +963,18 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -978,26 +984,17 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -1047,17 +1044,11 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 
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
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e80e3fcbb8e8..e5eb5616be0c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1001,6 +1001,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 				err = xp_alloc_tx_descs(xs->pool, xs);
 				if (err) {
 					xp_put_pool(xs->pool);
+					xs->pool = NULL;
 					sockfd_put(sock);
 					goto out_unlock;
 				}
diff --git a/tools/testing/radix-tree/regression1.c b/tools/testing/radix-tree/regression1.c
index a61c7bcbc72d..63f468bf8245 100644
--- a/tools/testing/radix-tree/regression1.c
+++ b/tools/testing/radix-tree/regression1.c
@@ -177,7 +177,7 @@ void regression1_test(void)
 	nr_threads = 2;
 	pthread_barrier_init(&worker_barrier, NULL, nr_threads);
 
-	threads = malloc(nr_threads * sizeof(pthread_t *));
+	threads = malloc(nr_threads * sizeof(*threads));
 
 	for (i = 0; i < nr_threads; i++) {
 		arg = i;
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 5861446d0777..7996ec07e0bd 100644
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
 			{15, "R4=pkt(id=1,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			{15, "R5=pkt(id=1,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Variable offset is added to R5 packet pointer,
-			 * resulting in auxiliary alignment of 4.
+			 * resulting in auxiliary alignment of 4. To avoid BPF
+			 * verifier's precision backtracking logging
+			 * interfering we also have a no-op R4 = R5
+			 * instruction to validate R5 state. We also check
+			 * that R4 is what it should be in such case.
 			 */
-			{18, "R5_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{19, "R4_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{19, "R5_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{19, "R5_w=pkt(id=2,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{20, "R5_w=pkt(id=2,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
 			 * aligned, so the total offset is 4-byte aligned and
 			 * meets the load's requirements.
 			 */
-			{23, "R4=pkt(id=2,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
-			{23, "R5=pkt(id=2,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R4=pkt(id=2,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R5=pkt(id=2,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{26, "R5_w=pkt(id=0,off=14,r=8"},
+			{27, "R5_w=pkt(id=0,off=14,r=8"},
 			/* Variable offset is added to R5, resulting in a
-			 * variable offset of (4n).
+			 * variable offset of (4n). See comment for insn #19
+			 * for R4 = R5 trick.
 			 */
-			{27, "R5_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{29, "R4_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{29, "R5_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{28, "R5_w=pkt(id=3,off=18,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{30, "R5_w=pkt(id=3,off=18,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{29, "R5_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{32, "R4_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{32, "R5_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{33, "R4=pkt(id=4,off=22,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
-			{33, "R5=pkt(id=4,off=18,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R4=pkt(id=4,off=22,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R5=pkt(id=4,off=18,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
 		},
 	},
 	{
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 3a469099f30d..e09c5239a595 100644
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
+		prog = "test_sk_assign_libbpf.o";
+	else
+		prog = "test_sk_assign.o";
+	if (CHECK_FAIL(pclose(tc)))
+		return false;
 
 	/* Move to a new networking namespace */
 	if (CHECK_FAIL(unshare(CLONE_NEWNET)))
@@ -46,8 +62,8 @@ configure_stack(void)
 	/* Load qdisc, BPF program */
 	if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
 		return false;
-	sprintf(tc_cmd, "%s %s %s %s", "tc filter add dev lo ingress bpf",
-		       "direct-action object-file ./test_sk_assign.o",
+	sprintf(tc_cmd, "%s %s %s %s %s", "tc filter add dev lo ingress bpf",
+		       "direct-action object-file", prog,
 		       "section classifier/sk_assign_test",
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
index a943d394fd3a..38ab1ce32e57 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -33,7 +33,7 @@
 
 int _version SEC("version") = 1;
 
-__attribute__ ((noinline))
+__attribute__ ((noinline)) __weak
 int do_bind(struct bpf_sock_addr *ctx)
 {
 	struct sockaddr_in sa = {};
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 1ecd987005d2..77fd42f835fc 100644
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
 
 int _version SEC("version") = 1;
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
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 0c066ba579d4..a194dbcb405a 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -1917,6 +1917,11 @@ basic()
 
 	run_cmd "$IP link set dev lo up"
 
+	# Dump should not loop endlessly when maximum nexthop ID is configured.
+	run_cmd "$IP nexthop add id $((2**32-1)) blackhole"
+	run_cmd "timeout 5 $IP nexthop"
+	log_test $? 0 "Maximum nexthop ID dump"
+
 	#
 	# groups
 	#
@@ -2137,6 +2142,11 @@ basic_res()
 	run_cmd "$IP nexthop bucket list fdb"
 	log_test $? 255 "Dump all nexthop buckets with invalid 'fdb' keyword"
 
+	# Dump should not loop endlessly when maximum nexthop ID is configured.
+	run_cmd "$IP nexthop add id $((2**32-1)) group 1/2 type resilient buckets 4"
+	run_cmd "timeout 5 $IP nexthop bucket"
+	log_test $? 0 "Maximum nexthop ID dump"
+
 	#
 	# resilient nexthop buckets get requests
 	#
diff --git a/tools/testing/selftests/net/forwarding/ethtool.sh b/tools/testing/selftests/net/forwarding/ethtool.sh
index dbb9fcf759e0..aa2eafb7b243 100755
--- a/tools/testing/selftests/net/forwarding/ethtool.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool.sh
@@ -286,6 +286,8 @@ different_speeds_autoneg_on()
 	ethtool -s $h1 autoneg on
 }
 
+skip_on_veth
+
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh b/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
index 4b42dfd4efd1..baf831da5366 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
@@ -95,6 +95,8 @@ no_cable()
 	ip link set dev $swp3 down
 }
 
+skip_on_veth
+
 setup_prepare
 
 tests_run
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index b7d946cf14eb..83e8f9466d62 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -122,6 +122,17 @@ check_ethtool_lanes_support()
 	fi
 }
 
+skip_on_veth()
+{
+	local kind=$(ip -j -d link show dev ${NETIFS[p1]} |
+		jq -r '.[].linkinfo.info_kind')
+
+	if [[ $kind == veth ]]; then
+		echo "SKIP: Test cannot be run with veth pairs"
+		exit $ksft_skip
+	fi
+}
+
 if [[ "$(id -u)" -ne 0 ]]; then
 	echo "SKIP: need root privileges"
 	exit $ksft_skip
@@ -174,6 +185,11 @@ create_netif_veth()
 	for ((i = 1; i <= NUM_NETIFS; ++i)); do
 		local j=$((i+1))
 
+		if [ -z ${NETIFS[p$i]} ]; then
+			echo "SKIP: Cannot create interface. Name not specified"
+			exit $ksft_skip
+		fi
+
 		ip link show dev ${NETIFS[p$i]} &> /dev/null
 		if [[ $? -ne 0 ]]; then
 			ip link add ${NETIFS[p$i]} type veth \
diff --git a/tools/testing/selftests/net/forwarding/settings b/tools/testing/selftests/net/forwarding/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/net/forwarding/tc_flower.sh b/tools/testing/selftests/net/forwarding/tc_flower.sh
index 683711f41aa9..b1daad19b01e 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower.sh
@@ -52,8 +52,8 @@ match_dst_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
@@ -78,8 +78,8 @@ match_src_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 215e1067f037..82ceca6aab96 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -4,8 +4,10 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 CLANG_FLAGS += -no-integrated-as
 endif
 
+top_srcdir = ../../../..
+
 CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT) -Wl,-rpath=./ \
-	  $(CLANG_FLAGS)
+	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
 LDLIBS += -lpthread -ldl
 
 # Own dependencies because we only want to build against 1st prerequisite, but
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index b736a5169aad..e20191fb40d4 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -29,6 +29,8 @@
 #include <dlfcn.h>
 #include <stddef.h>
 
+#include <linux/compiler.h>
+
 #include "../kselftest.h"
 #include "rseq.h"
 
