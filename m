Return-Path: <linux-kernel+bounces-26289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A88182DE1C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4761C21E63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A73318643;
	Mon, 15 Jan 2024 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8LhiVe3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079531805A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705338100; x=1736874100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tuXsnLpj2x6E0qxbdbl5zZtSQpYNIsi1oslLdV3rXHU=;
  b=n8LhiVe3SzGVt9nn0Fx+Mccn6RQNc8jOCp0P2z/H/EJ5T4W1R24SgmFj
   f4xWDC6cU80zfXdV1rfxBhQRxlM9iPOUlH379Oj2t87ywMXo4w4iYILtH
   096yHLdLrBEObRCt/4BBF42tBv7zwf4WeAC6ez+xWy2f5+a052IzzW8CK
   Q4FEYXjxkbZRf7CHcoCea9PgsJyG/fwgpXRiwA4JFODzXxUJs18TriN0T
   I3GkFMza6KM/tGu11mxRA0aThJibuVXKUb6uGjZA+c6XHLrXVc6yL4MH/
   ifg+jB+1aV5+F6GZvWMxRxnDZhDNFpU4L0duifHR6qf05RxbQ5A2IjJCB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6408206"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="6408206"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="907101354"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="907101354"
Received: from mleonvig-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.223.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:01:37 -0800
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	tvrtko.ursulin@linux.intel.com
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Subject: [RFC 3/3] perf: Reference count struct perf_cpu_pmu_context to fix driver unbind
Date: Mon, 15 Jan 2024 17:01:20 +0000
Message-Id: <20240115170120.662220-4-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240115170120.662220-1-tvrtko.ursulin@linux.intel.com>
References: <20240115170120.662220-1-tvrtko.ursulin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

If a PMU driver is a PCI driver which can be unbound at runtime there is
currently an use after free issue with CPU contexts when an active perf fd
is kept around.

Specifically, when perf_pmu_unregister() calls free_pmu_context() on the
PMU provided per cpu struct perf_cpu_pmu_context storage, any call path
which ends up in event_sched_out() (such as __perf_remove_from_context()
via perf_event_release_kernel()) will dereference a freed event->pmu_ctx.
Furthermore if the same percpu area has in the meantime been re-allocated,
the use after free will corrupt someone elses per cpu storage area.

To fix it we attempt to add reference counting to struct
perf_cpu_pmu_context such that the object remains until the last user
is done with it.

TODO/FIXME/QQQ:

1)

I am really not sure about the locking here. I *think* I needed a per
struct pmu counter and by looking at what find_get_pmu_context does when
it takes a slot from driver provided pmu->cpu_pmu_context under the
ctx->lock, it looked like that should be sufficient. Maybe even if not
atomic_t. Or maybe ctx->lock is not enough.

2)

I believe pmu->pmu_disable_count will need a similar treatment, but as
I wasn't sure of the locking model, or even if this all makes sense on
the high level I left it out for now. Like does the idea to reference
count even flies or a completely different solution will be needed.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a567d2d98be1..bd1c8f3c1736 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -317,6 +317,7 @@ struct pmu {
 
 	int __percpu			*pmu_disable_count;
 	struct perf_cpu_pmu_context __percpu *cpu_pmu_context;
+	atomic_t 			cpu_pmu_context_refcount;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
 	int				hrtimer_interval_ms;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4b62d2201ca7..0c95aecf560a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4873,6 +4873,9 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 			atomic_inc(&epc->refcount);
 		}
 		raw_spin_unlock_irq(&ctx->lock);
+
+		atomic_inc(&pmu->cpu_pmu_context_refcount);
+
 		return epc;
 	}
 
@@ -4928,6 +4931,12 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 	return epc;
 }
 
+static void put_pmu_context(struct pmu *pmu)
+{
+	if (atomic_dec_and_test(&pmu->cpu_pmu_context_refcount))
+		free_percpu(pmu->cpu_pmu_context);
+}
+
 static void get_pmu_ctx(struct perf_event_pmu_context *epc)
 {
 	WARN_ON_ONCE(!atomic_inc_not_zero(&epc->refcount));
@@ -4967,8 +4976,10 @@ static void put_pmu_ctx(struct perf_event_pmu_context *epc)
 
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
-	if (epc->embedded)
+	if (epc->embedded) {
+		put_pmu_context(epc->pmu);
 		return;
+	}
 
 	call_rcu(&epc->rcu_head, free_epc_rcu);
 }
@@ -11347,11 +11358,6 @@ static int perf_event_idx_default(struct perf_event *event)
 	return 0;
 }
 
-static void free_pmu_context(struct pmu *pmu)
-{
-	free_percpu(pmu->cpu_pmu_context);
-}
-
 /*
  * Let userspace know that this PMU supports address range filtering:
  */
@@ -11573,6 +11579,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		pmu->event_idx = perf_event_idx_default;
 
 	list_add_rcu(&pmu->entry, &pmus);
+	atomic_set(&pmu->cpu_pmu_context_refcount, 1);
 	atomic_set(&pmu->exclusive_cnt, 0);
 	ret = 0;
 unlock:
@@ -11615,7 +11622,7 @@ void perf_pmu_unregister(struct pmu *pmu)
 		device_del(pmu->dev);
 		put_device(pmu->dev);
 	}
-	free_pmu_context(pmu);
+	put_pmu_context(pmu);
 	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
-- 
2.40.1


