Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE37E4869
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjKGSk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKGSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:40:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA6F12B;
        Tue,  7 Nov 2023 10:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699382423; x=1730918423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K0VNtu18XupFGGixMLkWpky1YTjIXhLMqucmTQYHaMs=;
  b=jdj2mgk4hnFPhYu+iFSFsJQrNf5JPn0tgUzOf4YQjtkBSPi5ZAegeDrW
   iwvdRfXcTZJYLK2bEq0dDISoBespVN58lrpxWZJtL2iA/pBemD31GWS3O
   gsye/0x1bLEUbk12H6FbleRhxAoauKXHJbRagtlh1gXNBl7Afgf1+9ULW
   4thDt03ZDL4HDkJEW4w0SmUedpQG9ENjveOltNeUVFIK+eAUQ7iBytlJY
   lhAbkpD+TCeqBpJZMUJPKQNRYlM0McFL+4IQ70g2O43c0Br92GPF1q39j
   +jUTHKk8Y+aLkioC+L6YlIZWl0GZ6HsrrqPphnOrek1SUNVKsq+eldRBw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="368925010"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="368925010"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 10:40:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="739227341"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="739227341"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2023 10:40:22 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        tinghao.zhang@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2] perf test: Basic branch counter support
Date:   Tue,  7 Nov 2023 10:40:20 -0800
Message-Id: <20231107184020.1497571-1-kan.liang@linux.intel.com>
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

Changes since V2:
- Update the output msg for the skipped case (Ian)

 tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 4fbc74805d52..cc207a16ae24 100755
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
+      echo "branch counter feature not supported on all core PMUs ($dir) [Skipped]"
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

