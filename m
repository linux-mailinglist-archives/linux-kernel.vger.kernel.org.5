Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE07D6787
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjJYJvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjJYJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:51:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8079DCE;
        Wed, 25 Oct 2023 02:51:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF11C433C7;
        Wed, 25 Oct 2023 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698227505;
        bh=wg3UodJ/+ES3BCM1SVj8v8EPONGAzS1rcS9lDl4hbEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyJtZ3ptUrCqO1xOj8qVtkq1ZZR2U051/caHEUKKmbYI+Bd4VD+71LrvV/KfyBxrv
         NSRHRS11Xu1gEWWPqHnQTm71Zp4tpHKHAt2LRKLztQby/K0zAPCuQXJJ1m4fGbkof2
         tDIFI1zL2JxXM+kwVX6Od23Yao07eGK9CxHD7uvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.328
Date:   Wed, 25 Oct 2023 11:51:35 +0200
Message-ID: <2023102534-tint-undocked-cbd9@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023102534-reverse-whiny-2546@gregkh>
References: <2023102534-reverse-whiny-2546@gregkh>
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

diff --git a/Makefile b/Makefile
index 2f6318924f21..f0bb45a62374 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 327
+SUBLEVEL = 328
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index bad690b23081..6d2ee40d88e1 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -533,6 +533,7 @@
 &uart3 {
 	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0x17c>;
+	overrun-throttle-ms = <500>;
 };
 
 &uart4 {
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 0d300ee00f4e..9db7cacfe1f0 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
 #include <linux/pci.h>
+#include <linux/overflow.h>
 #include <asm/pci_dma.h>
 
 #define S390_MAPPING_ERROR		(~(dma_addr_t) 0x0)
@@ -527,6 +528,17 @@ static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		s->dma_length = 0;
 	}
 }
+
+static unsigned long *bitmap_vzalloc(size_t bits, gfp_t flags)
+{
+	size_t n = BITS_TO_LONGS(bits);
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, sizeof(unsigned long), &bytes)))
+		return NULL;
+
+	return vzalloc(bytes);
+}
 	
 static int s390_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
@@ -568,13 +580,13 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 				zdev->end_dma - zdev->start_dma + 1);
 	zdev->end_dma = zdev->start_dma + zdev->iommu_size - 1;
 	zdev->iommu_pages = zdev->iommu_size >> PAGE_SHIFT;
-	zdev->iommu_bitmap = vzalloc(zdev->iommu_pages / 8);
+	zdev->iommu_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
 	if (!zdev->iommu_bitmap) {
 		rc = -ENOMEM;
 		goto free_dma_table;
 	}
 	if (!s390_iommu_strict) {
-		zdev->lazy_bitmap = vzalloc(zdev->iommu_pages / 8);
+		zdev->lazy_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
 		if (!zdev->lazy_bitmap) {
 			rc = -ENOMEM;
 			goto free_bitmap;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3a1e43588685..a10cd3fef963 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -442,6 +442,10 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index e0c9ede0196a..96305270c435 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -24,6 +24,7 @@
 
 static const int amd_erratum_383[];
 static const int amd_erratum_400[];
+static const int amd_erratum_1485[];
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum);
 
 /*
@@ -974,6 +975,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
 	if (!cpu_has(c, X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	    cpu_has_amd_erratum(c, amd_erratum_1485))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
 #ifdef CONFIG_X86_32
@@ -1102,6 +1107,10 @@ static const int amd_erratum_383[] =
 	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
 
 
+static const int amd_erratum_1485[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
+			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
 	int osvw_id = *erratum++;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4305f094d2c5..2c12ae71aa49 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2085,13 +2085,17 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type)
 {
 	u32 reg = kvm_lapic_get_reg(apic, lvt_type);
 	int vector, mode, trig_mode;
+	int r;
 
 	if (kvm_apic_hw_enabled(apic) && !(reg & APIC_LVT_MASKED)) {
 		vector = reg & APIC_VECTOR_MASK;
 		mode = reg & APIC_MODE_MASK;
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
-		return __apic_accept_irq(apic, mode, vector, 1, trig_mode,
-					NULL);
+
+		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
+		if (r && lvt_type == APIC_LVTPC)
+			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
+		return r;
 	}
 	return 0;
 }
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 7c352cba0528..8ac01375fe8f 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -55,6 +55,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
 	struct irq_fwspec fwspec;
+	unsigned int irq;
 
 	if (WARN_ON(!acpi_gsi_domain_id)) {
 		pr_warn("GSI: No registered irqchip, giving up\n");
@@ -66,7 +67,11 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
 
-	return irq_create_fwspec_mapping(&fwspec);
+	irq = irq_create_fwspec_mapping(&fwspec);
+	if (!irq)
+		return -EINVAL;
+
+	return irq;
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8a789de05680..18126dd96496 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2466,7 +2466,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	const char *frozen, *desc;
-	char tries_buf[6] = "";
+	char tries_buf[16] = "";
 	int tag, nr_failed = 0;
 
 	if (ehc->i.flags & ATA_EHI_QUIET)
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 1c5ff22d92f1..a28e9e2111b4 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1242,7 +1242,7 @@ static int dev_get_regmap_match(struct device *dev, void *res, void *data)
 
 	/* If the user didn't specify a name match any */
 	if (data)
-		return !strcmp((*r)->name, data);
+		return (*r)->name && !strcmp((*r)->name, data);
 	else
 		return 1;
 }
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index e6f6dbc04131..f72d8f168ae9 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -82,7 +82,10 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+
+	mutex_lock(&data->open_mutex);
 	skb_queue_tail(&data->readq, skb);
