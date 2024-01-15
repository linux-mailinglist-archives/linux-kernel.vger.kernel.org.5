Return-Path: <linux-kernel+bounces-26468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED182E15B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951091C221FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBE11A28A;
	Mon, 15 Jan 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Fvt/V/E3"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7619BCE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id PTJsreNfxZ1tSPTJsr3DED; Mon, 15 Jan 2024 21:12:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705349550;
	bh=Zag1tyR6DZ8o6qntEb3YzGjDPt9iK1tzSJavyfJS+3c=;
	h=From:To:Cc:Subject:Date;
	b=Fvt/V/E3sZtxVJf+mQhWHRGR9UNENrZh+TtJZiiT94FKJKCLoKfIhOWzFRNOlOL6S
	 2ANyEWnTwBUJwHzg7yqtS8/Xj28GYXpAbsuMBZ4KvDMCExUgkmLwovLs5DAyNJQEV/
	 a1/OQUCeh+xlIvp7U8OCVkTZn45UOszSqr4K7PpP48W1IC618W+VxNlTKP/S5qw3rk
	 kI9zZtbWY1rK3KDRybgAhVZEZp4l59LGeF3AtEKkLVHe3oT8CcURsphSxQ5v/fscFG
	 rWyhFzmmaGJrXZ6lGL4yimXGK0QUDdGGRI5LZH8xIuWkj1kH6Hs0KMCO4rr5velLWT
	 VD28KI6E4UjJA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Jan 2024 21:12:30 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove usage of the deprecated ida_simple_xx() API
Date: Mon, 15 Jan 2024 21:12:19 +0100
Message-ID: <3b3523b475d0f5cadf81b3131bb1a38b7476b020.1705349526.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_max() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I've not been able to find the rational for the HCI_MAX_ID value (i.e.
10000) is the BT spec I've found.

Instead of having these HCI_MAX_ID-1 in the code, we could also change
the value of HCI_MAX_ID to 9999.
I don't know what makes the more sense.
---
 net/bluetooth/hci_core.c | 9 +++++----
 net/bluetooth/hci_sock.c | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e5cb618fa6d3..41d2d1956527 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2639,10 +2639,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	 */
 	switch (hdev->dev_type) {
 	case HCI_PRIMARY:
-		id = ida_simple_get(&hci_index_ida, 0, HCI_MAX_ID, GFP_KERNEL);
+		id = ida_alloc_max(&hci_index_ida, HCI_MAX_ID - 1, GFP_KERNEL);
 		break;
 	case HCI_AMP:
-		id = ida_simple_get(&hci_index_ida, 1, HCI_MAX_ID, GFP_KERNEL);
+		id = ida_alloc_range(&hci_index_ida, 1, HCI_MAX_ID - 1,
+				     GFP_KERNEL);
 		break;
 	default:
 		return -EINVAL;
@@ -2741,7 +2742,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
 err:
-	ida_simple_remove(&hci_index_ida, hdev->id);
+	ida_free(&hci_index_ida, hdev->id);
 
 	return error;
 }
@@ -2824,7 +2825,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 
 	ida_destroy(&hdev->unset_handle_ida);
-	ida_simple_remove(&hci_index_ida, hdev->id);
+	ida_free(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
 	kfree_skb(hdev->recv_event);
 	kfree(hdev);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 3e7cd330d731..4ee1b976678b 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -101,7 +101,7 @@ static bool hci_sock_gen_cookie(struct sock *sk)
 	int id = hci_pi(sk)->cookie;
 
 	if (!id) {
-		id = ida_simple_get(&sock_cookie_ida, 1, 0, GFP_KERNEL);
+		id = ida_alloc_min(&sock_cookie_ida, 1, GFP_KERNEL);
 		if (id < 0)
 			id = 0xffffffff;
 
@@ -119,7 +119,7 @@ static void hci_sock_free_cookie(struct sock *sk)
 
 	if (id) {
 		hci_pi(sk)->cookie = 0xffffffff;
-		ida_simple_remove(&sock_cookie_ida, id);
+		ida_free(&sock_cookie_ida, id);
 	}
 }
 
-- 
2.43.0


