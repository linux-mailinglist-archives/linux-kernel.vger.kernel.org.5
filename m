Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38B7EFF11
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjKRKmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKRKlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:45 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63BED7E;
        Sat, 18 Nov 2023 02:41:39 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SXVgg4Lmfz4f3kFX;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 1AC471A0176;
        Sat, 18 Nov 2023 18:41:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S13;
        Sat, 18 Nov 2023 18:41:36 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 09/14] kddv/core: Add test support for SPI driver
Date:   Sat, 18 Nov 2023 18:40:35 +0800
Message-Id: <20231118104040.386381-10-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S13
X-Coremail-Antispam: 1UD129KBjvAXoWfXrWkKF4kJw17tw47tF1UWrg_yoW5Jry7Zo
        WfWF4rAF4IkFZrWan0ga4rX34xWrWkKrZrJF45Cw1UZF4jvw17Jr48Cw43XasIvayxK34r
        WF1fZ3yfJa18tr95n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYq7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
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
        MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
        nIWIevJa73UjIFyTuYvjxUFgAwUUUUU
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

The spi driver test case should inherit the 'SPIDriverTest'
and config the driver as below:

  MAX31722_REG_CFG = 0x00
  MAX31722_RESOLUTION_12BIT = 0x06

  class TestMax31722(SPIDriverTest):
      name = 'max31722'

      @property
      def regbytes(self):
          return 1

      @property
      def valbytes(self):
          return 1

      @property
      def configs(self):
          return { CFG_REG_MASK: 0x7f }

      def test_device_probe(self):
          with self.assertRaisesFault():
              with self.device() as dev:
                  self.assertRegEqual(MAX31722_REG_CFG,
                                      MAX31722_RESOLUTION_12BIT)

The kddv can auto load the 'spi-xfer-r{regbytes}v{valbytes}.o' bpf
program as the mock device chipsets.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu@huawei.com>
---
 tools/testing/kddv/kddv/Makefile              |  5 +
 tools/testing/kddv/kddv/core/__init__.py      |  6 ++
 .../testing/kddv/kddv/core/buses/__init__.py  | 13 +++
 tools/testing/kddv/kddv/core/buses/spi.py     | 74 ++++++++++++++
 tools/testing/kddv/kddv/core/mockup.py        |  8 ++
 tools/testing/kddv/kddv/data/Makefile         | 21 ++++
 tools/testing/kddv/kddv/data/bpf/Makefile     | 22 +++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-base.h    | 99 +++++++++++++++++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r1v1.c    | 51 ++++++++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r1v2.c    | 51 ++++++++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r1v3.c    | 86 ++++++++++++++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r2v1.c    | 51 ++++++++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r2v2.c    | 51 ++++++++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r3v1.c    | 52 ++++++++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r4v4.c    | 89 +++++++++++++++++
 15 files changed, 679 insertions(+)
 create mode 100755 tools/testing/kddv/kddv/core/buses/__init__.py
 create mode 100755 tools/testing/kddv/kddv/core/buses/spi.py
 create mode 100644 tools/testing/kddv/kddv/data/Makefile
 create mode 100644 tools/testing/kddv/kddv/data/bpf/Makefile
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-base.h
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v1.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v2.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v3.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v1.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v2.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r3v1.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r4v4.c

diff --git a/tools/testing/kddv/kddv/Makefile b/tools/testing/kddv/kddv/Makefile
index a5c91fcb0e9a..b7a12069e443 100644
--- a/tools/testing/kddv/kddv/Makefile
+++ b/tools/testing/kddv/kddv/Makefile
@@ -2,6 +2,7 @@
 include ../../../scripts/Makefile.include
 
 INSTALL ?= install
+SUBDIRS := data
 
 all:
 	@for SUBDIR in $(SUBDIRS); do		\
@@ -15,6 +16,10 @@ install:
 	cp -rf cmds/ $(INSTALL_PATH)
 	cp -rf tests/ $(INSTALL_PATH)
 
+	@for SUBDIR in $(SUBDIRS); do		\
+		$(MAKE) INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR -C $$SUBDIR install; \
+	done;
+
 clean:
 	@for SUBDIR in $(SUBDIRS); do		\
 		$(MAKE) -C $$SUBDIR clean;	\
