Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2E37E474C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjKGRoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKGRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:44:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C9120;
        Tue,  7 Nov 2023 09:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699379051; x=1730915051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8APqL6kLTnsH4eX3AVkSK73CanFIhsaw4KsKL+yc3Tc=;
  b=ZMgK+n/taLFSM6pDCU/M/N/jcgeXwXD+G9rn/42Z0uBeE69MoVRtP3UU
   QmiaifDF8Cf9XwXUtTeiZWBS+kbj76d9EGUT6U9QJT/vRTKRxjnK3hMJn
   nrj1V5GfdzvY3I8kCddhjiEIdSBlSPp60cGc8EJprfN8Il1yQas3WPvny
   63mwWY2Qpm/GvM0eN1YwJGjLriWKmt/nZrsm50i0FTvnyzVoyH+ySPC0E
   m6bczo2+rsC9ES/tyNDcyH2BiP8Acj1JvUZcHulPmWOkZpZU7p6XBE6vG
   fwy4pFMf7BsbPSm8T9rUPjYiUUlFKL0hCsbc5CwHZpi5vEhFWM8HxD8v0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="393468640"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="393468640"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 09:44:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="756271088"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="756271088"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2023 09:44:10 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        tinghao.zhang@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf test: Basic branch counter support
Date:   Tue,  7 Nov 2023 09:44:11 -0800
Message-Id: <20231107174411.1496958-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add a basic test for the branch counter feature.

The test verifies that
- The new filter can be successfully applied on the supported platforms.
- The counter value can be outputted via the perf report -D

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 4fbc74805d52..2783e867c07c 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -11,6 +11,9 @@ err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 testprog="perf test -w thloop"
 testsym="test_loop"
+cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
+br_cntr_file="/caps/branch_counter_nr"
+br_cntr_output="branch stack counters"
 
 cleanup() {
   rm -rf "${perfdata}"
@@ -154,10 +157,37 @@ test_workload() {
   echo "Basic target workload test [Success]"
 }
 
+test_branch_counter() {
+  echo "Basic branch counter test"
+  # Check if the branch counter feature is supported
+  for dir in $cpu_pmu_dir
+  do
+    if [ ! -e "$dir$br_cntr_file" ]
+    then
+      echo "Not support branch counter feature [Skipped]"
+      return
+    fi
+  done
+  if ! perf record -o "${perfdata}" -j any,counter ${testprog} 2> /dev/null
+  then
+    echo "Basic branch counter test [Failed record]"
+    err=1
+    return
+  fi
+  if ! perf report -i "${perfdata}" -D -q | grep -q "$br_cntr_output"
+  then
+    echo "Basic branch record test [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Basic branch counter test [Success]"
+}
+
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
+test_branch_counter
 
 cleanup
 exit $err
-- 
2.35.1

