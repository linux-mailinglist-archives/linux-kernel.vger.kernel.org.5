Return-Path: <linux-kernel+bounces-113201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4067888242
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215BD1C2267C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFECA17BB3F;
	Sun, 24 Mar 2024 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU+70fyM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095A617BB21;
	Sun, 24 Mar 2024 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320004; cv=none; b=PFcj9sGeUDEMERO0u3B6TPY6+vJghX0yAAR6c8BDaCc872+h59wz+Krgj1mzaXn/DWoO6FxYwrtxtz1UddZt50WenyEewAR05c9MPfsL2QGxYbi3G3WKqx9qkWXjjOioOctIwhDYtq8kdW+4/5H4+fQ6TH+zAdJZmpLc2n+QQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320004; c=relaxed/simple;
	bh=PUibFJzq8s1O50wIgMpnQ+UAHV1ejtQduBLCizncLr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf+9ZSKZlpAboC/wtHg0XxNJxPYrTNJCLanif/wOx6eebhGwLKNxra1UgXaiEzADFr68TcKHI4/Y1X5+qgwA4FX/aiKH879hdnmUl1BaeJERNHO/JW7MGzjkpIw1jidza9ANEoiN+8vZx9F4rr1kDFV5eXbZyMvKKuweQuYZO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU+70fyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4661DC433C7;
	Sun, 24 Mar 2024 22:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320003;
	bh=PUibFJzq8s1O50wIgMpnQ+UAHV1ejtQduBLCizncLr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bU+70fyMb7FJmPaXE6GMZv4dZGZmOGadIqtaFYll6EoaynJSePQbOJJYgblOOVJin
	 YCN6i57W8SXJh9oBjQeEIwxZN58xBqwIh6y/oWaS30/YVLMBPo+JGQWfhd6oSs+Qkn
	 kEYU7gFQCY0+j2pOUevssARahnDyxeRWkyd1Ysup7a3hHPCTH+rFdtKPAXwLC+TPbU
	 AsKYzMIa+lo4AHrJPUc3xNs89KsVsdKwnMRRPFJ9XHu4y/Idocbcymbp37cSIoNntY
	 /jLCJ+wwiSZyNd3lz9Q+meSd1uvnt6idsGbWBY2rw7qGcupOFsbpscB8bXTfvwXyKZ
	 /UEOYMEwcubBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 310/715] Bluetooth: hci_h5: Add ability to allocate memory for private data
Date: Sun, 24 Mar 2024 18:28:09 -0400
Message-ID: <20240324223455.1342824-311-sashal@kernel.org>
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
index 39c8b567da3c0..214fff876eae5 100644
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


