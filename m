Return-Path: <linux-kernel+bounces-19547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35269826E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1461F22D95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2831C55E4A;
	Mon,  8 Jan 2024 12:34:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9FC4597F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B3AC15;
	Mon,  8 Jan 2024 04:35:36 -0800 (PST)
Received: from [127.0.1.1] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E13CE3F64C;
	Mon,  8 Jan 2024 04:34:49 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 08 Jan 2024 12:34:15 +0000
Subject: [PATCH 5/6] firmware: arm_ffa: Use xa_insert() and check for
 result
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ffa_fixes_6-8-v1-5-75bf7035bc50@arm.com>
References: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
In-Reply-To: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.12.4

While adding new partitions descriptors to the XArray the outcome of the
stores should be checked and, in particular, it has also to be ensured
that an existing entry with the same index was not already present, since
partitions IDs are expected to be unique.

Use xa_insert() instead of xa_store() since it returns -EBUSY when the
index is already in use and log an error when that happens.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 2426021dbb58..c613b57747cf 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1197,7 +1197,7 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
 
 static void ffa_setup_partitions(void)
 {
-	int count, idx;
+	int count, idx, ret;
 	uuid_t uuid;
 	struct ffa_device *ffa_dev;
 	struct ffa_dev_part_info *info;
@@ -1236,7 +1236,14 @@ static void ffa_setup_partitions(void)
 			continue;
 		}
 		rwlock_init(&info->rw_lock);
-		xa_store(&drv_info->partition_info, tpbuf->id, info, GFP_KERNEL);
+		ret = xa_insert(&drv_info->partition_info, tpbuf->id,
+				info, GFP_KERNEL);
+		if (ret) {
+			pr_err("%s: failed to save partition ID 0x%x - ret:%d\n",
+			       __func__, tpbuf->id, ret);
+			ffa_device_unregister(ffa_dev);
+			kfree(info);
+		}
 	}
 
 	kfree(pbuf);
@@ -1246,7 +1253,13 @@ static void ffa_setup_partitions(void)
 	if (!info)
 		return;
 	rwlock_init(&info->rw_lock);
-	xa_store(&drv_info->partition_info, drv_info->vm_id, info, GFP_KERNEL);
+	ret = xa_insert(&drv_info->partition_info, drv_info->vm_id,
+			info, GFP_KERNEL);
+	if (ret) {
+		pr_err("%s: failed to save Host partition ID 0x%x - ret:%d. Abort.\n",
+		       __func__, drv_info->vm_id, ret);
+		kfree(info);
+	}
 }
 
 static void ffa_partitions_cleanup(void)

-- 
2.34.1


