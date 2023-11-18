Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252867EFF03
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjKRKlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjKRKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:42 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9EA10C1;
        Sat, 18 Nov 2023 02:41:37 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgZ2z5Wz4f3lfQ;
        Sat, 18 Nov 2023 18:41:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 8846F1A016F;
        Sat, 18 Nov 2023 18:41:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S6;
        Sat, 18 Nov 2023 18:41:34 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 02/14] kddv/core: Allow test case config bpf program
Date:   Sat, 18 Nov 2023 18:40:28 +0800
Message-Id: <20231118104040.386381-3-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1kAryrZryxCF18ur13XFb_yoWxXF18pF
        WfGFW7Cr1kAr4S9rnY9F9rJF4rXrsrWFy8ArykXa47ur1xWr1rCr4xt3WYyF93Wr97trWr
        Z3ySgF4UCrWxZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07je89NUUUUU=
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

Allow test case config bpf program read/write regs.

@property
def configs(self):
    return { CFG_REG_MASK: 0x3f }

CFG_REG_MASK: mask reg before use
CFG_REG_RSH: right shift reg before use
CFG_REG_LSH: left shift reg before use
CFG_REG_ORD: swap reg byteorder before use

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 tools/testing/kddv/kddv/core/consts.py        |  12 ++
 tools/testing/kddv/kddv/core/mockup.py        |  28 +++++
 tools/testing/kddv/kddv/core/model.py         |   4 +
 .../kddv/data/bpf/include/bpf-xfer-conf.h     | 111 ++++++++++++++++++
 4 files changed, 155 insertions(+)
 create mode 100755 tools/testing/kddv/kddv/core/consts.py
 create mode 100644 tools/testing/kddv/kddv/data/bpf/include/bpf-xfer-conf.h

diff --git a/tools/testing/kddv/kddv/core/consts.py b/tools/testing/kddv/kddv/core/consts.py
new file mode 100755
index 000000000000..22abd7fc655c
--- /dev/null
+++ b/tools/testing/kddv/kddv/core/consts.py
@@ -0,0 +1,12 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+CFG_REG_MASK = 0x10
+CFG_REG_RSH = 0x11
+CFG_REG_LSH = 0x12
+CFG_REG_ORD = 0x13
diff --git a/tools/testing/kddv/kddv/core/mockup.py b/tools/testing/kddv/kddv/core/mockup.py
index b5e6c83c9164..8bea2db97232 100755
--- a/tools/testing/kddv/kddv/core/mockup.py
+++ b/tools/testing/kddv/kddv/core/mockup.py
@@ -29,6 +29,7 @@ class Mockup(object):
         self.bpf = p.bpf
         self.addr = p.address
         self.devid = p.device_id
+        self.configs = p.configs
         self.regshift = p.regshift
         self.regbytes = p.regbytes
         self.valbytes = p.valbytes
@@ -103,6 +104,7 @@ class Mockup(object):
     def load(self):
         self.load_bpf()
         self.load_regmaps()
+        self.load_configs()
         self.create_device()
 
     def unload(self):
@@ -116,6 +118,32 @@ class Mockup(object):
     def to_bpf_bytes(self, val, len):
         return list("%d" % n for n in list(val.to_bytes(len, 'little')))
 
+    def write_bpf_map(self, name, addr, val):
+        cmds = [self.bpftool, 'map', 'update']
+        cmds += ['name', name]
+        cmds += ['key']
+        cmds += self.to_bpf_bytes(addr, 4)
+        cmds += ['value']
+        cmds += self.to_bpf_bytes(val, 4)
+        logger.debug(' '.join(cmds))
+        subprocess.check_output(cmds)
+
+    def write_config(self, addr, val):
+        if self.bpf is None:
+            return
+        self.write_bpf_map('bpf_xfer_conf', addr, val)
+
+    def write_configs(self, addr, data):
+        for i in range(len(data)):
+            self.write_config(addr + i, data[i])
+
+    def load_configs(self):
+        for reg, value in self.configs.items():
+            if isinstance(value, list):
+                self.write_configs(reg, value)
+            else:
+                self.write_config(reg, value)
+
     def load_regmaps(self):
         for reg, value in self.regmaps.items():
             if isinstance(value, list):
