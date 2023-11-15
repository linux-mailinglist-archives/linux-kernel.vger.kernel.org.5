Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194737E5B47
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjKHQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjKHQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:32:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB151FEF;
        Wed,  8 Nov 2023 08:32:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128A6C433C8;
        Wed,  8 Nov 2023 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699461151;
        bh=ZSJj+k3lRykYAVRVgOaAuHD0hKD5QsReK+HIG1hCLaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w67gWKIQx5wQztjUiblV6GTmD0qUSjQOcl8knRoUltFoaAJkOnNjBz4fbVJcVdXv/
         m/uM79U6EZssBuLBNMiUnKd4wf2tieiMX6IhAlzwRKulqJysASp0NJD55kGfwoOAS0
         /Vb/BNINp6fNRDhEkIv1vY5W87pIZjWaZBczlXfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.138
Date:   Wed,  8 Nov 2023 17:32:18 +0100
Message-ID: <2023110818-stress-unfocused-0a87@gregkh>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <2023110818-backstage-strung-facd@gregkh>
References: <2023110818-backstage-strung-facd@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 6e88459f2ab1..f8534e335aba 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 137
+SUBLEVEL = 138
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 0a9a0f301474..40687e271c10 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -394,7 +394,7 @@ interrupt_base:
 #ifdef CONFIG_PPC_FPU
 	FP_UNAVAILABLE_EXCEPTION
 #else
-	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, unknown_exception)
+	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, emulation_assist_interrupt)
 #endif
 
 	/* System Call Interrupt */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index b1e43b69a559..42338e2921d6 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -887,6 +887,8 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Parse memory topology */
 	mem_topology_setup();
+	/* Set max_mapnr before paging_init() */
+	set_max_mapnr(max_pfn);
 
 	/*
 	 * Release secondary cpus out of their spinloops at 0x60 now that
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 6902f453c745..01fc77564cac 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -288,7 +288,6 @@ void __init mem_init(void)
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-	set_max_mapnr(max_pfn);
 
 	kasan_late_init();
 
diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 781e39b3c009..481e94e1f685 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -453,5 +453,5 @@ ccslow:	cmp	%g1, 0
  * we only bother with faults on loads... */
 
 cc_fault:
-	ret
+	retl
 	 clr	%o0
diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 637fa1df3512..c715097e92fd 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -69,6 +69,8 @@ struct legacy_pic {
 	void (*make_irq)(unsigned int irq);
 };
 
+void legacy_pic_pcat_compat(void);
+
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a12458a7a8d4..e43ccc62fc1c 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -108,27 +108,16 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within
- * the file, and somewhat descriptive.  The size is in bytes.  Must be
- * used at file scope.
+ * Reserve space in the .brk section, which is a block of memory from which the
+ * caller is allowed to allocate very early (before even memblock is available)
+ * by calling extend_brk().  All allocated memory will be eventually converted
+ * to memblock.  Any leftover unallocated memory will be freed.
  *
- * (This uses a temp function to wrap the asm so we can pass it the
- * size parameter; otherwise we wouldn't be able to.  We can't use a
- * "section" attribute on a normal variable because it always ends up
- * being @progbits, which ends up allocating space in the vmlinux
- * executable.)
+ * The size is in bytes.
  */
-#define RESERVE_BRK(name,sz)						\
-	static void __section(".discard.text") __used notrace		\
-	__brk_reservation_fn_##name##__(void) {				\
-		asm volatile (						\
-			".pushsection .brk_reservation,\"aw\",@nobits;" \
-			".brk." #name ":"				\
-			" 1:.skip %c0;"					\
-			" .size .brk." #name ", . - 1b;"		\
-			" .popsection"					\
-			: : "i" (sz));					\
-	}
+#define RESERVE_BRK(name, size)					\
+	__section(".bss..brk") __aligned(1) __used	\
+	static char __brk_##name[size]
 
 extern void probe_roms(void);
 #ifdef __i386__
@@ -141,12 +130,19 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
 
 #endif /* __i386__ */
 #endif /* _SETUP */
-#else
-#define RESERVE_BRK(name,sz)				\
-	.pushsection .brk_reservation,"aw",@nobits;	\
-.brk.name:						\
-1:	.skip sz;					\
-	.size .brk.name,.-1b;				\
+
+#else  /* __ASSEMBLY */
+
+.macro __RESERVE_BRK name, size
+	.pushsection .bss..brk, "aw"
+SYM_DATA_START(__brk_\name)
+	.skip \size
+SYM_DATA_END(__brk_\name)
 	.popsection
+.endm
+
+#define RESERVE_BRK(name, size) __RESERVE_BRK name, size
+
 #endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_SETUP_H */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 94ac7402c1ac..44646540061c 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -139,6 +139,9 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
 
+	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
+		legacy_pic_pcat_compat();
+
 	default_acpi_madt_oem_check(madt->header.oem_id,
 				    madt->header.oem_table_id);
 
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index f91e5e31aa4f..2ac5f488300c 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -32,6 +32,7 @@
  */
 static void init_8259A(int auto_eoi);
 
+static bool pcat_compat __ro_after_init;
 static int i8259A_auto_eoi;
 DEFINE_RAW_SPINLOCK(i8259A_lock);
 
@@ -301,15 +302,32 @@ static void unmask_8259A(void)
 
 static int probe_8259A(void)
 {
+	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
 	unsigned long flags;
-	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
-	unsigned char new_val;
+
+	/*
+	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
+	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
+	 * fails.
+	 *
+	 * Right now this causes problems as quite some code depends on
+	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
+	 * when the system has an IO/APIC because then PIC is not required
+	 * at all, except for really old machines where the timer interrupt
+	 * must be routed through the PIC. So just pretend that the PIC is
+	 * there and let legacy_pic->init() initialize it for nothing.
+	 *
+	 * Alternatively this could just try to initialize the PIC and
+	 * repeat the probe, but for cases where there is no PIC that's
+	 * just pointless.
+	 */
+	if (pcat_compat)
+		return nr_legacy_irqs();
+
 	/*
-	 * Check to see if we have a PIC.
-	 * Mask all except the cascade and read
-	 * back the value we just wrote. If we don't
-	 * have a PIC, we will read 0xff as opposed to the
-	 * value we wrote.
+	 * Check to see if we have a PIC.  Mask all except the cascade and
+	 * read back the value we just wrote. If we don't have a PIC, we
+	 * will read 0xff as opposed to the value we wrote.
 	 */
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 
@@ -431,5 +449,9 @@ static int __init i8259A_init_ops(void)
 
 	return 0;
 }
-
 device_initcall(i8259A_init_ops);
+
+void __init legacy_pic_pcat_compat(void)
+{
+	pcat_compat = true;
+}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 8e56c4de00b9..dcfea7b01c57 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -66,11 +66,6 @@ RESERVE_BRK(dmi_alloc, 65536);
 #endif
 
 
-/*
- * Range of the BSS area. The size of the BSS area is determined
- * at link time, with RESERVE_BRK() facility reserving additional
- * chunks.
- */
 unsigned long _brk_start = (unsigned long)__brk_base;
 unsigned long _brk_end   = (unsigned long)__brk_base;
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ca1a7595edac..351c604de263 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -414,7 +414,7 @@ SECTIONS
 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
-		*(.brk_reservation)	/* areas brk users have reserved */
+		*(.bss..brk)		/* areas brk users have reserved */
 		__brk_limit = .;
 	}
 
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 8c0d33e182fd..1b9d47b10bd0 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -30,6 +30,75 @@ static struct device *next_device(struct klist_iter *i)
 	return dev;
 }
 
