Return-Path: <linux-kernel+bounces-140738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA48A187C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE80A1C20F06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DEC14A9F;
	Thu, 11 Apr 2024 15:19:41 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383914005;
	Thu, 11 Apr 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848780; cv=none; b=gh1BPYN6MhSCGCvbDIv/kDzwoWxmq6jVLvXqbnt5nxSS/GnT0VlOkhKHL89263D8D3/2R9YMfzwNrFV8NSGtJE+r38oetctc0z+rUSUP7yt9dSoVzsgmTGeUXcKLSa04HzZk0RTE99qp7PWWjFcQbCnDQOaB+VzCUterJKExW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848780; c=relaxed/simple;
	bh=7KQj8Ij5Bz+/jmiRyKCdBwrOjqQu8Ro0c+7Db6XxeZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s+1L0rviCQggdpGB4TRz8ZlA1HTWxBEHliO0BfGbBo/2gexL8WloIKFsQLtw2fRaHu3z+l0yll+xU1+ZhaxxADt2tsFqc0Nuqxd/1qAUuNbhowBZ0w2SWM9hRpnUjD1kStv0fiM9xgNS/dd57qyb8VmopzDo0uTBXwR5P4tO8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 3DFF42F2023F; Thu, 11 Apr 2024 15:19:36 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id C29D82F20238;
	Thu, 11 Apr 2024 15:19:34 +0000 (UTC)
From: kovalev@altlinux.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kovalev@altlinux.org,
	stable@vger.kernel.org
Subject: [PATCH net] Bluetooth: hci_event: fix possible multiple drops by marked conn->state after hci_disconnect()
Date: Thu, 11 Apr 2024 18:19:29 +0300
Message-Id: <20240411151929.403263-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

When returning from the hci_disconnect() function, the conn->state
continues to be set to BT_CONNECTED and hci_conn_drop() is executed,
which decrements the conn->refcnt.

Syzkaller has generated a reproducer that results in multiple calls to
hci_encrypt_change_evt() of the same conn object.
--
hci_encrypt_change_evt(){
	// conn->state == BT_CONNECTED
	hci_disconnect(){
		hci_abort_conn();
	}
	hci_conn_drop();
	// conn->state == BT_CONNECTED
}
--
This behavior can cause the conn->refcnt to go far into negative values
and cause problems. To get around this, you need to change the conn->state,
namely to BT_DISCONN, as it was before.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 64477e1bde7cec..e0477021183f9b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2989,6 +2989,7 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 
 	hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 	hci_conn_drop(conn);
+	conn->state = BT_DISCONN;
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -3654,6 +3655,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 		hci_encrypt_cfm(conn, ev->status);
 		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		hci_conn_drop(conn);
+		conn->state = BT_DISCONN;
 		goto unlock;
 	}
 
@@ -5248,6 +5250,7 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 	if (ev->status && conn->state == BT_CONNECTED) {
 		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		hci_conn_drop(conn);
+		conn->state = BT_DISCONN;
 		goto unlock;
 	}
 
-- 
2.33.8


