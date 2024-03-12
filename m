Return-Path: <linux-kernel+bounces-100328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB288795C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F30D1C21927
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929AB7BAEB;
	Tue, 12 Mar 2024 14:12:49 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A701E7A72F;
	Tue, 12 Mar 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252769; cv=none; b=uYgZnROnDaPfAVPxp2gjJLkuy4x2d0u7CurYUjX74WqguMExG044YZ1lTfp28y4lJ4G5tTK+uK6S8ihXGVEQImDF9KWYyISIgV//sULqwYOOHfgMN2N8G9jtC3w6TOlCw0R5par2sQAKQvZr7TV2NOHPJMaL0Sy6Xv62m/phCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252769; c=relaxed/simple;
	bh=WthfU5rqb52QnJaMPjT5KVgI3MToYZAyP8nlAgfk3BE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFVNEHHQHwh4ZMrPdoNFrOkSEKnPnlKkPsv6GVR6bPI8PmyF+sl9fle4AcETDtqUuKG1SlRXuiYLG8D/gGiQtm6GMnmd0KDAQDoB2JMePq26Gji8opda5APkB15hr1S6azdqd0Qt4INq7HrmiPa9DW0MbGA2VRx8JYu+RMisB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TvFtB30szz1xqkf;
	Tue, 12 Mar 2024 22:10:58 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C3F3B1A0172;
	Tue, 12 Mar 2024 22:12:42 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 12 Mar 2024 22:12:42 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v6 2/4] scsi: libsas: Move sas_add_parent_port() to sas_expander.c
Date: Tue, 12 Mar 2024 14:11:01 +0000
Message-ID: <20240312141103.31358-3-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240312141103.31358-1-yangxingui@huawei.com>
References: <20240312141103.31358-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100001.china.huawei.com (7.185.36.94)

Move sas_add_parent_port() to sas_expander.c and rename it to
sas_ex_add_parent_port() as it is only used in this file.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/libsas/sas_expander.c | 19 +++++++++++++++++--
 drivers/scsi/libsas/sas_internal.h | 15 ---------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index c8d4aef2f567..f28a83803947 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -33,6 +33,21 @@ static void sas_port_add_ex_phy(struct sas_port *port, struct ex_phy *ex_phy)
 	ex_phy->phy_state = PHY_DEVICE_DISCOVERED;
 }
 
+static void sas_ex_add_parent_port(struct domain_device *dev, int phy_id)
+{
+	struct expander_device *ex = &dev->ex_dev;
+	struct ex_phy *ex_phy = &ex->ex_phy[phy_id];
+
+	if (!ex->parent_port) {
+		ex->parent_port = sas_port_alloc(&dev->rphy->dev, phy_id);
+		/* FIXME: error handling */
+		BUG_ON(!ex->parent_port);
+		BUG_ON(sas_port_add(ex->parent_port));
+		sas_port_mark_backlink(ex->parent_port);
+	}
+	sas_port_add_phy(ex->parent_port, ex_phy->phy);
+}
+
 /* ---------- SMP task management ---------- */
 
 /* Give it some long enough timeout. In seconds. */
@@ -978,11 +993,11 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
 
 	/* Parent and domain coherency */
 	if (!dev->parent && sas_phy_match_port_addr(dev->port, ex_phy)) {
-		sas_add_parent_port(dev, phy_id);
+		sas_ex_add_parent_port(dev, phy_id);
 		return 0;
 	}
 	if (dev->parent && sas_phy_match_dev_addr(dev->parent, ex_phy)) {
-		sas_add_parent_port(dev, phy_id);
+		sas_ex_add_parent_port(dev, phy_id);
 		if (ex_phy->routing_attr == TABLE_ROUTING)
 			sas_configure_phy(dev, phy_id, dev->port->sas_addr, 1);
 		return 0;
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 3804aef165ad..85948963fb97 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -189,21 +189,6 @@ static inline void sas_phy_set_target(struct asd_sas_phy *p, struct domain_devic
 	}
 }
 
-static inline void sas_add_parent_port(struct domain_device *dev, int phy_id)
-{
-	struct expander_device *ex = &dev->ex_dev;
-	struct ex_phy *ex_phy = &ex->ex_phy[phy_id];
-
-	if (!ex->parent_port) {
-		ex->parent_port = sas_port_alloc(&dev->rphy->dev, phy_id);
-		/* FIXME: error handling */
-		BUG_ON(!ex->parent_port);
-		BUG_ON(sas_port_add(ex->parent_port));
-		sas_port_mark_backlink(ex->parent_port);
-	}
-	sas_port_add_phy(ex->parent_port, ex_phy->phy);
-}
-
 static inline struct domain_device *sas_alloc_device(void)
 {
 	struct domain_device *dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-- 
2.17.1


