Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACA57ABF52
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjIWJ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjIWJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:28:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3351B6;
        Sat, 23 Sep 2023 02:27:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C291C433C8;
        Sat, 23 Sep 2023 09:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695461270;
        bh=O1uelYN0CVTXEE8jUyVCPXhYFrLXnntPuH1Gfy5+XwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akAaNYqfjsiB+q3OBnNrsn2FNAgtZVUPn7BXwj07Sd1B4AadfDPiQvK285M7yc23s
         l+ptA57sA+aiQonWg8IsXGdup88udkzXHX7Qvun6JnmCHPGykFMF5Ne0CReEK0EjUS
         GHk4nI5vZtmlMebaTZ2Cfx01DFaWpO2R12E1UYsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.5.5
Date:   Sat, 23 Sep 2023 11:27:40 +0200
Message-ID: <2023092340-uniformed-economic-c727@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023092340-overpay-cognition-aa89@gregkh>
References: <2023092340-overpay-cognition-aa89@gregkh>
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

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 8d3afeede10e..fabaad3fd9c2 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -92,6 +92,8 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
+ memory.kmem.limit_in_bytes          This knob is deprecated and writing to
+                                     it will return -ENOTSUPP.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index bedd3a1d7b42..0ac452333eb4 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -198,6 +198,9 @@ stable kernels.
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
index beddccac3283..7545d2b0e7b7 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 5
-SUBLEVEL = 4
+SUBLEVEL = 5
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 054e9199f30d..dc0fb7a81371 100644
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
index 46364b699cc3..5d07cf9e0044 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -94,16 +94,28 @@ static void machine_crash_nonpanic_core(void *unused)
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
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 059dfccdfe7c..b51787b6561d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
@@ -78,6 +79,21 @@ switch-lid {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led-camera-indicator {
+			label = "white:camera-indicator";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&tlmm 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			default-state = "off";
+			/* Reuse as a panic indicator until we get a "camera on" trigger */
+			panic-indicator;
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
 
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 9f8a9ef398a2..de85086c65ad 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -79,7 +79,7 @@ pstore_mem: ramoops@ffc00000 {
 			reg = <0x0 0xffc40000 0x0 0xc0000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 		};
 
 		cmdline_mem: memory@ffd00000 {
diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index a7f4aeae9c1a..7c58d1299a60 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -52,7 +52,7 @@ pstore_mem: ramoops@ffc00000 {
 			reg = <0x0 0xffc40000 0x0 0xc0000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 		};
 
 		cmdline_mem: memory@ffd00000 {
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 7cafb32fbb94..4b4ea156a92c 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -673,7 +673,7 @@ ramoops: ramoops@ffc00000 {
 			reg = <0 0xffc00000 0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index baafea53770b..ae0ca48b89a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -222,7 +222,7 @@ ramoops@ffc00000 {
 			reg = <0x0 0xffc00000 0x0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index b044cffb419e..6b044eca7ad5 100644
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
index db2a1861bb97..35225632d70a 100644
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
diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index 2add435ad038..165e032d0864 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -243,11 +243,11 @@ static int dwc3_octeon_get_divider(void)
 	while (div < ARRAY_SIZE(clk_div)) {
 		uint64_t rate = octeon_get_io_clock_rate() / clk_div[div];
 		if (rate <= 300000000 && rate >= 150000000)
-			break;
+			return div;
 		div++;
 	}
 
-	return div;
+	return -EINVAL;
 }
 
 static int dwc3_octeon_config_power(struct device *dev, void __iomem *base)
@@ -374,6 +374,10 @@ static int dwc3_octeon_clocks_start(struct device *dev, void __iomem *base)
 
 	/* Step 4b: Select controller clock frequency. */
 	div = dwc3_octeon_get_divider();
+	if (div < 0) {
+		dev_err(dev, "clock divider invalid\n");
+		return div;
+	}
 	val = dwc3_octeon_readq(uctl_ctl_reg);
 	val &= ~USBDRD_UCTL_CTL_H_CLKDIV_SEL;
 	val |= FIELD_PREP(USBDRD_UCTL_CTL_H_CLKDIV_SEL, div);
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 44703f13985b..969cb9fc960f 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -460,6 +460,7 @@ static int __init ibmebus_bus_init(void)
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 		       __func__, err);
+		put_device(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index c08bb5c3b385..b3b96ff46d19 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -98,7 +98,13 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 	kbuf.image = image;
 	kbuf.buf_min = lowest_paddr;
 	kbuf.buf_max = ULONG_MAX;
-	kbuf.buf_align = PAGE_SIZE;
+
+	/*
+	 * Current riscv boot protocol requires 2MB alignment for
+	 * RV64 and 4MB alignment for RV32
+	 *
+	 */
+	kbuf.buf_align = PMD_SIZE;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
 	kbuf.top_down = false;
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 64bd7ac3e35d..f8d0550e5d2a 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -176,6 +176,7 @@ static unsigned long setup_kernel_memory_layout(void)
 	unsigned long asce_limit;
 	unsigned long rte_size;
 	unsigned long pages;
+	unsigned long vsize;
 	unsigned long vmax;
 
 	pages = ident_map_size / PAGE_SIZE;
@@ -183,11 +184,9 @@ static unsigned long setup_kernel_memory_layout(void)
 	vmemmap_size = SECTION_ALIGN_UP(pages) * sizeof(struct page);
 
 	/* choose kernel address space layout: 4 or 3 levels. */
-	vmemmap_start = round_up(ident_map_size, _REGION3_SIZE);
-	if (IS_ENABLED(CONFIG_KASAN) ||
-	    vmalloc_size > _REGION2_SIZE ||
-	    vmemmap_start + vmemmap_size + vmalloc_size + MODULES_LEN >
-		    _REGION2_SIZE) {
+	vsize = round_up(ident_map_size, _REGION3_SIZE) + vmemmap_size + MODULES_LEN;
+	vsize = size_add(vsize, vmalloc_size);
+	if (IS_ENABLED(CONFIG_KASAN) || (vsize > _REGION2_SIZE)) {
 		asce_limit = _REGION1_SIZE;
 		rte_size = _REGION2_SIZE;
 	} else {
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index bcc956c17872..08f93b0401bb 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -59,6 +59,14 @@ static void *alloc_pgt_page(void *context)
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
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 97a3de7892d3..5ff49fd67732 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -8,6 +8,14 @@
 #undef notrace
 #define notrace __attribute__((no_instrument_function))
 
+#ifdef CONFIG_64BIT
+/*
+ * The generic version tends to create spurious ENDBR instructions under
+ * certain conditions.
+ */
+#define _THIS_IP_ ({ unsigned long __here; asm ("lea 0(%%rip), %0" : "=r" (__here)); __here; })
+#endif
+
 #ifdef CONFIG_X86_32
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #endif /* CONFIG_X86_32 */
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 81b826d3b753..f2c02e4469cc 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -116,7 +116,7 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 		"2:\n"
 		_ASM_EXTABLE_UA(1b, 2b)
 		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
-		: : "memory", "rax", "r8", "r9", "r10", "r11");
+		: : "memory", "rax");
 	clac();
 	return len;
 }
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 099d58d02a26..44843a492e69 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -720,13 +720,8 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 {
 	s32 *s;
 
-	/*
-	 * Do not patch out the default return thunks if those needed are the
-	 * ones generated by the compiler.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK) &&
-	    (x86_return_thunk == __x86_return_thunk))
-		return;
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+		static_call_force_reinit();
 
 	for (s = start; s < end; s++) {
 		void *dest = NULL, *addr = (void *)s + *s;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 035a3db5330b..356de955e78d 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -24,6 +24,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT		0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
+#define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
+#define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 
 #define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
@@ -39,6 +41,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
+#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
@@ -56,6 +59,8 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{}
 };
@@ -85,6 +90,8 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{}
 };
@@ -106,6 +113,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{}
 };
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9384d5b4b8e..35acc95c6dd5 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1571,7 +1571,7 @@ static void __init build_socket_tables(void)
 {
 	struct uv_gam_range_entry *gre = uv_gre_table;
 	int nums, numn, nump;
-	int cpu, i, lnid;
+	int i, lnid, apicid;
 	int minsock = _min_socket;
 	int maxsock = _max_socket;
 	int minpnode = _min_pnode;
@@ -1622,15 +1622,14 @@ static void __init build_socket_tables(void)
 
 	/* Set socket -> node values: */
 	lnid = NUMA_NO_NODE;
-	for_each_possible_cpu(cpu) {
-		int nid = cpu_to_node(cpu);
-		int apicid, sockid;
+	for (apicid = 0; apicid < ARRAY_SIZE(__apicid_to_node); apicid++) {
+		int nid = __apicid_to_node[apicid];
+		int sockid;
 
-		if (lnid == nid)
+		if ((nid == NUMA_NO_NODE) || (lnid == nid))
 			continue;
 		lnid = nid;
 
-		apicid = per_cpu(x86_cpu_to_apicid, cpu);
 		sockid = apicid >> uv_cpuid.socketid_shift;
 
 		if (_socket_to_node[sockid - minsock] == SOCK_EMPTY)
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index c06bfc086565..faa9f2299848 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -272,7 +272,6 @@ void __init callthunks_patch_builtin_calls(void)
 	pr_info("Setting up call depth tracking\n");
 	mutex_lock(&text_mutex);
 	callthunks_setup(&cs, &builtin_coretext);
-	static_call_force_reinit();
 	thunks_initialized = true;
 	mutex_unlock(&text_mutex);
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7d82f0bd449c..747b83a373a2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -587,7 +587,6 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 }
 
 
-#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
 	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
@@ -611,7 +610,14 @@ static int x86_cluster_flags(void)
 	return cpu_cluster_flags() | x86_sched_itmt_flags();
 }
 #endif
-#endif
+
+static int x86_die_flags(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+	       return x86_sched_itmt_flags();
+
+	return 0;
+}
 
 /*
  * Set if a package/die has multiple NUMA nodes inside.
@@ -653,7 +659,7 @@ static void __init build_sched_topology(void)
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, SD_INIT_NAME(DIE)
+			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(DIE)
 		};
 	}
 
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 01c5de4c279b..0a81aafed7f8 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -27,7 +27,7 @@
  * NOTE! The calling convention is very intentionally the same as
  * for 'rep movs', so that we can rewrite the function call with
  * just a plain 'rep movs' on machines that have FSRM.  But to make
- * it simpler for us, we can clobber rsi/rdi and rax/r8-r11 freely.
+ * it simpler for us, we can clobber rsi/rdi and rax freely.
  */
 SYM_FUNC_START(rep_movs_alternative)
 	cmpq $64,%rcx
@@ -68,55 +68,24 @@ SYM_FUNC_START(rep_movs_alternative)
 	_ASM_EXTABLE_UA( 3b, .Lcopy_user_tail)
 
 .Llarge:
-0:	ALTERNATIVE "jmp .Lunrolled", "rep movsb", X86_FEATURE_ERMS
+0:	ALTERNATIVE "jmp .Llarge_movsq", "rep movsb", X86_FEATURE_ERMS
 1:	RET
 
-        _ASM_EXTABLE_UA( 0b, 1b)
+	_ASM_EXTABLE_UA( 0b, 1b)
 
-	.p2align 4
-.Lunrolled:
-10:	movq (%rsi),%r8
-11:	movq 8(%rsi),%r9
-12:	movq 16(%rsi),%r10
-13:	movq 24(%rsi),%r11
-14:	movq %r8,(%rdi)
-15:	movq %r9,8(%rdi)
-16:	movq %r10,16(%rdi)
-17:	movq %r11,24(%rdi)
-20:	movq 32(%rsi),%r8
-21:	movq 40(%rsi),%r9
-22:	movq 48(%rsi),%r10
-23:	movq 56(%rsi),%r11
-24:	movq %r8,32(%rdi)
-25:	movq %r9,40(%rdi)
-26:	movq %r10,48(%rdi)
-27:	movq %r11,56(%rdi)
-	addq $64,%rsi
-	addq $64,%rdi
-	subq $64,%rcx
-	cmpq $64,%rcx
-	jae .Lunrolled
-	cmpl $8,%ecx
-	jae .Lword
+.Llarge_movsq:
+	movq %rcx,%rax
+	shrq $3,%rcx
+	andl $7,%eax
+0:	rep movsq
+	movl %eax,%ecx
 	testl %ecx,%ecx
 	jne .Lcopy_user_tail
 	RET
 
-	_ASM_EXTABLE_UA(10b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(11b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(12b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(13b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(14b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(15b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(16b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(17b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(20b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(21b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(22b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(23b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(24b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(25b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(26b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(27b, .Lcopy_user_tail)
+1:	leaq (%rax,%rcx,8),%rcx
+	jmp .Lcopy_user_tail
+
+	_ASM_EXTABLE_UA( 0b, 1b)
 SYM_FUNC_END(rep_movs_alternative)
 EXPORT_SYMBOL(rep_movs_alternative)
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 1451e0c4ae22..235bbda6fc82 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -56,7 +56,6 @@ SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
 SYM_FUNC_START(__put_user_nocheck_1)
-	ENDBR
 	ASM_STAC
 2:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -76,7 +75,6 @@ SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
 SYM_FUNC_START(__put_user_nocheck_2)
-	ENDBR
 	ASM_STAC
 4:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -96,7 +94,6 @@ SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
 SYM_FUNC_START(__put_user_nocheck_4)
-	ENDBR
 	ASM_STAC
 6:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -119,7 +116,6 @@ SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
 SYM_FUNC_START(__put_user_nocheck_8)
-	ENDBR
 	ASM_STAC
 9:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index c2a29be35c01..08aa0f25f12a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -19,6 +19,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 # optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
 
+# When LTO is enabled, llvm emits many text sections, which is not supported
+# by kexec. Remove -flto=* flags.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 953f08354c8c..c21bc81a790f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4402,6 +4402,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 				       int new_nr_hw_queues)
 {
 	struct blk_mq_tags **new_tags;
+	int i;
 
 	if (set->nr_hw_queues >= new_nr_hw_queues)
 		goto done;
@@ -4416,6 +4417,16 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 		       sizeof(*set->tags));
 	kfree(set->tags);
 	set->tags = new_tags;
+
+	for (i = set->nr_hw_queues; i < new_nr_hw_queues; i++) {
+		if (!__blk_mq_alloc_map_and_rqs(set, i)) {
+			while (--i >= set->nr_hw_queues)
+				__blk_mq_free_map_and_rqs(set, i);
+			return -ENOMEM;
+		}
+		cond_resched();
+	}
+
 done:
 	set->nr_hw_queues = new_nr_hw_queues;
 	return 0;
@@ -4704,7 +4715,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 {
 	struct request_queue *q;
 	LIST_HEAD(head);
-	int prev_nr_hw_queues;
+	int prev_nr_hw_queues = set->nr_hw_queues;
+	int i;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -4731,7 +4743,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
 
-	prev_nr_hw_queues = set->nr_hw_queues;
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
 		goto reregister;
 
@@ -4767,6 +4778,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
+
+	/* Free the excess tags when nr_hw_queues shrink. */
+	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
+		__blk_mq_free_map_and_rqs(set, i);
 }
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
diff --git a/crypto/lrw.c b/crypto/lrw.c
index 1b0f76ba3eb5..59260aefed28 100644
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
index 09be909a6a1a..548b302c6c6a 100644
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
index 09029fe545f1..39e31030e5f4 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -603,7 +603,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 
 /* 7E */ ACPI_OP("Timer", ARGP_TIMER_OP, ARGI_TIMER_OP, ACPI_TYPE_ANY,
 			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_0A_0T_1R,
-			 AML_FLAGS_EXEC_0A_0T_1R),
+			 AML_FLAGS_EXEC_0A_0T_1R | AML_NO_OPERAND_RESOLVE),
 
 /* ACPI 5.0 opcodes */
 
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 56d887323ae5..6496ff5a6ba2 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1708,7 +1708,10 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
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
index 18cc08c858cf..442396f6ed1f 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -445,6 +445,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
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
@@ -486,6 +495,24 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
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
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 60cc4605169c..60835953ebfc 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -113,6 +113,12 @@ static void lpi_device_get_constraints_amd(void)
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
index c1e85e0ed43e..7907b09fc27e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1883,6 +1883,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 06aec35f88f2..a6212f6d3796 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1256,6 +1256,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
 	return sprintf(buf, "%d\n", emp->blink_policy);
 }
 
+static void ahci_port_clear_pending_irq(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp;
+
+	/* clear SError */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	dev_dbg(ap->host->dev, "PORT_SCR_ERR 0x%x\n", tmp);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear port IRQ */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	dev_dbg(ap->host->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
+	if (tmp)
+		writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);
+}
+
 static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -1270,18 +1290,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 	if (rc)
 		dev_warn(dev, "%s (%d)\n", emsg, rc);
 
-	/* clear SError */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	dev_dbg(dev, "PORT_SCR_ERR 0x%x\n", tmp);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
-
-	/* clear port IRQ */
-	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	dev_dbg(dev, "PORT_IRQ_STAT 0x%x\n", tmp);
-	if (tmp)
-		writel(tmp, port_mmio + PORT_IRQ_STAT);
-
-	writel(1 << port_no, mmio + HOST_IRQ_STAT);
+	ahci_port_clear_pending_irq(ap);
 
 	/* mark esata ports */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -1602,6 +1611,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 04db0f2c683a..79d02eb4e479 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4935,11 +4935,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		 * timeout using the policy 0xD. For these commands, invoke EH
 		 * to get the command sense data.
 		 */
-		if (qc->result_tf.status & ATA_SENSE &&
-		    ((ata_is_ncq(qc->tf.protocol) &&
-		      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
-		     (!ata_is_ncq(qc->tf.protocol) &&
-		      ata_id_sense_reporting_enabled(dev->id)))) {
+		if (qc->flags & ATA_QCFLAG_HAS_CDL &&
+		    qc->result_tf.status & ATA_SENSE) {
 			/*
 			 * Tell SCSI EH to not overwrite scmd->result even if
 			 * this command is finished with result SAM_STAT_GOOD.
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 85e279a12f62..09833f4d2079 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -396,10 +396,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
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
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e685acc5cacd..dfdfb72d350f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -625,9 +625,24 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0e4), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f1), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f5), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f6), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3804), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index c95fa4335fee..9766dbf607f9 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1525,6 +1525,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index b95963095729..f4c4c027b062 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -512,10 +512,17 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	int rc;
 	u32 ordinal;
 	unsigned long dur;
+	unsigned int try;
 
-	rc = tpm_tis_send_data(chip, buf, len);
-	if (rc < 0)
-		return rc;
+	for (try = 0; try < TPM_RETRY; try++) {
+		rc = tpm_tis_send_data(chip, buf, len);
+		if (rc >= 0)
+			/* Data transfer done successfully */
+			break;
+		else if (rc != -EIO)
+			/* Data transfer failed, not recoverable */
+			return rc;
+	}
 
 	rc = tpm_tis_verify_crc(priv, len, buf);
 	if (rc < 0) {
diff --git a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
index 7a8d402f05be..9af280735cba 100644
--- a/drivers/comedi/Kconfig
+++ b/drivers/comedi/Kconfig
@@ -67,7 +67,6 @@ config COMEDI_TEST
 
 config COMEDI_PARPORT
 	tristate "Parallel port support"
-	depends on HAS_IOPORT
 	help
 	  Enable support for the standard parallel port.
 	  A cheap and easy way to get a few more digital I/O lines. Steal
@@ -80,7 +79,6 @@ config COMEDI_PARPORT
 config COMEDI_SSV_DNP
 	tristate "SSV Embedded Systems DIL/Net-PC support"
 	depends on X86_32 || COMPILE_TEST
-	depends on HAS_IOPORT
 	help
 	  Enable support for SSV Embedded Systems DIL/Net-PC
 
@@ -91,7 +89,6 @@ endif # COMEDI_MISC_DRIVERS
 
 menuconfig COMEDI_ISA_DRIVERS
 	bool "Comedi ISA and PC/104 drivers"
-	depends on ISA
 	help
 	  Enable comedi ISA and PC/104 drivers to be built
 
@@ -103,8 +100,7 @@ if COMEDI_ISA_DRIVERS
 
 config COMEDI_PCL711
 	tristate "Advantech PCL-711/711b and ADlink ACL-8112 ISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCL-711 and 711b, ADlink ACL-8112
 
@@ -165,9 +161,8 @@ config COMEDI_PCL730
 
 config COMEDI_PCL812
 	tristate "Advantech PCL-812/813 and ADlink ACL-8112/8113/8113/8216"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCL-812/PG, PCL-813/B, ADLink
 	  ACL-8112DG/HG/PG, ACL-8113, ACL-8216, ICP DAS A-821PGH/PGL/PGL-NDA,
@@ -178,9 +173,8 @@ config COMEDI_PCL812
 
 config COMEDI_PCL816
 	tristate "Advantech PCL-814 and PCL-816 ISA card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCL-814 and PCL-816 ISA cards
 
@@ -189,9 +183,8 @@ config COMEDI_PCL816
 
 config COMEDI_PCL818
 	tristate "Advantech PCL-718 and PCL-818 ISA card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCL-818 ISA cards
 	  PCL-818L, PCL-818H, PCL-818HD, PCL-818HG, PCL-818 and PCL-718
@@ -210,7 +203,7 @@ config COMEDI_PCM3724
 
 config COMEDI_AMPLC_DIO200_ISA
 	tristate "Amplicon PC212E/PC214E/PC215E/PC218E/PC272E"
-	depends on COMEDI_AMPLC_DIO200
+	select COMEDI_AMPLC_DIO200
 	help
 	  Enable support for Amplicon PC212E, PC214E, PC215E, PC218E and
 	  PC272E ISA DIO boards
@@ -262,8 +255,7 @@ config COMEDI_DAC02
 
 config COMEDI_DAS16M1
 	tristate "MeasurementComputing CIO-DAS16/M1DAS-16 ISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Measurement Computing CIO-DAS16/M1 ISA cards.
@@ -273,7 +265,7 @@ config COMEDI_DAS16M1
 
 config COMEDI_DAS08_ISA
 	tristate "DAS-08 compatible ISA and PC/104 card support"
-	depends on COMEDI_DAS08
+	select COMEDI_DAS08
 	help
 	  Enable support for Keithley Metrabyte/ComputerBoards DAS08
 	  and compatible ISA and PC/104 cards:
@@ -286,9 +278,8 @@ config COMEDI_DAS08_ISA
 
 config COMEDI_DAS16
 	tristate "DAS-16 compatible ISA and PC/104 card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Keithley Metrabyte/ComputerBoards DAS16
@@ -305,8 +296,7 @@ config COMEDI_DAS16
 
 config COMEDI_DAS800
 	tristate "DAS800 and compatible ISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Keithley Metrabyte DAS800 and compatible ISA cards
 	  Keithley Metrabyte DAS-800, DAS-801, DAS-802
@@ -318,9 +308,8 @@ config COMEDI_DAS800
 
 config COMEDI_DAS1800
 	tristate "DAS1800 and compatible ISA card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for DAS1800 and compatible ISA cards
 	  Keithley Metrabyte DAS-1701ST, DAS-1701ST-DA, DAS-1701/AO,
@@ -334,8 +323,7 @@ config COMEDI_DAS1800
 
 config COMEDI_DAS6402
 	tristate "DAS6402 and compatible ISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for DAS6402 and compatible ISA cards
 	  Computerboards, Keithley Metrabyte DAS6402 and compatibles
@@ -414,8 +402,7 @@ config COMEDI_FL512
 
 config COMEDI_AIO_AIO12_8
 	tristate "I/O Products PC/104 AIO12-8 Analog I/O Board support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for I/O Products PC/104 AIO12-8 Analog I/O Board
@@ -469,9 +456,8 @@ config COMEDI_ADQ12B
 
 config COMEDI_NI_AT_A2150
 	tristate "NI AT-A2150 ISA card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for National Instruments AT-A2150 cards
 
@@ -480,8 +466,7 @@ config COMEDI_NI_AT_A2150
 
 config COMEDI_NI_AT_AO
 	tristate "NI AT-AO-6/10 EISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for National Instruments AT-AO-6/10 cards
 
@@ -512,7 +497,7 @@ config COMEDI_NI_ATMIO16D
 
 config COMEDI_NI_LABPC_ISA
 	tristate "NI Lab-PC and compatibles ISA support"
-	depends on COMEDI_NI_LABPC
+	select COMEDI_NI_LABPC
 	help
 	  Enable support for National Instruments Lab-PC and compatibles
 	  Lab-PC-1200, Lab-PC-1200AI, Lab-PC+.
@@ -576,7 +561,7 @@ endif # COMEDI_ISA_DRIVERS
 
 menuconfig COMEDI_PCI_DRIVERS
 	tristate "Comedi PCI drivers"
-	depends on PCI && HAS_IOPORT
+	depends on PCI
 	help
 	  Enable support for comedi PCI drivers.
 
@@ -725,8 +710,7 @@ config COMEDI_ADL_PCI8164
 
 config COMEDI_ADL_PCI9111
 	tristate "ADLink PCI-9111HR support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for ADlink PCI9111 cards
 
@@ -736,7 +720,7 @@ config COMEDI_ADL_PCI9111
 config COMEDI_ADL_PCI9118
 	tristate "ADLink PCI-9118DG, PCI-9118HG, PCI-9118HR support"
 	depends on HAS_DMA
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for ADlink PCI-9118DG, PCI-9118HG, PCI-9118HR cards
 
@@ -745,8 +729,7 @@ config COMEDI_ADL_PCI9118
 
 config COMEDI_ADV_PCI1710
 	tristate "Advantech PCI-171x and PCI-1731 support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCI-1710, PCI-1710HG, PCI-1711,
 	  PCI-1713 and PCI-1731
@@ -790,8 +773,7 @@ config COMEDI_ADV_PCI1760
 
 config COMEDI_ADV_PCI_DIO
 	tristate "Advantech PCI DIO card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Advantech PCI DIO cards
@@ -804,7 +786,7 @@ config COMEDI_ADV_PCI_DIO
 
 config COMEDI_AMPLC_DIO200_PCI
 	tristate "Amplicon PCI215/PCI272/PCIe215/PCIe236/PCIe296 DIO support"
-	depends on COMEDI_AMPLC_DIO200
+	select COMEDI_AMPLC_DIO200
 	help
 	  Enable support for Amplicon PCI215, PCI272, PCIe215, PCIe236
 	  and PCIe296 DIO boards.
@@ -832,8 +814,7 @@ config COMEDI_AMPLC_PC263_PCI
 
 config COMEDI_AMPLC_PCI224
 	tristate "Amplicon PCI224 and PCI234 support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Amplicon PCI224 and PCI234 AO boards
 
@@ -842,8 +823,7 @@ config COMEDI_AMPLC_PCI224
 
 config COMEDI_AMPLC_PCI230
 	tristate "Amplicon PCI230 and PCI260 support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Amplicon PCI230 and PCI260 Multifunction I/O
@@ -862,7 +842,7 @@ config COMEDI_CONTEC_PCI_DIO
 
 config COMEDI_DAS08_PCI
 	tristate "DAS-08 PCI support"
-	depends on COMEDI_DAS08
+	select COMEDI_DAS08
 	help
 	  Enable support for PCI DAS-08 cards.
 
@@ -949,8 +929,7 @@ config COMEDI_CB_PCIDAS64
 
 config COMEDI_CB_PCIDAS
 	tristate "MeasurementComputing PCI-DAS support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI-DAS with
@@ -974,8 +953,7 @@ config COMEDI_CB_PCIDDA
 
 config COMEDI_CB_PCIMDAS
 	tristate "MeasurementComputing PCIM-DAS1602/16, PCIe-DAS1602/16 support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI Migration
@@ -995,8 +973,7 @@ config COMEDI_CB_PCIMDDA
 
 config COMEDI_ME4000
 	tristate "Meilhaus ME-4000 support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Meilhaus PCI data acquisition cards
 	  ME-4650, ME-4670i, ME-4680, ME-4680i and ME-4680is
@@ -1054,7 +1031,7 @@ config COMEDI_NI_670X
 
 config COMEDI_NI_LABPC_PCI
 	tristate "NI Lab-PC PCI-1200 support"
-	depends on COMEDI_NI_LABPC
+	select COMEDI_NI_LABPC
 	help
 	  Enable support for National Instruments Lab-PC PCI-1200.
 
@@ -1076,7 +1053,6 @@ config COMEDI_NI_PCIDIO
 config COMEDI_NI_PCIMIO
 	tristate "NI PCI-MIO-E series and M series support"
 	depends on HAS_DMA
-	depends on HAS_IOPORT
 	select COMEDI_NI_TIOCMD
 	select COMEDI_8255
 	help
@@ -1098,8 +1074,7 @@ config COMEDI_NI_PCIMIO
 
 config COMEDI_RTD520
 	tristate "Real Time Devices PCI4520/DM7520 support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Real Time Devices PCI4520/DM7520
 
@@ -1139,8 +1114,7 @@ if COMEDI_PCMCIA_DRIVERS
 
 config COMEDI_CB_DAS16_CS
 	tristate "CB DAS16 series PCMCIA support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for the ComputerBoards/MeasurementComputing PCMCIA
 	  cards DAS16/16, PCM-DAS16D/12 and PCM-DAS16s/16
@@ -1150,7 +1124,7 @@ config COMEDI_CB_DAS16_CS
 
 config COMEDI_DAS08_CS
 	tristate "CB DAS08 PCMCIA support"
-	depends on COMEDI_DAS08
+	select COMEDI_DAS08
 	help
 	  Enable support for the ComputerBoards/MeasurementComputing DAS-08
 	  PCMCIA card
@@ -1160,7 +1134,6 @@ config COMEDI_DAS08_CS
 
 config COMEDI_NI_DAQ_700_CS
 	tristate "NI DAQCard-700 PCMCIA support"
-	depends on HAS_IOPORT
 	help
 	  Enable support for the National Instruments PCMCIA DAQCard-700 DIO
 
@@ -1169,7 +1142,6 @@ config COMEDI_NI_DAQ_700_CS
 
 config COMEDI_NI_DAQ_DIO24_CS
 	tristate "NI DAQ-Card DIO-24 PCMCIA support"
-	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for the National Instruments PCMCIA DAQ-Card DIO-24
@@ -1179,7 +1151,7 @@ config COMEDI_NI_DAQ_DIO24_CS
 
 config COMEDI_NI_LABPC_CS
 	tristate "NI DAQCard-1200 PCMCIA support"
-	depends on COMEDI_NI_LABPC
+	select COMEDI_NI_LABPC
 	help
 	  Enable support for the National Instruments PCMCIA DAQCard-1200
 
@@ -1188,7 +1160,6 @@ config COMEDI_NI_LABPC_CS
 
 config COMEDI_NI_MIO_CS
 	tristate "NI DAQCard E series PCMCIA support"
-	depends on HAS_IOPORT
 	select COMEDI_NI_TIO
 	select COMEDI_8255
 	help
@@ -1201,7 +1172,6 @@ config COMEDI_NI_MIO_CS
 
 config COMEDI_QUATECH_DAQP_CS
 	tristate "Quatech DAQP PCMCIA data capture card support"
-	depends on HAS_IOPORT
 	help
 	  Enable support for the Quatech DAQP PCMCIA data capture cards
 	  DAQP-208 and DAQP-308
@@ -1278,14 +1248,12 @@ endif # COMEDI_USB_DRIVERS
 
 config COMEDI_8254
 	tristate
-	depends on HAS_IOPORT
 
 config COMEDI_8255
 	tristate
 
 config COMEDI_8255_SA
 	tristate "Standalone 8255 support"
-	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for 8255 digital I/O as a standalone driver.
@@ -1317,7 +1285,7 @@ config COMEDI_KCOMEDILIB
 	  called kcomedilib.
 
 config COMEDI_AMPLC_DIO200
-	depends on COMEDI_8254
+	select COMEDI_8254
 	tristate
 
 config COMEDI_AMPLC_PC236
@@ -1326,7 +1294,7 @@ config COMEDI_AMPLC_PC236
 
 config COMEDI_DAS08
 	tristate
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 
 config COMEDI_ISADMA
@@ -1334,8 +1302,7 @@ config COMEDI_ISADMA
 
 config COMEDI_NI_LABPC
 	tristate
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 
 config COMEDI_NI_LABPC_ISADMA
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index a3104e35412c..aa597cda0d88 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -1211,7 +1211,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 		 * without actually having a link.
 		 */
  create:
-		device = kzalloc(sizeof(*device), GFP_KERNEL);
+		device = kzalloc(sizeof(*device), GFP_ATOMIC);
 		if (device == NULL)
 			break;
 
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 88466b663482..f40c81534381 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -101,7 +101,7 @@ static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
 {
 	struct fw_node *node;
 
-	node = kzalloc(struct_size(node, ports, port_count), GFP_KERNEL);
+	node = kzalloc(struct_size(node, ports, port_count), GFP_ATOMIC);
 	if (node == NULL)
 		return NULL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6dc950c1b689..a3b86b86dc47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1296,7 +1296,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
-bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index fb78a8f47587..946d031d2520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -127,7 +127,6 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	struct drm_gem_object *gobj;
 	struct amdgpu_bo *bo;
 	unsigned long size;
-	int r;
 
 	gobj = drm_gem_object_lookup(p->filp, data->handle);
 	if (gobj == NULL)
@@ -139,23 +138,14 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
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
 
 static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6e5e4603a51a..2168dc92c670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1461,32 +1461,6 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
-/*
- * On APUs with >= 64GB white flickering has been observed w/ SG enabled.
- * Disable S/G on such systems until we have a proper fix.
- * https://gitlab.freedesktop.org/drm/amd/-/issues/2354
- * https://gitlab.freedesktop.org/drm/amd/-/issues/2735
- */
-bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
-{
-	switch (amdgpu_sg_display) {
-	case -1:
-		break;
-	case 0:
-		return false;
-	case 1:
-		return true;
-	default:
-		return false;
-	}
-	if ((totalram_pages() << (PAGE_SHIFT - 10)) +
-	    (adev->gmc.real_vram_size / 1024) >= 64000000) {
-		DRM_WARN("Disabling S/G due to >=64GB RAM\n");
-		return false;
-	}
-	return true;
-}
-
 /*
  * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
  * speed switching. Until we have confirmation from Intel that a specific host
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index fceb3b384955..f3b0aaf3ebc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -138,6 +138,7 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 /**
  * amdgpu_ih_ring_write - write IV to the ring buffer
  *
+ * @adev: amdgpu_device pointer
  * @ih: ih ring to write to
  * @iv: the iv to write
  * @num_dw: size of the iv in dw
@@ -145,8 +146,8 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
  * Writes an IV to the ring buffer using the CPU and increment the wptr.
  * Used for testing and delegating IVs to a software ring.
  */
-void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
-			  unsigned int num_dw)
+void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
+			  const uint32_t *iv, unsigned int num_dw)
 {
 	uint32_t wptr = le32_to_cpu(*ih->wptr_cpu) >> 2;
 	unsigned int i;
@@ -161,6 +162,9 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	if (wptr != READ_ONCE(ih->rptr)) {
 		wmb();
 		WRITE_ONCE(*ih->wptr_cpu, cpu_to_le32(wptr));
+	} else if (adev->irq.retry_cam_enabled) {
+		dev_warn_once(adev->dev, "IH soft ring buffer overflow 0x%X, 0x%X\n",
+			      wptr, ih->rptr);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index dd1c2eded6b9..6c6184f0dbc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -27,6 +27,9 @@
 /* Maximum number of IVs processed at once */
 #define AMDGPU_IH_MAX_NUM_IVS	32
 
+#define IH_RING_SIZE	(256 * 1024)
+#define IH_SW_RING_SIZE	(8 * 1024)	/* enough for 256 CAM entries */
+
 struct amdgpu_device;
 struct amdgpu_iv_entry;
 
@@ -97,8 +100,8 @@ struct amdgpu_ih_funcs {
 int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 			unsigned ring_size, bool use_bus_addr);
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
-void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
-			  unsigned int num_dw);
+void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
+			  const uint32_t *iv, unsigned int num_dw);
 int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
 					    struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5273decc5753..fa6d0adcec20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -493,7 +493,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 			 struct amdgpu_iv_entry *entry,
 			 unsigned int num_dw)
 {
-	amdgpu_ih_ring_write(&adev->irq.ih_soft, entry->iv_entry, num_dw);
+	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
 	schedule_work(&adev->irq.ih_soft_work);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index c6b4337eb20c..10df731998b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -81,7 +81,7 @@ int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
 		     unsigned int size)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, true, 0);
+						   GFP_KERNEL, false, 0);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 72b629a78c62..d0fc62784e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -134,7 +134,7 @@ static int aqua_vanjaram_xcp_sched_list_update(
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		ring = adev->rings[i];
-		if (!ring || !ring->sched.ready)
+		if (!ring || !ring->sched.ready || ring->no_scheduler)
 			continue;
 
 		aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index b02e1cef78a7..980b24120080 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -535,7 +535,7 @@ static int ih_v6_0_sw_init(void *handle)
 	 * use bus address for ih ring by psp bl */
 	use_bus_addr =
 		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -548,7 +548,7 @@ static int ih_v6_0_sw_init(void *handle)
 	/* initialize ih control register offset */
 	ih_v6_0_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index eec13cb5bf75..b6a8478dabf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -565,7 +565,7 @@ static int navi10_ih_sw_init(void *handle)
 		use_bus_addr = false;
 	else
 		use_bus_addr = true;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -578,7 +578,7 @@ static int navi10_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	navi10_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 1e83db0c5438..d364c6dd152c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -485,7 +485,7 @@ static int vega10_ih_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, true);
 	if (r)
 		return r;
 
@@ -510,7 +510,7 @@ static int vega10_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega10_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 4d719df376a7..544ee55a22da 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -539,7 +539,7 @@ static int vega20_ih_sw_init(void *handle)
 	    (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2)))
 		use_bus_addr = false;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -565,7 +565,7 @@ static int vega20_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega20_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d4c9ee3f9953..1282559d2b10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1487,8 +1487,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
-	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
 	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
 	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3123ea2f4f30..e0d556cf919f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1272,11 +1272,15 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
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
@@ -1638,8 +1642,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		}
 		break;
 	}
-	if (init_data.flags.gpu_vm_support)
-		init_data.flags.gpu_vm_support = amdgpu_sg_display_supported(adev);
+	if (init_data.flags.gpu_vm_support &&
+	    (amdgpu_sg_display == 0))
+		init_data.flags.gpu_vm_support = false;
 
 	if (init_data.flags.gpu_vm_support)
 		adev->mode_info.gpu_vm_support = true;
@@ -2328,14 +2333,62 @@ static int dm_late_init(void *handle)
 	return detect_mst_link_for_all_connectors(adev_to_drm(adev));
 }
 
+static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
+{
+	int ret;
+	u8 guid[16];
+	u64 tmp64;
+
+	mutex_lock(&mgr->lock);
+	if (!mgr->mst_primary)
+		goto out_fail;
+
+	if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
+		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
+		goto out_fail;
+	}
+
+	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
+				 DP_MST_EN |
+				 DP_UP_REQ_EN |
+				 DP_UPSTREAM_IS_SRC);
+	if (ret < 0) {
+		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");
+		goto out_fail;
+	}
+
+	/* Some hubs forget their guids after they resume */
+	ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
+	if (ret != 16) {
+		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
+		goto out_fail;
+	}
+
+	if (memchr_inv(guid, 0, 16) == NULL) {
+		tmp64 = get_jiffies_64();
+		memcpy(&guid[0], &tmp64, sizeof(u64));
+		memcpy(&guid[8], &tmp64, sizeof(u64));
+
+		ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
+
+		if (ret != 16) {
+			drm_dbg_kms(mgr->dev, "check mstb guid failed - undocked during suspend?\n");
+			goto out_fail;
+		}
+	}
+
+	memcpy(mgr->mst_primary->guid, guid, 16);
+
+out_fail:
+	mutex_unlock(&mgr->lock);
+}
+
 static void s3_handle_mst(struct drm_device *dev, bool suspend)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct drm_dp_mst_topology_mgr *mgr;
-	int ret;
-	bool need_hotplug = false;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -2357,18 +2410,15 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 			if (!dp_is_lttpr_present(aconnector->dc_link))
 				try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
-			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
-			if (ret < 0) {
-				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
-					aconnector->dc_link);
-				need_hotplug = true;
-			}
+			/* TODO: move resume_mst_branch_status() into drm mst resume again
+			 * once topology probing work is pulled out from mst resume into mst
+			 * resume 2nd step. mst resume 2nd step should be called after old
+			 * state getting restored (i.e. drm_atomic_helper_resume()).
+			 */
+			resume_mst_branch_status(mgr);
 		}
 	}
 	drm_connector_list_iter_end(&iter);
-
-	if (need_hotplug)
-		drm_kms_helper_hotplug_event(dev);
 }
 
 static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
@@ -2762,7 +2812,8 @@ static int dm_resume(void *handle)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j;
+	int i, r, j, ret;
+	bool need_hotplug = false;
 
 	if (amdgpu_in_reset(adev)) {
 		dc_state = dm->cached_dc_state;
@@ -2860,7 +2911,7 @@ static int dm_resume(void *handle)
 			continue;
 
 		/*
-		 * this is the case when traversing through already created
+		 * this is the case when traversing through already created end sink
 		 * MST connectors, should be skipped
 		 */
 		if (aconnector && aconnector->mst_root)
@@ -2920,6 +2971,27 @@ static int dm_resume(void *handle)
 
 	dm->cached_state = NULL;
 
+	/* Do mst topology probing after resuming cached state*/
+	drm_connector_list_iter_begin(ddev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (aconnector->dc_link->type != dc_connection_mst_branch ||
+		    aconnector->mst_root)
+			continue;
+
+		ret = drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr, true);
+
+		if (ret < 0) {
+			dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
+					aconnector->dc_link);
+			need_hotplug = true;
+		}
+	}
+	drm_connector_list_iter_end(&iter);
+
+	if (need_hotplug)
+		drm_kms_helper_hotplug_event(ddev);
+
 	amdgpu_dm_irq_resume_late(adev);
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index cb992aca760d..5fc78bf927bb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -802,7 +802,7 @@ static void dcn32_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current
 					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 		else
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
+					clk_mgr_base->bw_params->max_memclk_mhz);
 	} else {
 		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 30c0644d4418..be5a6d008b29 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -169,11 +169,23 @@ static void add_link_enc_assignment(
 /* Return first available DIG link encoder. */
 static enum engine_id find_first_avail_link_enc(
 		const struct dc_context *ctx,
-		const struct dc_state *state)
+		const struct dc_state *state,
+		enum engine_id eng_id_requested)
 {
 	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
 	int i;
 
+	if (eng_id_requested != ENGINE_ID_UNKNOWN) {
+
+		for (i = 0; i < ctx->dc->res_pool->res_cap->num_dig_link_enc; i++) {
+			eng_id = state->res_ctx.link_enc_cfg_ctx.link_enc_avail[i];
+			if (eng_id == eng_id_requested)
+				return eng_id;
+		}
+	}
+
+	eng_id = ENGINE_ID_UNKNOWN;
+
 	for (i = 0; i < ctx->dc->res_pool->res_cap->num_dig_link_enc; i++) {
 		eng_id = state->res_ctx.link_enc_cfg_ctx.link_enc_avail[i];
 		if (eng_id != ENGINE_ID_UNKNOWN)
@@ -287,7 +299,7 @@ void link_enc_cfg_link_encs_assign(
 		struct dc_stream_state *streams[],
 		uint8_t stream_count)
 {
-	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
+	enum engine_id eng_id = ENGINE_ID_UNKNOWN, eng_id_req = ENGINE_ID_UNKNOWN;
 	int i;
 	int j;
 
@@ -377,8 +389,14 @@ void link_enc_cfg_link_encs_assign(
 		 * assigned to that endpoint.
 		 */
 		link_enc = get_link_enc_used_by_link(state, stream->link);
-		if (link_enc == NULL)
-			eng_id = find_first_avail_link_enc(stream->ctx, state);
+		if (link_enc == NULL) {
+
+			if (stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+					stream->link->dpia_preferred_eng_id != ENGINE_ID_UNKNOWN)
+				eng_id_req = stream->link->dpia_preferred_eng_id;
+
+			eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
+		}
 		else
 			eng_id =  link_enc->preferred_engine;
 
@@ -402,7 +420,9 @@ void link_enc_cfg_link_encs_assign(
 			DC_LOG_DEBUG("%s: CUR %s(%d) - enc_id(%d)\n",
 					__func__,
 					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ? "PHY" : "DPIA",
-					assignment.ep_id.link_id.enum_id - 1,
+					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ?
+							assignment.ep_id.link_id.enum_id :
+							assignment.ep_id.link_id.enum_id - 1,
 					assignment.eng_id);
 	}
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -413,7 +433,9 @@ void link_enc_cfg_link_encs_assign(
 			DC_LOG_DEBUG("%s: NEW %s(%d) - enc_id(%d)\n",
 					__func__,
 					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ? "PHY" : "DPIA",
-					assignment.ep_id.link_id.enum_id - 1,
+					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ?
+							assignment.ep_id.link_id.enum_id :
+							assignment.ep_id.link_id.enum_id - 1,
 					assignment.eng_id);
 	}
 
@@ -478,7 +500,6 @@ struct dc_link *link_enc_cfg_get_link_using_link_enc(
 	if (stream)
 		link = stream->link;
 
-	// dm_output_to_console("%s: No link using DIG(%d).\n", __func__, eng_id);
 	return link;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 63948170fd6d..81258392d44a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1479,6 +1479,7 @@ struct dc_link {
 	 * object creation.
 	 */
 	enum engine_id eng_id;
+	enum engine_id dpia_preferred_eng_id;
 
 	bool test_pattern_enabled;
 	union compliance_test_state compliance_test_state;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 6a9024aa3285..e79e1d690afa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1029,6 +1029,28 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCN30(_MASK)
 };
 
+/* ========================================================== */
+
+/*
+ * DPIA index | Preferred Encoder     |    Host Router
+ *   0        |      C                |       0
+ *   1        |      First Available  |       0
+ *   2        |      D                |       1
+ *   3        |      First Available  |       1
+ */
+/* ========================================================== */
+static const enum engine_id dpia_to_preferred_enc_id_table[] = {
+		ENGINE_ID_DIGC,
+		ENGINE_ID_DIGC,
+		ENGINE_ID_DIGD,
+		ENGINE_ID_DIGD
+};
+
+static enum engine_id dcn314_get_preferred_eng_id_dpia(unsigned int dpia_index)
+{
+	return dpia_to_preferred_enc_id_table[dpia_index];
+}
+
 static struct dce_i2c_hw *dcn31_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -1777,6 +1799,7 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.update_bw_bounding_box = dcn314_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn314_get_panel_config_defaults,
+	.get_preferred_eng_id_dpia = dcn314_get_preferred_eng_id_dpia,
 };
 
 static struct clock_source *dcn30_clock_source_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 61ceff6bc0b1..921f58c0c729 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -281,7 +281,8 @@ static void dccg32_set_dpstreamclk(
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	/* set the dtbclk_p source */
-	dccg32_set_dtbclk_p_src(dccg, src, otg_inst);
+	/* always program refclk as DTBCLK. No use-case expected to require DPREFCLK as refclk */
+	dccg32_set_dtbclk_p_src(dccg, DTBCLK0, otg_inst);
 
 	/* enabled to select one of the DTBCLKs for pipe */
 	switch (dp_hpo_inst) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 43016c462251..9d996d5fc3ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -4135,7 +4135,9 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN31_MAX_FMT_420_BUFFER_WIDTH
 						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
-					if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
+					if (v->Output[k] == dm_hdmi) {
+						FMTBufferExceeded = true;
+					} else if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
 						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
 						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 9010c47476e9..b763786bfcc8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -4227,7 +4227,9 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 				}
 				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN314_MAX_FMT_420_BUFFER_WIDTH
 						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
-					if (v->HActive[k] / 2 > DCN314_MAX_FMT_420_BUFFER_WIDTH) {
+					if (v->Output[k] == dm_hdmi) {
+						FMTBufferExceeded = true;
+					} else if (v->HActive[k] / 2 > DCN314_MAX_FMT_420_BUFFER_WIDTH) {
 						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
 						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index a50e7f4dce42..f74e5fc8218f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3459,6 +3459,7 @@ bool dml32_CalculatePrefetchSchedule(
 	double TimeForFetchingMetaPTE = 0;
 	double TimeForFetchingRowInVBlank = 0;
 	double LinesToRequestPrefetchPixelData = 0;
+	double LinesForPrefetchBandwidth = 0;
 	unsigned int HostVMDynamicLevelsTrips;
 	double  trip_to_mem;
 	double  Tvm_trips;
@@ -3888,11 +3889,15 @@ bool dml32_CalculatePrefetchSchedule(
 			TimeForFetchingMetaPTE = Tvm_oto;
 			TimeForFetchingRowInVBlank = Tr0_oto;
 			*PrefetchBandwidth = prefetch_bw_oto;
+			/* Clamp to oto for bandwidth calculation */
+			LinesForPrefetchBandwidth = dst_y_prefetch_oto;
 		} else {
 			*DestinationLinesForPrefetch = dst_y_prefetch_equ;
 			TimeForFetchingMetaPTE = Tvm_equ;
 			TimeForFetchingRowInVBlank = Tr0_equ;
 			*PrefetchBandwidth = prefetch_bw_equ;
+			/* Clamp to equ for bandwidth calculation */
+			LinesForPrefetchBandwidth = dst_y_prefetch_equ;
 		}
 
 		*DestinationLinesToRequestVMInVBlank = dml_ceil(4.0 * TimeForFetchingMetaPTE / LineTime, 1.0) / 4.0;
@@ -3900,7 +3905,7 @@ bool dml32_CalculatePrefetchSchedule(
 		*DestinationLinesToRequestRowInVBlank =
 				dml_ceil(4.0 * TimeForFetchingRowInVBlank / LineTime, 1.0) / 4.0;
 
-		LinesToRequestPrefetchPixelData = *DestinationLinesForPrefetch -
+		LinesToRequestPrefetchPixelData = LinesForPrefetchBandwidth -
 				*DestinationLinesToRequestVMInVBlank - 2 * *DestinationLinesToRequestRowInVBlank;
 
 #ifdef __DML_VBA_DEBUG__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 034610b74a37..3752410bc987 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -65,6 +65,7 @@ struct resource_context;
 struct clk_bw_params;
 
 struct resource_funcs {
+	enum engine_id (*get_preferred_eng_id_dpia)(unsigned int dpia_index);
 	void (*destroy)(struct resource_pool **pool);
 	void (*link_init)(struct dc_link *link);
 	struct panel_cntl*(*panel_cntl_create)(
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index ac1c3e2e7c1d..a1b800dceb65 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -783,6 +783,10 @@ static bool construct_dpia(struct dc_link *link,
 	/* Set dpia port index : 0 to number of dpia ports */
 	link->ddc_hw_inst = init_params->connector_index;
 
+	// Assign Dpia preferred eng_id
+	if (link->dc->res_pool->funcs->get_preferred_eng_id_dpia)
+		link->dpia_preferred_eng_id = link->dc->res_pool->funcs->get_preferred_eng_id_dpia(link->ddc_hw_inst);
+
 	/* TODO: Create link encoder */
 
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 73ec60757dbc..9e253af69c7a 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1009,7 +1009,7 @@ static int samsung_dsim_wait_for_hdr_fifo(struct samsung_dsim *dsi)
 	do {
 		u32 reg = samsung_dsim_read(dsi, DSIM_FIFOCTRL_REG);
 
-		if (!(reg & DSIM_SFR_HEADER_FULL))
+		if (reg & DSIM_SFR_HEADER_EMPTY)
 			return 0;
 
 		if (!cond_resched())
diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 5641395fd310..11445c50956e 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -231,7 +231,7 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_LPM;
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO_HSE;
 
 	ret = tc358762_parse_dt(ctx);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 1f470968ed14..9271e47d6657 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -230,6 +230,7 @@ static const struct edid_quirk {
 
 	/* OSVR HDK and HDK2 VR Headsets */
 	EDID_QUIRK('S', 'V', 'R', 0x1019, EDID_QUIRK_NON_DESKTOP),
+	EDID_QUIRK('A', 'U', 'O', 0x1111, EDID_QUIRK_NON_DESKTOP),
 };
 
 /*
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
diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 34a397adbd6b..cc893c9730bf 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -3659,6 +3659,27 @@ enum aux_ch intel_bios_dp_aux_ch(const struct intel_bios_encoder_data *devdata)
 	return map_aux_ch(devdata->i915, devdata->child.aux_channel);
 }
 
+bool intel_bios_dp_has_shared_aux_ch(const struct intel_bios_encoder_data *devdata)
+{
+	struct drm_i915_private *i915;
+	u8 aux_channel;
+	int count = 0;
+
+	if (!devdata || !devdata->child.aux_channel)
+		return false;
+
+	i915 = devdata->i915;
+	aux_channel = devdata->child.aux_channel;
+
+	list_for_each_entry(devdata, &i915->display.vbt.display_devices, node) {
+		if (intel_bios_encoder_supports_dp(devdata) &&
+		    aux_channel == devdata->child.aux_channel)
+			count++;
+	}
+
+	return count > 1;
+}
+
 int intel_bios_dp_boost_level(const struct intel_bios_encoder_data *devdata)
 {
 	if (!devdata || devdata->i915->display.vbt.version < 196 || !devdata->child.iboost)
diff --git a/drivers/gpu/drm/i915/display/intel_bios.h b/drivers/gpu/drm/i915/display/intel_bios.h
index 45fae97d9719..f60da533949d 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.h
+++ b/drivers/gpu/drm/i915/display/intel_bios.h
@@ -271,6 +271,7 @@ enum aux_ch intel_bios_dp_aux_ch(const struct intel_bios_encoder_data *devdata);
 int intel_bios_dp_boost_level(const struct intel_bios_encoder_data *devdata);
 int intel_bios_dp_max_lane_count(const struct intel_bios_encoder_data *devdata);
 int intel_bios_dp_max_link_rate(const struct intel_bios_encoder_data *devdata);
+bool intel_bios_dp_has_shared_aux_ch(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_boost_level(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_ddc_pin(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_level_shift(const struct intel_bios_encoder_data *devdata);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 9f40da20e88d..cb55112d6065 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5503,8 +5503,13 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	/*
 	 * VBT and straps are liars. Also check HPD as that seems
 	 * to be the most reliable piece of information available.
+	 *
+	 * ... expect on devices that forgot to hook HPD up for eDP
+	 * (eg. Acer Chromebook C710), so we'll check it only if multiple
+	 * ports are attempting to use the same AUX CH, according to VBT.
 	 */
-	if (!intel_digital_port_connected(encoder)) {
+	if (intel_bios_dp_has_shared_aux_ch(encoder->devdata) &&
+	    !intel_digital_port_connected(encoder)) {
 		/*
 		 * If this fails, presume the DPCD answer came
 		 * from some other port using the same AUX CH.
diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index c58b775877a3..076aa5491057 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -847,7 +847,7 @@ static int mtk_dp_aux_do_transfer(struct mtk_dp *mtk_dp, bool is_read, u8 cmd,
 		u32 phy_status = mtk_dp_read(mtk_dp, MTK_DP_AUX_P0_3628) &
 				 AUX_RX_PHY_STATE_AUX_TX_P0_MASK;
 		if (phy_status != AUX_RX_PHY_STATE_AUX_TX_P0_RX_IDLE) {
-			drm_err(mtk_dp->drm_dev,
+			dev_err(mtk_dp->dev,
 				"AUX Rx Aux hang, need SW reset\n");
 			return -EIO;
 		}
@@ -2062,7 +2062,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 		is_read = true;
 		break;
 	default:
-		drm_err(mtk_aux->drm_dev, "invalid aux cmd = %d\n",
+		dev_err(mtk_dp->dev, "invalid aux cmd = %d\n",
 			msg->request);
 		ret = -EINVAL;
 		goto err;
@@ -2078,7 +2078,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 					     to_access, &msg->reply);
 
 		if (ret) {
-			drm_info(mtk_dp->drm_dev,
+			dev_info(mtk_dp->dev,
 				 "Failed to do AUX transfer: %d\n", ret);
 			goto err;
 		}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a2513f716823..f6c614764017 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2489,8 +2489,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	/* Quirk data */
 	adreno_gpu->info = info;
 
-	if (adreno_is_a650(adreno_gpu) || adreno_is_a660_family(adreno_gpu))
-		adreno_gpu->base.hw_apriv = true;
+	adreno_gpu->base.hw_apriv = !!(info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
 
 	a6xx_llc_slices_init(pdev, a6xx_gpu);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 6e3c1368c5e1..b2283faa173a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -275,6 +275,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 	}, {
 		.rev = ADRENO_REV(6, 1, 9, ANY_ID),
@@ -286,6 +287,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a615_zap.mdt",
 		.hwcg = a615_hwcg,
@@ -299,6 +301,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a630_zap.mdt",
 		.hwcg = a630_hwcg,
@@ -312,6 +315,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a640_zap.mdt",
 		.hwcg = a640_hwcg,
@@ -325,6 +329,8 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M + SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a650_zap.mdt",
 		.hwcg = a650_hwcg,
@@ -339,6 +345,8 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M + SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mdt",
 		.hwcg = a660_hwcg,
@@ -351,6 +359,8 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.hwcg = a660_hwcg,
 		.address_space_size = SZ_16G,
@@ -364,6 +374,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_2M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a640_zap.mdt",
 		.hwcg = a640_hwcg,
@@ -375,6 +386,8 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_4M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a690_zap.mdt",
 		.hwcg = a690_hwcg,
@@ -586,9 +599,9 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	if (config.rev.core >= 6)
-		if (!adreno_has_gmu_wrapper(to_adreno_gpu(gpu)))
-			priv->has_cached_coherent = true;
+	priv->has_cached_coherent =
+		!!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT) &&
+		!adreno_has_gmu_wrapper(to_adreno_gpu(gpu));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 845019891ad1..129771563f3f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -32,6 +32,8 @@ enum {
 #define ADRENO_QUIRK_TWO_PASS_USE_WFI		BIT(0)
 #define ADRENO_QUIRK_FAULT_DETECT_MASK		BIT(1)
 #define ADRENO_QUIRK_LMLOADKILL_DISABLE		BIT(2)
+#define ADRENO_QUIRK_HAS_HW_APRIV		BIT(3)
+#define ADRENO_QUIRK_HAS_CACHED_COHERENT	BIT(4)
 
 struct adreno_rev {
 	uint8_t  core;
diff --git a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
index c87a57c9c592..22dd8b445685 100644
--- a/drivers/gpu/drm/radeon/radeon_sa.c
+++ b/drivers/gpu/drm/radeon/radeon_sa.c
@@ -123,7 +123,7 @@ int radeon_sa_bo_new(struct radeon_sa_manager *sa_manager,
 		     unsigned int size, unsigned int align)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, true, align);
+						   GFP_KERNEL, false, align);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;
diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index c5bb683e440c..0187539ff5ea 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -70,10 +70,10 @@ MODULE_PARM_DESC(eco_mode, "Turn on Eco mode (less bright, more silent)");
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
@@ -389,7 +389,7 @@ static void gm12u320_fb_update_work(struct work_struct *work)
 	 * switches back to showing its logo.
 	 */
 	queue_delayed_work(system_long_wq, &gm12u320->fb_update.work,
-			   IDLE_TIMEOUT);
+			   msecs_to_jiffies(IDLE_TIMEOUT));
 
 	return;
 err:
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 2e5acfeb76c8..5a416b39b818 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -698,13 +698,16 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 
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
index 5fac448c28fd..1afbc4f7c6e7 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -28,6 +28,7 @@ static LIST_HEAD(icc_providers);
 static int providers_count;
 static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
+static DEFINE_MUTEX(icc_bw_lock);
 static struct dentry *icc_debugfs_dir;
 
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
@@ -631,7 +632,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
 		return -EINVAL;
 
-	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
 
 	old_avg = path->reqs[0].avg_bw;
 	old_peak = path->reqs[0].peak_bw;
@@ -663,7 +664,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 		apply_constraints(path);
 	}
 
-	mutex_unlock(&icc_lock);
+	mutex_unlock(&icc_bw_lock);
 
 	trace_icc_set_bw_end(path, ret);
 
@@ -872,6 +873,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 		return;
 
 	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
 
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
@@ -900,6 +902,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
+	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
@@ -1025,6 +1028,7 @@ void icc_sync_state(struct device *dev)
 		return;
 
 	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
 	synced_state = true;
 	list_for_each_entry(p, &icc_providers, provider_list) {
 		dev_dbg(p->dev, "interconnect provider is in synced state\n");
@@ -1037,13 +1041,21 @@ void icc_sync_state(struct device *dev)
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
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 0d93661f88d3..095b9b49aa82 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -214,6 +214,7 @@ struct dm_table {
 
 	/* a list of devices used by this table */
 	struct list_head devices;
+	struct rw_semaphore devices_lock;
 
 	/* events get handed up using this callback */
 	void (*event_fn)(void *data);
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index f5ed729a8e0c..21ebb6c39394 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1630,6 +1630,8 @@ static void retrieve_deps(struct dm_table *table,
 	struct dm_dev_internal *dd;
 	struct dm_target_deps *deps;
 
+	down_read(&table->devices_lock);
+
 	deps = get_result_buffer(param, param_size, &len);
 
 	/*
@@ -1644,7 +1646,7 @@ static void retrieve_deps(struct dm_table *table,
 	needed = struct_size(deps, dev, count);
 	if (len < needed) {
 		param->flags |= DM_BUFFER_FULL_FLAG;
-		return;
+		goto out;
 	}
 
 	/*
@@ -1656,6 +1658,9 @@ static void retrieve_deps(struct dm_table *table,
 		deps->dev[count++] = huge_encode_dev(dd->dm_dev->bdev->bd_dev);
 
 	param->data_size = param->data_start + needed;
+
+out:
+	up_read(&table->devices_lock);
 }
 
 static int table_deps(struct file *filp, struct dm_ioctl *param, size_t param_size)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 7d208b2b1a19..37b48f63ae6a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -135,6 +135,7 @@ int dm_table_create(struct dm_table **result, blk_mode_t mode,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&t->devices);
+	init_rwsem(&t->devices_lock);
 
 	if (!num_targets)
 		num_targets = KEYS_PER_NODE;
@@ -359,16 +360,20 @@ int __ref dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 	if (dev == disk_devt(t->md->disk))
 		return -EINVAL;
 
+	down_write(&t->devices_lock);
+
 	dd = find_device(&t->devices, dev);
 	if (!dd) {
 		dd = kmalloc(sizeof(*dd), GFP_KERNEL);
-		if (!dd)
-			return -ENOMEM;
+		if (!dd) {
+			r = -ENOMEM;
+			goto unlock_ret_r;
+		}
 
 		r = dm_get_table_device(t->md, dev, mode, &dd->dm_dev);
 		if (r) {
 			kfree(dd);
-			return r;
+			goto unlock_ret_r;
 		}
 
 		refcount_set(&dd->count, 1);
@@ -378,12 +383,17 @@ int __ref dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
 		r = upgrade_mode(dd, mode, t->md);
 		if (r)
-			return r;
+			goto unlock_ret_r;
 	}
 	refcount_inc(&dd->count);
 out:
+	up_write(&t->devices_lock);
 	*result = dd->dm_dev;
 	return 0;
+
+unlock_ret_r:
+	up_write(&t->devices_lock);
+	return r;
 }
 EXPORT_SYMBOL(dm_get_device);
 
@@ -419,9 +429,12 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
 void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 {
 	int found = 0;
-	struct list_head *devices = &ti->table->devices;
+	struct dm_table *t = ti->table;
+	struct list_head *devices = &t->devices;
 	struct dm_dev_internal *dd;
 
+	down_write(&t->devices_lock);
+
 	list_for_each_entry(dd, devices, list) {
 		if (dd->dm_dev == d) {
 			found = 1;
@@ -430,14 +443,17 @@ void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 	}
 	if (!found) {
 		DMERR("%s: device %s not in table devices list",
-		      dm_device_name(ti->table->md), d->name);
-		return;
+		      dm_device_name(t->md), d->name);
+		goto unlock_ret;
 	}
 	if (refcount_dec_and_test(&dd->count)) {
-		dm_put_table_device(ti->table->md, d);
+		dm_put_table_device(t->md, d);
 		list_del(&dd->list);
 		kfree(dd);
 	}
+
+unlock_ret:
+	up_write(&t->devices_lock);
 }
 EXPORT_SYMBOL(dm_put_device);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f0f118ab20fa..64a1f306c96c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -715,24 +715,6 @@ static void dm_put_live_table_fast(struct mapped_device *md) __releases(RCU)
 	rcu_read_unlock();
 }
 
-static inline struct dm_table *dm_get_live_table_bio(struct mapped_device *md,
-					int *srcu_idx, blk_opf_t bio_opf)
-{
-	if (bio_opf & REQ_NOWAIT)
-		return dm_get_live_table_fast(md);
-	else
-		return dm_get_live_table(md, srcu_idx);
-}
-
-static inline void dm_put_live_table_bio(struct mapped_device *md, int srcu_idx,
-					 blk_opf_t bio_opf)
-{
-	if (bio_opf & REQ_NOWAIT)
-		dm_put_live_table_fast(md);
-	else
-		dm_put_live_table(md, srcu_idx);
-}
-
 static char *_dm_claim_ptr = "I belong to device-mapper";
 
 /*
@@ -1833,9 +1815,8 @@ static void dm_submit_bio(struct bio *bio)
 	struct mapped_device *md = bio->bi_bdev->bd_disk->private_data;
 	int srcu_idx;
 	struct dm_table *map;
-	blk_opf_t bio_opf = bio->bi_opf;
 
-	map = dm_get_live_table_bio(md, &srcu_idx, bio_opf);
+	map = dm_get_live_table(md, &srcu_idx);
 
 	/* If suspended, or map not yet available, queue this IO for later */
 	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags)) ||
@@ -1851,7 +1832,7 @@ static void dm_submit_bio(struct bio *bio)
 
 	dm_split_and_process_bio(md, map, bio);
 out:
-	dm_put_live_table_bio(md, srcu_idx, bio_opf);
+	dm_put_live_table(md, srcu_idx);
 }
 
 static bool dm_poll_dm_io(struct dm_io *io, struct io_comp_batch *iob,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2a4a3d3039fa..78d51dddf3a0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -798,14 +798,14 @@ void mddev_unlock(struct mddev *mddev)
 	} else
 		mutex_unlock(&mddev->reconfig_mutex);
 
+	md_wakeup_thread(mddev->thread);
+	wake_up(&mddev->sb_wait);
+
 	list_for_each_entry_safe(rdev, tmp, &delete, same_set) {
 		list_del_init(&rdev->same_set);
 		kobject_del(&rdev->kobj);
 		export_rdev(rdev, mddev);
 	}
-
-	md_wakeup_thread(mddev->thread);
-	wake_up(&mddev->sb_wait);
 }
 EXPORT_SYMBOL_GPL(mddev_unlock);
 
@@ -2452,7 +2452,8 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	blkdev_put(rdev->bdev, mddev->external ? &claim_rdev : rdev);
+	blkdev_put(rdev->bdev,
+		   test_bit(Holder, &rdev->flags) ? rdev : &claim_rdev);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -3632,6 +3633,7 @@ EXPORT_SYMBOL_GPL(md_rdev_init);
 static struct md_rdev *md_import_device(dev_t newdev, int super_format, int super_minor)
 {
 	struct md_rdev *rdev;
+	struct md_rdev *holder;
 	sector_t size;
 	int err;
 
@@ -3646,8 +3648,15 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
+	if (super_format == -2) {
+		holder = &claim_rdev;
+	} else {
+		holder = rdev;
+		set_bit(Holder, &rdev->flags);
+	}
+
 	rdev->bdev = blkdev_get_by_dev(newdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-			super_format == -2 ? &claim_rdev : rdev, NULL);
+				       holder, NULL);
 	if (IS_ERR(rdev->bdev)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
 			MAJOR(newdev), MINOR(newdev));
@@ -3684,7 +3693,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	blkdev_put(rdev->bdev, super_format == -2 ? &claim_rdev : rdev);
+	blkdev_put(rdev->bdev, holder);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
@@ -8205,7 +8214,7 @@ static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	spin_unlock(&all_mddevs_lock);
 
 	if (to_put)
-		mddev_put(mddev);
+		mddev_put(to_put);
 	return next_mddev;
 
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 1aef86bf3fc3..b0a0f5a5c783 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -211,6 +211,9 @@ enum flag_bits {
 				 * check if there is collision between raid1
 				 * serial bios.
 				 */
+	Holder,			/* rdev is used as holder while opening
+				 * underlying disk exclusively.
+				 */
 };
 
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index dd25832eb045..a60acd72210a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1831,6 +1831,9 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	int number = rdev->raid_disk;
 	struct raid1_info *p = conf->mirrors + number;
 
+	if (unlikely(number >= conf->raid_disks))
+		goto abort;
+
 	if (rdev != p->rdev)
 		p = conf->mirrors + conf->raid_disks + number;
 
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index 671fc0588e43..9af2c5596121 100644
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
index dc09fbdb062b..ca51776a961f 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -355,7 +355,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
 	void __iomem *const base = cio2->base;
 	u8 lanes, csi2bus = q->csi2.port;
 	u8 sensor_vc = SENSOR_VIR_CH_DFLT;
-	struct cio2_csi2_timing timing;
+	struct cio2_csi2_timing timing = { 0 };
 	int i, r;
 
 	fmt = cio2_find_format(NULL, &q->subdev_fmt.code);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index a605e80c7dc3..b0ca2b3a8a73 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -892,11 +892,13 @@ static int mdp_get_subsys_id(struct mdp_dev *mdp, struct device *dev,
 	ret = cmdq_dev_get_client_reg(&comp_pdev->dev, &cmdq_reg, index);
 	if (ret != 0) {
 		dev_err(&comp_pdev->dev, "cmdq_dev_get_subsys fail!\n");
+		put_device(&comp_pdev->dev);
 		return -EINVAL;
 	}
 
 	comp->subsys_id = cmdq_reg.subsys;
 	dev_dbg(&comp_pdev->dev, "subsys id=%d\n", cmdq_reg.subsys);
+	put_device(&comp_pdev->dev);
 
 	return 0;
 }
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
index 1e9c8d01523b..33a2aa8907e6 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -322,6 +322,8 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3 || msg[1].len < 1)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
 			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -381,6 +383,8 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
 			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -388,10 +392,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
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
index 2dcbb49d66da..2410054ddb2c 100644
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
index 0827bf3d4e8c..13604e6acdb8 100644
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
index 970b84c3f0b5..b3bb1805829a 100644
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
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 75e427f124b2..cadd4a820c03 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -496,6 +496,7 @@ config HISI_HIKEY_USB
 config OPEN_DICE
 	tristate "Open Profile for DICE driver"
 	depends on OF_RESERVED_MEM
+	depends on HAS_IOMEM
 	help
 	  This driver exposes a DICE reserved memory region to userspace via
 	  a character device. The memory region contains Compound Device
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index eebf94604a7f..cddecc1e1ac2 100644
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
@@ -961,7 +961,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+	if ((imx_data->socdata->flags & ESDHC_FLAG_ERR010450) &&
+	    (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))) {
 		unsigned int max_clock;
 
 		max_clock = imx_data->is_ddr ? 45000000 : 150000000;
diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 656dd80a0be7..58968c1e7d2f 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -48,9 +48,11 @@ static const struct spi_nor_locking_ops at25fs_nor_locking_ops = {
 	.is_locked = at25fs_nor_is_locked,
 };
 
-static void at25fs_nor_late_init(struct spi_nor *nor)
+static int at25fs_nor_late_init(struct spi_nor *nor)
 {
 	nor->params->locking_ops = &at25fs_nor_locking_ops;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups at25fs_nor_fixups = {
@@ -149,9 +151,11 @@ static const struct spi_nor_locking_ops atmel_nor_global_protection_ops = {
 	.is_locked = atmel_nor_is_global_protected,
 };
 
-static void atmel_nor_global_protection_late_init(struct spi_nor *nor)
+static int atmel_nor_global_protection_late_init(struct spi_nor *nor)
 {
 	nor->params->locking_ops = &atmel_nor_global_protection_ops;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups atmel_nor_global_protection_fixups = {
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 55f4a902b8be..72973cfb1d20 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2898,16 +2898,23 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
  * SFDP standard, or where SFDP tables are not defined at all.
  * Will replace the spi_nor_manufacturer_init_params() method.
  */
-static void spi_nor_late_init_params(struct spi_nor *nor)
+static int spi_nor_late_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
+	int ret;
 
 	if (nor->manufacturer && nor->manufacturer->fixups &&
-	    nor->manufacturer->fixups->late_init)
-		nor->manufacturer->fixups->late_init(nor);
+	    nor->manufacturer->fixups->late_init) {
+		ret = nor->manufacturer->fixups->late_init(nor);
+		if (ret)
+			return ret;
+	}
 
-	if (nor->info->fixups && nor->info->fixups->late_init)
-		nor->info->fixups->late_init(nor);
+	if (nor->info->fixups && nor->info->fixups->late_init) {
+		ret = nor->info->fixups->late_init(nor);
+		if (ret)
+			return ret;
+	}
 
 	/* Default method kept for backward compatibility. */
 	if (!params->set_4byte_addr_mode)
@@ -2925,6 +2932,8 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 
 	if (nor->info->n_banks > 1)
 		params->bank_size = div64_u64(params->size, nor->info->n_banks);
+
+	return 0;
 }
 
 /**
@@ -3083,9 +3092,7 @@ static int spi_nor_init_params(struct spi_nor *nor)
 		spi_nor_init_params_deprecated(nor);
 	}
 
-	spi_nor_late_init_params(nor);
-
-	return 0;
+	return spi_nor_late_init_params(nor);
 }
 
 /** spi_nor_octal_dtr_enable() - enable Octal DTR I/O if needed
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 4fb5ff09c63a..2453bd5743ac 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -377,6 +377,7 @@ struct spi_nor_otp {
  *			than reading the status register to indicate they
  *			are ready for a new command
  * @locking_ops:	SPI NOR locking methods.
+ * @priv:		flash's private data.
  */
 struct spi_nor_flash_parameter {
 	u64				bank_size;
@@ -405,6 +406,7 @@ struct spi_nor_flash_parameter {
 	int (*ready)(struct spi_nor *nor);
 
 	const struct spi_nor_locking_ops *locking_ops;
+	void *priv;
 };
 
 /**
@@ -431,7 +433,7 @@ struct spi_nor_fixups {
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt);
 	int (*post_sfdp)(struct spi_nor *nor);
-	void (*late_init)(struct spi_nor *nor);
+	int (*late_init)(struct spi_nor *nor);
 };
 
 /**
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 400e2b42f45a..accdf7aa2bfd 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -29,7 +29,7 @@ static const struct spi_nor_fixups is25lp256_fixups = {
 	.post_bfpt = is25lp256_post_bfpt_fixups,
 };
 
-static void pm25lv_nor_late_init(struct spi_nor *nor)
+static int pm25lv_nor_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_erase_map *map = &nor->params->erase_map;
 	int i;
@@ -38,6 +38,8 @@ static void pm25lv_nor_late_init(struct spi_nor *nor)
 	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++)
 		if (map->erase_type[i].size == 4096)
 			map->erase_type[i].opcode = SPINOR_OP_BE_4K_PMC;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups pm25lv_nor_fixups = {
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 04888258e891..eb149e517c1f 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -110,10 +110,12 @@ static void macronix_nor_default_init(struct spi_nor *nor)
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
-static void macronix_nor_late_init(struct spi_nor *nor)
+static int macronix_nor_late_init(struct spi_nor *nor)
 {
 	if (!nor->params->set_4byte_addr_mode)
 		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups macronix_nor_fixups = {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4b919756a205..28c9c14a4b29 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -429,7 +429,7 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 	nor->params->quad_enable = NULL;
 }
 
-static void micron_st_nor_late_init(struct spi_nor *nor)
+static int micron_st_nor_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
@@ -438,6 +438,8 @@ static void micron_st_nor_late_init(struct spi_nor *nor)
 
 	if (!params->set_4byte_addr_mode)
 		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups micron_st_nor_fixups = {
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 15f9a80c10b9..4fbaa6fba45a 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -4,14 +4,18 @@
  * Copyright (C) 2014, Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/device.h>
 #include <linux/mtd/spi-nor.h>
 
 #include "core.h"
 
 /* flash_info mfr_flag. Used to clear sticky prorietary SR bits. */
 #define USE_CLSR	BIT(0)
+#define USE_CLPEF	BIT(1)
 
 #define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
+#define SPINOR_OP_CLPEF		0x82	/* Clear program/erase failure flags */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
 #define SPINOR_REG_CYPRESS_VREG			0x00800000
@@ -25,6 +29,7 @@
 #define SPINOR_REG_CYPRESS_CFR2			0x3
 #define SPINOR_REG_CYPRESS_CFR2V					\
 	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR2)
+#define SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK	GENMASK(3, 0)
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
 #define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
 #define SPINOR_REG_CYPRESS_CFR3			0x4
@@ -57,22 +62,32 @@
 		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
 		   SPI_MEM_OP_DATA_IN(1, buf, 0))
 
-#define SPANSION_CLSR_OP						\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 0),			\
+#define SPANSION_OP(opcode)						\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
 		   SPI_MEM_OP_NO_ADDR,					\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
+/**
+ * struct spansion_nor_params - Spansion private parameters.
+ * @clsr:	Clear Status Register or Clear Program and Erase Failure Flag
+ *		opcode.
+ */
+struct spansion_nor_params {
+	u8 clsr;
+};
+
 /**
  * spansion_nor_clear_sr() - Clear the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  */
 static void spansion_nor_clear_sr(struct spi_nor *nor)
 {
+	const struct spansion_nor_params *priv_params = nor->params->priv;
 	int ret;
 
 	if (nor->spimem) {
-		struct spi_mem_op op = SPANSION_CLSR_OP;
+		struct spi_mem_op op = SPANSION_OP(priv_params->clsr);
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
@@ -148,8 +163,18 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	int ret;
 	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
 
+	op = (struct spi_mem_op)
+		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes,
+					  SPINOR_REG_CYPRESS_CFR2V, 0, buf);
+
+	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
 	/* Use 24 dummy cycles for memory array reads. */
-	*buf = SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24;
+	*buf &= ~SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK;
+	*buf |= FIELD_PREP(SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK,
+			   SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24);
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
 					  SPINOR_REG_CYPRESS_CFR2V, 1, buf);
@@ -528,9 +553,11 @@ static int s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
 	return 0;
 }
 
-static void s25fs256t_late_init(struct spi_nor *nor)
+static int s25fs256t_late_init(struct spi_nor *nor)
 {
 	cypress_nor_ecc_init(nor);
+
+	return 0;
 }
 
 static struct spi_nor_fixups s25fs256t_fixups = {
@@ -586,7 +613,7 @@ static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 	return cypress_nor_get_page_size(nor);
 }
 
-static void s25hx_t_late_init(struct spi_nor *nor)
+static int s25hx_t_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
@@ -598,6 +625,8 @@ static void s25hx_t_late_init(struct spi_nor *nor)
 	/* Replace ready() with multi die version */
 	if (params->n_dice)
 		params->ready = cypress_nor_sr_ready_and_clear;
+
+	return 0;
 }
 
 static struct spi_nor_fixups s25hx_t_fixups = {
@@ -665,10 +694,12 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 	return 0;
 }
 
-static void s28hx_t_late_init(struct spi_nor *nor)
+static int s28hx_t_late_init(struct spi_nor *nor)
 {
 	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
 	cypress_nor_ecc_init(nor);
+
+	return 0;
 }
 
 static const struct spi_nor_fixups s28hx_t_fixups = {
@@ -792,47 +823,54 @@ static const struct flash_info spansion_nor_parts[] = {
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "s25fs256t",  INFO6(0x342b19, 0x0f0890, 0, 0)
 		PARSE_SFDP
+		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25fs256t_fixups },
 	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 256 * 1024, 256)
 		PARSE_SFDP
-		MFR_FLAGS(USE_CLSR)
+		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 256 * 1024, 512)
 		PARSE_SFDP
-		MFR_FLAGS(USE_CLSR)
+		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hl02gt",  INFO6(0x342a1c, 0x0f0090, 0, 0)
 		PARSE_SFDP
+		MFR_FLAGS(USE_CLPEF)
 		FLAGS(NO_CHIP_ERASE)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 256 * 1024, 256)
 		PARSE_SFDP
-		MFR_FLAGS(USE_CLSR)
+		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 256 * 1024, 512)
 		PARSE_SFDP
-		MFR_FLAGS(USE_CLSR)
+		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hs02gt",  INFO6(0x342b1c, 0x0f0090, 0, 0)
 		PARSE_SFDP
+		MFR_FLAGS(USE_CLPEF)
 		FLAGS(NO_CHIP_ERASE)
 		.fixups = &s25hx_t_fixups },
 	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
 		FLAGS(SPI_NOR_NO_ERASE) },
 	{ "s28hl512t",   INFO(0x345a1a,      0, 256 * 1024, 256)
 		PARSE_SFDP
+		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
 	{ "s28hl01gt",   INFO(0x345a1b,      0, 256 * 1024, 512)
 		PARSE_SFDP
+		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
 	{ "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256)
 		PARSE_SFDP
+		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
 	{ "s28hs01gt",   INFO(0x345b1b,      0, 256 * 1024, 512)
 		PARSE_SFDP
+		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
 };
@@ -876,17 +914,35 @@ static int spansion_nor_sr_ready_and_clear(struct spi_nor *nor)
 	return !(nor->bouncebuf[0] & SR_WIP);
 }
 
-static void spansion_nor_late_init(struct spi_nor *nor)
+static int spansion_nor_late_init(struct spi_nor *nor)
 {
-	if (nor->params->size > SZ_16M) {
+	struct spi_nor_flash_parameter *params = nor->params;
+	struct spansion_nor_params *priv_params;
+	u8 mfr_flags = nor->info->mfr_flags;
+
+	if (params->size > SZ_16M) {
 		nor->flags |= SNOR_F_4B_OPCODES;
 		/* No small sector erase for 4-byte command set */
 		nor->erase_opcode = SPINOR_OP_SE;
 		nor->mtd.erasesize = nor->info->sector_size;
 	}
 
-	if (nor->info->mfr_flags & USE_CLSR)
-		nor->params->ready = spansion_nor_sr_ready_and_clear;
+	if (mfr_flags & (USE_CLSR | USE_CLPEF)) {
+		priv_params = devm_kmalloc(nor->dev, sizeof(*priv_params),
+					   GFP_KERNEL);
+		if (!priv_params)
+			return -ENOMEM;
+
+		if (mfr_flags & USE_CLSR)
+			priv_params->clsr = SPINOR_OP_CLSR;
+		else if (mfr_flags & USE_CLPEF)
+			priv_params->clsr = SPINOR_OP_CLPEF;
+
+		params->priv = priv_params;
+		params->ready = spansion_nor_sr_ready_and_clear;
+	}
+
+	return 0;
 }
 
 static const struct spi_nor_fixups spansion_nor_fixups = {
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 688eb20c763e..09fdc7023e09 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -49,9 +49,11 @@ static const struct spi_nor_locking_ops sst26vf_nor_locking_ops = {
 	.is_locked = sst26vf_nor_is_locked,
 };
 
-static void sst26vf_nor_late_init(struct spi_nor *nor)
+static int sst26vf_nor_late_init(struct spi_nor *nor)
 {
 	nor->params->locking_ops = &sst26vf_nor_locking_ops;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups sst26vf_nor_fixups = {
@@ -203,10 +205,12 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	return ret;
 }
 
-static void sst_nor_late_init(struct spi_nor *nor)
+static int sst_nor_late_init(struct spi_nor *nor)
 {
 	if (nor->info->mfr_flags & SST_WRITE)
 		nor->mtd._write = sst_nor_write;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups sst_nor_fixups = {
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 63ba8e3a96f5..cd99c9a1c568 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -217,7 +217,7 @@ static const struct spi_nor_otp_ops winbond_nor_otp_ops = {
 	.is_locked = spi_nor_otp_is_locked_sr2,
 };
 
-static void winbond_nor_late_init(struct spi_nor *nor)
+static int winbond_nor_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
@@ -233,6 +233,8 @@ static void winbond_nor_late_init(struct spi_nor *nor)
 	 * from BFPT, if any.
 	 */
 	params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups winbond_nor_fixups = {
diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index 7175de8aa336..00d53eae5ee8 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -155,10 +155,12 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 	return 0;
 }
 
-static void xilinx_nor_late_init(struct spi_nor *nor)
+static int xilinx_nor_late_init(struct spi_nor *nor)
 {
 	nor->params->setup = xilinx_nor_setup;
 	nor->params->ready = xilinx_nor_sr_ready;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups xilinx_nor_fixups = {
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index a5c5036dfb94..e626de33e735 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -185,10 +185,10 @@ config CAN_SLCAN
 
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
-	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
+	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
 	help
 	  Say Y here if you want to use CAN controller found on Allwinner
-	  A10/A20 SoCs.
+	  A10/A20/D1 SoCs.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called sun4i_can.
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 0827830bbf28..c508a328e38d 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -91,6 +91,8 @@
 #define SUN4I_REG_BUF12_ADDR	0x0070	/* CAN Tx/Rx Buffer 12 */
 #define SUN4I_REG_ACPC_ADDR	0x0040	/* CAN Acceptance Code 0 */
 #define SUN4I_REG_ACPM_ADDR	0x0044	/* CAN Acceptance Mask 0 */
+#define SUN4I_REG_ACPC_ADDR_D1	0x0028	/* CAN Acceptance Code 0 on the D1 */
+#define SUN4I_REG_ACPM_ADDR_D1	0x002C	/* CAN Acceptance Mask 0 on the D1 */
 #define SUN4I_REG_RBUF_RBACK_START_ADDR	0x0180	/* CAN transmit buffer start */
 #define SUN4I_REG_RBUF_RBACK_END_ADDR	0x01b0	/* CAN transmit buffer end */
 
@@ -205,9 +207,11 @@
  * struct sun4ican_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @acp_offset: Offset of ACPC and ACPM registers
  */
 struct sun4ican_quirks {
 	bool has_reset;
+	int acp_offset;
 };
 
 struct sun4ican_priv {
@@ -216,6 +220,7 @@ struct sun4ican_priv {
 	struct clk *clk;
 	struct reset_control *reset;
 	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
+	int acp_offset;
 };
 
 static const struct can_bittiming_const sun4ican_bittiming_const = {
@@ -338,8 +343,8 @@ static int sun4i_can_start(struct net_device *dev)
 	}
 
 	/* set filters - we accept all */
-	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR);
-	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR);
+	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR + priv->acp_offset);
+	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR + priv->acp_offset);
 
 	/* clear error counters and error code capture */
 	writel(0, priv->base + SUN4I_REG_ERRC_ADDR);
@@ -768,10 +773,17 @@ static const struct ethtool_ops sun4ican_ethtool_ops = {
 
 static const struct sun4ican_quirks sun4ican_quirks_a10 = {
 	.has_reset = false,
+	.acp_offset = 0,
 };
 
 static const struct sun4ican_quirks sun4ican_quirks_r40 = {
 	.has_reset = true,
+	.acp_offset = 0,
+};
+
+static const struct sun4ican_quirks sun4ican_quirks_d1 = {
+	.has_reset = true,
+	.acp_offset = (SUN4I_REG_ACPC_ADDR_D1 - SUN4I_REG_ACPC_ADDR),
 };
 
 static const struct of_device_id sun4ican_of_match[] = {
@@ -784,6 +796,9 @@ static const struct of_device_id sun4ican_of_match[] = {
 	}, {
 		.compatible = "allwinner,sun8i-r40-can",
 		.data = &sun4ican_quirks_r40
+	}, {
+		.compatible = "allwinner,sun20i-d1-can",
+		.data = &sun4ican_quirks_d1
 	}, {
 		/* sentinel */
 	},
@@ -870,6 +885,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 	priv->base = addr;
 	priv->clk = clk;
 	priv->reset = reset;
+	priv->acp_offset = quirks->acp_offset;
 	spin_lock_init(&priv->cmdreg_lock);
 
 	platform_set_drvdata(pdev, dev);
@@ -907,4 +923,4 @@ module_platform_driver(sun4i_can_driver);
 MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
 MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20)");
+MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20/D1)");
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
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 8f232c41a89e..459e32f6adb5 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -331,6 +331,9 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	np = netdev_priv(netdev);
 	vsi = np->vsi;
 
+	if (!vsi || !ice_is_switchdev_running(vsi->back))
+		return NETDEV_TX_BUSY;
+
 	if (ice_is_reset_in_progress(vsi->back->state) ||
 	    test_bit(ICE_VF_DIS, vsi->back->state))
 		return NETDEV_TX_BUSY;
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 9275a672f90c..73463ded4204 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3817,7 +3817,7 @@ static void __exit ath10k_pci_exit(void)
 module_exit(ath10k_pci_exit);
 
 MODULE_AUTHOR("Qualcomm Atheros");
-MODULE_DESCRIPTION("Driver support for Qualcomm Atheros 802.11ac WLAN PCIe/AHB devices");
+MODULE_DESCRIPTION("Driver support for Qualcomm Atheros PCIe/AHB 802.11ac WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* QCA988x 2.0 firmware files */
diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
index b0067af685b1..3c482baacec1 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -1126,5 +1126,5 @@ static struct usb_driver ath10k_usb_driver = {
 module_usb_driver(ath10k_usb_driver);
 
 MODULE_AUTHOR("Atheros Communications, Inc.");
-MODULE_DESCRIPTION("Driver support for Qualcomm Atheros 802.11ac WLAN USB devices");
+MODULE_DESCRIPTION("Driver support for Qualcomm Atheros USB 802.11ac WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index ec40adc1cb23..a181563ec085 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1036,7 +1036,7 @@ static void ath11k_pci_exit(void)
 
 module_exit(ath11k_pci_exit);
 
-MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN PCIe devices");
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies PCIe 802.11ax WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* firmware files */
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index ae1645d0f42a..f933896f2a68 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1129,6 +1129,7 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 	struct ath12k_dp *dp = &ab->dp;
 	struct sk_buff *skb;
 	int i;
+	u32 pool_id, tx_spt_page;
 
 	if (!dp->spt_info)
 		return;
@@ -1148,6 +1149,14 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 		dev_kfree_skb_any(skb);
 	}
 
+	for (i = 0; i < ATH12K_NUM_RX_SPT_PAGES; i++) {
+		if (!dp->spt_info->rxbaddr[i])
+			continue;
+
+		kfree(dp->spt_info->rxbaddr[i]);
+		dp->spt_info->rxbaddr[i] = NULL;
+	}
+
 	spin_unlock_bh(&dp->rx_desc_lock);
 
 	/* TX Descriptor cleanup */
@@ -1170,6 +1179,21 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 		spin_unlock_bh(&dp->tx_desc_lock[i]);
 	}
 
+	for (pool_id = 0; pool_id < ATH12K_HW_MAX_QUEUES; pool_id++) {
+		spin_lock_bh(&dp->tx_desc_lock[pool_id]);
+
+		for (i = 0; i < ATH12K_TX_SPT_PAGES_PER_POOL; i++) {
+			tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
+			if (!dp->spt_info->txbaddr[tx_spt_page])
+				continue;
+
+			kfree(dp->spt_info->txbaddr[tx_spt_page]);
+			dp->spt_info->txbaddr[tx_spt_page] = NULL;
+		}
+
+		spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
+	}
+
 	/* unmap SPT pages */
 	for (i = 0; i < dp->num_spt_pages; i++) {
 		if (!dp->spt_info[i].vaddr)
@@ -1343,6 +1367,8 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 			return -ENOMEM;
 		}
 
+		dp->spt_info->rxbaddr[i] = &rx_descs[0];
+
 		for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
 			rx_descs[j].cookie = ath12k_dp_cc_cookie_gen(i, j);
 			rx_descs[j].magic = ATH12K_DP_RX_DESC_MAGIC;
@@ -1368,8 +1394,10 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 				return -ENOMEM;
 			}
 
+			tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
+			dp->spt_info->txbaddr[tx_spt_page] = &tx_descs[0];
+
 			for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
-				tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
 				ppt_idx = ATH12K_NUM_RX_SPT_PAGES + tx_spt_page;
 				tx_descs[j].desc_id = ath12k_dp_cc_cookie_gen(ppt_idx, j);
 				tx_descs[j].pool_id = pool_id;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 7c5dafce5a68..9aeda0321cd7 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -289,6 +289,8 @@ struct ath12k_tx_desc_info {
 struct ath12k_spt_info {
 	dma_addr_t paddr;
 	u64 *vaddr;
+	struct ath12k_rx_desc_info *rxbaddr[ATH12K_NUM_RX_SPT_PAGES];
+	struct ath12k_tx_desc_info *txbaddr[ATH12K_NUM_TX_SPT_PAGES];
 };
 
 struct ath12k_reo_queue_ref {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 45d88e35fc2e..d165b24094ad 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2755,9 +2755,12 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	arg.scan_id = ATH12K_SCAN_ID;
 
 	if (req->ie_len) {
+		arg.extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
+		if (!arg.extraie.ptr) {
+			ret = -ENOMEM;
+			goto exit;
+		}
 		arg.extraie.len = req->ie_len;
-		arg.extraie.ptr = kzalloc(req->ie_len, GFP_KERNEL);
-		memcpy(arg.extraie.ptr, req->ie, req->ie_len);
 	}
 
 	if (req->n_ssids) {
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index e4f08a066ca1..fae5dfd6e9d7 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1411,5 +1411,5 @@ static void ath12k_pci_exit(void)
 
 module_exit(ath12k_pci_exit);
 
-MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11be WLAN PCIe devices");
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies PCIe 802.11be WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4928e4e91660..eebc5a65ce3b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2162,12 +2162,6 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	if (arg->num_bssid)
 		len += sizeof(*bssid) * arg->num_bssid;
 
-	len += TLV_HDR_SIZE;
-	if (arg->extraie.len)
-		extraie_len_with_pad =
-			roundup(arg->extraie.len, sizeof(u32));
-	len += extraie_len_with_pad;
-
 	if (arg->num_hint_bssid)
 		len += TLV_HDR_SIZE +
 		       arg->num_hint_bssid * sizeof(*hint_bssid);
@@ -2176,6 +2170,18 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 		len += TLV_HDR_SIZE +
 		       arg->num_hint_s_ssid * sizeof(*s_ssid);
 
+	len += TLV_HDR_SIZE;
+	if (arg->extraie.len)
+		extraie_len_with_pad =
+			roundup(arg->extraie.len, sizeof(u32));
+	if (extraie_len_with_pad <= (wmi->wmi_ab->max_msg_len[ar->pdev_idx] - len)) {
+		len += extraie_len_with_pad;
+	} else {
+		ath12k_warn(ar->ab, "discard large size %d bytes extraie for scan start\n",
+			    arg->extraie.len);
+		extraie_len_with_pad = 0;
+	}
+
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
@@ -2265,7 +2271,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, len);
 	ptr += TLV_HDR_SIZE;
 
-	if (arg->extraie.len)
+	if (extraie_len_with_pad)
 		memcpy(ptr, arg->extraie.ptr,
 		       arg->extraie.len);
 
@@ -3704,6 +3710,10 @@ static int ath12k_wmi_hw_mode_caps(struct ath12k_base *soc,
 	for (i = 0 ; i < svc_rdy_ext->n_hw_mode_caps; i++) {
 		hw_mode_caps = &svc_rdy_ext->hw_mode_caps[i];
 		mode = le32_to_cpu(hw_mode_caps->hw_mode_id);
+
+		if (mode >= WMI_HOST_HW_MODE_MAX)
+			continue;
+
 		pref = soc->wmi_ab.preferred_hw_mode;
 
 		if (ath12k_hw_mode_pri_map[mode] < ath12k_hw_mode_pri_map[pref]) {
diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 9cd12b20b18d..9bfaadfa6c00 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -132,8 +132,8 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	ah = sc->sc_ah;
 	ath9k_hw_name(ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)mem, irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, mem, irq);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath9k/mac.h b/drivers/net/wireless/ath/ath9k/mac.h
index af44b33814dd..f03d792732da 100644
--- a/drivers/net/wireless/ath/ath9k/mac.h
+++ b/drivers/net/wireless/ath/ath9k/mac.h
@@ -115,8 +115,10 @@ struct ath_tx_status {
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
index a09f9d223f3d..0633589b85c2 100644
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
index f6f2ab7a63ff..42058368e637 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -468,7 +468,7 @@ static void ath_tx_count_frames(struct ath_softc *sc, struct ath_buf *bf,
 	isaggr = bf_isaggr(bf);
 	if (isaggr) {
 		seq_st = ts->ts_seqnum;
-		memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+		memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 	}
 
 	while (bf) {
@@ -551,7 +551,7 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 	if (isaggr && txok) {
 		if (ts->ts_flags & ATH9K_TX_BA) {
 			seq_st = ts->ts_seqnum;
-			memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+			memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 		} else {
 			/*
 			 * AR5416 can become deaf/mute when BA
diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index 237cbd5c5060..f29ac6de7139 100644
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
index 1ae1bec1b97f..689f68d89a44 100644
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
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 009bca34ece3..447b51cff8f9 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -10,7 +10,7 @@
  * Copyright (c) 2007 Kalle Valo <kalle.valo@iki.fi>
  * Copyright (c) 2010 Sebastian Smolorz <sesmo@gmx.net>
  *
- * This file is part of the Berlios driver for WLAN USB devices based on the
+ * This file is part of the Berlios driver for USB WLAN devices based on the
  * Atmel AT76C503A/505/505A.
  *
  * Some iw_handler code was taken from airo.c, (C) 1999 Benjamin Reed
@@ -143,7 +143,7 @@ static const struct usb_device_id dev_table[] = {
 	{ USB_DEVICE(0x0cde, 0x0001), USB_DEVICE_DATA(BOARD_503_ISL3861) },
 	/* Dynalink/Askey WLL013 (intersil) */
 	{ USB_DEVICE(0x069a, 0x0320), USB_DEVICE_DATA(BOARD_503_ISL3861) },
-	/* EZ connect 11Mpbs Wireless USB Adapter SMC2662W v1 */
+	/* EZ connect 11Mpbs USB Wireless Adapter SMC2662W v1 */
 	{ USB_DEVICE(0x0d5c, 0xa001), USB_DEVICE_DATA(BOARD_503_ISL3861) },
 	/* BenQ AWL300 */
 	{ USB_DEVICE(0x04a5, 0x9000), USB_DEVICE_DATA(BOARD_503_ISL3861) },
@@ -195,7 +195,7 @@ static const struct usb_device_id dev_table[] = {
 	{ USB_DEVICE(0x04a5, 0x9001), USB_DEVICE_DATA(BOARD_503) },
 	/* 3Com 3CRSHEW696 */
 	{ USB_DEVICE(0x0506, 0x0a01), USB_DEVICE_DATA(BOARD_503) },
-	/* Siemens Santis ADSL WLAN USB adapter WLL 013 */
+	/* Siemens Santis ADSL USB WLAN adapter WLL 013 */
 	{ USB_DEVICE(0x0681, 0x001b), USB_DEVICE_DATA(BOARD_503) },
 	/* Belkin F5D6050, version 2 */
 	{ USB_DEVICE(0x050d, 0x0050), USB_DEVICE_DATA(BOARD_503) },
@@ -238,7 +238,7 @@ static const struct usb_device_id dev_table[] = {
 	{ USB_DEVICE(0x1915, 0x2233), USB_DEVICE_DATA(BOARD_505_2958) },
 	/* Xterasys XN-2122B, IBlitzz BWU613B/BWU613SB */
 	{ USB_DEVICE(0x12fd, 0x1001), USB_DEVICE_DATA(BOARD_505_2958) },
-	/* Corega WLAN USB Stick 11 */
+	/* Corega USB WLAN Stick 11 */
 	{ USB_DEVICE(0x07aa, 0x7613), USB_DEVICE_DATA(BOARD_505_2958) },
 	/* Microstar MSI Box MS6978 */
 	{ USB_DEVICE(0x0db0, 0x1020), USB_DEVICE_DATA(BOARD_505_2958) },
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 73c1fb3c0c5e..bc83d2ba55c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1132,12 +1132,6 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 	else
 		sd_reg_ver_addr = SD_REG_VER;
 
-	if (!iwl_trans_grab_nic_access(iwl_trans)) {
-		IWL_ERR(iwl_trans, "Failed to grab nic access before reading crf id\n");
-		ret = -EIO;
-		goto out;
-	}
-
 	/* Enable access to peripheral registers */
 	val = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
 	val |= ENABLE_WFPM;
@@ -1157,9 +1151,6 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 		 iwl_trans->hw_crf_id, iwl_trans->hw_cnv_id,
 		 iwl_trans->hw_wfpm_id);
 
-	iwl_trans_release_nic_access(iwl_trans);
-
-out:
 	return ret;
 }
 
@@ -1351,6 +1342,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ret)
 			goto out_free_trans;
 		if (iwl_trans_grab_nic_access(iwl_trans)) {
+			get_crf_id(iwl_trans);
 			/* all good */
 			iwl_trans_release_nic_access(iwl_trans);
 		} else {
@@ -1360,7 +1352,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
-	get_crf_id(iwl_trans);
 
 	/*
 	 * The RF_ID is set to zero in blank OTP so read version to
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
index dd31929261ab..866e0230df25 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -129,18 +129,18 @@ MODULE_FIRMWARE("orinoco_ezusb_fw");
 
 #define USB_AVAYA8_VENDOR_ID     0x0D98
 #define USB_AVAYAE_VENDOR_ID     0x0D9E
-#define USB_AVAYA_WIRELESS_ID    0x0300 /* Avaya Wireless USB Card */
+#define USB_AVAYA_WIRELESS_ID    0x0300 /* Avaya USB Wireless Card */
 
 #define USB_AGERE_VENDOR_ID      0x0D4E /* Agere Systems */
-#define USB_AGERE_MODEL0801_ID   0x1000 /* Wireless USB Card Model 0801 */
-#define USB_AGERE_MODEL0802_ID   0x1001 /* Wireless USB Card Model 0802 */
-#define USB_AGERE_REBRANDED_ID   0x047A /* WLAN USB Card */
+#define USB_AGERE_MODEL0801_ID   0x1000 /* USB Wireless Card Model 0801 */
+#define USB_AGERE_MODEL0802_ID   0x1001 /* USB Wireless Card Model 0802 */
+#define USB_AGERE_REBRANDED_ID   0x047A /* USB WLAN Card */
 
 #define USB_ELSA_VENDOR_ID       0x05CC
 #define USB_ELSA_AIRLANCER_ID    0x3100 /* ELSA AirLancer USB-11 */
 
 #define USB_LEGEND_VENDOR_ID     0x0E7C
-#define USB_LEGEND_JOYNET_ID     0x0300 /* Joynet WLAN USB Card */
+#define USB_LEGEND_JOYNET_ID     0x0300 /* Joynet USB WLAN Card */
 
 #define USB_SAMSUNG_VENDOR_ID    0x04E8
 #define USB_SAMSUNG_SEW2001U1_ID 0x5002 /* Samsung SEW-2001u Card */
@@ -154,7 +154,7 @@ MODULE_FIRMWARE("orinoco_ezusb_fw");
 #define USB_FUJITSU_E1100_ID     0x1002 /* connect2AIR WLAN E-1100 USB */
 
 #define USB_2WIRE_VENDOR_ID      0x1630
-#define USB_2WIRE_WIRELESS_ID    0xff81 /* 2Wire Wireless USB adapter */
+#define USB_2WIRE_WIRELESS_ID    0xff81 /* 2Wire USB Wireless adapter */
 
 
 #define EZUSB_REQUEST_FW_TRANS		0xA0
diff --git a/drivers/net/wireless/legacy/rndis_wlan.c b/drivers/net/wireless/legacy/rndis_wlan.c
index 712038d46bdb..e7fea7ded6d5 100644
--- a/drivers/net/wireless/legacy/rndis_wlan.c
+++ b/drivers/net/wireless/legacy/rndis_wlan.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Driver for RNDIS based wireless USB devices.
+ * Driver for RNDIS based USB wireless devices.
  *
  * Copyright (C) 2007 by Bjorge Dijkstra <bjd@jooz.net>
  * Copyright (C) 2008-2009 by Jussi Kivilinna <jussi.kivilinna@iki.fi>
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
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
index 6a0080f1d91c..dd16acfd9735 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
@@ -5,7 +5,7 @@ config MT7603E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7603E wireless PCIe devices and the WLAN core
+	  This adds support for MT7603E PCIe wireless devices and the WLAN core
 	  on MT7628/MT7688 SoC devices. This family supports IEEE 802.11n 2x2
 	  to 300Mbps PHY rate
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 30fba36ff46b..1ab1439143f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -11,7 +11,7 @@ config MT7615E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7615-based wireless PCIe devices,
+	  This adds support for MT7615-based PCIe wireless devices,
 	  which support concurrent dual-band operation at both 5GHz
 	  and 2.4GHz, IEEE 802.11ac 4x4:4SS 1733Mbps PHY rate, wave2
 	  MU-MIMO up to 4 users/group and 160MHz channels.
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig b/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
index 7c88ed8b8f1e..3ed888782a70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
@@ -10,7 +10,7 @@ config MT76x0U
 	depends on MAC80211
 	depends on USB
 	help
-	  This adds support for MT7610U-based wireless USB 2.0 dongles,
+	  This adds support for MT7610U-based USB 2.0 wireless dongles,
 	  which comply with IEEE 802.11ac standards and support 1x1
 	  433Mbps PHY rate.
 
@@ -22,7 +22,7 @@ config MT76x0E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7610/MT7630-based wireless PCIe devices,
+	  This adds support for MT7610/MT7630-based PCIe wireless devices,
 	  which comply with IEEE 802.11ac standards and support 1x1
 	  433Mbps PHY rate.
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig b/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
index 5fd4973e32df..482a32b70ddf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
@@ -9,7 +9,7 @@ config MT76x2E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7612/MT7602/MT7662-based wireless PCIe
+	  This adds support for MT7612/MT7602/MT7662-based PCIe wireless
 	  devices, which comply with IEEE 802.11ac standards and support
 	  2SS to 866Mbit/s PHY rate.
 
@@ -22,7 +22,7 @@ config MT76x2U
 	depends on MAC80211
 	depends on USB
 	help
-	  This adds support for MT7612U-based wireless USB 3.0 dongles,
+	  This adds support for MT7612U-based USB 3.0 wireless dongles,
 	  which comply with IEEE 802.11ac standards and support 2SS to
 	  866Mbit/s PHY rate.
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
index d710726d47bf..3337cdfed010 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
@@ -7,7 +7,7 @@ config MT7915E
 	depends on PCI
 	select RELAY
 	help
-	  This adds support for MT7915-based wireless PCIe devices,
+	  This adds support for MT7915-based PCIe wireless devices,
 	  which support concurrent dual-band operation at both 5GHz
 	  and 2.4GHz IEEE 802.11ax 4x4:4SS 1024-QAM, 160MHz channels,
 	  OFDMA, spatial reuse and dual carrier modulation.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 1675bf520481..a671c601c583 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1180,6 +1180,10 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (unlikely(tx_info->skb->len <= ETH_HLEN))
 		return -EINVAL;
 
+	err = skb_cow_head(skb, MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE);
+	if (err)
+		return err;
+
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
index 1afa2f662e47..bb44d4a5e2dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
@@ -7,7 +7,7 @@ config MT7996E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7996-based wireless PCIe devices,
+	  This adds support for MT7996-based PCIe wireless devices,
 	  which support concurrent tri-band operation at 6GHz, 5GHz,
 	  and 2.4GHz IEEE 802.11be 4x4:4SS 4096-QAM, 320MHz channels.
 
diff --git a/drivers/net/wireless/mediatek/mt7601u/Kconfig b/drivers/net/wireless/mediatek/mt7601u/Kconfig
index 4a8b96280670..4880fc053d9d 100644
--- a/drivers/net/wireless/mediatek/mt7601u/Kconfig
+++ b/drivers/net/wireless/mediatek/mt7601u/Kconfig
@@ -4,4 +4,4 @@ config MT7601U
 	depends on MAC80211
 	depends on USB
 	help
-	  This adds support for MT7601U-based wireless USB dongles.
+	  This adds support for MT7601U-based USB wireless dongles.
diff --git a/drivers/net/wireless/purelifi/plfxlc/Kconfig b/drivers/net/wireless/purelifi/plfxlc/Kconfig
index 4e0be27a5e0e..dd5fca480d7e 100644
--- a/drivers/net/wireless/purelifi/plfxlc/Kconfig
+++ b/drivers/net/wireless/purelifi/plfxlc/Kconfig
@@ -3,7 +3,7 @@ config PLFXLC
 	tristate "pureLiFi X, XL, XC device support"
 	depends on CFG80211 && MAC80211 && USB
 	help
-	   This option adds support for pureLiFi LiFi wireless USB
+	   This option adds support for pureLiFi LiFi USB wireless
 	   adapters. The pureLiFi X, XL, XC USB devices are based on
 	   802.11 OFDM PHY but uses light as the transmission medium.
 	   The driver supports common 802.11 encryption/authentication
diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index dcccc290a7f5..d1fd66d44a7e 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -170,7 +170,7 @@ config RT2800USB_RT35XX
 config RT2800USB_RT3573
 	bool "rt2800usb - Include support for rt3573 devices (EXPERIMENTAL)"
 	help
-	  This enables support for RT3573 chipset based wireless USB devices
+	  This enables support for RT3573 chipset based USB wireless devices
 	  in the rt2800usb driver.
 
 config RT2800USB_RT53XX
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c853e2f2d448..c2ddb4d382af 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2183,10 +2183,12 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 		release_firmware(wow_fw->firmware);
 
 	destroy_workqueue(rtwdev->tx_wq);
+	timer_delete_sync(&rtwdev->tx_report.purge_timer);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
-	skb_queue_purge(&rtwdev->coex.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
+	skb_queue_purge(&rtwdev->coex.queue);
+	skb_queue_purge(&rtwdev->c2h_queue);
 
 	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list,
 				 build_list) {
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 44a8fff34cdd..2bfc0e822b8d 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1828,5 +1828,5 @@ void rtw_pci_shutdown(struct pci_dev *pdev)
 EXPORT_SYMBOL(rtw_pci_shutdown);
 
 MODULE_AUTHOR("Realtek Corporation");
-MODULE_DESCRIPTION("Realtek 802.11ac wireless PCI driver");
+MODULE_DESCRIPTION("Realtek PCI 802.11ac wireless driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 875a61c9c80d..c279a500b4bd 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -930,5 +930,5 @@ void rtw_usb_disconnect(struct usb_interface *intf)
 EXPORT_SYMBOL(rtw_usb_disconnect);
 
 MODULE_AUTHOR("Realtek Corporation");
-MODULE_DESCRIPTION("Realtek 802.11ac wireless USB driver");
+MODULE_DESCRIPTION("Realtek USB 802.11ac wireless driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 9402f1a0caea..3a4bfc44142b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3939,5 +3939,5 @@ void rtw89_pci_remove(struct pci_dev *pdev)
 EXPORT_SYMBOL(rtw89_pci_remove);
 
 MODULE_AUTHOR("Realtek Corporation");
-MODULE_DESCRIPTION("Realtek 802.11ax wireless PCI driver");
+MODULE_DESCRIPTION("Realtek PCI 802.11ax wireless driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index f446fd0e8cd0..23307c8baea2 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -582,9 +582,8 @@ static int mac80211_hwsim_vendor_cmd_test(struct wiphy *wiphy,
 		 */
 
 		/* Add vendor data */
-		err = nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 1);
-		if (err)
-			return err;
+		nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 1);
+
 		/* Send the event - this will call nla_nest_end() */
 		cfg80211_vendor_event(skb, GFP_KERNEL);
 	}
@@ -5626,14 +5625,15 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
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
 
diff --git a/drivers/net/wireless/zydas/zd1201.c b/drivers/net/wireless/zydas/zd1201.c
index a85fe7e4c6d4..2814df1ecc78 100644
--- a/drivers/net/wireless/zydas/zd1201.c
+++ b/drivers/net/wireless/zydas/zd1201.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *	Driver for ZyDAS zd1201 based wireless USB devices.
+ *	Driver for ZyDAS zd1201 based USB wireless devices.
  *
  *	Copyright (c) 2004, 2005 Jeroen Vreeken (pe1rxq@amsat.org)
  *
@@ -23,8 +23,8 @@
 #include "zd1201.h"
 
 static const struct usb_device_id zd1201_table[] = {
-	{USB_DEVICE(0x0586, 0x3400)}, /* Peabird Wireless USB Adapter */
-	{USB_DEVICE(0x0ace, 0x1201)}, /* ZyDAS ZD1201 Wireless USB Adapter */
+	{USB_DEVICE(0x0586, 0x3400)}, /* Peabird USB Wireless Adapter */
+	{USB_DEVICE(0x0ace, 0x1201)}, /* ZyDAS ZD1201 USB Wireless Adapter */
 	{USB_DEVICE(0x050d, 0x6051)}, /* Belkin F5D6051 usb  adapter */
 	{USB_DEVICE(0x0db0, 0x6823)}, /* MSI UB11B usb  adapter */
 	{USB_DEVICE(0x1044, 0x8004)}, /* Gigabyte GN-WLBZ101 */
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..21783aa2ee8e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2245,25 +2245,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
-		u32 crto;
-
-		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
-		if (ret) {
-			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
-				ret);
-			return ret;
-		}
-
-		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
-			ctrl->ctrl_config |= NVME_CC_CRIME;
-			timeout = NVME_CRTO_CRIMT(crto);
-		} else {
-			timeout = NVME_CRTO_CRWMT(crto);
-		}
-	} else {
-		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
-	}
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
+		ctrl->ctrl_config |= NVME_CC_CRIME;
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
@@ -2277,6 +2260,39 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	/* CAP value may change after initial CC write */
+	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	if (ret)
+		return ret;
+
+	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
+		u32 crto, ready_timeout;
+
+		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
+		if (ret) {
+			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
+				ret);
+			return ret;
+		}
+
+		/*
+		 * CRTO should always be greater or equal to CAP.TO, but some
+		 * devices are known to get this wrong. Use the larger of the
+		 * two values.
+		 */
+		if (ctrl->ctrl_config & NVME_CC_CRIME)
+			ready_timeout = NVME_CRTO_CRIMT(crto);
+		else
+			ready_timeout = NVME_CRTO_CRWMT(crto);
+
+		if (ready_timeout < timeout)
+			dev_warn_once(ctrl->device, "bad crto:%x cap:%llx\n",
+				      crto, ctrl->cap);
+		else
+			timeout = ready_timeout;
+	}
+
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 868aa4de2e4c..cd92d7ddf5ed 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -348,7 +348,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		bvec_set_page(iov, sg_page(sg), sg->length,
+		bvec_set_page(iov, sg_page(sg), iov_len,
 				sg->offset + sg_offset);
 
 		length -= iov_len;
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 27aaa2a6bf39..a18c20085e94 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1040,6 +1040,7 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_deinit = imx6_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 0c90583c078b..1e9b44b8bba4 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -299,6 +299,7 @@ static int fu740_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pci->pp.ops = &fu740_pcie_host_ops;
+	pci->pp.num_vectors = MAX_MSI_IRQS;
 
 	/* SiFive specific region: mgmt */
 	afp->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e718a816d481..ad56df98b8e6 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -541,8 +541,23 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 				     PCI_CLASS_BRIDGE_PCI))
 					continue;
 
-				memset_io(base + PCI_IO_BASE, 0,
-					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+				/*
+				 * Temporarily disable the I/O range before updating
+				 * PCI_IO_BASE.
+				 */
+				writel(0x0000ffff, base + PCI_IO_BASE_UPPER16);
+				/* Update lower 16 bits of I/O base/limit */
+				writew(0x00f0, base + PCI_IO_BASE);
+				/* Update upper 16 bits of I/O base/limit */
+				writel(0, base + PCI_IO_BASE_UPPER16);
+
+				/* MMIO Base/Limit */
+				writel(0x0000fff0, base + PCI_MEMORY_BASE);
+
+				/* Prefetchable MMIO Base/Limit */
+				writel(0, base + PCI_PREF_LIMIT_UPPER32);
+				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
+				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
 			}
 		}
 	}
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 25a269d431e4..0e17c57ddb87 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -115,6 +115,7 @@
 #define SMMU_PMCG_PA_SHIFT              12
 
 #define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
+#define SMMU_PMCG_HARDEN_DISABLE        BIT(1)
 
 static int cpuhp_state_num;
 
@@ -159,6 +160,20 @@ static inline void smmu_pmu_enable(struct pmu *pmu)
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
@@ -167,6 +182,22 @@ static inline void smmu_pmu_disable(struct pmu *pmu)
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
@@ -765,7 +796,10 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
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
 
@@ -890,6 +924,16 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 	if (!dev->of_node)
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
index c684aab407f8..e78b30521be2 100644
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
@@ -428,6 +432,17 @@ static void ddr_perf_counter_enable(struct ddr_pmu *pmu, int config,
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
@@ -467,6 +482,12 @@ static void ddr_perf_event_update(struct perf_event *event)
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
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 500a61b093e4..356572452898 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -327,8 +327,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown is imminent!");
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
 		kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char **)env);
-		/* Begin orderly shutdown. Force shutdown after 1 second. */
-		hw_protection_shutdown("CrOS EC Panic", 1000);
+		/* Begin orderly shutdown. EC will force reset after a short period. */
+		hw_protection_shutdown("CrOS EC Panic", -1);
 		/* Do not query for other events after a panic is reported */
 		return;
 	}
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 62b71e8e3567..ff1b70269ccb 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1394,7 +1394,7 @@ static int eeepc_acpi_add(struct acpi_device *device)
 	 * and machine-specific scripts find the fixed name convenient.  But
 	 * It's also good for us to exclude multiple instances because both
 	 * our hwmon and our wlan rfkill subdevice use global ACPI objects
-	 * (the EC and the wlan PCI slot respectively).
+	 * (the EC and the PCI wlan slot respectively).
 	 */
 	result = eeepc_platform_init(eeepc);
 	if (result)
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 9a8963684369..e8d7eeeb2185 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -872,6 +872,7 @@ enum lpfc_irq_chann_mode {
 enum lpfc_hba_bit_flags {
 	FABRIC_COMANDS_BLOCKED,
 	HBA_PCI_ERR,
+	MBX_TMO_ERR,
 };
 
 struct lpfc_hba {
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 7f9b221e7c34..ea9b42225e62 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -6073,7 +6073,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 					    phba->hba_debugfs_root,
 					    phba,
 					    &lpfc_debugfs_op_multixripools);
-		if (!phba->debug_multixri_pools) {
+		if (IS_ERR(phba->debug_multixri_pools)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "0527 Cannot create debugfs multixripools\n");
 			goto debug_failed;
@@ -6085,7 +6085,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_cgn_buffer_op);
-		if (!phba->debug_cgn_buffer) {
+		if (IS_ERR(phba->debug_cgn_buffer)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6527 Cannot create debugfs "
 					 "cgn_buffer\n");
@@ -6098,7 +6098,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_rx_monitor_op);
-		if (!phba->debug_rx_monitor) {
+		if (IS_ERR(phba->debug_rx_monitor)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6528 Cannot create debugfs "
 					 "rx_monitor\n");
@@ -6111,7 +6111,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_ras_log);
-		if (!phba->debug_ras_log) {
+		if (IS_ERR(phba->debug_ras_log)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6148 Cannot create debugfs"
 					 " ras_log\n");
@@ -6132,7 +6132,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_op_lockstat);
-		if (!phba->debug_lockstat) {
+		if (IS_ERR(phba->debug_lockstat)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "4610 Can't create debugfs lockstat\n");
 			goto debug_failed;
@@ -6358,7 +6358,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_scsistat);
-	if (!vport->debug_scsistat) {
+	if (IS_ERR(vport->debug_scsistat)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "4611 Cannot create debugfs scsistat\n");
 		goto debug_failed;
@@ -6369,7 +6369,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_ioktime);
-	if (!vport->debug_ioktime) {
+	if (IS_ERR(vport->debug_ioktime)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "0815 Cannot create debugfs ioktime\n");
 		goto debug_failed;
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 2bad9954c355..6f6ef5235ee3 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -9588,11 +9588,13 @@ void
 lpfc_els_flush_cmd(struct lpfc_vport *vport)
 {
 	LIST_HEAD(abort_list);
+	LIST_HEAD(cancel_list);
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *tmp_iocb, *piocb;
 	u32 ulp_command;
 	unsigned long iflags = 0;
+	bool mbx_tmo_err;
 
 	lpfc_fabric_abort_vport(vport);
 
@@ -9614,15 +9616,16 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	if (phba->sli_rev == LPFC_SLI_REV4)
 		spin_lock(&pring->ring_lock);
 
+	mbx_tmo_err = test_bit(MBX_TMO_ERR, &phba->bit_flags);
 	/* First we need to issue aborts to outstanding cmds on txcmpl */
 	list_for_each_entry_safe(piocb, tmp_iocb, &pring->txcmplq, list) {
-		if (piocb->cmd_flag & LPFC_IO_LIBDFC)
+		if (piocb->cmd_flag & LPFC_IO_LIBDFC && !mbx_tmo_err)
 			continue;
 
 		if (piocb->vport != vport)
 			continue;
 
-		if (piocb->cmd_flag & LPFC_DRIVER_ABORTED)
+		if (piocb->cmd_flag & LPFC_DRIVER_ABORTED && !mbx_tmo_err)
 			continue;
 
 		/* On the ELS ring we can have ELS_REQUESTs or
@@ -9641,8 +9644,8 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 			 */
 			if (phba->link_state == LPFC_LINK_DOWN)
 				piocb->cmd_cmpl = lpfc_cmpl_els_link_down;
-		}
-		if (ulp_command == CMD_GEN_REQUEST64_CR)
+		} else if (ulp_command == CMD_GEN_REQUEST64_CR ||
+			   mbx_tmo_err)
 			list_add_tail(&piocb->dlist, &abort_list);
 	}
 
@@ -9654,11 +9657,19 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	list_for_each_entry_safe(piocb, tmp_iocb, &abort_list, dlist) {
 		spin_lock_irqsave(&phba->hbalock, iflags);
 		list_del_init(&piocb->dlist);
-		lpfc_sli_issue_abort_iotag(phba, pring, piocb, NULL);
+		if (mbx_tmo_err)
+			list_move_tail(&piocb->list, &cancel_list);
+		else
+			lpfc_sli_issue_abort_iotag(phba, pring, piocb, NULL);
+
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	}
-	/* Make sure HBA is alive */
-	lpfc_issue_hb_tmo(phba);
+	if (!list_empty(&cancel_list))
+		lpfc_sli_cancel_iocbs(phba, &cancel_list, IOSTAT_LOCAL_REJECT,
+				      IOERR_SLI_ABORTED);
+	else
+		/* Make sure HBA is alive */
+		lpfc_issue_hb_tmo(phba);
 
 	if (!list_empty(&abort_list))
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 3221a934066b..ce9e4cdd6004 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7550,6 +7550,8 @@ lpfc_disable_pci_dev(struct lpfc_hba *phba)
 void
 lpfc_reset_hba(struct lpfc_hba *phba)
 {
+	int rc = 0;
+
 	/* If resets are disabled then set error state and return. */
 	if (!phba->cfg_enable_hba_reset) {
 		phba->link_state = LPFC_HBA_ERROR;
@@ -7560,13 +7562,25 @@ lpfc_reset_hba(struct lpfc_hba *phba)
 	if (phba->sli.sli_flag & LPFC_SLI_ACTIVE) {
 		lpfc_offline_prep(phba, LPFC_MBX_WAIT);
 	} else {
+		if (test_bit(MBX_TMO_ERR, &phba->bit_flags)) {
+			/* Perform a PCI function reset to start from clean */
+			rc = lpfc_pci_function_reset(phba);
+			lpfc_els_flush_all_cmd(phba);
+		}
 		lpfc_offline_prep(phba, LPFC_MBX_NO_WAIT);
 		lpfc_sli_flush_io_rings(phba);
 	}
 	lpfc_offline(phba);
-	lpfc_sli_brdrestart(phba);
-	lpfc_online(phba);
-	lpfc_unblock_mgmt_io(phba);
+	clear_bit(MBX_TMO_ERR, &phba->bit_flags);
+	if (unlikely(rc)) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				"8888 PCI function reset failed rc %x\n",
+				rc);
+	} else {
+		lpfc_sli_brdrestart(phba);
+		lpfc_online(phba);
+		lpfc_unblock_mgmt_io(phba);
+	}
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 58d10f8f75a7..4dfadf254a72 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -3935,6 +3935,8 @@ void lpfc_poll_eratt(struct timer_list *t)
 	uint64_t sli_intr, cnt;
 
 	phba = from_timer(phba, t, eratt_poll);
+	if (!(phba->hba_flag & HBA_SETUP))
+		return;
 
 	/* Here we will also keep track of interrupts per sec of the hba */
 	sli_intr = phba->sli.slistat.sli_intr;
@@ -7693,7 +7695,9 @@ lpfc_sli4_repost_sgl_list(struct lpfc_hba *phba,
 		spin_unlock_irq(&phba->hbalock);
 	} else {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"3161 Failure to post sgl to port.\n");
+				"3161 Failure to post sgl to port,status %x "
+				"blkcnt %d totalcnt %d postcnt %d\n",
+				status, block_cnt, total_cnt, post_cnt);
 		return -EIO;
 	}
 
@@ -8478,6 +8482,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 			spin_unlock_irq(&phba->hbalock);
 		}
 	}
+	phba->hba_flag &= ~HBA_SETUP;
 
 	lpfc_sli4_dip(phba);
 
@@ -9282,6 +9287,7 @@ lpfc_mbox_timeout_handler(struct lpfc_hba *phba)
 	 * would get IOCB_ERROR from lpfc_sli_issue_iocb, allowing
 	 * it to fail all outstanding SCSI IO.
 	 */
+	set_bit(MBX_TMO_ERR, &phba->bit_flags);
 	spin_lock_irq(&phba->pport->work_port_lock);
 	phba->pport->work_port_events &= ~WORKER_MBOX_TMO;
 	spin_unlock_irq(&phba->pport->work_port_lock);
diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 3554f6b07727..94abba57582d 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2332,7 +2332,7 @@ struct megasas_instance {
 	u32 support_morethan256jbod; /* FW support for more than 256 PD/JBOD */
 	bool use_seqnum_jbod_fp;   /* Added for PD sequence */
 	bool smp_affinity_enable;
-	spinlock_t crashdump_lock;
+	struct mutex crashdump_lock;
 
 	struct megasas_register_set __iomem *reg_set;
 	u32 __iomem *reply_post_host_index_addr[MR_MAX_MSIX_REG_ARRAY];
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 050eed8e2684..c0d47141f6d3 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3271,14 +3271,13 @@ fw_crash_buffer_store(struct device *cdev,
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
 
@@ -3293,24 +3292,23 @@ fw_crash_buffer_show(struct device *cdev,
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
 
@@ -3322,7 +3320,7 @@ fw_crash_buffer_show(struct device *cdev,
 	src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
 		(buff_offset % dmachunk);
 	memcpy(buf, (void *)src_addr, size);
-	spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+	mutex_unlock(&instance->crashdump_lock);
 
 	return size;
 }
@@ -3347,7 +3345,6 @@ fw_crash_state_store(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 	int val = 0;
-	unsigned long flags;
 
 	if (kstrtoint(buf, 0, &val) != 0)
 		return -EINVAL;
@@ -3361,9 +3358,9 @@ fw_crash_state_store(struct device *cdev,
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
@@ -7422,7 +7419,7 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	init_waitqueue_head(&instance->int_cmd_wait_q);
 	init_waitqueue_head(&instance->abort_cmd_wait_q);
 
-	spin_lock_init(&instance->crashdump_lock);
+	mutex_init(&instance->crashdump_lock);
 	spin_lock_init(&instance->mfi_pool_lock);
 	spin_lock_init(&instance->hba_lock);
 	spin_lock_init(&instance->stream_lock);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 4995e1ef4e0e..6ebd1336a899 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -275,7 +275,6 @@ static irqreturn_t pm8001_interrupt_handler_intx(int irq, void *dev_id)
 	return ret;
 }
 
-static u32 pm8001_setup_irq(struct pm8001_hba_info *pm8001_ha);
 static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha);
 
 /**
@@ -296,13 +295,6 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
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
@@ -1034,47 +1026,38 @@ static u32 pm8001_request_msix(struct pm8001_hba_info *pm8001_ha)
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
index f060e593685d..a7a364760b80 100644
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
@@ -708,14 +708,14 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
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
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 0556969f6dc1..a4a56ab0ba74 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -577,7 +577,7 @@ fcport_is_bigger(fc_port_t *fcport)
 static inline struct qla_qpair *
 qla_mapq_nvme_select_qpair(struct qla_hw_data *ha, struct qla_qpair *qpair)
 {
-	int cpuid = smp_processor_id();
+	int cpuid = raw_smp_processor_id();
 
 	if (qpair->cpuid != cpuid &&
 	    ha->qp_cpu_map[cpuid]) {
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 1f42a413b598..a7321e02c641 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3817,7 +3817,7 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 	if (!ha->flags.fw_started)
 		return;
 
-	if (rsp->qpair->cpuid != smp_processor_id() || !rsp->qpair->rcv_intr) {
+	if (rsp->qpair->cpuid != raw_smp_processor_id() || !rsp->qpair->rcv_intr) {
 		rsp->qpair->rcv_intr = 1;
 
 		if (!rsp->qpair->cpu_mapped)
@@ -4308,7 +4308,7 @@ qla2xxx_msix_rsp_q(int irq, void *dev_id)
 	}
 	ha = qpair->hw;
 
-	queue_work_on(smp_processor_id(), ha->wq, &qpair->q_work);
+	queue_work(ha->wq, &qpair->q_work);
 
 	return IRQ_HANDLED;
 }
@@ -4334,7 +4334,7 @@ qla2xxx_msix_rsp_q_hs(int irq, void *dev_id)
 	wrt_reg_dword(&reg->hccr, HCCRX_CLR_RISC_INT);
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
-	queue_work_on(smp_processor_id(), ha->wq, &qpair->q_work);
+	queue_work(ha->wq, &qpair->q_work);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 2b815a9928ea..2ef2dbac0db2 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4425,8 +4425,7 @@ static int qlt_handle_cmd_for_atio(struct scsi_qla_host *vha,
 		queue_work_on(cmd->se_cmd.cpuid, qla_tgt_wq, &cmd->work);
 	} else if (ha->msix_count) {
 		if (cmd->atio.u.isp24.fcp_cmnd.rddata)
-			queue_work_on(smp_processor_id(), qla_tgt_wq,
-			    &cmd->work);
+			queue_work(qla_tgt_wq, &cmd->work);
 		else
 			queue_work_on(cmd->se_cmd.cpuid, qla_tgt_wq,
 			    &cmd->work);
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 3b5ba4b47b3b..68a0e6a2fb6e 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -310,7 +310,7 @@ static void tcm_qla2xxx_free_cmd(struct qla_tgt_cmd *cmd)
 	cmd->trc_flags |= TRC_CMD_DONE;
 
 	INIT_WORK(&cmd->work, tcm_qla2xxx_complete_free);
-	queue_work_on(smp_processor_id(), tcm_qla2xxx_free_wq, &cmd->work);
+	queue_work(tcm_qla2xxx_free_wq, &cmd->work);
 }
 
 /*
@@ -547,7 +547,7 @@ static void tcm_qla2xxx_handle_data(struct qla_tgt_cmd *cmd)
 	cmd->trc_flags |= TRC_DATA_IN;
 	cmd->cmd_in_wq = 1;
 	INIT_WORK(&cmd->work, tcm_qla2xxx_handle_data_work);
-	queue_work_on(smp_processor_id(), tcm_qla2xxx_free_wq, &cmd->work);
+	queue_work(tcm_qla2xxx_free_wq, &cmd->work);
 }
 
 static int tcm_qla2xxx_chk_dif_tags(uint32_t tag)
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 30d541612253..cec2747235ab 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -83,6 +83,9 @@
 #define SUN6I_XMIT_CNT_REG		0x34
 
 #define SUN6I_BURST_CTL_CNT_REG		0x38
+#define SUN6I_BURST_CTL_CNT_STC_MASK		GENMASK(23, 0)
+#define SUN6I_BURST_CTL_CNT_DRM			BIT(28)
+#define SUN6I_BURST_CTL_CNT_QUAD_EN		BIT(29)
 
 #define SUN6I_TXDATA_REG		0x200
 #define SUN6I_RXDATA_REG		0x300
@@ -90,6 +93,7 @@
 struct sun6i_spi_cfg {
 	unsigned long		fifo_depth;
 	bool			has_clk_ctl;
+	u32			mode_bits;
 };
 
 struct sun6i_spi {
@@ -266,7 +270,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	unsigned int div, div_cdr1, div_cdr2, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
-	unsigned int tx_len = 0, rx_len = 0;
+	unsigned int tx_len = 0, rx_len = 0, nbits = 0;
 	bool use_dma;
 	int ret = 0;
 	u32 reg;
@@ -418,13 +422,29 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG, reg);
 
 	/* Setup the transfer now... */
-	if (sspi->tx_buf)
+	if (sspi->tx_buf) {
 		tx_len = tfr->len;
+		nbits = tfr->tx_nbits;
+	} else if (tfr->rx_buf) {
+		nbits = tfr->rx_nbits;
+	}
+
+	switch (nbits) {
+	case SPI_NBITS_DUAL:
+		reg = SUN6I_BURST_CTL_CNT_DRM;
+		break;
+	case SPI_NBITS_QUAD:
+		reg = SUN6I_BURST_CTL_CNT_QUAD_EN;
+		break;
+	case SPI_NBITS_SINGLE:
+	default:
+		reg = FIELD_PREP(SUN6I_BURST_CTL_CNT_STC_MASK, tx_len);
+	}
 
 	/* Setup the counters */
+	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG, reg);
 	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, tfr->len);
 	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, tx_len);
-	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG, tx_len);
 
 	if (!use_dma) {
 		/* Fill the TX FIFO */
@@ -623,7 +643,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	master->set_cs = sun6i_spi_set_cs;
 	master->transfer_one = sun6i_spi_transfer_one;
 	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			    sspi->cfg->mode_bits;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index 80e36d03c4e2..0e0ccef4871e 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -11,45 +11,45 @@
 
 static const struct usb_device_id usb_prism_tbl[] = {
 	PRISM_DEV(0x04bb, 0x0922, "IOData AirPort WN-B11/USBS"),
-	PRISM_DEV(0x07aa, 0x0012, "Corega Wireless LAN USB Stick-11"),
-	PRISM_DEV(0x09aa, 0x3642, "Prism2.x 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x1668, 0x0408, "Actiontec Prism2.5 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x1668, 0x0421, "Actiontec Prism2.5 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x1915, 0x2236, "Linksys WUSB11v3.0 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x066b, 0x2212, "Linksys WUSB11v2.5 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x066b, 0x2213, "Linksys WUSB12v1.1 11Mbps WLAN USB Adapter"),
+	PRISM_DEV(0x07aa, 0x0012, "Corega USB Wireless LAN Stick-11"),
+	PRISM_DEV(0x09aa, 0x3642, "Prism2.x 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x1668, 0x0408, "Actiontec Prism2.5 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x1668, 0x0421, "Actiontec Prism2.5 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x1915, 0x2236, "Linksys WUSB11v3.0 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x066b, 0x2212, "Linksys WUSB11v2.5 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x066b, 0x2213, "Linksys WUSB12v1.1 11Mbps USB WLAN Adapter"),
 	PRISM_DEV(0x0411, 0x0016, "Melco WLI-USB-S11 11Mbps WLAN Adapter"),
-	PRISM_DEV(0x08de, 0x7a01, "PRISM25 IEEE 802.11 Mini USB Adapter"),
-	PRISM_DEV(0x8086, 0x1111, "Intel PRO/Wireless 2011B LAN USB Adapter"),
+	PRISM_DEV(0x08de, 0x7a01, "PRISM25 USB IEEE 802.11 Mini Adapter"),
+	PRISM_DEV(0x8086, 0x1111, "Intel PRO/Wireless 2011B USB LAN Adapter"),
 	PRISM_DEV(0x0d8e, 0x7a01, "PRISM25 IEEE 802.11 Mini USB Adapter"),
-	PRISM_DEV(0x045e, 0x006e, "Microsoft MN510 Wireless USB Adapter"),
+	PRISM_DEV(0x045e, 0x006e, "Microsoft MN510 USB Wireless Adapter"),
 	PRISM_DEV(0x0967, 0x0204, "Acer Warplink USB Adapter"),
 	PRISM_DEV(0x0cde, 0x0002, "Z-Com 725/726 Prism2.5 USB/USB Integrated"),
-	PRISM_DEV(0x0cde, 0x0005, "Z-Com Xl735 Wireless 802.11b USB Adapter"),
-	PRISM_DEV(0x413c, 0x8100, "Dell TrueMobile 1180 Wireless USB Adapter"),
-	PRISM_DEV(0x0b3b, 0x1601, "ALLNET 0193 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x0b3b, 0x1602, "ZyXEL ZyAIR B200 Wireless USB Adapter"),
-	PRISM_DEV(0x0baf, 0x00eb, "USRobotics USR1120 Wireless USB Adapter"),
+	PRISM_DEV(0x0cde, 0x0005, "Z-Com Xl735 USB Wireless 802.11b Adapter"),
+	PRISM_DEV(0x413c, 0x8100, "Dell TrueMobile 1180 USB Wireless Adapter"),
+	PRISM_DEV(0x0b3b, 0x1601, "ALLNET 0193 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x0b3b, 0x1602, "ZyXEL ZyAIR B200 USB Wireless Adapter"),
+	PRISM_DEV(0x0baf, 0x00eb, "USRobotics USR1120 USB Wireless Adapter"),
 	PRISM_DEV(0x0411, 0x0027, "Melco WLI-USB-KS11G 11Mbps WLAN Adapter"),
 	PRISM_DEV(0x04f1, 0x3009, "JVC MP-XP7250 Builtin USB WLAN Adapter"),
 	PRISM_DEV(0x0846, 0x4110, "NetGear MA111"),
 	PRISM_DEV(0x03f3, 0x0020, "Adaptec AWN-8020 USB WLAN Adapter"),
-	PRISM_DEV(0x2821, 0x3300, "ASUS-WL140 / Hawking HighDB Wireless USB Adapter"),
-	PRISM_DEV(0x2001, 0x3700, "DWL-122 Wireless USB Adapter"),
-	PRISM_DEV(0x2001, 0x3702, "DWL-120 Rev F Wireless USB Adapter"),
+	PRISM_DEV(0x2821, 0x3300, "ASUS-WL140 / Hawking HighDB USB Wireless Adapter"),
+	PRISM_DEV(0x2001, 0x3700, "DWL-122 USB Wireless Adapter"),
+	PRISM_DEV(0x2001, 0x3702, "DWL-120 Rev F USB Wireless Adapter"),
 	PRISM_DEV(0x50c2, 0x4013, "Averatec USB WLAN Adapter"),
-	PRISM_DEV(0x2c02, 0x14ea, "Planex GW-US11H WLAN USB Adapter"),
-	PRISM_DEV(0x124a, 0x168b, "Airvast PRISM3 WLAN USB Adapter"),
+	PRISM_DEV(0x2c02, 0x14ea, "Planex GW-US11H USB WLAN Adapter"),
+	PRISM_DEV(0x124a, 0x168b, "Airvast PRISM3 USB WLAN Adapter"),
 	PRISM_DEV(0x083a, 0x3503, "T-Sinus 111 USB WLAN Adapter"),
 	PRISM_DEV(0x0411, 0x0044, "Melco WLI-USB-KB11 11Mbps WLAN Adapter"),
-	PRISM_DEV(0x1668, 0x6106, "ROPEX FreeLan 802.11b USB Adapter"),
-	PRISM_DEV(0x124a, 0x4017, "Pheenet WL-503IA 802.11b USB Adapter"),
+	PRISM_DEV(0x1668, 0x6106, "ROPEX FreeLan USB 802.11b Adapter"),
+	PRISM_DEV(0x124a, 0x4017, "Pheenet WL-503IA USB 802.11b Adapter"),
 	PRISM_DEV(0x0bb2, 0x0302, "Ambit Microsystems Corp."),
-	PRISM_DEV(0x9016, 0x182d, "Sitecom WL-022 802.11b USB Adapter"),
+	PRISM_DEV(0x9016, 0x182d, "Sitecom WL-022 USB 802.11b Adapter"),
 	PRISM_DEV(0x0543, 0x0f01,
 		  "ViewSonic Airsync USB Adapter 11Mbps (Prism2.5)"),
 	PRISM_DEV(0x067c, 0x1022,
-		  "Siemens SpeedStream 1022 11Mbps WLAN USB Adapter"),
+		  "Siemens SpeedStream 1022 11Mbps USB WLAN Adapter"),
 	PRISM_DEV(0x049f, 0x0033,
 		  "Compaq/Intel W100 PRO/Wireless 11Mbps multiport WLAN Adapter"),
 	{ } /* terminator */
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 5d0f51822414..c142a67dc7cc 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -533,102 +533,102 @@ static ssize_t lio_target_nacl_info_show(struct config_item *item, char *page)
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
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 687adc9e086c..0686882bcbda 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -264,6 +264,7 @@ void target_free_cmd_counter(struct target_cmd_counter *cmd_cnt)
 		percpu_ref_put(&cmd_cnt->refcnt);
 
 	percpu_ref_exit(&cmd_cnt->refcnt);
+	kfree(cmd_cnt);
 }
 EXPORT_SYMBOL_GPL(target_free_cmd_counter);
 
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 66afa9bea6bf..71366a4cea22 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1255,19 +1255,14 @@ static void cpm_uart_console_write(struct console *co, const char *s,
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
index 884e2301237f..1168dbeed2ce 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -255,9 +255,10 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
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
index 7b151f5af3cc..0725668ffea4 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -208,8 +208,9 @@ static int __maybe_unused cdnsp_pci_resume(struct device *dev)
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
index 2d332a788871..4a4dbc2c1561 100644
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
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index f210b7489fd5..78cfbe621272 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -257,6 +257,7 @@ struct ci_hdrc {
 	bool				id_event;
 	bool				b_sess_valid_event;
 	bool				imx28_write_fix;
+	bool				has_portsc_pec_bug;
 	bool				supports_runtime_pm;
 	bool				in_lpm;
 	bool				wakeup_int;
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 873539f9a2c0..a96d8af93538 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -67,11 +67,13 @@ static const struct ci_hdrc_imx_platform_flag imx7d_usb_data = {
 
 static const struct ci_hdrc_imx_platform_flag imx7ulp_usb_data = {
 	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM |
+		CI_HDRC_HAS_PORTSC_PEC_MISSED |
 		CI_HDRC_PMQOS,
 };
 
 static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
-	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM,
+	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM |
+		CI_HDRC_HAS_PORTSC_PEC_MISSED,
 };
 
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 51994d655b82..500286a4576b 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1045,6 +1045,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		CI_HDRC_IMX28_WRITE_FIX);
 	ci->supports_runtime_pm = !!(ci->platdata->flags &
 		CI_HDRC_SUPPORTS_RUNTIME_PM);
+	ci->has_portsc_pec_bug = !!(ci->platdata->flags &
+		CI_HDRC_HAS_PORTSC_PEC_MISSED);
 	platform_set_drvdata(pdev, ci);
 
 	ret = hw_device_init(ci, base);
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index ebe7400243b1..08af26b762a2 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -151,6 +151,7 @@ static int host_start(struct ci_hdrc *ci)
 	ehci->has_hostpc = ci->hw_bank.lpm;
 	ehci->has_tdi_phy_lpm = ci->hw_bank.lpm;
 	ehci->imx28_write_fix = ci->imx28_write_fix;
+	ehci->has_ci_pec_bug = ci->has_portsc_pec_bug;
 
 	priv = (struct ehci_ci_priv *)ehci->priv;
 	priv->reg_vbus = NULL;
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 9c5dc1c1a68e..4aae86b47edf 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1959,6 +1959,8 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		int pipe = index & USB_ENDPOINT_NUMBER_MASK;
+		if (pipe >= USB_MAX_ENDPOINTS)
+			goto stall;
 		struct qe_ep *target_ep = &udc->eps[pipe];
 		u16 usep;
 
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index a1930db0da1c..802bfafb1012 100644
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
index efe30e3be22f..1aee392e8492 100644
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
@@ -875,6 +876,13 @@ int ehci_hub_control(
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
index c5c7f8782549..1441e3400796 100644
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
@@ -707,6 +708,15 @@ ehci_port_speed(struct ehci_hcd *ehci, unsigned int portsc)
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
diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 5e8edf3881c0..61a88f68b458 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -117,6 +117,16 @@ enum {
 	  IOM_PORT_STATUS_DHPD_HPD_STATUS_SHIFT) &			\
 	 IOM_PORT_STATUS_DHPD_HPD_STATUS_ASSERT)
 
+/* IOM port status register */
+#define IOM_PORT_STATUS_REGS(_offset_, _size_)	((_offset_) | (_size_))
+#define IOM_PORT_STATUS_REGS_SZ_MASK		BIT(0)
+#define IOM_PORT_STATUS_REGS_SZ_4		0
+#define IOM_PORT_STATUS_REGS_SZ_8		1
+#define IOM_PORT_STATUS_REGS_OFFSET(_d_)				\
+	((_d_) & ~IOM_PORT_STATUS_REGS_SZ_MASK)
+#define IOM_PORT_STATUS_REGS_SIZE(_d_)					\
+	(4 << ((_d_) & IOM_PORT_STATUS_REGS_SZ_MASK))
+
 struct pmc_usb;
 
 struct pmc_usb_port {
@@ -145,6 +155,7 @@ struct pmc_usb {
 	struct acpi_device *iom_adev;
 	void __iomem *iom_base;
 	u32 iom_port_status_offset;
+	u8 iom_port_status_size;
 
 	struct dentry *dentry;
 };
@@ -160,7 +171,7 @@ static void update_port_status(struct pmc_usb_port *port)
 
 	port->iom_status = readl(port->pmc->iom_base +
 				 port->pmc->iom_port_status_offset +
-				 port_num * sizeof(u32));
+				 port_num * port->pmc->iom_port_status_size);
 }
 
 static int sbu_orientation(struct pmc_usb_port *port)
@@ -589,13 +600,16 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
 /* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
 static const struct acpi_device_id iom_acpi_ids[] = {
 	/* TigerLake */
-	{ "INTC1072", 0x560, },
+	{ "INTC1072", IOM_PORT_STATUS_REGS(0x560, IOM_PORT_STATUS_REGS_SZ_4) },
 
 	/* AlderLake */
-	{ "INTC1079", 0x160, },
+	{ "INTC1079", IOM_PORT_STATUS_REGS(0x160, IOM_PORT_STATUS_REGS_SZ_4) },
 
 	/* Meteor Lake */
-	{ "INTC107A", 0x160, },
+	{ "INTC107A", IOM_PORT_STATUS_REGS(0x160, IOM_PORT_STATUS_REGS_SZ_4) },
+
+	/* Lunar Lake */
+	{ "INTC10EA", IOM_PORT_STATUS_REGS(0x150, IOM_PORT_STATUS_REGS_SZ_8) },
 	{}
 };
 
@@ -615,7 +629,8 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 	if (!adev)
 		return -ENODEV;
 
-	pmc->iom_port_status_offset = (u32)dev_id->driver_data;
+	pmc->iom_port_status_offset = IOM_PORT_STATUS_REGS_OFFSET(dev_id->driver_data);
+	pmc->iom_port_status_size = IOM_PORT_STATUS_REGS_SIZE(dev_id->driver_data);
 
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_memory_resources(adev, &resource_list);
diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 5d393f520fc2..0b2993fef564 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -79,6 +79,7 @@ config TYPEC_WCOVE
 config TYPEC_QCOM_PMIC
 	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on DRM || DRM=n
 	help
 	  A Type-C port and Power Delivery driver which aggregates two
 	  discrete pieces of silicon in the PM8150b PMIC block: the
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index 9b467a346114..273b4811b4ac 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -17,6 +17,9 @@
 #include <linux/usb/role.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec_mux.h>
+
+#include <drm/drm_bridge.h>
+
 #include "qcom_pmic_typec_pdphy.h"
 #include "qcom_pmic_typec_port.h"
 
@@ -33,6 +36,7 @@ struct pmic_typec {
 	struct pmic_typec_port	*pmic_typec_port;
 	bool			vbus_enabled;
 	struct mutex		lock;		/* VBUS state serialization */
+	struct drm_bridge	bridge;
 };
 
 #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
@@ -146,6 +150,35 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_DRM)
+static int qcom_pmic_typec_attach(struct drm_bridge *bridge,
+				     enum drm_bridge_attach_flags flags)
+{
+	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
+}
+
+static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
+	.attach = qcom_pmic_typec_attach,
+};
+
+static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
+{
+	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
+#ifdef CONFIG_OF
+	tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
+#endif
+	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
+	tcpm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
+
+	return devm_drm_bridge_add(tcpm->dev, &tcpm->bridge);
+}
+#else
+static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
+{
+	return 0;
+}
+#endif
+
 static int qcom_pmic_typec_probe(struct platform_device *pdev)
 {
 	struct pmic_typec *tcpm;
@@ -208,6 +241,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	mutex_init(&tcpm->lock);
 	platform_set_drvdata(pdev, tcpm);
 
+	ret = qcom_pmic_typec_init_drm(tcpm);
+	if (ret)
+		return ret;
+
 	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
 	if (!tcpm->tcpc.fwnode)
 		return -EINVAL;
diff --git a/fs/attr.c b/fs/attr.c
index d60dc1edb526..87af68bb8ad2 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -394,9 +394,25 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
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
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 82324c327a50..5e7a19fca79c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3014,8 +3014,16 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 fail:
 	btrfs_release_path(path);
-	/* We didn't update the block group item, need to revert @commit_used. */
-	if (ret < 0) {
+	/*
+	 * We didn't update the block group item, need to revert commit_used
+	 * unless the block group item didn't exist yet - this is to prevent a
+	 * race with a concurrent insertion of the block group item, with
+	 * insert_block_group_item(), that happened just after we attempted to
+	 * update. In that case we would reset commit_used to 0 just after the
+	 * insertion set it to a value greater than 0 - if the block group later
+	 * becomes with 0 used bytes, we would incorrectly skip its update.
+	 */
+	if (ret < 0 && ret != -ENOENT) {
 		spin_lock(&cache->lock);
 		cache->commit_used = old_commit_used;
 		spin_unlock(&cache->lock);
@@ -4273,6 +4281,17 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	struct btrfs_caching_control *caching_ctl;
 	struct rb_node *n;
 
+	if (btrfs_is_zoned(info)) {
+		if (info->active_meta_bg) {
+			btrfs_put_block_group(info->active_meta_bg);
+			info->active_meta_bg = NULL;
+		}
+		if (info->active_system_bg) {
+			btrfs_put_block_group(info->active_system_bg);
+			info->active_system_bg = NULL;
+		}
+	}
+
 	write_lock(&info->block_group_cache_lock);
 	while (!list_empty(&info->caching_block_groups)) {
 		caching_ctl = list_entry(info->caching_block_groups.next,
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6d51db066503..0f147240ce9b 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1153,20 +1153,33 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
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
index 4494883a19ab..681594df7334 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -525,6 +525,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(mapping->host->i_sb);
+	struct btrfs_subpage_info *spi = fs_info->subpage_info;
 	struct btrfs_subpage *subpage;
 	struct extent_buffer *eb;
 	int cur_bit = 0;
@@ -538,18 +539,19 @@ static bool btree_dirty_folio(struct address_space *mapping,
 		btrfs_assert_tree_write_locked(eb);
 		return filemap_dirty_folio(mapping, folio);
 	}
+
+	ASSERT(spi);
 	subpage = folio_get_private(folio);
 
-	ASSERT(subpage->dirty_bitmap);
-	while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
+	for (cur_bit = spi->dirty_offset;
+	     cur_bit < spi->dirty_offset + spi->bitmap_nr_bits;
+	     cur_bit++) {
 		unsigned long flags;
 		u64 cur;
-		u16 tmp = (1 << cur_bit);
 
 		spin_lock_irqsave(&subpage->lock, flags);
-		if (!(tmp & subpage->dirty_bitmap)) {
+		if (!test_bit(cur_bit, subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
-			cur_bit++;
 			continue;
 		}
 		spin_unlock_irqrestore(&subpage->lock, flags);
@@ -562,7 +564,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
 		btrfs_assert_tree_write_locked(eb);
 		free_extent_buffer(eb);
 
-		cur_bit += (fs_info->nodesize >> fs_info->sectorsize_bits);
+		cur_bit += (fs_info->nodesize >> fs_info->sectorsize_bits) - 1;
 	}
 	return filemap_dirty_folio(mapping, folio);
 }
@@ -2391,13 +2393,11 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
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
index e5566827da17..0917c5f39e3d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -402,11 +402,11 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 		}
 	}
 
+	WARN_ON(1);
 	btrfs_print_leaf(eb);
 	btrfs_err(eb->fs_info,
 		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
 		  eb->start, (unsigned long)iref, type);
-	WARN_ON(1);
 
 	return BTRFS_REF_TYPE_INVALID;
 }
@@ -869,6 +869,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
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
@@ -1079,13 +1084,13 @@ static int lookup_extent_backref(struct btrfs_trans_handle *trans,
 /*
  * helper to update/remove inline back ref
  */
-static noinline_for_stack
-void update_inline_extent_backref(struct btrfs_path *path,
+static noinline_for_stack int update_inline_extent_backref(struct btrfs_path *path,
 				  struct btrfs_extent_inline_ref *iref,
 				  int refs_to_mod,
 				  struct btrfs_delayed_extent_op *extent_op)
 {
 	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_data_ref *dref = NULL;
 	struct btrfs_shared_data_ref *sref = NULL;
@@ -1098,18 +1103,33 @@ void update_inline_extent_backref(struct btrfs_path *path,
 
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	refs = btrfs_extent_refs(leaf, ei);
-	WARN_ON(refs_to_mod < 0 && refs + refs_to_mod <= 0);
+	if (unlikely(refs_to_mod < 0 && refs + refs_to_mod <= 0)) {
+		struct btrfs_key key;
+		u32 extent_size;
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		if (key.type == BTRFS_METADATA_ITEM_KEY)
+			extent_size = fs_info->nodesize;
+		else
+			extent_size = key.offset;
+		btrfs_print_leaf(leaf);
+		btrfs_err(fs_info,
+	"invalid refs_to_mod for extent %llu num_bytes %u, has %d expect >= -%llu",
+			  key.objectid, extent_size, refs_to_mod, refs);
+		return -EUCLEAN;
+	}
 	refs += refs_to_mod;
 	btrfs_set_extent_refs(leaf, ei, refs);
 	if (extent_op)
 		__run_delayed_extent_op(extent_op, leaf, ei);
 
+	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_ANY);
 	/*
-	 * If type is invalid, we should have bailed out after
-	 * lookup_inline_extent_backref().
+	 * Function btrfs_get_extent_inline_ref_type() has already printed
+	 * error messages.
 	 */
-	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_ANY);
-	ASSERT(type != BTRFS_REF_TYPE_INVALID);
+	if (unlikely(type == BTRFS_REF_TYPE_INVALID))
+		return -EUCLEAN;
 
 	if (type == BTRFS_EXTENT_DATA_REF_KEY) {
 		dref = (struct btrfs_extent_data_ref *)(&iref->offset);
@@ -1119,10 +1139,43 @@ void update_inline_extent_backref(struct btrfs_path *path,
 		refs = btrfs_shared_data_ref_count(leaf, sref);
 	} else {
 		refs = 1;
-		BUG_ON(refs_to_mod != -1);
+		/*
+		 * For tree blocks we can only drop one ref for it, and tree
+		 * blocks should not have refs > 1.
+		 *
+		 * Furthermore if we're inserting a new inline backref, we
+		 * won't reach this path either. That would be
+		 * setup_inline_extent_backref().
+		 */
+		if (unlikely(refs_to_mod != -1)) {
+			struct btrfs_key key;
+
+			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+			btrfs_print_leaf(leaf);
+			btrfs_err(fs_info,
+			"invalid refs_to_mod for tree block %llu, has %d expect -1",
+				  key.objectid, refs_to_mod);
+			return -EUCLEAN;
+		}
 	}
 
-	BUG_ON(refs_to_mod < 0 && refs < -refs_to_mod);
+	if (unlikely(refs_to_mod < 0 && refs < -refs_to_mod)) {
+		struct btrfs_key key;
+		u32 extent_size;
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		if (key.type == BTRFS_METADATA_ITEM_KEY)
+			extent_size = fs_info->nodesize;
+		else
+			extent_size = key.offset;
+		btrfs_print_leaf(leaf);
+		btrfs_err(fs_info,
+"invalid refs_to_mod for backref entry, iref %lu extent %llu num_bytes %u, has %d expect >= -%llu",
+			  (unsigned long)iref, key.objectid, extent_size,
+			  refs_to_mod, refs);
+		return -EUCLEAN;
+	}
 	refs += refs_to_mod;
 
 	if (refs > 0) {
@@ -1142,6 +1195,7 @@ void update_inline_extent_backref(struct btrfs_path *path,
 		btrfs_truncate_item(path, item_size, 1);
 	}
 	btrfs_mark_buffer_dirty(leaf);
+	return 0;
 }
 
 static noinline_for_stack
@@ -1170,7 +1224,7 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 				   bytenr, num_bytes, root_objectid, path->slots[0]);
 			return -EUCLEAN;
 		}
-		update_inline_extent_backref(path, iref, refs_to_add, extent_op);
+		ret = update_inline_extent_backref(path, iref, refs_to_add, extent_op);
 	} else if (ret == -ENOENT) {
 		setup_inline_extent_backref(trans->fs_info, path, iref, parent,
 					    root_objectid, owner, offset,
@@ -1190,7 +1244,7 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 
 	BUG_ON(!is_data && refs_to_drop != 1);
 	if (iref)
-		update_inline_extent_backref(path, iref, -refs_to_drop, NULL);
+		ret = update_inline_extent_backref(path, iref, -refs_to_drop, NULL);
 	else if (is_data)
 		ret = remove_extent_data_ref(trans, root, path, refs_to_drop);
 	else
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 90ad3006ef3a..2ebc982e8ecc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1877,11 +1877,10 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
  * previous call.
  * Return <0 for fatal error.
  */
-static int submit_eb_page(struct page *page, struct writeback_control *wbc,
-			  struct extent_buffer **eb_context)
+static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 {
+	struct writeback_control *wbc = ctx->wbc;
 	struct address_space *mapping = page->mapping;
-	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -1908,7 +1907,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	if (eb == *eb_context) {
+	if (eb == ctx->eb) {
 		spin_unlock(&mapping->private_lock);
 		return 0;
 	}
@@ -1917,34 +1916,25 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	if (!ret)
 		return 0;
 
-	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
-		/*
-		 * If for_sync, this hole will be filled with
-		 * trasnsaction commit.
-		 */
-		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
-			ret = -EAGAIN;
-		else
+	ctx->eb = eb;
+
+	ret = btrfs_check_meta_write_pointer(eb->fs_info, ctx);
+	if (ret) {
+		if (ret == -EBUSY)
 			ret = 0;
 		free_extent_buffer(eb);
 		return ret;
 	}
 
-	*eb_context = eb;
-
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		btrfs_revert_meta_write_pointer(cache, eb);
-		if (cache)
-			btrfs_put_block_group(cache);
 		free_extent_buffer(eb);
 		return 0;
 	}
-	if (cache) {
-		/*
-		 * Implies write in zoned mode. Mark the last eb in a block group.
-		 */
-		btrfs_schedule_zone_finish_bg(cache, eb);
-		btrfs_put_block_group(cache);
+	/* Implies write in zoned mode. */
+	if (ctx->zoned_bg) {
+		/* Mark the last eb in the block group. */
+		btrfs_schedule_zone_finish_bg(ctx->zoned_bg, eb);
+		ctx->zoned_bg->meta_write_pointer += eb->len;
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
@@ -1954,7 +1944,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
-	struct extent_buffer *eb_context = NULL;
+	struct btrfs_eb_write_context ctx = { .wbc = wbc };
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
 	int done = 0;
@@ -1996,7 +1986,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, wbc, &eb_context);
+			ret = submit_eb_page(&folio->page, &ctx);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -2057,6 +2047,9 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = 0;
 	if (!ret && BTRFS_FS_ERROR(fs_info))
 		ret = -EROFS;
+
+	if (ctx.zoned_bg)
+		btrfs_put_block_group(ctx.zoned_bg);
 	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c5fae3a7d911..f61b7896320a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -94,6 +94,13 @@ struct extent_buffer {
 #endif
 };
 
+struct btrfs_eb_write_context {
+	struct writeback_control *wbc;
+	struct extent_buffer *eb;
+	/* Block group @eb resides in. Only used for zoned mode. */
+	struct btrfs_block_group *zoned_bg;
+};
+
 /*
  * Get the correct offset inside the page of extent buffer.
  *
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..1f2d33112106 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -766,6 +766,9 @@ struct btrfs_fs_info {
 	u64 data_reloc_bg;
 	struct mutex zoned_data_reloc_io_lock;
 
+	struct btrfs_block_group *active_meta_bg;
+	struct btrfs_block_group *active_system_bg;
+
 	u64 nr_global_roots;
 
 	spinlock_t zone_active_bgs_lock;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a895d105464b..d27b0d86b8e2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1958,6 +1958,13 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
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
@@ -1978,7 +1985,6 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 				goto out_put;
 			}
 
-			btrfs_release_path(path);
 			key.objectid = key.offset;
 			key.offset = (u64)-1;
 			dirid = key.objectid;
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a629532283bc..5b1aac3fc8e4 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -635,7 +635,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 			refcount_inc(&trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
 
-		ASSERT(trans);
+		ASSERT(trans || BTRFS_FS_ERROR(fs_info));
 		if (trans) {
 			if (atomic_dec_and_test(&trans->pending_ordered))
 				wake_up(&trans->pending_wait);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6aa9bf3661ac..51070c0d4141 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -681,6 +681,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
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
index b8c51f16ba86..0f87057bb575 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -749,5 +749,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
+u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb);
 
 #endif
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d9e6df2da272..f97e927499d7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -65,6 +65,9 @@
 
 #define SUPER_INFO_SECTORS	((u64)BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT)
 
+static void wait_eb_writebacks(struct btrfs_block_group *block_group);
+static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written);
+
 static inline bool sb_zone_is_full(const struct blk_zone *zone)
 {
 	return (zone->cond == BLK_ZONE_COND_FULL) ||
@@ -1758,41 +1761,121 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 	}
 }
 
-bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb,
-				    struct btrfs_block_group **cache_ret)
+static bool check_bg_is_active(struct btrfs_eb_write_context *ctx,
+			       struct btrfs_block_group **active_bg)
 {
-	struct btrfs_block_group *cache;
-	bool ret = true;
+	const struct writeback_control *wbc = ctx->wbc;
+	struct btrfs_block_group *block_group = ctx->zoned_bg;
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 
-	if (!btrfs_is_zoned(fs_info))
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
 		return true;
 
-	cache = btrfs_lookup_block_group(fs_info, eb->start);
-	if (!cache)
-		return true;
+	if (fs_info->treelog_bg == block_group->start) {
+		if (!btrfs_zone_activate(block_group)) {
+			int ret_fin = btrfs_zone_finish_one_bg(fs_info);
 
-	if (cache->meta_write_pointer != eb->start) {
-		btrfs_put_block_group(cache);
-		cache = NULL;
-		ret = false;
-	} else {
-		cache->meta_write_pointer = eb->start + eb->len;
-	}
+			if (ret_fin != 1 || !btrfs_zone_activate(block_group))
+				return false;
+		}
+	} else if (*active_bg != block_group) {
+		struct btrfs_block_group *tgt = *active_bg;
 
-	*cache_ret = cache;
+		/* zoned_meta_io_lock protects fs_info->active_{meta,system}_bg. */
+		lockdep_assert_held(&fs_info->zoned_meta_io_lock);
 
-	return ret;
+		if (tgt) {
+			/*
+			 * If there is an unsent IO left in the allocated area,
+			 * we cannot wait for them as it may cause a deadlock.
+			 */
+			if (tgt->meta_write_pointer < tgt->start + tgt->alloc_offset) {
+				if (wbc->sync_mode == WB_SYNC_NONE ||
+				    (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync))
+					return false;
+			}
+
+			/* Pivot active metadata/system block group. */
+			btrfs_zoned_meta_io_unlock(fs_info);
+			wait_eb_writebacks(tgt);
+			do_zone_finish(tgt, true);
+			btrfs_zoned_meta_io_lock(fs_info);
+			if (*active_bg == tgt) {
+				btrfs_put_block_group(tgt);
+				*active_bg = NULL;
+			}
+		}
+		if (!btrfs_zone_activate(block_group))
+			return false;
+		if (*active_bg != block_group) {
+			ASSERT(*active_bg == NULL);
+			*active_bg = block_group;
+			btrfs_get_block_group(block_group);
+		}
+	}
+
+	return true;
 }
 
-void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
-				     struct extent_buffer *eb)
+/*
+ * Check if @ctx->eb is aligned to the write pointer.
+ *
+ * Return:
+ *   0:        @ctx->eb is at the write pointer. You can write it.
+ *   -EAGAIN:  There is a hole. The caller should handle the case.
+ *   -EBUSY:   There is a hole, but the caller can just bail out.
+ */
+int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				   struct btrfs_eb_write_context *ctx)
 {
-	if (!btrfs_is_zoned(eb->fs_info) || !cache)
-		return;
+	const struct writeback_control *wbc = ctx->wbc;
+	const struct extent_buffer *eb = ctx->eb;
+	struct btrfs_block_group *block_group = ctx->zoned_bg;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	if (block_group) {
+		if (block_group->start > eb->start ||
+		    block_group->start + block_group->length <= eb->start) {
+			btrfs_put_block_group(block_group);
+			block_group = NULL;
+			ctx->zoned_bg = NULL;
+		}
+	}
+
+	if (!block_group) {
+		block_group = btrfs_lookup_block_group(fs_info, eb->start);
+		if (!block_group)
+			return 0;
+		ctx->zoned_bg = block_group;
+	}
 
-	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
-	cache->meta_write_pointer = eb->start;
+	if (block_group->meta_write_pointer == eb->start) {
+		struct btrfs_block_group **tgt;
+
+		if (!test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags))
+			return 0;
+
+		if (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)
+			tgt = &fs_info->active_system_bg;
+		else
+			tgt = &fs_info->active_meta_bg;
+		if (check_bg_is_active(ctx, tgt))
+			return 0;
+	}
+
+	/*
+	 * Since we may release fs_info->zoned_meta_io_lock, someone can already
+	 * start writing this eb. In that case, we can just bail out.
+	 */
+	if (block_group->meta_write_pointer > eb->start)
+		return -EBUSY;
+
+	/* If for_sync, this hole will be filled with trasnsaction commit. */
+	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
+		return -EAGAIN;
+	return -EBUSY;
 }
 
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length)
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 27322b926038..74ec37a25808 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -58,11 +58,8 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
-bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb,
-				    struct btrfs_block_group **cache_ret);
-void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
-				     struct extent_buffer *eb);
+int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				   struct btrfs_eb_write_context *ctx);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
 int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 				  u64 physical_start, u64 physical_pos);
@@ -189,17 +186,10 @@ static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
 }
 
-static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-			       struct extent_buffer *eb,
-			       struct btrfs_block_group **cache_ret)
-{
-	return true;
-}
-
-static inline void btrfs_revert_meta_write_pointer(
-						struct btrfs_block_group *cache,
-						struct extent_buffer *eb)
+static inline int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+						 struct btrfs_eb_write_context *ctx)
 {
+	return 0;
 }
 
 static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..996271473609 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -32,10 +32,16 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 storage_space, remaining_space, max_variable_size;
 	efi_status_t status;
 
-	status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
-					    &max_variable_size);
-	if (status != EFI_SUCCESS)
-		return efi_status_to_err(status);
+	/* Some UEFI firmware does not implement QueryVariableInfo() */
+	storage_space = remaining_space = 0;
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
+		status = efivar_query_variable_info(attr, &storage_space,
+						    &remaining_space,
+						    &max_variable_size);
+		if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
+			pr_warn_ratelimited("query_variable_info() failed: 0x%lx\n",
+					    status);
+	}
 
 	/*
 	 * This is not a normal filesystem, so no point in pretending it has a block
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 8906ba479aaf..89517937d36c 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -742,10 +742,10 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
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
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a197ef71b7b0..bd7557d8dec4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4223,12 +4223,13 @@ ext4_mb_pa_rb_next_iter(ext4_lblk_t new_start, ext4_lblk_t cur_start, struct rb_
 
 static inline void
 ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
-			  ext4_lblk_t start, ext4_lblk_t end)
+			  ext4_lblk_t start, loff_t end)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_prealloc_space *tmp_pa;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+	ext4_lblk_t tmp_pa_start;
+	loff_t tmp_pa_end;
 	struct rb_node *iter;
 
 	read_lock(&ei->i_prealloc_lock);
@@ -4237,7 +4238,7 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
 				  pa_node.inode_node);
 		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+		tmp_pa_end = pa_logical_end(sbi, tmp_pa);
 
 		spin_lock(&tmp_pa->pa_lock);
 		if (tmp_pa->pa_deleted == 0)
@@ -4259,14 +4260,14 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
  */
 static inline void
 ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
-			  ext4_lblk_t *start, ext4_lblk_t *end)
+			  ext4_lblk_t *start, loff_t *end)
 {
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_prealloc_space *tmp_pa = NULL, *left_pa = NULL, *right_pa = NULL;
 	struct rb_node *iter;
-	ext4_lblk_t new_start, new_end;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end, left_pa_end = -1, right_pa_start = -1;
+	ext4_lblk_t new_start, tmp_pa_start, right_pa_start = -1;
+	loff_t new_end, tmp_pa_end, left_pa_end = -1;
 
 	new_start = *start;
 	new_end = *end;
@@ -4285,7 +4286,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
 				  pa_node.inode_node);
 		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+		tmp_pa_end = pa_logical_end(sbi, tmp_pa);
 
 		/* PA must not overlap original request */
 		spin_lock(&tmp_pa->pa_lock);
@@ -4365,8 +4366,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	}
 
 	if (left_pa) {
-		left_pa_end =
-			left_pa->pa_lstart + EXT4_C2B(sbi, left_pa->pa_len);
+		left_pa_end = pa_logical_end(sbi, left_pa);
 		BUG_ON(left_pa_end > ac->ac_o_ex.fe_logical);
 	}
 
@@ -4405,8 +4405,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
-	ext4_lblk_t end;
-	loff_t size, start_off;
+	loff_t size, start_off, end;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
 
@@ -4433,7 +4432,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
 	/* first, let's learn actual file size
 	 * given current request is allocated */
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	size = size << bsbits;
 	if (size < i_size_read(ac->ac_inode))
 		size = i_size_read(ac->ac_inode);
@@ -4767,7 +4766,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_locality_group *lg;
 	struct ext4_prealloc_space *tmp_pa = NULL, *cpa = NULL;
-	loff_t tmp_pa_end;
 	struct rb_node *iter;
 	ext4_fsblk_t goal_block;
 
@@ -4863,9 +4861,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	 * pa can possibly satisfy the request hence check if it overlaps
 	 * original logical start and stop searching if it doesn't.
 	 */
-	tmp_pa_end = (loff_t)tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
-
-	if (ac->ac_o_ex.fe_logical >= tmp_pa_end) {
+	if (ac->ac_o_ex.fe_logical >= pa_logical_end(sbi, tmp_pa)) {
 		spin_unlock(&tmp_pa->pa_lock);
 		goto try_group_pa;
 	}
@@ -5181,8 +5177,11 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa = ac->ac_pa;
 
 	if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
-		int new_bex_start;
-		int new_bex_end;
+		struct ext4_free_extent ex = {
+			.fe_logical = ac->ac_g_ex.fe_logical,
+			.fe_len = ac->ac_orig_goal_len,
+		};
+		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
 
 		/* we can't allocate as much as normalizer wants.
 		 * so, found space must get proper lstart
@@ -5201,29 +5200,23 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 *    still cover original start
 		 * 3. Else, keep the best ex at start of original request.
 		 */
-		new_bex_end = ac->ac_g_ex.fe_logical +
-			EXT4_C2B(sbi, ac->ac_orig_goal_len);
-		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
-		if (ac->ac_o_ex.fe_logical >= new_bex_start)
-			goto adjust_bex;
+		ex.fe_len = ac->ac_b_ex.fe_len;
 
-		new_bex_start = ac->ac_g_ex.fe_logical;
-		new_bex_end =
-			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
-		if (ac->ac_o_ex.fe_logical < new_bex_end)
+		ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
+		if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
 			goto adjust_bex;
 
-		new_bex_start = ac->ac_o_ex.fe_logical;
-		new_bex_end =
-			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+		ex.fe_logical = ac->ac_g_ex.fe_logical;
+		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
+			goto adjust_bex;
 
+		ex.fe_logical = ac->ac_o_ex.fe_logical;
 adjust_bex:
-		ac->ac_b_ex.fe_logical = new_bex_start;
+		ac->ac_b_ex.fe_logical = ex.fe_logical;
 
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
 		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
-		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
-				      EXT4_C2B(sbi, ac->ac_orig_goal_len)));
+		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
 	}
 
 	pa->pa_lstart = ac->ac_b_ex.fe_logical;
