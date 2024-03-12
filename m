Return-Path: <linux-kernel+bounces-100327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C88795C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5D24B24557
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640647B3E7;
	Tue, 12 Mar 2024 14:12:49 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591CC7A726;
	Tue, 12 Mar 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252768; cv=none; b=KY9fALph9YN12QZrB8qtHCRn657gTtb+nA7QPQBta3uHYQiRv/13rKXdWWQZJYKFLvXxwhae4rBviavlw5kCNRUTyrDYUga8eP3weXaI92e3yYm/EXH84Sl44PZWxKKmoBNAHX2iMDA8AeYpEZ19UoX2mjNzn1DVstvTYJgGPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252768; c=relaxed/simple;
	bh=bmvQ8hOTiSgg1gYAFFWH60u0ekOQ2rtDYr9n67KF1Kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH6yFUxPypxwxm0Vcv6/2EmNzOTf3Qkxbb9S4Yldgub1zXjPHxsOwSahsBznM/oVEfU1d1gI7OjVHgTu9ip77sa5bMUqBC1B3H1l8sHjaiSX9sdzZgFw3IVpDMdAfanmyawrqFitEGCifXoRYkMWeEkulpmA1KVdMe2XC0//sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TvFvw1DzFz1FM6g;
	Tue, 12 Mar 2024 22:12:28 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id EA44718001B;
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
Subject: [PATCH v6 3/4] scsi: libsas: Set port when ex_phy is added or deleted
Date: Tue, 12 Mar 2024 14:11:02 +0000
Message-ID: <20240312141103.31358-4-yangxingui@huawei.com>
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

We found that when ex_phy was attached and added to the parent wide port,
ex_phy->port was not set, resulting in sas_unregister_devs_sas_addr() not
calling sas_port_delete_phy() when deleting the phy, and the deleted phy
was still on the parent wide port's phy_list.

When we use sas_port_add_ex_phy() to set ex_phy->port to solve the above
problem, we find that after all the phys of the parent_port are removed and
the number of phy becomes 0, the parent_port will not be set to NULL.
Causes the freed parent port to be used when attaching a new ex_phy in
sas_ex_add_parent_port().

So use sas_port_add_ex_phy() instead of sas_port_add_phy() to set
ex_phy->port when ex_phy is added to the parent port, and set
ex_dev->parent_port to NULL when the number of phy on the port becomes 0.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index f28a83803947..77daae36232b 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -45,7 +45,7 @@ static void sas_ex_add_parent_port(struct domain_device *dev, int phy_id)
 		BUG_ON(sas_port_add(ex->parent_port));
 		sas_port_mark_backlink(ex->parent_port);
 	}
-	sas_port_add_phy(ex->parent_port, ex_phy->phy);
+	sas_port_add_ex_phy(ex->parent_port, ex_phy);
 }
 
 /* ---------- SMP task management ---------- */
@@ -1879,9 +1879,12 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
 	if (phy->port) {
 		sas_port_delete_phy(phy->port, phy->phy);
 		sas_device_set_phy(found, phy->port);
-		if (phy->port->num_phys == 0)
+		if (phy->port->num_phys == 0) {
 			list_add_tail(&phy->port->del_list,
 				&parent->port->sas_port_del_list);
+			if (ex_dev->parent_port == phy->port)
+				ex_dev->parent_port = NULL;
+		}
 		phy->port = NULL;
 	}
 }
-- 
2.17.1


