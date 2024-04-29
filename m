Return-Path: <linux-kernel+bounces-162569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41FB8B5D83
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A575D28664D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F783A0B;
	Mon, 29 Apr 2024 15:23:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813308121A;
	Mon, 29 Apr 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404233; cv=none; b=FPD6JtpoQ5yNTuNTKI0PfotPMBd97WYjjudKUIQQl9UupSvMIsS77rZDe+op6t1bg9T1yqlGngvXR3b42icV9nVpHCK22YmehTiLpDa4ct1nHTVB2ZY10yGhe53ffqPB/QxZmtHLsn9DHCIESSifBMB4LJQT46hRx8Pi/HhzJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404233; c=relaxed/simple;
	bh=1Za128McDTF/C8ZV/bPj12q2cashQOnFU9fLRV2wwQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ciZqtywy/p+/EvZOPGFTSY6MvqSy1GO0fCUHajkK6NqJoSWGE9jAB/9Vx3d8T4HkAavhvkvZvdOZHnhwB6okVbnOMV+jELgLRlHO0oCFSdwCP9NyVRLmzPa5y4S3BKZ66C0itRhOGosh90+0mJF6Qk7BZNyiN2d2wwI/PF/UveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4BED2F4;
	Mon, 29 Apr 2024 08:24:17 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D917C3F793;
	Mon, 29 Apr 2024 08:23:47 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	scclevenger@os.amperecomputing.com,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	mike.leach@linaro.org
Cc: James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 02/17] perf auxtrace: Allow number of queues to be specified
Date: Mon, 29 Apr 2024 16:21:47 +0100
Message-Id: <20240429152207.479221-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429152207.479221-1-james.clark@arm.com>
References: <20240429152207.479221-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently it's only possible to initialize with the default number of
queues and then use auxtrace_queues__add_event() to grow the array. But
that's problematic if you don't have a real event to pass into that
function yet.

The queues hold a void *priv member to store custom state, and for
Coresight we want to create decoders upfront before receiving data, so
add a new function that allows pre-allocating queues. One reason to do
this is because we might need to store metadata (HW_ID events) that
effects other queues, but never actually receive auxtrace data on that
queue.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/auxtrace.c | 9 +++++++--
 tools/perf/util/auxtrace.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 3684e6009b63..563b6c4fca31 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -218,15 +218,20 @@ static struct auxtrace_queue *auxtrace_alloc_queue_array(unsigned int nr_queues)
 	return queue_array;
 }
 
-int auxtrace_queues__init(struct auxtrace_queues *queues)
+int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues)
 {
-	queues->nr_queues = AUXTRACE_INIT_NR_QUEUES;
+	queues->nr_queues = nr_queues;
 	queues->queue_array = auxtrace_alloc_queue_array(queues->nr_queues);
 	if (!queues->queue_array)
 		return -ENOMEM;
 	return 0;
 }
 
+int auxtrace_queues__init(struct auxtrace_queues *queues)
+{
+	return auxtrace_queues__init_nr(queues, AUXTRACE_INIT_NR_QUEUES);
+}
+
 static int auxtrace_queues__grow(struct auxtrace_queues *queues,
 				 unsigned int new_nr_queues)
 {
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 55702215a82d..8a6ec9565835 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -521,6 +521,7 @@ int auxtrace_mmap__read_snapshot(struct mmap *map,
 				 struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size);
 
+int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues);
 int auxtrace_queues__init(struct auxtrace_queues *queues);
 int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 			       struct perf_session *session,
-- 
2.34.1