@@ -5770,7 +5763,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 
 	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
 	inode_pa_eligible = true;
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
 		>> bsbits;
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index df6b5e7c2274..d7aeb5da7d86 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -233,6 +233,20 @@ static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
 		(fex->fe_start << EXT4_SB(sb)->s_cluster_bits);
 }
 
+static inline loff_t extent_logical_end(struct ext4_sb_info *sbi,
+					struct ext4_free_extent *fex)
+{
+	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
+	return (loff_t)fex->fe_logical + EXT4_C2B(sbi, fex->fe_len);
+}
+
+static inline loff_t pa_logical_end(struct ext4_sb_info *sbi,
+				    struct ext4_prealloc_space *pa)
+{
+	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
+	return (loff_t)pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
+}
+
 typedef int (*ext4_mballoc_query_range_fn)(
 	struct super_block		*sb,
 	ext4_group_t			agno,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6bcc3770ee19..46a2ddd9259e 100644
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
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7d2f70708f37..794fda5bd9bc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -927,7 +927,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 			 * the end of this data range, not the end of the folio.
 			 */
 			*punch_start_byte = min_t(loff_t, end_byte,
-					folio_next_index(folio) << PAGE_SHIFT);
+					folio_pos(folio) + folio_size(folio));
 		}
 
 		/* move offset to start of next folio in range */
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a14a0f18a4c4..88afd108c2dd 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -269,6 +269,7 @@ int dbUnmount(struct inode *ipbmap, int mounterror)
 
 	/* free the memory for the in-memory bmap. */
 	kfree(bmp);
