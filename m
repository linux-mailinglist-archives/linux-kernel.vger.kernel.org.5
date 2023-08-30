Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8045D78DED1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbjH3TcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245323AbjH3PK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:10:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA291AE;
        Wed, 30 Aug 2023 08:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E921EB81F6B;
        Wed, 30 Aug 2023 15:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B251CC433C7;
        Wed, 30 Aug 2023 15:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407812;
        bh=f4lp0jdLxR6O+0/UPuIWZAuXI25e9qY61fcuE+6gnpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYItmXtEHG2Laq6NZS1RzUWLgTRuKIx7xAcCXooL14NWohuHS4ZLNOCfyxThendVU
         F/liWbtN+UuMDHVHtYiBHX1cHKYC5fJunuo8qZ7FgquLxka+RHA2CTZw9wCi5wlJS/
         otP3VYUuJiS1Okx6kfnOp7yyQJYKbGih5xTC8kw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.4.13
Date:   Wed, 30 Aug 2023 17:03:21 +0200
Message-ID: <2023083020-lantern-paycheck-002f@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023083020-these-dander-e24d@gregkh>
References: <2023083020-these-dander-e24d@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 0ff13b943f99..900e515b87cf 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 4
-SUBLEVEL = 12
+SUBLEVEL = 13
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/loongarch/kernel/hw_breakpoint.c b/arch/loongarch/kernel/hw_breakpoint.c
index 021b59c248fa..fc55c4de2a11 100644
--- a/arch/loongarch/kernel/hw_breakpoint.c
+++ b/arch/loongarch/kernel/hw_breakpoint.c
@@ -207,8 +207,7 @@ static int hw_breakpoint_control(struct perf_event *bp,
 			write_wb_reg(CSR_CFG_CTRL, i, 0, CTRL_PLV_ENABLE);
 		} else {
 			ctrl = encode_ctrl_reg(info->ctrl);
-			write_wb_reg(CSR_CFG_CTRL, i, 1, ctrl | CTRL_PLV_ENABLE |
-				     1 << MWPnCFG3_LoadEn | 1 << MWPnCFG3_StoreEn);
+			write_wb_reg(CSR_CFG_CTRL, i, 1, ctrl | CTRL_PLV_ENABLE);
 		}
 		enable = csr_read64(LOONGARCH_CSR_CRMD);
 		csr_write64(CSR_CRMD_WE | enable, LOONGARCH_CSR_CRMD);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index b75a9fb99599..b0eea434ef08 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -143,6 +143,7 @@ static int subpage_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 static const struct mm_walk_ops subpage_walk_ops = {
 	.pmd_entry	= subpage_walk_pmd_entry,
+	.walk_lock	= PGWALK_WRLOCK_VERIFY,
 };
 
 static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a11b1c038c6d..052845384ed3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -525,24 +525,30 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
 config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	def_bool y
 	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
-	depends on AS_IS_GNU && AS_VERSION >= 23800
-	help
-	  Newer binutils versions default to ISA spec version 20191213 which
-	  moves some instructions from the I extension to the Zicsr and Zifencei
-	  extensions.
+	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
+	depends on AS_IS_GNU && AS_VERSION >= 23600
+	help
+	  Binutils-2.38 and GCC-12.1.0 bumped the default ISA spec to the newer
+	  20191213 version, which moves some instructions from the I extension to
+	  the Zicsr and Zifencei extensions. This requires explicitly specifying
+	  Zicsr and Zifencei when binutils >= 2.38 or GCC >= 12.1.0. Zicsr
+	  and Zifencei are supported in binutils from version 2.36 onwards.
+	  To make life easier, and avoid forcing toolchains that default to a
+	  newer ISA spec to version 2.2, relax the check to binutils >= 2.36.
+	  For clang < 17 or GCC < 11.3.0, for which this is not possible or need
+	  special treatment, this is dealt with in TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
 
 config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 	def_bool y
 	depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	# https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943c0c0d4498694e15bf8a16
-	depends on CC_IS_CLANG && CLANG_VERSION < 170000
-	help
-	  Certain versions of clang do not support zicsr and zifencei via -march
-	  but newer versions of binutils require it for the reasons noted in the
-	  help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. This
-	  option causes an older ISA spec compatible with these older versions
-	  of clang to be passed to GAS, which has the same result as passing zicsr
-	  and zifencei to -march.
+	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d29f5d6ab513c52fd872f532c492e35ae9fd6671
+	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION < 110300)
+	help
+	  Certain versions of clang and GCC do not support zicsr and zifencei via
+	  -march. This option causes an older ISA spec compatible with these older
+	  versions of clang and GCC to be passed to GAS, which has the same result
+	  as passing zicsr and zifencei to -march.
 
 config FPU
 	bool "FPU support"
diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
index 189345773e7e..b86e5e2c3aea 100644
--- a/arch/riscv/kernel/compat_vdso/Makefile
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -11,7 +11,13 @@ compat_vdso-syms += flush_icache
 COMPAT_CC := $(CC)
 COMPAT_LD := $(LD)
 
-COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
+# binutils 2.35 does not support the zifencei extension, but in the ISA
+# spec 20191213, G stands for IMAFD_ZICSR_ZIFENCEI.
+ifdef CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
+	COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
+else
+	COMPAT_CC_FLAGS := -march=rv32imafd -mabi=ilp32
+endif
 COMPAT_LD_FLAGS := -melf32lriscv
 
 # Disable attributes, as they're useless and break the build.
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index ea3d61de065b..161d0b34c2cb 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -102,6 +102,7 @@ static const struct mm_walk_ops pageattr_ops = {
 	.pmd_entry = pageattr_pmd_entry,
 	.pte_entry = pageattr_pte_entry,
 	.pte_hole = pageattr_pte_hole,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index d7e8297d5642..aeb06a811d8a 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2514,6 +2514,7 @@ static int thp_split_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 static const struct mm_walk_ops thp_split_walk_ops = {
 	.pmd_entry	= thp_split_walk_pmd_entry,
+	.walk_lock	= PGWALK_WRLOCK_VERIFY,
 };
 
 static inline void thp_split_mm(struct mm_struct *mm)
@@ -2558,6 +2559,7 @@ static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
 
 static const struct mm_walk_ops zap_zero_walk_ops = {
 	.pmd_entry	= __zap_zero_pages,
+	.walk_lock	= PGWALK_WRLOCK,
 };
 
 /*
@@ -2648,6 +2650,7 @@ static const struct mm_walk_ops enable_skey_walk_ops = {
 	.hugetlb_entry		= __s390_enable_skey_hugetlb,
 	.pte_entry		= __s390_enable_skey_pte,
 	.pmd_entry		= __s390_enable_skey_pmd,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 int s390_enable_skey(void)
@@ -2685,6 +2688,7 @@ static int __s390_reset_cmma(pte_t *pte, unsigned long addr,
 
 static const struct mm_walk_ops reset_cmma_walk_ops = {
 	.pte_entry		= __s390_reset_cmma,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 void s390_reset_cmma(struct mm_struct *mm)
@@ -2721,6 +2725,7 @@ static int s390_gather_pages(pte_t *ptep, unsigned long addr,
 
 static const struct mm_walk_ops gather_pages_ops = {
 	.pte_entry = s390_gather_pages,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 /*
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index af5cbdd9bd29..f6d856bd50bc 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -19,8 +19,7 @@
  * FPU state for a task MUST let the rest of the kernel know that the
  * FPU registers are no longer valid for this task.
  *
- * Either one of these invalidation functions is enough. Invalidate
- * a resource you control: CPU if using the CPU for something else
+ * Invalidate a resource you control: CPU if using the CPU for something else
  * (with preemption disabled), FPU for the current task, or a task that
  * is prevented from running by the current task.
  */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1015af1ae562..98e507cc7d34 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -679,7 +679,7 @@ static void fpu_reset_fpregs(void)
 	struct fpu *fpu = &current->thread.fpu;
 
 	fpregs_lock();
-	fpu__drop(fpu);
+	__fpu_invalidate_fpregs_state(fpu);
 	/*
 	 * This does not change the actual hardware registers. It just
 	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..1afbc4866b10 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -882,6 +882,13 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	/*
+	 * CPU capabilities initialization runs before FPU init. So
+	 * X86_FEATURE_OSXSAVE is not set. Now that XSAVE is completely
+	 * functional, set the feature bit so depending code works.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
+
 	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		fpu_kernel_cfg.max_features,
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index a4d9f149b48d..32cfa3f4efd3 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -501,9 +501,13 @@ static const struct dmi_system_id maingear_laptop[] = {
 static const struct dmi_system_id pcspecialist_laptop[] = {
 	{
 		.ident = "PCSpecialist Elimina Pro 16 M",
+		/*
+		 * Some models have product-name "Elimina Pro 16 M",
+		 * others "GM6BGEQ". Match on board-name to match both.
+		 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Elimina Pro 16 M"),
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
 		},
 	},
 	{ }
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 4fb4fd4b06bd..737aa70e2cb3 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -205,18 +205,19 @@ EXPORT_SYMBOL(devm_clk_put);
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id)
 {
-	struct clk **ptr, *clk;
+	struct devm_clk_state *state;
+	struct clk *clk;
 
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
+	state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
+	if (!state)
 		return ERR_PTR(-ENOMEM);
 
 	clk = of_clk_get_by_name(np, con_id);
 	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
+		state->clk = clk;
+		devres_add(dev, state);
 	} else {
-		devres_free(ptr);
+		devres_free(state);
 	}
 
 	return clk;
diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 348b3a9170fa..7f5ed1aa7a9f 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -191,6 +191,7 @@ static const struct dma_fence_ops timeline_fence_ops = {
  */
 static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 {
+	LIST_HEAD(signalled);
 	struct sync_pt *pt, *next;
 
 	trace_sync_timeline(obj);
@@ -203,21 +204,20 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 		if (!timeline_fence_signaled(&pt->base))
 			break;
 
-		list_del_init(&pt->link);
+		dma_fence_get(&pt->base);
+
+		list_move_tail(&pt->link, &signalled);
 		rb_erase(&pt->node, &obj->pt_tree);
 
-		/*
-		 * A signal callback may release the last reference to this
-		 * fence, causing it to be freed. That operation has to be
-		 * last to avoid a use after free inside this loop, and must
-		 * be after we remove the fence from the timeline in order to
-		 * prevent deadlocking on timeline->lock inside
-		 * timeline_fence_release().
-		 */
 		dma_fence_signal_locked(&pt->base);
 	}
 
 	spin_unlock_irq(&obj->lock);
+
+	list_for_each_entry_safe(pt, next, &signalled, link) {
+		list_del_init(&pt->link);
+		dma_fence_put(&pt->base);
+	}
 }
 
 /**
diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index f1f6f1c32987..533d81572579 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -291,6 +291,15 @@ static void gpio_sim_mutex_destroy(void *data)
 	mutex_destroy(lock);
 }
 
+static void gpio_sim_dispose_mappings(void *data)
+{
+	struct gpio_sim_chip *chip = data;
+	unsigned int i;
+
+	for (i = 0; i < chip->gc.ngpio; i++)
+		irq_dispose_mapping(irq_find_mapping(chip->irq_sim, i));
+}
+
 static void gpio_sim_sysfs_remove(void *data)
 {
 	struct gpio_sim_chip *chip = data;
@@ -402,10 +411,14 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (!chip->pull_map)
 		return -ENOMEM;
 
-	chip->irq_sim = devm_irq_domain_create_sim(dev, NULL, num_lines);
+	chip->irq_sim = devm_irq_domain_create_sim(dev, swnode, num_lines);
 	if (IS_ERR(chip->irq_sim))
 		return PTR_ERR(chip->irq_sim);
 
+	ret = devm_add_action_or_reset(dev, gpio_sim_dispose_mappings, chip);
+	if (ret)
+		return ret;
+
 	mutex_init(&chip->lock);
 	ret = devm_add_action_or_reset(dev, gpio_sim_mutex_destroy,
 				       &chip->lock);
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 2fb9bf901a2c..3f479483d7d8 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -262,6 +262,26 @@ static bool drm_kms_helper_enable_hpd(struct drm_device *dev)
 }
 
 #define DRM_OUTPUT_POLL_PERIOD (10*HZ)
+static void reschedule_output_poll_work(struct drm_device *dev)
+{
+	unsigned long delay = DRM_OUTPUT_POLL_PERIOD;
+
+	if (dev->mode_config.delayed_event)
+		/*
+		 * FIXME:
+		 *
+		 * Use short (1s) delay to handle the initial delayed event.
+		 * This delay should not be needed, but Optimus/nouveau will
+		 * fail in a mysterious way if the delayed event is handled as
+		 * soon as possible like it is done in
+		 * drm_helper_probe_single_connector_modes() in case the poll
+		 * was enabled before.
+		 */
+		delay = HZ;
+
+	schedule_delayed_work(&dev->mode_config.output_poll_work, delay);
+}
+
 /**
  * drm_kms_helper_poll_enable - re-enable output polling.
  * @dev: drm_device
@@ -279,37 +299,41 @@ static bool drm_kms_helper_enable_hpd(struct drm_device *dev)
  */
 void drm_kms_helper_poll_enable(struct drm_device *dev)
 {
-	bool poll = false;
-	unsigned long delay = DRM_OUTPUT_POLL_PERIOD;
-
 	if (!dev->mode_config.poll_enabled || !drm_kms_helper_poll ||
 	    dev->mode_config.poll_running)
 		return;
 
-	poll = drm_kms_helper_enable_hpd(dev);
-
-	if (dev->mode_config.delayed_event) {
-		/*
-		 * FIXME:
-		 *
-		 * Use short (1s) delay to handle the initial delayed event.
-		 * This delay should not be needed, but Optimus/nouveau will
-		 * fail in a mysterious way if the delayed event is handled as
-		 * soon as possible like it is done in
-		 * drm_helper_probe_single_connector_modes() in case the poll
-		 * was enabled before.
-		 */
-		poll = true;
-		delay = HZ;
-	}
-
-	if (poll)
-		schedule_delayed_work(&dev->mode_config.output_poll_work, delay);
+	if (drm_kms_helper_enable_hpd(dev) ||
+	    dev->mode_config.delayed_event)
+		reschedule_output_poll_work(dev);
 
 	dev->mode_config.poll_running = true;
 }
 EXPORT_SYMBOL(drm_kms_helper_poll_enable);
 
