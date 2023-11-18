Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558EF7EFF0A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjKRKmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjKRKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:43 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F8F10D5;
        Sat, 18 Nov 2023 02:41:38 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgd2jH1z4f3jqv;
        Sat, 18 Nov 2023 18:41:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id F23301A01A1;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S10;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 06/14] kddv/core: Add page and slab fault inject support
Date:   Sat, 18 Nov 2023 18:40:32 +0800
Message-Id: <20231118104040.386381-7-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S10
X-Coremail-Antispam: 1UD129KBjvAXoW3tF48GrW7Cw4xXw17WFWxJFb_yoW8GFyrWo
        Z7ur4UAFWfAFyUX3Wq93W7JryrWFZYkr4xX347JF4kWay8XF45Zw4xArnrWF9xArZYq3sa
        gFnxC348Jan5Jrn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYD7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
        67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
        MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
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

Implement page and slab fault inject, to test whether the drivers
can work properly when out of memory.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 tools/testing/kddv/kddv/core/ddunit.py        | 29 ++++++-
 tools/testing/kddv/kddv/core/driver.py        |  3 +
 tools/testing/kddv/kddv/core/environ.py       | 26 ++++++
 tools/testing/kddv/kddv/core/failnth.py       | 57 ++++++++++++
 tools/testing/kddv/kddv/core/faulter.py       | 48 +++++++++++
 .../testing/kddv/kddv/core/faults/__init__.py | 13 +++
 tools/testing/kddv/kddv/core/faults/fail.py   | 86 +++++++++++++++++++
 tools/testing/kddv/kddv/core/faults/page.py   | 40 +++++++++
 tools/testing/kddv/kddv/core/faults/slab.py   | 36 ++++++++
 9 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/kddv/kddv/core/failnth.py
 create mode 100755 tools/testing/kddv/kddv/core/faulter.py
 create mode 100755 tools/testing/kddv/kddv/core/faults/__init__.py
 create mode 100755 tools/testing/kddv/kddv/core/faults/fail.py
 create mode 100755 tools/testing/kddv/kddv/core/faults/page.py
 create mode 100755 tools/testing/kddv/kddv/core/faults/slab.py

diff --git a/tools/testing/kddv/kddv/core/ddunit.py b/tools/testing/kddv/kddv/core/ddunit.py
index 197300f8a6d4..716e0e1505d1 100755
--- a/tools/testing/kddv/kddv/core/ddunit.py
+++ b/tools/testing/kddv/kddv/core/ddunit.py
@@ -11,9 +11,26 @@ import unittest
 
 from .model import DriverModel
 from .environ import environ
+from .failnth import FaultIterator
 
 logger = logging.getLogger(__name__)
 
+class _AssertRaisesFaultContext(unittest.case._AssertRaisesContext):
+    def __enter__(self):
+        environ.enter_fault_inject()
+        return self
+
+    def __exit__(self, exc_type, exc_value, tb):
+        if not environ.exit_fault_inject():
+            return False
+        if exc_type is None:
+            return True
+        if issubclass(exc_type, self.expected):
+            return True
+        if issubclass(exc_type, AssertionError):
+            return True
+        return super().__exit__(exc_type, exc_value, tb)
+
 class DriverTest(unittest.TestCase, DriverModel):
     def __init__(self, methodName=None):
         super().__init__(methodName)
@@ -35,7 +52,10 @@ class DriverTest(unittest.TestCase, DriverModel):
         super().tearDown()
 
     def _callTestMethod(self, method):
-        method()
+        fault = FaultIterator()
+        for nth in iter(fault):
+            logger.debug(f"fault inject: nth={nth}")
+            method()
         self.assertFault()
 
     def assertRegEqual(self, reg, data, msg=None):
@@ -54,3 +74,10 @@ class DriverTest(unittest.TestCase, DriverModel):
         msg = environ.check_failure()
         if msg:
             raise self.failureException(msg)
+
+    def assertRaisesFault(self, *args, **kwargs):
+        context = _AssertRaisesFaultContext(OSError, self)
+        try:
+            return context.handle('assertRaises', args, kwargs)
+        finally:
+            context = None
diff --git a/tools/testing/kddv/kddv/core/driver.py b/tools/testing/kddv/kddv/core/driver.py
index 55ad804068b5..a6fcf3dcdd7d 100755
--- a/tools/testing/kddv/kddv/core/driver.py
+++ b/tools/testing/kddv/kddv/core/driver.py
@@ -12,6 +12,7 @@ import subprocess
 from pathlib import Path
 
 from .device import Device
+from .environ import environ
 
 logger = logging.getLogger(__name__)
 
@@ -54,9 +55,11 @@ class Driver(object):
         subprocess.check_output(
             ["/sbin/modprobe", self.module], stderr=subprocess.STDOUT
         )
+        environ.notify_insmod(self.module)
 
     def remove_mdule(self):
         logger.debug(f'rmmod {self.module}')