+	JFS_SBI(ipbmap->i_sb)->bmap = NULL;
 
 	return (0);
 }
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 390cbfce391f..6fb28572cb2c 100644
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
index df8b26a42524..a552bdb6badc 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1301,6 +1301,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
  out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
+	trace_posix_lock_inode(inode, request, error);
 	/*
 	 * Free any unused locks.
 	 */
@@ -1309,7 +1310,6 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	if (new_fl2)
 		locks_free_lock(new_fl2);
 	locks_dispose_list(&dispose);
-	trace_posix_lock_inode(inode, request, error);
 
 	return error;
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5ae670807449..7fe97c95938b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1024,8 +1024,8 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
index 568f743a5584..986d37a4c275 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -617,7 +617,8 @@ static int ovl_copy_up_metadata(struct ovl_copy_up_ctx *c, struct dentry *temp)
 	if (err)
 		return err;
 
-	if (inode->i_flags & OVL_COPY_I_FLAGS_MASK) {
+	if (inode->i_flags & OVL_COPY_I_FLAGS_MASK &&
+	    (S_ISREG(c->stat.mode) || S_ISDIR(c->stat.mode))) {
 		/*
 		 * Copy the fileattr inode flags that are the source of already
 		 * copied i_flags
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 21245b00722a..1d80583d72ed 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -19,7 +19,6 @@ struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
 	struct kiocb *orig_iocb;
-	struct fd fd;
 };
 
 static struct kmem_cache *ovl_aio_request_cachep;
@@ -277,7 +276,7 @@ static rwf_t ovl_iocb_to_rwf(int ifl)
 static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref)) {
-		fdput(aio_req->fd);
+		fput(aio_req->iocb.ki_filp);
 		kmem_cache_free(ovl_aio_request_cachep, aio_req);
 	}
 }
@@ -342,10 +341,9 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -413,10 +411,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
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
index 57ac8aa4a724..65e8bfa483b1 100644
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
 
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index ed013fdcc1ff..f0182ad3eacf 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -3,6 +3,8 @@
 #ifndef DRM_KUNIT_HELPERS_H_
 #define DRM_KUNIT_HELPERS_H_
 
+#include <linux/device.h>
+
 #include <kunit/test.h>
 
 struct drm_device;
@@ -51,7 +53,7 @@ __drm_kunit_helper_alloc_drm_device(struct kunit *test,
 {
 	struct drm_driver *driver;
 
-	driver = kunit_kzalloc(test, sizeof(*driver), GFP_KERNEL);
+	driver = devm_kzalloc(dev, sizeof(*driver), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, driver);
 
 	driver->driver_features = features;
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index ee7cb6aaff71..1cb65592c95d 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -21,6 +21,7 @@
  */
 #define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
 #define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
+#define IORT_SMMU_V3_PMCG_HISI_HIP09     0x00000002 /* HiSilicon HIP09 PMCG */
 
 int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f316affcd2e1..28e2e0ce2ed0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -640,7 +640,8 @@ enum bpf_type_flag {
 	MEM_RCU			= BIT(13 + BPF_BASE_TYPE_BITS),
 
 	/* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which are non-owning.
-	 * Currently only valid for linked-list and rbtree nodes.
+	 * Currently only valid for linked-list and rbtree nodes. If the nodes
+	 * have a bpf_refcount_field, they must be tagged MEM_RCU as well.
 	 */
 	NON_OWN_REF		= BIT(14 + BPF_BASE_TYPE_BITS),
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70f9ac884d2..b6e58dab8e27 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -745,7 +745,7 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
 	}
 }
 
-#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
+#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED | NON_OWN_REF)
 
 static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 {
diff --git a/include/linux/instruction_pointer.h b/include/linux/instruction_pointer.h
index cda1f706eaeb..aa0b3ffea935 100644
--- a/include/linux/instruction_pointer.h
+++ b/include/linux/instruction_pointer.h
@@ -2,7 +2,12 @@
 #ifndef _LINUX_INSTRUCTION_POINTER_H
 #define _LINUX_INSTRUCTION_POINTER_H
 
+#include <asm/linkage.h>
+
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
+
+#ifndef _THIS_IP_
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+#endif
 
 #endif /* _LINUX_INSTRUCTION_POINTER_H */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 820f7a3a2749..f5bb4415c5e2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -222,6 +222,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2dc75df1437f..8f9a459e1671 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -576,6 +576,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
+#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
+#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2166a69e3bf2..e657916c9509 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1316,15 +1316,31 @@ extern int perf_event_output(struct perf_event *event,
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
index dd35ce28bb90..6b687c155fb6 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -118,10 +118,36 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
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
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f99d798093ab..faa579209a72 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -62,13 +62,13 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 /* Used to find the offset and length of dynamic fields in trace events */
 struct trace_dynamic_info {
 #ifdef CONFIG_CPU_BIG_ENDIAN
-	u16	offset;
 	u16	len;
+	u16	offset;
 #else
-	u16	len;
 	u16	offset;
+	u16	len;
 #endif
-};
+} __packed;
 
 /*
  * The trace entry - the most basic unit of tracing. This is what
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index ee38835ed77c..0b4f2d5faa08 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -63,6 +63,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_IMX_IS_HSIC		BIT(14)
 #define CI_HDRC_PMQOS			BIT(15)
 #define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
+#define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
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
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4e9217c1eb2e..a1562f2cf3f3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4628,8 +4628,20 @@ static int __init io_uring_init(void)
 
 	io_uring_optable_init();
 
-	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
-				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
+	/*
+	 * Allow user copy in the per-command field, which starts after the
+	 * file in io_kiocb and until the opcode field. The openat2 handling
+	 * requires copying in user memory into the io_kiocb object in that
+	 * range, and HARDENED_USERCOPY will complain if we haven't
+	 * correctly annotated this range.
+	 */
+	req_cachep = kmem_cache_create_usercopy("io_kiocb",
+				sizeof(struct io_kiocb), 0,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU,
+				offsetof(struct io_kiocb, cmd.data),
+				sizeof_field(struct io_kiocb, cmd.data), NULL);
+
 	return 0;
 };
 __initcall(io_uring_init);
