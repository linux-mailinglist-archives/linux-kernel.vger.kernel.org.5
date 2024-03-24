Return-Path: <linux-kernel+bounces-114227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F39888938
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58AB1C2728B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB78D20A097;
	Sun, 24 Mar 2024 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3SXWZSx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AEC209E04;
	Sun, 24 Mar 2024 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321575; cv=none; b=F7YILjg5YQliYzm5AUiCq3PppjrLhB8v5ngAVshT5Xch6ddnKjbsr5vlMXuO5Bfzthc761GWjWl81WpqwAi8fL3R9iQ5ehuUfqf8DLZO70xQL3rGpnsL/Qq6tFigCxjpLgVNma5n25MNTOuBMUewcxLYi3ITJeSK6hN5CCQcAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321575; c=relaxed/simple;
	bh=l0RDBMO4ElUNEm1P/jMYSzC4AlfhT61QfEjifNxkOU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSVyGKz/KqAsIegRIlTvEWuSXljtwC5YpM2/cm/CTglfJJtDuThc5G9Bo9a//9BCA6+R67n1bFtVKEHlqv+N1KDUyzMInG/6bjbRwjDT3yQww4rCrafVAAMDetqC8VceRwGv995ar5fkWFQqhhYTK4l32ylxfzmwlnY/hCaUymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3SXWZSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF951C43390;
	Sun, 24 Mar 2024 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321574;
	bh=l0RDBMO4ElUNEm1P/jMYSzC4AlfhT61QfEjifNxkOU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3SXWZSx70yFrU7GbTThsz5ygAkjyoGH9/Y5xXyTXEbemtXb455MxW1UTHt9wwlKZ
	 fGqNjAcw2Rf8sZ5E80ne/GWo3U8HRhnULHFZU5xrJhw76W2zEzSV0bjimcTtE3m59M
	 W7AAQiZu074ZFx6tbJT6bKZoJL2DEtCKoD6fqhUnuBaVEl8AY630yAJGuY1PTRZ1Me
	 UjS43HdSxvZfszOat/O/KngvTDgcCljWSoK3sbwzJVdd9rCxCL3COxvAGQQWdAVPhN
	 tRR0VEc7FSLB+d3tqsm0tpARZkTUQs1amKWU35pOkBHUMCAkszpMfwMVJBLDF6C5Sh
	 xe/NhVhMGd/VQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 302/638] Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
Date: Sun, 24 Mar 2024 18:55:39 -0400
Message-ID: <20240324230116.1348576-303-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit eeda1bf97bb500a901f7a9ee5615bad2160f2378 ]

BIG Sync (aka. Broadcast sink) requires to inform that the device is
connected when a data path is active otherwise userspace could attempt
to free resources allocated to the device object while scanning.

Fixes: 1d11d70d1f6b ("Bluetooth: ISO: Pass BIG encryption info through QoS")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 21 ++++++++++++++-------
 net/bluetooth/mgmt.c      |  4 ++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dae5fff7a32b3..2bfc852283394 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2524,9 +2524,7 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	 * Only those in BT_CONFIG or BT_CONNECTED states can be
 	 * considered connected.
 	 */
-	if (conn &&
-	    (conn->state == BT_CONFIG || conn->state == BT_CONNECTED) &&
-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	if (conn && (conn->state == BT_CONFIG || conn->state == BT_CONNECTED))
 		mgmt_device_connected(hdev, conn, name, name_len);
 
 	if (discov->state == DISCOVERY_STOPPED)
@@ -3758,8 +3756,9 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else {
 		mgmt_device_connected(hdev, conn, NULL, 0);
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -3932,6 +3931,11 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *hdev, void *data,
 		 * last.
 		 */
 		hci_connect_cfm(conn, rp->status);
+
+		/* Notify device connected in case it is a BIG Sync */
+		if (!rp->status && test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
+			mgmt_device_connected(hdev, conn, NULL, 0);
+
 		break;
 	}
 
@@ -5006,8 +5010,9 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev, void *data,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else {
 		mgmt_device_connected(hdev, conn, NULL, 0);
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -5980,8 +5985,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, conn, NULL, 0);
+	mgmt_device_connected(hdev, conn, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->state = BT_CONFIG;
@@ -7220,6 +7224,9 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	/* Notify iso layer */
 	hci_connect_cfm(pa_sync, 0x00);
 
+	/* Notify MGMT layer */
+	mgmt_device_connected(hdev, pa_sync, NULL, 0);
+
 unlock:
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2186ac57981e5..b21b981f15a38 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3118,6 +3118,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 static u8 link_to_bdaddr(u8 link_type, u8 addr_type)
 {
 	switch (link_type) {
+	case ISO_LINK:
 	case LE_LINK:
 		switch (addr_type) {
 		case ADDR_LE_DEV_PUBLIC:
@@ -9610,6 +9611,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	u16 eir_len = 0;
 	u32 flags = 0;
 
+	if (test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		return;
+
 	/* allocate buff for LE or BR/EDR adv */
 	if (conn->le_adv_data_len > 0)
 		skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_CONNECTED,
-- 
2.43.0


