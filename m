Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69254811E32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442096AbjLMTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjLMTIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:08:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7AFD44
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:07:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACC9C433CD;
        Wed, 13 Dec 2023 19:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702494474;
        bh=XaMRvsCNCyHXRUqUqtXl+Hewv/GAOBmUcFVW4UwkeVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbQJSxBnsqcKlmdjynGx7V99OBEqKnuMUSsb7cRhlCq1NMrkOvZWnhcvE5vMnmdKO
         xXuBtFuqo/RH/LMxlLalBstRh3ssgSq8ompvjgLMKN16ooWkjowI9Rt+9hJ9aQnPa+
         7W5ytFYnmIEmqdxQDP7S6tCs+uL3igOigYfJkz4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.204
Date:   Wed, 13 Dec 2023 20:05:56 +0100
Message-ID: <2023121356-playful-phobia-7696@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023121355-compel-nervy-1208@gregkh>
References: <2023121355-compel-nervy-1208@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
index 0f58701367b6..af31e5a22d89 100644
--- a/Documentation/ABI/testing/sysfs-bus-optee-devices
+++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -6,3 +6,12 @@ Description:
 		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
 		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
 		are free to create needed API under optee-ta-<uuid> directory.
+
+What:		/sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
+Date:		November 2023
+KernelVersion:	6.7
+Contact:	op-tee@lists.trustedfirmware.org
+Description:
+		Allows to distinguish whether an OP-TEE based TA/device requires user-space
+		tee-supplicant to function properly or not. This attribute will be present for
+		devices which depend on tee-supplicant to be running.
diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 04885738cf15..0f8f0772d6f3 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -57,3 +57,12 @@ Description:
 			* 0 - default,
 			* 1 - overboost,
 			* 2 - silent
+
+What:		/sys/devices/platform/<platform>/dgpu_disable
+Date:		Aug 2022
+KernelVersion:	5.17
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Disable discrete GPU:
+			* 0 - Enable dGPU,
+			* 1 - Disable dGPU
diff --git a/Makefile b/Makefile
index 4cbeb198196b..87886018d774 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 203
+SUBLEVEL = 204
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 854c380cccea..03bde2fb9bb1 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -437,7 +437,7 @@ iomuxc_lpsr: iomuxc-lpsr@302c0000 {
 			};
 
 			gpt1: timer@302d0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302d0000 0x10000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT1_ROOT_CLK>,
@@ -446,7 +446,7 @@ gpt1: timer@302d0000 {
 			};
 
 			gpt2: timer@302e0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302e0000 0x10000>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT2_ROOT_CLK>,
@@ -456,7 +456,7 @@ gpt2: timer@302e0000 {
 			};
 
 			gpt3: timer@302f0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302f0000 0x10000>;
 				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT3_ROOT_CLK>,
@@ -466,7 +466,7 @@ gpt3: timer@302f0000 {
 			};
 
 			gpt4: timer@30300000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x30300000 0x10000>;
 				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT4_ROOT_CLK>,
diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index b9efe9da06e0..3d76e8c28c51 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -502,6 +502,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 	name = devm_kasprintf(&pdev->dev,
 				GFP_KERNEL, "mmdc%d", ret);
+	if (!name) {
+		ret = -ENOMEM;
+		goto pmu_release_id;
+	}
 
 	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
 	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;
@@ -524,9 +528,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 pmu_register_err:
 	pr_warn("MMDC Perf PMU failed (%d), disabled\n", ret);
-	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	hrtimer_cancel(&pmu_mmdc->hrtimer);
+pmu_release_id:
+	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 pmu_free:
 	kfree(pmu_mmdc);
 	return ret;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 3053f484c8cc..7e6cffdc5a55 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -69,7 +69,7 @@ red {
 		};
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 08ad0ffb24df..993f033d0bf0 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -55,7 +55,7 @@ wps {
 		};
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0 0x40000000 0 0x20000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 6dffada2e66b..2b66afcf026e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -43,7 +43,7 @@ extcon_usb: extcon_iddig {
 		id-gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb_p1_vbus: regulator@0 {
+	usb_p1_vbus: regulator-usb-p1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -52,7 +52,7 @@ usb_p1_vbus: regulator@0 {
 		enable-active-high;
 	};
 
-	usb_p0_vbus: regulator@1 {
+	usb_p0_vbus: regulator-usb-p0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbus";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index cba2d8933e79..1d2d2e7239a3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -30,7 +30,7 @@ reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		scp_mem_reserved: scp_mem_region {
+		scp_mem_reserved: memory@50000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x50000000 0 0x2900000>;
 			no-map;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 85f7c33ba446..a4f860bb4a84 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -95,7 +95,7 @@ reserved_memory: reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		scp_mem_reserved: scp_mem_region {
+		scp_mem_reserved: memory@50000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x50000000 0 0x2900000>;
 			no-map;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index c5f3d4f8f4d2..3180f576ed02 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1022,7 +1022,9 @@ power-domain@RK3399_PD_VCODEC {
 			power-domain@RK3399_PD_VDU {
 				reg = <RK3399_PD_VDU>;
 				clocks = <&cru ACLK_VDU>,
-					 <&cru HCLK_VDU>;
+					 <&cru HCLK_VDU>,
+					 <&cru SCLK_VDU_CA>,
+					 <&cru SCLK_VDU_CORE>;
 				pm_qos = <&qos_video_m1_r>,
 					 <&qos_video_m1_w>;
 			};
@@ -1276,7 +1278,7 @@ vpu_mmu: iommu@ff650800 {
 
 	vdec: video-codec@ff660000 {
 		compatible = "rockchip,rk3399-vdec";
-		reg = <0x0 0xff660000 0x0 0x400>;
+		reg = <0x0 0xff660000 0x0 0x480>;
 		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>,
 			 <&cru SCLK_VDU_CA>, <&cru SCLK_VDU_CORE>;
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 57839f63074f..18ebacf29889 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -468,6 +468,7 @@ config MACH_LOONGSON2EF
 
 config MACH_LOONGSON64
 	bool "Loongson 64-bit family of machines"
+	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
@@ -1379,6 +1380,7 @@ config CPU_LOONGSON64
 	select CPU_SUPPORTS_MSA
 	select CPU_DIEI_BROKEN if !LOONGSON3_ENHANCEMENT
 	select CPU_MIPSR2_IRQ_VI
+	select DMA_NONCOHERENT
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select MIPS_ASID_BITS_VARIABLE
diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index afc92b7a61c6..de0bd14d798a 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -117,7 +117,8 @@ struct irq_source_routing_table {
 	u64 pci_io_start_addr;
 	u64 pci_io_end_addr;
 	u64 pci_config_addr;
-	u32 dma_mask_bits;
+	u16 dma_mask_bits;
+	u16 dma_noncoherent;
 } __packed;
 
 struct interface_info {
diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
index 134cb8e9efc2..a59bae36f86a 100644
--- a/arch/mips/loongson64/env.c
+++ b/arch/mips/loongson64/env.c
@@ -13,6 +13,8 @@
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  */
+
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/pci_ids.h>
 #include <asm/bootinfo.h>
@@ -131,8 +133,14 @@ void __init prom_init_env(void)
 	loongson_sysconf.pci_io_base = eirq_source->pci_io_start_addr;
 	loongson_sysconf.dma_mask_bits = eirq_source->dma_mask_bits;
 	if (loongson_sysconf.dma_mask_bits < 32 ||
-		loongson_sysconf.dma_mask_bits > 64)
+			loongson_sysconf.dma_mask_bits > 64) {
 		loongson_sysconf.dma_mask_bits = 32;
+		dma_default_coherent = true;
+	} else {
+		dma_default_coherent = !eirq_source->dma_noncoherent;
+	}
+
+	pr_info("Firmware: Coherent DMA: %s\n", dma_default_coherent ? "on" : "off");
 
 	loongson_sysconf.restart_addr = boot_p->reset_system.ResetWarm;
 	loongson_sysconf.poweroff_addr = boot_p->reset_system.Shutdown;
diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index 052cce6a8a99..4071cc8841e3 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -140,6 +140,11 @@ static __init void reserve_pio_range(void)
 			}
 		}
 	}
+
+	/* Reserve vgabios if it comes from firmware */
+	if (loongson_sysconf.vgabios_addr)
+		memblock_reserve(virt_to_phys((void *)loongson_sysconf.vgabios_addr),
+				SZ_256K);
 }
 
 void __init arch_init_irq(void)
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 46c4dafe3ba0..b246c3dc6993 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -344,16 +344,14 @@ int handle_misaligned_store(struct pt_regs *regs)
 	} else if ((insn & INSN_MASK_C_SD) == INSN_MATCH_C_SD) {
 		len = 8;
 		val.data_ulong = GET_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_SDSP) == INSN_MATCH_C_SDSP &&
-		   ((insn >> SH_RD) & 0x1f)) {
+	} else if ((insn & INSN_MASK_C_SDSP) == INSN_MATCH_C_SDSP) {
 		len = 8;
 		val.data_ulong = GET_RS2C(insn, regs);
 #endif
 	} else if ((insn & INSN_MASK_C_SW) == INSN_MATCH_C_SW) {
 		len = 4;
 		val.data_ulong = GET_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_SWSP) == INSN_MATCH_C_SWSP &&
-		   ((insn >> SH_RD) & 0x1f)) {
+	} else if ((insn & INSN_MASK_C_SWSP) == INSN_MATCH_C_SWSP) {
 		len = 4;
 		val.data_ulong = GET_RS2C(insn, regs);
 	} else {
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 1c05caf68e7d..5b62e385af38 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -717,7 +717,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 		pte_clear(mm, addr, ptep);
 	}
 	if (reset)
-		pgste_val(pgste) &= ~_PGSTE_GPS_USAGE_MASK;
+		pgste_val(pgste) &= ~(_PGSTE_GPS_USAGE_MASK | _PGSTE_GPS_NODAT);
 	pgste_set_unlock(ptep, pgste);
 	preempt_enable();
 }
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d254e02aa179..f29c6bed9d65 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1328,6 +1328,9 @@ static void zenbleed_check_cpu(void *unused)
 
 void amd_check_microcode(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return;
+
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
 
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 9243468e2c99..4d725d1fd61a 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -29,6 +29,47 @@ struct devcd_entry {
 	struct device devcd_dev;
 	void *data;
 	size_t datalen;
+	/*
+	 * Here, mutex is required to serialize the calls to del_wk work between
+	 * user/kernel space which happens when devcd is added with device_add()
+	 * and that sends uevent to user space. User space reads the uevents,
+	 * and calls to devcd_data_write() which try to modify the work which is
+	 * not even initialized/queued from devcoredump.
+	 *
+	 *
+	 *
+	 *        cpu0(X)                                 cpu1(Y)
+	 *
+	 *        dev_coredump() uevent sent to user space
+	 *        device_add()  ======================> user space process Y reads the
+	 *                                              uevents writes to devcd fd
+	 *                                              which results into writes to
+	 *
+	 *                                             devcd_data_write()
+	 *                                               mod_delayed_work()
+	 *                                                 try_to_grab_pending()
+	 *                                                   del_timer()
+	 *                                                     debug_assert_init()
+	 *       INIT_DELAYED_WORK()
+	 *       schedule_delayed_work()
+	 *
+	 *
+	 * Also, mutex alone would not be enough to avoid scheduling of
+	 * del_wk work after it get flush from a call to devcd_free()
+	 * mentioned as below.
+	 *
+	 *	disabled_store()
+	 *        devcd_free()
+	 *          mutex_lock()             devcd_data_write()
+	 *          flush_delayed_work()
+	 *          mutex_unlock()
+	 *                                   mutex_lock()
+	 *                                   mod_delayed_work()
+	 *                                   mutex_unlock()
+	 * So, delete_work flag is required.
+	 */
+	struct mutex mutex;
+	bool delete_work;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
@@ -88,7 +129,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work) {
+		devcd->delete_work = true;
+		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	}
+	mutex_unlock(&devcd->mutex);
 
 	return count;
 }
@@ -116,7 +162,12 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work)
+		devcd->delete_work = true;
+
 	flush_delayed_work(&devcd->del_wk);
+	mutex_unlock(&devcd->mutex);
 	return 0;
 }
 
@@ -126,6 +177,30 @@ static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
 	return sysfs_emit(buf, "%d\n", devcd_disabled);
 }
 
+/*
+ *
+ *	disabled_store()                                	worker()
+ *	 class_for_each_device(&devcd_class,
+ *		NULL, NULL, devcd_free)
+ *         ...
+ *         ...
+ *	   while ((dev = class_dev_iter_next(&iter))
+ *                                                             devcd_del()
+ *                                                               device_del()
+ *                                                                 put_device() <- last reference
+ *             error = fn(dev, data)                           devcd_dev_release()
+ *             devcd_free(dev, data)                           kfree(devcd)
+ *             mutex_lock(&devcd->mutex);
+ *
+ *
+ * In the above diagram, It looks like disabled_store() would be racing with parallely
+ * running devcd_del() and result in memory abort while acquiring devcd->mutex which
+ * is called after kfree of devcd memory  after dropping its last reference with
+ * put_device(). However, this will not happens as fn(dev, data) runs
+ * with its own reference to device via klist_node so it is not its last reference.
+ * so, above situation would not occur.
+ */
+
 static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -282,13 +357,17 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
+	devcd->delete_work = false;
 
+	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
 
 	dev_set_name(&devcd->devcd_dev, "devcd%d",
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
+	mutex_lock(&devcd->mutex);
+	dev_set_uevent_suppress(&devcd->devcd_dev, true);
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -300,12 +379,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 			      "devcoredump"))
 		/* nothing - symlink will be missing */;
 
+	dev_set_uevent_suppress(&devcd->devcd_dev, false);
+	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
-
+	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
 	put_device(&devcd->devcd_dev);
+	mutex_unlock(&devcd->mutex);
  put_module:
 	module_put(owner);
  free:
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index fa5d945b2f28..f45ba0f789d4 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -491,14 +491,17 @@ static ssize_t export_store(struct class *class,
 	}
 
 	status = gpiod_set_transitory(desc, false);
-	if (!status) {
-		status = gpiod_export(desc, true);
-		if (status < 0)
-			gpiod_free(desc);
-		else
-			set_bit(FLAG_SYSFS, &desc->flags);
+	if (status) {
+		gpiod_free(desc);
+		goto done;
 	}
 
+	status = gpiod_export(desc, true);
+	if (status < 0)
+		gpiod_free(desc);
+	else
+		set_bit(FLAG_SYSFS, &desc->flags);
+
 done:
 	if (status)
 		pr_debug("%s: status %d\n", __func__, status);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 7f2adac82e3a..addeda42339f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -143,7 +143,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	}
 
 	for (i = 0; i < p->nchunks; i++) {
-		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
+		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 7cc7af2a6822..3671a700189d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -299,13 +299,11 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 		adev->have_disp_power_ref = true;
 		return ret;
 	}
-	/* if we have no active crtcs, then drop the power ref
-	   we got before */
-	if (!active && adev->have_disp_power_ref) {
-		pm_runtime_put_autosuspend(dev->dev);
+	/* if we have no active crtcs, then go to
+	 * drop the power ref we got before
+	 */
+	if (!active && adev->have_disp_power_ref)
 		adev->have_disp_power_ref = false;
-	}
-
 out:
 	/* drop the power reference we got coming in here */
 	pm_runtime_put_autosuspend(dev->dev);
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index a270b975e90b..5794d44538e9 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -32,6 +32,7 @@ ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
 #define POWER_METER_CAN_NOTIFY	(1 << 3)
 #define POWER_METER_IS_BATTERY	(1 << 8)
 #define UNKNOWN_HYSTERESIS	0xFFFFFFFF
+#define UNKNOWN_POWER		0xFFFFFFFF
 
 #define METER_NOTIFY_CONFIG	0x80
 #define METER_NOTIFY_TRIP	0x81
@@ -343,6 +344,9 @@ static ssize_t show_power(struct device *dev,
 	update_meter(resource);
 	mutex_unlock(&resource->lock);
 
+	if (resource->power == UNKNOWN_POWER)
+		return -ENODATA;
+
 	return sprintf(buf, "%llu\n", resource->power * 1000);
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 682fffaab2b4..c9f7783ac7cb 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -63,7 +63,7 @@ static int dw_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = readl_relaxed(dev->base + reg);
+	*val = readl(dev->base + reg);
 
 	return 0;
 }
@@ -72,7 +72,7 @@ static int dw_reg_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writel_relaxed(val, dev->base + reg);
+	writel(val, dev->base + reg);
 
 	return 0;
 }
@@ -81,7 +81,7 @@ static int dw_reg_read_swab(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = swab32(readl_relaxed(dev->base + reg));
+	*val = swab32(readl(dev->base + reg));
 
 	return 0;
 }
@@ -90,7 +90,7 @@ static int dw_reg_write_swab(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writel_relaxed(swab32(val), dev->base + reg);
+	writel(swab32(val), dev->base + reg);
 
 	return 0;
 }
@@ -99,8 +99,8 @@ static int dw_reg_read_word(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = readw_relaxed(dev->base + reg) |
-		(readw_relaxed(dev->base + reg + 2) << 16);
+	*val = readw(dev->base + reg) |
+		(readw(dev->base + reg + 2) << 16);
 
 	return 0;
 }
