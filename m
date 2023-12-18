Return-Path: <linux-kernel+bounces-3723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0381703F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AA128698E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C327206B;
	Mon, 18 Dec 2023 13:15:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAB3A1B7;
	Mon, 18 Dec 2023 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Sv0Zm32HmzB1CfX;
	Mon, 18 Dec 2023 21:11:28 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 18 Dec
 2023 21:15:01 +0800
Date: Mon, 18 Dec 2023 21:15:01 +0800
From: WangJinchao <wangjinchao@xfusion.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Tim Chen <tim.c.chen@linux.intel.com>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH v2] crypto:tcrypt: add script tcrypt_speed_compare.py
Message-ID: <202312182113+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

Create a script for comparing tcrypt speed test logs.
The script will systematically analyze differences item
by item and provide a summary (average).
This tool is useful for evaluating the stability of
cryptographic module algorithms and assisting with
performance optimization.

Please note that for such a comparison, stability depends
on whether we allow frequency to float or pin the frequency.

The script produces comparisons in two scenes:

1. For operations in seconds
================================================================================
rfc4106(gcm(aes)) (pcrypt(rfc4106(gcm_base(ctr(aes-generic),ghash-generic))))
                         encryption
--------------------------------------------------------------------------------
bit key | byte blocks | base ops    | new ops     | differ(%)
160     | 16          | 66439       | 63063       | -5.08
160     | 64          | 62220       | 57439       | -7.68
...
288     | 4096        | 15059       | 16278       | 8.09
288     | 8192        | 9043        | 9526        | 5.34
--------------------------------------------------------------------------------
average differ(%s)    | total_differ(%)
--------------------------------------------------------------------------------
5.70                  | -4.49
================================================================================

2. For avg cycles of operation
================================================================================
rfc4106(gcm(aes)) (pcrypt(rfc4106(gcm_base(ctr(aes-generic),ghash-generic))))
                         encryption
--------------------------------------------------------------------------------
bit key | byte blocks | base cycles | new cycles  | differ(%)
160     | 16          | 32500       | 35847       | 10.3
160     | 64          | 33175       | 45808       | 38.08
...
288     | 4096        | 131369      | 132132      | 0.58
288     | 8192        | 229503      | 234581      | 2.21
--------------------------------------------------------------------------------
average differ(%s)    | total_differ(%)
--------------------------------------------------------------------------------
8.41                  | -6.70
================================================================================

Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
---
 MAINTAINERS                                 |   6 +
 tools/crypto/tcrypt/tcrypt_speed_compare.py | 190 ++++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100755 tools/crypto/tcrypt/tcrypt_speed_compare.py

diff --git a/MAINTAINERS b/MAINTAINERS
index bba17f97eda7..b9c8dd607bce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5524,6 +5524,12 @@ F:	include/crypto/
 F:	include/linux/crypto*
 F:	lib/crypto/
 
+CRYPTO SPEED TEST COMPARE
+M:	Wang Jinchao <wangjinchao@xfusion.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	tools/crypto/tcrypt/tcrypt_speed_compare.py
+
 CRYPTOGRAPHIC RANDOM NUMBER GENERATOR
 M:	Neil Horman <nhorman@tuxdriver.com>
 L:	linux-crypto@vger.kernel.org
diff --git a/tools/crypto/tcrypt/tcrypt_speed_compare.py b/tools/crypto/tcrypt/tcrypt_speed_compare.py
new file mode 100755
index 000000000000..f3f5783cdc06
--- /dev/null
+++ b/tools/crypto/tcrypt/tcrypt_speed_compare.py
@@ -0,0 +1,190 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) xFusion Digital Technologies Co., Ltd., 2023
+#
+# Author: Wang Jinchao <wangjinchao@xfusion.com>
+#
+"""
+A tool for comparing tcrypt speed test logs.
+
+Please note that for such a comparison, stability depends
+on whether we allow frequency to float or pin the frequency.
+
+Both support tests for operations within one second and
+cycles of operation.
+For example, use it in the bash script below.
+
+```bash
+#!/bin/bash
+
+# log file prefix
+seq_num=0
+
+# When sec=0, it will perform cycle tests;
+# otherwise, it indicates the duration of a single test
+sec=0
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
+tools/crypto/tcrypt/tcrypt_speed_compare.py \
+    ${seq_num}_base_dmesg.log \
+    ${seq_num}_new_dmesg.log  \
+        >${seq_num}_compare.log
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


