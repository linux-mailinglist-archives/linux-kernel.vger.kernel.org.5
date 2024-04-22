Return-Path: <linux-kernel+bounces-153885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D208AD475
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F7283F98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC8F15534A;
	Mon, 22 Apr 2024 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sC/0mPu8"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1315530D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812297; cv=none; b=Bukpf8hWjPI6BNLIUjQ5UxB27b0a2n7HEwCEGzznsyP3ujQ1dE+rSr8mIqZRM+0yFFrplpGvIKw5Z5YP9UEJnau7u/iJYX5ivHBS0ZQT/cOqAvuJDrEZ+RmIL67A/3donab7DV7PElCnyjnA2i+h067iYabz3qNV3oohCYx2Y+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812297; c=relaxed/simple;
	bh=ucYZ+loFeMa2/Su14r82tDEgNbJTHjFpdGT6zZIFWKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxGzns2mFHtmxpzm7f5zBCvRgsRNrt4uPZteKfmvhA+wu6FrcJtAyjuUZ0EESneFYMgzsCTCVrBsvMWaoRxPq/+fE6VtUhJiKUpBLeV7w/iHHgHF0uKSe5RQPYSjQLWMOwbl3Y753GoAoccPTXW/xNkTWQBFxOqlpoOFUcl281Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sC/0mPu8; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713812293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QieHunxza7oONNqDvj8FAilmUbNuLii0kfErB3NoZW4=;
	b=sC/0mPu8+v9KnEygO9w7oUbzkZXNLGmM3vEaXpON0arLdxLJlMX8Xoi+PrJOVQxDNhAkti
	ITyBwp5vF1T2bA1wh1hr6vDoPFmAq7VB7RBxNk2tullNtGozKvjtrU3Kq3P6Viiqzvhcuf
	6WTCn+k2NPi82cVAvvnYWx0FdtbdsYk=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/3] phy: zynqmp: Add debugfs support
Date: Mon, 22 Apr 2024 14:58:03 -0400
Message-Id: <20240422185803.3575319-4-sean.anderson@linux.dev>
In-Reply-To: <20240422185803.3575319-1-sean.anderson@linux.dev>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for printing some basic status information to debugfs. This
is helpful when debugging phy consumers to make sure they are configuring
the phy appropriately.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/phy/xilinx/phy-zynqmp.c | 54 +++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 08c88dcd7799..e2e86943e9f3 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -122,6 +123,15 @@
 #define ICM_PROTOCOL_DP			0x4
 #define ICM_PROTOCOL_SGMII		0x5
 
+static const char *const xpsgtr_icm_str[] = {
+	[ICM_PROTOCOL_PD] = "powered down",
+	[ICM_PROTOCOL_PCIE] = "PCIe",
+	[ICM_PROTOCOL_SATA] = "SATA",
+	[ICM_PROTOCOL_USB] = "USB",
+	[ICM_PROTOCOL_DP] = "DisplayPort",
+	[ICM_PROTOCOL_SGMII] = "SGMII",
+};
+
 /* Test Mode common reset control  parameters */
 #define TM_CMN_RST			0x10018
 #define TM_CMN_RST_EN			0x1
@@ -768,6 +778,48 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 	return ERR_PTR(-EINVAL);
 }
 
+/*
+ * DebugFS
+ */
+
+static int xpsgtr_status_read(struct seq_file *seq, void *data)
+{
+	struct xpsgtr_phy *gtr_phy = seq->private;
+	struct clk *clk;
+	u32 pll_status;
+
+	mutex_lock(&gtr_phy->phy->mutex);
+	pll_status = xpsgtr_read_phy(gtr_phy, L0_PLL_STATUS_READ_1);
+	clk = gtr_phy->dev->clk[gtr_phy->refclk];
+
+	seq_printf(seq, "Lane:            %u\n", gtr_phy->lane);
+	seq_printf(seq, "Protocol:        %s\n",
+		   xpsgtr_icm_str[gtr_phy->protocol]);
+	seq_printf(seq, "Instance:        %u\n", gtr_phy->instance);
+	seq_printf(seq, "Reference clock: %u (%pC)\n", gtr_phy->refclk, clk);
+	seq_printf(seq, "Reference rate:  %lu\n", clk_get_rate(clk));
+	seq_printf(seq, "PLL locked:      %s\n",
+		   pll_status & PLL_STATUS_LOCKED ? "yes" : "no");
+
+	mutex_unlock(&gtr_phy->phy->mutex);
+	return 0;
+}
+
+static int xpsgtr_status_open(struct inode *inode, struct file *f)
+{
+	struct xpsgtr_phy *gtr_phy = inode->i_private;
+
+	return single_open(f, xpsgtr_status_read, gtr_phy);
+}
+
+static const struct file_operations xpsgtr_status_ops = {
+	.owner = THIS_MODULE,
+	.open = xpsgtr_status_open,
+	.release = single_release,
+	.read = seq_read,
+	.llseek = seq_lseek
+};
+
 /*
  * Power Management
  */
@@ -917,6 +969,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
 
 		gtr_phy->phy = phy;
 		phy_set_drvdata(phy, gtr_phy);
+		debugfs_create_file("status", 0444, phy->debugfs, gtr_phy,
+				    &xpsgtr_status_ops);
 	}
 
 	/* Register the PHY provider. */
-- 
2.35.1.1320.gc452695387.dirty