@@ -109,8 +109,8 @@ static int dw_reg_write_word(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writew_relaxed(val, dev->base + reg);
-	writew_relaxed(val >> 16, dev->base + reg + 2);
+	writew(val, dev->base + reg);
+	writew(val >> 16, dev->base + reg + 2);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 8a618769915d..76030eac49a3 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -70,7 +70,7 @@ static char version[] =
 		BNXT_RE_DESC "\n";
 
 MODULE_AUTHOR("Eddie Wai <eddie.wai@broadcom.com>");
-MODULE_DESCRIPTION(BNXT_RE_DESC " Driver");
+MODULE_DESCRIPTION(BNXT_RE_DESC);
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* globals */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 1a5805260778..e8b2b58cc9bc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -387,7 +387,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	struct rtrs_clt_sess *sess;
 	int err;
 
-	if (WARN_ON(!req->in_use))
+	if (!req->in_use)
 		return;
 	if (WARN_ON(!req->con))
 		return;
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index d5c3f7d54634..aa87542f116c 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1969,7 +1969,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	mei_hdr = mei_msg_hdr_init(cb);
 	if (IS_ERR(mei_hdr)) {
-		rets = -PTR_ERR(mei_hdr);
+		rets = PTR_ERR(mei_hdr);
 		mei_hdr = NULL;
 		goto err;
 	}
@@ -1993,7 +1993,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	hbuf_slots = mei_hbuf_empty_slots(dev);
 	if (hbuf_slots < 0) {
-		rets = -EOVERFLOW;
+		buf_len = -EOVERFLOW;
 		goto out;
 	}
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index fdeaaae08060..d5ca59bd1c99 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -553,6 +553,8 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
+	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, MMC_BUSY_IO);
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
 	cmd.arg          = 1; /* Discard entire queue */
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ebad70e4481a..b6bb7f7faee2 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -452,7 +452,7 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 	u32 status = 0;
 	int err;
 
-	if (host->ops->card_busy) {
+	if (busy_cmd != MMC_BUSY_IO && host->ops->card_busy) {
 		*busy = host->ops->card_busy(host);
 		return 0;
 	}
@@ -473,6 +473,7 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 		err = R1_STATUS(status) ? -EIO : 0;
 		break;
 	case MMC_BUSY_HPI:
+	case MMC_BUSY_IO:
 		break;
 	default:
 		err = -EINVAL;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 632009260e51..e3cbb1ddc31c 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -14,6 +14,7 @@ enum mmc_busy_cmd {
 	MMC_BUSY_CMD6,
 	MMC_BUSY_ERASE,
 	MMC_BUSY_HPI,
+	MMC_BUSY_IO,
 };
 
 struct mmc_host;
diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index 5d4a4c7efbbf..deeabd6ec2e8 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -186,6 +186,8 @@ do {									\
 #define ARC_IS_5MBIT    1   /* card default speed is 5MBit */
 #define ARC_CAN_10MBIT  2   /* card uses COM20022, supporting 10MBit,
 				 but default is 2.5MBit. */
+#define ARC_HAS_LED     4   /* card has software controlled LEDs */
+#define ARC_HAS_ROTARY  8   /* card has rotary encoder */
 
 /* information needed to define an encapsulation driver */
 struct ArcProto {
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index b4f8798d8c50..9d9e4200064f 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -127,6 +127,8 @@ static int com20020pci_probe(struct pci_dev *pdev,
 	int i, ioaddr, ret;
 	struct resource *r;
 
+	ret = 0;
+
 	if (pci_enable_device(pdev))
 		return -EIO;
 
@@ -142,6 +144,8 @@ static int com20020pci_probe(struct pci_dev *pdev,
 	priv->ci = ci;
 	mm = &ci->misc_map;
 
+	pci_set_drvdata(pdev, priv);
+
 	INIT_LIST_HEAD(&priv->list_dev);
 
 	if (mm->size) {
@@ -164,7 +168,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		dev = alloc_arcdev(device);
 		if (!dev) {
 			ret = -ENOMEM;
-			goto out_port;
+			break;
 		}
 		dev->dev_port = i;
 
@@ -181,7 +185,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			pr_err("IO region %xh-%xh already allocated\n",
 			       ioaddr, ioaddr + cm->size - 1);
 			ret = -EBUSY;
-			goto out_port;
+			goto err_free_arcdev;
 		}
 
 		/* Dummy access after Reset
@@ -209,76 +213,79 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		if (!strncmp(ci->name, "EAE PLX-PCI FB2", 15))
 			lp->backplane = 1;
 
-		/* Get the dev_id from the PLX rotary coder */
-		if (!strncmp(ci->name, "EAE PLX-PCI MA1", 15))
-			dev_id_mask = 0x3;
-		dev->dev_id = (inb(priv->misc + ci->rotary) >> 4) & dev_id_mask;
-
-		snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
+		if (ci->flags & ARC_HAS_ROTARY) {
+			/* Get the dev_id from the PLX rotary coder */
+			if (!strncmp(ci->name, "EAE PLX-PCI MA1", 15))
+				dev_id_mask = 0x3;
+			dev->dev_id = (inb(priv->misc + ci->rotary) >> 4) & dev_id_mask;
+			snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
+		}
 
 		if (arcnet_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
 			pr_err("IO address %Xh is empty!\n", ioaddr);
 			ret = -EIO;
-			goto out_port;
+			goto err_free_arcdev;
 		}
 		if (com20020_check(dev)) {
 			ret = -EIO;
-			goto out_port;
+			goto err_free_arcdev;
 		}
 
+		ret = com20020_found(dev, IRQF_SHARED);
+		if (ret)
+			goto err_free_arcdev;
+
 		card = devm_kzalloc(&pdev->dev, sizeof(struct com20020_dev),
 				    GFP_KERNEL);
 		if (!card) {
 			ret = -ENOMEM;
-			goto out_port;
+			goto err_free_arcdev;
 		}
 
 		card->index = i;
 		card->pci_priv = priv;
-		card->tx_led.brightness_set = led_tx_set;
-		card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
-						GFP_KERNEL, "arc%d-%d-tx",
-						dev->dev_id, i);
-		card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"pci:green:tx:%d-%d",
-						dev->dev_id, i);
-
-		card->tx_led.dev = &dev->dev;
-		card->recon_led.brightness_set = led_recon_set;
-		card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
-						GFP_KERNEL, "arc%d-%d-recon",
-						dev->dev_id, i);
-		card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"pci:red:recon:%d-%d",
-						dev->dev_id, i);
-		card->recon_led.dev = &dev->dev;
-		card->dev = dev;
-
-		ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
-		if (ret)
-			goto out_port;
-
-		ret = devm_led_classdev_register(&pdev->dev, &card->recon_led);
-		if (ret)
-			goto out_port;
-
-		dev_set_drvdata(&dev->dev, card);
 
-		ret = com20020_found(dev, IRQF_SHARED);
-		if (ret)
-			goto out_port;
-
-		devm_arcnet_led_init(dev, dev->dev_id, i);
+		if (ci->flags & ARC_HAS_LED) {
+			card->tx_led.brightness_set = led_tx_set;
+			card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
+							GFP_KERNEL, "arc%d-%d-tx",
+							dev->dev_id, i);
+			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"pci:green:tx:%d-%d",
+							dev->dev_id, i);
+
+			card->tx_led.dev = &dev->dev;
+			card->recon_led.brightness_set = led_recon_set;
+			card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
+							GFP_KERNEL, "arc%d-%d-recon",
+							dev->dev_id, i);
+			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"pci:red:recon:%d-%d",
+							dev->dev_id, i);
+			card->recon_led.dev = &dev->dev;
+
+			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
+			if (ret)
+				goto err_free_arcdev;
+
+			ret = devm_led_classdev_register(&pdev->dev, &card->recon_led);
+			if (ret)
+				goto err_free_arcdev;
+
+			dev_set_drvdata(&dev->dev, card);
+			devm_arcnet_led_init(dev, dev->dev_id, i);
+		}
 
+		card->dev = dev;
 		list_add(&card->list, &priv->list_dev);
-	}
-
-	pci_set_drvdata(pdev, priv);
-
-	return 0;
+		continue;
 
-out_port:
-	com20020pci_remove(pdev);
+err_free_arcdev:
+		free_arcdev(dev);
+		break;
+	}
+	if (ret)
+		com20020pci_remove(pdev);
 	return ret;
 }
 
@@ -325,7 +332,7 @@ static struct com20020_pci_card_info card_info_5mbit = {
 };
 
 static struct com20020_pci_card_info card_info_sohard = {
-	.name = "PLX-PCI",
+	.name = "SOHARD SH ARC-PCI",
 	.devcount = 1,
 	/* SOHARD needs PCI base addr 4 */
 	.chan_map_tbl = {
@@ -360,7 +367,7 @@ static struct com20020_pci_card_info card_info_eae_arc1 = {
 		},
 	},
 	.rotary = 0x0,
-	.flags = ARC_CAN_10MBIT,
+	.flags = ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
 
 static struct com20020_pci_card_info card_info_eae_ma1 = {
@@ -392,7 +399,7 @@ static struct com20020_pci_card_info card_info_eae_ma1 = {
 		},
 	},
 	.rotary = 0x0,
-	.flags = ARC_CAN_10MBIT,
+	.flags = ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
 
 static struct com20020_pci_card_info card_info_eae_fb2 = {
@@ -417,7 +424,7 @@ static struct com20020_pci_card_info card_info_eae_fb2 = {
 		},
 	},
 	.rotary = 0x0,
-	.flags = ARC_CAN_10MBIT,
+	.flags = ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
 
 static const struct pci_device_id com20020pci_id_table[] = {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 3e9b1f59e381..775d0b7521ca 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -2061,6 +2061,7 @@ int bnxt_init_tc(struct bnxt *bp)
 	rhashtable_destroy(&tc_info->flow_table);
 free_tc_info:
 	kfree(tc_info);
+	bp->tc_info = NULL;
 	return rc;
 }
 
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 5647833303a4..b010f28b0abf 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6864,7 +6864,7 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 				       desc_idx, *post_ptr);
 		drop_it_no_recycle:
 			/* Other statistics kept track of by card. */
-			tp->rx_dropped++;
+			tnapi->rx_dropped++;
 			goto next_pkt;
 		}
 
@@ -7890,8 +7890,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
@@ -8161,7 +8163,7 @@ static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	dev_kfree_skb_any(skb);
 drop_nofree:
-	tp->tx_dropped++;
+	tnapi->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
@@ -9340,7 +9342,7 @@ static void __tg3_set_rx_mode(struct net_device *);
 /* tp->lock is held. */
 static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 {
-	int err;
+	int err, i;
 
 	tg3_stop_fw(tp);
 
@@ -9361,6 +9363,13 @@ static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 
 		/* And make sure the next sample is new data */
 		memset(tp->hw_stats, 0, sizeof(struct tg3_hw_stats));
+
+		for (i = 0; i < TG3_IRQ_MAX_VECS; ++i) {
+			struct tg3_napi *tnapi = &tp->napi[i];
+
+			tnapi->rx_dropped = 0;
+			tnapi->tx_dropped = 0;
+		}
 	}
 
 	return err;
@@ -11915,6 +11924,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 {
 	struct rtnl_link_stats64 *old_stats = &tp->net_stats_prev;
 	struct tg3_hw_stats *hw_stats = tp->hw_stats;
+	unsigned long rx_dropped;
+	unsigned long tx_dropped;
+	int i;
 
 	stats->rx_packets = old_stats->rx_packets +
 		get_stat64(&hw_stats->rx_ucast_packets) +
@@ -11961,8 +11973,26 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 	stats->rx_missed_errors = old_stats->rx_missed_errors +
 		get_stat64(&hw_stats->rx_discards);
 
-	stats->rx_dropped = tp->rx_dropped;
-	stats->tx_dropped = tp->tx_dropped;
+	/* Aggregate per-queue counters. The per-queue counters are updated
+	 * by a single writer, race-free. The result computed by this loop
+	 * might not be 100% accurate (counters can be updated in the middle of
+	 * the loop) but the next tg3_get_nstats() will recompute the current
+	 * value so it is acceptable.
+	 *
+	 * Note that these counters wrap around at 4G on 32bit machines.
+	 */
+	rx_dropped = (unsigned long)(old_stats->rx_dropped);
+	tx_dropped = (unsigned long)(old_stats->tx_dropped);
+
+	for (i = 0; i < tp->irq_cnt; i++) {
+		struct tg3_napi *tnapi = &tp->napi[i];
+
+		rx_dropped += tnapi->rx_dropped;
+		tx_dropped += tnapi->tx_dropped;
+	}
+
+	stats->rx_dropped = rx_dropped;
+	stats->tx_dropped = tx_dropped;
 }
 
 static int tg3_get_regs_len(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index 1000c894064f..8d753f8c5b06 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3018,6 +3018,7 @@ struct tg3_napi {
 	u16				*rx_rcb_prod_idx;
 	struct tg3_rx_prodring_set	prodring;
 	struct tg3_rx_buffer_desc	*rx_rcb;
+	unsigned long			rx_dropped;
 
 	u32				tx_prod	____cacheline_aligned;
 	u32				tx_cons;
@@ -3026,6 +3027,7 @@ struct tg3_napi {
 	u32				prodmbox;
 	struct tg3_tx_buffer_desc	*tx_ring;
 	struct tg3_tx_ring_info		*tx_buffers;
+	unsigned long			tx_dropped;
 
 	dma_addr_t			status_mapping;
 	dma_addr_t			rx_rcb_mapping;
@@ -3219,8 +3221,6 @@ struct tg3 {
 
 
 	/* begin "everything else" cacheline(s) section */
-	unsigned long			rx_dropped;
-	unsigned long			tx_dropped;
 	struct rtnl_link_stats64	net_stats_prev;
 	struct tg3_ethtool_stats	estats_prev;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 4a448138b4ec..1f44a6463f45 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -66,6 +66,27 @@ static enum mac_mode hns_get_enet_interface(const struct hns_mac_cb *mac_cb)
 	}
 }
 
+static u32 hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv)
+{
+#define HNS_MAC_LINK_WAIT_TIME 5
+#define HNS_MAC_LINK_WAIT_CNT 40
+
+	u32 link_status = 0;
+	int i;
+
+	if (!mac_ctrl_drv->get_link_status)
+		return link_status;
+
+	for (i = 0; i < HNS_MAC_LINK_WAIT_CNT; i++) {
+		msleep(HNS_MAC_LINK_WAIT_TIME);
+		mac_ctrl_drv->get_link_status(mac_ctrl_drv, &link_status);
+		if (!link_status)
+			break;
+	}
+
+	return link_status;
+}
+
 void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
 {
 	struct mac_driver *mac_ctrl_drv;
@@ -83,6 +104,14 @@ void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
 							       &sfp_prsnt);
 		if (!ret)
 			*link_status = *link_status && sfp_prsnt;
+
+		/* for FIBER port, it may have a fake link up.
+		 * when the link status changes from down to up, we need to do
+		 * anti-shake. the anti-shake time is base on tests.
+		 * only FIBER port need to do this.
+		 */
+		if (*link_status && !mac_cb->link)
+			*link_status = hns_mac_link_anti_shake(mac_ctrl_drv);
 	}
 
 	mac_cb->link = *link_status;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 64e1f6f407b4..36e387ae967f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15480,7 +15480,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 	if (val < MAX_FRAME_SIZE_DEFAULT)
 		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 i, val);
+			 pf->hw.port, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index c6d408de0605..fc4ca8246df2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -254,9 +254,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 	if (is_otx2_lbkvf(pfvf->pdev))
 		return;
 
+	mutex_lock(&pfvf->mbox.lock);
 	req = otx2_mbox_alloc_msg_cgx_cfg_pause_frm(&pfvf->mbox);
-	if (!req)
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
 		return;
+	}
 
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pause_frm_cfg *)
@@ -264,6 +267,7 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 		pause->rx_pause = rsp->rx_pause;
 		pause->tx_pause = rsp->tx_pause;
 	}
