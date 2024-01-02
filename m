Return-Path: <linux-kernel+bounces-14754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E92582219A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710D31C2176F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C8171C2;
	Tue,  2 Jan 2024 18:59:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C616433;
	Tue,  2 Jan 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T4Mbd6BVcz9smm;
	Tue,  2 Jan 2024 19:59:41 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: hci_event: Do sanity checks before retrying to connect
Date: Tue,  2 Jan 2024 19:59:31 +0100
Message-ID: <20240102185933.64179-5-verdre@v0yd.nl>
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

When we receive "Command Disallowed" response to HCI_CREATE_CONNECTION,
we'll try to connect again later, assuming that the command failed either
because there's already concurrent "Create Connection" requests on the
card and all "slots" for new connections are exhausted, or the card is
in the middle of doing an HCI Inquiry.

Both of those conditions we should know about, so do some sanity checking
to ensure one of them actually applies. If they don't, log an error and
delete the connection.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
---
 net/bluetooth/hci_event.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e1f5b6f90..1376092c5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2323,8 +2323,28 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
+			/* If the request failed with "Command Disallowed", the
+			 * card is either using all its available "slots" for
+			 * attempting new connections, or it's currently
+			 * doing an HCI Inquiry. In these cases we'll try to
+			 * do the "Create Connection" request again later.
+			 */
 			if (status == HCI_ERROR_COMMAND_DISALLOWED) {
 				conn->state = BT_CONNECT2;
+
+				if (!hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT) &&
+				    !test_bit(HCI_INQUIRY, &hdev->flags)) {
+					bt_dev_err(hdev,
+						   "\"Create Connection\" returned error "
+						   "(0x%2.2x) indicating to try again, but "
+						   "there's no concurrent \"Create "
+						   "Connection\" nor an ongoing inquiry",
+						   status);
+
+					conn->state = BT_CLOSED;
+					hci_connect_cfm(conn, status);
+					hci_conn_del(conn);
+				}
 			} else {
 				conn->state = BT_CLOSED;
 				hci_connect_cfm(conn, status);
-- 
2.43.0


