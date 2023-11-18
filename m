Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05557EFF08
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjKRKmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjKRKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:44 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C861D10D0;
        Sat, 18 Nov 2023 02:41:40 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgd4krCz4f3lg9;
        Sat, 18 Nov 2023 18:41:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id C5AE71A016E;
        Sat, 18 Nov 2023 18:41:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S15;
        Sat, 18 Nov 2023 18:41:37 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 11/14] kddv/tests/hwmon: Add test cases for max31722 driver
Date:   Sat, 18 Nov 2023 18:40:37 +0800
Message-Id: <20231118104040.386381-12-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S15
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy5Aw1xKFW7AFWkJF4fKrg_yoW8ZF15pF
        1fGr1Y9Fn2qr1fXwnakF1a9FyrZF4xuF4Ykr47Aw15WFn8JrySkrZIkFyUAF13XrWFgFWr
        Z348WF4akw43JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIx
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

This add test case for max31722 hwmon driver, test for
the device loading and read temperature from the device.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 .../kddv/kddv/tests/hwmon/test_max31722.py    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tools/testing/kddv/kddv/tests/hwmon/test_max31722.py

diff --git a/tools/testing/kddv/kddv/tests/hwmon/test_max31722.py b/tools/testing/kddv/kddv/tests/hwmon/test_max31722.py
new file mode 100755
index 000000000000..70223eb0ef7b
--- /dev/null
+++ b/tools/testing/kddv/kddv/tests/hwmon/test_max31722.py
@@ -0,0 +1,40 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+from kddv.core import SPIDriverTest
+from kddv.core.consts import CFG_REG_MASK
+from . import HwMonDriver
+import errno
+
+MAX31722_REG_CFG = 0x00
+MAX31722_REG_TEMP_LSB = 0x01
+MAX31722_MODE_CONTINUOUS = 0x00
+MAX31722_RESOLUTION_12BIT = 0x06
+
+class TestMax31722(SPIDriverTest, HwMonDriver):
+    name = 'max31722'
+
+    @property
+    def configs(self):
+        return { CFG_REG_MASK: 0x7f }
+
+    def test_device_probe(self):
+        with self.assertRaisesFault():
+            with self.device() as dev:
+                self.assertRegEqual(MAX31722_REG_CFG, MAX31722_RESOLUTION_12BIT)
+
+    def test_read_temp_input(self):
+        with self.device() as dev:
+            self.write_regs(MAX31722_REG_TEMP_LSB, [0x12, 0x34])
+            temp = self.hwmon_read_temp_input(dev)
+            self.assertEqual(temp, int(0x3412 * 125 / 32))
+
+            self.trigger_io_fault()
+            with self.assertRaises(OSError) as cm:
+                self.hwmon_read_temp_input(dev)
+            self.assertEqual(cm.exception.errno, errno.EIO)
-- 
2.34.1

