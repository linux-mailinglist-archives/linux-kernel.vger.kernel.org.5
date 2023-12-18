Return-Path: <linux-kernel+bounces-3273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157D816A36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446591F23269
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B10125BA;
	Mon, 18 Dec 2023 09:51:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E825134A1;
	Mon, 18 Dec 2023 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Stw605ZNSz1fyfG;
	Mon, 18 Dec 2023 17:49:44 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 686981A0172;
	Mon, 18 Dec 2023 17:50:56 +0800 (CST)
Received: from DESKTOP-4VUP2L6.huawei.com (10.174.177.147) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 17:50:55 +0800
From: JiangJianJun <jiangjianjun3@huawei.com>
To: <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<louhongxiang@huawei.com>, <haowenchao2@huawei.com>, <lixiaokeng@huawei.com>
Subject: [PATCH] scsi: sr: fix signed integer overflow
Date: Mon, 18 Dec 2023 17:50:54 +0800
Message-ID: <20231218095054.12228-1-jiangjianjun3@huawei.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)

Checking the range of the parameter speed, avoid integer overflow.

Signed-off-by: JiangJianJun <jiangjianjun3@huawei.com>
---
 drivers/scsi/sr_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index 5b0b35e60e61..d5b2cd80d171 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -430,6 +430,8 @@ int sr_select_speed(struct cdrom_device_info *cdi, int speed)
 	Scsi_CD *cd = cdi->handle;
 	struct packet_command cgc;
 
+	if (speed < 0 || speed > (INT_MAX / 177))
+		return -EINVAL;
 	if (speed == 0)
 		speed = 0xffff;	/* set to max */
 	else
-- 
2.39.3


