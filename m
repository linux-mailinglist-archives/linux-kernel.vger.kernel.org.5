Return-Path: <linux-kernel+bounces-160395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA978B3D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7BC1F23F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B7158D92;
	Fri, 26 Apr 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT0QMFye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0C2B9AF;
	Fri, 26 Apr 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149921; cv=none; b=C4k2j9xUPAOr4NhhyCaQA+HfyPp8GM8sS3KaR9LLV7TXs5FshKMNm2+VDB1Iu+PTA6fSIhnXf87dlt/jmYB3kcKG5ibow1pyoJRcHdTojwSHJ1RTp872Ly+XatD2jsoa99uWiS9ENEcr8qZMSsrvtCBsrwPsx6raCl2Onqylhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149921; c=relaxed/simple;
	bh=gPXudTVXPzAYk/IBuGVv5BUulrSGwKA4k/IvdqMV+jI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XcIns9jGwnwj++uSlzgq1tb3Cb7ZreTylcm/7c3a395M8KJOpOAdzNEhxUl4LIyOXBMwik5xsafh/pJvQ+DzHHhmfMJDmLe+x1FPZTvPPFrxaE0BJlRwYkt4XY5TvfZ5TfzZDY5piUsh5HO2vFotsTKuy7hvknUbqlJAvp/bMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT0QMFye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D726AC113CD;
	Fri, 26 Apr 2024 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714149921;
	bh=gPXudTVXPzAYk/IBuGVv5BUulrSGwKA4k/IvdqMV+jI=;
	h=Date:From:To:Cc:Subject:From;
	b=FT0QMFyeSVc2Lx2CmRk7crSVNfJaB0pkKTvk5aoG+2MGabFQBQ5HqlIp6LG8pX/pV
	 NmgQiygFd+jDSleYF6/O1OL+bfbUBxu3DsNubI1LEN5RaN/5u/KtTxMhosLM/VzxJP
	 nxsk+KBjNop6Zenc6VqkwdEeZ3Wt8C80RH1l/ycne0OHmUMxy74B0MEJwzxPKMTfhk
	 bdfZvWNdzoseDHsOAtrYU6v2VFZLTXV4ag9Z+Xgtol26uVtpTUI5IteVk5z3uhntaj
	 7s6C4QJ8HedVi03aEmUPc9oNTUGeGx8OU1HnsionPFDfnJKqPiUF5bdRCje2+yfm77
	 KtuxRii81zOtQ==
Date: Fri, 26 Apr 2024 10:45:17 -0600
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
Subject: [PATCH v2][next] Bluetooth: hci_conn: Use __counted_by() in struct
 hci_cp_le_big_create_sync and avoid -Wfamnae warning
Message-ID: <ZivaHUQyDDK9fXEk@neat>
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
Changes in v2:
 - Use `sizeof(*pdu) + num_bis` instead of `__struct_size(pdu)`

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZivYcpzZsc7aIFZ5@neat/

 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_conn.c    | 26 +++++++++++---------------
 2 files changed, 12 insertions(+), 16 deletions(-)

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
index 81166a5bc034..d6daf55f0307 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2112,13 +2112,10 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
 {
-	struct _packed {
-		struct hci_cp_le_big_create_sync cp;
-		__u8  bis[0x11];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
 	int err;
 
-	if (num_bis < 0x01 || num_bis > sizeof(pdu.bis))
+	if (num_bis < 0x01 || num_bis > pdu->num_bis)
 		return -EINVAL;
 
 	err = qos_set_big(hdev, qos);
@@ -2128,18 +2125,17 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
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
+	pdu->handle = qos->bcast.big;
+	pdu->sync_handle = cpu_to_le16(sync_handle);
+	pdu->encryption = qos->bcast.encryption;
+	memcpy(pdu->bcode, qos->bcast.bcode, sizeof(pdu->bcode));
+	pdu->mse = qos->bcast.mse;
+	pdu->timeout = cpu_to_le16(qos->bcast.timeout);
+	pdu->num_bis = num_bis;
+	memcpy(pdu->bis, bis, num_bis);
 
 	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
-			    sizeof(pdu.cp) + num_bis, &pdu);
+			    sizeof(*pdu) + num_bis, pdu);
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
-- 
2.34.1


