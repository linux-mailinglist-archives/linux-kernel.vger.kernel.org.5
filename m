Return-Path: <linux-kernel+bounces-74238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0030885D173
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D371F2524F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498743AC19;
	Wed, 21 Feb 2024 07:33:34 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF823C9;
	Wed, 21 Feb 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500813; cv=none; b=JRlUK4Rn5wc4+obzesvExZyT9Hi4G23hMtfUFzkLu8SzicMYSR2WAuC2HX9qIeVVY6HrSmZqql/HI+4W2eiPO3xv43OX4hmZZxLbOK0X+UDMg7o2RJ71nkEh/Ctu1DrW3UJ/Vz69wF/0LPSUD1Atu/kHrYvjFBWMfRteBXkOMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500813; c=relaxed/simple;
	bh=PlY8APXUkmE6j7kWNFypEEvOafZlgJQqQ7toSvbcGM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T9a0tI6PxL4FpueF23hQqgF0A1g89QKrzT+p7qG1BscqhcmNdEsPrUOg0Z7DNfHTMux9dX6hW/NERlpWvq0I+g3+Jfq4nUM5eXZvlE2PR1SrFaEVWxUM0695kc0KYyDVtkfyFJN+b092pLGHhlUP24h7ppMUGfFm3VsOFSILbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tfnv16861z1FLF3;
	Wed, 21 Feb 2024 15:28:29 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FCD51A0172;
	Wed, 21 Feb 2024 15:33:21 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Wed, 21 Feb 2024 15:33:21 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH] scsi: libsas: Fix disk not being scanned in after being removed
Date: Wed, 21 Feb 2024 07:31:59 +0000
Message-ID: <20240221073159.29408-1-yangxingui@huawei.com>
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

As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
update PHY info"), do discovery will send a new SMP_DISCOVER and update
phy->phy_change_count. We found that if the disk is reconnected and phy
change_count changes at this time, the disk scanning process will not be
triggered.

So update the PHY info with the last query results.

Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to update PHY info")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..9563f5589948 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1681,6 +1681,10 @@ int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
 		if (*type == 0)
 			memset(sas_addr, 0, SAS_ADDR_SIZE);
 	}
+
+	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM))
+		sas_set_ex_phy(dev, phy_id, disc_resp);
+
 	kfree(disc_resp);
 	return res;
 }
@@ -1972,11 +1976,6 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
 		phy->phy_state = PHY_EMPTY;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
-		/*
-		 * Even though the PHY is empty, for convenience we discover
-		 * the PHY to update the PHY info, like negotiated linkrate.
-		 */
-		sas_ex_phy_discover(dev, phy_id);
 		return res;
 	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
 		   dev_type_flutter(type, phy->attached_dev_type)) {
-- 
2.17.1