diff --git a/io_uring/net.c b/io_uring/net.c
index 8c419c01a5db..47ecb070194b 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -183,6 +183,10 @@ static int io_setup_async_msg(struct io_kiocb *req,
 	memcpy(async_msg, kmsg, sizeof(*kmsg));
 	if (async_msg->msg.msg_name)
 		async_msg->msg.msg_name = &async_msg->addr;
+
+	if ((req->flags & REQ_F_BUFFER_SELECT) && !async_msg->msg.msg_iter.nr_segs)
+		return -EAGAIN;
+
 	/* if were using fast_iov, set it to the new one */
 	if (iter_is_iovec(&kmsg->msg.msg_iter) && !kmsg->free_iov) {
 		size_t fast_idx = iter_iov(&kmsg->msg.msg_iter) - kmsg->fast_iov;
@@ -542,6 +546,7 @@ static int io_recvmsg_copy_hdr(struct io_kiocb *req,
 			       struct io_async_msghdr *iomsg)
 {
 	iomsg->msg.msg_name = &iomsg->addr;
+	iomsg->msg.msg_iter.nr_segs = 0;
 
 #ifdef CONFIG_COMPAT
 	if (req->ctx->compat)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 76845dd22cd2..9cdba4ce23d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7841,6 +7841,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
 		 * can be non-zero. This was already checked above. So pass
@@ -10302,6 +10303,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_verifier_state *state = env->cur_state;
+	struct btf_record *rec = reg_btf_record(reg);
 
 	if (!state->active_lock.ptr) {
 		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
@@ -10314,6 +10316,9 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 	}
 
 	reg->type |= NON_OWN_REF;
+	if (rec->refcount_off >= 0)
+		reg->type |= MEM_RCU;
+
 	return 0;
 }
 
@@ -11154,6 +11159,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
 
+		if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
+			verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
+			return -EACCES;
+		}
+
 		if (rcu_lock) {
 			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
 			return -EINVAL;
@@ -16453,7 +16463,8 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_rcu_lock) {
+				if (env->cur_state->active_rcu_lock &&
+				    !in_rbtree_lock_required_cb(env)) {
 					verbose(env, "bpf_rcu_read_unlock is missing\n");
 					return -EINVAL;
 				}
diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..f81149739eb9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -985,6 +985,14 @@ void __put_task_struct(struct task_struct *tsk)
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
diff --git a/kernel/panic.c b/kernel/panic.c
index 10effe40a3fa..ea1c5fcb2d19 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -697,6 +697,7 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 	if (!fmt) {
 		__warn(file, line, __builtin_return_address(0), taint,
 		       NULL, NULL);
+		warn_rcu_exit(rcu);
 		return;
 	}
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2b4a946a6ff5..8d35b9f9aaa3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -786,9 +786,9 @@ int hibernate(void)
 	unlock_device_hotplug();
 	if (snapshot_test) {
 		pm_pr_dbg("Checking hibernation image\n");
-		error = swsusp_check(snapshot_test);
+		error = swsusp_check(false);
 		if (!error)
-			error = load_image_and_restore(snapshot_test);
+			error = load_image_and_restore(false);
 	}
 	thaw_processes();
 
@@ -945,14 +945,14 @@ static int software_resume(void)
 	pm_pr_dbg("Looking for hibernation image.\n");
 
 	mutex_lock(&system_transition_mutex);
-	error = swsusp_check(false);
+	error = swsusp_check(true);
 	if (error)
 		goto Unlock;
 
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
-		swsusp_close(false);
+		swsusp_close(true);
 		goto Unlock;
 	}
 
@@ -973,7 +973,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	error = load_image_and_restore(false);
+	error = load_image_and_restore(true);
 	thaw_processes();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
@@ -987,7 +987,7 @@ static int software_resume(void)
 	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
-	swsusp_close(false);
+	swsusp_close(true);
 	goto Finish;
 }
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2a17704136f1..7d4979d5c3ce 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -103,3 +103,5 @@ struct printk_message {
 	u64			seq;
 	unsigned long		dropped;
 };
