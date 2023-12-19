Return-Path: <linux-kernel+bounces-4634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B075818024
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B5F1F242D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527FB4C8A;
	Tue, 19 Dec 2023 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBUgzV8B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E5468A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702955696; x=1734491696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AhwUmGMH6mFwdIM96UWsGqMSQLgZNex9wFQ5ll+Sjnw=;
  b=FBUgzV8BrKZXb4iz8T4vrgve4jmJzXlfqHMbkN1IU0VUis7Unu2uO5QD
   uTDbMFdGACPNTId2j/kj29NwLOg4XaZneTRt2DzOAIi3MKvzyPXRDUzfJ
   7544z4h2rSu+6pFweYO7cqVt/53bWC7nVz1XVAD8p8ja7rMl5WktPB8qS
   RI86junmoQSSXZidufWicEN/szfJlWMLSFWnBmGtoxjKrjUs2O8ODYleU
   TYLhbR654mMh8KvjUD9u81FyaQ9cZJVWjFrC2H0Ry8N+2pQAwBwaLxzCs
   BTBWTMEqwcyUNk/r7z8rsQqoXoQelxLPIrCd6cKCGBwx+De5Snhr3laCu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="426729837"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="426729837"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:14:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="17440868"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orviesa002.jf.intel.com with ESMTP; 18 Dec 2023 19:14:51 -0800
From: Feng Tang <feng.tang@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH] sched/debug: Dump end of stack when detected corrupted
Date: Tue, 19 Dec 2023 11:22:54 +0800
Message-Id: <20231219032254.96685-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When debugging a kernel hang during suspend/resume, there are random
memory corruptions in different places like being detected by scheduler
with error message:

  "Kernel panic - not syncing: corrupted stack end detected inside scheduler"

Dump the corrupted memory around the stack end will give more direct
hints about how the memory is corrupted:

 "
 Corrupted Stack: ff11000122770000: ff ff ff ff ff ff 14 91 82 3b 78 e8 08 00 45 00  .........;x...E.
 Corrupted Stack: ff11000122770010: 00 1d 2a ff 40 00 40 11 98 c8 0a ef 30 2c 0a ef  ..*.@.@.....0,..
 Corrupted Stack: ff11000122770020: 30 ff a2 00 22 3d 00 09 9a 95 2a 00 00 00 00 00  0..."=....*.....
 ...
 Kernel panic - not syncing: corrupted stack end detected inside scheduler
 "

And with it, the culprit was quickly identified to be an ethernet
driver with its DMA operations.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 kernel/sched/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a795e030678c..1280f7012bc5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5949,8 +5949,18 @@ static noinline void __schedule_bug(struct task_struct *prev)
 static inline void schedule_debug(struct task_struct *prev, bool preempt)
 {
 #ifdef CONFIG_SCHED_STACK_END_CHECK
-	if (task_stack_end_corrupted(prev))
+	if (task_stack_end_corrupted(prev)) {
+		unsigned long *ptr = end_of_stack(prev);
+
+		/* Dump 16 ulong words around the corruption point */
+#ifdef CONFIG_STACK_GROWSUP
+		ptr -= 15;
+#endif
+		print_hex_dump(KERN_ERR, "Corrupted Stack: ",
+			DUMP_PREFIX_ADDRESS, 16, 1, ptr, 16 * sizeof(*ptr), 1);
+
 		panic("corrupted stack end detected inside scheduler\n");
+	}
 
 	if (task_scs_end_corrupted(prev))
 		panic("corrupted shadow stack detected inside scheduler\n");
-- 
2.27.0