+/**
+ * drm_kms_helper_poll_reschedule - reschedule the output polling work
+ * @dev: drm_device
+ *
+ * This function reschedules the output polling work, after polling for a
+ * connector has been enabled.
+ *
+ * Drivers must call this helper after enabling polling for a connector by
+ * setting %DRM_CONNECTOR_POLL_CONNECT / %DRM_CONNECTOR_POLL_DISCONNECT flags
+ * in drm_connector::polled. Note that after disabling polling by clearing these
+ * flags for a connector will stop the output polling work automatically if
+ * the polling is disabled for all other connectors as well.
+ *
+ * The function can be called only after polling has been enabled by calling
+ * drm_kms_helper_poll_init() / drm_kms_helper_poll_enable().
+ */
+void drm_kms_helper_poll_reschedule(struct drm_device *dev)
+{
+	if (dev->mode_config.poll_running)
+		reschedule_output_poll_work(dev);
+}
+EXPORT_SYMBOL(drm_kms_helper_poll_reschedule);
+
 static enum drm_connector_status
 drm_helper_probe_detect_ctx(struct drm_connector *connector, bool force)
 {
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index 8c57d48e8270..95c413f713fb 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -5,7 +5,10 @@
 
 #include <drm/i915_pciids.h>
 #include <drm/drm_color_mgmt.h>
+#include <linux/pci.h>
 
+#include "i915_drv.h"
+#include "i915_reg.h"
 #include "intel_display_device.h"
 #include "intel_display_power.h"
 #include "intel_display_reg_defs.h"
@@ -657,10 +660,24 @@ static const struct intel_display_device_info xe_lpdp_display = {
 		BIT(TRANSCODER_C) | BIT(TRANSCODER_D),
 };
 
+/*
+ * Separate detection for no display cases to keep the display id array simple.
+ *
+ * IVB Q requires subvendor and subdevice matching to differentiate from IVB D
+ * GT2 server.
+ */
+static bool has_no_display(struct pci_dev *pdev)
+{
+	static const struct pci_device_id ids[] = {
+		INTEL_IVB_Q_IDS(0),
+		{}
+	};
+
+	return pci_match_id(ids, pdev);
+}
+
 #undef INTEL_VGA_DEVICE
-#undef INTEL_QUANTA_VGA_DEVICE
 #define INTEL_VGA_DEVICE(id, info) { id, info }
-#define INTEL_QUANTA_VGA_DEVICE(info) { 0x16a, info }
 
 static const struct {
 	u32 devid;
@@ -685,7 +702,6 @@ static const struct {
 	INTEL_IRONLAKE_M_IDS(&ilk_m_display),
 	INTEL_SNB_D_IDS(&snb_display),
 	INTEL_SNB_M_IDS(&snb_display),
-	INTEL_IVB_Q_IDS(NULL),		/* must be first IVB in list */
 	INTEL_IVB_M_IDS(&ivb_display),
 	INTEL_IVB_D_IDS(&ivb_display),
 	INTEL_HSW_IDS(&hsw_display),
@@ -710,19 +726,78 @@ static const struct {
 	INTEL_RPLP_IDS(&xe_lpd_display),
 	INTEL_DG2_IDS(&xe_hpd_display),
 
-	/* FIXME: Replace this with a GMD_ID lookup */
-	INTEL_MTL_IDS(&xe_lpdp_display),
+	/*
+	 * Do not add any GMD_ID-based platforms to this list.  They will
+	 * be probed automatically based on the IP version reported by
+	 * the hardware.
+	 */
 };
 
+static const struct {
+	u16 ver;
+	u16 rel;
+	const struct intel_display_device_info *display;
+} gmdid_display_map[] = {
+	{ 14,  0, &xe_lpdp_display },
+};
+
+static const struct intel_display_device_info *
+probe_gmdid_display(struct drm_i915_private *i915, u16 *ver, u16 *rel, u16 *step)
+{
+	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
+	void __iomem *addr;
+	u32 val;
+	int i;
+
+	addr = pci_iomap_range(pdev, 0, i915_mmio_reg_offset(GMD_ID_DISPLAY), sizeof(u32));
+	if (!addr) {
+		drm_err(&i915->drm, "Cannot map MMIO BAR to read display GMD_ID\n");
+		return &no_display;
+	}
+
+	val = ioread32(addr);
+	pci_iounmap(pdev, addr);
+
+	if (val == 0)
+		/* Platform doesn't have display */
+		return &no_display;
+
+	*ver = REG_FIELD_GET(GMD_ID_ARCH_MASK, val);
+	*rel = REG_FIELD_GET(GMD_ID_RELEASE_MASK, val);
+	*step = REG_FIELD_GET(GMD_ID_STEP, val);
+
+	for (i = 0; i < ARRAY_SIZE(gmdid_display_map); i++)
+		if (*ver == gmdid_display_map[i].ver &&
+		    *rel == gmdid_display_map[i].rel)
+			return gmdid_display_map[i].display;
+
+	drm_err(&i915->drm, "Unrecognized display IP version %d.%02d; disabling display.\n",
+		*ver, *rel);
+	return &no_display;
+}
+
 const struct intel_display_device_info *
-intel_display_device_probe(u16 pci_devid)
+intel_display_device_probe(struct drm_i915_private *i915, bool has_gmdid,
+			   u16 *gmdid_ver, u16 *gmdid_rel, u16 *gmdid_step)
 {
+	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	int i;
 
+	if (has_gmdid)
+		return probe_gmdid_display(i915, gmdid_ver, gmdid_rel, gmdid_step);
+
+	if (has_no_display(pdev)) {
+		drm_dbg_kms(&i915->drm, "Device doesn't have display\n");
+		return &no_display;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(intel_display_ids); i++) {
-		if (intel_display_ids[i].devid == pci_devid)
+		if (intel_display_ids[i].devid == pdev->device)
 			return intel_display_ids[i].info;
 	}
 
+	drm_dbg(&i915->drm, "No display ID found for device ID %04x; disabling display.\n",
+		pdev->device);
+
 	return &no_display;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
index 1f7d08b3ad6b..d1d11581d85d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.h
+++ b/drivers/gpu/drm/i915/display/intel_display_device.h
@@ -10,6 +10,8 @@
 
 #include "display/intel_display_limits.h"
 
+struct drm_i915_private;
+
 #define DEV_INFO_DISPLAY_FOR_EACH_FLAG(func) \
 	/* Keep in alphabetical order */ \
 	func(cursor_needs_physical); \
@@ -81,6 +83,7 @@ struct intel_display_device_info {
 };
 
 const struct intel_display_device_info *
-intel_display_device_probe(u16 pci_devid);
+intel_display_device_probe(struct drm_i915_private *i915, bool has_gmdid,
+			   u16 *ver, u16 *rel, u16 *step);
 
 #endif
diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
index b12900446828..6dd0d66e54f4 100644
--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
@@ -210,7 +210,7 @@ intel_hpd_irq_storm_switch_to_polling(struct drm_i915_private *dev_priv)
 
 	/* Enable polling and queue hotplug re-enabling. */
 	if (hpd_disabled) {
-		drm_kms_helper_poll_enable(&dev_priv->drm);
+		drm_kms_helper_poll_reschedule(&dev_priv->drm);
 		mod_delayed_work(system_wq, &dev_priv->display.hotplug.reenable_work,
 				 msecs_to_jiffies(HPD_STORM_REENABLE_DELAY));
 	}
@@ -644,7 +644,7 @@ static void i915_hpd_poll_init_work(struct work_struct *work)
 	drm_connector_list_iter_end(&conn_iter);
 
 	if (enabled)
-		drm_kms_helper_poll_enable(&dev_priv->drm);
+		drm_kms_helper_poll_reschedule(&dev_priv->drm);
 
 	mutex_unlock(&dev_priv->drm.mode_config.mutex);
 
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 2980ccdef6cd..46834299a7d5 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -433,7 +433,6 @@ static int i915_pcode_init(struct drm_i915_private *i915)
 static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
-	struct pci_dev *root_pdev;
 	int ret;
 
 	if (i915_inject_probe_failure(dev_priv))
@@ -547,15 +546,6 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 
 	intel_bw_init_hw(dev_priv);
 
-	/*
-	 * FIXME: Temporary hammer to avoid freezing the machine on our DGFX
-	 * This should be totally removed when we handle the pci states properly
-	 * on runtime PM and on s2idle cases.
-	 */
-	root_pdev = pcie_find_root_port(pdev);
-	if (root_pdev)
-		pci_d3cold_disable(root_pdev);
-
 	return 0;
 
 err_opregion:
@@ -581,7 +571,6 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 static void i915_driver_hw_remove(struct drm_i915_private *dev_priv)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
-	struct pci_dev *root_pdev;
 
 	i915_perf_fini(dev_priv);
 
@@ -589,10 +578,6 @@ static void i915_driver_hw_remove(struct drm_i915_private *dev_priv)
 
 	if (pdev->msi_enabled)
 		pci_disable_msi(pdev);
-
-	root_pdev = pcie_find_root_port(pdev);
-	if (root_pdev)
-		pci_d3cold_enable(root_pdev);
 }
 
 /**
@@ -754,13 +739,17 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct drm_i915_private *i915;
 	int ret;
 
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		pr_err("Failed to enable graphics device: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
 	i915 = i915_driver_create(pdev, ent);
-	if (IS_ERR(i915))
+	if (IS_ERR(i915)) {
+		pci_disable_device(pdev);
 		return PTR_ERR(i915);
-
-	ret = pci_enable_device(pdev);
-	if (ret)
-		goto out_fini;
+	}
 
 	ret = i915_driver_early_probe(i915);
 	if (ret < 0)
@@ -843,7 +832,6 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	i915_driver_late_release(i915);
 out_pci_disable:
 	pci_disable_device(pdev);
-out_fini:
 	i915_probe_error(i915, "Device initialization failed (%d)\n", ret);
 	return ret;
 }
@@ -1499,6 +1487,8 @@ static int intel_runtime_suspend(struct device *kdev)
 {
 	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
 	struct intel_runtime_pm *rpm = &dev_priv->runtime_pm;
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	struct pci_dev *root_pdev;
 	struct intel_gt *gt;
 	int ret, i;
 
@@ -1550,6 +1540,15 @@ static int intel_runtime_suspend(struct device *kdev)
 		drm_err(&dev_priv->drm,
 			"Unclaimed access detected prior to suspending\n");
 
+	/*
+	 * FIXME: Temporary hammer to avoid freezing the machine on our DGFX
+	 * This should be totally removed when we handle the pci states properly
+	 * on runtime PM.
+	 */
+	root_pdev = pcie_find_root_port(pdev);
+	if (root_pdev)
+		pci_d3cold_disable(root_pdev);
+
 	rpm->suspended = true;
 
 	/*
@@ -1588,6 +1587,8 @@ static int intel_runtime_resume(struct device *kdev)
 {
 	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
 	struct intel_runtime_pm *rpm = &dev_priv->runtime_pm;
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	struct pci_dev *root_pdev;
 	struct intel_gt *gt;
 	int ret, i;
 
@@ -1601,6 +1602,11 @@ static int intel_runtime_resume(struct device *kdev)
 
 	intel_opregion_notify_adapter(dev_priv, PCI_D0);
 	rpm->suspended = false;
+
+	root_pdev = pcie_find_root_port(pdev);
+	if (root_pdev)
+		pci_d3cold_enable(root_pdev);
+
 	if (intel_uncore_unclaimed_mmio(&dev_priv->uncore))
 		drm_dbg(&dev_priv->drm,
 			"Unclaimed access during suspend, bios?\n");
diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
index 79523e55ca9c..2f79d232b04a 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -345,7 +345,6 @@ static void ip_ver_read(struct drm_i915_private *i915, u32 offset, struct intel_
 static void intel_ipver_early_init(struct drm_i915_private *i915)
 {
 	struct intel_runtime_info *runtime = RUNTIME_INFO(i915);
-	struct intel_display_runtime_info *display_runtime = DISPLAY_RUNTIME_INFO(i915);
 
 	if (!HAS_GMD_ID(i915)) {
 		drm_WARN_ON(&i915->drm, RUNTIME_INFO(i915)->graphics.ip.ver > 12);
@@ -366,8 +365,6 @@ static void intel_ipver_early_init(struct drm_i915_private *i915)
 		RUNTIME_INFO(i915)->graphics.ip.ver = 12;
 		RUNTIME_INFO(i915)->graphics.ip.rel = 70;
 	}
-	ip_ver_read(i915, i915_mmio_reg_offset(GMD_ID_DISPLAY),
-		    (struct intel_ip_version *)&display_runtime->ip);
 	ip_ver_read(i915, i915_mmio_reg_offset(GMD_ID_MEDIA),
 		    &runtime->media.ip);
 }
@@ -574,6 +571,7 @@ void intel_device_info_driver_create(struct drm_i915_private *i915,
 {
 	struct intel_device_info *info;
 	struct intel_runtime_info *runtime;
+	u16 ver, rel, step;
 
 	/* Setup the write-once "constant" device info */
 	info = mkwrite_device_info(i915);
@@ -584,11 +582,18 @@ void intel_device_info_driver_create(struct drm_i915_private *i915,
 	memcpy(runtime, &INTEL_INFO(i915)->__runtime, sizeof(*runtime));
 
 	/* Probe display support */
-	info->display = intel_display_device_probe(device_id);
+	info->display = intel_display_device_probe(i915, info->has_gmd_id,
+						   &ver, &rel, &step);
 	memcpy(DISPLAY_RUNTIME_INFO(i915),
 	       &DISPLAY_INFO(i915)->__runtime_defaults,
 	       sizeof(*DISPLAY_RUNTIME_INFO(i915)));
 
+	if (info->has_gmd_id) {
+		DISPLAY_RUNTIME_INFO(i915)->ip.ver = ver;
+		DISPLAY_RUNTIME_INFO(i915)->ip.rel = rel;
+		DISPLAY_RUNTIME_INFO(i915)->ip.step = step;
+	}
+
 	runtime->device_id = device_id;
 }
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 58dfb15a8757..e78de99e9933 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -96,7 +96,7 @@ static int panfrost_read_speedbin(struct device *dev)
 		 * keep going without it; any other error means that we are
 		 * supposed to read the bin value, but we failed doing so.
 		 */
-		if (ret != -ENOENT) {
+		if (ret != -ENOENT && ret != -EOPNOTSUPP) {
 			DRM_DEV_ERROR(dev, "Cannot read speed-bin (%d).", ret);
 			return ret;
 		}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 82094c137855..c43853597776 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -497,10 +497,9 @@ static int vmw_user_bo_synccpu_release(struct drm_file *filp,
 		if (!(flags & drm_vmw_synccpu_allow_cs)) {
 			atomic_dec(&vmw_bo->cpu_writers);
 		}
-		ttm_bo_put(&vmw_bo->tbo);
+		vmw_user_bo_unref(vmw_bo);
 	}
 
-	drm_gem_object_put(&vmw_bo->tbo.base);
 	return ret;
 }
 
@@ -540,8 +539,7 @@ int vmw_user_bo_synccpu_ioctl(struct drm_device *dev, void *data,
 			return ret;
 
 		ret = vmw_user_bo_synccpu_grab(vbo, arg->flags);
-		vmw_bo_unreference(&vbo);
-		drm_gem_object_put(&vbo->tbo.base);
+		vmw_user_bo_unref(vbo);
 		if (unlikely(ret != 0)) {
 			if (ret == -ERESTARTSYS || ret == -EBUSY)
 				return -EBUSY;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
index 50a836e70994..1d433fceed3d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
@@ -195,6 +195,14 @@ static inline struct vmw_bo *vmw_bo_reference(struct vmw_bo *buf)
 	return buf;
 }
 
+static inline void vmw_user_bo_unref(struct vmw_bo *vbo)
+{
+	if (vbo) {
+		ttm_bo_put(&vbo->tbo);
+		drm_gem_object_put(&vbo->tbo.base);
+	}
+}
+
 static inline struct vmw_bo *to_vmw_bo(struct drm_gem_object *gobj)
 {
 	return container_of((gobj), struct vmw_bo, tbo.base);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 3810a9984a7f..58bfdf203eca 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1513,4 +1513,16 @@ static inline bool vmw_has_fences(struct vmw_private *vmw)
 	return (vmw_fifo_caps(vmw) & SVGA_FIFO_CAP_FENCE) != 0;
 }
 
+static inline bool vmw_shadertype_is_valid(enum vmw_sm_type shader_model,
+					   u32 shader_type)
+{
+	SVGA3dShaderType max_allowed = SVGA3D_SHADERTYPE_PREDX_MAX;
+
+	if (shader_model >= VMW_SM_5)
+		max_allowed = SVGA3D_SHADERTYPE_MAX;
+	else if (shader_model >= VMW_SM_4)
+		max_allowed = SVGA3D_SHADERTYPE_DX10_MAX;
+	return shader_type >= SVGA3D_SHADERTYPE_MIN && shader_type < max_allowed;
+}
+
 #endif
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 6b9aa2b4ef54..98e0723ca6f5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1164,8 +1164,7 @@ static int vmw_translate_mob_ptr(struct vmw_private *dev_priv,
 	}
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_MOB, VMW_BO_DOMAIN_MOB);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
-	ttm_bo_put(&vmw_bo->tbo);
-	drm_gem_object_put(&vmw_bo->tbo.base);
+	vmw_user_bo_unref(vmw_bo);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -1221,8 +1220,7 @@ static int vmw_translate_guest_ptr(struct vmw_private *dev_priv,
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM,
 			     VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
-	ttm_bo_put(&vmw_bo->tbo);
-	drm_gem_object_put(&vmw_bo->tbo.base);
+	vmw_user_bo_unref(vmw_bo);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -1992,7 +1990,7 @@ static int vmw_cmd_set_shader(struct vmw_private *dev_priv,
 
 	cmd = container_of(header, typeof(*cmd), header);
 
-	if (cmd->body.type >= SVGA3D_SHADERTYPE_PREDX_MAX) {
+	if (!vmw_shadertype_is_valid(VMW_SM_LEGACY, cmd->body.type)) {
 		VMW_DEBUG_USER("Illegal shader type %u.\n",
 			       (unsigned int) cmd->body.type);
 		return -EINVAL;
@@ -2115,8 +2113,6 @@ vmw_cmd_dx_set_single_constant_buffer(struct vmw_private *dev_priv,
 				      SVGA3dCmdHeader *header)
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXSetSingleConstantBuffer);
-	SVGA3dShaderType max_shader_num = has_sm5_context(dev_priv) ?
-		SVGA3D_NUM_SHADERTYPE : SVGA3D_NUM_SHADERTYPE_DX10;
 
 	struct vmw_resource *res = NULL;
 	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
@@ -2133,6 +2129,14 @@ vmw_cmd_dx_set_single_constant_buffer(struct vmw_private *dev_priv,
 	if (unlikely(ret != 0))
 		return ret;
 
+	if (!vmw_shadertype_is_valid(dev_priv->sm_type, cmd->body.type) ||
+	    cmd->body.slot >= SVGA3D_DX_MAX_CONSTBUFFERS) {
+		VMW_DEBUG_USER("Illegal const buffer shader %u slot %u.\n",
+			       (unsigned int) cmd->body.type,
+			       (unsigned int) cmd->body.slot);
+		return -EINVAL;
+	}
+
 	binding.bi.ctx = ctx_node->ctx;
 	binding.bi.res = res;
 	binding.bi.bt = vmw_ctx_binding_cb;
@@ -2141,14 +2145,6 @@ vmw_cmd_dx_set_single_constant_buffer(struct vmw_private *dev_priv,
 	binding.size = cmd->body.sizeInBytes;
 	binding.slot = cmd->body.slot;
 
-	if (binding.shader_slot >= max_shader_num ||
-	    binding.slot >= SVGA3D_DX_MAX_CONSTBUFFERS) {
-		VMW_DEBUG_USER("Illegal const buffer shader %u slot %u.\n",
-			       (unsigned int) cmd->body.type,
-			       (unsigned int) binding.slot);
-		return -EINVAL;
-	}
-
 	vmw_binding_add(ctx_node->staged, &binding.bi, binding.shader_slot,
 			binding.slot);
 
@@ -2207,15 +2203,13 @@ static int vmw_cmd_dx_set_shader_res(struct vmw_private *dev_priv,
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXSetShaderResources) =
 		container_of(header, typeof(*cmd), header);
-	SVGA3dShaderType max_allowed = has_sm5_context(dev_priv) ?
-		SVGA3D_SHADERTYPE_MAX : SVGA3D_SHADERTYPE_DX10_MAX;
 
 	u32 num_sr_view = (cmd->header.size - sizeof(cmd->body)) /
 		sizeof(SVGA3dShaderResourceViewId);
 
 	if ((u64) cmd->body.startView + (u64) num_sr_view >
 	    (u64) SVGA3D_DX_MAX_SRVIEWS ||
-	    cmd->body.type >= max_allowed) {
+	    !vmw_shadertype_is_valid(dev_priv->sm_type, cmd->body.type)) {
 		VMW_DEBUG_USER("Invalid shader binding.\n");
 		return -EINVAL;
 	}
@@ -2239,8 +2233,6 @@ static int vmw_cmd_dx_set_shader(struct vmw_private *dev_priv,
 				 SVGA3dCmdHeader *header)
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXSetShader);
-	SVGA3dShaderType max_allowed = has_sm5_context(dev_priv) ?
-		SVGA3D_SHADERTYPE_MAX : SVGA3D_SHADERTYPE_DX10_MAX;
 	struct vmw_resource *res = NULL;
 	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
 	struct vmw_ctx_bindinfo_shader binding;
@@ -2251,8 +2243,7 @@ static int vmw_cmd_dx_set_shader(struct vmw_private *dev_priv,
 
 	cmd = container_of(header, typeof(*cmd), header);
 
-	if (cmd->body.type >= max_allowed ||
-	    cmd->body.type < SVGA3D_SHADERTYPE_MIN) {
+	if (!vmw_shadertype_is_valid(dev_priv->sm_type, cmd->body.type)) {
 		VMW_DEBUG_USER("Illegal shader type %u.\n",
 			       (unsigned int) cmd->body.type);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index b62207be3363..1489ad73c103 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1665,10 +1665,8 @@ static struct drm_framebuffer *vmw_kms_fb_create(struct drm_device *dev,
 
 err_out:
 	/* vmw_user_lookup_handle takes one ref so does new_fb */
-	if (bo) {
-		vmw_bo_unreference(&bo);
-		drm_gem_object_put(&bo->tbo.base);
-	}
+	if (bo)
+		vmw_user_bo_unref(bo);
 	if (surface)
 		vmw_surface_unreference(&surface);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index 7e112319a23c..fb85f244c3d0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -451,8 +451,7 @@ int vmw_overlay_ioctl(struct drm_device *dev, void *data,
 
 	ret = vmw_overlay_update_stream(dev_priv, buf, arg, true);
 
-	vmw_bo_unreference(&buf);
-	drm_gem_object_put(&buf->tbo.base);
+	vmw_user_bo_unref(buf);
 
 out_unlock:
 	mutex_unlock(&overlay->mutex);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index e7226db8b242..1e81ff2422cf 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -809,8 +809,7 @@ static int vmw_shader_define(struct drm_device *dev, struct drm_file *file_priv,
 				    shader_type, num_input_sig,
 				    num_output_sig, tfile, shader_handle);
 out_bad_arg:
-	vmw_bo_unreference(&buffer);
-	drm_gem_object_put(&buffer->tbo.base);
+	vmw_user_bo_unref(buffer);
 	return ret;
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index db65e77bd373..664f05297830 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 		return -EINVAL;
 
 	if (*nplanes) {
+		if (*nplanes != q_data->fmt->num_planes)
+			return -EINVAL;
 		for (i = 0; i < *nplanes; i++)
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index b9dbad3a8af8..fc5da5d7744d 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -660,10 +660,10 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 		return NULL;
 	arp = (struct arp_pkt *)skb_network_header(skb);
 
-	/* Don't modify or load balance ARPs that do not originate locally
-	 * (e.g.,arrive via a bridge).
+	/* Don't modify or load balance ARPs that do not originate
+	 * from the bond itself or a VLAN directly above the bond.
 	 */
-	if (!bond_slave_has_mac_rx(bond, arp->mac_src))
+	if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
 		return NULL;
 
 	dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 4068d962203d..98c669ad5141 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -192,12 +192,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 
 		nla_peer = data[VXCAN_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifla(peer_tb,
-					  nla_data(nla_peer) +
-					  sizeof(struct ifinfomsg),
-					  nla_len(nla_peer) -
-					  sizeof(struct ifinfomsg),
-					  NULL);
+		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		if (err < 0)
 			return err;
 
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 7e773c4ba046..32dc4f19c82c 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1006,6 +1006,10 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
 		   MT753X_BPDU_CPU_ONLY);
 
+	/* Trap 802.1X PAE frames to the CPU port(s) */
+	mt7530_rmw(priv, MT753X_BPC, MT753X_PAE_PORT_FW_MASK,
+		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY));
+
 	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) */
 	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_PORT_FW_MASK,
 		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 08045b035e6a..17e42d30fff4 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -66,6 +66,8 @@ enum mt753x_id {
 /* Registers for BPDU and PAE frame control*/
 #define MT753X_BPC			0x24
 #define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
+#define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_PAE_PORT_FW(x)		FIELD_PREP(MT753X_PAE_PORT_FW_MASK, x)
 
 /* Register for :03 and :0E MAC DA frame control */
 #define MT753X_RGAC2			0x2c
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index ca69973ae91b..b1ecd08cec96 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1081,6 +1081,9 @@ static u64 vsc9959_tas_remaining_gate_len_ps(u64 gate_len_ns)
 	if (gate_len_ns == U64_MAX)
 		return U64_MAX;
 
+	if (gate_len_ns < VSC9959_TAS_MIN_GATE_LEN_NS)
+		return 0;
+
 	return (gate_len_ns - VSC9959_TAS_MIN_GATE_LEN_NS) * PSEC_PER_NSEC;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 10c7c232cc4e..52ee3751187a 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1448,7 +1448,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
 	int err;
 
 	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-	if (!phy_dev || IS_ERR(phy_dev)) {
+	if (IS_ERR(phy_dev)) {
 		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
 		return -ENODEV;
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 0092e46c46f8..cc3afb605b1e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -617,7 +617,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
 		};
 
 		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-		if (!phydev || IS_ERR(phydev)) {
+		if (IS_ERR(phydev)) {
 			dev_err(kdev, "failed to register fixed PHY device\n");
 			return -ENODEV;
 		}
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 5ef073a79ce9..cb2810f175cc 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6881,7 +6881,10 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 
 			ri->data = NULL;
 
-			skb = build_skb(data, frag_size);
+			if (frag_size)
+				skb = build_skb(data, frag_size);
+			else
+				skb = slab_build_skb(data);
 			if (!skb) {
 				tg3_frag_free(frag_size != 0, data);
 				goto drop_it_no_recycle;
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index c2e7037c7ba1..7750702900fa 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -1466,7 +1466,7 @@ static void make_established(struct sock *sk, u32 snd_isn, unsigned int opt)
 	tp->write_seq = snd_isn;
 	tp->snd_nxt = snd_isn;
 	tp->snd_una = snd_isn;
-	inet_sk(sk)->inet_id = get_random_u16();
+	atomic_set(&inet_sk(sk)->inet_id, get_random_u16());
 	assign_rxopt(sk, opt);
 
 	if (tp->rcv_wnd > (RCV_BUFSIZ_M << 10))
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 113fcb3e353e..832a2ae01950 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -203,7 +203,7 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
 	unsigned long offset;
 
 	for (offset = 0; offset < length; offset += SMP_CACHE_BYTES)
-		asm("dcbfl %0,%1" :: "b" (addr), "r" (offset));
+		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
 }
 
 /* replenish the buffers for a pool.  note that we don't need to
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b847bd105b16..5d21cb4ef630 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2615,7 +2615,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			retval = i40e_correct_mac_vlan_filters
 				(vsi, &tmp_add_list, &tmp_del_list,
 				 vlan_filters);
-		else
+		else if (pf->vf)
 			retval = i40e_correct_vf_mac_vlan_filters
 				(vsi, &tmp_add_list, &tmp_del_list,
 				 vlan_filters, pf->vf[vsi->vf_id].trusted);
@@ -2788,7 +2788,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 	}
 
 	/* if the VF is not trusted do not do promisc */
-	if ((vsi->type == I40E_VSI_SRIOV) && !pf->vf[vsi->vf_id].trusted) {
+	if (vsi->type == I40E_VSI_SRIOV && pf->vf &&
+	    !pf->vf[vsi->vf_id].trusted) {
 		clear_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
 		goto out;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 619cb07a4069..25e09ab708ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -393,7 +393,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Receive Packet Data Buffer Size.
 	 * The Packet Data Buffer Size is defined in 128 byte units.
 	 */
-	rlan_ctx.dbuf = ring->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
+	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
+				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
 
 	/* use 32 byte descriptors */
 	rlan_ctx.dsize = 1;
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 588ad8696756..f1dca59bd844 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1171,7 +1171,7 @@ int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
 	if (!vf)
 		return -EINVAL;
 
-	ret = ice_check_vf_ready_for_reset(vf);
+	ret = ice_check_vf_ready_for_cfg(vf);
 	if (ret)
 		goto out_put_vf;
 
@@ -1286,7 +1286,7 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		goto out_put_vf;
 	}
 
-	ret = ice_check_vf_ready_for_reset(vf);
+	ret = ice_check_vf_ready_for_cfg(vf);
 	if (ret)
 		goto out_put_vf;
 
@@ -1340,7 +1340,7 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 		return -EOPNOTSUPP;
 	}
 
-	ret = ice_check_vf_ready_for_reset(vf);
+	ret = ice_check_vf_ready_for_cfg(vf);
 	if (ret)
 		goto out_put_vf;
 
@@ -1653,7 +1653,7 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 	if (!vf)
 		return -EINVAL;
 
-	ret = ice_check_vf_ready_for_reset(vf);
+	ret = ice_check_vf_ready_for_cfg(vf);
 	if (ret)
 		goto out_put_vf;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index bf74a2f3a4f8..14da7ebaaead 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -185,25 +185,6 @@ int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
 	return 0;
 }
 
-/**
- * ice_check_vf_ready_for_reset - check if VF is ready to be reset
- * @vf: VF to check if it's ready to be reset
- *
- * The purpose of this function is to ensure that the VF is not in reset,
- * disabled, and is both initialized and active, thus enabling us to safely
- * initialize another reset.
- */
-int ice_check_vf_ready_for_reset(struct ice_vf *vf)
-{
-	int ret;
-
-	ret = ice_check_vf_ready_for_cfg(vf);
-	if (!ret && !test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
-		ret = -EAGAIN;
-
-	return ret;
-}
-
 /**
  * ice_trigger_vf_reset - Reset a VF on HW
  * @vf: pointer to the VF structure
@@ -631,11 +612,17 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 		return 0;
 	}
 
+	if (flags & ICE_VF_RESET_LOCK)
+		mutex_lock(&vf->cfg_lock);
+	else
+		lockdep_assert_held(&vf->cfg_lock);
+
 	if (ice_is_vf_disabled(vf)) {
 		vsi = ice_get_vf_vsi(vf);
 		if (!vsi) {
 			dev_dbg(dev, "VF is already removed\n");
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_unlock;
 		}
 		ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, vf->vf_id);
 
@@ -644,14 +631,9 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 
 		dev_dbg(dev, "VF is already disabled, there is no need for resetting it, telling VM, all is fine %d\n",
 			vf->vf_id);
-		return 0;
+		goto out_unlock;
 	}
 
-	if (flags & ICE_VF_RESET_LOCK)
-		mutex_lock(&vf->cfg_lock);
-	else
-		lockdep_assert_held(&vf->cfg_lock);
-
 	/* Set VF disable bit state here, before triggering reset */
 	set_bit(ICE_VF_STATE_DIS, vf->vf_states);
 	ice_trigger_vf_reset(vf, flags & ICE_VF_RESET_VFLR, false);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index a38ef00a3679..e3cda6fb71ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -215,7 +215,6 @@ u16 ice_get_num_vfs(struct ice_pf *pf);
 struct ice_vsi *ice_get_vf_vsi(struct ice_vf *vf);
 bool ice_is_vf_disabled(struct ice_vf *vf);
 int ice_check_vf_ready_for_cfg(struct ice_vf *vf);
-int ice_check_vf_ready_for_reset(struct ice_vf *vf);
 void ice_set_vf_state_dis(struct ice_vf *vf);
 bool ice_is_any_vf_in_unicast_promisc(struct ice_pf *pf);
 void
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index f4a524f80b11..97243c616d5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3955,7 +3955,6 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 		ice_vc_notify_vf_link_state(vf);
 		break;
 	case VIRTCHNL_OP_RESET_VF:
-		clear_bit(ICE_VF_STATE_ACTIVE, vf->vf_states);
 		ops->reset_vf(vf);
 		break;
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 405886ee5261..319c544b9f04 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1385,18 +1385,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
-	spin_lock_init(&adapter->tmreg_lock);
-	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
-
-	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
-				  igb_ptp_overflow_check);
-
-	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
-	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-
-	igb_ptp_reset(adapter);
-
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1406,6 +1394,18 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
+
+		spin_lock_init(&adapter->tmreg_lock);
+		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
+
+		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
+					  igb_ptp_overflow_check);
+
+		adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+
+		igb_ptp_reset(adapter);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 44a507029946..2f780cc90883 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -546,7 +546,7 @@
 #define IGC_PTM_CTRL_START_NOW	BIT(29) /* Start PTM Now */
 #define IGC_PTM_CTRL_EN		BIT(30) /* Enable PTM */
 #define IGC_PTM_CTRL_TRIG	BIT(31) /* PTM Cycle trigger */
-#define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x2f) << 2)
+#define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x3f) << 2)
 #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
 
 #define IGC_PTM_SHORT_CYC_DEFAULT	10  /* Default Short/interrupted cycle interval */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 8cdf91a5bf44..49c1dbe5ec78 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4016,9 +4016,10 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (link < 0)
 		return NIX_AF_ERR_RX_LINK_INVALID;
 
-	nix_find_link_frs(rvu, req, pcifunc);
 
 linkcfg:
+	nix_find_link_frs(rvu, req, pcifunc);
+
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link));
 	cfg = (cfg & ~(0xFFFFULL << 16)) | ((u64)req->maxlen << 16);
 	if (req->update_minlen)
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 985cff910f30..3b651efcc25e 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -221,9 +221,13 @@ void mtk_wed_fe_reset(void)
 
 	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
 		struct mtk_wed_hw *hw = hw_list[i];
-		struct mtk_wed_device *dev = hw->wed_dev;
+		struct mtk_wed_device *dev;
 		int err;
 
+		if (!hw)
+			break;
+
+		dev = hw->wed_dev;
 		if (!dev || !dev->wlan.reset)
 			continue;
 
@@ -244,8 +248,12 @@ void mtk_wed_fe_reset_complete(void)
 
 	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
 		struct mtk_wed_hw *hw = hw_list[i];
-		struct mtk_wed_device *dev = hw->wed_dev;
+		struct mtk_wed_device *dev;
+
+		if (!hw)
+			break;
 
+		dev = hw->wed_dev;
 		if (!dev || !dev->wlan.reset_complete)
 			continue;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index bd1a51a0a540..f208a237d0b5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -32,8 +32,8 @@ static const struct mlxsw_afk_element_info mlxsw_afk_element_infos[] = {
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_TTL_, 0x18, 0, 8),
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_ECN, 0x18, 9, 2),
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_DSCP, 0x18, 11, 6),
-	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_MSB, 0x18, 17, 3),
-	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_LSB, 0x18, 20, 8),
+	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_MSB, 0x18, 17, 4),
+	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_LSB, 0x18, 21, 8),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_96_127, 0x20, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_64_95, 0x24, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_32_63, 0x28, 4),
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index c968309657dd..51eea1f0529c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -517,11 +517,15 @@ static void mlxsw_pci_skb_cb_ts_set(struct mlxsw_pci *mlxsw_pci,
 				    struct sk_buff *skb,
 				    enum mlxsw_pci_cqe_v cqe_v, char *cqe)
 {
+	u8 ts_type;
+
 	if (cqe_v != MLXSW_PCI_CQE_V2)
 		return;
 
-	if (mlxsw_pci_cqe2_time_stamp_type_get(cqe) !=
-	    MLXSW_PCI_CQE_TIME_STAMP_TYPE_UTC)
+	ts_type = mlxsw_pci_cqe2_time_stamp_type_get(cqe);
+
+	if (ts_type != MLXSW_PCI_CQE_TIME_STAMP_TYPE_UTC &&
+	    ts_type != MLXSW_PCI_CQE_TIME_STAMP_TYPE_MIRROR_UTC)
 		return;
 
 	mlxsw_skb_cb(skb)->cqe_ts.sec = mlxsw_pci_cqe2_time_stamp_sec_get(cqe);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 8165bf31a99a..17160e867bef 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -97,14 +97,6 @@ MLXSW_ITEM32(reg, sspr, m, 0x00, 31, 1);
  */
 MLXSW_ITEM32_LP(reg, sspr, 0x00, 16, 0x00, 12);
 
-/* reg_sspr_sub_port
- * Virtual port within the physical port.
- * Should be set to 0 when virtual ports are not enabled on the port.
- *
- * Access: RW
- */
-MLXSW_ITEM32(reg, sspr, sub_port, 0x00, 8, 8);
-
 /* reg_sspr_system_port
  * Unique identifier within the stacking domain that represents all the ports
  * that are available in the system (external ports).
@@ -120,7 +112,6 @@ static inline void mlxsw_reg_sspr_pack(char *payload, u16 local_port)
 	MLXSW_REG_ZERO(sspr, payload);
 	mlxsw_reg_sspr_m_set(payload, 1);
 	mlxsw_reg_sspr_local_port_set(payload, local_port);
-	mlxsw_reg_sspr_sub_port_set(payload, 0);
 	mlxsw_reg_sspr_system_port_set(payload, local_port);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
index e4f4cded2b6f..b1178b7a7f51 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
@@ -193,7 +193,7 @@ mlxsw_sp2_mr_tcam_rule_parse(struct mlxsw_sp_acl_rule *rule,
 				       key->vrid, GENMASK(7, 0));
 	mlxsw_sp_acl_rulei_keymask_u32(rulei,
 				       MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-				       key->vrid >> 8, GENMASK(2, 0));
+				       key->vrid >> 8, GENMASK(3, 0));
 	switch (key->proto) {
 	case MLXSW_SP_L3_PROTO_IPV4:
 		return mlxsw_sp2_mr_tcam_rule_parse4(rulei, key);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index 00c32320f891..173808c096ba 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -169,7 +169,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_2[] = {
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_LSB, 0x04, 24, 8),
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_MSB, 0x00, 0, 3),
+	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER_MSB, 0x00, 0, 3, 0, true),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_0[] = {
@@ -319,7 +319,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] = {
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4b[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_LSB, 0x04, 13, 8),
-	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER_MSB, 0x04, 21, 4, 0, true),
+	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_MSB, 0x04, 21, 4),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index b15dd9a3ad54..1b55928e89b8 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -748,7 +748,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 		write_pnet(&port->pnet, newnet);
 
-		ipvlan_migrate_l3s_hook(oldnet, newnet);
+		if (port->mode == IPVLAN_MODE_L3S)
+			ipvlan_migrate_l3s_hook(oldnet, newnet);
 		break;
 	}
 	case NETDEV_UNREGISTER:
diff --git a/drivers/net/mdio/mdio-bitbang.c b/drivers/net/mdio/mdio-bitbang.c
index b83932562be2..81b7748c10ce 100644
--- a/drivers/net/mdio/mdio-bitbang.c
+++ b/drivers/net/mdio/mdio-bitbang.c
@@ -186,7 +186,7 @@ int mdiobb_read_c45(struct mii_bus *bus, int phy, int devad, int reg)
 	struct mdiobb_ctrl *ctrl = bus->priv;
 
 	mdiobb_cmd_addr(ctrl, phy, devad, reg);
-	mdiobb_cmd(ctrl, MDIO_C45_READ, phy, reg);
+	mdiobb_cmd(ctrl, MDIO_C45_READ, phy, devad);
 
 	return mdiobb_read_common(bus, phy);
 }
@@ -222,7 +222,7 @@ int mdiobb_write_c45(struct mii_bus *bus, int phy, int devad, int reg, u16 val)
 	struct mdiobb_ctrl *ctrl = bus->priv;
 
 	mdiobb_cmd_addr(ctrl, phy, devad, reg);
-	mdiobb_cmd(ctrl, MDIO_C45_WRITE, phy, reg);
+	mdiobb_cmd(ctrl, MDIO_C45_WRITE, phy, devad);
 
 	return mdiobb_write_common(bus, val);
 }
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 76019949e3fe..c977b704f134 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1851,10 +1851,7 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 
 		nla_peer = data[VETH_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifla(peer_tb,
-					  nla_data(nla_peer) + sizeof(struct ifinfomsg),
-					  nla_len(nla_peer) - sizeof(struct ifinfomsg),
-					  NULL);
+		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		if (err < 0)
 			return err;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index b20409f8c13a..20971304fdef 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -66,6 +66,7 @@ config IWLMVM
 	tristate "Intel Wireless WiFi MVM Firmware support"
 	select WANT_DEV_COREDUMP
 	depends on MAC80211
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  This is the driver that supports the MVM firmware. The list
 	  of the devices that use this firmware is available here:
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index e311d406b170..4999636eaa92 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -63,15 +63,14 @@ int of_reconfig_notifier_unregister(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(of_reconfig_notifier_unregister);
 
-#ifdef DEBUG
-const char *action_names[] = {
+static const char *action_names[] = {
+	[0] = "INVALID",
 	[OF_RECONFIG_ATTACH_NODE] = "ATTACH_NODE",
 	[OF_RECONFIG_DETACH_NODE] = "DETACH_NODE",
 	[OF_RECONFIG_ADD_PROPERTY] = "ADD_PROPERTY",
 	[OF_RECONFIG_REMOVE_PROPERTY] = "REMOVE_PROPERTY",
 	[OF_RECONFIG_UPDATE_PROPERTY] = "UPDATE_PROPERTY",
 };
-#endif
 
 int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
 {
@@ -620,21 +619,9 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 		}
 
 		ret = __of_add_property(ce->np, ce->prop);
-		if (ret) {
-			pr_err("changeset: add_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 	case OF_RECONFIG_REMOVE_PROPERTY:
 		ret = __of_remove_property(ce->np, ce->prop);
-		if (ret) {
-			pr_err("changeset: remove_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 
 	case OF_RECONFIG_UPDATE_PROPERTY:
@@ -648,20 +635,17 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 		}
 
 		ret = __of_update_property(ce->np, ce->prop, &old_prop);
-		if (ret) {
-			pr_err("changeset: update_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 	default:
 		ret = -EINVAL;
 	}
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
-	if (ret)
+	if (ret) {
+		pr_err("changeset: apply failed: %-15s %pOF:%s\n",
+		       action_names[ce->action], ce->np, ce->prop->name);
 		return ret;
+	}
 
 	switch (ce->action) {
 	case OF_RECONFIG_ATTACH_NODE:
@@ -947,6 +931,9 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	if (!ce)
 		return -ENOMEM;
 
+	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
+		return -EINVAL;
+
 	/* get a reference to the node */
 	ce->action = action;
 	ce->np = of_node_get(np);
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index f26d2ba8a371..68278340cecf 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -184,7 +184,8 @@ int __init ima_free_kexec_buffer(void)
 	if (ret)
 		return ret;
 
-	return memblock_phys_free(addr, size);
+	memblock_free_late(addr, size);
+	return 0;
 }
 #endif
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 2191c0136531..4fe02e9f7dcd 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -664,12 +664,12 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	memset(&args, 0, sizeof(args));
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle");
+		     "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678");
 
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-phandle",
 					    "phandle", 0, &args);
 	EXPECT_END(KERN_INFO,
-		   "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle");
+		   "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678");
 
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 5b1f271c6034..601129772b2d 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -512,12 +512,15 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
-					__pci_bus_size_bridges(dev->subordinate,
-							       &add_list);
+					if (pci_is_root_bus(bus))
+						__pci_bus_size_bridges(dev->subordinate, &add_list);
 				}
 			}
 		}