diff --git a/tools/testing/kddv/kddv/core/__init__.py b/tools/testing/kddv/kddv/core/__init__.py
index 45a35c909e86..601464c0e9ed 100755
--- a/tools/testing/kddv/kddv/core/__init__.py
+++ b/tools/testing/kddv/kddv/core/__init__.py
@@ -5,3 +5,9 @@
 #
 # Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
 # Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+__all__ = [
+    'SPIDriverTest',
+]
+
+from .buses import SPIDriverTest
diff --git a/tools/testing/kddv/kddv/core/buses/__init__.py b/tools/testing/kddv/kddv/core/buses/__init__.py
new file mode 100755
index 000000000000..1cbd4bed181a
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/buses/__init__.py
@@ -0,0 +1,13 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+__all__ = [
+    'SPIDriverTest',
+]
+
+from .spi import SPIDriverTest
diff --git a/tools/testing/kddv/kddv/core/buses/spi.py b/tools/testing/kddv/kddv/core/buses/spi.py
new file mode 100755
index 000000000000..13c96de5b7bd
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/buses/spi.py
@@ -0,0 +1,74 @@
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
+from pathlib import Path
+
+from ..ddunit import DriverTest
+from ..device import Device
+from ..mockup import Mockup
+
+logger = logging.getLogger(__name__)
+
+class SPIDriverTest(DriverTest):
+    bus = 'spi'
+
+    @property
+    def bpf(self):
+        return f'spi-xfer-r{self.regbytes}v{self.valbytes}'
+
+class SPIDevice(Device):
+    bus = 'spi'
+
+    @property
+    def device_id(self):
+        return f"{self.bus}{self.busid}.{self.addr}"
+
+SPI_MASTER_PATH = '/sys/class/spi_master/spi0'
+
+class SPIMockup(Mockup):
+    bus = 'spi'
+    host = Path('/sys/kernel/config/spi-mockup/spi0')
+    live = Path('/sys/kernel/config/spi-mockup/spi0/live')
+
+    def setup(self):
+        logger.debug('setup')
+        if not self.host.exists():
+            self.host.mkdir()
+
+        self.live.write_text('true')
+
+    def teardown(self):
+        logger.debug('spi mockup teardown')
+        self.live.write_text('false')
+        self.host.rmdir()
+
+    @property
+    def device_id(self):
+        return f"{self.devid} {self.addr}"
+
+    def create_device(self):
+        logger.debug(f'new device {self.devid} to spi bus')
+        dev = Path(f'/sys/kernel/config/spi-mockup/spi0/targets/{self.devid}')
+        if not dev.exists():
+            dev.mkdir()
+        device_id = Path(f'/sys/kernel/config/spi-mockup/spi0/targets/{self.devid}/device_id')
+        device_id.write_text(self.devid)
+
+        device_live = Path(f'/sys/kernel/config/spi-mockup/spi0/targets/{self.devid}/live')
+        device_live.write_text('true')
+
+    def remove_device(self):
+        logger.debug(f'delete device {self.devid} from spi bus')
+        logger.debug(f'delete device {self.devid} to spi bus')
+        device_live = Path(f'/sys/kernel/config/spi-mockup/spi0/targets/{self.devid}/live')
+        device_live.write_text('false')
+        dev = Path(f'/sys/kernel/config/spi-mockup/spi0/targets/{self.devid}')
+        dev.rmdir()
+
diff --git a/tools/testing/kddv/kddv/core/mockup.py b/tools/testing/kddv/kddv/core/mockup.py
index 8bea2db97232..cf23dd711ca0 100755
--- a/tools/testing/kddv/kddv/core/mockup.py
+++ b/tools/testing/kddv/kddv/core/mockup.py
@@ -101,7 +101,14 @@ class Mockup(object):
     def remove_device(self):
         pass
 
+    def setup(self):
+        pass
+
+    def teardown(self):
+        pass
+
     def load(self):
+        self.setup()
         self.load_bpf()
         self.load_regmaps()
         self.load_configs()
@@ -110,6 +117,7 @@ class Mockup(object):
     def unload(self):
         self.remove_device()
         self.unload_bpf()
+        self.teardown()
 
     def bpf_map_name(self):
         bpf_name = re.sub("-", "_", self.bpf)
