Return-Path: <linux-kernel+bounces-19546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A6826E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B71FB224FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0945C1B;
	Mon,  8 Jan 2024 12:34:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBBB45954
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A22A6150C;
	Mon,  8 Jan 2024 04:35:35 -0800 (PST)
Received: from [127.0.1.1] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 114313F64C;
	Mon,  8 Jan 2024 04:34:48 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 08 Jan 2024 12:34:14 +0000
Subject: [PATCH 4/6] firmware: arm_ffa: Simplify ffa_partitions_cleanup()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ffa_fixes_6-8-v1-4-75bf7035bc50@arm.com>
References: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
In-Reply-To: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.12.4

On cleanup iterate the XArrays with xa_for_each() and remove the existent
entries with xa_erase(), finally destroy the XArray itself.
Remove partition_count field from drv_info since no more used anywhwere.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 0ea1dd6e55c4..2426021dbb58 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -107,7 +107,6 @@ struct ffa_drv_info {
 	struct work_struct notif_pcpu_work;
 	struct work_struct irq_work;
 	struct xarray partition_info;
-	unsigned int partition_count;
 	DECLARE_HASHTABLE(notifier_hash, ilog2(FFA_MAX_NOTIFICATIONS));
 	struct mutex notify_lock; /* lock to protect notifier hashtable  */
 };
@@ -1239,7 +1238,6 @@ static void ffa_setup_partitions(void)
 		rwlock_init(&info->rw_lock);
 		xa_store(&drv_info->partition_info, tpbuf->id, info, GFP_KERNEL);
 	}
-	drv_info->partition_count = count;
 
 	kfree(pbuf);
 
@@ -1249,29 +1247,18 @@ static void ffa_setup_partitions(void)
 		return;
 	rwlock_init(&info->rw_lock);
 	xa_store(&drv_info->partition_info, drv_info->vm_id, info, GFP_KERNEL);
-	drv_info->partition_count++;
 }
 
 static void ffa_partitions_cleanup(void)
 {
-	struct ffa_dev_part_info **info;
-	int idx, count = drv_info->partition_count;
-
-	if (!count)
-		return;
-
-	info = kcalloc(count, sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return;
-
-	xa_extract(&drv_info->partition_info, (void **)info, 0, VM_ID_MASK,
-		   count, XA_PRESENT);
+	struct ffa_dev_part_info *info;
+	unsigned long idx;
 
-	for (idx = 0; idx < count; idx++)
-		kfree(info[idx]);
-	kfree(info);
+	xa_for_each(&drv_info->partition_info, idx, info) {
+		xa_erase(&drv_info->partition_info, idx);
+		kfree(info);
+	}
 
-	drv_info->partition_count = 0;
 	xa_destroy(&drv_info->partition_info);
 }
 
@@ -1547,7 +1534,6 @@ static void __exit ffa_exit(void)
 	ffa_rxtx_unmap(drv_info->vm_id);
 	free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
 	free_pages_exact(drv_info->rx_buffer, RXTX_BUFFER_SIZE);
-	xa_destroy(&drv_info->partition_info);
 	kfree(drv_info);
 	arm_ffa_bus_exit();
 }

-- 
2.34.1