-		__pci_bus_assign_resources(bus, &add_list, NULL);
+		if (pci_is_root_bus(bus))
+			__pci_bus_assign_resources(bus, &add_list, NULL);
+		else
+			pci_assign_unassigned_bridge_resources(bus->self);
 	}
 
 	acpiphp_sanitize_bus(bus);
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index b129d7c76b3e..3b10e0a01b1d 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -862,6 +862,33 @@ static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_group_set = amd_pinconf_group_set,
 };
 
+static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
+{
+	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	unsigned long flags;
+	u32 pin_reg, mask;
+	int i;
+
+	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
+		BIT(WAKE_CNTRL_OFF_S4);
+
+	for (i = 0; i < desc->npins; i++) {
+		int pin = desc->pins[i].number;
+		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
+
+		if (!pd)
+			continue;
+
+		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+
+		pin_reg = readl(gpio_dev->base + pin * 4);
+		pin_reg &= ~mask;
+		writel(pin_reg, gpio_dev->base + pin * 4);
+
+		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+	}
+}
+
 #ifdef CONFIG_PM_SLEEP
 static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 {
@@ -1099,6 +1126,9 @@ static int amd_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio_dev->pctrl);
 	}
 
+	/* Disable and mask interrupts */
+	amd_gpio_irq_init(gpio_dev);
+
 	girq = &gpio_dev->gc.irq;
 	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index 40b1326a1077..5591ddf16fdf 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -14,6 +14,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinmux.h>
 
@@ -46,6 +47,7 @@ struct rza2_pinctrl_priv {
 	struct pinctrl_dev *pctl;
 	struct pinctrl_gpio_range gpio_range;
 	int npins;
+	struct mutex mutex; /* serialize adding groups and functions */
 };
 
 #define RZA2_PDR(port)		(0x0000 + (port) * 2)	/* Direction 16-bit */
@@ -358,10 +360,14 @@ static int rza2_dt_node_to_map(struct pinctrl_dev *pctldev,
 		psel_val[i] = MUX_FUNC(value);
 	}
 
+	mutex_lock(&priv->mutex);
+
 	/* Register a single pin group listing all the pins we read from DT */
 	gsel = pinctrl_generic_add_group(pctldev, np->name, pins, npins, NULL);
-	if (gsel < 0)
-		return gsel;
+	if (gsel < 0) {
+		ret = gsel;
+		goto unlock;
+	}
 
 	/*
 	 * Register a single group function where the 'data' is an array PSEL
@@ -390,6 +396,8 @@ static int rza2_dt_node_to_map(struct pinctrl_dev *pctldev,
 	(*map)->data.mux.function = np->name;
 	*num_maps = 1;
 
+	mutex_unlock(&priv->mutex);
+
 	return 0;
 
 remove_function:
@@ -398,6 +406,9 @@ static int rza2_dt_node_to_map(struct pinctrl_dev *pctldev,
 remove_group:
 	pinctrl_generic_remove_group(pctldev, gsel);
 
+unlock:
+	mutex_unlock(&priv->mutex);
+
 	dev_err(priv->dev, "Unable to parse DT node %s\n", np->name);
 
 	return ret;
@@ -473,6 +484,8 @@ static int rza2_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	mutex_init(&priv->mutex);
+
 	platform_set_drvdata(pdev, priv);
 
 	priv->npins = (int)(uintptr_t)of_device_get_match_data(&pdev->dev) *
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index b53d26167da5..6e8a76556e23 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/seq_file.h>
@@ -149,10 +150,11 @@ struct rzg2l_pinctrl {
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
 	DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);
-	spinlock_t			bitmap_lock;
+	spinlock_t			bitmap_lock; /* protect tint_slot bitmap */
 	unsigned int			hwirq[RZG2L_TINT_MAX_INTERRUPT];
 
-	spinlock_t			lock;
+	spinlock_t			lock; /* lock read/write registers */
+	struct mutex			mutex; /* serialize adding groups and functions */
 };
 
 static const unsigned int iolh_groupa_mA[] = { 2, 4, 8, 12 };
@@ -362,11 +364,13 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		name = np->name;
 	}
 
+	mutex_lock(&pctrl->mutex);
+
 	/* Register a single pin group listing all the pins we read from DT */
 	gsel = pinctrl_generic_add_group(pctldev, name, pins, num_pinmux, NULL);
 	if (gsel < 0) {
 		ret = gsel;
-		goto done;
+		goto unlock;
 	}
 
 	/*
@@ -380,6 +384,8 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		goto remove_group;
 	}
 
+	mutex_unlock(&pctrl->mutex);
+
 	maps[idx].type = PIN_MAP_TYPE_MUX_GROUP;
 	maps[idx].data.mux.group = name;
 	maps[idx].data.mux.function = name;
@@ -391,6 +397,8 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 remove_group:
 	pinctrl_generic_remove_group(pctldev, gsel);
+unlock:
+	mutex_unlock(&pctrl->mutex);
 done:
 	*index = idx;
 	kfree(configs);
@@ -1509,6 +1517,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 
 	spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
+	mutex_init(&pctrl->mutex);
 
 	platform_set_drvdata(pdev, pctrl);
 
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 35b23c1a5684..9146101ea9e2 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -14,6 +14,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/spinlock.h>
 
@@ -123,7 +124,8 @@ struct rzv2m_pinctrl {
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
 
-	spinlock_t			lock;
+	spinlock_t			lock; /* lock read/write registers */
+	struct mutex			mutex; /* serialize adding groups and functions */
 };
 
 static const unsigned int drv_1_8V_group2_uA[] = { 1800, 3800, 7800, 11000 };
@@ -322,11 +324,13 @@ static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		name = np->name;
 	}
 
+	mutex_lock(&pctrl->mutex);
+
 	/* Register a single pin group listing all the pins we read from DT */
 	gsel = pinctrl_generic_add_group(pctldev, name, pins, num_pinmux, NULL);
 	if (gsel < 0) {
 		ret = gsel;
-		goto done;
+		goto unlock;
 	}
 
 	/*
@@ -340,6 +344,8 @@ static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		goto remove_group;
 	}
 
+	mutex_unlock(&pctrl->mutex);
+
 	maps[idx].type = PIN_MAP_TYPE_MUX_GROUP;
 	maps[idx].data.mux.group = name;
 	maps[idx].data.mux.function = name;
@@ -351,6 +357,8 @@ static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 remove_group:
 	pinctrl_generic_remove_group(pctldev, gsel);
+unlock:
+	mutex_unlock(&pctrl->mutex);
 done:
 	*index = idx;
 	kfree(configs);
@@ -1071,6 +1079,7 @@ static int rzv2m_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	spin_lock_init(&pctrl->lock);
+	mutex_init(&pctrl->mutex);
 
 	platform_set_drvdata(pdev, pctrl);
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index d2fee9a3e239..6d9297c1d96c 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1049,6 +1049,11 @@ static const struct key_entry ideapad_keymap[] = {
 	{ KE_IGNORE,	0x03 | IDEAPAD_WMI_KEY },
 	/* Customizable Lenovo Hotkey ("star" with 'S' inside) */
 	{ KE_KEY,	0x01 | IDEAPAD_WMI_KEY, { KEY_FAVORITES } },
+	{ KE_KEY,	0x04 | IDEAPAD_WMI_KEY, { KEY_SELECTIVE_SCREENSHOT } },
+	/* Lenovo Support */
+	{ KE_KEY,	0x07 | IDEAPAD_WMI_KEY, { KEY_HELP } },
+	{ KE_KEY,	0x0e | IDEAPAD_WMI_KEY, { KEY_PICKUP_PHONE } },
+	{ KE_KEY,	0x0f | IDEAPAD_WMI_KEY, { KEY_HANGUP_PHONE } },
 	/* Dark mode toggle */
 	{ KE_KEY,	0x13 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
 	/* Sound profile switch */
diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index f360370d5002..e1fbc35504d4 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -36,6 +36,13 @@ static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
 		},
 	},
+	{
+		/* Lenovo Yoga 7 14ACN6 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 711252e52d8e..95a86e0dfd77 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -209,54 +209,6 @@ raid_attr_ro_state(level);
 raid_attr_ro_fn(resync);
 raid_attr_ro_state_fn(state);
 
-static void raid_component_release(struct device *dev)
-{
-	struct raid_component *rc =
-		container_of(dev, struct raid_component, dev);
-	dev_printk(KERN_ERR, rc->dev.parent, "COMPONENT RELEASE\n");
-	put_device(rc->dev.parent);
-	kfree(rc);
-}
-
-int raid_component_add(struct raid_template *r,struct device *raid_dev,
-		       struct device *component_dev)
-{
-	struct device *cdev =
-		attribute_container_find_class_device(&r->raid_attrs.ac,
-						      raid_dev);
-	struct raid_component *rc;
-	struct raid_data *rd = dev_get_drvdata(cdev);
-	int err;
-
-	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&rc->node);
-	device_initialize(&rc->dev);
-	rc->dev.release = raid_component_release;
-	rc->dev.parent = get_device(component_dev);
-	rc->num = rd->component_count++;
-
-	dev_set_name(&rc->dev, "component-%d", rc->num);
-	list_add_tail(&rc->node, &rd->component_list);
-	rc->dev.class = &raid_class.class;
-	err = device_add(&rc->dev);
-	if (err)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	put_device(&rc->dev);
-	list_del(&rc->node);
-	rd->component_count--;
-	put_device(component_dev);
-	kfree(rc);
-	return err;
-}
-EXPORT_SYMBOL(raid_component_add);
-
 struct raid_template *
 raid_class_attach(struct raid_function_template *ft)
 {
diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
index cd27562ec922..6c529b37f3b4 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -303,12 +303,11 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
-		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);
 		spin_unlock_irqrestore(snic->shost->host_lock, flags);
-		kfree(tgt);
+		put_device(&tgt->dev);
 		tgt = NULL;
 
 		return tgt;
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 26e663369319..f2825a2f1c17 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -316,12 +316,6 @@ static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
 	xspi->rx_bytes -= nrx;
 
 	while (ntx || nrx) {
-		/* When xspi in busy condition, bytes may send failed,
-		 * then spi control did't work thoroughly, add one byte delay
-		 */
-		if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
-			udelay(10);
-
 		if (ntx) {
 			if (xspi->txbuf)
 				cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
@@ -391,6 +385,11 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 		if (xspi->tx_bytes) {
 			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
 		} else {
+			/* Fixed delay due to controller limitation with
+			 * RX_NEMPTY incorrect status
+			 * Xilinx AR:65885 contains more details
+			 */
+			udelay(10);
 			cdns_spi_process_fifo(xspi, 0, trans_cnt);
 			cdns_spi_write(xspi, CDNS_SPI_IDR,
 				       CDNS_SPI_IXR_DEFAULT);
@@ -438,12 +437,18 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 		cdns_spi_setup_transfer(spi, transfer);
 	} else {
 		/* Set TX empty threshold to half of FIFO depth
-		 * only if TX bytes are more than half FIFO depth.
+		 * only if TX bytes are more than FIFO depth.
 		 */
 		if (xspi->tx_bytes > xspi->tx_fifo_depth)
 			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
 	}
 
+	/* When xspi in busy condition, bytes may send failed,
+	 * then spi control didn't work thoroughly, add one byte delay
+	 */
+	if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
+		udelay(10);
+
 	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
 	spi_transfer_delay_exec(transfer);
 
diff --git a/drivers/thunderbolt/tmu.c b/drivers/thunderbolt/tmu.c
index 626aca3124b1..d9544600b386 100644
--- a/drivers/thunderbolt/tmu.c
+++ b/drivers/thunderbolt/tmu.c
@@ -415,7 +415,8 @@ int tb_switch_tmu_disable(struct tb_switch *sw)
 		 * uni-directional mode and we don't want to change it's TMU
 		 * mode.
 		 */
-		tb_switch_tmu_rate_write(sw, TB_SWITCH_TMU_RATE_OFF);
+		ret = tb_switch_tmu_rate_write(sw, TB_SWITCH_TMU_RATE_OFF);
+			return ret;
 
 		tb_port_tmu_time_sync_disable(up);
 		ret = tb_port_tmu_time_sync_disable(down);
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 341abaed4ce2..069de553127c 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -164,6 +164,9 @@ config LEGACY_TIOCSTI
 	  userspace depends on this functionality to continue operating
 	  normally.
 
+	  Processes which run with CAP_SYS_ADMIN, such as BRLTTY, can
+	  use TIOCSTI even when this is set to N.
+
 	  This functionality can be changed at runtime with the
 	  dev.tty.legacy_tiocsti sysctl. This configuration option sets
 	  the default value of the sysctl.
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 82d02e7f3b4f..6e6d0dc5ece5 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -225,7 +225,7 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
 		   REG_UFS_CFG1);
 
-	if (host->hw_ver.major == 0x05)
+	if (host->hw_ver.major >= 0x05)
 		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
 
 	/* make sure above configuration is applied before we return */
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index c4e0da6db719..9ec91017a7f3 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -27,7 +27,7 @@
  *
  * Called with j_list_lock held.
  */
-static inline void __buffer_unlink_first(struct journal_head *jh)
+static inline void __buffer_unlink(struct journal_head *jh)
 {
 	transaction_t *transaction = jh->b_cp_transaction;
 
@@ -40,23 +40,6 @@ static inline void __buffer_unlink_first(struct journal_head *jh)
 	}
 }
 
