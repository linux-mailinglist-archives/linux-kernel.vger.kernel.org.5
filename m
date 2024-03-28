Return-Path: <linux-kernel+bounces-117576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C007E88ACC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33D51C3F930
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424E12A142;
	Mon, 25 Mar 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PAxcNMJi"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA2D84D2B;
	Mon, 25 Mar 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387256; cv=none; b=FOW8vOS6Q3l3WxzDrgJ2HXi7oRD62iFfBB1PV1FsP5A3jzYFVYc0OyLo3hty0Q331ZOv5fhIg2BaPONpFnTzXPiByHoE9P0L0pVnsLhyEL5GI9dx70UVwhk6RnQ/agBJOHuZJSaDQbj2yPhxYgPwdLg/QL0qU15DdK/2pvocwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387256; c=relaxed/simple;
	bh=P/VnF/qnJ/q/CFLwO6pmKiUWpJe7q8mHYQKoiG5ldhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNFJjE5roJJ2tyA1DxzwU0i69gzmWHnyyxGePmbOM7roCsRgLhxHpAej8V8+XNxK5HkMe2QG5yi/w4U84234+ViZBFjMXfaw+W+XAluyxzHQzOa/Wno3SP+b52flj7SLpYsaK9s0yymrk/iI3N7Dl8omUj5PkBeJvh/bteD0sC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PAxcNMJi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKnCR013604;
	Mon, 25 Mar 2024 12:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387249;
	bh=KDf4x/lczdR2LuWICqLSkiUo9SNZ0/+dHt1tFmC5qbw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PAxcNMJiGyYHRESsdSIXjqFc+IZH2346a4uCIZzDZQqE0r3U+Mw6DmB0hdCopL5Nq
	 9OwV6/1m/DsG2tOtnJ/AhsxS1DhZU6KwiS3cCO6pJXF4KK1f1yl2qygktqAyrpDweg
	 ZuNO1bGQSdXs9cKM5i5UA/WUa9Loi53PRxpE3Zpo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKnQh105018
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:49 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:49 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYe075282;
	Mon, 25 Mar 2024 12:20:49 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 08/13] mailbox: omap: Merge mailbox child node setup loops
Date: Mon, 25 Mar 2024 12:20:40 -0500
Message-ID: <20240325172045.113047-9-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325172045.113047-1-afd@ti.com>
References: <20240325172045.113047-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Currently the driver loops through all mailbox child nodes twice, once
to read in data from each node, and again to make use of this data.
Instead read the data and make use of it in one pass. This removes
the need for several temporary data structures and reduces the
complexity of this main loop in probe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 119 +++++++++++++--------------------
 1 file changed, 46 insertions(+), 73 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 4f956c7b4072c..17c9b9df78b1d 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -89,19 +89,6 @@ struct omap_mbox_device {
 	struct mbox_controller controller;
 };
 
