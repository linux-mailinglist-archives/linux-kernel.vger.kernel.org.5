Return-Path: <linux-kernel+bounces-19548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92436826EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463951F22DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3FE55E67;
	Mon,  8 Jan 2024 12:34:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69945BFC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 703E6FEC;
	Mon,  8 Jan 2024 04:35:37 -0800 (PST)
Received: from [127.0.1.1] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55CD3F64C;
	Mon,  8 Jan 2024 04:34:50 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 08 Jan 2024 12:34:16 +0000
Subject: [PATCH 6/6] firmware: arm_ffa: Handle partitions setup failures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ffa_fixes_6-8-v1-6-75bf7035bc50@arm.com>
References: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
In-Reply-To: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.12.4

Make ffa_setup_partitions() fail, cleanup and return an error when the Host
partition setup fails: in such a case ffa_init() itself will fail.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index c613b57747cf..f2556a8e9401 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -112,6 +112,7 @@ struct ffa_drv_info {
 };
 
 static struct ffa_drv_info *drv_info;
+static void ffa_partitions_cleanup(void);
 
 /*
  * The driver must be able to support all the versions from the earliest
@@ -1195,7 +1196,7 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
 	kfree(pbuf);
 }
 
-static void ffa_setup_partitions(void)
+static int ffa_setup_partitions(void)
 {
 	int count, idx, ret;
 	uuid_t uuid;
@@ -1206,7 +1207,7 @@ static void ffa_setup_partitions(void)
 	count = ffa_partition_probe(&uuid_null, &pbuf);
 	if (count <= 0) {
 		pr_info("%s: No partitions found, error %d\n", __func__, count);
-		return;
+		return -EINVAL;
 	}
 
 	xa_init(&drv_info->partition_info);
@@ -1250,8 +1251,14 @@ static void ffa_setup_partitions(void)
 
 	/* Allocate for the host */
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return;
+	if (!info) {
+		pr_err("%s: failed to alloc Host partition ID 0x%x. Abort.\n",
+		       __func__, drv_info->vm_id);
+		/* Already registered devices are freed on bus_exit */
+		ffa_partitions_cleanup();
+		return -ENOMEM;
+	}
+
 	rwlock_init(&info->rw_lock);
 	ret = xa_insert(&drv_info->partition_info, drv_info->vm_id,
 			info, GFP_KERNEL);
@@ -1259,7 +1266,11 @@ static void ffa_setup_partitions(void)
 		pr_err("%s: failed to save Host partition ID 0x%x - ret:%d. Abort.\n",
 		       __func__, drv_info->vm_id, ret);
 		kfree(info);
+		/* Already registered devices are freed on bus_exit */
+		ffa_partitions_cleanup();
 	}
+
+	return ret;
 }
 
 static void ffa_partitions_cleanup(void)
@@ -1520,7 +1531,11 @@ static int __init ffa_init(void)
 
 	ffa_notifications_setup();
 
-	ffa_setup_partitions();
+	ret = ffa_setup_partitions();
+	if (ret) {
+		pr_err("failed to setup partitions\n");
+		goto cleanup_notifs;
+	}
 
 	ret = ffa_sched_recv_cb_update(drv_info->vm_id, ffa_self_notif_handle,
 				       drv_info, true);
@@ -1528,6 +1543,9 @@ static int __init ffa_init(void)
 		pr_info("Failed to register driver sched callback %d\n", ret);
 
 	return 0;
+
+cleanup_notifs:
+	ffa_notifications_cleanup();
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);

-- 
2.34.1


