Return-Path: <linux-kernel+bounces-113207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18202888250
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4D71C2275D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7877131BCD;
	Sun, 24 Mar 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSpdP+0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567B131BA5;
	Sun, 24 Mar 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320009; cv=none; b=qxqr6ZnHJL9NbdiUiP88AozMcSpwvCuxdnMfy7YwyJaF/heKQ08t8ooyXT87ZZFOoQ4AlIWhzX6Ykb0Kv6gPYmPDnPPRMccABGmv283ThgaL8KZ/JNe4OXv6jOJhn+PDBmycdaA/PxXijSNFSC6w6cl1oJKw+Ih/k+f8kwyIutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320009; c=relaxed/simple;
	bh=CgppWVbYSdfdH7pUfBvvux86ej8YyJiAHOmFHrzmnXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHIheQECA/OzV1hxTqFJ81QT51zXXXuDhVPEYbWXJC7jnWz7jrEOkKkV01nXSVw3A+0anMaIc6J5NMiBiTjxNJMurHWC3+WSwR3xOD9gaijpI/GCncXVZD8/qRfZlxFzROmY0ME+k9JUmgcwa7GLH7orClWhy7Us6wSq7IlC08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSpdP+0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E611C43399;
	Sun, 24 Mar 2024 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320008;
	bh=CgppWVbYSdfdH7pUfBvvux86ej8YyJiAHOmFHrzmnXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSpdP+0FgNnBsb84NNj+RV+ZAv5gway4REsNXF+EcXn7JVFEBNRavNMcZBIFsx4kE
	 DQhuVPutO+3KdpwKKg5DohE48UlPWNn56uO3RksBbUcmqkcCbUUUr2WITz1ln/wrR0
	 frg+nI5PkYRpNxyfL2LeX7lyJdSpF6PEAaVek2P58gKkuuGBUteir99o7zOw9JPwzh
	 GTsBGul+8qJ5T8DUuYduBhmDHzQ7F0yD9/ViQQmNJ+DQclRsP9lQNDHhGrseLnHFB+
	 wwan61Cwdf6gCSTOpQpNGqfcEzWx9wIlF1jVWo28ASqkPlZfQWG0iYLta5U/i0eZZT
	 yEGGH7qk+Gcyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 316/715] Bluetooth: fix use-after-free in accessing skb after sending it
Date: Sun, 24 Mar 2024 18:28:15 -0400
Message-ID: <20240324223455.1342824-317-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 947ec0d002dce8577b655793dcc6fc78d67b7cb6 ]

hci_send_cmd_sync first sends skb and then tries to clone it.  However,
the driver may have already freed the skb at that point.

Fix by cloning the sent_cmd cloned just above, instead of the original.

Log:
================================================================
BUG: KASAN: slab-use-after-free in __copy_skb_header+0x1a/0x240
..
Call Trace: ..
 __skb_clone+0x59/0x2c0
 hci_cmd_work+0x3b3/0x3d0 [bluetooth]
 process_one_work+0x459/0x900
..
Allocated by task 129: ...
 __alloc_skb+0x1ae/0x220
 __hci_cmd_sync_sk+0x44c/0x7a0 [bluetooth]
 __hci_cmd_sync_status+0x24/0xb0 [bluetooth]
 set_cig_params_sync+0x778/0x7d0 [bluetooth]
..
Freed by task 0: ...
 kmem_cache_free+0x157/0x3c0
 __usb_hcd_giveback_urb+0x11e/0x1e0
 usb_giveback_urb_bh+0x1ad/0x2a0
 tasklet_action_common.isra.0+0x259/0x4a0
 __do_softirq+0x15b/0x5a7
================================================================

Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 85a91c438d721..7d5334b529834 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4185,7 +4185,7 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 	if (hci_req_status_pend(hdev) &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		kfree_skb(hdev->req_skb);
-		hdev->req_skb = skb_clone(skb, GFP_KERNEL);
+		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
 
 	atomic_dec(&hdev->cmd_cnt);
-- 
2.43.0


