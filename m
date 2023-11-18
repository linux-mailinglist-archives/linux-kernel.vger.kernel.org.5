Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD57EFF0F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjKRKmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjKRKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:43 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C0BD6C;
        Sat, 18 Nov 2023 02:41:39 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SXVgg1JfLz4f3kFl;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id AB7221A016F;
        Sat, 18 Nov 2023 18:41:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S12;
        Sat, 18 Nov 2023 18:41:36 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 08/14] kddv/cmd: Add command to run testcases
Date:   Sat, 18 Nov 2023 18:40:34 +0800
Message-Id: <20231118104040.386381-9-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S12
X-Coremail-Antispam: 1UD129KBjvJXoWxXF48Wr4UCr45uw1xGr4Durg_yoW5Zw4Upa
        4fCr1F9FyfWF1rKwnxCFyUurW5Xan5AF4jkFyxC343ta15CrZF9rWIkayaqF9xWw4rX34a
        v3W0qr43Gw4DJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
        VFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

Add command kddv.cmds.test, which can help to run the testcase
use the python unittest framework.
  $ python3 -m kddv.cmd.test
  or
  $ python3 -m kddv.cmd.test kddv.tests.hwmon.test_max31722

Also enable fault inject test or enable kmemleak check. Usage:

Enable fault inject test:
  $ python3 -m kddv.cmds.test --fault-inject=all
  or
  $ python3 -m kddv.cmds.test --fault-inject=all \
  kddv.tests.hwmon.test_max31722.TestMax31722.test_device_probe

Enable kmemleak check:
  $ python3 -m kddv.cmds.test --kmemleak

Both fault inject and kmemleak will increase the time times.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 tools/testing/kddv/kddv/cmds/test.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100755 tools/testing/kddv/kddv/cmds/test.py

diff --git a/tools/testing/kddv/kddv/cmds/test.py b/tools/testing/kddv/kddv/cmds/test.py
new file mode 100755
index 000000000000..9be346983286
--- /dev/null
+++ b/tools/testing/kddv/kddv/cmds/test.py
@@ -0,0 +1,75 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import os
+import sys
+import fnmatch
+import argparse
+import unittest
+
+from kddv.core.ddunit import DriverTest
+from kddv.core.environ import environ
+from . import utils
+
+ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
+
+def _list_suite(suite, tfilter=None):
+    for t in suite:
+        if isinstance(t, unittest.TestSuite):
+            _list_suite(t, tfilter)
+        elif isinstance(t, DriverTest):
+            id = t.id()
+            if tfilter and not any(fnmatch.fnmatch(id, f) for f in tfilter):
+                continue
+            print(f"kddv.tests.{id}")
+        else:
+            return None
+
+def list_suite(args):
+    args.filter = [f"*{f}*" for f in args.filter]
+    loader = unittest.defaultTestLoader
+    suites = loader.discover(os.path.join(ROOT_DIR, 'tests'))
+    _list_suite(suites, args.filter)
+    return 0
+
+def main() -> None:
+    parser = argparse.ArgumentParser()
+
+    parser.add_argument(
+        "--log-level", type=str, default=None,
+        choices=utils.LOG_LEVELS, help="Log Level"
+    )
+    parser.add_argument(
+        "--list", action='store_true', default=False,
+        help="List test cases",
+    )
+    parser.add_argument(
+        "--kmemleak", action='store_true', default=False,
+        help="Enable kmemeleak check",
+    )
+    parser.add_argument(
+        "--fault-inject", type=str, default=None,
+        choices=["slab", "page", "all"],
+        help="Enable fault inject features",
+    )
+    parser.add_argument("--filter", nargs="+", default=[],)
+
+    args, argv = parser.parse_known_args(sys.argv)
+    if args.log_level:
+        utils.setup_logger(args.log_level)
+    if args.list:
+        return list_suite(args)
+    if args.kmemleak:
+        environ.enable_kmemleak()
+    if args.fault_inject:
+        environ.enable_fault_inject(args.fault_inject)
+
+    unittest.main(verbosity=2, module=None, argv=argv)
+
+if __name__ == "__main__":
+    main()
-- 
2.34.1

