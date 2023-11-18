Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F887EFF10
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjKRKmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjKRKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:44 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F110DD;
        Sat, 18 Nov 2023 02:41:40 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SXVgg6k0Nz4f3kFr;
        Sat, 18 Nov 2023 18:41:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 6F8951A0175;
        Sat, 18 Nov 2023 18:41:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S14;
        Sat, 18 Nov 2023 18:41:37 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 10/14] kddv/tests: Add support for testing hwmon driver
Date:   Sat, 18 Nov 2023 18:40:36 +0800
Message-Id: <20231118104040.386381-11-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S14
X-Coremail-Antispam: 1UD129KBjvAXoW3CrWUGw1fZF13WFW5Zr1UWrg_yoW8CrWUKo
        WrA3Wfta4xJa4vqasrA3Z7Krn7GFy0yr4Syr1YqFs8K3W3Zry0qr9avFsFya13Jw1Fqw1a
        gr9agrZ3WrZ7Ary3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYq7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
        67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMI
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

This implement some helper function for hwmon device,
hwmon driver test case can inherit 'HwMonDriver' to simplify code.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 .../testing/kddv/kddv/tests/hwmon/__init__.py | 425 ++++++++++++++++++
 1 file changed, 425 insertions(+)
 create mode 100755 tools/testing/kddv/kddv/tests/hwmon/__init__.py

