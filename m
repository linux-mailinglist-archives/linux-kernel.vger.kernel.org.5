Return-Path: <linux-kernel+bounces-14753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818B822197
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E981F215B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6A168C8;
	Tue,  2 Jan 2024 18:59:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F516415;
	Tue,  2 Jan 2024 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T4Mbc4QNnz9sQb;
	Tue,  2 Jan 2024 19:59:40 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: hci_event: Remove limit of 2 reconnection attempts
Date: Tue,  2 Jan 2024 19:59:30 +0100
Message-ID: <20240102185933.64179-4-verdre@v0yd.nl>
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
X-Rspamd-Queue-Id: 4T4Mbc4QNnz9sQb

Since commit 4c67bc74f016b0d360b8573e18969c0ff7926974, we retry connecting
later when we get a "Command Disallowed" error returned by "Create
Connection".

In this commit the intention was to retry only once, and give up if we see
"Command Disallowed" again on the second try.

This made sense back then when the retry was initiated *only* from the
"Connect Complete" event. If we received that event, we knew that now the
card now must have a "free slot" for a new connection request again. These
days we call hci_conn_check_pending() from a few more places though, and
in these places we can't really be sure that there's a "free slot" on the
card, so the second try to "Create Connection" might fail again.

Deal with this by being less strict about these retries and try again
every time we get "Command Disallowed" errors, removing the limitation to
only two attempts.

Since this can potentially cause us to enter an endless cycle of
reconnection attempts, we'll add some guarding against that with the next
commit.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
---
 net/bluetooth/hci_event.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e8b4a0126..e1f5b6f90 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2323,12 +2323,13 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
-			if (status != HCI_ERROR_COMMAND_DISALLOWED || conn->attempt > 2) {
+			if (status == HCI_ERROR_COMMAND_DISALLOWED) {
+				conn->state = BT_CONNECT2;
+			} else {
 				conn->state = BT_CLOSED;
 				hci_connect_cfm(conn, status);
 				hci_conn_del(conn);
-			} else
-				conn->state = BT_CONNECT2;
+			}
 		}
 	} else {
 		if (!conn) {
-- 
2.43.0


