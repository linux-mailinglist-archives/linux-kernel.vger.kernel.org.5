Return-Path: <linux-kernel+bounces-160342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7DB8B3C28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314FD2829B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F114C5BF;
	Fri, 26 Apr 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6eLPFEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A19149C5E;
	Fri, 26 Apr 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147230; cv=none; b=hdgvbJWuza/qF3bT9r62Jxyhf9MApCDShcmqDdS+UHm9VPDxUjliyBBmdyyyH+RS24w8wNB5XEZ/JW0Jbk/NDjLk881j6XLqM9KquBLHTciMzN3iZ6QDtMIIGs5fUgPPQcxt8RMZSM/iFe306nQBzwhobaePF8NWHpy1Kf7ZyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147230; c=relaxed/simple;
	bh=uK9h4I1j7rfKSkPKuWAlFuwzANHYKX0M1bFIxX+3AkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDM4TOKis2YWIYJSiVYNP0SaupY5g0fDS6HuvJG02I9RYawCdvQx/lbaIsaZgrbaBvqEF/onzxthTLx2NMGa+Q/IPzPilX0jCZ6qsdBDI3WHIuFg1ipMF9sTnfQUmAz6vVFjqMQjDfoUDUXEu2oDrl1kQIH7yMSkbSnp/aR6cx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6eLPFEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E78C113CD;
	Fri, 26 Apr 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714147229;
	bh=uK9h4I1j7rfKSkPKuWAlFuwzANHYKX0M1bFIxX+3AkE=;
	h=From:To:Cc:Subject:Date:From;
	b=f6eLPFEiZ6xNNJR3mQ6Qo5xBHM1aC6YKRza2POnm6EEgTvufM6RD2WTbKE5ZfwT4D
	 sVfWuJBpAr8DBIyiwvZPB18cr67rmn5iMsDHpGKtuOm9+kAIE59IuQnndZwCi32kif
	 s6Dps+UkIJP4Rvv9VSnh5zsQ1PsR4jQxbmuOG75ywi6D7vjNOizvvcjN6NwU5tUm3D
	 SS1+FixvkAz5d/a+N20Mynix+Ma0x8+RoXBDBch3hn8cDblQgoYKzAEjes9aeLOkCt
	 5jGDeOjmdNnbK7grD0vvInoTi9+RcNo68eD7DgSFszh5weqEQFGmLSKFf9xYyqOqh/
	 14rjkm0Ef9Sjw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s0Nzz-000000006c4-1Xt8;
	Fri, 26 Apr 2024 18:00:31 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: [PATCH] Bluetooth: qca: generalise device address check
Date: Fri, 26 Apr 2024 17:58:01 +0200
Message-ID: <20240426155801.25277-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default device address apparently comes from the NVM configuration
file and can differ quite a bit.

Store the default address when parsing the configuration file and use it
to determine whether the controller has been provisioned with an
address.

This makes sure that devices without a unique address start as
unconfigured unless a valid address has been provided in the devicetree.

Fixes: 00567f70051a ("Bluetooth: qca: fix invalid device address check")
Cc: stable@vger.kernel.org      # 6.5
Cc: Doug Anderson <dianders@chromium.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 21 ++++++++++++---------
 drivers/bluetooth/btqca.h |  2 ++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index cfa71708397b..d7a6738e4691 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -15,9 +15,6 @@
 
 #define VERSION "0.1"
 
-#define QCA_BDADDR_DEFAULT (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x00, 0x00 }})
-#define QCA_BDADDR_WCN3991 (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x98, 0x39 }})
-
 int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 			 enum qca_btsoc_type soc_type)
 {
@@ -351,6 +348,11 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 
 			/* Update NVM tags as needed */
 			switch (tag_id) {
+			case EDL_TAG_ID_BD_ADDR:
+				if (tag_len != sizeof(bdaddr_t))
+					break;
+				memcpy(&config->bdaddr, tlv_nvm->data, sizeof(bdaddr_t));
+				break;
 			case EDL_TAG_ID_HCI:
 				/* HCI transport layer parameters
 				 * enabling software inband sleep
@@ -615,7 +617,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
-static int qca_check_bdaddr(struct hci_dev *hdev)
+static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *config)
 {
 	struct hci_rp_read_bd_addr *bda;
 	struct sk_buff *skb;
@@ -624,6 +626,9 @@ static int qca_check_bdaddr(struct hci_dev *hdev)
 	if (bacmp(&hdev->public_addr, BDADDR_ANY))
 		return 0;
 
+	if (!bacmp(&config->bdaddr, BDADDR_ANY))
+		return 0;
+
 	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
@@ -639,10 +644,8 @@ static int qca_check_bdaddr(struct hci_dev *hdev)
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, QCA_BDADDR_DEFAULT) ||
-	    !bacmp(&bda->bdaddr, QCA_BDADDR_WCN3991)) {
+	if (!bacmp(&bda->bdaddr, &config->bdaddr))
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-	}
 
 	kfree_skb(skb);
 
@@ -670,7 +673,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
 		   const char *firmware_name)
 {
-	struct qca_fw_config config;
+	struct qca_fw_config config = {};
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
@@ -855,7 +858,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		break;
 	}
 
-	err = qca_check_bdaddr(hdev);
+	err = qca_check_bdaddr(hdev, &config);
 	if (err)
 		return err;
 
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index dc31984f71dc..49ad668d0d0b 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -29,6 +29,7 @@
 #define EDL_PATCH_CONFIG_RES_EVT	(0x00)
 #define QCA_DISABLE_LOGGING_SUB_OP	(0x14)
 
+#define EDL_TAG_ID_BD_ADDR		2
 #define EDL_TAG_ID_HCI			(17)
 #define EDL_TAG_ID_DEEP_SLEEP		(27)
 
@@ -94,6 +95,7 @@ struct qca_fw_config {
 	uint8_t user_baud_rate;
 	enum qca_tlv_dnld_mode dnld_mode;
 	enum qca_tlv_dnld_mode dnld_type;
+	bdaddr_t bdaddr;
 };
 
 struct edl_event_hdr {
-- 
2.43.2


