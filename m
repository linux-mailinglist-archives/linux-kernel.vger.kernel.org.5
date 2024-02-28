Return-Path: <linux-kernel+bounces-85523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F26886B708
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FD61F2682A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C940862;
	Wed, 28 Feb 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aJKdUie4"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBE34084C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144339; cv=none; b=MIe7fzFvli5hfc8KeJPHbcA5wMeiGZDcOh3dvBkwhjSy90HJtRV/ch697rdszFoTdPPbIHFpLwSpKJEfIFLxNULufEyCj2aOjTV9N3LXYVrCax4NhuQ/i/tGgg9bCXjp5km4xT+ehhIKQ/GrvN6gbYWmMNbGNCaj6dBgGRr2LB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144339; c=relaxed/simple;
	bh=ctQuxA/YbpcInqTpD6+LUKnEtN3IvRYl52XsonnTBRw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=N7l1fRtOzcH2TKUbPqGlIWj7/EzwDHBz6Qr7RIl5fm+KPSWNRjVHek4lB23ICRXgfJCx9p5MTuXeW3WADSIyd7BZvOuWA3pjBoI886qFzZA8HUk3vES2fgozX/tdzp2UPJeEfS/UuQgxT2Ph2FWX9kMjC/BPTvHftGw3Z3TzhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aJKdUie4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7357E20B74C0;
	Wed, 28 Feb 2024 10:18:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7357E20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709144337;
	bh=yYZPAWRso4kZ0IbrwPw0ArpV7c3Fq15yCkQN2Ac6BqQ=;
	h=From:To:Cc:Subject:Date:From;
	b=aJKdUie4ndiI+3TiPDgJ2JFkI1p84w+PHi++1EUxFy5pgJlfjYP6f64Cvi5HvZ9e6
	 JJOTsAmJuHY+uli/YfEZc2r18f82up0hLmHDweFvDU2kfmalLCchD6fiOq/eMjBKor
	 aDe0VRqoDGWUExmgCzjs67uw1aSy26Nrb/sEQSII=
From: Allen Pais <apais@linux.microsoft.com>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: Introduce enable_and_queue_work() convenience function
Date: Wed, 28 Feb 2024 18:18:50 +0000
Message-Id: <20240228181850.5895-1-apais@linux.microsoft.com>
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
It first attempts to enable the work item using enable_work(). If the
enable operation is successful, the work item is then queued on the
specified workqueue using queue_work(). The function returns true if
the work item was successfully enabled and queued, and false otherwise.

This addition aims to enhance code readability and maintainability by
providing a unified interface for the common use case of enabling and
queuing work items on a workqueue.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 include/linux/workqueue.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index aedfb81f9c49..31bbd38ef8c8 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -678,6 +678,29 @@ static inline bool schedule_work(struct work_struct *work)
 	return queue_work(system_wq, work);
 }
 
+/**
+ * enable_and_queue_work - Enable and queue a work item on a specific workqueue
+ * @wq: The target workqueue
+ * @work: The work item to be enabled and queued
+ *
+ * This function attempts to enable the specified work item using enable_work().
+ * If the enable operation is successful, the work item is then queued on the
+ * provided workqueue using queue_work(). It returns %true if the work item was
+ * successfully enabled and queued, and %false otherwise.
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


