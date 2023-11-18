Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA37B7EFF0B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjKRKl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjKRKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:43 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD20D79;
        Sat, 18 Nov 2023 02:41:37 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgZ0Rnfz4f3lfL;
        Sat, 18 Nov 2023 18:41:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 315041A0169;
        Sat, 18 Nov 2023 18:41:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S5;
        Sat, 18 Nov 2023 18:41:34 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 01/14] kddv/core: Implement a ligth weight device driver test framework
Date:   Sat, 18 Nov 2023 18:40:27 +0800
Message-Id: <20231118104040.386381-2-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S5
X-Coremail-Antispam: 1UD129KBjvAXoW3uFy8XrWDAw47Cw18XFyxKrg_yoW8Ww18Go
        Z3Wrs8JF47JFW8ua1j9a47JryrWFWkKF4xWw1UAr1DCayjv34UXw48ZwnxXasxZrWUK3s3
        uF95GrWfAa1rArn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYT7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUzl1vUUUUU
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

Implement a ligth weight device driver test framework, KDDV(Kernel
Device Driver Verification). Which using eBPF based bus controllers
to mockup device chipsets.

Directory structure as below:

  $ tree tools/testing/kddv/kddv
  tools/testing/kddv/kddv/
  ├── core           # general data structure of the kddv
  │   ├── __init__.py
  │   ├── ddunit.py  # basic testcase class
  │   ├── device.py  # device common info and operations
  │   ├── driver.py  # driver controller, load modules and bind device
  │   ├── mockup.py  # bpf controller, mockup hardware
  │   └── model.py   # drivers common info and operations
  ├── __init__.py
  ├── Makefile
  └── tests             # test case folder
      └── __init__.py

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 tools/testing/kddv/.gitignore             |   3 +
 tools/testing/kddv/Makefile               |  25 ++++
 tools/testing/kddv/kddv/Makefile          |  22 +++
 tools/testing/kddv/kddv/__init__.py       |   0
 tools/testing/kddv/kddv/core/__init__.py  |   7 +
 tools/testing/kddv/kddv/core/ddunit.py    |  44 ++++++
 tools/testing/kddv/kddv/core/device.py    |  78 +++++++++++
 tools/testing/kddv/kddv/core/driver.py    |  79 +++++++++++
 tools/testing/kddv/kddv/core/mockup.py    | 157 ++++++++++++++++++++++
 tools/testing/kddv/kddv/core/model.py     |  87 ++++++++++++
 tools/testing/kddv/kddv/tests/__init__.py |   0
 11 files changed, 502 insertions(+)
 create mode 100644 tools/testing/kddv/.gitignore
 create mode 100644 tools/testing/kddv/Makefile
 create mode 100644 tools/testing/kddv/kddv/Makefile
 create mode 100755 tools/testing/kddv/kddv/__init__.py
 create mode 100755 tools/testing/kddv/kddv/core/__init__.py
 create mode 100755 tools/testing/kddv/kddv/core/ddunit.py
 create mode 100755 tools/testing/kddv/kddv/core/device.py
 create mode 100755 tools/testing/kddv/kddv/core/driver.py
 create mode 100755 tools/testing/kddv/kddv/core/mockup.py
 create mode 100755 tools/testing/kddv/kddv/core/model.py
 create mode 100755 tools/testing/kddv/kddv/tests/__init__.py

