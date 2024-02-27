Return-Path: <linux-kernel+bounces-82903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FBC868B91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474F5B2781E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D04913666E;
	Tue, 27 Feb 2024 09:03:28 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D11369AA;
	Tue, 27 Feb 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024608; cv=none; b=morcscWOzxEsHmRLXQmtqIZycQ8dXXbkC6pV6xs3JzhRKhUAs7qLxcCfenhvUKSu/0AyF7b6E5FxjFXvrML9nnIDKI3kyoZ2YeYv3i+Pm/IrFqdSgLc9xLZZ37WK84ms9/iR9tJBPOhT/Cqm9S9ZAl83tQ42jgde6zC/6Vp+0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024608; c=relaxed/simple;
	bh=rpAcgDu08eOYArumIDP3NkspxMrhkm+nJ8NzviuOPCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BpbnqvzDh1PXx5uTkJRGs3ZwRxncz7sj4ASooTMPXZvPUqQIPL9XYPZvNmbEfWEvfXQzPok4feqi9S9IsbUkLN2J93fo/AFNBzVeLhVR/tzQ0W5++xgivQrH8CM0VqvypsggWOHBoUSUu1ptg07mQGCuInVaQgIJbsClFrZEubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TkWbt2Lzdz1b12P;
	Tue, 27 Feb 2024 16:58:18 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FC3B1A016B;
	Tue, 27 Feb 2024 17:03:16 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 17:03:16 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v2] scsi: libsas: Fix disk not being scanned in after being removed
Date: Tue, 27 Feb 2024 09:01:49 +0000
Message-ID: <20240227090149.29039-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd100001.china.huawei.com (7.185.36.94)

As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
update PHY info"), do discovery will send a new SMP_DISCOVER and update
phy->phy_change_count. We found that if the disk is reconnected and phy
change_count changes at this time, the disk scanning process will not be
triggered.

So update the PHY info with the last query results.

Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to update PHY info")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
v1 -> v2:
Use sas_get_phy_discover() instead of sas_get_phy_attached_dev() in
sas_rediscover_dev() and use disc_resp to update phy info.
---
 drivers/scsi/libsas/sas_expander.c | 37 ++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..a75dcce7a9ba 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1940,6 +1940,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 	struct expander_device *ex = &dev->ex_dev;
 	struct ex_phy *phy = &ex->ex_phy[phy_id];
 	enum sas_device_type type = SAS_PHY_UNUSED;
+	struct smp_disc_resp *disc_resp;
 	u8 sas_addr[SAS_ADDR_SIZE];
 	char msg[80] = "";
 	int res;
@@ -1951,33 +1952,47 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 		 SAS_ADDR(dev->sas_addr), phy_id, msg);
 
 	memset(sas_addr, 0, SAS_ADDR_SIZE);
-	res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
+	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
+	if (!disc_resp)
+		return -ENOMEM;
+
+	res = sas_get_phy_discover(dev, phy_id, disc_resp);
 	switch (res) {
 	case SMP_RESP_NO_PHY:
 		phy->phy_state = PHY_NOT_PRESENT;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
-		return res;
+		goto out;
 	case SMP_RESP_PHY_VACANT:
 		phy->phy_state = PHY_VACANT;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
-		return res;
+		goto out;
 	case SMP_RESP_FUNC_ACC:
 		break;
 	case -ECOMM:
 		break;
 	default:
-		return res;
+		goto out;
+	}
+
+	if (res == 0) {
+		struct discover_resp *dr = &disc_resp->disc;
+
+		memcpy(sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
+		type = to_dev_type(dr);
+		if (type == 0)
+			memset(sas_addr, 0, SAS_ADDR_SIZE);
 	}
 
 	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
 		phy->phy_state = PHY_EMPTY;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
 		/*
-		 * Even though the PHY is empty, for convenience we discover
-		 * the PHY to update the PHY info, like negotiated linkrate.
+		 * Even though the PHY is empty, for convenience we update
+		 * the PHY info, like negotiated linkrate.
 		 */
-		sas_ex_phy_discover(dev, phy_id);
-		return res;
+		if (res == 0)
+			sas_set_ex_phy(dev, phy_id, disc_resp);
+		goto out;
 	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
 		   dev_type_flutter(type, phy->attached_dev_type)) {
 		struct domain_device *ata_dev = sas_ex_to_ata(dev, phy_id);
@@ -1989,7 +2004,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 			action = ", needs recovery";
 		pr_debug("ex %016llx phy%02d broadcast flutter%s\n",
 			 SAS_ADDR(dev->sas_addr), phy_id, action);
-		return res;
+		goto out;
 	}
 
 	/* we always have to delete the old device when we went here */
@@ -1998,7 +2013,11 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 		SAS_ADDR(phy->attached_sas_addr));
 	sas_unregister_devs_sas_addr(dev, phy_id, last);
 
+	kfree(disc_resp);
 	return sas_discover_new(dev, phy_id);
+out:
+	kfree(disc_resp);
+	return res;
 }
 
 /**
-- 
2.17.1


