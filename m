Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897D47ABF47
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjIWJ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjIWJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:27:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926CC196;
        Sat, 23 Sep 2023 02:27:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1B7C433C7;
        Sat, 23 Sep 2023 09:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695461258;
        bh=VhUWO786umP/45TWKoal5dCtQ+df0sFkzH1BiRPNIgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kbw7hZv2YHYeI4HkaCdQb53rqTxV5d3EyPRtmaDaaV+idRzp9B4e1MNIlcfpEIVQx
         9GO+HgJZZ6sVW9Mybk2x7g9MqTvdgMKdbtpWjsZj1/Gc0/6KwPnE6rrN166QcHrGm4
         LdFIZDNEI2G3FLjfPFZGcIkRKxICaye9KUFeiIoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.133
Date:   Sat, 23 Sep 2023 11:27:28 +0200
Message-ID: <2023092328-aggregate-unskilled-e84b@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023092328-registry-deduct-1830@gregkh>
References: <2023092328-registry-deduct-1830@gregkh>
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
index 83a75e16e54d..d2f90ecc426f 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -172,6 +172,9 @@ stable kernels.
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
index b2ff07a0176b..b6e42a131235 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 132
+SUBLEVEL = 133
 EXTRAVERSION =
 NAME = Trick or Treat
 
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
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index f567032a09c0..6d1938d1b4df 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -92,16 +92,28 @@ void machine_crash_nonpanic_core(void *unused)
 	}
 }
 
+static DEFINE_PER_CPU(call_single_data_t, cpu_stop_csd) =
+	CSD_INIT(machine_crash_nonpanic_core, NULL);
+
 void crash_smp_send_stop(void)
 {
 	static int cpus_stopped;
 	unsigned long msecs;
+	call_single_data_t *csd;
+	int cpu, this_cpu = raw_smp_processor_id();
 
 	if (cpus_stopped)
 		return;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
+	for_each_online_cpu(cpu) {
+		if (cpu == this_cpu)
+			continue;
+
+		csd = &per_cpu(cpu_stop_csd, cpu);
+		smp_call_function_single_async(cpu, csd);
+	}
+
 	msecs = 1000; /* Wait at most a second for the other cpus to stop */
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
 		mdelay(1);
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 47f8e5397ebb..8625fb3a7f0a 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -74,7 +74,7 @@ pstore_mem: ramoops@ffc00000 {
 			reg = <0x0 0xffc40000 0x0 0xc0000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 		};
 
 		cmdline_mem: memory@ffd00000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index 04c71f74ab72..c9aa7764fc59 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -127,7 +127,7 @@ ramoops@ffc00000 {
 			reg = <0x0 0xffc00000 0x0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index e622cbe167b0..aeec0b6a1d7d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -126,7 +126,7 @@ ramoops@ffc00000 {
 			reg = <0x0 0xffc00000 0x0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 2a7f21314cde..c30fa2445832 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -654,7 +654,7 @@ static int breakpoint_handler(unsigned long unused, unsigned long esr,
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
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 151e98698f76..3830217fab41 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -323,7 +323,7 @@ KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef need-compiler
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
-	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
+	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif
 
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 1b2ea34c3d3b..ed090ef30757 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -68,7 +68,7 @@ KCOV_INSTRUMENT := n
 
 # Check that we don't have PIC 'jalr t9' calls left
 quiet_cmd_vdso_mips_check = VDSOCHK $@
-      cmd_vdso_mips_check = if $(OBJDUMP) --disassemble $@ | egrep -h "jalr.*t9" > /dev/null; \
+      cmd_vdso_mips_check = if $(OBJDUMP) --disassemble $@ | grep -E -h "jalr.*t9" > /dev/null; \
 		       then (echo >&2 "$@: PIC 'jalr t9' calls are not supported"; \
 			     rm -f $@; /bin/false); fi
 
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 7ee3ed7d6cc2..6936ffee253b 100644
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
index f7213d0943b8..575d881ff86e 100644
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
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index dc0b91c1db04..7a7701d1e18d 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -19,6 +19,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 # optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
 
+# When LTO is enabled, llvm emits many text sections, which is not supported
+# by kexec. Remove -flto=* flags.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
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
index de6cbcf69bbd..b05020657cdc 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -396,10 +396,10 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
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
index 3e80eb1a5f35..590326c200a2 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -603,7 +603,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 
 /* 7E */ ACPI_OP("Timer", ARGP_TIMER_OP, ARGI_TIMER_OP, ACPI_TYPE_ANY,
 			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_0A_0T_1R,
-			 AML_FLAGS_EXEC_0A_0T_1R),
+			 AML_FLAGS_EXEC_0A_0T_1R | AML_NO_OPERAND_RESOLVE),
 
 /* ACPI 5.0 opcodes */
 
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index f2f8f05662de..3dd74ad95d01 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1381,7 +1381,10 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
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
index 038542b3a80a..5afc42d52e49 100644
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
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 946e0160ad3b..ada989670d9b 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -111,6 +111,12 @@ static void lpi_device_get_constraints_amd(void)
 		union acpi_object *package = &out_obj->package.elements[i];
 
 		if (package->type == ACPI_TYPE_PACKAGE) {
+			if (lpi_constraints_table) {
+				acpi_handle_err(lps0_device_handle,
+						"Duplicate constraints list\n");
+				goto free_acpi_buffer;
+			}
+
 			lpi_constraints_table = kcalloc(package->package.count,
 							sizeof(*lpi_constraints_table),
 							GFP_KERNEL);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 149ee16fd022..acc028414ee9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1886,6 +1886,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index b5aa525d8760..cb9395a3ad8e 100644
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
index 436c0f3563d7..74ab6cf031ce 100644
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
index 4b01188385b2..2d8f71dde980 100644
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
index 4cf33abfb7cc..317ddc807158 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1204,11 +1204,15 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	agp_top = adev->gmc.agp_end >> 24;
 
 
-	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44) & 0xF;
-	page_table_start.low_part = (u32)(adev->gmc.gart_start >> 12);
-	page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44) & 0xF;
-	page_table_end.low_part = (u32)(adev->gmc.gart_end >> 12);
-	page_table_base.high_part = upper_32_bits(pt_base) & 0xF;
+	page_table_start.high_part = upper_32_bits(adev->gmc.gart_start >>
+						   AMDGPU_GPU_PAGE_SHIFT);
+	page_table_start.low_part = lower_32_bits(adev->gmc.gart_start >>
+						  AMDGPU_GPU_PAGE_SHIFT);
+	page_table_end.high_part = upper_32_bits(adev->gmc.gart_end >>
+						 AMDGPU_GPU_PAGE_SHIFT);
+	page_table_end.low_part = lower_32_bits(adev->gmc.gart_end >>
+						AMDGPU_GPU_PAGE_SHIFT);
+	page_table_base.high_part = upper_32_bits(pt_base);
 	page_table_base.low_part = lower_32_bits(pt_base);
 
 	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;
@@ -8790,6 +8794,13 @@ static void handle_cursor_update(struct drm_plane *plane,
 	attributes.rotation_angle    = 0;
 	attributes.attribute_flags.value = 0;
 
+	/* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma in DRM
+	 * legacy gamma setup.
+	 */
+	if (crtc_state->cm_is_degamma_srgb &&
+	    adev->dm.dc->caps.color.dpp.gamma_corr)
+		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
+
 	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
 
 	if (crtc_state->stream) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index aa0507e01792..c5e0de4f77b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -4162,7 +4162,9 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN31_MAX_FMT_420_BUFFER_WIDTH
 						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
-					if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
+					if (v->Output[k] == dm_hdmi) {
+						FMTBufferExceeded = true;
+					} else if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
 						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
 						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
 
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
index 4153f302de7c..d19e796c2061 100644
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
index 6bc0c298739c..9985a4419bb0 100644
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
@@ -386,7 +386,7 @@ static void gm12u320_fb_update_work(struct work_struct *work)
 	 * switches back to showing its logo.
 	 */
 	queue_delayed_work(system_long_wq, &gm12u320->fb_update.work,
-			   IDLE_TIMEOUT);
+			   msecs_to_jiffies(IDLE_TIMEOUT));
 
 	return;
 err:
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 67e8b97c0c95..d93e0e517e70 100644
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
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 14d785e5629e..ab654b33f5d2 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -29,6 +29,7 @@ static LIST_HEAD(icc_providers);
 static int providers_count;
 static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
+static DEFINE_MUTEX(icc_bw_lock);
 static struct dentry *icc_debugfs_dir;
 
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
@@ -632,7 +633,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
 		return -EINVAL;
 
-	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
 
 	old_avg = path->reqs[0].avg_bw;
 	old_peak = path->reqs[0].peak_bw;
@@ -664,7 +665,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 		apply_constraints(path);
 	}
 
-	mutex_unlock(&icc_lock);
+	mutex_unlock(&icc_bw_lock);
 
 	trace_icc_set_bw_end(path, ret);
 
@@ -967,6 +968,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 		return;
 
 	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
 
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
@@ -992,6 +994,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
+	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
@@ -1119,6 +1122,7 @@ void icc_sync_state(struct device *dev)
 		return;
 
 	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
 	synced_state = true;
 	list_for_each_entry(p, &icc_providers, provider_list) {
 		dev_dbg(p->dev, "interconnect provider is in synced state\n");
@@ -1131,13 +1135,21 @@ void icc_sync_state(struct device *dev)
 			}
 		}
 	}