+/**
+ * driver_set_override() - Helper to set or clear driver override.
+ * @dev: Device to change
+ * @override: Address of string to change (e.g. &device->driver_override);
+ *            The contents will be freed and hold newly allocated override.
+ * @s: NUL-terminated string, new driver name to force a match, pass empty
+ *     string to clear it ("" or "\n", where the latter is only for sysfs
+ *     interface).
+ * @len: length of @s
+ *
+ * Helper to set or clear driver override in a device, intended for the cases
+ * when the driver_override field is allocated by driver/bus code.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len)
+{
+	const char *new, *old;
+	char *cp;
+
+	if (!override || !s)
+		return -EINVAL;
+
+	/*
+	 * The stored value will be used in sysfs show callback (sysfs_emit()),
+	 * which has a length limit of PAGE_SIZE and adds a trailing newline.
+	 * Thus we can store one character less to avoid truncation during sysfs
+	 * show.
+	 */
+	if (len >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (!len) {
+		/* Empty string passed - clear override */
+		device_lock(dev);
+		old = *override;
+		*override = NULL;
+		device_unlock(dev);
+		kfree(old);
+
+		return 0;
+	}
+
+	cp = strnchr(s, len, '\n');
+	if (cp)
+		len = cp - s;
+
+	new = kstrndup(s, len, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	device_lock(dev);
+	old = *override;
+	if (cp != s) {
+		*override = new;
+	} else {
+		/* "\n" passed - clear override */
+		kfree(new);
+		*override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(driver_set_override);
+
 /**
  * driver_for_each_device - Iterator for devices bound to a driver.
  * @drv: Driver we're iterating.
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ac5cf1a8d79a..596fbe6b701a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1270,31 +1270,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	char *driver_override, *old, *cp;
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5eba83745d8d..b37af6b27e9c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3182,6 +3182,7 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
 				 unsigned int i, char terminator)
 {
 	struct clk_core *parent;
+	const char *name = NULL;
 
 	/*
 	 * Go through the following options to fetch a parent's name.
@@ -3196,18 +3197,20 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
 	 * registered (yet).
 	 */
 	parent = clk_core_get_parent_by_index(core, i);
-	if (parent)
+	if (parent) {
 		seq_puts(s, parent->name);
-	else if (core->parents[i].name)
+	} else if (core->parents[i].name) {
 		seq_puts(s, core->parents[i].name);
-	else if (core->parents[i].fw_name)
+	} else if (core->parents[i].fw_name) {
 		seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
-	else if (core->parents[i].index >= 0)
-		seq_puts(s,
-			 of_clk_get_parent_name(core->of_node,
-						core->parents[i].index));
-	else
-		seq_puts(s, "(missing)");
+	} else {
+		if (core->parents[i].index >= 0)
+			name = of_clk_get_parent_name(core->of_node, core->parents[i].index);
+		if (!name)
+			name = "(missing)";
+
+		seq_puts(s, name);
+	}
 
 	seq_putc(s, terminator);
 }
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index cb6b0e9ed5ad..0e9cb0168264 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3697,6 +3697,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_disable(base->dev);
 
 	kfree(base->lcla_pool.alloc_map);
 	kfree(base->lookup_log_chans);
diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index 1f410809d3ee..0f656e4191d5 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -115,11 +115,11 @@ static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 		dsp_chan->idx = i % 2;
 		dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
 		if (IS_ERR(dsp_chan->ch)) {
-			kfree(dsp_chan->name);
 			ret = PTR_ERR(dsp_chan->ch);
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
 					chan_name, ret);
+			kfree(dsp_chan->name);
 			goto out;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d90da384d185..1f1e7966beb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1285,6 +1285,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2cf49a32ac6c..f57334fff7fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1319,6 +1319,25 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+/*
+ * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
+ * speed switching. Until we have confirmation from Intel that a specific host
+ * supports it, it's safer that we keep it disabled for all.
+ *
+ * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ */
+bool amdgpu_device_pcie_dynamic_switching_supported(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return false;
+#endif
+	return true;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index b9555ba6d32f..6d64d603a97a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1147,7 +1147,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_pcie_dynamic_switching_supported())
 		return;
 
 	if (adev->flags & AMD_IS_APU ||
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index d02e323a4ecd..865c7f39143e 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2615,14 +2615,14 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
 	struct drm_dp_mst_branch *found_mstb;
 	struct drm_dp_mst_port *port;
 
+	if (!mstb)
+		return NULL;
+
 	if (memcmp(mstb->guid, guid, 16) == 0)
 		return mstb;
 
 
 	list_for_each_entry(port, &mstb->ports, next) {
-		if (!port->mstb)
-			continue;
-
 		found_mstb = get_mst_branch_device_by_guid_helper(port->mstb, guid);
 
 		if (found_mstb)
diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 0b488d49694c..5fdaa2d36fdd 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -761,9 +761,18 @@ static void i915_pmu_event_start(struct perf_event *event, int flags)
 
 static void i915_pmu_event_stop(struct perf_event *event, int flags)
 {
+	struct drm_i915_private *i915 =
+		container_of(event->pmu, typeof(*i915), pmu.base);
+	struct i915_pmu *pmu = &i915->pmu;
+
+	if (pmu->closed)
+		goto out;
+
 	if (flags & PERF_EF_UPDATE)
 		i915_pmu_event_read(event);
 	i915_pmu_disable(event);
+
+out:
 	event->hw.state = PERF_HES_STOPPED;
 }
 
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 2df59b3c2ea1..291cdd893fc5 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -234,10 +234,6 @@ void ttm_device_fini(struct ttm_device *bdev)
 	struct ttm_resource_manager *man;
 	unsigned i;
 
-	man = ttm_manager_type(bdev, TTM_PL_SYSTEM);
-	ttm_resource_manager_set_used(man, false);
-	ttm_set_driver_manager(bdev, TTM_PL_SYSTEM, NULL);
-
 	mutex_lock(&ttm_global_mutex);
 	list_del(&bdev->device_list);
 	mutex_unlock(&ttm_global_mutex);
@@ -247,6 +243,10 @@ void ttm_device_fini(struct ttm_device *bdev)
 	if (ttm_bo_delayed_delete(bdev, true))
 		pr_debug("Delayed destroy list was clean\n");
 
+	man = ttm_manager_type(bdev, TTM_PL_SYSTEM);
+	ttm_resource_manager_set_used(man, false);
+	ttm_set_driver_manager(bdev, TTM_PL_SYSTEM, NULL);
+
 	spin_lock(&bdev->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i)
 		if (list_empty(&man->lru[0]))
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index d93e0e517e70..b7cad1bed3dc 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -744,6 +744,8 @@ static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
 	func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
 	func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
 	writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+
+	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 }
 
 static int aspeed_i2c_reg_slave(struct i2c_client *client)
@@ -760,7 +762,6 @@ static int aspeed_i2c_reg_slave(struct i2c_client *client)
 	__aspeed_i2c_reg_slave(bus, client->addr);
 
 	bus->slave = client;
-	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 	spin_unlock_irqrestore(&bus->lock, flags);
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 50d5ae81d227..b26c3ee63609 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1063,9 +1063,10 @@ static int stm32f7_i2c_smbus_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 	/* Configure PEC */
 	if ((flags & I2C_CLIENT_PEC) && f7_msg->size != I2C_SMBUS_QUICK) {
 		cr1 |= STM32F7_I2C_CR1_PECEN;
-		cr2 |= STM32F7_I2C_CR2_PECBYTE;
-		if (!f7_msg->read_write)
+		if (!f7_msg->read_write) {
+			cr2 |= STM32F7_I2C_CR2_PECBYTE;
 			f7_msg->count++;
+		}
 	} else {
 		cr1 &= ~STM32F7_I2C_CR1_PECEN;
 		cr2 &= ~STM32F7_I2C_CR2_PECBYTE;
@@ -1153,8 +1154,10 @@ static void stm32f7_i2c_smbus_rep_start(struct stm32f7_i2c_dev *i2c_dev)
 	f7_msg->stop = true;
 
 	/* Add one byte for PEC if needed */
-	if (cr1 & STM32F7_I2C_CR1_PECEN)
+	if (cr1 & STM32F7_I2C_CR1_PECEN) {
+		cr2 |= STM32F7_I2C_CR2_PECBYTE;
 		f7_msg->count++;
+	}
 
 	/* Set number of bytes to be transferred */
 	cr2 &= ~(STM32F7_I2C_CR2_NBYTES_MASK);
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 8e8688e8de0f..45a3f7e7b3f6 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -61,7 +61,7 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 	if (ret)
 		goto err;
 
-	adap = of_find_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
+	adap = of_get_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
 	if (!adap) {
 		ret = -ENODEV;
 		goto err_with_revert;
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index 33024acaac02..0ebc12575081 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -52,7 +52,7 @@ static struct i2c_adapter *mux_parent_adapter(struct device *dev)
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return ERR_PTR(-ENODEV);
 	}
-	parent = of_find_i2c_adapter_by_node(parent_np);
+	parent = of_get_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
 	if (!parent)
 		return ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index f1bb00a11ad6..fc991cf002af 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -62,7 +62,7 @@ static struct i2c_adapter *i2c_mux_pinctrl_parent_adapter(struct device *dev)
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return ERR_PTR(-ENODEV);
 	}
-	parent = of_find_i2c_adapter_by_node(parent_np);
+	parent = of_get_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
 	if (!parent)
 		return ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 3b3868aa2533..82dd148d7624 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -826,16 +826,26 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* leave out any TS related code if unreachable */
+	if (IS_REACHABLE(CONFIG_INPUT)) {
+		has_ts = of_property_read_bool(pdev->dev.of_node,
+					       "has-touchscreen") || pdata;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 	info->irq = irq;
 
-	irq = platform_get_irq(pdev, 1);
-	if (irq == -EPROBE_DEFER)
-		return irq;
+	if (has_ts) {
+		irq = platform_get_irq(pdev, 1);
+		if (irq == -EPROBE_DEFER)
+			return irq;
 
-	info->tsirq = irq;
+		info->tsirq = irq;
+	} else {
+		info->tsirq = -1;
+	}
 
 	info->dev = &pdev->dev;
 
@@ -900,12 +910,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (info->data->init_hw)
 		info->data->init_hw(info);
 
-	/* leave out any TS related code if unreachable */
-	if (IS_REACHABLE(CONFIG_INPUT)) {
-		has_ts = of_property_read_bool(pdev->dev.of_node,
-					       "has-touchscreen") || pdata;
-	}
-
 	if (pdata)
 		info->delay = pdata->delay;
 	else
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 198d2916266d..9fa754b56b52 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -454,6 +454,9 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const unsigned int xadc_axi_reg_offsets[] = {
@@ -564,6 +567,9 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const struct xadc_ops xadc_us_axi_ops = {
@@ -575,6 +581,12 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED,
 	.type = XADC_TYPE_US,
+	/**
+	 * Values below are for UltraScale+ (SYSMONE4) using internal reference.
+	 * See https://docs.xilinx.com/v/u/en-US/ug580-ultrascale-sysmon
+	 */
+	.temp_scale = 509314,
+	.temp_offset = 280231,
 };
 
 static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
@@ -946,8 +958,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 			*val2 = chan->scan_type.realbits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
-			/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
-			*val = 503975;
+			*val = xadc->ops->temp_scale;
 			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
@@ -955,7 +966,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		/* Only the temperature channel has an offset */
-		*val = -((273150 << bits) / 503975);
+		*val = -((xadc->ops->temp_offset << bits) / xadc->ops->temp_scale);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = xadc_read_samplerate(xadc);
@@ -1434,28 +1445,6 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Disable all alarms */
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
-				  XADC_CONF1_ALARM_MASK);
-	if (ret)
-		return ret;
-
-	/* Set thresholds to min/max */
-	for (i = 0; i < 16; i++) {
-		/*
-		 * Set max voltage threshold and both temperature thresholds to
-		 * 0xffff, min voltage threshold to 0.
-		 */
-		if (i % 8 < 4 || i == 7)
-			xadc->threshold[i] = 0xffff;
-		else
-			xadc->threshold[i] = 0;
-		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
-			xadc->threshold[i]);
-		if (ret)
-			return ret;
-	}
-
 	/* Go to non-buffered mode */
 	xadc_postdisable(indio_dev);
 
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 8b80195725e9..546c24295363 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -86,6 +86,8 @@ struct xadc_ops {
 
 	unsigned int flags;
 	enum xadc_type type;
+	int temp_scale;
+	int temp_offset;
 };
 
 static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index cc28713b0dc8..ea0a39882eb2 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -3,43 +3,91 @@
  * IIO rescale driver
  *
  * Copyright (C) 2018 Axentia Technologies AB
+ * Copyright (C) 2022 Liam Beguin <liambeguin@gmail.com>
  *
  * Author: Peter Rosin <peda@axentia.se>
  */
 
 #include <linux/err.h>
 #include <linux/gcd.h>
-#include <linux/iio/consumer.h>
-#include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
-struct rescale;
+#include <linux/iio/afe/rescale.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
 
-struct rescale_cfg {
-	enum iio_chan_type type;
-	int (*props)(struct device *dev, struct rescale *rescale);
-};
+int rescale_process_scale(struct rescale *rescale, int scale_type,
+			  int *val, int *val2)
+{
+	s64 tmp;
 
-struct rescale {
-	const struct rescale_cfg *cfg;
-	struct iio_channel *source;
-	struct iio_chan_spec chan;
-	struct iio_chan_spec_ext_info *ext_info;
-	bool chan_processed;
-	s32 numerator;
-	s32 denominator;
-};
+	switch (scale_type) {
+	case IIO_VAL_FRACTIONAL:
+		*val *= rescale->numerator;
+		*val2 *= rescale->denominator;
+		return scale_type;
+	case IIO_VAL_INT:
+		*val *= rescale->numerator;
+		if (rescale->denominator == 1)
+			return scale_type;
+		*val2 = rescale->denominator;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = (s64)*val * 1000000000LL;
+		tmp = div_s64(tmp, rescale->denominator);
+		tmp *= rescale->numerator;
+		tmp = div_s64(tmp, 1000000000LL);
+		*val = tmp;
+		return scale_type;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+int rescale_process_offset(struct rescale *rescale, int scale_type,
+			   int scale, int scale2, int schan_off,
+			   int *val, int *val2)
+{
+	s64 tmp, tmp2;
+
+	switch (scale_type) {
+	case IIO_VAL_FRACTIONAL:
+		tmp = (s64)rescale->offset * scale2;
+		*val = div_s64(tmp, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT:
+		*val = div_s64(rescale->offset, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = (s64)rescale->offset * (1 << scale2);
+		*val = div_s64(tmp, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT_PLUS_NANO:
+		tmp = (s64)rescale->offset * 1000000000LL;
+		tmp2 = ((s64)scale * 1000000000LL) + scale2;
+		*val = div64_s64(tmp, tmp2) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT_PLUS_MICRO:
+		tmp = (s64)rescale->offset * 1000000LL;
+		tmp2 = ((s64)scale * 1000000LL) + scale2;
+		*val = div64_s64(tmp, tmp2) + schan_off;
+		return IIO_VAL_INT;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
 
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	s64 tmp;
+	int scale, scale2;
+	int schan_off = 0;
 	int ret;
 
 	switch (mask) {
@@ -65,27 +113,58 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		} else {
 			ret = iio_read_channel_scale(rescale->source, val, val2);
 		}
-		switch (ret) {
-		case IIO_VAL_FRACTIONAL:
-			*val *= rescale->numerator;
-			*val2 *= rescale->denominator;
-			return ret;
-		case IIO_VAL_INT:
-			*val *= rescale->numerator;
-			if (rescale->denominator == 1)
-				return ret;
-			*val2 = rescale->denominator;
-			return IIO_VAL_FRACTIONAL;
-		case IIO_VAL_FRACTIONAL_LOG2:
-			tmp = (s64)*val * 1000000000LL;
-			tmp = div_s64(tmp, rescale->denominator);
-			tmp *= rescale->numerator;
-			tmp = div_s64(tmp, 1000000000LL);
-			*val = tmp;
-			return ret;
-		default:
-			return -EOPNOTSUPP;
+		return rescale_process_scale(rescale, ret, val, val2);
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * Processed channels are scaled 1-to-1 and source offset is
+		 * already taken into account.
+		 *
+		 * In other cases, real world measurement are expressed as:
+		 *
+		 *	schan_scale * (raw + schan_offset)
+		 *
+		 * Given that the rescaler parameters are applied recursively:
+		 *
+		 *	rescaler_scale * (schan_scale * (raw + schan_offset) +
+		 *		rescaler_offset)
+		 *
+		 * Or,
+		 *
+		 *	(rescaler_scale * schan_scale) * (raw +
+		 *		(schan_offset +	rescaler_offset / schan_scale)
+		 *
+		 * Thus, reusing the original expression the parameters exposed
+		 * to userspace are:
+		 *
+		 *	scale = schan_scale * rescaler_scale
+		 *	offset = schan_offset + rescaler_offset / schan_scale
+		 */
+		if (rescale->chan_processed) {
+			*val = rescale->offset;
+			return IIO_VAL_INT;
+		}
+
+		if (iio_channel_has_info(rescale->source->channel,
+					 IIO_CHAN_INFO_OFFSET)) {
+			ret = iio_read_channel_offset(rescale->source,
+						      &schan_off, NULL);
+			if (ret != IIO_VAL_INT)
+				return ret < 0 ? ret : -EOPNOTSUPP;
+		}
+
+		if (iio_channel_has_info(rescale->source->channel,
+					 IIO_CHAN_INFO_SCALE)) {
+			ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
+			return rescale_process_offset(rescale, ret, scale, scale2,
+						      schan_off, val, val2);
 		}
+
+		/*
+		 * If we get here we have no scale so scale 1:1 but apply
+		 * rescaler and offset, if any.
+		 */
+		return rescale_process_offset(rescale, IIO_VAL_FRACTIONAL, 1, 1,
+					      schan_off, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -149,8 +228,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->type = rescale->cfg->type;
 
 	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
-	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
-		dev_info(dev, "using raw+scale source channel\n");
+	    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
+	     iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
+		dev_info(dev, "using raw+scale/offset source channel\n");
 	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
 		dev_info(dev, "using processed channel\n");
 		rescale->chan_processed = true;
@@ -162,6 +242,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -326,6 +409,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ecc7ca653d75..c3a341c16d45 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1752,6 +1752,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 		psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
 		!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10);
 	const struct rmi_device_platform_data pdata = {
+		.reset_delay_ms = 30,
 		.sensor_pdata = {
 			.sensor_type = rmi_sensor_touchpad,
 			.axis_align.flip_y = true,
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 2407ea43de59..f38bf9a5f599 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -235,12 +235,29 @@ static void rmi_smb_clear_state(struct rmi_smb_xport *rmi_smb)
 
 static int rmi_smb_enable_smbus_mode(struct rmi_smb_xport *rmi_smb)
 {
-	int retval;
+	struct i2c_client *client = rmi_smb->client;
+	int smbus_version;
+
+	/*
+	 * psmouse driver resets the controller, we only need to wait
+	 * to give the firmware chance to fully reinitialize.
+	 */
+	if (rmi_smb->xport.pdata.reset_delay_ms)
+		msleep(rmi_smb->xport.pdata.reset_delay_ms);
 
 	/* we need to get the smbus version to activate the touchpad */
-	retval = rmi_smb_get_version(rmi_smb);
-	if (retval < 0)
-		return retval;
+	smbus_version = rmi_smb_get_version(rmi_smb);
+	if (smbus_version < 0)
+		return smbus_version;
+
+	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
+		smbus_version);
+
+	if (smbus_version != 2 && smbus_version != 3) {
+		dev_err(&client->dev, "Unrecognized SMB version %d\n",
+				smbus_version);
+		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -253,11 +270,10 @@ static int rmi_smb_reset(struct rmi_transport_dev *xport, u16 reset_addr)
 	rmi_smb_clear_state(rmi_smb);
 
 	/*
-	 * we do not call the actual reset command, it has to be handled in
-	 * PS/2 or there will be races between PS/2 and SMBus.
-	 * PS/2 should ensure that a psmouse_reset is called before
-	 * intializing the device and after it has been removed to be in a known
-	 * state.
+	 * We do not call the actual reset command, it has to be handled in
+	 * PS/2 or there will be races between PS/2 and SMBus. PS/2 should
+	 * ensure that a psmouse_reset is called before initializing the
+	 * device and after it has been removed to be in a known state.
 	 */
 	return rmi_smb_enable_smbus_mode(rmi_smb);
 }
@@ -273,7 +289,6 @@ static int rmi_smb_probe(struct i2c_client *client,
 {
 	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct rmi_smb_xport *rmi_smb;
-	int smbus_version;
 	int error;
 
 	if (!pdata) {
@@ -312,18 +327,9 @@ static int rmi_smb_probe(struct i2c_client *client,
 	rmi_smb->xport.proto_name = "smb";
 	rmi_smb->xport.ops = &rmi_smb_ops;
 
-	smbus_version = rmi_smb_get_version(rmi_smb);
-	if (smbus_version < 0)
-		return smbus_version;
-
-	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
-		smbus_version);
-
-	if (smbus_version != 2 && smbus_version != 3) {
-		dev_err(&client->dev, "Unrecognized SMB version %d\n",
-				smbus_version);
-		return -ENODEV;
-	}
+	error = rmi_smb_enable_smbus_mode(rmi_smb);
+	if (error)
+		return error;
 
 	i2c_set_clientdata(client, rmi_smb);
 
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 8017f6d32d52..54c99441c1b5 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -109,8 +109,16 @@ static int __init riscv_intc_init(struct device_node *node,
 	 * for each INTC DT node. We only need to do INTC initialization
 	 * for the INTC DT node belonging to boot CPU (or boot HART).
 	 */
-	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
+	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id()) {
+		/*
+		 * The INTC nodes of each CPU are suppliers for downstream
+		 * interrupt controllers (such as PLIC, IMSIC and APLIC
+		 * direct-mode) so we should mark an INTC node as initialized
+		 * if we are not creating IRQ domain for it.
+		 */
+		fwnode_dev_initialized(of_fwnode_handle(node), true);
 		return 0;
+	}
 
 	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
 					    &riscv_intc_domain_ops, NULL);
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 33c76710f845..9c150c402f0b 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -408,6 +408,7 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static void stm32_irq_ack(struct irq_data *d)
diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 53decd89876e..a851e0236464 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -23,7 +23,7 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret = 0;
+	int ret = 0, table_size;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -58,16 +58,43 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 
 	ret = chameleon_parse_cells(priv->bus, priv->mem->start, priv->base);
 	if (ret < 0) {
-		mcb_release_bus(priv->bus);
-		return ret;
+		goto out_mcb_bus;
 	}
 
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size = ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mem->start, resource_size(priv->mem));
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res = devm_request_mem_region(&pdev->dev, priv->mem->start,
+					      table_size,
+					      KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret = -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base = devm_ioremap(&pdev->dev, priv->mem->start, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret = -ENOMEM;
+			goto out_mcb_bus;
+		}
+
+		platform_set_drvdata(pdev, priv);
+	}
 
 	mcb_bus_add_devices(priv->bus);
 
 	return 0;
 
+out_mcb_bus:
+	mcb_release_bus(priv->bus);
+	return ret;
 }
 
 static int mcb_lpc_remove(struct platform_device *pdev)
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index c41cbacc75a2..656b6b71c768 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -128,7 +128,7 @@ static void chameleon_parse_bar(void __iomem *base,
 	}
 }
 
-static int chameleon_get_bar(char __iomem **base, phys_addr_t mapbase,
+static int chameleon_get_bar(void __iomem **base, phys_addr_t mapbase,
 			     struct chameleon_bar **cb)
 {
 	struct chameleon_bar *c;
@@ -177,12 +177,13 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 {
 	struct chameleon_fpga_header *header;
 	struct chameleon_bar *cb;
-	char __iomem *p = base;
+	void __iomem *p = base;
 	int num_cells = 0;
 	uint32_t dtype;
 	int bar_count;
 	int ret;
 	u32 hsize;
+	u32 table_size;
 
 	hsize = sizeof(struct chameleon_fpga_header);
 
@@ -237,12 +238,16 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 		num_cells++;
 	}
 
-	if (num_cells == 0)
-		num_cells = -EINVAL;
+	if (num_cells == 0) {
+		ret = -EINVAL;
+		goto free_bar;
+	}
 
+	table_size = p - base;
+	pr_debug("%d cell(s) found. Chameleon table size: 0x%04x bytes\n", num_cells, table_size);
 	kfree(cb);
 	kfree(header);
-	return num_cells;
+	return table_size;
 
 free_bar:
 	kfree(cb);
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 24dfc069dbc6..b121f9081e5e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -992,11 +992,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		err = wait_for_completion_interruptible(&ctx->work);
 	}
 
-	if (err)
-		goto bail;
-
-	/* Check the response from remote dsp */
-	err = ctx->retval;
 	if (err)
 		goto bail;
 
@@ -1009,6 +1004,11 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 			goto bail;
 	}
 
+	/* Check the response from remote dsp */
+	err = ctx->retval;
+	if (err)
+		goto bail;
+
 bail:
 	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
 		/* We are done with this compute context */
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 2ad28f1b1461..3382cf4905de 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -71,6 +71,7 @@
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
+#define PCI_DEVICE_ID_TI_J721S2		0xb013
 #define PCI_DEVICE_ID_LS1088A			0x80c0
 
 #define is_am654_pci_dev(pdev)		\
@@ -1004,6 +1005,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM64),
 	  .driver_data = (kernel_ulong_t)&j721e_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721S2),
+	  .driver_data = (kernel_ulong_t)&j721e_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index b1c9f65ab10f..c99f5920c957 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3816,6 +3816,8 @@ int t4_load_phy_fw(struct adapter *adap, int win,
 		 FW_PARAMS_PARAM_Z_V(FW_PARAMS_PARAM_DEV_PHYFW_DOWNLOAD));
 	ret = t4_set_params_timeout(adap, adap->mbox, adap->pf, 0, 1,
 				    &param, &val, 30000);
+	if (ret)
+		return ret;
 
 	/* If we have version number support, then check to see that the new
 	 * firmware got loaded properly.
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7b18b4fd9e54..d947c2c33412 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -157,7 +157,7 @@ static int gve_alloc_page_dqo(struct gve_priv *priv,
 	int err;
 
 	err = gve_alloc_page(priv, &priv->pdev->dev, &buf_state->page_info.page,
-			     &buf_state->addr, DMA_FROM_DEVICE, GFP_KERNEL);
+			     &buf_state->addr, DMA_FROM_DEVICE, GFP_ATOMIC);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index b76e6f94edb0..22802222d34d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -566,7 +566,6 @@ struct i40e_pf {
 #define I40E_FLAG_DISABLE_FW_LLDP		BIT(24)
 #define I40E_FLAG_RS_FEC			BIT(25)
 #define I40E_FLAG_BASE_R_FEC			BIT(26)
-#define I40E_FLAG_VF_VLAN_PRUNING		BIT(27)
 /* TOTAL_PORT_SHUTDOWN
  * Allows to physically disable the link on the NIC's port.
  * If enabled, (after link down request from the OS)
@@ -589,6 +588,7 @@ struct i40e_pf {
  *   in abilities field of i40e_aq_set_phy_config structure
  */
 #define I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED	BIT(27)
+#define I40E_FLAG_VF_VLAN_PRUNING		BIT(28)
 
 	struct i40e_client_instance *cinst;
 	bool stat_offsets_loaded;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 9787e794eeda..1d096141625e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2759,7 +2759,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+	if (q_vector->tx.ring[0].flags & I40E_TXR_FLAGS_WB_ON_ITR)
 		q_vector->arm_wb_state = false;
 
 	/* Exit the polling mode, but don't re-enable interrupts if stack might
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index b2f46004a3d0..39c7bdf8c0e2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2974,11 +2974,15 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	if (err)
 		goto err_out_w_lock;
 
-	igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	err = igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	if (err)
+		goto err_out_input_filter;
 
 	spin_unlock(&adapter->nfc_lock);
 	return 0;
 
+err_out_input_filter:
+	igb_erase_filter(adapter, input);
 err_out_w_lock:
 	spin_unlock(&adapter->nfc_lock);
 err_out:
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 17cb4c13d002..3bffd2729a43 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1810,7 +1810,7 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct net_device *dev = adapter->netdev;
 	struct igc_hw *hw = &adapter->hw;
-	u32 advertising;
+	u16 advertised = 0;
 
 	/* When adapter in resetting mode, autoneg/speed/duplex
 	 * cannot be changed
@@ -1835,18 +1835,33 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
-	/* Converting to legacy u32 drops ETHTOOL_LINK_MODE_2500baseT_Full_BIT.
-	 * We have to check this and convert it to ADVERTISE_2500_FULL
-	 * (aka ETHTOOL_LINK_MODE_2500baseX_Full_BIT) explicitly.
-	 */
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising, 2500baseT_Full))
-		advertising |= ADVERTISE_2500_FULL;
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  2500baseT_Full))
+		advertised |= ADVERTISE_2500_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  1000baseT_Full))
+		advertised |= ADVERTISE_1000_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Full))
+		advertised |= ADVERTISE_100_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Half))
+		advertised |= ADVERTISE_100_HALF;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Full))
+		advertised |= ADVERTISE_10_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Half))
+		advertised |= ADVERTISE_10_HALF;
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		hw->mac.autoneg = 1;
-		hw->phy.autoneg_advertised = advertising;
+		hw->phy.autoneg_advertised = advertised;
 		if (adapter->fc_autoneg)
 			hw->fc.requested_mode = igc_fc_default;
 	} else {
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 264bb3ec44a5..1cd0928472c0 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4443,7 +4443,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		unsigned int entry = dirty_tx % NUM_TX_DESC;
 		u32 status;
 
-		status = le32_to_cpu(tp->TxDescArray[entry].opts1);
+		status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
 		if (status & DescOwn)
 			break;
 
@@ -4480,7 +4480,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		 * If skb is NULL then we come here again once a tx irq is
 		 * triggered after the last fragment is marked transmitted.
 		 */
-		if (tp->cur_tx != dirty_tx && skb)
+		if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
 			rtl8169_doorbell(tp);
 	}
 }