diff --git a/tools/testing/kddv/kddv/core/model.py b/tools/testing/kddv/kddv/core/model.py
index 9da4716df7dc..494b69566536 100755
--- a/tools/testing/kddv/kddv/core/model.py
+++ b/tools/testing/kddv/kddv/core/model.py
@@ -67,6 +67,10 @@ class DriverModel(object):
     def valbytes(self):
         return 1
 
+    @property
+    def configs(self):
+        return {}
+
     @property
     def regmaps(self):
         return {}
diff --git a/tools/testing/kddv/kddv/data/bpf/include/bpf-xfer-conf.h b/tools/testing/kddv/kddv/data/bpf/include/bpf-xfer-conf.h
new file mode 100644
index 000000000000..49adbcc6a1af
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/include/bpf-xfer-conf.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * The bpf program of control xfer configuration
+ *
+ * Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+ */
+
+#ifndef __BPF_XFER_CONF_
+#define __BPF_XFER_CONF_
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#define CONF_REGS_SIZE		0x100
+
+#define BPF_CONF_REG_MASK	0x10
+#define BPF_CONF_REG_RSHIFT	0x11
+#define BPF_CONF_REG_LSHIFT	0x12
+#define BPF_CONF_REG_XBSWAP	0x13
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CONF_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u32);
+} bpf_xfer_conf SEC(".maps");
+
+static u32 bpf_reg_mask, bpf_reg_xbswap;
+static u32 bpf_reg_rshift, bpf_reg_lshift;
+
+static u32 bpf_xfer_read_conf(u32 key)
+{
+	u32 *reg;
+
+	reg = bpf_map_lookup_elem(&bpf_xfer_conf, &key);
+	if (!reg) {
+		bpf_printk("config key %d not exists", key);
+		return 0;
+	}
+
+	return *reg;
+}
+
+static int bpf_xfer_write_conf(u32 key, u32 value)
+{
+	if (bpf_map_update_elem(&bpf_xfer_conf, &key, &value,
+				BPF_EXIST)) {
+		bpf_printk("config key %d not exists", key);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int bpf_xfer_update_config(void)
+{
+	bpf_reg_mask = bpf_xfer_read_conf(BPF_CONF_REG_MASK);
+	bpf_reg_rshift = bpf_xfer_read_conf(BPF_CONF_REG_RSHIFT);
+	bpf_reg_lshift = bpf_xfer_read_conf(BPF_CONF_REG_LSHIFT);
+	bpf_reg_xbswap = bpf_xfer_read_conf(BPF_CONF_REG_XBSWAP);
+
+	return 0;
+}
+
+u8 bpf_xfer_reg_u8(u8 reg)
+{
+	reg = reg & (bpf_reg_mask ? bpf_reg_mask : 0xff);
+	if (bpf_reg_rshift)
+		reg = reg >> bpf_reg_rshift;
+	if (bpf_reg_lshift)
+		reg = reg << bpf_reg_lshift;
+	return reg;
+}
+
+u16 bpf_xfer_reg_u16(u16 reg)
+{
+	if (bpf_reg_xbswap)
+		reg = __builtin_bswap16(reg);
+	reg = reg & (bpf_reg_mask ? bpf_reg_mask : 0x7fff);
+	if (bpf_reg_rshift)
+		reg = reg >> bpf_reg_rshift;
+	if (bpf_reg_lshift)
+		reg = reg << bpf_reg_lshift;
+	return reg;
+}
+
+u32 bpf_xfer_reg_u24(u32 reg)
+{
+	if (bpf_reg_xbswap)
+		reg = __builtin_bswap32(reg);
+	reg = reg & (bpf_reg_mask ? bpf_reg_mask : 0x7fffff);
+	if (bpf_reg_rshift)
+		reg = reg >> bpf_reg_rshift;
+	if (bpf_reg_lshift)
+		reg = reg << bpf_reg_lshift;
+	return reg;
+}
+
+u32 bpf_xfer_reg_u32(u32 reg)
+{
+	if (bpf_reg_xbswap)
+		reg = __builtin_bswap32(reg);
+	reg = reg & (bpf_reg_mask ? bpf_reg_mask : 0x7fffffff);
+	if (bpf_reg_rshift)
+		reg = reg >> bpf_reg_rshift;
+	if (bpf_reg_lshift)
+		reg = reg << bpf_reg_lshift;
+	return reg;
+}
+#endif
-- 
2.34.1

