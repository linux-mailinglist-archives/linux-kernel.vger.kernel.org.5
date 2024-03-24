Return-Path: <linux-kernel+bounces-114234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC79888F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536001F22C14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152216A9AE;
	Sun, 24 Mar 2024 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci65BtE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2B209E2F;
	Sun, 24 Mar 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321583; cv=none; b=es0ivuAeQVymnKKvT7te0wCvfHLbDFmCt3ZSmkkUtxFgea/fjIMG0lMllELYxmGr/tb2Av/w4KOtg4n74DQPOb9o5Nwu7v7CgJn6YJTkh5gzfpSTYdjoRluN4BCHcQpaDmInQg4ewwk43NSBeZ0kJT4IQk1rTGLtTI1nMKlr5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321583; c=relaxed/simple;
	bh=epv7NMyYMjfOOD6a1efAZbOUcwhy5jbD9SVjVk810xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uS2VPgaE5p+nt++/3kCIqeOzBZI5Xa+AkhCfF3FH9wOe2b308mAKCz47/2V270AmiiFtbGUCWjhn6yH+pAmzaFh+nhGrbX6G+5MmzTDH+TOqibDVylj/bSPfACXkr1ErnyG6LCyQ3BNrQcjlf+INDcJ3KkyjWZ7SmsD3ZYLfUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci65BtE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5158FC433B1;
	Sun, 24 Mar 2024 23:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321581;
	bh=epv7NMyYMjfOOD6a1efAZbOUcwhy5jbD9SVjVk810xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ci65BtE5gKt+yz2y0Wu/zbK9JH/jwzSCYtHTxCWloOb4Zqqjh2r4U1xN2iL9jutjb
	 HchrEDBdJ35GVZSas7KkL9jlI5ZgQP6AuvUTY/aFOrKo8LVChXAQMr0iFVoQfLjwG9
	 PsibfrgfJvicPvpkjEtXbLQ5T1EE5464rCbGyawBqEEjvBsx8ZoZc/OZEt1Mof5mCY
	 fmXlv3Ko71d6I5b6xaQ8/kUiAgKwt/7hYyrZ8RD6i3rQe+a7KvQaSJyuaIbpkwjrIt
	 qKcZCQBfcNXIIUxLaT70Op1Doi1PSwinF2A8ihsAi3X9duOWbDt67ThaC0q+TudVCt
	 McocWOwaquCxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 311/638] Bluetooth: btusb: Fix memory leak
Date: Sun, 24 Mar 2024 18:55:48 -0400
Message-ID: <20240324230116.1348576-312-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit 79f4127a502c5905f04da1f20a7bbe07103fb77c ]

This checks if CONFIG_DEV_COREDUMP is enabled before attempting to clone
the skb and also make sure btmtk_process_coredump frees the skb passed
following the same logic.

Fixes: 0b7015132878 ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmtk.c |  4 +++-
 drivers/bluetooth/btusb.c | 10 ++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index aaabb732082cd..285418dbb43f5 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -372,8 +372,10 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 	struct btmediatek_data *data = hci_get_priv(hdev);
 	int err;
 
-	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP)) {
+		kfree_skb(skb);
 		return 0;
+	}
 
 	switch (data->cd_info.state) {
 	case HCI_DEVCOREDUMP_IDLE:
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 66080fae072f2..8dbdc51976e7b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3267,7 +3267,6 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
-	struct sk_buff *skb_cd;
 
 	switch (handle) {
 	case 0xfc6f:		/* Firmware dump from device */
@@ -3280,9 +3279,12 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 		 * for backward compatibility, so we have to clone the packet
 		 * extraly for the in-kernel coredump support.
 		 */
-		skb_cd = skb_clone(skb, GFP_ATOMIC);
-		if (skb_cd)
-			btmtk_process_coredump(hdev, skb_cd);
+		if (IS_ENABLED(CONFIG_DEV_COREDUMP)) {
+			struct sk_buff *skb_cd = skb_clone(skb, GFP_ATOMIC);
+
+			if (skb_cd)
+				btmtk_process_coredump(hdev, skb_cd);
+		}
 
 		fallthrough;
 	case 0x05ff:		/* Firmware debug logging 1 */
-- 
2.43.0


