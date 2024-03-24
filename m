Return-Path: <linux-kernel+bounces-114230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E3888947
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2521C278CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D5E25408B;
	Sun, 24 Mar 2024 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UV/7wu/z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E69209E16;
	Sun, 24 Mar 2024 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321578; cv=none; b=p4moThybw4xE+IqSAF/HWvPdcZN2oGutrOzH/YlNVvTmee48rRTIJCN825snbbOYRNaG8i9MfTVcnpoBIPa1Euu9dc8OwRZzG9LoA52iV9v1Ki7mGZJjnfWNr5l+55fD0FCPitZ6Dd6+Aqknql688C3rYIptVKr6zSd/OHk1p3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321578; c=relaxed/simple;
	bh=ArHPtWX3+1gtQ68zc8c0UMu038IRAJ3nC1hv6nvkR10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mww0lnrZ/Gscrbe/2e0nDmqTIHl0rutAF4O7hPfQd2+sg4xnIOdoTEWzBwl2ioUalALEkFBsrKBl95y41VXsEg6434imY1V6Atwp2EhWO0FIsSJxaWPkySJrACt1sW5cJwT9fnHPwZBEltNIpmoGoBUHppYVFTy1KVWK17Nwa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UV/7wu/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BAAC43399;
	Sun, 24 Mar 2024 23:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321577;
	bh=ArHPtWX3+1gtQ68zc8c0UMu038IRAJ3nC1hv6nvkR10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UV/7wu/zHPh5gPefd/HqjdyhhA2pscEAl3bztZAvX5IKrQs+KC3k1LXZm7LlYfO8A
	 SVD4jchCWyDvHBHt9tdpKp0RmX6pzYSQifTvCdEceyqNF0tkpXIKN0GVaMobr/T/Nz
	 fyOOKpJ/nR+P8z4mSbUbpagtO0ij7AZfrdy6wkEFKTxaEIcWacHsm6SUX1uiZKyks3
	 yTSBShS4FkfZ6xIhtk/qxkXKtTWOh6kkbj7P1MnA0eSSfZDVzFV0l71uKPFEXjoun/
	 coUy3ppsP3TLO6z1udt7PTt/tqTlpxXUMo6UqOfz/2Db9HKNXqLZtKiPwZz2tG5iRF
	 Ma9L8YIxFxOcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 306/638] Bluetooth: hci_h5: Add ability to allocate memory for private data
Date: Sun, 24 Mar 2024 18:55:43 -0400
Message-ID: <20240324230116.1348576-307-sashal@kernel.org>
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

From: Andrey Skvortsov <andrej.skvortzov@gmail.com>

[ Upstream commit 7a6d793e9ca8bc0c1d2f0aa0a02ec380d1124c74 ]

In some cases uart-base drivers may need to use priv data. For
example, to store information needed for devcoredump.

Fixes: 044014ce85a1 ("Bluetooth: btrtl: Add Realtek devcoredump support")
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_h5.c     |  4 +++-
 drivers/bluetooth/hci_serdev.c |  9 +++++----
 drivers/bluetooth/hci_uart.h   | 12 +++++++++++-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 71e748a9477e4..b66136348bd64 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -113,6 +113,7 @@ struct h5_vnd {
 	int (*suspend)(struct h5 *h5);
 	int (*resume)(struct h5 *h5);
 	const struct acpi_gpio_mapping *acpi_gpio_map;
+	int sizeof_priv;
 };
 
 struct h5_device_data {
@@ -863,7 +864,8 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (IS_ERR(h5->device_wake_gpio))
 		return PTR_ERR(h5->device_wake_gpio);
 
-	return hci_uart_register_device(&h5->serdev_hu, &h5p);
+	return hci_uart_register_device_priv(&h5->serdev_hu, &h5p,
+					     h5->vnd->sizeof_priv);
 }
 
 static void h5_serdev_remove(struct serdev_device *serdev)
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index f16fd79bc02b8..611a11fbb2f3a 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -300,8 +300,9 @@ static const struct serdev_device_ops hci_serdev_client_ops = {
 	.write_wakeup = hci_uart_write_wakeup,
 };
 
-int hci_uart_register_device(struct hci_uart *hu,
-			     const struct hci_uart_proto *p)
+int hci_uart_register_device_priv(struct hci_uart *hu,
+			     const struct hci_uart_proto *p,
+			     int sizeof_priv)
 {
 	int err;
 	struct hci_dev *hdev;
@@ -325,7 +326,7 @@ int hci_uart_register_device(struct hci_uart *hu,
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
 	/* Initialize and register HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev_priv(sizeof_priv);
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
 		err = -ENOMEM;
@@ -394,7 +395,7 @@ int hci_uart_register_device(struct hci_uart *hu,
 	percpu_free_rwsem(&hu->proto_lock);
 	return err;
 }
-EXPORT_SYMBOL_GPL(hci_uart_register_device);
+EXPORT_SYMBOL_GPL(hci_uart_register_device_priv);
 
 void hci_uart_unregister_device(struct hci_uart *hu)
 {
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index fb4a2d0d8cc80..68c8c7e95d64d 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -97,7 +97,17 @@ struct hci_uart {
 
 int hci_uart_register_proto(const struct hci_uart_proto *p);
 int hci_uart_unregister_proto(const struct hci_uart_proto *p);
-int hci_uart_register_device(struct hci_uart *hu, const struct hci_uart_proto *p);
+
+int hci_uart_register_device_priv(struct hci_uart *hu,
+				  const struct hci_uart_proto *p,
+				  int sizeof_priv);
+
+static inline int hci_uart_register_device(struct hci_uart *hu,
+					   const struct hci_uart_proto *p)
+{
+	return hci_uart_register_device_priv(hu, p, 0);
+}
+
 void hci_uart_unregister_device(struct hci_uart *hu);
 
 int hci_uart_tx_wakeup(struct hci_uart *hu);
-- 
2.43.0