@@ -4513,7 +4513,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		dma_addr_t addr;
 		u32 status;
 
-		status = le32_to_cpu(desc->opts1);
+		status = le32_to_cpu(READ_ONCE(desc->opts1));
 		if (status & DescOwn)
 			break;
 
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index dc14a66583ff..44488c153ea2 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
@@ -1217,7 +1217,7 @@ static int gelic_wl_set_encodeext(struct net_device *netdev,
 		key_index = wl->current_key;
 
 	if (!enc->length && (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)) {
-		/* reques to change default key index */
+		/* request to change default key index */
 		pr_debug("%s: request to change default key to %d\n",
 			 __func__, key_index);
 		wl->current_key = key_index;
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index a3878aef0ea4..69bbc868b947 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -543,8 +543,9 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 
 	rt->dst.ops->update_pmtu(&rt->dst, NULL, skb, mtu, false);
 
-	if (!skb_is_gso(skb) && (iph->frag_off & htons(IP_DF)) &&
-	    mtu < ntohs(iph->tot_len)) {
+	if (iph->frag_off & htons(IP_DF) &&
+	    ((!skb_is_gso(skb) && skb->len > mtu) ||
+	     (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu)))) {
 		netdev_dbg(dev, "packet too big, fragmentation needed\n");
 		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 			      htonl(mtu));
diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 07adbeec1978..14cf8b0dfad9 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1162,9 +1162,10 @@ static int adf7242_stats_show(struct seq_file *file, void *offset)
 
 static void adf7242_debugfs_init(struct adf7242_local *lp)
 {
-	char debugfs_dir_name[DNAME_INLINE_LEN + 1] = "adf7242-";
+	char debugfs_dir_name[DNAME_INLINE_LEN + 1];
 
-	strncat(debugfs_dir_name, dev_name(&lp->spi->dev), DNAME_INLINE_LEN);
+	snprintf(debugfs_dir_name, sizeof(debugfs_dir_name),
+		 "adf7242-%s", dev_name(&lp->spi->dev));
 
 	lp->debugfs_root = debugfs_create_dir(debugfs_dir_name, NULL);
 
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 4cd9bcca84c5..663e3880bf71 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1208,7 +1208,7 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_in,
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -1231,7 +1231,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_out,
 			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
 
 	kfree(tmp);
 
@@ -3648,6 +3648,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
@@ -3688,6 +3690,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
@@ -4051,6 +4055,9 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 	for (i = 0; wait && i < 5000; i++) {
 		u32 ocp_data;
 
+		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+			break;
+
 		usleep_range(1000, 2000);
 		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
 		if ((ocp_data & PATCH_READY) ^ check)
@@ -9538,7 +9545,8 @@ u8 rtl8152_get_version(struct usb_interface *intf)
 
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp), 500);
+			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+			      USB_CTRL_GET_TIMEOUT);
 	if (ret > 0)
 		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
 
@@ -9798,6 +9806,10 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 out1:
 	tasklet_kill(&tp->tx_tl);
+	cancel_delayed_work_sync(&tp->hw_phy_work);
+	if (tp->rtl_ops.unload)
+		tp->rtl_ops.unload(tp);
+	rtl8152_release_firmware(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 16a6cdf02515..5f962f58ff49 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -84,7 +84,9 @@ static int __must_check __smsc95xx_read_reg(struct usbnet *dev, u32 index,
 	ret = fn(dev, USB_VENDOR_REQUEST_READ_REGISTER, USB_DIR_IN
 		 | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 0, index, &buf, 4);
-	if (ret < 0) {
+	if (ret < 4) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		if (ret != -ENODEV)
 			netdev_warn(dev->net, "Failed to read reg index 0x%08x: %d\n",
 				    index, ret);
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 08f41328cc71..73eea9d0c11b 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -485,7 +485,7 @@ static const struct ocotp_params imx6sl_params = {
 };
 
 static const struct ocotp_params imx6sll_params = {
-	.nregs = 128,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
@@ -499,14 +499,14 @@ static const struct ocotp_params imx6sx_params = {
 };
 
 static const struct ocotp_params imx6ul_params = {
-	.nregs = 128,
+	.nregs = 144,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx6ull_params = {
-	.nregs = 64,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ec17d42c2a15..5955e682c434 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -592,7 +592,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
 /*
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
- * claim it.
+ * claim it. The same applies on the VanGogh platform device ([1022:163a]).
  *
  * But the dwc3 driver is a more specific driver for this device, and we'd
  * prefer to use it instead of xhci. To prevent xhci from claiming the
@@ -600,7 +600,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
  * defines as "USB device (not host controller)". The dwc3 driver can then
  * claim it based on its Vendor and Device ID.
  */
-static void quirk_amd_nl_class(struct pci_dev *pdev)
+static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
@@ -610,7 +610,9 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
-		quirk_amd_nl_class);
+		quirk_amd_dwc_class);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VANGOGH_USB,
+		quirk_amd_dwc_class);
 
 /*
  * Synopsys USB 3.x host HAPS platform has a class code of
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index dd1c9fd733c8..ec37ad43a636 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -102,7 +102,8 @@ struct lpi_pinctrl {
 	char __iomem *tlmm_base;
 	char __iomem *slew_base;
 	struct clk_bulk_data clks[MAX_LPI_NUM_CLKS];
-	struct mutex slew_access_lock;
+	/* Protects from concurrent register updates */
+	struct mutex lock;
 	const struct lpi_pinctrl_variant_data *data;
 };
 
@@ -330,9 +331,11 @@ static int lpi_gpio_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 	if (WARN_ON(i == g->nfuncs))
 		return -EINVAL;
 
+	mutex_lock(&pctrl->lock);
 	val = lpi_gpio_read(pctrl, pin, LPI_GPIO_CFG_REG);
 	u32p_replace_bits(&val, i, LPI_GPIO_FUNCTION_MASK);
 	lpi_gpio_write(pctrl, pin, LPI_GPIO_CFG_REG, val);
+	mutex_unlock(&pctrl->lock);
 
 	return 0;
 }
@@ -438,14 +441,14 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 			if (slew_offset == NO_SLEW)
 				break;
 
-			mutex_lock(&pctrl->slew_access_lock);
+			mutex_lock(&pctrl->lock);
 
 			sval = ioread32(pctrl->slew_base + LPI_SLEW_RATE_CTL_REG);
 			sval &= ~(LPI_SLEW_RATE_MASK << slew_offset);
 			sval |= arg << slew_offset;
 			iowrite32(sval, pctrl->slew_base + LPI_SLEW_RATE_CTL_REG);
 
-			mutex_unlock(&pctrl->slew_access_lock);
+			mutex_unlock(&pctrl->lock);
 			break;
 		default:
 			return -EINVAL;
@@ -461,6 +464,7 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
 	}
 
+	mutex_lock(&pctrl->lock);
 	val = lpi_gpio_read(pctrl, group, LPI_GPIO_CFG_REG);
 
 	u32p_replace_bits(&val, pullup, LPI_GPIO_PULL_MASK);
@@ -469,6 +473,7 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 	u32p_replace_bits(&val, output_enabled, LPI_GPIO_OE_MASK);
 
 	lpi_gpio_write(pctrl, group, LPI_GPIO_CFG_REG, val);
+	mutex_unlock(&pctrl->lock);
 
 	return 0;
 }
@@ -642,7 +647,7 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
 	pctrl->chip.of_gpio_n_cells = 2;
 	pctrl->chip.can_sleep = false;
 
