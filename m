Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABB780BA23
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjLJKTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJKTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:19:45 -0500
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07587F2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:19:47 -0800 (PST)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Sp14K6v2fz9yQBw;
        Sun, 10 Dec 2023 18:16:17 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 10 Dec
 2023 18:19:42 +0800
Date:   Sun, 10 Dec 2023 18:19:41 +0800
From:   WangJinchao <wangjinchao@xfusion.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] crypto: tcrypt - add script tcrypt_speed_compare.py
Message-ID: <202312101758+0800-wangjinchao@xfusion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a script for comparing tcrypt speed test logs.
The script will systematically analyze differences item
by item and provide a summary (average).
This tool is useful for evaluating the stability of
cryptographic module algorithms and assisting with
performance optimization.

The script produces comparisons in two scenes:

1. For operations in seconds
===========================================================================
rfc4106(gcm(aes)) (pcrypt(rfc4106(gcm_base(ctr(aes-generic),ghash-generic))
                         encryption
---------------------------------------------------------------------------
bit key | byte blocks | base ops    | new ops     | differ(%)
160     | 16          | 60276       | 47081       | -21.89
160     | 64          | 55307       | 45430       | -17.86
160     | 256         | 53196       | 41391       | -22.19
160     | 512         | 45629       | 38511       | -15.6
160     | 1024        | 37489       | 44333       | 18.26
160     | 1420        | 32963       | 32815       | -0.45
160     | 4096        | 18416       | 18356       | -0.33
160     | 8192        | 11878       | 10701       | -9.91
224     | 16          | 55332       | 56620       | 2.33
224     | 64          | 59551       | 55006       | -7.63
224     | 256         | 53144       | 49892       | -6.12
224     | 512         | 46655       | 44010       | -5.67
224     | 1024        | 38379       | 35988       | -6.23
224     | 1420        | 33125       | 31529       | -4.82
224     | 4096        | 17750       | 17351       | -2.25
224     | 8192        | 10213       | 10046       | -1.64
288     | 16          | 64662       | 56571       | -12.51
288     | 64          | 57780       | 54815       | -5.13
288     | 256         | 54679       | 50110       | -8.36
288     | 512         | 46895       | 43201       | -7.88
288     | 1024        | 36286       | 35860       | -1.17
288     | 1420        | 31175       | 32327       | 3.7
288     | 4096        | 16686       | 16699       | 0.08
288     | 8192        | 9662        | 9548        | -1.18
---------------------------------------------------------------------------
average differ(%s)    | total_differ(%)
---------------------------------------------------------------------------
-5.60                 | 7.28
===========================================================================

2. For avg cycles of operation
===========================================================================
rfc4309(ccm(aes)) (rfc4309(ccm_base(ctr(aes-generic),cbcmac(aes-generic))))
                         encryption
---------------------------------------------------------------------------
bit key | byte blocks | base ops    | new ops     | differ(%)
152     | 16          | 792483      | 801555      | 1.14
152     | 64          | 552470      | 557953      | 0.99
152     | 256         | 254997      | 260518      | 2.17
152     | 512         | 148486      | 153241      | 3.2
152     | 1024        | 80925       | 83446       | 3.12
152     | 1420        | 59601       | 60999       | 2.35
152     | 4096        | 21714       | 22064       | 1.61
152     | 8192        | 10984       | 11301       | 2.89
---------------------------------------------------------------------------
average differ(%s)    | total_differ(%)
---------------------------------------------------------------------------
2.18                  | -1.53
===========================================================================

Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
---
 MAINTAINERS                                 |   5 +
 tools/crypto/tcrypt/tcrypt_speed_compare.py | 179 ++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100755 tools/crypto/tcrypt/tcrypt_speed_compare.py

To: Daniel Jordan <daniel.m.jordan@oracle.com>
After spending a considerable amount of time analyzing and 
benchmarking, I've found that although my approach could simplify
the code logic, it leads to a performance decrease. Therefore,
I have decided to abandon the code optimization effort.
During the performance comparison, I utilized the Python script
from this commit and found it to be valuable.
Despite not optimizing padata, I would like to share this tool,
which is helpful for analyzing cryptographic performance, 
for the benefit of others.

Additionally, thank you for your assistance throughout this process.

To: Steffen Klassert <steffen.klassert@secunet.com>
Thank you for providing the testing method. Based on the approach
you suggested, I conducted performance comparisons for padata.
You were correct; the scheduling overhead is significant compared
to 'parallel()' calls. During profiling, approximately 80% of the
time was spent on operations related to 'queue_work_on' and locks.

Furthermore, I observed a substantial number of 'pcrypt(pcrypt(...'
structures during multiple 'modprobe' runs for pcrypt.
To address this, I adjusted the testing procedure by removing the
pcrypt module before each test, as indicated in the comments of this commit.

In summary, I appreciate your guidance. This serves as a conclusion
to my attempt at modifying padata, which I have decided to abandon.

Thank you
diff --git a/MAINTAINERS b/MAINTAINERS
index a0fb0df07b43..5690ab99f107 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5535,6 +5535,11 @@ F:	include/crypto/
 F:	include/linux/crypto*
 F:	lib/crypto/
 
+CRYPTO SPEED TEST COMPARE
+M:	WangJinchao <wangjinchao@xfusion.com>
+L:	linux-crypto@vger.kernel.org
+F:	tools/crypto/tcrypt/tcrypt_speed_compare.py
+
 CRYPTOGRAPHIC RANDOM NUMBER GENERATOR
 M:	Neil Horman <nhorman@tuxdriver.com>
 L:	linux-crypto@vger.kernel.org
diff --git a/tools/crypto/tcrypt/tcrypt_speed_compare.py b/tools/crypto/tcrypt/tcrypt_speed_compare.py
new file mode 100755
index 000000000000..789d24013d8e
--- /dev/null
+++ b/tools/crypto/tcrypt/tcrypt_speed_compare.py
@@ -0,0 +1,179 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) xFusion Digital Technologies Co., Ltd., 2023
+#
+# Author: WangJinchao <wangjinchao@xfusion.com>
+#
+"""
+A tool for comparing tcrypt speed test logs.
+
+Both support test for operations in one second and cycles of operation
+for example, use it in bellow bash script
+
+```bash
+#!/bin/bash
+
+seq_num=1
+sec=1
+num_mb=8
+mode=211
+
+# base speed test
+lsmod | grep pcrypt && modprobe -r pcrypt
+dmesg -C
+modprobe tcrypt alg="pcrypt(rfc4106(gcm(aes)))" type=3
+modprobe tcrypt mode=${mode} sec=${sec} num_mb=${num_mb}
+dmesg > ${seq_num}_base_dmesg.log
+
+# new speed test
+lsmod | grep pcrypt && modprobe -r pcrypt
+dmesg -C
+modprobe tcrypt alg="pcrypt(rfc4106(gcm(aes)))" type=3
+modprobe tcrypt mode=${mode} sec=${sec} num_mb=${num_mb}
+dmesg > ${seq_num}_new_dmesg.log
+lsmod | grep pcrypt && modprobe -r pcrypt
+
+./tcrypt_speed_compare.py ${seq_num}_base_dmesg.log ${seq_num}_new_dmesg.log  >${seq_num}_compare.log
+grep 'average' -A2 -B0 --group-separator="" ${seq_num}_compare.log
+```
+"""
+
+import sys
+import re
+
+
+def parse_title(line):
+    pattern = r'tcrypt: testing speed of (.*?) (encryption|decryption)'
+    match = re.search(pattern, line)
+    if match:
+        alg = match.group(1)
+        op = match.group(2)
+        return alg, op
+    else:
+        return "", ""
+
+
+def parse_item(line):
+    pattern_operations = r'\((\d+) bit key, (\d+) byte blocks\): (\d+) operations'
+    pattern_cycles = r'\((\d+) bit key, (\d+) byte blocks\): 1 operation in (\d+) cycles'
+    match = re.search(pattern_operations, line)
+    if match:
+        res = {
+            "bit_key": int(match.group(1)),
+            "byte_blocks": int(match.group(2)),
+            "operations": int(match.group(3)),
+        }
+        return res
+
+    match = re.search(pattern_cycles, line)
+    if match:
+        res = {
+            "bit_key": int(match.group(1)),
+            "byte_blocks": int(match.group(2)),
+            "cycles": int(match.group(3)),
+        }
+        return res
+
+    return None
+
+
+def parse(filepath):
+    result = {}
+    alg, op = "", ""
+    with open(filepath, 'r') as file:
+        for line in file:
+            if not line:
+                continue
+            _alg, _op = parse_title(line)
+            if _alg:
+                alg, op = _alg, _op
+                if alg not in result:
+                    result[alg] = {}
+                if op not in result[alg]:
+                    result[alg][op] = []
+                continue
+            parsed_result = parse_item(line)
+            if parsed_result:
+                result[alg][op].append(parsed_result)
+    return result
+
+
+def merge(base, new):
+    merged = {}
+    for alg in base.keys():
+        merged[alg] = {}
+        for op in base[alg].keys():
+            if op not in merged[alg]:
+                merged[alg][op] = []
+            for index in range(len(base[alg][op])):
+                merged_item = {
+                    "bit_key": base[alg][op][index]["bit_key"],
+                    "byte_blocks": base[alg][op][index]["byte_blocks"],
+                }
+                if "operations" in base[alg][op][index].keys():
+                    merged_item["base_ops"] = base[alg][op][index]["operations"]
+                    merged_item["new_ops"] = new[alg][op][index]["operations"]
+                else:
+                    merged_item["base_cycles"] = base[alg][op][index]["cycles"]
+                    merged_item["new_cycles"] = new[alg][op][index]["cycles"]
+
+                merged[alg][op].append(merged_item)
+    return merged
+
+
+def format(merged):
+    for alg in merged.keys():
+        for op in merged[alg].keys():
+            base_sum = 0
+            new_sum = 0
+            differ_sum = 0
+            differ_cnt = 0
+            print()
+            hlen = 80
+            print("="*hlen)
+            print(f"{alg}")
+            print(f"{' '*(len(alg)//3) + op}")
+            print("-"*hlen)
+            key = ""
+            if "base_ops" in merged[alg][op][0]:
+                key = "ops"
+                print(f"bit key | byte blocks | base ops    | new ops     | differ(%)")
+            else:
+                key = "cycles"
+                print(f"bit key | byte blocks | base cycles | new cycles  | differ(%)")
+            for index in range(len(merged[alg][op])):
+                item = merged[alg][op][index]
+                base_cnt = item[f"base_{key}"]
+                new_cnt = item[f"new_{key}"]
+                base_sum += base_cnt
+                new_sum += new_cnt
+                differ = round((new_cnt - base_cnt)*100/base_cnt, 2)
+                differ_sum += differ
+                differ_cnt += 1
+                bit_key = item["bit_key"]
+                byte_blocks = item["byte_blocks"]
+                print(
+                    f"{bit_key:<7} | {byte_blocks:<11} | {base_cnt:<11} | {new_cnt:<11} | {differ:<8}")
+            average_speed_up = "{:.2f}".format(differ_sum/differ_cnt)
+            ops_total_speed_up = "{:.2f}".format(
+                (base_sum - new_sum) * 100 / base_sum)
+            print('-'*hlen)
+            print(f"average differ(%s)    | total_differ(%)")
+            print('-'*hlen)
+            print(f"{average_speed_up:<21} | {ops_total_speed_up:<10}")
+            print('='*hlen)
+
+
+def main(base_log, new_log):
+    base = parse(base_log)
+    new = parse(new_log)
+    merged = merge(base, new)
+    format(merged)
+
+
+if __name__ == "__main__":
+    if len(sys.argv) != 3:
+        print(f"usage: {sys.argv[0]} base_log new_log")
+        exit(-1)
+    main(sys.argv[1], sys.argv[2])
-- 
2.40.0