+        environ.notify_rmmod()
         subprocess.check_output(["/sbin/rmmod", self.module])
 
     def setup(self):
diff --git a/tools/testing/kddv/kddv/core/environ.py b/tools/testing/kddv/kddv/core/environ.py
index 68c98e8c44da..8bd7d6a60cb7 100755
--- a/tools/testing/kddv/kddv/core/environ.py
+++ b/tools/testing/kddv/kddv/core/environ.py
@@ -9,6 +9,7 @@
 import logging
 
 from .dmesg import KernelMessage
+from .faulter import FaultInject
 from .memleak import Kmemleak
 
 logger = logging.getLogger(__name__)
@@ -17,12 +18,15 @@ class Environ(object):
     def __init__(self):
         self.kmsg = KernelMessage()
         self.leak = Kmemleak()
+        self.fault = FaultInject()
 
     def setup(self):
         self.kmsg.setup()
         self.leak.setup()
+        self.fault.setup()
 
     def teardown(self):
+        self.fault.teardown()
         self.leak.teardown()
         self.kmsg.teardown()
 
@@ -36,4 +40,26 @@ class Environ(object):
             return msg
         return self.leak.check_failure()
 
+    def enable_fault_inject(self, feature):
+        """Enable fault injection feature"""
+        self.fault.enable_feature(feature)
+
+    def fault_running(self):
+        """Fault injection has been enabled"""
+        return self.fault.running
+
+    def enter_fault_inject(self):
+        """Enter fault injection"""
+        self.fault.start_features()
+
+    def exit_fault_inject(self):
+        """Exit fault injection"""
+        return self.fault.stop_features()
+
+    def notify_insmod(self, name):
+        self.fault.filter_module(name)
+
+    def notify_rmmod(self):
+        self.fault.filter_module(None)
+
 environ = Environ()
