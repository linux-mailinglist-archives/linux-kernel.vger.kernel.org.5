Return-Path: <linux-kernel+bounces-154510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C788ADCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CBFFB232BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB0E1DFCE;
	Tue, 23 Apr 2024 04:52:06 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B311B813
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713847926; cv=none; b=jR51Go+flP8fW+//e6JF9YcufnVBSu0PMqkallsAtDy0t0PJYwf4gkBZwFPu+RY16yK/nCO9+CH2w7MCDnfIa3GMwTd7BAhzUn9qSKMHc9E3TXV9OKG8mGYcy9FLSv7zK13QskfCsNB6S9a4p/r9xPdxqMY56J32co4FFax4840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713847926; c=relaxed/simple;
	bh=aYVYenudeseP7u4NAoXIRMIRqOl5yvNTBW+HWmhF2f0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rT/8rnptzM6OrI5wERXGsc6lhdIDDJt9/BlrL6YIUtwcaSOQtKpa77tKkL5/84Axcnh5DLCDdKC64GMuzY8ll56iUZUSp6YY9/oBsL4lW1SAb7jqWEubTTWexZ6UXuCdUzovtwyFyIjd0iqffjtkxjX/mTuytc/Kd2c/N9qvNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VNqQx64KFzNtRn;
	Tue, 23 Apr 2024 12:49:29 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D88BD140444;
	Tue, 23 Apr 2024 12:51:59 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 12:51:59 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Aaron
 Tomlin <atomlin@atomlin.com>, <linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao22@gmail.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH] workqueue: Fix rescuer task's name truncated
Date: Wed, 24 Apr 2024 02:21:04 +0800
Message-ID: <20240423182104.1812150-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600012.china.huawei.com (7.193.23.74)

Task comm of task is limitted to 16, prefix "kworker/R-" is added for
rescuer worker's task, which cause most task name is truncated as
following:

root   81  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xprti]
root   82  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-cfg80]
root   85  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-nfsio]
root   86  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfsal]
root   87  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfs_m]
root   88  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-acpi_]
root   93  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-iscsi]
root   95  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
root   97  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
root   99  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]

I want to fix this issue by split rescuer name to 2 part like other
kworker, the normal part is "kworker/R" which is set to task_struct's comm,
another part is wq->name which is added to kworker's desc. These 2 parts
would be merged in wq_worker_comm().

Fixes: b6a46f7263bd ("workqueue: Rename rescuer kworker")

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 kernel/workqueue.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0066c8f6c154..0ce9e8597a4d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5430,7 +5430,7 @@ static int init_rescuer(struct workqueue_struct *wq)
 	}
 
 	rescuer->rescue_wq = wq;
-	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R-%s", wq->name);
+	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R");
 	if (IS_ERR(rescuer->task)) {
 		ret = PTR_ERR(rescuer->task);
 		pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
@@ -5439,6 +5439,8 @@ static int init_rescuer(struct workqueue_struct *wq)
 		return ret;
 	}
 
+	snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);
+
 	wq->rescuer = rescuer;
 	if (wq->flags & WQ_UNBOUND)
 		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
@@ -6289,6 +6291,8 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 						  worker->desc);
 			}
 			raw_spin_unlock_irq(&pool->lock);
+		} else if (worker->desc[0] != '\0') {
+			scnprintf(buf + off, size - off, "-%s", worker->desc);
 		}
 	}
 
-- 
2.32.0


