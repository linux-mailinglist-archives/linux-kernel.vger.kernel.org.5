Return-Path: <linux-kernel+bounces-95711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C287519D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922D928390B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFF912EBC8;
	Thu,  7 Mar 2024 14:15:55 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E312D771;
	Thu,  7 Mar 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820954; cv=none; b=WUZE5eXqwWsAl+gOoqrE+jEfmyNEJ4ADxwIBVQQErkiyizq9iQ1OlJWdhI5XgpK5ItYFfCI4jLhOBWIfsOzf01eH0qFNjFdKd16e0awICHBwQcnfckMIwnMNEPapPV9c6NcOmTVklVj6LMYsL2u53FzACfX8cLG9cyv33pynkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820954; c=relaxed/simple;
	bh=0oU6KL9B71fDtOf5uIw+wC2C4iG62LR7H2m3mEJxiNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk1DXsHOSa5rfBCWxJH5hWWyL3Vq2e8EPDUkndtItAcqaDcM+Hs3UR8E1SGZSDJTEvXTMPPEUCPKORV7gtD9nbfS9PQQgoJDRwKJrmN2u5WnbG4Wwdu8c2jrTfUiYj1YBqgd5lDQd6qXWQDaRQwg3zVqZZVI71k77s9ca7OjML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TrBB94cPlz1xq7L;
	Thu,  7 Mar 2024 22:14:09 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 97DC81A0172;
	Thu,  7 Mar 2024 22:15:48 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 22:15:48 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v4 1/2] scsi: libsas: Add a helper sas_get_sas_addr_and_dev_type()
Date: Thu, 7 Mar 2024 14:14:12 +0000
Message-ID: <20240307141413.48049-2-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240307141413.48049-1-yangxingui@huawei.com>
References: <20240307141413.48049-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100001.china.huawei.com (7.185.36.94)

Add a helper to get attached_sas_addr and device type from disc_resp.

Suggested-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/libsas/sas_expander.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 1eeb69cba8da..d6147616339f 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1631,6 +1631,16 @@ int sas_discover_root_expander(struct domain_device *dev)
 
 /* ---------- Domain revalidation ---------- */
 
+static void sas_get_sas_addr_and_dev_type(struct smp_disc_resp *disc_resp,
+					  u8 *sas_addr,
+					  enum sas_device_type *type)
+{
+	memcpy(sas_addr, disc_resp->disc.attached_sas_addr, SAS_ADDR_SIZE);
+	*type = to_dev_type(&disc_resp->disc);
+	if (*type == SAS_PHY_UNUSED)
+		memset(sas_addr, 0, SAS_ADDR_SIZE);
+}
+
 static int sas_get_phy_discover(struct domain_device *dev,
 				int phy_id, struct smp_disc_resp *disc_resp)
 {
@@ -1684,13 +1694,8 @@ int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
 		return -ENOMEM;
 
 	res = sas_get_phy_discover(dev, phy_id, disc_resp);
-	if (res == 0) {
-		memcpy(sas_addr, disc_resp->disc.attached_sas_addr,
-		       SAS_ADDR_SIZE);
-		*type = to_dev_type(&disc_resp->disc);
-		if (*type == 0)
-			memset(sas_addr, 0, SAS_ADDR_SIZE);
-	}
+	if (res == 0)
+		sas_get_sas_addr_and_dev_type(disc_resp, sas_addr, type);
 	kfree(disc_resp);
 	return res;
 }
-- 
2.17.1