+	mutex_unlock(&data->open_mutex);
 
 	wake_up_interruptible(&data->read_wait);
 	return 0;
diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index 181f86ce00cd..639c8daaeb31 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -55,9 +55,10 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 	unsigned offset, bool enabled)
 {
 	struct timbgpio *tgpio = gpiochip_get_data(gpio);
+	unsigned long flags;
 	u32 reg;
 
-	spin_lock(&tgpio->lock);
+	spin_lock_irqsave(&tgpio->lock, flags);
 	reg = ioread32(tgpio->membase + offset);
 
 	if (enabled)
@@ -66,7 +67,7 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 		reg &= ~(1 << index);
 
 	iowrite32(reg, tgpio->membase + offset);
-	spin_unlock(&tgpio->lock);
+	spin_unlock_irqrestore(&tgpio->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 457ee42023f4..6c8aafec069c 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -137,14 +137,14 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 	unsigned long mask = BIT(gpio);
 	u32 val;
 
+	vf610_gpio_set(chip, gpio, value);
+
 	if (port->sdata && port->sdata->have_paddr) {
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	vf610_gpio_set(chip, gpio, value);
-
 	return pinctrl_gpio_direction_output(chip->base + gpio);
 }
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 4fa091797656..f708c3752f3a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -107,7 +107,7 @@ static int etnaviv_gem_prime_mmap_obj(struct etnaviv_gem_object *etnaviv_obj,
 	ret = dma_buf_mmap(etnaviv_obj->base.dma_buf, vma, 0);
 	if (!ret) {
 		/* Drop the reference acquired by drm_gem_mmap_obj(). */
-		drm_gem_object_put(&etnaviv_obj->base);
+		drm_gem_object_put_unlocked(&etnaviv_obj->base);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 996696ad6f98..3bb0a36260c2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1836,7 +1836,7 @@ static int vmw_cmd_tex_state(struct vmw_private *dev_priv,
 	} *cmd;
 
 	SVGA3dTextureState *last_state = (SVGA3dTextureState *)
-	  ((unsigned long) header + header->size + sizeof(header));
+	  ((unsigned long) header + header->size + sizeof(*header));
 	SVGA3dTextureState *cur_state = (SVGA3dTextureState *)
 		((unsigned long) header + sizeof(struct vmw_tex_state_cmd));
 	struct vmw_resource_val_node *ctx_node;
diff --git a/drivers/hid/hid-holtek-kbd.c b/drivers/hid/hid-holtek-kbd.c
index 2f8eb6639744..72788ca260e0 100644
--- a/drivers/hid/hid-holtek-kbd.c
+++ b/drivers/hid/hid-holtek-kbd.c
@@ -133,6 +133,10 @@ static int holtek_kbd_input_event(struct input_dev *dev, unsigned int type,
 		return -ENODEV;
 
 	boot_hid = usb_get_intfdata(boot_interface);
+	if (list_empty(&boot_hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
 	boot_hid_input = list_first_entry(&boot_hid->inputs,
 		struct hid_input, list);
 
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1588508b3e7b..5ebbde4852c4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3128,7 +3128,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	/* Allow incoming packets */
 	hid_device_io_start(hdev);
 
-	hidpp_connect_event(hidpp);
+	schedule_work(&hidpp->work);
+	flush_work(&hidpp->work);
 
 	return ret;
 
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 7ba31f6bf148..ad5fd357b2bc 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -334,7 +334,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 		priv->adap.lock_ops = &i2c_parent_lock_ops;
 
 	/* Sanity check on class */
-	if (i2c_mux_parent_classes(parent) & class)
+	if (i2c_mux_parent_classes(parent) & class & ~I2C_CLASS_DEPRECATED)
 		dev_err(&parent->dev,
 			"Segment %d behind mux can't share classes with ancestors\n",
 			chan_id);
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index ae415b4e381a..0714da47a2f9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1050,7 +1050,7 @@ int bmp280_common_probe(struct device *dev,
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
+	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
 			goto out_disable_vdda;
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index b4b343c3bd87..5127c9b42dd9 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -79,7 +79,7 @@ static bool ms5611_prom_is_valid(u16 *prom, size_t len)
 
 	crc = (crc >> 12) & 0x000F;
 
-	return crc_orig != 0x0000 && crc == crc_orig;
+	return crc == crc_orig;
 }
 
 static int ms5611_read_prom(struct iio_dev *indio_dev)
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 357960d48e66..2086844dfade 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1902,6 +1902,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
 	int win;
 
 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
 	req = __skb_put_zero(skb, sizeof(*req));
 	req->op_compl = htonl(WR_OP_V(FW_OFLD_CONNECTION_WR));
 	req->len16_pkd = htonl(FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*req), 16)));
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 9f503c1e74b4..1dbe30335458 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -269,6 +269,7 @@ static const struct xpad_device {
 	{ 0x1038, 0x1430, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
+	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
 	{ 0x1209, 0x2882, "Ardwiino Controller", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
@@ -463,6 +464,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
+	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 5c8c79623c87..eecaa40b4770 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -424,6 +424,7 @@ static void powermate_disconnect(struct usb_interface *intf)
 		pm->requires_update = 0;
 		usb_kill_urb(pm->irq);
 		input_unregister_device(pm->input);
+		usb_kill_urb(pm->config);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 7fd32b0183dc..6e7e91387f3c 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -392,17 +392,13 @@ EXPORT_SYMBOL_GPL(mcb_free_dev);
 
 static int __mcb_bus_add_devices(struct device *dev, void *data)
 {
-	struct mcb_device *mdev = to_mcb_device(dev);
 	int retval;
 
-	if (mdev->is_added)
-		return 0;
-
 	retval = device_attach(dev);
-	if (retval < 0)
+	if (retval < 0) {
 		dev_err(dev, "Error adding device (%d)\n", retval);
-
-	mdev->is_added = true;
+		return retval;
+	}
 
 	return 0;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 3636349648b4..08a85e43ef88 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -98,8 +98,6 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	mdev->mem.end = mdev->mem.start + size - 1;
 	mdev->mem.flags = IORESOURCE_MEM;
 
-	mdev->is_added = false;
-
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
 		goto err;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 32bf0b47e339..48343effc850 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -98,7 +98,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 3fd2dfaf2bd5..5150793492bf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1320,7 +1320,7 @@ void i40e_clear_hw(struct i40e_hw *hw)
 		     I40E_PFLAN_QALLOC_FIRSTQ_SHIFT;
 	j = (val & I40E_PFLAN_QALLOC_LASTQ_MASK) >>
 	    I40E_PFLAN_QALLOC_LASTQ_SHIFT;
-	if (val & I40E_PFLAN_QALLOC_VALID_MASK)
+	if (val & I40E_PFLAN_QALLOC_VALID_MASK && j >= base_queue)
 		num_queues = (j - base_queue) + 1;
 	else
 		num_queues = 0;
@@ -1330,7 +1330,7 @@ void i40e_clear_hw(struct i40e_hw *hw)
 	    I40E_PF_VT_PFALLOC_FIRSTVF_SHIFT;
 	j = (val & I40E_PF_VT_PFALLOC_LASTVF_MASK) >>
 	    I40E_PF_VT_PFALLOC_LASTVF_SHIFT;
-	if (val & I40E_PF_VT_PFALLOC_VALID_MASK)
+	if (val & I40E_PF_VT_PFALLOC_VALID_MASK && j >= i)
 		num_vfs = (j - i) + 1;
 	else
 		num_vfs = 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index f36bb9e7d8d5..3698c45837d8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -53,6 +53,9 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	struct vf_macvlans *mv_list;
 	int num_vf_macvlans, i;
 
+	/* Initialize list of VF macvlans */
+	INIT_LIST_HEAD(&adapter->vf_mvs.l);
+
 	num_vf_macvlans = hw->mac.num_rar_entries -
 			  (IXGBE_MAX_PF_MACVLANS + 1 + num_vfs);
 	if (!num_vf_macvlans)
@@ -61,8 +64,6 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
 			  GFP_KERNEL);
 	if (mv_list) {
-		/* Initialize list of VF macvlans */
-		INIT_LIST_HEAD(&adapter->vf_mvs.l);
 		for (i = 0; i < num_vf_macvlans; i++) {
 			mv_list[i].vf = -1;
 			mv_list[i].free = true;
diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
index b02b6523083c..99451585a45f 100644
--- a/drivers/net/ethernet/marvell/sky2.h
+++ b/drivers/net/ethernet/marvell/sky2.h
@@ -2201,7 +2201,7 @@ struct rx_ring_info {
 	struct sk_buff	*skb;
 	dma_addr_t	data_addr;
 	DEFINE_DMA_UNMAP_LEN(data_size);
-	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
+	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1];
 };
 
 enum flow_control {
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 4ec65582eaf7..d903106436dc 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2782,7 +2782,6 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 	struct device_node *np = spi->dev.of_node;
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 	struct ca8210_platform_data *pdata = spi->dev.platform_data;
-	int ret = 0;
 
 	if (!np)
 		return -EFAULT;
@@ -2799,18 +2798,8 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 		dev_crit(&spi->dev, "Failed to register external clk\n");
 		return PTR_ERR(priv->clk);
 	}
-	ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
-	if (ret) {
-		clk_unregister(priv->clk);
-		dev_crit(
-			&spi->dev,
-			"Failed to register external clock as clock provider\n"
-		);
-	} else {
-		dev_info(&spi->dev, "External clock set as clock provider\n");
-	}
 
-	return ret;
+	return of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
 }
 
 /**
@@ -2822,8 +2811,8 @@ static void ca8210_unregister_ext_clock(struct spi_device *spi)
 {
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 
-	if (!priv->clk)
-		return
+	if (IS_ERR_OR_NULL(priv->clk))
+		return;
 
 	of_clk_del_provider(spi->dev.of_node);
 	clk_unregister(priv->clk);
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 915ac75b55fc..5aad26600b03 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -221,13 +221,18 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 
 	__le16 res;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(dev->net, "Only internal phy supported\n");
 		return 0;
 	}
 
-	dm_read_shared_word(dev, 1, loc, &res);
+	err = dm_read_shared_word(dev, 1, loc, &res);
+	if (err < 0) {
+		netdev_err(dev->net, "MDIO read error: %d\n", err);
+		return err;
+	}
 
 	netdev_dbg(dev->net,
 		   "dm9601_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index b1e3ec3dcac3..e70eac578f5e 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1054,7 +1054,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 
 	if (timeout >= 100) {
 		netdev_warn(dev->net, "timeout waiting for completion of Lite Reset\n");
-		return ret;
+		return -ETIMEDOUT;
 	}
 
 	ret = smsc95xx_write_reg(dev, PM_CTRL, PM_CTL_PHY_RST_);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 213ce28395d4..4a0765bca8e7 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -143,6 +143,10 @@ int usb_device_supports_lpm(struct usb_device *udev)
 	if (udev->quirks & USB_QUIRK_NO_LPM)
 		return 0;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return 0;
+
 	/* USB 2.1 (and greater) devices indicate LPM support through
 	 * their USB 2.0 Extended Capabilities BOS descriptor.
 	 */
@@ -316,6 +320,10 @@ static void usb_set_lpm_parameters(struct usb_device *udev)
 	if (!udev->lpm_capable || udev->speed < USB_SPEED_SUPER)
 		return;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
 	hub = usb_hub_to_struct_hub(udev->parent);
 	/* It doesn't take time to transition the roothub into U0, since it
 	 * doesn't have an upstream link.
@@ -2621,7 +2629,8 @@ int usb_authorize_device(struct usb_device *usb_dev)
 }
 
 /*
- * Return 1 if port speed is SuperSpeedPlus, 0 otherwise
+ * Return 1 if port speed is SuperSpeedPlus, 0 otherwise or if the
+ * capability couldn't be checked.
  * check it from the link protocol field of the current speed ID attribute.
  * current speed ID is got from ext port status request. Sublink speed attribute
  * table is returned with the hub BOS SSP device capability descriptor
@@ -2631,8 +2640,12 @@ static int port_speed_is_ssp(struct usb_device *hdev, int speed_id)
 	int ssa_count;
 	u32 ss_attr;
 	int i;
-	struct usb_ssp_cap_descriptor *ssp_cap = hdev->bos->ssp_cap;
+	struct usb_ssp_cap_descriptor *ssp_cap;
 
+	if (!hdev->bos)
+		return 0;
+
+	ssp_cap = hdev->bos->ssp_cap;
 	if (!ssp_cap)
 		return 0;
 
@@ -3968,8 +3981,15 @@ static void usb_enable_link_state(struct usb_hcd *hcd, struct usb_device *udev,
 		enum usb3_link_state state)
 {
 	int timeout, ret;
-	__u8 u1_mel = udev->bos->ss_cap->bU1devExitLat;
-	__le16 u2_mel = udev->bos->ss_cap->bU2DevExitLat;
+	__u8 u1_mel;
+	__le16 u2_mel;
+
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
+	u1_mel = udev->bos->ss_cap->bU1devExitLat;
+	u2_mel = udev->bos->ss_cap->bU2DevExitLat;
 
 	/* If the device says it doesn't have *any* exit latency to come out of
 	 * U1 or U2, it's probably lying.  Assume it doesn't implement that link
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 064096e447ae..127303be41af 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -145,7 +145,7 @@ static inline int hub_is_superspeedplus(struct usb_device *hdev)
 {
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS &&
 		le16_to_cpu(hdev->descriptor.bcdUSB) >= 0x0310 &&
-		hdev->bos->ssp_cap);
+		hdev->bos && hdev->bos->ssp_cap);
 }
 
 static inline unsigned hub_power_on_good_delay(struct usb_hub *hub)
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 24a8e01e34fa..47d1f4e960cb 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1201,7 +1201,8 @@ static int ncm_unwrap_ntb(struct gether *port,
 			  struct sk_buff_head *list)
 {
 	struct f_ncm	*ncm = func_to_ncm(&port->func);
-	__le16		*tmp = (void *) skb->data;
+	unsigned char	*ntb_ptr = skb->data;
+	__le16		*tmp;
 	unsigned	index, index2;
 	int		ndp_index;
 	unsigned	dg_len, dg_len2;
@@ -1214,6 +1215,10 @@ static int ncm_unwrap_ntb(struct gether *port,
 	const struct ndp_parser_opts *opts = ncm->parser_opts;
 	unsigned	crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
 	int		dgram_counter;
+	int		to_process = skb->len;
+
+parse_ntb:
+	tmp = (__le16 *)ntb_ptr;
 
 	/* dwSignature */
 	if (get_unaligned_le32(tmp) != opts->nth_sign) {
@@ -1260,7 +1265,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 		 * walk through NDP
 		 * dwSignature
 		 */
-		tmp = (void *)(skb->data + ndp_index);
+		tmp = (__le16 *)(ntb_ptr + ndp_index);
 		if (get_unaligned_le32(tmp) != ncm->ndp_sign) {
 			INFO(port->func.config->cdev, "Wrong NDP SIGN\n");
 			goto err;
@@ -1317,11 +1322,11 @@ static int ncm_unwrap_ntb(struct gether *port,
 			if (ncm->is_crc) {
 				uint32_t crc, crc2;
 
-				crc = get_unaligned_le32(skb->data +
+				crc = get_unaligned_le32(ntb_ptr +
 							 index + dg_len -
 							 crc_len);
 				crc2 = ~crc32_le(~0,
-						 skb->data + index,
+						 ntb_ptr + index,
 						 dg_len - crc_len);
 				if (crc != crc2) {
 					INFO(port->func.config->cdev,
@@ -1348,7 +1353,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 							 dg_len - crc_len);
 			if (skb2 == NULL)
 				goto err;
-			skb_put_data(skb2, skb->data + index,
+			skb_put_data(skb2, ntb_ptr + index,
 				     dg_len - crc_len);
 
 			skb_queue_tail(list, skb2);
@@ -1361,10 +1366,17 @@ static int ncm_unwrap_ntb(struct gether *port,
 		} while (ndp_len > 2 * (opts->dgram_item_len * 2));
 	} while (ndp_index);
 
-	dev_consume_skb_any(skb);
-
 	VDBG(port->func.config->cdev,
 	     "Parsed NTB with %d frames\n", dgram_counter);
+
+	to_process -= block_len;
+	if (to_process != 0) {
+		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
+		goto parse_ntb;
+	}
+
+	dev_consume_skb_any(skb);
+
 	return 0;
 err:
 	skb_queue_purge(list);
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index c2e396e00492..11ad940e25e3 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -501,11 +501,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		/* Get the Buffer address and copy the transmit data.*/
 		eprambase = (u32 __force *)(udc->addr + ep->rambase);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF0COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -519,11 +521,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		eprambase = (u32 __force *)(udc->addr + ep->rambase +
 			     ep->ep_usb.maxpacket);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF1COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -1027,7 +1031,7 @@ static int __xudc_ep0_queue(struct xusb_ep *ep0, struct xusb_req *req)
 			   udc->addr);
 		length = req->usb_req.actual = min_t(u32, length,
 						     EP0_MAX_PACKET);
-		memcpy(corebuf, req->usb_req.buf, length);
+		memcpy_toio((void __iomem *)corebuf, req->usb_req.buf, length);
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, length);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
 	} else {
@@ -1753,7 +1757,7 @@ static void xudc_handle_setup(struct xusb_udc *udc)
 
 	/* Load up the chapter 9 command buffer.*/
 	ep0rambase = (u32 __force *) (udc->addr + XUSB_SETUP_PKT_ADDR_OFFSET);
-	memcpy(&setup, ep0rambase, 8);
+	memcpy_toio((void __iomem *)&setup, ep0rambase, 8);
 
 	udc->setup = setup;
 	udc->setup.wValue = cpu_to_le16(setup.wValue);
@@ -1840,7 +1844,7 @@ static void xudc_ep0_out(struct xusb_udc *udc)
 			     (ep0->rambase << 2));
 		buffer = req->usb_req.buf + req->usb_req.actual;
 		req->usb_req.actual = req->usb_req.actual + bytes_to_rx;
-		memcpy(buffer, ep0rambase, bytes_to_rx);
+		memcpy_toio((void __iomem *)buffer, ep0rambase, bytes_to_rx);
 
 		if (req->usb_req.length == req->usb_req.actual) {
 			/* Data transfer completed get ready for Status stage */
@@ -1916,7 +1920,7 @@ static void xudc_ep0_in(struct xusb_udc *udc)
 				     (ep0->rambase << 2));
 			buffer = req->usb_req.buf + req->usb_req.actual;
 			req->usb_req.actual = req->usb_req.actual + length;
-			memcpy(ep0rambase, buffer, length);
+			memcpy_toio((void __iomem *)ep0rambase, buffer, length);
 		}
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, count);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index abb1cc5f566a..63ea58e64774 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -700,7 +700,7 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
 static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 		struct xhci_ring *ring, struct xhci_td *td)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_segment *seg = td->bounce_seg;
 	struct urb *urb = td->urb;
 	size_t len;
@@ -3272,7 +3272,7 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 static int xhci_align_td(struct xhci_hcd *xhci, struct urb *urb, u32 enqd_len,
 			 u32 *trb_buff_len, struct xhci_segment *seg)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int unalign;
 	unsigned int max_pkt;
 	u32 new_buff_len;
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 480b2119f1e7..20bc4d1f85b1 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -64,7 +64,7 @@ static const struct musb_register_map musb_regmap[] = {
 	{ "IntrUsbE",	MUSB_INTRUSBE,	8 },
 	{ "DevCtl",	MUSB_DEVCTL,	8 },
 	{ "VControl",	0x68,		32 },
-	{ "HWVers",	0x69,		16 },
+	{ "HWVers",	MUSB_HWVERS,	16 },
 	{ "LinkInfo",	MUSB_LINKINFO,	8 },
 	{ "VPLen",	MUSB_VPLEN,	8 },
 	{ "HS_EOF1",	MUSB_HS_EOF1,	8 },
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 3ec0752e67ac..3ac80ef76d31 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -366,10 +366,16 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
 
+	/*
+	 * musb->lock had been unlocked in musb_giveback, so qh may
+	 * be freed, need to get it again
+	 */
+	qh = musb_ep_get_qh(hw_ep, is_in);
+
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
 	 * invalidate qh as soon as list_empty(&hep->urb_list)
 	 */
-	if (list_empty(&qh->hep->urb_list)) {
+	if (qh && list_empty(&qh->hep->urb_list)) {
 		struct list_head	*head;
 		struct dma_controller	*dma = musb->dma_controller;
 
@@ -2459,6 +2465,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		 * and its URB list has emptied, recycle this qh.
 		 */
 		if (ready && list_empty(&qh->hep->urb_list)) {
+			musb_ep_set_qh(qh->hw_ep, is_in, NULL);
 			qh->hep->hcpriv = NULL;
 			list_del(&qh->ring);
 			kfree(qh);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8792aca5bc27..43a812f4edb6 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -206,6 +206,9 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
+#define DELL_PRODUCT_FM101R			0x8213
+#define DELL_PRODUCT_FM101R_ESIM		0x8215
+
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
 #define KYOCERA_PRODUCT_KPC680			0x180a
@@ -1111,6 +1114,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(6) },
 	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM),
 	  .driver_info = RSVD(0) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R, 0xff) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R_ESIM, 0xff) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_500A) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_620UW) },
@@ -1293,6 +1298,7 @@ static const struct usb_device_id option_ids[] = {
 	 .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1033, 0xff),	/* Telit LE910C1-EUX (ECM) */
 	 .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1035, 0xff) }, /* Telit LE910C4-WWX (ECM) */
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG0),
 	  .driver_info = RSVD(0) | RSVD(1) | NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG1),