-/*
- * Unlink a buffer from a transaction checkpoint(io) list.
- *
- * Called with j_list_lock held.
- */
-static inline void __buffer_unlink(struct journal_head *jh)
-{
-	transaction_t *transaction = jh->b_cp_transaction;
-
-	__buffer_unlink_first(jh);
-	if (transaction->t_checkpoint_io_list == jh) {
-		transaction->t_checkpoint_io_list = jh->b_cpnext;
-		if (transaction->t_checkpoint_io_list == jh)
-			transaction->t_checkpoint_io_list = NULL;
-	}
-}
-
 /*
  * Check a checkpoint buffer could be release or not.
  *
@@ -366,50 +349,10 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 
 /* Checkpoint list management */
 
-/*
- * journal_clean_one_cp_list
- *
- * Find all the written-back checkpoint buffers in the given list and
- * release them. If 'destroy' is set, clean all buffers unconditionally.
- *
- * Called with j_list_lock held.
- * Returns 1 if we freed the transaction, 0 otherwise.
- */
-static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
-{
-	struct journal_head *last_jh;
-	struct journal_head *next_jh = jh;
-
-	if (!jh)
-		return 0;
-
-	last_jh = jh->b_cpprev;
-	do {
-		jh = next_jh;
-		next_jh = jh->b_cpnext;
-
-		if (!destroy && __cp_buffer_busy(jh))
-			return 0;
-
-		if (__jbd2_journal_remove_checkpoint(jh))
-			return 1;
-		/*
-		 * This function only frees up some memory
-		 * if possible so we dont have an obligation
-		 * to finish processing. Bail out if preemption
-		 * requested:
-		 */
-		if (need_resched())
-			return 0;
-	} while (jh != last_jh);
-
-	return 0;
-}
-
 /*
  * journal_shrink_one_cp_list
  *
- * Find 'nr_to_scan' written-back checkpoint buffers in the given list
+ * Find all the written-back checkpoint buffers in the given list
  * and try to release them. If the whole transaction is released, set
  * the 'released' parameter. Return the number of released checkpointed
  * buffers.
@@ -417,15 +360,15 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
-						unsigned long *nr_to_scan,
-						bool *released)
+						bool destroy, bool *released)
 {
 	struct journal_head *last_jh;
 	struct journal_head *next_jh = jh;
 	unsigned long nr_freed = 0;
 	int ret;
 
-	if (!jh || *nr_to_scan == 0)
+	*released = false;
+	if (!jh)
 		return 0;
 
 	last_jh = jh->b_cpprev;
@@ -433,12 +376,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		(*nr_to_scan)--;
-		if (__cp_buffer_busy(jh))
-			continue;
+		if (destroy) {
+			ret = __jbd2_journal_remove_checkpoint(jh);
+		} else {
+			ret = jbd2_journal_try_remove_checkpoint(jh);
+			if (ret < 0)
+				continue;
+		}
 
 		nr_freed++;
-		ret = __jbd2_journal_remove_checkpoint(jh);
 		if (ret) {
 			*released = true;
 			break;
@@ -446,7 +392,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 
 		if (need_resched())
 			break;
-	} while (jh != last_jh && *nr_to_scan);
+	} while (jh != last_jh);
 
 	return nr_freed;
 }
@@ -464,11 +410,11 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 						  unsigned long *nr_to_scan)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	bool released;
+	bool __maybe_unused released;
 	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
-	unsigned long nr_scanned = *nr_to_scan;
+	unsigned long freed;
 
 again:
 	spin_lock(&journal->j_list_lock);
@@ -497,19 +443,11 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		tid = transaction->t_tid;
-		released = false;
 
-		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						       nr_to_scan, &released);
-		if (*nr_to_scan == 0)
-			break;
-		if (need_resched() || spin_needbreak(&journal->j_list_lock))
-			break;
-		if (released)
-			continue;
-
-		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_io_list,
-						       nr_to_scan, &released);
+		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
+						   false, &released);
+		nr_freed += freed;
+		(*nr_to_scan) -= min(*nr_to_scan, freed);
 		if (*nr_to_scan == 0)
 			break;
 		if (need_resched() || spin_needbreak(&journal->j_list_lock))
@@ -530,9 +468,8 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	if (*nr_to_scan && next_tid)
 		goto again;
 out:
-	nr_scanned -= *nr_to_scan;
 	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,
-					  nr_freed, nr_scanned, next_tid);
+					  nr_freed, next_tid);
 
 	return nr_freed;
 }
@@ -548,7 +485,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	int ret;
+	bool released;
 
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
@@ -559,8 +496,8 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 	do {
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
-		ret = journal_clean_one_cp_list(transaction->t_checkpoint_list,
-						destroy);
+		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
+					   destroy, &released);
 		/*
 		 * This function only frees up some memory if possible so we
 		 * dont have an obligation to finish processing. Bail out if
@@ -568,23 +505,12 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 		 */
 		if (need_resched())
 			return;
-		if (ret)
-			continue;
-		/*
-		 * It is essential that we are as careful as in the case of
-		 * t_checkpoint_list with removing the buffer from the list as
-		 * we can possibly see not yet submitted buffers on io_list
-		 */
-		ret = journal_clean_one_cp_list(transaction->
-				t_checkpoint_io_list, destroy);
-		if (need_resched())
-			return;
 		/*
 		 * Stop scanning if we couldn't free the transaction. This
 		 * avoids pointless scanning of transactions which still
 		 * weren't checkpointed.
 		 */
-		if (!ret)
+		if (!released)
 			return;
 	} while (transaction != last_transaction);
 }
@@ -663,7 +589,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	jbd2_journal_put_journal_head(jh);
 
 	/* Is this transaction empty? */
-	if (transaction->t_checkpoint_list || transaction->t_checkpoint_io_list)
+	if (transaction->t_checkpoint_list)
 		return 0;
 
 	/*
@@ -694,6 +620,34 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	return 1;
 }
 
+/*
+ * Check the checkpoint buffer and try to remove it from the checkpoint
+ * list if it's clean. Returns -EBUSY if it is not clean, returns 1 if
+ * it frees the transaction, 0 otherwise.
+ *
+ * This function is called with j_list_lock held.
+ */
+int jbd2_journal_try_remove_checkpoint(struct journal_head *jh)
+{
+	struct buffer_head *bh = jh2bh(jh);
+
+	if (!trylock_buffer(bh))
+		return -EBUSY;
+	if (buffer_dirty(bh)) {
+		unlock_buffer(bh);
+		return -EBUSY;
+	}
+	unlock_buffer(bh);
+
+	/*
+	 * Buffer is clean and the IO has finished (we held the buffer
+	 * lock) so the checkpoint is done. We can safely remove the
+	 * buffer from this transaction.
+	 */
+	JBUFFER_TRACE(jh, "remove from checkpoint list");
+	return __jbd2_journal_remove_checkpoint(jh);
+}
+
 /*
  * journal_insert_checkpoint: put a committed buffer onto a checkpoint
  * list so that we know when it is safe to clean the transaction out of
@@ -755,7 +709,6 @@ void __jbd2_journal_drop_transaction(journal_t *journal, transaction_t *transact
 	J_ASSERT(transaction->t_forget == NULL);
 	J_ASSERT(transaction->t_shadow_list == NULL);
 	J_ASSERT(transaction->t_checkpoint_list == NULL);
-	J_ASSERT(transaction->t_checkpoint_io_list == NULL);
 	J_ASSERT(atomic_read(&transaction->t_updates) == 0);
 	J_ASSERT(journal->j_committing_transaction != transaction);
 	J_ASSERT(journal->j_running_transaction != transaction);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index b33155dd7001..1073259902a6 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -1141,8 +1141,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	/* Check if the transaction can be dropped now that we are finished */
-	if (commit_transaction->t_checkpoint_list == NULL &&
-	    commit_transaction->t_checkpoint_io_list == NULL) {
+	if (commit_transaction->t_checkpoint_list == NULL) {
 		__jbd2_journal_drop_transaction(journal, commit_transaction);
 		jbd2_journal_free_transaction(commit_transaction);
 	}
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 18611241f451..6ef5022949c4 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1784,8 +1784,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		 * Otherwise, if the buffer has been written to disk,
 		 * it is safe to remove the checkpoint and drop it.
 		 */
-		if (!buffer_dirty(bh)) {
-			__jbd2_journal_remove_checkpoint(jh);
+		if (jbd2_journal_try_remove_checkpoint(jh) >= 0) {
 			spin_unlock(&journal->j_list_lock);
 			goto drop;
 		}
@@ -2112,20 +2111,14 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
 
 	jh = bh2jh(bh);
 
-	if (buffer_locked(bh) || buffer_dirty(bh))
-		goto out;
-
 	if (jh->b_next_transaction != NULL || jh->b_transaction != NULL)
-		goto out;
+		return;
 
 	spin_lock(&journal->j_list_lock);
-	if (jh->b_cp_transaction != NULL) {
-		/* written-back checkpointed metadata buffer */
-		JBUFFER_TRACE(jh, "remove from checkpoint list");
-		__jbd2_journal_remove_checkpoint(jh);
-	}
+	/* Remove written-back checkpointed metadata buffer */
+	if (jh->b_cp_transaction != NULL)
+		jbd2_journal_try_remove_checkpoint(jh);
 	spin_unlock(&journal->j_list_lock);
-out:
 	return;
 }
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 9a18c5a69ace..aaffaaa336cc 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -472,20 +472,26 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	return result;
 }
 
-static void
-nfs_direct_join_group(struct list_head *list, struct inode *inode)
+static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 {
-	struct nfs_page *req, *next;
+	struct nfs_page *req, *subreq;
 
 	list_for_each_entry(req, list, wb_list) {
-		if (req->wb_head != req || req->wb_this_page == req)
+		if (req->wb_head != req)
 			continue;
-		for (next = req->wb_this_page;
-				next != req->wb_head;
-				next = next->wb_this_page) {
-			nfs_list_remove_request(next);
-			nfs_release_request(next);
-		}
+		subreq = req->wb_this_page;
+		if (subreq == req)
+			continue;
+		do {
+			/*
+			 * Remove subrequests from this list before freeing
+			 * them in the call to nfs_join_page_group().
+			 */
+			if (!list_empty(&subreq->wb_list)) {
+				nfs_list_remove_request(subreq);
+				nfs_release_request(subreq);
+			}
+		} while ((subreq = subreq->wb_this_page) != req);
 		nfs_join_page_group(req, inode);
 	}
 }
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 93e306bf4430..5d7e0511f351 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1360,7 +1360,6 @@ ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
 	for (i = 0; i < np; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
 		if (!pages[i]) {
-			np = i + 1;
 			err = -ENOMEM;
 			goto out;
 		}
@@ -1384,8 +1383,8 @@ ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
 	} while (exception.retry);
 
 out:
-	while (--np >= 0)
-		__free_page(pages[np]);
+	while (--i >= 0)
+		__free_page(pages[i]);
 	kfree(pages);
 
 	return err;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9faba2dac11d..fd752e0c4ec2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6004,9 +6004,8 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
 out_ok:
 	ret = res.acl_len;
 out_free:
-	for (i = 0; i < npages; i++)
-		if (pages[i])
-			__free_page(pages[i]);
+	while (--i >= 0)
+		__free_page(pages[i]);
 	if (res.acl_scratch)
 		__free_page(res.acl_scratch);
 	kfree(pages);
@@ -7181,8 +7180,15 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 		} else if (!nfs4_update_lock_stateid(lsp, &data->res.stateid))
 			goto out_restart;
 		break;
