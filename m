Return-Path: <linux-kernel+bounces-113205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AAD88824A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F301F21D44
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9817D241;
	Sun, 24 Mar 2024 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi0wxxlm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7617D228;
	Sun, 24 Mar 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320007; cv=none; b=powViEbk3gCVdEnWPcOrm+vHAQr6dICWUQ0zDKqGyNBWHt4B1Lfiv4fzvmznSHDclRQ/vaXLsxmuUjAj3w1/4VwfoEukHPgcu+d+r7KG+X0GHthkTDADP1TeK/2+aVFXRhpzZRhHN077RLLqjAwCyqR0z2ji8RoB22xJuJMcNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320007; c=relaxed/simple;
	bh=DJS3TGp3Td4MV9ZRjIwo5xMPi1BQTcb3/FYgdCrfEqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE2T0aPT+g6VhJZ5yeT0ce9vwbAM3JwCKDDRidggr2q5l4Lf+j4fsV9hECHjmTMMZGJSNsPQF+WEuy2AmPeLStYvp/gwlPR2sVv2u42I1pFpt4JamYQF81HId0GvTmE/AtEhbaioRpmq+5JeaSfwgK/YWxNLdB6WbRnxy/KvoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi0wxxlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E9CC433F1;
	Sun, 24 Mar 2024 22:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320007;
	bh=DJS3TGp3Td4MV9ZRjIwo5xMPi1BQTcb3/FYgdCrfEqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bi0wxxlmbGD36mkdAwNw1jBoDGOeoGcC6n5ki994OZOOzY8ogBCSYqb1EFypREDxH
	 hPqjXYSnKmmlwnoJgZ1bipySV/41oN5D1FSsd00xFA1nNiZ2AtMpccjIYzsaLlllGg
	 BQKPdkEohIjGoTgrS2ty3OwoIqX3+wmRVC5yhUux+ocAnqnEonLSbU2FC08KFVXUq4
	 5lgL0CCJC6Sxkkfg7yTZZsXsBH6OTI5StFkFTL7+whlA4OObrfE0NgbmjbUnHf1HFa
	 RAkinz3+MSVaax2I4/gHZyo6yAQbKGjGPrz6RWA94Dj3MGAXa6hbZzTmKw/WLOH5f4
	 PQDyPbIvbvtpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 314/715] Bluetooth: btusb: Fix memory leak
Date: Sun, 24 Mar 2024 18:28:13 -0400
Message-ID: <20240324223455.1342824-315-sashal@kernel.org>
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
index d31edad7a0560..6cb87d47ad7d5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3273,7 +3273,6 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
-	struct sk_buff *skb_cd;
 
 	switch (handle) {
 	case 0xfc6f:		/* Firmware dump from device */
@@ -3286,9 +3285,12 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
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


