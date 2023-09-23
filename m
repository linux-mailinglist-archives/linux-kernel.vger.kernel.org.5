Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8B7ABF3B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjIWJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjIWJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:23:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6941AB;
        Sat, 23 Sep 2023 02:23:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6952BC433CA;
        Sat, 23 Sep 2023 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695460982;
        bh=ieDYYy7SSsyDZB+GKBAnY98lN+ZVJA0Ai8LI2jJ9Zj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNwclNntFi25HOJfRPZrmV5nZd6LcXxY5Quu1CJRE/tZPkV+99k+AVTfVRSpMOHCd
         13/DggSzGPEe2OcEyYxcNCCRKunXsKpuxmTAYnV7m9e9W8+K/K8iPVGe7MyiBhoxxW
         Jk3wQw9wxev48adm2JXh+W770Fx5xa17qLAv1VK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.197
Date:   Sat, 23 Sep 2023 11:22:50 +0200
Message-ID: <2023092350-rejoicing-procurer-8f4a@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023092350-provolone-emblaze-3dee@gregkh>
References: <2023092350-provolone-emblaze-3dee@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 4f3206495217..10a26d44ef4a 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -149,6 +149,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| Hisilicon      | Hip08 SMMU PMCG | #162001900      | N/A                         |
+|                | Hip09 SMMU PMCG |                 |                             |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/Makefile b/Makefile
index 7021aa85afd1..12986f3532a9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 196
+SUBLEVEL = 197
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b1423fb130ea..8f1fa7aac31f 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &= ~alignment_mask;
 	hw->ctrl.len <<= offset;
 