-	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_OLD_STATEID:
+		if (data->arg.new_lock_owner != 0 &&
+			nfs4_refresh_open_old_stateid(&data->arg.open_stateid,
+					lsp->ls_state))
+			goto out_restart;
+		if (nfs4_refresh_lock_old_stateid(&data->arg.lock_stateid, lsp))
+			goto out_restart;
+		fallthrough;
+	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_STALE_STATEID:
 	case -NFS4ERR_EXPIRED:
 		if (data->arg.new_lock_owner != 0) {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3aefbad4cc09..daf305daa751 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1354,9 +1354,9 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
 	if (clp->cl_minorversion) {
+		spin_lock(&clp->cl_lock);
 		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
 		refcount_inc(&dp->dl_stid.sc_count);
-		spin_lock(&clp->cl_lock);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
 	}
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 581691e4be49..7ec16879756e 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -725,6 +725,11 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		struct folio *folio = fbatch.folios[i];
 
 		folio_lock(folio);
+		if (unlikely(folio->mapping != mapping)) {
+			/* Exclude folios removed from the address space */
+			folio_unlock(folio);
+			continue;
+		}
 		head = folio_buffers(folio);
 		if (!head) {
 			create_empty_buffers(&folio->page, i_blocksize(inode), 0);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 420510f6a545..f05850d6bef7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -759,12 +759,14 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 static const struct mm_walk_ops smaps_walk_ops = {
 	.pmd_entry		= smaps_pte_range,
 	.hugetlb_entry		= smaps_hugetlb_range,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static const struct mm_walk_ops smaps_shmem_walk_ops = {
 	.pmd_entry		= smaps_pte_range,
 	.hugetlb_entry		= smaps_hugetlb_range,
 	.pte_hole		= smaps_pte_hole,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 /*
@@ -1245,6 +1247,7 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
 static const struct mm_walk_ops clear_refs_walk_ops = {
 	.pmd_entry		= clear_refs_pte_range,
 	.test_walk		= clear_refs_test_walk,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 static ssize_t clear_refs_write(struct file *file, const char __user *buf,
@@ -1621,6 +1624,7 @@ static const struct mm_walk_ops pagemap_ops = {
 	.pmd_entry	= pagemap_pmd_range,
 	.pte_hole	= pagemap_pte_hole,
 	.hugetlb_entry	= pagemap_hugetlb_range,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 /*
@@ -1932,6 +1936,7 @@ static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 static const struct mm_walk_ops show_numa_ops = {
 	.hugetlb_entry = gather_hugetlb_stats,
 	.pmd_entry = gather_pte_stats,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 /*
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index f8813c1e059b..40aa08741ef2 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1534,7 +1534,7 @@ enum drm_dp_phy {
 
 #define DP_BRANCH_OUI_HEADER_SIZE	0xc
 #define DP_RECEIVER_CAP_SIZE		0xf
-#define DP_DSC_RECEIVER_CAP_SIZE        0xf
+#define DP_DSC_RECEIVER_CAP_SIZE        0x10 /* DSC Capabilities 0x60 through 0x6F */
 #define EDP_PSR_RECEIVER_CAP_SIZE	2
 #define EDP_DISPLAY_CTL_CAP_SIZE	3
 #define DP_LTTPR_COMMON_CAP_SIZE	8
diff --git a/include/drm/drm_probe_helper.h b/include/drm/drm_probe_helper.h
index 4977e0ab72db..fad3c4003b2b 100644
--- a/include/drm/drm_probe_helper.h
+++ b/include/drm/drm_probe_helper.h
@@ -25,6 +25,7 @@ void drm_kms_helper_connector_hotplug_event(struct drm_connector *connector);
 
 void drm_kms_helper_poll_disable(struct drm_device *dev);
 void drm_kms_helper_poll_enable(struct drm_device *dev);
+void drm_kms_helper_poll_reschedule(struct drm_device *dev);
 bool drm_kms_helper_is_poll_worker(void);
 
 enum drm_mode_status drm_crtc_helper_mode_valid_fixed(struct drm_crtc *crtc,
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1ef013324237..06f1b292f8a0 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -183,6 +183,39 @@ int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale);
  */
 bool clk_is_match(const struct clk *p, const struct clk *q);
 
+/**
+ * clk_rate_exclusive_get - get exclusivity over the rate control of a
+ *                          producer
+ * @clk: clock source
+ *
+ * This function allows drivers to get exclusive control over the rate of a
+ * provider. It prevents any other consumer to execute, even indirectly,
+ * opereation which could alter the rate of the provider or cause glitches
+ *
+ * If exlusivity is claimed more than once on clock, even by the same driver,
+ * the rate effectively gets locked as exclusivity can't be preempted.
+ *
+ * Must not be called from within atomic context.
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_rate_exclusive_get(struct clk *clk);
+
+/**
+ * clk_rate_exclusive_put - release exclusivity over the rate control of a
+ *                          producer
+ * @clk: clock source
+ *
+ * This function allows drivers to release the exclusivity it previously got
+ * from clk_rate_exclusive_get()
+ *
+ * The caller must balance the number of clk_rate_exclusive_get() and
+ * clk_rate_exclusive_put() calls.
+ *
+ * Must not be called from within atomic context.
+ */
+void clk_rate_exclusive_put(struct clk *clk);
+
 #else
 
 static inline int clk_notifier_register(struct clk *clk,
@@ -236,6 +269,13 @@ static inline bool clk_is_match(const struct clk *p, const struct clk *q)
 	return p == q;
 }
 
+static inline int clk_rate_exclusive_get(struct clk *clk)
+{
+	return 0;
+}
+
+static inline void clk_rate_exclusive_put(struct clk *clk) {}
+
 #endif
 
 #ifdef CONFIG_HAVE_CLK_PREPARE
@@ -583,38 +623,6 @@ struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id);
  */
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id);
-/**
- * clk_rate_exclusive_get - get exclusivity over the rate control of a
- *                          producer
- * @clk: clock source
- *
- * This function allows drivers to get exclusive control over the rate of a
- * provider. It prevents any other consumer to execute, even indirectly,
- * opereation which could alter the rate of the provider or cause glitches
- *
- * If exlusivity is claimed more than once on clock, even by the same driver,
- * the rate effectively gets locked as exclusivity can't be preempted.
- *
- * Must not be called from within atomic context.
- *
- * Returns success (0) or negative errno.
- */
-int clk_rate_exclusive_get(struct clk *clk);
-
-/**
- * clk_rate_exclusive_put - release exclusivity over the rate control of a
- *                          producer
- * @clk: clock source
- *
- * This function allows drivers to release the exclusivity it previously got
- * from clk_rate_exclusive_get()
- *
- * The caller must balance the number of clk_rate_exclusive_get() and
- * clk_rate_exclusive_put() calls.
- *
- * Must not be called from within atomic context.
- */
-void clk_rate_exclusive_put(struct clk *clk);
 
 /**
  * clk_enable - inform the system when the clock source should be running.
@@ -974,14 +982,6 @@ static inline void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks) {}
 
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
 
-
-static inline int clk_rate_exclusive_get(struct clk *clk)
-{
-	return 0;
-}
-
-static inline void clk_rate_exclusive_put(struct clk *clk) {}
-
 static inline int clk_enable(struct clk *clk)
 {
 	return 0;
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 980b76a1237e..d629094fac6e 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -71,8 +71,10 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
-extern void cpuset_read_lock(void);
-extern void cpuset_read_unlock(void);
+extern void inc_dl_tasks_cs(struct task_struct *task);
+extern void dec_dl_tasks_cs(struct task_struct *task);
+extern void cpuset_lock(void);
+extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -189,8 +191,10 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
-static inline void cpuset_read_lock(void) { }
-static inline void cpuset_read_unlock(void) { }
+static inline void inc_dl_tasks_cs(struct task_struct *task) { }
+static inline void dec_dl_tasks_cs(struct task_struct *task) { }
+static inline void cpuset_lock(void) { }
+static inline void cpuset_unlock(void) { }
 
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f619bae1dcc5..c212da35a052 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -622,12 +622,6 @@ struct transaction_s
 	 */
 	struct journal_head	*t_checkpoint_list;
 
-	/*
-	 * Doubly-linked circular list of all buffers submitted for IO while
-	 * checkpointing. [j_list_lock]
-	 */
-	struct journal_head	*t_checkpoint_io_list;
-
 	/*
 	 * Doubly-linked circular list of metadata buffers being
 	 * shadowed by log IO.  The IO buffers on the iobuf list and
@@ -1449,6 +1443,7 @@ extern void jbd2_journal_commit_transaction(journal_t *);
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
 unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
 int __jbd2_journal_remove_checkpoint(struct journal_head *);
+int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
 void jbd2_journal_destroy_checkpoint(journal_t *journal);
 void __jbd2_journal_insert_checkpoint(struct journal_head *, transaction_t *);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d1fd7c544dcd..6585547c5c06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3381,15 +3381,24 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
  * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
  * a (NUMA hinting) fault is required.
  */
-static inline bool gup_can_follow_protnone(unsigned int flags)
+static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
+					   unsigned int flags)
 {
 	/*
-	 * FOLL_FORCE has to be able to make progress even if the VMA is
-	 * inaccessible. Further, FOLL_FORCE access usually does not represent
-	 * application behaviour and we should avoid triggering NUMA hinting
-	 * faults.
+	 * If callers don't want to honor NUMA hinting faults, no need to
+	 * determine if we would actually have to trigger a NUMA hinting fault.
 	 */
-	return flags & FOLL_FORCE;
+	if (!(flags & FOLL_HONOR_NUMA_FAULT))
+		return true;
+
+	/*
+	 * NUMA hinting faults don't apply in inaccessible (PROT_NONE) VMAs.
+	 *
+	 * Requiring a fault here even for inaccessible VMAs would mean that
+	 * FOLL_FORCE cannot make any progress, because handle_mm_fault()
+	 * refuses to process NUMA hinting faults in inaccessible VMAs.
+	 */
+	return !vma_is_accessible(vma);
 }
 
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e74ce4a28cd..7d30dc4ff0ff 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1286,6 +1286,15 @@ enum {
 	FOLL_PCI_P2PDMA = 1 << 10,
 	/* allow interrupts from generic signals */
 	FOLL_INTERRUPTIBLE = 1 << 11,
+	/*
+	 * Always honor (trigger) NUMA hinting faults.
+	 *
+	 * FOLL_WRITE implicitly honors NUMA hinting faults because a
+	 * PROT_NONE-mapped page is not writable (exceptions with FOLL_FORCE
+	 * apply). get_user_pages_fast_only() always implicitly honors NUMA
+	 * hinting faults.
+	 */
+	FOLL_HONOR_NUMA_FAULT = 1 << 12,
 
 	/* See also internal only FOLL flags in mm/internal.h */
 };
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 27a6df448ee5..27cd1e59ccf7 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -6,6 +6,16 @@
 
 struct mm_walk;
 
+/* Locking requirement during a page walk. */
+enum page_walk_lock {
+	/* mmap_lock should be locked for read to stabilize the vma tree */
+	PGWALK_RDLOCK = 0,
+	/* vma will be write-locked during the walk */
+	PGWALK_WRLOCK = 1,
+	/* vma is expected to be already write-locked during the walk */
+	PGWALK_WRLOCK_VERIFY = 2,
+};
+
 /**
  * struct mm_walk_ops - callbacks for walk_page_range
  * @pgd_entry:		if set, called for each non-empty PGD (top-level) entry
@@ -66,6 +76,7 @@ struct mm_walk_ops {
 	int (*pre_vma)(unsigned long start, unsigned long end,
 		       struct mm_walk *walk);
 	void (*post_vma)(struct mm_walk *walk);
+	enum page_walk_lock walk_lock;
 };
 
 /*
diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index 6a9b177d5c41..e50416ba9cd9 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -77,7 +77,3 @@ DEFINE_RAID_ATTRIBUTE(enum raid_state, state)
 	
 struct raid_template *raid_class_attach(struct raid_function_template *);
 void raid_class_release(struct raid_template *);
-
-int __must_check raid_component_add(struct raid_template *, struct device *,
-				    struct device *);
-
diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f..2553918f0b61 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1852,7 +1852,9 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int task_can_attach(struct task_struct *p);
+extern int dl_bw_alloc(int cpu, u64 dl_bw);
+extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 7c4a0b72334e..c55fc453e33b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -59,6 +59,17 @@ int trace_raw_output_prep(struct trace_iterator *iter,
 extern __printf(2, 3)
 void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 
+/* Used to find the offset and length of dynamic fields in trace events */
+struct trace_dynamic_info {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	u16	offset;
+	u16	len;
+#else
+	u16	len;
+	u16	offset;
+#endif
+};
+
 /*
  * The trace entry - the most basic unit of tracing. This is what
  * is printed in the end as a single line in the trace output, such as:
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 59955ac33157..6e4e406d8cd2 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -724,23 +724,14 @@ static inline struct slave *bond_slave_has_mac(struct bonding *bond,
 }
 
 /* Caller must hold rcu_read_lock() for read */
-static inline bool bond_slave_has_mac_rx(struct bonding *bond, const u8 *mac)
+static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
 {
 	struct list_head *iter;
 	struct slave *tmp;
-	struct netdev_hw_addr *ha;
 
 	bond_for_each_slave_rcu(bond, tmp, iter)
 		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
 			return true;
-
-	if (netdev_uc_empty(bond->dev))
-		return false;
-
-	netdev_for_each_uc_addr(ha, bond->dev)
-		if (ether_addr_equal_64bits(mac, ha->addr))
-			return true;
-
 	return false;
 }
 
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 0bb32bfc6183..491ceb7ebe5d 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -222,8 +222,8 @@ struct inet_sock {
 	__s16			uc_ttl;
 	__u16			cmsg_flags;
 	struct ip_options_rcu __rcu	*inet_opt;
+	atomic_t		inet_id;
 	__be16			inet_sport;
-	__u16			inet_id;
 
 	__u8			tos;
 	__u8			min_ttl;
diff --git a/include/net/ip.h b/include/net/ip.h
index 530e7257e438..1872f570abed 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -532,8 +532,19 @@ static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
 	 * generator as much as we can.
 	 */
 	if (sk && inet_sk(sk)->inet_daddr) {
-		iph->id = htons(inet_sk(sk)->inet_id);
-		inet_sk(sk)->inet_id += segs;
+		int val;
+
+		/* avoid atomic operations for TCP,
+		 * as we hold socket lock at this point.
+		 */
+		if (sk_is_tcp(sk)) {
+			sock_owned_by_me(sk);
+			val = atomic_read(&inet_sk(sk)->inet_id);
+			atomic_set(&inet_sk(sk)->inet_id, val + segs);
+		} else {
+			val = atomic_add_return(segs, &inet_sk(sk)->inet_id);
+		}
+		iph->id = htons(val);
 		return;
 	}
 	if ((iph->frag_off & htons(IP_DF)) && !skb->ignore_df) {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 65510cfda37a..67d81f718666 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6578,6 +6578,7 @@ void ieee80211_stop_rx_ba_session(struct ieee80211_vif *vif, u16 ba_rx_bitmap,
  * marks frames marked in the bitmap as having been filtered. Afterwards, it
  * checks if any frames in the window starting from @ssn can now be released
  * (in case they were only waiting for frames that were filtered.)
+ * (Only work correctly if @max_rx_aggregation_subframes <= 64 frames)
  */
 void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 					  u16 ssn, u64 filtered,
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index ad97049e2888..9f7bf417b948 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -534,6 +534,7 @@ struct nft_set_elem_expr {
  *	@expr: stateful expression
  * 	@ops: set ops
  * 	@flags: set flags
+ *	@dead: set will be freed, never cleared
  *	@genmask: generation mask
  * 	@klen: key length
  * 	@dlen: data length
@@ -586,6 +587,11 @@ static inline void *nft_set_priv(const struct nft_set *set)
 	return (void *)set->data;
 }
 
+static inline bool nft_set_gc_is_pending(const struct nft_set *s)
+{
+	return refcount_read(&s->refs) != 1;
+}
+
 static inline struct nft_set *nft_set_container_of(const void *priv)
 {
 	return (void *)priv - offsetof(struct nft_set, data);
@@ -1817,6 +1823,7 @@ struct nftables_pernet {
 	u64			table_handle;
 	unsigned int		base_seq;
 	unsigned int		gc_seq;
+	u8			validate_state;
 };
 
 extern unsigned int nf_tables_net_id;
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index d9076a7a430c..6506221c5fe3 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -190,8 +190,8 @@ int rtnl_delete_link(struct net_device *dev, u32 portid, const struct nlmsghdr *
 int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 			u32 portid, const struct nlmsghdr *nlh);
 
-int rtnl_nla_parse_ifla(struct nlattr **tb, const struct nlattr *head, int len,
-			struct netlink_ext_ack *exterr);
+int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
+			     struct netlink_ext_ack *exterr);
 struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid);
 
 #define MODULE_ALIAS_RTNL_LINK(kind) MODULE_ALIAS("rtnl-link-" kind)
diff --git a/include/net/sock.h b/include/net/sock.h
index 415f3840a26a..d0d796d51a50 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1324,6 +1324,7 @@ struct proto {
 	/*
 	 * Pressure flag: try to collapse.
 	 * Technical note: it is used by multiple contexts non atomically.
+	 * Make sure to use READ_ONCE()/WRITE_ONCE() for all reads/writes.
 	 * All the __sk_mem_schedule() is of this nature: accounting
 	 * is strict, actions are advisory and have some latency.
 	 */
@@ -1424,7 +1425,7 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 static inline bool sk_under_global_memory_pressure(const struct sock *sk)
 {
 	return sk->sk_prot->memory_pressure &&
-		!!*sk->sk_prot->memory_pressure;
+		!!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
 static inline bool sk_under_memory_pressure(const struct sock *sk)
@@ -1436,7 +1437,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return !!*sk->sk_prot->memory_pressure;
+	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
 static inline long
@@ -1513,7 +1514,7 @@ proto_memory_pressure(struct proto *prot)
 {
 	if (!prot->memory_pressure)
 		return false;
-	return !!*prot->memory_pressure;
+	return !!READ_ONCE(*prot->memory_pressure);
 }
 
 
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 8f5ee380d309..5646ae15a957 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -462,11 +462,9 @@ TRACE_EVENT(jbd2_shrink_scan_exit,
 TRACE_EVENT(jbd2_shrink_checkpoint_list,
 
 	TP_PROTO(journal_t *journal, tid_t first_tid, tid_t tid, tid_t last_tid,
-		 unsigned long nr_freed, unsigned long nr_scanned,
-		 tid_t next_tid),
+		 unsigned long nr_freed, tid_t next_tid),
 
-	TP_ARGS(journal, first_tid, tid, last_tid, nr_freed,
-		nr_scanned, next_tid),
+	TP_ARGS(journal, first_tid, tid, last_tid, nr_freed, next_tid),
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
@@ -474,7 +472,6 @@ TRACE_EVENT(jbd2_shrink_checkpoint_list,
 		__field(tid_t, tid)
 		__field(tid_t, last_tid)
 		__field(unsigned long, nr_freed)
-		__field(unsigned long, nr_scanned)
 		__field(tid_t, next_tid)
 	),
 
@@ -484,15 +481,14 @@ TRACE_EVENT(jbd2_shrink_checkpoint_list,
 		__entry->tid		= tid;
 		__entry->last_tid	= last_tid;
 		__entry->nr_freed	= nr_freed;
-		__entry->nr_scanned	= nr_scanned;
 		__entry->next_tid	= next_tid;
 	),
 
 	TP_printk("dev %d,%d shrink transaction %u-%u(%u) freed %lu "
-		  "scanned %lu next transaction %u",
+		  "next transaction %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->first_tid, __entry->tid, __entry->last_tid,
-		  __entry->nr_freed, __entry->nr_scanned, __entry->next_tid)
+		  __entry->nr_freed, __entry->next_tid)
 );
 
 #endif /* _TRACE_JBD2_H */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3299ec69ce0d..5b9648c940b4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -57,6 +57,7 @@
 #include <linux/file.h>
 #include <linux/fs_parser.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/deadline.h>
 #include <linux/psi.h>
 #include <net/sock.h>
 
@@ -6696,6 +6697,9 @@ void cgroup_exit(struct task_struct *tsk)
 	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 	cset->nr_tasks--;
 
+	if (dl_task(tsk))
+		dec_dl_tasks_cs(tsk);
+
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
 	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
 		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e4ca2dd2b764..2c76fcd9f0bc 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -193,6 +193,14 @@ struct cpuset {
 	int use_parent_ecpus;
 	int child_ecpus_count;
 
+	/*
+	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
+	 * know when to rebuild associated root domain bandwidth information.
+	 */
+	int nr_deadline_tasks;
+	int nr_migrate_dl_tasks;
+	u64 sum_migrate_dl_bw;
+
 	/* Invalid partition error code, not lock protected */
 	enum prs_errcode prs_err;
 
@@ -245,6 +253,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 	return css_cs(cs->css.parent);
 }
 
+void inc_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks++;
+}
+
+void dec_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks--;
+}
+
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_ONLINE,
@@ -366,22 +388,23 @@ static struct cpuset top_cpuset = {
 		if (is_cpuset_online(((des_cs) = css_cs((pos_css)))))
 
 /*
- * There are two global locks guarding cpuset structures - cpuset_rwsem and
+ * There are two global locks guarding cpuset structures - cpuset_mutex and
  * callback_lock. We also require taking task_lock() when dereferencing a
  * task's cpuset pointer. See "The task_lock() exception", at the end of this
- * comment.  The cpuset code uses only cpuset_rwsem write lock.  Other
- * kernel subsystems can use cpuset_read_lock()/cpuset_read_unlock() to
- * prevent change to cpuset structures.
+ * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
+ * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
+ * structures. Note that cpuset_mutex needs to be a mutex as it is used in
+ * paths that rely on priority inheritance (e.g. scheduler - on RT) for
+ * correctness.
  *
  * A task must hold both locks to modify cpusets.  If a task holds
- * cpuset_rwsem, it blocks others wanting that rwsem, ensuring that it
- * is the only task able to also acquire callback_lock and be able to
- * modify cpusets.  It can perform various checks on the cpuset structure
- * first, knowing nothing will change.  It can also allocate memory while
- * just holding cpuset_rwsem.  While it is performing these checks, various
- * callback routines can briefly acquire callback_lock to query cpusets.
- * Once it is ready to make the changes, it takes callback_lock, blocking
- * everyone else.
+ * cpuset_mutex, it blocks others, ensuring that it is the only task able to
+ * also acquire callback_lock and be able to modify cpusets.  It can perform
+ * various checks on the cpuset structure first, knowing nothing will change.
+ * It can also allocate memory while just holding cpuset_mutex.  While it is
+ * performing these checks, various callback routines can briefly acquire
+ * callback_lock to query cpusets.  Once it is ready to make the changes, it
+ * takes callback_lock, blocking everyone else.
  *
  * Calls to the kernel memory allocator can not be made while holding
  * callback_lock, as that would risk double tripping on callback_lock
@@ -403,16 +426,16 @@ static struct cpuset top_cpuset = {
  * guidelines for accessing subsystem state in kernel/cgroup.c
  */
 
-DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
+static DEFINE_MUTEX(cpuset_mutex);
 
-void cpuset_read_lock(void)
+void cpuset_lock(void)
 {
-	percpu_down_read(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 }
 
-void cpuset_read_unlock(void)
+void cpuset_unlock(void)
 {
-	percpu_up_read(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 static DEFINE_SPINLOCK(callback_lock);
@@ -496,7 +519,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
  * One way or another, we guarantee to return some non-empty subset
  * of cpu_online_mask.
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_mutex held.
  */
 static void guarantee_online_cpus(struct task_struct *tsk,
 				  struct cpumask *pmask)
@@ -538,7 +561,7 @@ static void guarantee_online_cpus(struct task_struct *tsk,
  * One way or another, we guarantee to return some non-empty subset
  * of node_states[N_MEMORY].
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_mutex held.
  */
 static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 {
@@ -550,7 +573,7 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 /*
  * update task's spread flag if cpuset's page/slab spread flag is set
  *
- * Call with callback_lock or cpuset_rwsem held. The check can be skipped
+ * Call with callback_lock or cpuset_mutex held. The check can be skipped
  * if on default hierarchy.
  */
 static void cpuset_update_task_spread_flags(struct cpuset *cs,
@@ -575,7 +598,7 @@ static void cpuset_update_task_spread_flags(struct cpuset *cs,
  *
  * One cpuset is a subset of another if all its allowed CPUs and
  * Memory Nodes are a subset of the other, and its exclusive flags
- * are only set if the other's are set.  Call holding cpuset_rwsem.
+ * are only set if the other's are set.  Call holding cpuset_mutex.
  */
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
@@ -713,7 +736,7 @@ static int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
  * If we replaced the flag and mask values of the current cpuset
  * (cur) with those values in the trial cpuset (trial), would
  * our various subset and exclusive rules still be valid?  Presumes
- * cpuset_rwsem held.
+ * cpuset_mutex held.
  *
  * 'cur' is the address of an actual, in-use cpuset.  Operations
  * such as list traversal that depend on the actual address of the
@@ -829,7 +852,7 @@ static void update_domain_attr_tree(struct sched_domain_attr *dattr,
 	rcu_read_unlock();
 }
 
-/* Must be called with cpuset_rwsem held.  */
+/* Must be called with cpuset_mutex held.  */
 static inline int nr_cpusets(void)
 {
 	/* jump label reference count + the top-level cpuset */
@@ -855,7 +878,7 @@ static inline int nr_cpusets(void)
  * domains when operating in the severe memory shortage situations
  * that could cause allocation failures below.
  *
- * Must be called with cpuset_rwsem held.
+ * Must be called with cpuset_mutex held.
  *
  * The three key local variables below are:
  *    cp - cpuset pointer, used (together with pos_css) to perform a
@@ -1066,11 +1089,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
-static void update_tasks_root_domain(struct cpuset *cs)
+static void dl_update_tasks_root_domain(struct cpuset *cs)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
@@ -1079,12 +1105,12 @@ static void update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void rebuild_root_domains(void)
+static void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
@@ -1107,7 +1133,7 @@ static void rebuild_root_domains(void)
 
 		rcu_read_unlock();
 
-		update_tasks_root_domain(cs);
+		dl_update_tasks_root_domain(cs);
 
 		rcu_read_lock();
 		css_put(&cs->css);
@@ -1121,7 +1147,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	mutex_lock(&sched_domains_mutex);
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	rebuild_root_domains();
+	dl_rebuild_rd_accounting();
 	mutex_unlock(&sched_domains_mutex);
 }
 
@@ -1134,7 +1160,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  * 'cpus' is removed, then call this routine to rebuild the
  * scheduler's dynamic sched domains.
  *
- * Call with cpuset_rwsem held.  Takes cpus_read_lock().
+ * Call with cpuset_mutex held.  Takes cpus_read_lock().
  */
 static void rebuild_sched_domains_locked(void)
 {
@@ -1145,7 +1171,7 @@ static void rebuild_sched_domains_locked(void)
 	int ndoms;
 
 	lockdep_assert_cpus_held();
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * If we have raced with CPU hotplug, return early to avoid
@@ -1196,9 +1222,9 @@ static void rebuild_sched_domains_locked(void)
 void rebuild_sched_domains(void)
 {
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	rebuild_sched_domains_locked();
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 }
 
@@ -1208,7 +1234,7 @@ void rebuild_sched_domains(void)
  * @new_cpus: the temp variable for the new effective_cpus mask
  *
  * Iterate through each task of @cs updating its cpus_allowed to the
- * effective cpuset's.  As this function is called with cpuset_rwsem held,
+ * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable. For top_cpuset, task_cpu_possible_mask()
  * is used instead of effective_cpus to make sure all offline CPUs are also
  * included as hotplug code won't update cpumasks for tasks in top_cpuset.
@@ -1322,7 +1348,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * The parent must be a partition root.
@@ -1545,7 +1571,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
  *
  * On legacy hierarchy, effective_cpus will be the same with cpu_allowed.
  *
- * Called with cpuset_rwsem held
+ * Called with cpuset_mutex held
  */
 static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				 bool force)
@@ -1705,7 +1731,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	struct cpuset *sibling;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * Check all its siblings and call update_cpumasks_hier()
@@ -1955,12 +1981,12 @@ static void *cpuset_being_rebound;
  * @cs: the cpuset in which each task's mems_allowed mask needs to be changed
  *
  * Iterate through each task of @cs updating its mems_allowed to the
- * effective cpuset's.  As this function is called with cpuset_rwsem held,
+ * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
  */
 static void update_tasks_nodemask(struct cpuset *cs)
 {
-	static nodemask_t newmems;	/* protected by cpuset_rwsem */
+	static nodemask_t newmems;	/* protected by cpuset_mutex */
 	struct css_task_iter it;
 	struct task_struct *task;
 
@@ -1973,7 +1999,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
 	 * take while holding tasklist_lock.  Forks can happen - the
 	 * mpol_dup() cpuset_being_rebound check will catch such forks,
 	 * and rebind their vma mempolicies too.  Because we still hold
-	 * the global cpuset_rwsem, we know that no other rebind effort
+	 * the global cpuset_mutex, we know that no other rebind effort
 	 * will be contending for the global variable cpuset_being_rebound.
 	 * It's ok if we rebind the same mm twice; mpol_rebind_mm()
 	 * is idempotent.  Also migrate pages in each mm to new nodes.
@@ -2019,7 +2045,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
  *
  * On legacy hierarchy, effective_mems will be the same with mems_allowed.
  *
- * Called with cpuset_rwsem held
+ * Called with cpuset_mutex held
  */
 static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 {
@@ -2072,7 +2098,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
  * mempolicies and if the cpuset is marked 'memory_migrate',
  * migrate the tasks pages to the new memory.
  *
- * Call with cpuset_rwsem held. May take callback_lock during call.
+ * Call with cpuset_mutex held. May take callback_lock during call.
  * Will take tasklist_lock, scan tasklist for tasks in cpuset cs,
  * lock each such tasks mm->mmap_lock, scan its vma's and rebind
  * their mempolicies to the cpusets new mems_allowed.
@@ -2164,7 +2190,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
  * @cs: the cpuset in which each task's spread flags needs to be changed
  *
  * Iterate through each task of @cs updating its spread flags.  As this
- * function is called with cpuset_rwsem held, cpuset membership stays
+ * function is called with cpuset_mutex held, cpuset membership stays
  * stable.
  */
 static void update_tasks_flags(struct cpuset *cs)
@@ -2184,7 +2210,7 @@ static void update_tasks_flags(struct cpuset *cs)
  * cs:		the cpuset to update
  * turning_on: 	whether the flag is being set or cleared
  *
- * Call with cpuset_rwsem held.
+ * Call with cpuset_mutex held.
  */
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
@@ -2234,7 +2260,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  * @new_prs: new partition root state
  * Return: 0 if successful, != 0 if error
  *
- * Call with cpuset_rwsem held.
+ * Call with cpuset_mutex held.
  */
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
@@ -2472,19 +2498,26 @@ static int cpuset_can_attach_check(struct cpuset *cs)
 	return 0;
 }
 
-/* Called by cgroups to determine if a cpuset is usable; cpuset_rwsem held */
+static void reset_migrate_dl_data(struct cpuset *cs)
+{
+	cs->nr_migrate_dl_tasks = 0;
+	cs->sum_migrate_dl_bw = 0;
+}
+
+/* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
+	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	int ret;
 
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
+	oldcs = cpuset_attach_old_cs;
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs);
@@ -2492,21 +2525,46 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->effective_cpus);
+		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
 		if (ret)
 			goto out_unlock;
+
+		if (dl_task(task)) {
+			cs->nr_migrate_dl_tasks++;
+			cs->sum_migrate_dl_bw += task->dl.dl_bw;
+		}
 	}
 
+	if (!cs->nr_migrate_dl_tasks)
+		goto out_success;
+
+	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
+		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+
+		if (unlikely(cpu >= nr_cpu_ids)) {
+			reset_migrate_dl_data(cs);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+		if (ret) {
+			reset_migrate_dl_data(cs);
+			goto out_unlock;
+		}
+	}
+
+out_success:
 	/*
 	 * Mark attach is in progress.  This makes validate_change() fail
 	 * changes which zero cpus/mems_allowed.
 	 */
 	cs->attach_in_progress++;
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
@@ -2518,15 +2576,23 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
-	percpu_up_write(&cpuset_rwsem);
+
+	if (cs->nr_migrate_dl_tasks) {
+		int cpu = cpumask_any(cs->effective_cpus);
+
+		dl_bw_free(cpu, cs->sum_migrate_dl_bw);
+		reset_migrate_dl_data(cs);
+	}
+
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
- * Protected by cpuset_rwsem. cpus_attach is used only by cpuset_attach_task()
+ * Protected by cpuset_mutex. cpus_attach is used only by cpuset_attach_task()
  * but we can't allocate it dynamically there.  Define it global and
  * allocate from cpuset_init().
  */
@@ -2535,7 +2601,7 @@ static nodemask_t cpuset_attach_nodemask_to;
 
 static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 {
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	if (cs != &top_cpuset)
 		guarantee_online_cpus(task, cpus_attach);
@@ -2565,7 +2631,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	cpus_updated = !cpumask_equal(cs->effective_cpus,
 				      oldcs->effective_cpus);
 	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
@@ -2622,11 +2688,17 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 out:
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
+	if (cs->nr_migrate_dl_tasks) {
+		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
+		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
+		reset_migrate_dl_data(cs);
+	}
+
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /* The various types of files and directories in a cpuset file system */
@@ -2658,7 +2730,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = 0;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -2694,7 +2766,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return retval;
 }
@@ -2707,7 +2779,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = -ENODEV;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2720,7 +2792,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return retval;
 }
@@ -2753,7 +2825,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	 * operation like this one can lead to a deadlock through kernfs
 	 * active_ref protection.  Let's break the protection.  Losing the
 	 * protection is okay as we check whether @cs is online after
-	 * grabbing cpuset_rwsem anyway.  This only happens on the legacy
+	 * grabbing cpuset_mutex anyway.  This only happens on the legacy
 	 * hierarchies.
 	 */
 	css_get(&cs->css);
@@ -2761,7 +2833,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	flush_work(&cpuset_hotplug_work);
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2785,7 +2857,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	free_cpuset(trialcs);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
@@ -2933,13 +3005,13 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 
 	css_get(&cs->css);
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
 	retval = update_prstate(cs, val);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	css_put(&cs->css);
 	return retval ?: nbytes;
@@ -3156,7 +3228,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		return 0;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
@@ -3207,7 +3279,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return 0;
 }
@@ -3228,7 +3300,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	struct cpuset *cs = css_cs(css);
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	if (is_partition_valid(cs))
 		update_prstate(cs, 0);
@@ -3247,7 +3319,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 }
 
@@ -3260,7 +3332,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
@@ -3273,7 +3345,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 	}
 
 	spin_unlock_irq(&callback_lock);
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
@@ -3294,14 +3366,14 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 		return 0;
 
 	lockdep_assert_held(&cgroup_mutex);
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs);
 	if (ret)
 		goto out_unlock;
 
-	ret = task_can_attach(task, cs->effective_cpus);
+	ret = task_can_attach(task);
 	if (ret)
 		goto out_unlock;
 
@@ -3315,7 +3387,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	 */
 	cs->attach_in_progress++;
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
@@ -3331,11 +3403,11 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
 	if (same_cs)
 		return;
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
@@ -3363,7 +3435,7 @@ static void cpuset_fork(struct task_struct *task)
 	}
 
 	/* CLONE_INTO_CGROUP */
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 	cpuset_attach_task(cs, task);
 
@@ -3371,7 +3443,7 @@ static void cpuset_fork(struct task_struct *task)
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 struct cgroup_subsys cpuset_cgrp_subsys = {
@@ -3472,7 +3544,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	is_empty = cpumask_empty(cs->cpus_allowed) ||
 		   nodes_empty(cs->mems_allowed);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
@@ -3482,7 +3554,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	if (is_empty)
 		remove_tasks_in_empty_cpuset(cs);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 }
 
 static void
@@ -3533,14 +3605,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/*
 	 * We have raced with task attaching. We wait until attaching
 	 * is finished, so we won't attach a task to an empty cpuset.
 	 */
 	if (cs->attach_in_progress) {
-		percpu_up_write(&cpuset_rwsem);
+		mutex_unlock(&cpuset_mutex);
 		goto retry;
 	}
 
@@ -3637,7 +3709,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 					    cpus_updated, mems_updated);
 
 unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /**
@@ -3667,7 +3739,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
 		ptmp = &tmp;
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* fetch the available cpus/mems and find out which changed how */
 	cpumask_copy(&new_cpus, cpu_active_mask);
@@ -3724,7 +3796,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		update_tasks_nodemask(&top_cpuset);
 	}
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/* if cpus or mems changed, we need to propagate to descendants */
 	if (cpus_updated || mems_updated) {
@@ -4155,7 +4227,7 @@ void __cpuset_memory_pressure_bump(void)
  *  - Used for /proc/<pid>/cpuset.
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
  *    doesn't really matter if tsk->cpuset changes after we read it,
- *    and we take cpuset_rwsem, keeping cpuset_attach() from changing it
+ *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
  *    anyway.
  */
 int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..90005760003f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7590,6 +7590,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct rq *rq;
+	bool cpuset_locked = false;
 
 	/* The pi code expects interrupts enabled */
 	BUG_ON(pi && in_interrupt());
@@ -7639,8 +7640,14 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
-	if (pi)
-		cpuset_read_lock();
+	/*
+	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
+	 * information.
+	 */
+	if (dl_policy(policy) || dl_policy(p->policy)) {
+		cpuset_locked = true;
+		cpuset_lock();
+	}
 
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
@@ -7716,8 +7723,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
-		if (pi)
-			cpuset_read_unlock();
+		if (cpuset_locked)
+			cpuset_unlock();
 		goto recheck;
 	}
 
@@ -7784,7 +7791,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
-		cpuset_read_unlock();
+		if (cpuset_locked)
+			cpuset_unlock();
 		rt_mutex_adjust_pi(p);
 	}
 
@@ -7796,8 +7804,8 @@ static int __sched_setscheduler(struct task_struct *p,
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
-	if (pi)
-		cpuset_read_unlock();
+	if (cpuset_locked)
+		cpuset_unlock();
 	return retval;
 }
 
@@ -9286,8 +9294,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_effective_cpus)
+int task_can_attach(struct task_struct *p)
 {
 	int ret = 0;
 
@@ -9300,21 +9307,9 @@ int task_can_attach(struct task_struct *p,
 	 * success of set_cpus_allowed_ptr() on all attached tasks
 	 * before cpus_mask may be changed.
 	 */
-	if (p->flags & PF_NO_SETAFFINITY) {
+	if (p->flags & PF_NO_SETAFFINITY)
 		ret = -EINVAL;
-		goto out;
-	}
 
-	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
-					      cs_effective_cpus)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs_effective_cpus);
-
-		if (unlikely(cpu >= nr_cpu_ids))
-			return -EINVAL;
-		ret = dl_cpu_busy(cpu, p);
-	}
-
-out:
 	return ret;
 }
 
