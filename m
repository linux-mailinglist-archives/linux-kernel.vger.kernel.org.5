Return-Path: <linux-kernel+bounces-485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196008141DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8DB282D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA5D275;
	Fri, 15 Dec 2023 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cEqYxVbK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1ECA68;
	Fri, 15 Dec 2023 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c5d81fb69b1411eea5db2bebc7c28f94-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BTCqKfdwdR9v46nV62z59E3sFP0odYPdEQLNmh4+llU=;
	b=cEqYxVbKs3VPo4AxOjw3XAhJSwoby8Xb4LO9qNx3TRORAGykptMjEOTR/puo2KmVKPuz3xJLInxtvADBMrjeJ4kpdTNAmczVbLphMph+chaV9uJfrdUSsG3jllR/Y2S82ioHy6YcgGYGOr51RrFVWn0fXWYBKd4aA7SKpH2+UIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:68d2a743-a06a-49f2-bfb6-3b8bd3ae02c9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:0b79d273-1bd3-4f48-b671-ada88705968c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c5d81fb69b1411eea5db2bebc7c28f94-20231215
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <hao.qin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1908214513; Fri, 15 Dec 2023 14:40:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 14:40:00 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 14:39:59 +0800
From: Hao Qin <hao.qin@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Steve
 Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, hao.qin <hao.qin@mediatek.com>
Subject: [PATCH 1/1] Bluetooth: btusb: mediatek: add a recovery method for MT7922
Date: Fri, 15 Dec 2023 14:37:14 +0800
Message-ID: <20231215063714.7684-1-hao.qin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: "hao.qin" <hao.qin@mediatek.com>

For MT7922, perform a reset before patch download to avoid
unexpected problems caused by inconsistency between upper layer
status and dongle status. Add USB reset retry to recover from
unexpected patch download failure.

Signed-off-by: hao.qin <hao.qin@mediatek.com>
---
 drivers/bluetooth/btusb.c | 66 +++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0926e4451802..778e1a0d9cae 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2812,7 +2812,7 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 	 * WMT command.
 	 */
 	err = wait_on_bit_timeout(&data->flags, BTUSB_TX_WAIT_VND_EVT,
-				  TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
+				  TASK_INTERRUPTIBLE, HCI_CMD_TIMEOUT);
 	if (err == -EINTR) {
 		bt_dev_err(hdev, "Execution of wmt command interrupted");
 		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
@@ -2994,28 +2994,22 @@ static u32 btusb_mtk_reset_done(struct hci_dev *hdev)
 	return val & MTK_BT_RST_DONE;
 }
 
-static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
+static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct btmediatek_data *mediatek;
 	u32 val;
 	int err;
 
-	/* It's MediaTek specific bluetooth reset mechanism via USB */
-	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
-		bt_dev_err(hdev, "last reset failed? Not resetting again");
-		return -EBUSY;
-	}
-
-	err = usb_autopm_get_interface(data->intf);
-	if (err < 0)
-		return err;
-
-	btusb_stop_traffic(data);
-	usb_kill_anchored_urbs(&data->tx_anchor);
-	mediatek = hci_get_priv(hdev);
-
-	if (mediatek->dev_id == 0x7925) {
+	if (dev_id == 0x7922) {
+		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		val |= 0x00002020;
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
+		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		val |= (1 << 0);
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		msleep(100);
+	} else if (dev_id == 0x7925) {
 		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
 		val |= (1 << 5);
 		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
@@ -3053,14 +3047,41 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
 				 val & MTK_BT_RST_DONE, 20000, 1000000);
 	if (err < 0)
-		bt_dev_err(hdev, "Reset timeout");
+		bt_dev_err(hdev, "Subsys reset timeout");
+
+	if (dev_id == 0x7922)
+		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
 
 	btusb_mtk_id_get(data, 0x70010200, &val);
 	if (!val)
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
 
-	usb_queue_reset_device(data->intf);
+	return err;
+}
+
+static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmediatek_data *mediatek;
+	int err;
+
+	/* It's MediaTek specific bluetooth reset mechanism via USB */
+	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		return -EBUSY;
+	}
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return err;
+
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+	mediatek = hci_get_priv(hdev);
 
+	err = btusb_mtk_subsys_reset(hdev, mediatek->dev_id);
+
+	usb_queue_reset_device(data->intf);
 	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
 
 	return err;
@@ -3119,6 +3140,8 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		fwname = FIRMWARE_MT7668;
 		break;
 	case 0x7922:
+		btusb_mtk_subsys_reset(hdev, dev_id);
+		fallthrough;
 	case 0x7961:
 	case 0x7925:
 		if (dev_id == 0x7925)
@@ -3134,6 +3157,9 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 						btusb_mtk_hci_wmt_sync);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
+			btusb_stop_traffic(data);
+			usb_kill_anchored_urbs(&data->tx_anchor);
+			usb_queue_reset_device(data->intf);
 			return err;
 		}
 
-- 
2.18.0


