Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2180F6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377135AbjLLTjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:39:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61606A1;
        Tue, 12 Dec 2023 11:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702409958; x=1733945958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OP8Kh8R/PGKsbqJgH2vyY1FjTdW43FE57dbTsxnKgHc=;
  b=BGncVD4Hf77lLw2iBYcWwJTEvYUouDAzBn2LmZjSKcMkVmj9mjRkacfr
   98OX/xO+Fdk8FOSthevX5Pm5E3dhScEGbN+feg9U4fRQshqVAl1CMTS5u
   hLNx/CWVZ85Y8jjCr7aJyziWC6O0zmM+/7JlYwNJzBSL9juR2RIY2m+fx
   U/ryWSEFlv+6WLOMxjMYFZNwYeQC5XAwq31wPp7d4PNyjegdXI8w3TeLi
   uNU0C+dGnmjuqxQ3BHLnv/gp++qH8WAJKGCPYGo0CktUdj908d5LAC7Co
   8ak3v+iNNqObLKRPV3LBMrLSvs2O9ynyEe6mPA9zYa6qmUSUbZUv9oegu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8223342"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="8223342"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 11:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="807889787"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="807889787"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2023 11:39:17 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com
Cc:     namhyung@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2] perf top: Use evsel's cpus to replace user_requested_cpus
Date:   Tue, 12 Dec 2023 11:38:33 -0800
Message-Id: <20231212193833.415110-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

perf top errors out on a hybrid machine
 $perf top

 Error:
 The cycles:P event is not supported.

The perf top expects that the "cycles" is collected on all CPUs in the
system. But for hybrid there is no single "cycles" event which can cover
all CPUs. Perf has to split it into two cycles events, e.g.,
cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask.
If a event is opened on the unsupported CPU. The open fails. That's the
reason of the above error out.

Perf should only open the cycles event on the corresponding CPU. The
commit ef91871c960e ("perf evlist: Propagate user CPU maps intersecting
core PMU maps") intersect the requested CPU map with the CPU map of the
PMU. Use the evsel's cpus to replace user_requested_cpus.

The evlist's threads are also propagated to the evsel's threads in
__perf_evlist__propagate_maps(). For a system-wide event, perf appends
a dummy event and assign it to the evsel's threads. For a per-thread
event, the evlist's thread_map is assigned to the evsel's threads. The
same as the other tools, e.g., perf record, using the evsel's threads
when opening an event.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Update the description
- Add Reviewed-by from Ian

 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eee..cce9350177e2 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
 
 	evlist__for_each_entry(evlist, counter) {
 try_again:
-		if (evsel__open(counter, top->evlist->core.user_requested_cpus,
-				     top->evlist->core.threads) < 0) {
+		if (evsel__open(counter, counter->core.cpus,
+				counter->core.threads) < 0) {
 
 			/*
 			 * Specially handle overwrite fall back.
-- 
2.35.1

