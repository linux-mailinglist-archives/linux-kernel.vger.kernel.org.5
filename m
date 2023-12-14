Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62D881337B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573382AbjLNOqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjLNOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:46:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9415F11D;
        Thu, 14 Dec 2023 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702565209; x=1734101209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yNDl1AIWfRrLV+Gwxh9D4+zILF9whC0/B0msILdny9c=;
  b=OTFX2+/kwNA7oLgae0X1dxrrhj+m8T4ihA04GYgpa2RoXpRK4jdMZBlq
   QYnwWZcd4cXiILjpUxtGe5al5z6704UKZ12D2nZL6so62yeVKol871F0Y
   5hao1C3UWWb3MKyQjMGaBrfqoQUs7n1hK2Aid7JMZlWzoGfbpjDGfTA9F
   ywg15vvVWhvsfRx42V+WglYrrGGA2POa2iiW7aQpaM81MYyB67Hdzhbny
   PG2SPDY6q0pPWYkZtyF23qmIdRW6H74LvXLKh58ODKXASNmBUdZNORKZo
   7cnf1NWrKt70FvUk2noLLTbkbhH0aileoMXB5bRIT+eBGn5udSq8KXiZy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="16676490"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="16676490"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="22434527"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa001.jf.intel.com with ESMTP; 14 Dec 2023 06:46:45 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com
Cc:     namhyung@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 1/2] perf top: Use evsel's cpus to replace user_requested_cpus
Date:   Thu, 14 Dec 2023 06:46:11 -0800
Message-Id: <20231214144612.1092028-1-kan.liang@linux.intel.com>
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

No changes since V2

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

