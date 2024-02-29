Return-Path: <linux-kernel+bounces-87256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEEF86D1C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5620D1F265F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B45134411;
	Thu, 29 Feb 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4C7myv3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A8134404
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230392; cv=none; b=ccMNGs7AeVHEIAjjSilWrrKOZ45I+RIoIATSOP/P4wRrqr7YO7P82L3hIx3Ge4fOIPPEBXo3Ol1QsPrSOXD2jI7syTNUvmrTkpxF7gGP7FwEfmVxP2xFpODghogizyTwC8vXY4/TBTcTB8M1YvMdLQOkVcwBb2Y44F967YjxNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230392; c=relaxed/simple;
	bh=AE4Wax6AwWzhWNRdm2NepGfbrJaZkUojuHf7ZO1wUMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ja+u4ckN71BSvyFpylKB0bTP35b6HtUnPU49xc5D/rtV9iH8vUPQZGsk/drIxUhwuMeV6QieFGqwVT4reDy7xnQDoJ+1X+uid9/n84LQCtZOQeP6ilIjJdJR13GuQBa46vi+4FM2ib2pFC1+l4X010SUMjcWEK076zeu8YPrxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4C7myv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3F3C433F1;
	Thu, 29 Feb 2024 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230391;
	bh=AE4Wax6AwWzhWNRdm2NepGfbrJaZkUojuHf7ZO1wUMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4C7myv3oAagE1rI8WVPi5L1zholvwFbhRoaGGTQf6moCO+soeLoTeMCxMxiXr5L3
	 pkH0Qt92RgAAWtbD5svK8/SWbnV2NPi7cG/Y+6l2cXL/fEoWrenkoYSL9yIgY7+IX7
	 83wzlTnwTdBQoQYxPa/vATWIKBupgTmCdCfa2gE6eVjoiQufJN4ggKmwWKo3Yhk9bv
	 qo3WMUKq3lTT7H+mMiRhzGOm8cma2iVSblxT5/AqO1y3FNhyTAJRIvaGeZw59P1bt6
	 ea4xmkAoFsxiFPra7c8R70JJ7sD/P0xaoNOkkugooNlUryrub9tzVw6cwVWfe5u+E1
	 DaqxeLl8i5brQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] mei: txe: remove unnecessary NULL pointer checks
Date: Thu, 29 Feb 2024 12:12:59 -0600
Message-Id: <20240229181300.352077-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229181300.352077-1-helgaas@kernel.org>
References: <20240229181300.352077-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The .shutdown(), .remove(), and power management callbacks are never called
unless .probe() has already returned success, which means it has set
drvdata to a non-NULL pointer, so "dev" can never be NULL in the other
callbacks.

Remove the unnecessary checks.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/mei/pci-txe.c | 40 ++++++--------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index fa20d9a27813..2a584104ba38 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -166,11 +166,7 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  */
 static void mei_txe_shutdown(struct pci_dev *pdev)
 {
-	struct mei_device *dev;
-
-	dev = pci_get_drvdata(pdev);
-	if (!dev)
-		return;
+	struct mei_device *dev = pci_get_drvdata(pdev);
 
 	dev_dbg(&pdev->dev, "shutdown\n");
 	mei_stop(dev);
@@ -191,13 +187,7 @@ static void mei_txe_shutdown(struct pci_dev *pdev)
  */
 static void mei_txe_remove(struct pci_dev *pdev)
 {
-	struct mei_device *dev;
-
-	dev = pci_get_drvdata(pdev);
-	if (!dev) {
-		dev_err(&pdev->dev, "mei: dev == NULL\n");
-		return;
-	}
+	struct mei_device *dev = pci_get_drvdata(pdev);
 
 	pm_runtime_get_noresume(&pdev->dev);
 
@@ -218,9 +208,6 @@ static int mei_txe_pci_suspend(struct device *device)
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev = pci_get_drvdata(pdev);
 
-	if (!dev)
-		return -ENODEV;
-
 	dev_dbg(&pdev->dev, "suspend\n");
 
 	mei_stop(dev);
@@ -236,13 +223,9 @@ static int mei_txe_pci_suspend(struct device *device)
 static int mei_txe_pci_resume(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
-	struct mei_device *dev;
+	struct mei_device *dev = pci_get_drvdata(pdev);
 	int err;
 
-	dev = pci_get_drvdata(pdev);
-	if (!dev)
-		return -ENODEV;
-
 	pci_enable_msi(pdev);
 
 	mei_clear_interrupts(dev);
@@ -273,13 +256,10 @@ static int mei_txe_pci_resume(struct device *device)
 #ifdef CONFIG_PM
 static int mei_txe_pm_runtime_idle(struct device *device)
 {
-	struct mei_device *dev;
+	struct mei_device *dev = dev_get_drvdata(device);
 
 	dev_dbg(device, "rpm: txe: runtime_idle\n");
 
-	dev = dev_get_drvdata(device);
-	if (!dev)
-		return -ENODEV;
 	if (mei_write_is_idle(dev))
 		pm_runtime_autosuspend(device);
 
@@ -287,15 +267,11 @@ static int mei_txe_pm_runtime_idle(struct device *device)
 }
 static int mei_txe_pm_runtime_suspend(struct device *device)
 {
-	struct mei_device *dev;
+	struct mei_device *dev = dev_get_drvdata(device);
 	int ret;
 
 	dev_dbg(device, "rpm: txe: runtime suspend\n");
 
-	dev = dev_get_drvdata(device);
-	if (!dev)
-		return -ENODEV;
-
 	mutex_lock(&dev->device_lock);
 
 	if (mei_write_is_idle(dev))
@@ -317,15 +293,11 @@ static int mei_txe_pm_runtime_suspend(struct device *device)
 
 static int mei_txe_pm_runtime_resume(struct device *device)
 {
-	struct mei_device *dev;
+	struct mei_device *dev = dev_get_drvdata(device);
 	int ret;
 
 	dev_dbg(device, "rpm: txe: runtime resume\n");
 
-	dev = dev_get_drvdata(device);
-	if (!dev)
-		return -ENODEV;
-
 	mutex_lock(&dev->device_lock);
 
 	mei_enable_interrupts(dev);
-- 
2.34.1


