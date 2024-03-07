Return-Path: <linux-kernel+bounces-95236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EB4874B13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EED41F2B20E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27384A28;
	Thu,  7 Mar 2024 09:39:14 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AD383CDB;
	Thu,  7 Mar 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804353; cv=none; b=AB80Pgy1c92A7wwIDRk92W4Vrjn1q4lpWdMaOTNq//7J9efu0+Qxwa4oym/fhGETLYz63tzKaQAoSxy/BSwdiZFjlBV+hL/14LvBob/JtOegZAPApVT6vfau7Gy8ERLRjGfSBsH43bFBjdbQV2xhfaNcbdH0rQEdKXMczRuitnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804353; c=relaxed/simple;
	bh=zRQKWwo4ws0uBzmnbQDiBb/B4IeY2WAPFa4HgSvKD6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DekVFUiMq/SvhbTo7l5Q6/dId0wS0TPV1EjQuNq+RZ18r19QkTZKS0pYp7RkdoNeMhKEzHWFaGap8FS+gw5IqJs8FfKLehETNa0Cm+SBs3unpA28+ef+apXwE4P/5BFeGvomR8aKg/HqD10FYHf72mTp5/IgQ6R51Q3Eizz7ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tr44g21BHz1FM3R;
	Thu,  7 Mar 2024 17:38:59 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F442140336;
	Thu,  7 Mar 2024 17:39:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 17:39:08 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v3 1/3] scsi: libsas: Allow smp_execute_task() arguments to be on the stack
Date: Thu, 7 Mar 2024 09:37:31 +0000
Message-ID: <20240307093733.41222-2-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240307093733.41222-1-yangxingui@huawei.com>
References: <20240307093733.41222-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100001.china.huawei.com (7.185.36.94)

We need to use alloc_smp_resp() and alloc_smp_req() before call
smp_execute_task() as we can't allocate these memories on the stack for
calling sg_init_one(). But if we changed smp_execute_task() to memcpy
from/to data on the stack, it might make callers simpler.

Suggested-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 32 ++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..1eeb69cba8da 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -120,17 +120,6 @@ static int smp_execute_task_sg(struct domain_device *dev,
 	return res;
 }
 
-static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
-			    void *resp, int resp_size)
-{
-	struct scatterlist req_sg;
-	struct scatterlist resp_sg;
-
-	sg_init_one(&req_sg, req, req_size);
-	sg_init_one(&resp_sg, resp, resp_size);
-	return smp_execute_task_sg(dev, &req_sg, &resp_sg);
-}
-
 /* ---------- Allocations ---------- */
 
 static inline void *alloc_smp_req(int size)
@@ -146,6 +135,27 @@ static inline void *alloc_smp_resp(int size)
 	return kzalloc(size, GFP_KERNEL);
 }
 
+static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
+			    void *resp, int resp_size)
+{
+	struct scatterlist req_sg;
+	struct scatterlist resp_sg;
+	void *_req = kmemdup(req, req_size, GFP_KERNEL);
+	void *_resp = alloc_smp_resp(resp_size);
+	int ret;
+
+	if (!_req || !resp)
+		return -ENOMEM;
+
+	sg_init_one(&req_sg, _req, req_size);
+	sg_init_one(&resp_sg, _resp, resp_size);
+	ret = smp_execute_task_sg(dev, &req_sg, &resp_sg);
+	memcpy(resp, _resp, resp_size);
+	kfree(_req);
+	kfree(_resp);
+	return ret;
+}
+
 static char sas_route_char(struct domain_device *dev, struct ex_phy *phy)
 {
 	switch (phy->routing_attr) {
-- 
2.17.1


