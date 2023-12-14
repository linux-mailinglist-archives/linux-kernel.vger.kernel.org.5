Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD0813039
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573076AbjLNMd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573081AbjLNMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:33:23 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88344116;
        Thu, 14 Dec 2023 04:33:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VyUMJ2Z_1702557203;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VyUMJ2Z_1702557203)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 20:33:26 +0800
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        al.grant@arm.com, mathieu.poirier@linaro.org, tor@ti.com,
        acme@redhat.com, Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 3/3] perf scripts python: arm-cs-trace-disasm.py: do not ignore disam first sample
Date:   Thu, 14 Dec 2023 20:33:04 +0800
Message-Id: <20231214123304.34087-4-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm-cs-trace-disasm ignore disam the first branch sample, For example as
follow, the instructions beteween 0x0000ffffae878750 and
0x0000ffffae878754 is lose:

  ARM CoreSight Trace Data Assembler Dump
  Event type: branches:uH
  Sample = { cpu: 0000 addr: 0x0000ffffae878750 phys_addr: 0x0000000000000000 ip: 0x0000000000000000 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
  Event type: branches:uH
  Sample = { cpu: 0000 addr: 0x0000000000000000 phys_addr: 0x0000000000000000 ip: 0x0000ffffae878754 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }

Initialize cpu_data earlier to fix it:

  ARM CoreSight Trace Data Assembler Dump
  Event type: branches:uH
  Sample = { cpu: 0000 addr: 0x0000000000000000 phys_addr: 0x0000000000000000 ip: 0x0000ffffae878754 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
        0000000000028740 <ioctl>: (base address is 0x0000ffffae850000)
           28750: b13ffc1f      cmn     x0, #4095
           28754: 54000042      b.hs    0x2875c <ioctl+0x1c>
            test 4003489/4003489 [0000]     26765.151766034  __GI___ioctl+0x14                        /usr/lib64/libc-2.32.so
  Event type: branches:uH
  Sample = { cpu: 0000 addr: 0x0000ffffa67535ac phys_addr: 0x0000000000000000 ip: 0x0000000000000000 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index c9e14af5b58c..b1eb4293cbef 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -190,6 +190,17 @@ def process_event(param_dict):
 	dso_end = get_optional(param_dict, "dso_map_end")
 	symbol = get_optional(param_dict, "symbol")
 
+	cpu = sample["cpu"]
+	ip = sample["ip"]
+	addr = sample["addr"]
+
+	# Initialize CPU data if it's empty, and directly return back
+	# if this is the first tracing event for this CPU.
+	if (cpu_data.get(str(cpu) + 'addr') == None):
+		cpu_data[str(cpu) + 'addr'] = addr
+		return
+
+
 	if (options.verbose == True):
 		print("Event type: %s" % name)
 		print_sample(sample)
@@ -211,16 +222,6 @@ def process_event(param_dict):
 	if (name[0:8] != "branches"):
 		return
 
-	cpu = sample["cpu"]
-	ip = sample["ip"]
-	addr = sample["addr"]
-
-	# Initialize CPU data if it's empty, and directly return back
-	# if this is the first tracing event for this CPU.
-	if (cpu_data.get(str(cpu) + 'addr') == None):
-		cpu_data[str(cpu) + 'addr'] = addr
-		return
-
 	# The format for packet is:
 	#
 	#		  +------------+------------+------------+
-- 
2.33.1

