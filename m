Return-Path: <linux-kernel+bounces-28006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2044B82F8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF117288D83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176165C210;
	Tue, 16 Jan 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI2MZe++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF613C4FB;
	Tue, 16 Jan 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434823; cv=none; b=C6iw0zWj2jLZd7gyA5ExDx2xafPdQdE/imeiXwOZtQJxsECHmIpGMpitNBGHmbYrm5UXUXXYSQ0AO0VyDuI6SEJvYFrNalbqxMbym5Z7KRjcF/MXcbFnztEWBUzsiTyRfvxkHZE24I6gPlcKdfZobAry5N7gNRxnwzKxULFX7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434823; c=relaxed/simple;
	bh=HZWbSuLvYBtkPlXx/m8SCHZ8mGDY4zsIs5hUx6mN2C8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=piGnEDThWH8X4TPFcJfPKGDdSZIwczQF1NHxMK73cXx8EhNFjPZvRMnsEzhds8TM8rOHZieu3eM7KVNhZizaJq6gv7WiaoF+/4DZDYn9WXCGkUW0UpQAb0HrJZ5MHMb6bnojkjASGFbXfQe37oasYbceyxQFiWZeRXc6rRED3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI2MZe++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362A2C43390;
	Tue, 16 Jan 2024 19:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434823;
	bh=HZWbSuLvYBtkPlXx/m8SCHZ8mGDY4zsIs5hUx6mN2C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PI2MZe++3Cb5l5VLRA/8nvRWWf07SFxz3/vz3kawHeoLbIq4roijcPls9eOlIZoIe
	 lK0gSJ24LAxRGI4xhEa0uKwjy6BEHCFXRw05+5SV4WtL8eyK1b1MTe7WqjBqTLG4k6
	 jVCrM/4xDZlGYtPDmXn3L1ie9wifbaer/2g//ZJ1v5J3Z9CubT0gRq8MSMJjabmbW/
	 gCa2JFwMHdJ6L/C69A28d05nat8BAmw6Js4psYYOl8BC1Q7uwM/buH+Agb56lc+PjH
	 ihfbDUI5TY1swCSUu8wVAP4jOjG/c14lRSHvndyILVWPlOq80IbHUbl6wN0XKRmDfR
	 NzYvyxH+ctNow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 094/104] Bluetooth: ISO: Avoid creating child socket if PA sync is terminating
Date: Tue, 16 Jan 2024 14:47:00 -0500
Message-ID: <20240116194908.253437-94-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Iulia Tanasescu <iulia.tanasescu@nxp.com>

[ Upstream commit 9f150019f176078144b02c4b9b9dbe7fd5a2fcc3 ]

When a PA sync socket is closed, the associated hcon is also unlinked
and cleaned up. If there are no other hcons marked with the
HCI_CONN_PA_SYNC flag, HCI_OP_LE_PA_TERM_SYNC is sent to controller.

Between the time of the command and the moment PA sync is terminated
in controller, residual BIGInfo reports might continue to come.
This causes a new PA sync hcon to be added, and a new socket to be
notified to user space.

This commit fixs this by adding a flag on a Broadcast listening
socket to mark when the PA sync child has been closed.

This flag is checked when BIGInfo reports are indicated in
iso_connect_ind, to avoid recreating a hcon and socket if
residual reports arrive before PA sync is terminated.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 51 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2132a16be93c..0eeec6480139 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -52,6 +52,7 @@ static void iso_sock_kill(struct sock *sk);
 enum {
 	BT_SK_BIG_SYNC,
 	BT_SK_PA_SYNC,
+	BT_SK_PA_SYNC_TERM,
 };
 
 struct iso_pinfo {
@@ -80,6 +81,11 @@ static bool iso_match_sid(struct sock *sk, void *data);
 static bool iso_match_sync_handle(struct sock *sk, void *data);
 static void iso_sock_disconn(struct sock *sk);
 
+typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
+
+static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
+					iso_sock_match_t match, void *data);
+
 /* ---- ISO timers ---- */
 #define ISO_CONN_TIMEOUT	(HZ * 40)
 #define ISO_DISCONN_TIMEOUT	(HZ * 2)
@@ -188,10 +194,21 @@ static void iso_chan_del(struct sock *sk, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 }
 
+static bool iso_match_conn_sync_handle(struct sock *sk, void *data)
+{
+	struct hci_conn *hcon = data;
+
+	if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
+		return false;
+
+	return hcon->sync_handle == iso_pi(sk)->sync_handle;
+}
+
 static void iso_conn_del(struct hci_conn *hcon, int err)
 {
 	struct iso_conn *conn = hcon->iso_data;
 	struct sock *sk;
+	struct sock *parent;
 
 	if (!conn)
 		return;
@@ -207,6 +224,25 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 
 	if (sk) {
 		lock_sock(sk);
+
+		/* While a PA sync hcon is in the process of closing,
+		 * mark parent socket with a flag, so that any residual
+		 * BIGInfo adv reports that arrive before PA sync is
+		 * terminated are not processed anymore.
+		 */
+		if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+			parent = iso_get_sock_listen(&hcon->src,
+						     &hcon->dst,
+						     iso_match_conn_sync_handle,
+						     hcon);
+
+			if (parent) {
+				set_bit(BT_SK_PA_SYNC_TERM,
+					&iso_pi(parent)->flags);
+				sock_put(parent);
+			}
+		}
+
 		iso_sock_clear_timer(sk);
 		iso_chan_del(sk, err);
 		release_sock(sk);
@@ -543,8 +579,6 @@ static struct sock *__iso_get_sock_listen_by_sid(bdaddr_t *ba, bdaddr_t *bc,
 	return NULL;
 }
 
-typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
-
 /* Find socket listening:
  * source bdaddr (Unicast)
  * destination bdaddr (Broadcast only)
@@ -1756,9 +1790,20 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		/* Try to get PA sync listening socket, if it exists */
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 						iso_match_pa_sync_flag, NULL);
-		if (!sk)
+
+		if (!sk) {
 			sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 						 iso_match_sync_handle, ev2);
+
+			/* If PA Sync is in process of terminating,
+			 * do not handle any more BIGInfo adv reports.
+			 */
+
+			if (sk && test_bit(BT_SK_PA_SYNC_TERM,
+					   &iso_pi(sk)->flags))
+				return lm;
+		}
+
 		if (sk) {
 			int err;
 
-- 
2.43.0