diff --git a/tools/testing/kddv/kddv/core/failnth.py b/tools/testing/kddv/kddv/core/failnth.py
new file mode 100755
index 000000000000..6d547aabb0a1
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/failnth.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import os
+import re
+import logging
+
+from pathlib import Path
+from .environ import environ
+
+logger = logging.getLogger(__name__)
+
+class FaultIterator(object):
+    def __init__(self, max_loop = 0):
+        self._max_loop = max_loop
+        self._cur_fail = 0
+        self._max_fail = 3
+        self.path = Path(f"/proc/self/fail-nth")
+
+    def __iter__(self):
+        self.nth = -1
+        return self
+
+    def __next__(self):
+        self.nth += 1
+        if not self.nth:
+            return self.nth
+        if not environ.fault_running():
+            logger.debug('fault inject not running')
+            raise StopIteration
+        if not os.path.exists(self.path):
+            logger.debug('fault inject not exists')
+            raise StopIteration
+        if self._max_loop and self._max_loop < self.nth:
+            raise StopIteration
+        if self.read_nth() > 0:
+            self.write_nth(0)
+            self._cur_fail += 1
+            if self._cur_fail >= self._max_fail:
+                logger.debug('end fault inject')
+                raise StopIteration
+        else:
+           self._cur_fail = 0
+        self.write_nth(self.nth)
+        return self.nth
+
+    def read_nth(self):
+        return int(self.path.read_text().rstrip())
+
+    def write_nth(self, val):
+        logger.debug(f"write {val} to fail-nth")
+        self.path.write_text(str(val))
diff --git a/tools/testing/kddv/kddv/core/faulter.py b/tools/testing/kddv/kddv/core/faulter.py
new file mode 100755
index 000000000000..32f4d5c3a57c
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/faulter.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+from .faults import FailModule
+
+class FaultInject(object):
+    def __init__(self):
+        self.enabled = False
+        self.running = False
+        self.features = []
+        for subclass in FailModule.__subclasses__():
+            self.features.append(subclass())
+
+    def setup(self):
+        pass
+
+    def teardown(self):
+        self.running = False
+
+    def start_features(self):
+        if not self.enabled:
+            return
+        for feature in self.features:
+            feature.start()
+        self.running = True
+
+    def stop_features(self):
+        if not self.enabled:
+            return False
+        for feature in self.features:
+            feature.stop()
+        return True
+
+    def filter_module(self, module):
+        for feature in self.features:
+            feature.filter_module(module)
+
+    def enable_feature(self, name):
+        for feature in self.features:
+            if name in [feature.key, 'all']:
+                if feature.has_support:
+                    feature.enabled = True
+                    self.enabled = True
diff --git a/tools/testing/kddv/kddv/core/faults/__init__.py b/tools/testing/kddv/kddv/core/faults/__init__.py
new file mode 100755
index 000000000000..2e1280ca20da
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/faults/__init__.py
@@ -0,0 +1,13 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+__all__ = ['FailModule']
+
+from .fail import FailModule
+from .slab import FailSlab
+from .page import FailPage
diff --git a/tools/testing/kddv/kddv/core/faults/fail.py b/tools/testing/kddv/kddv/core/faults/fail.py
new file mode 100755
index 000000000000..4d4344e00e9a
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/faults/fail.py
@@ -0,0 +1,86 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import re
+import os
+import logging
+from pathlib import Path
+
+logger = logging.getLogger(__name__)
+
+class FailModule(object):
+    name = None
+    key = None
+
+    def __init__(self):
+        self.has_support = os.path.exists(f"/sys/kernel/debug/{self.name}")
+        self.ftext = Path(f"/sys/kernel/debug/{self.name}/require-start")
+        self.fdata = Path(f"/sys/kernel/debug/{self.name}/require-end")
+        self.fdepth = Path(f"/sys/kernel/debug/{self.name}/stacktrace-depth")
+        self.nowarn = Path(f"/sys/kernel/debug/{self.name}/verbose")
+        self.enabled = False
+        self.module = None
+
+    def feature_enabled(self):
+        if not self.has_support:
+            return False
+        return self.enabled
+
+    def filter_module(self, name):
+        if name is None:
+            self.module = None
+        else:
+            self.module = re.sub('-', '_', name)
+
+    def enable_verbose(self):
+        if not self.feature_enabled():
+            return
+        self.nowarn.write_text('1')
+
+    def disable_verbose(self):
+        if not self.feature_enabled():
+            return
+        self.nowarn.write_text('0')
+
+    def enable_module_filter(self):
+        if not self.feature_enabled():
+            return
+        if self.module is None:
+            return
+        logger.debug(f"enter module filter for fail {self.name}")
+        mtext = Path(f"/sys/module/{self.module}/sections/.text")
+        mdata = Path(f"/sys/module/{self.module}/sections/.data")
+        self.ftext.write_text(mtext.read_text().rstrip())
+        self.fdata.write_text(mdata.read_text().rstrip())
+        self.fdepth.write_text('32')
+
+    def disable_module_filter(self):
+        if not self.feature_enabled():
+            return
+        if self.module is None:
+            return
+        logger.debug(f"exit module filter for fail {self.name}")
+        self.ftext.write_text('0')
+        self.fdata.write_text('0')
+        self.fdepth.write_text('32')
+
+    def enable_feature(self):
+        pass
+
+    def disable_feature(self):
+        pass
+
+    def start(self):
+        self.enable_module_filter()
+        self.enable_verbose()
+        self.enable_feature()
+
+    def stop(self):
+        self.disable_feature()
+        self.disable_verbose()
+        self.disable_module_filter()
diff --git a/tools/testing/kddv/kddv/core/faults/page.py b/tools/testing/kddv/kddv/core/faults/page.py
new file mode 100755
index 000000000000..e78f6e1a8c88
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/faults/page.py
@@ -0,0 +1,40 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import logging
+from pathlib import Path
+
+from .fail import FailModule
+
+FAILPAGE_IGNORE_HMEM = '/sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem'
+FAILPAGE_IGNORE_WAIT = '/sys/kernel/debug/fail_page_alloc/ignore-gfp-wait'
+
+logger = logging.getLogger(__name__)
+
+class FailPage(FailModule):
+    name = 'fail_page_alloc'
+    key = 'page'
+
+    def __init__(self):
+        super().__init__()
+        self.ignore_hmem = Path(FAILPAGE_IGNORE_HMEM)
+        self.ignore_wait = Path(FAILPAGE_IGNORE_WAIT)
+
+    def enable_feature(self):
+        if not self.feature_enabled():
+            return
+        logger.debug("enter fail page injection")
+        self.ignore_hmem.write_text('N')
+        self.ignore_wait.write_text('N')
+
+    def disable_feature(self):
+        if not self.feature_enabled():
+            return
+        logger.debug("exit fail page injection")
+        self.ignore_hmem.write_text('Y')
+        self.ignore_wait.write_text('Y')
diff --git a/tools/testing/kddv/kddv/core/faults/slab.py b/tools/testing/kddv/kddv/core/faults/slab.py
new file mode 100755
index 000000000000..5472f1ec4795
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/faults/slab.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import logging
+from pathlib import Path
+
+from .fail import FailModule
+
+FAILSLAB_IGNORE = '/sys/kernel/debug/failslab/ignore-gfp-wait'
+
+logger = logging.getLogger(__name__)
+
+class FailSlab(FailModule):
+    name = 'failslab'
+    key = 'slab'
+
+    def __init__(self):
+        super().__init__()
+        self.ignore = Path(FAILSLAB_IGNORE)
+
+    def enable_feature(self):
+        if not self.feature_enabled():
+            return
+        logger.debug("enter fail slab injection")
+        self.ignore.write_text('N')
+
+    def disable_feature(self):
+        if not self.feature_enabled():
+            return
+        logger.debug("exit fail slab injection")
+        self.ignore.write_text('Y')
-- 
2.34.1