+
+bool other_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 357a4d18f638..08a9419046b6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2308,7 +2308,11 @@ asmlinkage int vprintk_emit(int facility, int level,
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
@@ -2585,6 +2589,26 @@ static int console_cpu_notify(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
+ */
+bool other_cpu_in_panic(void)
+{
+	if (!panic_in_progress())
+		return false;
+
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return atomic_read(&panic_cpu) != raw_smp_processor_id();
+}
+
 /**
  * console_lock - block the console subsystem from printing
  *
@@ -2597,6 +2621,10 @@ void console_lock(void)
 {
 	might_sleep();
 
+	/* On panic, the console_lock must be left to the panic cpu. */
+	while (other_cpu_in_panic())
+		msleep(1000);
+
 	down_console_sem();
 	if (console_suspended)
 		return;
@@ -2615,6 +2643,9 @@ EXPORT_SYMBOL(console_lock);
  */
 int console_trylock(void)
 {
+	/* On panic, the console_lock must be left to the panic cpu. */
+	if (other_cpu_in_panic())
+		return 0;
 	if (down_trylock_console_sem())
 		return 0;
 	if (console_suspended) {
@@ -2633,25 +2664,6 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
-/*
- * Return true when this CPU should unlock console_sem without pushing all
- * messages to the console. This reduces the chance that the console is
- * locked when the panic CPU tries to use it.
- */
-static bool abandon_console_lock_in_panic(void)
-{
-	if (!panic_in_progress())
-		return false;
-
-	/*
-	 * We can use raw_smp_processor_id() here because it is impossible for
-	 * the task to be migrated to the panic_cpu, or away from it. If
-	 * panic_cpu has already been set, and we're not currently executing on
-	 * that CPU, then we never will be.
-	 */
-	return atomic_read(&panic_cpu) != raw_smp_processor_id();
-}
-
 /*
  * Check if the given console is currently capable and allowed to print
  * records.
@@ -2948,7 +2960,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			any_progress = true;
 
 			/* Allow panic_cpu to take over the consoles safely. */
-			if (abandon_console_lock_in_panic())
+			if (other_cpu_in_panic())
 				goto abandon;
 
 			if (do_cond_resched)
@@ -3045,9 +3057,27 @@ EXPORT_SYMBOL(console_conditional_schedule);
 
 void console_unblank(void)
 {
+	bool found_unblank = false;
 	struct console *c;
 	int cookie;
 
+	/*
+	 * First check if there are any consoles implementing the unblank()
+	 * callback. If not, there is no reason to continue and take the
+	 * console lock, which in particular can be dangerous if
+	 * @oops_in_progress is set.
+	 */
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
+		if ((console_srcu_read_flags(c) & CON_ENABLED) && c->unblank) {
+			found_unblank = true;
+			break;
+		}
+	}
+	console_srcu_read_unlock(cookie);
+	if (!found_unblank)
+		return;
+
 	/*
 	 * Stop console printing because the unblank() callback may
 	 * assume the console is not within its write() callback.
@@ -3056,6 +3086,16 @@ void console_unblank(void)
 	 * In that case, attempt a trylock as best-effort.
 	 */
 	if (oops_in_progress) {
+		/* Semaphores are not NMI-safe. */
+		if (in_nmi())
+			return;
+
+		/*
+		 * Attempting to trylock the console lock can deadlock
+		 * if another CPU was stopped while modifying the
+		 * semaphore. "Hope and pray" that this is not the
+		 * current situation.
+		 */
 		if (down_trylock_console_sem() != 0)
 			return;
 	} else
@@ -3085,14 +3125,24 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	bool handover;
+	u64 next_seq;
+
+	/*
+	 * Ignore the console lock and flush out the messages. Attempting a
+	 * trylock would not be useful because:
+	 *
+	 *   - if it is contended, it must be ignored anyway
+	 *   - console_lock() and console_trylock() block and fail
+	 *     respectively in panic for non-panic CPUs
+	 *   - semaphores are not NMI-safe
+	 */
+
 	/*
-	 * If someone else is holding the console lock, trylock will fail
-	 * and may_schedule may be set.  Ignore and proceed to unlock so
-	 * that messages are flushed out.  As this can be called from any
-	 * context and we don't want to get preempted while flushing,
-	 * ensure may_schedule is cleared.
+	 * If another context is holding the console lock,
+	 * @console_may_schedule might be set. Clear it so that
+	 * this context does not call cond_resched() while flushing.
 	 */
-	console_trylock();
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL) {
@@ -3105,15 +3155,15 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
 			/*
-			 * If the above console_trylock() failed, this is an
-			 * unsynchronized assignment. But in that case, the
+			 * This is an unsynchronized assignment, but the
 			 * kernel is in "hope and pray" mode anyway.
 			 */
 			c->seq = seq;
 		}
 		console_srcu_read_unlock(cookie);
 	}
-	console_unlock();
+
+	console_flush_all(false, &next_seq, &handover);
 }
 
 /*
@@ -3798,11 +3848,33 @@ static void __wake_up_klogd(int val)
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
@@ -3819,12 +3891,7 @@ void printk_trigger_flush(void)
 
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
index d1221731c7cf..35aab6cbba58 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -424,7 +424,7 @@ rcu_scale_writer(void *arg)
 	sched_set_fifo_low(current);
 
 	if (holdoff)
-		schedule_timeout_uninterruptible(holdoff * HZ);
+		schedule_timeout_idle(holdoff * HZ);
 
 	/*
 	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 5d113aa59e77..83c33ba0ca7e 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -171,7 +171,8 @@ static void scf_torture_stats_print(void)
 		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
 	}
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
-	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
+	    atomic_read(&n_mb_out_errs) ||
+	    (!IS_ENABLED(CONFIG_KASAN) && atomic_read(&n_alloc_errs)))
 		bangstr = "!!! ";
 	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld single_rpc: %lld single_rpc_ofl: %lld many: %lld/%lld all: %lld/%lld ",
 		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count, scfs.n_resched,
@@ -323,7 +324,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
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
index 745332d10b3e..81c4dade3763 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1772,7 +1772,7 @@ static void trace_create_maxlat_file(struct trace_array *tr,
 	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
 	tr->d_max_latency = trace_create_file("tracing_max_latency",
 					      TRACE_MODE_WRITE,
-					      d_tracer, &tr->max_latency,
+					      d_tracer, tr,
 					      &tracing_max_lat_fops);
 }
 
@@ -1805,7 +1805,7 @@ void latency_fsnotify(struct trace_array *tr)
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, &tr->max_latency, &tracing_max_lat_fops)
+			  d_tracer, tr, &tracing_max_lat_fops)
 
 #endif
 
@@ -4987,6 +4987,33 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * The private pointer of the inode is the trace_event_file.
+ * Update the tr ref count associated to it.
+ */
+int tracing_open_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(file->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+
+	return 0;
+}
+
+int tracing_release_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+
+	trace_array_put(file->tr);
+
+	return 0;
+}
+
 static int tracing_mark_open(struct inode *inode, struct file *filp)
 {
 	stream_open(inode, filp);
@@ -6706,14 +6733,18 @@ static ssize_t
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
@@ -7770,18 +7801,20 @@ static const struct file_operations tracing_thresh_fops = {
 
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
@@ -8974,12 +9007,33 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 73eaec158473..c98c3f42c386 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -601,6 +601,8 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_open_file_tr(struct inode *inode, struct file *filp);
+int tracing_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 578f1f7d49a6..0cf84a7449f5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2103,9 +2103,10 @@ static const struct file_operations ftrace_set_event_notrace_pid_fops = {
 };
 
 static const struct file_operations ftrace_enable_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_enable_read,
 	.write = event_enable_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
@@ -2122,9 +2123,10 @@ static const struct file_operations ftrace_event_id_fops = {
 };
 
 static const struct file_operations ftrace_event_filter_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_filter_read,
 	.write = event_filter_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index abe805d471eb..8650562bdaa9 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -328,7 +328,8 @@ event_inject_read(struct file *file, char __user *buf, size_t size,
 }
 
 const struct file_operations event_inject_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_inject_read,
 	.write = event_inject_write,
+	.release = tracing_release_file_tr,
 };
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 9897d0bfcab7..14cb275a0bab 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -337,7 +337,7 @@ static void print_synth_event_num_val(struct trace_seq *s,
 		break;
 
 	default:
-		trace_seq_printf(s, print_fmt, name, val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u64, space);
 		break;
 	}
 }
