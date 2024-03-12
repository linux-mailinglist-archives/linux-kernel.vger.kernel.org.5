Return-Path: <linux-kernel+bounces-100604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3012F879AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2CE28704C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22956139590;
	Tue, 12 Mar 2024 17:34:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFC13956C;
	Tue, 12 Mar 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264871; cv=none; b=j7QUHPEkvkofdF8yQYq/RDTG9uoFpWxj3K2etgNVeom76bQqbOcCjRTRitsXgjHYUybHI0Dw0M1yr1cc3rYan8mnjbbxjDvH2VNgDeHbI3XP2fwy3PXvEz+7qWt4KJWvHNG7FKLAGSDgNTGaeld9crSx+Cq+bKSnzqWDCvpt5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264871; c=relaxed/simple;
	bh=G61qQSbKIc/00ZL3F3yoF/s/9tEIXEVun3SaCdru6+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEnecvSIGr1uB6WhaUm0vAkewEBWjPuUlTxX31ZwCz6zRNDFFBfhb4iLlLwIid00T5vIo3GPEgybhCfAJHt6asRwxaPJ1el7umv2nYNp5MkTGRqQNLM/nPuiPjLTxyDf57j4xkOS+AJnMaZPAIc3jPvjfqgRBq+eU4mzH3W/E5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B54E015DB;
	Tue, 12 Mar 2024 10:35:06 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 847BC3F762;
	Tue, 12 Mar 2024 10:34:27 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: [PATCH 02/10] perf: Add capability for common event support
Date: Tue, 12 Mar 2024 17:34:04 +0000
Message-Id: <feb10873fe9e4e10b5ffbbe8e296c8a45632e3c2.1710257512.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1710257512.git.robin.murphy@arm.com>
References: <cover.1710257512.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many PMUs do not support common hardware/cache/etc. events and only
handle their own PMU-specific events. Since this only depends on
matching the event and PMU types, it's a prime candidate for a core
capability to save more event_init boilerplate in drivers.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..983201f21dd2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -291,6 +291,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
+#define PERF_PMU_CAP_NO_COMMON_EVENTS		0x0200
 
 struct perf_output_handle;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1..7ad80826c218 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11649,6 +11649,11 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	struct perf_event_context *ctx = NULL;
 	int ret;
 
+	/* Short-circuit if we know the PMU won't want this event */
+	if (pmu->capabilities & PERF_PMU_CAP_NO_COMMON_EVENTS &&
+	    event->attr.type != pmu->type)
+		return -ENOENT;
+
 	if (!try_module_get(pmu->module))
 		return -ENODEV;
 
-- 
2.39.2.101.g768bb238c484.dirty


