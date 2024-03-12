Return-Path: <linux-kernel+bounces-100163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB458792D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50C6284A68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B91979B79;
	Tue, 12 Mar 2024 11:19:06 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8169D0C;
	Tue, 12 Mar 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242345; cv=none; b=hL5OzbWl5cRTK9+aYm2dK49OmJOURhxqEj2E8cZWrCVu8+arZRm1lvhX3bbfpUb5htEX4pjiIiKc4migb/wiKShIoexizDMdTtSa2D+rfUPb/XaOGw4cFzGTF5PjlJjzORDH6qkvD5LGsOX3xeUqEDjKTcd92RIi8WK/koF9H5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242345; c=relaxed/simple;
	bh=5+eGqcR3MYkhD8YduUqqIVrGgEQDeDQ5doHWHZxAOGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eBKJ8xSiat7z2t3MBT/a8kggstp9CoPkeF9LSDgWxAdVLOnIcRnKd25AQlyiN+/BomKW8FkWHbjN+FadXdgXYRv009SMk3PyNXpKbUsiuNd+9UulbGxWeNx+8K8o8lh6tiajjNz3nGet101xIu2WPJblvIkNnXm/CCu2jiV3FCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42CBIsjO64193468, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42CBIsjO64193468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 19:18:55 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 19:18:54 +0800
Received: from localhost.localhost (172.21.132.123) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 19:18:53 +0800
From: <max.chou@realtek.com>
To: <marcel@holtmann.org>
CC: <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <karenhsu@realtek.com>, <kidman@realtek.com>, <max.chou@realtek.com>
Subject: [PATCH v2] Bluetooth: btrtl: Add the support for RTL8922A
Date: Tue, 12 Mar 2024 19:18:48 +0800
Message-ID: <20240312111848.4599-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Max Chou <max.chou@realtek.com>

Add the support for RTL8922A BT controller on USB interface.
The necessary firmware will be submitted to linux-firmware project.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=8922 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00E04C885A01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Max Chou <max.chou@realtek.com>

---
change in v2:
 - update device info for Driver field.
---
 drivers/bluetooth/btrtl.c | 16 ++++++++++++++++
 drivers/bluetooth/btusb.c | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index cc50de69e8dc..51a2d459cf6d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -30,6 +30,7 @@
 #define RTL_ROM_LMP_8822B	0x8822
 #define RTL_ROM_LMP_8852A	0x8852
 #define RTL_ROM_LMP_8851B	0x8851
+#define RTL_ROM_LMP_8922A	0x8922
 #define RTL_CONFIG_MAGIC	0x8723ab55
 
 #define RTL_VSC_OP_COREDUMP	0xfcff
@@ -69,6 +70,7 @@ enum btrtl_chip_id {
 	CHIP_ID_8852B = 20,
 	CHIP_ID_8852C = 25,
 	CHIP_ID_8851B = 36,
+	CHIP_ID_8922A = 44,
 	CHIP_ID_8852BT = 47,
 };
 
@@ -309,6 +311,15 @@ static const struct id_table ic_id_table[] = {
 	  .cfg_name = "rtl_bt/rtl8851bu_config",
 	  .hw_info  = "rtl8851bu" },
 
+	/* 8922A */
+	{ IC_INFO(RTL_ROM_LMP_8922A, 0xa, 0xc, HCI_USB),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8922au_fw",
+	  .cfg_name = "rtl_bt/rtl8922au_config",
+	  .hw_info  = "rtl8922au" },
+
 	/* 8852BT/8852BE-VT */
 	{ IC_INFO(RTL_ROM_LMP_8852A, 0x87, 0xc, HCI_USB),
 	  .config_needed = false,
@@ -655,6 +666,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8852A, 20 },	/* 8852B */
 		{ RTL_ROM_LMP_8852A, 25 },	/* 8852C */
 		{ RTL_ROM_LMP_8851B, 36 },	/* 8851B */
+		{ RTL_ROM_LMP_8922A, 44 },	/* 8922A */
 		{ RTL_ROM_LMP_8852A, 47 },	/* 8852BT */
 	};
 
@@ -1255,6 +1267,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	case RTL_ROM_LMP_8852A:
 	case RTL_ROM_LMP_8703B:
 	case RTL_ROM_LMP_8851B:
+	case RTL_ROM_LMP_8922A:
 		err = btrtl_setup_rtl8723b(hdev, btrtl_dev);
 		break;
 	default:
@@ -1286,6 +1299,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852B:
 	case CHIP_ID_8852C:
 	case CHIP_ID_8851B:
+	case CHIP_ID_8922A:
 	case CHIP_ID_8852BT:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
@@ -1522,3 +1536,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852btu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8922au_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8922au_config.bin");
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 06e915b57283..d4aa9a84979b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -556,6 +556,17 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8852BT/8852BE-VT Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x8520), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+
+	/* Realtek 8922AE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0x8922), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3617), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3616), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
-- 
2.25.1


