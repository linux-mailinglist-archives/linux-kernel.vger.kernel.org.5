Return-Path: <linux-kernel+bounces-100329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDAD8795C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7187F1F21B62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F01D7BAF1;
	Tue, 12 Mar 2024 14:12:49 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC707A72C;
	Tue, 12 Mar 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252769; cv=none; b=PWc4LrhyAMs9YwRjvgV0Xe8LtOfxvGlLy/baUmMLIaMm6vZAlMOMJdpQTqFJxHN8ML/ZjUyi+N9IgxnTUq6JFQgm8ciyWxVeQ7w6F2cJ7zqDMuku5qb0WQDaE9MIs19O0749C0AHYpcengOLW/G192yGAnviICEQl9kGMGm31EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252769; c=relaxed/simple;
	bh=0bX+OS5NnVGCnM0RrD8Kuci2Q6DddH1OHEL9F4Qbbok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6lh3LsFklckMxhOX3PftJkVDIuBL1UqyobMrDPShNcyURzKJCIA16CI4nKvvL6mjJiJOSbZF3Sn1H6uBzbBi4KsPI/maF7nnT+OIlHn6yT9jc2eMoL4s4baz8vi9gk/p2Vd7Sk4ZZ5NhJUP+aeb2OCD1ob2e2FUOevFiS/MT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TvFsM5Vw9z1Z1ZM;
	Tue, 12 Mar 2024 22:10:15 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DB83140155;
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
Subject: [PATCH v6 1/4] scsi: libsas: Add helper for port add ex_phy
Date: Tue, 12 Mar 2024 14:11:00 +0000
Message-ID: <20240312141103.31358-2-yangxingui@huawei.com>
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

This moves the process of adding ex_phy to a port into a new helper.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/libsas/sas_expander.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index ee3808bfd534..c8d4aef2f567 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -26,6 +26,13 @@ static int sas_configure_phy(struct domain_device *dev, int phy_id,
 			     u8 *sas_addr, int include);
 static int sas_disable_routing(struct domain_device *dev,  u8 *sas_addr);
 
+static void sas_port_add_ex_phy(struct sas_port *port, struct ex_phy *ex_phy)
+{
+	sas_port_add_phy(port, ex_phy->phy);
+	ex_phy->port = port;
+	ex_phy->phy_state = PHY_DEVICE_DISCOVERED;
+}
+
 /* ---------- SMP task management ---------- */
 
 /* Give it some long enough timeout. In seconds. */
@@ -867,9 +874,7 @@ static bool sas_ex_join_wide_port(struct domain_device *parent, int phy_id)
 
 		if (!memcmp(phy->attached_sas_addr, ephy->attached_sas_addr,
 			    SAS_ADDR_SIZE) && ephy->port) {
-			sas_port_add_phy(ephy->port, phy->phy);
-			phy->port = ephy->port;
-			phy->phy_state = PHY_DEVICE_DISCOVERED;
+			sas_port_add_ex_phy(ephy->port, phy);
 			return true;
 		}
 	}
-- 
2.17.1