diff --git a/tools/testing/kddv/.gitignore b/tools/testing/kddv/.gitignore
new file mode 100644
index 000000000000..159cec72565a
--- /dev/null
+++ b/tools/testing/kddv/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+__pycache__/
+*.py[cod]
\ No newline at end of file
diff --git a/tools/testing/kddv/Makefile b/tools/testing/kddv/Makefile
new file mode 100644
index 000000000000..f4ef60a1342b
--- /dev/null
+++ b/tools/testing/kddv/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../scripts/Makefile.include
+
+SUBDIRS := kddv
+
+all:
+	@for SUBDIR in $(SUBDIRS); do \
+		$(MAKE) -C $$SUBDIR;\
+	done;
+
+install:
+ifdef INSTALL_PATH
+	@for SUBDIR in $(SUBDIRS); do \
+		$(MAKE) INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR -C $$SUBDIR install;\
+	done;
+else
+	$(error Error: set INSTALL_PATH to use install)
+endif
+
+clean:
+	@for SUBDIR in $(SUBDIRS); do \
+		$(MAKE) -C $$SUBDIR clean;\
+	done;
+
+.PHONY: all install clean
diff --git a/tools/testing/kddv/kddv/Makefile b/tools/testing/kddv/kddv/Makefile
new file mode 100644
index 000000000000..a68112154669
--- /dev/null
+++ b/tools/testing/kddv/kddv/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../scripts/Makefile.include
+
+INSTALL ?= install
+
+all:
+	@for SUBDIR in $(SUBDIRS); do		\
+		$(MAKE) -C $$SUBDIR;		\
+	done;
+
+install:
+	$(INSTALL) -m 0755 -d $(INSTALL_PATH)
+	$(INSTALL) __init__.py $(INSTALL_PATH)
+	cp -rf core/ $(INSTALL_PATH)
+	cp -rf tests/ $(INSTALL_PATH)
+
+clean:
+	@for SUBDIR in $(SUBDIRS); do		\
+		$(MAKE) -C $$SUBDIR clean;	\
+	done;
+
+.PHONY: all install clean
diff --git a/tools/testing/kddv/kddv/__init__.py b/tools/testing/kddv/kddv/__init__.py
new file mode 100755
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/kddv/kddv/core/__init__.py b/tools/testing/kddv/kddv/core/__init__.py
new file mode 100755
index 000000000000..45a35c909e86
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/__init__.py
@@ -0,0 +1,7 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
diff --git a/tools/testing/kddv/kddv/core/ddunit.py b/tools/testing/kddv/kddv/core/ddunit.py
new file mode 100755
index 000000000000..fd4ab9fe048c
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/ddunit.py
@@ -0,0 +1,44 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import logging
+import unittest
+
+from .model import DriverModel
+
+logger = logging.getLogger(__name__)
+
+class DriverTest(unittest.TestCase, DriverModel):
+    def __init__(self, methodName=None):
+        super().__init__(methodName)
+        DriverModel.__init__(self)
+
+    def setUp(self):
+        super().setUp()
+        try:
+            self.driver.setup()
+        except:
+            self.skipTest(f"Module {self.module_name} not found")
+        self.mockup.load()
+
+    def tearDown(self):
+        self.mockup.unload()
+        self.driver.teardown()
+        super().tearDown()
+
+    def assertRegEqual(self, reg, data, msg=None):
+        value = self.read_reg(reg)
+        self.assertEqual(value, data, msg)
+
+    def assertRegBitsEqual(self, reg, data, mask, msg=None):
+        value = self.read_reg(reg)
+        self.assertEqual(value & mask, data & mask, msg)
+
+    def assertRegsEqual(self, reg, data, msg=None):
+        value = self.read_regs(reg, len(data))
+        self.assertListEqual(value, data, msg)
diff --git a/tools/testing/kddv/kddv/core/device.py b/tools/testing/kddv/kddv/core/device.py
new file mode 100755
index 000000000000..db862890e9a4
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/device.py
@@ -0,0 +1,78 @@
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
+
+from pathlib import Path
+
+logger = logging.getLogger(__name__)
+
+class Device(object):
+    bus = None
+
+    def __init__(self, bus, driver, busid, addr, devid):
+        self.bus = bus
+        self.driver = driver
+        self.busid = busid
+        self.addr = addr
+        self.devid = devid
+        self.status = False
+        self.path = Path(f"/sys/bus/{self.bus}/devices/{self.device_id}")
+
+    def __enter__(self):
+        self.bind()
+        return self
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        self.unbind()
+
+    def __del__(self):
+        self.unbind()
+
+    @classmethod
+    def create(cls, bus, driver, busid, addr, devid):
+        for subclass in cls.__subclasses__():
+            if subclass.bus == bus:
+                return subclass(bus, driver, busid, addr, devid)
+        return cls(bus, driver, busid, addr, devid)
+
+    @property
+    def device_id(self):
+        return self.devid
+
+    def bind(self):
+        if self.status is True:
+            return
+        self.status = True
+        self.driver.bind(self.device_id)
+
+    def unbind(self):
+        if self.status is False:
+            return
+        try:
+            self.driver.unbind(self.device_id)
+        except:
+            pass
+        self.status = False
+
+    def read_attr(self, attr):
+        path = self.path / attr
+        if not os.path.exists(path):
+            logger.info(f"attr '{attr}' not exists")
+            return None
+        logger.debug(f"read from {path}")
+        return path.read_text().rstrip()
+
+    def write_attr(self, attr, val):
+        path = self.path / attr
+        if not os.path.exists(path):
+            logger.info(f"attr '{attr}' not exists")
+            return
+        logger.debug(f"write '{val}' to {path}")
+        return path.write_bytes(val.encode())
diff --git a/tools/testing/kddv/kddv/core/driver.py b/tools/testing/kddv/kddv/core/driver.py
new file mode 100755
index 000000000000..55ad804068b5
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/driver.py
@@ -0,0 +1,79 @@
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
+import subprocess
+from pathlib import Path
+
+from .device import Device
+
+logger = logging.getLogger(__name__)
+
+class Driver(object):
+    def __init__(self, p):
+        self.bus = p.bus
+        self.domain_nr = p.domain_nr
+        self.bus_id = p.bus_id
+        self.parent_bus = p.parent_bus
+        self.driver = p.driver_name
+        self.module = p.module_name
+        self.depmod = p.dependencies
+        self.path = Path(f"/sys/bus/{self.bus}/drivers/{self.driver}")
+
+    def write_ctrl(self, spath, val):
+        path = self.path / spath
+        logger.debug(f"write '{val}' to {path}")
+        return path.write_text(val)
+
+    def disable_autoprobe(self):
+        logger.debug(f"disable {self.bus} drivers autoprobe")
+        path = Path(f"/sys/bus/{self.bus}/drivers_autoprobe")
+        path.write_text("0")
+
+    def enable_autoprobe(self):
+        logger.debug(f"enable {self.bus} drivers autoprobe")
+        path = Path(f"/sys/bus/{self.bus}/drivers_autoprobe")
+        path.write_text("1")
+
+    def probe_depmod(self):
+        if not self.depmod:
+            return
+        for mod in self.depmod:
+            logger.debug(f'modprobe {mod}')
+            subprocess.check_output(["/sbin/modprobe", mod])
+
+    def probe_module(self):
+        self.probe_depmod()
+        logger.debug(f'modprobe {self.module}')
+        subprocess.check_output(
+            ["/sbin/modprobe", self.module], stderr=subprocess.STDOUT
+        )
+
+    def remove_mdule(self):
+        logger.debug(f'rmmod {self.module}')
+        subprocess.check_output(["/sbin/rmmod", self.module])
+
+    def setup(self):
+        self.disable_autoprobe()
+        self.probe_module()
+
+    def teardown(self):
+        self.remove_mdule()
+        self.enable_autoprobe()
+
+    def bind(self, devid):
+        if os.path.exists(self.path / devid):
+            return
+        self.write_ctrl("bind", devid)
+
+    def unbind(self, devid):
+        self.write_ctrl("unbind", devid)
+
+    def device(self, addr, devid):
+        return Device.create(self.bus, self, self.bus_id, addr, devid)
diff --git a/tools/testing/kddv/kddv/core/mockup.py b/tools/testing/kddv/kddv/core/mockup.py
new file mode 100755
index 000000000000..b5e6c83c9164
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/mockup.py
@@ -0,0 +1,157 @@
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
+import json
+import struct
+import logging
+import subprocess
+
+from pathlib import Path
+
+logger = logging.getLogger(__name__)
+
+ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
+ROOT_BPF = os.path.join(ROOT_DIR, 'data', 'bpf')
+DEST_BPF = '/sys/fs/bpf'
+
+class Mockup(object):
+    bus = None
+
+    def __init__(self, bus, p) -> None:
+        self.bus = bus
+        self.bpf = p.bpf
+        self.addr = p.address
+        self.devid = p.device_id
+        self.regshift = p.regshift
+        self.regbytes = p.regbytes
+        self.valbytes = p.valbytes
+        self.regmaps = p.regmaps
+
+    @classmethod
+    def create(cls, bus, p):
+        for sub in cls.__subclasses__():
+            if sub.bus == bus:
+                return sub(bus, p)
+        return cls(bus, p)
+
+    @property
+    def device_id(self):
+        return f"{self.addr}"
+
+    @property
+    def bpftool(self):
+        return os.environ.get('BPFTOOL_PATH', 'bpftool')
+
+    def get_valbytes(self):
+        if self.valbytes == 3:
+            return 4
+        return self.valbytes
+
+    def search_file(self, path, filename):
+        for curfile in os.listdir(path):
+            abspath = os.path.join(path, curfile)
+            if os.path.isdir(abspath):
+                subfile = self.search_file(abspath, filename)
+                if subfile is not None:
+                    return subfile
+            if curfile == filename:
+                return abspath
+        return None
+
+    def bpf_prog_name(self):
+        bpf_name = re.sub("-", "_", os.path.basename(self.bpf))
+        return f'{bpf_name}'[:15]
+
+    def load_bpf(self):
+        if self.bpf is None:
+            return
+        bpf_file = self.search_file(ROOT_BPF, f"{self.bpf}.o")
+        if bpf_file is None:
+            logger.error(f'bpf file {self.bpf} not found')
+            return
+        logger.debug(f'load bpf {self.bpf}.o')
+        bpf_path = os.path.join(DEST_BPF, self.bpf_prog_name())
+        if os.path.exists(bpf_path):
+            os.unlink(bpf_path)
+        cmds = [self.bpftool, 'prog', 'load']
+        cmds += [bpf_file, bpf_path]
+        cmds += ['autoattach']
+        logger.debug(' '.join(cmds))
+        subprocess.check_output(cmds)
+
+    def unload_bpf(self):
+        if self.bpf is None:
+            return
+        logger.debug(f'unload bpf {self.bpf}.o')
+        bpf_path = os.path.join(DEST_BPF, self.bpf_prog_name())
+        if os.path.exists(bpf_path):
+            os.unlink(bpf_path)
+
+    def create_device(self):
+        pass
+
+    def remove_device(self):
+        pass
+
+    def load(self):
+        self.load_bpf()
+        self.load_regmaps()
+        self.create_device()
+
+    def unload(self):
+        self.remove_device()
+        self.unload_bpf()
+
+    def bpf_map_name(self):
+        bpf_name = re.sub("-", "_", self.bpf)
+        return f'regs_{bpf_name}'[:15]
+
+    def to_bpf_bytes(self, val, len):
+        return list("%d" % n for n in list(val.to_bytes(len, 'little')))
+
+    def load_regmaps(self):
+        for reg, value in self.regmaps.items():
+            if isinstance(value, list):
+                self.write_regs(reg, value)
+            else:
+                self.write_reg(reg, value)
+
+    def read_reg(self, addr):
+        if self.bpf is None:
+            return
+        cmds = [self.bpftool, 'map', 'lookup']
+        cmds += ['name', self.bpf_map_name()]
+        cmds += ['key']
+        cmds += self.to_bpf_bytes(addr, 4)
+        logger.debug(' '.join(cmds))
+        mapval = subprocess.check_output(cmds)
+        return json.loads(mapval).get("value", 0)
+
+    def read_regs(self, addr, len):
+        data = []
+        for i in range(len):
+            data += [self.read_reg(addr + (i << self.regshift))]
+        return data
+
+    def write_reg(self, addr, val):
+        if self.bpf is None:
+            return
+        cmds = [self.bpftool, 'map', 'update']
+        cmds += ['name', self.bpf_map_name()]
+        cmds += ['key']
+        cmds += self.to_bpf_bytes(addr, 4)
+        cmds += ['value']
+        cmds += self.to_bpf_bytes(val, self.get_valbytes())
+        logger.debug(' '.join(cmds))
+        subprocess.check_output(cmds)
+
+    def write_regs(self, addr, data):
+        for i in range(len(data)):
+            self.write_reg(addr + (i << self.regshift), data[i])
diff --git a/tools/testing/kddv/kddv/core/model.py b/tools/testing/kddv/kddv/core/model.py
new file mode 100755
index 000000000000..9da4716df7dc
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/model.py
@@ -0,0 +1,87 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+from .driver import Driver
+from .mockup import Mockup
+
+class DriverModel(object):
+    bus = None
+    name = None
+    addr = 0x00
+
+    def __init__(self):
+        self.driver = Driver(self)
+        self.mockup = Mockup.create(self.bus, self)
+
+    @property
+    def driver_name(self):
+        return self.name
+
+    @property
+    def module_name(self):
+        return self.name
+
+    @property
+    def dependencies(self):
+        """List of module dependencies by running tests."""
+        return None
+
+    @property
+    def domain_nr(self):
+        return 0
+
+    @property
+    def bus_id(self):
+        return 0
+
+    @property
+    def parent_bus(self):
+        return None
+
+    @property
+    def bpf(self):
+        return None
+
+    @property
+    def address(self):
+        return self.addr
+
+    @property
+    def device_id(self):
+        return self.name
+
+    @property
+    def regshift(self):
+        return 0
+
+    @property
+    def regbytes(self):
+        return 1
+
+    @property
+    def valbytes(self):
+        return 1
+
+    @property
+    def regmaps(self):
+        return {}
+
+    def device(self):
+        return self.driver.device(self.address, self.device_id)
+
+    def read_reg(self, addr):
+        return self.mockup.read_reg(addr)
+
+    def read_regs(self, addr, len):
+        return self.mockup.read_regs(addr, len)
+
+    def write_reg(self, addr, val):
+        self.mockup.write_reg(addr, val)
+
+    def write_regs(self, addr, data):
+        self.mockup.write_regs(addr, data)
diff --git a/tools/testing/kddv/kddv/tests/__init__.py b/tools/testing/kddv/kddv/tests/__init__.py
new file mode 100755
index 000000000000..e69de29bb2d1
-- 
2.34.1