-	mutex_init(&pctrl->slew_access_lock);
+	mutex_init(&pctrl->lock);
 
 	pctrl->ctrl = devm_pinctrl_register(dev, &pctrl->desc, pctrl);
 	if (IS_ERR(pctrl->ctrl)) {
@@ -660,7 +665,7 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 
 err_pinctrl:
-	mutex_destroy(&pctrl->slew_access_lock);
+	mutex_destroy(&pctrl->lock);
 	clk_bulk_disable_unprepare(MAX_LPI_NUM_CLKS, pctrl->clks);
 
 	return ret;
@@ -670,7 +675,7 @@ static int lpi_pinctrl_remove(struct platform_device *pdev)
 {
 	struct lpi_pinctrl *pctrl = platform_get_drvdata(pdev);
 
-	mutex_destroy(&pctrl->slew_access_lock);
+	mutex_destroy(&pctrl->lock);
 	clk_bulk_disable_unprepare(MAX_LPI_NUM_CLKS, pctrl->clks);
 
 	return 0;
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 194f3205e559..767f4406e55f 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -588,24 +588,25 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	if (vring->cur_len + sizeof(u64) <= len) {
 		/* The whole word. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       sizeof(u64));
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       sizeof(u64));
+		} else {
+			memcpy(&data, addr + vring->cur_len,
+			       sizeof(u64));
 		}
 		vring->cur_len += sizeof(u64);
 	} else {
 		/* Leftover bytes. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       len - vring->cur_len);
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       len - vring->cur_len);
+		} else {
+			data = 0;
+			memcpy(&data, addr + vring->cur_len,
+			       len - vring->cur_len);
 		}
 		vring->cur_len = len;
 	}
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index d37fd1f431fe..35e7291aa969 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1395,6 +1395,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
@@ -1623,6 +1624,7 @@ static void qcom_glink_device_release(struct device *dev)
 
 	/* Release qcom_glink_alloc_channel() reference */
 	kref_put(&channel->refcount, qcom_glink_channel_release);
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index a71de08acc7b..8bb78c747e30 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -376,7 +376,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\
@@ -568,24 +569,52 @@ static struct bus_type rpmsg_bus = {
 	.remove		= rpmsg_dev_remove,
 };
 
-int rpmsg_register_device(struct rpmsg_device *rpdev)
+/*
+ * A helper for registering rpmsg device with driver override and name.
+ * Drivers should not be using it, but instead rpmsg_register_device().
+ */
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override)
 {
 	struct device *dev = &rpdev->dev;
 	int ret;
 
+	if (driver_override)
+		strcpy(rpdev->id.name, driver_override);
+
 	dev_set_name(&rpdev->dev, "%s.%s.%d.%d", dev_name(dev->parent),
 		     rpdev->id.name, rpdev->src, rpdev->dst);
 
 	rpdev->dev.bus = &rpmsg_bus;
 
-	ret = device_register(&rpdev->dev);
+	device_initialize(dev);
+	if (driver_override) {
+		ret = driver_set_override(dev, &rpdev->driver_override,
+					  driver_override,
+					  strlen(driver_override));
+		if (ret) {
+			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
+			return ret;
+		}
+	}
+
+	ret = device_add(dev);
 	if (ret) {
-		dev_err(dev, "device_register failed: %d\n", ret);
+		dev_err(dev, "device_add failed: %d\n", ret);
+		kfree(rpdev->driver_override);
+		rpdev->driver_override = NULL;
 		put_device(&rpdev->dev);
 	}
 
 	return ret;
 }
+EXPORT_SYMBOL(rpmsg_register_device_override);
+
+int rpmsg_register_device(struct rpmsg_device *rpdev)
+{
+	return rpmsg_register_device_override(rpdev, NULL);
+}
 EXPORT_SYMBOL(rpmsg_register_device);
 
 /*
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index a76c344253bf..7985af92aa48 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -90,10 +90,7 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
  */
 static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
 {
-	strcpy(rpdev->id.name, "rpmsg_chrdev");
-	rpdev->driver_override = "rpmsg_chrdev";
-
-	return rpmsg_register_device(rpdev);
+	return rpmsg_register_device_override(rpdev, "rpmsg_ctrl");
 }
 
 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index 762ff1ae279f..c70ad03ff2e9 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -20,12 +20,10 @@
  */
 int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
 {
-	strcpy(rpdev->id.name, "rpmsg_ns");
-	rpdev->driver_override = "rpmsg_ns";
 	rpdev->src = RPMSG_NS_ADDR;
 	rpdev->dst = RPMSG_NS_ADDR;
 
-	return rpmsg_register_device(rpdev);
+	return rpmsg_register_device_override(rpdev, "rpmsg_ns");
 }
 EXPORT_SYMBOL(rpmsg_ns_register_device);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 9eb3d0b4891d..c9f85605349b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12899,8 +12899,10 @@ _mpt3sas_init(void)
 	mpt3sas_ctl_init(hbas_to_enumerate);
 
 	error = pci_register_driver(&mpt3sas_driver);
-	if (error)
+	if (error) {
+		mpt3sas_ctl_exit(hbas_to_enumerate);
 		scsih_exit();
+	}
 
 	return error;
 }
diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index b62471ab6d7f..1edaf22e265b 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -334,8 +334,9 @@ static int npcm_fiu_uma_read(struct spi_mem *mem,
 		uma_cfg |= ilog2(op->cmd.buswidth);
 		uma_cfg |= ilog2(op->addr.buswidth)
 			<< NPCM_FIU_UMA_CFG_ADBPCK_SHIFT;
-		uma_cfg |= ilog2(op->dummy.buswidth)
-			<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
+		if (op->dummy.nbytes)
+			uma_cfg |= ilog2(op->dummy.buswidth)
+				<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
 		uma_cfg |= ilog2(op->data.buswidth)
 			<< NPCM_FIU_UMA_CFG_RDBPCK_SHIFT;
 		uma_cfg |= op->dummy.nbytes << NPCM_FIU_UMA_CFG_DBSIZ_SHIFT;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c16ed6e9e49d..2337402f95df 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3273,6 +3273,8 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 
 static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 {
+	if (dlci->gsm->dead)
+		return -EL2HLT;
 	if (dlci->adaption == 2) {
 		/* Send convergence layer type 2 empty data frame. */
 		gsm_modem_upd_via_data(dlci, brk);
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 5f0daa0d1dd0..1d842bb8d946 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2719,6 +2719,153 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init			= pci_oxsemi_tornado_init,
 		.setup		= pci_oxsemi_tornado_setup,
 	},
+	/*
+	 * Brainboxes devices - all Oxsemi based
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4027,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4028,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4029,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4019,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4016,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4015,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400A,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400E,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400C,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400B,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400F,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4010,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4011,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x401D,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x401E,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4013,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4017,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4018,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8811,
@@ -5340,6 +5487,12 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b1_bt_1_115200 },
 
+	/*
+	 * IntaShield IS-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D60,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
 	/*
 	 * IntaShield IS-200
 	 */
@@ -5352,6 +5505,27 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
+	/*
+	 * IntaShield IX-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4027,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * IntaShield IX-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4028,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * IntaShield IX-400
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4029,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
 	/* Brainboxes Devices */
 	/*
 	* Brainboxes UC-101
@@ -5367,10 +5541,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
 	/*
-	 * Brainboxes UC-257
+	 * Brainboxes UC-253/UC-734
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0CA1,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
@@ -5406,6 +5584,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-310
 	 */
@@ -5416,6 +5602,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-313
 	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5430,6 +5624,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-346
 	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5441,6 +5639,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A82,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5453,12 +5655,94 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
-	 * Brainboxes UC-420/431
+	 * Brainboxes UC-420
 	 */
 	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-607
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-836
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UP-189
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-869
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C02,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C03,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-880
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes PX-101
 	 */
@@ -5491,7 +5775,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4015,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_4_15625000 },
+		pbn_oxsemi_2_15625000 },
 	/*
 	 * Brainboxes PX-260/PX-701
 	 */
@@ -5499,6 +5783,13 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_oxsemi_4_15625000 },
+	/*
+	 * Brainboxes PX-275/279
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0E41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_8_115200 },
 	/*
 	 * Brainboxes PX-310
 	 */
@@ -5546,16 +5837,38 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_oxsemi_4_15625000 },
 	/*
-	 * Brainboxes PX-803
+	 * Brainboxes PX-475
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x401D,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes PX-803/PX-857
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4009,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_b0_1_115200 },
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4018,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x401E,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_1_15625000 },
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-820
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4002,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4013,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
 	/*
 	 * Brainboxes PX-846
 	 */
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 9d13f2274398..e65aec99f894 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -663,12 +663,12 @@ static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 	if (WARN_ON(in && dev->ep0_out_pending)) {
 		ret = -ENODEV;
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_unlock;
 	}
 	if (WARN_ON(!in && dev->ep0_in_pending)) {
 		ret = -ENODEV;
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_unlock;
 	}
 
 	dev->req->buf = data;
@@ -683,7 +683,7 @@ static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 				"fail, usb_ep_queue returned %d\n", ret);
 		spin_lock_irqsave(&dev->lock, flags);
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_queue_failed;
 	}
 
 	ret = wait_for_completion_interruptible(&dev->ep0_done);
@@ -692,13 +692,16 @@ static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 		usb_ep_dequeue(dev->gadget->ep0, dev->req);
 		wait_for_completion(&dev->ep0_done);
 		spin_lock_irqsave(&dev->lock, flags);
-		goto out_done;
+		if (dev->ep0_status == -ECONNRESET)
+			dev->ep0_status = -EINTR;
+		goto out_interrupted;
 	}
 
 	spin_lock_irqsave(&dev->lock, flags);
-	ret = dev->ep0_status;
 
-out_done:
+out_interrupted:
+	ret = dev->ep0_status;
+out_queue_failed:
 	dev->ep0_urb_queued = false;
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -1060,7 +1063,7 @@ static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 				"fail, usb_ep_queue returned %d\n", ret);
 		spin_lock_irqsave(&dev->lock, flags);
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_queue_failed;
 	}
 
 	ret = wait_for_completion_interruptible(&done);
@@ -1069,13 +1072,16 @@ static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 		usb_ep_dequeue(ep->ep, ep->req);
 		wait_for_completion(&done);
 		spin_lock_irqsave(&dev->lock, flags);
-		goto out_done;
+		if (ep->status == -ECONNRESET)
+			ep->status = -EINTR;
+		goto out_interrupted;
 	}
 
 	spin_lock_irqsave(&dev->lock, flags);
-	ret = ep->status;
 
-out_done:
+out_interrupted:
+	ret = ep->status;
+out_queue_failed:
 	ep->urb_queued = false;
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
diff --git a/drivers/usb/storage/unusual_cypress.h b/drivers/usb/storage/unusual_cypress.h
index 0547daf116a2..5df40759d77a 100644
--- a/drivers/usb/storage/unusual_cypress.h
+++ b/drivers/usb/storage/unusual_cypress.h
@@ -19,7 +19,7 @@ UNUSUAL_DEV(  0x04b4, 0x6831, 0x0000, 0x9999,
 		"Cypress ISD-300LP",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
 
-UNUSUAL_DEV( 0x14cd, 0x6116, 0x0160, 0x0160,
+UNUSUAL_DEV( 0x14cd, 0x6116, 0x0150, 0x0160,
 		"Super Top",
 		"USB 2.0  SATA BRIDGE",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 7833518c6038..d917b133d2a5 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1608,6 +1608,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (PD_VDO_VID(p[0]) != USB_SID_PD)
 				break;
 
+			if (IS_ERR_OR_NULL(port->partner))
+				break;
+
 			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
 				typec_partner_set_svdm_version(port->partner,
 							       PD_VDO_SVDM_VER(p[0]));
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 047fa2faef56..bc14f1245a65 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1171,9 +1171,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 		goto done;
 	}
 
-	if ((msg.type == VHOST_IOTLB_UPDATE ||
-	     msg.type == VHOST_IOTLB_INVALIDATE) &&
-	     msg.size == 0) {
+	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
 		ret = -EINVAL;
 		goto done;
 	}
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 1aef3d6ebd88..246bf67b32ea 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3447,11 +3447,15 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	}
 
 	info->fix.mmio_start = raddr;
+#if defined(__i386__) || defined(__ia64__)
 	/*
 	 * By using strong UC we force the MTRR to never have an
 	 * effect on the MMIO region on both non-PAT and PAT systems.
 	 */
 	par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
+#else
+	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+#endif
 	if (par->ati_regbase == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 1f3b7e013568..3a285af76f7e 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1935,10 +1935,10 @@ static void uvesafb_exit(void)
 		}
 	}
 
-	cn_del_callback(&uvesafb_cn_id);
 	driver_remove_file(&uvesafb_driver.driver, &driver_attr_v86d);
 	platform_device_unregister(uvesafb_device);
 	platform_driver_unregister(&uvesafb_driver);
+	cn_del_callback(&uvesafb_cn_id);
 }
 
 module_exit(uvesafb_exit);
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c22ff0117b46..0f3c22cee4e7 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -402,7 +402,11 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	virtio_cread_le(vb->vdev, struct virtio_balloon_config, num_pages,
 			&num_pages);
 
-	target = num_pages;
+	/*
+	 * Aligned up to guest page size to avoid inflating and deflating
+	 * balloon endlessly.
+	 */
+	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
 	return target - vb->num_pages;
 }
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index f4d43d60d710..17908c37751a 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -596,14 +596,17 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	spin_lock_init(&vm_dev->lock);
 
 	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(vm_dev->base))
-		return PTR_ERR(vm_dev->base);
+	if (IS_ERR(vm_dev->base)) {
+		rc = PTR_ERR(vm_dev->base);
+		goto free_vm_dev;
+	}
 
 	/* Check magic value */
 	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 
 	/* Check device version */
@@ -611,7 +614,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	if (vm_dev->version < 1 || vm_dev->version > 2) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto free_vm_dev;
 	}
 
 	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
@@ -620,7 +624,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
 		 * with no function. End probing now with no error reported.
 		 */
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
@@ -650,6 +655,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		put_device(&vm_dev->vdev.dev);
 
 	return rc;
+
+free_vm_dev:
+	kfree(vm_dev);
+	return rc;
 }
 
 static int virtio_mmio_remove(struct platform_device *pdev)
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e5b81d8be232..f3dc84ff0efa 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4049,8 +4049,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
-	ext4_lblk_t end;
-	loff_t size, start_off;
+	loff_t size, start_off, end;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
@@ -4079,7 +4078,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
 	/* first, let's learn actual file size
 	 * given current request is allocated */
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	size = size << bsbits;
 	if (size < i_size_read(ac->ac_inode))
 		size = i_size_read(ac->ac_inode);
@@ -4158,7 +4157,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	/* check we don't cross already preallocated blocks */
 	rcu_read_lock();
 	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
-		ext4_lblk_t pa_end;
+		loff_t pa_end;
 
 		if (pa->pa_deleted)
 			continue;
@@ -4168,8 +4167,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 			continue;
 		}
 
-		pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
-						  pa->pa_len);
+		pa_end = pa_logical_end(EXT4_SB(ac->ac_sb), pa);
 
 		/* PA must not overlap original request */
 		BUG_ON(!(ac->ac_o_ex.fe_logical >= pa_end ||
@@ -4198,12 +4196,11 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	/* XXX: extra loop to check we really don't overlap preallocations */
 	rcu_read_lock();
 	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
-		ext4_lblk_t pa_end;
+		loff_t pa_end;
 
 		spin_lock(&pa->pa_lock);
 		if (pa->pa_deleted == 0) {
-			pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
-							  pa->pa_len);
+			pa_end = pa_logical_end(EXT4_SB(ac->ac_sb), pa);
 			BUG_ON(!(start >= pa_end || end <= pa->pa_lstart));
 		}
 		spin_unlock(&pa->pa_lock);
@@ -4419,8 +4416,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
 		if (ac->ac_o_ex.fe_logical < pa->pa_lstart ||
-		    ac->ac_o_ex.fe_logical >= (pa->pa_lstart +
-					       EXT4_C2B(sbi, pa->pa_len)))
+		    ac->ac_o_ex.fe_logical >= pa_logical_end(sbi, pa))
 			continue;
 
 		/* non-extent files can't have physical blocks past 2^32 */
@@ -4665,8 +4661,11 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa = ac->ac_pa;
 
 	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
-		int new_bex_start;
-		int new_bex_end;
+		struct ext4_free_extent ex = {
+			.fe_logical = ac->ac_g_ex.fe_logical,
+			.fe_len = ac->ac_g_ex.fe_len,
+		};
+		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
 
 		/* we can't allocate as much as normalizer wants.
 		 * so, found space must get proper lstart
@@ -4685,29 +4684,23 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 *    still cover original start
 		 * 3. Else, keep the best ex at start of original request.
 		 */
