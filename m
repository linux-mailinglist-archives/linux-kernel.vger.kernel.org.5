Return-Path: <linux-kernel+bounces-12530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB281F641
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36045283289
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA463CA;
	Thu, 28 Dec 2023 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HRFKcLfp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30CA63A8;
	Thu, 28 Dec 2023 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6569d70ca56211eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=j3gssqpamwVPINxlyQtLb57s1xKFMi9YNYYa36A9GTc=;
	b=HRFKcLfpYpbEOnq6iJ5vg00qcFDCOt8Kt2Cg4f7fcZgEFqdPp22CBXwnfO7sSdE/WS/yqyBhd8DWpDTOwLSHiXBxax0CkpMYTz1D9a4+fICcMAsRnN8u6IrSNDWPC69EWmzWAR47+6ABxR1CsydQ2bUz1jWxjgJN3gygHxo4sRI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:006e0797-2d99-40df-a4da-1c69c029b265,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:b4b64282-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6569d70ca56211eea2298b7352fd921d-20231228
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <peter.tsao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2133886294; Thu, 28 Dec 2023 17:20:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 17:20:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 17:20:51 +0800
From: Peter Tsao <peter.tsao@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, Steve
 Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Tsao <peter.tsao@mediatek.com>
Subject: [PATCH] Bluetooth: btusb: Fix MT7925 fail to send download patch command
Date: Thu, 28 Dec 2023 17:20:14 +0800
Message-ID: <20231228092014.23184-1-peter.tsao@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Write the register 0x18011100[1] = 1 to avoid the device enter sleep
state during download patch flow on specific platform.

Error log:
Bluetooth: hci0: Execution of wmt command timed out
Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
Bluetooth: hci0: Failed to set up firmware (-110)

Signed-off-by: Peter Tsao <peter.tsao@mediatek.com>
---
 drivers/bluetooth/btmtk.h | 3 +++
 drivers/bluetooth/btusb.c | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 56f5502baadf..8b582077a01f 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -22,6 +22,9 @@
 #define MT7921_DLSTATUS 0x7c053c10
 #define BT_DL_STATE BIT(1)
 
+#define MT7925_SLPPROT 0x18011100
+#define SLPPROT_BYPASS BIT(1)
+
 #define MTK_COREDUMP_SIZE		(1024 * 1000)
 #define MTK_COREDUMP_END		"coredump end"
 #define MTK_COREDUMP_END_LEN		(sizeof(MTK_COREDUMP_END))
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7835170b1d66..842fda0527db 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3120,9 +3120,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	case 0x7668:
 		fwname = FIRMWARE_MT7668;
 		break;
+	case 0x7925:
+		btusb_mtk_uhw_reg_read(data, MT7925_SLPPROT, &val);
+		val |= SLPPROT_BYPASS;
+		btusb_mtk_uhw_reg_write(data, MT7925_SLPPROT, val);
+		fallthrough;
 	case 0x7922:
 	case 0x7961:
-	case 0x7925:
 		if (dev_id == 0x7925)
 			snprintf(fw_bin_name, sizeof(fw_bin_name),
 				 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-- 
2.18.0