diff --git a/tools/testing/kddv/kddv/tests/hwmon/__init__.py b/tools/testing/kddv/kddv/tests/hwmon/__init__.py
new file mode 100755
index 000000000000..0b2efedbb02e
--- /dev/null
+++ b/tools/testing/kddv/kddv/tests/hwmon/__init__.py
@@ -0,0 +1,425 @@
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
+logger = logging.getLogger(__name__)
+
+class HwMon:
+    def __init__(self, path: Path) -> None:
+        hwmon = next(path.glob("hwmon/hwmon*")).name
+        self.cdev = Path(f"/sys/class/hwmon/{hwmon}")
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, *_):
+        pass
+
+    def read_attr(self, attr):
+        rpath = self.cdev / attr
+        logger.debug(f"read from file {rpath}")
+        return rpath.read_text().rstrip()
+
+    def write_attr(self, attr, value):
+        wpath = self.cdev / attr
+        logger.debug(f"write '{value}' to file {wpath}")
+        wpath.write_text(value)
+
+class HwMonDriver:
+    def hwmon_read_attr(self, dev, attr):
+        with HwMon(dev.path) as hwmon:
+            return int(hwmon.read_attr(attr))
+
+    def hwmon_write_attr(self, dev, attr, value):
+        with HwMon(dev.path) as hwmon:
+            return hwmon.write_attr(attr, str(value))
+
+    def hwmon_read_attr_str(self, dev, attr):
+        with HwMon(dev.path) as hwmon:
+            return hwmon.read_attr(attr)
+
+    def hwmon_write_attr_str(self, dev, attr, value):
+        with HwMon(dev.path) as hwmon:
+            return hwmon.write_attr(attr, value)
+
+    def hwmon_read_temp_label(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_label')
+
+    def hwmon_read_temp_input(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_input')
+
+    def hwmon_write_temp_input(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_input', value)
+
+    def hwmon_read_temp_lcrit(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_lcrit')
+
+    def hwmon_write_temp_lcrit(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_lcrit', value)
+
+    def hwmon_read_temp_lcrit_hyst(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_lcrit_hyst')
+
+    def hwmon_write_temp_lcrit_hyst(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_lcrit_hyst', value)
+
+    def hwmon_read_temp_min(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_min')
+
+    def hwmon_write_temp_min(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_min', value)
+
+    def hwmon_read_temp_min_hyst(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_min_hyst')
+
+    def hwmon_write_temp_min_hyst(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_min_hyst', value)
+
+    def hwmon_read_temp_max(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_max')
+
+    def hwmon_write_temp_max(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_max', value)
+
+    def hwmon_read_temp_max_hyst(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_max_hyst')
+
+    def hwmon_write_temp_max_hyst(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_max_hyst', value)
+
+    def hwmon_read_temp_crit(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_crit')
+
+    def hwmon_write_temp_crit(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_crit', value)
+
+    def hwmon_read_temp_crit_hyst(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_crit_hyst')
+
+    def hwmon_write_temp_crit_hyst(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_crit_hyst', value)
+
+    def hwmon_read_temp_emergency(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_emergency')
+
+    def hwmon_write_temp_emergency(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_emergency', value)
+
+    def hwmon_read_temp_emergency_hyst(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_emergency_hyst')
+
+    def hwmon_write_temp_emergency_hyst(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_emergency_hyst', value)
+
+    def hwmon_read_temp_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_alarm')
+
+    def hwmon_write_temp_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_alarm', value)
+
+    def hwmon_read_temp_lcrit_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_lcrit_alarm')
+
+    def hwmon_write_temp_lcrit_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_lcrit_alarm', value)
+
+    def hwmon_read_temp_min_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_min_alarm')
+
+    def hwmon_write_temp_min_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_min_alarm', value)
+
+    def hwmon_read_temp_max_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_max_alarm')
+
+    def hwmon_write_temp_max_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_max_alarm', value)
+
+    def hwmon_read_temp_crit_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_crit_alarm')
+
+    def hwmon_write_temp_crit_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_crit_alarm', value)
+
+    def hwmon_read_temp_emergency_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_emergency_alarm')
+
+    def hwmon_write_temp_emergency_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_emergency_alarm', value)
+
+    def hwmon_read_temp_fault(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_fault')
+
+    def hwmon_write_temp_fault(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_fault', value)
+
+    def hwmon_read_temp_offset(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_offset')
+
+    def hwmon_write_temp_offset(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_offset', value)
+
+    def hwmon_read_temp_label(self, dev, chan=0):
+        return self.hwmon_read_attr_str(dev, f'temp{chan+1}_label')
+
+    def hwmon_write_temp_label(self, dev, value, chan=0):
+        return self.hwmon_write_attr_str(dev, f'temp{chan+1}_label', value)
+
+    def hwmon_read_temp_lowest(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_lowest')
+
+    def hwmon_write_temp_lowest(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_lowest', value)
+
+    def hwmon_read_temp_highest(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_highest')
+
+    def hwmon_write_temp_highest(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_highest', value)
+
+    def hwmon_read_temp_reset_history(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_reset_history')
+
+    def hwmon_write_temp_reset_history(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_reset_history', value)
+
+    def hwmon_read_temp_rated_min(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_rated_min')
+
+    def hwmon_write_temp_rated_min(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_rated_min', value)
+
+    def hwmon_read_temp_rated_max(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'temp{chan+1}_rated_max')
+
+    def hwmon_write_temp_rated_max(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'temp{chan+1}_rated_max', value)
+
+    def hwmon_read_fan_enable(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'fan{chan+1}_enable')
+
+    def hwmon_write_fan_enable(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'fan{chan+1}_enable', value)
+
+    def hwmon_read_fan_input(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'fan{chan+1}_input')
+
+    def hwmon_write_fan_input(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'fan{chan+1}_input', value)
+
+    def hwmon_read_fan_fault(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'fan{chan+1}_fault')
+
+    def hwmon_write_fan_fault(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'fan{chan+1}_fault', value)
+
+    def hwmon_read_pwm_input(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'pwm{chan+1}')
+
+    def hwmon_write_pwm_input(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'pwm{chan+1}', value)
+
+    def hwmon_read_pwm_enable(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'pwm{chan+1}_enable')
+
+    def hwmon_write_pwm_enable(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'pwm{chan+1}_enable', value)
+
+    def hwmon_read_pwm_mode(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'pwm{chan+1}_mode')
+
+    def hwmon_write_pwm_mode(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'pwm{chan+1}_mode', value)
+
+    def hwmon_read_pwm_freq(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'pwm{chan+1}_freq')
+
+    def hwmon_write_pwm_freq(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'pwm{chan+1}_freq', value)
+
+    def hwmon_read_pwm_auto_channels_temp(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'pwm{chan+1}_auto_channels_temp')
+
+    def hwmon_write_pwm_auto_channels_temp(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'pwm{chan+1}_auto_channels_temp', value)
+
+    def hwmon_read_in_label(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_label')
+
+    def hwmon_read_in_input(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_input')
+
+    def hwmon_write_in_input(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'in{chan+1}_input', value)
+
+    def hwmon_read_in_min(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_min')
+
+    def hwmon_write_in_min(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_min', value)
+
+    def hwmon_read_in_min_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_min_alarm')
+
+    def hwmon_write_in_min_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'in{chan+1}_min_alarm', value)
+
+    def hwmon_read_in_max(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_max')
+
+    def hwmon_write_in_max(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'in{chan+1}_max', value)
+
+    def hwmon_read_in_max_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_max_alarm')
+
+    def hwmon_write_in_max_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'in{chan+1}_max_alarm', value)
+
+    def hwmon_read_in_crit(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_crit')
+
+    def hwmon_write_in_crit(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'in{chan+1}_crit', value)
+
+    def hwmon_read_in_crit_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_crit_alarm')
+
+    def hwmon_write_in_crit_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'in{chan+1}_crit_alarm', value)
+
+    def hwmon_read_in_lcrit(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_lcrit')
+
+    def hwmon_write_in_lcrit(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_lcrit', value)
+
+    def hwmon_read_in_lcrit_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_lcrit_alarm')
+
+    def hwmon_write_in_lcrit_alarm(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_lcrit_alarm', value)
+
+    def hwmon_read_in_rated_min(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_rated_min')
+
+    def hwmon_write_in_rated_min(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_rated_min', value)
+
+    def hwmon_read_in_rated_max(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_rated_max')
+
+    def hwmon_write_in_rated_max(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'in{chan+1}_rated_max', value)
+
+    def hwmon_read_curr_label(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_label')
+
+    def hwmon_read_curr_input(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_input')
+
+    def hwmon_write_curr_input(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'curr{chan+1}_input', value)
+
+    def hwmon_read_curr_max(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_max')
+
+    def hwmon_write_curr_max(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'curr{chan+1}_max', value)
+
+    def hwmon_read_curr_max_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_max_alarm')
+
+    def hwmon_write_curr_max_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'curr{chan+1}_max_alarm', value)
+
+    def hwmon_read_curr_crit(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_crit')
+
+    def hwmon_write_curr_crit(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'curr{chan+1}_crit', value)
+
+    def hwmon_read_curr_crit_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_crit_alarm')
+
+    def hwmon_write_curr_crit_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'curr{chan+1}_crit_alarm', value)
+
+    def hwmon_read_curr_lcrit(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_lcrit')
+
+    def hwmon_write_curr_lcrit(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'curr{chan+1}_lcrit', value)
+
+    def hwmon_read_curr_lcrit_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_lcrit_alarm')
+
+    def hwmon_write_curr_lcrit_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'curr{chan+1}_lcrit_alarm', value)
+
+    def hwmon_read_curr_rated_max(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_rated_max')
+
+    def hwmon_write_curr_rated_max(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'curr{chan+1}_rated_max', value)
+
+    def hwmon_read_power_input(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_input')
+
+    def hwmon_write_power_input(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'power{chan+1}_input', value)
+
+    def hwmon_read_power_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_alarm')
+
+    def hwmon_write_power_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'power{chan+1}_alarm', value)
+
+    def hwmon_read_power_cap(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_cap')
+
+    def hwmon_write_power_cap(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'power{chan+1}_cap', value)
+
+    def hwmon_read_power_cap_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_cap_alarm')
+
+    def hwmon_write_power_cap_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'power{chan+1}_cap_alarm', value)
+
+    def hwmon_read_power_max(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_max')
+
+    def hwmon_write_power_max(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'power{chan+1}_max', value)
+
+    def hwmon_read_power_max_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_max_alarm')
+
+    def hwmon_write_power_max_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'power{chan+1}_max_alarm', value)
+
+    def hwmon_read_power_crit(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_crit')
+
+    def hwmon_write_power_crit(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'power{chan+1}_crit', value)
+
+    def hwmon_read_power_crit_alarm(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_crit_alarm')
+
+    def hwmon_write_power_crit_alarm(self, dev, value, chan=0):
+        return self.hwmon_write_attr(dev, f'power{chan+1}_crit_alarm', value)
+
+    def hwmon_read_power_rated_max(self, dev, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_rated_max')
+
+    def hwmon_write_power_rated_max(self, dev, value, chan=0):
+        return self.hwmon_read_attr(dev, f'power{chan+1}_rated_max', value)
-- 
2.34.1

