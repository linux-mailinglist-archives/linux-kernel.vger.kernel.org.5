Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AA48032BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344015AbjLDMcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjLDMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:32:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926BFC3;
        Mon,  4 Dec 2023 04:32:34 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SkNJ00Ldhz1P9HW;
        Mon,  4 Dec 2023 20:28:48 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 4 Dec 2023 20:32:32 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v5 2/3] scsi: libsas: Move sas_add_parent_port() to sas_expander.c
Date:   Mon, 4 Dec 2023 12:29:31 +0000
Message-ID: <20231204122932.55741-3-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204122932.55741-1-yangxingui@huawei.com>
References: <20231204122932.55741-1-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move sas_add_parent_port() to sas_expander.c since it is only used in this
file.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 15 +++++++++++++++
 drivers/scsi/libsas/sas_internal.h | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 1257f90130fb..7aa968b85e1e 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -33,6 +33,21 @@ static void sas_port_add_ex_phy(struct sas_port *port, struct ex_phy *ex_phy)
 	ex_phy->phy_state = PHY_DEVICE_DISCOVERED;
 }
 
+static void sas_add_parent_port(struct domain_device *dev, int phy_id)
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