diff --git a/lib/kobject.c b/lib/kobject.c
index 16d530f9c174..4c7a990d6f12 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -854,6 +854,11 @@ int kset_register(struct kset *k)
 	if (!k)
 		return -EINVAL;
 
+	if (!k->kobj.ktype) {
+		pr_err("must have a ktype to be initialized properly!\n");
+		return -EINVAL;
+	}
+
 	kset_init(k);
 	err = kobject_add_internal(&k->kobj);
 	if (err) {
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e79267c1eee0..4fe5a562d0bb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3871,6 +3871,10 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		case _MEMSWAP:
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
+		case _KMEM:
+			/* kmem.limit_in_bytes is deprecated. */
+			ret = -EOPNOTSUPP;
+			break;
 		case _TCP:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
@@ -5081,6 +5085,12 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.seq_show = memcg_numa_stat_show,
 	},
 #endif
+	{
+		.name = "kmem.limit_in_bytes",
+		.private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
+		.write = mem_cgroup_write,
+		.read_u64 = mem_cgroup_read_u64,
+	},
 	{
 		.name = "kmem.usage_in_bytes",
 		.private = MEMFILE_PRIVATE(_KMEM, RES_USAGE),
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2c845c9a26be..29ae9b254a34 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2436,6 +2436,9 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
 		return NOTIFY_DONE;
 
+	/* To avoid a potential race with hci_unregister_dev. */
+	hci_dev_hold(hdev);
+
 	if (action == PM_SUSPEND_PREPARE)
 		ret = hci_suspend_dev(hdev);
 	else if (action == PM_POST_SUSPEND)
@@ -2445,6 +2448,7 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 		bt_dev_err(hdev, "Suspend notifier action (%lu) failed: %d",
 			   action, ret);
 
+	hci_dev_put(hdev);
 	return NOTIFY_DONE;
 }
 
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 757ec46fc45a..aa23479b20b2 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
 		return ret;
 
 	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
