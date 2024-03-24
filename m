Return-Path: <linux-kernel+bounces-115937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CCD889E08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB8BB2E66D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C6838E708;
	Mon, 25 Mar 2024 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcX31ePM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10169229D91;
	Sun, 24 Mar 2024 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322144; cv=none; b=nvX3IpCUqiX8gsh19H01Xtbzep2h3wZ8JtdG3C3AMIYKVVD9tVKiZcwuPol2X4dqjXLdcFkwGBWP9Ugnxq4czQOcx3RzTHgNTExJREtmA2zz0rKged5bBtHbhwrozX81/3Ts4o0eLNhqeoWJs+Ok30MQS+c+Y36gfnqwnlWE63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322144; c=relaxed/simple;
	bh=70+Of7/72M+9iSPocJk3c0sQgYlZ86lfC/taxquLJag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jzdb/cj4EK2gszBhHT/D0LXIh/wMXCm2YMoe2u2LK7eaij91liS/4MVbNM7eCq2QOO8K2SVnVWZoSZh7uP/4eIN1PQRd0vqy5KZnLxxQsKsh8tDPIUZxO+7L2t4iQHnbbn6upPiPhABhwHlCnjEcwYESwhLb0UeE8IM8psKbpSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcX31ePM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2A1C433F1;
	Sun, 24 Mar 2024 23:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322142;
	bh=70+Of7/72M+9iSPocJk3c0sQgYlZ86lfC/taxquLJag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcX31ePMv0M5UF68Ya3yaDjXn15fdCN9hfAMPfUui96CfpkIMnh4wJSEbNsyRuYmb
	 9CC4dpt4DO0w0JUVXfXpLbSbDCQ1Lov2oNuHgIA1TxB2nKk9MAKt8o5wMMjDUac/3s
	 b/LfOSwG8EN1TSPqLPt0Q1CWoda5CKwqn9Qye6+ewfKAWB98QdTh2TU9uuLOzhjPPt
	 HEs6PE1e3XNXnPXcUKeAH30cVUqEmatEFihcVLYpxHATiszpmgygKibC0FgtcuyKbP
	 ypcWHTMsfbeMZckG7aQjllIOb61U1uRUNXuhtgL2PGAWpKMZMXUGzuGGXoAp1spPfZ
	 09NOxhuDSE7bQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 219/451] Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH
Date: Sun, 24 Mar 2024 19:08:15 -0400
Message-ID: <20240324231207.1351418-220-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 112b5090c21905531314fee41f691f0317bbf4f6 ]

HCI_MAX_AD_LENGTH shall only be used if the controller doesn't support
extended advertising, otherwise HCI_MAX_EXT_AD_LENGTH shall be used
instead.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 2ab3e8d67fc1 ("Bluetooth: Fix eir name length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_event.c        | 12 +++++++-----
 net/bluetooth/mgmt.c             |  6 +++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6bc6de5345261..53155cb703b5d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1710,6 +1710,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
+/* Maximum advertising length */
+#define max_adv_len(dev) \
+	(ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH)
+
 /* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 1789:
  *
  * C24: Mandatory if the LE Controller supports Connection State and either
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6b746ab9f6d21..b150dee88f35c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1761,7 +1761,7 @@ static void store_pending_adv_report(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct discovery_state *d = &hdev->discovery;
 
-	if (len > HCI_MAX_AD_LENGTH)
+	if (len > max_adv_len(hdev))
 		return;
 
 	bacpy(&d->last_adv_addr, bdaddr);
@@ -6240,8 +6240,9 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		return;
 	}
 
-	if (!ext_adv && len > HCI_MAX_AD_LENGTH) {
-		bt_dev_err_ratelimited(hdev, "legacy adv larger than 31 bytes");
+	if (len > max_adv_len(hdev)) {
+		bt_dev_err_ratelimited(hdev,
+				       "adv larger than maximum supported");
 		return;
 	}
 
@@ -6306,7 +6307,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 */
 	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, bdaddr_resolved,
 				     type);
-	if (!ext_adv && conn && type == LE_ADV_IND && len <= HCI_MAX_AD_LENGTH) {
+	if (!ext_adv && conn && type == LE_ADV_IND &&
+	    len <= max_adv_len(hdev)) {
 		/* Store report for later inclusion by
 		 * mgmt_device_connected
 		 */
@@ -6447,7 +6449,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 					info->length + 1))
 			break;
 
-		if (info->length <= HCI_MAX_AD_LENGTH) {
+		if (info->length <= max_adv_len(hdev)) {
 			rssi = info->data[info->length];
 			process_adv_report(hdev, info->type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0, rssi,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4a35535f56607..1486fb9bb78f7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8436,8 +8436,8 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	supported_flags = get_supported_adv_flags(hdev);
 
 	rp->supported_flags = cpu_to_le32(supported_flags);
-	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
-	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
+	rp->max_adv_data_len = max_adv_len(hdev);
+	rp->max_scan_rsp_len = max_adv_len(hdev);
 	rp->max_instances = hdev->le_num_of_adv_sets;
 	rp->num_instances = hdev->adv_instance_cnt;
 
@@ -8473,7 +8473,7 @@ static u8 calculate_name_len(struct hci_dev *hdev)
 static u8 tlv_data_max_len(struct hci_dev *hdev, u32 adv_flags,
 			   bool is_adv_data)
 {
-	u8 max_len = HCI_MAX_AD_LENGTH;
+	u8 max_len = max_adv_len(hdev);
 
 	if (is_adv_data) {
 		if (adv_flags & (MGMT_ADV_FLAG_DISCOV |
-- 
2.43.0


