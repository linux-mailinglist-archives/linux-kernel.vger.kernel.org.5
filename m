Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B037EFF00
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjKRKls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjKRKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:42 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185510D0;
        Sat, 18 Nov 2023 02:41:38 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgb3bkfz4f3lfh;
        Sat, 18 Nov 2023 18:41:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 9BC8C1A0176;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S9;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 05/14] kddv/core: Support kernel memory leak detector
Date:   Sat, 18 Nov 2023 18:40:31 +0800
Message-Id: <20231118104040.386381-6-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kCry3tr43tFW8Cr48JFb_yoW5XF1xpa
        n5Kr1agF17uF13Krs3tF1UWFWF9rs7GF48tF97Jw45Wry3JFyYyr43t3W2vFyfW3s5t393
        A3y0gr42krWUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUFgAwUUUUU
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

Check the kmemleak before return from test case,
fail the test case if a kmemleak is detected.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 tools/testing/kddv/kddv/core/environ.py | 13 ++++++++-
 tools/testing/kddv/kddv/core/memleak.py | 39 +++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/kddv/kddv/core/memleak.py

diff --git a/tools/testing/kddv/kddv/core/environ.py b/tools/testing/kddv/kddv/core/environ.py
index d57e33a6ac6e..68c98e8c44da 100755
--- a/tools/testing/kddv/kddv/core/environ.py
+++ b/tools/testing/kddv/kddv/core/environ.py
@@ -9,20 +9,31 @@
 import logging
 
 from .dmesg import KernelMessage
+from .memleak import Kmemleak
 
 logger = logging.getLogger(__name__)
 
 class Environ(object):
     def __init__(self):
         self.kmsg = KernelMessage()
+        self.leak = Kmemleak()
 
     def setup(self):
         self.kmsg.setup()
+        self.leak.setup()
 
     def teardown(self):
+        self.leak.teardown()
         self.kmsg.teardown()
 
+    def enable_kmemleak(self):
+        """Enable Kernel memory leak detector"""
+        self.leak.enabled = True
+
     def check_failure(self):
-        return self.kmsg.check_failure()
+        msg = self.kmsg.check_failure()
+        if msg:
+            return msg
+        return self.leak.check_failure()
 
 environ = Environ()
diff --git a/tools/testing/kddv/kddv/core/memleak.py b/tools/testing/kddv/kddv/core/memleak.py
new file mode 100755
index 000000000000..7ff67997560f
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/memleak.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import os
+import logging
+import pathlib
+
+KMEMLEAK = '/sys/kernel/debug/kmemleak'
+
+logger = logging.getLogger(__name__)
+
+class Kmemleak(object):
+    def __init__(self):
+        self.has_feature = os.path.exists(KMEMLEAK)
+        self.ctrl = pathlib.Path(KMEMLEAK)
+        self.enabled = False
+
+    def setup(self):
+        if not self.has_feature or not self.enabled:
+            return
+        self.ctrl.write_text('clear')
+
+    def teardown(self):
+        if not self.has_feature or not self.enabled:
+            return
+        self.ctrl.write_text('clear')
+
+    def check_failure(self):
+        if not self.has_feature or not self.enabled:
+            return None
+        logger.debug('check kernel memleak')
+        self.ctrl.write_text('scan')
+        self.ctrl.write_text('scan')
+        return self.ctrl.read_text().rstrip()
-- 
2.34.1