-		new_bex_end = ac->ac_g_ex.fe_logical +
-			EXT4_C2B(sbi, ac->ac_g_ex.fe_len);
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
-				      EXT4_C2B(sbi, ac->ac_g_ex.fe_len)));
+		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
 	}
 
 	/* preallocation can change ac_b_ex, thus we store actually
@@ -5241,7 +5234,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 
 	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
 	inode_pa_eligible = true;
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
 		>> bsbits;
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 39da92ceabf8..bf048cbf3986 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -219,6 +219,20 @@ static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
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
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 15a86876e3d9..c39b8a653804 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1762,6 +1762,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
+	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
+		goto out;
+	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
+		goto out;
+
 retry:
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
@@ -1796,12 +1802,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ndentry == trap)
 		goto out_dput_new;
 
-	host_err = -EXDEV;
-	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
-	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
-
 	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
 	    nfsd_has_cached_files(ndentry)) {
 		close_cached = true;
diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 321d55b3ca17..1d5ac2164d94 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1583,10 +1583,8 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			le_b = NULL;
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
-			if (!attr_b) {
-				err = -ENOENT;
-				goto out;
-			}
+			if (!attr_b)
+				return -ENOENT;
 
 			attr = attr_b;
 			le = le_b;
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 81c22df27c72..0c6a68e71e7d 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -52,7 +52,8 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 
 	if (!attr->non_res) {
 		lsize = le32_to_cpu(attr->res.data_size);
-		le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
+		/* attr is resident: lsize < record_size (1K or 4K) */
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
@@ -80,7 +81,17 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 		if (err < 0)
 			goto out;
 
-		le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
+		/* attr is nonresident.
+		 * The worst case:
+		 * 1T (2^40) extremely fragmented file.
+		 * cluster = 4K (2^12) => 2^28 fragments
+		 * 2^9 fragments per one record => 2^19 records
+		 * 2^5 bytes of ATTR_LIST_ENTRY per one record => 2^24 bytes.
+		 *
+		 * the result is 16M bytes per attribute list.
+		 * Use kvmalloc to allocate in range [several Kbytes - dozen Mbytes]
+		 */
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 3261b69cdac3..21536b72aa5e 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -667,7 +667,8 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 		wnd->bits_last = wbits;
 
 	wnd->free_bits =
-		kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
+		kvmalloc_array(wnd->nwnd, sizeof(u16), GFP_KERNEL | __GFP_ZERO);
+
 	if (!wnd->free_bits)
 		return -ENOMEM;
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index fb438d604040..d4d9f4ffb6d9 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -309,7 +309,11 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		return 0;
 	}
 
-	dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+	/* NTFS: symlinks are "dir + reparse" or "file + reparse" */
+	if (fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT)
+		dt_type = DT_LNK;
+	else
+		dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
 
 	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
 }
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 9a1744955d1c..b02778cbb1d3 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2100,7 +2100,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
-		if (i == idx)
+		if (i == idx || !pg)
 			continue;
 		unlock_page(pg);
 		put_page(pg);
@@ -3144,6 +3144,12 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 		if (!fname || !memcmp(&fname->dup, dup, sizeof(fname->dup)))
 			continue;
 
+		/* Check simple case when parent inode equals current inode. */
+		if (ino_get(&fname->home) == ni->vfs_inode.i_ino) {
+			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+			continue;
+		}
+
 		/* ntfs_iget5 may sleep. */
 		dir = ntfs_iget5(sb, &fname->home, NULL);
 		if (IS_ERR(dir)) {
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 59f813cbdaa8..8b95c06e5a4c 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2169,8 +2169,10 @@ static int last_log_lsn(struct ntfs_log *log)
 
 			if (!page) {
 				page = kmalloc(log->page_size, GFP_NOFS);
-				if (!page)
-					return -ENOMEM;
+				if (!page) {
+					err = -ENOMEM;
+					goto out;
+				}
 			}
 
 			/*
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 11de2d469e9e..4413f6da68e6 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -958,18 +958,11 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 	if (err)
 		return err;
 
-	mark_inode_dirty(&ni->vfs_inode);
+	mark_inode_dirty_sync(&ni->vfs_inode);
 	/* verify(!ntfs_update_mftmirr()); */
 
-	/*
-	 * If we used wait=1, sync_inode_metadata waits for the io for the
-	 * inode to finish. It hangs when media is removed.
-	 * So wait=0 is sent down to sync_inode_metadata
-	 * and filemap_fdatawrite is used for the data blocks.
-	 */
-	err = sync_inode_metadata(&ni->vfs_inode, 0);
-	if (!err)
-		err = filemap_fdatawrite(ni->vfs_inode.i_mapping);
+	/* write mft record on disk. */
+	err = _ni_write_inode(&ni->vfs_inode, 1);
 
 	return err;
 }
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 33b1833ad525..fbaf1c84311b 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1136,7 +1136,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto put_inode_out;
 	}
 	bytes = inode->i_size;
-	sbi->def_table = t = kmalloc(bytes, GFP_NOFS | __GFP_NOWARN);
+	sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL);
 	if (!t) {
 		err = -ENOMEM;
 		goto put_inode_out;
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index a498ebcf4993..abf948e102f5 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -150,6 +150,8 @@ extern int __must_check driver_create_file(struct device_driver *driver,
 extern void driver_remove_file(struct device_driver *driver,
 			       const struct driver_attribute *attr);
 
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len);
 extern int __must_check driver_for_each_device(struct device_driver *drv,
 					       struct device *start,
 					       void *data,
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
new file mode 100644
index 000000000000..6eecb435488f
--- /dev/null
+++ b/include/linux/iio/afe/rescale.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2018 Axentia Technologies AB
+ */
+
+#ifndef __IIO_RESCALE_H__
+#define __IIO_RESCALE_H__
+
+#include <linux/types.h>
+#include <linux/iio/iio.h>
+
+struct device;
+struct rescale;
+
+struct rescale_cfg {
+	enum iio_chan_type type;
+	int (*props)(struct device *dev, struct rescale *rescale);
+};
+
+struct rescale {
+	const struct rescale_cfg *cfg;
+	struct iio_channel *source;
+	struct iio_chan_spec chan;
+	struct iio_chan_spec_ext_info *ext_info;
+	bool chan_processed;
+	s32 numerator;
+	s32 denominator;
+	s32 offset;
+};
+
+int rescale_process_scale(struct rescale *rescale, int scale_type,
+			  int *val, int *val2);
+int rescale_process_offset(struct rescale *rescale, int scale_type,
+			   int scale, int scale2, int schan_off,
+			   int *val, int *val2);
+#endif /* __IIO_RESCALE_H__ */
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index f407e937241a..00cbe31c8748 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -471,10 +471,10 @@ static inline void kasan_free_shadow(const struct vm_struct *vm) {}
 
 #endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
-#ifdef CONFIG_KASAN_INLINE
+#ifdef CONFIG_KASAN
 void kasan_non_canonical_hook(unsigned long addr);
-#else /* CONFIG_KASAN_INLINE */
+#else /* CONFIG_KASAN */
 static inline void kasan_non_canonical_hook(unsigned long addr) { }
-#endif /* CONFIG_KASAN_INLINE */
+#endif /* CONFIG_KASAN */
 
 #endif /* LINUX_KASAN_H */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 8a1e26473566..d2d5e854c692 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -556,6 +556,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 8aefdc0099c8..72cf70857b85 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -31,7 +31,11 @@ struct platform_device {
 	struct resource	*resource;
 
 	const struct platform_device_id	*id_entry;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	/* MFD cell pointer */
 	struct mfd_cell *mfd_cell;
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index a8dcf8a9ae88..a63c5a4ff3e1 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -41,7 +41,9 @@ struct rpmsg_channel_info {
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @src: local address
  * @dst: destination address
  * @ept: the rpmsg endpoint of this channel
@@ -51,7 +53,7 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
-	char *driver_override;
+	const char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
@@ -163,6 +165,8 @@ static inline __rpmsg64 cpu_to_rpmsg64(struct rpmsg_device *rpdev, u64 val)
 
 #if IS_ENABLED(CONFIG_RPMSG)
 
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override);
 int rpmsg_register_device(struct rpmsg_device *rpdev);
 int rpmsg_unregister_device(struct device *parent,
 			    struct rpmsg_channel_info *chinfo);
@@ -188,6 +192,12 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
 #else
 
+static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+						 const char *driver_override)
+{
+	return -ENXIO;
+}
+
 static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
 {
 	return -ENXIO;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e93a48edf438..3aee02ad0116 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -314,7 +314,7 @@ void tcp_shutdown(struct sock *sk, int how);
 int tcp_v4_early_demux(struct sk_buff *skb);
 int tcp_v4_rcv(struct sk_buff *skb);
 
-void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb);
+void tcp_remove_empty_skb(struct sock *sk);
 int tcp_v4_tw_remember_stamp(struct inet_timewait_sock *tw);
 int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
index 590f8aea2b6d..439c982f7e81 100644
--- a/include/uapi/linux/can/isotp.h
+++ b/include/uapi/linux/can/isotp.h
@@ -124,18 +124,19 @@ struct can_isotp_ll_options {
 
 /* flags for isotp behaviour */
 
-#define CAN_ISOTP_LISTEN_MODE	0x001	/* listen only (do not send FC) */
-#define CAN_ISOTP_EXTEND_ADDR	0x002	/* enable extended addressing */
-#define CAN_ISOTP_TX_PADDING	0x004	/* enable CAN frame padding tx path */
-#define CAN_ISOTP_RX_PADDING	0x008	/* enable CAN frame padding rx path */
-#define CAN_ISOTP_CHK_PAD_LEN	0x010	/* check received CAN frame padding */
-#define CAN_ISOTP_CHK_PAD_DATA	0x020	/* check received CAN frame padding */
-#define CAN_ISOTP_HALF_DUPLEX	0x040	/* half duplex error state handling */
-#define CAN_ISOTP_FORCE_TXSTMIN	0x080	/* ignore stmin from received FC */
-#define CAN_ISOTP_FORCE_RXSTMIN	0x100	/* ignore CFs depending on rx stmin */
-#define CAN_ISOTP_RX_EXT_ADDR	0x200	/* different rx extended addressing */
-#define CAN_ISOTP_WAIT_TX_DONE	0x400	/* wait for tx completion */
-#define CAN_ISOTP_SF_BROADCAST	0x800	/* 1-to-N functional addressing */
+#define CAN_ISOTP_LISTEN_MODE	0x0001	/* listen only (do not send FC) */
+#define CAN_ISOTP_EXTEND_ADDR	0x0002	/* enable extended addressing */
+#define CAN_ISOTP_TX_PADDING	0x0004	/* enable CAN frame padding tx path */
+#define CAN_ISOTP_RX_PADDING	0x0008	/* enable CAN frame padding rx path */
+#define CAN_ISOTP_CHK_PAD_LEN	0x0010	/* check received CAN frame padding */
+#define CAN_ISOTP_CHK_PAD_DATA	0x0020	/* check received CAN frame padding */
+#define CAN_ISOTP_HALF_DUPLEX	0x0040	/* half duplex error state handling */
+#define CAN_ISOTP_FORCE_TXSTMIN	0x0080	/* ignore stmin from received FC */
+#define CAN_ISOTP_FORCE_RXSTMIN	0x0100	/* ignore CFs depending on rx stmin */
+#define CAN_ISOTP_RX_EXT_ADDR	0x0200	/* different rx extended addressing */
+#define CAN_ISOTP_WAIT_TX_DONE	0x0400	/* wait for tx completion */
+#define CAN_ISOTP_SF_BROADCAST	0x0800	/* 1-to-N functional addressing */
+#define CAN_ISOTP_CF_BROADCAST	0x1000	/* 1-to-N transmission w/o FC */
 
 /* protocol machine default values */
 
diff --git a/include/uapi/linux/gtp.h b/include/uapi/linux/gtp.h
index 79f9191bbb24..82d0e58ec3ce 100644
--- a/include/uapi/linux/gtp.h
+++ b/include/uapi/linux/gtp.h
@@ -32,6 +32,6 @@ enum gtp_attrs {
 	GTPA_PAD,
 	__GTPA_MAX,
 };
-#define GTPA_MAX (__GTPA_MAX + 1)
+#define GTPA_MAX (__GTPA_MAX - 1)
 
 #endif /* _UAPI_LINUX_GTP_H_ */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1732f6548bc6..8e1290340aaf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13277,7 +13277,8 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e755e09805ab..a015ed3f823b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -945,7 +945,7 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
  * @name: The name of the kprobe event
  * @loc: The location of the kprobe event
  * @kretprobe: Is this a return probe?
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
@@ -1018,7 +1018,7 @@ EXPORT_SYMBOL_GPL(__kprobe_event_gen_cmd_start);
 /**
  * __kprobe_event_add_fields - Add probe fields to a kprobe command from arg list
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the kprobe_event_add_fields() wrapper, which
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 887af873733b..1c929d964dde 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -457,9 +457,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
-#ifdef CONFIG_KASAN_INLINE
 /*
- * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
+ * With CONFIG_KASAN, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
  * before the actual access. For addresses in the low canonical half of the
  * address space, as well as most non-canonical addresses, that out-of-bounds
@@ -495,4 +494,3 @@ void kasan_non_canonical_hook(unsigned long addr)
 	pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
 		 orig_addr, orig_addr + KASAN_GRANULE_SIZE - 1);
 }
-#endif
diff --git a/mm/migrate.c b/mm/migrate.c
index dd50b1cc089e..c7d5566623ad 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1788,6 +1788,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			 const int __user *nodes,
 			 int __user *status, int flags)
 {
+	compat_uptr_t __user *compat_pages = (void __user *)pages;
 	int current_node = NUMA_NO_NODE;
 	LIST_HEAD(pagelist);
 	int start, i;
@@ -1801,8 +1802,17 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		int node;
 
 		err = -EFAULT;
-		if (get_user(p, pages + i))
-			goto out_flush;
+		if (in_compat_syscall()) {
+			compat_uptr_t cp;
+
+			if (get_user(cp, compat_pages + i))
+				goto out_flush;
+
+			p = compat_ptr(cp);
+		} else {
+			if (get_user(p, pages + i))
+				goto out_flush;
+		}
 		if (get_user(node, nodes + i))
 			goto out_flush;
 		addr = (unsigned long)untagged_addr(p);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f320ee2bd34a..ec3333a1f7fe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9481,6 +9481,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			next_page = page;
 			current_buddy = page + size;
 		}
+		page = next_page;
 
 		if (set_page_guard(zone, current_buddy, high, migratetype))
 			continue;
@@ -9488,7 +9489,6 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 		if (current_buddy != target) {
 			add_to_free_list(current_buddy, zone, high, migratetype);
 			set_buddy_order(current_buddy, high);
-			page = next_page;
 		}
 	}
 }
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 4dccf7b4b88d..7f62628c6ddd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -14,7 +14,6 @@
  * - use CAN_ISOTP_WAIT_TX_DONE flag to block the caller until the PDU is sent
  * - as we have static buffers the check whether the PDU fits into the buffer
  *   is done at FF reception time (no support for sending 'wait frames')
- * - take care of the tx-queue-len as traffic shaping is still on the TODO list
  *
  * Copyright (c) 2020 Volkswagen Group Electronic Research
  * All rights reserved.
@@ -87,9 +86,9 @@ MODULE_ALIAS("can-proto-6");
 /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
  * take full 32 bit values (4 Gbyte). We would need some good concept to handle
  * this between user space and kernel space. For now increase the static buffer
- * to something about 8 kbyte to be able to test this new functionality.
+ * to something about 64 kbyte to be able to test this new functionality.
  */
-#define MAX_MSG_LENGTH 8200
+#define MAX_MSG_LENGTH 66000
 
 /* N_PCI type values in bits 7-4 of N_PCI bytes */
 #define N_PCI_SF 0x00	/* single frame */
@@ -105,18 +104,23 @@ MODULE_ALIAS("can-proto-6");
 #define FC_CONTENT_SZ 3	/* flow control content size in byte (FS/BS/STmin) */
 
 #define ISOTP_CHECK_PADDING (CAN_ISOTP_CHK_PAD_LEN | CAN_ISOTP_CHK_PAD_DATA)
+#define ISOTP_ALL_BC_FLAGS (CAN_ISOTP_SF_BROADCAST | CAN_ISOTP_CF_BROADCAST)
 
 /* Flow Status given in FC frame */
 #define ISOTP_FC_CTS 0		/* clear to send */
 #define ISOTP_FC_WT 1		/* wait */
 #define ISOTP_FC_OVFLW 2	/* overflow */
 
+#define ISOTP_FC_TIMEOUT 1	/* 1 sec */
+#define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
+
 enum {
 	ISOTP_IDLE = 0,
 	ISOTP_WAIT_FIRST_FC,
 	ISOTP_WAIT_FC,
 	ISOTP_WAIT_DATA,
-	ISOTP_SENDING
+	ISOTP_SENDING,
+	ISOTP_SHUTDOWN,
 };
 
 struct tpcon {
@@ -137,13 +141,14 @@ struct isotp_sock {
 	canid_t rxid;
 	ktime_t tx_gap;
 	ktime_t lastrxcf_tstamp;
-	struct hrtimer rxtimer, txtimer;
+	struct hrtimer rxtimer, txtimer, txfrtimer;
 	struct can_isotp_options opt;
 	struct can_isotp_fc_options rxfc, txfc;
 	struct can_isotp_ll_options ll;
 	u32 frame_txtime;
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
+	u32 cfecho; /* consecutive frame echo tag */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
@@ -159,6 +164,17 @@ static inline struct isotp_sock *isotp_sk(const struct sock *sk)
 	return (struct isotp_sock *)sk;
 }
 
+static u32 isotp_bc_flags(struct isotp_sock *so)
+{
+	return so->opt.flags & ISOTP_ALL_BC_FLAGS;
+}
+
+static bool isotp_register_rxid(struct isotp_sock *so)
+{
+	/* no broadcast modes => register rx_id for FC frame reception */
+	return (isotp_bc_flags(so) == 0);
+}
+
 static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
@@ -240,7 +256,8 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	so->lastrxcf_tstamp = ktime_set(0, 0);
 
 	/* start rx timeout watchdog */
-	hrtimer_start(&so->rxtimer, ktime_set(1, 0), HRTIMER_MODE_REL_SOFT);
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
 	return 0;
 }
 
@@ -326,6 +343,8 @@ static int check_pad(struct isotp_sock *so, struct canfd_frame *cf,
 	return 0;
 }
 
+static void isotp_send_cframe(struct isotp_sock *so);
+
 static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 {
 	struct sock *sk = &so->sk;
@@ -380,14 +399,15 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 	case ISOTP_FC_CTS:
 		so->tx.bs = 0;
 		so->tx.state = ISOTP_SENDING;
-		/* start cyclic timer for sending CF frame */
-		hrtimer_start(&so->txtimer, so->tx_gap,
+		/* send CF frame and enable echo timeout handling */
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
+		isotp_send_cframe(so);
 		break;
 
 	case ISOTP_FC_WT:
 		/* start timer to wait for next FC frame */
-		hrtimer_start(&so->txtimer, ktime_set(1, 0),
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		break;
 
@@ -582,7 +602,7 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	/* perform blocksize handling, if enabled */
 	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
 		/* start rx timeout watchdog */
-		hrtimer_start(&so->rxtimer, ktime_set(1, 0),
+		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		return 0;
 	}
@@ -713,6 +733,63 @@ static void isotp_fill_dataframe(struct canfd_frame *cf, struct isotp_sock *so,
 		cf->data[0] = so->opt.ext_address;
 }
 
+static void isotp_send_cframe(struct isotp_sock *so)
+{
+	struct sock *sk = &so->sk;
+	struct sk_buff *skb;
+	struct net_device *dev;
+	struct canfd_frame *cf;
+	int can_send_ret;
+	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+
+	dev = dev_get_by_index(sock_net(sk), so->ifindex);
+	if (!dev)
+		return;
+
+	skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	if (!skb) {
+		dev_put(dev);
+		return;
+	}
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
+
+	cf = (struct canfd_frame *)skb->data;
+	skb_put_zero(skb, so->ll.mtu);
+
+	/* create consecutive frame */
+	isotp_fill_dataframe(cf, so, ae, 0);
+
+	/* place consecutive frame N_PCI in appropriate index */
+	cf->data[ae] = N_PCI_CF | so->tx.sn++;
+	so->tx.sn %= 16;
+	so->tx.bs++;
+
+	cf->flags = so->ll.tx_flags;
+
+	skb->dev = dev;
+	can_skb_set_owner(skb, sk);
+
+	/* cfecho should have been zero'ed by init/isotp_rcv_echo() */
+	if (so->cfecho)
+		pr_notice_once("can-isotp: cfecho is %08X != 0\n", so->cfecho);
+
+	/* set consecutive frame echo tag */
+	so->cfecho = *(u32 *)cf->data;
+
+	/* send frame with local echo enabled */
+	can_send_ret = can_send(skb, 1);
+	if (can_send_ret) {
+		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
+			       __func__, ERR_PTR(can_send_ret));
+		if (can_send_ret == -ENOBUFS)
+			pr_notice_once("can-isotp: tx queue is full\n");
+	}
+	dev_put(dev);
+}
+
 static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 				int ae)
 {
@@ -746,145 +823,120 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 		cf->data[i] = so->tx.buf[so->tx.idx++];
 
 	so->tx.sn = 1;
-	so->tx.state = ISOTP_WAIT_FIRST_FC;
 }
 
-static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
-	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
-					     txtimer);
-	struct sock *sk = &so->sk;
-	struct sk_buff *skb;
-	struct net_device *dev;
-	struct canfd_frame *cf;
-	enum hrtimer_restart restart = HRTIMER_NORESTART;
-	int can_send_ret;
-	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+	struct sock *sk = (struct sock *)data;
+	struct isotp_sock *so = isotp_sk(sk);
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
-	switch (so->tx.state) {
-	case ISOTP_WAIT_FC:
-	case ISOTP_WAIT_FIRST_FC:
+	/* only handle my own local echo CF/SF skb's (no FF!) */
+	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
+		return;
 
-		/* we did not get any flow control frame in time */
+	/* cancel local echo timeout */
+	hrtimer_cancel(&so->txtimer);
 
-		/* report 'communication error on send' */
-		sk->sk_err = ECOMM;
-		if (!sock_flag(sk, SOCK_DEAD))
-			sk_error_report(sk);
+	/* local echo skb with consecutive frame has been consumed */
+	so->cfecho = 0;
 
-		/* reset tx state */
+	if (so->tx.idx >= so->tx.len) {
+		/* we are done */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
-		break;
-
-	case ISOTP_SENDING:
-
-		/* push out the next segmented pdu */
-		dev = dev_get_by_index(sock_net(sk), so->ifindex);
-		if (!dev)
-			break;
+		return;
+	}
 
-isotp_tx_burst:
-		skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv),
-				GFP_ATOMIC);
-		if (!skb) {
-			dev_put(dev);
-			break;
-		}
+	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
+		/* stop and wait for FC with timeout */
+		so->tx.state = ISOTP_WAIT_FC;
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		return;
+	}
 
