Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48DC7EFF0E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjKRKmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjKRKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:44 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B210C1;
        Sat, 18 Nov 2023 02:41:40 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgg3ydbz4f3k6f;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 29E341A016F;
        Sat, 18 Nov 2023 18:41:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S16;
        Sat, 18 Nov 2023 18:41:38 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 12/14] kddv/tests: Add support for testing mtd driver
Date:   Sat, 18 Nov 2023 18:40:38 +0800
Message-Id: <20231118104040.386381-13-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S16
X-Coremail-Antispam: 1UD129KBjvJXoW7AF13WrWUGF45uryfZrWkJFb_yoW8Kw1rpa
        yfAa1Y9r17Zr13GwsakFy7X39Y9r4kCFW7GrZrAr4j9rnxK34SqFW7K34Yq3W5tFyxWFWS
        vrWv9FWxuF47A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
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

This implement some helper function for mtd device,
mtd driver test case can inherit 'MTDDriver' to simplify code.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu@huawei.com>
---
 tools/testing/kddv/kddv/tests/mtd/__init__.py | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 tools/testing/kddv/kddv/tests/mtd/__init__.py

diff --git a/tools/testing/kddv/kddv/tests/mtd/__init__.py b/tools/testing/kddv/kddv/tests/mtd/__init__.py
new file mode 100644
index 000000000000..4defd92deb05
--- /dev/null
+++ b/tools/testing/kddv/kddv/tests/mtd/__init__.py
@@ -0,0 +1,63 @@
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
+class MTD(object):
+    def __init__(self, path):
+        mtd = next(path.glob("mtd/mtd*")).name
+        self.cdev = Path(f"/sys/class/mtd/{mtd}")
+        self.rdev = f"/dev/{mtd}"
+
+    def read_bytes(self, len, offset = 0):
+        with open(self.rdev, "rb") as dev:
+            if offset:
+                dev.seek(offset)
+            return dev.read(len)
+
+    def write_bytes(self, data, offset = 0):
+        with open(self.rdev, "wb") as dev:
+            if offset:
+                dev.seek(offset)
+            dev.write(data)
+
+    def read_attr(self, attr):
+        path = self.cdev / attr
+        logger.debug(f"read from {path}")
+        if not os.path.exists(path):
+            return f"attr '{attr}' not exists"
+        return path.read_text().rstrip()
+
+    def write_attr(self, attr, val):
+        path = self.cdev / attr
+        if not os.path.exists(path):
+            return f"attr '{attr}' not exists"
+        logger.debug(f"write '{val}' to {path}")
+        return path.write_bytes(val.encode())
+
+class MTDDriver(object):
+    def mtd_read_attr(self, dev, attr):
+        mtddev = MTD(dev.path)
+        return mtddev.read_attr(attr)
+
+    def mtd_write_attr(self, dev, attr, val):
+        mtddev = MTD(dev.path)
+        return mtddev.write_attr(attr)
+
+    def mtd_read_bytes(self, dev, len):
+        mtddev = MTD(dev.path)
+        return mtddev.read_bytes(len)
+
+    def mtd_write_bytes(self, dev, data):
+        mtddev = MTD(dev.path)
+        return mtddev.write_bytes(data)
-- 
2.34.1

