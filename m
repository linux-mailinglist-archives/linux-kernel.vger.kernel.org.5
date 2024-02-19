Return-Path: <linux-kernel+bounces-70865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0905F859D70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48200B2177F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F971210E0;
	Mon, 19 Feb 2024 07:47:46 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE420DF4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328866; cv=none; b=h0nRIHJWV5lck8olfzplnQCSH0iEvkv2b8KfzVjSbyatB2Nhk379aI4E7nytJat0bW1RMJEGFfQjyEHNjj0USzFDhyqQS9VHH3nYiUerxe9lLG2tbsriTrCVFIak0fGwVNDBpajNTI/8HsJrd8S4gkLgNNYAo/FZGIEqKrF2HbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328866; c=relaxed/simple;
	bh=ewsDsPkbeobOE48ZRHp1eMRBk4DRcJdny5eRpEC1R6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V/LS9qSsHGj2joBhy3CximfAYwYUWu2sC7bvv58GsRrbkc5l/AUBpwvRVOIb8pkXre4ejv8D3UIFZlmgs34e3lbTtFg10lOGaKrfmKH1XlgCH0jzw1U+oZZs325gL9hBGHrqWHjo+qasn+26uVH9ow4vI+Lp2QEwUm6RRMJBWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41J7kfiO037258;
	Mon, 19 Feb 2024 15:46:41 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TdZNL0c0lz2KCvlD;
	Mon, 19 Feb 2024 15:46:10 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 19 Feb 2024 15:46:39 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <tj@kernel.org>, <jiangshanlai@gmail.com>, <corbet@lwn.net>
CC: <paulmck@kernel.org>, <rdunlap@infradead.org>, <peterz@infradead.org>,
        <yanjiewtw@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [PATCH] workqueue: Control the frequency of intensive warning through cmdline
Date: Mon, 19 Feb 2024 15:46:34 +0800
Message-ID: <20240219074634.2039-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 41J7kfiO037258

When CONFIG_WQ_CPU_INTENSIVE_REPORT is set, the kernel will report
the work functions which violate the intensive_threshold_us repeatedly.
And now, only when the violate times exceed 4 and is a power of 2,
the kernel warning could be triggered.

However, sometimes we want to print the warning every time when the work
executed too long. Because sometimes, even if a long work execution time
occurs only once, it may cause other work to be delayed for a long time.

In order to freely control the frequency of printing, a boot argument
is added so that the user can control the warning to be printed
only after a certain number of work timeouts.

Default, it would print warning every 4 times.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 kernel/workqueue.c                              | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..599fc59fcf70 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7225,6 +7225,15 @@
 			threshold repeatedly. They are likely good
 			candidates for using WQ_UNBOUND workqueues instead.
 
+	workqueue.cpu_intensive_warning_per_count=
+			If CONFIG_WQ_CPU_INTENSIVE_REPORT is set, the kernel
+			will report the work functions which violate the
+			intensive_threshold_us repeatedly. In order to prevent
+			the kernel log from being printed too frequently.
+			Control the frequency.
+
+			Default, it will print one warning per 4 times.
+
 	workqueue.power_efficient
 			Per-cpu workqueues are generally preferred because
 			they show better performance thanks to cache
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7b482a26d741..8e8cccf5329a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -359,6 +359,10 @@ static const char *wq_affn_names[WQ_AFFN_NR_TYPES] = {
  */
 static unsigned long wq_cpu_intensive_thresh_us = ULONG_MAX;
 module_param_named(cpu_intensive_thresh_us, wq_cpu_intensive_thresh_us, ulong, 0644);
+#ifdef CONFIG_WQ_CPU_INTENSIVE_REPORT
+static unsigned int wq_cpu_intensive_warning_per_count = 4;
+module_param_named(cpu_intensive_warning_per_count, wq_cpu_intensive_warning_per_count, uint, 0644);
+#endif
 
 /* see the comment above the definition of WQ_POWER_EFFICIENT */
 static bool wq_power_efficient = IS_ENABLED(CONFIG_WQ_POWER_EFFICIENT_DEFAULT);
@@ -1202,7 +1206,7 @@ static void wq_cpu_intensive_report(work_func_t func)
 		 * exponentially.
 		 */
 		cnt = atomic64_inc_return_relaxed(&ent->cnt);
-		if (cnt >= 4 && is_power_of_2(cnt))
+		if (wq_cpu_intensive_warning_per_count && !(cnt % wq_cpu_intensive_warning_per_count))
 			printk_deferred(KERN_WARNING "workqueue: %ps hogged CPU for >%luus %llu times, consider switching to WQ_UNBOUND\n",
 					ent->func, wq_cpu_intensive_thresh_us,
 					atomic64_read(&ent->cnt));
@@ -1231,10 +1235,12 @@ static void wq_cpu_intensive_report(work_func_t func)
 
 	ent = &wci_ents[wci_nr_ents++];
 	ent->func = func;
-	atomic64_set(&ent->cnt, 1);
+	atomic64_set(&ent->cnt, 0);
 	hash_add_rcu(wci_hash, &ent->hash_node, (unsigned long)func);
 
 	raw_spin_unlock(&wci_lock);
+
+	goto restart;
 }
 
 #else	/* CONFIG_WQ_CPU_INTENSIVE_REPORT */
-- 
2.25.1


