Return-Path: <linux-kernel+bounces-117581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC588ACD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A613A1C603A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3D12C805;
	Mon, 25 Mar 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I1SnGiYZ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899F12B15E;
	Mon, 25 Mar 2024 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387267; cv=none; b=G625PXFifrpO3hK4ELqh+mcV7oaybKtCL+KOHmy87MwiYtGiG6NWLaIh3psr+amT9XztXTrYLuqxbJMLaw9oeycH0PaXTCvLbhBBz/z3ZxnZ+lXjPWpJ1ntnhDAQ76k2NGFItbn1Yd5xyCsge2/vILi5ouA89DjqrtlQ6lhl4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387267; c=relaxed/simple;
	bh=PTegs9ykbvHC1ICQVyVsRDew1j48hO85AyiibH06nsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWmjJzdZIFE/c3AEW3G8pUEPMcnQPEjPBg9wpzy468QAlETdsjwv+qhqnm49MnUu3jKkYcR/Ei3xiI4hQtI7hRI1hhpq3Zy/wDrxEkxRyrlt3nQMK6EDzhkIvntvxtCpZpm95bzp/N12PpmtKNKXhTiNbHj2jH5Rnzg3W0KgMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I1SnGiYZ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKo9B022683;
	Mon, 25 Mar 2024 12:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387250;
	bh=D2x4h79JlmRi6L/Tkiiqwzm9M9u1cUSEJdufr2dangU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=I1SnGiYZsAcQxDRE7NS64e8LIoQbtBHu7f/ttHpk5VqgSmJSWoRO/KBblRvwthnkr
	 +IVXt4ZESRPC6S1Zqk+JcdC5b7dxPHB0VClN9PJtGylOkee943HZ8K30RHCMq+OkEW
	 vZoOM245LIGBvozRnHJP4rzX3tsIvoFW7UBSKuso=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKo3A105033
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:50 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:50 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYg075282;
	Mon, 25 Mar 2024 12:20:49 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 10/13] mailbox: omap: Use mbox_controller channel list directly
Date: Mon, 25 Mar 2024 12:20:42 -0500
Message-ID: <20240325172045.113047-11-afd@ti.com>
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

The driver stores a list of omap_mbox structs so it can later use it to
lookup the mailbox names in of_xlate. This same information is already
available in the mbox_controller passed into of_xlate. Simply use that
data and remove the extra allocation and storage of the omap_mbox list.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 42 +++++++++-------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 97f59d9f9f319..8e42266cb31a5 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -85,7 +85,6 @@ struct omap_mbox_device {
 	u32 num_users;
 	u32 num_fifos;
 	u32 intr_type;
-	struct omap_mbox **mboxes;
 };
 
 struct omap_mbox {
@@ -356,25 +355,6 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	mbox_queue_free(mbox->rxq);
 }
 
-static struct omap_mbox *omap_mbox_device_find(struct omap_mbox_device *mdev,
-					       const char *mbox_name)
-{
-	struct omap_mbox *_mbox, *mbox = NULL;
-	struct omap_mbox **mboxes = mdev->mboxes;
-	int i;
-
-	if (!mboxes)
-		return NULL;
-
-	for (i = 0; (_mbox = mboxes[i]); i++) {
-		if (!strcmp(_mbox->name, mbox_name)) {
-			mbox = _mbox;
-			break;
-		}
-	}
-	return mbox;
-}
-
 static int omap_mbox_chan_startup(struct mbox_chan *chan)
 {
 	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
@@ -539,6 +519,7 @@ static struct mbox_chan *omap_mbox_of_xlate(struct mbox_controller *controller,
 	struct device_node *node;
 	struct omap_mbox_device *mdev;
 	struct omap_mbox *mbox;
+	int i;
 
 	mdev = dev_get_drvdata(controller->dev);
 	if (WARN_ON(!mdev))
@@ -551,16 +532,23 @@ static struct mbox_chan *omap_mbox_of_xlate(struct mbox_controller *controller,
 		return ERR_PTR(-ENODEV);
 	}
 
-	mbox = omap_mbox_device_find(mdev, node->name);
+	for (i = 0; i < controller->num_chans; i++) {
+		mbox = controller->chans[i].con_priv;
+		if (!strcmp(mbox->name, node->name)) {
+			of_node_put(node);
+			return &controller->chans[i];
+		}
+	}
+
 	of_node_put(node);
-	return mbox ? mbox->chan : ERR_PTR(-ENOENT);
+	return ERR_PTR(-ENOENT);
 }
 
 static int omap_mbox_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct mbox_chan *chnls;
-	struct omap_mbox **list, *mbox;
+	struct omap_mbox *mbox;
 	struct omap_mbox_device *mdev;
 	struct omap_mbox_fifo *fifo;
 	struct device_node *node = pdev->dev.of_node;
@@ -608,12 +596,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	if (!mdev->irq_ctx)
 		return -ENOMEM;
 
-	/* allocate one extra for marking end of list */
-	list = devm_kcalloc(&pdev->dev, info_count + 1, sizeof(*list),
-			    GFP_KERNEL);
-	if (!list)
-		return -ENOMEM;
-
 	chnls = devm_kcalloc(&pdev->dev, info_count + 1, sizeof(*chnls),
 			     GFP_KERNEL);
 	if (!chnls)
@@ -675,7 +657,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
 			return mbox->irq;
 		mbox->chan = &chnls[i];
 		chnls[i].con_priv = mbox;
-		list[i] = mbox++;
 	}
 
 	mutex_init(&mdev->cfg_lock);
@@ -683,7 +664,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	mdev->num_users = num_users;
 	mdev->num_fifos = num_fifos;
 	mdev->intr_type = intr_type;
-	mdev->mboxes = list;
 
 	controller = devm_kzalloc(&pdev->dev, sizeof(*controller), GFP_KERNEL);
 	if (!controller)
-- 
2.39.2