-		can_skb_reserve(skb);
-		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
+	/* no gap between data frames needed => use burst mode */
+	if (!so->tx_gap) {
+		/* enable echo timeout handling */
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		isotp_send_cframe(so);
+		return;
+	}
 
-		cf = (struct canfd_frame *)skb->data;
-		skb_put_zero(skb, so->ll.mtu);
+	/* start timer to send next consecutive frame with correct delay */
+	hrtimer_start(&so->txfrtimer, so->tx_gap, HRTIMER_MODE_REL_SOFT);
+}
 
-		/* create consecutive frame */
-		isotp_fill_dataframe(cf, so, ae, 0);
+static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txtimer);
+	struct sock *sk = &so->sk;
 
-		/* place consecutive frame N_PCI in appropriate index */
-		cf->data[ae] = N_PCI_CF | so->tx.sn++;
-		so->tx.sn %= 16;
-		so->tx.bs++;
+	/* don't handle timeouts in IDLE or SHUTDOWN state */
+	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
+		return HRTIMER_NORESTART;
 
-		cf->flags = so->ll.tx_flags;
+	/* we did not get any flow control or echo frame in time */
 
-		skb->dev = dev;
-		can_skb_set_owner(skb, sk);
+	/* report 'communication error on send' */
+	sk->sk_err = ECOMM;
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk_error_report(sk);
 
-		can_send_ret = can_send(skb, 1);
-		if (can_send_ret) {
-			pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
-				       __func__, ERR_PTR(can_send_ret));
-			if (can_send_ret == -ENOBUFS)
-				pr_notice_once("can-isotp: tx queue is full, increasing txqueuelen may prevent this error\n");
-		}
-		if (so->tx.idx >= so->tx.len) {
-			/* we are done */
-			so->tx.state = ISOTP_IDLE;
-			dev_put(dev);
-			wake_up_interruptible(&so->wait);
-			break;
-		}
+	/* reset tx state */
+	so->tx.state = ISOTP_IDLE;
+	wake_up_interruptible(&so->wait);
 
-		if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
-			/* stop and wait for FC */
-			so->tx.state = ISOTP_WAIT_FC;
-			dev_put(dev);
-			hrtimer_set_expires(&so->txtimer,
-					    ktime_add(ktime_get(),
-						      ktime_set(1, 0)));
-			restart = HRTIMER_RESTART;
-			break;
-		}
+	return HRTIMER_NORESTART;
+}
 
-		/* no gap between data frames needed => use burst mode */
-		if (!so->tx_gap)
-			goto isotp_tx_burst;
+static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txfrtimer);
 
-		/* start timer to send next data frame with correct delay */
-		dev_put(dev);
-		hrtimer_set_expires(&so->txtimer,
-				    ktime_add(ktime_get(), so->tx_gap));
-		restart = HRTIMER_RESTART;
-		break;
+	/* start echo timeout handling and cover below protocol error */
+	hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
 
-	default:
-		WARN_ON_ONCE(1);
-	}
+	/* cfecho should be consumed by isotp_rcv_echo() here */
+	if (so->tx.state == ISOTP_SENDING && !so->cfecho)
+		isotp_send_cframe(so);
 
-	return restart;
+	return HRTIMER_NORESTART;
 }
 
 static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
-	u32 old_state = so->tx.state;
 	struct sk_buff *skb;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
-	s64 hrtimer_sec = 0;
+	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	int off;
 	int err;
 
-	if (!so->bound)
+	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-	/* we do not support multiple buffers - for now */
-	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE ||
-	    wq_has_sleeper(&so->wait)) {
-		if (msg->msg_flags & MSG_DONTWAIT) {
-			err = -EAGAIN;
-			goto err_out;
-		}
+	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+		/* we do not support multiple buffers - for now */
+		if (msg->msg_flags & MSG_DONTWAIT)
+			return -EAGAIN;
+
+		if (so->tx.state == ISOTP_SHUTDOWN)
+			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 		if (err)
-			goto err_out;
+			goto err_event_drop;
 	}
 
 	if (!size || size > MAX_MSG_LENGTH) {
@@ -896,7 +948,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	off = (so->tx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
 
 	/* does the given data fit into a single frame for SF_BROADCAST? */
-	if ((so->opt.flags & CAN_ISOTP_SF_BROADCAST) &&
+	if ((isotp_bc_flags(so) == CAN_ISOTP_SF_BROADCAST) &&
 	    (size > so->tx.ll_dl - SF_PCI_SZ4 - ae - off)) {
 		err = -EINVAL;
 		goto err_out_drop;
@@ -929,6 +981,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
+	/* cfecho should have been zero'ed by init / former isotp_rcv_echo() */
+	if (so->cfecho)
+		pr_notice_once("can-isotp: uninit cfecho %08X\n", so->cfecho);
+
 	/* check for single frame transmission depending on TX_DL */
 	if (size <= so->tx.ll_dl - SF_PCI_SZ4 - ae - off) {
 		/* The message size generally fits into a SingleFrame - good.
@@ -954,22 +1010,40 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		else
 			cf->data[ae] |= size;
 
-		so->tx.state = ISOTP_IDLE;
-		wake_up_interruptible(&so->wait);
-
-		/* don't enable wait queue for a single frame transmission */
-		wait_tx_done = 0;
+		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
+		so->cfecho = *(u32 *)cf->data;
 	} else {
-		/* send first frame and wait for FC */
+		/* send first frame */
 
 		isotp_create_fframe(cf, so, ae);
 
-		/* start timeout for FC */
-		hrtimer_sec = 1;
-		hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
-			      HRTIMER_MODE_REL_SOFT);
+		if (isotp_bc_flags(so) == CAN_ISOTP_CF_BROADCAST) {
+			/* set timer for FC-less operation (STmin = 0) */
+			if (so->opt.flags & CAN_ISOTP_FORCE_TXSTMIN)
+				so->tx_gap = ktime_set(0, so->force_tx_stmin);
+			else
+				so->tx_gap = ktime_set(0, so->frame_txtime);
+
+			/* disable wait for FCs due to activated block size */
+			so->txfc.bs = 0;
+
+			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
+			so->cfecho = *(u32 *)cf->data;
+		} else {
+			/* standard flow control check */
+			so->tx.state = ISOTP_WAIT_FIRST_FC;
+
+			/* start timeout for FC */
+			hrtimer_sec = ISOTP_FC_TIMEOUT;
+
+			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
+			so->cfecho = 0;
+		}
 	}
 
+	hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
 
@@ -982,15 +1056,19 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			       __func__, ERR_PTR(err));
 
 		/* no transmission -> no timeout monitoring */
-		if (hrtimer_sec)
-			hrtimer_cancel(&so->txtimer);
+		hrtimer_cancel(&so->txtimer);
+
+		/* reset consecutive frame echo tag */
+		so->cfecho = 0;
 
 		goto err_out_drop;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
-		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		if (err)
+			goto err_event_drop;
 
 		err = sock_error(sk);
 		if (err)
@@ -999,13 +1077,15 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	return size;
 
+err_event_drop:
+	/* got signal: force tx state machine to be idle */
+	so->tx.state = ISOTP_IDLE;
+	hrtimer_cancel(&so->txfrtimer);
+	hrtimer_cancel(&so->txtimer);
 err_out_drop:
 	/* drop this PDU and unlock a potential wait queue */
-	old_state = ISOTP_IDLE;
-err_out:
-	so->tx.state = old_state;
-	if (so->tx.state == ISOTP_IDLE)
-		wake_up_interruptible(&so->wait);
+	so->tx.state = ISOTP_IDLE;
+	wake_up_interruptible(&so->wait);
 
 	return err;
 }
@@ -1069,7 +1149,13 @@ static int isotp_release(struct socket *sock)
 	net = sock_net(sk);
 
 	/* wait for complete transmission of current pdu */
-	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
+	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
+		;
+
+	/* force state machines to be idle also when a signal occurred */
+	so->tx.state = ISOTP_SHUTDOWN;
+	so->rx.state = ISOTP_IDLE;
 
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
@@ -1083,21 +1169,27 @@ static int isotp_release(struct socket *sock)
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-	if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST))) {
+	if (so->bound) {
 		if (so->ifindex) {
 			struct net_device *dev;
 
 			dev = dev_get_by_index(net, so->ifindex);
 			if (dev) {
-				can_rx_unregister(net, dev, so->rxid,
-						  SINGLE_MASK(so->rxid),
-						  isotp_rcv, sk);
+				if (isotp_register_rxid(so))
+					can_rx_unregister(net, dev, so->rxid,
+							  SINGLE_MASK(so->rxid),
+							  isotp_rcv, sk);
+
+				can_rx_unregister(net, dev, so->txid,
+						  SINGLE_MASK(so->txid),
+						  isotp_rcv_echo, sk);
 				dev_put(dev);
 				synchronize_rcu();
 			}
 		}
 	}
 
+	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->rxtimer);
 