@@ -9596,7 +9591,7 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_cpu_busy(cpu, NULL);
+		int ret = dl_bw_check_overflow(cpu);
 
 		if (ret)
 			return ret;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5a9a4b81c972..166c3e6eae61 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -16,6 +16,8 @@
  *                    Fabio Checconi <fchecconi@gmail.com>
  */
 
+#include <linux/cpuset.h>
+
 /*
  * Default limits for DL period; on the top end we guard against small util
  * tasks still getting ridiculously long effective runtimes, on the bottom end we
@@ -2596,6 +2598,12 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(p);
 
+	/*
+	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
+	 * keep track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	dec_dl_tasks_cs(p);
+
 	if (!task_on_rq_queued(p)) {
 		/*
 		 * Inactive timer is armed. However, p is leaving DEADLINE and
@@ -2636,6 +2644,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
 		put_task_struct(p);
 
+	/*
+	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep
+	 * track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	inc_dl_tasks_cs(p);
+
 	/* If p is not queued we will update its parameters at next wakeup. */
 	if (!task_on_rq_queued(p)) {
 		add_rq_bw(&p->dl, &rq->dl);
@@ -3044,26 +3058,38 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int dl_cpu_busy(int cpu, struct task_struct *p)
+enum dl_bw_request {
+	dl_bw_req_check_overflow = 0,
+	dl_bw_req_alloc,
+	dl_bw_req_free
+};
+
+static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 {
-	unsigned long flags, cap;
+	unsigned long flags;
 	struct dl_bw *dl_b;
-	bool overflow;
+	bool overflow = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cap = dl_bw_capacity(cpu);
-	overflow = __dl_overflow(dl_b, cap, 0, p ? p->dl.dl_bw : 0);
 
-	if (!overflow && p) {
-		/*
-		 * We reserve space for this task in the destination
-		 * root_domain, as we can't fail after this point.
-		 * We will free resources in the source root_domain
-		 * later on (see set_cpus_allowed_dl()).
-		 */
-		__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
+	if (req == dl_bw_req_free) {
+		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
+	} else {
+		unsigned long cap = dl_bw_capacity(cpu);
+
+		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
+
+		if (req == dl_bw_req_alloc && !overflow) {
+			/*
+			 * We reserve space in the destination
+			 * root_domain, as we can't fail after this point.
+			 * We will free resources in the source root_domain
+			 * later on (see set_cpus_allowed_dl()).
+			 */
+			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
+		}
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
@@ -3071,6 +3097,21 @@ int dl_cpu_busy(int cpu, struct task_struct *p)
 
 	return overflow ? -EBUSY : 0;
 }
+
+int dl_bw_check_overflow(int cpu)
+{
+	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
+}
+
+int dl_bw_alloc(int cpu, u64 dl_bw)
+{
+	return dl_bw_manage(dl_bw_req_alloc, cpu, dl_bw);
+}
+
+void dl_bw_free(int cpu, u64 dl_bw)
+{
+	dl_bw_manage(dl_bw_req_free, cpu, dl_bw);
+}
 #endif
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 81ac605b9cd5..ead91c1fbe75 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -330,7 +330,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int  dl_cpu_busy(int cpu, struct task_struct *p);
+extern int  dl_bw_check_overflow(int cpu);
 
 #ifdef CONFIG_CGROUP_SCHED
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fd051f85efd4..f4855be6ac2b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4196,8 +4196,15 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	 * will point to the same string as current_trace->name.
 	 */
 	mutex_lock(&trace_types_lock);
-	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name))
+	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name)) {
+		/* Close iter->trace before switching to the new current tracer */
+		if (iter->trace->close)
+			iter->trace->close(iter);
 		*iter->trace = *tr->current_trace;
+		/* Reopen the new current tracer */
+		if (iter->trace->open)
+			iter->trace->open(iter);
+	}
 	mutex_unlock(&trace_types_lock);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -5260,11 +5267,17 @@ int tracing_set_cpumask(struct trace_array *tr,
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 	}
 	arch_spin_unlock(&tr->max_lock);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index eee1f3ca4749..2daeac8e690a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1282,6 +1282,14 @@ static inline void trace_branch_disable(void)
 /* set ring buffers to default size if not already done so */
 int tracing_update_buffers(void);
 
+union trace_synth_field {
+	u8				as_u8;
+	u16				as_u16;
+	u32				as_u32;
+	u64				as_u64;
+	struct trace_dynamic_info	as_dynamic;
+};
+
 struct ftrace_event_field {
 	struct list_head	link;
 	const char		*name;
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d6a70aff2410..32109d092b10 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -127,7 +127,7 @@ static bool synth_event_match(const char *system, const char *event,
 
 struct synth_trace_event {
 	struct trace_entry	ent;
-	u64			fields[];
+	union trace_synth_field	fields[];
 };
 
 static int synth_event_define_fields(struct trace_event_call *call)
@@ -321,19 +321,19 @@ static const char *synth_field_fmt(char *type)
 
 static void print_synth_event_num_val(struct trace_seq *s,
 				      char *print_fmt, char *name,
-				      int size, u64 val, char *space)
+				      int size, union trace_synth_field *val, char *space)
 {
 	switch (size) {
 	case 1:
-		trace_seq_printf(s, print_fmt, name, (u8)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u8, space);
 		break;
 
 	case 2:
-		trace_seq_printf(s, print_fmt, name, (u16)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u16, space);
 		break;
 
 	case 4:
-		trace_seq_printf(s, print_fmt, name, (u32)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u32, space);
 		break;
 
 	default:
@@ -350,7 +350,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	struct synth_trace_event *entry;
 	struct synth_event *se;
-	unsigned int i, n_u64;
+	unsigned int i, j, n_u64;
 	char print_fmt[32];
 	const char *fmt;
 
@@ -374,43 +374,28 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		/* parameter values */
 		if (se->fields[i]->is_string) {
 			if (se->fields[i]->is_dynamic) {
-				u32 offset, data_offset;
-				char *str_field;
-
-				offset = (u32)entry->fields[n_u64];
-				data_offset = offset & 0xffff;
-
-				str_field = (char *)entry + data_offset;
+				union trace_synth_field *data = &entry->fields[n_u64];
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
 						 STR_VAR_LEN_MAX,
-						 str_field,
+						 (char *)entry + data->as_dynamic.offset,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;
 			} else {
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
 						 STR_VAR_LEN_MAX,
-						 (char *)&entry->fields[n_u64],
+						 (char *)&entry->fields[n_u64].as_u64,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
 		} else if (se->fields[i]->is_stack) {
-			u32 offset, data_offset, len;
-			unsigned long *p, *end;
-
-			offset = (u32)entry->fields[n_u64];
-			data_offset = offset & 0xffff;
-			len = offset >> 16;
-
-			p = (void *)entry + data_offset;
-			end = (void *)p + len - (sizeof(long) - 1);
+			union trace_synth_field *data = &entry->fields[n_u64];
+			unsigned long *p = (void *)entry + data->as_dynamic.offset;
 
 			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
-
-			for (; *p && p < end; p++)
-				trace_seq_printf(s, "=> %pS\n", (void *)*p);
+			for (j = 1; j < data->as_dynamic.len / sizeof(long); j++)
+				trace_seq_printf(s, "=> %pS\n", (void *)p[j]);
 			n_u64++;
-
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
@@ -419,13 +404,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 			print_synth_event_num_val(s, print_fmt,
 						  se->fields[i]->name,
 						  se->fields[i]->size,
-						  entry->fields[n_u64],
+						  &entry->fields[n_u64],
 						  space);
 
 			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
 				trace_seq_puts(s, " (");
 				trace_print_flags_seq(s, "|",
-						      entry->fields[n_u64],
+						      entry->fields[n_u64].as_u64,
 						      __flags);
 				trace_seq_putc(s, ')');
 			}
@@ -454,21 +439,16 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	int ret;
 
 	if (is_dynamic) {
-		u32 data_offset;
-
-		data_offset = struct_size(entry, fields, event->n_u64);
-		data_offset += data_size;
-
-		len = fetch_store_strlen((unsigned long)str_val);
+		union trace_synth_field *data = &entry->fields[*n_u64];
 
-		data_offset |= len << 16;
-		*(u32 *)&entry->fields[*n_u64] = data_offset;
+		data->as_dynamic.offset = struct_size(entry, fields, event->n_u64) + data_size;
+		data->as_dynamic.len = fetch_store_strlen((unsigned long)str_val);
 
 		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
 
 		(*n_u64)++;
 	} else {
-		str_field = (char *)&entry->fields[*n_u64];
+		str_field = (char *)&entry->fields[*n_u64].as_u64;
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 		if ((unsigned long)str_val < TASK_SIZE)
@@ -492,6 +472,7 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 				 unsigned int data_size,
 				 unsigned int *n_u64)
 {
+	union trace_synth_field *data = &entry->fields[*n_u64];
 	unsigned int len;
 	u32 data_offset;
 	void *data_loc;
@@ -504,10 +485,6 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 			break;
 	}
 
-	/* Include the zero'd element if it fits */
-	if (len < HIST_STACKTRACE_DEPTH)
-		len++;
-
 	len *= sizeof(long);
 
 	/* Find the dynamic section to copy the stack into. */
@@ -515,8 +492,9 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 	memcpy(data_loc, stack, len);
 
 	/* Fill in the field that holds the offset/len combo */
-	data_offset |= len << 16;
-	*(u32 *)&entry->fields[*n_u64] = data_offset;
+
+	data->as_dynamic.offset = data_offset;
+	data->as_dynamic.len = len;
 
 	(*n_u64)++;
 
@@ -550,7 +528,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		str_val = (char *)(long)var_ref_vals[val_idx];
 
 		if (event->dynamic_fields[i]->is_stack) {
-			len = *((unsigned long *)str_val);
+			/* reserve one extra element for size */
+			len = *((unsigned long *)str_val) + 1;
 			len *= sizeof(unsigned long);
 		} else {
 			len = fetch_store_strlen((unsigned long)str_val);
@@ -592,19 +571,19 @@ static notrace void trace_event_raw_event_synth(void *__data,
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&entry->fields[n_u64] = (u8)val;
+				entry->fields[n_u64].as_u8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&entry->fields[n_u64] = (u16)val;
+				entry->fields[n_u64].as_u16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&entry->fields[n_u64] = (u32)val;
+				entry->fields[n_u64].as_u32 = (u32)val;
 				break;
 
 			default:
-				entry->fields[n_u64] = val;
+				entry->fields[n_u64].as_u64 = val;
 				break;
 			}
 			n_u64++;
@@ -1790,19 +1769,19 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				state.entry->fields[n_u64].as_u8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				state.entry->fields[n_u64].as_u16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				state.entry->fields[n_u64].as_u32 = (u32)val;
 				break;
 
 			default:
-				state.entry->fields[n_u64] = val;
+				state.entry->fields[n_u64].as_u64 = val;
 				break;
 			}
 			n_u64++;
@@ -1883,19 +1862,19 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				state.entry->fields[n_u64].as_u8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				state.entry->fields[n_u64].as_u16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				state.entry->fields[n_u64].as_u32 = (u32)val;
 				break;
 
 			default:
-				state.entry->fields[n_u64] = val;
+				state.entry->fields[n_u64].as_u64 = val;
 				break;
 			}
 			n_u64++;
@@ -2030,19 +2009,19 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 	} else {
 		switch (field->size) {
 		case 1:
-			*(u8 *)&trace_state->entry->fields[field->offset] = (u8)val;
+			trace_state->entry->fields[field->offset].as_u8 = (u8)val;
 			break;
 
 		case 2:
-			*(u16 *)&trace_state->entry->fields[field->offset] = (u16)val;
+			trace_state->entry->fields[field->offset].as_u16 = (u16)val;
 			break;
 
 		case 4:
-			*(u32 *)&trace_state->entry->fields[field->offset] = (u32)val;
+			trace_state->entry->fields[field->offset].as_u32 = (u32)val;
 			break;
 
 		default:
-			trace_state->entry->fields[field->offset] = val;
+			trace_state->entry->fields[field->offset].as_u64 = val;
 			break;
 		}
 	}
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 590b3d51afae..ba37f768e2f2 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -231,7 +231,8 @@ static void irqsoff_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-
+	else
+		iter->private = NULL;
 }
 
 static void irqsoff_trace_close(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 330aee1c1a49..0469a04a355f 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -168,6 +168,8 @@ static void wakeup_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
+	else
+		iter->private = NULL;
 }
 
 static void wakeup_trace_close(struct trace_iterator *iter)
diff --git a/lib/clz_ctz.c b/lib/clz_ctz.c
index 0d3a686b5ba2..fb8c0c5c2bd2 100644
--- a/lib/clz_ctz.c
+++ b/lib/clz_ctz.c
@@ -28,36 +28,16 @@ int __weak __clzsi2(int val)
 }
 EXPORT_SYMBOL(__clzsi2);
 
-int __weak __clzdi2(long val);
-int __weak __ctzdi2(long val);
-#if BITS_PER_LONG == 32
-
-int __weak __clzdi2(long val)
+int __weak __clzdi2(u64 val);
+int __weak __clzdi2(u64 val)
 {
-	return 32 - fls((int)val);
+	return 64 - fls64(val);
 }
 EXPORT_SYMBOL(__clzdi2);
 
-int __weak __ctzdi2(long val)
+int __weak __ctzdi2(u64 val);
+int __weak __ctzdi2(u64 val)
 {
-	return __ffs((u32)val);
+	return __ffs64(val);
 }
 EXPORT_SYMBOL(__ctzdi2);
-
-#elif BITS_PER_LONG == 64
-
-int __weak __clzdi2(long val)
-{
-	return 64 - fls64((u64)val);
-}
-EXPORT_SYMBOL(__clzdi2);
-
-int __weak __ctzdi2(long val)
-{
-	return __ffs64((u64)val);
-}
-EXPORT_SYMBOL(__ctzdi2);
-
-#else
-#error BITS_PER_LONG not 32 or 64
-#endif
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb28a49d173c..3315eaf93f56 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4315,6 +4315,9 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
+	if (mt_in_rcu(mas->tree))
+		return false;
+
 	if ((mas->index != wr_mas->r_min) && (mas->last == wr_mas->r_max)) {
 		if (new_end < node_pivots)
 			wr_mas->pivots[new_end] = wr_mas->pivots[end];
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 1a31065b2036..976b9bd02a1b 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1136,7 +1136,6 @@ static void set_iter_tags(struct radix_tree_iter *iter,
 void __rcu **radix_tree_iter_resume(void __rcu **slot,
 					struct radix_tree_iter *iter)
 {
-	slot++;
 	iter->index = __radix_tree_iter_add(iter, 1);
 	iter->next_index = iter->index;
 	iter->tags = 0;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 37994fb6120c..81068829a7e3 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -384,6 +384,7 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 static const struct mm_walk_ops damon_mkold_ops = {
 	.pmd_entry = damon_mkold_pmd_entry,
 	.hugetlb_entry = damon_mkold_hugetlb_entry,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
@@ -519,6 +520,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 static const struct mm_walk_ops damon_young_ops = {
 	.pmd_entry = damon_young_pmd_entry,
 	.hugetlb_entry = damon_young_hugetlb_entry,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
diff --git a/mm/gup.c b/mm/gup.c
index e3e6c473bbc1..cdffc0edc20d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -551,7 +551,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	pte = *ptep;
 	if (!pte_present(pte))
 		goto no_page;
-	if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
+	if (pte_protnone(pte) && !gup_can_follow_protnone(vma, flags))
 		goto no_page;
 
 	page = vm_normal_page(vma, address, pte);
@@ -672,7 +672,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (likely(!pmd_trans_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
-	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(flags))
+	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
 		return no_page_table(vma, flags);
 
 	ptl = pmd_lock(mm, pmd);
@@ -820,6 +820,10 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
 		return NULL;
 
+	/*
+	 * We never set FOLL_HONOR_NUMA_FAULT because callers don't expect
+	 * to fail on PROT_NONE-mapped pages.
+	 */
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
@@ -2134,6 +2138,13 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
 		gup_flags |= FOLL_UNLOCKABLE;
 	}
 
+	/*
+	 * For now, always trigger NUMA hinting faults. Some GUP users like
+	 * KVM require the hint to be as the calling context of GUP is
+	 * functionally similar to a memory reference from task context.
+	 */
+	gup_flags |= FOLL_HONOR_NUMA_FAULT;
+
 	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
 	if (WARN_ON_ONCE((gup_flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
@@ -2394,7 +2405,14 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		struct page *page;
 		struct folio *folio;
 
-		if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
+		/*
+		 * Always fallback to ordinary GUP on PROT_NONE-mapped pages:
+		 * pte_access_permitted() better should reject these pages
+		 * either way: otherwise, GUP-fast might succeed in
+		 * cases where ordinary GUP would fail due to VMA access
+		 * permissions.
+		 */
+		if (pte_protnone(pte))
 			goto pte_unmap;
 
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
@@ -2784,8 +2802,8 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 
 		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
 			     pmd_devmap(pmd))) {
-			if (pmd_protnone(pmd) &&
-			    !gup_can_follow_protnone(flags))
+			/* See gup_pte_range() */
+			if (pmd_protnone(pmd))
 				return 0;
 
 			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
@@ -2965,7 +2983,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
 				       FOLL_FAST_ONLY | FOLL_NOFAULT |
-				       FOLL_PCI_P2PDMA)))
+				       FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
 		return -EINVAL;
 
 	if (gup_flags & FOLL_PIN)
diff --git a/mm/hmm.c b/mm/hmm.c
index 6a151c09de5e..a334c9bf0014 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -560,6 +560,7 @@ static const struct mm_walk_ops hmm_walk_ops = {
 	.pte_hole	= hmm_vma_walk_hole,
 	.hugetlb_entry	= hmm_vma_walk_hugetlb_entry,
 	.test_walk	= hmm_vma_walk_test,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 /**
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 624671aaa60d..4231a720a02c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1467,8 +1467,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
 		return ERR_PTR(-EFAULT);
 
-	/* Full NUMA hinting faults to serialise migration in fault paths */
-	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(flags))
+	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
 		return NULL;
 
 	if (!pmd_write(*pmd) && gup_must_unshare(vma, flags, page))
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6d97ac..8a2b57134b97 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -994,6 +994,16 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
 		smp_rmb();
 
+	/*
+	 * During GUP-fast we might not get called on the head page for a
+	 * hugetlb page that is mapped using cont-PTE, because GUP-fast does
+	 * not work with the abstracted hugetlb PTEs that always point at the
+	 * head page. For hugetlb, PageAnonExclusive only applies on the head
+	 * page (as it cannot be partially COW-shared), so lookup the head page.
+	 */
+	if (unlikely(!PageHead(page) && PageHuge(page)))
+		page = compound_head(page);
+
 	/*
 	 * Note that PageKsm() pages cannot be exclusive, and consequently,
 	 * cannot get pinned.
diff --git a/mm/ksm.c b/mm/ksm.c
index 0156bded3a66..8a8462037f5e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -454,6 +454,12 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
 
 static const struct mm_walk_ops break_ksm_ops = {
 	.pmd_entry = break_ksm_pmd_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
+static const struct mm_walk_ops break_ksm_lock_vma_ops = {
+	.pmd_entry = break_ksm_pmd_entry,
+	.walk_lock = PGWALK_WRLOCK,
 };
 
 /*
@@ -469,16 +475,17 @@ static const struct mm_walk_ops break_ksm_ops = {
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
-static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
+static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
 {
 	vm_fault_t ret = 0;
+	const struct mm_walk_ops *ops = lock_vma ?
+				&break_ksm_lock_vma_ops : &break_ksm_ops;
 
 	do {
 		int ksm_page;
 
 		cond_resched();
-		ksm_page = walk_page_range_vma(vma, addr, addr + 1,
-					       &break_ksm_ops, NULL);
+		ksm_page = walk_page_range_vma(vma, addr, addr + 1, ops, NULL);
 		if (WARN_ON_ONCE(ksm_page < 0))
 			return ksm_page;
 		if (!ksm_page)
@@ -564,7 +571,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (vma)
-		break_ksm(vma, addr);
+		break_ksm(vma, addr, false);
 	mmap_read_unlock(mm);
 }
 
@@ -870,7 +877,7 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
  * in cmp_and_merge_page on one of the rmap_items we would be removing.
  */
 static int unmerge_ksm_pages(struct vm_area_struct *vma,
-			     unsigned long start, unsigned long end)
+			     unsigned long start, unsigned long end, bool lock_vma)
 {
 	unsigned long addr;
 	int err = 0;
@@ -881,7 +888,7 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 		if (signal_pending(current))
 			err = -ERESTARTSYS;
 		else
-			err = break_ksm(vma, addr);
+			err = break_ksm(vma, addr, lock_vma);
 	}
 	return err;
 }
@@ -1028,7 +1035,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 				continue;
 			err = unmerge_ksm_pages(vma,
-						vma->vm_start, vma->vm_end);
+						vma->vm_start, vma->vm_end, false);
 			if (err)
 				goto error;
 		}
