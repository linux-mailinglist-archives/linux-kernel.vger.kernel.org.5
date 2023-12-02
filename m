Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD89C8018BB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442006AbjLBAKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbjLBAKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:10:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EDB386F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:09:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4343FC433CB;
        Sat,  2 Dec 2023 00:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475692;
        bh=RPGqDNVbRfHZdHfv52ZXw/68V6PB6K+dkXKHSqnAU/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eS0GQJL0HFbLi29VHlV8HHJ66TzvYLdR6ptWgktTsJ+ve9HpARkVXJ/lTBvWM6PZ0
         PcWeIAFDosQS6fItHLeCOtbITCASeM/mpK+1bIDecMd3ZDk/GHSdwSI8rnxo4RmEM6
         /owzTnEWigKz9PIuqsPveep8ynF6jpKJAPEq+17cmIjo57c/pnE1yffaPTz36+nU3y
         OovjM/a6n6c2AdBjkFzAk9sPQdD0WWldR607zXYsbdhafadiPe8M1QDMtrlJrVqFvq
         k2Ig07layGEKD0GjJSSonWptIfJPglIdFsIUjlUhxMw+0sxb4t6zaS7yXbnIipwjtx
         r0vwISU4ttEjg==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] selftests/damon: add a test for update_schemes_tried_regions sysfs command
Date:   Sat,  2 Dec 2023 00:08:05 +0000
Message-Id: <20231202000806.46210-5-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202000806.46210-1-sj@kernel.org>
References: <20231202000806.46210-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic test for verifying accuracy of DAMON's access monitoring
functionality.  The test starts a program of artificial access pattern,
monitor the accesses using DAMON, and check if DAMON gets working set
size with reasonable amount of error rate.  Note that the acceptable
error rate is set with only a naive assumption.  Failure of this test
may not always mean DAMON is broken, and we could adjust it in future.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  2 +
 tools/testing/selftests/damon/access_memory.c | 41 ++++++++++++++++
 ...te_schemes_tried_regions_wss_estimation.py | 48 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/damon/access_memory.c
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index d2105d41ea25..1363987709c6 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -4,6 +4,7 @@
 TEST_GEN_FILES += huge_count_read_write
 TEST_GEN_FILES += dbgfs_target_ids_read_before_terminate_race
 TEST_GEN_FILES += dbgfs_target_ids_pid_leak
+TEST_GEN_FILES += access_memory
 
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
 TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
@@ -11,6 +12,7 @@ TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
+TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 TEST_PROGS += dbgfs_target_ids_read_before_terminate_race.sh
 TEST_PROGS += dbgfs_target_ids_pid_leak.sh
diff --git a/tools/testing/selftests/damon/access_memory.c b/tools/testing/selftests/damon/access_memory.c
new file mode 100644
index 000000000000..585a2fa54329
--- /dev/null
+++ b/tools/testing/selftests/damon/access_memory.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Artificial memory access program for testing DAMON.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+
+int main(int argc, char *argv[])
+{
+	char **regions;
+	clock_t start_clock;
+	int nr_regions;
+	int sz_region;
+	int access_time_ms;
+	int i;
+
+	if (argc != 4) {
+		printf("Usage: %s <number> <size (bytes)> <time (ms)>\n",
+				argv[0]);
+		return -1;
+	}
+
+	nr_regions = atoi(argv[1]);
+	sz_region = atoi(argv[2]);
+	access_time_ms = atoi(argv[3]);
+
+	regions = malloc(sizeof(*regions) * nr_regions);
+	for (i = 0; i < nr_regions; i++)
+		regions[i] = malloc(sz_region);
+
+	for (i = 0; i < nr_regions; i++) {
+		start_clock = clock();
+		while ((clock() - start_clock) * 1000 / CLOCKS_PER_SEC <
+				access_time_ms)
+			memset(regions[i], i, 1024 * 1024 * 10);
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
new file mode 100755
index 000000000000..2aa66f4ad2dc
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+import _damon
+
+def main():
+    # access three 10 MiB memory regions, 1 second per each
+    sz_region = 10 * 1024 * 1024
+    proc = subprocess.Popen(['./access_memory', '3', '%d' % sz_region, '1000'])
+    kdamonds = _damon.Kdamonds([_damon.Kdamond(
+            contexts=[_damon.DamonCtx(
+                ops='vaddr',
+                targets=[_damon.DamonTarget(pid=proc.pid)],
+                schemes=[_damon.Damos(
+                    access_pattern=_damon.DamosAccessPattern(
+                        nr_accesses=[1, 20]))] # schemes
+                )] # contexts
+            )]) # kdamonds
+
+    err = kdamonds.start()
+    if err != None:
+        print('kdmaond start failed: %s' % err)
+        exit(1)
+
+    wss_collected = []
+    while proc.poll() == None:
+        time.sleep(0.1)
+        err = kdamonds.kdamonds[0].update_schemes_tried_bytes()
+        if err != None:
+            print('tried bytes update failed: %s' % err)
+            exit(1)
+
+        wss_collected.append(
+                kdamonds.kdamonds[0].contexts[0].schemes[0].tried_bytes)
+
+    wss_collected.sort()
+    for percentile in [25, 75]:
+        sample = wss_collected[int(len(wss_collected) * percentile / 100)]
+        error_rate = abs(sample - sz_region) / sz_region
+        print('%d-th percentile error %f' % (percentile, error_rate))
+        if error_rate > 0.5:
+            exit(1)
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1

