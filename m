Return-Path: <linux-kernel+bounces-19423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B1E826CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20721F2251E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC7224E9;
	Mon,  8 Jan 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cPAtMVSH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2472E82A;
	Mon,  8 Jan 2024 11:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F307BC433C9;
	Mon,  8 Jan 2024 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704713188;
	bh=HpPKsj4Nc1ZThAxSpw2Dr2zw04q9yAeqxsgscV3Zifs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPAtMVSHa+ZXL8VOCzeIkDHAYbyE7Sfkz+Ow26Ka4M2AKeYf4JIkWKMLsVMpgll2P
	 HbfSKEHXI7uMcabbGyxtbYvbetCATkvCAtDoyjsiwf/+VT2K1NJk2UHotF69zJycAA
	 LqkkGw6HjfRMtoAEObqmtBXOa1os78PbnszXyTWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.335
Date: Mon,  8 Jan 2024 12:26:19 +0100
Message-ID: <2024010819-nervous-rockfish-6669@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024010819-audition-creative-f1dc@gregkh>
References: <2024010819-audition-creative-f1dc@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 4afe89430803..3c6015cad38f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 334
+SUBLEVEL = 335
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 79d71b1eae59..1bc17fd49e48 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -784,10 +784,15 @@ void __init omap_soc_device_init(void)
 
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
index 44830bce13df..689dfd1ef98b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -421,13 +421,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
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
index 94ab60397c95..8af3ec3c692e 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1257,11 +1257,12 @@ static void integrity_metadata(struct work_struct *w)
 			checksums = checksums_onstack;
 
 		__bio_for_each_segment(bv, bio, iter, dio->orig_bi_iter) {
+			struct bio_vec bv_copy = bv;
 			unsigned pos;
 			char *mem, *checksums_ptr;
 
 again:
-			mem = (char *)kmap_atomic(bv.bv_page) + bv.bv_offset;
+			mem = (char *)kmap_atomic(bv_copy.bv_page) + bv_copy.bv_offset;
 			pos = 0;
 			checksums_ptr = checksums;
 			do {
@@ -1270,7 +1271,7 @@ static void integrity_metadata(struct work_struct *w)
 				sectors_to_process -= ic->sectors_per_block;
 				pos += ic->sectors_per_block << SECTOR_SHIFT;
 				sector += ic->sectors_per_block;
-			} while (pos < bv.bv_len && sectors_to_process && checksums != checksums_onstack);
+			} while (pos < bv_copy.bv_len && sectors_to_process && checksums != checksums_onstack);
 			kunmap_atomic(mem);
 
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
@@ -1290,9 +1291,9 @@ static void integrity_metadata(struct work_struct *w)
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
index 33a688d8aaba..3c6a32d54846 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -880,10 +880,13 @@ static int atl1e_setup_ring_resources(struct atl1e_adapter *adapter)
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
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 93b046c7409c..59271e49ec48 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1006,9 +1006,9 @@ static const struct usb_device_id id_table_combined[] = {
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
index 07bf2297a9c1..902bbe52a1d6 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -275,6 +275,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200U			0x0901
+#define QUECTEL_PRODUCT_EG912Y			0x6001
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
 #define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
@@ -1235,6 +1236,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, 0x0700, 0xff), /* BG95 */
 	  .driver_info = RSVD(3) | ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
 	  .driver_info = ZLP },
@@ -1247,6 +1249,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG912Y, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
@@ -2244,6 +2247,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0da, 0xff),                     /* Foxconn T99W265 MBIM variant */
+	  .driver_info = RSVD(3) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0db, 0xff),			/* Foxconn T99W265 MBIM */
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0ee, 0xff),			/* Foxconn T99W368 MBIM */
diff --git a/fs/block_dev.c b/fs/block_dev.c
index a56974d04010..a3f1fba18d64 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2033,21 +2033,26 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
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
diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 1885403c9a3e..31e37af6109c 100644
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
@@ -251,6 +253,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 						    GFP_NOFS);
 					if (!*wnames)
 						errcode = -ENOMEM;
+					else
+						(*wnames)[0] = NULL;
 				}
 
 				if (!errcode) {
@@ -262,8 +266,10 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
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
 
@@ -271,11 +277,14 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
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
index bf863cf845bb..07605fcc9091 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1471,7 +1471,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		return;
 	}
 
-	set_bit(HCI_INQUIRY, &hdev->flags);
+	if (hci_sent_cmd_data(hdev, HCI_OP_INQUIRY))
+		set_bit(HCI_INQUIRY, &hdev->flags);
 }
 
 static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
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
index f69c6c38ca43..ab46de4536c4 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1025,8 +1025,8 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
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
@@ -1034,9 +1034,9 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
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
index f8f3b1a8f8e3..9e3210cbe922 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -129,6 +129,14 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
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

