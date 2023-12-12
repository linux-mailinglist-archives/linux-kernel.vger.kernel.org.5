Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9516480F63C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377215AbjLLTMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377128AbjLLTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:12:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD0691
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:12:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED58C433CA;
        Tue, 12 Dec 2023 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408339;
        bh=qDPLpQDef/itGfo/TklI8cUVBWxVqosgPn9XJfgMvTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fe548kOa1eEySWtrJregkohnvqpY7vdWjKKPCudLgwBBb+9e6xzFaoH0+WvaqguDx
         ZxHypfeWg97/jfKcQUaCtcorEwUUrssWyeoUMuUvVxoY29wGmcPyZaQ4d5OkrgcOQQ
         nwazE99GcCCIgiV9RdLrxpKwqnWVZkALMeRr12SqAa7yasIzFnoe1Q0QoJaWQcEGlT
         Jlo2peINZz+lkxp29aM3YkyyG5n4FTUmspwosyQOf/nseLqoytIJfrmMQbYV/TRVlF
         oDFD2WIHnDmjMVKO6nUxpOcT9jfgLqN7yAQkkWCYXqizU4d/Rn/otkz6LJkXh+KWKc
         dvC8vmZur3sZg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] selftests/damon: add a test for update_schemes_tried_regions hang bug
Date:   Tue, 12 Dec 2023 19:12:06 +0000
Message-Id: <20231212191206.52917-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212191206.52917-1-sj@kernel.org>
References: <20231212191206.52917-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for reproducing the update_schemes_tried_{regions,bytes}
command-causing indefinite hang bug that fixed by commit 7d6fa31a2fd7
("mm/damon/sysfs-schemes: add timeout for
update_schemes_tried_regions"), to avoid mistakenly re-introducing the
bug.  Refer to the fix commit for more details of the bug.

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
index 000000000000..8c690ba1a573
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+import _damon_sysfs
+
+def main():
+    proc = subprocess.Popen(['sleep', '2'])
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(
+                    access_pattern=_damon_sysfs.DamosAccessPattern(
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

