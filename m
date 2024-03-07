Return-Path: <linux-kernel+bounces-95761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D787522D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8331C23516
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405112B144;
	Thu,  7 Mar 2024 14:45:53 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BA1EB23;
	Thu,  7 Mar 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822753; cv=none; b=l/g3miYKODA0A64rSX6LQ+q+GOxNz/qhbcdxzdkQ2DBaH9LuZuZgX9bYjeLCnkHMZ44uGxmz9oChBl181gYMvHKvziePfIxk+nnVgQexA198tTyaOTDLe/oefmVEc0LaoWMZgiq+u89PP6VLKUW7sM2ofABd+jzsMIHYYDilZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822753; c=relaxed/simple;
	bh=IW0qVhH4nYENGiRhPuPTheMDlyWsJMqgiGs+tbx5VdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+KIuITDRl7dteQGslwq36IcoZeTBXUJck2hN1N7Gcz3qVPRwpemq/7GiiJfZKH8+j7duv+T3+r05TIub0Y7MW8sAAOBWx+2qw1YFwdvvB+cQaHm7EnO8YK2k5ik8SeklbLCAqxPm/lkZp3V7WeqbMCsZbCZDkU80p2NZ3DUJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TrBrP2VKJz1Q9NV;
	Thu,  7 Mar 2024 22:43:49 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FA1B140134;
	Thu,  7 Mar 2024 22:45:48 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 22:45:47 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao2@huawei.com>, <louhongxiang@huawei.com>
Subject: [PATCH v4 2/3] scsi: scsi_error: Fix wrong statistic when print error info
Date: Thu, 7 Mar 2024 22:43:10 +0800
Message-ID: <20240307144311.73735-3-haowenchao2@huawei.com>
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
removing, so commands of these devices would be ignored in
scsi_eh_prt_fail_stats().

Fix this issue by using shost_for_each_device_include_deleted()
to iterate devices in scsi_eh_prt_fail_stats().

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 612489afe8d2..a61fd8af3b1f 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -409,7 +409,7 @@ static inline void scsi_eh_prt_fail_stats(struct Scsi_Host *shost,
 	int cmd_cancel = 0;
 	int devices_failed = 0;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device_include_deleted(sdev, shost) {
 		list_for_each_entry(scmd, work_q, eh_entry) {
 			if (scmd->device == sdev) {
 				++total_failures;
-- 
2.32.0


