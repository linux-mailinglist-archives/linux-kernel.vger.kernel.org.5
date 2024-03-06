Return-Path: <linux-kernel+bounces-94136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E0873A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066571F2C23B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52660134724;
	Wed,  6 Mar 2024 15:11:47 +0000 (UTC)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0228EC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737906; cv=none; b=oMGVNv3o38BUuwNmyCyHC14eWXylZTiWw50z07YkWz8jARHLbAuWD9Jg1rs4ttv3uVm4P0cfcB5yzBiPyaXIVlwB9+AikA8aWPcj/ZHhh23lr3dnGyw/KW4nehsQh3tAu1ThYvu3g8JjZGv3EaaIRCdz+w4vXSgabanb8ZsH98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737906; c=relaxed/simple;
	bh=uKasaggYyymUs6qBZv4V07v1uNFlEBuf7STPeXfV9nc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GmyC+I7eFllLkHMKcW7O7Pt+emiobtXOVW+YltMoYg5oabGOcVZu58L4rboC6LPUEj3ehcUJMapIFhsUQgXQgQm2BfwzgrvU3HG5paB0+ZS7+g0Q5ii+KT6RQUBGkpE9o2+PSITzBvrooB4uoIgF7nh8ww9pDIEUEE1xg5HOJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp90t1709737615t5wfynxx