@@ -2264,6 +2270,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ } /* Terminating entry */
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2407a231d9ad..f73a1438a6ac 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4191,7 +4191,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int slot;
 	int ins_nr = 0;
-	int start_slot;
+	int start_slot = 0;
 	int ret;
 
 	if (!(inode->flags & BTRFS_INODE_PREALLOC))
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 90db2cd07840..4dd7c77dcf9e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -615,9 +615,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 			ci->i_truncate_seq = truncate_seq;
 
 			/* the MDS should have revoked these caps */
-			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_EXCL |
-					       CEPH_CAP_FILE_RD |
-					       CEPH_CAP_FILE_WR |
+			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_RD |
 					       CEPH_CAP_FILE_LAZYIO));
 			/*
 			 * If we hold relevant caps, or in the case where we're
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index f3ed80e2966c..4a5b0f3c6af3 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -201,7 +201,7 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid =
-		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET,
+		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_CTIME,
 		.ia_atime = stat->atime,
 		.ia_mtime = stat->mtime,
 	};
diff --git a/include/linux/mcb.h b/include/linux/mcb.h
index b1a0ad9d23b3..8052e5f20630 100644
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -66,7 +66,6 @@ static inline struct mcb_bus *to_mcb_bus(struct device *dev)
 struct mcb_device {
 	struct device dev;
 	struct mcb_bus *bus;
-	bool is_added;
 	struct mcb_driver *driver;
 	u16 id;
 	int inst;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e175d5e3acd6..bcc80855f681 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -579,6 +579,7 @@ struct perf_event {
 	/* The cumulative AND of all event_caps for events in this group. */
 	int				group_caps;
 
