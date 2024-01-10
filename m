Return-Path: <linux-kernel+bounces-17954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E40A8255FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F87C1C23120
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111E2E855;
	Fri,  5 Jan 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7tXidFA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DE2E823;
	Fri,  5 Jan 2024 14:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796B9C433CA;
	Fri,  5 Jan 2024 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465880;
	bh=I+KNHGm4vi5dgFLc5CSeDuxFtk3AFn3CdAwM0cxG+t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7tXidFAkZJP1UNBQQbVyg0OfxCUxo5BJYP4reyVh5YKliN/xRNLhrefnvrbIh6j/
	 UTFlSDLSa3RZLY0VhxMV0vJ4hz7tmq1Tf2sRm/VZmWtdoYbJnLbiT9a8Q+9q4/Qj5n
	 DWyhjB4L1DSLp5OpbTf1gecxq5inWPPtlsLOg7Is=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.146
Date: Fri,  5 Jan 2024 15:42:33 +0100
Message-ID: <2024010533-staunch-enforcer-b1a3@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024010533-untrimmed-cure-1ca0@gregkh>
References: <2024010533-untrimmed-cure-1ca0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
index ff317fd7c15b..2e1fcff3c280 100644
--- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -14,9 +14,11 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-ocotp
-      - fsl,imx28-ocotp
+    items:
+      - enum:
+          - fsl,imx23-ocotp
+          - fsl,imx28-ocotp
+      - const: fsl,ocotp
 
   "#address-cells":
     const: 1
@@ -40,7 +42,7 @@ additionalProperties: false
 examples:
   - |
     ocotp: efuse@8002c000 {
-        compatible = "fsl,imx28-ocotp";
+        compatible = "fsl,imx28-ocotp", "fsl,ocotp";
         #address-cells = <1>;
         #size-cells = <1>;
         reg = <0x8002c000 0x2000>;
diff --git a/Makefile b/Makefile
index d46825496e8e..bf3b4827b612 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 145
+SUBLEVEL = 146
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f53695ecbb78..7daf6ae2cd9a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -349,6 +349,7 @@ usb: target-module@47400000 {
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>,
 					<SYSC_IDLE_SMART_WKUP>;
+			ti,sysc-delay-us = <2>;
 			clocks = <&l3s_clkctrl AM3_L3S_USB_OTG_HS_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 61a3fb3e2a2f..0cb5ec39e33a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -144,7 +144,7 @@ ocp: ocp {
 
 		l3-noc@44000000 {
 			compatible = "ti,dra7-l3-noc";
-			reg = <0x44000000 0x1000>,
+			reg = <0x44000000 0x1000000>,
 			      <0x45000000 0x1000>;
 			interrupts-extended = <&crossbar_mpu GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
 					      <&wakeupgen GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 59755b5a1ad7..75091aa7269a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -793,11 +793,16 @@ void __init omap_soc_device_init(void)
 
 	soc_dev_attr->machine  = soc_name;
 	soc_dev_attr->family   = omap_get_family();
+	if (!soc_dev_attr->family) {
+		kfree(soc_dev_attr);
+		return;
+	}
 	soc_dev_attr->revision = soc_rev;
 	soc_dev_attr->custom_attr_group = omap_soc_groups[0];
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
 		kfree(soc_dev_attr);
 		return;
 	}
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3fe816c244ce..47d737672aba 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -356,7 +356,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_pmu_vcpu_destroy(vcpu);
-
+	kvm_vgic_vcpu_destroy(vcpu);
 	kvm_arm_vcpu_destroy(vcpu);
 }
 
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 340c51d87677..1ccbb19fad77 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -363,7 +363,10 @@ void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
 	vgic_flush_pending_lpis(vcpu);
 
 	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
-	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
+		vgic_unregister_redist_iodev(vcpu);
+		vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+	}
 }
 
 /* To be called with kvm->lock held */
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index a09cdc0b953c..b94a6d1de35d 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -744,7 +744,7 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
+void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 {
 	struct vgic_io_device *rd_dev = &vcpu->arch.vgic_cpu.rd_iodev;
 
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 36021c31a706..640249950acf 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -223,6 +223,7 @@ int vgic_v3_lpi_sync_pending_status(struct kvm *kvm, struct vgic_irq *irq);
 int vgic_v3_save_pending_tables(struct kvm *kvm);
 int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count);
 int vgic_register_redist_iodev(struct kvm_vcpu *vcpu);
+void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu);
 bool vgic_v3_check_base(struct kvm *kvm);
 
 void vgic_v3_load(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/include/asm/fpu/api.h b/arch/s390/include/asm/fpu/api.h
index a959b815a58b..b8c7e8538c85 100644
--- a/arch/s390/include/asm/fpu/api.h
+++ b/arch/s390/include/asm/fpu/api.h
@@ -78,7 +78,7 @@ static inline int test_fp_ctl(u32 fpc)
 #define KERNEL_VXR_HIGH		(KERNEL_VXR_V16V23|KERNEL_VXR_V24V31)
 
 #define KERNEL_VXR		(KERNEL_VXR_LOW|KERNEL_VXR_HIGH)
-#define KERNEL_FPR		(KERNEL_FPC|KERNEL_VXR_V0V7)
+#define KERNEL_FPR		(KERNEL_FPC|KERNEL_VXR_LOW)
 
 struct kernel_fpu;
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c9e3246bf4f3..aea88d0d8352 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -963,8 +963,8 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	} else {
 		local_irq_save(flags);
 		memcpy(addr, opcode, len);
-		local_irq_restore(flags);
 		sync_core();
+		local_irq_restore(flags);
 
 		/*
 		 * Could also do a CLFLUSH here to speed up CPU recovery; but
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index dccaab2113f9..ee6e3cda1738 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2403,3 +2403,49 @@ bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
 }
+
+void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
+			       struct bpf_prog *new, struct bpf_prog *old)
+{
+	u8 *old_addr, *new_addr, *old_bypass_addr;
+	int ret;
+
+	old_bypass_addr = old ? NULL : poke->bypass_addr;
+	old_addr = old ? (u8 *)old->bpf_func + poke->adj_off : NULL;
+	new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
+
+	/*
+	 * On program loading or teardown, the program's kallsym entry
+	 * might not be in place, so we use __bpf_arch_text_poke to skip
+	 * the kallsyms check.
+	 */
+	if (new) {
+		ret = __bpf_arch_text_poke(poke->tailcall_target,
+					   BPF_MOD_JUMP,
+					   old_addr, new_addr, true);
+		BUG_ON(ret < 0);
+		if (!old) {
+			ret = __bpf_arch_text_poke(poke->tailcall_bypass,
+						   BPF_MOD_JUMP,
+						   poke->bypass_addr,
+						   NULL, true);
+			BUG_ON(ret < 0);
+		}
+	} else {
+		ret = __bpf_arch_text_poke(poke->tailcall_bypass,
+					   BPF_MOD_JUMP,
+					   old_bypass_addr,
+					   poke->bypass_addr, true);
+		BUG_ON(ret < 0);
+		/* let other CPUs finish the execution of program
+		 * so that it will not possible to expose them
+		 * to invalid nop, stack unwind, nop state
+		 */
+		if (!ret)
+			synchronize_rcu();
+		ret = __bpf_arch_text_poke(poke->tailcall_target,
+					   BPF_MOD_JUMP,
+					   old_addr, NULL, true);
+		BUG_ON(ret < 0);
+	}
+}
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 17a648d64356..21f4184db42f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -18,12 +18,19 @@
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
 
-struct fwnode_handle *dev_fwnode(struct device *dev)
+struct fwnode_handle *__dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
 		of_fwnode_handle(dev->of_node) : dev->fwnode;
 }
-EXPORT_SYMBOL_GPL(dev_fwnode);
+EXPORT_SYMBOL_GPL(__dev_fwnode);
+
+const struct fwnode_handle *__dev_fwnode_const(const struct device *dev)
+{
+	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
+		of_fwnode_handle(dev->of_node) : dev->fwnode;
+}
+EXPORT_SYMBOL_GPL(__dev_fwnode_const);
 
 /**
  * device_property_present - check if a property of a device is present
@@ -1281,7 +1288,7 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
-const void *device_get_match_data(struct device *dev)
+const void *device_get_match_data(const struct device *dev)
 {
 	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
 }
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 0a159989c899..05ae57775853 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2104,13 +2104,23 @@ static int sysc_reset(struct sysc *ddata)
 		sysc_val = sysc_read_sysconfig(ddata);
 		sysc_val |= sysc_mask;
 		sysc_write(ddata, sysc_offset, sysc_val);
-		/* Flush posted write */
+
+		/*
+		 * Some devices need a delay before reading registers
+		 * after reset. Presumably a srst_udelay is not needed
+		 * for devices that use a rstctrl register reset.
+		 */
+		if (ddata->cfg.srst_udelay)
+			fsleep(ddata->cfg.srst_udelay);
+
+		/*
+		 * Flush posted write. For devices needing srst_udelay
+		 * this should trigger an interconnect error if the
+		 * srst_udelay value is needed but not configured.
+		 */
 		sysc_val = sysc_read_sysconfig(ddata);
 	}
 
-	if (ddata->cfg.srst_udelay)
-		fsleep(ddata->cfg.srst_udelay);
-
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);
 
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index a503f37001eb..8773cbf6138f 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -277,13 +277,15 @@ static void dwapb_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val |= BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTEN) | BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTEN, val);
+	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
@@ -291,12 +293,14 @@ static void dwapb_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val &= ~BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
+	val = dwapb_read(gpio, GPIO_INTEN) & ~BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTEN, val);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 2a2e0691462b..1db991cb2efc 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2224,10 +2224,7 @@ static int lineinfo_unwatch(struct gpio_chardev_data *cdev, void __user *ip)
 	return 0;
 }
 
-/*
- * gpio_ioctl() - ioctl handler for the GPIO chardev
- */
-static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long gpio_ioctl_unlocked(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_device *gdev = cdev->gdev;
@@ -2264,6 +2261,17 @@ static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 }
 
+/*
+ * gpio_ioctl() - ioctl handler for the GPIO chardev
+ */
+static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct gpio_chardev_data *cdev = file->private_data;
+
+	return call_ioctl_locked(file, cmd, arg, cdev->gdev,
+				 gpio_ioctl_unlocked);
+}
+
 #ifdef CONFIG_COMPAT
 static long gpio_ioctl_compat(struct file *file, unsigned int cmd,
 			      unsigned long arg)
diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
index b4e7ac51aa31..655c039a9c8f 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -40,6 +40,7 @@
 #include "intel_global_state.h"
 #include "intel_hdcp.h"
 #include "intel_psr.h"
+#include "intel_fb.h"
 #include "skl_universal_plane.h"
 
 /**
@@ -310,198 +311,6 @@ intel_crtc_destroy_state(struct drm_crtc *crtc,
 	kfree(crtc_state);
 }
 
-static void intel_atomic_setup_scaler(struct intel_crtc_scaler_state *scaler_state,
-				      int num_scalers_need, struct intel_crtc *intel_crtc,
-				      const char *name, int idx,
-				      struct intel_plane_state *plane_state,
-				      int *scaler_id)
-{
-	struct drm_i915_private *dev_priv = to_i915(intel_crtc->base.dev);
-	int j;
-	u32 mode;
-
-	if (*scaler_id < 0) {
-		/* find a free scaler */
-		for (j = 0; j < intel_crtc->num_scalers; j++) {
-			if (scaler_state->scalers[j].in_use)
-				continue;
-
-			*scaler_id = j;
-			scaler_state->scalers[*scaler_id].in_use = 1;
-			break;
-		}
-	}
-
-	if (drm_WARN(&dev_priv->drm, *scaler_id < 0,
-		     "Cannot find scaler for %s:%d\n", name, idx))
-		return;
-
-	/* set scaler mode */
-	if (plane_state && plane_state->hw.fb &&
-	    plane_state->hw.fb->format->is_yuv &&
-	    plane_state->hw.fb->format->num_planes > 1) {
-		struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
-		if (DISPLAY_VER(dev_priv) == 9) {
-			mode = SKL_PS_SCALER_MODE_NV12;
-		} else if (icl_is_hdr_plane(dev_priv, plane->id)) {
-			/*
-			 * On gen11+'s HDR planes we only use the scaler for
-			 * scaling. They have a dedicated chroma upsampler, so
-			 * we don't need the scaler to upsample the UV plane.
-			 */
-			mode = PS_SCALER_MODE_NORMAL;
-		} else {
-			struct intel_plane *linked =
-				plane_state->planar_linked_plane;
-
-			mode = PS_SCALER_MODE_PLANAR;
-
-			if (linked)
-				mode |= PS_PLANE_Y_SEL(linked->id);
-		}
-	} else if (DISPLAY_VER(dev_priv) >= 10) {
-		mode = PS_SCALER_MODE_NORMAL;
-	} else if (num_scalers_need == 1 && intel_crtc->num_scalers > 1) {
-		/*
-		 * when only 1 scaler is in use on a pipe with 2 scalers
-		 * scaler 0 operates in high quality (HQ) mode.
-		 * In this case use scaler 0 to take advantage of HQ mode
-		 */
-		scaler_state->scalers[*scaler_id].in_use = 0;
-		*scaler_id = 0;
-		scaler_state->scalers[0].in_use = 1;
-		mode = SKL_PS_SCALER_MODE_HQ;
-	} else {
-		mode = SKL_PS_SCALER_MODE_DYN;
-	}
-
-	drm_dbg_kms(&dev_priv->drm, "Attached scaler id %u.%u to %s:%d\n",
-		    intel_crtc->pipe, *scaler_id, name, idx);
-	scaler_state->scalers[*scaler_id].mode = mode;
-}
-
-/**
- * intel_atomic_setup_scalers() - setup scalers for crtc per staged requests
- * @dev_priv: i915 device
- * @intel_crtc: intel crtc
- * @crtc_state: incoming crtc_state to validate and setup scalers
- *
- * This function sets up scalers based on staged scaling requests for
- * a @crtc and its planes. It is called from crtc level check path. If request
- * is a supportable request, it attaches scalers to requested planes and crtc.
- *
- * This function takes into account the current scaler(s) in use by any planes
- * not being part of this atomic state
- *
- *  Returns:
- *         0 - scalers were setup succesfully
- *         error code - otherwise
- */
-int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
-			       struct intel_crtc *intel_crtc,
-			       struct intel_crtc_state *crtc_state)
-{
-	struct drm_plane *plane = NULL;
-	struct intel_plane *intel_plane;
-	struct intel_plane_state *plane_state = NULL;
-	struct intel_crtc_scaler_state *scaler_state =
-		&crtc_state->scaler_state;
-	struct drm_atomic_state *drm_state = crtc_state->uapi.state;
-	struct intel_atomic_state *intel_state = to_intel_atomic_state(drm_state);
-	int num_scalers_need;
-	int i;
-
-	num_scalers_need = hweight32(scaler_state->scaler_users);
-
-	/*
-	 * High level flow:
-	 * - staged scaler requests are already in scaler_state->scaler_users
-	 * - check whether staged scaling requests can be supported
-	 * - add planes using scalers that aren't in current transaction
-	 * - assign scalers to requested users
-	 * - as part of plane commit, scalers will be committed
-	 *   (i.e., either attached or detached) to respective planes in hw
-	 * - as part of crtc_commit, scaler will be either attached or detached
-	 *   to crtc in hw
-	 */
-
-	/* fail if required scalers > available scalers */
-	if (num_scalers_need > intel_crtc->num_scalers){
-		drm_dbg_kms(&dev_priv->drm,
-			    "Too many scaling requests %d > %d\n",
-			    num_scalers_need, intel_crtc->num_scalers);
-		return -EINVAL;
-	}
-
-	/* walkthrough scaler_users bits and start assigning scalers */
-	for (i = 0; i < sizeof(scaler_state->scaler_users) * 8; i++) {
-		int *scaler_id;
-		const char *name;
-		int idx;
-
-		/* skip if scaler not required */
-		if (!(scaler_state->scaler_users & (1 << i)))
-			continue;
-
-		if (i == SKL_CRTC_INDEX) {
-			name = "CRTC";
-			idx = intel_crtc->base.base.id;
-
-			/* panel fitter case: assign as a crtc scaler */
-			scaler_id = &scaler_state->scaler_id;
-		} else {
-			name = "PLANE";
-
-			/* plane scaler case: assign as a plane scaler */
-			/* find the plane that set the bit as scaler_user */
-			plane = drm_state->planes[i].ptr;
-
-			/*
-			 * to enable/disable hq mode, add planes that are using scaler
-			 * into this transaction
-			 */
-			if (!plane) {
-				struct drm_plane_state *state;
-
-				/*
-				 * GLK+ scalers don't have a HQ mode so it
-				 * isn't necessary to change between HQ and dyn mode
-				 * on those platforms.
-				 */
-				if (DISPLAY_VER(dev_priv) >= 10)
-					continue;
-
-				plane = drm_plane_from_index(&dev_priv->drm, i);
-				state = drm_atomic_get_plane_state(drm_state, plane);
-				if (IS_ERR(state)) {
-					drm_dbg_kms(&dev_priv->drm,
-						    "Failed to add [PLANE:%d] to drm_state\n",
-						    plane->base.id);
-					return PTR_ERR(state);
-				}
-			}
-
-			intel_plane = to_intel_plane(plane);
-			idx = plane->base.id;
-
-			/* plane on different crtc cannot be a scaler user of this crtc */
-			if (drm_WARN_ON(&dev_priv->drm,
-					intel_plane->pipe != intel_crtc->pipe))
-				continue;
-
-			plane_state = intel_atomic_get_new_plane_state(intel_state,
-								       intel_plane);
-			scaler_id = &plane_state->scaler_id;
-		}
-
-		intel_atomic_setup_scaler(scaler_state, num_scalers_need,
-					  intel_crtc, name, idx,
-					  plane_state, scaler_id);
-	}
-
-	return 0;
-}
-
 struct drm_atomic_state *
 intel_atomic_state_alloc(struct drm_device *dev)
 {
diff --git a/drivers/gpu/drm/i915/display/intel_atomic.h b/drivers/gpu/drm/i915/display/intel_atomic.h
index d2700c74c9da..509deb75f698 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.h
+++ b/drivers/gpu/drm/i915/display/intel_atomic.h
@@ -54,8 +54,4 @@ struct intel_crtc_state *
 intel_atomic_get_crtc_state(struct drm_atomic_state *state,
 			    struct intel_crtc *crtc);
 
-int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
-			       struct intel_crtc *intel_crtc,
-			       struct intel_crtc_state *crtc_state);
-
 #endif /* __INTEL_ATOMIC_H__ */
diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
index 37eabeff8197..e55df2f05cbd 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.c
+++ b/drivers/gpu/drm/i915/display/skl_scaler.c
@@ -294,6 +294,263 @@ int skl_update_scaler_plane(struct intel_crtc_state *crtc_state,
 	return 0;
 }
 
+static int intel_atomic_setup_scaler(struct intel_crtc_scaler_state *scaler_state,
+				     int num_scalers_need, struct intel_crtc *intel_crtc,
+				     const char *name, int idx,
+				     struct intel_plane_state *plane_state,
+				     int *scaler_id)
+{
+	struct drm_i915_private *dev_priv = to_i915(intel_crtc->base.dev);
+	int j;
+	u32 mode;
+
+	if (*scaler_id < 0) {
+		/* find a free scaler */
+		for (j = 0; j < intel_crtc->num_scalers; j++) {
+			if (scaler_state->scalers[j].in_use)
+				continue;
+
+			*scaler_id = j;
+			scaler_state->scalers[*scaler_id].in_use = 1;
+			break;
+		}
+	}
+
+	if (drm_WARN(&dev_priv->drm, *scaler_id < 0,
+		     "Cannot find scaler for %s:%d\n", name, idx))
+		return -EINVAL;
+
+	/* set scaler mode */
+	if (plane_state && plane_state->hw.fb &&
+	    plane_state->hw.fb->format->is_yuv &&
+	    plane_state->hw.fb->format->num_planes > 1) {
+		struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
+
+		if (DISPLAY_VER(dev_priv) == 9) {
+			mode = SKL_PS_SCALER_MODE_NV12;
+		} else if (icl_is_hdr_plane(dev_priv, plane->id)) {
+			/*
+			 * On gen11+'s HDR planes we only use the scaler for
+			 * scaling. They have a dedicated chroma upsampler, so
+			 * we don't need the scaler to upsample the UV plane.
+			 */
+			mode = PS_SCALER_MODE_NORMAL;
+		} else {
+			struct intel_plane *linked =
+				plane_state->planar_linked_plane;
+
+			mode = PS_SCALER_MODE_PLANAR;
+
+			if (linked)
+				mode |= PS_PLANE_Y_SEL(linked->id);
+		}
+	} else if (DISPLAY_VER(dev_priv) >= 10) {
+		mode = PS_SCALER_MODE_NORMAL;
+	} else if (num_scalers_need == 1 && intel_crtc->num_scalers > 1) {
+		/*
+		 * when only 1 scaler is in use on a pipe with 2 scalers
+		 * scaler 0 operates in high quality (HQ) mode.
+		 * In this case use scaler 0 to take advantage of HQ mode
+		 */
+		scaler_state->scalers[*scaler_id].in_use = 0;
+		*scaler_id = 0;
+		scaler_state->scalers[0].in_use = 1;
+		mode = SKL_PS_SCALER_MODE_HQ;
+	} else {
+		mode = SKL_PS_SCALER_MODE_DYN;
+	}
+
+	/*
+	 * FIXME: we should also check the scaler factors for pfit, so
+	 * this shouldn't be tied directly to planes.
+	 */
+	if (plane_state && plane_state->hw.fb) {
+		const struct drm_framebuffer *fb = plane_state->hw.fb;
+		const struct drm_rect *src = &plane_state->uapi.src;
+		const struct drm_rect *dst = &plane_state->uapi.dst;
+		int hscale, vscale, max_vscale, max_hscale;
+
+		/*
+		 * FIXME: When two scalers are needed, but only one of
+		 * them needs to downscale, we should make sure that
+		 * the one that needs downscaling support is assigned
+		 * as the first scaler, so we don't reject downscaling
+		 * unnecessarily.
+		 */
+
+		if (DISPLAY_VER(dev_priv) >= 14) {
+			/*
+			 * On versions 14 and up, only the first
+			 * scaler supports a vertical scaling factor
+			 * of more than 1.0, while a horizontal
+			 * scaling factor of 3.0 is supported.
+			 */
+			max_hscale = 0x30000 - 1;
+			if (*scaler_id == 0)
+				max_vscale = 0x30000 - 1;
+			else
+				max_vscale = 0x10000;
+
+		} else if (DISPLAY_VER(dev_priv) >= 10 ||
+			   !intel_format_info_is_yuv_semiplanar(fb->format, fb->modifier)) {
+			max_hscale = 0x30000 - 1;
+			max_vscale = 0x30000 - 1;
+		} else {
+			max_hscale = 0x20000 - 1;
+			max_vscale = 0x20000 - 1;
+		}
+
+		/*
+		 * FIXME: We should change the if-else block above to
+		 * support HQ vs dynamic scaler properly.
+		 */
+
+		/* Check if required scaling is within limits */
+		hscale = drm_rect_calc_hscale(src, dst, 1, max_hscale);
+		vscale = drm_rect_calc_vscale(src, dst, 1, max_vscale);
+
+		if (hscale < 0 || vscale < 0) {
+			drm_dbg_kms(&dev_priv->drm,
+				    "Scaler %d doesn't support required plane scaling\n",
+				    *scaler_id);
+			drm_rect_debug_print("src: ", src, true);
+			drm_rect_debug_print("dst: ", dst, false);
+
+			return -EINVAL;
+		}
+	}
+
+	drm_dbg_kms(&dev_priv->drm, "Attached scaler id %u.%u to %s:%d\n",
+		    intel_crtc->pipe, *scaler_id, name, idx);
+	scaler_state->scalers[*scaler_id].mode = mode;
+
+	return 0;
+}
+
+/**
+ * intel_atomic_setup_scalers() - setup scalers for crtc per staged requests
+ * @dev_priv: i915 device
+ * @intel_crtc: intel crtc
+ * @crtc_state: incoming crtc_state to validate and setup scalers
+ *
+ * This function sets up scalers based on staged scaling requests for
+ * a @crtc and its planes. It is called from crtc level check path. If request
+ * is a supportable request, it attaches scalers to requested planes and crtc.
+ *
+ * This function takes into account the current scaler(s) in use by any planes
+ * not being part of this atomic state
+ *
+ *  Returns:
+ *         0 - scalers were setup successfully
+ *         error code - otherwise
+ */
+int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
+			       struct intel_crtc *intel_crtc,
+			       struct intel_crtc_state *crtc_state)
+{
+	struct drm_plane *plane = NULL;
+	struct intel_plane *intel_plane;
+	struct intel_crtc_scaler_state *scaler_state =
+		&crtc_state->scaler_state;
+	struct drm_atomic_state *drm_state = crtc_state->uapi.state;
+	struct intel_atomic_state *intel_state = to_intel_atomic_state(drm_state);
+	int num_scalers_need;
+	int i;
+
+	num_scalers_need = hweight32(scaler_state->scaler_users);
+
+	/*
+	 * High level flow:
+	 * - staged scaler requests are already in scaler_state->scaler_users
+	 * - check whether staged scaling requests can be supported
+	 * - add planes using scalers that aren't in current transaction
+	 * - assign scalers to requested users
+	 * - as part of plane commit, scalers will be committed
+	 *   (i.e., either attached or detached) to respective planes in hw
+	 * - as part of crtc_commit, scaler will be either attached or detached
+	 *   to crtc in hw
+	 */
+
+	/* fail if required scalers > available scalers */
+	if (num_scalers_need > intel_crtc->num_scalers) {
+		drm_dbg_kms(&dev_priv->drm,
+			    "Too many scaling requests %d > %d\n",
+			    num_scalers_need, intel_crtc->num_scalers);
+		return -EINVAL;
+	}
+
+	/* walkthrough scaler_users bits and start assigning scalers */
+	for (i = 0; i < sizeof(scaler_state->scaler_users) * 8; i++) {
+		struct intel_plane_state *plane_state = NULL;
+		int *scaler_id;
+		const char *name;
+		int idx, ret;
+
+		/* skip if scaler not required */
+		if (!(scaler_state->scaler_users & (1 << i)))
+			continue;
+
+		if (i == SKL_CRTC_INDEX) {
+			name = "CRTC";
+			idx = intel_crtc->base.base.id;
+
+			/* panel fitter case: assign as a crtc scaler */
+			scaler_id = &scaler_state->scaler_id;
+		} else {
+			name = "PLANE";
+
+			/* plane scaler case: assign as a plane scaler */
+			/* find the plane that set the bit as scaler_user */
+			plane = drm_state->planes[i].ptr;
+
+			/*
+			 * to enable/disable hq mode, add planes that are using scaler
+			 * into this transaction
+			 */
+			if (!plane) {
+				struct drm_plane_state *state;
+
+				/*
+				 * GLK+ scalers don't have a HQ mode so it
+				 * isn't necessary to change between HQ and dyn mode
+				 * on those platforms.
+				 */
+				if (DISPLAY_VER(dev_priv) >= 10)
+					continue;
+
+				plane = drm_plane_from_index(&dev_priv->drm, i);
+				state = drm_atomic_get_plane_state(drm_state, plane);
+				if (IS_ERR(state)) {
+					drm_dbg_kms(&dev_priv->drm,
+						    "Failed to add [PLANE:%d] to drm_state\n",
+						    plane->base.id);
+					return PTR_ERR(state);
+				}
+			}
+
+			intel_plane = to_intel_plane(plane);
+			idx = plane->base.id;
+
+			/* plane on different crtc cannot be a scaler user of this crtc */
+			if (drm_WARN_ON(&dev_priv->drm,
+					intel_plane->pipe != intel_crtc->pipe))
+				continue;
+
+			plane_state = intel_atomic_get_new_plane_state(intel_state,
+								       intel_plane);
+			scaler_id = &plane_state->scaler_id;
+		}
+
+		ret = intel_atomic_setup_scaler(scaler_state, num_scalers_need,
+						intel_crtc, name, idx,
+						plane_state, scaler_id);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int glk_coef_tap(int i)
 {
 	return i % 7;
diff --git a/drivers/gpu/drm/i915/display/skl_scaler.h b/drivers/gpu/drm/i915/display/skl_scaler.h
index 0097d5d08e10..f040f6ac061f 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.h
+++ b/drivers/gpu/drm/i915/display/skl_scaler.h
@@ -8,17 +8,22 @@
 #include <linux/types.h>
 
 enum drm_scaling_filter;
+enum pipe;
 struct drm_i915_private;
+struct intel_crtc;
 struct intel_crtc_state;
-struct intel_plane_state;
 struct intel_plane;
-enum pipe;
+struct intel_plane_state;
 
 int skl_update_scaler_crtc(struct intel_crtc_state *crtc_state);
 
 int skl_update_scaler_plane(struct intel_crtc_state *crtc_state,
 			    struct intel_plane_state *plane_state);
 
+int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
+			       struct intel_crtc *intel_crtc,
+			       struct intel_crtc_state *crtc_state);
+
 void skl_pfit_enable(const struct intel_crtc_state *crtc_state);
 
 void skl_program_plane_scaler(struct intel_plane *plane,
@@ -26,4 +31,5 @@ void skl_program_plane_scaler(struct intel_plane *plane,
 			      const struct intel_plane_state *plane_state);
 void skl_detach_scalers(const struct intel_crtc_state *crtc_state);
 void skl_scaler_disable(const struct intel_crtc_state *old_crtc_state);
+
 #endif
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index b7cad1bed3dc..e61ed702a12c 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -250,18 +250,46 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	if (!slave)
 		return 0;
 
-	command = readl(bus->base + ASPEED_I2C_CMD_REG);
+	/*
+	 * Handle stop conditions early, prior to SLAVE_MATCH. Some masters may drive
+	 * transfers with low enough latency between the nak/stop phase of the current
+	 * command and the start/address phase of the following command that the
+	 * interrupts are coalesced by the time we process them.
+	 */
+	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
+		irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
+		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
+	}
+
+	if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
+	    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
+		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
+		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
+	}
+
+	/* Propagate any stop conditions to the slave implementation. */
+	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
+		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
+		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
+	}
 
-	/* Slave was requested, restart state machine. */
+	/*
+	 * Now that we've dealt with any potentially coalesced stop conditions,
+	 * address any start conditions.
+	 */
 	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
 		irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
 		bus->slave_state = ASPEED_I2C_SLAVE_START;
 	}
 
-	/* Slave is not currently active, irq was for someone else. */
+	/*
+	 * If the slave has been stopped and not started then slave interrupt
+	 * handling is complete.
+	 */
 	if (bus->slave_state == ASPEED_I2C_SLAVE_INACTIVE)
 		return irq_handled;
 
+	command = readl(bus->base + ASPEED_I2C_CMD_REG);
 	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
 		irq_status, command);
 
@@ -280,17 +308,6 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		irq_handled |= ASPEED_I2CD_INTR_RX_DONE;
 	}
 
-	/* Slave was asked to stop. */
-	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
-		irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
-		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
-	}
-	if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
-	    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
-		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
-		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
-	}
-
 	switch (bus->slave_state) {
 	case ASPEED_I2C_SLAVE_READ_REQUESTED:
 		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_ACK))
@@ -319,8 +336,7 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		i2c_slave_event(slave, I2C_SLAVE_WRITE_RECEIVED, &value);
 		break;
 	case ASPEED_I2C_SLAVE_STOP:
-		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
-		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
+		/* Stop event handling is done early. Unreachable. */
 		break;
 	case ASPEED_I2C_SLAVE_START:
 		/* Slave was just started. Waiting for the next event. */;
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 855cc2d64ac8..084a18724f82 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -632,8 +632,10 @@ static int tiadc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	err = tiadc_request_dma(pdev, adc_dev);
-	if (err && err == -EPROBE_DEFER)
+	if (err && err != -ENODEV) {
+		dev_err_probe(&pdev->dev, err, "DMA request failed\n");
 		goto err_dma;
+	}
 
 	return 0;
 
diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index f77c4538141e..6dac1e83de9c 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -44,6 +44,16 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer;
 	int ret;
 
+	/*
+	 * iio_triggered_buffer_cleanup() assumes that the buffer allocated here
+	 * is assigned to indio_dev->buffer but this is only the case if this
+	 * function is the first caller to iio_device_attach_buffer(). If
+	 * indio_dev->buffer is already set then we can't proceed otherwise the
+	 * cleanup function will try to free a buffer that was not allocated here.
+	 */
+	if (indio_dev->buffer)
+		return -EADDRINUSE;
+
 	buffer = iio_kfifo_allocate();
 	if (!buffer) {
 		ret = -ENOMEM;
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 16ea697e945c..79809646708a 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -15,8 +15,8 @@
 /* Conversion times in us */
 static const u16 ms_sensors_ht_t_conversion_time[] = { 50000, 25000,
 						       13000, 7000 };
-static const u16 ms_sensors_ht_h_conversion_time[] = { 16000, 3000,
-						       5000, 8000 };
+static const u16 ms_sensors_ht_h_conversion_time[] = { 16000, 5000,
+						       3000, 8000 };
 static const u16 ms_sensors_tp_conversion_time[] = { 500, 1100, 2100,
 						     4100, 8220, 16440 };
 
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 9d28534db3b0..a3b9745dd176 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1273,50 +1273,6 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
 	return 0;
 }
 
