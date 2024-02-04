Return-Path: <linux-kernel+bounces-51510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0646F848C0B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CF61C21754
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437B10A35;
	Sun,  4 Feb 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D6gYpc3S"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2C10958;
	Sun,  4 Feb 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707033737; cv=none; b=FLhsu0LoMfvBsE3zk4TcMeJhrgs1TOprHiZnGOTZlRyeO9iU/695H6qd8HeQQen5ox/ZG/wWEcDb7/Maok/JtIvcRq1nShKs1DZHYf2pnPrr80XgavWCM3HJEWsmXdliwVpM0j3Zq3h/AIqNNlHL/dUZ32641omKQTE4jFcqz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707033737; c=relaxed/simple;
	bh=sUv5rFk0aEEpl0ZpdPmyX0o2IZjmXDBQ/ogddWLM6VY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMh1R27D2nPFhHquRtgYdtqP2Cp24jbeFRjZrGrwQH+6YWJ0u8ecFHEx66L7/jwtUhWUvd0BoDLCpv07zr9gQ7nZU3TejhwZZSDnw+7XuVQ3io3CYYXAhYPyYjxDWLIgIhCl8m5wwEL+qzia1WGxOaa7gxwkMndl+mKMuGaynYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D6gYpc3S; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707033727; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fnJBG1HYaP2ae74e0hOy/sgtFi6pdPcie6U/1Z9TVEk=;
	b=D6gYpc3SyRoDnRXktZQ+wQBYb7cQzTQFe4xXWVbL+r6VVAEh0ANWc+ChX2Mccgf+901sB5q1JKgI74V6IBo0bg2CcWQ6+LQwmNqHZ8ditRDVyOnl3vfDAEUPGORASn00lwWS/egHZDv6TUQNZjxcwrDlIN9Iytv58nt+7xeDuZs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0W0003Lp_1707033722;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W0003Lp_1707033722)
          by smtp.aliyun-inc.com;
          Sun, 04 Feb 2024 16:02:05 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: bp@alien8.de,
	rafael@kernel.org,
	wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com,
	mawupeng1@huawei.com,
	tony.luck@intel.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	james.morse@arm.com,
	gregkh@linuxfoundation.org,
	will@kernel.org,
	jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-edac@vger.kernel.org,
	x86@kernel.org,
	xueshuai@linux.alibaba.com,
	justin.he@arm.com,
	ardb@kernel.org,
	ying.huang@intel.com,
	ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	lenb@kernel.org,
	hpa@zytor.com,
	robert.moore@intel.com,
	lvying6@huawei.com,
	xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v11 2/3] mm: memory-failure: move return value documentation to function declaration
Date: Sun,  4 Feb 2024 16:01:43 +0800
Message-Id: <20240204080144.7977-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Part of return value comments for memory_failure() were originally
documented at the call site. Move those comments to the function
declaration to improve code readability and to provide developers with
immediate access to function usage and return information.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/core.c | 9 +--------
 mm/memory-failure.c            | 9 ++++++---
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bc39252bc54f..822b21eb48ad 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1365,17 +1365,10 @@ static void kill_me_maybe(struct callback_head *cb)
 		return;
 	}
 
-	/*
-	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
-	 * to the current process with the proper error info,
-	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
-	 *
-	 * In both cases, no further processing is required.
-	 */
 	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
 		return;
 
-	pr_err("Memory error not recovered");
+	pr_err("Sending SIGBUS to current task due to memory error not recovered");
 	kill_me_now(cb);
 }
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 636280d04008..d33729c48eff 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2175,9 +2175,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
  * Must run in process context (e.g. a work queue) with interrupts
  * enabled and no spinlocks held.
  *
- * Return: 0 for successfully handled the memory error,
- *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
- *         < 0(except -EOPNOTSUPP) on failure.
+ * Return values:
+ *   0             - success
+ *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event.
+ *   -EHWPOISON    - sent SIGBUS to the current process with the proper
+ *                   error info by kill_accessing_process().
+ *   other negative values - failure
  */
 int memory_failure(unsigned long pfn, int flags)
 {
-- 
2.39.3