-	if (is_default_overflow_handler(bp)) {
+	if (uses_default_overflow_handler(bp)) {
 		/*
 		 * Mismatch breakpoints are required for single-stepping
 		 * breakpoints.
@@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		 * Otherwise, insert a temporary mismatch breakpoint so that
 		 * we can single-step over the watchpoint trigger.
 		 */
-		if (!is_default_overflow_handler(wp))
+		if (!uses_default_overflow_handler(wp))
 			continue;
 step:
 		enable_single_step(wp, instruction_pointer(regs));
@@ -811,7 +811,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		info->trigger = addr;
 		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
 		perf_bp_event(wp, regs);
-		if (is_default_overflow_handler(wp))
+		if (uses_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
 	}
 
@@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 			info->trigger = addr;
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (is_default_overflow_handler(bp))
+			if (uses_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 712e97c03e54..e5a0c38f1b5e 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -654,7 +654,7 @@ static int breakpoint_handler(unsigned long unused, unsigned int esr,
 		perf_bp_event(bp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (is_default_overflow_handler(bp))
+		if (uses_default_overflow_handler(bp))
 			step = 1;
 unlock:
 		rcu_read_unlock();
@@ -733,7 +733,7 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 static int watchpoint_report(struct perf_event *wp, unsigned long addr,
 			     struct pt_regs *regs)
 {
-	int step = is_default_overflow_handler(wp);
+	int step = uses_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info = counter_arch_bp(wp);
 
 	info->trigger = addr;
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 8c6e509f6967..c3cc010e9cc4 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -451,6 +451,7 @@ static int __init ibmebus_bus_init(void)
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 		       __func__, err);
+		put_device(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 39b2eded7bc2..f4a2e6d373b2 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -67,6 +67,14 @@ static void *alloc_pgt_page(void *context)
 		return NULL;
 	}
 
+	/* Consumed more tables than expected? */
+	if (pages->pgt_buf_offset == BOOT_PGT_SIZE_WARN) {
+		debug_putstr("pgt_buf running low in " __FILE__ "\n");
+		debug_putstr("Need to raise BOOT_PGT_SIZE?\n");
+		debug_putaddr(pages->pgt_buf_offset);
+		debug_putaddr(pages->pgt_buf_size);
+	}
+
 	entry = pages->pgt_buf + pages->pgt_buf_offset;
 	pages->pgt_buf_offset += PAGE_SIZE;
 
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3..215d37f7dde8 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -40,23 +40,40 @@
 #ifdef CONFIG_X86_64
 # define BOOT_STACK_SIZE	0x4000
 
+/*
+ * Used by decompressor's startup_32() to allocate page tables for identity
+ * mapping of the 4G of RAM in 4-level paging mode:
+ * - 1 level4 table;
+ * - 1 level3 table;
+ * - 4 level2 table that maps everything with 2M pages;
+ *
+ * The additional level5 table needed for 5-level paging is allocated from
+ * trampoline_32bit memory.
+ */
 # define BOOT_INIT_PGT_SIZE	(6*4096)
-# ifdef CONFIG_RANDOMIZE_BASE
+
 /*
- * Assuming all cross the 512GB boundary:
- * 1 page for level4
- * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
- * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
- * Total is 19 pages.
+ * Total number of page tables kernel_add_identity_map() can allocate,
+ * including page tables consumed by startup_32().
+ *
+ * Worst-case scenario:
+ *  - 5-level paging needs 1 level5 table;
+ *  - KASLR needs to map kernel, boot_params, cmdline and randomized kernel,
+ *    assuming all of them cross 256T boundary:
+ *    + 4*2 level4 table;
+ *    + 4*2 level3 table;
+ *    + 4*2 level2 table;
+ *  - X86_VERBOSE_BOOTUP needs to map the first 2M (video RAM):
+ *    + 1 level4 table;
+ *    + 1 level3 table;
+ *    + 1 level2 table;
+ * Total: 28 tables
+ *
+ * Add 4 spare table in case decompressor touches anything beyond what is
+ * accounted above. Warn if it happens.
  */
-#  ifdef CONFIG_X86_VERBOSE_BOOTUP
-#   define BOOT_PGT_SIZE	(19*4096)
-#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
-#   define BOOT_PGT_SIZE	(17*4096)
-#  endif
-# else /* !CONFIG_RANDOMIZE_BASE */
-#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
-# endif
+# define BOOT_PGT_SIZE_WARN	(28*4096)
+# define BOOT_PGT_SIZE		(32*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
diff --git a/crypto/lrw.c b/crypto/lrw.c
index bcf09fbc750a..80d9076e42e0 100644
--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -357,10 +357,10 @@ static int lrw_create(struct crypto_template *tmpl, struct rtattr **tb)
 	 * cipher name.
 	 */
 	if (!strncmp(cipher_name, "ecb(", 4)) {
-		unsigned len;
+		int len;
 
-		len = strlcpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
-		if (len < 2 || len >= sizeof(ecb_name))
+		len = strscpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
+		if (len < 2)
 			goto err_free_inst;
 
 		if (ecb_name[len - 1] != ')')
diff --git a/crypto/xts.c b/crypto/xts.c
index c6a105dba38b..74dc199d5486 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -395,10 +395,10 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 	 * cipher name.
 	 */
 	if (!strncmp(cipher_name, "ecb(", 4)) {
-		unsigned len;
+		int len;
 
-		len = strlcpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
-		if (len < 2 || len >= sizeof(ctx->name))
+		len = strscpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
+		if (len < 2)
 			goto err_free_inst;
 
 		if (ctx->name[len - 1] != ')')
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 28af49263ebf..62957cba30f6 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -603,7 +603,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 
 /* 7E */ ACPI_OP("Timer", ARGP_TIMER_OP, ARGI_TIMER_OP, ACPI_TYPE_ANY,
 			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_0A_0T_1R,
-			 AML_FLAGS_EXEC_0A_0T_1R),
+			 AML_FLAGS_EXEC_0A_0T_1R | AML_NO_OPERAND_RESOLVE),
 
 /* ACPI 5.0 opcodes */
 
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 50ed949dc144..554943be2698 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1474,7 +1474,10 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 static struct acpi_platform_list pmcg_plat_info[] __initdata = {
 	/* HiSilicon Hip08 Platform */
 	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
-	 "Erratum #162001800", IORT_SMMU_V3_PMCG_HISI_HIP08},
+	 "Erratum #162001800, Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP08},
+	/* HiSilicon Hip09 Platform */
+	{"HISI  ", "HIP09   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
+	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
 	{ }
 };
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b02d381e7848..a5cb9e1d48bc 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -307,6 +307,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
 		},
 	},
+	{
+	 /* https://bugzilla.suse.com/show_bug.cgi?id=1208724 */
+	 .callback = video_detect_force_native,
+	 /* Lenovo Ideapad Z470 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Z470"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
 	 .callback = video_detect_force_native,
@@ -348,6 +357,24 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
 		},
 	},
+	{
+	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/1838 */
+	 .callback = video_detect_force_native,
+	 /* Apple iMac12,1 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,1"),
+		},
+	},
+	{
+	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/2753 */
+	 .callback = video_detect_force_native,
+	 /* Apple iMac12,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7ca9fa9a75e2..bf949f7da483 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1882,6 +1882,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	else
 		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
 
+	if (!(hpriv->cap & HOST_CAP_PART))
+		host->flags |= ATA_HOST_NO_PART;
+
+	if (!(hpriv->cap & HOST_CAP_SSC))
+		host->flags |= ATA_HOST_NO_SSC;
+
+	if (!(hpriv->cap2 & HOST_CAP2_SDS))
+		host->flags |= ATA_HOST_NO_DEVSLP;
+
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index c16423e44525..4fd9a107fe7f 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -394,10 +394,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	case ATA_LPM_MED_POWER_WITH_DIPM:
 	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
 	case ATA_LPM_MIN_POWER:
-		if (ata_link_nr_enabled(link) > 0)
-			/* no restrictions on LPM transitions */
+		if (ata_link_nr_enabled(link) > 0) {
+			/* assume no restrictions on LPM transitions */
 			scontrol &= ~(0x7 << 8);
-		else {
+
+			/*
+			 * If the controller does not support partial, slumber,
+			 * or devsleep, then disallow these transitions.
+			 */
+			if (link->ap->host->flags & ATA_HOST_NO_PART)
+				scontrol |= (0x1 << 8);
+
+			if (link->ap->host->flags & ATA_HOST_NO_SSC)
+				scontrol |= (0x2 << 8);
+
+			if (link->ap->host->flags & ATA_HOST_NO_DEVSLP)
+				scontrol |= (0x4 << 8);
+		} else {
 			/* empty port, power off */
 			scontrol &= ~0xf;
 			scontrol |= (0x1 << 2);
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index c8e0f8cb9aa3..5e8c078efd22 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1504,6 +1504,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d7c440ac465f..b3452259d6e0 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -469,10 +469,17 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	int rc;
 	u32 ordinal;
 	unsigned long dur;
-
-	rc = tpm_tis_send_data(chip, buf, len);
-	if (rc < 0)
-		return rc;
+	unsigned int try;
+
+	for (try = 0; try < TPM_RETRY; try++) {
+		rc = tpm_tis_send_data(chip, buf, len);
+		if (rc >= 0)
+			/* Data transfer done successfully */
+			break;
+		else if (rc != -EIO)
+			/* Data transfer failed, not recoverable */
+			return rc;
+	}
 
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e25c3387bcf8..7f2adac82e3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -45,7 +45,6 @@ static int amdgpu_cs_user_fence_chunk(struct amdgpu_cs_parser *p,
 	struct drm_gem_object *gobj;
 	struct amdgpu_bo *bo;
 	unsigned long size;
-	int r;
 
 	gobj = drm_gem_object_lookup(p->filp, data->handle);
 	if (gobj == NULL)
@@ -60,23 +59,14 @@ static int amdgpu_cs_user_fence_chunk(struct amdgpu_cs_parser *p,
 	drm_gem_object_put(gobj);
 
 	size = amdgpu_bo_size(bo);
-	if (size != PAGE_SIZE || (data->offset + 8) > size) {
-		r = -EINVAL;
-		goto error_unref;
-	}
+	if (size != PAGE_SIZE || data->offset > (size - 8))
+		return -EINVAL;
 
-	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
-		r = -EINVAL;
-		goto error_unref;
-	}
+	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
+		return -EINVAL;
 
 	*offset = data->offset;
-
 	return 0;
-
-error_unref:
-	amdgpu_bo_unref(&bo);
-	return r;
 }
 
 static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0bdc83d89946..652ddec18838 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6971,6 +6971,13 @@ static void handle_cursor_update(struct drm_plane *plane,
 	attributes.rotation_angle    = 0;
 	attributes.attribute_flags.value = 0;
 
+	/* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma in DRM
+	 * legacy gamma setup.
+	 */
+	if (crtc_state->cm_is_degamma_srgb &&
+	    adev->dm.dc->caps.color.dpp.gamma_corr)
+		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
+
 	attributes.pitch = attributes.width;
 
 	if (crtc_state->stream) {
diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 1bfdfc6affaf..21c57d343568 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -224,7 +224,7 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_LPM;
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO_HSE;
 
 	ret = tc358762_parse_dt(ctx);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
index 1c03485676ef..de9fadccf22e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
@@ -39,13 +39,12 @@ static void exynos_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (exynos_crtc->ops->atomic_disable)
 		exynos_crtc->ops->atomic_disable(exynos_crtc);
 
+	spin_lock_irq(&crtc->dev->event_lock);
 	if (crtc->state->event && !crtc->state->active) {
-		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
-		spin_unlock_irq(&crtc->dev->event_lock);
-
 		crtc->state->event = NULL;
 	}
+	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
 static int exynos_crtc_atomic_check(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 0f5d1e598d75..1656f3ee0b19 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -67,10 +67,10 @@ MODULE_PARM_DESC(eco_mode, "Turn on Eco mode (less bright, more silent)");
 #define READ_STATUS_SIZE		13
 #define MISC_VALUE_SIZE			4
 
-#define CMD_TIMEOUT			msecs_to_jiffies(200)
-#define DATA_TIMEOUT			msecs_to_jiffies(1000)
-#define IDLE_TIMEOUT			msecs_to_jiffies(2000)
-#define FIRST_FRAME_TIMEOUT		msecs_to_jiffies(2000)
+#define CMD_TIMEOUT			200
+#define DATA_TIMEOUT			1000
+#define IDLE_TIMEOUT			2000
+#define FIRST_FRAME_TIMEOUT		2000
 
 #define MISC_REQ_GET_SET_ECO_A		0xff
 #define MISC_REQ_GET_SET_ECO_B		0x35
@@ -399,7 +399,7 @@ static void gm12u320_fb_update_work(struct work_struct *work)
 	 * switches back to showing its logo.
 	 */
 	queue_delayed_work(system_long_wq, &gm12u320->fb_update.work,
-			   IDLE_TIMEOUT);
+			   msecs_to_jiffies(IDLE_TIMEOUT));
 
 	return;
 err:
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 724bf30600d6..dac46bc2fafc 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -693,13 +693,16 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 
 	if (time_left == 0) {
 		/*
-		 * If timed out and bus is still busy in a multi master
-		 * environment, attempt recovery at here.
+		 * In a multi-master setup, if a timeout occurs, attempt
+		 * recovery. But if the bus is idle, we still need to reset the
+		 * i2c controller to clear the remaining interrupts.
 		 */
 		if (bus->multi_master &&
 		    (readl(bus->base + ASPEED_I2C_CMD_REG) &
 		     ASPEED_I2CD_BUS_BUSY_STS))
 			aspeed_i2c_recover_bus(bus);
+		else
+			aspeed_i2c_reset(bus);
 
 		/*
 		 * If timed out and the state is still pending, drop the pending
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 6b5cc3f59fb3..3619db7e382a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1793,6 +1793,9 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	int number = rdev->raid_disk;
 	struct raid1_info *p = conf->mirrors + number;
 
+	if (unlikely(number >= conf->raid_disks))
+		goto abort;
+
 	if (rdev != p->rdev)
 		p = conf->mirrors + conf->raid_disks + number;
 
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index a380e0920a21..86e3bb590371 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -412,7 +412,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 				dev->height >> 1);
 		break;
 	default:
-		BUG();
+		return -EINVAL; /* should not happen */
 	}
 	dprintk(2, "[%p/%d] buffer_init - %dx%d %dbpp 0x%08x - dma=0x%08lx\n",
 		buf, buf->vb.vb2_buf.index,
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index d6838c8ebd7e..f8dca4790476 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -355,7 +355,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
 	void __iomem *const base = cio2->base;
 	u8 lanes, csi2bus = q->csi2.port;
 	u8 sensor_vc = SENSOR_VIR_CH_DFLT;
-	struct cio2_csi2_timing timing;
+	struct cio2_csi2_timing timing = { 0 };
 	int i, r;
 
 	fmt = cio2_find_format(NULL, &q->subdev_fmt.code);
diff --git a/drivers/media/tuners/qt1010.c b/drivers/media/tuners/qt1010.c
index 60931367b82c..48fc79cd4027 100644
--- a/drivers/media/tuners/qt1010.c
+++ b/drivers/media/tuners/qt1010.c
@@ -345,11 +345,12 @@ static int qt1010_init(struct dvb_frontend *fe)
 			else
 				valptr = &tmpval;
 
-			BUG_ON(i >= ARRAY_SIZE(i2c_data) - 1);
-
-			err = qt1010_init_meas1(priv, i2c_data[i+1].reg,
-						i2c_data[i].reg,
-						i2c_data[i].val, valptr);
+			if (i >= ARRAY_SIZE(i2c_data) - 1)
+				err = -EIO;
+			else
+				err = qt1010_init_meas1(priv, i2c_data[i + 1].reg,
+							i2c_data[i].reg,
+							i2c_data[i].val, valptr);
 			i++;
 			break;
 		}
diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index b1f69c11c839..8cbaab9a6084 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -269,6 +269,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	struct state *state = d_to_priv(d);
 	int ret;
+	u32 reg;
 
 	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
 		return -EAGAIN;
@@ -321,8 +322,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3 || msg[1].len < 1)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
-			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
+			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
 
 			if (msg[0].addr == state->af9033_i2c_addr[1])
@@ -380,17 +383,16 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
-			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
+			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
 
 			if (msg[0].addr == state->af9033_i2c_addr[1])
 				reg |= 0x100000;
 
-			ret = (msg[0].len >= 3) ? af9035_wr_regs(d, reg,
-							         &msg[0].buf[3],
-							         msg[0].len - 3)
-					        : -EOPNOTSUPP;
+			ret = af9035_wr_regs(d, reg, &msg[0].buf[3], msg[0].len - 3);
 		} else {
 			/* I2C write */
 			u8 buf[MAX_XFER_SIZE];
diff --git a/drivers/media/usb/dvb-usb-v2/anysee.c b/drivers/media/usb/dvb-usb-v2/anysee.c
index 89a1b204b90c..3dacf3914d75 100644
--- a/drivers/media/usb/dvb-usb-v2/anysee.c
+++ b/drivers/media/usb/dvb-usb-v2/anysee.c
@@ -202,7 +202,7 @@ static int anysee_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
-			if (msg[i].len > 2 || msg[i+1].len > 60) {
+			if (msg[i].len != 2 || msg[i + 1].len > 60) {
 				ret = -EOPNOTSUPP;
 				break;
 			}
diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 7524c90f5da6..6cbfe75791c2 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -788,6 +788,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C W addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_WR;
 			index = msgs[i].buf[0];
 			value = addr | (1 << 8);
@@ -802,6 +806,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C R addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_RD;
 			index = msgs[i].buf[0];
 			value = addr;
diff --git a/drivers/media/usb/dvb-usb-v2/gl861.c b/drivers/media/usb/dvb-usb-v2/gl861.c
index 0c434259c36f..c71e7b93476d 100644
--- a/drivers/media/usb/dvb-usb-v2/gl861.c
+++ b/drivers/media/usb/dvb-usb-v2/gl861.c
@@ -120,7 +120,7 @@ static int gl861_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	} else if (num == 2 && !(msg[0].flags & I2C_M_RD) &&
 		   (msg[1].flags & I2C_M_RD)) {
 		/* I2C write + read */
-		if (msg[0].len > 1 || msg[1].len > sizeof(ctx->buf)) {
+		if (msg[0].len != 1 || msg[1].len > sizeof(ctx->buf)) {
 			ret = -EOPNOTSUPP;
 			goto err;
 		}
diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
index b6a2436d16e9..9af54fcbed1d 100644
--- a/drivers/media/usb/dvb-usb/af9005.c
+++ b/drivers/media/usb/dvb-usb/af9005.c
@@ -422,6 +422,10 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		if (ret == 0)
 			ret = 2;
 	} else {
+		if (msg[0].len < 2) {
+			ret = -EOPNOTSUPP;
+			goto unlock;
+		}
 		/* write one or more registers */
 		reg = msg[0].buf[0];
 		addr = msg[0].addr;
@@ -431,6 +435,7 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = 1;
 	}
 
+unlock:
 	mutex_unlock(&d->i2c_mutex);
 	return ret;
 }
diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 3c4ac998d040..2290f132a82c 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -128,6 +128,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 
 	switch (num) {
 	case 2:
+		if (msg[0].len < 1) {
+			num = -EOPNOTSUPP;
+			break;
+		}
 		/* read stv0299 register */
 		value = msg[0].buf[0];/* register */
 		for (i = 0; i < msg[1].len; i++) {
@@ -139,6 +143,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	case 1:
 		switch (msg[0].addr) {
 		case 0x68:
+			if (msg[0].len < 2) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			/* write to stv0299 register */
 			buf6[0] = 0x2a;
 			buf6[1] = msg[0].buf[0];
@@ -148,6 +156,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			break;
 		case 0x60:
 			if (msg[0].flags == 0) {
+				if (msg[0].len < 4) {
+					num = -EOPNOTSUPP;
+					break;
+				}
 			/* write to tuner pll */
 				buf6[0] = 0x2c;
 				buf6[1] = 5;
@@ -159,6 +171,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				dw210x_op_rw(d->udev, 0xb2, 0, 0,
 						buf6, 7, DW210X_WRITE_MSG);
 			} else {
+				if (msg[0].len < 1) {
+					num = -EOPNOTSUPP;
+					break;
+				}
 			/* read from tuner */
 				dw210x_op_rw(d->udev, 0xb5, 0, 0,
 						buf6, 1, DW210X_READ_MSG);
@@ -166,12 +182,20 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			}
 			break;
 		case (DW2102_RC_QUERY):
+			if (msg[0].len < 2) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
 					buf6, 2, DW210X_READ_MSG);
 			msg[0].buf[0] = buf6[0];
 			msg[0].buf[1] = buf6[1];
 			break;
 		case (DW2102_VOLTAGE_CTRL):
+			if (msg[0].len < 1) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			buf6[0] = 0x30;
 			buf6[1] = msg[0].buf[0];
 			dw210x_op_rw(d->udev, 0xb2, 0, 0,
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 70f388f83485..b030f657e253 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -166,8 +166,8 @@
 #define ESDHC_FLAG_HS400		BIT(9)
 /*
  * The IP has errata ERR010450
- * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
- * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
+ * uSDHC: At 1.8V due to the I/O timing limit, for SDR mode, SD card
+ * clock can't exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
  */
 #define ESDHC_FLAG_ERR010450		BIT(10)
 /* The IP supports HS400ES mode */
@@ -873,7 +873,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+	if ((imx_data->socdata->flags & ESDHC_FLAG_ERR010450) &&
+	    (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))) {
 		unsigned int max_clock;
 
 		max_clock = imx_data->is_ddr ? 45000000 : 150000000;
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index e170c545fec5..11d706ff30dd 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/static_key.h>
 #include <linux/list.h>
 #include <linux/log2.h>
 
@@ -207,6 +208,8 @@ enum {
 
 struct brcmnand_host;
 
+static DEFINE_STATIC_KEY_FALSE(brcmnand_soc_has_ops_key);
+
 struct brcmnand_controller {
 	struct device		*dev;
 	struct nand_controller	controller;
@@ -265,6 +268,7 @@ struct brcmnand_controller {
 	const unsigned int	*page_sizes;
 	unsigned int		page_size_shift;
 	unsigned int		max_oob;
+	u32			ecc_level_shift;
 	u32			features;
 
 	/* for low-power standby/resume only */
@@ -589,15 +593,53 @@ enum {
 	INTFC_CTLR_READY		= BIT(31),
 };
 
+/***********************************************************************
+ * NAND ACC CONTROL bitfield
+ *
+ * Some bits have remained constant throughout hardware revision, while
+ * others have shifted around.
+ ***********************************************************************/
+
+/* Constant for all versions (where supported) */
+enum {
+	/* See BRCMNAND_HAS_CACHE_MODE */
+	ACC_CONTROL_CACHE_MODE				= BIT(22),
+
+	/* See BRCMNAND_HAS_PREFETCH */
+	ACC_CONTROL_PREFETCH				= BIT(23),
+
+	ACC_CONTROL_PAGE_HIT				= BIT(24),
+	ACC_CONTROL_WR_PREEMPT				= BIT(25),
+	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
+	ACC_CONTROL_RD_ERASED				= BIT(27),
+	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
+	ACC_CONTROL_WR_ECC				= BIT(30),
+	ACC_CONTROL_RD_ECC				= BIT(31),
+};
+
+#define	ACC_CONTROL_ECC_SHIFT			16
+/* Only for v7.2 */
+#define	ACC_CONTROL_ECC_EXT_SHIFT		13
+
+static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctrl)
+{
+	return static_branch_unlikely(&brcmnand_soc_has_ops_key);
+}
+
 static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)
 {
+	if (brcmnand_non_mmio_ops(ctrl))
+		return brcmnand_soc_read(ctrl->soc, offs);
 	return brcmnand_readl(ctrl->nand_base + offs);
 }
 
 static inline void nand_writereg(struct brcmnand_controller *ctrl, u32 offs,
 				 u32 val)
 {
-	brcmnand_writel(val, ctrl->nand_base + offs);
+	if (brcmnand_non_mmio_ops(ctrl))
+		brcmnand_soc_write(ctrl->soc, val, offs);
+	else
+		brcmnand_writel(val, ctrl->nand_base + offs);
 }
 
 static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
@@ -716,6 +758,12 @@ static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
 	else if (of_property_read_bool(ctrl->dev->of_node, "brcm,nand-has-wp"))
 		ctrl->features |= BRCMNAND_HAS_WP;
 
+	/* v7.2 has different ecc level shift in the acc register */
+	if (ctrl->nand_version == 0x0702)
+		ctrl->ecc_level_shift = ACC_CONTROL_ECC_EXT_SHIFT;
+	else
+		ctrl->ecc_level_shift = ACC_CONTROL_ECC_SHIFT;
+
 	return 0;
 }
 
@@ -763,13 +811,18 @@ static inline void brcmnand_rmw_reg(struct brcmnand_controller *ctrl,
 
 static inline u32 brcmnand_read_fc(struct brcmnand_controller *ctrl, int word)
 {
+	if (brcmnand_non_mmio_ops(ctrl))
+		return brcmnand_soc_read(ctrl->soc, BRCMNAND_NON_MMIO_FC_ADDR);
 	return __raw_readl(ctrl->nand_fc + word * 4);
 }
 
 static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
 				     int word, u32 val)
 {
-	__raw_writel(val, ctrl->nand_fc + word * 4);
+	if (brcmnand_non_mmio_ops(ctrl))
+		brcmnand_soc_write(ctrl->soc, val, BRCMNAND_NON_MMIO_FC_ADDR);
+	else
+		__raw_writel(val, ctrl->nand_fc + word * 4);
 }
 
 static inline void edu_writel(struct brcmnand_controller *ctrl,
@@ -899,30 +952,6 @@ static inline int brcmnand_cmd_shift(struct brcmnand_controller *ctrl)
 	return 0;
 }
 
-/***********************************************************************
- * NAND ACC CONTROL bitfield
- *
- * Some bits have remained constant throughout hardware revision, while
- * others have shifted around.
- ***********************************************************************/
-
-/* Constant for all versions (where supported) */
-enum {
-	/* See BRCMNAND_HAS_CACHE_MODE */
-	ACC_CONTROL_CACHE_MODE				= BIT(22),
-
-	/* See BRCMNAND_HAS_PREFETCH */
-	ACC_CONTROL_PREFETCH				= BIT(23),
-
-	ACC_CONTROL_PAGE_HIT				= BIT(24),
-	ACC_CONTROL_WR_PREEMPT				= BIT(25),
-	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
-	ACC_CONTROL_RD_ERASED				= BIT(27),
-	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
-	ACC_CONTROL_WR_ECC				= BIT(30),
-	ACC_CONTROL_RD_ECC				= BIT(31),
-};
-
 static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
 {
 	if (ctrl->nand_version == 0x0702)
@@ -935,18 +964,15 @@ static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
 		return GENMASK(4, 0);
 }
 
-#define NAND_ACC_CONTROL_ECC_SHIFT	16
-#define NAND_ACC_CONTROL_ECC_EXT_SHIFT	13
-
 static inline u32 brcmnand_ecc_level_mask(struct brcmnand_controller *ctrl)
 {
 	u32 mask = (ctrl->nand_version >= 0x0600) ? 0x1f : 0x0f;
 
-	mask <<= NAND_ACC_CONTROL_ECC_SHIFT;
+	mask <<= ACC_CONTROL_ECC_SHIFT;
 
 	/* v7.2 includes additional ECC levels */
-	if (ctrl->nand_version >= 0x0702)
-		mask |= 0x7 << NAND_ACC_CONTROL_ECC_EXT_SHIFT;
+	if (ctrl->nand_version == 0x0702)
+		mask |= 0x7 << ACC_CONTROL_ECC_EXT_SHIFT;
 
 	return mask;
 }
@@ -960,8 +986,8 @@ static void brcmnand_set_ecc_enabled(struct brcmnand_host *host, int en)
 
 	if (en) {
 		acc_control |= ecc_flags; /* enable RD/WR ECC */
-		acc_control |= host->hwcfg.ecc_level
-			       << NAND_ACC_CONTROL_ECC_SHIFT;
+		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
+		acc_control |= host->hwcfg.ecc_level << ctrl->ecc_level_shift;
 	} else {
 		acc_control &= ~ecc_flags; /* disable RD/WR ECC */
 		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
@@ -2515,7 +2541,7 @@ static int brcmnand_set_cfg(struct brcmnand_host *host,
 	tmp &= ~brcmnand_ecc_level_mask(ctrl);
 	tmp &= ~brcmnand_spare_area_mask(ctrl);
 	if (ctrl->nand_version >= 0x0302) {
-		tmp |= cfg->ecc_level << NAND_ACC_CONTROL_ECC_SHIFT;
+		tmp |= cfg->ecc_level << ctrl->ecc_level_shift;
 		tmp |= cfg->spare_area_size;
 	}
 	nand_writereg(ctrl, acc_control_offs, tmp);
@@ -2985,6 +3011,12 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	dev_set_drvdata(dev, ctrl);
 	ctrl->dev = dev;
 
+	/* Enable the static key if the soc provides I/O operations indicating
+	 * that a non-memory mapped IO access path must be used
+	 */
+	if (brcmnand_soc_has_ops(ctrl->soc))
+		static_branch_enable(&brcmnand_soc_has_ops_key);
+
 	init_completion(&ctrl->done);
 	init_completion(&ctrl->dma_done);
 	init_completion(&ctrl->edu_done);
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
index eb498fbe505e..f1f93d85f50d 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -11,12 +11,25 @@
 
 struct platform_device;
 struct dev_pm_ops;
+struct brcmnand_io_ops;
+
+/* Special register offset constant to intercept a non-MMIO access
+ * to the flash cache register space. This is intentionally large
+ * not to overlap with an existing offset.
+ */
+#define BRCMNAND_NON_MMIO_FC_ADDR	0xffffffff
 
 struct brcmnand_soc {
 	bool (*ctlrdy_ack)(struct brcmnand_soc *soc);
 	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
 	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
 				 bool is_param);
+	const struct brcmnand_io_ops *ops;
+};
+
+struct brcmnand_io_ops {
+	u32 (*read_reg)(struct brcmnand_soc *soc, u32 offset);
+	void (*write_reg)(struct brcmnand_soc *soc, u32 val, u32 offset);
 };
 
 static inline void brcmnand_soc_data_bus_prepare(struct brcmnand_soc *soc,
@@ -58,6 +71,22 @@ static inline void brcmnand_writel(u32 val, void __iomem *addr)
 		writel_relaxed(val, addr);
 }
 
+static inline bool brcmnand_soc_has_ops(struct brcmnand_soc *soc)
+{
+	return soc && soc->ops && soc->ops->read_reg && soc->ops->write_reg;
+}
+
+static inline u32 brcmnand_soc_read(struct brcmnand_soc *soc, u32 offset)
+{
+	return soc->ops->read_reg(soc, offset);
+}
+
+static inline void brcmnand_soc_write(struct brcmnand_soc *soc, u32 val,
+				      u32 offset)
+{
+	soc->ops->write_reg(soc, val, offset);
+}
+
 int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc);
 int brcmnand_remove(struct platform_device *pdev);
 
diff --git a/drivers/net/ethernet/atheros/alx/ethtool.c b/drivers/net/ethernet/atheros/alx/ethtool.c
index 2f4eabf652e8..51e5aa2c74b3 100644
--- a/drivers/net/ethernet/atheros/alx/ethtool.c
+++ b/drivers/net/ethernet/atheros/alx/ethtool.c
@@ -281,9 +281,8 @@ static void alx_get_ethtool_stats(struct net_device *netdev,
 	spin_lock(&alx->stats_lock);
 
 	alx_update_hw_stats(hw);
-	BUILD_BUG_ON(sizeof(hw->stats) - offsetof(struct alx_hw_stats, rx_ok) <
-		     ALX_NUM_STATS * sizeof(u64));
-	memcpy(data, &hw->stats.rx_ok, ALX_NUM_STATS * sizeof(u64));
+	BUILD_BUG_ON(sizeof(hw->stats) != ALX_NUM_STATS * sizeof(u64));
+	memcpy(data, &hw->stats, sizeof(hw->stats));
 
 	spin_unlock(&alx->stats_lock);
 }
diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index cdefb8e2daf1..05fb76a4e144 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -136,8 +136,8 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	ah = sc->sc_ah;
 	ath9k_hw_name(ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)mem, irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, mem, irq);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath9k/mac.h b/drivers/net/wireless/ath/ath9k/mac.h
index fd6aa49adadf..9b00e77a6fc3 100644
--- a/drivers/net/wireless/ath/ath9k/mac.h
+++ b/drivers/net/wireless/ath/ath9k/mac.h
@@ -113,8 +113,10 @@ struct ath_tx_status {
 	u8 qid;
 	u16 desc_id;
 	u8 tid;
-	u32 ba_low;
-	u32 ba_high;
+	struct_group(ba,
+		u32 ba_low;
+		u32 ba_high;
+	);
 	u32 evm0;
 	u32 evm1;
 	u32 evm2;
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index cff9af3af38d..4f90c304d121 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -994,8 +994,8 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sc->sc_ah->msi_reg = 0;
 
 	ath9k_hw_name(sc->sc_ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)sc->mem, pdev->irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, sc->mem, pdev->irq);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 6555abf02f18..84c68aefc171 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -421,7 +421,7 @@ static void ath_tx_count_frames(struct ath_softc *sc, struct ath_buf *bf,
 	isaggr = bf_isaggr(bf);
 	if (isaggr) {
 		seq_st = ts->ts_seqnum;
-		memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+		memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 	}
 
 	while (bf) {
@@ -504,7 +504,7 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 	if (isaggr && txok) {
 		if (ts->ts_flags & ATH9K_TX_BA) {
 			seq_st = ts->ts_seqnum;
-			memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+			memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 		} else {
 			/*
 			 * AR5416 can become deaf/mute when BA
diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index cc830c795b33..5b2de4f3fa0b 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -666,7 +666,7 @@ static int wil_rx_crypto_check(struct wil6210_priv *wil, struct sk_buff *skb)
 	struct wil_tid_crypto_rx *c = mc ? &s->group_crypto_rx :
 				      &s->tid_crypto_rx[tid];
 	struct wil_tid_crypto_rx_single *cc = &c->key_id[key_id];
-	const u8 *pn = (u8 *)&d->mac.pn_15_0;
+	const u8 *pn = (u8 *)&d->mac.pn;
 
 	if (!cc->key_set) {
 		wil_err_ratelimited(wil,
diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wireless/ath/wil6210/txrx.h
index 1f4c8ec75be8..0f6f6b62bfc9 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.h
+++ b/drivers/net/wireless/ath/wil6210/txrx.h
@@ -343,8 +343,10 @@ struct vring_rx_mac {
 	u32 d0;
 	u32 d1;
 	u16 w4;
-	u16 pn_15_0;
-	u32 pn_47_16;
+	struct_group_attr(pn, __packed,
+		u16 pn_15_0;
+		u32 pn_47_16;
+	);
 } __packed;
 
 /* Rx descriptor - DMA part
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 8ca2ce51c83e..b23c05f16320 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -548,7 +548,7 @@ static int wil_rx_crypto_check_edma(struct wil6210_priv *wil,
 	s = &wil->sta[cid];
 	c = mc ? &s->group_crypto_rx : &s->tid_crypto_rx[tid];
 	cc = &c->key_id[key_id];
-	pn = (u8 *)&st->ext.pn_15_0;
+	pn = (u8 *)&st->ext.pn;
 
 	if (!cc->key_set) {
 		wil_err_ratelimited(wil,
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.h b/drivers/net/wireless/ath/wil6210/txrx_edma.h
index c736f7413a35..ee90e225bb05 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.h
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.h
@@ -330,8 +330,10 @@ struct wil_rx_status_extension {
 	u32 d0;
 	u32 d1;
 	__le16 seq_num; /* only lower 12 bits */
-	u16 pn_15_0;
-	u32 pn_47_16;
+	struct_group_attr(pn, __packed,
+		u16 pn_15_0;
+		u32 pn_47_16;
+	);
 } __packed;
 
 struct wil_rx_status_extended {
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 255286b2324e..0d41f172a1dc 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3619,14 +3619,15 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	frame_data_len = nla_len(info->attrs[HWSIM_ATTR_FRAME]);
 	frame_data = (void *)nla_data(info->attrs[HWSIM_ATTR_FRAME]);
 
+	if (frame_data_len < sizeof(struct ieee80211_hdr_3addr) ||
+	    frame_data_len > IEEE80211_MAX_DATA_LEN)
+		goto err;
+
 	/* Allocate new skb here */
 	skb = alloc_skb(frame_data_len, GFP_KERNEL);
 	if (skb == NULL)
 		goto err;
 
-	if (frame_data_len > IEEE80211_MAX_DATA_LEN)
-		goto err;
-
 	/* Copy the data */
 	skb_put_data(skb, frame_data, frame_data_len);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 97bb87c3676b..6c60621b6ccc 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -735,6 +735,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 	int ret;
 	u16 capab;
 	struct ieee80211_ht_cap *ht_cap;
+	unsigned int extra;
 	u8 radio, *pos;
 
 	capab = priv->curr_bss_params.bss_descriptor.cap_info_bitmap;
@@ -753,7 +754,10 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 
 	switch (action_code) {
 	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
-		skb_put(skb, sizeof(mgmt->u.action.u.tdls_discover_resp) + 1);
+		/* See the layout of 'struct ieee80211_mgmt'. */
+		extra = sizeof(mgmt->u.action.u.tdls_discover_resp) +
+			sizeof(mgmt->u.action.category);
+		skb_put(skb, extra);
 		mgmt->u.action.category = WLAN_CATEGORY_PUBLIC;
 		mgmt->u.action.u.tdls_discover_resp.action_code =
 					      WLAN_PUB_ACTION_TDLS_DISCOVER_RES;
@@ -762,8 +766,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 		mgmt->u.action.u.tdls_discover_resp.capability =
 							     cpu_to_le16(capab);
 		/* move back for addr4 */
-		memmove(pos + ETH_ALEN, &mgmt->u.action.category,
-			sizeof(mgmt->u.action.u.tdls_discover_resp));
+		memmove(pos + ETH_ALEN, &mgmt->u.action, extra);
 		/* init address 4 */
 		eth_broadcast_addr(pos);
 
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index f5a33dbe7acb..6ebe72b86266 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -95,6 +95,7 @@
 #define SMMU_PMCG_PA_SHIFT              12
 
 #define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
+#define SMMU_PMCG_HARDEN_DISABLE        BIT(1)
 
 static int cpuhp_state_num;
 
@@ -138,6 +139,20 @@ static inline void smmu_pmu_enable(struct pmu *pmu)
 	writel(SMMU_PMCG_CR_ENABLE, smmu_pmu->reg_base + SMMU_PMCG_CR);
 }
 
+static int smmu_pmu_apply_event_filter(struct smmu_pmu *smmu_pmu,
+				       struct perf_event *event, int idx);
+
+static inline void smmu_pmu_enable_quirk_hip08_09(struct pmu *pmu)
+{
+	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
+	unsigned int idx;
+
+	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
+		smmu_pmu_apply_event_filter(smmu_pmu, smmu_pmu->events[idx], idx);
+
+	smmu_pmu_enable(pmu);
+}
+
 static inline void smmu_pmu_disable(struct pmu *pmu)
 {
 	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
@@ -146,6 +161,22 @@ static inline void smmu_pmu_disable(struct pmu *pmu)
 	writel(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
 }
 
+static inline void smmu_pmu_disable_quirk_hip08_09(struct pmu *pmu)
+{
+	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
+	unsigned int idx;
+
+	/*
+	 * The global disable of PMU sometimes fail to stop the counting.
+	 * Harden this by writing an invalid event type to each used counter
+	 * to forcibly stop counting.
+	 */
+	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
+		writel(0xffff, smmu_pmu->reg_base + SMMU_PMCG_EVTYPER(idx));
+
+	smmu_pmu_disable(pmu);
+}
+
 static inline void smmu_pmu_counter_set_value(struct smmu_pmu *smmu_pmu,
 					      u32 idx, u64 value)
 {
@@ -719,7 +750,10 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 	switch (model) {
 	case IORT_SMMU_V3_PMCG_HISI_HIP08:
 		/* HiSilicon Erratum 162001800 */
-		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
+		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY | SMMU_PMCG_HARDEN_DISABLE;
+		break;
+	case IORT_SMMU_V3_PMCG_HISI_HIP09:
+		smmu_pmu->options |= SMMU_PMCG_HARDEN_DISABLE;
 		break;
 	}
 
@@ -806,6 +840,16 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
 	smmu_pmu_get_acpi_options(smmu_pmu);
 
+	/*
+	 * For platforms suffer this quirk, the PMU disable sometimes fails to
+	 * stop the counters. This will leads to inaccurate or error counting.
+	 * Forcibly disable the counters with these quirk handler.
+	 */
+	if (smmu_pmu->options & SMMU_PMCG_HARDEN_DISABLE) {
+		smmu_pmu->pmu.pmu_enable = smmu_pmu_enable_quirk_hip08_09;
+		smmu_pmu->pmu.pmu_disable = smmu_pmu_disable_quirk_hip08_09;
+	}
+
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = raw_smp_processor_id();
 	WARN_ON(irq_set_affinity_hint(smmu_pmu->irq,
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 2b77cbbcdccb..f91eee01ce95 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -5909,7 +5909,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 					    phba->hba_debugfs_root,
 					    phba,
 					    &lpfc_debugfs_op_multixripools);
-		if (!phba->debug_multixri_pools) {
+		if (IS_ERR(phba->debug_multixri_pools)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "0527 Cannot create debugfs multixripools\n");
 			goto debug_failed;
@@ -5921,7 +5921,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_ras_log);
-		if (!phba->debug_ras_log) {
+		if (IS_ERR(phba->debug_ras_log)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6148 Cannot create debugfs"
 					 " ras_log\n");
@@ -5942,7 +5942,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_op_lockstat);
-		if (!phba->debug_lockstat) {
+		if (IS_ERR(phba->debug_lockstat)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "4610 Can't create debugfs lockstat\n");
 			goto debug_failed;
@@ -6171,7 +6171,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_scsistat);
-	if (!vport->debug_scsistat) {
+	if (IS_ERR(vport->debug_scsistat)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "4611 Cannot create debugfs scsistat\n");
 		goto debug_failed;
@@ -6182,7 +6182,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_ioktime);
-	if (!vport->debug_ioktime) {
+	if (IS_ERR(vport->debug_ioktime)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "0815 Cannot create debugfs ioktime\n");
 		goto debug_failed;
diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 2d5b1d597866..f78cb87e46fa 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2327,7 +2327,7 @@ struct megasas_instance {
 	u32 support_morethan256jbod; /* FW support for more than 256 PD/JBOD */
 	bool use_seqnum_jbod_fp;   /* Added for PD sequence */
 	bool smp_affinity_enable;
-	spinlock_t crashdump_lock;
+	struct mutex crashdump_lock;
 
 	struct megasas_register_set __iomem *reg_set;
 	u32 __iomem *reply_post_host_index_addr[MR_MAX_MSIX_REG_ARRAY];
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b5a74b237fd2..ec9a19d94855 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3221,14 +3221,13 @@ fw_crash_buffer_store(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 	int val = 0;
-	unsigned long flags;
 
 	if (kstrtoint(buf, 0, &val) != 0)
 		return -EINVAL;
 
-	spin_lock_irqsave(&instance->crashdump_lock, flags);
+	mutex_lock(&instance->crashdump_lock);
 	instance->fw_crash_buffer_offset = val;
-	spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+	mutex_unlock(&instance->crashdump_lock);
 	return strlen(buf);
 }
 
@@ -3243,24 +3242,23 @@ fw_crash_buffer_show(struct device *cdev,
 	unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
 	unsigned long chunk_left_bytes;
 	unsigned long src_addr;
-	unsigned long flags;
 	u32 buff_offset;
 
-	spin_lock_irqsave(&instance->crashdump_lock, flags);
+	mutex_lock(&instance->crashdump_lock);
 	buff_offset = instance->fw_crash_buffer_offset;
 	if (!instance->crash_dump_buf ||
 		!((instance->fw_crash_state == AVAILABLE) ||
 		(instance->fw_crash_state == COPYING))) {
 		dev_err(&instance->pdev->dev,
 			"Firmware crash dump is not available\n");
-		spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+		mutex_unlock(&instance->crashdump_lock);
 		return -EINVAL;
 	}
 
 	if (buff_offset > (instance->fw_crash_buffer_size * dmachunk)) {
 		dev_err(&instance->pdev->dev,
 			"Firmware crash dump offset is out of range\n");
-		spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+		mutex_unlock(&instance->crashdump_lock);
 		return 0;
 	}
 
@@ -3272,7 +3270,7 @@ fw_crash_buffer_show(struct device *cdev,
 	src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
 		(buff_offset % dmachunk);
 	memcpy(buf, (void *)src_addr, size);
-	spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+	mutex_unlock(&instance->crashdump_lock);
 
 	return size;
 }
@@ -3297,7 +3295,6 @@ fw_crash_state_store(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 	int val = 0;
-	unsigned long flags;
 
 	if (kstrtoint(buf, 0, &val) != 0)
 		return -EINVAL;
@@ -3311,9 +3308,9 @@ fw_crash_state_store(struct device *cdev,
 	instance->fw_crash_state = val;
 
 	if ((val == COPIED) || (val == COPY_ERROR)) {
-		spin_lock_irqsave(&instance->crashdump_lock, flags);
+		mutex_lock(&instance->crashdump_lock);
 		megasas_free_host_crash_buffer(instance);
-		spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+		mutex_unlock(&instance->crashdump_lock);
 		if (val == COPY_ERROR)
 			dev_info(&instance->pdev->dev, "application failed to "
 				"copy Firmware crash dump\n");
@@ -7325,7 +7322,7 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	init_waitqueue_head(&instance->int_cmd_wait_q);
 	init_waitqueue_head(&instance->abort_cmd_wait_q);
 
-	spin_lock_init(&instance->crashdump_lock);
+	mutex_init(&instance->crashdump_lock);
 	spin_lock_init(&instance->mfi_pool_lock);
 	spin_lock_init(&instance->hba_lock);
 	spin_lock_init(&instance->stream_lock);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 01eb2ade2070..f40db6f40b1d 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -255,7 +255,6 @@ static irqreturn_t pm8001_interrupt_handler_intx(int irq, void *dev_id)
 	return ret;
 }
 
-static u32 pm8001_setup_irq(struct pm8001_hba_info *pm8001_ha);
 static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha);
 
 /**
@@ -275,13 +274,6 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
 	pm8001_dbg(pm8001_ha, INIT, "pm8001_alloc: PHY:%x\n",
 		   pm8001_ha->chip->n_phy);
 
-	/* Setup Interrupt */
-	rc = pm8001_setup_irq(pm8001_ha);
-	if (rc) {
-		pm8001_dbg(pm8001_ha, FAIL,
-			   "pm8001_setup_irq failed [ret: %d]\n", rc);
-		goto err_out;
-	}
 	/* Request Interrupt */
 	rc = pm8001_request_irq(pm8001_ha);
 	if (rc)
@@ -990,47 +982,38 @@ static u32 pm8001_request_msix(struct pm8001_hba_info *pm8001_ha)
 }
 #endif
 
-static u32 pm8001_setup_irq(struct pm8001_hba_info *pm8001_ha)
-{
-	struct pci_dev *pdev;
-
-	pdev = pm8001_ha->pdev;
-
-#ifdef PM8001_USE_MSIX
-	if (pci_find_capability(pdev, PCI_CAP_ID_MSIX))
-		return pm8001_setup_msix(pm8001_ha);
-	pm8001_dbg(pm8001_ha, INIT, "MSIX not supported!!!\n");
-#endif
-	return 0;
-}
-
 /**
  * pm8001_request_irq - register interrupt
  * @pm8001_ha: our ha struct.
  */
 static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha)
 {
-	struct pci_dev *pdev;
+	struct pci_dev *pdev = pm8001_ha->pdev;
+#ifdef PM8001_USE_MSIX
 	int rc;
 
-	pdev = pm8001_ha->pdev;
+	if (pci_find_capability(pdev, PCI_CAP_ID_MSIX)) {
+		rc = pm8001_setup_msix(pm8001_ha);
+		if (rc) {
+			pm8001_dbg(pm8001_ha, FAIL,
+				   "pm8001_setup_irq failed [ret: %d]\n", rc);
+			return rc;
+		}
 
-#ifdef PM8001_USE_MSIX
-	if (pdev->msix_cap && pci_msi_enabled())
-		return pm8001_request_msix(pm8001_ha);
-	else {
-		pm8001_dbg(pm8001_ha, INIT, "MSIX not supported!!!\n");
-		goto intx;
+		if (pdev->msix_cap && pci_msi_enabled())
+			return pm8001_request_msix(pm8001_ha);
 	}
+
+	pm8001_dbg(pm8001_ha, INIT, "MSIX not supported!!!\n");
 #endif
 
-intx:
 	/* initialize the INT-X interrupt */
 	pm8001_ha->irq_vector[0].irq_id = 0;
 	pm8001_ha->irq_vector[0].drv_inst = pm8001_ha;
-	rc = request_irq(pdev->irq, pm8001_interrupt_handler_intx, IRQF_SHARED,
-		pm8001_ha->name, SHOST_TO_SAS_HA(pm8001_ha->shost));
-	return rc;
+
+	return request_irq(pdev->irq, pm8001_interrupt_handler_intx,
+			   IRQF_SHARED, pm8001_ha->name,
+			   SHOST_TO_SAS_HA(pm8001_ha->shost));
 }
 
 /**
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index d5ebcf7d70ff..7d778bf3fd72 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -116,7 +116,7 @@ qla2x00_dfs_create_rport(scsi_qla_host_t *vha, struct fc_port *fp)
 
 	sprintf(wwn, "pn-%016llx", wwn_to_u64(fp->port_name));
 	fp->dfs_rport_dir = debugfs_create_dir(wwn, vha->dfs_rport_root);
-	if (!fp->dfs_rport_dir)
+	if (IS_ERR(fp->dfs_rport_dir))
 		return;
 	if (NVME_TARGET(vha->hw, fp))
 		debugfs_create_file("dev_loss_tmo", 0600, fp->dfs_rport_dir,
@@ -571,14 +571,14 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 	if (IS_QLA27XX(ha) || IS_QLA83XX(ha) || IS_QLA28XX(ha)) {
 		ha->tgt.dfs_naqp = debugfs_create_file("naqp",
 		    0400, ha->dfs_dir, vha, &dfs_naqp_ops);
-		if (!ha->tgt.dfs_naqp) {
+		if (IS_ERR(ha->tgt.dfs_naqp)) {
 			ql_log(ql_log_warn, vha, 0xd011,
 			       "Unable to create debugFS naqp node.\n");
 			goto out;
 		}
 	}
 	vha->dfs_rport_root = debugfs_create_dir("rports", ha->dfs_dir);
-	if (!vha->dfs_rport_root) {
+	if (IS_ERR(vha->dfs_rport_root)) {
 		ql_log(ql_log_warn, vha, 0xd012,
 		       "Unable to create debugFS rports node.\n");
 		goto out;
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 0fa1d57b26fa..3cd671bbb9a4 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -508,102 +508,102 @@ static ssize_t lio_target_nacl_info_show(struct config_item *item, char *page)
 	spin_lock_bh(&se_nacl->nacl_sess_lock);
 	se_sess = se_nacl->nacl_sess;
 	if (!se_sess) {
-		rb += sprintf(page+rb, "No active iSCSI Session for Initiator"
+		rb += sysfs_emit_at(page, rb, "No active iSCSI Session for Initiator"
 			" Endpoint: %s\n", se_nacl->initiatorname);
 	} else {
 		sess = se_sess->fabric_sess_ptr;
 
-		rb += sprintf(page+rb, "InitiatorName: %s\n",
+		rb += sysfs_emit_at(page, rb, "InitiatorName: %s\n",
 			sess->sess_ops->InitiatorName);
-		rb += sprintf(page+rb, "InitiatorAlias: %s\n",
+		rb += sysfs_emit_at(page, rb, "InitiatorAlias: %s\n",
 			sess->sess_ops->InitiatorAlias);
 
-		rb += sprintf(page+rb,
+		rb += sysfs_emit_at(page, rb,
 			      "LIO Session ID: %u   ISID: 0x%6ph  TSIH: %hu  ",
 			      sess->sid, sess->isid, sess->tsih);
-		rb += sprintf(page+rb, "SessionType: %s\n",
+		rb += sysfs_emit_at(page, rb, "SessionType: %s\n",
 				(sess->sess_ops->SessionType) ?
 				"Discovery" : "Normal");
-		rb += sprintf(page+rb, "Session State: ");
+		rb += sysfs_emit_at(page, rb, "Session State: ");
 		switch (sess->session_state) {
 		case TARG_SESS_STATE_FREE:
-			rb += sprintf(page+rb, "TARG_SESS_FREE\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_FREE\n");
 			break;
 		case TARG_SESS_STATE_ACTIVE:
-			rb += sprintf(page+rb, "TARG_SESS_STATE_ACTIVE\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_STATE_ACTIVE\n");
 			break;
 		case TARG_SESS_STATE_LOGGED_IN:
-			rb += sprintf(page+rb, "TARG_SESS_STATE_LOGGED_IN\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_STATE_LOGGED_IN\n");
 			break;
 		case TARG_SESS_STATE_FAILED:
-			rb += sprintf(page+rb, "TARG_SESS_STATE_FAILED\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_STATE_FAILED\n");
 			break;
 		case TARG_SESS_STATE_IN_CONTINUE:
-			rb += sprintf(page+rb, "TARG_SESS_STATE_IN_CONTINUE\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_STATE_IN_CONTINUE\n");
 			break;
 		default:
-			rb += sprintf(page+rb, "ERROR: Unknown Session"
+			rb += sysfs_emit_at(page, rb, "ERROR: Unknown Session"
 					" State!\n");
 			break;
 		}
 
-		rb += sprintf(page+rb, "---------------------[iSCSI Session"
+		rb += sysfs_emit_at(page, rb, "---------------------[iSCSI Session"
 				" Values]-----------------------\n");
-		rb += sprintf(page+rb, "  CmdSN/WR  :  CmdSN/WC  :  ExpCmdSN"
+		rb += sysfs_emit_at(page, rb, "  CmdSN/WR  :  CmdSN/WC  :  ExpCmdSN"
 				"  :  MaxCmdSN  :     ITT    :     TTT\n");
 		max_cmd_sn = (u32) atomic_read(&sess->max_cmd_sn);
-		rb += sprintf(page+rb, " 0x%08x   0x%08x   0x%08x   0x%08x"
+		rb += sysfs_emit_at(page, rb, " 0x%08x   0x%08x   0x%08x   0x%08x"
 				"   0x%08x   0x%08x\n",
 			sess->cmdsn_window,
 			(max_cmd_sn - sess->exp_cmd_sn) + 1,
 			sess->exp_cmd_sn, max_cmd_sn,
 			sess->init_task_tag, sess->targ_xfer_tag);
-		rb += sprintf(page+rb, "----------------------[iSCSI"
+		rb += sysfs_emit_at(page, rb, "----------------------[iSCSI"
 				" Connections]-------------------------\n");
 
 		spin_lock(&sess->conn_lock);
 		list_for_each_entry(conn, &sess->sess_conn_list, conn_list) {
-			rb += sprintf(page+rb, "CID: %hu  Connection"
+			rb += sysfs_emit_at(page, rb, "CID: %hu  Connection"
 					" State: ", conn->cid);
 			switch (conn->conn_state) {
 			case TARG_CONN_STATE_FREE:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_FREE\n");
 				break;
 			case TARG_CONN_STATE_XPT_UP:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_XPT_UP\n");
 				break;
 			case TARG_CONN_STATE_IN_LOGIN:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_IN_LOGIN\n");
 				break;
 			case TARG_CONN_STATE_LOGGED_IN:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_LOGGED_IN\n");
 				break;
 			case TARG_CONN_STATE_IN_LOGOUT:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_IN_LOGOUT\n");
 				break;
 			case TARG_CONN_STATE_LOGOUT_REQUESTED:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_LOGOUT_REQUESTED\n");
 				break;
 			case TARG_CONN_STATE_CLEANUP_WAIT:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_CLEANUP_WAIT\n");
 				break;
 			default:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"ERROR: Unknown Connection State!\n");
 				break;
 			}
 
-			rb += sprintf(page+rb, "   Address %pISc %s", &conn->login_sockaddr,
+			rb += sysfs_emit_at(page, rb, "   Address %pISc %s", &conn->login_sockaddr,
 				(conn->network_transport == ISCSI_TCP) ?
 				"TCP" : "SCTP");
-			rb += sprintf(page+rb, "  StatSN: 0x%08x\n",
+			rb += sysfs_emit_at(page, rb, "  StatSN: 0x%08x\n",
 				conn->stat_sn);
 		}
 		spin_unlock(&sess->conn_lock);
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 4df47d02b34b..f727222469b6 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1263,19 +1263,14 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 {
 	struct uart_cpm_port *pinfo = &cpm_uart_ports[co->index];
 	unsigned long flags;
-	int nolock = oops_in_progress;
 
-	if (unlikely(nolock)) {
+	if (unlikely(oops_in_progress)) {
 		local_irq_save(flags);
-	} else {
-		spin_lock_irqsave(&pinfo->port.lock, flags);
-	}
-
-	cpm_uart_early_write(pinfo, s, count, true);
-
-	if (unlikely(nolock)) {
+		cpm_uart_early_write(pinfo, s, count, true);
 		local_irq_restore(flags);
 	} else {
+		spin_lock_irqsave(&pinfo->port.lock, flags);
+		cpm_uart_early_write(pinfo, s, count, true);
 		spin_unlock_irqrestore(&pinfo->port.lock, flags);
 	}
 }
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index fa66449b3907..618b0a38c885 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1950,9 +1950,13 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		int pipe = index & USB_ENDPOINT_NUMBER_MASK;
-		struct qe_ep *target_ep = &udc->eps[pipe];
+		struct qe_ep *target_ep;
 		u16 usep;
 
+		if (pipe >= USB_MAX_ENDPOINTS)
+			goto stall;
+		target_ep = &udc->eps[pipe];
+
 		/* stall if endpoint doesn't exist */
 		if (!target_ep->ep.desc)
 			goto stall;
diff --git a/fs/attr.c b/fs/attr.c
index 326a0db3296d..fefcdc778028 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -309,9 +309,25 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	}
 
 	if ((ia_valid & ATTR_MODE)) {
-		umode_t amode = attr->ia_mode;
+		/*
+		 * Don't allow changing the mode of symlinks:
+		 *
+		 * (1) The vfs doesn't take the mode of symlinks into account
+		 *     during permission checking.
+		 * (2) This has never worked correctly. Most major filesystems
+		 *     did return EOPNOTSUPP due to interactions with POSIX ACLs
+		 *     but did still updated the mode of the symlink.
+		 *     This inconsistency led system call wrapper providers such
+		 *     as libc to block changing the mode of symlinks with
+		 *     EOPNOTSUPP already.
+		 * (3) To even do this in the first place one would have to use
+		 *     specific file descriptors and quite some effort.
+		 */
+		if (S_ISLNK(inode->i_mode))
+			return -EOPNOTSUPP;
+
 		/* Flag setting protected by i_mutex */
-		if (is_sxid(amode))
+		if (is_sxid(attr->ia_mode))
 			inode->i_flags &= ~S_NOSEC;
 	}
 
diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 5ced859dac53..dd479198310e 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -32,8 +32,9 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name.name);
 		wq->name.name = NULL;
-		wq->wait_ctr--;
 		wake_up_interruptible(&wq->queue);
+		if (!--wq->wait_ctr)
+			kfree(wq);
 		wq = nwq;
 	}
 	fput(sbi->pipe);	/* Close the pipe */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bcc6848bb6d6..67831868ef0d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -529,8 +529,6 @@ struct btrfs_swapfile_pin {
 	int bg_extent_count;
 };
 
-bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
-
 enum {
 	BTRFS_FS_BARRIER,
 	BTRFS_FS_CLOSING_START,
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 04422d929c23..bcffe7886530 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1173,20 +1173,33 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 		ret = __btrfs_commit_inode_delayed_items(trans, path,
 							 curr_node);
 		if (ret) {
-			btrfs_release_delayed_node(curr_node);
-			curr_node = NULL;
 			btrfs_abort_transaction(trans, ret);
 			break;
 		}
 
 		prev_node = curr_node;
 		curr_node = btrfs_next_delayed_node(curr_node);
+		/*
+		 * See the comment below about releasing path before releasing
+		 * node. If the commit of delayed items was successful the path
+		 * should always be released, but in case of an error, it may
+		 * point to locked extent buffers (a leaf at the very least).
+		 */
+		ASSERT(path->nodes[0] == NULL);
 		btrfs_release_delayed_node(prev_node);
 	}
 
+	/*
+	 * Release the path to avoid a potential deadlock and lockdep splat when
+	 * releasing the delayed node, as that requires taking the delayed node's
+	 * mutex. If another task starts running delayed items before we take
+	 * the mutex, it will first lock the mutex and then it may try to lock
+	 * the same btree path (leaf).
+	 */
+	btrfs_free_path(path);
+
 	if (curr_node)
 		btrfs_release_delayed_node(curr_node);
-	btrfs_free_path(path);
 	trans->block_rsv = block_rsv;
 
 	return ret;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1bc6909d4de9..0e25a3f64b2e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2503,13 +2503,11 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (btrfs_fs_incompat(fs_info, METADATA_UUID) &&
-	    memcmp(fs_info->fs_devices->metadata_uuid,
-		   fs_info->super_copy->metadata_uuid, BTRFS_FSID_SIZE)) {
+	if (memcmp(fs_info->fs_devices->metadata_uuid, btrfs_sb_fsid_ptr(sb),
+		   BTRFS_FSID_SIZE) != 0) {
 		btrfs_err(fs_info,
 "superblock metadata_uuid doesn't match metadata uuid of fs_devices: %pU != %pU",
-			fs_info->super_copy->metadata_uuid,
-			fs_info->fs_devices->metadata_uuid);
+			  btrfs_sb_fsid_ptr(sb), fs_info->fs_devices->metadata_uuid);
 		ret = -EINVAL;
 	}
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9cdf50e2484e..4d2f25ebe304 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -857,6 +857,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		err = -ENOENT;
 		goto out;
 	} else if (WARN_ON(ret)) {
+		btrfs_print_leaf(path->nodes[0]);
+		btrfs_err(fs_info,
+"extent item not found for insert, bytenr %llu num_bytes %llu parent %llu root_objectid %llu owner %llu offset %llu",
+			  bytenr, num_bytes, parent, root_objectid, owner,
+			  offset);
 		err = -EIO;
 		goto out;
 	}
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 63bf68e0b006..930126b094ad 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2550,6 +2550,13 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 				goto out_put;
 			}
 
+			/*
+			 * We don't need the path anymore, so release it and
+			 * avoid deadlocks and lockdep warnings in case
+			 * btrfs_iget() needs to lookup the inode from its root
+			 * btree and lock the same leaf.
+			 */
+			btrfs_release_path(path);
 			temp_inode = btrfs_iget(sb, key2.objectid, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
@@ -2569,7 +2576,6 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 				goto out_put;
 			}
 
-			btrfs_release_path(path);
 			key.objectid = key.offset;
 			key.offset = (u64)-1;
 			dirid = key.objectid;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b798586263eb..86c50e0570a5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -718,6 +718,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	return -EINVAL;
 }
 
+u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
+{
+	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
+				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+
+	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
+}
+
 /*
  * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
  * being created with a disk that has already completed its fsid change. Such
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f2177263748e..b2046e92b914 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -580,4 +580,7 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 
+bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
+u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb);
+
 #endif
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 841fa6d9d744..f1dc11dab0d8 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -694,10 +694,10 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 			/* We need to allocate a new block */
 			ext2_fsblk_t goal = ext2_group_first_block_no(sb,
 						EXT2_I(inode)->i_block_group);
-			int block = ext2_new_block(inode, goal, &error);
+			ext2_fsblk_t block = ext2_new_block(inode, goal, &error);
 			if (error)
 				goto cleanup;
-			ea_idebug(inode, "creating block %d", block);
+			ea_idebug(inode, "creating block %lu", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (unlikely(!new_bh)) {
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index ca3d2a33a08c..a50eb4c61ecc 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -339,17 +339,17 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 						   struct buffer_head *bh)
 {
 	struct ext4_dir_entry_tail *t;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
 
 #ifdef PARANOID
 	struct ext4_dir_entry *d, *top;
 
 	d = (struct ext4_dir_entry *)bh->b_data;
 	top = (struct ext4_dir_entry *)(bh->b_data +
-		(EXT4_BLOCK_SIZE(inode->i_sb) -
-		 sizeof(struct ext4_dir_entry_tail)));
-	while (d < top && d->rec_len)
+		(blocksize - sizeof(struct ext4_dir_entry_tail)));
+	while (d < top && ext4_rec_len_from_disk(d->rec_len, blocksize))
 		d = (struct ext4_dir_entry *)(((void *)d) +
-		    le16_to_cpu(d->rec_len));
+		    ext4_rec_len_from_disk(d->rec_len, blocksize));
 
 	if (d != top)
 		return NULL;
@@ -360,7 +360,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 #endif
 
 	if (t->det_reserved_zero1 ||
-	    le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
+	    (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=
+	     sizeof(struct ext4_dir_entry_tail)) ||
 	    t->det_reserved_zero2 ||
 	    t->det_reserved_ft != EXT4_FT_DIR_CSUM)
 		return NULL;
@@ -441,13 +442,14 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 	struct ext4_dir_entry *dp;
 	struct dx_root_info *root;
 	int count_offset;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
+	unsigned int rlen = ext4_rec_len_from_disk(dirent->rec_len, blocksize);
 
-	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
+	if (rlen == blocksize)
 		count_offset = 8;
-	else if (le16_to_cpu(dirent->rec_len) == 12) {
+	else if (rlen == 12) {
 		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
-		if (le16_to_cpu(dp->rec_len) !=
-		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
+		if (ext4_rec_len_from_disk(dp->rec_len, blocksize) != blocksize - 12)
 			return NULL;
 		root = (struct dx_root_info *)(((void *)dp + 12));
 		if (root->reserved_zero ||
@@ -1256,6 +1258,7 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 	unsigned int buflen = bh->b_size;
 	char *base = bh->b_data;
 	struct dx_hash_info h = *hinfo;
+	int blocksize = EXT4_BLOCK_SIZE(dir->i_sb);
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		buflen -= sizeof(struct ext4_dir_entry_tail);
@@ -1269,11 +1272,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
-			map_tail->size = le16_to_cpu(de->rec_len);
+			map_tail->size = ext4_rec_len_from_disk(de->rec_len,
+								blocksize);
 			count++;
 			cond_resched();
 		}
-		de = ext4_next_entry(de, dir->i_sb->s_blocksize);
+		de = ext4_next_entry(de, blocksize);
 	}
 	return count;
 }
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cef3303d9499..a9c078fc2302 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -269,6 +269,7 @@ int dbUnmount(struct inode *ipbmap, int mounterror)
 
 	/* free the memory for the in-memory bmap. */
 	kfree(bmp);
+	JFS_SBI(ipbmap->i_sb)->bmap = NULL;
 
 	return (0);
 }
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 937ca07b58b1..67c67604b8c8 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -195,6 +195,7 @@ int diUnmount(struct inode *ipimap, int mounterror)
 	 * free in-memory control structure
 	 */
 	kfree(imap);
+	JFS_IP(ipimap)->i_imap = NULL;
 
 	return (0);
 }
diff --git a/fs/locks.c b/fs/locks.c
index 12d72c3d8756..cbb5701ce9f3 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1339,6 +1339,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
  out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
+	trace_posix_lock_inode(inode, request, error);
 	/*
 	 * Free any unused locks.
 	 */
@@ -1347,7 +1348,6 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	if (new_fl2)
 		locks_free_lock(new_fl2);
 	locks_dispose_list(&dispose);
-	trace_posix_lock_inode(inode, request, error);
 
 	return error;
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3c651cbcf897..e84996c3867c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -881,8 +881,8 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			     rename->rn_tname, rename->rn_tnamelen);
 	if (status)
 		return status;
-	set_change_info(&rename->rn_sinfo, &cstate->current_fh);
-	set_change_info(&rename->rn_tinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_sinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_tinfo, &cstate->current_fh);
 	return nfs_ok;
 }
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 0e734c8b4dfa..244e4258ce16 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -19,7 +19,6 @@ struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
 	struct kiocb *orig_iocb;
-	struct fd fd;
 };
 
 static struct kmem_cache *ovl_aio_request_cachep;
@@ -261,7 +260,7 @@ static rwf_t ovl_iocb_to_rwf(int ifl)
 static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref)) {
-		fdput(aio_req->fd);
+		fput(aio_req->iocb.ki_filp);
 		kmem_cache_free(ovl_aio_request_cachep, aio_req);
 	}
 }
@@ -327,10 +326,9 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		if (!aio_req)
 			goto out;
 
-		aio_req->fd = real;
 		real.flags = 0;
 		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, real.file);
+		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
 		refcount_set(&aio_req->ref, 2);
 		ret = vfs_iocb_iter_read(real.file, &aio_req->iocb, iter);
@@ -399,10 +397,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		/* Pacify lockdep, same trick as done in aio_write() */
 		__sb_writers_release(file_inode(real.file)->i_sb,
 				     SB_FREEZE_WRITE);
-		aio_req->fd = real;
 		real.flags = 0;
 		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, real.file);
+		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
 		refcount_set(&aio_req->ref, 2);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index a484c30bd5cf..712948e97991 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1881,7 +1881,7 @@ void proc_pid_evict_inode(struct proc_inode *ei)
 	put_pid(pid);
 }
 
-struct inode *proc_pid_make_inode(struct super_block * sb,
+struct inode *proc_pid_make_inode(struct super_block *sb,
 				  struct task_struct *task, umode_t mode)
 {
 	struct inode * inode;
@@ -1910,11 +1910,6 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 
 	/* Let the pid remember us for quick removal */
 	ei->pid = pid;
-	if (S_ISDIR(mode)) {
-		spin_lock(&pid->lock);
-		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
-		spin_unlock(&pid->lock);
-	}
 
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 	security_task_to_inode(task, inode);
@@ -1927,6 +1922,39 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	return NULL;
 }
 
+/*
+ * Generating an inode and adding it into @pid->inodes, so that task will
+ * invalidate inode's dentry before being released.
+ *
+ * This helper is used for creating dir-type entries under '/proc' and
+ * '/proc/<tgid>/task'. Other entries(eg. fd, stat) under '/proc/<tgid>'
+ * can be released by invalidating '/proc/<tgid>' dentry.
+ * In theory, dentries under '/proc/<tgid>/task' can also be released by
+ * invalidating '/proc/<tgid>' dentry, we reserve it to handle single
+ * thread exiting situation: Any one of threads should invalidate its
+ * '/proc/<tgid>/task/<pid>' dentry before released.
+ */
+static struct inode *proc_pid_make_base_inode(struct super_block *sb,
+				struct task_struct *task, umode_t mode)
+{
+	struct inode *inode;
+	struct proc_inode *ei;
+	struct pid *pid;
+
+	inode = proc_pid_make_inode(sb, task, mode);
+	if (!inode)
+		return NULL;
+
+	/* Let proc_flush_pid find this directory inode */
+	ei = PROC_I(inode);
+	pid = ei->pid;
+	spin_lock(&pid->lock);
+	hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
+	spin_unlock(&pid->lock);
+
+	return inode;
+}
+
 int pid_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int query_flags)
 {
@@ -3341,7 +3369,8 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 {
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_base_inode(dentry->d_sb, task,
+					 S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -3637,7 +3666,8 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
 	struct task_struct *task, const void *ptr)
 {
 	struct inode *inode;
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_base_inode(dentry->d_sb, task,
+					 S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 4b7057136852..7d78984af434 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -554,6 +554,9 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
  */
 struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
 {
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	return __create_dir(name, parent, &simple_dir_inode_operations);
 }
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1a12baa58e40..136dba94c646 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -21,6 +21,7 @@
  */
 #define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
 #define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
+#define IORT_SMMU_V3_PMCG_HISI_HIP09     0x00000002 /* HiSilicon HIP09 PMCG */
 
 int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d3600fc7f7c4..5ca9347bd8ef 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -260,6 +260,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 67a50c78232f..93dffe2f3fff 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1069,15 +1069,31 @@ extern int perf_event_output(struct perf_event *event,
 			     struct pt_regs *regs);
 
 static inline bool
-is_default_overflow_handler(struct perf_event *event)
+__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 {
-	if (likely(event->overflow_handler == perf_event_output_forward))
+	if (likely(overflow_handler == perf_event_output_forward))
 		return true;
-	if (unlikely(event->overflow_handler == perf_event_output_backward))
+	if (unlikely(overflow_handler == perf_event_output_backward))
 		return true;
 	return false;
 }
 
+#define is_default_overflow_handler(event) \
+	__is_default_overflow_handler((event)->overflow_handler)
+
+#ifdef CONFIG_BPF_SYSCALL
+static inline bool uses_default_overflow_handler(struct perf_event *event)
+{
+	if (likely(is_default_overflow_handler(event)))
+		return true;
+
+	return __is_default_overflow_handler(event->orig_overflow_handler);
+}
+#else
+#define uses_default_overflow_handler(event) \
+	is_default_overflow_handler(event)
+#endif
+
 extern void
 perf_event_header__init_id(struct perf_event_header *header,
 			   struct perf_sample_data *data,
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index e8304e929e28..de21a45a4ee7 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -110,10 +110,36 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
 }
 
 extern void __put_task_struct(struct task_struct *t);
+extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
 
 static inline void put_task_struct(struct task_struct *t)
 {
-	if (refcount_dec_and_test(&t->usage))
+	if (!refcount_dec_and_test(&t->usage))
+		return;
+
+	/*
+	 * under PREEMPT_RT, we can't call put_task_struct
+	 * in atomic context because it will indirectly
+	 * acquire sleeping locks.
+	 *
+	 * call_rcu() will schedule delayed_put_task_struct_rcu()
+	 * to be called in process context.
+	 *
+	 * __put_task_struct() is called when
+	 * refcount_dec_and_test(&t->usage) succeeds.
+	 *
+	 * This means that it can't "conflict" with
+	 * put_task_struct_rcu_user() which abuses ->rcu the same
+	 * way; rcu_users has a reference so task->usage can't be
+	 * zero after rcu_users 1 -> 0 transition.
+	 *
+	 * delayed_free_task() also uses ->rcu, but it is only called
+	 * when it fails to fork a process. Therefore, there is no
+	 * way it can conflict with put_task_struct().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
+		call_rcu(&t->rcu, __put_task_struct_rcu_cb);
+	else
 		__put_task_struct(t);
 }
 
diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index a494cf43a755..b0caad82b693 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -182,12 +182,14 @@ struct ebt_entry {
 	unsigned char sourcemsk[ETH_ALEN];
 	unsigned char destmac[ETH_ALEN];
 	unsigned char destmsk[ETH_ALEN];
-	/* sizeof ebt_entry + matches */
-	unsigned int watchers_offset;
-	/* sizeof ebt_entry + matches + watchers */
-	unsigned int target_offset;
-	/* sizeof ebt_entry + matches + watchers + target */
-	unsigned int next_offset;
+	__struct_group(/* no tag */, offsets, /* no attrs */,
+		/* sizeof ebt_entry + matches */
+		unsigned int watchers_offset;
+		/* sizeof ebt_entry + matches + watchers */
+		unsigned int target_offset;
+		/* sizeof ebt_entry + matches + watchers + target */
+		unsigned int next_offset;
+	);
 	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 31455f5ab015..633b0af1d1a7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -745,6 +745,14 @@ void __put_task_struct(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(__put_task_struct);
 
+void __put_task_struct_rcu_cb(struct rcu_head *rhp)
+{
+	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
+
+	__put_task_struct(task);
+}
+EXPORT_SYMBOL_GPL(__put_task_struct_rcu_cb);
+
 void __init __weak arch_task_cache_init(void) { }
 
 /*
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 6c05365ed80f..3b9783eda679 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -372,7 +372,7 @@ rcu_scale_writer(void *arg)
 	sched_set_fifo_low(current);
 
 	if (holdoff)
-		schedule_timeout_uninterruptible(holdoff * HZ);
+		schedule_timeout_idle(holdoff * HZ);
 
 	/*
 	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 060ee0b1569a..be86207a2ab6 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -158,7 +158,8 @@ static void scf_torture_stats_print(void)
 		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
 	}
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
-	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
+	    atomic_read(&n_mb_out_errs) ||
+	    (!IS_ENABLED(CONFIG_KASAN) && atomic_read(&n_alloc_errs)))
 		bangstr = "!!! ";
 	pr_alert("%s %sscf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
 		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count,
@@ -306,7 +307,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		preempt_disable();
 	if (scfsp->scfs_prim == SCF_PRIM_SINGLE || scfsp->scfs_wait) {
 		scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
-		if (WARN_ON_ONCE(!scfcp)) {
+		if (!scfcp) {
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_KASAN));
 			atomic_inc(&n_alloc_errs);
 		} else {
 			scfcp->scfc_cpu = -1;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3e0ae116806..7a64c0cd8819 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7324,10 +7324,11 @@ static const struct file_operations tracing_max_lat_fops = {
 #endif
 
 static const struct file_operations set_tracer_fops = {
-	.open		= tracing_open_generic,
+	.open		= tracing_open_generic_tr,
 	.read		= tracing_set_trace_read,
 	.write		= tracing_set_trace_write,
 	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations tracing_pipe_fops = {
@@ -8366,12 +8367,33 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
+static int tracing_open_options(struct inode *inode, struct file *filp)
+{
+	struct trace_option_dentry *topt = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(topt->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+	return 0;
+}
+
+static int tracing_release_options(struct inode *inode, struct file *file)
+{
+	struct trace_option_dentry *topt = file->private_data;
+
+	trace_array_put(topt->tr);
+	return 0;
+}
 
 static const struct file_operations trace_options_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_options,
 	.read = trace_options_read,
 	.write = trace_options_write,
 	.llseek	= generic_file_llseek,
+	.release = tracing_release_options,
 };
 
 /*
diff --git a/lib/kobject.c b/lib/kobject.c
index ea53b30cf483..cd3e1a98eff9 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -874,6 +874,11 @@ int kset_register(struct kset *k)
 	if (!k)
 		return -EINVAL;
 
+	if (!k->kobj.ktype) {
+		pr_err("must have a ktype to be initialized properly!\n");
+		return -EINVAL;
+	}
+
 	kset_init(k);
 	err = kobject_add_internal(&k->kobj);
 	if (err)
diff --git a/lib/mpi/mpi-cmp.c b/lib/mpi/mpi-cmp.c
index c4cfa3ff0581..0835b6213235 100644
--- a/lib/mpi/mpi-cmp.c
+++ b/lib/mpi/mpi-cmp.c
@@ -25,8 +25,12 @@ int mpi_cmp_ui(MPI u, unsigned long v)
 	mpi_limb_t limb = v;
 
 	mpi_normalize(u);
-	if (!u->nlimbs && !limb)
-		return 0;
+	if (u->nlimbs == 0) {
+		if (v == 0)
+			return 0;
+		else
+			return -1;
+	}
 	if (u->sign)
 		return -1;
 	if (u->nlimbs > 1)
diff --git a/mm/filemap.c b/mm/filemap.c
index 3a983bc1a71c..3b0d8c6dd587 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2203,6 +2203,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
 		return 0;
+	if (unlikely(!iov_iter_count(iter)))
+		return 0;
+
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
 	index = *ppos >> PAGE_SHIFT;
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 8335b7e4bcf6..bab14186f9ad 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2001,8 +2001,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
 		return ret;
 
 	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
-	memcpy(&offsets[1], &entry->watchers_offset,
-			sizeof(offsets) - sizeof(offsets[0]));
+	memcpy(&offsets[1], &entry->offsets, sizeof(entry->offsets));
 
 	if (state->buf_kern_start) {
 		buf_start = state->buf_kern_start + state->buf_kern_offset;
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 00c6944ed634..38666dde8934 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -3620,7 +3620,7 @@ static int devlink_param_get(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->get || devlink->reload_failed)
+	if (!param->get)
 		return -EOPNOTSUPP;
 	return param->get(devlink, param->id, ctx);
 }
@@ -3629,7 +3629,7 @@ static int devlink_param_set(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->set || devlink->reload_failed)
+	if (!param->set)
 		return -EOPNOTSUPP;
 	return param->set(devlink, param->id, ctx);
 }
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 697522371914..2046c16b29f0 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -548,34 +548,6 @@ config CLS_U32_MARK
 	help
 	  Say Y here to be able to use netfilter marks as u32 key.
 
-config NET_CLS_RSVP
-	tristate "IPv4 Resource Reservation Protocol (RSVP)"
-	select NET_CLS
-	help
-	  The Resource Reservation Protocol (RSVP) permits end systems to
-	  request a minimum and maximum data flow rate for a connection; this
-	  is important for real time data such as streaming sound or video.
-
-	  Say Y here if you want to be able to classify outgoing packets based
-	  on their RSVP requests.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called cls_rsvp.
-
-config NET_CLS_RSVP6
-	tristate "IPv6 Resource Reservation Protocol (RSVP6)"
-	select NET_CLS
-	help
-	  The Resource Reservation Protocol (RSVP) permits end systems to
-	  request a minimum and maximum data flow rate for a connection; this
-	  is important for real time data such as streaming sound or video.
-
-	  Say Y here if you want to be able to classify outgoing packets based
-	  on their RSVP requests and you are using the IPv6 protocol.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called cls_rsvp6.
-
 config NET_CLS_FLOW
 	tristate "Flow classifier"
 	select NET_CLS
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 4311fdb21119..df2bcd785f7d 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -68,8 +68,6 @@ obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
 obj-$(CONFIG_NET_CLS_FW)	+= cls_fw.o
-obj-$(CONFIG_NET_CLS_RSVP)	+= cls_rsvp.o
-obj-$(CONFIG_NET_CLS_RSVP6)	+= cls_rsvp6.o
 obj-$(CONFIG_NET_CLS_BASIC)	+= cls_basic.o
 obj-$(CONFIG_NET_CLS_FLOW)	+= cls_flow.o
 obj-$(CONFIG_NET_CLS_CGROUP)	+= cls_cgroup.o
diff --git a/net/sched/cls_rsvp.c b/net/sched/cls_rsvp.c
deleted file mode 100644
index de1c1d4da597..000000000000
--- a/net/sched/cls_rsvp.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * net/sched/cls_rsvp.c	Special RSVP packet classifier for IPv4.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <net/ip.h>
-#include <net/netlink.h>
-#include <net/act_api.h>
-#include <net/pkt_cls.h>
-
-#define RSVP_DST_LEN	1
-#define RSVP_ID		"rsvp"
-#define RSVP_OPS	cls_rsvp_ops
-
-#include "cls_rsvp.h"
-MODULE_LICENSE("GPL");
diff --git a/net/sched/cls_rsvp.h b/net/sched/cls_rsvp.h
deleted file mode 100644
index d36949d9382c..000000000000
--- a/net/sched/cls_rsvp.h
+++ /dev/null
@@ -1,777 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * net/sched/cls_rsvp.h	Template file for RSVPv[46] classifiers.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-/*
-   Comparing to general packet classification problem,
-   RSVP needs only sevaral relatively simple rules:
-
-   * (dst, protocol) are always specified,
-     so that we are able to hash them.
-   * src may be exact, or may be wildcard, so that
-     we can keep a hash table plus one wildcard entry.
-   * source port (or flow label) is important only if src is given.
-
-   IMPLEMENTATION.
-
-   We use a two level hash table: The top level is keyed by
-   destination address and protocol ID, every bucket contains a list
-   of "rsvp sessions", identified by destination address, protocol and
-   DPI(="Destination Port ID"): triple (key, mask, offset).
-
-   Every bucket has a smaller hash table keyed by source address
-   (cf. RSVP flowspec) and one wildcard entry for wildcard reservations.
-   Every bucket is again a list of "RSVP flows", selected by
-   source address and SPI(="Source Port ID" here rather than
-   "security parameter index"): triple (key, mask, offset).
-
-
-   NOTE 1. All the packets with IPv6 extension headers (but AH and ESP)
-   and all fragmented packets go to the best-effort traffic class.
-
-
-   NOTE 2. Two "port id"'s seems to be redundant, rfc2207 requires
-   only one "Generalized Port Identifier". So that for classic
-   ah, esp (and udp,tcp) both *pi should coincide or one of them
-   should be wildcard.
-
-   At first sight, this redundancy is just a waste of CPU
-   resources. But DPI and SPI add the possibility to assign different
-   priorities to GPIs. Look also at note 4 about tunnels below.
-
-
-   NOTE 3. One complication is the case of tunneled packets.
-   We implement it as following: if the first lookup
-   matches a special session with "tunnelhdr" value not zero,
-   flowid doesn't contain the true flow ID, but the tunnel ID (1...255).
-   In this case, we pull tunnelhdr bytes and restart lookup
-   with tunnel ID added to the list of keys. Simple and stupid 8)8)
-   It's enough for PIMREG and IPIP.
-
-
-   NOTE 4. Two GPIs make it possible to parse even GRE packets.
-   F.e. DPI can select ETH_P_IP (and necessary flags to make
-   tunnelhdr correct) in GRE protocol field and SPI matches
-   GRE key. Is it not nice? 8)8)
-
-
-   Well, as result, despite its simplicity, we get a pretty
-   powerful classification engine.  */
-
-
-struct rsvp_head {
-	u32			tmap[256/32];
-	u32			hgenerator;
-	u8			tgenerator;
-	struct rsvp_session __rcu *ht[256];
-	struct rcu_head		rcu;
-};
-
-struct rsvp_session {
-	struct rsvp_session __rcu	*next;
-	__be32				dst[RSVP_DST_LEN];
-	struct tc_rsvp_gpi		dpi;
-	u8				protocol;
-	u8				tunnelid;
-	/* 16 (src,sport) hash slots, and one wildcard source slot */
-	struct rsvp_filter __rcu	*ht[16 + 1];
-	struct rcu_head			rcu;
-};
-
-
-struct rsvp_filter {
-	struct rsvp_filter __rcu	*next;
-	__be32				src[RSVP_DST_LEN];
-	struct tc_rsvp_gpi		spi;
-	u8				tunnelhdr;
-
-	struct tcf_result		res;
-	struct tcf_exts			exts;
-
-	u32				handle;
-	struct rsvp_session		*sess;
-	struct rcu_work			rwork;
-};
-
-static inline unsigned int hash_dst(__be32 *dst, u8 protocol, u8 tunnelid)
-{
-	unsigned int h = (__force __u32)dst[RSVP_DST_LEN - 1];
-
-	h ^= h>>16;
-	h ^= h>>8;
-	return (h ^ protocol ^ tunnelid) & 0xFF;
-}
-
-static inline unsigned int hash_src(__be32 *src)
-{
-	unsigned int h = (__force __u32)src[RSVP_DST_LEN-1];
-
-	h ^= h>>16;
-	h ^= h>>8;
-	h ^= h>>4;
-	return h & 0xF;
-}
-
-#define RSVP_APPLY_RESULT()				\
-{							\
-	int r = tcf_exts_exec(skb, &f->exts, res);	\
-	if (r < 0)					\
-		continue;				\
-	else if (r > 0)					\
-		return r;				\
-}
-
-static int rsvp_classify(struct sk_buff *skb, const struct tcf_proto *tp,
-			 struct tcf_result *res)
-{
-	struct rsvp_head *head = rcu_dereference_bh(tp->root);
-	struct rsvp_session *s;
-	struct rsvp_filter *f;
-	unsigned int h1, h2;
-	__be32 *dst, *src;
-	u8 protocol;
-	u8 tunnelid = 0;
-	u8 *xprt;
-#if RSVP_DST_LEN == 4
-	struct ipv6hdr *nhptr;
-
-	if (!pskb_network_may_pull(skb, sizeof(*nhptr)))
-		return -1;
-	nhptr = ipv6_hdr(skb);
-#else
-	struct iphdr *nhptr;
-
-	if (!pskb_network_may_pull(skb, sizeof(*nhptr)))
-		return -1;
-	nhptr = ip_hdr(skb);
-#endif
-restart:
-
-#if RSVP_DST_LEN == 4
-	src = &nhptr->saddr.s6_addr32[0];
-	dst = &nhptr->daddr.s6_addr32[0];
-	protocol = nhptr->nexthdr;
-	xprt = ((u8 *)nhptr) + sizeof(struct ipv6hdr);
-#else
-	src = &nhptr->saddr;
-	dst = &nhptr->daddr;
-	protocol = nhptr->protocol;
-	xprt = ((u8 *)nhptr) + (nhptr->ihl<<2);
-	if (ip_is_fragment(nhptr))
-		return -1;
-#endif
-
-	h1 = hash_dst(dst, protocol, tunnelid);
-	h2 = hash_src(src);
-
-	for (s = rcu_dereference_bh(head->ht[h1]); s;
-	     s = rcu_dereference_bh(s->next)) {
-		if (dst[RSVP_DST_LEN-1] == s->dst[RSVP_DST_LEN - 1] &&
-		    protocol == s->protocol &&
-		    !(s->dpi.mask &
-		      (*(u32 *)(xprt + s->dpi.offset) ^ s->dpi.key)) &&
-#if RSVP_DST_LEN == 4
-		    dst[0] == s->dst[0] &&
-		    dst[1] == s->dst[1] &&
-		    dst[2] == s->dst[2] &&
-#endif
-		    tunnelid == s->tunnelid) {
-
-			for (f = rcu_dereference_bh(s->ht[h2]); f;
-			     f = rcu_dereference_bh(f->next)) {
-				if (src[RSVP_DST_LEN-1] == f->src[RSVP_DST_LEN - 1] &&
-				    !(f->spi.mask & (*(u32 *)(xprt + f->spi.offset) ^ f->spi.key))
-#if RSVP_DST_LEN == 4
-				    &&
-				    src[0] == f->src[0] &&
-				    src[1] == f->src[1] &&
-				    src[2] == f->src[2]
-#endif
-				    ) {
-					*res = f->res;
-					RSVP_APPLY_RESULT();
-
-matched:
-					if (f->tunnelhdr == 0)
-						return 0;
-
-					tunnelid = f->res.classid;
-					nhptr = (void *)(xprt + f->tunnelhdr - sizeof(*nhptr));
-					goto restart;
-				}
-			}
-
-			/* And wildcard bucket... */
-			for (f = rcu_dereference_bh(s->ht[16]); f;
-			     f = rcu_dereference_bh(f->next)) {
-				*res = f->res;
-				RSVP_APPLY_RESULT();
-				goto matched;
-			}
-			return -1;
-		}
-	}
-	return -1;
-}
-
-static void rsvp_replace(struct tcf_proto *tp, struct rsvp_filter *n, u32 h)
-{
-	struct rsvp_head *head = rtnl_dereference(tp->root);
-	struct rsvp_session *s;
-	struct rsvp_filter __rcu **ins;
-	struct rsvp_filter *pins;
-	unsigned int h1 = h & 0xFF;
-	unsigned int h2 = (h >> 8) & 0xFF;
-
-	for (s = rtnl_dereference(head->ht[h1]); s;
-	     s = rtnl_dereference(s->next)) {
-		for (ins = &s->ht[h2], pins = rtnl_dereference(*ins); ;
-		     ins = &pins->next, pins = rtnl_dereference(*ins)) {
-			if (pins->handle == h) {
-				RCU_INIT_POINTER(n->next, pins->next);
-				rcu_assign_pointer(*ins, n);
-				return;
-			}
-		}
-	}
-
-	/* Something went wrong if we are trying to replace a non-existant
-	 * node. Mind as well halt instead of silently failing.
-	 */
-	BUG_ON(1);
-}
-
-static void *rsvp_get(struct tcf_proto *tp, u32 handle)
-{
-	struct rsvp_head *head = rtnl_dereference(tp->root);
-	struct rsvp_session *s;
-	struct rsvp_filter *f;
-	unsigned int h1 = handle & 0xFF;
-	unsigned int h2 = (handle >> 8) & 0xFF;
-
-	if (h2 > 16)
-		return NULL;
-
-	for (s = rtnl_dereference(head->ht[h1]); s;
-	     s = rtnl_dereference(s->next)) {
-		for (f = rtnl_dereference(s->ht[h2]); f;
-		     f = rtnl_dereference(f->next)) {
-			if (f->handle == handle)
-				return f;
-		}
-	}
-	return NULL;
-}
-
-static int rsvp_init(struct tcf_proto *tp)
-{
-	struct rsvp_head *data;
-
-	data = kzalloc(sizeof(struct rsvp_head), GFP_KERNEL);
-	if (data) {
-		rcu_assign_pointer(tp->root, data);
-		return 0;
-	}
-	return -ENOBUFS;
-}
-
-static void __rsvp_delete_filter(struct rsvp_filter *f)
-{
-	tcf_exts_destroy(&f->exts);
-	tcf_exts_put_net(&f->exts);
-	kfree(f);
-}
-
-static void rsvp_delete_filter_work(struct work_struct *work)
-{
-	struct rsvp_filter *f = container_of(to_rcu_work(work),
-					     struct rsvp_filter,
-					     rwork);
-	rtnl_lock();
-	__rsvp_delete_filter(f);
-	rtnl_unlock();
-}
-
-static void rsvp_delete_filter(struct tcf_proto *tp, struct rsvp_filter *f)
-{
-	tcf_unbind_filter(tp, &f->res);
-	/* all classifiers are required to call tcf_exts_destroy() after rcu
-	 * grace period, since converted-to-rcu actions are relying on that
-	 * in cleanup() callback
-	 */
-	if (tcf_exts_get_net(&f->exts))
-		tcf_queue_work(&f->rwork, rsvp_delete_filter_work);
-	else
-		__rsvp_delete_filter(f);
-}
-
-static void rsvp_destroy(struct tcf_proto *tp, bool rtnl_held,
-			 struct netlink_ext_ack *extack)
-{
-	struct rsvp_head *data = rtnl_dereference(tp->root);
-	int h1, h2;
-
-	if (data == NULL)
-		return;
-
-	for (h1 = 0; h1 < 256; h1++) {
-		struct rsvp_session *s;
-
-		while ((s = rtnl_dereference(data->ht[h1])) != NULL) {
-			RCU_INIT_POINTER(data->ht[h1], s->next);
-
-			for (h2 = 0; h2 <= 16; h2++) {
-				struct rsvp_filter *f;
-
-				while ((f = rtnl_dereference(s->ht[h2])) != NULL) {
-					rcu_assign_pointer(s->ht[h2], f->next);
-					rsvp_delete_filter(tp, f);
-				}
-			}
-			kfree_rcu(s, rcu);
-		}
-	}
-	kfree_rcu(data, rcu);
-}
-
-static int rsvp_delete(struct tcf_proto *tp, void *arg, bool *last,
-		       bool rtnl_held, struct netlink_ext_ack *extack)
-{
-	struct rsvp_head *head = rtnl_dereference(tp->root);
-	struct rsvp_filter *nfp, *f = arg;
-	struct rsvp_filter __rcu **fp;
-	unsigned int h = f->handle;
-	struct rsvp_session __rcu **sp;
-	struct rsvp_session *nsp, *s = f->sess;
-	int i, h1;
-
-	fp = &s->ht[(h >> 8) & 0xFF];
-	for (nfp = rtnl_dereference(*fp); nfp;
-	     fp = &nfp->next, nfp = rtnl_dereference(*fp)) {
-		if (nfp == f) {
-			RCU_INIT_POINTER(*fp, f->next);
-			rsvp_delete_filter(tp, f);
-
-			/* Strip tree */
-
-			for (i = 0; i <= 16; i++)
-				if (s->ht[i])
-					goto out;
-
-			/* OK, session has no flows */
-			sp = &head->ht[h & 0xFF];
-			for (nsp = rtnl_dereference(*sp); nsp;
-			     sp = &nsp->next, nsp = rtnl_dereference(*sp)) {
-				if (nsp == s) {
-					RCU_INIT_POINTER(*sp, s->next);
-					kfree_rcu(s, rcu);
-					goto out;
-				}
-			}
-
-			break;
-		}
-	}
-
-out:
-	*last = true;
-	for (h1 = 0; h1 < 256; h1++) {
-		if (rcu_access_pointer(head->ht[h1])) {
-			*last = false;
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static unsigned int gen_handle(struct tcf_proto *tp, unsigned salt)
-{
-	struct rsvp_head *data = rtnl_dereference(tp->root);
-	int i = 0xFFFF;
-
-	while (i-- > 0) {
-		u32 h;
-
-		if ((data->hgenerator += 0x10000) == 0)
-			data->hgenerator = 0x10000;
-		h = data->hgenerator|salt;
-		if (!rsvp_get(tp, h))
-			return h;
-	}
-	return 0;
-}
-
-static int tunnel_bts(struct rsvp_head *data)
-{
-	int n = data->tgenerator >> 5;
-	u32 b = 1 << (data->tgenerator & 0x1F);
-
-	if (data->tmap[n] & b)
-		return 0;
-	data->tmap[n] |= b;
-	return 1;
-}
-
-static void tunnel_recycle(struct rsvp_head *data)
-{
-	struct rsvp_session __rcu **sht = data->ht;
-	u32 tmap[256/32];
-	int h1, h2;
-
-	memset(tmap, 0, sizeof(tmap));
-
-	for (h1 = 0; h1 < 256; h1++) {
-		struct rsvp_session *s;
-		for (s = rtnl_dereference(sht[h1]); s;
-		     s = rtnl_dereference(s->next)) {
-			for (h2 = 0; h2 <= 16; h2++) {
-				struct rsvp_filter *f;
-
-				for (f = rtnl_dereference(s->ht[h2]); f;
-				     f = rtnl_dereference(f->next)) {
-					if (f->tunnelhdr == 0)
-						continue;
-					data->tgenerator = f->res.classid;
-					tunnel_bts(data);
-				}
-			}
-		}
-	}
-
-	memcpy(data->tmap, tmap, sizeof(tmap));
-}
-
-static u32 gen_tunnel(struct rsvp_head *data)
-{
-	int i, k;
-
-	for (k = 0; k < 2; k++) {
-		for (i = 255; i > 0; i--) {
-			if (++data->tgenerator == 0)
-				data->tgenerator = 1;
-			if (tunnel_bts(data))
-				return data->tgenerator;
-		}
-		tunnel_recycle(data);
-	}
-	return 0;
-}
-
-static const struct nla_policy rsvp_policy[TCA_RSVP_MAX + 1] = {
-	[TCA_RSVP_CLASSID]	= { .type = NLA_U32 },
-	[TCA_RSVP_DST]		= { .len = RSVP_DST_LEN * sizeof(u32) },
-	[TCA_RSVP_SRC]		= { .len = RSVP_DST_LEN * sizeof(u32) },
-	[TCA_RSVP_PINFO]	= { .len = sizeof(struct tc_rsvp_pinfo) },
-};
-
-static int rsvp_change(struct net *net, struct sk_buff *in_skb,
-		       struct tcf_proto *tp, unsigned long base,
-		       u32 handle,
-		       struct nlattr **tca,
-		       void **arg, bool ovr, bool rtnl_held,
-		       struct netlink_ext_ack *extack)
-{
-	struct rsvp_head *data = rtnl_dereference(tp->root);
-	struct rsvp_filter *f, *nfp;
-	struct rsvp_filter __rcu **fp;
-	struct rsvp_session *nsp, *s;
-	struct rsvp_session __rcu **sp;
-	struct tc_rsvp_pinfo *pinfo = NULL;
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_RSVP_MAX + 1];
-	struct tcf_exts e;
-	unsigned int h1, h2;
-	__be32 *dst;
-	int err;
-
-	if (opt == NULL)
-		return handle ? -EINVAL : 0;
-
-	err = nla_parse_nested_deprecated(tb, TCA_RSVP_MAX, opt, rsvp_policy,
-					  NULL);
-	if (err < 0)
-		return err;
-
-	err = tcf_exts_init(&e, net, TCA_RSVP_ACT, TCA_RSVP_POLICE);
-	if (err < 0)
-		return err;
-	err = tcf_exts_validate(net, tp, tb, tca[TCA_RATE], &e, ovr, true,
-				extack);
-	if (err < 0)
-		goto errout2;
-
-	f = *arg;
-	if (f) {
-		/* Node exists: adjust only classid */
-		struct rsvp_filter *n;
-
-		if (f->handle != handle && handle)
-			goto errout2;
-
-		n = kmemdup(f, sizeof(*f), GFP_KERNEL);
-		if (!n) {
-			err = -ENOMEM;
-			goto errout2;
-		}
-
-		err = tcf_exts_init(&n->exts, net, TCA_RSVP_ACT,
-				    TCA_RSVP_POLICE);
-		if (err < 0) {
-			kfree(n);
-			goto errout2;
-		}
-
-		if (tb[TCA_RSVP_CLASSID]) {
-			n->res.classid = nla_get_u32(tb[TCA_RSVP_CLASSID]);
-			tcf_bind_filter(tp, &n->res, base);
-		}
-
-		tcf_exts_change(&n->exts, &e);
-		rsvp_replace(tp, n, handle);
-		return 0;
-	}
-
-	/* Now more serious part... */
-	err = -EINVAL;
-	if (handle)
-		goto errout2;
-	if (tb[TCA_RSVP_DST] == NULL)
-		goto errout2;
-
-	err = -ENOBUFS;
-	f = kzalloc(sizeof(struct rsvp_filter), GFP_KERNEL);
-	if (f == NULL)
-		goto errout2;
-
-	err = tcf_exts_init(&f->exts, net, TCA_RSVP_ACT, TCA_RSVP_POLICE);
-	if (err < 0)
-		goto errout;
-	h2 = 16;
-	if (tb[TCA_RSVP_SRC]) {
-		memcpy(f->src, nla_data(tb[TCA_RSVP_SRC]), sizeof(f->src));
-		h2 = hash_src(f->src);
-	}
-	if (tb[TCA_RSVP_PINFO]) {
-		pinfo = nla_data(tb[TCA_RSVP_PINFO]);
-		f->spi = pinfo->spi;
-		f->tunnelhdr = pinfo->tunnelhdr;
-	}
-	if (tb[TCA_RSVP_CLASSID])
-		f->res.classid = nla_get_u32(tb[TCA_RSVP_CLASSID]);
-
-	dst = nla_data(tb[TCA_RSVP_DST]);
-	h1 = hash_dst(dst, pinfo ? pinfo->protocol : 0, pinfo ? pinfo->tunnelid : 0);
-
-	err = -ENOMEM;
-	if ((f->handle = gen_handle(tp, h1 | (h2<<8))) == 0)
-		goto errout;
-
-	if (f->tunnelhdr) {
-		err = -EINVAL;
-		if (f->res.classid > 255)
-			goto errout;
-
-		err = -ENOMEM;
-		if (f->res.classid == 0 &&
-		    (f->res.classid = gen_tunnel(data)) == 0)
-			goto errout;
-	}
-
-	for (sp = &data->ht[h1];
-	     (s = rtnl_dereference(*sp)) != NULL;
-	     sp = &s->next) {
-		if (dst[RSVP_DST_LEN-1] == s->dst[RSVP_DST_LEN-1] &&
-		    pinfo && pinfo->protocol == s->protocol &&
-		    memcmp(&pinfo->dpi, &s->dpi, sizeof(s->dpi)) == 0 &&
-#if RSVP_DST_LEN == 4
-		    dst[0] == s->dst[0] &&
-		    dst[1] == s->dst[1] &&
-		    dst[2] == s->dst[2] &&
-#endif
-		    pinfo->tunnelid == s->tunnelid) {
-
-insert:
-			/* OK, we found appropriate session */
-
-			fp = &s->ht[h2];
-
-			f->sess = s;
-			if (f->tunnelhdr == 0)
-				tcf_bind_filter(tp, &f->res, base);
-
-			tcf_exts_change(&f->exts, &e);
-
-			fp = &s->ht[h2];
-			for (nfp = rtnl_dereference(*fp); nfp;
-			     fp = &nfp->next, nfp = rtnl_dereference(*fp)) {
-				__u32 mask = nfp->spi.mask & f->spi.mask;
-
-				if (mask != f->spi.mask)
-					break;
-			}
-			RCU_INIT_POINTER(f->next, nfp);
-			rcu_assign_pointer(*fp, f);
-
-			*arg = f;
-			return 0;
-		}
-	}
-
-	/* No session found. Create new one. */
-
-	err = -ENOBUFS;
-	s = kzalloc(sizeof(struct rsvp_session), GFP_KERNEL);
-	if (s == NULL)
-		goto errout;
-	memcpy(s->dst, dst, sizeof(s->dst));
-
-	if (pinfo) {
-		s->dpi = pinfo->dpi;
-		s->protocol = pinfo->protocol;
-		s->tunnelid = pinfo->tunnelid;
-	}
-	sp = &data->ht[h1];
-	for (nsp = rtnl_dereference(*sp); nsp;
-	     sp = &nsp->next, nsp = rtnl_dereference(*sp)) {
-		if ((nsp->dpi.mask & s->dpi.mask) != s->dpi.mask)
-			break;
-	}
-	RCU_INIT_POINTER(s->next, nsp);
-	rcu_assign_pointer(*sp, s);
-
-	goto insert;
-
-errout:
-	tcf_exts_destroy(&f->exts);
-	kfree(f);
-errout2:
-	tcf_exts_destroy(&e);
-	return err;
-}
-
-static void rsvp_walk(struct tcf_proto *tp, struct tcf_walker *arg,
-		      bool rtnl_held)
-{
-	struct rsvp_head *head = rtnl_dereference(tp->root);
-	unsigned int h, h1;
-
-	if (arg->stop)
-		return;
-
-	for (h = 0; h < 256; h++) {
-		struct rsvp_session *s;
-
-		for (s = rtnl_dereference(head->ht[h]); s;
-		     s = rtnl_dereference(s->next)) {
-			for (h1 = 0; h1 <= 16; h1++) {
-				struct rsvp_filter *f;
-
-				for (f = rtnl_dereference(s->ht[h1]); f;
-				     f = rtnl_dereference(f->next)) {
-					if (arg->count < arg->skip) {
-						arg->count++;
-						continue;
-					}
-					if (arg->fn(tp, f, arg) < 0) {
-						arg->stop = 1;
-						return;
-					}
-					arg->count++;
-				}
-			}
-		}
-	}
-}
-
-static int rsvp_dump(struct net *net, struct tcf_proto *tp, void *fh,
-		     struct sk_buff *skb, struct tcmsg *t, bool rtnl_held)
-{
-	struct rsvp_filter *f = fh;
-	struct rsvp_session *s;
-	struct nlattr *nest;
-	struct tc_rsvp_pinfo pinfo;
-
-	if (f == NULL)
-		return skb->len;
-	s = f->sess;
-
-	t->tcm_handle = f->handle;
-
-	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-
-	if (nla_put(skb, TCA_RSVP_DST, sizeof(s->dst), &s->dst))
-		goto nla_put_failure;
-	pinfo.dpi = s->dpi;
-	pinfo.spi = f->spi;
-	pinfo.protocol = s->protocol;
-	pinfo.tunnelid = s->tunnelid;
-	pinfo.tunnelhdr = f->tunnelhdr;
-	pinfo.pad = 0;
-	if (nla_put(skb, TCA_RSVP_PINFO, sizeof(pinfo), &pinfo))
-		goto nla_put_failure;
-	if (f->res.classid &&
-	    nla_put_u32(skb, TCA_RSVP_CLASSID, f->res.classid))
-		goto nla_put_failure;
-	if (((f->handle >> 8) & 0xFF) != 16 &&
-	    nla_put(skb, TCA_RSVP_SRC, sizeof(f->src), f->src))
-		goto nla_put_failure;
-
-	if (tcf_exts_dump(skb, &f->exts) < 0)
-		goto nla_put_failure;
-
-	nla_nest_end(skb, nest);
-
-	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-
-static void rsvp_bind_class(void *fh, u32 classid, unsigned long cl, void *q,
-			    unsigned long base)
-{
-	struct rsvp_filter *f = fh;
-
-	if (f && f->res.classid == classid) {
-		if (cl)
-			__tcf_bind_filter(q, &f->res, base);
-		else
-			__tcf_unbind_filter(q, &f->res);
-	}
-}
-
-static struct tcf_proto_ops RSVP_OPS __read_mostly = {
-	.kind		=	RSVP_ID,
-	.classify	=	rsvp_classify,
-	.init		=	rsvp_init,
-	.destroy	=	rsvp_destroy,
-	.get		=	rsvp_get,
-	.change		=	rsvp_change,
-	.delete		=	rsvp_delete,
-	.walk		=	rsvp_walk,
-	.dump		=	rsvp_dump,
-	.bind_class	=	rsvp_bind_class,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init init_rsvp(void)
-{
-	return register_tcf_proto_ops(&RSVP_OPS);
-}
-
-static void __exit exit_rsvp(void)
-{
-	unregister_tcf_proto_ops(&RSVP_OPS);
-}
-
-module_init(init_rsvp)
-module_exit(exit_rsvp)
diff --git a/net/sched/cls_rsvp6.c b/net/sched/cls_rsvp6.c
deleted file mode 100644
index 64078846000e..000000000000
--- a/net/sched/cls_rsvp6.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * net/sched/cls_rsvp6.c	Special RSVP packet classifier for IPv6.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/ipv6.h>
-#include <linux/skbuff.h>
-#include <net/act_api.h>
-#include <net/pkt_cls.h>
-#include <net/netlink.h>
-
-#define RSVP_DST_LEN	4
-#define RSVP_ID		"rsvp6"
-#define RSVP_OPS	cls_rsvp6_ops
-
-#include "cls_rsvp.h"
-MODULE_LICENSE("GPL");
diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index 418c46fe5ffc..b99322f188e5 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -70,7 +70,9 @@ static int __init hw_break_module_init(void)
 static void __exit hw_break_module_exit(void)
 {
 	unregister_wide_hw_breakpoint(sample_hbp);
-	symbol_put(ksym_name);
+#ifdef CONFIG_MODULE_UNLOAD
+	__symbol_put(ksym_name);
+#endif
 	printk(KERN_INFO "HW Breakpoint for %s write uninstalled\n", ksym_name);
 }
 
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index f96e70c85f84..801c89a3a1b6 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -368,6 +368,14 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
+/* Lunar Lake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_LUNARLAKE)
+	/* Lunarlake-P */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_LNL_P,
+	},
+#endif
 };
 
 static const struct config_entry *snd_intel_dsp_find_config
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3e7706c251e9..89905b4e9309 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -824,33 +824,36 @@ else
   endif
 endif
 
-ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd -lopcodes
-else
-  # we are on a system that requires -liberty and (maybe) -lz
-  # to link against -lbfd; test each case individually here
-
-  # call all detections now so we get correct
-  # status in VF output
-  $(call feature_check,libbfd-liberty)
-  $(call feature_check,libbfd-liberty-z)
 
-  ifeq ($(feature-libbfd-liberty), 1)
-    EXTLIBS += -lbfd -lopcodes -liberty
-    FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
+ifndef NO_LIBBFD
+  ifeq ($(feature-libbfd), 1)
+    EXTLIBS += -lbfd -lopcodes
   else
-    ifeq ($(feature-libbfd-liberty-z), 1)
-      EXTLIBS += -lbfd -lopcodes -liberty -lz
-      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+    # we are on a system that requires -liberty and (maybe) -lz
+    # to link against -lbfd; test each case individually here
+
+    # call all detections now so we get correct
+    # status in VF output
+    $(call feature_check,libbfd-liberty)
+    $(call feature_check,libbfd-liberty-z)
+
+    ifeq ($(feature-libbfd-liberty), 1)
+      EXTLIBS += -lbfd -lopcodes -liberty
+      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
+    else
+      ifeq ($(feature-libbfd-liberty-z), 1)
+        EXTLIBS += -lbfd -lopcodes -liberty -lz
+        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+      endif
     endif
+    $(call feature_check,disassembler-four-args)
   endif
-  $(call feature_check,disassembler-four-args)
-endif
 
-ifeq ($(feature-libbfd-buildid), 1)
-  CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
-else
-  msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
+  ifeq ($(feature-libbfd-buildid), 1)
+    CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
+  else
+    msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
+  endif
 endif
 
 ifdef NO_DEMANGLE
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 215ba30b8534..a055dee6a46a 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -6,10 +6,13 @@ pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
 JSON		=  $(shell [ -d $(JDIR) ] &&				\
 			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
+JDIR_TEST	=  pmu-events/arch/test
+JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
+			find $(JDIR_TEST) -name '*.json')
 
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
 #
-$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JEVENTS)
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS)
 	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c $(V)
diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 8ec1922e974e..55314cd197ab 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -30,6 +30,9 @@ err_ret=1
 # kselftest skip code is 4
 err_skip=4
 
+# umount required
+UMOUNT_DIR=""
+
 # cgroup RT scheduling prevents chrt commands from succeeding, which
 # induces failures in test wakeup tests.  Disable for the duration of
 # the tests.
@@ -44,6 +47,9 @@ setup() {
 
 cleanup() {
   echo $sched_rt_runtime_orig > $sched_rt_runtime
+  if [ -n "${UMOUNT_DIR}" ]; then
+    umount ${UMOUNT_DIR} ||:
+  fi
 }
 
 errexit() { # message
@@ -155,11 +161,13 @@ if [ -z "$TRACING_DIR" ]; then
 	    mount -t tracefs nodev /sys/kernel/tracing ||
 	      errexit "Failed to mount /sys/kernel/tracing"
 	    TRACING_DIR="/sys/kernel/tracing"
+	    UMOUNT_DIR=${TRACING_DIR}
 	# If debugfs exists, then so does /sys/kernel/debug
 	elif [ -d "/sys/kernel/debug" ]; then
 	    mount -t debugfs nodev /sys/kernel/debug ||
 	      errexit "Failed to mount /sys/kernel/debug"
 	    TRACING_DIR="/sys/kernel/debug/tracing"
+	    UMOUNT_DIR=${TRACING_DIR}
 	else
 	    err_ret=$err_skip
 	    errexit "debugfs and tracefs are not configured in this kernel"
