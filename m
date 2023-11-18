Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A5B7EFEF7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjKRKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:41 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF410CE;
        Sat, 18 Nov 2023 02:41:37 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgb137mz4f3lfd;
        Sat, 18 Nov 2023 18:41:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 44A8B1A0175;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S8;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 04/14] kddv/core: Check kmsg before return from test case
Date:   Sat, 18 Nov 2023 18:40:30 +0800
Message-Id: <20231118104040.386381-5-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S8
X-Coremail-Antispam: 1UD129KBjvJXoWxAw15Jry7ZF13JF1fKF48WFg_yoWrXF4xpa
        1rGr43WF4xur1Skw1SkF1UuFWrWan7CF4rKrnIy34agr13Aas8Kr47t3WUXFy3urn5t39a
        va4vgr4jkr47XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UZo7tUUUUU=
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

Check kernel message before return from test case, if bug
or error in kernel message, fail the test case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 tools/testing/kddv/kddv/core/ddunit.py  | 12 ++++++++
 tools/testing/kddv/kddv/core/dmesg.py   | 41 +++++++++++++++++++++++++
 tools/testing/kddv/kddv/core/environ.py | 28 +++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100755 tools/testing/kddv/kddv/core/dmesg.py
 create mode 100755 tools/testing/kddv/kddv/core/environ.py

diff --git a/tools/testing/kddv/kddv/core/ddunit.py b/tools/testing/kddv/kddv/core/ddunit.py
index fd4ab9fe048c..197300f8a6d4 100755
--- a/tools/testing/kddv/kddv/core/ddunit.py
+++ b/tools/testing/kddv/kddv/core/ddunit.py
@@ -10,6 +10,7 @@ import logging
 import unittest
 
 from .model import DriverModel
+from .environ import environ
 
 logger = logging.getLogger(__name__)
 
@@ -25,12 +26,18 @@ class DriverTest(unittest.TestCase, DriverModel):
         except:
             self.skipTest(f"Module {self.module_name} not found")
         self.mockup.load()
+        environ.setup()
 
     def tearDown(self):
+        environ.teardown()
         self.mockup.unload()
         self.driver.teardown()
         super().tearDown()
 
+    def _callTestMethod(self, method):
+        method()
+        self.assertFault()
+
     def assertRegEqual(self, reg, data, msg=None):
         value = self.read_reg(reg)
         self.assertEqual(value, data, msg)
@@ -42,3 +49,8 @@ class DriverTest(unittest.TestCase, DriverModel):
     def assertRegsEqual(self, reg, data, msg=None):
         value = self.read_regs(reg, len(data))
         self.assertListEqual(value, data, msg)
+
+    def assertFault(self):
+        msg = environ.check_failure()
+        if msg:
+            raise self.failureException(msg)
diff --git a/tools/testing/kddv/kddv/core/dmesg.py b/tools/testing/kddv/kddv/core/dmesg.py
new file mode 100755
index 000000000000..e528b6164f46
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/dmesg.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import re
+import logging
+import subprocess
+
+KERNEL_PANIC = [
+    "BUG:",
+    "WARNING:",
+    "INFO:",
+    "[kK]ernel BUG",
+    "PANIC: double fault",
+    "divide error:",
+    "UBSAN:",
+    "Unable to handle kernel",
+    "general protection fault",
+]
+
+logger = logging.getLogger(__name__)
+
+class KernelMessage(object):
+
+    def setup(self):
+        subprocess.run(["/usr/bin/dmesg", "-C"])
+
+    def teardown(self):
+        subprocess.run(["/usr/bin/dmesg", "-C"])
+
+    def check_failure(self):
+        logger.debug('check kernel message')
+        kmsg = subprocess.check_output(["/usr/bin/dmesg", "-c"])
+        regex_pattern = re.compile("|".join(KERNEL_PANIC))
+        if regex_pattern.search(kmsg.decode()):
+            return kmsg.decode()
+        return None
diff --git a/tools/testing/kddv/kddv/core/environ.py b/tools/testing/kddv/kddv/core/environ.py
new file mode 100755
index 000000000000..d57e33a6ac6e
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/environ.py
@@ -0,0 +1,28 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import logging
+
+from .dmesg import KernelMessage
+
+logger = logging.getLogger(__name__)
+
+class Environ(object):
+    def __init__(self):
+        self.kmsg = KernelMessage()
+
+    def setup(self):
+        self.kmsg.setup()
+
+    def teardown(self):
+        self.kmsg.teardown()
+
+    def check_failure(self):
+        return self.kmsg.check_failure()
+
+environ = Environ()
-- 
2.34.1

