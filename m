Return-Path: <linux-kernel+bounces-76010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E285F1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14703B2308E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7B17C72;
	Thu, 22 Feb 2024 07:29:48 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077017C66
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586988; cv=none; b=l+dmFywaI08EvXE3AbXiXYO5Z0128JYgwDCzhCdDW6kuIZIhgRJgx0ada4TA2XBb2QZ7ZdHOxULABI4t2tfg3cC6jYTWaPCcFKggjO/RSc8zTVrR4FAeF7in15C6i0tTLQCz4Ou/IurPLAn2Qyh0y3RCe4DjMATlr+5A2DBocMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586988; c=relaxed/simple;
	bh=ZewFdUzDiW9tecGSCwjtH6I1LkrKq7cYVcOWOnxt2kw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UMGsngpNZjnpSECF6QJFjX8f28vtuLo6OO6Fi49FsnPPvayr6mZHh2mw947xwLcRMEzdYd2ynRPAyd20l9H8ZlNj/1Jsgg9apf1zbLWeLWxwLNa/MikivzQwn27sydrBnET17xsnZ/PJ1TKIgSvAg+XdU31/DohsMjAx5r/g+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41M7SqTQ091900;
	Thu, 22 Feb 2024 15:28:52 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TgPrG70VJz2KL4Pp;
	Thu, 22 Feb 2024 15:28:14 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 22 Feb 2024 15:28:49 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <corbet@lwn.net>, <tj@kernel.org>
CC: <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
        <peterz@infradead.org>, <yanjiewtw@gmail.com>, <ke.wang@unisoc.com>,
        <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] workqueue: Control intensive warning threshold through cmdline
Date: Thu, 22 Feb 2024 15:28:08 +0800
Message-ID: <20240222072808.5363-1-xuewen.yan@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 41M7SqTQ091900

When CONFIG_WQ_CPU_INTENSIVE_REPORT is set, the kernel will report
the work functions which violate the intensive_threshold_us repeatedly.
And now, only when the violate times exceed 4 and is a power of 2,
the kernel warning could be triggered.

However, sometimes, even if a long work execution time occurs only once,
it may cause other work to be delayed for a long time. This may also
cause some problems sometimes.

In order to freely control the threshold of warninging, a boot argument
is added so that the user can control the warning threshold to be printed.
At the same time, keep the exponential backoff to prevent reporting too much.

By default, the warning threshold is 4.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
changes of v2:
 -Update descriptions and fix some syntax errors in documentation.
 -Use threshold to limit the warnning and keep the exponential backoff. 
---
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 kernel/workqueue.c                              | 14 +++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..cde809b22eba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7225,6 +7225,17 @@
 			threshold repeatedly. They are likely good
 			candidates for using WQ_UNBOUND workqueues instead.
 
+	workqueue.cpu_intensive_warning_thresh=<uint>
+			If CONFIG_WQ_CPU_INTENSIVE_REPORT is set, the kernel
+			will report the work functions which violate the
+			intensive_threshold_us repeatedly. In order to prevent
+			the kernel log from being printed too frequently,
+			control the frequency and the threshold.
+
+			By Default, the threshold is 4 times, and the warning
+			is limited by powers of 2. On the other hand, 0 will
+			disable the warning.
+
 	workqueue.power_efficient
 			Per-cpu workqueues are generally preferred because
 			they show better performance thanks to cache
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7b482a26d741..606ba8bf5271 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -359,6 +359,10 @@ static const char *wq_affn_names[WQ_AFFN_NR_TYPES] = {
  */
 static unsigned long wq_cpu_intensive_thresh_us = ULONG_MAX;
 module_param_named(cpu_intensive_thresh_us, wq_cpu_intensive_thresh_us, ulong, 0644);
+#ifdef CONFIG_WQ_CPU_INTENSIVE_REPORT
+static unsigned int wq_cpu_intensive_warning_thresh = 4;
+module_param_named(cpu_intensive_warning_thresh, wq_cpu_intensive_warning_thresh, uint, 0644);
+#endif
 
 /* see the comment above the definition of WQ_POWER_EFFICIENT */
 static bool wq_power_efficient = IS_ENABLED(CONFIG_WQ_POWER_EFFICIENT_DEFAULT);
@@ -1198,11 +1202,13 @@ static void wq_cpu_intensive_report(work_func_t func)
 		u64 cnt;
 
 		/*
-		 * Start reporting from the fourth time and back off
+		 * Start reporting from the warning_thresh and back off
 		 * exponentially.
 		 */
 		cnt = atomic64_inc_return_relaxed(&ent->cnt);
-		if (cnt >= 4 && is_power_of_2(cnt))
+		if (wq_cpu_intensive_warning_thresh &&
+		    cnt >= wq_cpu_intensive_warning_thresh &&
+		    is_power_of_2(cnt + 1 - wq_cpu_intensive_warning_thresh))
 			printk_deferred(KERN_WARNING "workqueue: %ps hogged CPU for >%luus %llu times, consider switching to WQ_UNBOUND\n",
 					ent->func, wq_cpu_intensive_thresh_us,
 					atomic64_read(&ent->cnt));
@@ -1231,10 +1237,12 @@ static void wq_cpu_intensive_report(work_func_t func)
 
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


