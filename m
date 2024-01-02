Return-Path: <linux-kernel+bounces-14432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADAB821CFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D20286C3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA90C101FA;
	Tue,  2 Jan 2024 13:42:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CC125B5;
	Tue,  2 Jan 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T4DM83spzz9tJ3;
	Tue,  2 Jan 2024 14:33:24 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	asahi@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: HCI: Add new state HCI_POWERING_DOWN
Date: Tue,  2 Jan 2024 14:33:09 +0100
Message-ID: <20240102133311.6712-4-verdre@v0yd.nl>
In-Reply-To: <20240102133311.6712-1-verdre@v0yd.nl>
References: <20240102133311.6712-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T4DM83spzz9tJ3

Add a new state HCI_POWERING_DOWN that indicates that the device is
currently powering down, this will be useful for the next commit.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_sync.c    | 16 +++++++++++-----
 net/bluetooth/mgmt.c        | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cf5d6230c..e08afd870 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -361,6 +361,7 @@ enum {
 	HCI_SETUP,
 	HCI_CONFIG,
 	HCI_DEBUGFS_CREATED,
+	HCI_POWERING_DOWN,
 	HCI_AUTO_OFF,
 	HCI_RFKILLED,
 	HCI_MGMT,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e6eee1808..c920de0a2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5389,27 +5389,33 @@ static int hci_power_off_sync(struct hci_dev *hdev)
 	if (!test_bit(HCI_UP, &hdev->flags))
 		return 0;
 
+	hci_dev_set_flag(hdev, HCI_POWERING_DOWN);
+
 	if (test_bit(HCI_ISCAN, &hdev->flags) ||
 	    test_bit(HCI_PSCAN, &hdev->flags)) {
 		err = hci_write_scan_enable_sync(hdev, 0x00);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	err = hci_clear_adv_sync(hdev, NULL, false);
 	if (err)
-		return err;
+		goto out;
 
 	err = hci_stop_discovery_sync(hdev);
 	if (err)
-		return err;
+		goto out;
 
 	/* Terminated due to Power Off */
 	err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
 	if (err)
-		return err;
+		goto out;
+
+	err = hci_dev_close_sync(hdev);
 
-	return hci_dev_close_sync(hdev);
+out:
+	hci_dev_clear_flag(hdev, HCI_POWERING_DOWN);
+	return err;
 }
 
 int hci_set_powered_sync(struct hci_dev *hdev, u8 val)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c5291e139..8f42ee059 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1382,6 +1382,14 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	if (!cp->val) {
+		if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
+			err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
+					      MGMT_STATUS_BUSY);
+			goto failed;
+		}
+	}
+
 	if (pending_find(MGMT_OP_SET_POWERED, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
 				      MGMT_STATUS_BUSY);
@@ -9742,6 +9750,9 @@ bool mgmt_powering_down(struct hci_dev *hdev)
 	struct mgmt_pending_cmd *cmd;
 	struct mgmt_mode *cp;
 
+	if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN))
+		return true;
+
 	cmd = pending_find(MGMT_OP_SET_POWERED, hdev);
 	if (!cmd)
 		return false;
@@ -10049,6 +10060,9 @@ void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 		/* If this is a HCI command related to powering on the
 		 * HCI dev don't send any mgmt signals.
 		 */
+		if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN))
+			return;
+
 		if (pending_find(MGMT_OP_SET_POWERED, hdev))
 			return;
 	}
-- 
2.43.0