@@ -2528,7 +2535,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 		return 0;
 
 	if (vma->anon_vma) {
-		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end);
+		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end, true);
 		if (err)
 			return err;
 	}
@@ -2666,7 +2673,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 			return 0;		/* just ignore the advice */
 
 		if (vma->anon_vma) {
-			err = unmerge_ksm_pages(vma, start, end);
+			err = unmerge_ksm_pages(vma, start, end, true);
 			if (err)
 				return err;
 		}
diff --git a/mm/madvise.c b/mm/madvise.c
index b5ffbaf616f5..a3f72d551b5f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -227,6 +227,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 
 static const struct mm_walk_ops swapin_walk_ops = {
 	.pmd_entry		= swapin_walk_pmd_entry,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static void force_shm_swapin_readahead(struct vm_area_struct *vma,
@@ -375,7 +376,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pfn_folio(pmd_pfn(orig_pmd));
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_mapcount(folio) != 1)
+		if (folio_estimated_sharers(folio) != 1)
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -447,7 +448,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 * are sure it's worth. Split it if we are only owner.
 		 */
 		if (folio_test_large(folio)) {
-			if (folio_mapcount(folio) != 1)
+			if (folio_estimated_sharers(folio) != 1)
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
@@ -521,6 +522,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 static const struct mm_walk_ops cold_walk_ops = {
 	.pmd_entry = madvise_cold_or_pageout_pte_range,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static void madvise_cold_page_range(struct mmu_gather *tlb,
@@ -664,8 +666,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		 * deactivate all pages.
 		 */
 		if (folio_test_large(folio)) {
-			if (folio_mapcount(folio) != 1)
-				goto out;
+			if (folio_estimated_sharers(folio) != 1)
+				break;
 			folio_get(folio);
 			if (!folio_trylock(folio)) {
 				folio_put(folio);
@@ -741,6 +743,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 
 static const struct mm_walk_ops madvise_free_walk_ops = {
 	.pmd_entry		= madvise_free_pte_range,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static int madvise_free_single_vma(struct vm_area_struct *vma,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c823c35c2ed4..cfacd9ceccf6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6072,6 +6072,7 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 
 static const struct mm_walk_ops precharge_walk_ops = {
 	.pmd_entry	= mem_cgroup_count_precharge_pte_range,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 static unsigned long mem_cgroup_count_precharge(struct mm_struct *mm)
@@ -6351,6 +6352,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 
 static const struct mm_walk_ops charge_walk_ops = {
 	.pmd_entry	= mem_cgroup_move_charge_pte_range,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 static void mem_cgroup_move_charge(void)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 244dbfe075a2..3d75a25d9a22 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -836,6 +836,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 static const struct mm_walk_ops hwp_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 /*
@@ -2743,10 +2744,13 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (ret > 0) {
 		ret = soft_offline_in_use_page(page);
 	} else if (ret == 0) {
-		if (!page_handle_poison(page, true, false) && try_again) {
-			try_again = false;
-			flags &= ~MF_COUNT_INCREASED;
-			goto retry;
+		if (!page_handle_poison(page, true, false)) {
+			if (try_again) {
+				try_again = false;
+				flags &= ~MF_COUNT_INCREASED;
+				goto retry;
+			}
+			ret = -EBUSY;
 		}
 	}
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d524bf8d0e90..bf9159fb7428 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -715,6 +715,14 @@ static const struct mm_walk_ops queue_pages_walk_ops = {
 	.hugetlb_entry		= queue_folios_hugetlb,
 	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
+	.hugetlb_entry		= queue_folios_hugetlb,
+	.pmd_entry		= queue_folios_pte_range,
+	.test_walk		= queue_pages_test_walk,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 /*
@@ -735,7 +743,7 @@ static const struct mm_walk_ops queue_pages_walk_ops = {
 static int
 queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		nodemask_t *nodes, unsigned long flags,
-		struct list_head *pagelist)
+		struct list_head *pagelist, bool lock_vma)
 {
 	int err;
 	struct queue_pages qp = {
@@ -746,8 +754,10 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		.end = end,
 		.first = NULL,
 	};
+	const struct mm_walk_ops *ops = lock_vma ?
+			&queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
 
-	err = walk_page_range(mm, start, end, &queue_pages_walk_ops, &qp);
+	err = walk_page_range(mm, start, end, ops, &qp);
 
 	if (!qp.first)
 		/* whole range in hole */
@@ -1075,7 +1085,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	vma = find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
 	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
-			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
+			flags | MPOL_MF_DISCONTIG_OK, &pagelist, false);
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
@@ -1321,12 +1331,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 	 * Lock the VMAs before scanning for pages to migrate, to ensure we don't
 	 * miss a concurrently inserted page.
 	 */
-	vma_iter_init(&vmi, mm, start);
-	for_each_vma_range(vmi, vma, end)
-		vma_start_write(vma);
-
 	ret = queue_pages_range(mm, start, end, nmask,
-			  flags | MPOL_MF_INVERT, &pagelist);
+			  flags | MPOL_MF_INVERT, &pagelist, true);
 
 	if (ret < 0) {
 		err = ret;
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de60b0d..dae008fec805 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -286,6 +286,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 static const struct mm_walk_ops migrate_vma_walk_ops = {
 	.pmd_entry		= migrate_vma_collect_pmd,
 	.pte_hole		= migrate_vma_collect_hole,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 /*
diff --git a/mm/mincore.c b/mm/mincore.c
index 2d5be013a25a..9750b15f6694 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -177,6 +177,7 @@ static const struct mm_walk_ops mincore_walk_ops = {
 	.pmd_entry		= mincore_pte_range,
 	.pte_hole		= mincore_unmapped_range,
 	.hugetlb_entry		= mincore_hugetlb,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 /*
diff --git a/mm/mlock.c b/mm/mlock.c
index 39e03a37f0a9..62da0b798a13 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -365,6 +365,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 {
 	static const struct mm_walk_ops mlock_walk_ops = {
 		.pmd_entry = mlock_pte_range,
+		.walk_lock = PGWALK_WRLOCK_VERIFY,
 	};
 
 	/*
diff --git a/mm/mprotect.c b/mm/mprotect.c
index c59e7561698c..7db20085667a 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -611,6 +611,7 @@ static const struct mm_walk_ops prot_none_walk_ops = {
 	.pte_entry		= prot_none_pte_entry,
 	.hugetlb_entry		= prot_none_hugetlb_entry,
 	.test_walk		= prot_none_test,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 int
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index cb23f8a15c13..cb7791d01326 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -384,6 +384,33 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 	return err;
 }
 
+static inline void process_mm_walk_lock(struct mm_struct *mm,
+					enum page_walk_lock walk_lock)
+{
+	if (walk_lock == PGWALK_RDLOCK)
+		mmap_assert_locked(mm);
+	else
+		mmap_assert_write_locked(mm);
+}
+
+static inline void process_vma_walk_lock(struct vm_area_struct *vma,
+					 enum page_walk_lock walk_lock)
+{
+#ifdef CONFIG_PER_VMA_LOCK
+	switch (walk_lock) {
+	case PGWALK_WRLOCK:
+		vma_start_write(vma);
+		break;
+	case PGWALK_WRLOCK_VERIFY:
+		vma_assert_write_locked(vma);
+		break;
+	case PGWALK_RDLOCK:
+		/* PGWALK_RDLOCK is handled by process_mm_walk_lock */
+		break;
+	}
+#endif
+}
+
 /**
  * walk_page_range - walk page table with caller specific callbacks
  * @mm:		mm_struct representing the target process of page table walk
@@ -443,7 +470,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	if (!walk.mm)
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	process_mm_walk_lock(walk.mm, ops->walk_lock);
 
 	vma = find_vma(walk.mm, start);
 	do {
@@ -458,6 +485,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 			if (ops->pte_hole)
 				err = ops->pte_hole(start, next, -1, &walk);
 		} else { /* inside vma */
+			process_vma_walk_lock(vma, ops->walk_lock);
 			walk.vma = vma;
 			next = min(end, vma->vm_end);
 			vma = find_vma(mm, vma->vm_end);
@@ -533,7 +561,8 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 	if (start < vma->vm_start || end > vma->vm_end)
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	process_mm_walk_lock(walk.mm, ops->walk_lock);
+	process_vma_walk_lock(vma, ops->walk_lock);
 	return __walk_page_range(start, end, &walk);
 }
 
@@ -550,7 +579,8 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 	if (!walk.mm)
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	process_mm_walk_lock(walk.mm, ops->walk_lock);
+	process_vma_walk_lock(vma, ops->walk_lock);
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 74abb97ea557..fe208a072e59 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -806,14 +806,16 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
 	unsigned long swapped = 0;
+	unsigned long max = end - 1;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, end - 1) {
+	xas_for_each(&xas, page, max) {
 		if (xas_retry(&xas, page))
 			continue;
 		if (xa_is_value(page))
 			swapped++;
-
+		if (xas.xa_index == max)
+			break;
 		if (need_resched()) {
 			xas_pause(&xas);
 			cond_resched_rcu();
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1d13d71687d7..73a0077ee3af 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2929,6 +2929,10 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 		free_vm_area(area);
 		return NULL;
 	}
+
+	flush_cache_vmap((unsigned long)area->addr,
+			 (unsigned long)area->addr + count * PAGE_SIZE);
+
 	return area->addr;
 }
 EXPORT_SYMBOL_GPL(vmap_pfn);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6114a1fc6c68..7ff3389c677f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4249,6 +4249,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 	static const struct mm_walk_ops mm_walk_ops = {
 		.test_walk = should_skip_vma,
 		.p4d_entry = walk_pud_range,
+		.walk_lock = PGWALK_RDLOCK,
 	};
 
 	int err;
@@ -4817,16 +4818,17 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 
 		spin_lock_irq(&pgdat->memcg_lru.lock);
 
-		VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
+		if (hlist_nulls_unhashed(&lruvec->lrugen.list))
+			goto unlock;
 
 		gen = lruvec->lrugen.gen;
 
-		hlist_nulls_del_rcu(&lruvec->lrugen.list);
+		hlist_nulls_del_init_rcu(&lruvec->lrugen.list);
 		pgdat->memcg_lru.nr_memcgs[gen]--;
 
 		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
 			WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
-
+unlock:
 		spin_unlock_irq(&pgdat->memcg_lru.lock);
 	}
 }
@@ -5397,8 +5399,10 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 	rcu_read_lock();
 
 	hlist_nulls_for_each_entry_rcu(lrugen, pos, &pgdat->memcg_lru.fifo[gen][bin], list) {
-		if (op)
+		if (op) {
 			lru_gen_rotate_memcg(lruvec, op);
+			op = 0;
+		}
 
 		mem_cgroup_put(memcg);
 
@@ -5406,7 +5410,7 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 		memcg = lruvec_memcg(lruvec);
 
 		if (!mem_cgroup_tryget(memcg)) {
-			op = 0;
+			lru_gen_release_memcg(memcg);
 			memcg = NULL;
 			continue;
 		}
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index acff565849ae..1d704574e6bf 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -505,7 +505,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_elp_packet *elp_packet;
 	struct batadv_hard_iface *primary_if;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *ethhdr;
 	bool res;
 	int ret = NET_RX_DROP;
 
@@ -513,6 +513,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	if (!res)
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e710e9afe78f..e503ee0d896b 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -123,8 +123,10 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
+		kfree_skb(skb);
 		return;
+	}
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
@@ -985,7 +987,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_ogm2_packet *ogm_packet;
-	struct ethhdr *ethhdr = eth_hdr(skb);
+	struct ethhdr *ethhdr;
 	int ogm_offset;
 	u8 *packet_pos;
 	int ret = NET_RX_DROP;
@@ -999,6 +1001,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	if (!batadv_check_management_packet(skb, if_incoming, BATADV_OGM2_HLEN))
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 41c1ad33d009..24c9c0c3f316 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -630,7 +630,19 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	soft_iface->mtu = batadv_hardif_min_mtu(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	int limit_mtu;
+	int mtu;
+
+	mtu = batadv_hardif_min_mtu(soft_iface);
+
+	if (bat_priv->mtu_set_by_user)
+		limit_mtu = bat_priv->mtu_set_by_user;
+	else
+		limit_mtu = ETH_DATA_LEN;
+
+	mtu = min(mtu, limit_mtu);
+	dev_set_mtu(soft_iface, mtu);
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index ad5714f737be..6efbc9275aec 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -495,7 +495,10 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED];
 
 		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
+
+		rtnl_lock();
 		batadv_update_min_mtu(bat_priv->soft_iface);
+		rtnl_unlock();
 	}
 
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d3fdf82282af..85d00dc9ce32 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -153,11 +153,14 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 
 static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+
 	/* check ranges */
 	if (new_mtu < 68 || new_mtu > batadv_hardif_min_mtu(dev))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
+	bat_priv->mtu_set_by_user = new_mtu;
 
 	return 0;
 }
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 36ca31252a73..b95c36765d04 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -774,7 +774,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 		if (roamed_back) {
 			batadv_tt_global_free(bat_priv, tt_global,
 					      "Roaming canceled");
-			tt_global = NULL;
 		} else {
 			/* The global entry has to be marked as ROAMING and
 			 * has to be kept for consistency purpose
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index ca9449ec9836..cf1a0eafe3ab 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1546,6 +1546,12 @@ struct batadv_priv {
 	/** @soft_iface: net device which holds this struct as private data */
 	struct net_device *soft_iface;
 
+	/**
+	 * @mtu_set_by_user: MTU was set once by user
+	 * protected by rtnl_lock
+	 */
+	int mtu_set_by_user;
+
 	/**
 	 * @bat_counters: mesh internal traffic statistic counters (see
 	 *  batadv_counters)
diff --git a/net/can/isotp.c b/net/can/isotp.c
index ca9d728d6d72..9d498a886a58 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -188,12 +188,6 @@ static bool isotp_register_rxid(struct isotp_sock *so)
 	return (isotp_bc_flags(so) == 0);
 }
 
-static bool isotp_register_txecho(struct isotp_sock *so)
-{
-	/* all modes but SF_BROADCAST register for tx echo skbs */
-	return (isotp_bc_flags(so) != CAN_ISOTP_SF_BROADCAST);
-}
-
 static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
@@ -1209,7 +1203,7 @@ static int isotp_release(struct socket *sock)
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-	if (so->bound && isotp_register_txecho(so)) {
+	if (so->bound) {
 		if (so->ifindex) {
 			struct net_device *dev;
 
@@ -1332,14 +1326,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
-	if (isotp_register_txecho(so)) {
-		/* no consecutive frame echo skb in flight */
-		so->cfecho = 0;
+	/* no consecutive frame echo skb in flight */
+	so->cfecho = 0;
 
-		/* register for echo skb's */
-		can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-				isotp_rcv_echo, sk, "isotpe", sk);
-	}
+	/* register for echo skb's */
+	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			isotp_rcv_echo, sk, "isotpe", sk);
 
 	dev_put(dev);
 
@@ -1560,7 +1552,7 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (so->bound && isotp_register_txecho(so)) {
+		if (so->bound) {
 			if (isotp_register_rxid(so))
 				can_rx_unregister(dev_net(dev), dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
diff --git a/net/can/raw.c b/net/can/raw.c
index f8e3866157a3..174d16be0a95 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -84,6 +84,8 @@ struct raw_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
@@ -277,21 +279,24 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (ro->ifindex != dev->ifindex)
+	if (ro->dev != dev)
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (ro->bound)
+		if (ro->bound) {
 			raw_disable_allfilters(dev_net(dev), dev, sk);
+			netdev_put(dev, &ro->dev_tracker);
+		}
 
 		if (ro->count > 1)
 			kfree(ro->filter);
 
 		ro->ifindex = 0;
 		ro->bound = 0;
+		ro->dev = NULL;
 		ro->count = 0;
 		release_sock(sk);
 
@@ -337,6 +342,7 @@ static int raw_init(struct sock *sk)
 
 	ro->bound            = 0;
 	ro->ifindex          = 0;
+	ro->dev              = NULL;
 
 	/* set default filter to single entry dfilter */
 	ro->dfilter.can_id   = 0;
@@ -383,18 +389,14 @@ static int raw_release(struct socket *sock)
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
+	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
 	if (ro->bound) {
-		if (ro->ifindex) {
-			struct net_device *dev;
-
-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
-			if (dev) {
-				raw_disable_allfilters(dev_net(dev), dev, sk);
-				dev_put(dev);
-			}
+		if (ro->dev) {
+			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
+			netdev_put(ro->dev, &ro->dev_tracker);
 		} else {
 			raw_disable_allfilters(sock_net(sk), NULL, sk);
 		}
@@ -405,6 +407,7 @@ static int raw_release(struct socket *sock)
 
 	ro->ifindex = 0;
 	ro->bound = 0;
+	ro->dev = NULL;
 	ro->count = 0;
 	free_percpu(ro->uniq);
 
@@ -412,6 +415,8 @@ static int raw_release(struct socket *sock)
 	sock->sk = NULL;
 
 	release_sock(sk);
+	rtnl_unlock();
+
 	sock_put(sk);
 
 	return 0;
@@ -422,6 +427,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	struct net_device *dev = NULL;
 	int ifindex;
 	int err = 0;
 	int notify_enetdown = 0;
@@ -431,24 +437,23 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
+	rtnl_lock();
 	lock_sock(sk);
 
 	if (ro->bound && addr->can_ifindex == ro->ifindex)
 		goto out;
 
 	if (addr->can_ifindex) {
-		struct net_device *dev;
-
 		dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
 		if (!dev) {
 			err = -ENODEV;
 			goto out;
 		}
 		if (dev->type != ARPHRD_CAN) {
-			dev_put(dev);
 			err = -ENODEV;
-			goto out;
+			goto out_put_dev;
 		}
+
 		if (!(dev->flags & IFF_UP))
 			notify_enetdown = 1;
 
@@ -456,7 +461,9 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), dev, sk);
-		dev_put(dev);
+		if (err)
+			goto out_put_dev;
+
 	} else {
 		ifindex = 0;
 
@@ -467,26 +474,30 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!err) {
 		if (ro->bound) {
 			/* unregister old filters */
-			if (ro->ifindex) {
-				struct net_device *dev;
-
-				dev = dev_get_by_index(sock_net(sk),
-						       ro->ifindex);
-				if (dev) {
-					raw_disable_allfilters(dev_net(dev),
-							       dev, sk);
-					dev_put(dev);
-				}
+			if (ro->dev) {
+				raw_disable_allfilters(dev_net(ro->dev),
+						       ro->dev, sk);
+				/* drop reference to old ro->dev */
+				netdev_put(ro->dev, &ro->dev_tracker);
 			} else {
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
 			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
+		/* bind() ok -> hold a reference for new ro->dev */
+		ro->dev = dev;
+		if (ro->dev)
+			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
 	}
 
- out:
+out_put_dev:
+	/* remove potential reference from dev_get_by_index() */
+	if (dev)
+		dev_put(dev);
+out:
 	release_sock(sk);
+	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
@@ -553,9 +564,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		rtnl_lock();
 		lock_sock(sk);
 
-		if (ro->bound && ro->ifindex) {
-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
-			if (!dev) {
+		dev = ro->dev;
+		if (ro->bound && dev) {
+			if (dev->reg_state != NETREG_REGISTERED) {
 				if (count > 1)
 					kfree(filter);
 				err = -ENODEV;
@@ -596,7 +607,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->count  = count;
 
  out_fil:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
@@ -614,9 +624,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		rtnl_lock();
 		lock_sock(sk);
 
-		if (ro->bound && ro->ifindex) {
-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
-			if (!dev) {
+		dev = ro->dev;
+		if (ro->bound && dev) {
+			if (dev->reg_state != NETREG_REGISTERED) {
 				err = -ENODEV;
 				goto out_err;
 			}
@@ -640,7 +650,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->err_mask = err_mask;
 
  out_err:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index aa1743b2b770..fd6d2430d40f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2268,13 +2268,27 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
-int rtnl_nla_parse_ifla(struct nlattr **tb, const struct nlattr *head, int len,
-			struct netlink_ext_ack *exterr)
+int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
+			     struct netlink_ext_ack *exterr)
 {
-	return nla_parse_deprecated(tb, IFLA_MAX, head, len, ifla_policy,
+	const struct ifinfomsg *ifmp;
+	const struct nlattr *attrs;
+	size_t len;
+
+	ifmp = nla_data(nla_peer);
+	attrs = nla_data(nla_peer) + sizeof(struct ifinfomsg);
+	len = nla_len(nla_peer) - sizeof(struct ifinfomsg);
+
+	if (ifmp->ifi_index < 0) {
+		NL_SET_ERR_MSG_ATTR(exterr, nla_peer,
+				    "ifindex can't be negative");
+		return -EINVAL;
+	}
+
+	return nla_parse_deprecated(tb, IFLA_MAX, attrs, len, ifla_policy,
 				    exterr);
 }
-EXPORT_SYMBOL(rtnl_nla_parse_ifla);
+EXPORT_SYMBOL(rtnl_nla_parse_ifinfomsg);
 
 struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
 {
@@ -3546,6 +3560,9 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
 		dev = __dev_get_by_index(net, ifm->ifi_index);
+	} else if (ifm->ifi_index < 0) {
+		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
+		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
 		dev = rtnl_dev_get(net, tb);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 3ab68415d121..e7b9703bd1a1 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -130,7 +130,7 @@ int dccp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 						    inet->inet_daddr,
 						    inet->inet_sport,
 						    inet->inet_dport);
-	inet->inet_id = get_random_u16();
+	atomic_set(&inet->inet_id, get_random_u16());
 
 	err = dccp_connect(sk);
 	rt = NULL;
@@ -432,7 +432,7 @@ struct sock *dccp_v4_request_recv_sock(const struct sock *sk,
 	RCU_INIT_POINTER(newinet->inet_opt, rcu_dereference(ireq->ireq_opt));
 	newinet->mc_index  = inet_iif(skb);
 	newinet->mc_ttl	   = ip_hdr(skb)->ttl;
-	newinet->inet_id   = get_random_u16();
+	atomic_set(&newinet->inet_id, get_random_u16());
 
 	if (dst == NULL && (dst = inet_csk_route_child_sock(sk, newsk, req)) == NULL)
 		goto put_and_exit;
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 18873f2308ec..f3494cb5fab0 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -315,11 +315,15 @@ EXPORT_SYMBOL_GPL(dccp_disconnect);
 __poll_t dccp_poll(struct file *file, struct socket *sock,
 		       poll_table *wait)
 {
-	__poll_t mask;
 	struct sock *sk = sock->sk;
+	__poll_t mask;
+	u8 shutdown;
+	int state;
 
 	sock_poll_wait(file, sock, wait);
-	if (sk->sk_state == DCCP_LISTEN)
+
+	state = inet_sk_state_load(sk);
+	if (state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
 	/* Socket is not locked. We are protected from async events
@@ -328,20 +332,21 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	 */
 
 	mask = 0;
-	if (sk->sk_err)
+	if (READ_ONCE(sk->sk_err))
 		mask = EPOLLERR;
+	shutdown = READ_ONCE(sk->sk_shutdown);
 
-	if (sk->sk_shutdown == SHUTDOWN_MASK || sk->sk_state == DCCP_CLOSED)
+	if (shutdown == SHUTDOWN_MASK || state == DCCP_CLOSED)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* Connected? */
-	if ((1 << sk->sk_state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
+	if ((1 << state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
 		if (atomic_read(&sk->sk_rmem_alloc) > 0)
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
 			if (sk_stream_is_writeable(sk)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
@@ -359,7 +364,6 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	}
 	return mask;
 }
-
 EXPORT_SYMBOL_GPL(dccp_poll);
 
 int dccp_ioctl(struct sock *sk, int cmd, unsigned long arg)
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 790e61b2a940..6ef6090eeffe 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6739,6 +6739,7 @@ void devlink_notify_unregister(struct devlink *devlink)
 	struct devlink_param_item *param_item;
 	struct devlink_trap_item *trap_item;
 	struct devlink_port *devlink_port;
+	struct devlink_linecard *linecard;
 	struct devlink_rate *rate_node;
 	struct devlink_region *region;
 	unsigned long port_index;
@@ -6767,6 +6768,8 @@ void devlink_notify_unregister(struct devlink *devlink)
 
 	xa_for_each(&devlink->ports, port_index, devlink_port)
 		devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
+	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
 	devlink_notify(devlink, DEVLINK_CMD_DEL);
 }
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 10ebe39dcc87..9dde8e842bef 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -340,7 +340,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	else
 		inet->pmtudisc = IP_PMTUDISC_WANT;
 
-	inet->inet_id = 0;
+	atomic_set(&inet->inet_id, 0);
 
 	sock_init_data(sock, sk);
 
diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index 4d1af0cd7d99..cb5dbee9e018 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -73,7 +73,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 	reuseport_has_conns_set(sk);
 	sk->sk_state = TCP_ESTABLISHED;
 	sk_set_txhash(sk);
-	inet->inet_id = get_random_u16();
+	atomic_set(&inet->inet_id, get_random_u16());
 
 	sk_dst_set(sk, &rt->dst);
 	err = 0;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 498dd4acdeec..caecb4d1e424 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -312,7 +312,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 					     inet->inet_daddr));
 	}
 
-	inet->inet_id = get_random_u16();
+	atomic_set(&inet->inet_id, get_random_u16());
 
 	if (tcp_fastopen_defer_connect(sk, &err))
 		return err;
@@ -1596,7 +1596,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	inet_csk(newsk)->icsk_ext_hdr_len = 0;
 	if (inet_opt)
 		inet_csk(newsk)->icsk_ext_hdr_len = inet_opt->opt.optlen;
-	newinet->inet_id = get_random_u16();
+	atomic_set(&newinet->inet_id, get_random_u16());
 
 	/* Set ToS of the new socket based upon the value of incoming SYN.
 	 * ECT bits are set later in tcp_init_transfer().
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index fc6e130364da..3f316e52cbe4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1083,7 +1083,8 @@ static inline bool ieee80211_rx_reorder_ready(struct tid_ampdu_rx *tid_agg_rx,
 	struct sk_buff *tail = skb_peek_tail(frames);
 	struct ieee80211_rx_status *status;
 
-	if (tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
+	if (tid_agg_rx->reorder_buf_filtered &&
+	    tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
 		return true;
 
 	if (!tail)
@@ -1124,7 +1125,8 @@ static void ieee80211_release_reorder_frame(struct ieee80211_sub_if_data *sdata,
 	}
 
 no_frame:
-	tid_agg_rx->reorder_buf_filtered &= ~BIT_ULL(index);
+	if (tid_agg_rx->reorder_buf_filtered)
+		tid_agg_rx->reorder_buf_filtered &= ~BIT_ULL(index);
 	tid_agg_rx->head_seq_num = ieee80211_sn_inc(tid_agg_rx->head_seq_num);
 }
 
@@ -4245,6 +4247,7 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 					  u16 ssn, u64 filtered,
 					  u16 received_mpdus)
 {
+	struct ieee80211_local *local;
 	struct sta_info *sta;
 	struct tid_ampdu_rx *tid_agg_rx;
 	struct sk_buff_head frames;
@@ -4262,6 +4265,11 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 
 	sta = container_of(pubsta, struct sta_info, sta);
 
+	local = sta->sdata->local;
+	WARN_ONCE(local->hw.max_rx_aggregation_subframes > 64,
+		  "RX BA marker can't support max_rx_aggregation_subframes %u > 64\n",
+		  local->hw.max_rx_aggregation_subframes);
+
 	if (!ieee80211_rx_data_set_sta(&rx, sta, -1))
 		return;
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b280b151a9e9..ad38f84a8f11 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1372,7 +1372,7 @@ static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
 	if (table == NULL)
 		goto err_kzalloc;
 
-	table->validate_state = NFT_VALIDATE_SKIP;
+	table->validate_state = nft_net->validate_state;
 	table->name = nla_strdup(attr, GFP_KERNEL_ACCOUNT);
 	if (table->name == NULL)
 		goto err_strdup;
@@ -9065,9 +9065,8 @@ static int nf_tables_validate(struct net *net)
 				return -EAGAIN;
 
 			nft_validate_state_update(table, NFT_VALIDATE_SKIP);
+			break;
 		}
-
-		break;
 	}
 
 	return 0;
@@ -9471,9 +9470,9 @@ static void nft_trans_gc_work(struct work_struct *work)
 	struct nft_trans_gc *trans, *next;
 	LIST_HEAD(trans_gc_list);
 
-	spin_lock(&nf_tables_destroy_list_lock);
+	spin_lock(&nf_tables_gc_list_lock);
 	list_splice_init(&nf_tables_gc_list, &trans_gc_list);
-	spin_unlock(&nf_tables_destroy_list_lock);
+	spin_unlock(&nf_tables_gc_list_lock);
 
 	list_for_each_entry_safe(trans, next, &trans_gc_list, list) {
 		list_del(&trans->list);
@@ -9813,8 +9812,10 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	}
 
 	/* 0. Validate ruleset, otherwise roll back for error reporting. */
-	if (nf_tables_validate(net) < 0)
+	if (nf_tables_validate(net) < 0) {
+		nft_net->validate_state = NFT_VALIDATE_DO;
 		return -EAGAIN;
+	}
 
 	err = nft_flow_rule_offload_commit(net);
 	if (err < 0)
@@ -10070,6 +10071,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
 
 	nft_gc_seq_end(nft_net, gc_seq);
+	nft_net->validate_state = NFT_VALIDATE_SKIP;
 	nf_tables_commit_release(net);
 
 	return 0;
@@ -10346,8 +10348,12 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
-	int ret = __nf_tables_abort(net, action);
+	unsigned int gc_seq;
+	int ret;
 
+	gc_seq = nft_gc_seq_begin(nft_net);
+	ret = __nf_tables_abort(net, action);
+	nft_gc_seq_end(nft_net, gc_seq);
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
@@ -11082,7 +11088,7 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 	gc_seq = nft_gc_seq_begin(nft_net);
 
 	if (!list_empty(&nf_tables_destroy_list))
-		rcu_barrier();
+		nf_tables_trans_destroy_flush_work();
 again:
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (nft_table_has_owner(table) &&
@@ -11126,6 +11132,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	mutex_init(&nft_net->commit_mutex);
 	nft_net->base_seq = 1;
 	nft_net->gc_seq = 0;
+	nft_net->validate_state = NFT_VALIDATE_SKIP;
 
 	return 0;
 }
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index cef5df846000..524763659f25 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -326,6 +326,9 @@ static void nft_rhash_gc(struct work_struct *work)
 	nft_net = nft_pernet(net);
 	gc_seq = READ_ONCE(nft_net->gc_seq);
 
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
 	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
 	if (!gc)
 		goto done;
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 352180b123fc..a9da4683b8c5 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -902,12 +902,14 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 static int pipapo_insert(struct nft_pipapo_field *f, const uint8_t *k,
 			 int mask_bits)
 {
-	int rule = f->rules++, group, ret, bit_offset = 0;
+	int rule = f->rules, group, ret, bit_offset = 0;
 
-	ret = pipapo_resize(f, f->rules - 1, f->rules);
+	ret = pipapo_resize(f, f->rules, f->rules + 1);
 	if (ret)
 		return ret;
 
+	f->rules++;
+
 	for (group = 0; group < f->groups; group++) {
 		int i, v;
 		u8 mask;
@@ -1052,7 +1054,9 @@ static int pipapo_expand(struct nft_pipapo_field *f,
 			step++;
 			if (step >= len) {
 				if (!masks) {
-					pipapo_insert(f, base, 0);
+					err = pipapo_insert(f, base, 0);
+					if (err < 0)
+						return err;
 					masks = 1;
 				}
 				goto out;
@@ -1235,6 +1239,9 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		else
 			ret = pipapo_expand(f, start, end, f->groups * f->bb);
 
+		if (ret < 0)
+			return ret;
+
 		if (f->bsize > bsize_max)
 			bsize_max = f->bsize;
 
@@ -1543,7 +1550,7 @@ static void nft_pipapo_gc_deactivate(struct net *net, struct nft_set *set,
 
 /**
  * pipapo_gc() - Drop expired entries from set, destroy start and end elements
- * @set:	nftables API set representation
+ * @_set:	nftables API set representation
  * @m:		Matching data
  */
 static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index f9d4c8fcbbf8..c6435e709231 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -611,6 +611,9 @@ static void nft_rbtree_gc(struct work_struct *work)
 	nft_net = nft_pernet(net);
 	gc_seq  = READ_ONCE(nft_net->gc_seq);
 
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
 	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
 	if (!gc)
 		goto done;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index aa6b1fe65151..e9eaf637220e 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1547,10 +1547,28 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+static bool req_create_or_replace(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_REPLACE);
+}
+
+static bool req_create_exclusive(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_EXCL);
+}
+
+static bool req_change(struct nlmsghdr *n)
+{
+	return (!(n->nlmsg_flags & NLM_F_CREATE) &&
+		!(n->nlmsg_flags & NLM_F_REPLACE) &&
+		!(n->nlmsg_flags & NLM_F_EXCL));
+}
+
 /*
  * Create/change qdisc.
  */
-
 static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			   struct netlink_ext_ack *extack)
 {
@@ -1644,27 +1662,35 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				 *
 				 *   We know, that some child q is already
 				 *   attached to this parent and have choice:
-				 *   either to change it or to create/graft new one.
+				 *   1) change it or 2) create/graft new one.
+				 *   If the requested qdisc kind is different
+				 *   than the existing one, then we choose graft.
+				 *   If they are the same then this is "change"
+				 *   operation - just let it fallthrough..
 				 *
 				 *   1. We are allowed to create/graft only
-				 *   if CREATE and REPLACE flags are set.
+				 *   if the request is explicitly stating
+				 *   "please create if it doesn't exist".
 				 *
-				 *   2. If EXCL is set, requestor wanted to say,
-				 *   that qdisc tcm_handle is not expected
+				 *   2. If the request is to exclusive create
+				 *   then the qdisc tcm_handle is not expected
 				 *   to exist, so that we choose create/graft too.
 				 *
 				 *   3. The last case is when no flags are set.
+				 *   This will happen when for example tc
+				 *   utility issues a "change" command.
 				 *   Alas, it is sort of hole in API, we
 				 *   cannot decide what to do unambiguously.
-				 *   For now we select create/graft, if
-				 *   user gave KIND, which does not match existing.
+				 *   For now we select create/graft.
 				 */
-				if ((n->nlmsg_flags & NLM_F_CREATE) &&
-				    (n->nlmsg_flags & NLM_F_REPLACE) &&
-				    ((n->nlmsg_flags & NLM_F_EXCL) ||
-				     (tca[TCA_KIND] &&
-				      nla_strcmp(tca[TCA_KIND], q->ops->id))))
-					goto create_n_graft;
+				if (tca[TCA_KIND] &&
+				    nla_strcmp(tca[TCA_KIND], q->ops->id)) {
+					if (req_create_or_replace(n) ||
+					    req_create_exclusive(n))
+						goto create_n_graft;
+					else if (req_change(n))
+						goto create_n_graft2;
+				}
 			}
 		}
 	} else {
@@ -1698,6 +1724,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		NL_SET_ERR_MSG(extack, "Qdisc not found. To create specify NLM_F_CREATE flag");
 		return -ENOENT;
 	}
+create_n_graft2:
 	if (clid == TC_H_INGRESS) {
 		if (dev_ingress_queue(dev)) {
 			q = qdisc_create(dev, dev_ingress_queue(dev),
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ee15eff6364e..d77561d97a1e 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -99,7 +99,7 @@ struct percpu_counter sctp_sockets_allocated;
 
 static void sctp_enter_memory_pressure(struct sock *sk)
 {
-	sctp_memory_pressure = 1;
+	WRITE_ONCE(sctp_memory_pressure, 1);
 }
 
 
@@ -9479,7 +9479,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newinet->inet_rcv_saddr = inet->inet_rcv_saddr;
 	newinet->inet_dport = htons(asoc->peer.port);
 	newinet->pmtudisc = inet->pmtudisc;
-	newinet->inet_id = get_random_u16();
+	atomic_set(&newinet->inet_id, get_random_u16());
 
 	newinet->uc_ttl = inet->uc_ttl;
 	newinet->mc_loop = 1;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index b098fde373ab..28c0771c4e8c 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -935,9 +935,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	if (!rep->rr_rdmabuf)
 		goto out_free;
 
-	if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
-		goto out_free_regbuf;
-
 	rep->rr_cid.ci_completion_id =
 		atomic_inc_return(&r_xprt->rx_ep->re_completion_ids);
 
@@ -956,8 +953,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	spin_unlock(&buf->rb_lock);
 	return rep;
 
-out_free_regbuf:
-	rpcrdma_regbuf_free(rep->rr_rdmabuf);
 out_free:
 	kfree(rep);
 out:
@@ -1363,6 +1358,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 			rep = rpcrdma_rep_create(r_xprt, temp);
 		if (!rep)
 			break;
+		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
+			rpcrdma_rep_put(buf, rep);
+			break;
+		}
 
 		rep->rr_cid.ci_queue_id = ep->re_attr.recv_cq->res.id;
 		trace_xprtrdma_post_recv(rep);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index adcfb63b3550..6f9ff4643dcb 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2005,6 +2005,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 		if (!datum)
 			goto out;
 
+		datum->next = NULL;
 		*dst = datum;
 
 		/* ebitmap_read() will at least init the bitmap */
@@ -2017,7 +2018,6 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 			goto out;
 
 		datum->otype = le32_to_cpu(buf[0]);
-		datum->next = NULL;
 
 		dst = &datum->next;
 	}
diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index b033bd290940..48444dda44de 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -152,8 +152,8 @@ static inline int snd_ymfpci_create_gameport(struct snd_ymfpci *chip, int dev, i
 void snd_ymfpci_free_gameport(struct snd_ymfpci *chip) { }
 #endif /* SUPPORT_JOYSTICK */
 
-static int snd_card_ymfpci_probe(struct pci_dev *pci,
-				 const struct pci_device_id *pci_id)
+static int __snd_card_ymfpci_probe(struct pci_dev *pci,
+				   const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
@@ -348,6 +348,12 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
 	return 0;
 }
 
+static int snd_card_ymfpci_probe(struct pci_dev *pci,
+				 const struct pci_device_id *pci_id)
+{
+	return snd_card_free_on_error(&pci->dev, __snd_card_ymfpci_probe(pci, pci_id));
+}
+
 static struct pci_driver ymfpci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_ymfpci_ids,
diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index e724cb3c70b7..57d5e342a8eb 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -71,6 +71,7 @@ config SND_SOC_AMD_RENOIR_MACH
 config SND_SOC_AMD_ACP5x
 	tristate "AMD Audio Coprocessor-v5.x I2S support"
 	depends on X86 && PCI
+	select SND_AMD_ACP_CONFIG
 	help
 	 This option enables ACP v5.x support on AMD platform
 
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 246299a178f9..5310ba0734b1 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -217,7 +217,7 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
 		}
 	},
 	{
@@ -248,6 +248,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M3402RA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 6ac501f008ec..8a879b6f4829 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -168,7 +168,7 @@ static int cs35l41_get_fs_mon_config_index(int freq)
 static const DECLARE_TLV_DB_RANGE(dig_vol_tlv,
 		0, 0, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
 		1, 913, TLV_DB_MINMAX_ITEM(-10200, 1200));
-static DECLARE_TLV_DB_SCALE(amp_gain_tlv, 0, 1, 1);
+static DECLARE_TLV_DB_SCALE(amp_gain_tlv, 50, 100, 0);
 
 static const struct snd_kcontrol_new dre_ctrl =
 	SOC_DAPM_SINGLE("Switch", CS35L41_PWR_CTRL3, 20, 1, 0);
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index f3fee448d759..6a2b0797f3c7 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -5,7 +5,6 @@
 // Copyright (C) 2023 Cirrus Logic, Inc. and
 //                    Cirrus Logic International Semiconductor Ltd.
 
-#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -1327,26 +1326,22 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 	return 0;
 }
 
-static int cs35l56_acpi_get_name(struct cs35l56_private *cs35l56)
+static int cs35l56_get_firmware_uid(struct cs35l56_private *cs35l56)
 {
-	acpi_handle handle = ACPI_HANDLE(cs35l56->dev);
-	const char *sub;
+	struct device *dev = cs35l56->dev;
+	const char *prop;
+	int ret;
 
-	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
-	if (!handle)
+	ret = device_property_read_string(dev, "cirrus,firmware-uid", &prop);
+	/* If bad sw node property, return 0 and fallback to legacy firmware path */
+	if (ret < 0)
 		return 0;
 
-	sub = acpi_get_subsystem_id(handle);
-	if (IS_ERR(sub)) {
-		/* If bad ACPI, return 0 and fallback to legacy firmware path, otherwise fail */
-		if (PTR_ERR(sub) == -ENODATA)
-			return 0;
-		else
-			return PTR_ERR(sub);
-	}
+	cs35l56->dsp.system_name = devm_kstrdup(dev, prop, GFP_KERNEL);
+	if (cs35l56->dsp.system_name == NULL)
+		return -ENOMEM;
 
-	cs35l56->dsp.system_name = sub;
-	dev_dbg(cs35l56->dev, "Subsystem ID: %s\n", cs35l56->dsp.system_name);
+	dev_dbg(dev, "Firmware UID: %s\n", cs35l56->dsp.system_name);
 
 	return 0;
 }
@@ -1390,7 +1385,7 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 		gpiod_set_value_cansleep(cs35l56->reset_gpio, 1);
 	}
 
-	ret = cs35l56_acpi_get_name(cs35l56);
+	ret = cs35l56_get_firmware_uid(cs35l56);
 	if (ret != 0)
 		goto err;
 
@@ -1577,8 +1572,6 @@ void cs35l56_remove(struct cs35l56_private *cs35l56)
 
 	regcache_cache_only(cs35l56->regmap, true);
 
-	kfree(cs35l56->dsp.system_name);
-
 	gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
 }
diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 9e2b6c45080d..49eb98605518 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -708,6 +708,9 @@ static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
 	struct snd_sof_pcm *spcm;
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
+	if (!spcm)
+		return -EINVAL;
+
 	time_info = spcm->stream[substream->stream].private;
 	/* delay calculation is not supported by current fw_reg ABI */
 	if (!time_info)
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
index 47ab90596acb..6358df5752f9 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
@@ -57,8 +57,8 @@ ip link add name veth2-bond type veth peer name veth2-end
 
 # add ports
 ip link set fbond master fab-br0
-ip link set veth1-bond down master fbond
-ip link set veth2-bond down master fbond
+ip link set veth1-bond master fbond
+ip link set veth2-bond master fbond
 
 # bring up
 ip link set veth1-end up
diff --git a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
index 7d9e73a43a49..0c47faff9274 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
@@ -98,12 +98,12 @@ sb_occ_etc_check()
 
 port_pool_test()
 {
-	local exp_max_occ=288
+	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
-	$MZ $h1 -c 1 -p 160 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
+	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
 		-t ip -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
@@ -126,12 +126,12 @@ port_pool_test()
 
 port_tc_ip_test()
 {
-	local exp_max_occ=288
+	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
-	$MZ $h1 -c 1 -p 160 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
+	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
 		-t ip -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
@@ -154,16 +154,12 @@ port_tc_ip_test()
 
 port_tc_arp_test()
 {
-	local exp_max_occ=96
+	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
-	if [[ $MLXSW_CHIP != "mlxsw_spectrum" ]]; then
-		exp_max_occ=144
-	fi
-
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
-	$MZ $h1 -c 1 -p 160 -a $h1mac -A 192.0.1.1 -t arp -q
+	$MZ $h1 -c 1 -p 10 -a $h1mac -A 192.0.1.1 -t arp -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
 
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 4adaad1b822f..20294553a5dd 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -57,9 +57,14 @@ enum {
 
 #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
 /* Just the flags we need, copied from mm.h: */
+
+#ifndef FOLL_WRITE
 #define FOLL_WRITE	0x01	/* check pte is writable */
-#define FOLL_LONGTERM   0x10000 /* mapping lifetime is indefinite */
+#endif
 
+#ifndef FOLL_LONGTERM
+#define FOLL_LONGTERM   0x100 /* mapping lifetime is indefinite */
+#endif
 FIXTURE(hmm)
 {
 	int		fd;
