Return-Path: <linux-kernel+bounces-160391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4AE8B3CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDA81C226FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D918156F38;
	Fri, 26 Apr 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH36pfzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E211DFED;
	Fri, 26 Apr 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149494; cv=none; b=eE4CuLIJXtHzeVrbocEeOZn9WWJtx8QqN9QDpcgCrr+B49WlVrfd0Ad4VcPUz3pnyoR2TbsRvHhJpWfAn2HrijqtgVmk7EdpIo4uEslsONTUgAwwQsmOZIW3CZYjZBzaxWkldmSKDCOU75+CiA9nyYzGzuyjEVsYgSO06d1Sixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149494; c=relaxed/simple;
	bh=po/3tPrumZXnjowvfQF0vobOIrYbMuIpxi3ty3Z4bsM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oyBRJeshFl4tNlXFoC6zclZZl71Tfd+NIPFUdUyk3SuOJEaDwkiHSokrVWU/Ix/vAieo+Turu+YQdwxucck/7qp45ZRDNHgPr3ZcOJakYyHK3MkaBSrub+JiuuLXiRdDXN0v08l4ABCPXVW5HDwhnieDVNmhh7liDHmaxCFdYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH36pfzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE92C113CD;
	Fri, 26 Apr 2024 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714149494;
	bh=po/3tPrumZXnjowvfQF0vobOIrYbMuIpxi3ty3Z4bsM=;
	h=Date:From:To:Cc:Subject:From;
	b=MH36pfzL5D0g8R54Ia7dwcxBhngVinvMwXLHW4/ap4/EgiHy8OaPeWQVork3iJQty
	 BLCUKNcR7mFVQYIPE0xVhMBMp2l7tKRvJ6BlEbEVFeubLwHBw7teqqZvb7mSum2p2R
	 LhOxkHfsxW23IxmfKx8VwSGJ4Nn1RYOeLBxSfm0vRCsxgAKpl6AVVwfFFpNdnY+dha
	 r4wD2roZproVXID2k75H/syTxz0M0ngUgRWaPE3eR1ONrpb5u3pivo6Qsl1Cil9qTs
	 2a/szL36z7LXJTmvt4L+V/6LgMeZ0PQg5zL3mzYwwZEoVs8EaQ+AwpCZkI332t2rMQ
	 OoBR7zQA4nLqA==
Date: Fri, 26 Apr 2024 10:38:10 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] Bluetooth: hci_conn: Use __counted_by() in struct
 hci_cp_le_big_create_sync and avoid -Wfamnae warning
Message-ID: <ZivYcpzZsc7aIFZ5@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the
__counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time
via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
(for strcpy/memcpy-family functions).

Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
getting ready to enable it globally.

So, use the `DEFINE_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

With these changes, fix the following warning:
net/bluetooth/hci_conn.c:2116:50: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_conn.c    | 30 +++++++++++++-----------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5c12761cbc0e..fe23e862921d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2216,7 +2216,7 @@ struct hci_cp_le_big_create_sync {
 	__u8    mse;
 	__le16  timeout;
 	__u8    num_bis;
-	__u8    bis[];
+	__u8    bis[] __counted_by(num_bis);
 } __packed;
 
 #define HCI_OP_LE_BIG_TERM_SYNC			0x206c
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 81166a5bc034..4c2efec81995 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2112,13 +2112,11 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
 {
-	struct _packed {
-		struct hci_cp_le_big_create_sync cp;
-		__u8  bis[0x11];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
+	size_t pdu_size = __struct_size(pdu);
 	int err;
 
-	if (num_bis < 0x01 || num_bis > sizeof(pdu.bis))
+	if (num_bis < 0x01 || num_bis > pdu->num_bis)
 		return -EINVAL;
 
 	err = qos_set_big(hdev, qos);
@@ -2128,18 +2126,16 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 	if (hcon)
 		hcon->iso_qos.bcast.big = qos->bcast.big;
 
-	memset(&pdu, 0, sizeof(pdu));
-	pdu.cp.handle = qos->bcast.big;
-	pdu.cp.sync_handle = cpu_to_le16(sync_handle);
-	pdu.cp.encryption = qos->bcast.encryption;
-	memcpy(pdu.cp.bcode, qos->bcast.bcode, sizeof(pdu.cp.bcode));
-	pdu.cp.mse = qos->bcast.mse;
-	pdu.cp.timeout = cpu_to_le16(qos->bcast.timeout);
-	pdu.cp.num_bis = num_bis;
-	memcpy(pdu.bis, bis, num_bis);
-
-	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
-			    sizeof(pdu.cp) + num_bis, &pdu);
+	pdu->handle = qos->bcast.big;
+	pdu->sync_handle = cpu_to_le16(sync_handle);
+	pdu->encryption = qos->bcast.encryption;
+	memcpy(pdu->bcode, qos->bcast.bcode, sizeof(pdu->bcode));
+	pdu->mse = qos->bcast.mse;
+	pdu->timeout = cpu_to_le16(qos->bcast.timeout);
+	pdu->num_bis = num_bis;
+	memcpy(pdu->bis, bis, num_bis);
+
+	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC, pdu_size, pdu);
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
-- 
2.34.1


