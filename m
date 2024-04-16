Return-Path: <linux-kernel+bounces-146144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1DA8A614E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14498B2160A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511881755C;
	Tue, 16 Apr 2024 03:09:44 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED212E48;
	Tue, 16 Apr 2024 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236983; cv=none; b=HI48VtHCKYHq+wqSdBVTx4zgvvL1oZbpOKcpuyoNxgn/9m6ft5inlhZCNzfUkPPrA7OTJCEW4gkP2oxBRySdUxu2Y1Mfrjt3a+/eul9GCVKEdY2n+/EVM5DMw0E47+lncGhdOYMO6dZ/9WfMmfazrpibiNPvaL0mkXGX6X7utKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236983; c=relaxed/simple;
	bh=lpF0oJa0WGrlcK+RmBCLs6iVDc79ONJGE0ALQEh7ls4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RxHIwjHU+Q62YUz92qBkw+3Wfd+yrWZBfyouzLRkdoY9NP5dF8iFEWFqQK6C2reCdXmF47zBVbakBjoDUE63vSCJeVCiJvShefz12ADYBIdJ9s1xChqIYjffzFXpMA3YYcCUbUfsyNG24powmKlwAOje8Eg8YVMetNJhUeTL2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VJTTX13FLz1RCqg;
	Tue, 16 Apr 2024 11:06:40 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 64C01180064;
	Tue, 16 Apr 2024 11:09:37 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 11:09:37 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH] scsi: libsas: Fix exp-attached end device cannot be scanned in again after probe failed
Date: Tue, 16 Apr 2024 03:07:27 +0000
Message-ID: <20240416030727.17074-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100001.china.huawei.com (7.185.36.94)

We found that it is judged as broadcast flutter and exits directly when the
exp-attached end device reconnects after the end device probe failed.

[78779.654026] sas: broadcast received: 0
[78779.654037] sas: REVALIDATING DOMAIN on port 0, pid:10
[78779.654680] sas: ex 500e004aaaaaaa1f phy05 change count has changed
[78779.662977] sas: ex 500e004aaaaaaa1f phy05 originated BROADCAST(CHANGE)
[78779.662986] sas: ex 500e004aaaaaaa1f phy05 new device attached
[78779.663079] sas: ex 500e004aaaaaaa1f phy05:U:8 attached: 500e004aaaaaaa05 (stp)
[78779.693542] hisi_sas_v3_hw 0000:b4:02.0: dev[16:5] found
[78779.701155] sas: done REVALIDATING DOMAIN on port 0, pid:10, res 0x0
[78779.707864] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
..
[78835.161307] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[78835.171344] sas: sas_probe_sata: for exp-attached device 500e004aaaaaaa05 returned -19
[78835.180879] hisi_sas_v3_hw 0000:b4:02.0: dev[16:5] is gone
[78835.187487] sas: broadcast received: 0
[78835.187504] sas: REVALIDATING DOMAIN on port 0, pid:10
[78835.188263] sas: ex 500e004aaaaaaa1f phy05 change count has changed
[78835.195870] sas: ex 500e004aaaaaaa1f phy05 originated BROADCAST(CHANGE)
[78835.195875] sas: ex 500e004aaaaaaa1f rediscovering phy05
[78835.196022] sas: ex 500e004aaaaaaa1f phy05:U:A attached: 500e004aaaaaaa05 (stp)
[78835.196026] sas: ex 500e004aaaaaaa1f phy05 broadcast flutter
[78835.197615] sas: done REVALIDATING DOMAIN on port 0, pid:10, res 0x0

The cause of the problem is that the related ex_phy information was not
cleared after the end device probe failed. In order to solve the above
problem, a function sas_ex_unregister_end_dev() is defined to clear the
ex_phy information and unregister the end device when the exp-attached end
device probe failed.

As the sata device is an asynchronous probe, the sata device may probe
failed after done REVALIDATING DOMAIN. Then after the port is added to the
sas_port_del_list, the port will not be deleted until the end of the next
REVALIDATING DOMAIN and sas_destruct_ports() is called. A warning about
creating a duplicate port will occur in the new REVALIDATING DOMAIN when
the end device reconnects. Therefore, the previous destroy_list and
sas_port_del_list should be handled before REVALIDATING DOMAIN.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_discover.c |  2 ++
 drivers/scsi/libsas/sas_expander.c | 16 ++++++++++++++++
 drivers/scsi/libsas/sas_internal.h |  6 +++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 8fb7c41c0962..aae90153f4c6 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -517,6 +517,8 @@ static void sas_revalidate_domain(struct work_struct *work)
 	struct sas_ha_struct *ha = port->ha;
 	struct domain_device *ddev = port->port_dev;
 
+	sas_destruct_devices(port);
+	sas_destruct_ports(port);
 	/* prevent revalidation from finding sata links in recovery */
 	mutex_lock(&ha->disco_mutex);
 	if (test_bit(SAS_HA_ATA_EH_ACTIVE, &ha->state)) {
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index f6e6db8b8aba..6ae1f4aaaf61 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1856,6 +1856,22 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
 	}
 }
 
+void sas_ex_unregister_end_dev(struct domain_device *dev)
+{
+	struct domain_device *parent = dev->parent;
+	struct expander_device *parent_ex = &parent->ex_dev;
+	int i;
+
+	for (i = 0; i < parent_ex->num_phys; i++) {
+		struct ex_phy *phy = &parent_ex->ex_phy[i];
+
+		if (sas_phy_match_dev_addr(dev, phy)) {
+			sas_unregister_devs_sas_addr(parent, i, true);
+			break;
+		}
+	}
+}
+
 static int sas_discover_bfs_by_root_level(struct domain_device *root,
 					  const int level)
 {
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 3804aef165ad..434f928c2ed8 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -50,6 +50,7 @@ void sas_discover_event(struct asd_sas_port *port, enum discover_event ev);
 
 void sas_init_dev(struct domain_device *dev);
 void sas_unregister_dev(struct asd_sas_port *port, struct domain_device *dev);
+void sas_ex_unregister_end_dev(struct domain_device *dev);
 
 void sas_scsi_recover_host(struct Scsi_Host *shost);
 
@@ -145,7 +146,10 @@ static inline void sas_fail_probe(struct domain_device *dev, const char *func, i
 		func, dev->parent ? "exp-attached" :
 		"direct-attached",
 		SAS_ADDR(dev->sas_addr), err);
-	sas_unregister_dev(dev->port, dev);
+	if (dev->parent && !dev_is_expander(dev->dev_type))
+		sas_ex_unregister_end_dev(dev);
+	else
+		sas_unregister_dev(dev->port, dev);
 }
 
 static inline void sas_fill_in_rphy(struct domain_device *dev,
-- 
2.17.1