+	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_sync_state);
 
 static int __init icc_init(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	struct device_node *root;
+
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&icc_bw_lock);
+	fs_reclaim_release(GFP_KERNEL);
+
+	root = of_find_node_by_path("/");
 
 	providers_count = of_count_icc_providers(root);
 	of_node_put(root);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 084bfea6ad31..8427c9767a61 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1822,6 +1822,9 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	int number = rdev->raid_disk;
 	struct raid1_info *p = conf->mirrors + number;
 
+	if (unlikely(number >= conf->raid_disks))
+		goto abort;
+
 	if (rdev != p->rdev)
 		p = conf->mirrors + conf->raid_disks + number;
 
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index b01499f81069..6851e01da1c5 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -413,7 +413,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 				dev->height >> 1);
 		break;
 	default:
-		BUG();
+		return -EINVAL; /* should not happen */
 	}
 	dprintk(2, "[%p/%d] buffer_init - %dx%d %dbpp 0x%08x - dma=0x%08lx\n",
 		buf, buf->vb.vb2_buf.index,
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 3a8af3936e93..162ab089124f 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -345,7 +345,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
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
index 5eef37b00a52..56bb507fca21 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -270,6 +270,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	struct state *state = d_to_priv(d);
 	int ret;
+	u32 reg;
 
 	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
 		return -EAGAIN;
@@ -322,8 +323,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
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
@@ -381,17 +384,16 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
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
index aa45b5d263f6..a1235d0cce92 100644
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
index 1ed62a80067c..253d13bdb63e 100644
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
index a6aa33dcd2a2..d8a408071236 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -171,8 +171,8 @@
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
@@ -917,7 +917,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+	if ((imx_data->socdata->flags & ESDHC_FLAG_ERR010450) &&
+	    (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))) {
 		unsigned int max_clock;
 
 		max_clock = imx_data->is_ddr ? 45000000 : 150000000;
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index c1afadb50eec..c1e7ab13e777 100644
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
@@ -268,6 +271,7 @@ struct brcmnand_controller {
 	const unsigned int	*page_sizes;
 	unsigned int		page_size_shift;
 	unsigned int		max_oob;
+	u32			ecc_level_shift;
 	u32			features;
 
 	/* for low-power standby/resume only */
@@ -592,15 +596,53 @@ enum {
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
@@ -719,6 +761,12 @@ static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
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
 
@@ -766,13 +814,18 @@ static inline void brcmnand_rmw_reg(struct brcmnand_controller *ctrl,
 
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
@@ -902,30 +955,6 @@ static inline int brcmnand_cmd_shift(struct brcmnand_controller *ctrl)
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
@@ -938,18 +967,15 @@ static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
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
@@ -963,8 +989,8 @@ static void brcmnand_set_ecc_enabled(struct brcmnand_host *host, int en)
 
 	if (en) {
 		acc_control |= ecc_flags; /* enable RD/WR ECC */
-		acc_control |= host->hwcfg.ecc_level
-			       << NAND_ACC_CONTROL_ECC_SHIFT;
+		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
+		acc_control |= host->hwcfg.ecc_level << ctrl->ecc_level_shift;
 	} else {
 		acc_control &= ~ecc_flags; /* disable RD/WR ECC */
 		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
@@ -2564,7 +2590,7 @@ static int brcmnand_set_cfg(struct brcmnand_host *host,
 	tmp &= ~brcmnand_ecc_level_mask(ctrl);
 	tmp &= ~brcmnand_spare_area_mask(ctrl);
 	if (ctrl->nand_version >= 0x0302) {
-		tmp |= cfg->ecc_level << NAND_ACC_CONTROL_ECC_SHIFT;
+		tmp |= cfg->ecc_level << ctrl->ecc_level_shift;
 		tmp |= cfg->spare_area_size;
 	}
 	nand_writereg(ctrl, acc_control_offs, tmp);
@@ -3034,6 +3060,12 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
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
index b716adacd815..7f6b69a52367 100644
--- a/drivers/net/ethernet/atheros/alx/ethtool.c
+++ b/drivers/net/ethernet/atheros/alx/ethtool.c
@@ -292,9 +292,8 @@ static void alx_get_ethtool_stats(struct net_device *netdev,
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
index a074e23013c5..f0e3901e8182 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -988,8 +988,8 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
index 201c8c35e0c9..1ba1f21ebea2 100644
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
index c3c3b5aa87b0..6eb3c845640b 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3693,14 +3693,15 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
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
 
diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 78d002be4f82..f6c71c1b657b 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -301,6 +301,7 @@ static int fu740_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pci->pp.ops = &fu740_pcie_host_ops;
+	pci->pp.num_vectors = MAX_MSI_IRQS;
 
 	/* SiFive specific region: mgmt */
 	afp->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 5933ad151f86..1ef683bb40b6 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -96,6 +96,7 @@
 #define SMMU_PMCG_PA_SHIFT              12
 
 #define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
+#define SMMU_PMCG_HARDEN_DISABLE        BIT(1)
 
 static int cpuhp_state_num;
 
@@ -140,6 +141,20 @@ static inline void smmu_pmu_enable(struct pmu *pmu)
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
@@ -148,6 +163,22 @@ static inline void smmu_pmu_disable(struct pmu *pmu)
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
@@ -747,7 +778,10 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
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
 
@@ -836,6 +870,16 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
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
 	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 4daa782c48df..6f6bc0a446ff 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -28,6 +28,8 @@
 #define CNTL_CLEAR_MASK		0xFFFFFFFD
 #define CNTL_OVER_MASK		0xFFFFFFFE
 
+#define CNTL_CP_SHIFT		16
+#define CNTL_CP_MASK		(0xFF << CNTL_CP_SHIFT)
 #define CNTL_CSV_SHIFT		24
 #define CNTL_CSV_MASK		(0xFFU << CNTL_CSV_SHIFT)
 
@@ -35,6 +37,8 @@
 #define EVENT_CYCLES_COUNTER	0
 #define NUM_COUNTERS		4
 
+/* For removing bias if cycle counter CNTL.CP is set to 0xf0 */
+#define CYCLES_COUNTER_MASK	0x0FFFFFFF
 #define AXI_MASKING_REVERT	0xffff0000	/* AXI_MASKING(MSB 16bits) + AXI_ID(LSB 16bits) */
 
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
@@ -429,6 +433,17 @@ static void ddr_perf_counter_enable(struct ddr_pmu *pmu, int config,
 		writel(0, pmu->base + reg);
 		val = CNTL_EN | CNTL_CLEAR;
 		val |= FIELD_PREP(CNTL_CSV_MASK, config);
+
+		/*
+		 * On i.MX8MP we need to bias the cycle counter to overflow more often.
+		 * We do this by initializing bits [23:16] of the counter value via the
+		 * COUNTER_CTRL Counter Parameter (CP) field.
+		 */
+		if (pmu->devtype_data->quirks & DDR_CAP_AXI_ID_FILTER_ENHANCED) {
+			if (counter == EVENT_CYCLES_COUNTER)
+				val |= FIELD_PREP(CNTL_CP_MASK, 0xf0);
+		}
+
 		writel(val, pmu->base + reg);
 	} else {
 		/* Disable counter */
@@ -468,6 +483,12 @@ static void ddr_perf_event_update(struct perf_event *event)
 	int ret;
 
 	new_raw_count = ddr_perf_read_counter(pmu, counter);
+	/* Remove the bias applied in ddr_perf_counter_enable(). */
+	if (pmu->devtype_data->quirks & DDR_CAP_AXI_ID_FILTER_ENHANCED) {
+		if (counter == EVENT_CYCLES_COUNTER)
+			new_raw_count &= CYCLES_COUNTER_MASK;
+	}
+
 	local64_add(new_raw_count, &event->count);
 
 	/*
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 560b2504e674..a15ad76aee21 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -6058,7 +6058,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 					    phba->hba_debugfs_root,
 					    phba,
 					    &lpfc_debugfs_op_multixripools);
-		if (!phba->debug_multixri_pools) {
+		if (IS_ERR(phba->debug_multixri_pools)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "0527 Cannot create debugfs multixripools\n");
 			goto debug_failed;
@@ -6070,7 +6070,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_cgn_buffer_op);
-		if (!phba->debug_cgn_buffer) {
+		if (IS_ERR(phba->debug_cgn_buffer)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6527 Cannot create debugfs "
 					 "cgn_buffer\n");
@@ -6083,7 +6083,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_rx_monitor_op);
-		if (!phba->debug_rx_monitor) {
+		if (IS_ERR(phba->debug_rx_monitor)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6528 Cannot create debugfs "
 					 "rx_monitor\n");
@@ -6096,7 +6096,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_ras_log);
-		if (!phba->debug_ras_log) {
+		if (IS_ERR(phba->debug_ras_log)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6148 Cannot create debugfs"
 					 " ras_log\n");
@@ -6117,7 +6117,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_op_lockstat);
-		if (!phba->debug_lockstat) {
+		if (IS_ERR(phba->debug_lockstat)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "4610 Can't create debugfs lockstat\n");
 			goto debug_failed;
@@ -6346,7 +6346,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_scsistat);
-	if (!vport->debug_scsistat) {
+	if (IS_ERR(vport->debug_scsistat)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "4611 Cannot create debugfs scsistat\n");
 		goto debug_failed;
@@ -6357,7 +6357,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_ioktime);
-	if (!vport->debug_ioktime) {
+	if (IS_ERR(vport->debug_ioktime)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "0815 Cannot create debugfs ioktime\n");
 		goto debug_failed;
diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 02d7ab119f80..acc14568bef5 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2330,7 +2330,7 @@ struct megasas_instance {
 	u32 support_morethan256jbod; /* FW support for more than 256 PD/JBOD */
 	bool use_seqnum_jbod_fp;   /* Added for PD sequence */
 	bool smp_affinity_enable;
-	spinlock_t crashdump_lock;
+	struct mutex crashdump_lock;
 
 	struct megasas_register_set __iomem *reg_set;
 	u32 __iomem *reply_post_host_index_addr[MR_MAX_MSIX_REG_ARRAY];
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index f7da1876e7a3..00b8b7a85388 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3275,14 +3275,13 @@ fw_crash_buffer_store(struct device *cdev,
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
 
@@ -3297,24 +3296,23 @@ fw_crash_buffer_show(struct device *cdev,
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
 
@@ -3326,7 +3324,7 @@ fw_crash_buffer_show(struct device *cdev,
 	src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
 		(buff_offset % dmachunk);
 	memcpy(buf, (void *)src_addr, size);
-	spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+	mutex_unlock(&instance->crashdump_lock);
 
 	return size;
 }
@@ -3351,7 +3349,6 @@ fw_crash_state_store(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 	int val = 0;
-	unsigned long flags;
 
 	if (kstrtoint(buf, 0, &val) != 0)
 		return -EINVAL;
@@ -3365,9 +3362,9 @@ fw_crash_state_store(struct device *cdev,
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
@@ -7432,7 +7429,7 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	init_waitqueue_head(&instance->int_cmd_wait_q);
 	init_waitqueue_head(&instance->abort_cmd_wait_q);
 
-	spin_lock_init(&instance->crashdump_lock);
+	mutex_init(&instance->crashdump_lock);
 	spin_lock_init(&instance->mfi_pool_lock);
 	spin_lock_init(&instance->hba_lock);
 	spin_lock_init(&instance->stream_lock);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index a25a34535b7a..a54460fe8630 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -255,7 +255,6 @@ static irqreturn_t pm8001_interrupt_handler_intx(int irq, void *dev_id)
 	return ret;
 }
 
-static u32 pm8001_setup_irq(struct pm8001_hba_info *pm8001_ha);
 static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha);
 
 /**
@@ -276,13 +275,6 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
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
@@ -1002,47 +994,38 @@ static u32 pm8001_request_msix(struct pm8001_hba_info *pm8001_ha)
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
index aa9d69e5274d..af921fd150d1 100644
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
@@ -615,14 +615,14 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
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
index f4a24fa5058e..df399110fbf1 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -507,102 +507,102 @@ static ssize_t lio_target_nacl_info_show(struct config_item *item, char *page)
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
index db07d6a5d764..2335edd51684 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1276,19 +1276,14 @@ static void cpm_uart_console_write(struct console *co, const char *s,
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
diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 4d0f027e5bd3..9cb647203dcf 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -256,9 +256,10 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
 	cdns3_set_platform_suspend(cdns->dev, false, false);
 
 	spin_lock_irqsave(&cdns->lock, flags);
-	cdns_resume(cdns, !PMSG_IS_AUTO(msg));
+	cdns_resume(cdns);
 	cdns->in_lpm = false;
 	spin_unlock_irqrestore(&cdns->lock, flags);
+	cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
 	if (cdns->wakeup_pending) {
 		cdns->wakeup_pending = false;
 		enable_irq(cdns->wakeup_irq);
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 29f433c5a6f3..a85db23fa19f 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -210,8 +210,9 @@ static int __maybe_unused cdnsp_pci_resume(struct device *dev)
 	int ret;
 
 	spin_lock_irqsave(&cdns->lock, flags);
-	ret = cdns_resume(cdns, 1);
+	ret = cdns_resume(cdns);
 	spin_unlock_irqrestore(&cdns->lock, flags);
+	cdns_set_active(cdns, 1);
 
 	return ret;
 }
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index dbcdf3b24b47..7b20d2d5c262 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -522,9 +522,8 @@ int cdns_suspend(struct cdns *cdns)
 }
 EXPORT_SYMBOL_GPL(cdns_suspend);
 
-int cdns_resume(struct cdns *cdns, u8 set_active)
+int cdns_resume(struct cdns *cdns)
 {
-	struct device *dev = cdns->dev;
 	enum usb_role real_role;
 	bool role_changed = false;
 	int ret = 0;
@@ -556,15 +555,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
 	if (cdns->roles[cdns->role]->resume)
 		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdns_resume);
+
+void cdns_set_active(struct cdns *cdns, u8 set_active)
+{
+	struct device *dev = cdns->dev;
+
 	if (set_active) {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
 	}
 
-	return 0;
+	return;
 }
-EXPORT_SYMBOL_GPL(cdns_resume);
+EXPORT_SYMBOL_GPL(cdns_set_active);
 #endif /* CONFIG_PM_SLEEP */
 
 MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index ab0cb68acd23..1b6631cdf5de 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -125,10 +125,13 @@ int cdns_init(struct cdns *cdns);
 int cdns_remove(struct cdns *cdns);
 
 #ifdef CONFIG_PM_SLEEP
-int cdns_resume(struct cdns *cdns, u8 set_active);
+int cdns_resume(struct cdns *cdns);
 int cdns_suspend(struct cdns *cdns);
+void cdns_set_active(struct cdns *cdns, u8 set_active);
 #else /* CONFIG_PM_SLEEP */
-static inline int cdns_resume(struct cdns *cdns, u8 set_active)
+static inline int cdns_resume(struct cdns *cdns)
+{ return 0; }
+static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
 { return 0; }
 static inline int cdns_suspend(struct cdns *cdns)
 { return 0; }
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 15db7a3868fe..8bf767a80dd4 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1956,9 +1956,13 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
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
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 144080321629..02044d45edde 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -755,10 +755,14 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 
 	/* normal [4.15.1.2] or error [4.15.1.1] completion */
 	if (likely ((status & (STS_INT|STS_ERR)) != 0)) {
-		if (likely ((status & STS_ERR) == 0))
+		if (likely ((status & STS_ERR) == 0)) {
 			INCR(ehci->stats.normal);
-		else
+		} else {
+			/* Force to check port status */
+			if (ehci->has_ci_pec_bug)
+				status |= STS_PCD;
 			INCR(ehci->stats.error);
+		}
 		bh = 1;
 	}
 
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index c4f6a2559a98..0350c03dc97a 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -674,7 +674,8 @@ ehci_hub_status_data (struct usb_hcd *hcd, char *buf)
 
 		if ((temp & mask) != 0 || test_bit(i, &ehci->port_c_suspend)
 				|| (ehci->reset_done[i] && time_after_eq(
-					jiffies, ehci->reset_done[i]))) {
+					jiffies, ehci->reset_done[i]))
+				|| ehci_has_ci_pec_bug(ehci, temp)) {
 			if (i < 7)
 			    buf [0] |= 1 << (i + 1);
 			else
@@ -874,6 +875,13 @@ int ehci_hub_control(
 		if (temp & PORT_PEC)
 			status |= USB_PORT_STAT_C_ENABLE << 16;
 
+		if (ehci_has_ci_pec_bug(ehci, temp)) {
+			status |= USB_PORT_STAT_C_ENABLE << 16;
+			ehci_info(ehci,
+				"PE is cleared by HW port:%d PORTSC:%08x\n",
+				wIndex + 1, temp);
+		}
+
 		if ((temp & PORT_OCC) && (!ignore_oc && !ehci->spurious_oc)){
 			status |= USB_PORT_STAT_C_OVERCURRENT << 16;
 
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index fdd073cc053b..9888ca5f5f36 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -207,6 +207,7 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		has_fsl_port_bug:1; /* FreeScale */
 	unsigned		has_fsl_hs_errata:1;	/* Freescale HS quirk */
 	unsigned		has_fsl_susp_errata:1;	/* NXP SUSP quirk */
+	unsigned		has_ci_pec_bug:1;	/* ChipIdea PEC bug */
 	unsigned		big_endian_mmio:1;
 	unsigned		big_endian_desc:1;
 	unsigned		big_endian_capbase:1;
@@ -706,6 +707,15 @@ ehci_port_speed(struct ehci_hcd *ehci, unsigned int portsc)
  */
 #define ehci_has_fsl_susp_errata(e)	((e)->has_fsl_susp_errata)
 
+/*
+ * Some Freescale/NXP processors using ChipIdea IP have a bug in which
+ * disabling the port (PE is cleared) does not cause PEC to be asserted
+ * when frame babble is detected.
+ */
+#define ehci_has_ci_pec_bug(e, portsc) \
+	((e)->has_ci_pec_bug && ((e)->command & CMD_PSE) \
+	 && !(portsc & PORT_PEC) && !(portsc & PORT_PE))
+
 /*
  * While most USB host controllers implement their registers in
  * little-endian format, a minority (celleb companion chip) implement
diff --git a/fs/attr.c b/fs/attr.c
index 28e953e86960..786d358dd699 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -402,9 +402,25 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return error;
 
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
index 54c1f8b8b075..efdc76732fae 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -32,8 +32,9 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name.name - wq->offset);
 		wq->name.name = NULL;
-		wq->wait_ctr--;
 		wake_up_interruptible(&wq->queue);
+		if (!--wq->wait_ctr)
+			kfree(wq);
 		wq = nwq;
 	}
 	fput(sbi->pipe);	/* Close the pipe */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 02d3ee6c7d9b..1467bf439cb4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -536,8 +536,6 @@ struct btrfs_swapfile_pin {
 	int bg_extent_count;
 };
 
-bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
-
 enum {
 	BTRFS_FS_BARRIER,
 	BTRFS_FS_CLOSING_START,
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1e08eb2b27f0..e6872d65c0e2 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1083,20 +1083,33 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
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
index 6e0fdfd98f23..f0654fe80b34 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2605,13 +2605,11 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
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
index 597cc2607481..48f2de789b75 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -860,6 +860,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
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
index c9b3d99171b2..33f4557d1a68 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2526,6 +2526,13 @@ static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
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
@@ -2546,7 +2553,6 @@ static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
 				goto out_put;
 			}
 
-			btrfs_release_path(path);
 			key.objectid = key.offset;
 			key.offset = (u64)-1;
 			dirid = key.objectid;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0e9236a745b8..56ea2ec26436 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -709,6 +709,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
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
index b49fa784e5ba..eb91d6eb78ce 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -622,4 +622,7 @@ const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
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
index d44fe5b1a725..14c977e1e4bb 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -343,17 +343,17 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
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
@@ -364,7 +364,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 #endif
 
 	if (t->det_reserved_zero1 ||
-	    le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
+	    (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=
+	     sizeof(struct ext4_dir_entry_tail)) ||
 	    t->det_reserved_zero2 ||
 	    t->det_reserved_ft != EXT4_FT_DIR_CSUM)
 		return NULL;
@@ -445,13 +446,14 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
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
@@ -1315,6 +1317,7 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 	unsigned int buflen = bh->b_size;
 	char *base = bh->b_data;
 	struct dx_hash_info h = *hinfo;
+	int blocksize = EXT4_BLOCK_SIZE(dir->i_sb);
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		buflen -= sizeof(struct ext4_dir_entry_tail);
@@ -1335,11 +1338,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
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
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 95d5bb7d825a..f033ac807013 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -165,7 +165,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	tid_t			this_tid;
 	int			result, batch_count = 0;
 
-	jbd_debug(1, "Start checkpoint\n");
+	jbd2_debug(1, "Start checkpoint\n");
 
 	/*
 	 * First thing: if there are any transactions in the log which
@@ -174,7 +174,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	 */
 	result = jbd2_cleanup_journal_tail(journal);
 	trace_jbd2_checkpoint(journal, result);
-	jbd_debug(1, "cleanup_journal_tail returned %d\n", result);
+	jbd2_debug(1, "cleanup_journal_tail returned %d\n", result);
 	if (result <= 0)
 		return result;
 
@@ -725,5 +725,5 @@ void __jbd2_journal_drop_transaction(journal_t *journal, transaction_t *transact
 
 	trace_jbd2_drop_transaction(journal, transaction);
 
-	jbd_debug(1, "Dropping transaction %d, all done\n", transaction->t_tid);
+	jbd2_debug(1, "Dropping transaction %d, all done\n", transaction->t_tid);
 }
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 20294c1bbeab..e058ef183937 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -419,7 +419,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	/* Do we need to erase the effects of a prior jbd2_journal_flush? */
 	if (journal->j_flags & JBD2_FLUSHED) {
-		jbd_debug(3, "super block updated\n");
+		jbd2_debug(3, "super block updated\n");
 		mutex_lock_io(&journal->j_checkpoint_mutex);
 		/*
 		 * We hold j_checkpoint_mutex so tail cannot change under us.
@@ -433,7 +433,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 						REQ_SYNC);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	} else {
-		jbd_debug(3, "superblock not updated\n");
+		jbd2_debug(3, "superblock not updated\n");
 	}
 
 	J_ASSERT(journal->j_running_transaction != NULL);
@@ -465,7 +465,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	commit_transaction = journal->j_running_transaction;
 
 	trace_jbd2_start_commit(journal, commit_transaction);
-	jbd_debug(1, "JBD2: starting commit of transaction %d\n",
+	jbd2_debug(1, "JBD2: starting commit of transaction %d\n",
 			commit_transaction->t_tid);
 
 	write_lock(&journal->j_state_lock);
@@ -484,22 +484,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	stats.run.rs_running = jbd2_time_diff(commit_transaction->t_start,
 					      stats.run.rs_locked);
 
-	spin_lock(&commit_transaction->t_handle_lock);
-	while (atomic_read(&commit_transaction->t_updates)) {
-		DEFINE_WAIT(wait);
+	// waits for any t_updates to finish
+	jbd2_journal_wait_updates(journal);
 
-		prepare_to_wait(&journal->j_wait_updates, &wait,
-					TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&commit_transaction->t_updates)) {
-			spin_unlock(&commit_transaction->t_handle_lock);
-			write_unlock(&journal->j_state_lock);
-			schedule();
-			write_lock(&journal->j_state_lock);
-			spin_lock(&commit_transaction->t_handle_lock);
-		}
-		finish_wait(&journal->j_wait_updates, &wait);
-	}
-	spin_unlock(&commit_transaction->t_handle_lock);
 	commit_transaction->t_state = T_SWITCH;
 
 	J_ASSERT (atomic_read(&commit_transaction->t_outstanding_credits) <=
@@ -551,7 +538,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	__jbd2_journal_clean_checkpoint_list(journal, false);
 	spin_unlock(&journal->j_list_lock);
 
-	jbd_debug(3, "JBD2: commit phase 1\n");
+	jbd2_debug(3, "JBD2: commit phase 1\n");
 
 	/*
 	 * Clear revoked flag to reflect there is no revoked buffers
@@ -584,7 +571,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	wake_up_all(&journal->j_wait_transaction_locked);
 	write_unlock(&journal->j_state_lock);
 
-	jbd_debug(3, "JBD2: commit phase 2a\n");
+	jbd2_debug(3, "JBD2: commit phase 2a\n");
 
 	/*
 	 * Now start flushing things to disk, in the order they appear
@@ -597,7 +584,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	blk_start_plug(&plug);
 	jbd2_journal_write_revoke_records(commit_transaction, &log_bufs);
 
-	jbd_debug(3, "JBD2: commit phase 2b\n");
+	jbd2_debug(3, "JBD2: commit phase 2b\n");
 
 	/*
 	 * Way to go: we have now written out all of the data for a
@@ -653,7 +640,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (!descriptor) {
 			J_ASSERT (bufs == 0);
 
-			jbd_debug(4, "JBD2: get descriptor\n");
+			jbd2_debug(4, "JBD2: get descriptor\n");
 
 			descriptor = jbd2_journal_get_descriptor_buffer(
 							commit_transaction,
@@ -663,7 +650,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				continue;
 			}
 
-			jbd_debug(4, "JBD2: got buffer %llu (%p)\n",
+			jbd2_debug(4, "JBD2: got buffer %llu (%p)\n",
 				(unsigned long long)descriptor->b_blocknr,
 				descriptor->b_data);
 			tagp = &descriptor->b_data[sizeof(journal_header_t)];
@@ -748,7 +735,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		    commit_transaction->t_buffers == NULL ||
 		    space_left < tag_bytes + 16 + csum_size) {
 
-			jbd_debug(4, "JBD2: Submit %d IOs\n", bufs);
+			jbd2_debug(4, "JBD2: Submit %d IOs\n", bufs);
 
 			/* Write an end-of-descriptor marker before
                            submitting the IOs.  "tag" still points to
@@ -819,7 +806,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	commit_transaction->t_state = T_COMMIT_DFLUSH;
 	write_unlock(&journal->j_state_lock);
 
-	/* 
+	/*
 	 * If the journal is not located on the file system device,
 	 * then we must flush the file system device before we issue
 	 * the commit record
@@ -850,7 +837,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	   so we incur less scheduling load.
 	*/
 
-	jbd_debug(3, "JBD2: commit phase 3\n");
+	jbd2_debug(3, "JBD2: commit phase 3\n");
 
 	while (!list_empty(&io_bufs)) {
 		struct buffer_head *bh = list_entry(io_bufs.prev,
@@ -893,7 +880,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	J_ASSERT (commit_transaction->t_shadow_list == NULL);
 
-	jbd_debug(3, "JBD2: commit phase 4\n");
+	jbd2_debug(3, "JBD2: commit phase 4\n");
 
 	/* Here we wait for the revoke record and descriptor record buffers */
 	while (!list_empty(&log_bufs)) {
@@ -917,7 +904,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	if (err)
 		jbd2_journal_abort(journal, err);
 
-	jbd_debug(3, "JBD2: commit phase 5\n");
+	jbd2_debug(3, "JBD2: commit phase 5\n");
 	write_lock(&journal->j_state_lock);
 	J_ASSERT(commit_transaction->t_state == T_COMMIT_DFLUSH);
 	commit_transaction->t_state = T_COMMIT_JFLUSH;
@@ -956,7 +943,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
            transaction can be removed from any checkpoint list it was on
            before. */
 
-	jbd_debug(3, "JBD2: commit phase 6\n");
+	jbd2_debug(3, "JBD2: commit phase 6\n");
 
 	J_ASSERT(list_empty(&commit_transaction->t_inode_list));
 	J_ASSERT(commit_transaction->t_buffers == NULL);
@@ -1133,7 +1120,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	/* Done with this transaction! */
 
-	jbd_debug(3, "JBD2: commit phase 7\n");
+	jbd2_debug(3, "JBD2: commit phase 7\n");
 
 	J_ASSERT(commit_transaction->t_state == T_COMMIT_JFLUSH);
 
@@ -1175,7 +1162,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		journal->j_fc_cleanup_callback(journal, 1, commit_transaction->t_tid);
 
 	trace_jbd2_end_commit(journal, commit_transaction);
-	jbd_debug(1, "JBD2: commit %d complete, head %d\n",
+	jbd2_debug(1, "JBD2: commit %d complete, head %d\n",
 		  journal->j_commit_sequence, journal->j_tail_sequence);
 
 	write_lock(&journal->j_state_lock);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 580d2fdfe21f..11fbc9b6ec5c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -203,11 +203,11 @@ static int kjournald2(void *arg)
 	if (journal->j_flags & JBD2_UNMOUNT)
 		goto end_loop;
 
-	jbd_debug(1, "commit_sequence=%u, commit_request=%u\n",
+	jbd2_debug(1, "commit_sequence=%u, commit_request=%u\n",
 		journal->j_commit_sequence, journal->j_commit_request);
 
 	if (journal->j_commit_sequence != journal->j_commit_request) {
-		jbd_debug(1, "OK, requests differ\n");
+		jbd2_debug(1, "OK, requests differ\n");
 		write_unlock(&journal->j_state_lock);
 		del_timer_sync(&journal->j_commit_timer);
 		jbd2_journal_commit_transaction(journal);
@@ -222,7 +222,7 @@ static int kjournald2(void *arg)
 		 * good idea, because that depends on threads that may
 		 * be already stopped.
 		 */
-		jbd_debug(1, "Now suspending kjournald2\n");
+		jbd2_debug(1, "Now suspending kjournald2\n");
 		write_unlock(&journal->j_state_lock);
 		try_to_freeze();
 		write_lock(&journal->j_state_lock);
@@ -252,7 +252,7 @@ static int kjournald2(void *arg)
 		finish_wait(&journal->j_wait_commit, &wait);
 	}
 
-	jbd_debug(1, "kjournald2 wakes\n");
+	jbd2_debug(1, "kjournald2 wakes\n");
 
 	/*
 	 * Were we woken up by a commit wakeup event?
@@ -260,7 +260,7 @@ static int kjournald2(void *arg)
 	transaction = journal->j_running_transaction;
 	if (transaction && time_after_eq(jiffies, transaction->t_expires)) {
 		journal->j_commit_request = transaction->t_tid;
-		jbd_debug(1, "woke because of timeout\n");
+		jbd2_debug(1, "woke because of timeout\n");
 	}
 	goto loop;
 
@@ -268,7 +268,7 @@ static int kjournald2(void *arg)
 	del_timer_sync(&journal->j_commit_timer);
 	journal->j_task = NULL;
 	wake_up(&journal->j_wait_done_commit);
-	jbd_debug(1, "Journal thread exiting.\n");
+	jbd2_debug(1, "Journal thread exiting.\n");
 	write_unlock(&journal->j_state_lock);
 	return 0;
 }
@@ -500,7 +500,7 @@ int __jbd2_log_start_commit(journal_t *journal, tid_t target)
 		 */
 
 		journal->j_commit_request = target;
-		jbd_debug(1, "JBD2: requesting commit %u/%u\n",
+		jbd2_debug(1, "JBD2: requesting commit %u/%u\n",
 			  journal->j_commit_request,
 			  journal->j_commit_sequence);
 		journal->j_running_transaction->t_requested = jiffies;
@@ -705,7 +705,7 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	}
 #endif
 	while (tid_gt(tid, journal->j_commit_sequence)) {
-		jbd_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
+		jbd2_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
 				  tid, journal->j_commit_sequence);
 		read_unlock(&journal->j_state_lock);
 		wake_up(&journal->j_wait_commit);
@@ -1123,7 +1123,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 		freed += journal->j_last - journal->j_first;
 
 	trace_jbd2_update_log_tail(journal, tid, block, freed);
-	jbd_debug(1,
+	jbd2_debug(1,
 		  "Cleaning journal tail from %u to %u (offset %lu), "
 		  "freeing %lu\n",
 		  journal->j_tail_sequence, tid, block, freed);
@@ -1498,7 +1498,7 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		return NULL;
 	}
 
-	jbd_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
+	jbd2_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
 		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
@@ -1577,7 +1577,7 @@ static int journal_reset(journal_t *journal)
 	 * attempting a write to a potential-readonly device.
 	 */
 	if (sb->s_start == 0) {
-		jbd_debug(1, "JBD2: Skipping superblock update on recovered sb "
+		jbd2_debug(1, "JBD2: Skipping superblock update on recovered sb "
 			"(start %ld, seq %u, errno %d)\n",
 			journal->j_tail, journal->j_tail_sequence,
 			journal->j_errno);
@@ -1680,7 +1680,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 	}
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
-	jbd_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
+	jbd2_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
 		  tail_block, tail_tid);
 
 	lock_buffer(journal->j_sb_buffer);
@@ -1721,7 +1721,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 		return;
 	}
 
-	jbd_debug(1, "JBD2: Marking journal as empty (seq %u)\n",
+	jbd2_debug(1, "JBD2: Marking journal as empty (seq %u)\n",
 		  journal->j_tail_sequence);
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
@@ -1867,7 +1867,7 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 	errcode = journal->j_errno;
 	if (errcode == -ESHUTDOWN)
 		errcode = 0;
-	jbd_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
+	jbd2_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
 	sb->s_errno    = cpu_to_be32(errcode);
 
 	jbd2_write_superblock(journal, REQ_SYNC | REQ_FUA);
@@ -2339,7 +2339,7 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 	    compat & JBD2_FEATURE_COMPAT_CHECKSUM)
 		compat &= ~JBD2_FEATURE_COMPAT_CHECKSUM;
 
-	jbd_debug(1, "Setting new features 0x%lx/0x%lx/0x%lx\n",
+	jbd2_debug(1, "Setting new features 0x%lx/0x%lx/0x%lx\n",
 		  compat, ro, incompat);
 
 	sb = journal->j_superblock;
@@ -2408,7 +2408,7 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
 {
 	journal_superblock_t *sb;
 
-	jbd_debug(1, "Clear features 0x%lx/0x%lx/0x%lx\n",
+	jbd2_debug(1, "Clear features 0x%lx/0x%lx/0x%lx\n",
 		  compat, ro, incompat);
 
 	sb = journal->j_superblock;
@@ -2865,7 +2865,7 @@ static struct journal_head *journal_alloc_journal_head(void)
 #endif
 	ret = kmem_cache_zalloc(jbd2_journal_head_cache, GFP_NOFS);
 	if (!ret) {
-		jbd_debug(1, "out of memory for journal_head\n");
+		jbd2_debug(1, "out of memory for journal_head\n");
 		pr_notice_ratelimited("ENOMEM in %s, retrying.\n", __func__);
 		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
 				GFP_NOFS | __GFP_NOFAIL);
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 3c5dd010e39d..cce36a76fd02 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -224,12 +224,8 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 /* Make sure we wrap around the log correctly! */
 #define wrap(journal, var)						\
 do {									\
-	unsigned long _wrap_last =					\
-		jbd2_has_feature_fast_commit(journal) ?			\
-			(journal)->j_fc_last : (journal)->j_last;	\
-									\
-	if (var >= _wrap_last)						\
-		var -= (_wrap_last - (journal)->j_first);		\
+	if (var >= (journal)->j_last)					\
+		var -= ((journal)->j_last - (journal)->j_first);	\
 } while (0)
 
 static int fc_do_one_pass(journal_t *journal,
@@ -245,11 +241,11 @@ static int fc_do_one_pass(journal_t *journal,
 		return 0;
 
 	while (next_fc_block <= journal->j_fc_last) {
-		jbd_debug(3, "Fast commit replay: next block %ld\n",
+		jbd2_debug(3, "Fast commit replay: next block %ld\n",
 			  next_fc_block);
 		err = jread(&bh, journal, next_fc_block);
 		if (err) {
-			jbd_debug(3, "Fast commit replay: read error\n");
+			jbd2_debug(3, "Fast commit replay: read error\n");
 			break;
 		}
 
@@ -264,7 +260,7 @@ static int fc_do_one_pass(journal_t *journal,
 	}
 
 	if (err)
-		jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
+		jbd2_debug(3, "Fast commit replay failed, err = %d\n", err);
 
 	return err;
 }
@@ -298,7 +294,7 @@ int jbd2_journal_recover(journal_t *journal)
 	 */
 
 	if (!sb->s_start) {
-		jbd_debug(1, "No recovery required, last transaction %d\n",
+		jbd2_debug(1, "No recovery required, last transaction %d\n",
 			  be32_to_cpu(sb->s_sequence));
 		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
 		return 0;
@@ -310,10 +306,10 @@ int jbd2_journal_recover(journal_t *journal)
 	if (!err)
 		err = do_one_pass(journal, &info, PASS_REPLAY);
 
-	jbd_debug(1, "JBD2: recovery, exit status %d, "
+	jbd2_debug(1, "JBD2: recovery, exit status %d, "
 		  "recovered transactions %u to %u\n",
 		  err, info.start_transaction, info.end_transaction);
-	jbd_debug(1, "JBD2: Replayed %d and revoked %d/%d blocks\n",
+	jbd2_debug(1, "JBD2: Replayed %d and revoked %d/%d blocks\n",
 		  info.nr_replays, info.nr_revoke_hits, info.nr_revokes);
 
 	/* Restart the log at the next transaction ID, thus invalidating
@@ -363,7 +359,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 #ifdef CONFIG_JBD2_DEBUG
 		int dropped = info.end_transaction - 
 			be32_to_cpu(journal->j_superblock->s_sequence);
-		jbd_debug(1,
+		jbd2_debug(1,
 			  "JBD2: ignoring %d transaction%s from the journal.\n",
 			  dropped, (dropped == 1) ? "" : "s");
 #endif
@@ -485,7 +481,7 @@ static int do_one_pass(journal_t *journal,
 	if (pass == PASS_SCAN)
 		info->start_transaction = first_commit_ID;
 
-	jbd_debug(1, "Starting recovery pass %d\n", pass);
+	jbd2_debug(1, "Starting recovery pass %d\n", pass);
 
 	/*
 	 * Now we walk through the log, transaction by transaction,
@@ -511,16 +507,14 @@ static int do_one_pass(journal_t *journal,
 			if (tid_geq(next_commit_ID, info->end_transaction))
 				break;
 
-		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block,
-			  jbd2_has_feature_fast_commit(journal) ?
-			  journal->j_fc_last : journal->j_last);
+		jbd2_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
+			  next_commit_ID, next_log_block, journal->j_last);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
 		 * record. */
 
-		jbd_debug(3, "JBD2: checking block %ld\n", next_log_block);
+		jbd2_debug(3, "JBD2: checking block %ld\n", next_log_block);
 		err = jread(&bh, journal, next_log_block);
 		if (err)
 			goto failed;
@@ -543,7 +537,7 @@ static int do_one_pass(journal_t *journal,
 
 		blocktype = be32_to_cpu(tmp->h_blocktype);
 		sequence = be32_to_cpu(tmp->h_sequence);
-		jbd_debug(3, "Found magic %d, sequence %d\n",
+		jbd2_debug(3, "Found magic %d, sequence %d\n",
 			  blocktype, sequence);
 
 		if (sequence != next_commit_ID) {
@@ -576,7 +570,7 @@ static int do_one_pass(journal_t *journal,
 					goto failed;
 				}
 				need_check_commit_time = true;
-				jbd_debug(1,
+				jbd2_debug(1,
 					"invalid descriptor block found in %lu\n",
 					next_log_block);
 			}
@@ -759,7 +753,7 @@ static int do_one_pass(journal_t *journal,
 				 * It likely does not belong to same journal,
 				 * just end this recovery with success.
 				 */
-				jbd_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
+				jbd2_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
 					  next_commit_ID);
 				brelse(bh);
 				goto done;
@@ -827,7 +821,7 @@ static int do_one_pass(journal_t *journal,
 			if (pass == PASS_SCAN &&
 			    !jbd2_descriptor_block_csum_verify(journal,
 							       bh->b_data)) {
-				jbd_debug(1, "JBD2: invalid revoke block found in %lu\n",
+				jbd2_debug(1, "JBD2: invalid revoke block found in %lu\n",
 					  next_log_block);
 				need_check_commit_time = true;
 			}
@@ -846,7 +840,7 @@ static int do_one_pass(journal_t *journal,
 			continue;
 
 		default:
-			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
+			jbd2_debug(3, "Unrecognised magic %d, end of scan.\n",
 				  blocktype);
 			brelse(bh);
 			goto done;
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index fa608788b93d..4556e4689024 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -398,7 +398,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 	}
 	handle->h_revoke_credits--;
 
-	jbd_debug(2, "insert revoke for block %llu, bh_in=%p\n",blocknr, bh_in);
+	jbd2_debug(2, "insert revoke for block %llu, bh_in=%p\n",blocknr, bh_in);
 	err = insert_revoke_hash(journal, blocknr,
 				handle->h_transaction->t_tid);
 	BUFFER_TRACE(bh_in, "exit");
@@ -428,7 +428,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	int did_revoke = 0;	/* akpm: debug */
 	struct buffer_head *bh = jh2bh(jh);
 
-	jbd_debug(4, "journal_head %p, cancelling revoke\n", jh);
+	jbd2_debug(4, "journal_head %p, cancelling revoke\n", jh);
 
 	/* Is the existing Revoke bit valid?  If so, we trust it, and
 	 * only perform the full cancel if the revoke bit is set.  If
@@ -444,7 +444,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	if (need_cancel) {
 		record = find_revoke_record(journal, bh->b_blocknr);
 		if (record) {
-			jbd_debug(4, "cancelled existing revoke on "
+			jbd2_debug(4, "cancelled existing revoke on "
 				  "blocknr %llu\n", (unsigned long long)bh->b_blocknr);
 			spin_lock(&journal->j_revoke_lock);
 			list_del(&record->hash);
@@ -560,7 +560,7 @@ void jbd2_journal_write_revoke_records(transaction_t *transaction,
 	}
 	if (descriptor)
 		flush_descriptor(journal, descriptor, offset);
-	jbd_debug(1, "Wrote %d revoke records\n", count);
+	jbd2_debug(1, "Wrote %d revoke records\n", count);
 }
 
 /*
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 62e68c5b8ec3..c2125203ef2d 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -107,7 +107,6 @@ static void jbd2_get_transaction(journal_t *journal,
 	transaction->t_start_time = ktime_get();
 	transaction->t_tid = journal->j_transaction_sequence++;
 	transaction->t_expires = jiffies + journal->j_commit_interval;
-	spin_lock_init(&transaction->t_handle_lock);
 	atomic_set(&transaction->t_updates, 0);
 	atomic_set(&transaction->t_outstanding_credits,
 		   jbd2_descriptor_blocks_per_trans(journal) +
@@ -139,24 +138,21 @@ static void jbd2_get_transaction(journal_t *journal,
 /*
  * Update transaction's maximum wait time, if debugging is enabled.
  *
- * In order for t_max_wait to be reliable, it must be protected by a
- * lock.  But doing so will mean that start_this_handle() can not be
- * run in parallel on SMP systems, which limits our scalability.  So
- * unless debugging is enabled, we no longer update t_max_wait, which
- * means that maximum wait time reported by the jbd2_run_stats
- * tracepoint will always be zero.
+ * t_max_wait is carefully updated here with use of atomic compare exchange.
+ * Note that there could be multiplre threads trying to do this simultaneously
+ * hence using cmpxchg to avoid any use of locks in this case.
  */
 static inline void update_t_max_wait(transaction_t *transaction,
 				     unsigned long ts)
 {
 #ifdef CONFIG_JBD2_DEBUG
+	unsigned long oldts, newts;
 	if (jbd2_journal_enable_debug &&
 	    time_after(transaction->t_start, ts)) {
-		ts = jbd2_time_diff(ts, transaction->t_start);
-		spin_lock(&transaction->t_handle_lock);
-		if (ts > transaction->t_max_wait)
-			transaction->t_max_wait = ts;
-		spin_unlock(&transaction->t_handle_lock);
+		newts = jbd2_time_diff(ts, transaction->t_start);
+		oldts = READ_ONCE(transaction->t_max_wait);
+		while (oldts < newts)
+			oldts = cmpxchg(&transaction->t_max_wait, oldts, newts);
 	}
 #endif
 }
@@ -378,7 +374,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 			return -ENOMEM;
 	}
 
-	jbd_debug(3, "New handle %p going live.\n", handle);
+	jbd2_debug(3, "New handle %p going live.\n", handle);
 
 	/*
 	 * We need to hold j_state_lock until t_updates has been incremented,
@@ -449,7 +445,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	}
 
 	/* OK, account for the buffers that this operation expects to
-	 * use and add the handle to the running transaction. 
+	 * use and add the handle to the running transaction.
 	 */
 	update_t_max_wait(transaction, ts);
 	handle->h_transaction = transaction;
@@ -458,7 +454,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	handle->h_start_jiffies = jiffies;
 	atomic_inc(&transaction->t_updates);
 	atomic_inc(&transaction->t_handle_count);
-	jbd_debug(4, "Handle %p given %d credits (total %d, free %lu)\n",
+	jbd2_debug(4, "Handle %p given %d credits (total %d, free %lu)\n",
 		  handle, blocks,
 		  atomic_read(&transaction->t_outstanding_credits),
 		  jbd2_log_space_left(journal));
@@ -679,7 +675,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 
 	/* Don't extend a locked-down transaction! */
 	if (transaction->t_state != T_RUNNING) {
-		jbd_debug(3, "denied handle %p %d blocks: "
+		jbd2_debug(3, "denied handle %p %d blocks: "
 			  "transaction not running\n", handle, nblocks);
 		goto error_out;
 	}
@@ -690,15 +686,14 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 		DIV_ROUND_UP(
 			handle->h_revoke_credits_requested,
 			journal->j_revoke_records_per_block);
-	spin_lock(&transaction->t_handle_lock);
 	wanted = atomic_add_return(nblocks,
 				   &transaction->t_outstanding_credits);
 
 	if (wanted > journal->j_max_transaction_buffers) {
-		jbd_debug(3, "denied handle %p %d blocks: "
+		jbd2_debug(3, "denied handle %p %d blocks: "
 			  "transaction too large\n", handle, nblocks);
 		atomic_sub(nblocks, &transaction->t_outstanding_credits);
-		goto unlock;
+		goto error_out;
 	}
 
 	trace_jbd2_handle_extend(journal->j_fs_dev->bd_dev,
@@ -713,9 +708,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 	handle->h_revoke_credits_requested += revoke_records;
 	result = 0;
 
-	jbd_debug(3, "extended handle %p by %d\n", handle, nblocks);
-unlock:
-	spin_unlock(&transaction->t_handle_lock);
+	jbd2_debug(3, "extended handle %p by %d\n", handle, nblocks);
 error_out:
 	read_unlock(&journal->j_state_lock);
 	return result;
@@ -803,7 +796,7 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
 	 * First unlink the handle from its current transaction, and start the
 	 * commit on that.
 	 */
-	jbd_debug(2, "restarting handle %p\n", handle);
+	jbd2_debug(2, "restarting handle %p\n", handle);
 	stop_this_handle(handle);
 	handle->h_transaction = NULL;
 
@@ -836,6 +829,43 @@ int jbd2_journal_restart(handle_t *handle, int nblocks)
 }
 EXPORT_SYMBOL(jbd2_journal_restart);
 
+/*
+ * Waits for any outstanding t_updates to finish.
+ * This is called with write j_state_lock held.
+ */
+void jbd2_journal_wait_updates(journal_t *journal)
+{
+	DEFINE_WAIT(wait);
+
+	while (1) {
+		/*
+		 * Note that the running transaction can get freed under us if
+		 * this transaction is getting committed in
+		 * jbd2_journal_commit_transaction() ->
+		 * jbd2_journal_free_transaction(). This can only happen when we
+		 * release j_state_lock -> schedule() -> acquire j_state_lock.
+		 * Hence we should everytime retrieve new j_running_transaction
+		 * value (after j_state_lock release acquire cycle), else it may
+		 * lead to use-after-free of old freed transaction.
+		 */
+		transaction_t *transaction = journal->j_running_transaction;
+
+		if (!transaction)
+			break;
+
+		prepare_to_wait(&journal->j_wait_updates, &wait,
+				TASK_UNINTERRUPTIBLE);
+		if (!atomic_read(&transaction->t_updates)) {
+			finish_wait(&journal->j_wait_updates, &wait);
+			break;
+		}
+		write_unlock(&journal->j_state_lock);
+		schedule();
+		finish_wait(&journal->j_wait_updates, &wait);
+		write_lock(&journal->j_state_lock);
+	}
+}
+
 /**
  * jbd2_journal_lock_updates () - establish a transaction barrier.
  * @journal:  Journal to establish a barrier on.
@@ -848,8 +878,6 @@ EXPORT_SYMBOL(jbd2_journal_restart);
  */
 void jbd2_journal_lock_updates(journal_t *journal)
 {
-	DEFINE_WAIT(wait);
-
 	jbd2_might_wait_for_commit(journal);
 
 	write_lock(&journal->j_state_lock);
@@ -863,27 +891,9 @@ void jbd2_journal_lock_updates(journal_t *journal)
 		write_lock(&journal->j_state_lock);
 	}
 
-	/* Wait until there are no running updates */
-	while (1) {
-		transaction_t *transaction = journal->j_running_transaction;
-
-		if (!transaction)
-			break;
+	/* Wait until there are no running t_updates */
+	jbd2_journal_wait_updates(journal);
 
-		spin_lock(&transaction->t_handle_lock);
-		prepare_to_wait(&journal->j_wait_updates, &wait,
-				TASK_UNINTERRUPTIBLE);
-		if (!atomic_read(&transaction->t_updates)) {
-			spin_unlock(&transaction->t_handle_lock);
-			finish_wait(&journal->j_wait_updates, &wait);
-			break;
-		}
-		spin_unlock(&transaction->t_handle_lock);
-		write_unlock(&journal->j_state_lock);
-		schedule();
-		finish_wait(&journal->j_wait_updates, &wait);
-		write_lock(&journal->j_state_lock);
-	}
 	write_unlock(&journal->j_state_lock);
 
 	/*
@@ -970,7 +980,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 
 	journal = transaction->t_journal;
 
-	jbd_debug(5, "journal_head %p, force_copy %d\n", jh, force_copy);
+	jbd2_debug(5, "journal_head %p, force_copy %d\n", jh, force_copy);
 
 	JBUFFER_TRACE(jh, "entry");
 repeat:
@@ -1270,7 +1280,7 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 	struct journal_head *jh = jbd2_journal_add_journal_head(bh);
 	int err;
 
-	jbd_debug(5, "journal_head %p\n", jh);
+	jbd2_debug(5, "journal_head %p\n", jh);
 	err = -EROFS;
 	if (is_handle_aborted(handle))
 		goto out;
@@ -1493,7 +1503,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	 * of the running transaction.
 	 */
 	jh = bh2jh(bh);
-	jbd_debug(5, "journal_head %p\n", jh);
+	jbd2_debug(5, "journal_head %p\n", jh);
 	JBUFFER_TRACE(jh, "entry");
 
 	/*
@@ -1826,7 +1836,7 @@ int jbd2_journal_stop(handle_t *handle)
 	pid_t pid;
 
 	if (--handle->h_ref > 0) {
-		jbd_debug(4, "h_ref %d -> %d\n", handle->h_ref + 1,
+		jbd2_debug(4, "h_ref %d -> %d\n", handle->h_ref + 1,
 						 handle->h_ref);
 		if (is_handle_aborted(handle))
 			return -EIO;
@@ -1846,7 +1856,7 @@ int jbd2_journal_stop(handle_t *handle)
 	if (is_handle_aborted(handle))
 		err = -EIO;
 
-	jbd_debug(4, "Handle %p going down\n", handle);
+	jbd2_debug(4, "Handle %p going down\n", handle);
 	trace_jbd2_handle_stats(journal->j_fs_dev->bd_dev,
 				tid, handle->h_type, handle->h_line_no,
 				jiffies - handle->h_start_jiffies,
@@ -1924,7 +1934,7 @@ int jbd2_journal_stop(handle_t *handle)
 		 * completes the commit thread, it just doesn't write
 		 * anything to disk. */
 
-		jbd_debug(2, "transaction too old, requesting commit for "
+		jbd2_debug(2, "transaction too old, requesting commit for "
 					"handle %p\n", handle);
 		/* This is non-blocking */
 		jbd2_log_start_commit(journal, tid);
@@ -2668,7 +2678,7 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 		return -EROFS;
 	journal = transaction->t_journal;
 
-	jbd_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
+	jbd2_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
 			transaction->t_tid);
 
 	spin_lock(&journal->j_list_lock);
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index f235a3d270a0..da4f9c3b714f 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -269,6 +269,7 @@ int dbUnmount(struct inode *ipbmap, int mounterror)
 
 	/* free the memory for the in-memory bmap. */
 	kfree(bmp);
+	JFS_SBI(ipbmap->i_sb)->bmap = NULL;
 
 	return (0);
 }
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 799d3837e7c2..4899663996d8 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -193,6 +193,7 @@ int diUnmount(struct inode *ipimap, int mounterror)
 	 * free in-memory control structure
 	 */
 	kfree(imap);
+	JFS_IP(ipimap)->i_imap = NULL;
 
 	return (0);
 }
diff --git a/fs/locks.c b/fs/locks.c
index 881fd16905c6..4899a4666f24 100644
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
index 3eb500adcda2..f71af990e1e8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -895,8 +895,8 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			     rename->rn_tname, rename->rn_tnamelen);
 	if (status)
 		return status;
-	set_change_info(&rename->rn_sinfo, &cstate->current_fh);
-	set_change_info(&rename->rn_tinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_sinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_tinfo, &cstate->current_fh);
 	return nfs_ok;
 }
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 46cc429c44f7..864e821c3910 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -583,7 +583,8 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 	if (err)
 		return err;
 
-	if (inode->i_flags & OVL_COPY_I_FLAGS_MASK) {
+	if (inode->i_flags & OVL_COPY_I_FLAGS_MASK &&
+	    (S_ISREG(c->stat.mode) || S_ISDIR(c->stat.mode))) {
 		/*
 		 * Copy the fileattr inode flags that are the source of already
 		 * copied i_flags
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 28cb05ef018c..49d3feded593 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -19,7 +19,6 @@ struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
 	struct kiocb *orig_iocb;
-	struct fd fd;
 };
 
 static struct kmem_cache *ovl_aio_request_cachep;
@@ -256,7 +255,7 @@ static rwf_t ovl_iocb_to_rwf(int ifl)
 static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref)) {
-		fdput(aio_req->fd);
+		fput(aio_req->iocb.ki_filp);
 		kmem_cache_free(ovl_aio_request_cachep, aio_req);
 	}
 }
@@ -322,10 +321,9 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -394,10 +392,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
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
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 066e8344934d..7c1aa4a60dc6 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -556,6 +556,9 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
  */
 struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
 {
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	return __create_dir(name, parent, &simple_dir_inode_operations);
 }
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index f1f0842a2cb2..43082bd44a99 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -21,6 +21,7 @@
  */
 #define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
 #define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
+#define IORT_SMMU_V3_PMCG_HISI_HIP09     0x00000002 /* HiSilicon HIP09 PMCG */
 
 int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index ade8a6d7acff..d19f527ade3b 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -58,10 +58,10 @@ extern ushort jbd2_journal_enable_debug;
 void __jbd2_debug(int level, const char *file, const char *func,
 		  unsigned int line, const char *fmt, ...);
 
-#define jbd_debug(n, fmt, a...) \
+#define jbd2_debug(n, fmt, a...) \
 	__jbd2_debug((n), __FILE__, __func__, __LINE__, (fmt), ##a)
 #else
-#define jbd_debug(n, fmt, a...)  no_printk(fmt, ##a)
+#define jbd2_debug(n, fmt, a...)  no_printk(fmt, ##a)
 #endif
 
 extern void *jbd2_alloc(size_t size, gfp_t flags);
@@ -554,9 +554,6 @@ struct transaction_chp_stats_s {
  *    ->j_list_lock
  *
  *    j_state_lock
- *    ->t_handle_lock
- *
- *    j_state_lock
  *    ->j_list_lock			(journal_unmap_buffer)
  *
  */
@@ -594,7 +591,7 @@ struct transaction_s
 	 */
 	unsigned long		t_log_start;
 
-	/* 
+	/*
 	 * Number of buffers on the t_buffers list [j_list_lock, no locks
 	 * needed for jbd2 thread]
 	 */
@@ -1538,6 +1535,8 @@ extern int	 jbd2_journal_flush(journal_t *journal, unsigned int flags);
 extern void	 jbd2_journal_lock_updates (journal_t *);
 extern void	 jbd2_journal_unlock_updates (journal_t *);
 
+void jbd2_journal_wait_updates(journal_t *);
+
 extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
 				struct block_device *fs_dev,
 				unsigned long long start, int len, int bsize);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d890c43cff14..fa568d35bcbf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -264,6 +264,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 014eb0a963fc..5806fc4dc7e5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1084,15 +1084,31 @@ extern int perf_event_output(struct perf_event *event,
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
index d23977e9035d..0c2d00809915 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -108,10 +108,36 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
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
index ace0717c71e2..753e641f617b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -764,6 +764,14 @@ void __put_task_struct(struct task_struct *tsk)
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
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8d856b7c2e5a..8b110b245d92 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2269,7 +2269,11 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	wake_up_klogd();
+	if (in_sched)
+		defer_console_output();
+	else
+		wake_up_klogd();
+
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
@@ -3277,11 +3281,33 @@ static void __wake_up_klogd(int val)
 	preempt_enable();
 }
 
+/**
+ * wake_up_klogd - Wake kernel logging daemon
+ *
+ * Use this function when new records have been added to the ringbuffer
+ * and the console printing of those records has already occurred or is
+ * known to be handled by some other context. This function will only
+ * wake the logging daemon.
+ *
+ * Context: Any context.
+ */
 void wake_up_klogd(void)
 {
 	__wake_up_klogd(PRINTK_PENDING_WAKEUP);
 }
 
+/**
+ * defer_console_output - Wake kernel logging daemon and trigger
+ *	console printing in a deferred context
+ *
+ * Use this function when new records have been added to the ringbuffer,
+ * this context is responsible for console printing those records, but
+ * the current context is not allowed to perform the console printing.
+ * Trigger an irq_work context to perform the console printing. This
+ * function also wakes the logging daemon.
+ *
+ * Context: Any context.
+ */
 void defer_console_output(void)
 {
 	/*
@@ -3298,12 +3324,7 @@ void printk_trigger_flush(void)
 
 int vprintk_deferred(const char *fmt, va_list args)
 {
-	int r;
-
-	r = vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
-	defer_console_output();
-
-	return r;
+	return vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
 }
 
 int _printk_deferred(const char *fmt, ...)
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index ef0f9a2044da..6d10927a07d8 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -38,13 +38,8 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (this_cpu_read(printk_context) || in_nmi()) {
-		int len;
-
-		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
-		defer_console_output();
-		return len;
-	}
+	if (this_cpu_read(printk_context) || in_nmi())
+		return vprintk_deferred(fmt, args);
 
 	/* No obstacles. */
 	return vprintk_default(fmt, args);
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 57ec414710bb..a83cb29d3760 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -402,7 +402,7 @@ rcu_scale_writer(void *arg)
 	sched_set_fifo_low(current);
 
 	if (holdoff)
-		schedule_timeout_uninterruptible(holdoff * HZ);
+		schedule_timeout_idle(holdoff * HZ);
 
 	/*
 	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 27286d99e0c2..41006eef003f 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -175,7 +175,8 @@ static void scf_torture_stats_print(void)
 		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
 	}
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
-	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
+	    atomic_read(&n_mb_out_errs) ||
+	    (!IS_ENABLED(CONFIG_KASAN) && atomic_read(&n_alloc_errs)))
 		bangstr = "!!! ";
 	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld single_rpc: %lld single_rpc_ofl: %lld many: %lld/%lld all: %lld/%lld ",
 		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count, scfs.n_resched,
@@ -327,7 +328,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
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
index f3f1e3c2f421..6adacfc880d6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1716,7 +1716,7 @@ static void trace_create_maxlat_file(struct trace_array *tr,
 	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
 	tr->d_max_latency = trace_create_file("tracing_max_latency",
 					      TRACE_MODE_WRITE,
-					      d_tracer, &tr->max_latency,
+					      d_tracer, tr,
 					      &tracing_max_lat_fops);
 }
 
@@ -1749,7 +1749,7 @@ void latency_fsnotify(struct trace_array *tr)
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, &tr->max_latency, &tracing_max_lat_fops)
+			  d_tracer, tr, &tracing_max_lat_fops)
 
 #endif
 
@@ -6575,14 +6575,18 @@ static ssize_t
 tracing_max_lat_read(struct file *filp, char __user *ubuf,
 		     size_t cnt, loff_t *ppos)
 {
-	return tracing_nsecs_read(filp->private_data, ubuf, cnt, ppos);
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_read(&tr->max_latency, ubuf, cnt, ppos);
 }
 
 static ssize_t
 tracing_max_lat_write(struct file *filp, const char __user *ubuf,
 		      size_t cnt, loff_t *ppos)
 {
-	return tracing_nsecs_write(filp->private_data, ubuf, cnt, ppos);
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_write(&tr->max_latency, ubuf, cnt, ppos);
 }
 
 #endif
@@ -7648,18 +7652,20 @@ static const struct file_operations tracing_thresh_fops = {
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 static const struct file_operations tracing_max_lat_fops = {
-	.open		= tracing_open_generic,
+	.open		= tracing_open_generic_tr,
 	.read		= tracing_max_lat_read,
 	.write		= tracing_max_lat_write,
 	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
 };
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
@@ -8824,12 +8830,33 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
index 184a3dab2699..b6ccb4cced63 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -882,6 +882,11 @@ int kset_register(struct kset *k)
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
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index a09b2fc11c80..c0389199c0dc 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2114,8 +2114,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
 		return ret;
 
 	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
-	memcpy(&offsets[1], &entry->watchers_offset,
-			sizeof(offsets) - sizeof(offsets[0]));
+	memcpy(&offsets[1], &entry->offsets, sizeof(entry->offsets));
 
 	if (state->buf_kern_start) {
 		buf_start = state->buf_kern_start + state->buf_kern_offset;
diff --git a/net/core/devlink.c b/net/core/devlink.c
index b4d7a7f749c1..db76c55e1a6d 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -4413,7 +4413,7 @@ static int devlink_param_get(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->get || devlink->reload_failed)
+	if (!param->get)
 		return -EOPNOTSUPP;
 	return param->get(devlink, param->id, ctx);
 }
@@ -4422,7 +4422,7 @@ static int devlink_param_set(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->set || devlink->reload_failed)
+	if (!param->set)
 		return -EOPNOTSUPP;
 	return param->set(devlink, param->id, ctx);
 }
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 175ead6b19cb..26943c93f14c 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3557,6 +3557,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		goto queue;
 	case WLAN_CATEGORY_S1G:
+		if (len < offsetofend(typeof(*mgmt),
+				      u.action.u.s1g.action_code))
+			break;
+
 		switch (mgmt->u.action.u.s1g.action_code) {
 		case WLAN_S1G_TWT_SETUP:
 		case WLAN_S1G_TWT_TEARDOWN:
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index bcdd6e925343..24cf0bf7c80e 100644
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
index b7dbac5c519f..8a33a35fc50d 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -69,8 +69,6 @@ obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
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
index 5cd9d6b143c4..000000000000
--- a/net/sched/cls_rsvp.h
+++ /dev/null
@@ -1,776 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * net/sched/cls_rsvp.h	Template file for RSVPv[46] classifiers.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-/*
-   Comparing to general packet classification problem,
-   RSVP needs only several relatively simple rules:
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
-	/* Something went wrong if we are trying to replace a non-existent
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
-		       u32 handle, struct nlattr **tca,
-		       void **arg, u32 flags,
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
-	err = tcf_exts_validate(net, tp, tb, tca[TCA_RATE], &e, flags,
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
index 513eadcc38d9..c69d069b3f2b 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -385,6 +385,14 @@ static const struct config_entry config_table[] = {
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
diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index f8deae4e26a1..44bbf80f0cfd 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -51,9 +51,9 @@ enum autochan {
  * Has the side effect of filling the channels[i].location values used
  * in processing the buffer output.
  **/
-static int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
+static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 {
-	int bytes = 0;
+	unsigned int bytes = 0;
 	int i = 0;
 
 	while (i < num_channels) {
@@ -348,7 +348,7 @@ int main(int argc, char **argv)
 	ssize_t read_size;
 	int dev_num = -1, trig_num = -1;
 	char *buffer_access = NULL;
-	int scan_size;
+	unsigned int scan_size;
 	int noevents = 0;
 	int notrigger = 0;
 	char *dummy;
@@ -674,7 +674,16 @@ int main(int argc, char **argv)
 	}
 
 	scan_size = size_from_channelarray(channels, num_channels);
-	data = malloc(scan_size * buf_len);
+
+	size_t total_buf_len = scan_size * buf_len;
+
+	if (scan_size > 0 && total_buf_len / scan_size != buf_len) {
+		ret = -EFAULT;
+		perror("Integer overflow happened when calculate scan_size * buf_len");
+		goto error;
+	}
+
+	data = malloc(total_buf_len);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 2aed20dc2262..6bf24b85294c 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -22,10 +22,10 @@ compare_number()
 }
 
 # skip if --bpf-counters is not supported
-if ! perf stat --bpf-counters true > /dev/null 2>&1; then
-	if [ "$1" == "-v" ]; then
+if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
+	if [ "$1" = "-v" ]; then
 		echo "Skipping: --bpf-counters not supported"
-		perf --no-pager stat --bpf-counters true || true
+		perf --no-pager stat -e cycles --bpf-counters true || true
 	fi
 	exit 2
 fi
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
