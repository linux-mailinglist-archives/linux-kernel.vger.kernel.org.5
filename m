Return-Path: <linux-kernel+bounces-19425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE12826CB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AA41F20F23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B71E328DF;
	Mon,  8 Jan 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVTjYOcl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0E31A9E;
	Mon,  8 Jan 2024 11:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBCDC433C9;
	Mon,  8 Jan 2024 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704713194;
	bh=r+WcrT+KYeieit3Ldjny251xsEYzCd8+SaREhWxbgN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVTjYOclAfqjKHm3r/tU+LBbmS2q0CMD+gYoCsY6A+2wAcuL5+tOhvWJ+zXv/mIMb
	 mqdBWf2D/cVGOPgghuZRD+OzmaMFXkVIhUFdtA7bCpegARzbQsn51lWQbqzpK+Rg28
	 fvQ0GNEnTVRxEGUz8+HcZAq1AS1l+PM39+6HYHkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.304
Date: Mon,  8 Jan 2024 12:26:25 +0100
Message-ID: <2024010824-irate-placard-b654@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024010824-disinfect-repeater-e5ba@gregkh>
References: <2024010824-disinfect-repeater-e5ba@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index dbfb41f4d203..fc7bc81130dc 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 303
+SUBLEVEL = 304
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 859c71c4e932..df8a9dda67a0 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -800,10 +800,15 @@ void __init omap_soc_device_init(void)
 
 	soc_dev_attr->machine  = soc_name;
 	soc_dev_attr->family   = omap_get_family();
+	if (!soc_dev_attr->family) {
+		kfree(soc_dev_attr);
+		return;
+	}
 	soc_dev_attr->revision = soc_rev;
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
 		kfree(soc_dev_attr);
 		return;
 	}
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 8e6ada20e6db..242a9e8dc0a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -51,7 +51,7 @@
 		id-gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb_p1_vbus: regulator@0 {
+	usb_p1_vbus: regulator-usb-p1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -60,7 +60,7 @@
 		enable-active-high;
 	};
 
