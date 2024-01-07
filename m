Return-Path: <linux-kernel+bounces-18944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC0826583
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40256B20DBF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3B29426;
	Sun,  7 Jan 2024 18:03:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C414F64;
	Sun,  7 Jan 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4T7Q644dvhz9srM;
	Sun,  7 Jan 2024 19:03:08 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	asahi@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: Disconnect connected devices before rfkilling adapter
Date: Sun,  7 Jan 2024 19:02:50 +0100
Message-ID: <20240107180252.73436-5-verdre@v0yd.nl>
In-Reply-To: <20240107180252.73436-1-verdre@v0yd.nl>
References: <20240107180252.73436-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On a lot of platforms (at least the MS Surface devices, M1 macbooks, and
a few ThinkPads) firmware doesn't do its job when rfkilling a device
and the bluetooth adapter is not actually shut down properly on rfkill.
This leads to connected devices remaining in connected state and the
bluetooth connection eventually timing out after rfkilling an adapter.

Use the rfkill hook in the HCI driver to go through the full power-off
sequence (including stopping scans and disconnecting devices) before
rfkilling it, just like MGMT_OP_SET_POWERED would do.

In case anything during the larger power-off sequence fails, make sure
the device is still closed and the rfkill ends up being effective in
the end.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
---
 net/bluetooth/hci_core.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1ec83985f..43e042338 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -940,20 +940,51 @@ int hci_get_dev_info(void __user *arg)
 
 /* ---- Interface to HCI drivers ---- */
 
+static int hci_dev_do_poweroff(struct hci_dev *hdev)
+{
+	int err;
+
+	BT_DBG("%s %p", hdev->name, hdev);
+
+	hci_req_sync_lock(hdev);
+
+	err = hci_set_powered_sync(hdev, false);
+
+	hci_req_sync_unlock(hdev);
+
+	return err;
+}
+
 static int hci_rfkill_set_block(void *data, bool blocked)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
 
 	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
 		return -EBUSY;
 
+	if (blocked == hci_dev_test_flag(hdev, HCI_RFKILLED))
+		return 0;
+
 	if (blocked) {
 		hci_dev_set_flag(hdev, HCI_RFKILLED);
+
 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
-		    !hci_dev_test_flag(hdev, HCI_CONFIG))
-			hci_dev_do_close(hdev);
+		    !hci_dev_test_flag(hdev, HCI_CONFIG)) {
+			err = hci_dev_do_poweroff(hdev);
+			if (err) {
+				bt_dev_err(hdev, "Error when powering off device on rfkill (%d)",
+					   err);
+
+				/* Make sure the device is still closed even if
+				 * anything during power off sequence (eg.
+				 * disconnecting devices) failed.
+				 */
+				hci_dev_do_close(hdev);
+			}
+		}
 	} else {
 		hci_dev_clear_flag(hdev, HCI_RFKILLED);
 	}
-- 
2.43.0