-struct omap_mbox_fifo_info {
-	int tx_id;
-	int tx_usr;
-	int tx_irq;
-
-	int rx_id;
-	int rx_usr;
-	int rx_irq;
-
-	const char *name;
-	bool send_no_irq;
-};
-
 struct omap_mbox {
 	const char		*name;
 	int			irq;
@@ -574,8 +561,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct mbox_chan *chnls;
-	struct omap_mbox **list, *mbox, *mboxblk;
-	struct omap_mbox_fifo_info *finfo, *finfoblk;
+	struct omap_mbox **list, *mbox;
 	struct omap_mbox_device *mdev;
 	struct omap_mbox_fifo *fifo;
 	struct device_node *node = pdev->dev.of_node;
@@ -609,40 +595,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	finfoblk = devm_kcalloc(&pdev->dev, info_count, sizeof(*finfoblk),
-				GFP_KERNEL);
-	if (!finfoblk)
-		return -ENOMEM;
-
-	finfo = finfoblk;
-	child = NULL;
-	for (i = 0; i < info_count; i++, finfo++) {
-		child = of_get_next_available_child(node, child);
-		ret = of_property_read_u32_array(child, "ti,mbox-tx", tmp,
-						 ARRAY_SIZE(tmp));
-		if (ret)
-			return ret;
-		finfo->tx_id = tmp[0];
-		finfo->tx_irq = tmp[1];
-		finfo->tx_usr = tmp[2];
-
-		ret = of_property_read_u32_array(child, "ti,mbox-rx", tmp,
-						 ARRAY_SIZE(tmp));
-		if (ret)
-			return ret;
-		finfo->rx_id = tmp[0];
-		finfo->rx_irq = tmp[1];
-		finfo->rx_usr = tmp[2];
-
-		finfo->name = child->name;
-
-		finfo->send_no_irq = of_property_read_bool(child, "ti,mbox-send-noirq");
-
-		if (finfo->tx_id >= num_fifos || finfo->rx_id >= num_fifos ||
-		    finfo->tx_usr >= num_users || finfo->rx_usr >= num_users)
-			return -EINVAL;
-	}
-
 	mdev = devm_kzalloc(&pdev->dev, sizeof(*mdev), GFP_KERNEL);
 	if (!mdev)
 		return -ENOMEM;
@@ -667,36 +619,58 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	if (!chnls)
 		return -ENOMEM;
 
-	mboxblk = devm_kcalloc(&pdev->dev, info_count, sizeof(*mbox),
-			       GFP_KERNEL);
-	if (!mboxblk)
-		return -ENOMEM;
+	child = NULL;
+	for (i = 0; i < info_count; i++) {
+		int tx_id, tx_irq, tx_usr;
+		int rx_id,         rx_usr;
+
+		mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
+		if (!mbox)
+			return -ENOMEM;
+
+		child = of_get_next_available_child(node, child);
+		ret = of_property_read_u32_array(child, "ti,mbox-tx", tmp,
+						 ARRAY_SIZE(tmp));
+		if (ret)
+			return ret;
+		tx_id = tmp[0];
+		tx_irq = tmp[1];
+		tx_usr = tmp[2];
+
+		ret = of_property_read_u32_array(child, "ti,mbox-rx", tmp,
+						 ARRAY_SIZE(tmp));
+		if (ret)
+			return ret;
+		rx_id = tmp[0];
+		/* rx_irq = tmp[1]; */
+		rx_usr = tmp[2];
+
+		if (tx_id >= num_fifos || rx_id >= num_fifos ||
+		    tx_usr >= num_users || rx_usr >= num_users)
+			return -EINVAL;
 
-	mbox = mboxblk;
-	finfo = finfoblk;
-	for (i = 0; i < info_count; i++, finfo++) {
 		fifo = &mbox->tx_fifo;
-		fifo->msg = MAILBOX_MESSAGE(finfo->tx_id);
-		fifo->fifo_stat = MAILBOX_FIFOSTATUS(finfo->tx_id);
-		fifo->intr_bit = MAILBOX_IRQ_NOTFULL(finfo->tx_id);
-		fifo->irqenable = MAILBOX_IRQENABLE(intr_type, finfo->tx_usr);
-		fifo->irqstatus = MAILBOX_IRQSTATUS(intr_type, finfo->tx_usr);
-		fifo->irqdisable = MAILBOX_IRQDISABLE(intr_type, finfo->tx_usr);
+		fifo->msg = MAILBOX_MESSAGE(tx_id);
+		fifo->fifo_stat = MAILBOX_FIFOSTATUS(tx_id);
+		fifo->intr_bit = MAILBOX_IRQ_NOTFULL(tx_id);
+		fifo->irqenable = MAILBOX_IRQENABLE(intr_type, tx_usr);
+		fifo->irqstatus = MAILBOX_IRQSTATUS(intr_type, tx_usr);
+		fifo->irqdisable = MAILBOX_IRQDISABLE(intr_type, tx_usr);
 
 		fifo = &mbox->rx_fifo;
-		fifo->msg = MAILBOX_MESSAGE(finfo->rx_id);
-		fifo->msg_stat =  MAILBOX_MSGSTATUS(finfo->rx_id);
-		fifo->intr_bit = MAILBOX_IRQ_NEWMSG(finfo->rx_id);
-		fifo->irqenable = MAILBOX_IRQENABLE(intr_type, finfo->rx_usr);
-		fifo->irqstatus = MAILBOX_IRQSTATUS(intr_type, finfo->rx_usr);
-		fifo->irqdisable = MAILBOX_IRQDISABLE(intr_type, finfo->rx_usr);
-
-		mbox->send_no_irq = finfo->send_no_irq;
+		fifo->msg = MAILBOX_MESSAGE(rx_id);
+		fifo->msg_stat =  MAILBOX_MSGSTATUS(rx_id);
+		fifo->intr_bit = MAILBOX_IRQ_NEWMSG(rx_id);
+		fifo->irqenable = MAILBOX_IRQENABLE(intr_type, rx_usr);
+		fifo->irqstatus = MAILBOX_IRQSTATUS(intr_type, rx_usr);
+		fifo->irqdisable = MAILBOX_IRQDISABLE(intr_type, rx_usr);
+
+		mbox->send_no_irq = of_property_read_bool(child, "ti,mbox-send-noirq");
 		mbox->intr_type = intr_type;
 
 		mbox->parent = mdev;
-		mbox->name = finfo->name;
-		mbox->irq = platform_get_irq(pdev, finfo->tx_irq);
+		mbox->name = child->name;
+		mbox->irq = platform_get_irq(pdev, tx_irq);
 		if (mbox->irq < 0)
 			return mbox->irq;
 		mbox->chan = &chnls[i];
@@ -743,7 +717,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	if (ret < 0 && ret != -ENOSYS)
 		return ret;
 
-	devm_kfree(&pdev->dev, finfoblk);
 	return 0;
 }
 
-- 
2.39.2


