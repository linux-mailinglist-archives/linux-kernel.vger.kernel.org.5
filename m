Return-Path: <linux-kernel+bounces-113780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C1D888693
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5E028EBFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053073A8D0;
	Sun, 24 Mar 2024 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU5fKoHm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983E1E3050;
	Sun, 24 Mar 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320791; cv=none; b=sAWJI1PBRv8avY430me4j8vnB9o210oce0N0DQX1eYOXsgNTWH/AN1nCLaDz409IaRO63yOrC18RuW14Loo/72NI7LPCdGA9vyqb3MoOWJPTt1EfTGJmLRXCCDnvI6157/v1Yl3GIvdp5Gy2bMa3UzBpywbgUvjKwrCZYauSXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320791; c=relaxed/simple;
	bh=Fj+Ywu3FPVpOr87/iZCyRE6IHhbeeRmWmiO+uTLZzo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iaytqew925I96bAb9l6xXUQ+ECcQ+NfwdtJUeDm7FNLCO2Sf8n0P0tRHQ4sahoBaKBeTBEYW3otWZ7z4haYGN2YJqJ3nRdytjDtQp5/6kEKAstRpPxs2AA6t5tQS3yQqiFVqM7OyOYnB/NqtnhTausFlndFbzfa92bZIdsUGBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU5fKoHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D354C433F1;
	Sun, 24 Mar 2024 22:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320791;
	bh=Fj+Ywu3FPVpOr87/iZCyRE6IHhbeeRmWmiO+uTLZzo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OU5fKoHm4W1EWBz6nOJ8/PlDySUgsEEe2SpXyLYmsBgXNLwMv32ZNG6P5pFxGGWv8
	 4uFiozpTJcuwBcsU0/Xuxmb9S9staNXdBVRTzx1XaCrSXEIPXTdbDcve3OM+fBb2oL
	 wV3H5eDE4lJtWtuy7cZUxdAV56f8mPq/ORlppfWFwGmJtjdL7d7UsuOqfulJhdktlP
	 QGsryg8xv1uZT7L9o+1iiCrg9Yp6Q/d1oENcuk1BntdHNDTItEx2hQsAnf8x+yrfAW
	 zD5gT5HZiApCxkz0H56lwim4MeQ0bNJj1VP1I5dRtrBtrhhwBSITmMFf8wYXRRlPGU
	 PQgJqDFwq6jzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 355/713] Bluetooth: btusb: Fix memory leak
Date: Sun, 24 Mar 2024 18:41:21 -0400
Message-ID: <20240324224720.1345309-356-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index b8e9de887b5de..81ccb88c904a3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3271,7 +3271,6 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
-	struct sk_buff *skb_cd;
 
 	switch (handle) {
 	case 0xfc6f:		/* Firmware dump from device */
@@ -3284,9 +3283,12 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
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


