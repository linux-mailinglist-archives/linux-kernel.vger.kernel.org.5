Return-Path: <linux-kernel+bounces-164492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D198B7E33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253A41F216C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71941802BE;
	Tue, 30 Apr 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO8L19Ia"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB401B96B;
	Tue, 30 Apr 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496931; cv=none; b=s6eNr2cWybE/S1Kt+9wGLomNbydpUS9Y22saTyG6xqUDpBD83RpMjIenR/OBZ3tqDuO55dBPR3Os6OuDlNHCLr1lDIl0w3UbxyoSl2QEKYSbM0cOkYjhTQPs82/Cpy5sHFYCXH3823c3wbPIU18VRhqqD48KtcURPXgSsCrTGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496931; c=relaxed/simple;
	bh=FhLIyQvkEOjvJXNcLofvpaDIzcF1HD78LcwNNGOv7dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODJwCSiFx7+qexWsk0BCIYVLeefBRUscu95fA+VQaf9gTVK7Qf7erA5Smxqx/Eq3iNA2tBDtvuE/G9vpmEjBeaYCMArgI+7Kp+1SnhckkiznkXjAR1spaMbZHJxM6KEHbppSxzIPO82GUx8g1s8QmIwTEpk++83NYmnDs1a12UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO8L19Ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8830C4AF17;
	Tue, 30 Apr 2024 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714496930;
	bh=FhLIyQvkEOjvJXNcLofvpaDIzcF1HD78LcwNNGOv7dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IO8L19Ias5sbXwBSDTvyl2itz5MfUrW0Nqsshuhh7cO6nrL8IpJXa7tDKl0swpU86
	 bR9Q2Tn2lY2T2sn/oG/UiZMrB18hSSkfSDq1Lz5VZjI618bf9VOHGnsyJtr4irQ1fD
	 8vug0yCAAVchNOe9+3CAInzdl3EBSMVarHvMAauAgyVDtEU2pw54UIqqs46m6r/H/M
	 z2q/Cz7uhIL5Z/pjqZvZSGuUSlRj75KOh11mpncUB8hmYpZgGHgXGGfIjgv5Ovrgxk
	 wtsclV7YshM4cuV4R0s1B3ahwicsU7rcWw6sLvNgULSaJIrxNZ7dthqFYp705HsnZ8
	 yvjWO/d5nwJ6w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s1qyK-0000000047c-3YZG;
	Tue, 30 Apr 2024 19:08:52 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: qca: generalise device address check
Date: Tue, 30 Apr 2024 19:07:41 +0200
Message-ID: <20240430170741.15742-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430170741.15742-1-johan+linaro@kernel.org>
References: <20240430170741.15742-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default device address apparently comes from the NVM configuration
file and can differ quite a bit between controllers.

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
index f6c9f89a6311..c6b2dd4d1716 100644
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
@@ -387,6 +384,14 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
 
 			/* Update NVM tags as needed */
 			switch (tag_id) {
+			case EDL_TAG_ID_BD_ADDR:
+				if (tag_len != sizeof(bdaddr_t))
+					return -EINVAL;
+
+				memcpy(&config->bdaddr, tlv_nvm->data, sizeof(bdaddr_t));
+
+				break;
+
 			case EDL_TAG_ID_HCI:
 				if (tag_len < 3)
 					return -EINVAL;
@@ -661,7 +666,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
-static int qca_check_bdaddr(struct hci_dev *hdev)
+static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *config)
 {
 	struct hci_rp_read_bd_addr *bda;
 	struct sk_buff *skb;
@@ -685,10 +690,8 @@ static int qca_check_bdaddr(struct hci_dev *hdev)
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, QCA_BDADDR_DEFAULT) ||
-	    !bacmp(&bda->bdaddr, QCA_BDADDR_WCN3991)) {
+	if (!bacmp(&bda->bdaddr, &config->bdaddr))
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-	}
 
 	kfree_skb(skb);
 
@@ -716,7 +719,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
 		   const char *firmware_name)
 {
-	struct qca_fw_config config;
+	struct qca_fw_config config = {};
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
@@ -901,7 +904,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
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


