Return-Path: <linux-kernel+bounces-115925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C6889C21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9514BB45569
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1731B1482E6;
	Mon, 25 Mar 2024 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0YgY+d+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361A227E2A;
	Sun, 24 Mar 2024 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322125; cv=none; b=ShGnTsobs1bEOGjaOn21mdMOq6IbJR3hYpYoIlHodDMADUQY4lCEO0Ep0qKbefxsjhXh5DjOyprki+PwlSSyuSReX8mfhSG5CRNFKdyQd0tEZXs5yNUEr+AL3OpkEDyPFEOGpo4gabKMDnVYZEwB9H0J57H1i3KXoB7+IpT3xI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322125; c=relaxed/simple;
	bh=U+sFrNRrw4wWn2Jdt14OrsUlRPm2do+nq6KN26wtAwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLhgByz3PMAVNClqrM9AnWG+pTLajyhIBPthcwuw+Iq16YsEXphYYqJN+7ZXRi/T2hJ20girdJ7J+Esfn51x6f8c0vB/RXsWs6PPrdlDLbAvVoVqWb7cT1ADWbgf5i/kF+adKtd3dXb1dv5W+K0FS2EEMl+tbLeBtj1F0ut9Orc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0YgY+d+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7938BC433C7;
	Sun, 24 Mar 2024 23:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322124;
	bh=U+sFrNRrw4wWn2Jdt14OrsUlRPm2do+nq6KN26wtAwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0YgY+d+5r1Mr8OwWluXhaGpYaY+3Oogzwo9G5DnsEvjMta5BVZUq1RCxmQ2vLzqr
	 rOIuaVKxamHbSKBcInBpNbqiwNWTyfLbm5541TCicw7TuBFeyRZYrw9xRGliPafHqI
	 /ERBMB3OSoPf+Q2SZmpCjAa8VX7Xjx0w4lbo0SPaOMdJUXpyhG8TeBHpDWwALyTKb9
	 c7qNssd5kjv1o+cwEcgs899aYY+Z7p5qZ3VjvJD7aYb5nPNzk/3volVtUr4jNZyhCG
	 2wSaouKh7zDOdnHmIAUnUVvJAdp0n/gmoYC3ViuUuEJ/7DkP93iFM4LnoEUTxsSGsK
	 7ngJPO7oxRxig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 199/451] Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running
Date: Sun, 24 Mar 2024 19:07:55 -0400
Message-ID: <20240324231207.1351418-200-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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

[ Upstream commit d883a4669a1def6d121ccf5e64ad28260d1c9531 ]

This makes sure hci_cmd_sync_queue only queue new work if HCI_RUNNING
has been set otherwise there is a risk of commands being sent while
turning off.

Because hci_cmd_sync_queue can no longer queue work while HCI_RUNNING is
not set it cannot be used to power on adapters so instead
hci_cmd_sync_submit is introduced which bypass the HCI_RUNNING check, so
it behaves like the old implementation.

Link: https://lore.kernel.org/all/CAB4PzUpDMvdc8j2MdeSAy1KkAE-D3woprCwAdYWeOc-3v3c9Sw@mail.gmail.com/
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_sync.c         | 25 +++++++++++++++++++++++--
 net/bluetooth/mgmt.c             | 12 ++++++++----
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 17f5a4c32f36e..2fa976c466b80 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -41,6 +41,8 @@ void hci_cmd_sync_clear(struct hci_dev *hdev);
 void hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
 void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
 
+int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a337340464567..31dd064d77a42 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -680,8 +680,12 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 }
 EXPORT_SYMBOL(hci_cmd_sync_cancel);
 
-int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
-		       void *data, hci_cmd_sync_work_destroy_t destroy)
+/* Submit HCI command to be run in as cmd_sync_work:
+ *
+ * - hdev must _not_ be unregistered
+ */
+int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	struct hci_cmd_sync_work_entry *entry;
 	int err = 0;
@@ -711,6 +715,23 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 	mutex_unlock(&hdev->unregister_lock);
 	return err;
 }
+EXPORT_SYMBOL(hci_cmd_sync_submit);
+
+/* Queue HCI command:
+ *
+ * - hdev must be running
+ */
+int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+		       void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	/* Only queue command if hdev is running which means it had been opened
+	 * and is either on init phase or is already up.
+	 */
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	return hci_cmd_sync_submit(hdev, func, data, destroy);
+}
 EXPORT_SYMBOL(hci_cmd_sync_queue);
 
 int hci_update_eir_sync(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a657dc1d4ec7a..732b6cf45fbe4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1402,11 +1402,15 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	/* Cancel potentially blocking sync operation before power off */
-	if (cp->val == 0x00)
+	if (cp->val == 0x00) {
 		__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
-
-	err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
-				 mgmt_set_powered_complete);
+		err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
+					 mgmt_set_powered_complete);
+	} else {
+		/* Use hci_cmd_sync_submit since hdev might not be running */
+		err = hci_cmd_sync_submit(hdev, set_powered_sync, cmd,
+					  mgmt_set_powered_complete);
+	}
 
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
2.43.0


