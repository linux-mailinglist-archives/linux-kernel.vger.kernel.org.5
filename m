Return-Path: <linux-kernel+bounces-87257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950DF86D1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E3C1C22B44
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436D13442B;
	Thu, 29 Feb 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLx6jYEv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEA012FB0B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230393; cv=none; b=KfFmdRC3j0PTbus6eUMtRCe25k0pjrigG/lWBaTqLRI/P/qm+2U36ZJbUcM6ZpcygDeNWrwiPbivjiSYt4FbuemVrFVPuLsc93xalK4AFTijuln0Ft9XYl3CqI8RbQ0I4iKp+eAXTZ3XbHwBRUO01YWqaSexgPtPTwhN7hLtZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230393; c=relaxed/simple;
	bh=Dkk4i1JgX0DpGT8BHQSypGGCaf+0/nlf7ejjaAd9LM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QD7yXmPoPhCKB95ZXsgs90l2ipmUwBO5+snBQJwdAXSuD0+L+ETpkHvTx4mviCa7xoKFCW9+e+7ODsGgO10TYNwoYXPASQjUHoOuDXe/D03j7qVNzdRNWpT3X4aljSKhNn0N08TBmRyU567MrwMfUC2xZcIskBo2FJ3mEDoh6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLx6jYEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029D1C43394;
	Thu, 29 Feb 2024 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230393;
	bh=Dkk4i1JgX0DpGT8BHQSypGGCaf+0/nlf7ejjaAd9LM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLx6jYEvLDIJSohi1mL2aFZMKS5uU2mNnrYEkCq/W8DJMzoI873tRTsRnzQXMG/YZ
	 ugENU1BojjNHkG/un/SXNZeBmRkekNS07BaH9oiDHC8I2qt0lwI8KBTU6GsV836uaa
	 O2J4PuhTqxUhaXsAVet9f2U9C5Qx+g7bgUf8N1+T6SH6+uRKzrseoSzqHlH8iCIyp6
	 he4iqhdzEgw8bBMYYIFF2GwS96VMrGG84NZkGB0H9h31H1yf2k/8cixzNYuW5B1q9l
	 wEDDIYOLYhQro3EATwlFPEqfL++F2HmHWS/n1SGvTHO45Z9PXevSNPQYIkzzW/zaAy
	 fBCzDkJtrlcJQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] mei: me: remove unnecessary NULL pointer checks
Date: Thu, 29 Feb 2024 12:13:00 -0600
Message-Id: <20240229181300.352077-4-helgaas@kernel.org>
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
 drivers/misc/mei/pci-me.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 676d566f38dd..1f0d983d3f06 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -295,11 +295,7 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  */
 static void mei_me_shutdown(struct pci_dev *pdev)
 {
-	struct mei_device *dev;
-
-	dev = pci_get_drvdata(pdev);
-	if (!dev)
-		return;
+	struct mei_device *dev = pci_get_drvdata(pdev);
 
 	dev_dbg(&pdev->dev, "shutdown\n");
 	mei_stop(dev);
@@ -320,11 +316,7 @@ static void mei_me_shutdown(struct pci_dev *pdev)
  */
 static void mei_me_remove(struct pci_dev *pdev)
 {
-	struct mei_device *dev;
-
-	dev = pci_get_drvdata(pdev);
-	if (!dev)
-		return;
+	struct mei_device *dev = pci_get_drvdata(pdev);
 
 	if (mei_pg_is_enabled(dev))
 		pm_runtime_get_noresume(&pdev->dev);
@@ -353,9 +345,6 @@ static int mei_me_pci_suspend(struct device *device)
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev = pci_get_drvdata(pdev);
 
-	if (!dev)
-		return -ENODEV;
-
 	dev_dbg(&pdev->dev, "suspend\n");
 
 	mei_stop(dev);
@@ -371,14 +360,10 @@ static int mei_me_pci_suspend(struct device *device)
 static int mei_me_pci_resume(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
-	struct mei_device *dev;
+	struct mei_device *dev = pci_get_drvdata(pdev);
 	unsigned int irqflags;
 	int err;
 
-	dev = pci_get_drvdata(pdev);
-	if (!dev)
-		return -ENODEV;
-
 	pci_enable_msi(pdev);
 
 	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT : IRQF_SHARED;
@@ -419,13 +404,10 @@ static void mei_me_pci_complete(struct device *device)
 #ifdef CONFIG_PM
 static int mei_me_pm_runtime_idle(struct device *device)
 {
-	struct mei_device *dev;
+	struct mei_device *dev = dev_get_drvdata(device);
 
 	dev_dbg(device, "rpm: me: runtime_idle\n");
 
-	dev = dev_get_drvdata(device);
-	if (!dev)
-		return -ENODEV;
 	if (mei_write_is_idle(dev))
 		pm_runtime_autosuspend(device);
 
@@ -434,15 +416,11 @@ static int mei_me_pm_runtime_idle(struct device *device)
 
 static int mei_me_pm_runtime_suspend(struct device *device)
 {
-	struct mei_device *dev;
+	struct mei_device *dev = dev_get_drvdata(device);
 	int ret;
 
 	dev_dbg(device, "rpm: me: runtime suspend\n");
 
-	dev = dev_get_drvdata(device);
-	if (!dev)
-		return -ENODEV;
-
 	mutex_lock(&dev->device_lock);
 
 	if (mei_write_is_idle(dev))
@@ -462,15 +440,11 @@ static int mei_me_pm_runtime_suspend(struct device *device)
 
 static int mei_me_pm_runtime_resume(struct device *device)
 {
-	struct mei_device *dev;
+	struct mei_device *dev = dev_get_drvdata(device);
 	int ret;
 
 	dev_dbg(device, "rpm: me: runtime resume\n");
 
-	dev = dev_get_drvdata(device);
-	if (!dev)
-		return -ENODEV;
-
 	mutex_lock(&dev->device_lock);
 
 	ret = mei_me_pg_exit_sync(dev);
-- 
2.34.1