@@ -1121,26 +1213,38 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct net *net = sock_net(sk);
 	int ifindex;
 	struct net_device *dev;
-	canid_t tx_id, rx_id;
+	canid_t tx_id = addr->can_addr.tp.tx_id;
+	canid_t rx_id = addr->can_addr.tp.rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
-	int do_rx_reg = 1;
 
 	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
-	/* sanitize tx/rx CAN identifiers */
-	tx_id = addr->can_addr.tp.tx_id;
+	if (addr->can_family != AF_CAN)
+		return -EINVAL;
+
+	/* sanitize tx CAN identifier */
 	if (tx_id & CAN_EFF_FLAG)
 		tx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
 	else
 		tx_id &= CAN_SFF_MASK;
 
-	rx_id = addr->can_addr.tp.rx_id;
-	if (rx_id & CAN_EFF_FLAG)
-		rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
-	else
-		rx_id &= CAN_SFF_MASK;
+	/* give feedback on wrong CAN-ID value */
+	if (tx_id != addr->can_addr.tp.tx_id)
+		return -EINVAL;
+
+	/* sanitize rx CAN identifier (if needed) */
+	if (isotp_register_rxid(so)) {
+		if (rx_id & CAN_EFF_FLAG)
+			rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
+		else
+			rx_id &= CAN_SFF_MASK;
+
+		/* give feedback on wrong CAN-ID value */
+		if (rx_id != addr->can_addr.tp.rx_id)
+			return -EINVAL;
+	}
 
 	if (!addr->can_ifindex)
 		return -ENODEV;
@@ -1152,12 +1256,8 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		goto out;
 	}
 
-	/* do not register frame reception for functional addressing */
-	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
-		do_rx_reg = 0;
-
-	/* do not validate rx address for functional addressing */
-	if (do_rx_reg && rx_id == tx_id) {
+	/* ensure different CAN IDs when the rx_id is to be registered */
+	if (isotp_register_rxid(so) && rx_id == tx_id) {
 		err = -EADDRNOTAVAIL;
 		goto out;
 	}
@@ -1182,10 +1282,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 	ifindex = dev->ifindex;
 
-	if (do_rx_reg)
+	if (isotp_register_rxid(so))
 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
+	/* no consecutive frame echo skb in flight */
+	so->cfecho = 0;
+
+	/* register for echo skb's */
+	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			isotp_rcv_echo, sk, "isotpe", sk);
+
 	dev_put(dev);
 
 	/* switch to new settings */
@@ -1246,6 +1353,15 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 		if (!(so->opt.flags & CAN_ISOTP_RX_EXT_ADDR))
 			so->opt.rx_ext_address = so->opt.ext_address;
 
+		/* these broadcast flags are not allowed together */
+		if (isotp_bc_flags(so) == ISOTP_ALL_BC_FLAGS) {
+			/* CAN_ISOTP_SF_BROADCAST is prioritized */
+			so->opt.flags &= ~CAN_ISOTP_CF_BROADCAST;
+
+			/* give user feedback on wrong config attempt */
+			ret = -EINVAL;
+		}
+
 		/* check for frame_txtime changes (0 => no changes) */
 		if (so->opt.frame_txtime) {
 			if (so->opt.frame_txtime == CAN_ISOTP_FRAME_TXTIME_ZERO)
@@ -1396,10 +1512,16 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST)))
-			can_rx_unregister(dev_net(dev), dev, so->rxid,
-					  SINGLE_MASK(so->rxid),
-					  isotp_rcv, sk);
+		if (so->bound) {
+			if (isotp_register_rxid(so))
+				can_rx_unregister(dev_net(dev), dev, so->rxid,
+						  SINGLE_MASK(so->rxid),
+						  isotp_rcv, sk);
+
+			can_rx_unregister(dev_net(dev), dev, so->txid,
+					  SINGLE_MASK(so->txid),
+					  isotp_rcv_echo, sk);
+		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
@@ -1472,6 +1594,8 @@ static int isotp_init(struct sock *sk)
 	so->rxtimer.function = isotp_rx_timer_handler;
 	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txtimer.function = isotp_tx_timer_handler;
+	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	so->txfrtimer.function = isotp_txfr_timer_handler;
 
 	init_waitqueue_head(&so->wait);
 	spin_lock_init(&so->rx_lock);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index a385086091fd..927c4db2703f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -223,7 +223,8 @@ bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
-	int max_clean = atomic_read(&tbl->gc_entries) - tbl->gc_thresh2;
+	int max_clean = atomic_read(&tbl->gc_entries) -
+			READ_ONCE(tbl->gc_thresh2);
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
@@ -252,7 +253,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 		}
 	}
 
-	tbl->last_flush = jiffies;
+	WRITE_ONCE(tbl->last_flush, jiffies);
 
 	write_unlock_bh(&tbl->lock);
 
