Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640208018BF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441939AbjLBAKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjLBAKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:10:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F7B2D41
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:09:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA99CC433CD;
        Sat,  2 Dec 2023 00:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475693;
        bh=0o1OidTQa+jBmmayVqOJ5Gh8ghc1rg4/WI7HWKTJJqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgHf7Eo3aY6hqilQ6vhoUxZZ0Dc2Zeu3gG4+W5pxm7RRYGGlX6sRPfdd19Ii+dGRU
         3b9OCW1b8U6a+3cQY+1RZWwDJqfWWXvPCDWx/MFMLLBT0neQjeR8jtY/JV+Z7x03qx
         dYbsUMgMGYcmq39jD6IJoUmkxwT4DwdLsNjOBAXOkWcfOuei2nWCGBKrbOs8JoIrY4
         OieJhlPmDjSE47hOJ9n1ygykcGnoQsGp/C/DuZ20al10JgSmXbU7X+xkKJOxRh51Ie
         kBxeDsvx0mPcaXCorB5l6mp4p/vYCUQ0vBhkwzggPNMJ8/arJWGiklqERGlbq77zk6
         3PXJSOLrvCU5A==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] selftests/damon: add a test for update_schemes_tried_regions hang bug
Date:   Sat,  2 Dec 2023 00:08:06 +0000
Message-Id: <20231202000806.46210-6-sj@kernel.org>
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

The update_schemees_tried_{regions,bytes} command was able to be
indefinitely hang in some corner cases.  It has fixed by introducing a
timeout for the command[1].  Add a test for the corner case to not
introduce the problem again.

[1] https://lore.kernel.org/damon/20231124213840.39157-1-sj@kernel.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 ...sysfs_update_schemes_tried_regions_hang.py | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 1363987709c6..d90bdba28ff4 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
+TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 TEST_PROGS += dbgfs_target_ids_read_before_terminate_race.sh
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
new file mode 100755
index 000000000000..14187be3b004
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+import _damon
+
+def main():
+    proc = subprocess.Popen(['sleep', '2'])
+    kdamonds = _damon.Kdamonds([_damon.Kdamond(
+            contexts=[_damon.DamonCtx(
+                ops='vaddr',
+                targets=[_damon.DamonTarget(pid=proc.pid)],
+                schemes=[_damon.Damos(
+                    access_pattern=_damon.DamosAccessPattern(
+                        nr_accesses=[200, 200]))] # schemes
+                )] # contexts
+            )]) # kdamonds
+
+    err = kdamonds.start()
+    if err != None:
+        print('kdmaond start failed: %s' % err)
+        exit(1)
+
+    while proc.poll() == None:
+        err = kdamonds.kdamonds[0].update_schemes_tried_bytes()
+        if err != None:
+            print('tried bytes update failed: %s' % err)
+            exit(1)
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1