+	unsigned int			group_generation;
 	struct perf_event		*group_leader;
 	struct pmu			*pmu;
 	void				*pmu_private;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d42288a06af6..8f899ad4a754 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -205,7 +205,7 @@ struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
 
-	char		name[8];
+	const char	*name;
 	unsigned long	flags;
 	__u16		id;
 	__u8		bus;
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 9991e5ef52cc..e3775b260bb3 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -48,6 +48,7 @@ struct netns_xfrm {
 	struct list_head	policy_all;
 	struct hlist_head	*policy_byidx;
 	unsigned int		policy_idx_hmask;
+	unsigned int		idx_generator;
 	struct hlist_head	policy_inexact[XFRM_POLICY_MAX];
 	struct xfrm_policy_hash	policy_bydst[XFRM_POLICY_MAX];
 	unsigned int		policy_count[XFRM_POLICY_MAX * 2];
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a14182e90f57..73a793be0612 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -392,10 +392,9 @@ static int pidlist_array_load(struct cgroup *cgrp, enum cgroup_filetype type,
 	}
 	css_task_iter_end(&it);
 	length = n;
-	/* now sort & (if procs) strip out duplicates */
+	/* now sort & strip out duplicates (tgids or recycled thread PIDs) */
 	sort(array, length, sizeof(pid_t), cmppid, NULL);
-	if (type == CGROUP_FILE_PROCS)
-		length = pidlist_uniq(array, length);
+	length = pidlist_uniq(array, length);
 
 	l = cgroup_pidlist_find_create(cgrp, type);
 	if (!l) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6e15f3a9696a..7ece49c14b74 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1699,6 +1699,7 @@ static void perf_group_attach(struct perf_event *event)
 
 	list_add_tail(&event->group_entry, &group_leader->sibling_list);
 	group_leader->nr_siblings++;
+	group_leader->group_generation++;
 
 	perf_event__header_size(group_leader);
 
@@ -1771,6 +1772,7 @@ static void perf_group_detach(struct perf_event *event)
 	if (event->group_leader != event) {
 		list_del_init(&event->group_entry);
 		event->group_leader->nr_siblings--;
+		event->group_leader->group_generation++;
 		goto out;
 	}
 
@@ -4483,7 +4485,7 @@ static int __perf_read_group_add(struct perf_event *leader,
 					u64 read_format, u64 *values)
 {
 	struct perf_event_context *ctx = leader->ctx;
-	struct perf_event *sub;
+	struct perf_event *sub, *parent;
 	unsigned long flags;
 	int n = 1; /* skip @nr */
 	int ret;
@@ -4493,6 +4495,33 @@ static int __perf_read_group_add(struct perf_event *leader,
 		return ret;
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
+	/*
+	 * Verify the grouping between the parent and child (inherited)
+	 * events is still in tact.
+	 *
+	 * Specifically:
+	 *  - leader->ctx->lock pins leader->sibling_list
+	 *  - parent->child_mutex pins parent->child_list
+	 *  - parent->ctx->mutex pins parent->sibling_list
+	 *
+	 * Because parent->ctx != leader->ctx (and child_list nests inside
+	 * ctx->mutex), group destruction is not atomic between children, also
+	 * see perf_event_release_kernel(). Additionally, parent can grow the
+	 * group.
+	 *
+	 * Therefore it is possible to have parent and child groups in a
+	 * different configuration and summing over such a beast makes no sense
+	 * what so ever.
+	 *
+	 * Reject this.
+	 */
+	parent = leader->parent;
+	if (parent &&
+	    (parent->group_generation != leader->group_generation ||
+	     parent->nr_siblings != leader->nr_siblings)) {
+		ret = -ECHILD;
+		goto unlock;
+	}
 
 	/*
 	 * Since we co-schedule groups, {enabled,running} times of siblings
@@ -4522,8 +4551,9 @@ static int __perf_read_group_add(struct perf_event *leader,
 			values[n++] = primary_event_id(sub);
 	}
 
+unlock:
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
-	return 0;
+	return ret;
 }
 
 static int perf_read_group(struct perf_event *event,
@@ -4542,10 +4572,6 @@ static int perf_read_group(struct perf_event *event,
 
 	values[0] = 1 + leader->nr_siblings;
 
-	/*
-	 * By locking the child_mutex of the leader we effectively
-	 * lock the child list of all siblings.. XXX explain how.
-	 */
 	mutex_lock(&leader->child_mutex);
 
 	ret = __perf_read_group_add(leader, read_format, values);
@@ -11033,6 +11059,7 @@ static int inherit_group(struct perf_event *parent_event,
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
 	}
+	leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 37be6913cfb2..f29552b009c8 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2240,6 +2240,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_printk(call, map[i]);
 			}
 		}
+		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 87eca8d1faad..69238bc8be50 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5001,9 +5001,13 @@ static int workqueue_apply_unbound_cpumask(void)
 	list_for_each_entry(wq, &workqueues, list) {
 		if (!(wq->flags & WQ_UNBOUND))
 			continue;
+
 		/* creating multiple pwqs breaks ordering guarantee */
-		if (wq->flags & __WQ_ORDERED)
-			continue;
+		if (!list_empty(&wq->pwqs)) {
+			if (wq->flags & __WQ_ORDERED_EXPLICIT)
+				continue;
+			wq->flags &= ~__WQ_ORDERED;
+		}
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs);
 		if (!ctx) {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e3cd81ce2a7b..ce4bbc426946 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1085,6 +1085,15 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Reject outgoing connection to device with same BD ADDR against
+	 * CVE-2020-26555
+	 */
+	if (!bacmp(&hdev->bdaddr, dst)) {
+		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
+			   dst);
+		return ERR_PTR(-ECONNREFUSED);
+	}
+
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
@@ -1260,34 +1269,41 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 	if (!test_bit(HCI_CONN_AUTH, &conn->flags))
 		goto auth;
 
-	/* An authenticated FIPS approved combination key has sufficient
-	 * security for security level 4. */
-	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256 &&
-	    sec_level == BT_SECURITY_FIPS)
-		goto encrypt;
-
-	/* An authenticated combination key has sufficient security for
-	   security level 3. */
-	if ((conn->key_type == HCI_LK_AUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_AUTH_COMBINATION_P256) &&
-	    sec_level == BT_SECURITY_HIGH)
-		goto encrypt;
-
-	/* An unauthenticated combination key has sufficient security for
-	   security level 1 and 2. */
-	if ((conn->key_type == HCI_LK_UNAUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_UNAUTH_COMBINATION_P256) &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
-		goto encrypt;
-
-	/* A combination key has always sufficient security for the security
-	   levels 1 or 2. High security level requires the combination key
-	   is generated using maximum PIN code length (16).
-	   For pre 2.1 units. */
-	if (conn->key_type == HCI_LK_COMBINATION &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW ||
-	     conn->pin_length == 16))
-		goto encrypt;
+	switch (conn->key_type) {
+	case HCI_LK_AUTH_COMBINATION_P256:
+		/* An authenticated FIPS approved combination key has
+		 * sufficient security for security level 4 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_FIPS)
+			goto encrypt;
+		break;
+	case HCI_LK_AUTH_COMBINATION_P192:
+		/* An authenticated combination key has sufficient security for
+		 * security level 3 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_HIGH)
+			goto encrypt;
+		break;
+	case HCI_LK_UNAUTH_COMBINATION_P192:
+	case HCI_LK_UNAUTH_COMBINATION_P256:
+		/* An unauthenticated combination key has sufficient security
+		 * for security level 2 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM)
+			goto encrypt;
+		break;
+	case HCI_LK_COMBINATION:
+		/* A combination key has always sufficient security for the
+		 * security levels 2 or lower. High security level requires the
+		 * combination key is generated using maximum PIN code length
+		 * (16). For pre 2.1 units.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM || conn->pin_length == 16)
+			goto encrypt;
+		break;
+	default:
+		break;
+	}
 
 auth:
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7052434c1061..2bf0bdee7186 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3113,7 +3113,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (id < 0)
 		return id;
 
-	snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
+	error = dev_set_name(&hdev->dev, "hci%u", id);
+	if (error)
+		return error;
+
+	hdev->name = dev_name(&hdev->dev);
 	hdev->id = id;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
@@ -3135,8 +3139,6 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!IS_ERR_OR_NULL(bt_debugfs))
 		hdev->debugfs = debugfs_create_dir(hdev->name, bt_debugfs);
 
-	dev_set_name(&hdev->dev, "%s", hdev->name);
-
 	error = device_add(&hdev->dev);
 	if (error < 0)
 		goto err_wqueue;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4eeba9dfb38f..bf863cf845bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -25,6 +25,8 @@
 /* Bluetooth HCI event handling. */
 
 #include <asm/unaligned.h>
+#include <linux/crypto.h>
+#include <crypto/algapi.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -2247,6 +2249,16 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
 	       ev->link_type);
 
