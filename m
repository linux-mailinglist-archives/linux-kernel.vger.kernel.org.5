Return-Path: <linux-kernel+bounces-114232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC088894C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7219128715A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694616A987;
	Sun, 24 Mar 2024 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+u9Dgns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D3209E24;
	Sun, 24 Mar 2024 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321581; cv=none; b=MOLCNd/Nh3xLrkMGrdnr27Mr5Vhl+hSGTL8jSOzIe4Y6ivevnXX7cDKVNIbJhEK77cvnLw27IpjKmYZsUX1KKlxrLXti7BOltCgFhReocASBNakK6wZG9892gS1apmcQDNesC6SoVF4qD/Ip466Yn6s3rF5nKhS/fNS444PyK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321581; c=relaxed/simple;
	bh=937m8QQtPhg4Yw4d9wkhLHxuM3X2FKfxaRJBMMb9aLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeTIaTI0sJdgq4+ZYD6nAH1JEcksIUChrMQuioIarjwENptvg8hbWlraVMiN3lj41WFybk7ZkWieu92PgcCeks4weGB0s2ZeZa2JWHZN8Fs4iv1CusPxCamB3Vr1Kr9+2G4WQslKs+tDrSLbxp1PA+8V1eSOQoif5dZ4DBpzJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+u9Dgns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF01C43394;
	Sun, 24 Mar 2024 23:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321580;
	bh=937m8QQtPhg4Yw4d9wkhLHxuM3X2FKfxaRJBMMb9aLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+u9DgnsptR5rZiNTZtAzNpBWekvafb5PCCN7esw2yj0d+6n3PvlZZJNcVcJw3+kL
	 lEbL+ho/z6Z5ZLix4n2GqcpiSfqsu3z8okapwRCs5KnjiUSXTiZm7sjD3WJ8qf3xjK
	 8YmelLNHQ2zRUq6VKIgN5iJPMqrQbAt+7Wxslp3zjNUrXyQ+/9siI5wTnjRSE3xA0L
	 I5xIH3gf8YDnh6YahbtvXbn4amiNCmahd79pNACJrbM+uqTTu9YlL1kK9hUhSQBtPO
	 zVqGTrhH8hPfzDc9559t8iMl7geAqXLXfg+2DdMDZeK+iw1pqmThpWGMB1hBHgJOVe
	 5vrh2uAuquGHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 309/638] Bluetooth: msft: __hci_cmd_sync() doesn't return NULL
Date: Sun, 24 Mar 2024 18:55:46 -0400
Message-ID: <20240324230116.1348576-310-sashal@kernel.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 41c56aa94c647a0f84c5c33fffb3f283e6f0e5bf ]

The __hci_cmd_sync() function doesn't return NULL.  Checking for NULL
doesn't make the code safer, it just confuses people.

When a function returns both error pointers and NULL then generally the
NULL is a kind of success case.  For example, maybe we look up an item
then errors mean we ran out of memory but NULL means the item is not
found.  Or if we request a feature, then error pointers mean that there
was an error but NULL means that the feature has been deliberately
turned off.

In this code it's different.  The NULL is handled as if there is a bug
in __hci_cmd_sync() where it accidentally returns NULL instead of a
proper error code.  This was done consistently until commit 9e14606d8f38
("Bluetooth: msft: Extended monitor tracking by address filter") which
deleted the work around for the potential future bug and treated NULL as
success.

Predicting potential future bugs is complicated, but we should just fix
them instead of working around them.  Instead of debating whether NULL
is failure or success, let's just say it's currently impossible and
delete the dead code.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: a6e06258f4c3 ("Bluetooth: msft: Fix memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/msft.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index abbafa6194ca1..630e3023273b2 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -150,10 +150,7 @@ static bool read_supported_features(struct hci_dev *hdev,
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR_OR_NULL(skb)) {
-		if (!skb)
-			skb = ERR_PTR(-EIO);
-
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to read MSFT supported features (%ld)",
 			   PTR_ERR(skb));
 		return false;
@@ -353,7 +350,7 @@ static void msft_remove_addr_filters_sync(struct hci_dev *hdev, u8 handle)
 
 		skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 				     HCI_CMD_TIMEOUT);
-		if (IS_ERR_OR_NULL(skb)) {
+		if (IS_ERR(skb)) {
 			kfree(address_filter);
 			continue;
 		}
@@ -442,11 +439,8 @@ static int msft_remove_monitor_sync(struct hci_dev *hdev,
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR_OR_NULL(skb)) {
-		if (!skb)
-			return -EIO;
+	if (IS_ERR(skb))
 		return PTR_ERR(skb);
-	}
 
 	return msft_le_cancel_monitor_advertisement_cb(hdev, hdev->msft_opcode,
 						       monitor, skb);
@@ -559,7 +553,7 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, total_size, cp,
 			     HCI_CMD_TIMEOUT);
 
-	if (IS_ERR_OR_NULL(skb)) {
+	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		goto out_free;
 	}
@@ -740,10 +734,10 @@ static int msft_cancel_address_filter_sync(struct hci_dev *hdev, void *data)
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR_OR_NULL(skb)) {
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "MSFT: Failed to cancel address (%pMR) filter",
 			   &address_filter->bdaddr);
-		err = -EIO;
+		err = PTR_ERR(skb);
 		goto done;
 	}
 	kfree_skb(skb);
@@ -893,7 +887,7 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, size, cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR_OR_NULL(skb)) {
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to enable address %pMR filter",
 			   &address_filter->bdaddr);
 		skb = NULL;
-- 
2.43.0