-	usb_p0_vbus: regulator@1 {
+	usb_p0_vbus: regulator-usb-p0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbus";
 		regulator-min-microvolt = <5000000>;
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
index dee94961a667..33882d5ab25d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -690,8 +690,8 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 	} else {
 		local_irq_save(flags);
 		memcpy(addr, opcode, len);
-		local_irq_restore(flags);
 		sync_core();
+		local_irq_restore(flags);
 
 		/*
 		 * Could also do a CLFLUSH here to speed up CPU recovery; but
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 125b5ff61d19..a551b0071349 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -16,8 +16,8 @@
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
index 6b560d99f385..351032e4eaad 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -508,13 +508,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
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
index 602900d1f937..2d0d09ee9ab0 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -108,6 +108,9 @@ static int micro_key_probe(struct platform_device *pdev)
 	keys->codes = devm_kmemdup(&pdev->dev, micro_keycodes,
 			   keys->input->keycodesize * keys->input->keycodemax,
 			   GFP_KERNEL);
+	if (!keys->codes)
+		return -ENOMEM;
+
 	keys->input->keycode = keys->codes;
 
 	__set_bit(EV_KEY, keys->input->evbit);
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 234464c1c050..a884fcf65063 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1379,11 +1379,12 @@ static void integrity_metadata(struct work_struct *w)
 			checksums = checksums_onstack;
 
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
@@ -1392,7 +1393,7 @@ static void integrity_metadata(struct work_struct *w)
 				sectors_to_process -= ic->sectors_per_block;
 				pos += ic->sectors_per_block << SECTOR_SHIFT;
 				sector += ic->sectors_per_block;
-			} while (pos < bv.bv_len && sectors_to_process && checksums != checksums_onstack);
+			} while (pos < bv_copy.bv_len && sectors_to_process && checksums != checksums_onstack);
 			kunmap_atomic(mem);
 
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
@@ -1412,9 +1413,9 @@ static void integrity_metadata(struct work_struct *w)
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
index e4d58c7aeaf8..c72ba133072f 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -881,10 +881,13 @@ static int atl1e_setup_ring_resources(struct atl1e_adapter *adapter)
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
 		pci_free_consistent(pdev, adapter->ring_size,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 97e6b06b1bff..24e9699434e3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -651,8 +651,8 @@ static void mlx5_fw_tracer_handle_traces(struct work_struct *work)
 		get_block_timestamp(tracer, &tmp_trace_block[TRACES_PER_BLOCK - 1]);
 
 	while (block_timestamp > tracer->last_timestamp) {
-		/* Check block override if its not the first block */
-		if (!tracer->last_timestamp) {
+		/* Check block override if it's not the first block */
+		if (tracer->last_timestamp) {
 			u64 *ts_event;
 			/* To avoid block override be the HW in case of buffer
 			 * wraparound, the time stamp of the previous block
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index cbbda24bf6a8..67befdce3805 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -939,6 +939,13 @@ static const struct of_device_id atmel_pctrl_of_match[] = {
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
@@ -1089,6 +1096,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		irq_set_chip_and_handler(irq, &atmel_gpio_irq_chip,
 					 handle_simple_irq);
 		irq_set_chip_data(irq, atmel_pioctrl);
+		irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
 		dev_dbg(dev,
 			"atmel gpio irq domain: hwirq: %d, linux irq: %d\n",
 			i, irq);
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index ccb97f4e31c3..1680d27040c9 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -459,6 +459,9 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 {
 	lockdep_assert_held(&reset_list_mutex);
 
+	if (IS_ERR_OR_NULL(rstc))
+		return;
+
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index ea2c601da8e1..2ab1fbf12ae1 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -435,8 +435,6 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct fc_frame_header *fh;
 	struct fcoe_rcv_info *fr;
 	struct fcoe_percpu_s *bg;
-	struct sk_buff *tmp_skb;
-	unsigned short oxid;
 
 	interface = container_of(ptype, struct bnx2fc_interface,
 				 fcoe_packet_type);
@@ -448,11 +446,9 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
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
@@ -470,8 +466,6 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 	skb_set_transport_header(skb, sizeof(struct fcoe_hdr));
 	fh = (struct fc_frame_header *) skb_transport_header(skb);
 
-	oxid = ntohs(fh->fh_ox_id);
-
 	fr = fcoe_dev_from_skb(skb);
 	fr->fr_dev = lport;
 
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 157742431961..d87b4fb0d9af 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -426,8 +426,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 			temp = size;
 		size -= temp;
 		next += temp;
-		if (temp == size)
-			goto done;
 	}
 
 	temp = snprintf(next, size, "\n");
@@ -437,7 +435,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 	size -= temp;
 	next += temp;
 
-done:
 	*sizep = size;
 	*nextp = next;
 }
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2a874058dff1..4d2de9ce03f9 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1873,9 +1873,8 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 			schedule_delayed_work(&musb->irq_work,
 					      msecs_to_jiffies(1000));
 			musb->quirk_retries--;
-			break;
 		}
-		/* fall through */
+		break;
 	case MUSB_QUIRK_B_INVALID_VBUS_91:
 		if (musb->quirk_retries && !musb->flush_irq_work) {
 			musb_dbg(musb,
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 1afffa92420a..6d4c572807a4 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1001,9 +1001,9 @@ static const struct usb_device_id id_table_combined[] = {
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
index 06bbb8d7a804..c0e385b3f4ae 100644
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
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index fc6c42eeb659..ff21ce511f47 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -172,20 +172,9 @@ static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
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
diff --git a/fs/block_dev.c b/fs/block_dev.c
index b34f76af59c4..5c6ff1572405 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2041,21 +2041,26 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	/* Invalidate the page cache, including dirty pages. */
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	mapping = bdev->bd_inode->i_mapping;
-	truncate_inode_pages_range(mapping, start, end);
 
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		truncate_inode_pages_range(mapping, start, end);
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		truncate_inode_pages_range(mapping, start, end);
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		truncate_inode_pages_range(mapping, start, end);
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
 		break;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 23beabb48923..c76277ccf03b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1789,6 +1789,15 @@ static noinline int btrfs_ioctl_snap_create_transid(struct file *file,
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
 			ret = btrfs_mksubvol(&file->f_path, name, namelen,
 					     BTRFS_I(src_inode)->root,
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index dd67f56ea61e..c9ebfff5190a 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -338,6 +338,10 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
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
index 7177720e822e..d3d5d2c6c401 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -302,6 +302,9 @@ static const bool has_smb2_data_area[NUMBER_OF_SMB2_COMMANDS] = {
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
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 8a44d59947b7..dd6e749b2400 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -610,7 +610,7 @@ struct smb2_tree_disconnect_rsp {
 #define SMB2_CREATE_SD_BUFFER			"SecD" /* security descriptor */
 #define SMB2_CREATE_DURABLE_HANDLE_REQUEST	"DHnQ"
 #define SMB2_CREATE_DURABLE_HANDLE_RECONNECT	"DHnC"
-#define SMB2_CREATE_ALLOCATION_SIZE		"AISi"
+#define SMB2_CREATE_ALLOCATION_SIZE		"AlSi"
 #define SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
 #define SMB2_CREATE_TIMEWARP_REQUEST		"TWrp"
 #define SMB2_CREATE_QUERY_ON_DISK_ID		"QFid"
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 4f60e86f4b8d..e92c914316cb 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -380,6 +380,8 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 		return 0;
 
 	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		err = vlan_vid_add(dev, vid_info->proto, vid_info->vid);
 		if (err)
 			goto unwind;
@@ -390,6 +392,8 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 	list_for_each_entry_continue_reverse(vid_info,
 					     &vlan_info->vid_list,
 					     list) {
+		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
+			continue;
 		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
 	}
 
@@ -409,8 +413,11 @@ void vlan_vids_del_by_dev(struct net_device *dev,
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
index 462ba144cb39..9104a2fce015 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -243,6 +243,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
 
+				*wnames = NULL;
+
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
 				if (!errcode) {
@@ -252,6 +254,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 							  GFP_NOFS);
 					if (!*wnames)
 						errcode = -ENOMEM;
+					else
+						(*wnames)[0] = NULL;
 				}
 
 				if (!errcode) {
@@ -263,8 +267,10 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
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
 
@@ -272,11 +278,14 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
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
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8b59f7808628..7ce6932d9ca6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1701,7 +1701,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		return;
 	}
 
-	set_bit(HCI_INQUIRY, &hdev->flags);
+	if (hci_sent_cmd_data(hdev, HCI_OP_INQUIRY))
+		set_bit(HCI_INQUIRY, &hdev->flags);
 }
 
 static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
diff --git a/net/core/dev.c b/net/core/dev.c
index 0f9214fb36e0..b5c9648c2192 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3200,6 +3200,14 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
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
index 5b5b0f95ffd1..c7f47dba884e 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1022,8 +1022,8 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
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
@@ -1031,9 +1031,9 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
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
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index af0842744fc8..7524544a965f 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -130,6 +130,14 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
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
index d32fb40650a7..015e475f5554 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -184,21 +184,47 @@ void rose_kill_by_neigh(struct rose_neigh *neigh)
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
@@ -658,7 +684,10 @@ static int rose_release(struct socket *sock)
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
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 44daf2a57d7e..2b345ba083d8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8606,6 +8606,17 @@ static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
 	}
 }
 
+static void alc897_fixup_lenovo_headset_mode(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+		spec->gen.hp_automute_hook = alc897_hp_automute_hook;
+	}
+}
+
 static const struct coef_fw alc668_coefs[] = {
 	WRITE_COEF(0x01, 0xbebe), WRITE_COEF(0x02, 0xaaaa), WRITE_COEF(0x03,    0x0),
 	WRITE_COEF(0x04, 0x0180), WRITE_COEF(0x06,    0x0), WRITE_COEF(0x07, 0x0f80),
@@ -8688,6 +8699,8 @@ enum {
 	ALC897_FIXUP_LENOVO_HEADSET_MIC,
 	ALC897_FIXUP_HEADSET_MIC_PIN,
 	ALC897_FIXUP_HP_HSMIC_VERB,
+	ALC897_FIXUP_LENOVO_HEADSET_MODE,
+	ALC897_FIXUP_HEADSET_MIC_PIN2,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -9095,6 +9108,19 @@ static const struct hda_fixup alc662_fixups[] = {
 			{ }
 		},
 	},
+	[ALC897_FIXUP_LENOVO_HEADSET_MODE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc897_fixup_lenovo_headset_mode,
+	},
+	[ALC897_FIXUP_HEADSET_MIC_PIN2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x01a11140 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC897_FIXUP_LENOVO_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -9144,6 +9170,10 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3321, "Lenovo ThinkCentre M70 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x331b, "Lenovo ThinkCentre M90 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3364, "Lenovo ThinkCentre M90 Gen5", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x1849, 0x5892, "ASRock B150M", ALC892_FIXUP_ASROCK_MOBO),