@@ -408,17 +409,17 @@ static struct neighbour *neigh_alloc(struct neigh_table *tbl,
 {
 	struct neighbour *n = NULL;
 	unsigned long now = jiffies;
-	int entries;
+	int entries, gc_thresh3;
 
 	if (exempt_from_gc)
 		goto do_alloc;
 
 	entries = atomic_inc_return(&tbl->gc_entries) - 1;
-	if (entries >= tbl->gc_thresh3 ||
-	    (entries >= tbl->gc_thresh2 &&
-	     time_after(now, tbl->last_flush + 5 * HZ))) {
-		if (!neigh_forced_gc(tbl) &&
-		    entries >= tbl->gc_thresh3) {
+	gc_thresh3 = READ_ONCE(tbl->gc_thresh3);
+	if (entries >= gc_thresh3 ||
+	    (entries >= READ_ONCE(tbl->gc_thresh2) &&
+	     time_after(now, READ_ONCE(tbl->last_flush) + 5 * HZ))) {
+		if (!neigh_forced_gc(tbl) && entries >= gc_thresh3) {
 			net_info_ratelimited("%s: neighbor table overflow!\n",
 					     tbl->id);
 			NEIGH_CACHE_STAT_INC(tbl, table_fulls);
@@ -897,13 +898,14 @@ static void neigh_periodic_work(struct work_struct *work)
 
 	if (time_after(jiffies, tbl->last_rand + 300 * HZ)) {
 		struct neigh_parms *p;
-		tbl->last_rand = jiffies;
+
+		WRITE_ONCE(tbl->last_rand, jiffies);
 		list_for_each_entry(p, &tbl->parms_list, list)
 			p->reachable_time =
 				neigh_rand_reach_time(NEIGH_VAR(p, BASE_REACHABLE_TIME));
 	}
 
-	if (atomic_read(&tbl->entries) < tbl->gc_thresh1)
+	if (atomic_read(&tbl->entries) < READ_ONCE(tbl->gc_thresh1))
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
@@ -2047,15 +2049,16 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 	ndtmsg->ndtm_pad2   = 0;
 
 	if (nla_put_string(skb, NDTA_NAME, tbl->id) ||
-	    nla_put_msecs(skb, NDTA_GC_INTERVAL, tbl->gc_interval, NDTA_PAD) ||
-	    nla_put_u32(skb, NDTA_THRESH1, tbl->gc_thresh1) ||
-	    nla_put_u32(skb, NDTA_THRESH2, tbl->gc_thresh2) ||
-	    nla_put_u32(skb, NDTA_THRESH3, tbl->gc_thresh3))
+	    nla_put_msecs(skb, NDTA_GC_INTERVAL, READ_ONCE(tbl->gc_interval),
+			  NDTA_PAD) ||
+	    nla_put_u32(skb, NDTA_THRESH1, READ_ONCE(tbl->gc_thresh1)) ||
+	    nla_put_u32(skb, NDTA_THRESH2, READ_ONCE(tbl->gc_thresh2)) ||
+	    nla_put_u32(skb, NDTA_THRESH3, READ_ONCE(tbl->gc_thresh3)))
 		goto nla_put_failure;
 	{
 		unsigned long now = jiffies;
-		long flush_delta = now - tbl->last_flush;
-		long rand_delta = now - tbl->last_rand;
+		long flush_delta = now - READ_ONCE(tbl->last_flush);
+		long rand_delta = now - READ_ONCE(tbl->last_rand);
 		struct neigh_hash_table *nht;
 		struct ndt_config ndc = {
 			.ndtc_key_len		= tbl->key_len,
@@ -2063,7 +2066,7 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			.ndtc_entries		= atomic_read(&tbl->entries),
 			.ndtc_last_flush	= jiffies_to_msecs(flush_delta),
 			.ndtc_last_rand		= jiffies_to_msecs(rand_delta),
-			.ndtc_proxy_qlen	= tbl->proxy_queue.qlen,
+			.ndtc_proxy_qlen	= READ_ONCE(tbl->proxy_queue.qlen),
 		};
 
 		rcu_read_lock_bh();
@@ -2086,17 +2089,17 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			struct neigh_statistics	*st;
 
 			st = per_cpu_ptr(tbl->stats, cpu);
-			ndst.ndts_allocs		+= st->allocs;
-			ndst.ndts_destroys		+= st->destroys;
-			ndst.ndts_hash_grows		+= st->hash_grows;
-			ndst.ndts_res_failed		+= st->res_failed;
-			ndst.ndts_lookups		+= st->lookups;
-			ndst.ndts_hits			+= st->hits;
-			ndst.ndts_rcv_probes_mcast	+= st->rcv_probes_mcast;
-			ndst.ndts_rcv_probes_ucast	+= st->rcv_probes_ucast;
-			ndst.ndts_periodic_gc_runs	+= st->periodic_gc_runs;
-			ndst.ndts_forced_gc_runs	+= st->forced_gc_runs;
-			ndst.ndts_table_fulls		+= st->table_fulls;
+			ndst.ndts_allocs		+= READ_ONCE(st->allocs);
+			ndst.ndts_destroys		+= READ_ONCE(st->destroys);
+			ndst.ndts_hash_grows		+= READ_ONCE(st->hash_grows);
+			ndst.ndts_res_failed		+= READ_ONCE(st->res_failed);
+			ndst.ndts_lookups		+= READ_ONCE(st->lookups);
+			ndst.ndts_hits			+= READ_ONCE(st->hits);
+			ndst.ndts_rcv_probes_mcast	+= READ_ONCE(st->rcv_probes_mcast);
+			ndst.ndts_rcv_probes_ucast	+= READ_ONCE(st->rcv_probes_ucast);
+			ndst.ndts_periodic_gc_runs	+= READ_ONCE(st->periodic_gc_runs);
+			ndst.ndts_forced_gc_runs	+= READ_ONCE(st->forced_gc_runs);
+			ndst.ndts_table_fulls		+= READ_ONCE(st->table_fulls);
 		}
 
 		if (nla_put_64bit(skb, NDTA_STATS, sizeof(ndst), &ndst,
@@ -2320,16 +2323,16 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout_tbl_lock;
 
 	if (tb[NDTA_THRESH1])
-		tbl->gc_thresh1 = nla_get_u32(tb[NDTA_THRESH1]);
+		WRITE_ONCE(tbl->gc_thresh1, nla_get_u32(tb[NDTA_THRESH1]));
 
 	if (tb[NDTA_THRESH2])
-		tbl->gc_thresh2 = nla_get_u32(tb[NDTA_THRESH2]);
+		WRITE_ONCE(tbl->gc_thresh2, nla_get_u32(tb[NDTA_THRESH2]));
 
 	if (tb[NDTA_THRESH3])
-		tbl->gc_thresh3 = nla_get_u32(tb[NDTA_THRESH3]);
+		WRITE_ONCE(tbl->gc_thresh3, nla_get_u32(tb[NDTA_THRESH3]));
 
 	if (tb[NDTA_GC_INTERVAL])
-		tbl->gc_interval = nla_get_msecs(tb[NDTA_GC_INTERVAL]);
+		WRITE_ONCE(tbl->gc_interval, nla_get_msecs(tb[NDTA_GC_INTERVAL]));
 
 	err = 0;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a91cf000bb61..6dcb77a2bde6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -953,8 +953,10 @@ int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
  * importantly be able to generate EPOLLOUT for Edge Trigger epoll()
  * users.
  */
-void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
+void tcp_remove_empty_skb(struct sock *sk)
 {
+	struct sk_buff *skb = tcp_write_queue_tail(sk);
+
 	if (skb && TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
 		tcp_unlink_write_queue(skb, sk);
 		if (tcp_write_queue_empty(sk))
@@ -1107,7 +1109,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 	return copied;
 
 do_error:
-	tcp_remove_empty_skb(sk, tcp_write_queue_tail(sk));
+	tcp_remove_empty_skb(sk);
 	if (copied)
 		goto out;
 out_err:
@@ -1330,14 +1332,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (copy > msg_data_left(msg))
 			copy = msg_data_left(msg);
 
-		/* Where to copy to? */
-		if (skb_availroom(skb) > 0 && !zc) {
-			/* We have some space in skb head. Superb! */
-			copy = min_t(int, copy, skb_availroom(skb));
-			err = skb_add_data_nocache(sk, skb, &msg->msg_iter, copy);
-			if (err)
-				goto do_fault;
-		} else if (!zc) {
+		if (!zc) {
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
 			struct page_frag *pfrag = sk_page_frag(sk);
@@ -1436,9 +1431,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	return copied + copied_syn;
 
 do_error:
-	skb = tcp_write_queue_tail(sk);
-do_fault:
-	tcp_remove_empty_skb(sk, skb);
+	tcp_remove_empty_skb(sk);
 
 	if (copied + copied_syn)
 		goto out;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d1e431ad5f61..8e4b42d394be 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2195,16 +2195,17 @@ void tcp_enter_loss(struct sock *sk)
  * restore sanity to the SACK scoreboard. If the apparent reneging
  * persists until this RTO then we'll clear the SACK scoreboard.
  */
-static bool tcp_check_sack_reneging(struct sock *sk, int flag)
+static bool tcp_check_sack_reneging(struct sock *sk, int *ack_flag)
 {
-	if (flag & FLAG_SACK_RENEGING &&
-	    flag & FLAG_SND_UNA_ADVANCED) {
+	if (*ack_flag & FLAG_SACK_RENEGING &&
+	    *ack_flag & FLAG_SND_UNA_ADVANCED) {
 		struct tcp_sock *tp = tcp_sk(sk);
 		unsigned long delay = max(usecs_to_jiffies(tp->srtt_us >> 4),
 					  msecs_to_jiffies(10));
 
 		inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
 					  delay, TCP_RTO_MAX);
+		*ack_flag &= ~FLAG_SET_XMIT_TIMER;
 		return true;
 	}
 	return false;
@@ -2974,7 +2975,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 		tp->prior_ssthresh = 0;
 
 	/* B. In all the states check for reneging SACKs. */
-	if (tcp_check_sack_reneging(sk, flag))
+	if (tcp_check_sack_reneging(sk, ack_flag))
 		return;
 
 	/* C. Check consistency of the current state. */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 82b1583f709d..62e1875b9290 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1337,24 +1337,19 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
-		if (snd_una != msk->snd_nxt) {
-			tcp_remove_empty_skb(ssk, tcp_write_queue_tail(ssk));
+		if (snd_una != msk->snd_nxt || tcp_write_queue_tail(ssk)) {
+			tcp_remove_empty_skb(ssk);
 			return 0;
 		}
 
 		zero_window_probe = true;
 		data_seq = snd_una - 1;
 		copy = 1;
-
-		/* all mptcp-level data is acked, no skbs should be present into the
-		 * ssk write queue
-		 */
-		WARN_ON_ONCE(reuse_skb);
 	}
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
 	if (!sk_wmem_schedule(ssk, copy)) {
-		tcp_remove_empty_skb(ssk, tcp_write_queue_tail(ssk));
+		tcp_remove_empty_skb(ssk);
 		return -ENOMEM;
 	}
 
@@ -1379,7 +1374,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (reuse_skb) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
 		mpext->data_len += copy;
-		WARN_ON_ONCE(zero_window_probe);
 		goto out;
 	}
 
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 7f83f9697fc1..09fe6cf358ec 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -687,8 +687,8 @@ nfulnl_log_packet(struct net *net,
 	unsigned int plen = 0;
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
+	enum ip_conntrack_info ctinfo = 0;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 17edcf1d1c3b..440c29dc058e 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -364,7 +364,7 @@ static int u32_init(struct tcf_proto *tp)
 	idr_init(&root_ht->handle_idr);
 
 	if (tp_c == NULL) {
-		tp_c = kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KERNEL);
+		tp_c = kzalloc(sizeof(*tp_c), GFP_KERNEL);
 		if (tp_c == NULL) {
 			kfree(root_ht);
 			return -ENOBUFS;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index c5f936fbf876..0b41028ed544 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -566,69 +566,35 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	mutex_unlock(&vsock->rx_lock);
 }
 
-static int virtio_vsock_probe(struct virtio_device *vdev)
+static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 {
-	vq_callback_t *callbacks[] = {
-		virtio_vsock_rx_done,
-		virtio_vsock_tx_done,
-		virtio_vsock_event_done,
-	};
+	struct virtio_device *vdev = vsock->vdev;
 	static const char * const names[] = {
 		"rx",
 		"tx",
 		"event",
 	};
-	struct virtio_vsock *vsock = NULL;
+	vq_callback_t *callbacks[] = {
+		virtio_vsock_rx_done,
+		virtio_vsock_tx_done,
+		virtio_vsock_event_done,
+	};
 	int ret;
 
-	ret = mutex_lock_interruptible(&the_virtio_vsock_mutex);
-	if (ret)
-		return ret;
-
-	/* Only one virtio-vsock device per guest is supported */
-	if (rcu_dereference_protected(the_virtio_vsock,
-				lockdep_is_held(&the_virtio_vsock_mutex))) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	vsock = kzalloc(sizeof(*vsock), GFP_KERNEL);
-	if (!vsock) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	vsock->vdev = vdev;
-
-	ret = virtio_find_vqs(vsock->vdev, VSOCK_VQ_MAX,
-			      vsock->vqs, callbacks, names,
+	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, callbacks, names,
 			      NULL);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	virtio_vsock_update_guest_cid(vsock);
 
-	vsock->rx_buf_nr = 0;
-	vsock->rx_buf_max_nr = 0;
-	atomic_set(&vsock->queued_replies, 0);
-
-	mutex_init(&vsock->tx_lock);
-	mutex_init(&vsock->rx_lock);
-	mutex_init(&vsock->event_lock);
-	spin_lock_init(&vsock->send_pkt_list_lock);
-	INIT_LIST_HEAD(&vsock->send_pkt_list);
-	INIT_WORK(&vsock->rx_work, virtio_transport_rx_work);
-	INIT_WORK(&vsock->tx_work, virtio_transport_tx_work);
-	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
-	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
-
-	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
-		vsock->seqpacket_allow = true;
-
-	vdev->priv = vsock;
-
 	virtio_device_ready(vdev);
 
+	return 0;
+}
+
+static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
+{
 	mutex_lock(&vsock->tx_lock);
 	vsock->tx_run = true;
 	mutex_unlock(&vsock->tx_lock);
@@ -643,30 +609,24 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	vsock->event_run = true;
 	mutex_unlock(&vsock->event_lock);
 
-	rcu_assign_pointer(the_virtio_vsock, vsock);
-
-	mutex_unlock(&the_virtio_vsock_mutex);
-
-	return 0;
-
-out:
-	kfree(vsock);
-	mutex_unlock(&the_virtio_vsock_mutex);
-	return ret;
+	/* virtio_transport_send_pkt() can queue packets once
+	 * the_virtio_vsock is set, but they won't be processed until
+	 * vsock->tx_run is set to true. We queue vsock->send_pkt_work
+	 * when initialization finishes to send those packets queued
+	 * earlier.
+	 * We don't need to queue the other workers (rx, event) because
+	 * as long as we don't fill the queues with empty buffers, the
+	 * host can't send us any notification.
+	 */
+	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
 }
 
-static void virtio_vsock_remove(struct virtio_device *vdev)
+static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 {
-	struct virtio_vsock *vsock = vdev->priv;
+	struct virtio_device *vdev = vsock->vdev;
 	struct virtio_vsock_pkt *pkt;
 
-	mutex_lock(&the_virtio_vsock_mutex);
-
-	vdev->priv = NULL;
-	rcu_assign_pointer(the_virtio_vsock, NULL);
-	synchronize_rcu();
-
-	/* Reset all connected sockets when the device disappear */
+	/* Reset all connected sockets when the VQs disappear */
 	vsock_for_each_connected_socket(&virtio_transport.transport,
 					virtio_vsock_reset_sock);
 
@@ -711,6 +671,79 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 
 	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_vsock_probe(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = NULL;
+	int ret;
+
+	ret = mutex_lock_interruptible(&the_virtio_vsock_mutex);
+	if (ret)
+		return ret;
+
+	/* Only one virtio-vsock device per guest is supported */
+	if (rcu_dereference_protected(the_virtio_vsock,
+				lockdep_is_held(&the_virtio_vsock_mutex))) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	vsock = kzalloc(sizeof(*vsock), GFP_KERNEL);
+	if (!vsock) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	vsock->vdev = vdev;
+
+	vsock->rx_buf_nr = 0;
+	vsock->rx_buf_max_nr = 0;
+	atomic_set(&vsock->queued_replies, 0);
+
+	mutex_init(&vsock->tx_lock);
+	mutex_init(&vsock->rx_lock);
+	mutex_init(&vsock->event_lock);
+	spin_lock_init(&vsock->send_pkt_list_lock);
+	INIT_LIST_HEAD(&vsock->send_pkt_list);
+	INIT_WORK(&vsock->rx_work, virtio_transport_rx_work);
+	INIT_WORK(&vsock->tx_work, virtio_transport_tx_work);
+	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
+	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
+
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
+		vsock->seqpacket_allow = true;
+
+	vdev->priv = vsock;
+
+	ret = virtio_vsock_vqs_init(vsock);
+	if (ret < 0)
+		goto out;
+
+	rcu_assign_pointer(the_virtio_vsock, vsock);
+	virtio_vsock_vqs_start(vsock);
+
+	mutex_unlock(&the_virtio_vsock_mutex);
+
+	return 0;
+
+out:
+	kfree(vsock);
+	mutex_unlock(&the_virtio_vsock_mutex);
+	return ret;
+}
+
+static void virtio_vsock_remove(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = vdev->priv;
+
+	mutex_lock(&the_virtio_vsock_mutex);
+
+	vdev->priv = NULL;
+	rcu_assign_pointer(the_virtio_vsock, NULL);
+	synchronize_rcu();
+
+	virtio_vsock_vqs_del(vsock);
 
 	/* Other works can be queued before 'config->del_vqs()', so we flush
 	 * all works before to free the vsock object to avoid use after free.
@@ -725,6 +758,50 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	kfree(vsock);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int virtio_vsock_freeze(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = vdev->priv;
+
+	mutex_lock(&the_virtio_vsock_mutex);
+
+	rcu_assign_pointer(the_virtio_vsock, NULL);
+	synchronize_rcu();
+
+	virtio_vsock_vqs_del(vsock);
+
+	mutex_unlock(&the_virtio_vsock_mutex);
+
+	return 0;
+}
+
+static int virtio_vsock_restore(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = vdev->priv;
+	int ret;
+
+	mutex_lock(&the_virtio_vsock_mutex);
+
+	/* Only one virtio-vsock device per guest is supported */
+	if (rcu_dereference_protected(the_virtio_vsock,
+				lockdep_is_held(&the_virtio_vsock_mutex))) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = virtio_vsock_vqs_init(vsock);
+	if (ret < 0)
+		goto out;
+
+	rcu_assign_pointer(the_virtio_vsock, vsock);
+	virtio_vsock_vqs_start(vsock);
+
+out:
+	mutex_unlock(&the_virtio_vsock_mutex);
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_VSOCK, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -742,6 +819,10 @@ static struct virtio_driver virtio_vsock_driver = {
 	.id_table = id_table,
 	.probe = virtio_vsock_probe,
 	.remove = virtio_vsock_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtio_vsock_freeze,
+	.restore = virtio_vsock_restore,
+#endif
 };
 
 static int __init virtio_vsock_init(void)
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index c69d069b3f2b..774d80f4b101 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -330,6 +330,12 @@ static const struct config_entry config_table[] = {
 					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
 				}
 			},
+			{
+				.ident = "Google firmware",
+				.matches = {
+					DMI_MATCH(DMI_BIOS_VERSION, "Google"),
+				}
+			},
 			{}
 		}
 	},
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 8ea6d4333562..385f2cca939a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3251,6 +3251,8 @@ int rt5645_set_jack_detect(struct snd_soc_component *component,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 	}
 	rt5645_irq(0, rt5645);
 
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 1fa58e2bff3d..529aa480267b 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4411,7 +4411,8 @@ static int wcd938x_bind(struct device *dev)
 	wcd938x->rxdev = wcd938x_sdw_device_get(wcd938x->rxnode);
 	if (!wcd938x->rxdev) {
 		dev_err(dev, "could not find slave with matching of node\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unbind;
 	}
 	wcd938x->sdw_priv[AIF1_PB] = dev_get_drvdata(wcd938x->rxdev);
 	wcd938x->sdw_priv[AIF1_PB]->wcd938x = wcd938x;
@@ -4419,7 +4420,8 @@ static int wcd938x_bind(struct device *dev)
 	wcd938x->txdev = wcd938x_sdw_device_get(wcd938x->txnode);
 	if (!wcd938x->txdev) {
 		dev_err(dev, "could not find txslave with matching of node\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_rxdev;
 	}
 	wcd938x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd938x->txdev);
 	wcd938x->sdw_priv[AIF1_CAP]->wcd938x = wcd938x;
@@ -4430,31 +4432,35 @@ static int wcd938x_bind(struct device *dev)
 	if (!device_link_add(wcd938x->rxdev, wcd938x->txdev, DL_FLAG_STATELESS |
 			    DL_FLAG_PM_RUNTIME)) {
 		dev_err(dev, "could not devlink tx and rx\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_txdev;
 	}
 
 	if (!device_link_add(dev, wcd938x->txdev, DL_FLAG_STATELESS |
 					DL_FLAG_PM_RUNTIME)) {
 		dev_err(dev, "could not devlink wcd and tx\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_remove_rxtx_link;
 	}
 
 	if (!device_link_add(dev, wcd938x->rxdev, DL_FLAG_STATELESS |
 					DL_FLAG_PM_RUNTIME)) {
 		dev_err(dev, "could not devlink wcd and rx\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_remove_tx_link;
 	}
 
 	wcd938x->regmap = devm_regmap_init_sdw(wcd938x->tx_sdw_dev, &wcd938x_regmap_config);
 	if (IS_ERR(wcd938x->regmap)) {
 		dev_err(dev, "%s: tx csr regmap not found\n", __func__);
-		return PTR_ERR(wcd938x->regmap);
+		ret = PTR_ERR(wcd938x->regmap);
+		goto err_remove_rx_link;
 	}
 
 	ret = wcd938x_irq_init(wcd938x, dev);
 	if (ret) {
 		dev_err(dev, "%s: IRQ init failed: %d\n", __func__, ret);
-		return ret;
+		goto err_remove_rx_link;
 	}
 
 	wcd938x->sdw_priv[AIF1_PB]->slave_irq = wcd938x->virq;
@@ -4463,17 +4469,33 @@ static int wcd938x_bind(struct device *dev)
 	ret = wcd938x_set_micbias_data(wcd938x);
 	if (ret < 0) {
 		dev_err(dev, "%s: bad micbias pdata\n", __func__);
-		return ret;
+		goto err_remove_rx_link;
 	}
 
 	ret = snd_soc_register_component(dev, &soc_codec_dev_wcd938x,
 					 wcd938x_dais, ARRAY_SIZE(wcd938x_dais));
-	if (ret)
+	if (ret) {
 		dev_err(dev, "%s: Codec registration failed\n",
 				__func__);
+		goto err_remove_rx_link;
+	}
 
-	return ret;
+	return 0;
 
+err_remove_rx_link:
+	device_link_remove(dev, wcd938x->rxdev);
+err_remove_tx_link:
+	device_link_remove(dev, wcd938x->txdev);
+err_remove_rxtx_link:
+	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
+err_put_txdev:
+	put_device(wcd938x->txdev);
+err_put_rxdev:
+	put_device(wcd938x->rxdev);
+err_unbind:
+	component_unbind_all(dev, wcd938x);
+
+	return ret;
 }
 
 static void wcd938x_unbind(struct device *dev)
@@ -4484,6 +4506,8 @@ static void wcd938x_unbind(struct device *dev)
 	device_link_remove(dev, wcd938x->txdev);
 	device_link_remove(dev, wcd938x->rxdev);
 	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
+	put_device(wcd938x->txdev);
+	put_device(wcd938x->rxdev);
 	component_unbind_all(dev, wcd938x);
 }
 
@@ -4574,7 +4598,13 @@ static int wcd938x_probe(struct platform_device *pdev)
 
 static int wcd938x_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &wcd938x_comp_ops);
+	struct device *dev = &pdev->dev;
+
+	component_master_del(dev, &wcd938x_comp_ops);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 
 	return 0;
 }
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 283aa21879aa..95e4c53cd90c 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -680,10 +680,12 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		struct snd_soc_dai_link *dai_link = priv->dai_link;
 		struct simple_dai_props *dai_props = priv->dai_props;
 
+		ret = -EINVAL;
+
 		cinfo = dev->platform_data;
 		if (!cinfo) {
 			dev_err(dev, "no info for asoc-simple-card\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		if (!cinfo->name ||
@@ -692,7 +694,7 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		    !cinfo->platform ||
 		    !cinfo->cpu_dai.name) {
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		cpus			= dai_link->cpus;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 36ad0b6b94a9..c3bb96e5bfa6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2202,7 +2202,7 @@ static bool is_special_call(struct instruction *insn)
 		if (!dest)
 			return false;
 
-		if (dest->fentry)
+		if (dest->fentry || dest->embedded_insn)
 			return true;
 	}
 