-static const struct of_device_id adis16475_of_match[] = {
-	{ .compatible = "adi,adis16470",
-		.data = &adis16475_chip_info[ADIS16470] },
-	{ .compatible = "adi,adis16475-1",
-		.data = &adis16475_chip_info[ADIS16475_1] },
-	{ .compatible = "adi,adis16475-2",
-		.data = &adis16475_chip_info[ADIS16475_2] },
-	{ .compatible = "adi,adis16475-3",
-		.data = &adis16475_chip_info[ADIS16475_3] },
-	{ .compatible = "adi,adis16477-1",
-		.data = &adis16475_chip_info[ADIS16477_1] },
-	{ .compatible = "adi,adis16477-2",
-		.data = &adis16475_chip_info[ADIS16477_2] },
-	{ .compatible = "adi,adis16477-3",
-		.data = &adis16475_chip_info[ADIS16477_3] },
-	{ .compatible = "adi,adis16465-1",
-		.data = &adis16475_chip_info[ADIS16465_1] },
-	{ .compatible = "adi,adis16465-2",
-		.data = &adis16475_chip_info[ADIS16465_2] },
-	{ .compatible = "adi,adis16465-3",
-		.data = &adis16475_chip_info[ADIS16465_3] },
-	{ .compatible = "adi,adis16467-1",
-		.data = &adis16475_chip_info[ADIS16467_1] },
-	{ .compatible = "adi,adis16467-2",
-		.data = &adis16475_chip_info[ADIS16467_2] },
-	{ .compatible = "adi,adis16467-3",
-		.data = &adis16475_chip_info[ADIS16467_3] },
-	{ .compatible = "adi,adis16500",
-		.data = &adis16475_chip_info[ADIS16500] },
-	{ .compatible = "adi,adis16505-1",
-		.data = &adis16475_chip_info[ADIS16505_1] },
-	{ .compatible = "adi,adis16505-2",
-		.data = &adis16475_chip_info[ADIS16505_2] },
-	{ .compatible = "adi,adis16505-3",
-		.data = &adis16475_chip_info[ADIS16505_3] },
-	{ .compatible = "adi,adis16507-1",
-		.data = &adis16475_chip_info[ADIS16507_1] },
-	{ .compatible = "adi,adis16507-2",
-		.data = &adis16475_chip_info[ADIS16507_2] },
-	{ .compatible = "adi,adis16507-3",
-		.data = &adis16475_chip_info[ADIS16507_3] },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, adis16475_of_match);
 
 static int adis16475_probe(struct spi_device *spi)
 {
@@ -1330,7 +1286,7 @@ static int adis16475_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->info = device_get_match_data(&spi->dev);
+	st->info = spi_get_device_match_data(spi);
 	if (!st->info)
 		return -EINVAL;
 
@@ -1370,12 +1326,83 @@ static int adis16475_probe(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id adis16475_of_match[] = {
+	{ .compatible = "adi,adis16470",
+		.data = &adis16475_chip_info[ADIS16470] },
+	{ .compatible = "adi,adis16475-1",
+		.data = &adis16475_chip_info[ADIS16475_1] },
+	{ .compatible = "adi,adis16475-2",
+		.data = &adis16475_chip_info[ADIS16475_2] },
+	{ .compatible = "adi,adis16475-3",
+		.data = &adis16475_chip_info[ADIS16475_3] },
+	{ .compatible = "adi,adis16477-1",
+		.data = &adis16475_chip_info[ADIS16477_1] },
+	{ .compatible = "adi,adis16477-2",
+		.data = &adis16475_chip_info[ADIS16477_2] },
+	{ .compatible = "adi,adis16477-3",
+		.data = &adis16475_chip_info[ADIS16477_3] },
+	{ .compatible = "adi,adis16465-1",
+		.data = &adis16475_chip_info[ADIS16465_1] },
+	{ .compatible = "adi,adis16465-2",
+		.data = &adis16475_chip_info[ADIS16465_2] },
+	{ .compatible = "adi,adis16465-3",
+		.data = &adis16475_chip_info[ADIS16465_3] },
+	{ .compatible = "adi,adis16467-1",
+		.data = &adis16475_chip_info[ADIS16467_1] },
+	{ .compatible = "adi,adis16467-2",
+		.data = &adis16475_chip_info[ADIS16467_2] },
+	{ .compatible = "adi,adis16467-3",
+		.data = &adis16475_chip_info[ADIS16467_3] },
+	{ .compatible = "adi,adis16500",
+		.data = &adis16475_chip_info[ADIS16500] },
+	{ .compatible = "adi,adis16505-1",
+		.data = &adis16475_chip_info[ADIS16505_1] },
+	{ .compatible = "adi,adis16505-2",
+		.data = &adis16475_chip_info[ADIS16505_2] },
+	{ .compatible = "adi,adis16505-3",
+		.data = &adis16475_chip_info[ADIS16505_3] },
+	{ .compatible = "adi,adis16507-1",
+		.data = &adis16475_chip_info[ADIS16507_1] },
+	{ .compatible = "adi,adis16507-2",
+		.data = &adis16475_chip_info[ADIS16507_2] },
+	{ .compatible = "adi,adis16507-3",
+		.data = &adis16475_chip_info[ADIS16507_3] },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adis16475_of_match);
+
+static const struct spi_device_id adis16475_ids[] = {
+	{ "adis16470", (kernel_ulong_t)&adis16475_chip_info[ADIS16470] },
+	{ "adis16475-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_1] },
+	{ "adis16475-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_2] },
+	{ "adis16475-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_3] },
+	{ "adis16477-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_1] },
+	{ "adis16477-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_2] },
+	{ "adis16477-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_3] },
+	{ "adis16465-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_1] },
+	{ "adis16465-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_2] },
+	{ "adis16465-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_3] },
+	{ "adis16467-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_1] },
+	{ "adis16467-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_2] },
+	{ "adis16467-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_3] },
+	{ "adis16500", (kernel_ulong_t)&adis16475_chip_info[ADIS16500] },
+	{ "adis16505-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_1] },
+	{ "adis16505-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_2] },
+	{ "adis16505-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_3] },
+	{ "adis16507-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_1] },
+	{ "adis16507-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_2] },
+	{ "adis16507-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_3] },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adis16475_ids);
+
 static struct spi_driver adis16475_driver = {
 	.driver = {
 		.name = "adis16475",
 		.of_match_table = adis16475_of_match,
 	},
 	.probe = adis16475_probe,
+	.id_table = adis16475_ids,
 };
 module_spi_driver(adis16475_driver);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 597768c29a72..caeef03b8c62 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -727,13 +727,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			return ret;
 		case IIO_ACCEL:
 			mutex_lock(&st->lock);
 			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			return ret;
 
 		default:
 			return -EINVAL;
diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index 13a66a8e3411..e0c51189e329 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -105,6 +105,9 @@ static int micro_key_probe(struct platform_device *pdev)
 	keys->codes = devm_kmemdup(&pdev->dev, micro_keycodes,
 			   keys->input->keycodesize * keys->input->keycodemax,
 			   GFP_KERNEL);
+	if (!keys->codes)
+		return -ENOMEM;
+
 	keys->input->keycode = keys->codes;
 
 	__set_bit(EV_KEY, keys->input->evbit);
diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 67a134c8448d..b9ef03af5263 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -299,6 +299,11 @@ static int soc_button_parse_btn_desc(struct device *dev,
 		info->name = "power";
 		info->event_code = KEY_POWER;
 		info->wakeup = true;
+	} else if (upage == 0x01 && usage == 0xc6) {
+		info->name = "airplane mode switch";
+		info->event_type = EV_SW;
+		info->event_code = SW_RFKILL_ALL;
+		info->active_low = false;
 	} else if (upage == 0x01 && usage == 0xca) {
 		info->name = "rotation lock switch";
 		info->event_type = EV_SW;
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index b7c41bd7409c..aadb2b97498a 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -382,6 +382,9 @@ struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 	}
 	mutex_unlock(&icc_lock);
 
+	if (!node)
+		return ERR_PTR(-EINVAL);
+
 	if (IS_ERR(node))
 		return ERR_CAST(node);
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 455788b6e5a1..df743650d8a9 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1762,11 +1762,12 @@ static void integrity_metadata(struct work_struct *w)
 		sectors_to_process = dio->range.n_sectors;
 
 		__bio_for_each_segment(bv, bio, iter, dio->bio_details.bi_iter) {
+			struct bio_vec bv_copy = bv;
 			unsigned pos;
 			char *mem, *checksums_ptr;
 
 again:
-			mem = (char *)kmap_atomic(bv.bv_page) + bv.bv_offset;
+			mem = (char *)kmap_atomic(bv_copy.bv_page) + bv_copy.bv_offset;
 			pos = 0;
 			checksums_ptr = checksums;
 			do {
@@ -1775,7 +1776,7 @@ static void integrity_metadata(struct work_struct *w)
 				sectors_to_process -= ic->sectors_per_block;
 				pos += ic->sectors_per_block << SECTOR_SHIFT;
 				sector += ic->sectors_per_block;
-			} while (pos < bv.bv_len && sectors_to_process && checksums != checksums_onstack);
+			} while (pos < bv_copy.bv_len && sectors_to_process && checksums != checksums_onstack);
 			kunmap_atomic(mem);
 
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
@@ -1796,9 +1797,9 @@ static void integrity_metadata(struct work_struct *w)
 			if (!sectors_to_process)
 				break;
 
-			if (unlikely(pos < bv.bv_len)) {
-				bv.bv_offset += pos;
-				bv.bv_len -= pos;
+			if (unlikely(pos < bv_copy.bv_len)) {
+				bv_copy.bv_offset += pos;
+				bv_copy.bv_len -= pos;
 				goto again;
 			}
 		}
diff --git a/drivers/net/ethernet/actions/owl-emac.c b/drivers/net/ethernet/actions/owl-emac.c
index c4ecf4fcadf8..add3480c6c56 100644
--- a/drivers/net/ethernet/actions/owl-emac.c
+++ b/drivers/net/ethernet/actions/owl-emac.c
@@ -342,7 +342,7 @@ static u32 owl_emac_dma_cmd_stop(struct owl_emac_priv *priv)
 static void owl_emac_set_hw_mac_addr(struct net_device *netdev)
 {
 	struct owl_emac_priv *priv = netdev_priv(netdev);
-	u8 *mac_addr = netdev->dev_addr;
+	const u8 *mac_addr = netdev->dev_addr;
 	u32 addr_high, addr_low;
 
 	addr_high = mac_addr[0] << 8 | mac_addr[1];
diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index e0f6cc910bd2..16b6b83f670b 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -955,7 +955,7 @@ static int netdev_open(struct net_device *dev)
 	writew(0, ioaddr + PerfFilterTable + 4);
 	writew(0, ioaddr + PerfFilterTable + 8);
 	for (i = 1; i < 16; i++) {
-		__be16 *eaddrs = (__be16 *)dev->dev_addr;
+		const __be16 *eaddrs = (const __be16 *)dev->dev_addr;
 		void __iomem *setup_frm = ioaddr + PerfFilterTable + i * 16;
 		writew(be16_to_cpu(eaddrs[2]), setup_frm); setup_frm += 4;
 		writew(be16_to_cpu(eaddrs[1]), setup_frm); setup_frm += 4;
@@ -1787,14 +1787,14 @@ static void set_rx_mode(struct net_device *dev)
 	} else if (netdev_mc_count(dev) <= 14) {
 		/* Use the 16 element perfect filter, skip first two entries. */
 		void __iomem *filter_addr = ioaddr + PerfFilterTable + 2 * 16;
-		__be16 *eaddrs;
+		const __be16 *eaddrs;
 		netdev_for_each_mc_addr(ha, dev) {
 			eaddrs = (__be16 *) ha->addr;
 			writew(be16_to_cpu(eaddrs[2]), filter_addr); filter_addr += 4;
 			writew(be16_to_cpu(eaddrs[1]), filter_addr); filter_addr += 4;
 			writew(be16_to_cpu(eaddrs[0]), filter_addr); filter_addr += 8;
 		}
-		eaddrs = (__be16 *)dev->dev_addr;
+		eaddrs = (const __be16 *)dev->dev_addr;
 		i = netdev_mc_count(dev) + 2;
 		while (i++ < 16) {
 			writew(be16_to_cpu(eaddrs[0]), filter_addr); filter_addr += 4;
@@ -1805,7 +1805,7 @@ static void set_rx_mode(struct net_device *dev)
 	} else {
 		/* Must use a multicast hash table. */
 		void __iomem *filter_addr;
-		__be16 *eaddrs;
+		const __be16 *eaddrs;
 		__le16 mc_filter[32] __attribute__ ((aligned(sizeof(long))));	/* Multicast hash filter */
 
 		memset(mc_filter, 0, sizeof(mc_filter));
@@ -1819,7 +1819,7 @@ static void set_rx_mode(struct net_device *dev)
 		}
 		/* Clear the perfect filter list, skip first two entries. */
 		filter_addr = ioaddr + PerfFilterTable + 2 * 16;
-		eaddrs = (__be16 *)dev->dev_addr;
+		eaddrs = (const __be16 *)dev->dev_addr;
 		for (i = 2; i < 16; i++) {
 			writew(be16_to_cpu(eaddrs[0]), filter_addr); filter_addr += 4;
 			writew(be16_to_cpu(eaddrs[1]), filter_addr); filter_addr += 4;
diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index 82f4f2608102..1fc9a1cd3ef8 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -1008,7 +1008,7 @@ static void slic_set_link_autoneg(struct slic_device *sdev)
 
 static void slic_set_mac_address(struct slic_device *sdev)
 {
-	u8 *addr = sdev->netdev->dev_addr;
+	const u8 *addr = sdev->netdev->dev_addr;
 	u32 val;
 
 	val = addr[5] | addr[4] << 8 | addr[3] << 16 | addr[2] << 24;
diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index 9dc12b13061f..afa383355265 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -2712,7 +2712,7 @@ static int ace_set_mac_addr(struct net_device *dev, void *p)
 	struct ace_private *ap = netdev_priv(dev);
 	struct ace_regs __iomem *regs = ap->regs;
 	struct sockaddr *addr=p;
-	u8 *da;
+	const u8 *da;
 	struct cmd cmd;
 
 	if(netif_running(dev))
@@ -2720,7 +2720,7 @@ static int ace_set_mac_addr(struct net_device *dev, void *p)
 
 	memcpy(dev->dev_addr, addr->sa_data,dev->addr_len);
 
-	da = (u8 *)dev->dev_addr;
+	da = (const u8 *)dev->dev_addr;
 
 	writel(da[0] << 8 | da[1], &regs->MacAddrHi);
 	writel((da[2] << 24) | (da[3] << 16) | (da[4] << 8) | da[5],
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 9e721436f06f..36bf3ce545c9 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -853,7 +853,7 @@ static int init_phy(struct net_device *dev)
 	return 0;
 }
 
-static void tse_update_mac_addr(struct altera_tse_private *priv, u8 *addr)
+static void tse_update_mac_addr(struct altera_tse_private *priv, const u8 *addr)
 {
 	u32 msb;
 	u32 lsb;
diff --git a/drivers/net/ethernet/amd/nmclan_cs.c b/drivers/net/ethernet/amd/nmclan_cs.c
index 8bd063e54ac3..0f961d7e7196 100644
--- a/drivers/net/ethernet/amd/nmclan_cs.c
+++ b/drivers/net/ethernet/amd/nmclan_cs.c
@@ -529,7 +529,8 @@ static void mace_write(mace_private *lp, unsigned int ioaddr, int reg,
 mace_init
 	Resets the MACE chip.
 ---------------------------------------------------------------------------- */
-static int mace_init(mace_private *lp, unsigned int ioaddr, char *enet_addr)
+static int mace_init(mace_private *lp, unsigned int ioaddr,
+		     const char *enet_addr)
 {
   int i;
   int ct = 0;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index decc1c09a031..4030d619e84f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1087,7 +1087,7 @@ static int xgbe_add_mac_addresses(struct xgbe_prv_data *pdata)
 	return 0;
 }
 
-static int xgbe_set_mac_address(struct xgbe_prv_data *pdata, u8 *addr)
+static int xgbe_set_mac_address(struct xgbe_prv_data *pdata, const u8 *addr)
 {
 	unsigned int mac_addr_hi, mac_addr_lo;
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index e0b8f3c4cc0b..497c4ec6089a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -730,7 +730,7 @@ struct xgbe_ext_stats {
 struct xgbe_hw_if {
 	int (*tx_complete)(struct xgbe_ring_desc *);
 
-	int (*set_mac_address)(struct xgbe_prv_data *, u8 *addr);
+	int (*set_mac_address)(struct xgbe_prv_data *, const u8 *addr);
 	int (*config_rx_mode)(struct xgbe_prv_data *);
 
 	int (*enable_rx_csum)(struct xgbe_prv_data *);
diff --git a/drivers/net/ethernet/apm/xgene-v2/mac.c b/drivers/net/ethernet/apm/xgene-v2/mac.c
index 2da979e4fad1..6423e22e05b2 100644
--- a/drivers/net/ethernet/apm/xgene-v2/mac.c
+++ b/drivers/net/ethernet/apm/xgene-v2/mac.c
@@ -65,7 +65,7 @@ void xge_mac_set_speed(struct xge_pdata *pdata)
 
 void xge_mac_set_station_addr(struct xge_pdata *pdata)
 {
-	u8 *dev_addr = pdata->ndev->dev_addr;
+	const u8 *dev_addr = pdata->ndev->dev_addr;
 	u32 addr0, addr1;
 
 	addr0 = (dev_addr[3] << 24) | (dev_addr[2] << 16) |
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
index 5f657879134e..e641dbbea1e2 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
@@ -378,8 +378,8 @@ u32 xgene_enet_rd_stat(struct xgene_enet_pdata *pdata, u32 rd_addr)
 
 static void xgene_gmac_set_mac_addr(struct xgene_enet_pdata *pdata)
 {
+	const u8 *dev_addr = pdata->ndev->dev_addr;
 	u32 addr0, addr1;
-	u8 *dev_addr = pdata->ndev->dev_addr;
 
 	addr0 = (dev_addr[3] << 24) | (dev_addr[2] << 16) |
 		(dev_addr[1] << 8) | dev_addr[0];
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c b/drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c
index f482ced2cadd..72b5e8eb0ec7 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c
@@ -165,8 +165,8 @@ static void xgene_sgmac_reset(struct xgene_enet_pdata *p)
 
 static void xgene_sgmac_set_mac_addr(struct xgene_enet_pdata *p)
 {
+	const u8 *dev_addr = p->ndev->dev_addr;
 	u32 addr0, addr1;
-	u8 *dev_addr = p->ndev->dev_addr;
 
 	addr0 = (dev_addr[3] << 24) | (dev_addr[2] << 16) |
 		(dev_addr[1] << 8) | dev_addr[0];
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c b/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c
index 304b5d43f236..86607b79c09f 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c
@@ -207,8 +207,8 @@ static void xgene_pcs_reset(struct xgene_enet_pdata *pdata)
 
 static void xgene_xgmac_set_mac_addr(struct xgene_enet_pdata *pdata)
 {
+	const u8 *dev_addr = pdata->ndev->dev_addr;
 	u32 addr0, addr1;
-	u8 *dev_addr = pdata->ndev->dev_addr;
 
 	addr0 = (dev_addr[3] << 24) | (dev_addr[2] << 16) |
 		(dev_addr[1] << 8) | dev_addr[0];
diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index 7a966361d83f..4c513f7a36a8 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -308,7 +308,7 @@ bmac_init_registers(struct net_device *dev)
 {
 	struct bmac_data *bp = netdev_priv(dev);
 	volatile unsigned short regValue;
-	unsigned short *pWord16;
+	const unsigned short *pWord16;
 	int i;
 
 	/* XXDEBUG(("bmac: enter init_registers\n")); */
@@ -371,7 +371,7 @@ bmac_init_registers(struct net_device *dev)
 	bmwrite(dev, BHASH1, bp->hash_table_mask[2]); 	/* bits 47 - 32 */
 	bmwrite(dev, BHASH0, bp->hash_table_mask[3]); 	/* bits 63 - 48 */
 
-	pWord16 = (unsigned short *)dev->dev_addr;
+	pWord16 = (const unsigned short *)dev->dev_addr;
 	bmwrite(dev, MADD0, *pWord16++);
 	bmwrite(dev, MADD1, *pWord16++);
 	bmwrite(dev, MADD2, *pWord16);
@@ -522,7 +522,7 @@ static int bmac_set_address(struct net_device *dev, void *addr)
 {
 	struct bmac_data *bp = netdev_priv(dev);
 	unsigned char *p = addr;
-	unsigned short *pWord16;
+	const unsigned short *pWord16;
 	unsigned long flags;
 	int i;
 
@@ -533,7 +533,7 @@ static int bmac_set_address(struct net_device *dev, void *addr)
 		dev->dev_addr[i] = p[i];
 	}
 	/* load up the hardware address */
-	pWord16  = (unsigned short *)dev->dev_addr;
+	pWord16  = (const unsigned short *)dev->dev_addr;
 	bmwrite(dev, MADD0, *pWord16++);
 	bmwrite(dev, MADD1, *pWord16++);
 	bmwrite(dev, MADD2, *pWord16);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index 7442850ca95f..dbd284660135 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -219,7 +219,7 @@ struct aq_hw_ops {
 	int (*hw_ring_tx_head_update)(struct aq_hw_s *self,
 				      struct aq_ring_s *aq_ring);
 
-	int (*hw_set_mac_address)(struct aq_hw_s *self, u8 *mac_addr);
+	int (*hw_set_mac_address)(struct aq_hw_s *self, const u8 *mac_addr);
 
 	int (*hw_soft_reset)(struct aq_hw_s *self);
 
@@ -228,7 +228,7 @@ struct aq_hw_ops {
 
 	int (*hw_reset)(struct aq_hw_s *self);
 
-	int (*hw_init)(struct aq_hw_s *self, u8 *mac_addr);
+	int (*hw_init)(struct aq_hw_s *self, const u8 *mac_addr);
 
 	int (*hw_start)(struct aq_hw_s *self);
 
@@ -375,7 +375,7 @@ struct aq_fw_ops {
 	int (*set_phyloopback)(struct aq_hw_s *self, u32 mode, bool enable);
 
 	int (*set_power)(struct aq_hw_s *self, unsigned int power_state,
-			 u8 *mac);
+			 const u8 *mac);
 
 	int (*send_fw_request)(struct aq_hw_s *self,
 			       const struct hw_fw_request_iface *fw_req,
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
index ee823a18294c..958b7f8c77d9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
@@ -35,7 +35,7 @@ static int aq_apply_macsec_cfg(struct aq_nic_s *nic);
 static int aq_apply_secy_cfg(struct aq_nic_s *nic,
 			     const struct macsec_secy *secy);
 
-static void aq_ether_addr_to_mac(u32 mac[2], unsigned char *emac)
+static void aq_ether_addr_to_mac(u32 mac[2], const unsigned char *emac)
 {
 	u32 tmp[2] = { 0 };
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
index 611875ef2cd1..4625ccb79499 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
@@ -322,7 +322,7 @@ static int hw_atl_a0_hw_init_rx_path(struct aq_hw_s *self)
 	return aq_hw_err_from_flags(self);
 }
 
-static int hw_atl_a0_hw_mac_addr_set(struct aq_hw_s *self, u8 *mac_addr)
+static int hw_atl_a0_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_addr)
 {
 	unsigned int h = 0U;
 	unsigned int l = 0U;
@@ -348,7 +348,7 @@ static int hw_atl_a0_hw_mac_addr_set(struct aq_hw_s *self, u8 *mac_addr)
 	return err;
 }
 
-static int hw_atl_a0_hw_init(struct aq_hw_s *self, u8 *mac_addr)
+static int hw_atl_a0_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 {
 	static u32 aq_hw_atl_igcr_table_[4][2] = {
 		[AQ_HW_IRQ_INVALID] = { 0x20000000U, 0x20000000U },
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 45c17c585d74..15ede7285fb5 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -533,7 +533,7 @@ static int hw_atl_b0_hw_init_rx_path(struct aq_hw_s *self)
 	return aq_hw_err_from_flags(self);
 }
 
-int hw_atl_b0_hw_mac_addr_set(struct aq_hw_s *self, u8 *mac_addr)
+int hw_atl_b0_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_addr)
 {
 	unsigned int h = 0U;
 	unsigned int l = 0U;
@@ -558,7 +558,7 @@ int hw_atl_b0_hw_mac_addr_set(struct aq_hw_s *self, u8 *mac_addr)
 	return err;
 }
 
-static int hw_atl_b0_hw_init(struct aq_hw_s *self, u8 *mac_addr)
+static int hw_atl_b0_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 {
 	static u32 aq_hw_atl_igcr_table_[4][2] = {
 		[AQ_HW_IRQ_INVALID] = { 0x20000000U, 0x20000000U },
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h
index d8db972113ec..5298846dd9f7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h
@@ -58,7 +58,7 @@ int hw_atl_b0_hw_ring_rx_stop(struct aq_hw_s *self, struct aq_ring_s *ring);
 
 void hw_atl_b0_hw_init_rx_rss_ctrl1(struct aq_hw_s *self);
 
-int hw_atl_b0_hw_mac_addr_set(struct aq_hw_s *self, u8 *mac_addr);
+int hw_atl_b0_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_addr);
 
 int hw_atl_b0_set_fc(struct aq_hw_s *self, u32 fc, u32 tc);
 int hw_atl_b0_set_loopback(struct aq_hw_s *self, u32 mode, bool enable);
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
index 65b9e5846be4..7e88d7234b14 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -965,7 +965,7 @@ u32 hw_atl_utils_get_fw_version(struct aq_hw_s *self)
 }
 
 static int aq_fw1x_set_wake_magic(struct aq_hw_s *self, bool wol_enabled,
-				  u8 *mac)
+				  const u8 *mac)
 {
 	struct hw_atl_utils_fw_rpc *prpc = NULL;
 	unsigned int rpc_size = 0U;
@@ -1008,7 +1008,7 @@ static int aq_fw1x_set_wake_magic(struct aq_hw_s *self, bool wol_enabled,
 }
 
 static int aq_fw1x_set_power(struct aq_hw_s *self, unsigned int power_state,
-			     u8 *mac)
+			     const u8 *mac)
 {
 	struct hw_atl_utils_fw_rpc *prpc = NULL;
 	unsigned int rpc_size = 0U;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
index 05086f0040fd..4d4cfbc91e19 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -355,7 +355,7 @@ static int aq_fw2x_get_phy_temp(struct aq_hw_s *self, int *temp)
 	return 0;
 }
 
-static int aq_fw2x_set_wol(struct aq_hw_s *self, u8 *mac)
+static int aq_fw2x_set_wol(struct aq_hw_s *self, const u8 *mac)
 {
 	struct hw_atl_utils_fw_rpc *rpc = NULL;
 	struct offload_info *info = NULL;
@@ -401,7 +401,7 @@ static int aq_fw2x_set_wol(struct aq_hw_s *self, u8 *mac)
 }
 
 static int aq_fw2x_set_power(struct aq_hw_s *self, unsigned int power_state,
-			     u8 *mac)
+			     const u8 *mac)
 {
 	int err = 0;
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index c76ccdc77ba6..5dfc751572ed 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -530,7 +530,7 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
 	return aq_hw_err_from_flags(self);
 }
 
-static int hw_atl2_hw_init(struct aq_hw_s *self, u8 *mac_addr)
+static int hw_atl2_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 {
 	static u32 aq_hw_atl2_igcr_table_[4][2] = {
 		[AQ_HW_IRQ_INVALID] = { 0x20000000U, 0x20000000U },
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index db13311e77e7..dc1165f11b6e 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -866,10 +866,13 @@ static int atl1e_setup_ring_resources(struct atl1e_adapter *adapter)
 		netdev_err(adapter->netdev, "offset(%d) > ring size(%d) !!\n",
 			   offset, adapter->ring_size);
 		err = -1;
-		goto failed;
+		goto free_buffer;
 	}
 
 	return 0;
+free_buffer:
+	kfree(tx_ring->tx_buffer);
+	tx_ring->tx_buffer = NULL;
 failed:
 	if (adapter->ring_vir_addr != NULL) {
 		dma_free_coherent(&pdev->dev, adapter->ring_size,
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index fa784953c601..485d32dda56f 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -218,7 +218,8 @@ static inline void __b44_cam_read(struct b44 *bp, unsigned char *data, int index
 	data[1] = (val >> 0) & 0xFF;
 }
 
-static inline void __b44_cam_write(struct b44 *bp, unsigned char *data, int index)
+static inline void __b44_cam_write(struct b44 *bp,
+				   const unsigned char *data, int index)
 {
 	u32 val;
 
@@ -1507,7 +1508,8 @@ static void bwfilter_table(struct b44 *bp, u8 *pp, u32 bytes, u32 table_offset)
 	}
 }
 
-static int b44_magic_pattern(u8 *macaddr, u8 *ppattern, u8 *pmask, int offset)
+static int b44_magic_pattern(const u8 *macaddr, u8 *ppattern, u8 *pmask,
+			     int offset)
 {
 	int magicsync = 6;
 	int k, j, len = offset;
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 25466d73b432..93c965bcdb6c 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1820,7 +1820,7 @@ static inline void umac_reset(struct bcm_sysport_priv *priv)
 }
 
 static void umac_set_hw_addr(struct bcm_sysport_priv *priv,
-			     unsigned char *addr)
+			     const unsigned char *addr)
 {
 	u32 mac0 = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) |
 		    addr[3];
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index c691635cf4eb..3b42674b9df6 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -768,7 +768,7 @@ static void bgmac_umac_cmd_maskset(struct bgmac *bgmac, u32 mask, u32 set,
 	udelay(2);
 }
 
-static void bgmac_write_mac_address(struct bgmac *bgmac, u8 *addr)
+static void bgmac_write_mac_address(struct bgmac *bgmac, const u8 *addr)
 {
 	u32 tmp;
 
diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 9d70d908c064..cf4535f8b344 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -2704,7 +2704,7 @@ bnx2_alloc_bad_rbuf(struct bnx2 *bp)
 }
 
 static void
-bnx2_set_mac_addr(struct bnx2 *bp, u8 *mac_addr, u32 pos)
+bnx2_set_mac_addr(struct bnx2 *bp, const u8 *mac_addr, u32 pos)
 {
 	u32 val;
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index 9e79bcfb365f..2209d99b3404 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -2002,7 +2002,7 @@ int bnx2x_idle_chk(struct bnx2x *bp);
  * operation has been successfully scheduled and a negative - if a requested
  * operations has failed.
  */
-int bnx2x_set_mac_one(struct bnx2x *bp, u8 *mac,
+int bnx2x_set_mac_one(struct bnx2x *bp, const u8 *mac,
 		      struct bnx2x_vlan_mac_obj *obj, bool set,
 		      int mac_type, unsigned long *ramrod_flags);
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 9c26c46771f5..ed20a5945885 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -8428,7 +8428,7 @@ int bnx2x_alloc_mem(struct bnx2x *bp)
  * Init service functions
  */
 
-int bnx2x_set_mac_one(struct bnx2x *bp, u8 *mac,
+int bnx2x_set_mac_one(struct bnx2x *bp, const u8 *mac,
 		      struct bnx2x_vlan_mac_obj *obj, bool set,
 		      int mac_type, unsigned long *ramrod_flags)
 {
@@ -9157,7 +9157,7 @@ u32 bnx2x_send_unload_req(struct bnx2x *bp, int unload_mode)
 
 	else if (bp->wol) {
 		u32 emac_base = port ? GRCBASE_EMAC1 : GRCBASE_EMAC0;
-		u8 *mac_addr = bp->dev->dev_addr;
+		const u8 *mac_addr = bp->dev->dev_addr;
 		struct pci_dev *pdev = bp->pdev;
 		u32 val;
 		u16 pmc;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
index 966d5722c5e2..8c2cf5519787 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
@@ -508,7 +508,8 @@ int bnx2x_vfpf_init(struct bnx2x *bp);
 void bnx2x_vfpf_close_vf(struct bnx2x *bp);
 int bnx2x_vfpf_setup_q(struct bnx2x *bp, struct bnx2x_fastpath *fp,
 		       bool is_leading);
-int bnx2x_vfpf_config_mac(struct bnx2x *bp, u8 *addr, u8 vf_qid, bool set);
+int bnx2x_vfpf_config_mac(struct bnx2x *bp, const u8 *addr, u8 vf_qid,
+			  bool set);
 int bnx2x_vfpf_config_rss(struct bnx2x *bp,
 			  struct bnx2x_config_rss_params *params);
 int bnx2x_vfpf_set_mcast(struct net_device *dev);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index ea0e9394f898..05d861679a02 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -722,7 +722,7 @@ static int bnx2x_vfpf_teardown_queue(struct bnx2x *bp, int qidx)
 }
 
 /* request pf to add a mac for the vf */
-int bnx2x_vfpf_config_mac(struct bnx2x *bp, u8 *addr, u8 vf_qid, bool set)
+int bnx2x_vfpf_config_mac(struct bnx2x *bp, const u8 *addr, u8 vf_qid, bool set)
 {
 	struct vfpf_set_q_filters_tlv *req = &bp->vf2pf_mbox->req.set_q_filters;
 	struct pfvf_general_resp_tlv *resp = &bp->vf2pf_mbox->resp.general_resp;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4cb22e406052..42fa21829529 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4882,7 +4882,7 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 #endif
 
 static int bnxt_hwrm_set_vnic_filter(struct bnxt *bp, u16 vnic_id, u16 idx,
-				     u8 *mac_addr)
+				     const u8 *mac_addr)
 {
 	struct hwrm_cfa_l2_filter_alloc_output *resp;
 	struct hwrm_cfa_l2_filter_alloc_input *req;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 78763f5027d1..7de7101d5389 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -1151,7 +1151,7 @@ void bnxt_hwrm_exec_fwd_req(struct bnxt *bp)
 	}
 }
 
-int bnxt_approve_mac(struct bnxt *bp, u8 *mac, bool strict)
+int bnxt_approve_mac(struct bnxt *bp, const u8 *mac, bool strict)
 {
 	struct hwrm_func_vf_cfg_input *req;
 	int rc = 0;
@@ -1246,7 +1246,7 @@ void bnxt_update_vf_mac(struct bnxt *bp)
 {
 }
 
-int bnxt_approve_mac(struct bnxt *bp, u8 *mac, bool strict)
+int bnxt_approve_mac(struct bnxt *bp, const u8 *mac, bool strict)
 {
 	return 0;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h
index 995535e4c11b..9a4bacba477b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h
@@ -41,5 +41,5 @@ int bnxt_cfg_hw_sriov(struct bnxt *bp, int *num_vfs, bool reset);
 void bnxt_sriov_disable(struct bnxt *);
 void bnxt_hwrm_exec_fwd_req(struct bnxt *);
 void bnxt_update_vf_mac(struct bnxt *);
-int bnxt_approve_mac(struct bnxt *, u8 *, bool);
+int bnxt_approve_mac(struct bnxt *, const u8 *, bool);
 #endif
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e036a244b78b..f6a553e5df25 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3239,7 +3239,7 @@ static void bcmgenet_umac_reset(struct bcmgenet_priv *priv)
 }
 
 static void bcmgenet_set_hw_addr(struct bcmgenet_priv *priv,
-				 unsigned char *addr)
+				 const unsigned char *addr)
 {
 	bcmgenet_umac_writel(priv, get_unaligned_be32(&addr[0]), UMAC_MAC0);
 	bcmgenet_umac_writel(priv, get_unaligned_be16(&addr[4]), UMAC_MAC1);
@@ -3537,7 +3537,7 @@ static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
 #define MAX_MDF_FILTER	17
 
 static inline void bcmgenet_set_mdf_addr(struct bcmgenet_priv *priv,
-					 unsigned char *addr,
+					 const unsigned char *addr,
 					 int *i)
 {
 	bcmgenet_umac_writel(priv, addr[0] << 8 | addr[1],
diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index b6a066404f4b..9695c261d18f 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -607,7 +607,7 @@ static inline void xgmac_mac_disable(void __iomem *ioaddr)
 	writel(value, ioaddr + XGMAC_CONTROL);
 }
 
-static void xgmac_set_mac_addr(void __iomem *ioaddr, unsigned char *addr,
+static void xgmac_set_mac_addr(void __iomem *ioaddr, const unsigned char *addr,
 			       int num)
 {
 	u32 data;
diff --git a/drivers/net/ethernet/chelsio/cxgb/gmac.h b/drivers/net/ethernet/chelsio/cxgb/gmac.h
index dfa77491a910..5913eaf442b5 100644
--- a/drivers/net/ethernet/chelsio/cxgb/gmac.h
+++ b/drivers/net/ethernet/chelsio/cxgb/gmac.h
@@ -117,7 +117,7 @@ struct cmac_ops {
 	const struct cmac_statistics *(*statistics_update)(struct cmac *, int);
 
 	int (*macaddress_get)(struct cmac *, u8 mac_addr[6]);
-	int (*macaddress_set)(struct cmac *, u8 mac_addr[6]);
+	int (*macaddress_set)(struct cmac *, const u8 mac_addr[6]);
 };
 
 typedef struct _cmac_instance cmac_instance;
diff --git a/drivers/net/ethernet/chelsio/cxgb/pm3393.c b/drivers/net/ethernet/chelsio/cxgb/pm3393.c
index c27908e66f5e..0bb37e4680c7 100644
--- a/drivers/net/ethernet/chelsio/cxgb/pm3393.c
+++ b/drivers/net/ethernet/chelsio/cxgb/pm3393.c
@@ -496,7 +496,7 @@ static int pm3393_macaddress_get(struct cmac *cmac, u8 mac_addr[6])
 	return 0;
 }
 
-static int pm3393_macaddress_set(struct cmac *cmac, u8 ma[6])
+static int pm3393_macaddress_set(struct cmac *cmac, const u8 ma[6])
 {
 	u32 val, lo, mid, hi, enabled = cmac->instance->enabled;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb/vsc7326.c b/drivers/net/ethernet/chelsio/cxgb/vsc7326.c
index 873c1c7b4ca0..81317a9baf1a 100644
--- a/drivers/net/ethernet/chelsio/cxgb/vsc7326.c
+++ b/drivers/net/ethernet/chelsio/cxgb/vsc7326.c
@@ -379,7 +379,7 @@ static int mac_intr_clear(struct cmac *mac)
 }
 
 /* Expect MAC address to be in network byte order. */
-static int mac_set_address(struct cmac* mac, u8 addr[6])
+static int mac_set_address(struct cmac* mac, const u8 addr[6])
 {
 	u32 val;
 	int port = mac->instance->index;
diff --git a/drivers/net/ethernet/chelsio/cxgb3/common.h b/drivers/net/ethernet/chelsio/cxgb3/common.h
index b706f2fbe4f4..a309016f7f8c 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/common.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/common.h
@@ -710,7 +710,7 @@ int t3_mac_enable(struct cmac *mac, int which);
 int t3_mac_disable(struct cmac *mac, int which);
 int t3_mac_set_mtu(struct cmac *mac, unsigned int mtu);
 int t3_mac_set_rx_mode(struct cmac *mac, struct net_device *dev);
-int t3_mac_set_address(struct cmac *mac, unsigned int idx, u8 addr[6]);
+int t3_mac_set_address(struct cmac *mac, unsigned int idx, const u8 addr[6]);
 int t3_mac_set_num_ucast(struct cmac *mac, int n);
 const struct mac_stats *t3_mac_update_stats(struct cmac *mac);
 int t3_mac_set_speed_duplex_fc(struct cmac *mac, int speed, int duplex, int fc);
diff --git a/drivers/net/ethernet/chelsio/cxgb3/xgmac.c b/drivers/net/ethernet/chelsio/cxgb3/xgmac.c
index 3af19a550372..1bdc6cad1e49 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/xgmac.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/xgmac.c
@@ -240,7 +240,7 @@ static void set_addr_filter(struct cmac *mac, int idx, const u8 * addr)
 }
 
 /* Set one of the station's unicast MAC addresses. */
-int t3_mac_set_address(struct cmac *mac, unsigned int idx, u8 addr[6])
+int t3_mac_set_address(struct cmac *mac, unsigned int idx, const u8 addr[6])
 {
 	if (idx >= mac->nucast)
 		return -EINVAL;
diff --git a/drivers/net/ethernet/cisco/enic/enic_pp.c b/drivers/net/ethernet/cisco/enic/enic_pp.c
index e6a83198c3dd..80f46dbd5117 100644
--- a/drivers/net/ethernet/cisco/enic/enic_pp.c
+++ b/drivers/net/ethernet/cisco/enic/enic_pp.c
@@ -73,9 +73,9 @@ static int enic_set_port_profile(struct enic *enic, int vf)
 	struct vic_provinfo *vp;
 	const u8 oui[3] = VIC_PROVINFO_CISCO_OUI;
 	const __be16 os_type = htons(VIC_GENERIC_PROV_OS_TYPE_LINUX);
+	const u8 *client_mac;
 	char uuid_str[38];
 	char client_mac_str[18];
-	u8 *client_mac;
 	int err;
 
 	ENIC_PP_BY_INDEX(enic, vf, pp, &err);
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 202ecb132053..993bba0ffb16 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -567,7 +567,7 @@ static void rio_hw_init(struct net_device *dev)
 	 */
 	for (i = 0; i < 3; i++)
 		dw16(StationAddr0 + 2 * i,
-		     cpu_to_le16(((u16 *)dev->dev_addr)[i]));
+		     cpu_to_le16(((const u16 *)dev->dev_addr)[i]));
 
 	set_multicast (dev);
 	if (np->coalesce) {
diff --git a/drivers/net/ethernet/dnet.c b/drivers/net/ethernet/dnet.c
index 14dc2e13bf03..667ef2b18047 100644
--- a/drivers/net/ethernet/dnet.c
+++ b/drivers/net/ethernet/dnet.c
@@ -60,11 +60,11 @@ static void __dnet_set_hwaddr(struct dnet *bp)
 {
 	u16 tmp;
 
-	tmp = be16_to_cpup((__be16 *)bp->dev->dev_addr);
+	tmp = be16_to_cpup((const __be16 *)bp->dev->dev_addr);
 	dnet_writew_mac(bp, DNET_INTERNAL_MAC_ADDR_0_REG, tmp);
-	tmp = be16_to_cpup((__be16 *)(bp->dev->dev_addr + 2));
+	tmp = be16_to_cpup((const __be16 *)(bp->dev->dev_addr + 2));
 	dnet_writew_mac(bp, DNET_INTERNAL_MAC_ADDR_1_REG, tmp);
-	tmp = be16_to_cpup((__be16 *)(bp->dev->dev_addr + 4));
+	tmp = be16_to_cpup((const __be16 *)(bp->dev->dev_addr + 4));
 	dnet_writew_mac(bp, DNET_INTERNAL_MAC_ADDR_2_REG, tmp);
 }
 
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 1288b5e3d220..b4f5e57d0285 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -1080,7 +1080,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 }
 
 /* Uses synchronous MCCQ */
-int be_cmd_pmac_add(struct be_adapter *adapter, u8 *mac_addr,
+int be_cmd_pmac_add(struct be_adapter *adapter, const u8 *mac_addr,
 		    u32 if_id, u32 *pmac_id, u32 domain)
 {
 	struct be_mcc_wrb *wrb;
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.h b/drivers/net/ethernet/emulex/benet/be_cmds.h
index 9e17d6a7ab8c..e2085c68c0ee 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.h
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.h
@@ -2385,7 +2385,7 @@ int be_pci_fnum_get(struct be_adapter *adapter);
 int be_fw_wait_ready(struct be_adapter *adapter);
 int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 			  bool permanent, u32 if_handle, u32 pmac_id);
-int be_cmd_pmac_add(struct be_adapter *adapter, u8 *mac_addr, u32 if_id,
+int be_cmd_pmac_add(struct be_adapter *adapter, const u8 *mac_addr, u32 if_id,
 		    u32 *pmac_id, u32 domain);
 int be_cmd_pmac_del(struct be_adapter *adapter, u32 if_id, int pmac_id,
 		    u32 domain);
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index a61b368286e0..b91029db1f21 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -272,7 +272,7 @@ void be_cq_notify(struct be_adapter *adapter, u16 qid, bool arm, u16 num_popped)
 	iowrite32(val, adapter->db + DB_CQ_OFFSET);
 }
 
-static int be_dev_mac_add(struct be_adapter *adapter, u8 *mac)
+static int be_dev_mac_add(struct be_adapter *adapter, const u8 *mac)
 {
 	int i;
 
diff --git a/drivers/net/ethernet/ethoc.c b/drivers/net/ethernet/ethoc.c
index 7f456297fc45..b6c3c562107c 100644
--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -806,8 +806,8 @@ static int ethoc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 static void ethoc_do_set_mac_address(struct net_device *dev)
 {
+	const unsigned char *mac = dev->dev_addr;
 	struct ethoc *priv = netdev_priv(dev);
-	unsigned char *mac = dev->dev_addr;
 
 	ethoc_write(priv, MAC_ADDR0, (mac[2] << 24) | (mac[3] << 16) |
 				     (mac[4] <<  8) | (mac[5] <<  0));
diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index 819266d463b0..ab194c9b0691 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -827,7 +827,7 @@ static int netdev_open(struct net_device *dev)
 		return -EAGAIN;
 
 	for (i = 0; i < 3; i++)
-		iowrite16(((unsigned short*)dev->dev_addr)[i],
+		iowrite16(((const unsigned short *)dev->dev_addr)[i],
 				ioaddr + PAR0 + i*2);
 
 	init_ring(dev);
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index fe5fc2b3406f..1766b7d94ffa 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -272,7 +272,7 @@ static int dpaa_netdev_init(struct net_device *net_dev,
 	} else {
 		eth_hw_addr_random(net_dev);
 		err = priv->mac_dev->change_addr(priv->mac_dev->fman_mac,
-			(enet_addr_t *)net_dev->dev_addr);
+			(const enet_addr_t *)net_dev->dev_addr);
 		if (err) {
 			dev_err(dev, "Failed to set random MAC address\n");
 			return -EINVAL;
@@ -452,7 +452,7 @@ static int dpaa_set_mac_address(struct net_device *net_dev, void *addr)
 	mac_dev = priv->mac_dev;
 
 	err = mac_dev->change_addr(mac_dev->fman_mac,
-				   (enet_addr_t *)net_dev->dev_addr);
+				   (const enet_addr_t *)net_dev->dev_addr);
 	if (err < 0) {
 		netif_err(priv, drv, net_dev, "mac_dev->change_addr() = %d\n",
 			  err);
diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index bce3c9398887..1950a8936bc0 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -366,7 +366,7 @@ static void set_dflts(struct dtsec_cfg *cfg)
 	cfg->maximum_frame = DEFAULT_MAXIMUM_FRAME;
 }
 
-static void set_mac_address(struct dtsec_regs __iomem *regs, u8 *adr)
+static void set_mac_address(struct dtsec_regs __iomem *regs, const u8 *adr)
 {
 	u32 tmp;
 
@@ -516,7 +516,7 @@ static int init(struct dtsec_regs __iomem *regs, struct dtsec_cfg *cfg,
 
 	if (addr) {
 		MAKE_ENET_ADDR_FROM_UINT64(addr, eth_addr);
-		set_mac_address(regs, (u8 *)eth_addr);
+		set_mac_address(regs, (const u8 *)eth_addr);
 	}
 
 	/* HASH */
@@ -1022,7 +1022,7 @@ int dtsec_accept_rx_pause_frames(struct fman_mac *dtsec, bool en)
 	return 0;
 }
 
-int dtsec_modify_mac_address(struct fman_mac *dtsec, enet_addr_t *enet_addr)
+int dtsec_modify_mac_address(struct fman_mac *dtsec, const enet_addr_t *enet_addr)
 {
 	struct dtsec_regs __iomem *regs = dtsec->regs;
 	enum comm_mode mode = COMM_MODE_NONE;
@@ -1041,7 +1041,7 @@ int dtsec_modify_mac_address(struct fman_mac *dtsec, enet_addr_t *enet_addr)
 	 * Station address have to be swapped (big endian to little endian
 	 */
 	dtsec->addr = ENET_ADDR_TO_UINT64(*enet_addr);
-	set_mac_address(dtsec->regs, (u8 *)(*enet_addr));
+	set_mac_address(dtsec->regs, (const u8 *)(*enet_addr));
 
 	graceful_start(dtsec, mode);
 
diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.h b/drivers/net/ethernet/freescale/fman/fman_dtsec.h
index 5149d96ec2c1..68512c3bd6e5 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.h
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.h
@@ -37,7 +37,7 @@
 
 struct fman_mac *dtsec_config(struct fman_mac_params *params);
 int dtsec_set_promiscuous(struct fman_mac *dtsec, bool new_val);
-int dtsec_modify_mac_address(struct fman_mac *dtsec, enet_addr_t *enet_addr);
+int dtsec_modify_mac_address(struct fman_mac *dtsec, const enet_addr_t *enet_addr);
 int dtsec_adjust_link(struct fman_mac *dtsec,
 		      u16 speed);
 int dtsec_restart_autoneg(struct fman_mac *dtsec);
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 62f42921933d..2216b7f51d26 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -354,7 +354,7 @@ struct fman_mac {
 	bool allmulti_enabled;
 };
 
-static void add_addr_in_paddr(struct memac_regs __iomem *regs, u8 *adr,
+static void add_addr_in_paddr(struct memac_regs __iomem *regs, const u8 *adr,
 			      u8 paddr_num)
 {
 	u32 tmp0, tmp1;
@@ -897,12 +897,12 @@ int memac_accept_rx_pause_frames(struct fman_mac *memac, bool en)
 	return 0;
 }
 
-int memac_modify_mac_address(struct fman_mac *memac, enet_addr_t *enet_addr)
+int memac_modify_mac_address(struct fman_mac *memac, const enet_addr_t *enet_addr)
 {
 	if (!is_init_done(memac->memac_drv_param))
 		return -EINVAL;
 
-	add_addr_in_paddr(memac->regs, (u8 *)(*enet_addr), 0);
+	add_addr_in_paddr(memac->regs, (const u8 *)(*enet_addr), 0);
 
 	return 0;
 }
@@ -1058,7 +1058,7 @@ int memac_init(struct fman_mac *memac)
 	/* MAC Address */
 	if (memac->addr != 0) {
 		MAKE_ENET_ADDR_FROM_UINT64(memac->addr, eth_addr);
-		add_addr_in_paddr(memac->regs, (u8 *)eth_addr, 0);
+		add_addr_in_paddr(memac->regs, (const u8 *)eth_addr, 0);
 	}
 
 	fixed_link = memac_drv_param->fixed_link;
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.h b/drivers/net/ethernet/freescale/fman/fman_memac.h
index b2c671ec0ce7..3820f7a22983 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.h
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.h
@@ -40,7 +40,7 @@
 
 struct fman_mac *memac_config(struct fman_mac_params *params);
 int memac_set_promiscuous(struct fman_mac *memac, bool new_val);
-int memac_modify_mac_address(struct fman_mac *memac, enet_addr_t *enet_addr);
+int memac_modify_mac_address(struct fman_mac *memac, const enet_addr_t *enet_addr);
 int memac_adjust_link(struct fman_mac *memac, u16 speed);
 int memac_cfg_max_frame_len(struct fman_mac *memac, u16 new_val);
 int memac_cfg_reset_on_init(struct fman_mac *memac, bool enable);
diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.c b/drivers/net/ethernet/freescale/fman/fman_tgec.c
index 41946b16f6c7..311c1906e044 100644
--- a/drivers/net/ethernet/freescale/fman/fman_tgec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_tgec.c
@@ -221,7 +221,7 @@ struct fman_mac {
 	bool allmulti_enabled;
 };
 
-static void set_mac_address(struct tgec_regs __iomem *regs, u8 *adr)
+static void set_mac_address(struct tgec_regs __iomem *regs, const u8 *adr)
 {
 	u32 tmp0, tmp1;
 
@@ -514,13 +514,13 @@ int tgec_accept_rx_pause_frames(struct fman_mac *tgec, bool en)
 	return 0;
 }
 
-int tgec_modify_mac_address(struct fman_mac *tgec, enet_addr_t *p_enet_addr)
+int tgec_modify_mac_address(struct fman_mac *tgec, const enet_addr_t *p_enet_addr)
 {
 	if (!is_init_done(tgec->cfg))
 		return -EINVAL;
 
 	tgec->addr = ENET_ADDR_TO_UINT64(*p_enet_addr);
-	set_mac_address(tgec->regs, (u8 *)(*p_enet_addr));
+	set_mac_address(tgec->regs, (const u8 *)(*p_enet_addr));
 
 	return 0;
 }
@@ -704,7 +704,7 @@ int tgec_init(struct fman_mac *tgec)
 
 	if (tgec->addr) {
 		MAKE_ENET_ADDR_FROM_UINT64(tgec->addr, eth_addr);
-		set_mac_address(tgec->regs, (u8 *)eth_addr);
+		set_mac_address(tgec->regs, (const u8 *)eth_addr);
 	}
 
 	/* interrupts */
diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.h b/drivers/net/ethernet/freescale/fman/fman_tgec.h
index 3bfd1062b386..b28b20b26148 100644
--- a/drivers/net/ethernet/freescale/fman/fman_tgec.h
+++ b/drivers/net/ethernet/freescale/fman/fman_tgec.h
@@ -37,7 +37,7 @@
 
 struct fman_mac *tgec_config(struct fman_mac_params *params);
 int tgec_set_promiscuous(struct fman_mac *tgec, bool new_val);
-int tgec_modify_mac_address(struct fman_mac *tgec, enet_addr_t *enet_addr);
+int tgec_modify_mac_address(struct fman_mac *tgec, const enet_addr_t *enet_addr);
 int tgec_cfg_max_frame_len(struct fman_mac *tgec, u16 new_val);
 int tgec_enable(struct fman_mac *tgec, enum comm_mode mode);
 int tgec_disable(struct fman_mac *tgec, enum comm_mode mode);
diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethernet/freescale/fman/mac.h
index 824a81a9f350..daa285a9b8b2 100644
--- a/drivers/net/ethernet/freescale/fman/mac.h
+++ b/drivers/net/ethernet/freescale/fman/mac.h
@@ -66,7 +66,7 @@ struct mac_device {
 	int (*stop)(struct mac_device *mac_dev);
 	void (*adjust_link)(struct mac_device *mac_dev);
 	int (*set_promisc)(struct fman_mac *mac_dev, bool enable);
-	int (*change_addr)(struct fman_mac *mac_dev, enet_addr_t *enet_addr);
+	int (*change_addr)(struct fman_mac *mac_dev, const enet_addr_t *enet_addr);
 	int (*set_allmulti)(struct fman_mac *mac_dev, bool enable);
 	int (*set_tstamp)(struct fman_mac *mac_dev, bool enable);
 	int (*set_multi)(struct net_device *net_dev,
diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 05cb4582a58d..d881f8de74fc 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -427,7 +427,7 @@ static void hisi_femac_free_skb_rings(struct hisi_femac_priv *priv)
 }
 
 static int hisi_femac_set_hw_mac_addr(struct hisi_femac_priv *priv,
-				      unsigned char *mac)
+				      const unsigned char *mac)
 {
 	u32 reg;
 
diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 923191b9a87d..b981b6cbe6ff 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -429,7 +429,7 @@ static void hix5hd2_port_disable(struct hix5hd2_priv *priv)
 static void hix5hd2_hw_set_mac_addr(struct net_device *dev)
 {
 	struct hix5hd2_priv *priv = netdev_priv(dev);
-	unsigned char *mac = dev->dev_addr;
+	const unsigned char *mac = dev->dev_addr;
 	u32 val;
 
 	val = mac[1] | (mac[0] << 8);
diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethernet/hisilicon/hns/hnae.h
index 2b7db1c22321..3d6de4cfa9f7 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -499,7 +499,7 @@ struct hnae_ae_ops {
 				   u32 *tx_usecs_high, u32 *rx_usecs_high);
 	void (*set_promisc_mode)(struct hnae_handle *handle, u32 en);
 	int (*get_mac_addr)(struct hnae_handle *handle, void **p);
-	int (*set_mac_addr)(struct hnae_handle *handle, void *p);
+	int (*set_mac_addr)(struct hnae_handle *handle, const void *p);
 	int (*add_uc_addr)(struct hnae_handle *handle,
 			   const unsigned char *addr);
 	int (*rm_uc_addr)(struct hnae_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
index 75e4ec569da8..b13ee48b458c 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -207,7 +207,7 @@ static void hns_ae_fini_queue(struct hnae_queue *q)
 		hns_rcb_reset_ring_hw(q);
 }
 
-static int hns_ae_set_mac_address(struct hnae_handle *handle, void *p)
+static int hns_ae_set_mac_address(struct hnae_handle *handle, const void *p)
 {
 	int ret;
 	struct hns_mac_cb *mac_cb = hns_get_mac_cb(handle);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
index f387a859a201..8f391e2adcc0 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -450,7 +450,7 @@ static void hns_gmac_update_stats(void *mac_drv)
 		+= dsaf_read_dev(drv, GMAC_TX_PAUSE_FRAMES_REG);
 }
 
-static void hns_gmac_set_mac_addr(void *mac_drv, char *mac_addr)
+static void hns_gmac_set_mac_addr(void *mac_drv, const char *mac_addr)
 {
 	struct mac_driver *drv = (struct mac_driver *)mac_drv;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index ec9a02495df4..236ee9b9d1e6 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -269,7 +269,7 @@ int hns_mac_get_inner_port_num(struct hns_mac_cb *mac_cb, u8 vmid, u8 *port_num)
  *@addr:mac address
  */
 int hns_mac_change_vf_addr(struct hns_mac_cb *mac_cb,
-			   u32 vmid, char *addr)
+			   u32 vmid, const char *addr)
 {
 	int ret;
 	struct mac_driver *mac_ctrl_drv = hns_mac_get_drv(mac_cb);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
index 8943ffab4418..e3bb05959ba9 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
@@ -348,7 +348,7 @@ struct mac_driver {
 	/*disable mac when disable nic or dsaf*/
 	void (*mac_disable)(void *mac_drv, enum mac_commom_mode mode);
 	/* config mac address*/
-	void (*set_mac_addr)(void *mac_drv,	char *mac_addr);
+	void (*set_mac_addr)(void *mac_drv,	const char *mac_addr);
 	/*adjust mac mode of port,include speed and duplex*/
 	int (*adjust_link)(void *mac_drv, enum mac_speed speed,
 			   u32 full_duplex);
@@ -425,7 +425,8 @@ int hns_mac_init(struct dsaf_device *dsaf_dev);
 void mac_adjust_link(struct net_device *net_dev);
 bool hns_mac_need_adjust_link(struct hns_mac_cb *mac_cb, int speed, int duplex);
 void hns_mac_get_link_status(struct hns_mac_cb *mac_cb,	u32 *link_status);
-int hns_mac_change_vf_addr(struct hns_mac_cb *mac_cb, u32 vmid, char *addr);
+int hns_mac_change_vf_addr(struct hns_mac_cb *mac_cb, u32 vmid,
+			   const char *addr);
 int hns_mac_set_multi(struct hns_mac_cb *mac_cb,
 		      u32 port_num, char *addr, bool enable);
 int hns_mac_vm_config_bc_en(struct hns_mac_cb *mac_cb, u32 vm, bool enable);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
index 401fef5f1d07..fc26ffaae620 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -255,7 +255,7 @@ static void hns_xgmac_pausefrm_cfg(void *mac_drv, u32 rx_en, u32 tx_en)
 	dsaf_write_dev(drv, XGMAC_MAC_PAUSE_CTRL_REG, origin);
 }
 
-static void hns_xgmac_set_pausefrm_mac_addr(void *mac_drv, char *mac_addr)
+static void hns_xgmac_set_pausefrm_mac_addr(void *mac_drv, const char *mac_addr)
 {
 	struct mac_driver *drv = (struct mac_driver *)mac_drv;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 695e299f534d..b51afb83d023 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -590,7 +590,7 @@ struct hnae3_ae_ops {
 				   u32 *tx_usecs_high, u32 *rx_usecs_high);
 
 	void (*get_mac_addr)(struct hnae3_handle *handle, u8 *p);
-	int (*set_mac_addr)(struct hnae3_handle *handle, void *p,
+	int (*set_mac_addr)(struct hnae3_handle *handle, const void *p,
 			    bool is_first);
 	int (*do_ioctl)(struct hnae3_handle *handle,
 			struct ifreq *ifr, int cmd);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9e33f0f0b75d..12274c2b9fea 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9444,7 +9444,7 @@ int hclge_update_mac_node_for_dev_addr(struct hclge_vport *vport,
 	return 0;
 }
 
-static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p,
+static int hclge_set_mac_addr(struct hnae3_handle *handle, const void *p,
 			      bool is_first)
 {
 	const unsigned char *new_addr = (const unsigned char *)p;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 880feeac0637..bd8468c2d9a6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1349,7 +1349,7 @@ static void hclgevf_get_mac_addr(struct hnae3_handle *handle, u8 *p)
 		ether_addr_copy(p, hdev->hw.mac.mac_addr);
 }
 
-static int hclgevf_set_mac_addr(struct hnae3_handle *handle, void *p,
+static int hclgevf_set_mac_addr(struct hnae3_handle *handle, const void *p,
 				bool is_first)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 0696f723228a..18d32302c3c7 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -461,7 +461,7 @@ static int init586(struct net_device *dev)
 	ias_cmd->cmd_cmd	= swab16(CMD_IASETUP | CMD_LAST);
 	ias_cmd->cmd_link	= 0xffff;
 
-	memcpy((char *)&ias_cmd->iaddr,(char *) dev->dev_addr,ETH_ALEN);
+	memcpy((char *)&ias_cmd->iaddr,(const char *) dev->dev_addr,ETH_ALEN);
 
 	p->scb->cbl_offset = make16(ias_cmd);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 22802222d34d..453a85410634 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -437,7 +437,7 @@ static inline bool i40e_is_channel_macvlan(struct i40e_channel *ch)
 	return !!ch->fwd;
 }
 
-static inline u8 *i40e_channel_mac(struct i40e_channel *ch)
+static inline const u8 *i40e_channel_mac(struct i40e_channel *ch)
 {
 	if (i40e_is_channel_macvlan(ch))
 		return ch->fwd->netdev->dev_addr;
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_hw.c b/drivers/net/ethernet/intel/ixgb/ixgb_hw.c
index a430871d1c27..c8d1e815ec6b 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_hw.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_hw.c
@@ -549,7 +549,7 @@ ixgb_mta_set(struct ixgb_hw *hw,
  *****************************************************************************/
 void
 ixgb_rar_set(struct ixgb_hw *hw,
-		  u8 *addr,
+		  const u8 *addr,
 		  u32 index)
 {
 	u32 rar_low, rar_high;
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_hw.h b/drivers/net/ethernet/intel/ixgb/ixgb_hw.h
index 6064583095da..70bcff5fb3db 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_hw.h
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_hw.h
@@ -740,7 +740,7 @@ bool ixgb_adapter_start(struct ixgb_hw *hw);
 void ixgb_check_for_link(struct ixgb_hw *hw);
 bool ixgb_check_for_bad_link(struct ixgb_hw *hw);
 
-void ixgb_rar_set(struct ixgb_hw *hw, u8 *addr, u32 index);
+void ixgb_rar_set(struct ixgb_hw *hw, const u8 *addr, u32 index);
 
 /* Filters (multicast, vlan, receive) */
 void ixgb_mc_addr_list_update(struct ixgb_hw *hw, u8 *mc_addr_list,
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index fc67e9d31f6d..d37a0fba3d16 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -1770,7 +1770,7 @@ static void uc_addr_get(struct mv643xx_eth_private *mp, unsigned char *addr)
 	addr[5] = mac_l & 0xff;
 }
 
-static void uc_addr_set(struct mv643xx_eth_private *mp, unsigned char *addr)
+static void uc_addr_set(struct mv643xx_eth_private *mp, const u8 *addr)
 {
 	wrlp(mp, MAC_ADDR_HIGH,
 		(addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) | addr[3]);
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 5fa81322a44b..3f124268bd4d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1623,8 +1623,8 @@ static void mvneta_set_ucast_addr(struct mvneta_port *pp, u8 last_nibble,
 }
 
 /* Set mac address */
-static void mvneta_mac_addr_set(struct mvneta_port *pp, unsigned char *addr,
-				int queue)
+static void mvneta_mac_addr_set(struct mvneta_port *pp,
+				const unsigned char *addr, int queue)
 {
 	unsigned int mac_h;
 	unsigned int mac_l;
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 8ebd13f089db..11ef1d8dea15 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -389,7 +389,7 @@ static void inverse_every_nibble(unsigned char *mac_addr)
  * Outputs
  * return the calculated entry.
  */
-static u32 hash_function(unsigned char *mac_addr_orig)
+static u32 hash_function(const unsigned char *mac_addr_orig)
 {
 	u32 hash_result;
 	u32 addr0;
@@ -434,7 +434,7 @@ static u32 hash_function(unsigned char *mac_addr_orig)
  * -ENOSPC if table full
  */
 static int add_del_hash_entry(struct pxa168_eth_private *pep,
-			      unsigned char *mac_addr,
+			      const unsigned char *mac_addr,
 			      u32 rd, u32 skip, int del)
 {
 	struct addr_table_entry *entry, *start;
@@ -521,7 +521,7 @@ static int add_del_hash_entry(struct pxa168_eth_private *pep,
  */
 static void update_hash_table_mac_address(struct pxa168_eth_private *pep,
 					  unsigned char *oaddr,
-					  unsigned char *addr)
+					  const unsigned char *addr)
 {
 	/* Delete old entry */
 	if (oaddr)
diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 8f3493e146e5..67f9e4415ae9 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -522,7 +522,7 @@ static void mtk_star_dma_resume_tx(struct mtk_star_priv *priv)
 static void mtk_star_set_mac_addr(struct net_device *ndev)
 {
 	struct mtk_star_priv *priv = netdev_priv(ndev);
-	u8 *mac_addr = ndev->dev_addr;
+	const u8 *mac_addr = ndev->dev_addr;
 	unsigned int high, low;
 
 	high = mac_addr[0] << 8 | mac_addr[1] << 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index b69ab30ecf03..efa2e0a8fa1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -691,7 +691,7 @@ static void mlx5_fw_tracer_handle_traces(struct work_struct *work)
 
 	while (block_timestamp > tracer->last_timestamp) {
 		/* Check block override if it's not the first block */
-		if (!tracer->last_timestamp) {
+		if (tracer->last_timestamp) {
 			u64 *ts_event;
 			/* To avoid block override be the HW in case of buffer
 			 * wraparound, the time stamp of the previous block
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index 7aa25a5e29d7..b26edbc53cad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -156,6 +156,7 @@ static int fs_udp_create_groups(struct mlx5e_flow_table *ft, enum fs_udp_type ty
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
 		kfree(ft->g);
+		ft->g = NULL;
 		kvfree(in);
 		return -ENOMEM;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 303e6e7a5c44..d90c6dc41c9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -294,6 +294,9 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv4_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -313,8 +316,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv4_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv4_put(&attr);
@@ -397,12 +398,16 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
+	e->encap_size = ipv4_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto free_encap;
+		goto release_neigh;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -416,10 +421,6 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
-	e->encap_size = ipv4_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv4_put(&attr);
@@ -558,6 +559,9 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv6_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -577,8 +581,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv6_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv6_put(&attr);
@@ -660,12 +662,16 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
+	e->encap_size = ipv6_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto free_encap;
+		goto release_neigh;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -679,10 +685,6 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
-	e->encap_size = ipv6_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv6_put(&attr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index d226cc5ab1d1..aeff1d972a46 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -71,12 +71,12 @@ struct mlx5e_l2_hash_node {
 	bool   mpfs;
 };
 
-static inline int mlx5e_hash_l2(u8 *addr)
+static inline int mlx5e_hash_l2(const u8 *addr)
 {
 	return addr[5];
 }
 
-static void mlx5e_add_l2_to_hash(struct hlist_head *hash, u8 *addr)
+static void mlx5e_add_l2_to_hash(struct hlist_head *hash, const u8 *addr)
 {
 	struct mlx5e_l2_hash_node *hn;
 	int ix = mlx5e_hash_l2(addr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 7a00faa62d99..de168d8cf33f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -73,7 +73,7 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
 	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
-	if (count == sizeof(drvinfo->fw_version))
+	if (count >= sizeof(drvinfo->fw_version))
 		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 10940b8dc83e..8ffc69e57dc6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -223,7 +223,7 @@ void mlx5i_uninit_underlay_qp(struct mlx5e_priv *priv)
 
 int mlx5i_create_underlay_qp(struct mlx5e_priv *priv)
 {
-	unsigned char *dev_addr = priv->netdev->dev_addr;
+	const unsigned char *dev_addr = priv->netdev->dev_addr;
 	u32 out[MLX5_ST_SZ_DW(create_qp_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(create_qp_in)] = {};
 	struct mlx5i_priv *ipriv = priv->ppriv;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 4c1440a95ad7..0478e5ecd491 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -277,7 +277,7 @@ int mlx5_query_nic_vport_mac_list(struct mlx5_core_dev *dev,
 		req_list_size = max_list_size;
 	}
 
-	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_in) +
+	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_out) +
 			req_list_size * MLX5_ST_SZ_BYTES(mac_address_layout);
 
 	out = kzalloc(out_sz, GFP_KERNEL);
diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index b27713906d3a..b639557dbdc6 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -380,7 +380,7 @@ static void ks8842_read_mac_addr(struct ks8842_adapter *adapter, u8 *dest)
 	}
 }
 
-static void ks8842_write_mac_addr(struct ks8842_adapter *adapter, u8 *mac)
+static void ks8842_write_mac_addr(struct ks8842_adapter *adapter, const u8 *mac)
 {
 	unsigned long flags;
 	unsigned i;
diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
index e2eb0caeac82..c0ab179541b2 100644
--- a/drivers/net/ethernet/micrel/ks8851.h
+++ b/drivers/net/ethernet/micrel/ks8851.h
@@ -350,6 +350,8 @@ union ks8851_tx_hdr {
  * @rxd: Space for receiving SPI data, in DMA-able space.
  * @txd: Space for transmitting SPI data, in DMA-able space.
  * @msg_enable: The message flags controlling driver output (see ethtool).
+ * @tx_space: Free space in the hardware TX buffer (cached copy of KS_TXMIR).
+ * @queued_len: Space required in hardware TX buffer for queued packets in txq.
  * @fid: Incrementing frame id tag.
  * @rc_ier: Cached copy of KS_IER.
  * @rc_ccr: Cached copy of KS_CCR.
@@ -399,6 +401,7 @@ struct ks8851_net {
 	struct work_struct	rxctrl_work;
 
 	struct sk_buff_head	txq;
+	unsigned int		queued_len;
 
 	struct eeprom_93cx6	eeprom;
 	struct regulator	*vdd_reg;
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 2c80dba2606c..fb3bed24d50f 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -361,16 +361,18 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		handled |= IRQ_RXPSI;
 
 	if (status & IRQ_TXI) {
-		handled |= IRQ_TXI;
+		unsigned short tx_space = ks8851_rdreg16(ks, KS_TXMIR);
 
-		/* no lock here, tx queue should have been stopped */
+		netif_dbg(ks, intr, ks->netdev,
+			  "%s: txspace %d\n", __func__, tx_space);
 
-		/* update our idea of how much tx space is available to the
-		 * system */
-		ks->tx_space = ks8851_rdreg16(ks, KS_TXMIR);
+		spin_lock(&ks->statelock);
+		ks->tx_space = tx_space;
+		if (netif_queue_stopped(ks->netdev))
+			netif_wake_queue(ks->netdev);
+		spin_unlock(&ks->statelock);
 
-		netif_dbg(ks, intr, ks->netdev,
-			  "%s: txspace %d\n", __func__, ks->tx_space);
+		handled |= IRQ_TXI;
 	}
 
 	if (status & IRQ_RXI)
@@ -413,9 +415,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	if (status & IRQ_TXI)
-		netif_wake_queue(ks->netdev);
-
 	return IRQ_HANDLED;
 }
 
@@ -499,6 +498,7 @@ static int ks8851_net_open(struct net_device *dev)
 	ks8851_wrreg16(ks, KS_ISR, ks->rc_ier);
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);
 
+	ks->queued_len = 0;
 	netif_start_queue(ks->netdev);
 
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 479406ecbaa3..cd17eca77285 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -286,6 +286,18 @@ static void ks8851_wrfifo_spi(struct ks8851_net *ks, struct sk_buff *txp,
 		netdev_err(ks->netdev, "%s: spi_sync() failed\n", __func__);
 }
 
+/**
+ * calc_txlen - calculate size of message to send packet
+ * @len: Length of data
+ *
+ * Returns the size of the TXFIFO message needed to send
+ * this packet.
+ */
+static unsigned int calc_txlen(unsigned int len)
+{
+	return ALIGN(len + 4, 4);
+}
+
 /**
  * ks8851_rx_skb_spi - receive skbuff
  * @ks: The device state
@@ -305,7 +317,9 @@ static void ks8851_rx_skb_spi(struct ks8851_net *ks, struct sk_buff *skb)
  */
 static void ks8851_tx_work(struct work_struct *work)
 {
+	unsigned int dequeued_len = 0;
 	struct ks8851_net_spi *kss;
+	unsigned short tx_space;
 	struct ks8851_net *ks;
 	unsigned long flags;
 	struct sk_buff *txb;
@@ -322,6 +336,8 @@ static void ks8851_tx_work(struct work_struct *work)
 		last = skb_queue_empty(&ks->txq);
 
 		if (txb) {
+			dequeued_len += calc_txlen(txb->len);
+
 			ks8851_wrreg16_spi(ks, KS_RXQCR,
 					   ks->rc_rxqcr | RXQCR_SDA);
 			ks8851_wrfifo_spi(ks, txb, last);
@@ -332,6 +348,13 @@ static void ks8851_tx_work(struct work_struct *work)
 		}
 	}
 
+	tx_space = ks8851_rdreg16_spi(ks, KS_TXMIR);
+
+	spin_lock(&ks->statelock);
+	ks->queued_len -= dequeued_len;
+	ks->tx_space = tx_space;
+	spin_unlock(&ks->statelock);
+
 	ks8851_unlock_spi(ks, &flags);
 }
 
@@ -346,18 +369,6 @@ static void ks8851_flush_tx_work_spi(struct ks8851_net *ks)
 	flush_work(&kss->tx_work);
 }
 
-/**
- * calc_txlen - calculate size of message to send packet
- * @len: Length of data
- *
- * Returns the size of the TXFIFO message needed to send
- * this packet.
- */
-static unsigned int calc_txlen(unsigned int len)
-{
-	return ALIGN(len + 4, 4);
-}
-
 /**
  * ks8851_start_xmit_spi - transmit packet using SPI
  * @skb: The buffer to transmit
@@ -386,16 +397,17 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_buff *skb,
 
 	spin_lock(&ks->statelock);
 
-	if (needed > ks->tx_space) {
+	if (ks->queued_len + needed > ks->tx_space) {
 		netif_stop_queue(dev);
 		ret = NETDEV_TX_BUSY;
 	} else {
-		ks->tx_space -= needed;
+		ks->queued_len += needed;
 		skb_queue_tail(&ks->txq, skb);
 	}
 
 	spin_unlock(&ks->statelock);
-	schedule_work(&kss->tx_work);
+	if (ret == NETDEV_TX_OK)
+		schedule_work(&kss->tx_work);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet/micrel/ksz884x.c
index f56bcd3e36d2..4de7ac046265 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -4033,7 +4033,7 @@ static void hw_set_add_addr(struct ksz_hw *hw)
 	}
 }
 
-static int hw_add_addr(struct ksz_hw *hw, u8 *mac_addr)
+static int hw_add_addr(struct ksz_hw *hw, const u8 *mac_addr)
 {
 	int i;
 	int j = ADDITIONAL_ENTRIES;
@@ -4054,7 +4054,7 @@ static int hw_add_addr(struct ksz_hw *hw, u8 *mac_addr)
 	return -1;
 }
 
-static int hw_del_addr(struct ksz_hw *hw, u8 *mac_addr)
+static int hw_del_addr(struct ksz_hw *hw, const u8 *mac_addr)
 {
 	int i;
 
diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index fe4e7a7d9c0b..8b6c4cc37c53 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -19,6 +19,7 @@ config MICROSOFT_MANA
 	tristate "Microsoft Azure Network Adapter (MANA) support"
 	depends on PCI_MSI && X86_64
 	depends on PCI_HYPERV
+	select PAGE_POOL
 	help
 	  This driver supports Microsoft Azure Network Adapter (MANA).
 	  So far, the driver is only supported on X86_64.
diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 97c2604df019..e6f18e004036 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -796,7 +796,8 @@ static int myri10ge_load_firmware(struct myri10ge_priv *mgp, int adopt)
 	return status;
 }
 
-static int myri10ge_update_mac_address(struct myri10ge_priv *mgp, u8 * addr)
+static int myri10ge_update_mac_address(struct myri10ge_priv *mgp,
+				       const u8 * addr)
 {
 	struct myri10ge_cmd cmd;
 	int status;
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index 65ccdbe665e5..7b50c5135bfa 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -5217,7 +5217,7 @@ static int s2io_set_mac_addr(struct net_device *dev, void *p)
  *  as defined in errno.h file on failure.
  */
 
-static int do_s2io_prog_unicast(struct net_device *dev, u8 *addr)
+static int do_s2io_prog_unicast(struct net_device *dev, const u8 *addr)
 {
 	struct s2io_nic *sp = netdev_priv(dev);
 	register u64 mac_addr = 0, perm_addr = 0;
diff --git a/drivers/net/ethernet/neterion/s2io.h b/drivers/net/ethernet/neterion/s2io.h
index 5a6032212c19..a4266d1544ab 100644
--- a/drivers/net/ethernet/neterion/s2io.h
+++ b/drivers/net/ethernet/neterion/s2io.h
@@ -1073,7 +1073,7 @@ static void s2io_reset(struct s2io_nic * sp);
 static int s2io_poll_msix(struct napi_struct *napi, int budget);
 static int s2io_poll_inta(struct napi_struct *napi, int budget);
 static void s2io_init_pci(struct s2io_nic * sp);
-static int do_s2io_prog_unicast(struct net_device *dev, u8 *addr);
+static int do_s2io_prog_unicast(struct net_device *dev, const u8 *addr);
 static void s2io_alarm_handle(struct timer_list *t);
 static irqreturn_t
 s2io_msix_ring_handle(int irq, void *dev_id);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index babd374333f3..cb43651ea9ba 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -837,7 +837,7 @@ nfp_tunnel_put_ipv6_off(struct nfp_app *app, struct nfp_ipv6_addr_entry *entry)
 }
 
 static int
-__nfp_tunnel_offload_mac(struct nfp_app *app, u8 *mac, u16 idx, bool del)
+__nfp_tunnel_offload_mac(struct nfp_app *app, const u8 *mac, u16 idx, bool del)
 {
 	struct nfp_tun_mac_addr_offload payload;
 
@@ -886,7 +886,7 @@ static bool nfp_tunnel_is_mac_idx_global(u16 nfp_mac_idx)
 }
 
 static struct nfp_tun_offloaded_mac *
-nfp_tunnel_lookup_offloaded_macs(struct nfp_app *app, u8 *mac)
+nfp_tunnel_lookup_offloaded_macs(struct nfp_app *app, const u8 *mac)
 {
 	struct nfp_flower_priv *priv = app->priv;
 
@@ -1005,7 +1005,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
 
 static int
 nfp_tunnel_del_shared_mac(struct nfp_app *app, struct net_device *netdev,
-			  u8 *mac, bool mod)
+			  const u8 *mac, bool mod)
 {
 	struct nfp_flower_priv *priv = app->priv;
 	struct nfp_flower_repr_priv *repr_priv;
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index b42b65fb034e..0b8d605f5ad9 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -419,7 +419,7 @@ struct netdata_local {
 /*
  * MAC support functions
  */
-static void __lpc_set_mac(struct netdata_local *pldat, u8 *mac)
+static void __lpc_set_mac(struct netdata_local *pldat, const u8 *mac)
 {
 	u32 tmp;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index ba445724ee65..3478f6fba826 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -951,7 +951,7 @@ qed_llh_remove_filter(struct qed_hwfn *p_hwfn,
 }
 
 int qed_llh_add_mac_filter(struct qed_dev *cdev,
-			   u8 ppfid, u8 mac_addr[ETH_ALEN])
+			   u8 ppfid, const u8 mac_addr[ETH_ALEN])
 {
 	struct qed_hwfn *p_hwfn = QED_LEADING_HWFN(cdev);
 	struct qed_ptt *p_ptt = qed_ptt_acquire(p_hwfn);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev_api.h b/drivers/net/ethernet/qlogic/qed/qed_dev_api.h
index a0a766a1723c..2475058e7caa 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev_api.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev_api.h
@@ -381,7 +381,7 @@ int qed_llh_set_roce_affinity(struct qed_dev *cdev, enum qed_eng eng);
  * Return: Int.
  */
 int qed_llh_add_mac_filter(struct qed_dev *cdev,
-			   u8 ppfid, u8 mac_addr[ETH_ALEN]);
+			   u8 ppfid, const u8 mac_addr[ETH_ALEN]);
 
 /**
  * qed_llh_remove_mac_filter(): Remove a LLH MAC filter from the given
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 6ffa6425a75a..0872b6c85ab8 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -2857,7 +2857,7 @@ static int qed_fp_cqe_completion(struct qed_dev *dev,
 				      cqe);
 }
 
-static int qed_req_bulletin_update_mac(struct qed_dev *cdev, u8 *mac)
+static int qed_req_bulletin_update_mac(struct qed_dev *cdev, const u8 *mac)
 {
 	int i, ret;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 26700b0b4b37..6e902d57c793 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -2892,7 +2892,7 @@ static int qed_update_drv_state(struct qed_dev *cdev, bool active)
 	return status;
 }
 
-static int qed_update_mac(struct qed_dev *cdev, u8 *mac)
+static int qed_update_mac(struct qed_dev *cdev, const u8 *mac)
 {
 	struct qed_hwfn *hwfn = QED_LEADING_HWFN(cdev);
 	struct qed_ptt *ptt;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 24cd41567775..b734c120d508 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -2854,7 +2854,7 @@ int qed_mcp_ov_update_mtu(struct qed_hwfn *p_hwfn,
 }
 
 int qed_mcp_ov_update_mac(struct qed_hwfn *p_hwfn,
-			  struct qed_ptt *p_ptt, u8 *mac)
+			  struct qed_ptt *p_ptt, const u8 *mac)
 {
 	struct qed_mcp_mb_params mb_params;
 	u32 mfw_mac[2];
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.h b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
index 352b757183e8..526cfdf7ffcc 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -536,7 +536,7 @@ int qed_mcp_ov_update_mtu(struct qed_hwfn *p_hwfn,
  * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_ov_update_mac(struct qed_hwfn *p_hwfn,
-			  struct qed_ptt *p_ptt, u8 *mac);
+			  struct qed_ptt *p_ptt, const u8 *mac);
 
 /**
  * qed_mcp_ov_update_wol(): Send WOL mode to MFW.
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 4f4b79250a2b..725ace88272e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -1966,7 +1966,7 @@ static void qed_rdma_remove_user(void *rdma_cxt, u16 dpi)
 
 static int qed_roce_ll2_set_mac_filter(struct qed_dev *cdev,
 				       u8 *old_mac_address,
-				       u8 *new_mac_address)
+				       const u8 *new_mac_address)
 {
 	int rc = 0;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index e2a5a6a373cb..f25d9676e572 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -1379,7 +1379,7 @@ int qed_vf_pf_get_coalesce(struct qed_hwfn *p_hwfn,
 
 int
 qed_vf_pf_bulletin_update_mac(struct qed_hwfn *p_hwfn,
-			      u8 *p_mac)
+			      const u8 *p_mac)
 {
 	struct qed_vf_iov *p_iov = p_hwfn->vf_iov_info;
 	struct vfpf_bulletin_update_mac_tlv *p_req;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.h b/drivers/net/ethernet/qlogic/qed/qed_vf.h
index 976201fc7d4a..a6492f265487 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.h
@@ -1070,7 +1070,7 @@ u32 qed_vf_hw_bar_size(struct qed_hwfn *p_hwfn, enum BAR_ID bar_id);
  *
  * Return: Int.
  */
-int qed_vf_pf_bulletin_update_mac(struct qed_hwfn *p_hwfn, u8 *p_mac);
+int qed_vf_pf_bulletin_update_mac(struct qed_hwfn *p_hwfn, const u8 *p_mac);
 
 #else
 static inline void qed_vf_get_link_params(struct qed_hwfn *p_hwfn,
@@ -1259,7 +1259,7 @@ static inline int qed_vf_pf_tunnel_param_update(struct qed_hwfn *p_hwfn,
 }
 
 static inline int qed_vf_pf_bulletin_update_mac(struct qed_hwfn *p_hwfn,
-						u8 *p_mac)
+						const u8 *p_mac)
 {
 	return -EINVAL;
 }
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 03c51dd37e1f..3010833ddde3 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -617,7 +617,7 @@ void qede_fill_rss_params(struct qede_dev *edev,
 
 static int qede_set_ucast_rx_mac(struct qede_dev *edev,
 				 enum qed_filter_xcast_params_type opcode,
-				 unsigned char mac[ETH_ALEN])
+				 const unsigned char mac[ETH_ALEN])
 {
 	struct qed_filter_ucast_params ucast;
 
diff --git a/drivers/net/ethernet/qualcomm/emac/emac-mac.c b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
index 87b8c032195d..06104d2ff5b3 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
@@ -420,7 +420,7 @@ static void emac_mac_dma_config(struct emac_adapter *adpt)
 }
 
 /* set MAC address */
-static void emac_set_mac_address(struct emac_adapter *adpt, u8 *addr)
+static void emac_set_mac_address(struct emac_adapter *adpt, const u8 *addr)
 {
 	u32 sta;
 
diff --git a/drivers/net/ethernet/rdc/r6040.c b/drivers/net/ethernet/rdc/r6040.c
index 5a8a6977ec9a..91e136bc2c67 100644
--- a/drivers/net/ethernet/rdc/r6040.c
+++ b/drivers/net/ethernet/rdc/r6040.c
@@ -453,7 +453,7 @@ static void r6040_down(struct net_device *dev)
 {
 	struct r6040_private *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
-	u16 *adrp;
+	const u16 *adrp;
 
 	/* Stop MAC */
 	iowrite16(MSK_INT, ioaddr + MIER);	/* Mask Off Interrupt */
@@ -462,7 +462,7 @@ static void r6040_down(struct net_device *dev)
 	r6040_reset_mac(lp);
 
 	/* Restore MAC Address to MIDx */
-	adrp = (u16 *) dev->dev_addr;
+	adrp = (const u16 *) dev->dev_addr;
 	iowrite16(adrp[0], ioaddr + MID_0L);
 	iowrite16(adrp[1], ioaddr + MID_0M);
 	iowrite16(adrp[2], ioaddr + MID_0H);
@@ -731,13 +731,13 @@ static void r6040_mac_address(struct net_device *dev)
 {
 	struct r6040_private *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
-	u16 *adrp;
+	const u16 *adrp;
 
 	/* Reset MAC */
 	r6040_reset_mac(lp);
 
 	/* Restore MAC Address */
-	adrp = (u16 *) dev->dev_addr;
+	adrp = (const u16 *) dev->dev_addr;
 	iowrite16(adrp[0], ioaddr + MID_0L);
 	iowrite16(adrp[1], ioaddr + MID_0M);
 	iowrite16(adrp[2], ioaddr + MID_0H);
@@ -849,13 +849,13 @@ static void r6040_multicast_list(struct net_device *dev)
 	unsigned long flags;
 	struct netdev_hw_addr *ha;
 	int i;
-	u16 *adrp;
+	const u16 *adrp;
 	u16 hash_table[4] = { 0 };
 
 	spin_lock_irqsave(&lp->lock, flags);
 
 	/* Keep our MAC Address */
-	adrp = (u16 *)dev->dev_addr;
+	adrp = (const u16 *)dev->dev_addr;
 	iowrite16(adrp[0], ioaddr + MID_0L);
 	iowrite16(adrp[1], ioaddr + MID_0M);
 	iowrite16(adrp[2], ioaddr + MID_0H);
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
index 049dc6cf4611..0f45107db8dd 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
@@ -329,7 +329,7 @@ struct sxgbe_core_ops {
 	/* Set power management mode (e.g. magic frame) */
 	void (*pmt)(void __iomem *ioaddr, unsigned long mode);
 	/* Set/Get Unicast MAC addresses */
-	void (*set_umac_addr)(void __iomem *ioaddr, unsigned char *addr,
+	void (*set_umac_addr)(void __iomem *ioaddr, const unsigned char *addr,
 			      unsigned int reg_n);
 	void (*get_umac_addr)(void __iomem *ioaddr, unsigned char *addr,
 			      unsigned int reg_n);
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_core.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_core.c
index e96e2bd295ef..7d9f257de92a 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_core.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_core.c
@@ -85,7 +85,8 @@ static void sxgbe_core_pmt(void __iomem *ioaddr, unsigned long mode)
 }
 
 /* Set/Get Unicast MAC addresses */
-static void sxgbe_core_set_umac_addr(void __iomem *ioaddr, unsigned char *addr,
+static void sxgbe_core_set_umac_addr(void __iomem *ioaddr,
+				     const unsigned char *addr,
 				     unsigned int reg_n)
 {
 	u32 high_word, low_word;
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index b20dbda37c7e..d8b3b339a8df 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1038,7 +1038,7 @@ int efx_ef10_vadaptor_free(struct efx_nic *efx, unsigned int port_id)
 }
 
 int efx_ef10_vport_add_mac(struct efx_nic *efx,
-			   unsigned int port_id, u8 *mac)
+			   unsigned int port_id, const u8 *mac)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_VPORT_ADD_MAC_ADDRESS_IN_LEN);
 
@@ -1050,7 +1050,7 @@ int efx_ef10_vport_add_mac(struct efx_nic *efx,
 }
 
 int efx_ef10_vport_del_mac(struct efx_nic *efx,
-			   unsigned int port_id, u8 *mac)
+			   unsigned int port_id, const u8 *mac)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_VPORT_DEL_MAC_ADDRESS_IN_LEN);
 
diff --git a/drivers/net/ethernet/sfc/ef10_sriov.c b/drivers/net/ethernet/sfc/ef10_sriov.c
index eeaecea77cb8..92550c7e85ce 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.c
+++ b/drivers/net/ethernet/sfc/ef10_sriov.c
@@ -484,7 +484,7 @@ static int efx_ef10_vport_del_vf_mac(struct efx_nic *efx, unsigned int port_id,
 	return rc;
 }
 
-int efx_ef10_sriov_set_vf_mac(struct efx_nic *efx, int vf_i, u8 *mac)
+int efx_ef10_sriov_set_vf_mac(struct efx_nic *efx, int vf_i, const u8 *mac)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	struct ef10_vf *vf;
diff --git a/drivers/net/ethernet/sfc/ef10_sriov.h b/drivers/net/ethernet/sfc/ef10_sriov.h
index cfe556d17313..3c703ca878b0 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.h
+++ b/drivers/net/ethernet/sfc/ef10_sriov.h
@@ -39,7 +39,7 @@ static inline void efx_ef10_sriov_reset(struct efx_nic *efx) {}
 void efx_ef10_sriov_fini(struct efx_nic *efx);
 static inline void efx_ef10_sriov_flr(struct efx_nic *efx, unsigned vf_i) {}
 
-int efx_ef10_sriov_set_vf_mac(struct efx_nic *efx, int vf, u8 *mac);
+int efx_ef10_sriov_set_vf_mac(struct efx_nic *efx, int vf, const u8 *mac);
 
 int efx_ef10_sriov_set_vf_vlan(struct efx_nic *efx, int vf_i,
 			       u16 vlan, u8 qos);
@@ -60,9 +60,9 @@ int efx_ef10_vswitching_restore_vf(struct efx_nic *efx);
 void efx_ef10_vswitching_remove_pf(struct efx_nic *efx);
 void efx_ef10_vswitching_remove_vf(struct efx_nic *efx);
 int efx_ef10_vport_add_mac(struct efx_nic *efx,
-			   unsigned int port_id, u8 *mac);
+			   unsigned int port_id, const u8 *mac);
 int efx_ef10_vport_del_mac(struct efx_nic *efx,
-			   unsigned int port_id, u8 *mac);
+			   unsigned int port_id, const u8 *mac);
 int efx_ef10_vadaptor_alloc(struct efx_nic *efx, unsigned int port_id);
 int efx_ef10_vadaptor_query(struct efx_nic *efx, unsigned int port_id,
 			    u32 *port_flags, u32 *vadaptor_flags,
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 6df500dbb6b7..67a9758467b1 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1482,7 +1482,7 @@ struct efx_nic_type {
 	bool (*sriov_wanted)(struct efx_nic *efx);
 	void (*sriov_reset)(struct efx_nic *efx);
 	void (*sriov_flr)(struct efx_nic *efx, unsigned vf_i);
-	int (*sriov_set_vf_mac)(struct efx_nic *efx, int vf_i, u8 *mac);
+	int (*sriov_set_vf_mac)(struct efx_nic *efx, int vf_i, const u8 *mac);
 	int (*sriov_set_vf_vlan)(struct efx_nic *efx, int vf_i, u16 vlan,
 				 u8 qos);
 	int (*sriov_set_vf_spoofchk)(struct efx_nic *efx, int vf_i,
diff --git a/drivers/net/ethernet/sfc/siena_sriov.c b/drivers/net/ethernet/sfc/siena_sriov.c
index 441e7f3e5375..f12851a527d9 100644
--- a/drivers/net/ethernet/sfc/siena_sriov.c
+++ b/drivers/net/ethernet/sfc/siena_sriov.c
@@ -1591,7 +1591,7 @@ void efx_fini_sriov(void)
 	destroy_workqueue(vfdi_workqueue);
 }
 
-int efx_siena_sriov_set_vf_mac(struct efx_nic *efx, int vf_i, u8 *mac)
+int efx_siena_sriov_set_vf_mac(struct efx_nic *efx, int vf_i, const u8 *mac)
 {
 	struct siena_nic_data *nic_data = efx->nic_data;
 	struct siena_vf *vf;
diff --git a/drivers/net/ethernet/sfc/siena_sriov.h b/drivers/net/ethernet/sfc/siena_sriov.h
index e441c89c25ce..e548c4daf189 100644
--- a/drivers/net/ethernet/sfc/siena_sriov.h
+++ b/drivers/net/ethernet/sfc/siena_sriov.h
@@ -46,7 +46,7 @@ bool efx_siena_sriov_wanted(struct efx_nic *efx);
 void efx_siena_sriov_reset(struct efx_nic *efx);
 void efx_siena_sriov_flr(struct efx_nic *efx, unsigned flr);
 
-int efx_siena_sriov_set_vf_mac(struct efx_nic *efx, int vf, u8 *mac);
+int efx_siena_sriov_set_vf_mac(struct efx_nic *efx, int vf, const u8 *mac);
 int efx_siena_sriov_set_vf_vlan(struct efx_nic *efx, int vf,
 				u16 vlan, u8 qos);
 int efx_siena_sriov_set_vf_spoofchk(struct efx_nic *efx, int vf,
diff --git a/drivers/net/ethernet/sis/sis900.c b/drivers/net/ethernet/sis/sis900.c
index 60a0c0e9ded2..d105779ba3b2 100644
--- a/drivers/net/ethernet/sis/sis900.c
+++ b/drivers/net/ethernet/sis/sis900.c
@@ -1098,7 +1098,7 @@ sis900_init_rxfilter (struct net_device * net_dev)
 
 	/* load MAC addr to filter data register */
 	for (i = 0 ; i < 3 ; i++) {
-		u32 w = (u32) *((u16 *)(net_dev->dev_addr)+i);
+		u32 w = (u32) *((const u16 *)(net_dev->dev_addr)+i);
 
 		sw32(rfcr, i << RFADDR_shift);
 		sw32(rfdr, w);
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index b330dcbe949d..42f79147739b 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -1508,7 +1508,7 @@ static int smsc911x_soft_reset(struct smsc911x_data *pdata)
 
 /* Sets the device MAC address to dev_addr, called with mac_lock held */
 static void
-smsc911x_set_hw_mac_address(struct smsc911x_data *pdata, u8 dev_addr[6])
+smsc911x_set_hw_mac_address(struct smsc911x_data *pdata, const u8 dev_addr[6])
 {
 	u32 mac_high16 = (dev_addr[5] << 8) | dev_addr[4];
 	u32 mac_low32 = (dev_addr[3] << 24) | (dev_addr[2] << 16) |
diff --git a/drivers/net/ethernet/smsc/smsc9420.c b/drivers/net/ethernet/smsc/smsc9420.c
index fdbd2a43e267..2bded7313600 100644
--- a/drivers/net/ethernet/smsc/smsc9420.c
+++ b/drivers/net/ethernet/smsc/smsc9420.c
@@ -404,7 +404,7 @@ static const struct ethtool_ops smsc9420_ethtool_ops = {
 static void smsc9420_set_mac_address(struct net_device *dev)
 {
 	struct smsc9420_pdata *pd = netdev_priv(dev);
-	u8 *dev_addr = dev->dev_addr;
+	const u8 *dev_addr = dev->dev_addr;
 	u32 mac_high16 = (dev_addr[5] << 8) | dev_addr[4];
 	u32 mac_low32 = (dev_addr[3] << 24) | (dev_addr[2] << 16) |
 	    (dev_addr[1] << 8) | dev_addr[0];
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index c113ec56f5b0..c03ac229e936 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -545,13 +545,13 @@ int dwmac4_setup(struct stmmac_priv *priv);
 int dwxgmac2_setup(struct stmmac_priv *priv);
 int dwxlgmac2_setup(struct stmmac_priv *priv);
 
-void stmmac_set_mac_addr(void __iomem *ioaddr, u8 addr[6],
+void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 			 unsigned int high, unsigned int low);
 void stmmac_get_mac_addr(void __iomem *ioaddr, unsigned char *addr,
 			 unsigned int high, unsigned int low);
 void stmmac_set_mac(void __iomem *ioaddr, bool enable);
 
-void stmmac_dwmac4_set_mac_addr(void __iomem *ioaddr, u8 addr[6],
+void stmmac_dwmac4_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 				unsigned int high, unsigned int low);
 void stmmac_dwmac4_get_mac_addr(void __iomem *ioaddr, unsigned char *addr,
 				unsigned int high, unsigned int low);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 06e2af9387d7..fda53b4b9406 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -634,7 +634,7 @@ static void sun8i_dwmac_set_mac(void __iomem *ioaddr, bool enable)
  * If addr is NULL, clear the slot
  */
 static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
-				      unsigned char *addr,
+				      const unsigned char *addr,
 				      unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index fc8759f146c7..76edb9b72675 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -104,7 +104,7 @@ static void dwmac1000_dump_regs(struct mac_device_info *hw, u32 *reg_space)
 }
 
 static void dwmac1000_set_umac_addr(struct mac_device_info *hw,
-				    unsigned char *addr,
+				    const unsigned char *addr,
 				    unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index ebcad8dd99db..75071a7d551a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -68,7 +68,7 @@ static int dwmac100_irq_status(struct mac_device_info *hw,
 }
 
 static void dwmac100_set_umac_addr(struct mac_device_info *hw,
-				   unsigned char *addr,
+				   const unsigned char *addr,
 				   unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 29480314a486..f6d6a6d9c555 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -334,7 +334,7 @@ static void dwmac4_pmt(struct mac_device_info *hw, unsigned long mode)
 }
 
 static void dwmac4_set_umac_addr(struct mac_device_info *hw,
-				 unsigned char *addr, unsigned int reg_n)
+				 const unsigned char *addr, unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 7011c08d2e01..7c26394f665e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -187,7 +187,7 @@ int dwmac4_dma_interrupt(void __iomem *ioaddr,
 	return ret;
 }
 
-void stmmac_dwmac4_set_mac_addr(void __iomem *ioaddr, u8 addr[6],
+void stmmac_dwmac4_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 				unsigned int high, unsigned int low)
 {
 	unsigned long data;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 01d0a14f6752..9b6138b11776 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -239,7 +239,7 @@ void dwmac_dma_flush_tx_fifo(void __iomem *ioaddr)
 	do {} while ((readl(ioaddr + DMA_CONTROL) & DMA_CONTROL_FTF));
 }
 
-void stmmac_set_mac_addr(void __iomem *ioaddr, u8 addr[6],
+void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 			 unsigned int high, unsigned int low)
 {
 	unsigned long data;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 3568bf3ccfbe..c2181c277291 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -335,7 +335,8 @@ static void dwxgmac2_pmt(struct mac_device_info *hw, unsigned long mode)
 }
 
 static void dwxgmac2_set_umac_addr(struct mac_device_info *hw,
-				   unsigned char *addr, unsigned int reg_n)
+				   const unsigned char *addr,
+				   unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index cc229ccd5d81..58e5c6c428dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -330,7 +330,8 @@ struct stmmac_ops {
 	/* Set power management mode (e.g. magic frame) */
 	void (*pmt)(struct mac_device_info *hw, unsigned long mode);
 	/* Set/Get Unicast MAC addresses */
-	void (*set_umac_addr)(struct mac_device_info *hw, unsigned char *addr,
+	void (*set_umac_addr)(struct mac_device_info *hw,
+			      const unsigned char *addr,
 			      unsigned int reg_n);
 	void (*get_umac_addr)(struct mac_device_info *hw, unsigned char *addr,
 			      unsigned int reg_n);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index ea7200b7b647..4705344077b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -36,7 +36,7 @@ struct stmmac_packet_attrs {
 	int vlan_id_in;
 	int vlan_id_out;
 	unsigned char *src;
-	unsigned char *dst;
+	const unsigned char *dst;
 	u32 ip_src;
 	u32 ip_dst;
 	int tcp;
@@ -249,8 +249,8 @@ static int stmmac_test_loopback_validate(struct sk_buff *skb,
 					 struct net_device *orig_ndev)
 {
 	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
+	const unsigned char *dst = tpriv->packet->dst;
 	unsigned char *src = tpriv->packet->src;
-	unsigned char *dst = tpriv->packet->dst;
 	struct stmmachdr *shdr;
 	struct ethhdr *ehdr;
 	struct udphdr *uhdr;
diff --git a/drivers/net/ethernet/sun/sunbmac.c b/drivers/net/ethernet/sun/sunbmac.c
index c646575e79d5..d70426670c37 100644
--- a/drivers/net/ethernet/sun/sunbmac.c
+++ b/drivers/net/ethernet/sun/sunbmac.c
@@ -623,7 +623,7 @@ static int bigmac_init_hw(struct bigmac *bp, bool non_blocking)
 	void __iomem *cregs        = bp->creg;
 	void __iomem *bregs        = bp->bregs;
 	__u32 bblk_dvma = (__u32)bp->bblock_dvma;
-	unsigned char *e = &bp->dev->dev_addr[0];
+	const unsigned char *e = &bp->dev->dev_addr[0];
 
 	/* Latch current counters into statistics. */
 	bigmac_get_counters(bp, bregs);
diff --git a/drivers/net/ethernet/sun/sunqe.c b/drivers/net/ethernet/sun/sunqe.c
index 577cd9753d8e..7591d2d77eb6 100644
--- a/drivers/net/ethernet/sun/sunqe.c
+++ b/drivers/net/ethernet/sun/sunqe.c
@@ -144,7 +144,7 @@ static int qe_init(struct sunqe *qep, int from_irq)
 	void __iomem *cregs = qep->qcregs;
 	void __iomem *mregs = qep->mregs;
 	void __iomem *gregs = qecp->gregs;
-	unsigned char *e = &qep->dev->dev_addr[0];
+	const unsigned char *e = &qep->dev->dev_addr[0];
 	__u32 qblk_dvma = (__u32)qep->qblock_dvma;
 	u32 tmp;
 	int i;
diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c
index bf6c1c6779ff..76eb7db80f13 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c
@@ -57,7 +57,7 @@ static int xlgmac_enable_rx_csum(struct xlgmac_pdata *pdata)
 	return 0;
 }
 
-static int xlgmac_set_mac_address(struct xlgmac_pdata *pdata, u8 *addr)
+static int xlgmac_set_mac_address(struct xlgmac_pdata *pdata, const u8 *addr)
 {
 	unsigned int mac_addr_hi, mac_addr_lo;
 
diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac.h b/drivers/net/ethernet/synopsys/dwc-xlgmac.h
index 8598aaf3ec99..98e3a271e017 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac.h
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac.h
@@ -410,7 +410,7 @@ struct xlgmac_hw_ops {
 	void (*dev_xmit)(struct xlgmac_channel *channel);
 	int (*dev_read)(struct xlgmac_channel *channel);
 
-	int (*set_mac_address)(struct xlgmac_pdata *pdata, u8 *addr);
+	int (*set_mac_address)(struct xlgmac_pdata *pdata, const u8 *addr);
 	int (*config_rx_mode)(struct xlgmac_pdata *pdata);
 	int (*enable_rx_csum)(struct xlgmac_pdata *pdata);
 	int (*disable_rx_csum)(struct xlgmac_pdata *pdata);
diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index 77c448ad67ce..eab7d78d7c72 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -184,7 +184,7 @@ static void	tlan_print_list(struct tlan_list *, char *, int);
 static void	tlan_read_and_clear_stats(struct net_device *, int);
 static void	tlan_reset_adapter(struct net_device *);
 static void	tlan_finish_reset(struct net_device *);
-static void	tlan_set_mac(struct net_device *, int areg, char *mac);
+static void	tlan_set_mac(struct net_device *, int areg, const char *mac);
 
 static void	__tlan_phy_print(struct net_device *);
 static void	tlan_phy_print(struct net_device *);
@@ -2346,7 +2346,7 @@ tlan_finish_reset(struct net_device *dev)
  *
  **************************************************************/
 
-static void tlan_set_mac(struct net_device *dev, int areg, char *mac)
+static void tlan_set_mac(struct net_device *dev, int areg, const char *mac)
 {
 	int i;
 
diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
index 52245ac60fc7..07f9f8e19890 100644
--- a/drivers/net/ethernet/toshiba/tc35815.c
+++ b/drivers/net/ethernet/toshiba/tc35815.c
@@ -1859,7 +1859,8 @@ static struct net_device_stats *tc35815_get_stats(struct net_device *dev)
 	return &dev->stats;
 }
 
-static void tc35815_set_cam_entry(struct net_device *dev, int index, unsigned char *addr)
+static void tc35815_set_cam_entry(struct net_device *dev, int index,
+				  const unsigned char *addr)
 {
 	struct tc35815_local *lp = netdev_priv(dev);
 	struct tc35815_regs __iomem *tr =
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 093c75da38c4..84e459358b05 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -206,12 +206,13 @@ static void xemaclite_disable_interrupts(struct net_local *drvdata)
  * This function writes data from a 16-bit aligned buffer to a 32-bit aligned
  * address in the EmacLite device.
  */
-static void xemaclite_aligned_write(void *src_ptr, u32 *dest_ptr,
+static void xemaclite_aligned_write(const void *src_ptr, u32 *dest_ptr,
 				    unsigned length)
 {
+	const u16 *from_u16_ptr;
 	u32 align_buffer;
 	u32 *to_u32_ptr;
-	u16 *from_u16_ptr, *to_u16_ptr;
+	u16 *to_u16_ptr;
 
 	to_u32_ptr = dest_ptr;
 	from_u16_ptr = src_ptr;
@@ -470,7 +471,7 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
  * buffers (if configured).
  */
 static void xemaclite_update_address(struct net_local *drvdata,
-				     u8 *address_ptr)
+				     const u8 *address_ptr)
 {
 	void __iomem *addr;
 	u32 reg_data;
diff --git a/drivers/net/ethernet/xircom/xirc2ps_cs.c b/drivers/net/ethernet/xircom/xirc2ps_cs.c
index f8bbd1489af1..10f42b7df8b3 100644
--- a/drivers/net/ethernet/xircom/xirc2ps_cs.c
+++ b/drivers/net/ethernet/xircom/xirc2ps_cs.c
@@ -1276,7 +1276,7 @@ struct set_address_info {
 	unsigned int ioaddr;
 };
 
-static void set_address(struct set_address_info *sa_info, char *addr)
+static void set_address(struct set_address_info *sa_info, const char *addr)
 {
 	unsigned int ioaddr = sa_info->ioaddr;
 	int i;
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index cef43b1344a9..b349c359089e 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -273,12 +273,12 @@ static int vsc85xx_downshift_set(struct phy_device *phydev, u8 count)
 static int vsc85xx_wol_set(struct phy_device *phydev,
 			   struct ethtool_wolinfo *wol)
 {
+	const u8 *mac_addr = phydev->attached_dev->dev_addr;
 	int rc;
 	u16 reg_val;
 	u8  i;
 	u16 pwd[3] = {0, 0, 0};
 	struct ethtool_wolinfo *wol_conf = wol;
-	u8 *mac_addr = phydev->attached_dev->dev_addr;
 
 	mutex_lock(&phydev->lock);
 	rc = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED_2);
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index bc5e3f45c499..6db37eb6c5cc 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -119,7 +119,7 @@ static int aqc111_write_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
 }
 
 static int aqc111_write_cmd(struct usbnet *dev, u8 cmd, u16 value,
-			    u16 index, u16 size, void *data)
+			    u16 index, u16 size, const void *data)
 {
 	int ret;
 
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index c419baf47813..a2b1f9a0c6d9 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -169,6 +169,10 @@ struct ax88179_data {
 	u8  eee_active;
 	u16 rxctl;
 	u16 reserved;
+	u8 in_pm;
+	u32 wol_supported;
+	u32 wolopts;
+	u8 disconnecting;
 };
 
 struct ax88179_int_data {
@@ -185,15 +189,30 @@ static const struct {
 	{7, 0xcc, 0x4c, 0x18, 8},
 };
 
+static void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode)
+{
+	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+
+	ax179_data->in_pm = pm_mode;
+}
+
+static int ax88179_in_pm(struct usbnet *dev)
+{
+	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+
+	return ax179_data->in_pm;
+}
+
 static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
-			      u16 size, void *data, int in_pm)
+			      u16 size, void *data)
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	BUG_ON(!dev);
 
-	if (!in_pm)
+	if (!ax88179_in_pm(dev))
 		fn = usbnet_read_cmd;
 	else
 		fn = usbnet_read_cmd_nopm;
@@ -201,7 +220,7 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely((ret < 0) && !(ret == -ENODEV && ax179_data->disconnecting)))
 		netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
 			    index, ret);
 
@@ -209,14 +228,15 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 }
 
 static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
-			       u16 size, void *data, int in_pm)
+			       u16 size, const void *data)
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	BUG_ON(!dev);
 
-	if (!in_pm)
+	if (!ax88179_in_pm(dev))
 		fn = usbnet_write_cmd;
 	else
 		fn = usbnet_write_cmd_nopm;
@@ -224,7 +244,7 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely((ret < 0) && !(ret == -ENODEV && ax179_data->disconnecting)))
 		netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
 			    index, ret);
 
@@ -249,47 +269,6 @@ static void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value,
 	}
 }
 
-static int ax88179_read_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
-				 u16 index, u16 size, void *data)
-{
-	int ret;
-
-	if (2 == size) {
-		u16 buf;
-		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf, 1);
-		le16_to_cpus(&buf);
-		*((u16 *)data) = buf;
-	} else if (4 == size) {
-		u32 buf;
-		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf, 1);
-		le32_to_cpus(&buf);
-		*((u32 *)data) = buf;
-	} else {
-		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data, 1);
-	}
-
-	return ret;
-}
-
-static int ax88179_write_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
-				  u16 index, u16 size, void *data)
-{
-	int ret;
-
-	if (2 == size) {
-		u16 buf;
-		buf = *((u16 *)data);
-		cpu_to_le16s(&buf);
-		ret = __ax88179_write_cmd(dev, cmd, value, index,
-					  size, &buf, 1);
-	} else {
-		ret = __ax88179_write_cmd(dev, cmd, value, index,
-					  size, data, 1);
-	}
-
-	return ret;
-}
-
 static int ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 			    u16 size, void *data)
 {
@@ -297,23 +276,23 @@ static int ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 
 	if (2 == size) {
 		u16 buf = 0;
-		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf, 0);
+		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
 		le16_to_cpus(&buf);
 		*((u16 *)data) = buf;
 	} else if (4 == size) {
 		u32 buf = 0;
-		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf, 0);
+		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
 		le32_to_cpus(&buf);
 		*((u32 *)data) = buf;
 	} else {
-		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data, 0);
+		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data);
 	}
 
 	return ret;
 }
 
 static int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
-			     u16 size, void *data)
+			     u16 size, const void *data)
 {
 	int ret;
 
@@ -322,10 +301,10 @@ static int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 		buf = *((u16 *)data);
 		cpu_to_le16s(&buf);
 		ret = __ax88179_write_cmd(dev, cmd, value, index,
-					  size, &buf, 0);
+					  size, &buf);
 	} else {
 		ret = __ax88179_write_cmd(dev, cmd, value, index,
-					  size, data, 0);
+					  size, data);
 	}
 
 	return ret;
@@ -425,55 +404,63 @@ ax88179_phy_write_mmd_indirect(struct usbnet *dev, u16 prtad, u16 devad,
 static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *priv = dev->driver_priv;
 	u16 tmp16;
 	u8 tmp8;
 
+	ax88179_set_pm_mode(dev, true);
+
 	usbnet_suspend(intf, message);
 
+	/* Enable WoL */
+	if (priv->wolopts) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD,
+				 1, 1, &tmp8);
+		if (priv->wolopts & WAKE_PHY)
+			tmp8 |= AX_MONITOR_MODE_RWLC;
+		if (priv->wolopts & WAKE_MAGIC)
+			tmp8 |= AX_MONITOR_MODE_RWMP;
+
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD,
+				  1, 1, &tmp8);
+	}
+
 	/* Disable RX path */
-	ax88179_read_cmd_nopm(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
-			      2, 2, &tmp16);
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+			 2, 2, &tmp16);
 	tmp16 &= ~AX_MEDIUM_RECEIVE_EN;
-	ax88179_write_cmd_nopm(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
-			       2, 2, &tmp16);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+			  2, 2, &tmp16);
 
 	/* Force bulk-in zero length */
-	ax88179_read_cmd_nopm(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
-			      2, 2, &tmp16);
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
+			 2, 2, &tmp16);
 
 	tmp16 |= AX_PHYPWR_RSTCTL_BZ | AX_PHYPWR_RSTCTL_IPRL;
-	ax88179_write_cmd_nopm(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
-			       2, 2, &tmp16);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
+			  2, 2, &tmp16);
 
 	/* change clock */
 	tmp8 = 0;
-	ax88179_write_cmd_nopm(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp8);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp8);
 
 	/* Configure RX control register => stop operation */
 	tmp16 = AX_RX_CTL_STOP;
-	ax88179_write_cmd_nopm(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
+
+	ax88179_set_pm_mode(dev, false);
 
 	return 0;
 }
 
 /* This function is used to enable the autodetach function. */
 /* This function is determined by offset 0x43 of EEPROM */
-static int ax88179_auto_detach(struct usbnet *dev, int in_pm)
+static int ax88179_auto_detach(struct usbnet *dev)
 {
 	u16 tmp16;
 	u8 tmp8;
-	int (*fnr)(struct usbnet *, u8, u16, u16, u16, void *);
-	int (*fnw)(struct usbnet *, u8, u16, u16, u16, void *);
 
-	if (!in_pm) {
-		fnr = ax88179_read_cmd;
-		fnw = ax88179_write_cmd;
-	} else {
-		fnr = ax88179_read_cmd_nopm;
-		fnw = ax88179_write_cmd_nopm;
-	}
-
-	if (fnr(dev, AX_ACCESS_EEPROM, 0x43, 1, 2, &tmp16) < 0)
+	if (ax88179_read_cmd(dev, AX_ACCESS_EEPROM, 0x43, 1, 2, &tmp16) < 0)
 		return 0;
 
 	if ((tmp16 == 0xFFFF) || (!(tmp16 & 0x0100)))
@@ -481,13 +468,13 @@ static int ax88179_auto_detach(struct usbnet *dev, int in_pm)
 
 	/* Enable Auto Detach bit */
 	tmp8 = 0;
-	fnr(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp8);
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp8);
 	tmp8 |= AX_CLK_SELECT_ULR;
-	fnw(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp8);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp8);
 
-	fnr(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
 	tmp16 |= AX_PHYPWR_RSTCTL_AT;
-	fnw(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
 
 	return 0;
 }
@@ -498,74 +485,74 @@ static int ax88179_resume(struct usb_interface *intf)
 	u16 tmp16;
 	u8 tmp8;
 
+	ax88179_set_pm_mode(dev, true);
+
 	usbnet_link_change(dev, 0, 0);
 
 	/* Power up ethernet PHY */
 	tmp16 = 0;
-	ax88179_write_cmd_nopm(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
-			       2, 2, &tmp16);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
+			  2, 2, &tmp16);
 	udelay(1000);
 
 	tmp16 = AX_PHYPWR_RSTCTL_IPRL;
-	ax88179_write_cmd_nopm(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
-			       2, 2, &tmp16);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
+			  2, 2, &tmp16);
 	msleep(200);
 
 	/* Ethernet PHY Auto Detach*/
-	ax88179_auto_detach(dev, 1);
+	ax88179_auto_detach(dev);
 
 	/* Enable clock */
-	ax88179_read_cmd_nopm(dev, AX_ACCESS_MAC,  AX_CLK_SELECT, 1, 1, &tmp8);
+	ax88179_read_cmd(dev, AX_ACCESS_MAC,  AX_CLK_SELECT, 1, 1, &tmp8);
 	tmp8 |= AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
-	ax88179_write_cmd_nopm(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp8);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp8);
 	msleep(100);
 
 	/* Configure RX control register => start operation */
 	tmp16 = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_IPE | AX_RX_CTL_START |
 		AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
-	ax88179_write_cmd_nopm(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
+
+	ax88179_set_pm_mode(dev, false);
 
 	return usbnet_resume(intf);
 }
 
+static void ax88179_disconnect(struct usb_interface *intf)
+{
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *ax179_data;
+
+	if (!dev)
+		return;
+
+	ax179_data = dev->driver_priv;
+	ax179_data->disconnecting = 1;
+
+	usbnet_disconnect(intf);
+}
+
 static void
 ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	u8 opt;
-
-	if (ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD,
-			     1, 1, &opt) < 0) {
-		wolinfo->supported = 0;
-		wolinfo->wolopts = 0;
-		return;
-	}
+	struct ax88179_data *priv = dev->driver_priv;
 
-	wolinfo->supported = WAKE_PHY | WAKE_MAGIC;
-	wolinfo->wolopts = 0;
-	if (opt & AX_MONITOR_MODE_RWLC)
-		wolinfo->wolopts |= WAKE_PHY;
-	if (opt & AX_MONITOR_MODE_RWMP)
-		wolinfo->wolopts |= WAKE_MAGIC;
+	wolinfo->supported = priv->wol_supported;
+	wolinfo->wolopts = priv->wolopts;
 }
 
 static int
 ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	u8 opt = 0;
+	struct ax88179_data *priv = dev->driver_priv;
 
-	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+	if (wolinfo->wolopts & ~(priv->wol_supported))
 		return -EINVAL;
 
-	if (wolinfo->wolopts & WAKE_PHY)
-		opt |= AX_MONITOR_MODE_RWLC;
-	if (wolinfo->wolopts & WAKE_MAGIC)
-		opt |= AX_MONITOR_MODE_RWMP;
-
-	if (ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD,
-			      1, 1, &opt) < 0)
-		return -EINVAL;
+	priv->wolopts = wolinfo->wolopts;
 
 	return 0;
 }
@@ -599,8 +586,7 @@ ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 	/* ax88179/178A returns 2 bytes from eeprom on read */
 	for (i = first_word; i <= last_word; i++) {
 		ret = __ax88179_read_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
-					 &eeprom_buff[i - first_word],
-					 0);
+					 &eeprom_buff[i - first_word]);
 		if (ret < 0) {
 			kfree(eeprom_buff);
 			return -EIO;
@@ -1069,7 +1055,7 @@ static int ax88179_check_eeprom(struct usbnet *dev)
 		} while (buf & EEP_BUSY);
 
 		__ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_SROM_DATA_LOW,
-				   2, 2, &eeprom[i * 2], 0);
+				   2, 2, &eeprom[i * 2]);
 
 		if ((i == 0) && (eeprom[0] == 0xFF))
 			return -EINVAL;
@@ -1707,7 +1693,7 @@ static int ax88179_reset(struct usbnet *dev)
 	msleep(200);
 
 	/* Ethernet PHY Auto Detach*/
-	ax88179_auto_detach(dev, 0);
+	ax88179_auto_detach(dev);
 
 	/* Read MAC address from DTB or asix chip */
 	ax88179_get_mac_addr(dev);
@@ -1756,6 +1742,12 @@ static int ax88179_reset(struct usbnet *dev)
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
 			  2, 2, tmp16);
 
+	/* Check if WoL is supported */
+	ax179_data->wol_supported = 0;
+	if (ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD,
+			     1, 1, &tmp) > 0)
+		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
+
 	ax88179_led_setting(dev);
 
 	ax179_data->eee_enabled = 0;
@@ -1971,7 +1963,7 @@ static struct usb_driver ax88179_178a_driver = {
 	.suspend =	ax88179_suspend,
 	.resume =	ax88179_resume,
 	.reset_resume =	ax88179_resume,
-	.disconnect =	usbnet_disconnect,
+	.disconnect =	ax88179_disconnect,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 };
diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index 97ba67042d12..24db5768a3c0 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -615,7 +615,7 @@ static void catc_stats_timer(struct timer_list *t)
  * Receive modes. Broadcast, Multicast, Promisc.
  */
 
-static void catc_multicast(unsigned char *addr, u8 *multicast)
+static void catc_multicast(const unsigned char *addr, u8 *multicast)
 {
 	u32 crc;
 
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 56f1c334cdd2..1959e12a3ff8 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -93,7 +93,8 @@ static int dm_write_reg(struct usbnet *dev, u8 reg, u8 value)
 				value, reg, NULL, 0);
 }
 
-static void dm_write_async(struct usbnet *dev, u8 reg, u16 length, void *data)
+static void dm_write_async(struct usbnet *dev, u8 reg, u16 length,
+			   const void *data)
 {
 	usbnet_write_cmd_async(dev, DM_WRITE_REGS,
 			       USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index a31a3b9cbd58..8f484c4949d9 100644
--- a/drivers/net/usb/mcs7830.c
+++ b/drivers/net/usb/mcs7830.c
@@ -140,7 +140,8 @@ static int mcs7830_hif_get_mac_address(struct usbnet *dev, unsigned char *addr)
 	return 0;
 }
 
-static int mcs7830_hif_set_mac_address(struct usbnet *dev, unsigned char *addr)
+static int mcs7830_hif_set_mac_address(struct usbnet *dev,
+				       const unsigned char *addr)
 {
 	int ret = mcs7830_set_reg(dev, HIF_REG_ETHERNET_ADDR, ETH_ALEN, addr);
 
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 1fac6ee273c4..279a540aef10 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -56,7 +56,8 @@ static int sr_write_reg(struct usbnet *dev, u8 reg, u8 value)
 				value, reg, NULL, 0);
 }
 
-static void sr_write_async(struct usbnet *dev, u8 reg, u16 length, void *data)
+static void sr_write_async(struct usbnet *dev, u8 reg, u16 length,
+			   const void *data)
 {
 	usbnet_write_cmd_async(dev, SR_WR_REGS, SR_REQ_WR_REG,
 			       0, reg, data, length);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index b7b2d28b3e43..8a19463bc81c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2960,7 +2960,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 	struct iwl_rxq *rxq = &trans_pcie->rxq[0];
 	u32 i, r, j, rb_len = 0;
 
-	spin_lock(&rxq->lock);
+	spin_lock_bh(&rxq->lock);
 
 	r = le16_to_cpu(iwl_get_closed_rb_stts(trans, rxq)) & 0x0FFF;
 
@@ -2984,7 +2984,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 		*data = iwl_fw_error_next_data(*data);
 	}
 
-	spin_unlock(&rxq->lock);
+	spin_unlock_bh(&rxq->lock);
 
 	return rb_len;
 }
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 62b9a94c10ba..d80c3911b5b1 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1038,6 +1038,13 @@ static const struct of_device_id atmel_pctrl_of_match[] = {
 	}
 };
 
+/*
+ * This lock class allows to tell lockdep that parent IRQ and children IRQ do
+ * not share the same class so it does not raise false positive
+ */
+static struct lock_class_key atmel_lock_key;
+static struct lock_class_key atmel_request_key;
+
 static int atmel_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1193,6 +1200,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		irq_set_chip_and_handler(irq, &atmel_gpio_irq_chip,
 					 handle_simple_irq);
 		irq_set_chip_data(irq, atmel_pioctrl);
+		irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
 		dev_dbg(dev,
 			"atmel gpio irq domain: hwirq: %d, linux irq: %d\n",
 			i, irq);
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 61e688882643..320412e513c0 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -806,6 +806,9 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 {
 	lockdep_assert_held(&reset_list_mutex);
 
+	if (IS_ERR_OR_NULL(rstc))
+		return;
+
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
@@ -1016,11 +1019,8 @@ EXPORT_SYMBOL_GPL(reset_control_put);
 void reset_control_bulk_put(int num_rstcs, struct reset_control_bulk_data *rstcs)
 {
 	mutex_lock(&reset_list_mutex);
-	while (num_rstcs--) {
-		if (IS_ERR_OR_NULL(rstcs[num_rstcs].rstc))
-			continue;
+	while (num_rstcs--)
 		__reset_control_put_internal(rstcs[num_rstcs].rstc);
-	}
 	mutex_unlock(&reset_list_mutex);
 }
 EXPORT_SYMBOL_GPL(reset_control_bulk_put);
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index e2586472ecad..6090434ad6f3 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -432,7 +432,6 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct fcoe_ctlr *ctlr;
 	struct fcoe_rcv_info *fr;
 	struct fcoe_percpu_s *bg;
-	struct sk_buff *tmp_skb;
 
 	interface = container_of(ptype, struct bnx2fc_interface,
 				 fcoe_packet_type);
@@ -444,11 +443,9 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto err;
 	}
 
-	tmp_skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!tmp_skb)
-		goto err;
-
-	skb = tmp_skb;
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return -1;
 
 	if (unlikely(eth_hdr(skb)->h_proto != htons(ETH_P_FCOE))) {
 		printk(KERN_ERR PFX "bnx2fc_rcv: Wrong FC type frame\n");
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 18b99240a906..f79cfd1cb3e7 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1104,6 +1104,7 @@ static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
 
 	scsi_log_send(scmd);
 	scmd->submitter = SUBMITTED_BY_SCSI_ERROR_HANDLER;
+	scmd->flags |= SCMD_LAST;
 
 	/*
 	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
@@ -2397,6 +2398,7 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	scmd->cmnd = scsi_req(rq)->cmd;
 
 	scmd->submitter = SUBMITTED_BY_SCSI_RESET_IOCTL;
+	scmd->flags |= SCMD_LAST;
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
 
 	scmd->cmd_len			= 0;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 06dd1be54925..d4b186a35bb2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -335,6 +335,18 @@ const struct spi_device_id *spi_get_device_id(const struct spi_device *sdev)
 }
 EXPORT_SYMBOL_GPL(spi_get_device_id);
 
+const void *spi_get_device_match_data(const struct spi_device *sdev)
+{
+	const void *match;
+
+	match = device_get_match_data(&sdev->dev);
+	if (match)
+		return match;
+
+	return (const void *)spi_get_device_id(sdev)->driver_data;
+}
+EXPORT_SYMBOL_GPL(spi_get_device_match_data);
+
 static int spi_match_device(struct device *dev, struct device_driver *drv)
 {
 	const struct spi_device	*spi = to_spi_device(dev);
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index d9a3fd8af7a0..b0b6caaa29bd 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -429,8 +429,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 			temp = size;
 		size -= temp;
 		next += temp;
-		if (temp == size)
-			goto done;
 	}
 
 	temp = snprintf(next, size, "\n");
@@ -440,7 +438,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 	size -= temp;
 	next += temp;
 
-done:
 	*sizep = size;
 	*nextp = next;
 }
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 49448cdbe998..2345208b7221 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1011,9 +1011,9 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, ACTISENSE_USG_PID) },
 	{ USB_DEVICE(FTDI_VID, ACTISENSE_NGT_PID) },
 	{ USB_DEVICE(FTDI_VID, ACTISENSE_NGW_PID) },
-	{ USB_DEVICE(FTDI_VID, ACTISENSE_D9AC_PID) },
-	{ USB_DEVICE(FTDI_VID, ACTISENSE_D9AD_PID) },
-	{ USB_DEVICE(FTDI_VID, ACTISENSE_D9AE_PID) },
+	{ USB_DEVICE(FTDI_VID, ACTISENSE_UID_PID) },
+	{ USB_DEVICE(FTDI_VID, ACTISENSE_USA_PID) },
+	{ USB_DEVICE(FTDI_VID, ACTISENSE_NGX_PID) },
 	{ USB_DEVICE(FTDI_VID, ACTISENSE_D9AF_PID) },
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEAGAUGE_PID) },
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEASWITCH_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 31c8ccabbbb7..9a0f9fc99124 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1561,9 +1561,9 @@
 #define ACTISENSE_USG_PID		0xD9A9 /* USG USB Serial Adapter */
 #define ACTISENSE_NGT_PID		0xD9AA /* NGT NMEA2000 Interface */
 #define ACTISENSE_NGW_PID		0xD9AB /* NGW NMEA2000 Gateway */
-#define ACTISENSE_D9AC_PID		0xD9AC /* Actisense Reserved */
-#define ACTISENSE_D9AD_PID		0xD9AD /* Actisense Reserved */
-#define ACTISENSE_D9AE_PID		0xD9AE /* Actisense Reserved */
+#define ACTISENSE_UID_PID		0xD9AC /* USB Isolating Device */
+#define ACTISENSE_USA_PID		0xD9AD /* USB to Serial Adapter */
+#define ACTISENSE_NGX_PID		0xD9AE /* NGX NMEA2000 Gateway */
 #define ACTISENSE_D9AF_PID		0xD9AF /* Actisense Reserved */
 #define CHETCO_SEAGAUGE_PID		0xA548 /* SeaGauge USB Adapter */
 #define CHETCO_SEASWITCH_PID		0xA549 /* SeaSwitch USB Adapter */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 7f2aa72d52e6..4adef9259870 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -272,6 +272,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200U			0x0901
+#define QUECTEL_PRODUCT_EG912Y			0x6001
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
 #define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
@@ -1232,6 +1233,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, 0x0700, 0xff), /* BG95 */
 	  .driver_info = RSVD(3) | ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
 	  .driver_info = ZLP },
@@ -1244,6 +1246,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG912Y, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
@@ -2242,6 +2245,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0da, 0xff),                     /* Foxconn T99W265 MBIM variant */
+	  .driver_info = RSVD(3) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0db, 0xff),			/* Foxconn T99W265 MBIM */
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0ee, 0xff),			/* Foxconn T99W368 MBIM */
diff --git a/fs/Kconfig b/fs/Kconfig
index a6313a969bc5..971339ecc1a2 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -369,8 +369,8 @@ source "fs/ksmbd/Kconfig"
 
 config SMBFS_COMMON
 	tristate
-	default y if CIFS=y
-	default m if CIFS=m
+	default y if CIFS=y || SMB_SERVER=y
+	default m if CIFS=m || SMB_SERVER=m
 
 source "fs/coda/Kconfig"
 source "fs/afs/Kconfig"
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index d88407fb9bc0..77571372888d 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -158,7 +158,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 		cell->name[i] = tolower(name[i]);
 	cell->name[i] = 0;
 
-	atomic_set(&cell->ref, 1);
+	refcount_set(&cell->ref, 1);
 	atomic_set(&cell->active, 0);
 	INIT_WORK(&cell->manager, afs_manage_cell_work);
 	cell->volumes = RB_ROOT;
@@ -287,7 +287,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	cell = candidate;
 	candidate = NULL;
 	atomic_set(&cell->active, 2);
-	trace_afs_cell(cell->debug_id, atomic_read(&cell->ref), 2, afs_cell_trace_insert);
+	trace_afs_cell(cell->debug_id, refcount_read(&cell->ref), 2, afs_cell_trace_insert);
 	rb_link_node_rcu(&cell->net_node, parent, pp);
 	rb_insert_color(&cell->net_node, &net->cells);
 	up_write(&net->cells_lock);
@@ -295,7 +295,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	afs_queue_cell(cell, afs_cell_trace_get_queue_new);
 
 wait_for_cell:
-	trace_afs_cell(cell->debug_id, atomic_read(&cell->ref), atomic_read(&cell->active),
+	trace_afs_cell(cell->debug_id, refcount_read(&cell->ref), atomic_read(&cell->active),
 		       afs_cell_trace_wait);
 	_debug("wait_for_cell");
 	wait_var_event(&cell->state,
@@ -409,10 +409,12 @@ static int afs_update_cell(struct afs_cell *cell)
 		if (ret == -ENOMEM)
 			goto out_wake;
 
-		ret = -ENOMEM;
 		vllist = afs_alloc_vlserver_list(0);
-		if (!vllist)
+		if (!vllist) {
+			if (ret >= 0)
+				ret = -ENOMEM;
 			goto out_wake;
+		}
 
 		switch (ret) {
 		case -ENODATA:
@@ -490,13 +492,13 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 {
 	struct afs_cell *cell = container_of(rcu, struct afs_cell, rcu);
 	struct afs_net *net = cell->net;
-	int u;
+	int r;
 
 	_enter("%p{%s}", cell, cell->name);
 
-	u = atomic_read(&cell->ref);
-	ASSERTCMP(u, ==, 0);
-	trace_afs_cell(cell->debug_id, u, atomic_read(&cell->active), afs_cell_trace_free);
+	r = refcount_read(&cell->ref);
+	ASSERTCMP(r, ==, 0);
+	trace_afs_cell(cell->debug_id, r, atomic_read(&cell->active), afs_cell_trace_free);
 
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
 	afs_unuse_cell(net, cell->alias_of, afs_cell_trace_unuse_alias);
@@ -539,13 +541,10 @@ void afs_cells_timer(struct timer_list *timer)
  */
 struct afs_cell *afs_get_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 {
-	int u;
+	int r;
 
-	if (atomic_read(&cell->ref) <= 0)
-		BUG();
-
-	u = atomic_inc_return(&cell->ref);
-	trace_afs_cell(cell->debug_id, u, atomic_read(&cell->active), reason);
+	__refcount_inc(&cell->ref, &r);
+	trace_afs_cell(cell->debug_id, r + 1, atomic_read(&cell->active), reason);
 	return cell;
 }
 
@@ -556,12 +555,14 @@ void afs_put_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 {
 	if (cell) {
 		unsigned int debug_id = cell->debug_id;
-		unsigned int u, a;
+		unsigned int a;
+		bool zero;
+		int r;
 
 		a = atomic_read(&cell->active);
-		u = atomic_dec_return(&cell->ref);
-		trace_afs_cell(debug_id, u, a, reason);
-		if (u == 0) {
+		zero = __refcount_dec_and_test(&cell->ref, &r);
+		trace_afs_cell(debug_id, r - 1, a, reason);
+		if (zero) {
 			a = atomic_read(&cell->active);
 			WARN(a != 0, "Cell active count %u > 0\n", a);
 			call_rcu(&cell->rcu, afs_cell_destroy);
@@ -574,14 +575,12 @@ void afs_put_cell(struct afs_cell *cell, enum afs_cell_trace reason)
  */
 struct afs_cell *afs_use_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 {
-	int u, a;
-
-	if (atomic_read(&cell->ref) <= 0)
-		BUG();
+	int r, a;
 
-	u = atomic_read(&cell->ref);
+	r = refcount_read(&cell->ref);
+	WARN_ON(r == 0);
 	a = atomic_inc_return(&cell->active);
-	trace_afs_cell(cell->debug_id, u, a, reason);
+	trace_afs_cell(cell->debug_id, r, a, reason);
 	return cell;
 }
 
@@ -593,7 +592,7 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
 {
 	unsigned int debug_id;
 	time64_t now, expire_delay;
-	int u, a;
+	int r, a;
 
 	if (!cell)
 		return;
@@ -607,9 +606,9 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
 		expire_delay = afs_cell_gc_delay;
 
 	debug_id = cell->debug_id;
-	u = atomic_read(&cell->ref);
+	r = refcount_read(&cell->ref);
 	a = atomic_dec_return(&cell->active);
-	trace_afs_cell(debug_id, u, a, reason);
+	trace_afs_cell(debug_id, r, a, reason);
 	WARN_ON(a == 0);
 	if (a == 1)
 		/* 'cell' may now be garbage collected. */
@@ -621,11 +620,11 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
  */
 void afs_see_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 {
-	int u, a;
+	int r, a;
 
-	u = atomic_read(&cell->ref);
+	r = refcount_read(&cell->ref);
 	a = atomic_read(&cell->active);
-	trace_afs_cell(cell->debug_id, u, a, reason);
+	trace_afs_cell(cell->debug_id, r, a, reason);
 }
 
 /*
@@ -751,7 +750,7 @@ static void afs_manage_cell(struct afs_cell *cell)
 		active = 1;
 		if (atomic_try_cmpxchg_relaxed(&cell->active, &active, 0)) {
 			rb_erase(&cell->net_node, &net->cells);
-			trace_afs_cell(cell->debug_id, atomic_read(&cell->ref), 0,
+			trace_afs_cell(cell->debug_id, refcount_read(&cell->ref), 0,
 				       afs_cell_trace_unuse_delete);
 			smp_store_release(&cell->state, AFS_CELL_REMOVED);
 		}
@@ -878,7 +877,7 @@ void afs_manage_cells(struct work_struct *work)
 		bool sched_cell = false;
 
 		active = atomic_read(&cell->active);
-		trace_afs_cell(cell->debug_id, atomic_read(&cell->ref),
+		trace_afs_cell(cell->debug_id, refcount_read(&cell->ref),
 			       active, afs_cell_trace_manage);
 
 		ASSERTCMP(active, >=, 1);
@@ -886,7 +885,7 @@ void afs_manage_cells(struct work_struct *work)
 		if (purging) {
 			if (test_and_clear_bit(AFS_CELL_FL_NO_GC, &cell->flags)) {
 				active = atomic_dec_return(&cell->active);
-				trace_afs_cell(cell->debug_id, atomic_read(&cell->ref),
+				trace_afs_cell(cell->debug_id, refcount_read(&cell->ref),
 					       active, afs_cell_trace_unuse_pin);
 			}
 		}
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index a3f5de28be79..cedd627e1fae 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -213,7 +213,7 @@ static void SRXAFSCB_CallBack(struct work_struct *work)
 	 */
 	if (call->server) {
 		trace_afs_server(call->server,
-				 atomic_read(&call->server->ref),
+				 refcount_read(&call->server->ref),
 				 atomic_read(&call->server->active),
 				 afs_server_trace_callback);
 		afs_break_callbacks(call->server, call->count, call->request);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index b35c6081dbfe..96b404d9e13a 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -113,6 +113,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	struct afs_net *net = afs_d2net(dentry);
 	const char *name = dentry->d_name.name;
 	size_t len = dentry->d_name.len;
+	char *result = NULL;
 	int ret;
 
 	/* Names prefixed with a dot are R/W mounts. */
@@ -130,9 +131,22 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	}
 
 	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
-			NULL, NULL, false);
-	if (ret == -ENODATA || ret == -ENOKEY)
+			&result, NULL, false);
+	if (ret == -ENODATA || ret == -ENOKEY || ret == 0)
 		ret = -ENOENT;
+	if (ret > 0 && ret >= sizeof(struct dns_server_list_v1_header)) {
+		struct dns_server_list_v1_header *v1 = (void *)result;
+
+		if (v1->hdr.zero == 0 &&
+		    v1->hdr.content == DNS_PAYLOAD_IS_SERVER_LIST &&
+		    v1->hdr.version == 1 &&
+		    (v1->status != DNS_LOOKUP_GOOD &&
+		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD))
+			return -ENOENT;
+
+	}
+
+	kfree(result);
 	return ret;
 }
 
@@ -251,20 +265,9 @@ static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return 1;
 }
 
-/*
- * Allow the VFS to enquire as to whether a dentry should be unhashed (mustn't
- * sleep)
- * - called from dput() when d_count is going to 0.
- * - return 1 to request dentry be unhashed, 0 otherwise
- */
-static int afs_dynroot_d_delete(const struct dentry *dentry)
-{
-	return d_really_is_positive(dentry);
-}
-
 const struct dentry_operations afs_dynroot_dentry_operations = {
 	.d_revalidate	= afs_dynroot_d_revalidate,
-	.d_delete	= afs_dynroot_d_delete,
+	.d_delete	= always_delete_dentry,
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,
 };
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 183200c6ce20..0c03877cdaf7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -123,7 +123,7 @@ struct afs_call {
 	};
 	struct afs_operation	*op;
 	unsigned int		server_index;
-	atomic_t		usage;
+	refcount_t		ref;
 	enum afs_call_state	state;
 	spinlock_t		state_lock;
 	int			error;		/* error code */
@@ -368,7 +368,7 @@ struct afs_cell {
 #endif
 	time64_t		dns_expiry;	/* Time AFSDB/SRV record expires */
 	time64_t		last_inactive;	/* Time of last drop of usage count */
-	atomic_t		ref;		/* Struct refcount */
+	refcount_t		ref;		/* Struct refcount */
 	atomic_t		active;		/* Active usage counter */
 	unsigned long		flags;
 #define AFS_CELL_FL_NO_GC	0		/* The cell was added manually, don't auto-gc */
@@ -413,7 +413,7 @@ struct afs_vlserver {
 #define AFS_VLSERVER_FL_IS_YFS	2		/* Server is YFS not AFS */
 #define AFS_VLSERVER_FL_RESPONDING 3		/* VL server is responding */
 	rwlock_t		lock;		/* Lock on addresses */
-	atomic_t		usage;
+	refcount_t		ref;
 	unsigned int		rtt;		/* Server's current RTT in uS */
 
 	/* Probe state */
@@ -449,7 +449,7 @@ struct afs_vlserver_entry {
 
 struct afs_vlserver_list {
 	struct rcu_head		rcu;
-	atomic_t		usage;
+	refcount_t		ref;
 	u8			nr_servers;
 	u8			index;		/* Server currently in use */
 	u8			preferred;	/* Preferred server */
@@ -520,7 +520,7 @@ struct afs_server {
 #define AFS_SERVER_FL_NO_IBULK	17		/* Fileserver doesn't support FS.InlineBulkStatus */
 #define AFS_SERVER_FL_NO_RM2	18		/* Fileserver doesn't support YFS.RemoveFile2 */
 #define AFS_SERVER_FL_HAS_FS64	19		/* Fileserver supports FS.{Fetch,Store}Data64 */
-	atomic_t		ref;		/* Object refcount */
+	refcount_t		ref;		/* Object refcount */
 	atomic_t		active;		/* Active user count */
 	u32			addr_version;	/* Address list version */
 	unsigned int		rtt;		/* Server's current RTT in uS */
@@ -575,7 +575,7 @@ struct afs_volume {
 		struct rcu_head	rcu;
 		afs_volid_t	vid;		/* volume ID */
 	};
-	atomic_t		usage;
+	refcount_t		ref;
 	time64_t		update_at;	/* Time at which to next update */
 	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
 	struct rb_node		cell_node;	/* Link in cell->volumes */
@@ -589,6 +589,7 @@ struct afs_volume {
 #define AFS_VOLUME_OFFLINE	4	/* - T if volume offline notice given */
 #define AFS_VOLUME_BUSY		5	/* - T if volume busy notice given */
 #define AFS_VOLUME_MAYBE_NO_IBULK 6	/* - T if some servers don't have InlineBulkStatus */
+#define AFS_VOLUME_RM_TREE	7	/* - Set if volume removed from cell->volumes */
 #ifdef CONFIG_AFS_FSCACHE
 	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
@@ -1483,14 +1484,14 @@ extern int afs_end_vlserver_operation(struct afs_vl_cursor *);
  */
 static inline struct afs_vlserver *afs_get_vlserver(struct afs_vlserver *vlserver)
 {
-	atomic_inc(&vlserver->usage);
+	refcount_inc(&vlserver->ref);
 	return vlserver;
 }
 
 static inline struct afs_vlserver_list *afs_get_vlserverlist(struct afs_vlserver_list *vllist)
 {
 	if (vllist)
-		atomic_inc(&vllist->usage);
+		refcount_inc(&vllist->ref);
 	return vllist;
 }
 
@@ -1507,6 +1508,7 @@ extern struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *,
 extern struct afs_volume *afs_create_volume(struct afs_fs_context *);
 extern void afs_activate_volume(struct afs_volume *);
 extern void afs_deactivate_volume(struct afs_volume *);
+bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason);
 extern struct afs_volume *afs_get_volume(struct afs_volume *, enum afs_volume_trace);
 extern void afs_put_volume(struct afs_net *, struct afs_volume *, enum afs_volume_trace);
 extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 065a28bfa3f1..254ccf1d592f 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -47,7 +47,7 @@ static int afs_proc_cells_show(struct seq_file *m, void *v)
 
 	/* display one cell per line on subsequent lines */
 	seq_printf(m, "%3u %3u %6lld %2u %2u %s\n",
-		   atomic_read(&cell->ref),
+		   refcount_read(&cell->ref),
 		   atomic_read(&cell->active),
 		   cell->dns_expiry - ktime_get_real_seconds(),
 		   vllist ? vllist->nr_servers : 0,
@@ -217,7 +217,7 @@ static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
 	}
 
 	seq_printf(m, "%3d %08llx %s %s\n",
-		   atomic_read(&vol->usage), vol->vid,
+		   refcount_read(&vol->ref), vol->vid,
 		   afs_vol_types[vol->type],
 		   vol->name);
 
@@ -388,7 +388,7 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 	alist = rcu_dereference(server->addresses);
 	seq_printf(m, "%pU %3d %3d\n",
 		   &server->uuid,
-		   atomic_read(&server->ref),
+		   refcount_read(&server->ref),
 		   atomic_read(&server->active));
 	seq_printf(m, "  - info: fl=%lx rtt=%u brk=%x\n",
 		   server->flags, server->rtt, server->cb_s_break);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index f7305f2791fe..ea40da937fcd 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -145,7 +145,7 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	call->type = type;
 	call->net = net;
 	call->debug_id = atomic_inc_return(&rxrpc_debug_id);
-	atomic_set(&call->usage, 1);
+	refcount_set(&call->ref, 1);
 	INIT_WORK(&call->async_work, afs_process_async_call);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
@@ -163,14 +163,15 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 void afs_put_call(struct afs_call *call)
 {
 	struct afs_net *net = call->net;
-	int n = atomic_dec_return(&call->usage);
-	int o = atomic_read(&net->nr_outstanding_calls);
+	bool zero;
+	int r, o;
 
-	trace_afs_call(call, afs_call_trace_put, n, o,
+	zero = __refcount_dec_and_test(&call->ref, &r);
+	o = atomic_read(&net->nr_outstanding_calls);
+	trace_afs_call(call, afs_call_trace_put, r - 1, o,
 		       __builtin_return_address(0));
 
-	ASSERTCMP(n, >=, 0);
-	if (n == 0) {
+	if (zero) {
 		ASSERT(!work_pending(&call->async_work));
 		ASSERT(call->type->name != NULL);
 
@@ -198,9 +199,11 @@ void afs_put_call(struct afs_call *call)
 static struct afs_call *afs_get_call(struct afs_call *call,
 				     enum afs_call_trace why)
 {
-	int u = atomic_inc_return(&call->usage);
+	int r;
 
-	trace_afs_call(call, why, u,
+	__refcount_inc(&call->ref, &r);
+
+	trace_afs_call(call, why, r + 1,
 		       atomic_read(&call->net->nr_outstanding_calls),
 		       __builtin_return_address(0));
 	return call;
@@ -663,14 +666,13 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
 				   unsigned long call_user_ID)
 {
 	struct afs_call *call = (struct afs_call *)call_user_ID;
-	int u;
+	int r;
 
 	trace_afs_notify_call(rxcall, call);
 	call->need_attention = true;
 
-	u = atomic_fetch_add_unless(&call->usage, 1, 0);
-	if (u != 0) {
-		trace_afs_call(call, afs_call_trace_wake, u + 1,
+	if (__refcount_inc_not_zero(&call->ref, &r)) {
+		trace_afs_call(call, afs_call_trace_wake, r + 1,
 			       atomic_read(&call->net->nr_outstanding_calls),
 			       __builtin_return_address(0));
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 6e5b9a19b234..ffed828622b6 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -228,7 +228,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	if (!server)
 		goto enomem;
 
-	atomic_set(&server->ref, 1);
+	refcount_set(&server->ref, 1);
 	atomic_set(&server->active, 1);
 	server->debug_id = atomic_inc_return(&afs_server_debug_id);
 	RCU_INIT_POINTER(server->addresses, alist);
@@ -352,9 +352,10 @@ void afs_servers_timer(struct timer_list *timer)
 struct afs_server *afs_get_server(struct afs_server *server,
 				  enum afs_server_trace reason)
 {
-	unsigned int u = atomic_inc_return(&server->ref);
+	int r;
 
-	trace_afs_server(server, u, atomic_read(&server->active), reason);
+	__refcount_inc(&server->ref, &r);
+	trace_afs_server(server, r + 1, atomic_read(&server->active), reason);
 	return server;
 }
 
@@ -364,14 +365,14 @@ struct afs_server *afs_get_server(struct afs_server *server,
 static struct afs_server *afs_maybe_use_server(struct afs_server *server,
 					       enum afs_server_trace reason)
 {
-	unsigned int r = atomic_fetch_add_unless(&server->ref, 1, 0);
 	unsigned int a;
+	int r;
 
-	if (r == 0)
+	if (!__refcount_inc_not_zero(&server->ref, &r))
 		return NULL;
 
 	a = atomic_inc_return(&server->active);
-	trace_afs_server(server, r, a, reason);
+	trace_afs_server(server, r + 1, a, reason);
 	return server;
 }
 
@@ -380,10 +381,13 @@ static struct afs_server *afs_maybe_use_server(struct afs_server *server,
  */
 struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_trace reason)
 {
-	unsigned int r = atomic_inc_return(&server->ref);
-	unsigned int a = atomic_inc_return(&server->active);
+	unsigned int a;
+	int r;
+
+	__refcount_inc(&server->ref, &r);
+	a = atomic_inc_return(&server->active);
 
-	trace_afs_server(server, r, a, reason);
+	trace_afs_server(server, r + 1, a, reason);
 	return server;
 }
 
@@ -393,14 +397,15 @@ struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_tra
 void afs_put_server(struct afs_net *net, struct afs_server *server,
 		    enum afs_server_trace reason)
 {
-	unsigned int usage;
+	bool zero;
+	int r;
 
 	if (!server)
 		return;
 
-	usage = atomic_dec_return(&server->ref);
-	trace_afs_server(server, usage, atomic_read(&server->active), reason);
-	if (unlikely(usage == 0))
+	zero = __refcount_dec_and_test(&server->ref, &r);
+	trace_afs_server(server, r - 1, atomic_read(&server->active), reason);
+	if (unlikely(zero))
 		__afs_put_server(net, server);
 }
 
@@ -436,7 +441,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 {
 	struct afs_server *server = container_of(rcu, struct afs_server, rcu);
 
-	trace_afs_server(server, atomic_read(&server->ref),
+	trace_afs_server(server, refcount_read(&server->ref),
 			 atomic_read(&server->active), afs_server_trace_free);
 	afs_put_addrlist(rcu_access_pointer(server->addresses));
 	kfree(server);
@@ -487,7 +492,7 @@ static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
 
 		active = atomic_read(&server->active);
 		if (active == 0) {
-			trace_afs_server(server, atomic_read(&server->ref),
+			trace_afs_server(server, refcount_read(&server->ref),
 					 active, afs_server_trace_gc);
 			next = rcu_dereference_protected(
 				server->uuid_next, lockdep_is_held(&net->fs_lock.lock));
@@ -553,7 +558,7 @@ void afs_manage_servers(struct work_struct *work)
 		_debug("manage %pU %u", &server->uuid, active);
 
 		if (purging) {
-			trace_afs_server(server, atomic_read(&server->ref),
+			trace_afs_server(server, refcount_read(&server->ref),
 					 active, afs_server_trace_purging);
 			if (active != 0)
 				pr_notice("Can't purge s=%08x\n", server->debug_id);
@@ -633,7 +638,8 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
 
 	_enter("");
 
-	trace_afs_server(server, atomic_read(&server->ref), atomic_read(&server->active),
+	trace_afs_server(server, refcount_read(&server->ref),
+			 atomic_read(&server->active),
 			 afs_server_trace_update);
 
 	alist = afs_vl_lookup_addrs(op->volume->cell, op->key, &server->uuid);
diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index 38b2ba1d9ec0..acc48216136a 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -17,7 +17,7 @@ struct afs_vlserver *afs_alloc_vlserver(const char *name, size_t name_len,
 	vlserver = kzalloc(struct_size(vlserver, name, name_len + 1),
 			   GFP_KERNEL);
 	if (vlserver) {
-		atomic_set(&vlserver->usage, 1);
+		refcount_set(&vlserver->ref, 1);
 		rwlock_init(&vlserver->lock);
 		init_waitqueue_head(&vlserver->probe_wq);
 		spin_lock_init(&vlserver->probe_lock);
@@ -39,13 +39,9 @@ static void afs_vlserver_rcu(struct rcu_head *rcu)
 
 void afs_put_vlserver(struct afs_net *net, struct afs_vlserver *vlserver)
 {
-	if (vlserver) {
-		unsigned int u = atomic_dec_return(&vlserver->usage);
-		//_debug("VL PUT %p{%u}", vlserver, u);
-
-		if (u == 0)
-			call_rcu(&vlserver->rcu, afs_vlserver_rcu);
-	}
+	if (vlserver &&
+	    refcount_dec_and_test(&vlserver->ref))
+		call_rcu(&vlserver->rcu, afs_vlserver_rcu);
 }
 
 struct afs_vlserver_list *afs_alloc_vlserver_list(unsigned int nr_servers)
@@ -54,7 +50,7 @@ struct afs_vlserver_list *afs_alloc_vlserver_list(unsigned int nr_servers)
 
 	vllist = kzalloc(struct_size(vllist, servers, nr_servers), GFP_KERNEL);
 	if (vllist) {
-		atomic_set(&vllist->usage, 1);
+		refcount_set(&vllist->ref, 1);
 		rwlock_init(&vllist->lock);
 	}
 
@@ -64,10 +60,7 @@ struct afs_vlserver_list *afs_alloc_vlserver_list(unsigned int nr_servers)
 void afs_put_vlserverlist(struct afs_net *net, struct afs_vlserver_list *vllist)
 {
 	if (vllist) {
-		unsigned int u = atomic_dec_return(&vllist->usage);
-
-		//_debug("VLLS PUT %p{%u}", vllist, u);
-		if (u == 0) {
+		if (refcount_dec_and_test(&vllist->ref)) {
 			int i;
 
 			for (i = 0; i < vllist->nr_servers; i++) {
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index f84194b791d3..137a970c19fb 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -33,8 +33,13 @@ static struct afs_volume *afs_insert_volume_into_cell(struct afs_cell *cell,
 		} else if (p->vid > volume->vid) {
 			pp = &(*pp)->rb_right;
 		} else {
-			volume = afs_get_volume(p, afs_volume_trace_get_cell_insert);
-			goto found;
+			if (afs_try_get_volume(p, afs_volume_trace_get_cell_insert)) {
+				volume = p;
+				goto found;
+			}
+
+			set_bit(AFS_VOLUME_RM_TREE, &volume->flags);
+			rb_replace_node_rcu(&p->cell_node, &volume->cell_node, &cell->volumes);
 		}
 	}
 
@@ -53,11 +58,12 @@ static void afs_remove_volume_from_cell(struct afs_volume *volume)
 	struct afs_cell *cell = volume->cell;
 
 	if (!hlist_unhashed(&volume->proc_link)) {
-		trace_afs_volume(volume->vid, atomic_read(&volume->usage),
+		trace_afs_volume(volume->vid, refcount_read(&cell->ref),
 				 afs_volume_trace_remove);
 		write_seqlock(&cell->volume_lock);
 		hlist_del_rcu(&volume->proc_link);
-		rb_erase(&volume->cell_node, &cell->volumes);
+		if (!test_and_set_bit(AFS_VOLUME_RM_TREE, &volume->flags))
+			rb_erase(&volume->cell_node, &cell->volumes);
 		write_sequnlock(&cell->volume_lock);
 	}
 }
@@ -88,7 +94,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 	volume->type_force	= params->force;
 	volume->name_len	= vldb->name_len;
 
-	atomic_set(&volume->usage, 1);
+	refcount_set(&volume->ref, 1);
 	INIT_HLIST_NODE(&volume->proc_link);
 	rwlock_init(&volume->servers_lock);
 	rwlock_init(&volume->cb_v_break_lock);
@@ -229,13 +235,27 @@ static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
 	afs_remove_volume_from_cell(volume);
 	afs_put_serverlist(net, rcu_access_pointer(volume->servers));
 	afs_put_cell(volume->cell, afs_cell_trace_put_vol);
-	trace_afs_volume(volume->vid, atomic_read(&volume->usage),
+	trace_afs_volume(volume->vid, refcount_read(&volume->ref),
 			 afs_volume_trace_free);
 	kfree_rcu(volume, rcu);
 
 	_leave(" [destroyed]");
 }
 
+/*
+ * Try to get a reference on a volume record.
+ */
+bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason)
+{
+	int r;
+
+	if (__refcount_inc_not_zero(&volume->ref, &r)) {
+		trace_afs_volume(volume->vid, r + 1, reason);
+		return true;
+	}
+	return false;
+}
+
 /*
  * Get a reference on a volume record.
  */
@@ -243,8 +263,10 @@ struct afs_volume *afs_get_volume(struct afs_volume *volume,
 				  enum afs_volume_trace reason)
 {
 	if (volume) {
-		int u = atomic_inc_return(&volume->usage);
-		trace_afs_volume(volume->vid, u, reason);
+		int r;
+
+		__refcount_inc(&volume->ref, &r);
+		trace_afs_volume(volume->vid, r + 1, reason);
 	}
 	return volume;
 }
@@ -258,9 +280,12 @@ void afs_put_volume(struct afs_net *net, struct afs_volume *volume,
 {
 	if (volume) {
 		afs_volid_t vid = volume->vid;
-		int u = atomic_dec_return(&volume->usage);
-		trace_afs_volume(vid, u, reason);
-		if (u == 0)
+		bool zero;
+		int r;
+
+		zero = __refcount_dec_and_test(&volume->ref, &r);
+		trace_afs_volume(vid, r - 1, reason);
+		if (zero)
 			afs_destroy_volume(net, volume);
 	}
 }
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 5e4dab5dfb7a..33328eae03d7 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -340,6 +340,10 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
 			cifs_dbg(VFS, "Length less than smb header size\n");
 		}
 		return -EIO;
+	} else if (total_read < sizeof(*smb) + 2 * smb->WordCount) {
+		cifs_dbg(VFS, "%s: can't read BCC due to invalid WordCount(%u)\n",
+			 __func__, smb->WordCount);
+		return -EIO;
 	}
 
 	/* otherwise, there is enough to get to the BCC */
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 29b5554f6263..e2f401c8c5ce 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -298,6 +298,9 @@ static const bool has_smb2_data_area[NUMBER_OF_SMB2_COMMANDS] = {
 char *
 smb2_get_data_area_len(int *off, int *len, struct smb2_sync_hdr *shdr)
 {
+	const int max_off = 4096;
+	const int max_len = 128 * 1024;
+
 	*off = 0;
 	*len = 0;
 
@@ -369,29 +372,20 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_sync_hdr *shdr)
 	 * Invalid length or offset probably means data area is invalid, but
 	 * we have little choice but to ignore the data area in this case.
 	 */
-	if (*off > 4096) {
-		cifs_dbg(VFS, "offset %d too large, data area ignored\n", *off);
-		*len = 0;
-		*off = 0;
-	} else if (*off < 0) {
-		cifs_dbg(VFS, "negative offset %d to data invalid ignore data area\n",
-			 *off);
+	if (unlikely(*off < 0 || *off > max_off ||
+		     *len < 0 || *len > max_len)) {
+		cifs_dbg(VFS, "%s: invalid data area (off=%d len=%d)\n",
+			 __func__, *off, *len);
 		*off = 0;
 		*len = 0;
-	} else if (*len < 0) {
-		cifs_dbg(VFS, "negative data length %d invalid, data area ignored\n",
-			 *len);
-		*len = 0;
-	} else if (*len > 128 * 1024) {
-		cifs_dbg(VFS, "data area larger than 128K: %d\n", *len);
+	} else if (*off == 0) {
 		*len = 0;
 	}
 
 	/* return pointer to beginning of data area, ie offset from SMB start */
-	if ((*off != 0) && (*len != 0))
+	if (*off > 0 && *len > 0)
 		return (char *)shdr + *off;
-	else
-		return NULL;
+	return NULL;
 }
 
 /*
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 7c2ecbb17f54..f31da2647d04 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3263,7 +3263,7 @@ smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
 	struct kvec close_iov[1];
 	struct smb2_ioctl_rsp *ioctl_rsp;
 	struct reparse_data_buffer *reparse_buf;
-	u32 plen;
+	u32 off, count, len;
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, full_path);
 
@@ -3343,16 +3343,22 @@ smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
 	 */
 	if (rc == 0) {
 		/* See MS-FSCC 2.3.23 */
+		off = le32_to_cpu(ioctl_rsp->OutputOffset);
+		count = le32_to_cpu(ioctl_rsp->OutputCount);
+		if (check_add_overflow(off, count, &len) ||
+		    len > rsp_iov[1].iov_len) {
+			cifs_tcon_dbg(VFS, "%s: invalid ioctl: off=%d count=%d\n",
+				      __func__, off, count);
+			rc = -EIO;
+			goto query_rp_exit;
+		}
 
-		reparse_buf = (struct reparse_data_buffer *)
-			((char *)ioctl_rsp +
-			 le32_to_cpu(ioctl_rsp->OutputOffset));
-		plen = le32_to_cpu(ioctl_rsp->OutputCount);
-
-		if (plen + le32_to_cpu(ioctl_rsp->OutputOffset) >
-		    rsp_iov[1].iov_len) {
-			cifs_tcon_dbg(FYI, "srv returned invalid ioctl len: %d\n",
-				 plen);
+		reparse_buf = (void *)((u8 *)ioctl_rsp + off);
+		len = sizeof(*reparse_buf);
+		if (count < len ||
+		    count < le16_to_cpu(reparse_buf->ReparseDataLength) + len) {
+			cifs_tcon_dbg(VFS, "%s: invalid ioctl: off=%d count=%d\n",
+				      __func__, off, count);
 			rc = -EIO;
 			goto query_rp_exit;
 		}
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index f51fea2e808d..6714e9db0ee8 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -364,10 +364,15 @@ static int __smb2_plain_req_init(__le16 smb2_command, struct cifs_tcon *tcon,
 				 void **request_buf, unsigned int *total_len)
 {
 	/* BB eventually switch this to SMB2 specific small buf size */
-	if (smb2_command == SMB2_SET_INFO)
+	switch (smb2_command) {
+	case SMB2_SET_INFO:
+	case SMB2_QUERY_INFO:
 		*request_buf = cifs_buf_get();
-	else
+		break;
+	default:
 		*request_buf = cifs_small_buf_get();
+		break;
+	}
 	if (*request_buf == NULL) {
 		/* BB should we add a retry in here if not a writepage? */
 		return -ENOMEM;
@@ -3415,8 +3420,13 @@ SMB2_query_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	struct smb2_query_info_req *req;
 	struct kvec *iov = rqst->rq_iov;
 	unsigned int total_len;
+	size_t len;
 	int rc;
 
+	if (unlikely(check_add_overflow(input_len, sizeof(*req), &len) ||
+		     len > CIFSMaxBufSize))
+		return -EINVAL;
+
 	rc = smb2_plain_req_init(SMB2_QUERY_INFO, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
@@ -3438,7 +3448,7 @@ SMB2_query_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 
 	iov[0].iov_base = (char *)req;
 	/* 1 for Buffer */
-	iov[0].iov_len = total_len - 1 + input_len;
+	iov[0].iov_len = len;
 	return 0;
 }
 
@@ -3446,7 +3456,7 @@ void
 SMB2_query_info_free(struct smb_rqst *rqst)
 {
 	if (rqst && rqst->rq_iov)
-		cifs_small_buf_release(rqst->rq_iov[0].iov_base); /* request */
+		cifs_buf_release(rqst->rq_iov[0].iov_base); /* request */
 }
 
 static int
@@ -5176,6 +5186,11 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon,
 	return 0;
 }
 
+static inline void free_qfs_info_req(struct kvec *iov)
+{
+	cifs_buf_release(iov->iov_base);
+}
+
 int
 SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon *tcon,
 	      u64 persistent_fid, u64 volatile_fid, struct kstatfs *fsdata)
@@ -5207,7 +5222,7 @@ SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(iov.iov_base);
+	free_qfs_info_req(&iov);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
 		goto posix_qfsinf_exit;
@@ -5258,7 +5273,7 @@ SMB2_QFS_info(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(iov.iov_base);
+	free_qfs_info_req(&iov);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
 		goto qfsinf_exit;
@@ -5325,7 +5340,7 @@ SMB2_QFS_attr(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(iov.iov_base);
+	free_qfs_info_req(&iov);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
 		goto qfsattr_exit;
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index f32c99c9ba13..301c155c5267 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -779,7 +779,7 @@ struct smb2_tree_disconnect_rsp {
 #define SMB2_CREATE_SD_BUFFER			"SecD" /* security descriptor */
 #define SMB2_CREATE_DURABLE_HANDLE_REQUEST	"DHnQ"
 #define SMB2_CREATE_DURABLE_HANDLE_RECONNECT	"DHnC"
-#define SMB2_CREATE_ALLOCATION_SIZE		"AISi"
+#define SMB2_CREATE_ALLOCATION_SIZE		"AlSi"
 #define SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
 #define SMB2_CREATE_TIMEWARP_REQUEST		"TWrp"
 #define SMB2_CREATE_QUERY_ON_DISK_ID		"QFid"
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c3a87586a15f..4b8f094345e1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,19 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/* Submount lookup tracking */
+struct fuse_submount_lookup {
+	/** Refcount */
+	refcount_t count;
+
+	/** Unique ID, which identifies the inode between userspace
+	 * and kernel */
+	u64 nodeid;
+
+	/** The request used for sending the FORGET message */
+	struct fuse_forget_link *forget;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -155,6 +168,8 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+	/** Submount specific lookup tracking */
+	struct fuse_submount_lookup *submount_lookup;
 };
 
 /** FUSE inode state bits */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 50365143f50e..97dc24557bf2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -69,6 +69,24 @@ struct fuse_forget_link *fuse_alloc_forget(void)
 	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL_ACCOUNT);
 }
 
+static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
+{
+	struct fuse_submount_lookup *sl;
+
+	sl = kzalloc(sizeof(struct fuse_submount_lookup), GFP_KERNEL_ACCOUNT);
+	if (!sl)
+		return NULL;
+	sl->forget = fuse_alloc_forget();
+	if (!sl->forget)
+		goto out_free;
+
+	return sl;
+
+out_free:
+	kfree(sl);
+	return NULL;
+}
+
 static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
 	struct fuse_inode *fi;
@@ -84,6 +102,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->attr_version = 0;
 	fi->orig_ino = 0;
 	fi->state = 0;
+	fi->submount_lookup = NULL;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
@@ -114,6 +133,17 @@ static void fuse_free_inode(struct inode *inode)
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
+static void fuse_cleanup_submount_lookup(struct fuse_conn *fc,
+					 struct fuse_submount_lookup *sl)
+{
+	if (!refcount_dec_and_test(&sl->count))
+		return;
+
+	fuse_queue_forget(fc, sl->forget, sl->nodeid, 1);
+	sl->forget = NULL;
+	kfree(sl);
+}
+
 static void fuse_evict_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -133,6 +163,11 @@ static void fuse_evict_inode(struct inode *inode)
 					  fi->nlookup);
 			fi->forget = NULL;
 		}
+
+		if (fi->submount_lookup) {
+			fuse_cleanup_submount_lookup(fc, fi->submount_lookup);
+			fi->submount_lookup = NULL;
+		}
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
 		WARN_ON(!list_empty(&fi->write_files));
@@ -279,6 +314,13 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	}
 }
 
+static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
+				      u64 nodeid)
+{
+	sl->nodeid = nodeid;
+	refcount_set(&sl->count, 1);
+}
+
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	inode->i_mode = attr->mode & S_IFMT;
@@ -336,12 +378,22 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	 */
 	if (fc->auto_submounts && (attr->flags & FUSE_ATTR_SUBMOUNT) &&
 	    S_ISDIR(attr->mode)) {
+		struct fuse_inode *fi;
+
 		inode = new_inode(sb);
 		if (!inode)
 			return NULL;
 
 		fuse_init_inode(inode, attr);
-		get_fuse_inode(inode)->nodeid = nodeid;
+		fi = get_fuse_inode(inode);
+		fi->nodeid = nodeid;
+		fi->submount_lookup = fuse_alloc_submount_lookup();
+		if (!fi->submount_lookup) {
+			iput(inode);
+			return NULL;
+		}
+		/* Sets nlookup = 1 on fi->submount_lookup->nlookup */
+		fuse_init_submount_lookup(fi->submount_lookup, nodeid);
 		inode->i_flags |= S_AUTOMOUNT;
 		goto done;
 	}
@@ -364,11 +416,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		iput(inode);
 		goto retry;
 	}
-done:
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->nlookup++;
 	spin_unlock(&fi->lock);
+done:
 	fuse_change_attributes(inode, attr, attr_valid, attr_version);
 
 	return inode;
@@ -1380,6 +1432,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	struct super_block *parent_sb = parent_fi->inode.i_sb;
 	struct fuse_attr root_attr;
 	struct inode *root;
+	struct fuse_submount_lookup *sl;
+	struct fuse_inode *fi;
 
 	fuse_sb_defaults(sb);
 	fm->sb = sb;
@@ -1402,12 +1456,27 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	 * its nlookup should not be incremented.  fuse_iget() does
 	 * that, though, so undo it here.
 	 */
-	get_fuse_inode(root)->nlookup--;
+	fi = get_fuse_inode(root);
+	fi->nlookup--;
+
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root)
 		return -ENOMEM;
 
+	/*
+	 * Grab the parent's submount_lookup pointer and take a
+	 * reference on the shared nlookup from the parent.  This is to
+	 * prevent the last forget for this nodeid from getting
+	 * triggered until all users have finished with it.
+	 */
+	sl = parent_fi->submount_lookup;
+	WARN_ON(!sl);
+	if (sl) {
+		refcount_inc(&sl->count);
+		fi->submount_lookup = sl;
+	}
+
 	return 0;
 }
 
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 1cf2d2a3746a..2da256259722 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -102,9 +102,10 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 	lease->new_state = 0;
 	lease->flags = lctx->flags;
 	lease->duration = lctx->duration;
+	lease->is_dir = lctx->is_dir;
 	memcpy(lease->parent_lease_key, lctx->parent_lease_key, SMB2_LEASE_KEY_SIZE);
 	lease->version = lctx->version;
-	lease->epoch = 0;
+	lease->epoch = le16_to_cpu(lctx->epoch);
 	INIT_LIST_HEAD(&opinfo->lease_entry);
 	opinfo->o_lease = lease;
 
@@ -395,8 +396,8 @@ void close_id_del_oplock(struct ksmbd_file *fp)
 {
 	struct oplock_info *opinfo;
 
-	if (S_ISDIR(file_inode(fp->filp)->i_mode))
-		return;
+	if (fp->reserve_lease_break)
+		smb_lazy_parent_lease_break_close(fp);
 
 	opinfo = opinfo_get(fp);
 	if (!opinfo)
@@ -543,12 +544,13 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 			/* upgrading lease */
 			if ((atomic_read(&ci->op_count) +
 			     atomic_read(&ci->sop_count)) == 1) {
-				if (lease->state ==
-				    (lctx->req_state & lease->state)) {
+				if (lease->state != SMB2_LEASE_NONE_LE &&
+				    lease->state == (lctx->req_state & lease->state)) {
 					lease->state |= lctx->req_state;
 					if (lctx->req_state &
 						SMB2_LEASE_WRITE_CACHING_LE)
 						lease_read_to_write(opinfo);
+
 				}
 			} else if ((atomic_read(&ci->op_count) +
 				    atomic_read(&ci->sop_count)) > 1) {
@@ -900,7 +902,8 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
 					lease->new_state =
 						SMB2_LEASE_READ_CACHING_LE;
 			} else {
-				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE &&
+						!lease->is_dir)
 					lease->new_state =
 						SMB2_LEASE_READ_CACHING_LE;
 				else
@@ -1032,6 +1035,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	       SMB2_LEASE_KEY_SIZE);
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
+	lease2->epoch = lease1->epoch++;
 }
 
 static int add_lease_global_list(struct oplock_info *opinfo)
@@ -1081,6 +1085,89 @@ static void set_oplock_level(struct oplock_info *opinfo, int level,
 	}
 }
 
+void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
+				      struct lease_ctx_info *lctx)
+{
+	struct oplock_info *opinfo;
+	struct ksmbd_inode *p_ci = NULL;
+
+	if (lctx->version != 2)
+		return;
+
+	p_ci = ksmbd_inode_lookup_lock(fp->filp->f_path.dentry->d_parent);
+	if (!p_ci)
+		return;
+
+	read_lock(&p_ci->m_lock);
+	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
+		if (!opinfo->is_lease)
+			continue;
+
+		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE &&
+		    (!(lctx->flags & SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE) ||
+		     !compare_guid_key(opinfo, fp->conn->ClientGUID,
+				      lctx->parent_lease_key))) {
+			if (!atomic_inc_not_zero(&opinfo->refcount))
+				continue;
+
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				continue;
+			}
+
+			read_unlock(&p_ci->m_lock);
+			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
+			opinfo_conn_put(opinfo);
+			read_lock(&p_ci->m_lock);
+		}
+	}
+	read_unlock(&p_ci->m_lock);
+
+	ksmbd_inode_put(p_ci);
+}
+
+void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo;
+	struct ksmbd_inode *p_ci = NULL;
+
+	rcu_read_lock();
+	opinfo = rcu_dereference(fp->f_opinfo);
+	rcu_read_unlock();
+
+	if (!opinfo->is_lease || opinfo->o_lease->version != 2)
+		return;
+
+	p_ci = ksmbd_inode_lookup_lock(fp->filp->f_path.dentry->d_parent);
+	if (!p_ci)
+		return;
+
+	read_lock(&p_ci->m_lock);
+	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
+		if (!opinfo->is_lease)
+			continue;
+
+		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE) {
+			if (!atomic_inc_not_zero(&opinfo->refcount))
+				continue;
+
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				continue;
+			}
+			read_unlock(&p_ci->m_lock);
+			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
+			opinfo_conn_put(opinfo);
+			read_lock(&p_ci->m_lock);
+		}
+	}
+	read_unlock(&p_ci->m_lock);
+
+	ksmbd_inode_put(p_ci);
+}
+
 /**
  * smb_grant_oplock() - handle oplock/lease request on file open
  * @work:		smb work
@@ -1104,10 +1191,6 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	bool prev_op_has_lease;
 	__le32 prev_op_state = 0;
 
-	/* not support directory lease */
-	if (S_ISDIR(file_inode(fp->filp)->i_mode))
-		return 0;
-
 	opinfo = alloc_opinfo(work, pid, tid);
 	if (!opinfo)
 		return -ENOMEM;
@@ -1364,6 +1447,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		memcpy(buf->lcontext.LeaseKey, lease->lease_key,
 		       SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
+		buf->lcontext.Epoch = cpu_to_le16(++lease->epoch);
 		buf->lcontext.LeaseState = lease->state;
 		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
 		       SMB2_LEASE_KEY_SIZE);
@@ -1400,10 +1484,11 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 /**
  * parse_lease_state() - parse lease context containted in file open request
  * @open_req:	buffer containing smb2 file open(create) request
+ * @is_dir:	whether leasing file is directory
  *
  * Return:  oplock state, -ENOENT if create lease context not found
  */
-struct lease_ctx_info *parse_lease_state(void *open_req)
+struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 {
 	struct create_context *cc;
 	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
@@ -1421,8 +1506,14 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-		lreq->req_state = lc->lcontext.LeaseState;
+		if (is_dir) {
+			lreq->req_state = lc->lcontext.LeaseState &
+				~SMB2_LEASE_WRITE_CACHING_LE;
+			lreq->is_dir = true;
+		} else
+			lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->epoch = lc->lcontext.Epoch;
 		lreq->duration = lc->lcontext.LeaseDuration;
 		memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
 				SMB2_LEASE_KEY_SIZE);
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index 4b0fe6da7694..5b93ea9196c0 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -34,7 +34,9 @@ struct lease_ctx_info {
 	__le32			flags;
 	__le64			duration;
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
+	__le16			epoch;
 	int			version;
+	bool			is_dir;
 };
 
 struct lease_table {
@@ -53,6 +55,7 @@ struct lease {
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
 	int			version;
 	unsigned short		epoch;
+	bool			is_dir;
 	struct lease_table	*l_lb;
 };
 
@@ -108,7 +111,7 @@ void opinfo_put(struct oplock_info *opinfo);
 
 /* Lease related functions */
 void create_lease_buf(u8 *rbuf, struct lease *lease);
-struct lease_ctx_info *parse_lease_state(void *open_req);
+struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir);
 __u8 smb2_map_lease_to_oplock(__le32 lease_state);
 int lease_read_to_write(struct oplock_info *opinfo);
 
@@ -124,4 +127,7 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 			struct lease_ctx_info *lctx);
 void destroy_lease_table(struct ksmbd_conn *conn);
+void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
+				      struct lease_ctx_info *lctx);
+void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index 39e523f115d2..4d1211bde190 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -107,16 +107,25 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	case SMB2_CREATE:
 	{
+		unsigned short int name_off =
+			le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
+		unsigned short int name_len =
+			le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
+
 		if (((struct smb2_create_req *)hdr)->CreateContextsLength) {
 			*off = le32_to_cpu(((struct smb2_create_req *)
 				hdr)->CreateContextsOffset);
 			*len = le32_to_cpu(((struct smb2_create_req *)
 				hdr)->CreateContextsLength);
-			break;
+			if (!name_len)
+				break;
+
+			if (name_off + name_len < (u64)*off + *len)
+				break;
 		}
 
-		*off = le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
-		*len = le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
+		*off = name_off;
+		*len = name_len;
 		break;
 	}
 	case SMB2_QUERY_INFO:
diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
index 9138e1c29b22..c69943d96565 100644
--- a/fs/ksmbd/smb2ops.c
+++ b/fs/ksmbd/smb2ops.c
@@ -222,7 +222,8 @@ void init_smb3_0_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
 	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
@@ -246,7 +247,8 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
@@ -271,7 +273,8 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 7ce5746f9167..8875c04e8382 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2516,7 +2516,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da, false);
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da, true);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
 }
@@ -2729,10 +2729,6 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
-	req_op_level = req->RequestedOplockLevel;
-	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
-		lc = parse_lease_state(req);
-
 	if (le32_to_cpu(req->ImpersonationLevel) > le32_to_cpu(IL_DELEGATE_LE)) {
 		pr_err("Invalid impersonationlevel : 0x%x\n",
 		       le32_to_cpu(req->ImpersonationLevel));
@@ -3186,23 +3182,6 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out;
 	}
 
-	rc = ksmbd_vfs_getattr(&path, &stat);
-	if (rc)
-		goto err_out;
-
-	if (stat.result_mask & STATX_BTIME)
-		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
-	else
-		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
-	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
-		fp->f_ci->m_fattr =
-			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
-
-	if (!created)
-		smb2_update_xattrs(tcon, &path, fp);
-	else
-		smb2_new_xattrs(tcon, &path, fp);
-
 	if (file_present || created)
 		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 
@@ -3212,6 +3191,10 @@ int smb2_open(struct ksmbd_work *work)
 		need_truncate = 1;
 	}
 
+	req_op_level = req->RequestedOplockLevel;
+	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
+		lc = parse_lease_state(req, S_ISDIR(file_inode(filp)->i_mode));
+
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
 	    (req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
@@ -3222,6 +3205,13 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	} else {
 		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+			/*
+			 * Compare parent lease using parent key. If there is no
+			 * a lease that has same parent key, Send lease break
+			 * notification.
+			 */
+			smb_send_parent_lease_break_noti(fp, lc);
+
 			req_op_level = smb2_map_lease_to_oplock(lc->req_state);
 			ksmbd_debug(SMB,
 				    "lease req for(%s) req oplock state 0x%x, lease state 0x%x\n",
@@ -3292,6 +3282,23 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
+	rc = ksmbd_vfs_getattr(&path, &stat);
+	if (rc)
+		goto err_out1;
+
+	if (stat.result_mask & STATX_BTIME)
+		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
+	else
+		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
+	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
+		fp->f_ci->m_fattr =
+			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
+
+	if (!created)
+		smb2_update_xattrs(tcon, &path, fp);
+	else
+		smb2_new_xattrs(tcon, &path, fp);
+
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
 	rsp->StructureSize = cpu_to_le16(89);
@@ -8214,6 +8221,11 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 			    le32_to_cpu(req->LeaseState));
 	}
 
+	if (ret < 0) {
+		rsp->hdr.Status = err;
+		goto err_out;
+	}
+
 	lease_state = lease->state;
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
@@ -8221,11 +8233,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	wake_up_interruptible_all(&opinfo->oplock_brk);
 	opinfo_put(opinfo);
 
-	if (ret < 0) {
-		rsp->hdr.Status = err;
-		goto err_out;
-	}
-
 	rsp->StructureSize = cpu_to_le16(36);
 	rsp->Reserved = 0;
 	rsp->Flags = 0;
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index e1d0849ee68f..912bd94257ec 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -737,6 +737,7 @@ struct create_posix_rsp {
 #define SMB2_LEASE_WRITE_CACHING_LE		cpu_to_le32(0x04)
 
 #define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE	cpu_to_le32(0x02)
+#define SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE	cpu_to_le32(0x04)
 
 #define SMB2_LEASE_KEY_SIZE			16
 
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index a89529b21c86..173a488bfeee 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -517,6 +517,9 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		}
 	}
 
+	/* Reserve lease break for parent dir at closing time */
+	fp->reserve_lease_break = true;
+
 	/* Do we need to break any of a levelII oplock? */
 	smb_break_all_levII_oplock(work, fp, 1);
 
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 774a387fccce..2528ce8aeebb 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -86,6 +86,17 @@ static struct ksmbd_inode *ksmbd_inode_lookup(struct ksmbd_file *fp)
 	return __ksmbd_inode_lookup(fp->filp->f_path.dentry);
 }
 
+struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d)
+{
+	struct ksmbd_inode *ci;
+
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(d);
+	read_unlock(&inode_hash_lock);
+
+	return ci;
+}
+
 int ksmbd_query_inode_status(struct dentry *dentry)
 {
 	struct ksmbd_inode *ci;
@@ -198,7 +209,7 @@ static void ksmbd_inode_free(struct ksmbd_inode *ci)
 	kfree(ci);
 }
 
-static void ksmbd_inode_put(struct ksmbd_inode *ci)
+void ksmbd_inode_put(struct ksmbd_inode *ci)
 {
 	if (atomic_dec_and_test(&ci->m_count))
 		ksmbd_inode_free(ci);
diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
index 8325cf4527c4..a528f0cc775a 100644
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -105,6 +105,7 @@ struct ksmbd_file {
 	struct ksmbd_readdir_data	readdir_data;
 	int				dot_dotdot[2];
 	unsigned int			f_state;
+	bool				reserve_lease_break;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -138,6 +139,8 @@ struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 					u64 pid);
 void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
+struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d);
+void ksmbd_inode_put(struct ksmbd_inode *ci);
 struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
 struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9ab087d73ab3..00c615fc8ec3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2280,6 +2280,9 @@ enum bpf_text_poke_type {
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
+void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
+			       struct bpf_prog *new, struct bpf_prog *old);
+
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 7d985a1dfe4a..5caf3ce82373 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -73,6 +73,7 @@ struct key_type {
 
 	unsigned int flags;
 #define KEY_TYPE_NET_DOMAIN	0x00000001 /* Keys of this type have a net namespace domain */
+#define KEY_TYPE_INSTANT_REAP	0x00000002 /* Keys of this type don't have a delay after expiring */
 
 	/* vet a description */
 	int (*vet_description)(const char *description);
diff --git a/include/linux/property.h b/include/linux/property.h
index 357513a977e5..fe2092e39aed 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -31,7 +31,12 @@ enum dev_dma_attr {
 	DEV_DMA_COHERENT,
 };
 
-struct fwnode_handle *dev_fwnode(struct device *dev);
+const struct fwnode_handle *__dev_fwnode_const(const struct device *dev);
+struct fwnode_handle *__dev_fwnode(struct device *dev);
+#define dev_fwnode(dev)							\
+	_Generic((dev),							\
+		 const struct device *: __dev_fwnode_const,	\
+		 struct device *: __dev_fwnode)(dev)
 
 bool device_property_present(struct device *dev, const char *propname);
 int device_property_read_u8_array(struct device *dev, const char *propname,
@@ -385,7 +390,7 @@ bool device_dma_supported(struct device *dev);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
 
-const void *device_get_match_data(struct device *dev);
+const void *device_get_match_data(const struct device *dev);
 
 int device_get_phy_mode(struct device *dev);
 
diff --git a/include/linux/qed/qed_eth_if.h b/include/linux/qed/qed_eth_if.h
index 4df0bf0a0864..e1bf3219b4e6 100644
--- a/include/linux/qed/qed_eth_if.h
+++ b/include/linux/qed/qed_eth_if.h
@@ -331,7 +331,7 @@ struct qed_eth_ops {
 	int (*configure_arfs_searcher)(struct qed_dev *cdev,
 				       enum qed_filter_config_mode mode);
 	int (*get_coalesce)(struct qed_dev *cdev, u16 *coal, void *handle);
-	int (*req_bulletin_update_mac)(struct qed_dev *cdev, u8 *mac);
+	int (*req_bulletin_update_mac)(struct qed_dev *cdev, const u8 *mac);
 };
 
 const struct qed_eth_ops *qed_get_eth_ops(void);
diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
index f39451aaaeec..905de11cc209 100644
--- a/include/linux/qed/qed_if.h
+++ b/include/linux/qed/qed_if.h
@@ -1111,7 +1111,7 @@ struct qed_common_ops {
  *
  * Return: Int.
  */
-	int (*update_mac)(struct qed_dev *cdev, u8 *mac);
+	int (*update_mac)(struct qed_dev *cdev, const u8 *mac);
 
 /**
  * update_mtu(): API to inform the change in the mtu.
diff --git a/include/linux/qed/qed_rdma_if.h b/include/linux/qed/qed_rdma_if.h
index aeb242cefebf..3b76c07fbcf8 100644
--- a/include/linux/qed/qed_rdma_if.h
+++ b/include/linux/qed/qed_rdma_if.h
@@ -662,7 +662,8 @@ struct qed_rdma_ops {
 			     u8 connection_handle,
 			     struct qed_ll2_stats *p_stats);
 	int (*ll2_set_mac_filter)(struct qed_dev *cdev,
-				  u8 *old_mac_address, u8 *new_mac_address);
+				  u8 *old_mac_address,
+				  const u8 *new_mac_address);
 
 	int (*iwarp_set_engine_affin)(struct qed_dev *cdev, bool b_reset);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6b0b686f6f90..9ab3dab9568a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1499,6 +1499,9 @@ extern void spi_unregister_device(struct spi_device *spi);
 extern const struct spi_device_id *
 spi_get_device_id(const struct spi_device *sdev);
 
+extern const void *
+spi_get_device_match_data(const struct spi_device *sdev);
+
 static inline bool
 spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1f718e91509f..9a21ccbb5b5c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -176,6 +176,7 @@ struct blocked_key {
 struct smp_csrk {
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
+	u8 link_type;
 	u8 type;
 	u8 val[16];
 };
@@ -185,6 +186,7 @@ struct smp_ltk {
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
+	u8 link_type;
 	u8 authenticated;
 	u8 type;
 	u8 enc_size;
@@ -199,6 +201,7 @@ struct smp_irk {
 	bdaddr_t rpa;
 	bdaddr_t bdaddr;
 	u8 addr_type;
+	u8 link_type;
 	u8 val[16];
 };
 
@@ -206,6 +209,8 @@ struct link_key {
 	struct list_head list;
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
+	u8 bdaddr_type;
+	u8 link_type;
 	u8 type;
 	u8 val[HCI_LINK_KEY_SIZE];
 	u8 pin_len;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index bca73e8c8cde..5556c5da117f 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -728,14 +728,14 @@ TRACE_EVENT(afs_cb_call,
 
 TRACE_EVENT(afs_call,
 	    TP_PROTO(struct afs_call *call, enum afs_call_trace op,
-		     int usage, int outstanding, const void *where),
+		     int ref, int outstanding, const void *where),
 
-	    TP_ARGS(call, op, usage, outstanding, where),
+	    TP_ARGS(call, op, ref, outstanding, where),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call		)
 		    __field(int,			op		)
-		    __field(int,			usage		)
+		    __field(int,			ref		)
 		    __field(int,			outstanding	)
 		    __field(const void *,		where		)
 			     ),
@@ -743,15 +743,15 @@ TRACE_EVENT(afs_call,
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
 		    __entry->op = op;
-		    __entry->usage = usage;
+		    __entry->ref = ref;
 		    __entry->outstanding = outstanding;
 		    __entry->where = where;
 			   ),
 
-	    TP_printk("c=%08x %s u=%d o=%d sp=%pSR",
+	    TP_printk("c=%08x %s r=%d o=%d sp=%pSR",
 		      __entry->call,
 		      __print_symbolic(__entry->op, afs_call_traces),
-		      __entry->usage,
+		      __entry->ref,
 		      __entry->outstanding,
 		      __entry->where)
 	    );
@@ -1475,36 +1475,36 @@ TRACE_EVENT(afs_volume,
 		    __entry->reason = reason;
 			   ),
 
-	    TP_printk("V=%llx %s u=%d",
+	    TP_printk("V=%llx %s ur=%d",
 		      __entry->vid,
 		      __print_symbolic(__entry->reason, afs_volume_traces),
 		      __entry->ref)
 	    );
 
 TRACE_EVENT(afs_cell,
-	    TP_PROTO(unsigned int cell_debug_id, int usage, int active,
+	    TP_PROTO(unsigned int cell_debug_id, int ref, int active,
 		     enum afs_cell_trace reason),
 
-	    TP_ARGS(cell_debug_id, usage, active, reason),
+	    TP_ARGS(cell_debug_id, ref, active, reason),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		cell		)
-		    __field(int,			usage		)
+		    __field(int,			ref		)
 		    __field(int,			active		)
 		    __field(int,			reason		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->cell = cell_debug_id;
-		    __entry->usage = usage;
+		    __entry->ref = ref;
 		    __entry->active = active;
 		    __entry->reason = reason;
 			   ),
 
-	    TP_printk("L=%08x %s u=%d a=%d",
+	    TP_printk("L=%08x %s r=%d a=%d",
 		      __entry->cell,
 		      __print_symbolic(__entry->reason, afs_cell_traces),
-		      __entry->usage,
+		      __entry->ref,
 		      __entry->active)
 	    );
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 88014cd31b28..23ffb8f0b5d7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -957,11 +957,16 @@ static void prog_array_map_poke_untrack(struct bpf_map *map,
 	mutex_unlock(&aux->poke_mutex);
 }
 
+void __weak bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
+				      struct bpf_prog *new, struct bpf_prog *old)
+{
+	WARN_ON_ONCE(1);
+}
+
 static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 				    struct bpf_prog *old,
 				    struct bpf_prog *new)
 {
-	u8 *old_addr, *new_addr, *old_bypass_addr;
 	struct prog_poke_elem *elem;
 	struct bpf_array_aux *aux;
 
@@ -970,7 +975,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 
 	list_for_each_entry(elem, &aux->poke_progs, list) {
 		struct bpf_jit_poke_descriptor *poke;
-		int i, ret;
+		int i;
 
 		for (i = 0; i < elem->aux->size_poke_tab; i++) {
 			poke = &elem->aux->poke_tab[i];
@@ -989,21 +994,10 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 			 *    activated, so tail call updates can arrive from here
 			 *    while JIT is still finishing its final fixup for
 			 *    non-activated poke entries.
-			 * 3) On program teardown, the program's kallsym entry gets
-			 *    removed out of RCU callback, but we can only untrack
-			 *    from sleepable context, therefore bpf_arch_text_poke()
-			 *    might not see that this is in BPF text section and
-			 *    bails out with -EINVAL. As these are unreachable since
-			 *    RCU grace period already passed, we simply skip them.
-			 * 4) Also programs reaching refcount of zero while patching
+			 * 3) Also programs reaching refcount of zero while patching
 			 *    is in progress is okay since we're protected under
 			 *    poke_mutex and untrack the programs before the JIT
-			 *    buffer is freed. When we're still in the middle of
-			 *    patching and suddenly kallsyms entry of the program
-			 *    gets evicted, we just skip the rest which is fine due
-			 *    to point 3).
-			 * 5) Any other error happening below from bpf_arch_text_poke()
-			 *    is a unexpected bug.
+			 *    buffer is freed.
 			 */
 			if (!READ_ONCE(poke->tailcall_target_stable))
 				continue;
@@ -1013,39 +1007,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 			    poke->tail_call.key != key)
 				continue;
 
-			old_bypass_addr = old ? NULL : poke->bypass_addr;
-			old_addr = old ? (u8 *)old->bpf_func + poke->adj_off : NULL;
-			new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
-
-			if (new) {
-				ret = bpf_arch_text_poke(poke->tailcall_target,
-							 BPF_MOD_JUMP,
-							 old_addr, new_addr);
-				BUG_ON(ret < 0 && ret != -EINVAL);
-				if (!old) {
-					ret = bpf_arch_text_poke(poke->tailcall_bypass,
-								 BPF_MOD_JUMP,
-								 poke->bypass_addr,
-								 NULL);
-					BUG_ON(ret < 0 && ret != -EINVAL);
-				}
-			} else {
-				ret = bpf_arch_text_poke(poke->tailcall_bypass,
-							 BPF_MOD_JUMP,
-							 old_bypass_addr,
-							 poke->bypass_addr);
-				BUG_ON(ret < 0 && ret != -EINVAL);
-				/* let other CPUs finish the execution of program
-				 * so that it will not possible to expose them
-				 * to invalid nop, stack unwind, nop state
-				 */
-				if (!ret)
-					synchronize_rcu();
-				ret = bpf_arch_text_poke(poke->tailcall_target,
-							 BPF_MOD_JUMP,
-							 old_addr, NULL);
-				BUG_ON(ret < 0 && ret != -EINVAL);
-			}
+			bpf_arch_poke_desc_update(poke, new, old);
 		}
 	}
 }
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5fb88b5519dd..65a728b89574 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -691,44 +691,6 @@ rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
 	return ret == expect;
 }
 
-static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
-{
-	unsigned long cnt, top, bottom;
-	unsigned long cnt2, top2, bottom2;
-	u64 val;
-
-	/* Any interruptions in this function should cause a failure */
-	cnt = local_read(&t->cnt);
-
-	/* The cmpxchg always fails if it interrupted an update */
-	 if (!__rb_time_read(t, &val, &cnt2))
-		 return false;
-
-	 if (val != expect)
-		 return false;
-
-	 if ((cnt & 3) != cnt2)
-		 return false;
-
-	 cnt2 = cnt + 1;
-
-	 rb_time_split(val, &top, &bottom);
-	 top = rb_time_val_cnt(top, cnt);
-	 bottom = rb_time_val_cnt(bottom, cnt);
-
-	 rb_time_split(set, &top2, &bottom2);
-	 top2 = rb_time_val_cnt(top2, cnt2);
-	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
-
-	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->top, top, top2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
-		return false;
-	return true;
-}
-
 #else /* 64 bits */
 
 /* local64_t always succeeds */
@@ -742,13 +704,6 @@ static void rb_time_set(rb_time_t *t, u64 val)
 {
 	local64_set(&t->time, val);
 }
-
-static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
-{
-	u64 val;
-	val = local64_cmpxchg(&t->time, expect, set);
-	return val == expect;
-}
 #endif
 
 /*
@@ -897,9 +852,14 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
 	if (!nr_pages || !full)
 		return true;
 
-	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
+	/*
+	 * Add one as dirty will never equal nr_pages, as the sub-buffer
+	 * that the writer is on is not counted as dirty.
+	 * This is needed if "buffer_percent" is set to 100.
+	 */
+	dirty = ring_buffer_nr_dirty_pages(buffer, cpu) + 1;
 
-	return (dirty * 100) > (full * nr_pages);
+	return (dirty * 100) >= (full * nr_pages);
 }
 
 /*
@@ -959,7 +919,8 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 	/* make sure the waiters see the new index */
 	smp_wmb();
 
-	rb_wake_up_waiters(&rbwork->work);
+	/* This can be called in any context */
+	irq_work_queue(&rbwork->work);
 }
 
 /**
@@ -2936,25 +2897,6 @@ static unsigned rb_calculate_event_length(unsigned length)
 	return length;
 }
 
-static u64 rb_time_delta(struct ring_buffer_event *event)
-{
-	switch (event->type_len) {
-	case RINGBUF_TYPE_PADDING:
-		return 0;
-
-	case RINGBUF_TYPE_TIME_EXTEND:
-		return rb_event_time_stamp(event);
-
-	case RINGBUF_TYPE_TIME_STAMP:
-		return 0;
-
-	case RINGBUF_TYPE_DATA:
-		return event->time_delta;
-	default:
-		return 0;
-	}
-}
-
 static inline int
 rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		  struct ring_buffer_event *event)
@@ -2963,8 +2905,6 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *bpage;
 	unsigned long index;
 	unsigned long addr;
-	u64 write_stamp;
-	u64 delta;
 
 	new_index = rb_event_index(event);
 	old_index = new_index + rb_event_ts_length(event);
@@ -2973,14 +2913,10 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 
 	bpage = READ_ONCE(cpu_buffer->tail_page);
 
-	delta = rb_time_delta(event);
-
-	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
-		return 0;
-
-	/* Make sure the write stamp is read before testing the location */
-	barrier();
-
+	/*
+	 * Make sure the tail_page is still the same and
+	 * the next write location is the end of this event
+	 */
 	if (bpage->page == (void *)addr && rb_page_write(bpage) == old_index) {
 		unsigned long write_mask =
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
@@ -2991,20 +2927,20 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		 * to make sure that the next event adds an absolute
 		 * value and does not rely on the saved write stamp, which
 		 * is now going to be bogus.
+		 *
+		 * By setting the before_stamp to zero, the next event
+		 * is not going to use the write_stamp and will instead
+		 * create an absolute timestamp. This means there's no
+		 * reason to update the wirte_stamp!
 		 */
 		rb_time_set(&cpu_buffer->before_stamp, 0);
 
-		/* Something came in, can't discard */
-		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
-				       write_stamp, write_stamp - delta))
-			return 0;
-
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume
 		 * that this event just added itself before updating
 		 * the write stamp. The interrupting event will fix the
-		 * write stamp for us, and use the before stamp as its delta.
+		 * write stamp for us, and use an absolute timestamp.
 		 */
 
 		/*
@@ -3443,7 +3379,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
@@ -3587,20 +3523,36 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		/* Was interrupted before here, write_stamp must be valid */
+
+		/* Save the old before_stamp */
+		a_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
 		RB_WARN_ON(cpu_buffer, !a_ok);
+
+		/*
+		 * Read a new timestamp and update the before_stamp to make
+		 * the next event after this one force using an absolute
+		 * timestamp. This is in case an interrupt were to come in
+		 * between E and F.
+		 */
 		ts = rb_time_stamp(cpu_buffer->buffer);
+		rb_time_set(&cpu_buffer->before_stamp, ts);
+
 		barrier();
- /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
-		    info->after < ts &&
-		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
-				    info->after, ts)) {
-			/* Nothing came after this event between C and E */
+ /*E*/		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
+		/* Was interrupted before here, write_stamp must be valid */
+		RB_WARN_ON(cpu_buffer, !a_ok);
+		barrier();
+ /*F*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
+		    info->after == info->before && info->after < ts) {
+			/*
+			 * Nothing came after this event between C and F, it is
+			 * safe to use info->after for the delta as it
+			 * matched info->before and is still valid.
+			 */
 			info->delta = ts - info->after;
 		} else {
 			/*
-			 * Interrupted between C and E:
+			 * Interrupted between C and F:
 			 * Lost the previous events time stamp. Just set the
 			 * delta to zero, and this will be the same time as
 			 * the event this event interrupted. And the events that
diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 8d77526892f4..d944924cd1e1 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -477,6 +477,17 @@ static int __init synth_event_gen_test_init(void)
 
 	ret = test_trace_synth_event();
 	WARN_ON(ret);
+
+	/* Disable when done */
+	trace_array_set_clr_event(gen_synth_test->tr,
+				  "synthetic",
+				  "gen_synth_test", false);
+	trace_array_set_clr_event(empty_synth_test->tr,
+				  "synthetic",
+				  "empty_synth_test", false);
+	trace_array_set_clr_event(create_synth_test->tr,
+				  "synthetic",
+				  "create_synth_test", false);
  out:
 	return ret;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d1b7dbffbfe4..91ff118138c8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1837,6 +1837,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 	__update_max_tr(tr, tsk, cpu);
 
 	arch_spin_unlock(&tr->max_lock);
+
+	/* Any waiters on the old snapshot buffer need to wake up */
+	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
 }
 
 /**
@@ -1888,12 +1891,23 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
+	int ret;
+
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
 		return 0;
 
-	return ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file,
-				full);
+	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	/*
+	 * Make sure this is still the snapshot buffer, as if a snapshot were
+	 * to happen, this would now be the main buffer.
+	 */
+	if (iter->snapshot)
+		iter->array_buffer = &iter->tr->max_buffer;
+#endif
+	return ret;
 }
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
@@ -8383,7 +8397,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		wait_index = READ_ONCE(iter->wait_index);
 
-		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
+		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
 		if (ret)
 			goto out;
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a60f0bb2ea90..d86abdc77c26 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2111,15 +2111,20 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
 
 	/* Loop starting from the root node to the current node. */
 	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
-		struct fwnode_handle *__fwnode =
-			fwnode_get_nth_parent(fwnode, depth);
+		/*
+		 * Only get a reference for other nodes (i.e. parent nodes).
+		 * fwnode refcount may be 0 here.
+		 */
+		struct fwnode_handle *__fwnode = depth ?
+			fwnode_get_nth_parent(fwnode, depth) : fwnode;
 
 		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
 			     default_str_spec);
 		buf = string(buf, end, fwnode_get_name(__fwnode),
 			     default_str_spec);
 
-		fwnode_handle_put(__fwnode);
+		if (depth)
+			fwnode_handle_put(__fwnode);
 	}
 
 	return buf;
diff --git a/mm/filemap.c b/mm/filemap.c
index 84a5b0213e0e..b76deb24aeea 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2648,6 +2648,15 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			goto put_pages;
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
 
+		/*
+		 * Pairs with a barrier in
+		 * block_write_end()->mark_buffer_dirty() or other page
+		 * dirtying routines like iomap_write_end() to ensure
+		 * changes to page contents are visible before we see
+		 * increased inode size.
+		 */
+		smp_rmb();
+
 		/*
 		 * Once we start copying data, we don't want to be touching any
 		 * cachelines that might be contended:
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 59bc13b5f14f..8710d5d7d3c1 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -407,6 +407,8 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 		return 0;
 
 	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		err = vlan_vid_add(dev, vid_info->proto, vid_info->vid);
 		if (err)
 			goto unwind;
@@ -417,6 +419,8 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 	list_for_each_entry_continue_reverse(vid_info,
 					     &vlan_info->vid_list,
 					     list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
 	}
 
@@ -436,8 +440,11 @@ void vlan_vids_del_by_dev(struct net_device *dev,
 	if (!vlan_info)
 		return;
 
-	list_for_each_entry(vid_info, &vlan_info->vid_list, list)
+	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
+	}
 }
 EXPORT_SYMBOL(vlan_vids_del_by_dev);
 
diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 59eb71f357fa..d473e5eb29cc 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -230,6 +230,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
 
+				*wnames = NULL;
+
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
 				if (!errcode) {
@@ -239,6 +241,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 							  GFP_NOFS);
 					if (!*wnames)
 						errcode = -ENOMEM;
+					else
+						(*wnames)[0] = NULL;
 				}
 
 				if (!errcode) {
@@ -250,8 +254,10 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 								proto_version,
 								"s",
 								&(*wnames)[i]);
-						if (errcode)
+						if (errcode) {
+							(*wnames)[i] = NULL;
 							break;
+						}
 					}
 				}
 
@@ -259,11 +265,14 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 					if (*wnames) {
 						int i;
 
-						for (i = 0; i < *nwname; i++)
+						for (i = 0; i < *nwname; i++) {
+							if (!(*wnames)[i])
+								break;
 							kfree((*wnames)[i]);
+						}
+						kfree(*wnames);
+						*wnames = NULL;
 					}
-					kfree(*wnames);
-					*wnames = NULL;
 				}
 			}
 			break;
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index ce744b14d1a9..b7498e890f0b 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -263,11 +263,14 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	lock_sock(sk);
+
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
 	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
-			return 0;
+			err = 0;
 
+		release_sock(sk);
 		return err;
 	}
 
@@ -293,6 +296,8 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
+	release_sock(sk);
+
 	if (flags & MSG_TRUNC)
 		copied = skblen;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1dd65f13f893..edf5132b5dc9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1926,7 +1926,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		return;
 	}
 
-	set_bit(HCI_INQUIRY, &hdev->flags);
+	if (hci_sent_cmd_data(hdev, HCI_OP_INQUIRY))
+		set_bit(HCI_INQUIRY, &hdev->flags);
 }
 
 static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0770286ecf0b..9f3596de90a7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6493,6 +6493,14 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 	kfree_skb(skb);
 }
 
+static inline void l2cap_sig_send_rej(struct l2cap_conn *conn, u16 ident)
+{
+	struct l2cap_cmd_rej_unk rej;
+
+	rej.reason = cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
+	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
+}
+
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
@@ -6518,23 +6526,24 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 
 		if (len > skb->len || !cmd->ident) {
 			BT_DBG("corrupted command");
+			l2cap_sig_send_rej(conn, cmd->ident);
 			break;
 		}
 
 		err = l2cap_bredr_sig_cmd(conn, cmd, len, skb->data);
 		if (err) {
-			struct l2cap_cmd_rej_unk rej;
-
 			BT_ERR("Wrong link type (%d)", err);
-
-			rej.reason = cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
-			l2cap_send_cmd(conn, cmd->ident, L2CAP_COMMAND_REJ,
-				       sizeof(rej), &rej);
+			l2cap_sig_send_rej(conn, cmd->ident);
 		}
 
 		skb_pull(skb, len);
 	}
 
+	if (skb->len > 0) {
+		BT_DBG("corrupted command");
+		l2cap_sig_send_rej(conn, 0);
+	}
+
 drop:
 	kfree_skb(skb);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 04000499f4a2..8f1162961836 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2378,7 +2378,8 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
-		if (key->addr.type != BDADDR_BREDR || key->type > 0x08)
+		/* Considering SMP over BREDR/LE, there is no need to check addr_type */
+		if (key->type > 0x08)
 			return mgmt_cmd_status(sk, hdev->id,
 					       MGMT_OP_LOAD_LINK_KEYS,
 					       MGMT_STATUS_INVALID_PARAMS);
@@ -6180,6 +6181,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
+		u8 addr_type = le_addr_type(irk->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_IRK,
@@ -6189,8 +6191,12 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			continue;
 		}
 
+		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
+		if (irk->addr.type == BDADDR_BREDR)
+			addr_type = BDADDR_BREDR;
+
 		hci_add_irk(hdev, &irk->addr.bdaddr,
-			    le_addr_type(irk->addr.type), irk->val,
+			    addr_type, irk->val,
 			    BDADDR_ANY);
 	}
 
@@ -6271,6 +6277,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type, authenticated;
+		u8 addr_type = le_addr_type(key->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_LTK,
@@ -6305,8 +6312,12 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			continue;
 		}
 
+		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
+		if (key->addr.type == BDADDR_BREDR)
+			addr_type = BDADDR_BREDR;
+
 		hci_add_ltk(hdev, &key->addr.bdaddr,
-			    le_addr_type(key->addr.type), type, authenticated,
+			    addr_type, type, authenticated,
 			    key->val, key->enc_size, key->ediv, key->rand);
 	}
 
@@ -8673,7 +8684,7 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = BDADDR_BREDR;
+	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, HCI_LINK_KEY_SIZE);
 	ev.key.pin_len = key->pin_len;
@@ -8724,7 +8735,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
 	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
@@ -8753,7 +8764,7 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
-	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
+	ev.irk.addr.type = link_to_bdaddr(irk->link_type, irk->addr_type);
 	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
 
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
@@ -8782,7 +8793,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(csrk->link_type, csrk->bdaddr_type);
 	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 11f853d0500f..f688f941c40c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1058,6 +1058,7 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->remote_irk) {
+		smp->remote_irk->link_type = hcon->type;
 		mgmt_new_irk(hdev, smp->remote_irk, persistent);
 
 		/* Now that user space can be considered to know the
@@ -1072,24 +1073,28 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->csrk) {
+		smp->csrk->link_type = hcon->type;
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->csrk, persistent);
 	}
 
 	if (smp->responder_csrk) {
+		smp->responder_csrk->link_type = hcon->type;
 		smp->responder_csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
 	}
 
 	if (smp->ltk) {
+		smp->ltk->link_type = hcon->type;
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->ltk, persistent);
 	}
 
 	if (smp->responder_ltk) {
+		smp->responder_ltk->link_type = hcon->type;
 		smp->responder_ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
@@ -1109,6 +1114,8 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		key = hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
 				       smp->link_key, type, 0, &persistent);
 		if (key) {
+			key->link_type = hcon->type;
+			key->bdaddr_type = hcon->dst_type;
 			mgmt_new_link_key(hdev, key, persistent);
 
 			/* Don't keep debug keys around if the relevant
diff --git a/net/core/dev.c b/net/core/dev.c
index 8f4f355a963f..8501645ff67d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3540,6 +3540,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	if (gso_segs > dev->gso_max_segs)
 		return features & ~NETIF_F_GSO_MASK;
 
+	if (unlikely(skb->len >= READ_ONCE(dev->gso_max_size)))
+		return features & ~NETIF_F_GSO_MASK;
+
 	if (!skb_shinfo(skb)->gso_type) {
 		skb_warn_bad_offload(skb);
 		return features & ~NETIF_F_GSO_MASK;
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 3aced951d5ab..03f8f33dc134 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -91,6 +91,7 @@ const struct cred *dns_resolver_cache;
 static int
 dns_resolver_preparse(struct key_preparsed_payload *prep)
 {
+	const struct dns_server_list_v1_header *v1;
 	const struct dns_payload_header *bin;
 	struct user_key_payload *upayload;
 	unsigned long derrno;
@@ -122,6 +123,13 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 			return -EINVAL;
 		}
 
+		v1 = (const struct dns_server_list_v1_header *)bin;
+		if ((v1->status != DNS_LOOKUP_GOOD &&
+		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
+			if (prep->expiry == TIME64_MAX)
+				prep->expiry = ktime_get_real_seconds() + 1;
+		}
+
 		result_len = datalen;
 		goto store_result;
 	}
@@ -314,7 +322,7 @@ static long dns_resolver_read(const struct key *key,
 
 struct key_type key_type_dns_resolver = {
 	.name		= "dns_resolver",
-	.flags		= KEY_TYPE_NET_DOMAIN,
+	.flags		= KEY_TYPE_NET_DOMAIN | KEY_TYPE_INSTANT_REAP,
 	.preparse	= dns_resolver_preparse,
 	.free_preparse	= dns_resolver_free_preparse,
 	.instantiate	= generic_key_instantiate,
diff --git a/net/ife/ife.c b/net/ife/ife.c
index 13bbf8cb6a39..be05b690b9ef 100644
--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -82,6 +82,7 @@ void *ife_decode(struct sk_buff *skb, u16 *metalen)
 	if (unlikely(!pskb_may_pull(skb, total_pull)))
 		return NULL;
 
+	ifehdr = (struct ifeheadr *)(skb->data + skb->dev->hard_header_len);
 	skb_set_mac_header(skb, total_pull);
 	__skb_pull(skb, total_pull);
 	*metalen = ifehdrln - IFE_METAHDRLEN;
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index a829470dd59e..44ce979a9fd5 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1050,8 +1050,8 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
 	case WLAN_SP_MESH_PEERING_OPEN:
 		if (!matches_local)
 			event = OPN_RJCT;
-		if (!mesh_plink_free_count(sdata) ||
-		    (sta->mesh->plid && sta->mesh->plid != plid))
+		else if (!mesh_plink_free_count(sdata) ||
+			 (sta->mesh->plid && sta->mesh->plid != plid))
 			event = OPN_IGNR;
 		else
 			event = OPN_ACPT;
@@ -1059,9 +1059,9 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
 	case WLAN_SP_MESH_PEERING_CONFIRM:
 		if (!matches_local)
 			event = CNF_RJCT;
-		if (!mesh_plink_free_count(sdata) ||
-		    sta->mesh->llid != llid ||
-		    (sta->mesh->plid && sta->mesh->plid != plid))
+		else if (!mesh_plink_free_count(sdata) ||
+			 sta->mesh->llid != llid ||
+			 (sta->mesh->plid && sta->mesh->plid != plid))
 			event = CNF_IGNR;
 		else
 			event = CNF_ACPT;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 20c2b4f5e893..3ee0f632a942 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9256,7 +9256,7 @@ static void nft_set_commit_update(struct list_head *set_update_list)
 	list_for_each_entry_safe(set, next, set_update_list, pending_update) {
 		list_del_init(&set->pending_update);
 
-		if (!set->ops->commit)
+		if (!set->ops->commit || set->dead)
 			continue;
 
 		set->ops->commit(set);
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 2cc95c8dc4c7..f74baefd855d 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -116,6 +116,14 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = gpiod_direction_output(rfkill->reset_gpio, true);
+	if (ret)
+		return ret;
+
+	ret = gpiod_direction_output(rfkill->shutdown_gpio, true);
+	if (ret)
+		return ret;
+
 	rfkill->rfkill_dev = rfkill_alloc(rfkill->name, &pdev->dev,
 					  rfkill->type, &rfkill_gpio_ops,
 					  rfkill);
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index b3e7a92f1ec1..1d95ff34b13c 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -181,21 +181,47 @@ void rose_kill_by_neigh(struct rose_neigh *neigh)
  */
 static void rose_kill_by_device(struct net_device *dev)
 {
-	struct sock *s;
+	struct sock *sk, *array[16];
+	struct rose_sock *rose;
+	bool rescan;
+	int i, cnt;
 
+start:
+	rescan = false;
+	cnt = 0;
 	spin_lock_bh(&rose_list_lock);
-	sk_for_each(s, &rose_list) {
-		struct rose_sock *rose = rose_sk(s);
+	sk_for_each(sk, &rose_list) {
+		rose = rose_sk(sk);
+		if (rose->device == dev) {
+			if (cnt == ARRAY_SIZE(array)) {
+				rescan = true;
+				break;
+			}
+			sock_hold(sk);
+			array[cnt++] = sk;
+		}
+	}
+	spin_unlock_bh(&rose_list_lock);
 
+	for (i = 0; i < cnt; i++) {
+		sk = array[cnt];
+		rose = rose_sk(sk);
+		lock_sock(sk);
+		spin_lock_bh(&rose_list_lock);
 		if (rose->device == dev) {
-			rose_disconnect(s, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
+			rose_disconnect(sk, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
 			if (rose->neighbour)
 				rose->neighbour->use--;
 			dev_put(rose->device);
 			rose->device = NULL;
 		}
+		spin_unlock_bh(&rose_list_lock);
+		release_sock(sk);
+		sock_put(sk);
+		cond_resched();
 	}
-	spin_unlock_bh(&rose_list_lock);
+	if (rescan)
+		goto start;
 }
 
 /*
@@ -655,7 +681,10 @@ static int rose_release(struct socket *sock)
 		break;
 	}
 
+	spin_lock_bh(&rose_list_lock);
 	dev_put(rose->device);
+	rose->device = NULL;
+	spin_unlock_bh(&rose_list_lock);
 	sock->sk = NULL;
 	release_sock(sk);
 	sock_put(sk);
diff --git a/net/wireless/certs/wens.hex b/net/wireless/certs/wens.hex
new file mode 100644
index 000000000000..0d50369bede9
--- /dev/null
+++ b/net/wireless/certs/wens.hex
@@ -0,0 +1,87 @@
+/* Chen-Yu Tsai's regdb certificate */
+0x30, 0x82, 0x02, 0xa7, 0x30, 0x82, 0x01, 0x8f,
+0x02, 0x14, 0x61, 0xc0, 0x38, 0x65, 0x1a, 0xab,
+0xdc, 0xf9, 0x4b, 0xd0, 0xac, 0x7f, 0xf0, 0x6c,
+0x72, 0x48, 0xdb, 0x18, 0xc6, 0x00, 0x30, 0x0d,
+0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d,
+0x01, 0x01, 0x0b, 0x05, 0x00, 0x30, 0x0f, 0x31,
+0x0d, 0x30, 0x0b, 0x06, 0x03, 0x55, 0x04, 0x03,
+0x0c, 0x04, 0x77, 0x65, 0x6e, 0x73, 0x30, 0x20,
+0x17, 0x0d, 0x32, 0x33, 0x31, 0x32, 0x30, 0x31,
+0x30, 0x37, 0x34, 0x31, 0x31, 0x34, 0x5a, 0x18,
+0x0f, 0x32, 0x31, 0x32, 0x33, 0x31, 0x31, 0x30,
+0x37, 0x30, 0x37, 0x34, 0x31, 0x31, 0x34, 0x5a,
+0x30, 0x0f, 0x31, 0x0d, 0x30, 0x0b, 0x06, 0x03,
+0x55, 0x04, 0x03, 0x0c, 0x04, 0x77, 0x65, 0x6e,
+0x73, 0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06,
+0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01,
+0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f,
+0x00, 0x30, 0x82, 0x01, 0x0a, 0x02, 0x82, 0x01,
+0x01, 0x00, 0xa9, 0x7a, 0x2c, 0x78, 0x4d, 0xa7,
+0x19, 0x2d, 0x32, 0x52, 0xa0, 0x2e, 0x6c, 0xef,
+0x88, 0x7f, 0x15, 0xc5, 0xb6, 0x69, 0x54, 0x16,
+0x43, 0x14, 0x79, 0x53, 0xb7, 0xae, 0x88, 0xfe,
+0xc0, 0xb7, 0x5d, 0x47, 0x8e, 0x1a, 0xe1, 0xef,
+0xb3, 0x90, 0x86, 0xda, 0xd3, 0x64, 0x81, 0x1f,
+0xce, 0x5d, 0x9e, 0x4b, 0x6e, 0x58, 0x02, 0x3e,
+0xb2, 0x6f, 0x5e, 0x42, 0x47, 0x41, 0xf4, 0x2c,
+0xb8, 0xa8, 0xd4, 0xaa, 0xc0, 0x0e, 0xe6, 0x48,
+0xf0, 0xa8, 0xce, 0xcb, 0x08, 0xae, 0x37, 0xaf,
+0xf6, 0x40, 0x39, 0xcb, 0x55, 0x6f, 0x5b, 0x4f,
+0x85, 0x34, 0xe6, 0x69, 0x10, 0x50, 0x72, 0x5e,
+0x4e, 0x9d, 0x4c, 0xba, 0x38, 0x36, 0x0d, 0xce,
+0x73, 0x38, 0xd7, 0x27, 0x02, 0x2a, 0x79, 0x03,
+0xe1, 0xac, 0xcf, 0xb0, 0x27, 0x85, 0x86, 0x93,
+0x17, 0xab, 0xec, 0x42, 0x77, 0x37, 0x65, 0x8a,
+0x44, 0xcb, 0xd6, 0x42, 0x93, 0x92, 0x13, 0xe3,
+0x39, 0x45, 0xc5, 0x6e, 0x00, 0x4a, 0x7f, 0xcb,
+0x42, 0x17, 0x2b, 0x25, 0x8c, 0xb8, 0x17, 0x3b,
+0x15, 0x36, 0x59, 0xde, 0x42, 0xce, 0x21, 0xe6,
+0xb6, 0xc7, 0x6e, 0x5e, 0x26, 0x1f, 0xf7, 0x8a,
+0x57, 0x9e, 0xa5, 0x96, 0x72, 0xb7, 0x02, 0x32,
+0xeb, 0x07, 0x2b, 0x73, 0xe2, 0x4f, 0x66, 0x58,
+0x9a, 0xeb, 0x0f, 0x07, 0xb6, 0xab, 0x50, 0x8b,
+0xc3, 0x8f, 0x17, 0xfa, 0x0a, 0x99, 0xc2, 0x16,
+0x25, 0xbf, 0x2d, 0x6b, 0x1a, 0xaa, 0xe6, 0x3e,
+0x5f, 0xeb, 0x6d, 0x9b, 0x5d, 0x4d, 0x42, 0x83,
+0x2d, 0x39, 0xb8, 0xc9, 0xac, 0xdb, 0x3a, 0x91,
+0x50, 0xdf, 0xbb, 0xb1, 0x76, 0x6d, 0x15, 0x73,
+0xfd, 0xc6, 0xe6, 0x6b, 0x71, 0x9e, 0x67, 0x36,
+0x22, 0x83, 0x79, 0xb1, 0xd6, 0xb8, 0x84, 0x52,
+0xaf, 0x96, 0x5b, 0xc3, 0x63, 0x02, 0x4e, 0x78,
+0x70, 0x57, 0x02, 0x03, 0x01, 0x00, 0x01, 0x30,
+0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7,
+0x0d, 0x01, 0x01, 0x0b, 0x05, 0x00, 0x03, 0x82,
+0x01, 0x01, 0x00, 0x24, 0x28, 0xee, 0x22, 0x74,
+0x7f, 0x7c, 0xfa, 0x6c, 0x1f, 0xb3, 0x18, 0xd1,
+0xc2, 0x3d, 0x7d, 0x29, 0x42, 0x88, 0xad, 0x82,
+0xa5, 0xb1, 0x8a, 0x05, 0xd0, 0xec, 0x5c, 0x91,
+0x20, 0xf6, 0x82, 0xfd, 0xd5, 0x67, 0x60, 0x5f,
+0x31, 0xf5, 0xbd, 0x88, 0x91, 0x70, 0xbd, 0xb8,
+0xb9, 0x8c, 0x88, 0xfe, 0x53, 0xc9, 0x54, 0x9b,
+0x43, 0xc4, 0x7a, 0x43, 0x74, 0x6b, 0xdd, 0xb0,
+0xb1, 0x3b, 0x33, 0x45, 0x46, 0x78, 0xa3, 0x1c,
+0xef, 0x54, 0x68, 0xf7, 0x85, 0x9c, 0xe4, 0x51,
+0x6f, 0x06, 0xaf, 0x81, 0xdb, 0x2a, 0x7b, 0x7b,
+0x6f, 0xa8, 0x9c, 0x67, 0xd8, 0xcb, 0xc9, 0x91,
+0x40, 0x00, 0xae, 0xd9, 0xa1, 0x9f, 0xdd, 0xa6,
+0x43, 0x0e, 0x28, 0x7b, 0xaa, 0x1b, 0xe9, 0x84,
+0xdb, 0x76, 0x64, 0x42, 0x70, 0xc9, 0xc0, 0xeb,
+0xae, 0x84, 0x11, 0x16, 0x68, 0x4e, 0x84, 0x9e,
+0x7e, 0x92, 0x36, 0xee, 0x1c, 0x3b, 0x08, 0x63,
+0xeb, 0x79, 0x84, 0x15, 0x08, 0x9d, 0xaf, 0xc8,
+0x9a, 0xc7, 0x34, 0xd3, 0x94, 0x4b, 0xd1, 0x28,
+0x97, 0xbe, 0xd1, 0x45, 0x75, 0xdc, 0x35, 0x62,
+0xac, 0x1d, 0x1f, 0xb7, 0xb7, 0x15, 0x87, 0xc8,
+0x98, 0xc0, 0x24, 0x31, 0x56, 0x8d, 0xed, 0xdb,
+0x06, 0xc6, 0x46, 0xbf, 0x4b, 0x6d, 0xa6, 0xd5,
+0xab, 0xcc, 0x60, 0xfc, 0xe5, 0x37, 0xb6, 0x53,
+0x7d, 0x58, 0x95, 0xa9, 0x56, 0xc7, 0xf7, 0xee,
+0xc3, 0xa0, 0x76, 0xf7, 0x65, 0x4d, 0x53, 0xfa,
+0xff, 0x5f, 0x76, 0x33, 0x5a, 0x08, 0xfa, 0x86,
+0x92, 0x5a, 0x13, 0xfa, 0x1a, 0xfc, 0xf2, 0x1b,
+0x8c, 0x7f, 0x42, 0x6d, 0xb7, 0x7e, 0xb7, 0xb4,
+0xf0, 0xc7, 0x83, 0xbb, 0xa2, 0x81, 0x03, 0x2d,
+0xd4, 0x2a, 0x63, 0x3f, 0xf7, 0x31, 0x2e, 0x40,
+0x33, 0x5c, 0x46, 0xbc, 0x9b, 0xc1, 0x05, 0xa5,
+0x45, 0x4e, 0xc3,
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 3c90807476eb..eaddaceda14e 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -66,6 +66,19 @@ void key_schedule_gc(time64_t gc_at)
 	}
 }
 
+/*
+ * Set the expiration time on a key.
+ */
+void key_set_expiry(struct key *key, time64_t expiry)
+{
+	key->expiry = expiry;
+	if (expiry != TIME64_MAX) {
+		if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
+			expiry += key_gc_delay;
+		key_schedule_gc(expiry);
+	}
+}
+
 /*
  * Schedule a dead links collection run.
  */
@@ -176,7 +189,6 @@ static void key_garbage_collector(struct work_struct *work)
 	static u8 gc_state;		/* Internal persistent state */
 #define KEY_GC_REAP_AGAIN	0x01	/* - Need another cycle */
 #define KEY_GC_REAPING_LINKS	0x02	/* - We need to reap links */
-#define KEY_GC_SET_TIMER	0x04	/* - We need to restart the timer */
 #define KEY_GC_REAPING_DEAD_1	0x10	/* - We need to mark dead keys */
 #define KEY_GC_REAPING_DEAD_2	0x20	/* - We need to reap dead key links */
 #define KEY_GC_REAPING_DEAD_3	0x40	/* - We need to reap dead keys */
@@ -184,21 +196,17 @@ static void key_garbage_collector(struct work_struct *work)
 
 	struct rb_node *cursor;
 	struct key *key;
-	time64_t new_timer, limit;
+	time64_t new_timer, limit, expiry;
 
 	kenter("[%lx,%x]", key_gc_flags, gc_state);
 
 	limit = ktime_get_real_seconds();
-	if (limit > key_gc_delay)
-		limit -= key_gc_delay;
-	else
-		limit = key_gc_delay;
 
 	/* Work out what we're going to be doing in this pass */
 	gc_state &= KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2;
 	gc_state <<= 1;
 	if (test_and_clear_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags))
-		gc_state |= KEY_GC_REAPING_LINKS | KEY_GC_SET_TIMER;
+		gc_state |= KEY_GC_REAPING_LINKS;
 
 	if (test_and_clear_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags))
 		gc_state |= KEY_GC_REAPING_DEAD_1;
@@ -233,8 +241,11 @@ static void key_garbage_collector(struct work_struct *work)
 			}
 		}
 
-		if (gc_state & KEY_GC_SET_TIMER) {
-			if (key->expiry > limit && key->expiry < new_timer) {
+		expiry = key->expiry;
+		if (expiry != TIME64_MAX) {
+			if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
+				expiry += key_gc_delay;
+			if (expiry > limit && expiry < new_timer) {
 				kdebug("will expire %x in %lld",
 				       key_serial(key), key->expiry - limit);
 				new_timer = key->expiry;
@@ -276,7 +287,7 @@ static void key_garbage_collector(struct work_struct *work)
 	 */
 	kdebug("pass complete");
 
-	if (gc_state & KEY_GC_SET_TIMER && new_timer != (time64_t)TIME64_MAX) {
+	if (new_timer != TIME64_MAX) {
 		new_timer += key_gc_delay;
 		key_schedule_gc(new_timer);
 	}
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..bede6c71ffd9 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -176,6 +176,7 @@ extern unsigned key_gc_delay;
 extern void keyring_gc(struct key *keyring, time64_t limit);
 extern void keyring_restriction_gc(struct key *keyring,
 				   struct key_type *dead_type);
+void key_set_expiry(struct key *key, time64_t expiry);
 extern void key_schedule_gc(time64_t gc_at);
 extern void key_schedule_gc_links(void);
 extern void key_gc_keytype(struct key_type *ktype);
@@ -224,10 +225,18 @@ extern struct key *key_get_instantiation_authkey(key_serial_t target_id);
  */
 static inline bool key_is_dead(const struct key *key, time64_t limit)
 {
+	time64_t expiry = key->expiry;
+
+	if (expiry != TIME64_MAX) {
+		if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
+			expiry += key_gc_delay;
+		if (expiry <= limit)
+			return true;
+	}
+
 	return
 		key->flags & ((1 << KEY_FLAG_DEAD) |
 			      (1 << KEY_FLAG_INVALIDATED)) ||
-		(key->expiry > 0 && key->expiry <= limit) ||
 		key->domain_tag->removed;
 }
 
diff --git a/security/keys/key.c b/security/keys/key.c
index c45afdd1dfbb..e65240641ca5 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -294,6 +294,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->uid = uid;
 	key->gid = gid;
 	key->perm = perm;
+	key->expiry = TIME64_MAX;
 	key->restrict_link = restrict_link;
 	key->last_used_at = ktime_get_real_seconds();
 
@@ -463,10 +464,7 @@ static int __key_instantiate_and_link(struct key *key,
 			if (authkey)
 				key_invalidate(authkey);
 
-			if (prep->expiry != TIME64_MAX) {
-				key->expiry = prep->expiry;
-				key_schedule_gc(prep->expiry + key_gc_delay);
-			}
+			key_set_expiry(key, prep->expiry);
 		}
 	}
 
@@ -606,8 +604,7 @@ int key_reject_and_link(struct key *key,
 		atomic_inc(&key->user->nikeys);
 		mark_key_instantiated(key, -error);
 		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
-		key->expiry = ktime_get_real_seconds() + timeout;
-		key_schedule_gc(key->expiry + key_gc_delay);
+		key_set_expiry(key, ktime_get_real_seconds() + timeout);
 
 		if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
 			awaken = 1;
@@ -722,16 +719,14 @@ struct key_type *key_type_lookup(const char *type)
 
 void key_set_timeout(struct key *key, unsigned timeout)
 {
-	time64_t expiry = 0;
+	time64_t expiry = TIME64_MAX;
 
 	/* make the changes with the locks held to prevent races */
 	down_write(&key->sem);
 
 	if (timeout > 0)
 		expiry = ktime_get_real_seconds() + timeout;
-
-	key->expiry = expiry;
-	key_schedule_gc(key->expiry + key_gc_delay);
+	key_set_expiry(key, expiry);
 
 	up_write(&key->sem);
 }
diff --git a/security/keys/proc.c b/security/keys/proc.c
index d0cde6685627..4f4e2c1824f1 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -198,7 +198,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 
 	/* come up with a suitable timeout value */
 	expiry = READ_ONCE(key->expiry);
-	if (expiry == 0) {
+	if (expiry == TIME64_MAX) {
 		memcpy(xbuf, "perm", 5);
 	} else if (now >= expiry) {
 		memcpy(xbuf, "expd", 5);
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 0a7e2f8ca71a..410fb59807f1 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -843,8 +843,9 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
 static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
 				   unsigned int jack_status)
 {
-	if (hcp->jack && jack_status != hcp->jack_status) {
-		snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
+	if (jack_status != hcp->jack_status) {
+		if (hcp->jack)
+			snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
 		hcp->jack_status = jack_status;
 	}
 }
@@ -873,6 +874,13 @@ static int hdmi_codec_set_jack(struct snd_soc_component *component,
 
 	if (hcp->hcd.ops->hook_plugged_cb) {
 		hcp->jack = jack;
+
+		/*
+		 * Report the initial jack status which may have been provided
+		 * by the parent hdmi driver while the hpd hook was registered.
+		 */
+		snd_soc_jack_report(jack, hcp->jack_status, SND_JACK_LINEOUT);
+
 		return 0;
 	}
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 6d87f58d1b00..9cdf0e05cf49 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1125,7 +1125,7 @@ static int snd_usb_motu_microbookii_boot_quirk(struct usb_device *dev)
 
 static int snd_usb_motu_m_series_boot_quirk(struct usb_device *dev)
 {
-	msleep(2000);
+	msleep(4000);
 
 	return 0;
 }
@@ -1364,7 +1364,7 @@ int snd_usb_apply_boot_quirk_once(struct usb_device *dev,
 				  unsigned int id)
 {
 	switch (id) {
-	case USB_ID(0x07fd, 0x0008): /* MOTU M Series */
+	case USB_ID(0x07fd, 0x0008): /* MOTU M Series, 1st hardware version */
 		return snd_usb_motu_m_series_boot_quirk(dev);
 	}
 