+	/* Reject incoming connection from device with same BD ADDR against
+	 * CVE-2020-26555
+	 */
+	if (hdev && !bacmp(&hdev->bdaddr, &ev->bdaddr)) {
+		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
+			   &ev->bdaddr);
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
+	}
+
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type,
 				      &flags);
 
@@ -3494,6 +3506,15 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
+	/* Ignore NULL link key against CVE-2020-26555 */
+	if (!crypto_memneq(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+		bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR",
+			   &ev->bdaddr);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	hci_conn_hold(conn);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(conn);
@@ -3972,8 +3993,8 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 		 * available, then do not declare that OOB data is
 		 * present.
 		 */
-		if (!memcmp(data->rand256, ZERO_KEY, 16) ||
-		    !memcmp(data->hash256, ZERO_KEY, 16))
+		if (!crypto_memneq(data->rand256, ZERO_KEY, 16) ||
+		    !crypto_memneq(data->hash256, ZERO_KEY, 16))
 			return 0x00;
 
 		return 0x02;
@@ -3983,8 +4004,8 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 	 * not supported by the hardware, then check that if
 	 * P-192 data values are present.
 	 */
-	if (!memcmp(data->rand192, ZERO_KEY, 16) ||
-	    !memcmp(data->hash192, ZERO_KEY, 16))
+	if (!crypto_memneq(data->rand192, ZERO_KEY, 16) ||
+	    !crypto_memneq(data->hash192, ZERO_KEY, 16))
 		return 0x00;
 
 	return 0x01;
@@ -4000,7 +4021,7 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn)
+	if (!conn || !hci_conn_ssp_enabled(conn))
 		goto unlock;
 
 	hci_conn_hold(conn);