X-QQ-Originating-IP: bY9xEtJbLzmEQY5vLSrN13Ffer26Gmy6nNa4BoNZRsU=
Received: from HX01040022.powercore.com.cn ( [39.144.153.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Mar 2024 23:06:52 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: SGbEDZt3ZyZPyzccUHOvFC9Mp1nj4kwhx4l6Eis6fDtGrbCYOFxO2r/6il5QT
	1eEtdSR1ESETfHwFHGWi2/4t8GRz13TUXzV7z4OXUQBFDl1/q0DUxY8gIXYNRX/gCQ+gFbU
	Ip0RHI0ryTI/36a92YDwmOwCZ0XYkWCNM+QH74eogT4iEdN0l653IFlacPecmSA0W4XHheZ
	VZuk1E3hHqTmm9EIPmYXxzSWqf817WY6DKHNkTgMcOM8qEttFn2H17kxg/isdWiPofh9UYC
	jshgM/ijDQzWdHNyhyyxPZ+d+mj44XNx4abBZqEeLCwlMbkdLAps97T9o1H0RpYtn6qxrVx
	Nob0NFoulsW2eNmCZTg6/KwFbxW0XQLtPmV3Y3CSG+Vv72E5LC0XeHmbw0n7g==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 264853607128593426
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: Handle generic events normally instead of trying all pmu
Date: Wed,  6 Mar 2024 23:10:15 +0800
Message-Id: <20240306151017.2114-1-jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

We have pay more effort on handling generic events. We treat them
specially caused us paying more. Now time have told us that PMU type
between 0 and PERF_TYPE_MAX only corresponds to one PMU. So we can
handle the special when registering PMU not in event opening. And we
can know which PMU is used to the generic event.

The added capabilities PERF_PMU_CAP_EVENT_HARDWARE and
PERF_PMU_CAP_EVENT_HW_CACHE will alloc idr for PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE with same PMU.

We'd better handle uncore-task event before calling pmu->event_init().

The code is compatible with PERF_PMU_TYPE_SHIFT.
/*
 * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
 * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
 *					AA: hardware event ID
 *					EEEEEEEE: PMU type ID
 * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
 *					BB: hardware cache ID
 *					CC: hardware cache op ID
 *					DD: hardware cache op result ID
 *					EEEEEEEE: PMU type ID
 * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
 */

But the drivers have to give the corresponding capabilities obviously.

Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
---
 include/linux/perf_event.h |  4 +-
 kernel/events/core.c       | 83 +++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..edf4365ab7cc 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -290,7 +290,9 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_ITRACE			0x0020
 #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
-#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
+#define PERF_PMU_CAP_EVENT_HARDWARE             0x0100
+#define PERF_PMU_CAP_EVENT_HW_CACHE             0x0200
+#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0300
 
 struct perf_output_handle;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1..02f14ae09d09 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11516,6 +11516,7 @@ static struct lock_class_key cpuctx_lock;
 int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 {
 	int cpu, ret, max = PERF_TYPE_MAX;
+	int cap = pmu->capabilities;
 
 	mutex_lock(&pmus_lock);
 	ret = -ENOMEM;
@@ -11523,7 +11524,6 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->pmu_disable_count)
 		goto unlock;
 
-	pmu->type = -1;
 	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
 		ret = -EINVAL;
 		goto free_pdc;
@@ -11538,15 +11538,34 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (ret < 0)
 		goto free_pdc;
 
+	/*
+	 * Ensure one type ([0, PERF_TYPE_MAX)) correspond to one PMU.
+	 */
 	WARN_ON(type >= 0 && ret != type);
 
 	type = ret;
 	pmu->type = type;
 
+	if ((type != PERF_TYPE_HARDWARE) &&
+	    (cap & PERF_PMU_CAP_EVENT_HARDWARE)) {
+		ret = idr_alloc(&pmu_idr, pmu, PERF_TYPE_HARDWARE,
+				PERF_TYPE_HARDWARE + 1, GFP_KERNEL);
+		if (ret < 0)
+			goto free_idr;
+	}
+
+	if ((type != PERF_TYPE_HW_CACHE) &&
+	    (cap & PERF_PMU_CAP_EVENT_HW_CACHE)) {
+		ret = idr_alloc(&pmu_idr, pmu, PERF_TYPE_HW_CACHE,
+				PERF_TYPE_HW_CACHE + 1, GFP_KERNEL);
+		if (ret < 0)
+			goto free_idr_hw;
+	}
+
 	if (pmu_bus_running && !pmu->dev) {
 		ret = pmu_dev_alloc(pmu);
 		if (ret)
-			goto free_idr;
+			goto free_idr_hw_cache;
 	}
 
 	ret = -ENOMEM;
@@ -11604,6 +11623,14 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		put_device(pmu->dev);
 	}
 
+free_idr_hw_cache:
+	if (cap & PERF_PMU_CAP_EVENT_HW_CACHE)
+		idr_remove(&pmu_idr, PERF_TYPE_HW_CACHE);
+
+free_idr_hw:
+	if (cap & PERF_PMU_CAP_EVENT_HARDWARE)
+		idr_remove(&pmu_idr, PERF_TYPE_HARDWARE);
+
 free_idr:
 	idr_remove(&pmu_idr, pmu->type);
 
@@ -11648,6 +11675,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 {
 	struct perf_event_context *ctx = NULL;
 	int ret;
+	bool uncore_pmu = false, extded_pmu = false;
 
 	if (!try_module_get(pmu->module))
 		return -ENODEV;
@@ -11668,6 +11696,20 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		BUG_ON(!ctx);
 	}
 
+	if (perf_invalid_context == pmu->task_ctx_nr)
+		uncore_pmu = true;
+
+	if (pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)
+		extded_pmu = true;
+
+	/* Disallow uncore-task events. */
+	if (uncore_pmu && (event->attach_state & PERF_ATTACH_TASK))
+		return -EINVAL;
+
+	/* Ensure pmu not supporting generic events will not be passed such event. */
+	if (!extded_pmu && (event->attr.type & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+		return -EINVAL;
+
 	event->pmu = pmu;
 	ret = pmu->event_init(event);
 
@@ -11695,7 +11737,6 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 
 static struct pmu *perf_init_event(struct perf_event *event)
 {
-	bool extended_type = false;
 	int idx, type, ret;
 	struct pmu *pmu;
 
@@ -11720,36 +11761,15 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	 * are often aliases for PERF_TYPE_RAW.
 	 */
 	type = event->attr.type;
-	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
-		type = event->attr.config >> PERF_PMU_TYPE_SHIFT;
-		if (!type) {
-			type = PERF_TYPE_RAW;
-		} else {
-			extended_type = true;
-			event->attr.config &= PERF_HW_EVENT_MASK;
-		}
-	}
+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
+		event->attr.config &= PERF_HW_EVENT_MASK;
 
-again:
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
-	if (pmu) {
-		if (event->attr.type != type && type != PERF_TYPE_RAW &&
-		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-			goto fail;
 
-		ret = perf_try_init_event(pmu, event);
-		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
-			type = event->attr.type;
-			goto again;
-		}
-
-		if (ret)
-			pmu = ERR_PTR(ret);
-
-		goto unlock;
-	}
+	if (!pmu || perf_try_init_event(pmu, event))
+		goto fail;
 
 	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
 		ret = perf_try_init_event(pmu, event);
@@ -12026,11 +12046,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	/*
-	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
-	 * events (they don't make sense as the cgroup will be different
-	 * on other CPUs in the uncore mask).
+	 * Disallow uncore-cgroup events (they don't make sense
+	 * as the cgroup will be different on other CPUs in the uncore mask).
 	 */
-	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
+	if (task || cgroup_fd != -1) {
 		err = -EINVAL;
 		goto err_pmu;
 	}
-- 
2.25.1