+	mutex_unlock(&pfvf->mbox.lock);
 }
 
 static int otx2_set_pauseparam(struct net_device *netdev,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 6c243b17312c..64d27e8e0772 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -191,7 +191,7 @@ struct ionic_desc_info {
 	void *cb_arg;
 };
 
-#define IONIC_QUEUE_NAME_MAX_SZ		32
+#define IONIC_QUEUE_NAME_MAX_SZ		16
 
 struct ionic_queue {
 	struct device *dev;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 098772601df8..49c28134ac2c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -45,24 +45,24 @@ static void ionic_lif_queue_identify(struct ionic_lif *lif);
 static void ionic_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
+	struct ionic_intr_info *intr;
 	struct dim_cq_moder cur_moder;
 	struct ionic_qcq *qcq;
+	struct ionic_lif *lif;
 	u32 new_coal;
 
 	cur_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	qcq = container_of(dim, struct ionic_qcq, dim);
-	new_coal = ionic_coal_usec_to_hw(qcq->q.lif->ionic, cur_moder.usec);
+	lif = qcq->q.lif;
+	new_coal = ionic_coal_usec_to_hw(lif->ionic, cur_moder.usec);
 	new_coal = new_coal ? new_coal : 1;
 
-	if (qcq->intr.dim_coal_hw != new_coal) {
-		unsigned int qi = qcq->cq.bound_q->index;
-		struct ionic_lif *lif = qcq->q.lif;
-
-		qcq->intr.dim_coal_hw = new_coal;
+	intr = &qcq->intr;
+	if (intr->dim_coal_hw != new_coal) {
+		intr->dim_coal_hw = new_coal;
 
 		ionic_intr_coal_init(lif->ionic->idev.intr_ctrl,
-				     lif->rxqcqs[qi]->intr.index,
-				     qcq->intr.dim_coal_hw);
+				     intr->index, intr->dim_coal_hw);
 	}
 
 	dim->state = DIM_START_MEASURE;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 88253cedd9d9..c72ff0fd38c4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -205,6 +205,7 @@ enum rtl_registers {
 					/* No threshold before first PCI xfer */
 #define	RX_FIFO_THRESH			(7 << RXCFG_FIFO_SHIFT)
 #define	RX_EARLY_OFF			(1 << 11)
+#define	RX_PAUSE_SLOT_ON		(1 << 11)	/* 8125b and later */
 #define	RXCFG_DMA_SHIFT			8
 					/* Unlimited maximum PCI burst. */
 #define	RX_DMA_BURST			(7 << RXCFG_DMA_SHIFT)
@@ -2318,9 +2319,13 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_52:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
 		break;
-	case RTL_GIGA_MAC_VER_60 ... RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
+	case RTL_GIGA_MAC_VER_63:
+		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
+			RX_PAUSE_SLOT_ON);
+		break;
 	default:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
 		break;
diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
index ca7bf7f897d3..c8cbd85adcf9 100644
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -3,5 +3,6 @@ config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on HYPERV
 	select UCS2_STRING
+	select NLS
 	help
 	  Select this option to enable the Hyper-V virtual network driver.
diff --git a/drivers/of/base.c b/drivers/of/base.c
index a44a0e7ba251..eb02974f36bd 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -244,7 +244,7 @@ struct device_node *__of_find_all_nodes(struct device_node *prev)
  * @prev:	Previous node or NULL to start iteration
  *		of_node_put() will be called on it
  *
- * Returns a node pointer with refcount incremented, use
+ * Return: A node pointer with refcount incremented, use
  * of_node_put() on it when done.
  */
 struct device_node *of_find_all_nodes(struct device_node *prev)
@@ -305,7 +305,7 @@ bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
 	return (u32)phys_id == cpu;
 }
 
-/**
+/*
  * Checks if the given "prop_name" property holds the physical id of the
  * core/thread corresponding to the logical cpu 'cpu'. If 'thread' is not
  * NULL, local thread number within the core is returned in it.
@@ -374,7 +374,7 @@ bool __weak arch_find_n_match_cpu_physical_id(struct device_node *cpun,
  * before booting secondary cores. This function uses arch_match_cpu_phys_id
  * which can be overridden by architecture specific implementation.
  *
- * Returns a node pointer for the logical cpu with refcount incremented, use
+ * Return: A node pointer for the logical cpu with refcount incremented, use
  * of_node_put() on it when done. Returns NULL if not found.
  */
 struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
@@ -394,8 +394,8 @@ EXPORT_SYMBOL(of_get_cpu_node);
  *
  * @cpu_node: Pointer to the device_node for CPU.
  *
- * Returns the logical CPU number of the given CPU device_node.
- * Returns -ENODEV if the CPU is not found.
+ * Return: The logical CPU number of the given CPU device_node or -ENODEV if the
+ * CPU is not found.
  */
 int of_cpu_node_to_id(struct device_node *cpu_node)
 {
@@ -427,7 +427,7 @@ EXPORT_SYMBOL(of_cpu_node_to_id);
  * bindings. This function check for both and returns the idle state node for
  * the requested index.
  *
- * In case an idle state node is found at @index, the refcount is incremented
+ * Return: An idle state node if found at @index. The refcount is incremented
  * for it, so call of_node_put() on it when done. Returns NULL if not found.
  */
 struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
@@ -561,7 +561,7 @@ int of_device_compatible_match(struct device_node *device,
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
  *
- * Returns a positive integer if the root node has the given value in its
+ * Return: A positive integer if the root node has the given value in its
  * compatible property.
  */
 int of_machine_is_compatible(const char *compat)
@@ -583,7 +583,7 @@ EXPORT_SYMBOL(of_machine_is_compatible);
  *
  *  @device: Node to check for availability, with locks already held
  *
- *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  Return: True if the status property is absent or set to "okay" or "ok",
  *  false otherwise
  */
 static bool __of_device_is_available(const struct device_node *device)
@@ -611,7 +611,7 @@ static bool __of_device_is_available(const struct device_node *device)
  *
  *  @device: Node to check for availability
  *
- *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  Return: True if the status property is absent or set to "okay" or "ok",
  *  false otherwise
  */
 bool of_device_is_available(const struct device_node *device)
@@ -632,7 +632,7 @@ EXPORT_SYMBOL(of_device_is_available);
  *
  *  @device: Node to check for endianness
  *
- *  Returns true if the device has a "big-endian" property, or if the kernel
+ *  Return: True if the device has a "big-endian" property, or if the kernel
  *  was compiled for BE *and* the device has a "native-endian" property.
  *  Returns false otherwise.
  *
@@ -651,11 +651,11 @@ bool of_device_is_big_endian(const struct device_node *device)
 EXPORT_SYMBOL(of_device_is_big_endian);
 
 /**
- *	of_get_parent - Get a node's parent if any
- *	@node:	Node to get parent
+ * of_get_parent - Get a node's parent if any
+ * @node:	Node to get parent
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_get_parent(const struct device_node *node)
 {
@@ -673,15 +673,15 @@ struct device_node *of_get_parent(const struct device_node *node)
 EXPORT_SYMBOL(of_get_parent);
 
 /**
- *	of_get_next_parent - Iterate to a node's parent
- *	@node:	Node to get parent of
+ * of_get_next_parent - Iterate to a node's parent
+ * @node:	Node to get parent of
  *
- *	This is like of_get_parent() except that it drops the
- *	refcount on the passed node, making it suitable for iterating
- *	through a node's parents.
+ * This is like of_get_parent() except that it drops the
+ * refcount on the passed node, making it suitable for iterating
+ * through a node's parents.
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_get_next_parent(struct device_node *node)
 {
@@ -719,13 +719,13 @@ static struct device_node *__of_get_next_child(const struct device_node *node,
 	     child = __of_get_next_child(parent, child))
 
 /**
- *	of_get_next_child - Iterate a node childs
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
+ * of_get_next_child - Iterate a node childs
+ * @node:	parent node
+ * @prev:	previous child of the parent node, or NULL to get first
  *
- *	Returns a node pointer with refcount incremented, use of_node_put() on
- *	it when done. Returns NULL when prev is the last child. Decrements the
- *	refcount of prev.
+ * Return: A node pointer with refcount incremented, use of_node_put() on
+ * it when done. Returns NULL when prev is the last child. Decrements the
+ * refcount of prev.
  */
 struct device_node *of_get_next_child(const struct device_node *node,
 	struct device_node *prev)
@@ -741,12 +741,12 @@ struct device_node *of_get_next_child(const struct device_node *node,
 EXPORT_SYMBOL(of_get_next_child);
 
 /**
- *	of_get_next_available_child - Find the next available child node
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
+ * of_get_next_available_child - Find the next available child node
+ * @node:	parent node
+ * @prev:	previous child of the parent node, or NULL to get first
  *
- *      This function is like of_get_next_child(), except that it
- *      automatically skips any disabled nodes (i.e. status = "disabled").
+ * This function is like of_get_next_child(), except that it
+ * automatically skips any disabled nodes (i.e. status = "disabled").
  */
 struct device_node *of_get_next_available_child(const struct device_node *node,
 	struct device_node *prev)
@@ -772,12 +772,12 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
 EXPORT_SYMBOL(of_get_next_available_child);
 
 /**
- *	of_get_next_cpu_node - Iterate on cpu nodes
- *	@prev:	previous child of the /cpus node, or NULL to get first
+ * of_get_next_cpu_node - Iterate on cpu nodes
+ * @prev:	previous child of the /cpus node, or NULL to get first
  *
- *	Returns a cpu node pointer with refcount incremented, use of_node_put()
- *	on it when done. Returns NULL when prev is the last child. Decrements
- *	the refcount of prev.
+ * Return: A cpu node pointer with refcount incremented, use of_node_put()
+ * on it when done. Returns NULL when prev is the last child. Decrements
+ * the refcount of prev.
  */
 struct device_node *of_get_next_cpu_node(struct device_node *prev)
 {
@@ -816,7 +816,7 @@ EXPORT_SYMBOL(of_get_next_cpu_node);
  * Lookup child node whose compatible property contains the given compatible
  * string.
  *
- * Returns a node pointer with refcount incremented, use of_node_put() on it
+ * Return: a node pointer with refcount incremented, use of_node_put() on it
  * when done; or NULL if not found.
  */
 struct device_node *of_get_compatible_child(const struct device_node *parent,
@@ -834,15 +834,15 @@ struct device_node *of_get_compatible_child(const struct device_node *parent,
 EXPORT_SYMBOL(of_get_compatible_child);
 
 /**
- *	of_get_child_by_name - Find the child node by name for a given parent
- *	@node:	parent node
- *	@name:	child name to look for.
+ * of_get_child_by_name - Find the child node by name for a given parent
+ * @node:	parent node
+ * @name:	child name to look for.
  *
- *      This function looks for child node for given matching name
+ * This function looks for child node for given matching name
  *
- *	Returns a node pointer if found, with refcount incremented, use
- *	of_node_put() on it when done.
- *	Returns NULL if node is not found.
+ * Return: A node pointer if found, with refcount incremented, use
+ * of_node_put() on it when done.
+ * Returns NULL if node is not found.
  */
 struct device_node *of_get_child_by_name(const struct device_node *node,
 				const char *name)
@@ -893,22 +893,22 @@ struct device_node *__of_find_node_by_full_path(struct device_node *node,
 }
 
 /**
- *	of_find_node_opts_by_path - Find a node matching a full OF path
- *	@path: Either the full path to match, or if the path does not
- *	       start with '/', the name of a property of the /aliases
- *	       node (an alias).  In the case of an alias, the node
- *	       matching the alias' value will be returned.
- *	@opts: Address of a pointer into which to store the start of
- *	       an options string appended to the end of the path with
- *	       a ':' separator.
- *
- *	Valid paths:
- *		/foo/bar	Full path
- *		foo		Valid alias
- *		foo/bar		Valid alias + relative path
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_node_opts_by_path - Find a node matching a full OF path
+ * @path: Either the full path to match, or if the path does not
+ *       start with '/', the name of a property of the /aliases
+ *       node (an alias).  In the case of an alias, the node
+ *       matching the alias' value will be returned.
+ * @opts: Address of a pointer into which to store the start of
+ *       an options string appended to the end of the path with
+ *       a ':' separator.
+ *
+ * Valid paths:
+ *  * /foo/bar	Full path
+ *  * foo	Valid alias
+ *  * foo/bar	Valid alias + relative path
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_opts_by_path(const char *path, const char **opts)
 {
@@ -958,15 +958,15 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 EXPORT_SYMBOL(of_find_node_opts_by_path);
 
 /**
- *	of_find_node_by_name - Find a node by its "name" property
- *	@from:	The node to start searching from or NULL; the node
+ * of_find_node_by_name - Find a node by its "name" property
+ * @from:	The node to start searching from or NULL; the node
  *		you pass will not be searched, only the next one
  *		will. Typically, you pass what the previous call
  *		returned. of_node_put() will be called on @from.
- *	@name:	The name string to match against
+ * @name:	The name string to match against
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_name(struct device_node *from,
 	const char *name)
@@ -985,16 +985,16 @@ struct device_node *of_find_node_by_name(struct device_node *from,
 EXPORT_SYMBOL(of_find_node_by_name);
 
 /**
- *	of_find_node_by_type - Find a node by its "device_type" property
- *	@from:	The node to start searching from, or NULL to start searching
+ * of_find_node_by_type - Find a node by its "device_type" property
+ * @from:	The node to start searching from, or NULL to start searching
  *		the entire device tree. The node you pass will not be
  *		searched, only the next one will; typically, you pass
  *		what the previous call returned. of_node_put() will be
  *		called on from for you.
- *	@type:	The type string to match against
+ * @type:	The type string to match against
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_type(struct device_node *from,
 	const char *type)
@@ -1013,18 +1013,18 @@ struct device_node *of_find_node_by_type(struct device_node *from,
 EXPORT_SYMBOL(of_find_node_by_type);
 
 /**
- *	of_find_compatible_node - Find a node based on type and one of the
+ * of_find_compatible_node - Find a node based on type and one of the
  *                                tokens in its "compatible" property
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@type:		The type string to match "device_type" or NULL to ignore
- *	@compatible:	The string to match to one of the tokens in the device
- *			"compatible" list.
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @type:	The type string to match "device_type" or NULL to ignore
+ * @compatible:	The string to match to one of the tokens in the device
+ *		"compatible" list.
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_compatible_node(struct device_node *from,
 	const char *type, const char *compatible)
@@ -1044,16 +1044,16 @@ struct device_node *of_find_compatible_node(struct device_node *from,
 EXPORT_SYMBOL(of_find_compatible_node);
 
 /**
- *	of_find_node_with_property - Find a node which has a property with
- *                                   the given name.
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@prop_name:	The name of the property to look for.
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_node_with_property - Find a node which has a property with
+ *                              the given name.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @prop_name:	The name of the property to look for.
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_with_property(struct device_node *from,
 	const char *prop_name)
@@ -1102,10 +1102,10 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
 
 /**
  * of_match_node - Tell if a device_node has a matching of_match structure
- *	@matches:	array of of device match structures to search in
- *	@node:		the of device structure to match against
+ * @matches:	array of of device match structures to search in
+ * @node:	the of device structure to match against
  *
- *	Low level utility function used by device matching.
+ * Low level utility function used by device matching.
  */
 const struct of_device_id *of_match_node(const struct of_device_id *matches,
 					 const struct device_node *node)
@@ -1121,17 +1121,17 @@ const struct of_device_id *of_match_node(const struct of_device_id *matches,
 EXPORT_SYMBOL(of_match_node);
 
 /**
- *	of_find_matching_node_and_match - Find a node based on an of_device_id
- *					  match table.
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@matches:	array of of device match structures to search in
- *	@match		Updated to point at the matches entry which matched
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_matching_node_and_match - Find a node based on an of_device_id
+ *				     match table.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @matches:	array of of device match structures to search in
+ * @match:	Updated to point at the matches entry which matched
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_matching_node_and_match(struct device_node *from,
 					const struct of_device_id *matches,
@@ -1170,7 +1170,7 @@ EXPORT_SYMBOL(of_find_matching_node_and_match);
  * It does this by stripping the manufacturer prefix (as delimited by a ',')
  * from the first entry in the compatible list property.
  *
- * This routine returns 0 on success, <0 on failure.
+ * Return: This routine returns 0 on success, <0 on failure.
  */
 int of_modalias_node(struct device_node *node, char *modalias, int len)
 {
@@ -1190,7 +1190,7 @@ EXPORT_SYMBOL_GPL(of_modalias_node);
  * of_find_node_by_phandle - Find a node given a phandle
  * @handle:	phandle of the node to find
  *
- * Returns a node pointer with refcount incremented, use
+ * Return: A node pointer with refcount incremented, use
  * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_phandle(phandle handle)
@@ -1431,7 +1431,7 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
  * @index: For properties holding a table of phandles, this is the index into
  *         the table
  *
- * Returns the device_node pointer with refcount incremented.  Use
+ * Return: The device_node pointer with refcount incremented.  Use
  * of_node_put() on it when done.
  */
 struct device_node *of_parse_phandle(const struct device_node *np,
@@ -1465,21 +1465,21 @@ EXPORT_SYMBOL(of_parse_phandle);
  * Caller is responsible to call of_node_put() on the returned out_args->np
  * pointer.
  *
- * Example:
+ * Example::
  *
- * phandle1: node1 {
+ *  phandle1: node1 {
  *	#list-cells = <2>;
- * }
+ *  };
  *
- * phandle2: node2 {
+ *  phandle2: node2 {
  *	#list-cells = <1>;
- * }
+ *  };
  *
- * node3 {
+ *  node3 {
  *	list = <&phandle1 1 2 &phandle2 3>;
- * }
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
+ * To get a device_node of the ``node2`` node you may call this:
  * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
  */
 int of_parse_phandle_with_args(const struct device_node *np, const char *list_name,
@@ -1517,29 +1517,29 @@ EXPORT_SYMBOL(of_parse_phandle_with_args);
  * Caller is responsible to call of_node_put() on the returned out_args->np
  * pointer.
  *
- * Example:
+ * Example::
  *
- * phandle1: node1 {
- *	#list-cells = <2>;
- * }
+ *  phandle1: node1 {
+ *  	#list-cells = <2>;
+ *  };
  *
- * phandle2: node2 {
- *	#list-cells = <1>;
- * }
+ *  phandle2: node2 {
+ *  	#list-cells = <1>;
+ *  };
  *
- * phandle3: node3 {
- * 	#list-cells = <1>;
- * 	list-map = <0 &phandle2 3>,
- * 		   <1 &phandle2 2>,
- * 		   <2 &phandle1 5 1>;
- *	list-map-mask = <0x3>;
- * };
+ *  phandle3: node3 {
+ *  	#list-cells = <1>;
+ *  	list-map = <0 &phandle2 3>,
+ *  		   <1 &phandle2 2>,
+ *  		   <2 &phandle1 5 1>;
+ *  	list-map-mask = <0x3>;
+ *  };
  *
- * node4 {
- *	list = <&phandle1 1 2 &phandle3 0>;
- * }
+ *  node4 {
+ *  	list = <&phandle1 1 2 &phandle3 0>;
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
+ * To get a device_node of the ``node2`` node you may call this:
  * of_parse_phandle_with_args(node4, "list", "list", 1, &args);
  */
 int of_parse_phandle_with_args_map(const struct device_node *np,
@@ -1699,19 +1699,19 @@ EXPORT_SYMBOL(of_parse_phandle_with_args_map);
  * Caller is responsible to call of_node_put() on the returned out_args->np
  * pointer.
  *
- * Example:
+ * Example::
  *
- * phandle1: node1 {
- * }
+ *  phandle1: node1 {
+ *  };
  *
- * phandle2: node2 {
- * }
+ *  phandle2: node2 {
+ *  };
  *
- * node3 {
- *	list = <&phandle1 0 2 &phandle2 2 3>;
- * }
+ *  node3 {
+ *  	list = <&phandle1 0 2 &phandle2 2 3>;
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
+ * To get a device_node of the ``node2`` node you may call this:
  * of_parse_phandle_with_fixed_args(node3, "list", 2, 1, &args);
  */
 int of_parse_phandle_with_fixed_args(const struct device_node *np,
@@ -1731,7 +1731,7 @@ EXPORT_SYMBOL(of_parse_phandle_with_fixed_args);
  * @list_name:	property name that contains a list
  * @cells_name:	property name that specifies phandles' arguments count
  *
- * Returns the number of phandle + argument tuples within a property. It
+ * Return: The number of phandle + argument tuples within a property. It
  * is a typical pattern to encode a list of phandle and variable
  * arguments into a single property. The number of arguments is encoded
  * by a property in the phandle-target node. For example, a gpios
@@ -1779,6 +1779,8 @@ EXPORT_SYMBOL(of_count_phandle_with_args);
 
 /**
  * __of_add_property - Add a property to a node without lock operations
+ * @np:		Caller's Device Node
+ * @prob:	Property to add
  */
 int __of_add_property(struct device_node *np, struct property *prop)
 {
@@ -1800,6 +1802,8 @@ int __of_add_property(struct device_node *np, struct property *prop)
 
 /**
  * of_add_property - Add a property to a node
+ * @np:		Caller's Device Node
+ * @prob:	Property to add
  */
 int of_add_property(struct device_node *np, struct property *prop)
 {
@@ -1844,6 +1848,8 @@ int __of_remove_property(struct device_node *np, struct property *prop)
 
 /**
  * of_remove_property - Remove a property from a node.
+ * @np:		Caller's Device Node
+ * @prob:	Property to remove
  *
  * Note that we don't actually remove it, since we have given out
  * who-knows-how-many pointers to the data using get-property.
@@ -1951,13 +1957,12 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 
 /**
  * of_alias_scan - Scan all properties of the 'aliases' node
+ * @dt_alloc:	An allocator that provides a virtual address to memory
+ *		for storing the resulting tree
  *
  * The function scans all the properties of the 'aliases' node and populates
  * the global lookup table with the properties.  It returns the
  * number of alias properties found, or an error code in case of failure.
- *
- * @dt_alloc:	An allocator that provides a virtual address to memory
- *		for storing the resulting tree
  */
 void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 {
@@ -2026,7 +2031,9 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
  * @stem:	Alias stem of the given device_node
  *
  * The function travels the lookup table to get the alias id for the given
- * device_node and alias stem.  It returns the alias id if found.
+ * device_node and alias stem.
+ *
+ * Return: The alias id if found.
  */
 int of_alias_get_id(struct device_node *np, const char *stem)
 {
@@ -2130,13 +2137,14 @@ EXPORT_SYMBOL_GPL(of_alias_get_highest_id);
 
 /**
  * of_console_check() - Test and setup console for DT setup
- * @dn - Pointer to device node
- * @name - Name to use for preferred console without index. ex. "ttyS"
- * @index - Index to use for preferred console.
+ * @dn: Pointer to device node
+ * @name: Name to use for preferred console without index. ex. "ttyS"
+ * @index: Index to use for preferred console.
  *
  * Check if the given device node matches the stdout-path property in the
- * /chosen node. If it does then register it as the preferred console and return
- * TRUE. Otherwise return FALSE.
+ * /chosen node. If it does then register it as the preferred console.
+ *
+ * Return: TRUE if console successfully setup. Otherwise return FALSE.
  */
 bool of_console_check(struct device_node *dn, char *name, int index)
 {
@@ -2152,12 +2160,12 @@ bool of_console_check(struct device_node *dn, char *name, int index)
 EXPORT_SYMBOL_GPL(of_console_check);
 
 /**
- *	of_find_next_cache_node - Find a node's subsidiary cache
- *	@np:	node of type "cpu" or "cache"
+ * of_find_next_cache_node - Find a node's subsidiary cache
+ * @np:	node of type "cpu" or "cache"
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.  Caller should hold a reference
- *	to np.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.  Caller should hold a reference
+ * to np.
  */
 struct device_node *of_find_next_cache_node(const struct device_node *np)
 {
@@ -2187,7 +2195,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
  *
  * @cpu: cpu number(logical index) for which the last cache level is needed
  *
- * Returns the the level at which the last cache is present. It is exactly
+ * Return: The the level at which the last cache is present. It is exactly
  * same as  the total number of cache levels for the given logical cpu.
  */
 int of_find_last_cache_level(unsigned int cpu)
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 7d0232af9c23..b6a3ee65437b 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -27,7 +27,7 @@ static struct device_node *kobj_to_device_node(struct kobject *kobj)
  * @node:	Node to inc refcount, NULL is supported to simplify writing of
  *		callers
  *
- * Returns node.
+ * Return: The node with refcount incremented.
  */
 struct device_node *of_node_get(struct device_node *node)
 {
@@ -103,8 +103,10 @@ int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
  * @arg		- argument of the of notifier
  *
  * Returns the new state of a device based on the notifier used.
- * Returns 0 on device going from enabled to disabled, 1 on device
- * going from disabled to enabled and -1 on no change.
+ *
+ * Return: OF_RECONFIG_CHANGE_REMOVE on device going from enabled to
+ * disabled, OF_RECONFIG_CHANGE_ADD on device going from disabled to
+ * enabled and OF_RECONFIG_NO_CHANGE on no change.
  */
 int of_reconfig_get_state_change(unsigned long action, struct of_reconfig_data *pr)
 {
@@ -370,7 +372,8 @@ void of_node_release(struct kobject *kobj)
  * property structure and the property name & contents. The property's
  * flags have the OF_DYNAMIC bit set so that we can differentiate between
  * dynamically allocated properties and not.
- * Returns the newly allocated property or NULL on out of memory error.
+ *
+ * Return: The newly allocated property or NULL on out of memory error.
  */
 struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
 {
@@ -413,7 +416,7 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
  * another node.  The node data are dynamically allocated and all the node
  * flags have the OF_DYNAMIC & OF_DETACHED bits set.
  *
- * Returns the newly allocated node or NULL on out of memory error.
+ * Return: The newly allocated node or NULL on out of memory error.
  */
 struct device_node *__of_node_dup(const struct device_node *np,
 				  const char *full_name)
@@ -764,7 +767,8 @@ static int __of_changeset_apply(struct of_changeset *ocs)
  * Any side-effects of live tree state changes are applied here on
  * success, like creation/destruction of devices and side-effects
  * like creation of sysfs properties and directories.
- * Returns 0 on success, a negative error value in case of an error.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
  * On error the partially applied effects are reverted.
  */
 int of_changeset_apply(struct of_changeset *ocs)
@@ -858,7 +862,8 @@ static int __of_changeset_revert(struct of_changeset *ocs)
  * was before the application.
  * Any side-effects like creation/destruction of devices and
  * removal of sysfs properties and directories are applied.
- * Returns 0 on success, a negative error value in case of an error.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
  */
 int of_changeset_revert(struct of_changeset *ocs)
 {
@@ -886,7 +891,8 @@ EXPORT_SYMBOL_GPL(of_changeset_revert);
  * + OF_RECONFIG_ADD_PROPERTY
  * + OF_RECONFIG_REMOVE_PROPERTY,
  * + OF_RECONFIG_UPDATE_PROPERTY
- * Returns 0 on success, a negative error value in case of an error.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
  */
 int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 		struct device_node *np, struct property *prop)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 5a1b8688b460..384510d0200c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -282,7 +282,7 @@ static void reverse_nodes(struct device_node *parent)
  * @dad: Parent struct device_node
  * @nodepp: The device_node tree created by the call
  *
- * It returns the size of unflattened device tree or error code
+ * Return: The size of unflattened device tree or error code
  */
 static int unflatten_dt_nodes(const void *blob,
 			      void *mem,
@@ -349,11 +349,6 @@ static int unflatten_dt_nodes(const void *blob,
 
 /**
  * __unflatten_device_tree - create tree of device_nodes from flat blob
- *
- * unflattens a device-tree, creating the
- * tree of struct device_node. It also fills the "name" and "type"
- * pointers of the nodes so the normal device-tree walking functions
- * can be used.
  * @blob: The blob to expand
  * @dad: Parent device node
  * @mynodes: The device_node tree created by the call
@@ -361,7 +356,11 @@ static int unflatten_dt_nodes(const void *blob,
  * for the resulting tree
  * @detached: if true set OF_DETACHED on @mynodes
  *
- * Returns NULL on failure or the memory chunk containing the unflattened
+ * unflattens a device-tree, creating the tree of struct device_node. It also
+ * fills the "name" and "type" pointers of the nodes so the normal device-tree
+ * walking functions can be used.
+ *
+ * Return: NULL on failure or the memory chunk containing the unflattened
  * device tree on success.
  */
 void *__unflatten_device_tree(const void *blob,
@@ -442,7 +441,7 @@ static DEFINE_MUTEX(of_fdt_unflatten_mutex);
  * pointers of the nodes so the normal device-tree walking functions
  * can be used.
  *
- * Returns NULL on failure or the memory chunk containing the unflattened
+ * Return: NULL on failure or the memory chunk containing the unflattened
  * device tree on success.
  */
 void *of_fdt_unflatten_tree(const unsigned long *blob,
@@ -716,7 +715,7 @@ const void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
  * @node: node to test
  * @compat: compatible string to compare with compatible list.
  *
- * On match, returns a non-zero value with smaller values returned for more
+ * Return: a non-zero value on match with smaller values returned for more
  * specific compatible values.
  */
 static int of_fdt_is_compatible(const void *blob,
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 25d17b8a1a1a..352e14b007e7 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -48,7 +48,7 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
  * of_irq_find_parent - Given a device node, find its interrupt parent node
  * @child: pointer to device node
  *
- * Returns a pointer to the interrupt parent node, or NULL if the interrupt
+ * Return: A pointer to the interrupt parent node, or NULL if the interrupt
  * parent could not be determined.
  */
 struct device_node *of_irq_find_parent(struct device_node *child)
@@ -81,14 +81,14 @@ EXPORT_SYMBOL_GPL(of_irq_find_parent);
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
  * @out_irq:	structure of_phandle_args updated by this function
  *
- * Returns 0 on success and a negative number on error
- *
  * This function is a low-level interrupt tree walking function. It
  * can be used to do a partial walk with synthetized reg and interrupts
  * properties, for example when resolving PCI interrupts when no device
  * node exist for the parent. It takes an interrupt specifier structure as
  * input, walks the tree looking for any interrupt-map properties, translates
  * the specifier for each map, and then returns the translated map.
+ *
+ * Return: 0 on success and a negative number on error
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
@@ -380,7 +380,7 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource);
  * @dev: pointer to device tree node
  * @index: zero-based index of the IRQ
  *
- * Returns Linux IRQ number on success, or 0 on the IRQ mapping failure, or
+ * Return: Linux IRQ number on success, or 0 on the IRQ mapping failure, or
  * -EPROBE_DEFER if the IRQ domain is not yet created, or error code in case
  * of any other failure.
  */
@@ -407,7 +407,7 @@ EXPORT_SYMBOL_GPL(of_irq_get);
  * @dev: pointer to device tree node
  * @name: IRQ name
  *
- * Returns Linux IRQ number on success, or 0 on the IRQ mapping failure, or
+ * Return: Linux IRQ number on success, or 0 on the IRQ mapping failure, or
  * -EPROBE_DEFER if the IRQ domain is not yet created, or error code in case
  * of any other failure.
  */
@@ -447,7 +447,7 @@ int of_irq_count(struct device_node *dev)
  * @res: array of resources to fill in
  * @nr_irqs: the number of IRQs (and upper bound for num of @res elements)
  *
- * Returns the size of the filled in table (up to @nr_irqs).
+ * Return: The size of the filled in table (up to @nr_irqs).
  */
 int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
 		int nr_irqs)
@@ -602,7 +602,7 @@ static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
  * Walk up the device hierarchy looking for devices with a "msi-map"
  * property.  If found, apply the mapping to @id_in.
  *
- * Returns the mapped MSI ID.
+ * Return: The mapped MSI ID.
  */
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
 {
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 67b404f36e79..3ac874e2be08 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -296,7 +296,7 @@ static struct property *dup_and_fixup_symbol_prop(
  *
  * Update of property in symbols node is not allowed.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay.
  */
 static int add_changeset_property(struct overlay_changeset *ovcs,
@@ -401,7 +401,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
  *
  * NOTE_2: Multiple mods of created nodes not supported.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay.
  */
 static int add_changeset_node(struct overlay_changeset *ovcs,
@@ -473,7 +473,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
  *
  * Do not allow symbols node to have any children.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay_node.
  */
 static int build_changeset_next_level(struct overlay_changeset *ovcs,
@@ -604,7 +604,7 @@ static int find_dup_cset_prop(struct overlay_changeset *ovcs,
  * the same node or duplicate {add, delete, or update} properties entries
  * for the same property.
  *
- * Returns 0 on success, or -EINVAL if duplicate changeset entry found.
+ * Return: 0 on success, or -EINVAL if duplicate changeset entry found.
  */
 static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
 {
@@ -628,7 +628,7 @@ static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
  * any portions of the changeset that were successfully created will remain
  * in @ovcs->cset.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid overlay in @ovcs->fragments[].
  */
 static int build_changeset(struct overlay_changeset *ovcs)
@@ -724,7 +724,7 @@ static struct device_node *find_target(struct device_node *info_node)
  * the top level of @tree.  The relevant top level nodes are the fragment
  * nodes and the __symbols__ node.  Any other top level node will be ignored.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
+ * Return: 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
  * detected in @tree, or -ENOSPC if idr_alloc() error.
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
@@ -1179,7 +1179,7 @@ static int overlay_removal_is_ok(struct overlay_changeset *remove_ovcs)
  * If an error is returned by an overlay changeset post-remove notifier
  * then no further overlay changeset post-remove notifier will be called.
  *
- * Returns 0 on success, or a negative error number.  *ovcs_id is set to
+ * Return: 0 on success, or a negative error number.  *ovcs_id is set to
  * zero after reverting the changeset, even if a subsequent error occurs.
  */
 int of_overlay_remove(int *ovcs_id)
@@ -1257,7 +1257,7 @@ EXPORT_SYMBOL_GPL(of_overlay_remove);
  *
  * Removes all overlays from the system in the correct order.
  *
- * Returns 0 on success, or a negative error number
+ * Return: 0 on success, or a negative error number
  */
 int of_overlay_remove_all(void)
 {
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b557a0fcd4ba..43748c6480c8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -44,7 +44,7 @@ static const struct of_device_id of_skipped_node_table[] = {
  * Takes a reference to the embedded struct device which needs to be dropped
  * after use.
  *
- * Returns platform_device pointer, or NULL if not found
+ * Return: platform_device pointer, or NULL if not found
  */
 struct platform_device *of_find_device_by_node(struct device_node *np)
 {
@@ -160,7 +160,7 @@ EXPORT_SYMBOL(of_device_alloc);
  * @platform_data: pointer to populate platform_data pointer with
  * @parent: Linux device model parent device.
  *
- * Returns pointer to created platform device, or NULL if a device was not
+ * Return: Pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
 static struct platform_device *of_platform_device_create_pdata(
@@ -204,7 +204,7 @@ static struct platform_device *of_platform_device_create_pdata(
  * @bus_id: name to assign device
  * @parent: Linux device model parent device.
  *
- * Returns pointer to created platform device, or NULL if a device was not
+ * Return: Pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
 struct platform_device *of_platform_device_create(struct device_node *np,
@@ -463,7 +463,7 @@ EXPORT_SYMBOL(of_platform_bus_probe);
  * New board support should be using this function instead of
  * of_platform_bus_probe().
  *
- * Returns 0 on success, < 0 on failure.
+ * Return: 0 on success, < 0 on failure.
  */
 int of_platform_populate(struct device_node *root,
 			const struct of_device_id *matches,
@@ -608,7 +608,7 @@ static void devm_of_platform_populate_release(struct device *dev, void *res)
  * Similar to of_platform_populate(), but will automatically call
  * of_platform_depopulate() when the device is unbound from the bus.
  *
- * Returns 0 on success, < 0 on failure.
+ * Return: 0 on success, < 0 on failure.
  */
 int devm_of_platform_populate(struct device *dev)
 {
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 8f998351bf4f..a411460d2b21 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -60,9 +60,11 @@ EXPORT_SYMBOL(of_graph_is_present);
  * @elem_size:	size of the individual element
  *
  * Search for a property in a device node and count the number of elements of
- * size elem_size in it. Returns number of elements on sucess, -EINVAL if the
- * property does not exist or its length does not match a multiple of elem_size
- * and -ENODATA if the property does not have a value.
+ * size elem_size in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does not
+ * exist or its length does not match a multiple of elem_size and -ENODATA if
+ * the property does not have a value.
  */
 int of_property_count_elems_of_size(const struct device_node *np,
 				const char *propname, int elem_size)
@@ -94,8 +96,9 @@ EXPORT_SYMBOL_GPL(of_property_count_elems_of_size);
  * @len:	if !=NULL, actual length is written to here
  *
  * Search for a property in a device node and valid the requested size.
- * Returns the property value on success, -EINVAL if the property does not
- *  exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
+ *
+ * Return: The property value on success, -EINVAL if the property does not
+ * exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data is too small or too large.
  *
  */
@@ -128,7 +131,9 @@ static void *of_find_property_value_of_size(const struct device_node *np,
  * @out_value:	pointer to return value, modified only if no error.
  *
  * Search for a property in a device node and read nth 32-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -160,7 +165,9 @@ EXPORT_SYMBOL_GPL(of_property_read_u32_index);
  * @out_value:	pointer to return value, modified only if no error.
  *
  * Search for a property in a device node and read nth 64-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -195,12 +202,14 @@ EXPORT_SYMBOL_GPL(of_property_read_u64_index);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 8-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
- * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
- * if the property data is smaller than sz_min or longer than sz_max.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 8 <0x50 0x60 0x70>;
+ *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
+ * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
+ * if the property data is smaller than sz_min or longer than sz_max.
  *
  * The out_values is modified only if a valid u8 value can be decoded.
  */
@@ -243,12 +252,14 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u8_array);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 16-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
- * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
- * if the property data is smaller than sz_min or longer than sz_max.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 16 <0x5000 0x6000 0x7000>;
+ *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
+ * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
+ * if the property data is smaller than sz_min or longer than sz_max.
  *
  * The out_values is modified only if a valid u16 value can be decoded.
  */
@@ -291,7 +302,9 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u16_array);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 32-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
+ * it.
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
  * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
  * if the property data is smaller than sz_min or longer than sz_max.
  *
@@ -330,7 +343,9 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u32_array);
  * @out_value:	pointer to return value, modified only if return value is 0.
  *
  * Search for a property in a device node and read a 64-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -365,7 +380,9 @@ EXPORT_SYMBOL_GPL(of_property_read_u64);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 64-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
+ * it.
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
  * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
  * if the property data is smaller than sz_min or longer than sz_max.
  *
@@ -407,10 +424,11 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u64_array);
  *		return value is 0.
  *
  * Search for a property in a device tree node and retrieve a null
- * terminated string value (pointer to data, not a copy). Returns 0 on
- * success, -EINVAL if the property does not exist, -ENODATA if property
- * does not have a value, and -EILSEQ if the string is not null-terminated
- * within the length of the property data.
+ * terminated string value (pointer to data, not a copy).
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist, -ENODATA if
+ * property does not have a value, and -EILSEQ if the string is not
+ * null-terminated within the length of the property data.
  *
  * The out_string pointer is modified only if a valid string can be decoded.
  */
@@ -774,7 +792,7 @@ EXPORT_SYMBOL(of_graph_get_remote_port_parent);
  * @node: pointer to a local endpoint device_node
  *
  * Return: Remote port node associated with remote endpoint node linked
- *	   to @node. Use of_node_put() on it when done.
+ * to @node. Use of_node_put() on it when done.
  */
 struct device_node *of_graph_get_remote_port(const struct device_node *node)
 {
@@ -807,7 +825,7 @@ EXPORT_SYMBOL(of_graph_get_endpoint_count);
  * @endpoint: identifier (value of reg property) of the endpoint node
  *
  * Return: Remote device node associated with remote endpoint node linked
- *	   to @node. Use of_node_put() on it when done.
+ * to @node. Use of_node_put() on it when done.
  */
 struct device_node *of_graph_get_remote_node(const struct device_node *node,
 					     u32 port, u32 endpoint)
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 925be41eeebe..de5a823f3031 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2613,6 +2613,8 @@ enum parport_pc_pci_cards {
 	netmos_9865,
 	quatech_sppxp100,
 	wch_ch382l,
+	brainboxes_uc146,
+	brainboxes_px203,
 };
 
 
@@ -2676,6 +2678,8 @@ static struct parport_pc_pci {
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
+	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_px203 */	{ 1, { { 0, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2767,6 +2771,23 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
 	/* WCH CH382L PCI-E single parallel port card */
 	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
+	/* Brainboxes IX-500/550 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x402a,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes UC-146/UC-157 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	/* Brainboxes PX-146/PX-257 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x401c,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes PX-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x4007,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px203 },
+	/* Brainboxes PX-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x401f,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 5d21c6adf1ab..9911d4f85469 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -17,6 +17,7 @@
 
 #define MLXBF_BOOTCTL_SB_SECURE_MASK		0x03
 #define MLXBF_BOOTCTL_SB_TEST_MASK		0x0c
+#define MLXBF_BOOTCTL_SB_DEV_MASK		BIT(4)
 
 #define MLXBF_SB_KEY_NUM			4
 
@@ -37,11 +38,18 @@ static struct mlxbf_bootctl_name boot_names[] = {
 	{ MLXBF_BOOTCTL_NONE, "none" },
 };
 
+enum {
+	MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION = 0,
+	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE = 1,
+	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE = 2,
+	MLXBF_BOOTCTL_SB_LIFECYCLE_RMA = 3
+};
+
 static const char * const mlxbf_bootctl_lifecycle_states[] = {
-	[0] = "Production",
-	[1] = "GA Secured",
-	[2] = "GA Non-Secured",
-	[3] = "RMA",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION] = "Production",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE] = "GA Secured",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE] = "GA Non-Secured",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_RMA] = "RMA",
 };
 
 /* ARM SMC call which is atomic and no need for lock. */
@@ -165,25 +173,30 @@ static ssize_t second_reset_action_store(struct device *dev,
 static ssize_t lifecycle_state_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
+	int status_bits;
+	int use_dev_key;
+	int test_state;
 	int lc_state;
 
-	lc_state = mlxbf_bootctl_smc(MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
-				     MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE);
-	if (lc_state < 0)
-		return lc_state;
+	status_bits = mlxbf_bootctl_smc(MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
+					MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE);
+	if (status_bits < 0)
+		return status_bits;
 
-	lc_state &=
-		MLXBF_BOOTCTL_SB_TEST_MASK | MLXBF_BOOTCTL_SB_SECURE_MASK;
+	use_dev_key = status_bits & MLXBF_BOOTCTL_SB_DEV_MASK;
+	test_state = status_bits & MLXBF_BOOTCTL_SB_TEST_MASK;
+	lc_state = status_bits & MLXBF_BOOTCTL_SB_SECURE_MASK;
 
 	/*
 	 * If the test bits are set, we specify that the current state may be
 	 * due to using the test bits.
 	 */
-	if (lc_state & MLXBF_BOOTCTL_SB_TEST_MASK) {
-		lc_state &= MLXBF_BOOTCTL_SB_SECURE_MASK;
-
+	if (test_state) {
 		return sprintf(buf, "%s(test)\n",
 			       mlxbf_bootctl_lifecycle_states[lc_state]);
+	} else if (use_dev_key &&
+		   (lc_state == MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE)) {
+		return sprintf(buf, "Secured (development)\n");
 	}
 
 	return sprintf(buf, "%s\n", mlxbf_bootctl_lifecycle_states[lc_state]);
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 84c5b922f245..c14c145b88d8 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -243,6 +243,7 @@ config ASUS_WMI
 	depends on RFKILL || RFKILL = n
 	depends on HOTPLUG_PCI
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on SERIO_I8042 || SERIO_I8042 = n
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
@@ -256,7 +257,6 @@ config ASUS_WMI
 config ASUS_NB_WMI
 	tristate "Asus Notebook WMI Driver"
 	depends on ASUS_WMI
-	depends on SERIO_I8042 || SERIO_I8042 = n
 	help
 	  This is a driver for newer Asus notebooks. It adds extra features
 	  like wireless radio and bluetooth control, leds, hotkeys, backlight...
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 04503ad6c7fb..49505939352a 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -41,6 +41,10 @@ static int wapf = -1;
 module_param(wapf, uint, 0444);
 MODULE_PARM_DESC(wapf, "WAPF value");
 
+static int tablet_mode_sw = -1;
+module_param(tablet_mode_sw, uint, 0444);
+MODULE_PARM_DESC(tablet_mode_sw, "Tablet mode detect: -1:auto 0:disable 1:kbd-dock 2:lid-flip");
+
 static struct quirk_entry *quirks;
 
 static bool asus_q500a_i8042_filter(unsigned char data, unsigned char str,
@@ -111,7 +115,17 @@ static struct quirk_entry quirk_asus_forceals = {
 };
 
 static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
-	.use_kbd_dock_devid = true,
+	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
+};
+
+static struct quirk_entry quirk_asus_use_lid_flip_devid = {
+	.wmi_backlight_set_devstate = true,
+	.tablet_switch_mode = asus_wmi_lid_flip_devid,
+};
+
+static struct quirk_entry quirk_asus_tablet_mode = {
+	.wmi_backlight_set_devstate = true,
+	.tablet_switch_mode = asus_wmi_lid_flip_rog_devid,
 };
 
 static int dmi_matched(const struct dmi_system_id *dmi)
@@ -443,13 +457,39 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_use_kbd_dock_devid,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ZenBook Flip UX360",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			/* Match UX360* */
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX360"),
+		},
+		.driver_data = &quirk_asus_use_lid_flip_devid,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS TP200s / E205SA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E205SA"),
+		},
+		.driver_data = &quirk_asus_use_lid_flip_devid,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG FLOW X13",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV301Q"),
+		},
+		.driver_data = &quirk_asus_tablet_mode,
+	},
 	{},
 };
 
 static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 {
-	int ret;
-
 	quirks = &quirk_asus_unknown;
 	dmi_check_system(asus_quirks);
 
@@ -462,14 +502,8 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 	else
 		wapf = quirks->wapf;
 
-	if (quirks->i8042_filter) {
-		ret = i8042_install_filter(quirks->i8042_filter);
-		if (ret) {
-			pr_warn("Unable to install key filter\n");
-			return;
-		}
-		pr_info("Using i8042 filter function for receiving events\n");
-	}
+	if (tablet_mode_sw != -1)
+		quirks->tablet_switch_mode = tablet_mode_sw;
 }
 
 static const struct key_entry asus_nb_wmi_keymap[] = {
@@ -541,6 +575,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
+	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
 	{ KE_END, 0},
 };
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index db369cf26111..931656494768 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -63,6 +63,8 @@ MODULE_LICENSE("GPL");
 #define NOTIFY_KBD_BRTTOGGLE		0xc7
 #define NOTIFY_KBD_FBM			0x99
 #define NOTIFY_KBD_TTP			0xae
+#define NOTIFY_LID_FLIP			0xfa
+#define NOTIFY_LID_FLIP_ROG		0xbd
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
@@ -198,6 +200,10 @@ struct asus_wmi {
 	struct asus_rfkill gps;
 	struct asus_rfkill uwb;
 
+	int tablet_switch_event_code;
+	u32 tablet_switch_dev_id;
+	bool tablet_switch_inverted;
+
 	enum fan_type fan_type;
 	int fan_pwm_mode;
 	int agfn_pwm;
@@ -206,6 +212,9 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
+	bool dgpu_disable_available;
+	bool dgpu_disable;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -346,10 +355,35 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
 }
 
 /* Input **********************************************************************/
+static void asus_wmi_tablet_sw_report(struct asus_wmi *asus, bool value)
+{
+	input_report_switch(asus->inputdev, SW_TABLET_MODE,
+			    asus->tablet_switch_inverted ? !value : value);
+	input_sync(asus->inputdev);
+}
+
+static void asus_wmi_tablet_sw_init(struct asus_wmi *asus, u32 dev_id, int event_code)
+{
+	struct device *dev = &asus->platform_device->dev;
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, dev_id);
+	if (result >= 0) {
+		input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
+		asus_wmi_tablet_sw_report(asus, result);
+		asus->tablet_switch_dev_id = dev_id;
+		asus->tablet_switch_event_code = event_code;
+	} else if (result == -ENODEV) {
+		dev_err(dev, "This device has tablet-mode-switch quirk but got ENODEV checking it. This is a bug.");
+	} else {
+		dev_err(dev, "Error checking for tablet-mode-switch: %d\n", result);
+	}
+}
 
 static int asus_wmi_input_init(struct asus_wmi *asus)
 {
-	int err, result;
+	struct device *dev = &asus->platform_device->dev;
+	int err;
 
 	asus->inputdev = input_allocate_device();
 	if (!asus->inputdev)
@@ -358,21 +392,26 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 	asus->inputdev->name = asus->driver->input_name;
 	asus->inputdev->phys = asus->driver->input_phys;
 	asus->inputdev->id.bustype = BUS_HOST;
-	asus->inputdev->dev.parent = &asus->platform_device->dev;
+	asus->inputdev->dev.parent = dev;
 	set_bit(EV_REP, asus->inputdev->evbit);
 
 	err = sparse_keymap_setup(asus->inputdev, asus->driver->keymap, NULL);
 	if (err)
 		goto err_free_dev;
 
-	if (asus->driver->quirks->use_kbd_dock_devid) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
-		if (result >= 0) {
-			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
-			input_report_switch(asus->inputdev, SW_TABLET_MODE, !result);
-		} else if (result != -ENODEV) {
-			pr_err("Error checking for keyboard-dock: %d\n", result);
-		}
+	switch (asus->driver->quirks->tablet_switch_mode) {
+	case asus_wmi_no_tablet_switch:
+		break;
+	case asus_wmi_kbd_dock_devid:
+		asus->tablet_switch_inverted = true;
+		asus_wmi_tablet_sw_init(asus, ASUS_WMI_DEVID_KBD_DOCK, NOTIFY_KBD_DOCK_CHANGE);
+		break;
+	case asus_wmi_lid_flip_devid:
+		asus_wmi_tablet_sw_init(asus, ASUS_WMI_DEVID_LID_FLIP, NOTIFY_LID_FLIP);
+		break;
+	case asus_wmi_lid_flip_rog_devid:
+		asus_wmi_tablet_sw_init(asus, ASUS_WMI_DEVID_LID_FLIP_ROG, NOTIFY_LID_FLIP_ROG);
+		break;
 	}
 
 	err = input_register_device(asus->inputdev);
@@ -394,6 +433,107 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 	asus->inputdev = NULL;
 }
 
+/* Tablet mode ****************************************************************/
+
+static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
+{
+	int result;
+
+	if (!asus->tablet_switch_dev_id)
+		return;
+
+	result = asus_wmi_get_devstate_simple(asus, asus->tablet_switch_dev_id);
+	if (result >= 0)
+		asus_wmi_tablet_sw_report(asus, result);
+}
+
+/* dGPU ********************************************************************/
+static int dgpu_disable_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->dgpu_disable_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+		asus->dgpu_disable_available = true;
+		asus->dgpu_disable = result & ASUS_WMI_DSTS_STATUS_BIT;
+	}
+
+	return 0;
+}
+
+static int dgpu_disable_write(struct asus_wmi *asus)
+{
+	u32 retval;
+	u8 value;
+	int err;
+
+	/* Don't rely on type conversion */
+	value = asus->dgpu_disable ? 1 : 0;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
+	if (err) {
+		pr_warn("Failed to set dgpu disable: %d\n", err);
+		return err;
+	}
+
+	if (retval > 1 || retval < 0) {
+		pr_warn("Failed to set dgpu disable (retval): 0x%x\n", retval);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "dgpu_disable");
+
+	return 0;
+}
+
+static ssize_t dgpu_disable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->dgpu_disable;
+
+	return sysfs_emit(buf, "%d\n", mode);
+}
+
+/*
+ * A user may be required to store the value twice, typcial store first, then
+ * rescan PCI bus to activate power, then store a second time to save correctly.
+ * The reason for this is that an extra code path in the ACPI is enabled when
+ * the device and bus are powered.
+ */
+static ssize_t dgpu_disable_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	bool disable;
+	int result;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &disable);
+	if (result)
+		return result;
+
+	asus->dgpu_disable = disable;
+
+	result = dgpu_disable_write(asus);
+	if (result)
+		return result;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(dgpu_disable);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -2074,9 +2214,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 {
 	unsigned int key_value = 1;
 	bool autorelease = 1;
-	int result, orig_code;
-
-	orig_code = code;
+	int orig_code = code;
 
 	if (asus->driver->key_filter) {
 		asus->driver->key_filter(asus->driver, &code, &key_value,
@@ -2119,14 +2257,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
-	if (asus->driver->quirks->use_kbd_dock_devid && code == NOTIFY_KBD_DOCK_CHANGE) {
-		result = asus_wmi_get_devstate_simple(asus,
-						      ASUS_WMI_DEVID_KBD_DOCK);
-		if (result >= 0) {
-			input_report_switch(asus->inputdev, SW_TABLET_MODE,
-					    !result);
-			input_sync(asus->inputdev);
-		}
+	if (code == asus->tablet_switch_event_code) {
+		asus_wmi_tablet_mode_get_state(asus);
 		return;
 	}
 
@@ -2287,6 +2419,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_touchpad.attr,
+	&dev_attr_dgpu_disable.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -2312,6 +2445,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
+	else if (attr == &dev_attr_dgpu_disable.attr)
+		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -2571,6 +2706,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
+	err = dgpu_disable_check_present(asus);
+	if (err)
+		goto fail_dgpu_disable;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -2647,6 +2786,12 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_wmi_handler;
 	}
 
+	if (asus->driver->quirks->i8042_filter) {
+		err = i8042_install_filter(asus->driver->quirks->i8042_filter);
+		if (err)
+			pr_warn("Unable to install key filter - %d\n", err);
+	}
+
 	asus_wmi_battery_init(asus);
 
 	asus_wmi_debugfs_init(asus);
@@ -2667,6 +2812,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_sysfs:
 fail_throttle_thermal_policy:
 fail_fan_boost_mode:
+fail_dgpu_disable:
 fail_platform:
 	kfree(asus);
 	return err;
@@ -2677,6 +2823,8 @@ static int asus_wmi_remove(struct platform_device *device)
 	struct asus_wmi *asus;
 
 	asus = platform_get_drvdata(device);
+	if (asus->driver->quirks->i8042_filter)
+		i8042_remove_filter(asus->driver->quirks->i8042_filter);
 	wmi_remove_notify_handler(asus->driver->event_guid);
 	asus_wmi_backlight_exit(asus);
 	asus_wmi_input_exit(asus);
@@ -2721,6 +2869,8 @@ static int asus_hotk_resume(struct device *device)
 
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
+
+	asus_wmi_tablet_mode_get_state(asus);
 	return 0;
 }
 
@@ -2759,6 +2909,8 @@ static int asus_hotk_restore(struct device *device)
 
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
+
+	asus_wmi_tablet_mode_get_state(asus);
 	return 0;
 }
 
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 1d0b592e2651..b817a312f2e1 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -25,6 +25,13 @@ struct module;
 struct key_entry;
 struct asus_wmi;
 
+enum asus_wmi_tablet_switch_mode {
+	asus_wmi_no_tablet_switch,
+	asus_wmi_kbd_dock_devid,
+	asus_wmi_lid_flip_devid,
+	asus_wmi_lid_flip_rog_devid,
+};
+
 struct quirk_entry {
 	bool hotplug_wireless;
 	bool scalar_panel_brightness;
@@ -33,7 +40,7 @@ struct quirk_entry {
 	bool wmi_backlight_native;
 	bool wmi_backlight_set_devstate;
 	bool wmi_force_als_set;
-	bool use_kbd_dock_devid;
+	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*
 	 * For machines with AMD graphic chips, it will send out WMI event
diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index b977e039bb78..5e5c359eaf98 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2694,6 +2694,7 @@ static int beiscsi_init_wrb_handle(struct beiscsi_hba *phba)
 		kfree(pwrb_context->pwrb_handle_base);
 		kfree(pwrb_context->pwrb_handle_basestd);
 	}
+	kfree(phwi_ctxt->be_wrbq);
 	return -ENOMEM;
 }
 
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 60ffc54da003..3cb39f02fae0 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -60,7 +60,16 @@ static void optee_release_device(struct device *dev)
 	kfree(optee_device);
 }
 
-static int optee_register_device(const uuid_t *device_uuid)
+static ssize_t need_supplicant_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return 0;
+}
+
+static DEVICE_ATTR_RO(need_supplicant);
+
+static int optee_register_device(const uuid_t *device_uuid, u32 func)
 {
 	struct tee_client_device *optee_device = NULL;
 	int rc;
@@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *device_uuid)
 		put_device(&optee_device->dev);
 	}
 
+	if (func == PTA_CMD_GET_DEVICES_SUPP)
+		device_create_file(&optee_device->dev,
+				   &dev_attr_need_supplicant);
+
 	return rc;
 }
 
@@ -143,7 +156,7 @@ static int __optee_enumerate_devices(u32 func)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx]);
+		rc = optee_register_device(&device_uuid[idx], func);
 		if (rc)
 			goto out_shm;
 	}
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 70d7826788f5..ccacbf0f14b3 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -199,6 +199,7 @@ static int __init early_omap8250_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(omap8250, "ti,omap2-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
+OF_EARLYCON_DECLARE(omap8250, "ti,am654-uart", early_omap8250_setup);
 
 #endif
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index e7e84aa2c5f8..bd4118f1b694 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -844,7 +844,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
 		reg = serial_in(p, UART_OMAP_IER2);
 		reg &= ~UART_OMAP_IER2_RHR_IT_DIS;
-		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+		serial_out(p, UART_OMAP_IER2, reg);
 	}
 
 	dmaengine_tx_status(rxchan, cookie, &state);
@@ -986,7 +986,7 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
 		reg = serial_in(p, UART_OMAP_IER2);
 		reg |= UART_OMAP_IER2_RHR_IT_DIS;
-		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+		serial_out(p, UART_OMAP_IER2, reg);
 	}
 
 	dma_async_issue_pending(dma->rxchan);
@@ -1209,10 +1209,12 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (priv->habit & UART_HAS_EFR2)
-		am654_8250_handle_rx_dma(up, iir, status);
-	else
-		status = omap_8250_handle_rx_dma(up, iir, status);
+	if ((iir & 0x3f) != UART_IIR_THRI) {
+		if (priv->habit & UART_HAS_EFR2)
+			am654_8250_handle_rx_dma(up, iir, status);
+		else
+			status = omap_8250_handle_rx_dma(up, iir, status);
+	}
 
 	serial8250_modem_status(up);
 	if (status & UART_LSR_THRE && up->dma->tx_err) {
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 348d4b2a391a..d4a93a94b4ca 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -222,17 +222,18 @@ static struct vendor_data vendor_zte = {
 
 /* Deals with DMA transactions */
 
-struct pl011_sgbuf {
-	struct scatterlist sg;
-	char *buf;
+struct pl011_dmabuf {
+	dma_addr_t		dma;
+	size_t			len;
+	char			*buf;
 };
 
 struct pl011_dmarx_data {
 	struct dma_chan		*chan;
 	struct completion	complete;
 	bool			use_buf_b;
-	struct pl011_sgbuf	sgbuf_a;
-	struct pl011_sgbuf	sgbuf_b;
+	struct pl011_dmabuf	dbuf_a;
+	struct pl011_dmabuf	dbuf_b;
 	dma_cookie_t		cookie;
 	bool			running;
 	struct timer_list	timer;
@@ -245,7 +246,8 @@ struct pl011_dmarx_data {
 
 struct pl011_dmatx_data {
 	struct dma_chan		*chan;
-	struct scatterlist	sg;
+	dma_addr_t		dma;
+	size_t			len;
 	char			*buf;
 	bool			queued;
 };
@@ -366,32 +368,24 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 
 #define PL011_DMA_BUFFER_SIZE PAGE_SIZE
 
-static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
+static int pl011_dmabuf_init(struct dma_chan *chan, struct pl011_dmabuf *db,
 	enum dma_data_direction dir)
 {
-	dma_addr_t dma_addr;
-
-	sg->buf = dma_alloc_coherent(chan->device->dev,
-		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
-	if (!sg->buf)
+	db->buf = dma_alloc_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
+				     &db->dma, GFP_KERNEL);
+	if (!db->buf)
 		return -ENOMEM;
-
-	sg_init_table(&sg->sg, 1);
-	sg_set_page(&sg->sg, phys_to_page(dma_addr),
-		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
-	sg_dma_address(&sg->sg) = dma_addr;
-	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
+	db->len = PL011_DMA_BUFFER_SIZE;
 
 	return 0;
 }
 
-static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
+static void pl011_dmabuf_free(struct dma_chan *chan, struct pl011_dmabuf *db,
 	enum dma_data_direction dir)
 {
-	if (sg->buf) {
+	if (db->buf) {
 		dma_free_coherent(chan->device->dev,
-			PL011_DMA_BUFFER_SIZE, sg->buf,
-			sg_dma_address(&sg->sg));
+				  PL011_DMA_BUFFER_SIZE, db->buf, db->dma);
 	}
 }
 
@@ -552,8 +546,8 @@ static void pl011_dma_tx_callback(void *data)
 
 	spin_lock_irqsave(&uap->port.lock, flags);
 	if (uap->dmatx.queued)
-		dma_unmap_sg(dmatx->chan->device->dev, &dmatx->sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
+				dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
@@ -639,18 +633,19 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 			memcpy(&dmatx->buf[first], &xmit->buf[0], second);
 	}
 
-	dmatx->sg.length = count;
-
-	if (dma_map_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE) != 1) {
+	dmatx->len = count;
+	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
+				    DMA_TO_DEVICE);
+	if (dmatx->dma == DMA_MAPPING_ERROR) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
 	}
 
-	desc = dmaengine_prep_slave_sg(chan, &dmatx->sg, 1, DMA_MEM_TO_DEV,
+	desc = dmaengine_prep_slave_single(chan, dmatx->dma, dmatx->len, DMA_MEM_TO_DEV,
 					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
-		dma_unmap_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE);
+		dma_unmap_single(dma_dev->dev, dmatx->dma, dmatx->len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		/*
 		 * If DMA cannot be used right now, we complete this
@@ -814,8 +809,8 @@ __acquires(&uap->port.lock)
 	dmaengine_terminate_async(uap->dmatx.chan);
 
 	if (uap->dmatx.queued) {
-		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(uap->dmatx.chan->device->dev, uap->dmatx.dma,
+				 uap->dmatx.len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -829,15 +824,15 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	struct dma_chan *rxchan = uap->dmarx.chan;
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_async_tx_descriptor *desc;
-	struct pl011_sgbuf *sgbuf;
+	struct pl011_dmabuf *dbuf;
 
 	if (!rxchan)
 		return -EIO;
 
 	/* Start the RX DMA job */
-	sgbuf = uap->dmarx.use_buf_b ?
-		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
-	desc = dmaengine_prep_slave_sg(rxchan, &sgbuf->sg, 1,
+	dbuf = uap->dmarx.use_buf_b ?
+		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
+	desc = dmaengine_prep_slave_single(rxchan, dbuf->dma, dbuf->len,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	/*
@@ -877,8 +872,8 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 			       bool readfifo)
 {
 	struct tty_port *port = &uap->port.state->port;
-	struct pl011_sgbuf *sgbuf = use_buf_b ?
-		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	struct pl011_dmabuf *dbuf = use_buf_b ?
+		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	int dma_count = 0;
 	u32 fifotaken = 0; /* only used for vdbg() */
 
@@ -887,7 +882,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	if (uap->dmarx.poll_rate) {
 		/* The data can be taken by polling */
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = dbuf->len - dmarx->last_residue;
 		/* Recalculate the pending size */
 		if (pending >= dmataken)
 			pending -= dmataken;
@@ -901,7 +896,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 		 * Note that tty_insert_flip_buf() tries to take as many chars
 		 * as it can.
 		 */
-		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
 				pending);
 
 		uap->port.icount.rx += dma_count;
@@ -912,7 +907,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	/* Reset the last_residue for Rx DMA poll */
 	if (uap->dmarx.poll_rate)
-		dmarx->last_residue = sgbuf->sg.length;
+		dmarx->last_residue = dbuf->len;
 
 	/*
 	 * Only continue with trying to read the FIFO if all DMA chars have
@@ -949,8 +944,8 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 {
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = dmarx->chan;
-	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
-		&dmarx->sgbuf_b : &dmarx->sgbuf_a;
+	struct pl011_dmabuf *dbuf = dmarx->use_buf_b ?
+		&dmarx->dbuf_b : &dmarx->dbuf_a;
 	size_t pending;
 	struct dma_tx_state state;
 	enum dma_status dmastat;
@@ -972,7 +967,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = false;
 
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -999,8 +994,8 @@ static void pl011_dma_rx_callback(void *data)
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = dmarx->chan;
 	bool lastbuf = dmarx->use_buf_b;
-	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
-		&dmarx->sgbuf_b : &dmarx->sgbuf_a;
+	struct pl011_dmabuf *dbuf = dmarx->use_buf_b ?
+		&dmarx->dbuf_b : &dmarx->dbuf_a;
 	size_t pending;
 	struct dma_tx_state state;
 	int ret;
@@ -1018,7 +1013,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * the DMA irq handler. So we check the residue here.
 	 */
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1070,16 +1065,16 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	unsigned long flags = 0;
 	unsigned int dmataken = 0;
 	unsigned int size = 0;
-	struct pl011_sgbuf *sgbuf;
+	struct pl011_dmabuf *dbuf;
 	int dma_count;
 	struct dma_tx_state state;
 
-	sgbuf = dmarx->use_buf_b ? &uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	dbuf = dmarx->use_buf_b ? &uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
 	if (likely(state.residue < dmarx->last_residue)) {
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = dbuf->len - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
-		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
 				size);
 		if (dma_count == size)
 			dmarx->last_residue =  state.residue;
@@ -1126,7 +1121,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		return;
 	}
 
-	sg_init_one(&uap->dmatx.sg, uap->dmatx.buf, PL011_DMA_BUFFER_SIZE);
+	uap->dmatx.len = PL011_DMA_BUFFER_SIZE;
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
@@ -1136,7 +1131,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		goto skip_rx;
 
 	/* Allocate and map DMA RX buffers */
-	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_a,
 			       DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
@@ -1144,12 +1139,12 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		goto skip_rx;
 	}
 
-	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_b,
+	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_b,
 			       DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
 			"RX buffer B", ret);
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a,
 				 DMA_FROM_DEVICE);
 		goto skip_rx;
 	}
@@ -1203,8 +1198,9 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
 		dmaengine_terminate_all(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
-			dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-				     DMA_TO_DEVICE);
+			dma_unmap_single(uap->dmatx.chan->device->dev,
+					 uap->dmatx.dma, uap->dmatx.len,
+					 DMA_TO_DEVICE);
 			uap->dmatx.queued = false;
 		}
 
@@ -1215,8 +1211,8 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	if (uap->using_rx_dma) {
 		dmaengine_terminate_all(uap->dmarx.chan);
 		/* Clean up the RX DMA */
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a, DMA_FROM_DEVICE);
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_b, DMA_FROM_DEVICE);
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a, DMA_FROM_DEVICE);
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_b, DMA_FROM_DEVICE);
 		if (uap->dmarx.poll_rate)
 			del_timer_sync(&uap->dmarx.timer);
 		uap->using_rx_dma = false;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index c681ed589303..fd9be81bcfd8 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -694,6 +694,18 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		case SC16IS7XX_IIR_RTOI_SRC:
 		case SC16IS7XX_IIR_XOFFI_SRC:
 			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
+
+			/*
+			 * There is a silicon bug that makes the chip report a
+			 * time-out interrupt but no data in the FIFO. This is
+			 * described in errata section 18.1.4.
+			 *
+			 * When this happens, read one byte from the FIFO to
+			 * clear the interrupt.
+			 */
+			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
+				rxlen = 1;
+
 			if (rxlen)
 				sc16is7xx_handle_rx(port, rxlen, iir);
 			break;
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index e7cf56b13c64..ba018aeb21d8 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -88,6 +88,7 @@ static void hidg_release(struct device *dev)
 {
 	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
 
+	kfree(hidg->report_desc);
 	kfree(hidg->set_report_buf);
 	kfree(hidg);
 }
@@ -1287,9 +1288,9 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->report_length = opts->report_length;
 	hidg->report_desc_length = opts->report_desc_length;
 	if (opts->report_desc) {
-		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
-						 opts->report_desc_length,
-						 GFP_KERNEL);
+		hidg->report_desc = kmemdup(opts->report_desc,
+					    opts->report_desc_length,
+					    GFP_KERNEL);
 		if (!hidg->report_desc) {
 			put_device(&hidg->dev);
 			--opts->refcnt;
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 0933a94ebe29..53f832787350 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -345,8 +345,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-	else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
-		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9d3a35b2046d..18b35e817361 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -194,7 +194,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	if (!partner)
 		return;
 
-	adev = &partner->adev;
+	adev = &altmode->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -424,7 +424,8 @@ static void typec_altmode_release(struct device *dev)
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	typec_altmode_put_partner(alt);
+	if (!is_typec_port(dev->parent))
+		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cd689d5c4c82..0e25a3f64b2e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2972,7 +2972,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
-	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
 	/*
 	 * Verify the type first, if that or the checksum value are
 	 * corrupted, we'll find out
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fd4edd966450..ea731fa8bd35 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -318,10 +318,7 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
 
 static void btrfs_put_super(struct super_block *sb)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-
-	btrfs_info(fs_info, "last unmount of filesystem %pU", fs_info->fs_devices->fsid);
-	close_ctree(fs_info);
+	close_ctree(btrfs_sb(sb));
 }
 
 enum {
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index b87d6792b14a..16155529e449 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1093,7 +1093,9 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	unsigned int xid;
 	int rc;
 
-	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
+	if (remap_flags & REMAP_FILE_DEDUP)
+		return -EOPNOTSUPP;
+	if (remap_flags & ~REMAP_FILE_ADVISORY)
 		return -EINVAL;
 
 	cifs_dbg(FYI, "clone range\n");
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 015b7b37edee..e58525a95827 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2765,6 +2765,8 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 				(char **)&dfs_rsp, &dfs_rsp_size);
 	} while (rc == -EAGAIN);
 
+	if (!rc && !dfs_rsp)
+		rc = -EIO;
 	if (rc) {
 		if ((rc != -ENOENT) && (rc != -EOPNOTSUPP))
 			cifs_tcon_dbg(VFS, "ioctl error in %s rc=%d\n", __func__, rc);
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index b3abe69382fd..23b4b8863e7f 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -501,15 +501,38 @@ int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 
 	down_write(&NILFS_MDT(sufile)->mi_sem);
 	ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
-	if (!ret) {
-		mark_buffer_dirty(bh);
-		nilfs_mdt_mark_dirty(sufile);
-		kaddr = kmap_atomic(bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (ret)
+		goto out_sem;
+
+	kaddr = kmap_atomic(bh->b_page);
+	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (unlikely(nilfs_segment_usage_error(su))) {
+		struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+
+		kunmap_atomic(kaddr);
+		brelse(bh);
+		if (nilfs_segment_is_active(nilfs, segnum)) {
+			nilfs_error(sufile->i_sb,
+				    "active segment %llu is erroneous",
+				    (unsigned long long)segnum);
+		} else {
+			/*
+			 * Segments marked erroneous are never allocated by
+			 * nilfs_sufile_alloc(); only active segments, ie,
+			 * the segments indexed by ns_segnum or ns_nextnum,
+			 * can be erroneous here.
+			 */
+			WARN_ON_ONCE(1);
+		}
+		ret = -EIO;
+	} else {
 		nilfs_segment_usage_set_dirty(su);
 		kunmap_atomic(kaddr);
+		mark_buffer_dirty(bh);
+		nilfs_mdt_mark_dirty(sufile);
 		brelse(bh);
 	}
+out_sem:
 	up_write(&NILFS_MDT(sufile)->mi_sem);
 	return ret;
 }
@@ -536,9 +559,14 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 
 	kaddr = kmap_atomic(bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
-	WARN_ON(nilfs_segment_usage_error(su));
-	if (modtime)
+	if (modtime) {
+		/*
+		 * Check segusage error and set su_lastmod only when updating
+		 * this entry with a valid timestamp, not for cancellation.
+		 */
+		WARN_ON_ONCE(nilfs_segment_usage_error(su));
 		su->su_lastmod = cpu_to_le64(modtime);
+	}
 	su->su_nblocks = cpu_to_le32(nblocks);
 	kunmap_atomic(kaddr);
 
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 1566e86e8e55..a8374d89da7c 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -717,7 +717,11 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 			goto failed_sbh;
 		}
 		nilfs_release_super_block(nilfs);
-		sb_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize)) {
+			nilfs_err(sb, "bad blocksize %d", blocksize);
+			err = -EINVAL;
+			goto out;
+		}
 
 		err = nilfs_load_super_block(nilfs, sb, blocksize, &sbp);
 		if (err)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7cc2889608e0..f5a5df3a8cfd 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -149,6 +149,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
+	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 7f1b8549ebce..a88be8bd4e1d 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -526,9 +526,9 @@ extern void sysrq_timer_list_show(void);
 
 int hrtimers_prepare_cpu(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
-int hrtimers_dead_cpu(unsigned int cpu);
+int hrtimers_cpu_dying(unsigned int cpu);
 #else
-#define hrtimers_dead_cpu	NULL
+#define hrtimers_cpu_dying	NULL
 #endif
 
 #endif
diff --git a/include/linux/of.h b/include/linux/of.h
index 0f4e81e6fb23..57f2d3dddc0c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -424,12 +424,14 @@ extern int of_detach_node(struct device_node *);
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 8-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 8 <0x50 0x60 0x70>;
+ *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
  *
  * The out_values is modified only if a valid u8 value can be decoded.
  */
@@ -454,12 +456,14 @@ static inline int of_property_read_u8_array(const struct device_node *np,
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 16-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 16 <0x5000 0x6000 0x7000>;
+ *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
  *
  * The out_values is modified only if a valid u16 value can be decoded.
  */
@@ -485,7 +489,9 @@ static inline int of_property_read_u16_array(const struct device_node *np,
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 32-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -513,7 +519,9 @@ static inline int of_property_read_u32_array(const struct device_node *np,
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 64-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -1063,7 +1071,9 @@ static inline bool of_node_is_type(const struct device_node *np, const char *typ
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u8 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u8 and -ENODATA if the
  * property does not have a value.
  */
@@ -1080,7 +1090,9 @@ static inline int of_property_count_u8_elems(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u16 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u16 and -ENODATA if the
  * property does not have a value.
  */
@@ -1097,7 +1109,9 @@ static inline int of_property_count_u16_elems(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u32 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u32 and -ENODATA if the
  * property does not have a value.
  */
@@ -1114,7 +1128,9 @@ static inline int of_property_count_u32_elems(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u64 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u64 and -ENODATA if the
  * property does not have a value.
  */
@@ -1135,7 +1151,7 @@ static inline int of_property_count_u64_elems(const struct device_node *np,
  * Search for a property in a device tree node and retrieve a list of
  * terminated string values (pointer to data, not a copy) in that property.
  *
- * If @out_strs is NULL, the number of strings in the property is returned.
+ * Return: If @out_strs is NULL, the number of strings in the property is returned.
  */
 static inline int of_property_read_string_array(const struct device_node *np,
 						const char *propname, const char **out_strs,
@@ -1151,10 +1167,11 @@ static inline int of_property_read_string_array(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device tree node and retrieve the number of null
- * terminated string contain in it. Returns the number of strings on
- * success, -EINVAL if the property does not exist, -ENODATA if property
- * does not have a value, and -EILSEQ if the string is not null-terminated
- * within the length of the property data.
+ * terminated string contain in it.
+ *
+ * Return: The number of strings on success, -EINVAL if the property does not
+ * exist, -ENODATA if property does not have a value, and -EILSEQ if the string
+ * is not null-terminated within the length of the property data.
  */
 static inline int of_property_count_strings(const struct device_node *np,
 					    const char *propname)
@@ -1174,7 +1191,8 @@ static inline int of_property_count_strings(const struct device_node *np,
  * Search for a property in a device tree node and retrieve a null
  * terminated string value (pointer to data, not a copy) in the list of strings
  * contained in that property.
- * Returns 0 on success, -EINVAL if the property does not exist, -ENODATA if
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist, -ENODATA if
  * property does not have a value, and -EILSEQ if the string is not
  * null-terminated within the length of the property data.
  *
@@ -1194,7 +1212,8 @@ static inline int of_property_read_string_index(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node.
- * Returns true if the property exists false otherwise.
+ *
+ * Return: true if the property exists false otherwise.
  */
 static inline bool of_property_read_bool(const struct device_node *np,
 					 const char *propname)
@@ -1440,7 +1459,7 @@ static inline int of_reconfig_get_state_change(unsigned long action,
  * of_device_is_system_power_controller - Tells if system-power-controller is found for device_node
  * @np: Pointer to the given device_node
  *
- * return true if present false otherwise
+ * Return: true if present false otherwise
  */
 static inline bool of_device_is_system_power_controller(const struct device_node *np)
 {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 50557d903a05..3b038a2cc007 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -744,6 +744,8 @@ struct perf_event {
 	struct pid_namespace		*ns;
 	u64				id;
 
+	atomic64_t			lost_samples;
+
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 897b8332a39f..60cad2aac5c1 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -62,6 +62,8 @@
 
 /* Misc */
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
+#define ASUS_WMI_DEVID_LID_FLIP		0x00060062
+#define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
 
 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER	0x00080013
@@ -88,6 +90,9 @@
 /* Keyboard dock */
 #define ASUS_WMI_DEVID_KBD_DOCK		0x00120063
 
+/* dgpu on/off */
+#define ASUS_WMI_DEVID_DGPU		0x00090020
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index e55ec1597ce7..3057c8e6dcfe 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -11,9 +11,12 @@
 /**
  * struct genl_multicast_group - generic netlink multicast group
  * @name: name of the multicast group, names are per-family
+ * @cap_sys_admin: whether %CAP_SYS_ADMIN is required for binding
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
+	u8			flags;
+	u8			cap_sys_admin:1;
 };
 
 struct genl_ops;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b95d3c485d27..6ca63ab6bee5 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -279,6 +279,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -286,6 +287,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -295,8 +297,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 0c4f159865b9..aa15e8d878a9 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -8452,49 +8452,6 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
-static int io_sqe_file_register(struct io_ring_ctx *ctx, struct file *file,
-				int index)
-{
-#if defined(CONFIG_UNIX)
-	struct sock *sock = ctx->ring_sock->sk;
-	struct sk_buff_head *head = &sock->sk_receive_queue;
-	struct sk_buff *skb;
-
-	/*
-	 * See if we can merge this file into an existing skb SCM_RIGHTS
-	 * file set. If there's no room, fall back to allocating a new skb
-	 * and filling it in.
-	 */
-	spin_lock_irq(&head->lock);
-	skb = skb_peek(head);
-	if (skb) {
-		struct scm_fp_list *fpl = UNIXCB(skb).fp;
-
-		if (fpl->count < SCM_MAX_FD) {
-			__skb_unlink(skb, head);
-			spin_unlock_irq(&head->lock);
-			fpl->fp[fpl->count] = get_file(file);
-			unix_inflight(fpl->user, fpl->fp[fpl->count]);
-			fpl->count++;
-			spin_lock_irq(&head->lock);
-			__skb_queue_head(head, skb);
-		} else {
-			skb = NULL;
-		}
-	}
-	spin_unlock_irq(&head->lock);
-
-	if (skb) {
-		fput(file);
-		return 0;
-	}
-
-	return __io_sqe_files_scm(ctx, 1, index);
-#else
-	return 0;
-#endif
-}
-
 static int io_queue_rsrc_removal(struct io_rsrc_data *data, unsigned idx,
 				 struct io_rsrc_node *node, void *rsrc)
 {
@@ -8552,12 +8509,6 @@ static int io_install_fixed_file(struct io_kiocb *req, struct file *file,
 
 	*io_get_tag_slot(ctx->file_data, slot_index) = 0;
 	io_fixed_file_set(file_slot, file);
-	ret = io_sqe_file_register(ctx, file, slot_index);
-	if (ret) {
-		file_slot->file_ptr = 0;
-		goto err;
-	}
-
 	ret = 0;
 err:
 	if (needs_switch)
@@ -8671,12 +8622,6 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 			}
 			*io_get_tag_slot(data, i) = tag;
 			io_fixed_file_set(file_slot, file);
-			err = io_sqe_file_register(ctx, file, i);
-			if (err) {
-				file_slot->file_ptr = 0;
-				fput(file);
-				break;
-			}
 		}
 	}
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 008b50da2224..abf717c4f57c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1595,7 +1595,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_HRTIMERS_PREPARE] = {
 		.name			= "hrtimers:prepare",
 		.startup.single		= hrtimers_prepare_cpu,
-		.teardown.single	= hrtimers_dead_cpu,
+		.teardown.single	= NULL,
 	},
 	[CPUHP_SMPCFD_PREPARE] = {
 		.name			= "smpcfd:prepare",
@@ -1662,6 +1662,12 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= NULL,
 		.teardown.single	= smpcfd_dying_cpu,
 	},
+	[CPUHP_AP_HRTIMERS_DYING] = {
+		.name			= "hrtimers:dying",
+		.startup.single		= NULL,
+		.teardown.single	= hrtimers_cpu_dying,
+	},
+
 	/* Entry state on starting. Interrupts enabled from here on. Transient
 	 * state for synchronsization */
 	[CPUHP_AP_ONLINE] = {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5072635f0b0c..0a6855d64803 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1912,28 +1912,34 @@ static inline void perf_event__state_init(struct perf_event *event)
 					      PERF_EVENT_STATE_INACTIVE;
 }
 
-static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
+static int __perf_event_read_size(u64 read_format, int nr_siblings)
 {
 	int entry = sizeof(u64); /* value */
 	int size = 0;
 	int nr = 1;
 
-	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		size += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		size += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_ID)
+	if (read_format & PERF_FORMAT_ID)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_LOST)
 		entry += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_GROUP) {
+	if (read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
 	}
 
-	size += entry * nr;
-	event->read_size = size;
+	/*
+	 * Since perf_event_validate_size() limits this to 16k and inhibits
+	 * adding more siblings, this will never overflow.
+	 */
+	return size + nr * entry;
 }
 
 static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
@@ -1977,8 +1983,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
  */
 static void perf_event__header_size(struct perf_event *event)
 {
-	__perf_event_read_size(event,
-			       event->group_leader->nr_siblings);
+	event->read_size =
+		__perf_event_read_size(event->attr.read_format,
+				       event->group_leader->nr_siblings);
 	__perf_event_header_size(event, event->attr.sample_type);
 }
 
@@ -2009,24 +2016,35 @@ static void perf_event__id_header_size(struct perf_event *event)
 	event->id_header_size = size;
 }
 
+/*
+ * Check that adding an event to the group does not result in anybody
+ * overflowing the 64k event limit imposed by the output buffer.
+ *
+ * Specifically, check that the read_size for the event does not exceed 16k,
+ * read_size being the one term that grows with groups size. Since read_size
+ * depends on per-event read_format, also (re)check the existing events.
+ *
+ * This leaves 48k for the constant size fields and things like callchains,
+ * branch stacks and register sets.
+ */
 static bool perf_event_validate_size(struct perf_event *event)
 {
-	/*
-	 * The values computed here will be over-written when we actually
-	 * attach the event.
-	 */
-	__perf_event_read_size(event, event->group_leader->nr_siblings + 1);
-	__perf_event_header_size(event, event->attr.sample_type & ~PERF_SAMPLE_READ);
-	perf_event__id_header_size(event);
+	struct perf_event *sibling, *group_leader = event->group_leader;
 
-	/*
-	 * Sum the lot; should not exceed the 64k limit we have on records.
-	 * Conservative limit to allow for callchains and other variable fields.
-	 */
-	if (event->read_size + event->header_size +
-	    event->id_header_size + sizeof(struct perf_event_header) >= 16*1024)
+	if (__perf_event_read_size(event->attr.read_format,
+				   group_leader->nr_siblings + 1) > 16*1024)
+		return false;
+
+	if (__perf_event_read_size(group_leader->attr.read_format,
+				   group_leader->nr_siblings + 1) > 16*1024)
 		return false;
 
+	for_each_sibling_event(sibling, group_leader) {
+		if (__perf_event_read_size(sibling->attr.read_format,
+					   group_leader->nr_siblings + 1) > 16*1024)
+			return false;
+	}
+
 	return true;
 }
 
@@ -5283,11 +5301,15 @@ static int __perf_read_group_add(struct perf_event *leader,
 	values[n++] += perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 	}
 
 unlock:
@@ -5341,7 +5363,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -5351,6 +5373,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = running;
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -6830,7 +6854,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -6844,6 +6868,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	}
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -6854,7 +6880,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -6872,6 +6898,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -6885,6 +6913,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 01351e7e2543..ca27946fdaaf 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -172,8 +172,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 
 	if (unlikely(rb->paused)) {
-		if (rb->nr_pages)
+		if (rb->nr_pages) {
 			local_inc(&rb->lost);
+			atomic64_inc(&event->lost_samples);
+		}
 		goto out;
 	}
 
@@ -254,6 +256,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 fail:
 	local_inc(&rb->lost);
+	atomic64_inc(&event->lost_samples);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 70deb2f01e97..ede09dda36e9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2114,29 +2114,22 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 	}
 }
 
-int hrtimers_dead_cpu(unsigned int scpu)
+int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i;
+	int i, ncpu = cpumask_first(cpu_active_mask);
 
-	BUG_ON(cpu_online(scpu));
-	tick_cancel_sched_timer(scpu);
+	tick_cancel_sched_timer(dying_cpu);
+
+	old_base = this_cpu_ptr(&hrtimer_bases);
+	new_base = &per_cpu(hrtimer_bases, ncpu);
 
-	/*
-	 * this BH disable ensures that raise_softirq_irqoff() does
-	 * not wakeup ksoftirqd (and acquire the pi-lock) while
-	 * holding the cpu_base lock
-	 */
-	local_bh_disable();
-	local_irq_disable();
-	old_base = &per_cpu(hrtimer_bases, scpu);
-	new_base = this_cpu_ptr(&hrtimer_bases);
 	/*
 	 * The caller is globally serialized and nobody else
 	 * takes two locks at once, deadlock is not possible.
 	 */
-	raw_spin_lock(&new_base->lock);
-	raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
+	raw_spin_lock(&old_base->lock);
+	raw_spin_lock_nested(&new_base->lock, SINGLE_DEPTH_NESTING);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
 		migrate_hrtimer_list(&old_base->clock_base[i],
@@ -2147,15 +2140,13 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	 * The migration might have changed the first expiring softirq
 	 * timer on this CPU. Update it.
 	 */
-	hrtimer_update_softirq_timer(new_base, false);
+	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
+	/* Tell the other CPU to retrigger the next event */
+	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
-	raw_spin_unlock(&old_base->lock);
 	raw_spin_unlock(&new_base->lock);
+	raw_spin_unlock(&old_base->lock);
 
-	/* Check, if we got expired work to do */
-	__hrtimer_peek_ahead_timers();
-	local_irq_enable();
-	local_bh_enable();
 	return 0;
 }
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0938222b4598..7e1148aafd28 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2903,22 +2903,19 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
 		unsigned long event_length = rb_event_length(event);
 
+		/*
+		 * For the before_stamp to be different than the write_stamp
+		 * to make sure that the next event adds an absolute
+		 * value and does not rely on the saved write stamp, which
+		 * is now going to be bogus.
+		 */
+		rb_time_set(&cpu_buffer->before_stamp, 0);
+
 		/* Something came in, can't discard */
 		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
 				       write_stamp, write_stamp - delta))
 			return 0;
 
-		/*
-		 * It's possible that the event time delta is zero
-		 * (has the same time stamp as the previous event)
-		 * in which case write_stamp and before_stamp could
-		 * be the same. In such a case, force before_stamp
-		 * to be different than write_stamp. It doesn't
-		 * matter what it is, as long as its different.
-		 */
-		if (!delta)
-			rb_time_set(&cpu_buffer->before_stamp, 0);
-
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 89a8bb8e24df..4e0411b19ef9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2287,13 +2287,7 @@ int is_tracing_stopped(void)
 	return global_trace.stop_count;
 }
 
-/**
- * tracing_start - quick start of the tracer
- *
- * If tracing is enabled but was stopped by tracing_stop,
- * this will start the tracer back up.
- */
-void tracing_start(void)
+static void tracing_start_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
 	unsigned long flags;
@@ -2301,119 +2295,83 @@ void tracing_start(void)
 	if (tracing_disabled)
 		return;
 
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (--global_trace.stop_count) {
-		if (global_trace.stop_count < 0) {
+	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	if (--tr->stop_count) {
+		if (WARN_ON_ONCE(tr->stop_count < 0)) {
 			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
-			global_trace.stop_count = 0;
+			tr->stop_count = 0;
 		}
 		goto out;
 	}
 
 	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
+	arch_spin_lock(&tr->max_lock);
 
-	buffer = global_trace.array_buffer.buffer;
+	buffer = tr->array_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
+	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 #endif
 
-	arch_spin_unlock(&global_trace.max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
-}
-
-static void tracing_start_tr(struct trace_array *tr)
-{
-	struct trace_buffer *buffer;
-	unsigned long flags;
-
-	if (tracing_disabled)
-		return;
-
-	/* If global, we need to also start the max tracer */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return tracing_start();
-
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
-
-	if (--tr->stop_count) {
-		if (tr->stop_count < 0) {
-			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
-			tr->stop_count = 0;
-		}
-		goto out;
-	}
-
-	buffer = tr->array_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_enable(buffer);
+	arch_spin_unlock(&tr->max_lock);
 
  out:
 	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
 /**
- * tracing_stop - quick stop of the tracer
+ * tracing_start - quick start of the tracer
  *
- * Light weight way to stop tracing. Use in conjunction with
- * tracing_start.
+ * If tracing is enabled but was stopped by tracing_stop,
+ * this will start the tracer back up.
  */
-void tracing_stop(void)
+void tracing_start(void)
+
+{
+	return tracing_start_tr(&global_trace);
+}
+
+static void tracing_stop_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (global_trace.stop_count++)
+	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	if (tr->stop_count++)
 		goto out;
 
 	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
+	arch_spin_lock(&tr->max_lock);
 
-	buffer = global_trace.array_buffer.buffer;
+	buffer = tr->array_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
+	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 #endif
 
-	arch_spin_unlock(&global_trace.max_lock);
+	arch_spin_unlock(&tr->max_lock);
 
  out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
+	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
-static void tracing_stop_tr(struct trace_array *tr)
+/**
+ * tracing_stop - quick stop of the tracer
+ *
+ * Light weight way to stop tracing. Use in conjunction with
+ * tracing_start.
+ */
+void tracing_stop(void)
 {
-	struct trace_buffer *buffer;
-	unsigned long flags;
-
-	/* If global, we need to also stop the max tracer */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return tracing_stop();
-
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
-	if (tr->stop_count++)
-		goto out;
-
-	buffer = tr->array_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_disable(buffer);
-
- out:
-	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
+	return tracing_stop_tr(&global_trace);
 }
 
 static int trace_save_cmdline(struct task_struct *tsk)
@@ -2687,8 +2645,11 @@ void trace_buffered_event_enable(void)
 	for_each_tracing_cpu(cpu) {
 		page = alloc_pages_node(cpu_to_node(cpu),
 					GFP_KERNEL | __GFP_NORETRY, 0);
-		if (!page)
-			goto failed;
+		/* This is just an optimization and can handle failures */
+		if (!page) {
+			pr_err("Failed to allocate event buffer\n");
+			break;
+		}
 
 		event = page_address(page);
 		memset(event, 0, sizeof(*event));
@@ -2702,10 +2663,6 @@ void trace_buffered_event_enable(void)
 			WARN_ON_ONCE(1);
 		preempt_enable();
 	}
-
-	return;
- failed:
-	trace_buffered_event_disable();
 }
 
 static void enable_trace_buffered_event(void *data)
@@ -2740,11 +2697,9 @@ void trace_buffered_event_disable(void)
 	if (--trace_buffered_event_ref)
 		return;
 
-	preempt_disable();
 	/* For each CPU, set the buffer as used. */
-	smp_call_function_many(tracing_buffer_mask,
-			       disable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	on_each_cpu_mask(tracing_buffer_mask, disable_trace_buffered_event,
+			 NULL, true);
 
 	/* Wait for all current users to finish */
 	synchronize_rcu();
@@ -2753,17 +2708,19 @@ void trace_buffered_event_disable(void)
 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
 		per_cpu(trace_buffered_event, cpu) = NULL;
 	}
+
 	/*
-	 * Make sure trace_buffered_event is NULL before clearing
-	 * trace_buffered_event_cnt.
+	 * Wait for all CPUs that potentially started checking if they can use
+	 * their event buffer only after the previous synchronize_rcu() call and
+	 * they still read a valid pointer from trace_buffered_event. It must be
+	 * ensured they don't see cleared trace_buffered_event_cnt else they
+	 * could wrongly decide to use the pointed-to buffer which is now freed.
 	 */
-	smp_wmb();
+	synchronize_rcu();
 
-	preempt_disable();
-	/* Do the work on each cpu */
-	smp_call_function_many(tracing_buffer_mask,
-			       enable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	/* For each CPU, relinquish the buffer */
+	on_each_cpu_mask(tracing_buffer_mask, enable_trace_buffered_event, NULL,
+			 true);
 }
 
 static struct trace_buffer *temp_buffer;
@@ -5895,6 +5852,15 @@ static void set_buffer_entries(struct array_buffer *buf, unsigned long val)
 		per_cpu_ptr(buf->data, cpu)->entries = val;
 }
 
+static void update_buffer_entries(struct array_buffer *buf, int cpu)
+{
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		set_buffer_entries(buf, ring_buffer_size(buf->buffer, 0));
+	} else {
+		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_size(buf->buffer, cpu);
+	}
+}
+
 #ifdef CONFIG_TRACER_MAX_TRACE
 /* resize @tr's buffer to the size of @size_tr's entries */
 static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
@@ -5939,13 +5905,15 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->array_buffer.buffer)
 		return 0;
 
+	/* Do not allow tracing while resizng ring buffer */
+	tracing_stop_tr(tr);
+
 	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
 	if (ret < 0)
-		return ret;
+		goto out_start;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!(tr->flags & TRACE_ARRAY_FL_GLOBAL) ||
-	    !tr->current_trace->use_max_tr)
+	if (!tr->current_trace->use_max_tr)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
@@ -5970,22 +5938,17 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 			WARN_ON(1);
 			tracing_disabled = 1;
 		}
-		return ret;
+		goto out_start;
 	}
 
-	if (cpu == RING_BUFFER_ALL_CPUS)
-		set_buffer_entries(&tr->max_buffer, size);
-	else
-		per_cpu_ptr(tr->max_buffer.data, cpu)->entries = size;
+	update_buffer_entries(&tr->max_buffer, cpu);
 
  out:
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
-	if (cpu == RING_BUFFER_ALL_CPUS)
-		set_buffer_entries(&tr->array_buffer, size);
-	else
-		per_cpu_ptr(tr->array_buffer.data, cpu)->entries = size;
-
+	update_buffer_entries(&tr->array_buffer, cpu);
+ out_start:
+	tracing_start_tr(tr);
 	return ret;
 }
 
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index ed9dd17f9348..7742ee689141 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -183,7 +183,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", },
+	{ .name = "events", .cap_sys_admin = 1 },
 };
 
 static void send_dm_alert(struct work_struct *work)
@@ -1616,11 +1616,13 @@ static const struct genl_small_ops dropmon_ops[] = {
 		.cmd = NET_DM_CMD_START,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_STOP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_CONFIG_GET,
diff --git a/net/core/filter.c b/net/core/filter.c
index ea8ab9c70483..6cfc8fb0562a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2595,6 +2595,22 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
 	return 0;
 }
 
+static void sk_msg_reset_curr(struct sk_msg *msg)
+{
+	u32 i = msg->sg.start;
+	u32 len = 0;
+
+	do {
+		len += sk_msg_elem(msg, i)->length;
+		sk_msg_iter_var_next(i);
+		if (len >= msg->sg.size)
+			break;
+	} while (i != msg->sg.end);
+
+	msg->sg.curr = i;
+	msg->sg.copybreak = 0;
+}
+
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
 	.func           = bpf_msg_cork_bytes,
 	.gpl_only       = false,
@@ -2714,6 +2730,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		      msg->sg.end - shift + NR_MSG_FRAG_IDS :
 		      msg->sg.end - shift;
 out:
+	sk_msg_reset_curr(msg);
 	msg->data = sg_virt(&msg->sg.data[first_sge]) + start - offset;
 	msg->data_end = msg->data + bytes;
 	return 0;
@@ -2850,6 +2867,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		msg->sg.data[new] = rsge;
 	}
 
+	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
 	return 0;
 }
@@ -3018,6 +3036,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 
 	sk_mem_uncharge(msg->sk, len - pop);
 	msg->sg.size -= (len - pop);
+	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
 	return 0;
 }
diff --git a/net/core/scm.c b/net/core/scm.c
index 8156d4fb8a39..3c7f160720d3 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -26,6 +26,7 @@
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
 #include <linux/errqueue.h>
+#include <linux/io_uring.h>
 
 #include <linux/uaccess.h>
 
@@ -103,6 +104,11 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 
 		if (fd < 0 || !(file = fget_raw(fd)))
 			return -EBADF;
+		/* don't allow io_uring files */
+		if (io_uring_get_socket(file)) {
+			fput(file);
+			return -EINVAL;
+		}
 		*fpp++ = file;
 		fpl->count++;
 	}
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 9d1a50657104..a6ad0fe1387c 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -629,15 +629,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 	}
 
 	if (dev->header_ops) {
+		int pull_len = tunnel->hlen + sizeof(struct iphdr);
+
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
 		tnl_params = (const struct iphdr *)skb->data;
 
-		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
-		 * to gre header.
-		 */
-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+		if (!pskb_network_may_pull(skb, pull_len))
+			goto free_skb;
+
+		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
+		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a8948c76d19b..0f9fe5edad14 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3772,8 +3772,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 * then we can probably ignore it.
 	 */
 	if (before(ack, prior_snd_una)) {
+		u32 max_window;
+
+		/* do not accept ACK for bytes we never sent. */
+		max_window = min_t(u64, tp->max_window, tp->bytes_acked);
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
-		if (before(ack, prior_snd_una - tp->max_window)) {
+		if (before(ack, prior_snd_una - max_window)) {
 			if (!(flag & FLAG_NO_CHALLENGE_ACK))
 				tcp_send_challenge_ack(sk, skb);
 			return -1;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index c783b9123132..608205c632c8 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1499,13 +1499,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 			if (!pn_leaf && !(pn->fn_flags & RTN_RTINFO)) {
 				pn_leaf = fib6_find_prefix(info->nl_net, table,
 							   pn);
-#if RT6_DEBUG >= 2
-				if (!pn_leaf) {
-					WARN_ON(!pn_leaf);
+				if (!pn_leaf)
 					pn_leaf =
 					    info->nl_net->ipv6.fib6_null_entry;
-				}
-#endif
 				fib6_info_hold(pn_leaf);
 				rcu_assign_pointer(pn->leaf, pn_leaf);
 			}
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 26613e3731d0..24f81826ed4a 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -61,6 +61,8 @@ MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
 	ip_set_dereference((inst)->ip_set_list)[id]
 #define ip_set_ref_netlink(inst,id)	\
 	rcu_dereference_raw((inst)->ip_set_list)[id]
+#define ip_set_dereference_nfnl(p)	\
+	rcu_dereference_check(p, lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET))
 
 /* The set types are implemented in modules and registered set types
  * can be found in ip_set_type_list. Adding/deleting types is
@@ -708,15 +710,10 @@ __ip_set_put_netlink(struct ip_set *set)
 static struct ip_set *
 ip_set_rcu_get(struct net *net, ip_set_id_t index)
 {
-	struct ip_set *set;
 	struct ip_set_net *inst = ip_set_pernet(net);
 
-	rcu_read_lock();
-	/* ip_set_list itself needs to be protected */
-	set = rcu_dereference(inst->ip_set_list)[index];
-	rcu_read_unlock();
-
-	return set;
+	/* ip_set_list and the set pointer need to be protected */
+	return ip_set_dereference_nfnl(inst->ip_set_list)[index];
 }
 
 static inline void
@@ -1407,6 +1404,9 @@ static int ip_set_swap(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
+	/* Make sure all readers of the old set pointers are completed. */
+	synchronize_rcu();
+
 	return 0;
 }
 
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index fbfcc3275cad..bc30bd121ff2 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2028,6 +2028,9 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		e = f->mt[r].e;
 
+		if (!nft_set_elem_active(&e->ext, iter->genmask))
+			goto cont;
+
 		elem.priv = e;
 
 		iter->err = iter->fn(ctx, set, iter, &elem);
diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index e85ce69924ae..50332888c8d2 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -76,18 +76,23 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		 */
 		return false;
 
-	filp = sk->sk_socket->file;
-	if (filp == NULL)
+	read_lock_bh(&sk->sk_callback_lock);
+	filp = sk->sk_socket ? sk->sk_socket->file : NULL;
+	if (filp == NULL) {
+		read_unlock_bh(&sk->sk_callback_lock);
 		return ((info->match ^ info->invert) &
 		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
+	}
 
 	if (info->match & XT_OWNER_UID) {
 		kuid_t uid_min = make_kuid(net->user_ns, info->uid_min);
 		kuid_t uid_max = make_kuid(net->user_ns, info->uid_max);
 		if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
 		     uid_lte(filp->f_cred->fsuid, uid_max)) ^
-		    !(info->invert & XT_OWNER_UID))
+		    !(info->invert & XT_OWNER_UID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
 	if (info->match & XT_OWNER_GID) {
@@ -112,10 +117,13 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			}
 		}
 
-		if (match ^ !(info->invert & XT_OWNER_GID))
+		if (match ^ !(info->invert & XT_OWNER_GID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
+	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9737c3229c12..901358a5b593 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1021,7 +1021,6 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	netlink_lock_table();
 	if (nlk->netlink_bind && groups) {
 		int group;
 
@@ -1033,13 +1032,14 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			if (!err)
 				continue;
 			netlink_undo_bind(group, groups, sk);
-			goto unlock;
+			return err;
 		}
 	}
 
 	/* No need for barriers here as we return to user-space without
 	 * using any of the bound attributes.
 	 */
+	netlink_lock_table();
 	if (!bound) {
 		err = nladdr->nl_pid ?
 			netlink_insert(sk, nladdr->nl_pid) :
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 9fd7ba01b9f8..e9035de65546 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1364,11 +1364,46 @@ static struct genl_family genl_ctrl __ro_after_init = {
 	.netnsok = true,
 };
 
+static int genl_bind(struct net *net, int group)
+{
+	const struct genl_family *family;
+	unsigned int id;
+	int ret = 0;
+
+	genl_lock_all();
+
+	idr_for_each_entry(&genl_fam_idr, family, id) {
+		const struct genl_multicast_group *grp;
+		int i;
+
+		if (family->n_mcgrps == 0)
+			continue;
+
+		i = group - family->mcgrp_offset;
+		if (i < 0 || i >= family->n_mcgrps)
+			continue;
+
+		grp = &family->mcgrps[i];
+		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
+		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+			ret = -EPERM;
+		if (grp->cap_sys_admin &&
+		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
+			ret = -EPERM;
+
+		break;
+	}
+
+	genl_unlock_all();
+	return ret;
+}
+
 static int __net_init genl_pernet_init(struct net *net)
 {
 	struct netlink_kernel_cfg cfg = {
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
+		.bind		= genl_bind,
 	};
 
 	/* we'll bump the group number right afterwards */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index bbdb32acac32..b292d58fdcc4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4248,7 +4248,7 @@ static void packet_mm_open(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_inc(&pkt_sk(sk)->mapped);
+		atomic_long_inc(&pkt_sk(sk)->mapped);
 }
 
 static void packet_mm_close(struct vm_area_struct *vma)
@@ -4258,7 +4258,7 @@ static void packet_mm_close(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_dec(&pkt_sk(sk)->mapped);
+		atomic_long_dec(&pkt_sk(sk)->mapped);
 }
 
 static const struct vm_operations_struct packet_mmap_ops = {
@@ -4353,7 +4353,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	if (!closing) {
-		if (atomic_read(&po->mapped))
+		if (atomic_long_read(&po->mapped))
 			goto out;
 		if (packet_read_pending(rb))
 			goto out;
@@ -4456,7 +4456,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
-	if (closing || atomic_read(&po->mapped) == 0) {
+	if (closing || atomic_long_read(&po->mapped) == 0) {
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4474,9 +4474,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		po->prot_hook.func = (po->rx_ring.pg_vec) ?
 						tpacket_rcv : packet_rcv;
 		skb_queue_purge(rb_queue);
-		if (atomic_read(&po->mapped))
-			pr_err("packet_mmap: vma is busy: %d\n",
-			       atomic_read(&po->mapped));
+		if (atomic_long_read(&po->mapped))
+			pr_err("packet_mmap: vma is busy: %ld\n",
+			       atomic_long_read(&po->mapped));
 	}
 	mutex_unlock(&po->pg_vec_lock);
 
@@ -4554,7 +4554,7 @@ static int packet_mmap(struct file *file, struct socket *sock,
 		}
 	}
 
-	atomic_inc(&po->mapped);
+	atomic_long_inc(&po->mapped);
 	vma->vm_ops = &packet_mmap_ops;
 	err = 0;
 
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 3938cb413d5d..69e58cb74492 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -126,7 +126,7 @@ struct packet_sock {
 	__be16			num;
 	struct packet_rollover	*rollover;
 	struct packet_mclist	*mclist;
-	atomic_t		mapped;
+	atomic_long_t		mapped;
 	enum tpacket_versions	tp_version;
 	unsigned int		tp_hdrlen;
 	unsigned int		tp_reserve;
diff --git a/net/psample/psample.c b/net/psample/psample.c
index 482c07f2766b..5913da77c71d 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -30,7 +30,8 @@ enum psample_nl_multicast_groups {
 
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
-	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
+	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
+				      .flags = GENL_UNS_ADMIN_PERM },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index d2c38584ece6..758884b61f92 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -142,15 +142,11 @@ $total_size = 0;
 while (my $line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
 		$func = $1;
-		next if $line !~ m/^($xs*)/;
+		next if $line !~ m/^($x*)/;
 		if ($total_size > $min_stack) {
 			push @stack, "$intro$total_size\n";
 		}
-
-		$addr = $1;
-		$addr =~ s/ /0/g;
-		$addr = "0x$addr";
-
+		$addr = "0x$1";
 		$intro = "$addr $func [$file]:";
 		my $padlen = 56 - length($intro);
 		while ($padlen > 0) {
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index ffa3ec65cc90..a2056fa80de2 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -123,9 +123,9 @@ static long long sym_get_range_val(struct symbol *sym, int base)
 static void sym_validate_range(struct symbol *sym)
 {
 	struct property *prop;
+	struct symbol *range_sym;
 	int base;
 	long long val, val2;
-	char str[64];
 
 	switch (sym->type) {
 	case S_INT:
@@ -141,17 +141,15 @@ static void sym_validate_range(struct symbol *sym)
 	if (!prop)
 		return;
 	val = strtoll(sym->curr.val, NULL, base);
-	val2 = sym_get_range_val(prop->expr->left.sym, base);
+	range_sym = prop->expr->left.sym;
+	val2 = sym_get_range_val(range_sym, base);
 	if (val >= val2) {
-		val2 = sym_get_range_val(prop->expr->right.sym, base);
+		range_sym = prop->expr->right.sym;
+		val2 = sym_get_range_val(range_sym, base);
 		if (val <= val2)
 			return;
 	}
-	if (sym->type == S_INT)
-		sprintf(str, "%lld", val2);
-	else
-		sprintf(str, "0x%llx", val2);
-	sym->curr.val = xstrdup(str);
+	sym->curr.val = range_sym->curr.val;
 }
 
 static void sym_set_changed(struct symbol *sym)
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 59d222446d77..bec81f6ba6ba 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -251,6 +251,7 @@ static const char * const snd_pcm_state_names[] = {
 	STATE(DRAINING),
 	STATE(PAUSED),
 	STATE(SUSPENDED),
+	STATE(DISCONNECTED),
 };
 
 static const char * const snd_pcm_access_names[] = {
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3d94a2f41d82..d9140630cf3d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11227,6 +11227,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3321, "Lenovo ThinkCentre M70 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x331b, "Lenovo ThinkCentre M90 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3364, "Lenovo ThinkCentre M90 Gen5", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 10189f44af28..ef7936fce7a2 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3763,12 +3763,12 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].base_offset,
 					  &region->base_addr);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].size_offset,
 					  &offset);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		region->cumulative_size = offset;
 
@@ -3779,6 +3779,10 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 	}
 
 	return 0;
+
+err:
+	kfree(buf->regions);
+	return ret;
 }
 
 static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b95d3c485d27..6ca63ab6bee5 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -279,6 +279,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -286,6 +287,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -295,8 +297,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