-	memcpy(&offsets[1], &entry->watchers_offset,
-			sizeof(offsets) - sizeof(offsets[0]));
+	memcpy(&offsets[1], &entry->offsets, sizeof(entry->offsets));
 
 	if (state->buf_kern_start) {
 		buf_start = state->buf_kern_start + state->buf_kern_offset;
diff --git a/net/core/sock.c b/net/core/sock.c
index 29c6cb030818..eef27812013a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1824,14 +1824,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_PEERNAME:
 	{
-		char address[128];
+		struct sockaddr_storage address;
 
-		lv = sock->ops->getname(sock, (struct sockaddr *)address, 2);
+		lv = sock->ops->getname(sock, (struct sockaddr *)&address, 2);
 		if (lv < 0)
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_sockptr(optval, address, len))
+		if (copy_to_sockptr(optval, &address, len))
 			return -EFAULT;
 		goto lenout;
 	}
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index bfed7929a904..5277eb3c7d0a 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -3946,7 +3946,7 @@ static int devlink_param_get(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->get || devlink->reload_failed)
+	if (!param->get)
 		return -EOPNOTSUPP;
 	return param->get(devlink, param->id, ctx);
 }
@@ -3955,7 +3955,7 @@ static int devlink_param_set(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->set || devlink->reload_failed)
+	if (!param->set)
 		return -EOPNOTSUPP;
 	return param->set(devlink, param->id, ctx);
 }
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6935d07a60c3..a8d2e8b1ff41 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -236,7 +236,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
 			    __func__);
 	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
