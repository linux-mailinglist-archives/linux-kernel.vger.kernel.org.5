Return-Path: <linux-kernel+bounces-131560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880189898F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F491C2264C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4512AAED;
	Thu,  4 Apr 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xi5mLNp5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53B1292FC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239666; cv=none; b=AbhxCK+mAtyG7zodnUM5jQgi5SNgD2OYAnOWC2pifr9AY4SOvoz2QhY33FLfxRkcQomSwHNPeR2m3Vb+pldynYIHJrvdSe4mw84IA0Boo2tTuGKh3zqm+PY1b8Ttq2OFUYBB63pjxRo7qY+hQCgTOkcyOzkhtbOt6JAp9PUIz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239666; c=relaxed/simple;
	bh=BVXkXJecaA0EQTyQSqb/PRF3aJ3g+11gW4kk1+RxAWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQbzbiM4ewXMczxyYPz7vMg/JVTU1Os3vQ+N7imFMYjLa68u56S9j+bRbhRX+Ly+ychx85himrs8kyQFbFvWpfwmLAve4hkzAK+JwDjncNqJv5esTY6k4Fc6DtQ7dE89a4NUitNYobZ4RUnwcVELfHmjXmCompUC9WXObfQgP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xi5mLNp5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239665; x=1743775665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BVXkXJecaA0EQTyQSqb/PRF3aJ3g+11gW4kk1+RxAWA=;
  b=Xi5mLNp531tISMSu/8NB5Faxt323NFTR0LqsOVOLt2hSxUgpMXs5i5Qo
   K0SASqr+2+erx8xhugBoRdSs/LwLvDSdqynTYS5olMy9qwzn28f0JrOeh
   eRm/r4CyJ14xwWyiUkRhH/9GhwGQdBaUByifrFsC8nfEiTwnuTQc74EbN
   JJB5bxxNp6Sqx7Q7CGsl83KeJhlojDMbfx7erBOv8cxftEeo3AZUCHF0l
   5BmAme+G2Vc7fClaV0pGiQ5fVxfF7+fiqrFtYJjkhAiR1dfDr7+mpXeSx
   GU+2arWgvY+JTNUzyjq98j7+baEXOE0niAwrcYil4KP3C+DzgWz3NF6Td
   w==;
X-CSE-ConnectionGUID: KCk/ZrVpRJOEmMW2C1yiog==
X-CSE-MsgGUID: mVdnp0qHTPuoy0uVCameyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346525"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346525"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:44 -0700
X-CSE-ConnectionGUID: wODgWHdoR8qpEfOtvS08xQ==
X-CSE-MsgGUID: g4id8G13TNCPB4g758myWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258881"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:44 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 05/12] perf/x86: Add config_mask to represent EVENTSEL bitmask
Date: Thu,  4 Apr 2024 07:06:30 -0700
Message-Id: <20240404140637.1232635-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240404140637.1232635-1-kan.liang@linux.intel.com>
References: <20240404140637.1232635-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Different vendors may support different fields in EVENTSEL MSR, such as
Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
used to filter the attr.config.

Introduce a new config_mask to record the real supported EVENTSEL
bitmask.
Only apply it to the existing code now. No functional change.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 5 ++++-
 arch/x86/events/intel/core.c | 1 +
 arch/x86/events/perf_event.h | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 08c31f48cead..f692e7fba740 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -624,7 +624,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 		event->hw.config |= ARCH_PERFMON_EVENTSEL_OS;
 
 	if (event->attr.type == event->pmu->type)
-		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
+		event->hw.config |= x86_pmu_get_event_config(event);
 
 	if (event->attr.sample_period && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
@@ -2097,6 +2097,9 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.intel_ctrl)
 		x86_pmu.intel_ctrl = x86_pmu.cntr_mask64;
 
+	if (!x86_pmu.config_mask)
+		x86_pmu.config_mask = X86_RAW_EVENT_MASK;
+
 	perf_events_lapic_init();
 	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 16b4efdad03e..bbb98b4c2a84 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6151,6 +6151,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 		pmu->cntr_mask64 = x86_pmu.cntr_mask64;
 		pmu->fixed_cntr_mask64 = x86_pmu.fixed_cntr_mask64;
 		pmu->pebs_events_mask = intel_pmu_pebs_mask(pmu->cntr_mask64);
+		pmu->config_mask = X86_RAW_EVENT_MASK;
 		pmu->unconstrained = (struct event_constraint)
 				     __EVENT_CONSTRAINT(0, pmu->cntr_mask64,
 							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3a65bfbb1173..4e448696bf96 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -695,6 +695,7 @@ struct x86_hybrid_pmu {
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
 	u64				pebs_events_mask;
+	u64				config_mask;
 	union {
 			u64		cntr_mask64;
 			unsigned long	cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
@@ -790,6 +791,7 @@ struct x86_pmu {
 	int		(*rdpmc_index)(int index);
 	u64		(*event_map)(int);
 	int		max_events;
+	u64		config_mask;
 	union {
 			u64		cntr_mask64;
 			unsigned long	cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
@@ -1231,6 +1233,11 @@ static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
 	return hweight64(hybrid(pmu, fixed_cntr_mask64));
 }
 
+static inline u64 x86_pmu_get_event_config(struct perf_event *event)
+{
+	return event->attr.config & hybrid(event->pmu, config_mask);
+}
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
-- 
2.35.1


