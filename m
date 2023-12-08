Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D7E80AE9A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574779AbjLHVJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjLHVJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:09:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4494A193;
        Fri,  8 Dec 2023 13:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702069754; x=1733605754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/SGOKoA+Swz5M7d9MFKFLrftb660oNkZR5QqizVC2Sk=;
  b=N/9O9tL/walmMZXDf8xP9cXNMH5vAy8Cb5YB5Ts7Plecqb/AcKxeZiLh
   4j0Ob6wllnMjmZ51yDdpdEUlCyHr0caqFEZ+PekikWcznDZKXkdrjaNfP
   wvah0O9IAzcNadby7bVw8m3tKEmkpAoJRE/LZ4/mSkkZbIw8hl4XPpvSF
   7Yr3QVmOEBxe4qR+nUBoVRrVfxdhBcKBHYS4wnTBWtqHx3y/GGoHBliPm
   +7pCRBB4MKFCGNWaH7SxNK9U7PYT36boEBhSgLloVBDX+lytcdYmcOdNR
   31h4YrVR0YX50l6brVKNLFIwvRfGcC5OFMjRUrruegC/YuWXkRRR8ddfv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="7791999"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="7791999"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 13:09:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="772261155"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="772261155"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2023 13:09:13 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com
Cc:     namhyung@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Date:   Fri,  8 Dec 2023 13:08:55 -0800
Message-Id: <20231208210855.407580-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

The user_requested_cpus may contain CPUs that are invalid for a hybrid
PMU. It causes perf_event_open to fail.

The commit ef91871c960e ("perf evlist: Propagate user CPU maps
intersecting core PMU maps") already intersect the requested CPU map
with the CPU map of the PMU. Use the evsel's cpus to replace
user_requested_cpus.

The evlist's threads is also propagated to evsel's threads in
__perf_evlist__propagate_maps(). Replace it as well.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
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

