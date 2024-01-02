Return-Path: <linux-kernel+bounces-14755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD682219D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350971F23196
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6817738;
	Tue,  2 Jan 2024 18:59:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09D168DF;
	Tue,  2 Jan 2024 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T4Mbg1nPPz9sp4;
	Tue,  2 Jan 2024 19:59:43 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: hci_event: Try reconnecting on more kinds of errors
Date: Tue,  2 Jan 2024 19:59:32 +0100
Message-ID: <20240102185933.64179-6-verdre@v0yd.nl>
In-Reply-To: <20240102185933.64179-1-verdre@v0yd.nl>
References: <20240102185933.64179-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T4Mbg1nPPz9sp4

While some hardware seems to return "HCI Command Disallowed" errors when
trying to connect to too many devices at once, other hardware (eg. the
BCM4378 found in M1 macbooks) returns "HCI Hardware Failure" in this case.

And the Marvell 88W8897 in various Microsoft Surface devices behaves
different again: Here the "HCI Create Connection" succeeds, but later
a "HCI Connection Complete" event with status "Rejected Limited Resources"
comes in.

Handle all these cases as expected by userspace and reuse the existing
BT_CONNECT2 logic to try "HCI Create Connection" again after the ongoing
connection attempts have been completed.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fef723afd..23890f53e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -637,6 +637,7 @@ enum {
 
 /* ---- HCI Error Codes ---- */
 #define HCI_ERROR_UNKNOWN_CONN_ID	0x02
+#define HCI_ERROR_HARDWARE_FAILURE	0x03
 #define HCI_ERROR_AUTH_FAILURE		0x05
 #define HCI_ERROR_PIN_OR_KEY_MISSING	0x06
 #define HCI_ERROR_MEMORY_EXCEEDED	0x07
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1376092c5..46b6d7e27 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2323,13 +2323,14 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
-			/* If the request failed with "Command Disallowed", the
+			/* If the request failed with a certain status, the
 			 * card is either using all its available "slots" for
 			 * attempting new connections, or it's currently
 			 * doing an HCI Inquiry. In these cases we'll try to
 			 * do the "Create Connection" request again later.
 			 */
-			if (status == HCI_ERROR_COMMAND_DISALLOWED) {
+			if (status == HCI_ERROR_COMMAND_DISALLOWED ||
+			    status == HCI_ERROR_HARDWARE_FAILURE) {
 				conn->state = BT_CONNECT2;
 
 				if (!hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT) &&
@@ -3254,7 +3255,26 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 done:
 	if (status) {
-		hci_conn_failed(conn, status);
+		if (status == HCI_ERROR_REJ_LIMITED_RESOURCES) {
+			conn->state = BT_CONNECT2;
+
+			if (!hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT) &&
+			    !test_bit(HCI_INQUIRY, &hdev->flags)) {
+				bt_dev_err(hdev,
+					   "\"Connect Complete\" event with error "
+					   "(0x%2.2x) indicating to try again, but "
+					   "there's no concurrent \"Create "
+					   "Connection\" nor an ongoing inquiry",
+					   status);
+
+				hci_conn_failed(conn, status);
+			}
+
+			hci_dev_unlock(hdev);
+			return;
+		} else {
+			hci_conn_failed(conn, status);
+		}
 	} else if (ev->link_type == SCO_LINK) {
 		switch (conn->setting & SCO_AIRMODE_MASK) {
 		case SCO_AIRMODE_CVSD:
-- 
2.43.0


