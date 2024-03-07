Return-Path: <linux-kernel+bounces-95764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526DD875232
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CD21F2589D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036A412E1D1;
	Thu,  7 Mar 2024 14:45:54 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF41EEEA;
	Thu,  7 Mar 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822753; cv=none; b=oJKMLF1Z95vRLKHDXEj6yHCtqeo8bxW3NWkyb7NGTIC451rg91nWqXOuq8EqbYA3CnjBxx4A2BYFxURaNGK1hecPAQIqSFB95kTgtwJIs53SBEKA/XMlKQ6KsQAnsOSw1n6g+MUJ+oqaq683ncihWF1aWjBljV5MBZ299/oifhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822753; c=relaxed/simple;
	bh=3WxwMc9C3eJk4hG+Fg+CDRmK8LPhlRNCupo83An7/ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5ytMVdstb50HciB4yjq0lnkc4tAIhdAu5WlwFGB0MQNCxd/e5LHT8/RBXazObL05cGuEocAPlrRg4qPdahejBDiMMd1z1Fc+myxSUhpWkjYRI0si+rFM8kLhAhcUXuPD+LKi7UUDQjKwnn3zL21up1EYzNLU9bJqUBaOpu+GJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TrBrp1FP2z1xqMR;
	Thu,  7 Mar 2024 22:44:10 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2625B1A016C;
	Thu,  7 Mar 2024 22:45:49 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 22:45:48 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao2@huawei.com>, <louhongxiang@huawei.com>
Subject: [PATCH v4 3/3] scsi: scsi_error: Fix device reset is not triggered
Date: Thu, 7 Mar 2024 22:43:11 +0800
Message-ID: <20240307144311.73735-4-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240307144311.73735-1-haowenchao2@huawei.com>
References: <20240307144311.73735-1-haowenchao2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)

shost_for_each_device() would skip devices which is in progress of
removing, so scsi_try_bus_device_reset() for these devices would be
skipped in scsi_eh_bus_device_reset() with following order:

T1:					T2:scsi_error_handle
__scsi_remove_device
  scsi_device_set_state(sdev, SDEV_DEL)
					// would skip device with SDEV_DEL state
  					shost_for_each_device()
					  scsi_try_bus_device_reset
					flush all commands
 ...
 releasing and free scsi_device

Some drivers like smartpqi only implement eh_device_reset_handler,
if device reset is skipped, the commands which had been sent to
firmware or devices hardware are not cleared. The error handle
would flush all these commands in scsi_unjam_host().

When the commands are finished by hardware, use after free issue is
triggered.

Fix this issue by using shost_for_each_device_include_deleted()
to iterate devices in scsi_eh_bus_device_reset().

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index a61fd8af3b1f..ab4a58f92838 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1571,7 +1571,7 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 	struct scsi_device *sdev;
 	enum scsi_disposition rtn;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device_include_deleted(sdev, shost) {
 		if (scsi_host_eh_past_deadline(shost)) {
 			SCSI_LOG_ERROR_RECOVERY(3,
 				sdev_printk(KERN_INFO, sdev,
-- 
2.32.0


