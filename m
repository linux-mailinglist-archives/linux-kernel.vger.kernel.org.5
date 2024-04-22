Return-Path: <linux-kernel+bounces-153233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57448ACB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134D51C21437
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6ED1465A0;
	Mon, 22 Apr 2024 10:49:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE0145B1D;
	Mon, 22 Apr 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782983; cv=none; b=KYjZ7uqrqN21weldBTpksc1tauckMahQT8lTyfPFUqpTQxz/mJo3PXUoM7CVp6nGHwQqPTHYGUSXI2zJovkn1rscnM+GsOR45a8DxD10ryPrs33+R49kvEEDS26ZhEW+agd1ECmLhLOBNZWmwaM/LW+59VKEMP/daduEVOOuGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782983; c=relaxed/simple;
	bh=JlMo9/yymdi+OtMCepRzEEO4IMsqxHF7a01c0tOVimw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVFgFEhCLG55VndRo6AEu9DI16EstZ/XVMSr2oUx4ubk+PGY7wKEm6qgkjBPO9RW/SPIRaEN4LCWkzfozlCxqJ8siV+XQyKnh5VImJ5o/OydxydVaiYx7l6FChyieUvDz2Sb5yrgr5uuwZ/r71iMeKhFIQttWuhUmRv9YTSE2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F4913D5;
	Mon, 22 Apr 2024 03:50:10 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C605B3F7BD;
	Mon, 22 Apr 2024 03:49:39 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: ak@linux.intel.com,
	will@kernel.org,
	james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [RFC PATCH v2 2/4] perf: Allow adding fixed random jitter to the alternate sampling period
Date: Mon, 22 Apr 2024 11:49:27 +0100
Message-ID: <20240422104929.264241-3-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422104929.264241-1-ben.gainey@arm.com>
References: <20240422104929.264241-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change modifies the core perf overflow handler, adding some small
random jitter to each sample period whenever an event switches between the
two alternate sample periods. A new flag is added to perf_event_attr to
opt into this behaviour.

This change follows the discussion in [1], where it is recognized that it
may be possible for certain patterns of execution to end up with biased
results.

[1] https://lore.kernel.org/linux-perf-users/Zc24eLqZycmIg3d2@tassilo/

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 include/uapi/linux/perf_event.h |  3 ++-
 kernel/events/core.c            | 11 ++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 5c1701d091cf..dd3697a4b300 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -461,7 +461,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				jitter_alternate_period : 1, /* add a limited amount of jitter on each alternate period */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 07f1f931e18e..079ae520e836 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15,6 +15,7 @@
 #include <linux/idr.h>
 #include <linux/file.h>
 #include <linux/poll.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/hash.h>
 #include <linux/tick.h>
@@ -9546,6 +9547,8 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 	return true;
 }
 
+# define MAX_ALT_SAMPLE_PERIOD_JITTER 16
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -9573,7 +9576,10 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (event->attr.alternative_sample_period) {
 		bool using_alt = hwc->using_alternative_sample_period;
 		u64 sample_period = (using_alt ? event->attr.sample_period
-					       : event->attr.alternative_sample_period);
+					       : event->attr.alternative_sample_period)
+				  + (event->attr.jitter_alternate_period
+					? get_random_u32_below(MAX_ALT_SAMPLE_PERIOD_JITTER)
+					: 0);
 
 		hwc->sample_period = sample_period;
 		hwc->using_alternative_sample_period = !using_alt;
@@ -12503,6 +12509,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
+	if (attr.jitter_alternate_period && !attr.alternative_sample_period)
+		return -EINVAL;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR)) {
 		err = perf_allow_kernel(&attr);
-- 
2.44.0