diff --git a/tools/testing/kddv/kddv/data/Makefile b/tools/testing/kddv/kddv/data/Makefile
new file mode 100644
index 000000000000..0e82984b99a9
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../../scripts/Makefile.include
+
+SUBDIRS := bpf
+
+all:
+	@for SUBDIR in $(SUBDIRS); do \
+		$(MAKE) -C $$SUBDIR;\
+	done;
+
+install:
+	@for SUBDIR in $(SUBDIRS); do \
+		$(MAKE) INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR -C $$SUBDIR install;\
+	done;
+
+clean:
+	@for SUBDIR in $(SUBDIRS); do \
+		$(MAKE) -C $$SUBDIR clean;\
+	done;
+
+.PHONY: all install clean
diff --git a/tools/testing/kddv/kddv/data/bpf/Makefile b/tools/testing/kddv/kddv/data/bpf/Makefile
new file mode 100644
index 000000000000..f693f8da1034
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../../../scripts/Makefile.include
+
+CC	= clang
+INSTALL ?= install
+
+bpf-objs-y := $(patsubst %.c,%.o,$(wildcard */*.c))
+
+CFLAGS += -I../../../../../bpf/bpftool/ -I../../../../../bpf/bpftool/libbpf/include
+CFLAGS += -Iinclude -Ispi
+
+all: $(bpf-objs-y)
+
+%.o: %.c
+	$(CC) -target bpf -Wall -O2 $(CFLAGS) -g -c $< -o $@
+
+install:
+	$(INSTALL) -m 0755 -d $(INSTALL_PATH)
+	$(INSTALL) $(bpf-objs-y) $(INSTALL_PATH)
+
+clean:
+	rm -rf $(bpf-objs-y)
diff --git a/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-base.h b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-base.h
new file mode 100644
index 000000000000..8a33e6049dbc
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-base.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * The spi xfer helpers for bpf program
+ *
+ * Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+ */
+
+#ifndef __SPI_XFER_BASE_
+#define __SPI_XFER_BASE_
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+int spi_xfer_read_u8(struct spi_msg_ctx *msg, unsigned int len,
+		     void *map, unsigned int reg, int offset)
+{
+	unsigned int i, key = reg;
+	u8 *value;
+
+	for (i = offset; i < len && i < sizeof(msg->data); i++, key++) {
+		value = bpf_map_lookup_elem(map, &key);
+		if (!value) {
+			bpf_printk("key 0x%x not exists", key);
+			return -1;
+		}
+
+		msg->data[i] = *value;
+
+		bpf_printk("SPI R8 [0x%x]=0x%x", key, msg->data[i]);
+	}
+
+	return 0;
+}
+
+int spi_xfer_write_u8(struct spi_msg_ctx *msg, unsigned int len,
+		      void *map, unsigned int reg, int offset)
+{
+	unsigned int i, key = reg;
+	u8 value;
+
+	for (i = offset; i < len && i < sizeof(msg->data); i++, key++) {
+		value = msg->data[i];
+
+		if (bpf_map_update_elem(map, &key, &value, BPF_EXIST)) {
+			bpf_printk("key 0x%x not exists", key);
+			return -1;
+		}
+
+		bpf_printk("SPI W8 [0x%x]=0x%x [%u/%u]", key, value, i, len);
+	}
+
+	return 0;
+}
+
+int spi_xfer_read_u16(struct spi_msg_ctx *msg, unsigned int len,
+		      void *map, unsigned int reg, int offset)
+{
+	unsigned int i, key = reg;
+	u16 *value;
+
+	for (i = offset; i < len && i < sizeof(msg->data) - 1; i += 2, key++) {
+		value = bpf_map_lookup_elem(map, &key);
+		if (!value) {
+			bpf_printk("key 0x%x not exists", key);
+			return -1;
+		}
+
+		msg->data[i + 0] = *value >> 8;
+		msg->data[i + 1] = *value & 0xff;
+
+		bpf_printk("SPI R16 [0x%x]=0x%x [%u/%u]", key, *value, i, len);
+	}
+
+	return 0;
+}
+
+int spi_xfer_write_u16(struct spi_msg_ctx *msg, unsigned int len,
+		       void *map, unsigned int reg, int offset)
+{
+	unsigned int i, key = reg;
+	u16 value;
+
+	for (i = offset; i < len && i < sizeof(msg->data) - 1; i += 2, key++) {
+		value = msg->data[i];
+		value = (value << 8) | msg->data[i + 1];
+
+		if (bpf_map_update_elem(map, &key, &value, BPF_EXIST)) {
+			bpf_printk("key 0x%x not exists", key);
+			return -1;
+		}
+
+		bpf_printk("SPI W16 [0x%x]=0x%x [%u/%u]", key, value, i, len);
+	}
+
+	return 0;
+}
+
+#endif
diff --git a/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v1.c b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v1.c
new file mode 100644
index 000000000000..3e7252207e23
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v1.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <errno.h>
+
+#include "bpf-xfer-conf.h"
+#include "spi-xfer-base.h"
+
+#define CHIP_REGS_SIZE	0x100
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u8);
+} regs_spi_xfer_r1v1 SEC(".maps");
+
+static unsigned int chip_reg;
+
+static int spi_xfer_read(struct spi_msg_ctx *msg, unsigned int len)
+{
+	return spi_xfer_read_u8(msg, len, &regs_spi_xfer_r1v1, chip_reg, 0);
+}
+
+static int spi_xfer_write(struct spi_msg_ctx *msg, unsigned int len)
+{
+	chip_reg = bpf_xfer_reg_u8(msg->data[0]);
+	return spi_xfer_write_u8(msg, len, &regs_spi_xfer_r1v1, chip_reg, 1);
+}
+
+SEC("raw_tp.w/spi_transfer_writeable")
+int BPF_PROG(spi_xfer_r1v1, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+{
+	if (bpf_xfer_should_fault()) {
+		msg->ret = -EIO;
+		return 0;
+	}
+
+	if (msg->tx_nbits)
+		msg->ret = spi_xfer_write(msg, len);
+	else if (msg->rx_nbits)
+		msg->ret = spi_xfer_read(msg, len);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v2.c b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v2.c
new file mode 100644
index 000000000000..ef9ff13a573d
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v2.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <errno.h>
+
+#include "bpf-xfer-conf.h"
+#include "spi-xfer-base.h"
+
+#define CHIP_REGS_SIZE	0x100
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u16);
+} regs_spi_xfer_r1v2 SEC(".maps");
+
+static unsigned int chip_reg;
+
+static int spi_xfer_read(struct spi_msg_ctx *msg, unsigned int len)
+{
+	return spi_xfer_read_u16(msg, len, &regs_spi_xfer_r1v2, chip_reg, 0);
+}
+
+static int spi_xfer_write(struct spi_msg_ctx *msg, unsigned int len)
+{
+	chip_reg = bpf_xfer_reg_u8(msg->data[0]);
+	return spi_xfer_write_u16(msg, len, &regs_spi_xfer_r1v2, chip_reg, 1);
+}
+
+SEC("raw_tp.w/spi_transfer_writeable")
+int BPF_PROG(spi_xfer_r1v2, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+{
+	if (bpf_xfer_should_fault()) {
+		msg->ret = -EIO;
+		return 0;
+	}
+
+	if (msg->tx_nbits)
+		msg->ret = spi_xfer_write(msg, len);
+	else if (msg->rx_nbits)
+		msg->ret = spi_xfer_read(msg, len);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v3.c b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v3.c
new file mode 100644
index 000000000000..b720115d16d2
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v3.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <errno.h>
+
+#include "bpf-xfer-conf.h"
+#include "spi-xfer-base.h"
+
+#define CHIP_REGS_SIZE	0x100
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u32);
+} regs_spi_xfer_r1v3 SEC(".maps");
+
+static unsigned int chip_reg;
+
+static int spi_xfer_read(struct spi_msg_ctx *msg, unsigned int len)
+{
+	unsigned int i, key = chip_reg;
+	u32 *value;
+
+	for (i = 0; i < len && i < sizeof(msg->data) - 2; i += 3, key++) {
+		value = bpf_map_lookup_elem(&regs_spi_xfer_r1v3, &key);
+		if (!value) {
+			bpf_printk("key 0x%x not exists", key);
+			return -EINVAL;
+		}
+
+		msg->data[i + 0] = (*value >> 16) & 0xff;
+		msg->data[i + 1] = (*value >> 8) & 0xff;
+		msg->data[i + 2] = *value & 0xff;
+
+		bpf_printk("SPI R24 [0x%x]=0x%x [%u/%u]", key, *value, i, len);
+	}
+
+	return 0;
+}
+
+static int spi_xfer_write(struct spi_msg_ctx *msg, unsigned int len)
+{
+	unsigned int i, key;
+	u32 value;
+
+	chip_reg = bpf_xfer_reg_u8(msg->data[0]);
+	key = chip_reg;
+
+	for (i = 1; i < len && i < sizeof(msg->data) - 2; i += 3, key++) {
+		value = msg->data[i];
+		value = (value << 8) | msg->data[i + 1];
+		value = (value << 8) | msg->data[i + 2];
+
+		if (bpf_map_update_elem(&regs_spi_xfer_r1v3, &key, &value, BPF_EXIST)) {
+			bpf_printk("key 0x%x not exists", key);
+			return -EINVAL;
+		}
+
+		bpf_printk("SPI W24 [0x%x]=0x%x", key, value);
+	}
+
+	return 0;
+}
+
+SEC("raw_tp.w/spi_transfer_writeable")
+int BPF_PROG(spi_xfer_r1v3, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+{
+	if (bpf_xfer_should_fault()) {
+		msg->ret = -EIO;
+		return 0;
+	}
+
+	if (msg->tx_nbits)
+		msg->ret = spi_xfer_write(msg, len);
+	else if (msg->rx_nbits)
+		msg->ret = spi_xfer_read(msg, len);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v1.c b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v1.c
new file mode 100644
index 000000000000..c1e7942be327
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v1.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <errno.h>
+
+#include "bpf-xfer-conf.h"
+#include "spi-xfer-base.h"
+
+#define CHIP_REGS_SIZE	0x1000
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u8);
+} regs_spi_xfer_r2v1 SEC(".maps");
+
+static unsigned int chip_reg;
+
+static int spi_xfer_read(struct spi_msg_ctx *msg, unsigned int len)
+{
+	return spi_xfer_read_u8(msg, len, &regs_spi_xfer_r2v1, chip_reg, 0);
+}
+
+static int spi_xfer_write(struct spi_msg_ctx *msg, unsigned int len)
+{
+	chip_reg = bpf_xfer_reg_u16(msg->data[0] << 8 | msg->data[1]);
+	return spi_xfer_write_u8(msg, len, &regs_spi_xfer_r2v1, chip_reg, 2);
+}
+
+SEC("raw_tp.w/spi_transfer_writeable")
+int BPF_PROG(spi_xfer_r2v1, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+{
+	if (bpf_xfer_should_fault()) {
+		msg->ret = -EIO;
+		return 0;
+	}
+
+	if (msg->tx_nbits)
+		msg->ret = spi_xfer_write(msg, len);
+	else if (msg->rx_nbits)
+		msg->ret = spi_xfer_read(msg, len);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v2.c b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v2.c
new file mode 100644
index 000000000000..4076722824ba
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v2.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <errno.h>
+
+#include "bpf-xfer-conf.h"
+#include "spi-xfer-base.h"
+
+#define CHIP_REGS_SIZE	0x1000
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u16);
+} regs_spi_xfer_r2v2 SEC(".maps");
+
+static unsigned int chip_reg;
+
+static int spi_xfer_read(struct spi_msg_ctx *msg, unsigned int len)
+{
+	return spi_xfer_read_u16(msg, len, &regs_spi_xfer_r2v2, chip_reg, 0);
+}
+
+static int spi_xfer_write(struct spi_msg_ctx *msg, unsigned int len)
+{
+	chip_reg = bpf_xfer_reg_u16(msg->data[0] << 8 | msg->data[1]);
+	return spi_xfer_write_u16(msg, len, &regs_spi_xfer_r2v2, chip_reg, 2);
+}
+
+SEC("raw_tp.w/spi_transfer_writeable")
+int BPF_PROG(spi_xfer_r2v2, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+{
+	if (bpf_xfer_should_fault()) {
+		msg->ret = -EIO;
+		return 0;
+	}
+
+	if (msg->tx_nbits)
+		msg->ret = spi_xfer_write(msg, len);
+	else if (msg->rx_nbits)
+		msg->ret = spi_xfer_read(msg, len);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r3v1.c b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r3v1.c
new file mode 100644
index 000000000000..7f056b8a7bdb
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r3v1.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <errno.h>
+
+#include "bpf-xfer-conf.h"
+#include "spi-xfer-base.h"
+
+#define CHIP_REGS_SIZE	0x1000
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u8);
+} regs_spi_xfer_r3v1 SEC(".maps");
+
+static unsigned int chip_reg;
+
+static int spi_xfer_read(struct spi_msg_ctx *msg, unsigned int len)
+{
+	return spi_xfer_read_u8(msg, len, &regs_spi_xfer_r3v1, chip_reg, 0);
+}
+
+static int spi_xfer_write(struct spi_msg_ctx *msg, unsigned int len)
+{
+	chip_reg = bpf_xfer_reg_u24((msg->data[0] << 16) | (msg->data[1] << 8) |
+				    msg->data[2]);
+	return spi_xfer_write_u8(msg, len, &regs_spi_xfer_r3v1, chip_reg, 3);
+}
+
+SEC("raw_tp.w/spi_transfer_writeable")
+int BPF_PROG(spi_xfer_r3v1, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+{
+	if (bpf_xfer_should_fault()) {
+		msg->ret = -EIO;
+		return 0;
+	}
+
+	if (msg->tx_nbits)
+		msg->ret = spi_xfer_write(msg, len);
+	else if (msg->rx_nbits)
+		msg->ret = spi_xfer_read(msg, len);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r4v4.c b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r4v4.c
new file mode 100644
index 000000000000..70f839a2222a
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r4v4.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <errno.h>
+
+#include "bpf-xfer-conf.h"
+#include "spi-xfer-base.h"
+
+#define CHIP_REGS_SIZE	0x8000
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u32);
+} regs_spi_xfer_r4v4 SEC(".maps");
+
+static unsigned int chip_reg;
+
+static int spi_xfer_read(struct spi_msg_ctx *msg, unsigned int len)
+{
+	unsigned int i, key = chip_reg;
+	u32 *value;
+
+	for (i = 0; i < len && i < sizeof(msg->data) - 3; i += 4, key++) {
+		value = bpf_map_lookup_elem(&regs_spi_xfer_r4v4, &key);
+		if (!value) {
+			bpf_printk("key 0x%x not exists", key);
+			return -EINVAL;
+		}
+
+		msg->data[i + 0] = (*value >> 24) & 0xff;
+		msg->data[i + 1] = (*value >> 16) & 0xff;
+		msg->data[i + 2] = (*value >> 8) & 0xff;
+		msg->data[i + 3] = *value & 0xff;
+
+		bpf_printk("SPI R32 [0x%x]=0x%x [%u/%u]", key, *value, i, len);
+	}
+
+	return 0;
+}
+
+static int spi_xfer_write(struct spi_msg_ctx *msg, unsigned int len)
+{
+	unsigned int i, key;
+	u32 value;
+
+	key = bpf_xfer_reg_u32((msg->data[0] << 24) | (msg->data[1] << 16) |
+			       (msg->data[2] << 8) | msg->data[3]);
+	chip_reg = key;
+
+	for (i = 4; i < len && i < sizeof(msg->data) - 3; i += 4, key++) {
+		value = msg->data[i];
+		value = (value << 8) | msg->data[i + 1];
+		value = (value << 8) | msg->data[i + 2];
+		value = (value << 8) | msg->data[i + 3];
+
+		if (bpf_map_update_elem(&regs_spi_xfer_r4v4, &key, &value, 0)) {
+			bpf_printk("key 0x%x not exists", key);
+			return -EINVAL;
+		}
+
+		bpf_printk("SPI W32 [0x%x]=0x%x [%u/%u]", key, value, i, len);
+	}
+
+	return 0;
+}
+
+SEC("raw_tp.w/spi_transfer_writeable")
+int BPF_PROG(spi_xfer_r4v4, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+{
+	if (bpf_xfer_should_fault()) {
+		msg->ret = -EIO;
+		return 0;
+	}
+
+	if (msg->tx_nbits)
+		msg->ret = spi_xfer_write(msg, len);
+	else if (msg->rx_nbits)
+		msg->ret = spi_xfer_read(msg, len);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.34.1