@@ -4235,7 +4256,7 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn)
+	if (!conn || !hci_conn_ssp_enabled(conn))
 		goto unlock;
 
 	/* Reset the authentication requirement to unknown */
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 9b1658346396..b67fc4c44afa 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -425,7 +425,8 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
-		memcpy(ni->name, hdev->name, 8);
+		memcpy_and_pad(ni->name, sizeof(ni->name), hdev->name,
+			       strnlen(hdev->name, sizeof(ni->name)), '\0');
 
 		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
 		break;
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d5e860573ecd..79fa2d7852ef 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -547,7 +547,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index e19624245e16..25c12d0ccd28 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -499,7 +499,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 7e62a55a03de..3914214dee05 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -650,7 +650,8 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		}
 
 		if (unlikely(tx->key && tx->key->flags & KEY_FLAG_TAINTED &&
-			     !ieee80211_is_deauth(hdr->frame_control)))
+			     !ieee80211_is_deauth(hdr->frame_control)) &&
+			     tx->skb->protocol != tx->sdata->control_port_protocol)
 			return TX_DROP;
 
 		if (!skip_hw && tx->key &&
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 77cfd5182784..0ef51c81ec94 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -84,7 +84,7 @@ static void nft_payload_eval(const struct nft_expr *expr,
 
 	switch (priv->base) {
 	case NFT_PAYLOAD_LL_HEADER:
-		if (!skb_mac_header_was_set(skb))
+		if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) == 0)
 			goto err;
 
 		if (skb_vlan_tag_present(skb)) {
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 216228c39acb..d42c603dd635 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -906,6 +906,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
 		return -EINVAL;
 	}
 
+	if (protocol >= NFC_PROTO_MAX) {
+		pr_err("the requested nfc protocol is invalid\n");
+		return -EINVAL;
+	}
+
 	if (!(nci_target->supported_protocols & (1 << protocol))) {
 		pr_err("target does not support the requested protocol 0x%x\n",
 		       protocol);
diff --git a/net/nfc/nci/spi.c b/net/nfc/nci/spi.c
index 452f4c16b7a9..d2de7fc226f0 100644
--- a/net/nfc/nci/spi.c
+++ b/net/nfc/nci/spi.c
@@ -163,6 +163,8 @@ static int send_acknowledge(struct nci_spi *nspi, u8 acknowledge)
 	int ret;
 
 	skb = nci_skb_alloc(nspi->ndev, 0, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
 
 	/* add the NCI SPI header to the start of the buffer */
 	hdr = skb_push(skb, NCI_SPI_HDR_LEN);
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 00192a996be0..f8f3b1a8f8e3 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -111,13 +111,13 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 
 	rfkill->clk = devm_clk_get(&pdev->dev, NULL);
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
 	rfkill->reset_gpio = gpio;
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7085c54e6e50..b4b564182db0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6159,7 +6159,7 @@ static int nl80211_update_mesh_config(struct sk_buff *skb,
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct mesh_config cfg;
+	struct mesh_config cfg = {};
 	u32 mask;
 	int err;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 66c23a1b8758..05844a0f6df5 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -646,8 +646,6 @@ EXPORT_SYMBOL(xfrm_policy_hash_rebuild);
  * of an absolute inpredictability of ordering of rules. This will not pass. */
 static u32 xfrm_gen_index(struct net *net, int dir, u32 index)
 {
-	static u32 idx_generator;
-
 	for (;;) {
 		struct hlist_head *list;
 		struct xfrm_policy *p;
@@ -655,8 +653,8 @@ static u32 xfrm_gen_index(struct net *net, int dir, u32 index)
 		int found;
 
 		if (!index) {
-			idx = (idx_generator | dir);
-			idx_generator += 8;
+			idx = (net->xfrm.idx_generator | dir);
+			net->xfrm.idx_generator += 8;
 		} else {
 			idx = index;
 			index = 0;
