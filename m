Return-Path: <linux-kernel+bounces-117670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526CC88AE47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76901F6738E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC7F12E4D;
	Mon, 25 Mar 2024 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JZC9nEiQ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492DA5223
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389733; cv=none; b=S3plvdBt8x24pcjgMwO1xFPyI+hr4NueVXWvylBgnqGaSPFY0d8sRIB/toJX9W5UFlQwqmVO2UIzfL7uk9h/DIVTQV///wu+0L0AzhMcUEhV6IZuBKRayaNuQLxV1EMUMqo8fqjDmY8CDQtTNa7OcUbkdQanIiRFeXZUJGd57gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389733; c=relaxed/simple;
	bh=ZJFsZAjUBWjMPreURlut2McqDHfGMz4gcUdv14i9EXs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FAdJ5Y7nExXM2tIniuUkFRDNkn14H4hFtPPMHalweNabm98HIR6bs9TcLRd9eN+A93BgyWBMWIL08B8dUQjLbXf1DDyibGuMcwgrKFCWeGtAANHsqoapslRS8e6/t9sJzfD3xvP7eYhakP3xcLgoe5lXiXZmwHv0K0XBRMHRGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JZC9nEiQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id BA76B20B74C2;
	Mon, 25 Mar 2024 11:02:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA76B20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711389729;
	bh=mO7tGr8n+9xjaTYc0BbXvWebsjvFHiUW78pERIlGG1c=;
	h=From:To:Cc:Subject:Date:From;
	b=JZC9nEiQT7voCu6LqTTN2Fml6prJ+ImItupExOuyAf9XT6rVk9PmNAIpv5+W0/yzL
	 b8Pc6Hq9PYoqN7iyNt6a7MVjgc0QDVsoQcIE5AoGiyLKegPNvcsa1gYZ3Ufhk2vTRj
	 kB3o9hvxdX5diy7fIp72FcsBHAtj8r47TraiA+Uk=
From: Allen Pais <apais@linux.microsoft.com>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernel: Introduce enable_and_queue_work() convenience function
Date: Mon, 25 Mar 2024 18:02:01 +0000
Message-Id: <20240325180201.6027-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The enable_and_queue_work() function is introduced to streamline
the process of enabling and queuing a work item on a specific
workqueue. This function combines the functionalities of
enable_work() and queue_work() in a single call, providing a
concise and convenient API for enabling and queuing work items.

The function accepts a target workqueue and a work item as parameters.
It first attempts to enable the work item using enable_work(). A successful
enable operation means that the work item was previously disabled
and is now marked as eligible for execution. If the enable operation
is successful, the work item is then queued on the specified workqueue
using queue_work(). The function returns true if the work item was
successfully enabled and queued, and false otherwise.

Note: This function may lead to unnecessary spurious wake-ups in cases
where the work item is expected to be dormant but enable/disable are called
frequently. Spurious wake-ups refer to the condition where worker threads
are woken up without actual work to be done. Callers should be aware of
this behavior and may need to employ additional synchronization mechanisms
to avoid these overheads if such wake-ups are not desired.

This addition aims to enhance code readability and maintainability by
providing a unified interface for the common use case of enabling and
queuing work items on a workqueue.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 include/linux/workqueue.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index aedfb81f9c49..a8d8b015d729 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -678,6 +678,37 @@ static inline bool schedule_work(struct work_struct *work)
 	return queue_work(system_wq, work);
 }
 
+/**
+ * enable_and_queue_work - Enable and queue a work item on a specific workqueue
+ * @wq: The target workqueue
+ * @work: The work item to be enabled and queued
+ *
+ * This function attempts to enable the specified work item using enable_work().
+ * A successful enable operation means that the work item was previously disabled
+ * and is now marked as eligible for execution. After successfully enabling the work,
+ * the work item is then queued on the specified workqueue using queue_work().
+ * It returns %true if the work item was successfully enabled and queued,
+ * and %false otherwise.
+ *
+ * Note: Enabling and queuing work may lead to unnecessary spurious wake-ups if the
+ * work item is already queued or currently being processed. Spurious wake-ups refer
+ * to waking up worker threads without actual work to be done. Callers should be aware
+ * of this behavior and, if it is not desired, take measures to prevent it, such as
+ * checking the state of the work item before attempting to enable and queue it.
+ *
+ * This function combines the operations of enable_work() and queue_work(),
+ * providing a convenient way to enable and queue a work item in a single call.
+ */
+static inline bool enable_and_queue_work(struct workqueue_struct *wq,
+					 struct work_struct *work)
+{
+	if (enable_work(work)) {
+		queue_work(wq, work);
+		return true;
+	}
+	return false;
+}
+
 /*
  * Detect attempt to flush system-wide workqueues at compile time when possible.
  * Warn attempt to flush system-wide workqueues at runtime.
-- 
2.17.1


