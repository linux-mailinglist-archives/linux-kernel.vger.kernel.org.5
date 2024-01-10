Return-Path: <linux-kernel+bounces-17952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA858255FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939311F275A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EAE2E655;
	Fri,  5 Jan 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ciT0en+1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1012E62C;
	Fri,  5 Jan 2024 14:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5FDC433C8;
	Fri,  5 Jan 2024 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465874;
	bh=Qu5Ba9pjxDMqAyyksZpysRfk8yPWR2RsoxGXQoSU314=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ciT0en+1vkK8jrrgLxEXbsvuvjv5LOO1pj87q5O/Wqjq8uvnknJX42Ifi/4G+Fnuc
	 loWIyXaMPnHFSRw2pb8XQziWH8Ya7h5xuYRTVJ5UoxWqNnAoBP5mO5mg82R7xLlm8A
	 QAdG8LC+QMe+ykg3Q8Q2Zjo40LTp3rxieliIYJEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.206
Date: Fri,  5 Jan 2024 15:42:27 +0100
Message-ID: <2024010527-kung-lurk-8e85@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024010527-revision-ended-aea2@gregkh>
References: <2024010527-revision-ended-aea2@gregkh>
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
index 5ba86be42e7c..134fba99314d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 205
+SUBLEVEL = 206
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f09a61cac2dc..3d064eb29099 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -347,6 +347,7 @@ usb: target-module@47400000 {
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>,
 					<SYSC_IDLE_SMART_WKUP>;
+			ti,sysc-delay-us = <2>;
 			clocks = <&l3s_clkctrl AM3_L3S_USB_OTG_HS_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
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
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 18ebacf29889..57839f63074f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -468,7 +468,6 @@ config MACH_LOONGSON2EF
 
 config MACH_LOONGSON64
 	bool "Loongson 64-bit family of machines"
-	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
@@ -1380,7 +1379,6 @@ config CPU_LOONGSON64
 	select CPU_SUPPORTS_MSA
 	select CPU_DIEI_BROKEN if !LOONGSON3_ENHANCEMENT
 	select CPU_MIPSR2_IRQ_VI
-	select DMA_NONCOHERENT
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select MIPS_ASID_BITS_VARIABLE
diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index de0bd14d798a..afc92b7a61c6 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -117,8 +117,7 @@ struct irq_source_routing_table {
 	u64 pci_io_start_addr;
 	u64 pci_io_end_addr;
 	u64 pci_config_addr;
-	u16 dma_mask_bits;
-	u16 dma_noncoherent;
+	u32 dma_mask_bits;
 } __packed;
 
 struct interface_info {
diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
index a59bae36f86a..134cb8e9efc2 100644
--- a/arch/mips/loongson64/env.c
+++ b/arch/mips/loongson64/env.c
@@ -13,8 +13,6 @@
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  */
-
-#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/pci_ids.h>
 #include <asm/bootinfo.h>
@@ -133,14 +131,8 @@ void __init prom_init_env(void)
 	loongson_sysconf.pci_io_base = eirq_source->pci_io_start_addr;
 	loongson_sysconf.dma_mask_bits = eirq_source->dma_mask_bits;
 	if (loongson_sysconf.dma_mask_bits < 32 ||
-			loongson_sysconf.dma_mask_bits > 64) {
+		loongson_sysconf.dma_mask_bits > 64)
 		loongson_sysconf.dma_mask_bits = 32;
-		dma_default_coherent = true;
-	} else {
-		dma_default_coherent = !eirq_source->dma_noncoherent;
-	}
-
-	pr_info("Firmware: Coherent DMA: %s\n", dma_default_coherent ? "on" : "off");
 
 	loongson_sysconf.restart_addr = boot_p->reset_system.ResetWarm;
 	loongson_sysconf.poweroff_addr = boot_p->reset_system.Shutdown;
diff --git a/arch/s390/include/asm/fpu/api.h b/arch/s390/include/asm/fpu/api.h
index 34a7ae68485c..be16a6c0f127 100644
--- a/arch/s390/include/asm/fpu/api.h
+++ b/arch/s390/include/asm/fpu/api.h
@@ -76,7 +76,7 @@ static inline int test_fp_ctl(u32 fpc)
 #define KERNEL_VXR_HIGH		(KERNEL_VXR_V16V23|KERNEL_VXR_V24V31)
 
 #define KERNEL_VXR		(KERNEL_VXR_LOW|KERNEL_VXR_HIGH)
-#define KERNEL_FPR		(KERNEL_FPC|KERNEL_VXR_V0V7)
+#define KERNEL_FPR		(KERNEL_FPC|KERNEL_VXR_LOW)
 
 struct kernel_fpu;
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d58621f0fe51..9e0a3daa838c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1093,8 +1093,8 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	} else {
 		local_irq_save(flags);
 		memcpy(addr, opcode, len);
-		local_irq_restore(flags);
 		sync_core();
+		local_irq_restore(flags);
 
 		/*
 		 * Could also do a CLFLUSH here to speed up CPU recovery; but
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index ef8c7bfd79a8..b1aa793b9eed 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2093,13 +2093,23 @@ static int sysc_reset(struct sysc *ddata)
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
 
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a1bc8a2c3ead..b915dfcff00d 100644
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
index e946903b0993..0ae57d6cfc49 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -640,8 +640,10 @@ static int tiadc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	err = tiadc_request_dma(pdev, adc_dev);
-	if (err && err == -EPROBE_DEFER)
+	if (err && err != -ENODEV) {
+		dev_err_probe(&pdev->dev, err, "DMA request failed\n");
 		goto err_dma;
+	}
 
 	return 0;
 
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index b9e2038d05ef..74806807a071 100644
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
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index ae391ec4a727..533c71a0dd01 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -707,13 +707,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
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
index e3f9e445e880..fe5a9c54ad58 100644
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
index 7db6d0fc6ec2..9390e2210663 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -380,6 +380,9 @@ struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 	}
 	mutex_unlock(&icc_lock);
 
+	if (!node)
+		return ERR_PTR(-EINVAL);
+
 	if (IS_ERR(node))
 		return ERR_CAST(node);
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 1667ac140609..62cae34ca3b4 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1657,11 +1657,12 @@ static void integrity_metadata(struct work_struct *w)
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
@@ -1670,7 +1671,7 @@ static void integrity_metadata(struct work_struct *w)
 				sectors_to_process -= ic->sectors_per_block;
 				pos += ic->sectors_per_block << SECTOR_SHIFT;
 				sector += ic->sectors_per_block;
-			} while (pos < bv.bv_len && sectors_to_process && checksums != checksums_onstack);
+			} while (pos < bv_copy.bv_len && sectors_to_process && checksums != checksums_onstack);
 			kunmap_atomic(mem);
 
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
@@ -1691,9 +1692,9 @@ static void integrity_metadata(struct work_struct *w)
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
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 696ce3c5a8ba..e8772972bc2f 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 86088ccab23a..d49fd21f4963 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 05bcd69994ec..90930e54b6f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -267,6 +267,9 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv4_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -283,8 +286,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv4_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	mlx5e_route_lookup_ipv4_put(route_dev, n);
@@ -430,6 +431,9 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv6_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -447,8 +451,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv6_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	mlx5e_route_lookup_ipv6_put(route_dev, n);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index f9f1a79d6bdd..6512bb231e7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -68,7 +68,7 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
 	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
-	if (count == sizeof(drvinfo->fw_version))
+	if (count >= sizeof(drvinfo->fw_version))
 		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index fc91bbf7d0c3..e77cf11356c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -276,7 +276,7 @@ int mlx5_query_nic_vport_mac_list(struct mlx5_core_dev *dev,
 		req_list_size = max_list_size;
 	}
 
-	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_in) +
+	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_out) +
 			req_list_size * MLX5_ST_SZ_BYTES(mac_address_layout);
 
 	out = kzalloc(out_sz, GFP_KERNEL);
diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
index 2b319e451121..0f37448d2665 100644
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
@@ -398,6 +400,7 @@ struct ks8851_net {
 	struct work_struct	rxctrl_work;
 
 	struct sk_buff_head	txq;
+	unsigned int		queued_len;
 
 	struct eeprom_93cx6	eeprom;
 	struct regulator	*vdd_reg;
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index f74eae8eed02..3d0ac7f3c87e 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -363,16 +363,18 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
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
@@ -415,9 +417,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	if (status & IRQ_TXI)
-		netif_wake_queue(ks->netdev);
-
 	return IRQ_HANDLED;
 }
 
@@ -501,6 +500,7 @@ static int ks8851_net_open(struct net_device *dev)
 	ks8851_wrreg16(ks, KS_ISR, ks->rc_ier);
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);
 
+	ks->queued_len = 0;
 	netif_start_queue(ks->netdev);
 
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 4ec7f1615977..8fb5a4cd21bb 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -288,6 +288,18 @@ static void ks8851_wrfifo_spi(struct ks8851_net *ks, struct sk_buff *txp,
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
@@ -307,7 +319,9 @@ static void ks8851_rx_skb_spi(struct ks8851_net *ks, struct sk_buff *skb)
  */
 static void ks8851_tx_work(struct work_struct *work)
 {
+	unsigned int dequeued_len = 0;
 	struct ks8851_net_spi *kss;
+	unsigned short tx_space;
 	struct ks8851_net *ks;
 	unsigned long flags;
 	struct sk_buff *txb;
@@ -324,6 +338,8 @@ static void ks8851_tx_work(struct work_struct *work)
 		last = skb_queue_empty(&ks->txq);
 
 		if (txb) {
+			dequeued_len += calc_txlen(txb->len);
+
 			ks8851_wrreg16_spi(ks, KS_RXQCR,
 					   ks->rc_rxqcr | RXQCR_SDA);
 			ks8851_wrfifo_spi(ks, txb, last);
@@ -334,6 +350,13 @@ static void ks8851_tx_work(struct work_struct *work)
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
 
@@ -348,18 +371,6 @@ static void ks8851_flush_tx_work_spi(struct ks8851_net *ks)
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
@@ -388,16 +399,17 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_buff *skb,
 
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
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index bf8aa0ea35d1..e26c496cdfb8 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -999,6 +999,13 @@ static const struct of_device_id atmel_pctrl_of_match[] = {
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
@@ -1148,6 +1155,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		irq_set_chip_and_handler(irq, &atmel_gpio_irq_chip,
 					 handle_simple_irq);
 		irq_set_chip_data(irq, atmel_pioctrl);
+		irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
 		dev_dbg(dev,
 			"atmel gpio irq domain: hwirq: %d, linux irq: %d\n",
 			i, irq);
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index f93388b9a4a1..662867435fbe 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -599,6 +599,9 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 {
 	lockdep_assert_held(&reset_list_mutex);
 
+	if (IS_ERR_OR_NULL(rstc))
+		return;
+
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 8f47bf83694f..45dbab8cbb54 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -430,7 +430,6 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct fcoe_ctlr *ctlr;
 	struct fcoe_rcv_info *fr;
 	struct fcoe_percpu_s *bg;
-	struct sk_buff *tmp_skb;
 
 	interface = container_of(ptype, struct bnx2fc_interface,
 				 fcoe_packet_type);
@@ -442,11 +441,9 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
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
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index d6c25a88cebc..034f2c8a9e0b 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -197,7 +197,7 @@ void scsi_finish_command(struct scsi_cmnd *cmd)
 				"(result %x)\n", cmd->result));
 
 	good_bytes = scsi_bufflen(cmd);
-	if (!blk_rq_is_passthrough(cmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
 		int old_good_bytes = good_bytes;
 		drv = scsi_cmd_to_driver(cmd);
 		if (drv->done)
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 0c4bc42b55c2..30eb8769dbab 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -50,8 +50,6 @@
 
 #include <asm/unaligned.h>
 
-static void scsi_eh_done(struct scsi_cmnd *scmd);
-
 /*
  * These should *probably* be handled by the host itself.
  * Since it is allowed to sleep, it probably should.
@@ -230,7 +228,7 @@ scsi_abort_command(struct scsi_cmnd *scmd)
  */
 static void scsi_eh_reset(struct scsi_cmnd *scmd)
 {
-	if (!blk_rq_is_passthrough(scmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_reset)
 			sdrv->eh_reset(scmd);
@@ -500,7 +498,8 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
 		/* handler does not care. Drop down to default handling */
 	}
 
-	if (scmd->cmnd[0] == TEST_UNIT_READY && scmd->scsi_done != scsi_eh_done)
+	if (scmd->cmnd[0] == TEST_UNIT_READY &&
+	    scmd->submitter != SUBMITTED_BY_SCSI_ERROR_HANDLER)
 		/*
 		 * nasty: for mid-layer issued TURs, we need to return the
 		 * actual sense data without any recovery attempt.  For eh
@@ -768,7 +767,7 @@ static int scsi_eh_completed_normally(struct scsi_cmnd *scmd)
  * scsi_eh_done - Completion function for error handling.
  * @scmd:	Cmd that is done.
  */
-static void scsi_eh_done(struct scsi_cmnd *scmd)
+void scsi_eh_done(struct scsi_cmnd *scmd)
 {
 	struct completion *eh_action;
 
@@ -1068,7 +1067,8 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	shost->eh_action = &done;
 
 	scsi_log_send(scmd);
-	scmd->scsi_done = scsi_eh_done;
+	scmd->submitter = SUBMITTED_BY_SCSI_ERROR_HANDLER;
+	scmd->flags |= SCMD_LAST;
 
 	/*
 	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
@@ -1095,6 +1095,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	if (rtn) {
 		if (timeleft > stall_for) {
 			scsi_eh_restore_cmnd(scmd, &ses);
+
 			timeleft -= stall_for;
 			msleep(jiffies_to_msecs(stall_for));
 			goto retry;
@@ -1167,7 +1168,7 @@ static int scsi_request_sense(struct scsi_cmnd *scmd)
 
 static int scsi_eh_action(struct scsi_cmnd *scmd, int rtn)
 {
-	if (!blk_rq_is_passthrough(scmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_action)
 			rtn = sdrv->eh_action(scmd, rtn);
@@ -1733,22 +1734,24 @@ static void scsi_eh_offline_sdevs(struct list_head *work_q,
  */
 int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 {
+	struct request *req = scsi_cmd_to_rq(scmd);
+
 	switch (host_byte(scmd->result)) {
 	case DID_OK:
 		break;
 	case DID_TIME_OUT:
 		goto check_type;
 	case DID_BUS_BUSY:
-		return (scmd->request->cmd_flags & REQ_FAILFAST_TRANSPORT);
+		return req->cmd_flags & REQ_FAILFAST_TRANSPORT;
 	case DID_PARITY:
-		return (scmd->request->cmd_flags & REQ_FAILFAST_DEV);
+		return req->cmd_flags & REQ_FAILFAST_DEV;
 	case DID_ERROR:
 		if (msg_byte(scmd->result) == COMMAND_COMPLETE &&
 		    status_byte(scmd->result) == RESERVATION_CONFLICT)
 			return 0;
 		fallthrough;
 	case DID_SOFT_ERROR:
-		return (scmd->request->cmd_flags & REQ_FAILFAST_DRIVER);
+		return req->cmd_flags & REQ_FAILFAST_DRIVER;
 	}
 
 	if (status_byte(scmd->result) != CHECK_CONDITION)
@@ -1759,8 +1762,7 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 	 * assume caller has checked sense and determined
 	 * the check condition was retryable.
 	 */
-	if (scmd->request->cmd_flags & REQ_FAILFAST_DEV ||
-	    blk_rq_is_passthrough(scmd->request))
+	if (req->cmd_flags & REQ_FAILFAST_DEV || blk_rq_is_passthrough(req))
 		return 1;
 
 	return 0;
@@ -2321,11 +2323,6 @@ void scsi_report_device_reset(struct Scsi_Host *shost, int channel, int target)
 }
 EXPORT_SYMBOL(scsi_report_device_reset);
 
-static void
-scsi_reset_provider_done_command(struct scsi_cmnd *scmd)
-{
-}
-
 /**
  * scsi_ioctl_reset: explicitly reset a host/bus/target/device
  * @dev:	scsi_device to operate on
@@ -2362,7 +2359,8 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	scmd->request = rq;
 	scmd->cmnd = scsi_req(rq)->cmd;
 
-	scmd->scsi_done		= scsi_reset_provider_done_command;
+	scmd->submitter = SUBMITTED_BY_SCSI_RESET_IOCTL;
+	scmd->flags |= SCMD_LAST;
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
 
 	scmd->cmd_len			= 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 99b90031500b..20c2700e1f63 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -153,13 +153,15 @@ scsi_set_blocked(struct scsi_cmnd *cmd, int reason)
 
 static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 {
-	if (cmd->request->rq_flags & RQF_DONTPREP) {
-		cmd->request->rq_flags &= ~RQF_DONTPREP;
+	struct request *rq = scsi_cmd_to_rq(cmd);
+
+	if (rq->rq_flags & RQF_DONTPREP) {
+		rq->rq_flags &= ~RQF_DONTPREP;
 		scsi_mq_uninit_cmd(cmd);
 	} else {
 		WARN_ON_ONCE(true);
 	}
-	blk_mq_requeue_request(cmd->request, true);
+	blk_mq_requeue_request(rq, true);
 }
 
 /**
@@ -198,7 +200,7 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 	 */
 	cmd->result = 0;
 
-	blk_mq_requeue_request(cmd->request, true);
+	blk_mq_requeue_request(scsi_cmd_to_rq(cmd), true);
 }
 
 /**
@@ -508,7 +510,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 {
-	if (!blk_rq_is_passthrough(cmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
 		struct scsi_driver *drv = scsi_cmd_to_driver(cmd);
 
 		if (drv->uninit_command)
@@ -658,7 +660,7 @@ static void scsi_io_completion_reprep(struct scsi_cmnd *cmd,
 
 static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 {
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	unsigned long wait_for;
 
 	if (cmd->allowed == SCSI_CMD_RETRIES_NO_LIMIT)
@@ -677,7 +679,7 @@ static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 {
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	int level = 0;
 	enum {ACTION_FAIL, ACTION_REPREP, ACTION_RETRY,
 	      ACTION_DELAYED_RETRY} action;
@@ -849,7 +851,7 @@ static int scsi_io_completion_nz_result(struct scsi_cmnd *cmd, int result,
 {
 	bool sense_valid;
 	bool sense_current = true;	/* false implies "deferred sense" */
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	struct scsi_sense_hdr sshdr;
 
 	sense_valid = scsi_command_normalize_sense(cmd, &sshdr);
@@ -938,7 +940,7 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 {
 	int result = cmd->result;
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	blk_status_t blk_stat = BLK_STS_OK;
 
 	if (unlikely(result))	/* a nz result may or may not be an error */
@@ -1006,7 +1008,7 @@ static inline bool scsi_cmd_needs_dma_drain(struct scsi_device *sdev,
 blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdev = cmd->device;
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	unsigned short nr_segs = blk_rq_nr_phys_segments(rq);
 	struct scatterlist *last_sg = NULL;
 	blk_status_t ret;
@@ -1135,7 +1137,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 {
 	void *buf = cmd->sense_buffer;
 	void *prot = cmd->prot_sdb;
-	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	unsigned int flags = cmd->flags & SCMD_PRESERVED_FLAGS;
 	unsigned long jiffies_at_alloc;
 	int retries, to_clear;
@@ -1594,12 +1596,21 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
-	if (unlikely(blk_should_fake_timeout(cmd->request->q)))
+	switch (cmd->submitter) {
+	case SUBMITTED_BY_BLOCK_LAYER:
+		break;
+	case SUBMITTED_BY_SCSI_ERROR_HANDLER:
+		return scsi_eh_done(cmd);
+	case SUBMITTED_BY_SCSI_RESET_IOCTL:
+		return;
+	}
+
+	if (unlikely(blk_should_fake_timeout(scsi_cmd_to_rq(cmd)->q)))
 		return;
 	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
 		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(cmd->request);
+	blk_mq_complete_request(scsi_cmd_to_rq(cmd));
 }
 
 static void scsi_mq_put_budget(struct request_queue *q)
@@ -1683,6 +1694,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	scsi_set_resid(cmd, 0);
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
+	cmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
 	cmd->scsi_done = scsi_mq_done;
 
 	blk_mq_start_request(req);
diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index 8ea44c6595ef..f0ae55ad0973 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -28,8 +28,9 @@ static void scsi_log_release_buffer(char *bufptr)
 
 static inline const char *scmd_name(const struct scsi_cmnd *scmd)
 {
-	return scmd->request->rq_disk ?
-		scmd->request->rq_disk->disk_name : NULL;
+	struct request *rq = scsi_cmd_to_rq((struct scsi_cmnd *)scmd);
+
+	return rq->rq_disk ? rq->rq_disk->disk_name : NULL;
 }
 
 static size_t sdev_format_header(char *logbuf, size_t logbuf_len,
@@ -91,7 +92,7 @@ void scmd_printk(const char *level, const struct scsi_cmnd *scmd,
 	if (!logbuf)
 		return;
 	off = sdev_format_header(logbuf, logbuf_len, scmd_name(scmd),
-				 scmd->request->tag);
+				 scsi_cmd_to_rq((struct scsi_cmnd *)scmd)->tag);
 	if (off < logbuf_len) {
 		va_start(args, fmt);
 		off += vscnprintf(logbuf + off, logbuf_len - off, fmt, args);
@@ -188,7 +189,7 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 		return;
 
 	off = sdev_format_header(logbuf, logbuf_len,
-				 scmd_name(cmd), cmd->request->tag);
+				 scmd_name(cmd), scsi_cmd_to_rq(cmd)->tag);
 	if (off >= logbuf_len)
 		goto out_printk;
 	off += scnprintf(logbuf + off, logbuf_len - off, "CDB: ");
@@ -210,7 +211,7 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 
 			off = sdev_format_header(logbuf, logbuf_len,
 						 scmd_name(cmd),
-						 cmd->request->tag);
+						 scsi_cmd_to_rq(cmd)->tag);
 			if (!WARN_ON(off > logbuf_len - 58)) {
 				off += scnprintf(logbuf + off, logbuf_len - off,
 						 "CDB[%02x]: ", k);
@@ -373,7 +374,8 @@ EXPORT_SYMBOL(__scsi_print_sense);
 /* Normalize and print sense buffer in SCSI command */
 void scsi_print_sense(const struct scsi_cmnd *cmd)
 {
-	scsi_log_print_sense(cmd->device, scmd_name(cmd), cmd->request->tag,
+	scsi_log_print_sense(cmd->device, scmd_name(cmd),
+			     scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag,
 			     cmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
 }
 EXPORT_SYMBOL(scsi_print_sense);
@@ -392,8 +394,8 @@ void scsi_print_result(const struct scsi_cmnd *cmd, const char *msg,
 	if (!logbuf)
 		return;
 
-	off = sdev_format_header(logbuf, logbuf_len,
-				 scmd_name(cmd), cmd->request->tag);
+	off = sdev_format_header(logbuf, logbuf_len, scmd_name(cmd),
+				 scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag);
 
 	if (off >= logbuf_len)
 		goto out_printk;
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 180636d54982..89992d8879ac 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -82,6 +82,7 @@ void scsi_eh_ready_devs(struct Scsi_Host *shost,
 int scsi_eh_get_sense(struct list_head *work_q,
 		      struct list_head *done_q);
 int scsi_noretry_cmd(struct scsi_cmnd *scmd);
+void scsi_eh_done(struct scsi_cmnd *scmd);
 
 /* scsi_lib.c */
 extern int scsi_maybe_unblock_host(struct scsi_device *sdev);
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 1db43cbead57..26fa3f8260fb 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -352,8 +352,6 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
-		if (spi->cs_gpiod)
-			gpiod_set_value(spi->cs_gpiod, 1);
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
 		int i;
@@ -369,8 +367,6 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << chip_select), mr);
-		if (spi->cs_gpiod)
-			gpiod_set_value(spi->cs_gpiod, 1);
 		spi_writel(as, MR, mr);
 	}
 
@@ -400,8 +396,6 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 
 	if (!spi->cs_gpiod)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
-	else
-		gpiod_set_value(spi->cs_gpiod, 0);
 }
 
 static void atmel_spi_lock(struct atmel_spi *as) __acquires(&as->lock)
@@ -867,7 +861,6 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
  * lock is held, spi irq is blocked
  */
 static void atmel_spi_pdc_next_xfer(struct spi_master *master,
-					struct spi_message *msg,
 					struct spi_transfer *xfer)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
@@ -883,12 +876,12 @@ static void atmel_spi_pdc_next_xfer(struct spi_master *master,
 	spi_writel(as, RPR, rx_dma);
 	spi_writel(as, TPR, tx_dma);
 
-	if (msg->spi->bits_per_word > 8)
+	if (xfer->bits_per_word > 8)
 		len >>= 1;
 	spi_writel(as, RCR, len);
 	spi_writel(as, TCR, len);
 
-	dev_dbg(&msg->spi->dev,
+	dev_dbg(&master->dev,
 		"  start xfer %p: len %u tx %p/%08llx rx %p/%08llx\n",
 		xfer, xfer->len, xfer->tx_buf,
 		(unsigned long long)xfer->tx_dma, xfer->rx_buf,
@@ -902,12 +895,12 @@ static void atmel_spi_pdc_next_xfer(struct spi_master *master,
 		spi_writel(as, RNPR, rx_dma);
 		spi_writel(as, TNPR, tx_dma);
 
-		if (msg->spi->bits_per_word > 8)
+		if (xfer->bits_per_word > 8)
 			len >>= 1;
 		spi_writel(as, RNCR, len);
 		spi_writel(as, TNCR, len);
 
-		dev_dbg(&msg->spi->dev,
+		dev_dbg(&master->dev,
 			"  next xfer %p: len %u tx %p/%08llx rx %p/%08llx\n",
 			xfer, xfer->len, xfer->tx_buf,
 			(unsigned long long)xfer->tx_dma, xfer->rx_buf,
@@ -1277,12 +1270,28 @@ static int atmel_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static void atmel_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct atmel_spi *as = spi_master_get_devdata(spi->master);
+	/* the core doesn't really pass us enable/disable, but CS HIGH vs CS LOW
+	 * since we already have routines for activate/deactivate translate
+	 * high/low to active/inactive
+	 */
+	enable = (!!(spi->mode & SPI_CS_HIGH) == enable);
+
+	if (enable) {
+		cs_activate(as, spi);
+	} else {
+		cs_deactivate(as, spi);
+	}
+
+}
+
 static int atmel_spi_one_transfer(struct spi_master *master,
-					struct spi_message *msg,
+					struct spi_device *spi,
 					struct spi_transfer *xfer)
 {
 	struct atmel_spi	*as;
-	struct spi_device	*spi = msg->spi;
 	u8			bits;
 	u32			len;
 	struct atmel_spi_device	*asd;
@@ -1291,11 +1300,8 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	unsigned long		dma_timeout;
 
 	as = spi_master_get_devdata(master);
-
-	if (!(xfer->tx_buf || xfer->rx_buf) && xfer->len) {
-		dev_dbg(&spi->dev, "missing rx or tx buf\n");
-		return -EINVAL;
-	}
+	/* This lock was orignally taken in atmel_spi_trasfer_one_message */
+	atmel_spi_lock(as);
 
 	asd = spi->controller_state;
 	bits = (asd->csr >> 4) & 0xf;
@@ -1309,13 +1315,13 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	 * DMA map early, for performance (empties dcache ASAP) and
 	 * better fault reporting.
 	 */
-	if ((!msg->is_dma_mapped)
+	if ((!master->cur_msg->is_dma_mapped)
 		&& as->use_pdc) {
 		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 			return -ENOMEM;
 	}
 
-	atmel_spi_set_xfer_speed(as, msg->spi, xfer);
+	atmel_spi_set_xfer_speed(as, spi, xfer);
 
 	as->done_status = 0;
 	as->current_transfer = xfer;
@@ -1324,7 +1330,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		reinit_completion(&as->xfer_completion);
 
 		if (as->use_pdc) {
-			atmel_spi_pdc_next_xfer(master, msg, xfer);
+			atmel_spi_pdc_next_xfer(master, xfer);
 		} else if (atmel_spi_use_dma(as, xfer)) {
 			len = as->current_remaining_bytes;
 			ret = atmel_spi_next_xfer_dma_submit(master,
@@ -1332,7 +1338,8 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 			if (ret) {
 				dev_err(&spi->dev,
 					"unable to use DMA, fallback to PIO\n");
-				atmel_spi_next_xfer_pio(master, xfer);
+				as->done_status = ret;
+				break;
 			} else {
 				as->current_remaining_bytes -= len;
 				if (as->current_remaining_bytes < 0)
@@ -1385,90 +1392,18 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		} else if (atmel_spi_use_dma(as, xfer)) {
 			atmel_spi_stop_dma(master);
 		}
-
-		if (!msg->is_dma_mapped
-			&& as->use_pdc)
-			atmel_spi_dma_unmap_xfer(master, xfer);
-
-		return 0;
-
-	} else {
-		/* only update length if no error */
-		msg->actual_length += xfer->len;
 	}
 
-	if (!msg->is_dma_mapped
+	if (!master->cur_msg->is_dma_mapped
 		&& as->use_pdc)
 		atmel_spi_dma_unmap_xfer(master, xfer);
 
-	spi_transfer_delay_exec(xfer);
-
-	if (xfer->cs_change) {
-		if (list_is_last(&xfer->transfer_list,
-				 &msg->transfers)) {
-			as->keep_cs = true;
-		} else {
-			cs_deactivate(as, msg->spi);
-			udelay(10);
-			cs_activate(as, msg->spi);
-		}
-	}
-
-	return 0;
-}
-
-static int atmel_spi_transfer_one_message(struct spi_master *master,
-						struct spi_message *msg)
-{
-	struct atmel_spi *as;
-	struct spi_transfer *xfer;
-	struct spi_device *spi = msg->spi;
-	int ret = 0;
-
-	as = spi_master_get_devdata(master);
-
-	dev_dbg(&spi->dev, "new message %p submitted for %s\n",
-					msg, dev_name(&spi->dev));
-
-	atmel_spi_lock(as);
-	cs_activate(as, spi);
-
-	as->keep_cs = false;
-
-	msg->status = 0;
-	msg->actual_length = 0;
-
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		trace_spi_transfer_start(msg, xfer);
-
-		ret = atmel_spi_one_transfer(master, msg, xfer);
-		if (ret)
-			goto msg_done;
-
-		trace_spi_transfer_stop(msg, xfer);
-	}
-
 	if (as->use_pdc)
 		atmel_spi_disable_pdc_transfer(as);
 
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		dev_dbg(&spi->dev,
-			"  xfer %p: len %u tx %p/%pad rx %p/%pad\n",
-			xfer, xfer->len,
-			xfer->tx_buf, &xfer->tx_dma,
-			xfer->rx_buf, &xfer->rx_dma);
-	}
-
-msg_done:
-	if (!as->keep_cs)
-		cs_deactivate(as, msg->spi);
-
 	atmel_spi_unlock(as);
 
-	msg->status = as->done_status;
-	spi_finalize_current_message(spi->master);
-
-	return ret;
+	return as->done_status;
 }
 
 static void atmel_spi_cleanup(struct spi_device *spi)
@@ -1557,8 +1492,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = 4;
 	master->setup = atmel_spi_setup;
-	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
-	master->transfer_one_message = atmel_spi_transfer_one_message;
+	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX |
+			SPI_MASTER_GPIO_SS);
+	master->transfer_one = atmel_spi_one_transfer;
+	master->set_cs = atmel_spi_set_cs;
 	master->cleanup = atmel_spi_cleanup;
 	master->auto_runtime_pm = true;
 	master->max_dma_len = SPI_MAX_DMA_XFER;
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index ff0b3457fd34..de925433d4c5 100644
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
index 3bfa395c3112..4d7f4a4ab69f 100644
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
index 851c24253940..6be7358ca1af 100644
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
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 887b673f6223..cfd3c4dabdb2 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -407,10 +407,12 @@ static int afs_update_cell(struct afs_cell *cell)
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
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6da8587e2ae3..f06824bea468 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1868,6 +1868,15 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			 * are limited to own subvolumes only
 			 */
 			ret = -EPERM;
+		} else if (btrfs_ino(BTRFS_I(src_inode)) != BTRFS_FIRST_FREE_OBJECTID) {
+			/*
+			 * Snapshots must be made with the src_inode referring
+			 * to the subvolume inode, otherwise the permission
+			 * checking above is useless because we may have
+			 * permission on a lower directory but not the subvol
+			 * itself.
+			 */
+			ret = -EINVAL;
 		} else {
 			ret = btrfs_mksnapshot(&file->f_path, name, namelen,
 					     BTRFS_I(src_inode)->root,
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 9044b0fca9a3..2d46018b0283 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -353,6 +353,10 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
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
index be3df90bb2bc..b98bba887f84 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -305,6 +305,9 @@ static const bool has_smb2_data_area[NUMBER_OF_SMB2_COMMANDS] = {
 char *
 smb2_get_data_area_len(int *off, int *len, struct smb2_sync_hdr *shdr)
 {
+	const int max_off = 4096;
+	const int max_len = 128 * 1024;
+
 	*off = 0;
 	*len = 0;
 
@@ -376,29 +379,20 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_sync_hdr *shdr)
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
index e58525a95827..26edaeb4245d 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3099,7 +3099,7 @@ smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
 	struct kvec close_iov[1];
 	struct smb2_ioctl_rsp *ioctl_rsp;
 	struct reparse_data_buffer *reparse_buf;
-	u32 plen;
+	u32 off, count, len;
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, full_path);
 
@@ -3178,16 +3178,22 @@ smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
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
index 9a80047bc9b7..76679dc4e632 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -373,10 +373,15 @@ static int __smb2_plain_req_init(__le16 smb2_command, struct cifs_tcon *tcon,
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
@@ -3346,8 +3351,13 @@ SMB2_query_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
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
@@ -3369,7 +3379,7 @@ SMB2_query_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 
 	iov[0].iov_base = (char *)req;
 	/* 1 for Buffer */
-	iov[0].iov_len = total_len - 1 + input_len;
+	iov[0].iov_len = len;
 	return 0;
 }
 
@@ -3377,7 +3387,7 @@ void
 SMB2_query_info_free(struct smb_rqst *rqst)
 {
 	if (rqst && rqst->rq_iov)
-		cifs_small_buf_release(rqst->rq_iov[0].iov_base); /* request */
+		cifs_buf_release(rqst->rq_iov[0].iov_base); /* request */
 }
 
 static int
@@ -5104,6 +5114,11 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon,
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
@@ -5135,7 +5150,7 @@ SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(iov.iov_base);
+	free_qfs_info_req(&iov);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
 		goto posix_qfsinf_exit;
@@ -5186,7 +5201,7 @@ SMB2_QFS_info(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(iov.iov_base);
+	free_qfs_info_req(&iov);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
 		goto qfsinf_exit;
@@ -5253,7 +5268,7 @@ SMB2_QFS_attr(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(iov.iov_base);
+	free_qfs_info_req(&iov);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
 		goto qfsattr_exit;
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 56ec9fba3925..89a732b31390 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -755,7 +755,7 @@ struct smb2_tree_disconnect_rsp {
 #define SMB2_CREATE_SD_BUFFER			"SecD" /* security descriptor */
 #define SMB2_CREATE_DURABLE_HANDLE_REQUEST	"DHnQ"
 #define SMB2_CREATE_DURABLE_HANDLE_RECONNECT	"DHnC"
-#define SMB2_CREATE_ALLOCATION_SIZE		"AISi"
+#define SMB2_CREATE_ALLOCATION_SIZE		"AlSi"
 #define SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
 #define SMB2_CREATE_TIMEWARP_REQUEST		"TWrp"
 #define SMB2_CREATE_QUERY_ON_DISK_ID		"QFid"
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 2ab2d6d6aeab..7de851a9af8f 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -72,6 +72,7 @@ struct key_type {
 
 	unsigned int flags;
 #define KEY_TYPE_NET_DOMAIN	0x00000001 /* Keys of this type have a net namespace domain */
+#define KEY_TYPE_INSTANT_REAP	0x00000002 /* Keys of this type don't have a delay after expiring */
 
 	/* vet a description */
 	int (*vet_description)(const char *description);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e33433ec4a98..a168a64696b6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -174,6 +174,7 @@ struct blocked_key {
 struct smp_csrk {
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
+	u8 link_type;
 	u8 type;
 	u8 val[16];
 };
@@ -183,6 +184,7 @@ struct smp_ltk {
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
+	u8 link_type;
 	u8 authenticated;
 	u8 type;
 	u8 enc_size;
@@ -197,6 +199,7 @@ struct smp_irk {
 	bdaddr_t rpa;
 	bdaddr_t bdaddr;
 	u8 addr_type;
+	u8 link_type;
 	u8 val[16];
 };
 
@@ -204,6 +207,8 @@ struct link_key {
 	struct list_head list;
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
+	u8 bdaddr_type;
+	u8 link_type;
 	u8 type;
 	u8 val[HCI_LINK_KEY_SIZE];
 	u8 pin_len;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 6b55155e05e9..faaba22e0d38 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -202,7 +202,7 @@ struct mgmt_cp_load_link_keys {
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
 	__u8	type;
-	__u8	master;
+	__u8	initiator;
 	__u8	enc_size;
 	__le16	ediv;
 	__le64	rand;
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index b1c9b52876f3..2e26eb0d353e 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -65,6 +65,12 @@ struct scsi_pointer {
 #define SCMD_STATE_COMPLETE	0
 #define SCMD_STATE_INFLIGHT	1
 
+enum scsi_cmnd_submitter {
+	SUBMITTED_BY_BLOCK_LAYER = 0,
+	SUBMITTED_BY_SCSI_ERROR_HANDLER = 1,
+	SUBMITTED_BY_SCSI_RESET_IOCTL = 2,
+} __packed;
+
 struct scsi_cmnd {
 	struct scsi_request req;
 	struct scsi_device *device;
@@ -88,6 +94,7 @@ struct scsi_cmnd {
 	unsigned char prot_op;
 	unsigned char prot_type;
 	unsigned char prot_flags;
+	enum scsi_cmnd_submitter submitter;
 
 	unsigned short cmd_len;
 	enum dma_data_direction sc_data_direction;
@@ -162,7 +169,9 @@ static inline void *scsi_cmd_priv(struct scsi_cmnd *cmd)
 /* make sure not to use it with passthrough commands */
 static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 {
-	return *(struct scsi_driver **)cmd->request->rq_disk->private_data;
+	struct request *rq = scsi_cmd_to_rq(cmd);
+
+	return *(struct scsi_driver **)rq->rq_disk->private_data;
 }
 
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
@@ -224,6 +233,18 @@ static inline int scsi_sg_copy_to_buffer(struct scsi_cmnd *cmd,
 				 buf, buflen);
 }
 
+static inline sector_t scsi_get_sector(struct scsi_cmnd *scmd)
+{
+	return blk_rq_pos(scsi_cmd_to_rq(scmd));
+}
+
+static inline sector_t scsi_get_lba(struct scsi_cmnd *scmd)
+{
+	unsigned int shift = ilog2(scmd->device->sector_size) - SECTOR_SHIFT;
+
+	return blk_rq_pos(scsi_cmd_to_rq(scmd)) >> shift;
+}
+
 /*
  * The operations below are hints that tell the controller driver how
  * to handle I/Os with DIF or similar types of protection information.
@@ -286,9 +307,11 @@ static inline unsigned char scsi_get_prot_type(struct scsi_cmnd *scmd)
 	return scmd->prot_type;
 }
 
-static inline sector_t scsi_get_lba(struct scsi_cmnd *scmd)
+static inline u32 scsi_prot_ref_tag(struct scsi_cmnd *scmd)
 {
-	return blk_rq_pos(scmd->request);
+	struct request *rq = blk_mq_rq_from_pdu(scmd);
+
+	return t10_pi_ref_tag(rq);
 }
 
 static inline unsigned int scsi_prot_interval(struct scsi_cmnd *scmd)
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 1a5c9a3df6d6..993e1e79dd0c 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -264,13 +264,15 @@ sdev_prefix_printk(const char *, const struct scsi_device *, const char *,
 __printf(3, 4) void
 scmd_printk(const char *, const struct scsi_cmnd *, const char *, ...);
 
-#define scmd_dbg(scmd, fmt, a...)					   \
-	do {								   \
-		if ((scmd)->request->rq_disk)				   \
-			sdev_dbg((scmd)->device, "[%s] " fmt,		   \
-				 (scmd)->request->rq_disk->disk_name, ##a);\
-		else							   \
-			sdev_dbg((scmd)->device, fmt, ##a);		   \
+#define scmd_dbg(scmd, fmt, a...)					\
+	do {								\
+		struct request *__rq = scsi_cmd_to_rq((scmd));		\
+									\
+		if (__rq->rq_disk)					\
+			sdev_dbg((scmd)->device, "[%s] " fmt,		\
+				 __rq->rq_disk->disk_name, ##a);	\
+		else							\
+			sdev_dbg((scmd)->device, fmt, ##a);		\
 	} while (0)
 
 enum scsi_target_state {
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 364fa91ab33e..5abe88091803 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -810,9 +810,14 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
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
@@ -861,7 +866,8 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 	/* make sure the waiters see the new index */
 	smp_wmb();
 
-	rb_wake_up_waiters(&rbwork->work);
+	/* This can be called in any context */
+	irq_work_queue(&rbwork->work);
 }
 
 /**
diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index a6a2813afb87..a5050f3f6f02 100644
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
index b2527624481d..0cbf833bebcc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1892,17 +1892,31 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	__update_max_tr(tr, tsk, cpu);
 	arch_spin_unlock(&tr->max_lock);
+
+	/* Any waiters on the old snapshot buffer need to wake up */
+	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
 }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
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
@@ -7953,7 +7967,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
 			goto out;
 
-		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
+		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
 		if (ret)
 			goto out;
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index daf32a489dc0..b08b8ee1bbc0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1984,15 +1984,20 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
 
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
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 78ec2e1b14d1..43aea97c5762 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -406,6 +406,8 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 		return 0;
 
 	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		err = vlan_vid_add(dev, vid_info->proto, vid_info->vid);
 		if (err)
 			goto unwind;
@@ -416,6 +418,8 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 	list_for_each_entry_continue_reverse(vid_info,
 					     &vlan_info->vid_list,
 					     list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
 	}
 
@@ -435,8 +439,11 @@ void vlan_vids_del_by_dev(struct net_device *dev,
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
 
diff --git a/net/9p/client.c b/net/9p/client.c
index e8862cd4f91b..cd85a4b6448b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -520,11 +520,14 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		return 0;
 
 	if (!p9_is_proto_dotl(c)) {
-		char *ename;
+		char *ename = NULL;
+
 		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
-		if (err)
+		if (err) {
+			kfree(ename);
 			goto out_err;
+		}
 
 		if (p9_is_proto_dotu(c) && ecode < 512)
 			err = -ecode;
diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 03593eb240d8..ef0a82dbbe04 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -228,6 +228,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
 
+				*wnames = NULL;
+
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
 				if (!errcode) {
@@ -237,6 +239,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 							  GFP_NOFS);
 					if (!*wnames)
 						errcode = -ENOMEM;
+					else
+						(*wnames)[0] = NULL;
 				}
 
 				if (!errcode) {
@@ -248,8 +252,10 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
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
 
@@ -257,11 +263,14 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
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
index 2f87f57e7a4f..14a917e70f3e 100644
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
index ad5294de9759..ee2c1a17366a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1834,7 +1834,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		return;
 	}
 
-	set_bit(HCI_INQUIRY, &hdev->flags);
+	if (hci_sent_cmd_data(hdev, HCI_OP_INQUIRY))
+		set_bit(HCI_INQUIRY, &hdev->flags);
 }
 
 static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7b40e4737a2b..cf78a48085ed 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6488,6 +6488,14 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
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
@@ -6513,23 +6521,24 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 
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
index 878bf7382244..bd8cfcfca7ae 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2373,7 +2373,8 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
-		if (key->addr.type != BDADDR_BREDR || key->type > 0x08)
+		/* Considering SMP over BREDR/LE, there is no need to check addr_type */
+		if (key->type > 0x08)
 			return mgmt_cmd_status(sk, hdev->id,
 					       MGMT_OP_LOAD_LINK_KEYS,
 					       MGMT_STATUS_INVALID_PARAMS);
@@ -5914,6 +5915,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
+		u8 addr_type = le_addr_type(irk->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_IRK,
@@ -5923,8 +5925,12 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
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
 
@@ -5939,7 +5945,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
-	if (key->master != 0x00 && key->master != 0x01)
+	if (key->initiator != 0x00 && key->initiator != 0x01)
 		return false;
 
 	switch (key->addr.type) {
@@ -6005,6 +6011,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type, authenticated;
+		u8 addr_type = le_addr_type(key->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_LTK,
@@ -6017,11 +6024,11 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		switch (key->type) {
 		case MGMT_LTK_UNAUTHENTICATED:
 			authenticated = 0x00;
-			type = key->master ? SMP_LTK : SMP_LTK_SLAVE;
+			type = key->initiator ? SMP_LTK : SMP_LTK_RESPONDER;
 			break;
 		case MGMT_LTK_AUTHENTICATED:
 			authenticated = 0x01;
-			type = key->master ? SMP_LTK : SMP_LTK_SLAVE;
+			type = key->initiator ? SMP_LTK : SMP_LTK_RESPONDER;
 			break;
 		case MGMT_LTK_P256_UNAUTH:
 			authenticated = 0x00;
@@ -6039,8 +6046,12 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
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
 
@@ -8043,7 +8054,7 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = BDADDR_BREDR;
+	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, HCI_LINK_KEY_SIZE);
 	ev.key.pin_len = key->pin_len;
@@ -8055,7 +8066,7 @@ static u8 mgmt_ltk_type(struct smp_ltk *ltk)
 {
 	switch (ltk->type) {
 	case SMP_LTK:
-	case SMP_LTK_SLAVE:
+	case SMP_LTK_RESPONDER:
 		if (ltk->authenticated)
 			return MGMT_LTK_AUTHENTICATED;
 		return MGMT_LTK_UNAUTHENTICATED;
@@ -8094,14 +8105,14 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
 	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
 	ev.key.rand = key->rand;
 
 	if (key->type == SMP_LTK)
-		ev.key.master = 1;
+		ev.key.initiator = 1;
 
 	/* Make sure we copy only the significant bytes based on the
 	 * encryption key size, and set the rest of the value to zeroes.
@@ -8123,7 +8134,7 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
-	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
+	ev.irk.addr.type = link_to_bdaddr(irk->link_type, irk->addr_type);
 	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
 
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
@@ -8152,7 +8163,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(csrk->link_type, csrk->bdaddr_type);
 	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b7374dbee23a..27381e7425a8 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -112,9 +112,9 @@ struct smp_chan {
 	u8		id_addr_type;
 	u8		irk[16];
 	struct smp_csrk	*csrk;
-	struct smp_csrk	*slave_csrk;
+	struct smp_csrk	*responder_csrk;
 	struct smp_ltk	*ltk;
-	struct smp_ltk	*slave_ltk;
+	struct smp_ltk	*responder_ltk;
 	struct smp_irk	*remote_irk;
 	u8		*link_key;
 	unsigned long	flags;
@@ -596,7 +596,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	if (!chan)
 		return;
 
-	BT_DBG("code 0x%2.2x", code);
+	bt_dev_dbg(conn->hcon->hdev, "code 0x%2.2x", code);
 
 	iv[0].iov_base = &code;
 	iv[0].iov_len = 1;
@@ -754,7 +754,7 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	mgmt_smp_complete(hcon, complete);
 
 	kfree_sensitive(smp->csrk);
-	kfree_sensitive(smp->slave_csrk);
+	kfree_sensitive(smp->responder_csrk);
 	kfree_sensitive(smp->link_key);
 
 	crypto_free_shash(smp->tfm_cmac);
@@ -777,9 +777,9 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 			kfree_rcu(smp->ltk, rcu);
 		}
 
-		if (smp->slave_ltk) {
-			list_del_rcu(&smp->slave_ltk->list);
-			kfree_rcu(smp->slave_ltk, rcu);
+		if (smp->responder_ltk) {
+			list_del_rcu(&smp->responder_ltk->list);
+			kfree_rcu(smp->responder_ltk, rcu);
 		}
 
 		if (smp->remote_irk) {
@@ -860,7 +860,8 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	memset(smp->tk, 0, sizeof(smp->tk));
 	clear_bit(SMP_FLAG_TK_VALID, &smp->flags);
 
-	BT_DBG("tk_request: auth:%d lcl:%d rem:%d", auth, local_io, remote_io);
+	bt_dev_dbg(hcon->hdev, "auth:%d lcl:%d rem:%d", auth, local_io,
+		   remote_io);
 
 	/* If neither side wants MITM, either "just" confirm an incoming
 	 * request or use just-works for outgoing ones. The JUST_CFM
@@ -925,7 +926,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 		get_random_bytes(&passkey, sizeof(passkey));
 		passkey %= 1000000;
 		put_unaligned_le32(passkey, smp->tk);
-		BT_DBG("PassKey: %d", passkey);
+		bt_dev_dbg(hcon->hdev, "PassKey: %d", passkey);
 		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
 	}
 
@@ -950,7 +951,7 @@ static u8 smp_confirm(struct smp_chan *smp)
 	struct smp_cmd_pairing_confirm cp;
 	int ret;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
 	ret = smp_c1(smp->tk, smp->prnd, smp->preq, smp->prsp,
 		     conn->hcon->init_addr_type, &conn->hcon->init_addr,
@@ -978,7 +979,8 @@ static u8 smp_random(struct smp_chan *smp)
 	u8 confirm[16];
 	int ret;
 
-	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
+	bt_dev_dbg(conn->hcon->hdev, "conn %p %s", conn,
+		   conn->hcon->out ? "initiator" : "responder");
 
 	ret = smp_c1(smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
@@ -1020,8 +1022,8 @@ static u8 smp_random(struct smp_chan *smp)
 		else
 			auth = 0;
 
-		/* Even though there's no _SLAVE suffix this is the
-		 * slave STK we're adding for later lookup (the master
+		/* Even though there's no _RESPONDER suffix this is the
+		 * responder STK we're adding for later lookup (the initiator
 		 * STK never needs to be stored).
 		 */
 		hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
@@ -1057,6 +1059,7 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->remote_irk) {
+		smp->remote_irk->link_type = hcon->type;
 		mgmt_new_irk(hdev, smp->remote_irk, persistent);
 
 		/* Now that user space can be considered to know the
@@ -1071,27 +1074,31 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->csrk) {
+		smp->csrk->link_type = hcon->type;
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->csrk, persistent);
 	}
 
-	if (smp->slave_csrk) {
-		smp->slave_csrk->bdaddr_type = hcon->dst_type;
-		bacpy(&smp->slave_csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->slave_csrk, persistent);
+	if (smp->responder_csrk) {
+		smp->responder_csrk->link_type = hcon->type;
+		smp->responder_csrk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
+		mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
 	}
 
 	if (smp->ltk) {
+		smp->ltk->link_type = hcon->type;
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->ltk, persistent);
 	}
 
-	if (smp->slave_ltk) {
-		smp->slave_ltk->bdaddr_type = hcon->dst_type;
-		bacpy(&smp->slave_ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->slave_ltk, persistent);
+	if (smp->responder_ltk) {
+		smp->responder_ltk->link_type = hcon->type;
+		smp->responder_ltk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
+		mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
 	}
 
 	if (smp->link_key) {
@@ -1108,6 +1115,8 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		key = hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
 				       smp->link_key, type, 0, &persistent);
 		if (key) {
+			key->link_type = hcon->type;
+			key->bdaddr_type = hcon->dst_type;
 			mgmt_new_link_key(hdev, key, persistent);
 
 			/* Don't keep debug keys around if the relevant
@@ -1237,7 +1246,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	struct hci_dev *hdev = hcon->hdev;
 	__u8 *keydist;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	rsp = (void *) &smp->prsp[1];
 
@@ -1267,11 +1276,11 @@ static void smp_distribute_keys(struct smp_chan *smp)
 		*keydist &= ~SMP_SC_NO_DIST;
 	}
 
-	BT_DBG("keydist 0x%x", *keydist);
+	bt_dev_dbg(hdev, "keydist 0x%x", *keydist);
 
 	if (*keydist & SMP_DIST_ENC_KEY) {
 		struct smp_cmd_encrypt_info enc;
-		struct smp_cmd_master_ident ident;
+		struct smp_cmd_initiator_ident ident;
 		struct smp_ltk *ltk;
 		u8 authenticated;
 		__le16 ediv;
@@ -1292,14 +1301,15 @@ static void smp_distribute_keys(struct smp_chan *smp)
 
 		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
 		ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type,
-				  SMP_LTK_SLAVE, authenticated, enc.ltk,
+				  SMP_LTK_RESPONDER, authenticated, enc.ltk,
 				  smp->enc_key_size, ediv, rand);
-		smp->slave_ltk = ltk;
+		smp->responder_ltk = ltk;
 
 		ident.ediv = ediv;
 		ident.rand = rand;
 
-		smp_send_cmd(conn, SMP_CMD_MASTER_IDENT, sizeof(ident), &ident);
+		smp_send_cmd(conn, SMP_CMD_INITIATOR_IDENT, sizeof(ident),
+			     &ident);
 
 		*keydist &= ~SMP_DIST_ENC_KEY;
 	}
@@ -1342,7 +1352,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 				csrk->type = MGMT_CSRK_LOCAL_UNAUTHENTICATED;
 			memcpy(csrk->val, sign.csrk, sizeof(csrk->val));
 		}
-		smp->slave_csrk = csrk;
+		smp->responder_csrk = csrk;
 
 		smp_send_cmd(conn, SMP_CMD_SIGN_INFO, sizeof(sign), &sign);
 
@@ -1367,13 +1377,14 @@ static void smp_timeout(struct work_struct *work)
 					    security_timer.work);
 	struct l2cap_conn *conn = smp->conn;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
 	hci_disconnect(conn->hcon, HCI_ERROR_REMOTE_USER_TERM);
 }
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 {
+	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp;
 
@@ -1383,13 +1394,13 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 	smp->tfm_cmac = crypto_alloc_shash("cmac(aes)", 0, 0);
 	if (IS_ERR(smp->tfm_cmac)) {
-		BT_ERR("Unable to create CMAC crypto context");
+		bt_dev_err(hcon->hdev, "Unable to create CMAC crypto context");
 		goto zfree_smp;
 	}
 
 	smp->tfm_ecdh = crypto_alloc_kpp("ecdh", 0, 0);
 	if (IS_ERR(smp->tfm_ecdh)) {
-		BT_ERR("Unable to create ECDH crypto context");
+		bt_dev_err(hcon->hdev, "Unable to create ECDH crypto context");
 		goto free_shash;
 	}
 
@@ -1400,7 +1411,7 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 	INIT_DELAYED_WORK(&smp->security_timer, smp_timeout);
 
-	hci_conn_hold(conn->hcon);
+	hci_conn_hold(hcon);
 
 	return smp;
 
@@ -1565,8 +1576,8 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 		if (!hcon->out)
 			return 0;
 
-		BT_DBG("%s Starting passkey round %u", hdev->name,
-		       smp->passkey_round + 1);
+		bt_dev_dbg(hdev, "Starting passkey round %u",
+			   smp->passkey_round + 1);
 
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 
@@ -1626,7 +1637,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	u32 value;
 	int err;
 
-	BT_DBG("");
+	bt_dev_dbg(conn->hcon->hdev, "");
 
 	if (!conn)
 		return -ENOTCONN;
@@ -1652,7 +1663,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	case MGMT_OP_USER_PASSKEY_REPLY:
 		value = le32_to_cpu(passkey);
 		memset(smp->tk, 0, sizeof(smp->tk));
-		BT_DBG("PassKey: %d", value);
+		bt_dev_dbg(conn->hcon->hdev, "PassKey: %d", value);
 		put_unaligned_le32(value, smp->tk);
 		fallthrough;
 	case MGMT_OP_USER_CONFIRM_REPLY:
@@ -1734,7 +1745,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	u8 key_size, auth, sec_level;
 	int ret;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*req))
 		return SMP_INVALID_PARAMS;
@@ -1888,7 +1899,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS)) {
-		BT_DBG("Using debug keys");
+		bt_dev_dbg(hdev, "Using debug keys");
 		if (set_ecdh_privkey(smp->tfm_ecdh, debug_sk))
 			return SMP_UNSPECIFIED;
 		memcpy(smp->local_pk, debug_pk, 64);
@@ -1925,7 +1936,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	u8 key_size, auth;
 	int ret;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rsp))
 		return SMP_INVALID_PARAMS;
@@ -2020,7 +2031,7 @@ static u8 sc_check_confirm(struct smp_chan *smp)
 {
 	struct l2cap_conn *conn = smp->conn;
 
-	BT_DBG("");
+	bt_dev_dbg(conn->hcon->hdev, "");
 
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_CONFIRM);
@@ -2046,7 +2057,7 @@ static int fixup_sc_false_positive(struct smp_chan *smp)
 	struct smp_cmd_pairing *req, *rsp;
 	u8 auth;
 
-	/* The issue is only observed when we're in slave role */
+	/* The issue is only observed when we're in responder role */
 	if (hcon->out)
 		return SMP_UNSPECIFIED;
 
@@ -2079,8 +2090,11 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
 
-	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
+	bt_dev_dbg(hdev, "conn %p %s", conn,
+		   hcon->out ? "initiator" : "responder");
 
 	if (skb->len < sizeof(smp->pcnf))
 		return SMP_INVALID_PARAMS;
@@ -2095,7 +2109,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 		if (test_bit(SMP_FLAG_REMOTE_PK, &smp->flags))
 			return sc_check_confirm(smp);
 
-		BT_ERR("Unexpected SMP Pairing Confirm");
+		bt_dev_err(hdev, "Unexpected SMP Pairing Confirm");
 
 		ret = fixup_sc_false_positive(smp);
 		if (ret)
@@ -2126,7 +2140,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	u32 passkey;
 	int err;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hcon->hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(smp->rrnd))
 		return SMP_INVALID_PARAMS;
@@ -2247,7 +2261,7 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	hci_le_start_enc(hcon, key->ediv, key->rand, key->val, key->enc_size);
 	hcon->enc_key_size = key->enc_size;
 
-	/* We never store STKs for master role, so clear this flag */
+	/* We never store STKs for initiator role, so clear this flag */
 	clear_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags);
 
 	return true;
@@ -2285,7 +2299,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp;
 	u8 sec_level, auth;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
@@ -2348,7 +2362,8 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	__u8 authreq;
 	int ret;
 
-	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
+	bt_dev_dbg(hcon->hdev, "conn %p hcon %p level 0x%2.2x", conn, hcon,
+		   sec_level);
 
 	/* This may be NULL if there's an unexpected disconnection */
 	if (!conn)
@@ -2462,7 +2477,7 @@ int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		/* Set keys to NULL to make sure smp_failure() does not try to
 		 * remove and free already invalidated rcu list entries. */
 		smp->ltk = NULL;
-		smp->slave_ltk = NULL;
+		smp->responder_ltk = NULL;
 		smp->remote_irk = NULL;
 
 		if (test_bit(SMP_FLAG_COMPLETE, &smp->flags))
@@ -2484,7 +2499,7 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
@@ -2498,7 +2513,7 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_INVALID_PARAMS;
 	}
 
-	SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
+	SMP_ALLOW_CMD(smp, SMP_CMD_INITIATOR_IDENT);
 
 	skb_pull(skb, sizeof(*rp));
 
@@ -2507,9 +2522,9 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
-static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
+static int smp_cmd_initiator_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_master_ident *rp = (void *) skb->data;
+	struct smp_cmd_initiator_ident *rp = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct hci_dev *hdev = conn->hcon->hdev;
@@ -2517,7 +2532,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_ltk *ltk;
 	u8 authenticated;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
@@ -2549,7 +2564,7 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 
-	BT_DBG("");
+	bt_dev_dbg(conn->hcon->hdev, "");
 
 	if (skb->len < sizeof(*info))
 		return SMP_INVALID_PARAMS;
@@ -2581,7 +2596,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	struct hci_conn *hcon = conn->hcon;
 	bdaddr_t rpa;
 
-	BT_DBG("");
+	bt_dev_dbg(hcon->hdev, "");
 
 	if (skb->len < sizeof(*info))
 		return SMP_INVALID_PARAMS;
@@ -2648,7 +2663,7 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = chan->data;
 	struct smp_csrk *csrk;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
@@ -2728,7 +2743,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing_confirm cfm;
 	int err;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*key))
 		return SMP_INVALID_PARAMS;
@@ -2792,7 +2807,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp->method = sc_select_method(smp);
 
-	BT_DBG("%s selected method 0x%02x", hdev->name, smp->method);
+	bt_dev_dbg(hdev, "selected method 0x%02x", smp->method);
 
 	/* JUST_WORKS and JUST_CFM result in an unauthenticated key */
 	if (smp->method == JUST_WORKS || smp->method == JUST_CFM)
@@ -2867,7 +2882,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	u8 io_cap[3], r[16], e[16];
 	int err;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hcon->hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*check))
 		return SMP_INVALID_PARAMS;
@@ -2908,7 +2923,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 			return 0;
 		}
 
-		/* Slave sends DHKey check as response to master */
+		/* Responder sends DHKey check as response to initiator */
 		sc_dhkey_check(smp);
 	}
 
@@ -2927,7 +2942,7 @@ static int smp_cmd_keypress_notify(struct l2cap_conn *conn,
 {
 	struct smp_cmd_keypress_notify *kp = (void *) skb->data;
 
-	BT_DBG("value 0x%02x", kp->value);
+	bt_dev_dbg(conn->hcon->hdev, "value 0x%02x", kp->value);
 
 	return 0;
 }
@@ -2995,8 +3010,8 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		reason = smp_cmd_encrypt_info(conn, skb);
 		break;
 
-	case SMP_CMD_MASTER_IDENT:
-		reason = smp_cmd_master_ident(conn, skb);
+	case SMP_CMD_INITIATOR_IDENT:
+		reason = smp_cmd_initiator_ident(conn, skb);
 		break;
 
 	case SMP_CMD_IDENT_INFO:
@@ -3024,7 +3039,7 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		break;
 
 	default:
-		BT_DBG("Unknown command code 0x%2.2x", code);
+		bt_dev_dbg(hcon->hdev, "Unknown command code 0x%2.2x", code);
 		reason = SMP_CMD_NOTSUPP;
 		goto done;
 	}
@@ -3049,7 +3064,7 @@ static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 {
 	struct l2cap_conn *conn = chan->conn;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(conn->hcon->hdev, "chan %p", chan);
 
 	if (chan->data)
 		smp_chan_destroy(conn);
@@ -3066,7 +3081,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 	struct smp_cmd_pairing req;
 	struct smp_chan *smp;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(hdev, "chan %p", chan);
 
 	/* Only new pairings are interesting */
 	if (!test_bit(HCI_CONN_NEW_LINK_KEY, &hcon->flags))
@@ -3113,7 +3128,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 
 	set_bit(SMP_FLAG_SC, &smp->flags);
 
-	BT_DBG("%s starting SMP over BR/EDR", hdev->name);
+	bt_dev_dbg(hdev, "starting SMP over BR/EDR");
 
 	/* Prepare and send the BR/EDR SMP Pairing Request */
 	build_bredr_pairing_cmd(smp, &req, NULL);
@@ -3131,7 +3146,7 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(hcon->hdev, "chan %p", chan);
 
 	if (hcon->type == ACL_LINK) {
 		bredr_pairing(chan);
@@ -3154,7 +3169,7 @@ static void smp_ready_cb(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(hcon->hdev, "chan %p", chan);
 
 	/* No need to call l2cap_chan_hold() here since we already own
 	 * the reference taken in smp_new_conn_cb(). This is just the
@@ -3172,7 +3187,7 @@ static int smp_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(chan->conn->hcon->hdev, "chan %p", chan);
 
 	err = smp_sig_channel(chan, skb);
 	if (err) {
@@ -3286,14 +3301,14 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 
 	tfm_cmac = crypto_alloc_shash("cmac(aes)", 0, 0);
 	if (IS_ERR(tfm_cmac)) {
-		BT_ERR("Unable to create CMAC crypto context");
+		bt_dev_err(hdev, "Unable to create CMAC crypto context");
 		kfree_sensitive(smp);
 		return ERR_CAST(tfm_cmac);
 	}
 
 	tfm_ecdh = crypto_alloc_kpp("ecdh", 0, 0);
 	if (IS_ERR(tfm_ecdh)) {
-		BT_ERR("Unable to create ECDH crypto context");
+		bt_dev_err(hdev, "Unable to create ECDH crypto context");
 		crypto_free_shash(tfm_cmac);
 		kfree_sensitive(smp);
 		return ERR_CAST(tfm_ecdh);
@@ -3422,7 +3437,7 @@ int smp_register(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "");
 
 	/* If the controller does not support Low Energy operation, then
 	 * there is also no need to register any SMP channel.
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 121edadd5f8d..5fe68e255cb2 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -79,8 +79,8 @@ struct smp_cmd_encrypt_info {
 	__u8	ltk[16];
 } __packed;
 
-#define SMP_CMD_MASTER_IDENT	0x07
-struct smp_cmd_master_ident {
+#define SMP_CMD_INITIATOR_IDENT	0x07
+struct smp_cmd_initiator_ident {
 	__le16	ediv;
 	__le64	rand;
 } __packed;
@@ -146,7 +146,7 @@ struct smp_cmd_keypress_notify {
 enum {
 	SMP_STK,
 	SMP_LTK,
-	SMP_LTK_SLAVE,
+	SMP_LTK_RESPONDER,
 	SMP_LTK_P256,
 	SMP_LTK_P256_DEBUG,
 };
diff --git a/net/core/dev.c b/net/core/dev.c
index 3fc27b52bf42..fc881d60a9dc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3523,6 +3523,14 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	if (gso_segs > dev->gso_max_segs)
 		return features & ~NETIF_F_GSO_MASK;
 
+	if (unlikely(skb->len >= READ_ONCE(dev->gso_max_size)))
+		return features & ~NETIF_F_GSO_MASK;
+
+	if (!skb_shinfo(skb)->gso_type) {
+		skb_warn_bad_offload(skb);
+		return features & ~NETIF_F_GSO_MASK;
+	}
+
 	/* Support for GSO partial features requires software
 	 * intervention before we can actually process the packets
 	 * so we need to strip support for any partial features now
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
index aca26df7587d..ee8b5013d67d 100644
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
index dfb347f8d3ad..f244a4323a43 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8377,7 +8377,7 @@ static void nft_set_commit_update(struct list_head *set_update_list)
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
index 151ff39b6803..67ad0826e385 100644
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
 
@@ -605,8 +603,7 @@ int key_reject_and_link(struct key *key,
 		atomic_inc(&key->user->nikeys);
 		mark_key_instantiated(key, -error);
 		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
-		key->expiry = ktime_get_real_seconds() + timeout;
-		key_schedule_gc(key->expiry + key_gc_delay);
+		key_set_expiry(key, ktime_get_real_seconds() + timeout);
 
 		if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
 			awaken = 1;
@@ -721,16 +718,14 @@ struct key_type *key_type_lookup(const char *type)
 
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
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 86a43b955db9..0d1c6c4c1ee6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1970,6 +1970,8 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x86ae, "ASUS", 1),  /* Z170 PRO */
 	SND_PCI_QUIRK(0x1043, 0x86c7, "ASUS", 1),  /* Z170M PLUS */
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
+	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
+	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
 	{}
 };
 