-	return -EINVAL;
+	return PTR_ERR(neigh);
 }
 
 static int ip_finish_output_gso(struct net *net, struct sock *sk,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d354b32a20f8..45e7a5d9c7d9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4133,19 +4133,20 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	mutex_lock(&local->mtx);
 
 	rcu_read_lock();
+	sta = sta_info_get_bss(sdata, peer);
+	if (!sta) {
+		ret = -ENOLINK;
+		goto unlock;
+	}
+
+	qos = sta->sta.wme;
+
 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		ret = -EINVAL;
 		goto unlock;
 	}
 	band = chanctx_conf->def.chan->band;
-	sta = sta_info_get_bss(sdata, peer);
-	if (sta) {
-		qos = sta->sta.wme;
-	} else {
-		ret = -ENOLINK;
-		goto unlock;
-	}
 
 	if (qos) {
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0af2599c17e8..e751cda5eef6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3734,6 +3734,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
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
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 383631873748..20082171f24a 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -84,7 +84,7 @@ struct listeners {
 
 static inline int netlink_is_kernel(struct sock *sk)
 {
-	return nlk_sk(sk)->flags & NETLINK_F_KERNEL_SOCKET;
+	return nlk_test_bit(KERNEL_SOCKET, sk);
 }
 
 struct netlink_table *nl_table __read_mostly;
@@ -349,9 +349,7 @@ static void netlink_deliver_tap_kernel(struct sock *dst, struct sock *src,
 
 static void netlink_overrun(struct sock *sk)
 {
-	struct netlink_sock *nlk = nlk_sk(sk);
-
-	if (!(nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)) {
+	if (!nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		if (!test_and_set_bit(NETLINK_S_CONGESTED,
 				      &nlk_sk(sk)->state)) {
 			sk->sk_err = ENOBUFS;
@@ -1402,9 +1400,7 @@ EXPORT_SYMBOL_GPL(netlink_has_listeners);
 
 bool netlink_strict_get_check(struct sk_buff *skb)
 {
-	const struct netlink_sock *nlk = nlk_sk(NETLINK_CB(skb).sk);
-
-	return nlk->flags & NETLINK_F_STRICT_CHK;
+	return nlk_test_bit(STRICT_CHK, NETLINK_CB(skb).sk);
 }
 EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 
@@ -1448,7 +1444,7 @@ static void do_one_broadcast(struct sock *sk,
 		return;
 
 	if (!net_eq(sock_net(sk), p->net)) {
-		if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
+		if (!nlk_test_bit(LISTEN_ALL_NSID, sk))
 			return;
 
 		if (!peernet_has_id(sock_net(sk), p->net))
@@ -1481,7 +1477,7 @@ static void do_one_broadcast(struct sock *sk,
 		netlink_overrun(sk);
 		/* Clone failed. Notify ALL listeners. */
 		p->failure = 1;
-		if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+		if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 			p->delivery_failure = 1;
 		goto out;
 	}
@@ -1496,7 +1492,7 @@ static void do_one_broadcast(struct sock *sk,
 	val = netlink_broadcast_deliver(sk, p->skb2);
 	if (val < 0) {
 		netlink_overrun(sk);
-		if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+		if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 			p->delivery_failure = 1;
 	} else {
 		p->congested |= val;
@@ -1576,7 +1572,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 	    !test_bit(p->group - 1, nlk->groups))
 		goto out;
 
-	if (p->code == ENOBUFS && nlk->flags & NETLINK_F_RECV_NO_ENOBUFS) {
+	if (p->code == ENOBUFS && nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		ret = 1;
 		goto out;
 	}
@@ -1643,7 +1639,7 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	unsigned int val = 0;
-	int err;
+	int nr = -1;
 
 	if (level != SOL_NETLINK)
 		return -ENOPROTOOPT;
@@ -1654,14 +1650,12 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case NETLINK_PKTINFO:
-		if (val)
-			nlk->flags |= NETLINK_F_RECV_PKTINFO;
-		else
-			nlk->flags &= ~NETLINK_F_RECV_PKTINFO;
-		err = 0;
+		nr = NETLINK_F_RECV_PKTINFO;
 		break;
 	case NETLINK_ADD_MEMBERSHIP:
 	case NETLINK_DROP_MEMBERSHIP: {
+		int err;
+
 		if (!netlink_allowed(sock, NL_CFG_F_NONROOT_RECV))
 			return -EPERM;
 		err = netlink_realloc_groups(sk);
@@ -1681,61 +1675,38 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		if (optname == NETLINK_DROP_MEMBERSHIP && nlk->netlink_unbind)
 			nlk->netlink_unbind(sock_net(sk), val);
 
-		err = 0;
 		break;
 	}
 	case NETLINK_BROADCAST_ERROR:
-		if (val)
-			nlk->flags |= NETLINK_F_BROADCAST_SEND_ERROR;
-		else
-			nlk->flags &= ~NETLINK_F_BROADCAST_SEND_ERROR;
-		err = 0;
+		nr = NETLINK_F_BROADCAST_SEND_ERROR;
 		break;
 	case NETLINK_NO_ENOBUFS:
+		assign_bit(NETLINK_F_RECV_NO_ENOBUFS, &nlk->flags, val);
 		if (val) {
-			nlk->flags |= NETLINK_F_RECV_NO_ENOBUFS;
 			clear_bit(NETLINK_S_CONGESTED, &nlk->state);
 			wake_up_interruptible(&nlk->wait);
-		} else {
-			nlk->flags &= ~NETLINK_F_RECV_NO_ENOBUFS;
 		}
-		err = 0;
 		break;
 	case NETLINK_LISTEN_ALL_NSID:
 		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_BROADCAST))
 			return -EPERM;
-
-		if (val)
-			nlk->flags |= NETLINK_F_LISTEN_ALL_NSID;
-		else
-			nlk->flags &= ~NETLINK_F_LISTEN_ALL_NSID;
-		err = 0;
+		nr = NETLINK_F_LISTEN_ALL_NSID;
 		break;
 	case NETLINK_CAP_ACK:
-		if (val)
-			nlk->flags |= NETLINK_F_CAP_ACK;
-		else
-			nlk->flags &= ~NETLINK_F_CAP_ACK;
-		err = 0;
+		nr = NETLINK_F_CAP_ACK;
 		break;
 	case NETLINK_EXT_ACK:
-		if (val)
-			nlk->flags |= NETLINK_F_EXT_ACK;
-		else
-			nlk->flags &= ~NETLINK_F_EXT_ACK;
-		err = 0;
+		nr = NETLINK_F_EXT_ACK;
 		break;
 	case NETLINK_GET_STRICT_CHK:
-		if (val)
-			nlk->flags |= NETLINK_F_STRICT_CHK;
-		else
-			nlk->flags &= ~NETLINK_F_STRICT_CHK;
-		err = 0;
+		nr = NETLINK_F_STRICT_CHK;
 		break;
 	default:
-		err = -ENOPROTOOPT;
+		return -ENOPROTOOPT;
 	}
-	return err;
+	if (nr >= 0)
+		assign_bit(nr, &nlk->flags, val);
+	return 0;
 }
 
 static int netlink_getsockopt(struct socket *sock, int level, int optname,
@@ -1802,7 +1773,7 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		return -EINVAL;
 
 	len = sizeof(int);
-	val = nlk->flags & flag ? 1 : 0;
+	val = test_bit(flag, &nlk->flags);
 
 	if (put_user(len, optlen) ||
 	    copy_to_user(optval, &val, len))
@@ -1979,9 +1950,9 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		msg->msg_namelen = sizeof(*addr);
 	}
 
-	if (nlk->flags & NETLINK_F_RECV_PKTINFO)
+	if (nlk_test_bit(RECV_PKTINFO, sk))
 		netlink_cmsg_recv_pktinfo(msg, skb);
-	if (nlk->flags & NETLINK_F_LISTEN_ALL_NSID)
+	if (nlk_test_bit(LISTEN_ALL_NSID, sk))
 		netlink_cmsg_listen_all_nsid(sk, msg, skb);
 
 	memset(&scm, 0, sizeof(scm));
@@ -2058,7 +2029,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 		goto out_sock_release;
 
 	nlk = nlk_sk(sk);
-	nlk->flags |= NETLINK_F_KERNEL_SOCKET;
+	set_bit(NETLINK_F_KERNEL_SOCKET, &nlk->flags);
 
 	netlink_table_grab();
 	if (!nl_table[unit].registered) {
@@ -2192,7 +2163,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	nl_dump_check_consistent(cb, nlh);
 	memcpy(nlmsg_data(nlh), &nlk->dump_done_errno, sizeof(nlk->dump_done_errno));
 
-	if (extack->_msg && nlk->flags & NETLINK_F_EXT_ACK) {
+	if (extack->_msg && test_bit(NETLINK_F_EXT_ACK, &nlk->flags)) {
 		nlh->nlmsg_flags |= NLM_F_ACK_TLVS;
 		if (!nla_put_string(skb, NLMSGERR_ATTR_MSG, extack->_msg))
 			nlmsg_end(skb, nlh);
@@ -2321,8 +2292,8 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 			 const struct nlmsghdr *nlh,
 			 struct netlink_dump_control *control)
 {
-	struct netlink_sock *nlk, *nlk2;
 	struct netlink_callback *cb;
+	struct netlink_sock *nlk;
 	struct sock *sk;
 	int ret;
 
@@ -2357,8 +2328,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	cb->min_dump_alloc = control->min_dump_alloc;
 	cb->skb = skb;
 
-	nlk2 = nlk_sk(NETLINK_CB(skb).sk);
-	cb->strict_check = !!(nlk2->flags & NETLINK_F_STRICT_CHK);
+	cb->strict_check = nlk_test_bit(STRICT_CHK, NETLINK_CB(skb).sk);
 
 	if (control->start) {
 		cb->extack = control->extack;
@@ -2402,7 +2372,7 @@ netlink_ack_tlv_len(struct netlink_sock *nlk, int err,
 {
 	size_t tlvlen;
 
-	if (!extack || !(nlk->flags & NETLINK_F_EXT_ACK))
+	if (!extack || !test_bit(NETLINK_F_EXT_ACK, &nlk->flags))
 		return 0;
 
 	tlvlen = 0;
@@ -2474,7 +2444,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 	 * requests to cap the error message, and get extra error data if
 	 * requested.
 	 */
-	if (err && !(nlk->flags & NETLINK_F_CAP_ACK))
+	if (err && !test_bit(NETLINK_F_CAP_ACK, &nlk->flags))
 		payload += nlmsg_len(nlh);
 	else
 		flags |= NLM_F_CAPPED;
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 90a3198a9b7f..3dbd38aef50a 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -8,14 +8,16 @@
 #include <net/sock.h>
 
 /* flags */
-#define NETLINK_F_KERNEL_SOCKET		0x1
-#define NETLINK_F_RECV_PKTINFO		0x2
-#define NETLINK_F_BROADCAST_SEND_ERROR	0x4
-#define NETLINK_F_RECV_NO_ENOBUFS	0x8
-#define NETLINK_F_LISTEN_ALL_NSID	0x10
-#define NETLINK_F_CAP_ACK		0x20
-#define NETLINK_F_EXT_ACK		0x40
-#define NETLINK_F_STRICT_CHK		0x80
+enum {
+	NETLINK_F_KERNEL_SOCKET,
+	NETLINK_F_RECV_PKTINFO,
+	NETLINK_F_BROADCAST_SEND_ERROR,
+	NETLINK_F_RECV_NO_ENOBUFS,
+	NETLINK_F_LISTEN_ALL_NSID,
+	NETLINK_F_CAP_ACK,
+	NETLINK_F_EXT_ACK,
+	NETLINK_F_STRICT_CHK,
+};
 
 #define NLGRPSZ(x)	(ALIGN(x, sizeof(unsigned long) * 8) / 8)
 #define NLGRPLONGS(x)	(NLGRPSZ(x)/sizeof(unsigned long))
@@ -23,10 +25,10 @@
 struct netlink_sock {
 	/* struct sock has to be the first member of netlink_sock */
 	struct sock		sk;
+	unsigned long		flags;
 	u32			portid;
 	u32			dst_portid;
 	u32			dst_group;
-	u32			flags;
 	u32			subscriptions;
 	u32			ngroups;
 	unsigned long		*groups;
@@ -54,6 +56,8 @@ static inline struct netlink_sock *nlk_sk(struct sock *sk)
 	return container_of(sk, struct netlink_sock, sk);
 }
 
+#define nlk_test_bit(nr, sk) test_bit(NETLINK_F_##nr, &nlk_sk(sk)->flags)
+
 struct netlink_table {
 	struct rhashtable	hash;
 	struct hlist_head	mc_list;
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index e4f21b1067bc..9c4f231be275 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -27,15 +27,15 @@ static int sk_diag_put_flags(struct sock *sk, struct sk_buff *skb)
 
 	if (nlk->cb_running)
 		flags |= NDIAG_FLAG_CB_RUNNING;
-	if (nlk->flags & NETLINK_F_RECV_PKTINFO)
+	if (nlk_test_bit(RECV_PKTINFO, sk))
 		flags |= NDIAG_FLAG_PKTINFO;
-	if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+	if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 		flags |= NDIAG_FLAG_BROADCAST_ERROR;
-	if (nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)
+	if (nlk_test_bit(RECV_NO_ENOBUFS, sk))
 		flags |= NDIAG_FLAG_NO_ENOBUFS;
-	if (nlk->flags & NETLINK_F_LISTEN_ALL_NSID)
+	if (nlk_test_bit(LISTEN_ALL_NSID, sk))
 		flags |= NDIAG_FLAG_LISTEN_ALL_NSID;
-	if (nlk->flags & NETLINK_F_CAP_ACK)
+	if (nlk_test_bit(CAP_ACK, sk))
 		flags |= NDIAG_FLAG_CAP_ACK;
 
 	return nla_put_u32(skb, NETLINK_DIAG_FLAGS, flags);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d7c697af3762..315bd59dea05 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2722,7 +2722,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 
 out_verifier:
 	trace_rpc_bad_verifier(task);
-	goto out_err;
+	goto out_garbage;
 
 out_msg_denied:
 	error = -EACCES;
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index ac059cefbeb3..775cac4d6100 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -281,6 +281,11 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 	    ether_addr_equal(req->bss->bssid, wdev->u.client.connected_addr))
 		return -EALREADY;
 
+	if (ether_addr_equal(req->bss->bssid, dev->dev_addr) ||
+	    (req->link_id >= 0 &&
+	     ether_addr_equal(req->ap_mld_addr, dev->dev_addr)))
+		return -EINVAL;
+
 	return rdev_auth(rdev, dev, req);
 }
 
@@ -335,6 +340,9 @@ int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 			if (req->links[i].bss == req->links[j].bss)
 				return -EINVAL;
 		}
+
+		if (ether_addr_equal(req->links[i].bss->bssid, dev->dev_addr))
+			return -EINVAL;
 	}
 
 	if (wdev->connected &&
@@ -342,6 +350,11 @@ int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 	     !ether_addr_equal(wdev->u.client.connected_addr, req->prev_bssid)))
 		return -EALREADY;
 
+	if ((req->bss && ether_addr_equal(req->bss->bssid, dev->dev_addr)) ||
+	    (req->link_id >= 0 &&
+	     ether_addr_equal(req->ap_mld_addr, dev->dev_addr)))
+		return -EINVAL;
+
 	cfg80211_oper_and_ht_capa(&req->ht_capa_mask,
 				  rdev->wiphy.ht_capa_mod_mask);
 	cfg80211_oper_and_vht_capa(&req->vht_capa_mask,
diff --git a/net/wireless/ocb.c b/net/wireless/ocb.c
index 27a1732264f9..29afaf3da54f 100644
--- a/net/wireless/ocb.c
+++ b/net/wireless/ocb.c
@@ -68,6 +68,9 @@ int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->leave_ocb)
 		return -EOPNOTSUPP;
 
+	if (!wdev->u.ocb.chandef.chan)
+		return -ENOTCONN;
+
 	err = rdev_leave_ocb(rdev, dev);
 	if (!err)
 		memset(&wdev->u.ocb.chandef, 0, sizeof(wdev->u.ocb.chandef));
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
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index afd663744041..5c16fe737a27 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2748,14 +2748,20 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 static int selinux_fs_context_submount(struct fs_context *fc,
 				   struct super_block *reference)
 {
-	const struct superblock_security_struct *sbsec;
+	const struct superblock_security_struct *sbsec = selinux_superblock(reference);
 	struct selinux_mnt_opts *opts;
 
+	/*
+	 * Ensure that fc->security remains NULL when no options are set
+	 * as expected by selinux_set_mnt_opts().
+	 */
+	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
+		return 0;
+
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
 		return -ENOMEM;
 
-	sbsec = selinux_superblock(reference);
 	if (sbsec->flags & FSCONTEXT_MNT)
 		opts->fscontext_sid = sbsec->sid;
 	if (sbsec->flags & CONTEXT_MNT)
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 317bdf6dcbef..2873420c9aca 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -481,6 +481,14 @@ static const struct config_entry config_table[] = {
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
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 0201029899ca..c86f8f9a6100 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -467,7 +467,9 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Rex"),
 		},
-		.driver_data = (void *)(SOF_SDW_PCH_DMIC),
+		.driver_data = (void *)(SOF_SDW_PCH_DMIC |
+					SOF_BT_OFFLOAD_SSP(1) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	/* LunarLake devices */
 	{
diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 8a0fc635a997..d07dc78074cc 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -168,6 +168,8 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 		if ((status & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
 			snd_sof_dsp_panic(sdev, sdev->dsp_box.offset + sizeof(status),
 					  true);
+			status = 0;
+			acp_mailbox_write(sdev, sdev->dsp_box.offset, &status, sizeof(status));
 			return IRQ_HANDLED;
 		}
 		snd_sof_ipc_msgs_rx(sdev);
@@ -197,6 +199,8 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 	acp_mailbox_read(sdev, sdev->debug_box.offset, &status, sizeof(u32));
 	if ((status & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
 		snd_sof_dsp_panic(sdev, sdev->dsp_oops_offset, true);
+		status = 0;
+		acp_mailbox_write(sdev, sdev->debug_box.offset, &status, sizeof(status));
 		return IRQ_HANDLED;
 	}
 
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 698129dccc7d..3866dd3cba69 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1117,10 +1117,11 @@ static void sof_disconnect_dai_widget(struct snd_soc_component *scomp,
 {
 	struct snd_soc_card *card = scomp->card;
 	struct snd_soc_pcm_runtime *rtd;
+	const char *sname = w->sname;
 	struct snd_soc_dai *cpu_dai;
 	int i, stream;
 
-	if (!w->sname)
+	if (!sname)
 		return;
 
 	if (w->id == snd_soc_dapm_dai_out)
@@ -1133,7 +1134,7 @@ static void sof_disconnect_dai_widget(struct snd_soc_component *scomp,
 	list_for_each_entry(rtd, &card->rtd_list, list) {
 		/* does stream match DAI link ? */
 		if (!rtd->dai_link->stream_name ||
-		    strcmp(w->sname, rtd->dai_link->stream_name))
+		    strcmp(sname, rtd->dai_link->stream_name))
 			continue;
 
 		for_each_rtd_cpu_dais(rtd, i, cpu_dai)
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
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e07dff7eba60..13b5623b720f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8356,6 +8356,7 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object_unload(obj);
 	btf__free(obj->btf);
+	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
diff --git a/tools/testing/selftests/arm64/signal/testcases/zt_regs.c b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
index e1eb4d5c027a..2e384d731618 100644
--- a/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
@@ -65,6 +65,7 @@ int zt_regs_run(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
 	if (memcmp(zeros, (char *)zt + ZT_SIG_REGS_OFFSET,
 		   ZT_SIG_REGS_SIZE(zt->nregs)) != 0) {
 		fprintf(stderr, "ZT data invalid\n");
+		free(zeros);
 		return 1;
 	}
 
diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index cb5f18c06593..d68264a5f3f0 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -31,6 +31,9 @@ err_ret=1
 # kselftest skip code is 4
 err_skip=4
 
+# umount required
+UMOUNT_DIR=""
+
 # cgroup RT scheduling prevents chrt commands from succeeding, which
 # induces failures in test wakeup tests.  Disable for the duration of
 # the tests.
@@ -45,6 +48,9 @@ setup() {
 
 cleanup() {
   echo $sched_rt_runtime_orig > $sched_rt_runtime
+  if [ -n "${UMOUNT_DIR}" ]; then
+    umount ${UMOUNT_DIR} ||:
+  fi
 }
 
 errexit() { # message
@@ -160,11 +166,13 @@ if [ -z "$TRACING_DIR" ]; then
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
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 486334981e60..8e7750e2eb97 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -769,7 +769,6 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 	lseek(fd, 0, SEEK_SET);
 
 	r = read(fd, buf, sizeof(buf) - 1);
-	buf[r] = '\0';
 
 	fclose(memfile);
 
@@ -779,6 +778,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 		return 1;
 	}
 
+	buf[r] = '\0';
 	llen += printf(" \"%s\" = \"%s\"", expected, buf);
 	ret = strncmp(expected, buf, c);
 
@@ -939,6 +939,35 @@ static const struct test test_names[] = {
 	{ 0 }
 };
 
+int is_setting_valid(char *test)
+{
+	int idx, len, test_len, valid = 0;
+	char delimiter;
+
+	if (!test)
+		return valid;
+
+	test_len = strlen(test);
+
+	for (idx = 0; test_names[idx].name; idx++) {
+		len = strlen(test_names[idx].name);
+		if (test_len < len)
+			continue;
+
+		if (strncmp(test, test_names[idx].name, len) != 0)
+			continue;
+
+		delimiter = test[len];
+		if (delimiter != ':' && delimiter != ',' && delimiter != '\0')
+			continue;
+
+		valid = 1;
+		break;
+	}
+
+	return valid;
+}
+
 int main(int argc, char **argv, char **envp)
 {
 	int min = 0;
@@ -964,10 +993,10 @@ int main(int argc, char **argv, char **envp)
 	 *    syscall:5-15[:.*],stdlib:8-10
 	 */
 	test = argv[1];
-	if (!test)
+	if (!is_setting_valid(test))
 		test = getenv("NOLIBC_TEST");
 
-	if (test) {
+	if (is_setting_valid(test)) {
 		char *comma, *colon, *dash, *value;
 
 		do {
