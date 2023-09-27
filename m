Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA127B0AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjI0RG4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 13:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjI0RGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:06:55 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4892;
        Wed, 27 Sep 2023 10:06:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 71C8524DFDE;
        Thu, 28 Sep 2023 01:06:43 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Sep
 2023 01:06:43 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Sep
 2023 01:06:37 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Nikita Shubin" <n.shubin@yadro.com>
CC:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH] perf vendor events riscv: add Starfive Dubhe JSON file
Date:   Thu, 28 Sep 2023 01:05:43 +0800
Message-ID: <20230927170543.802056-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starfive Dubhe supports raw event id 0x00 - 0x22.
The raw events are enabled through PMU node of the DT binding.

PMU DT node:
pmu {
	compatible = "riscv,pmu";
	riscv,raw-event-to-mhpmcounters =
		/* Event ID 1-31 */
		<0x00 0x00 0xFFFFFFFF 0xFFFFFFE0 0x00007FF8>,
		/* Event ID 32-33 */
		<0x00 0x20 0xFFFFFFFF 0xFFFFFFFE 0x00007FF8>,
		/* Event ID 34 */
		<0x00 0x22 0xFFFFFFFF 0xFFFFFF22 0x00007FF8>;
};

Perf stat output:
[root@user]# perf stat -a \
	-e access_mmu_stlb \
	-e miss_mmu_stlb \
	-e access_mmu_pte_c \
	-e rob_flush \
	-e btb_prediction_miss \
	-e itlb_miss \
	-e sync_del_fetch_g \
	-e icache_miss \
	-e bpu_br_retire \
	-e bpu_br_miss \
	-e ret_ins_retire
	-e ret_ins_miss \
	-- openssl speed rsa2048
Doing 2048 bits private rsa's for 10s: 39 2048 bits private RSA's in
10.03s
Doing 2048 bits public rsa's for 10s: 1469 2048 bits public RSA's in
9.47s
version: 3.0.10
built on: Tue Aug  1 13:47:24 2023 UTC
options: bn(64,64)
CPUINFO: N/A
                  sign    verify    sign/s verify/s
rsa 2048 bits 0.257179s 0.006447s      3.9    155.1

 Performance counter stats for 'system wide':

           3112882      access_mmu_stlb
             10550      miss_mmu_stlb
             18251      access_mmu_pte_c
            274765      rob_flush
          22470560      btb_prediction_miss
           3035839      itlb_miss
         643549060      sync_del_fetch_g
            133013      icache_miss
          62982796      bpu_br_retire
            287548      bpu_br_miss
           8935910      ret_ins_retire
              8308      ret_ins_miss

      20.656182600 seconds time elapsed

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 .../arch/riscv/starfive/dubhe/common.json     | 172 ++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/starfive/dubhe/common.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index c61b3d6ef616..a7d9abc5669a 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -15,3 +15,4 @@
 #
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
+0x67e-0x80000000db010500-0x[[:xdigit:]]+,v1,starfive/dubhe,core
diff --git a/tools/perf/pmu-events/arch/riscv/starfive/dubhe/common.json b/tools/perf/pmu-events/arch/riscv/starfive/dubhe/common.json
new file mode 100644
index 000000000000..fbffcacb2ace
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/starfive/dubhe/common.json
@@ -0,0 +1,172 @@
+[
+  {
+    "EventName": "ACCESS_MMU_STLB",
+    "EventCode": "0x1",
+    "BriefDescription": "access MMU STLB"
+  },
+  {
+    "EventName": "MISS_MMU_STLB",
+    "EventCode": "0x2",
+    "BriefDescription": "miss MMU STLB"
+  },
+  {
+    "EventName": "ACCESS_MMU_PTE_C",
+    "EventCode": "0x3",
+    "BriefDescription": "access MMU PTE-Cache"
+  },
+  {
+    "EventName": "MISS_MMU_PTE_C",
+    "EventCode": "0x4",
+    "BriefDescription": "miss MMU PTE-Cache"
+  },
+  {
+    "EventName": "ROB_FLUSH",
+    "EventCode": "0x5",
+    "BriefDescription": "ROB flush (all kinds of exceptions)"
+  },
+  {
+    "EventName": "BTB_PREDICTION_MISS",
+    "EventCode": "0x6",
+    "BriefDescription": "BTB prediction miss"
+  },
+  {
+    "EventName": "ITLB_MISS",
+    "EventCode": "0x7",
+    "BriefDescription": "ITLB miss"
+  },
+  {
+    "EventName": "SYNC_DEL_FETCH_G",
+    "EventCode": "0x8",
+    "BriefDescription": "SYNC delivery a fetch-group"
+  },
+  {
+    "EventName": "ICACHE_MISS",
+    "EventCode": "0x9",
+    "BriefDescription": "ICache miss"
+  },
+  {
+    "EventName": "BPU_BR_RETIRE",
+    "EventCode": "0xA",
+    "BriefDescription": "condition branch instruction retire"
+  },
+  {
+    "EventName": "BPU_BR_MISS",
+    "EventCode": "0xB",
+    "BriefDescription": "condition branch instruction miss"
+  },
+  {
+    "EventName": "RET_INS_RETIRE",
+    "EventCode": "0xC",
+    "BriefDescription": "return instruction retire"
+  },
+  {
+    "EventName": "RET_INS_MISS",
+    "EventCode": "0xD",
+    "BriefDescription": "return instruction miss"
+  },
+  {
+    "EventName": "INDIRECT_JR_MISS",
+    "EventCode": "0xE",
+    "BriefDescription": "indirect JR instruction miss (inlcude without target)"
+  },
+  {
+    "EventName": "IBUF_VAL_ID_NORDY",
+    "EventCode": "0xF",
+    "BriefDescription": "IBUF valid while ID not ready"
+  },
+  {
+    "EventName": "IBUF_NOVAL_ID_RDY",
+    "EventCode": "0x10",
+    "BriefDescription": "IBUF not valid while ID ready"
+  },
+  {
+    "EventName": "REN_INT_PHY_REG_NORDY",
+    "EventCode": "0x11",
+    "BriefDescription": "REN integer physical register file is not ready"
+  },
+  {
+    "EventName": "REN_FP_PHY_REG_NORDY",
+    "EventCode": "0x12",
+    "BriefDescription": "REN floating point physical register file is not ready"
+  },
+  {
+    "EventName": "REN_CP_NORDY",
+    "EventCode": "0x13",
+    "BriefDescription": "REN checkpoint is not ready"
+  },
+  {
+    "EventName": "DEC_VAL_ROB_NORDY",
+    "EventCode": "0x14",
+    "BriefDescription": "DEC is valid and ROB is not ready"
+  },
+  {
+    "EventName": "OOD_FLUSH_LS_DEP",
+    "EventCode": "0x15",
+    "BriefDescription": "out of order flush due to load/store dependency"
+  },
+  {
+    "EventName": "BRU_RET_IJR_INS",
+    "EventCode": "0x16",
+    "BriefDescription": "BRU retire an IJR instruction"
+  },
+  {
+    "EventName": "ACCESS_DTLB",
+    "EventCode": "0x17",
+    "BriefDescription": "access DTLB"
+  },
+  {
+    "EventName": "MISS_DTLB",
+    "EventCode": "0x18",
+    "BriefDescription": "miss DTLB"
+  },
+  {
+    "EventName": "LOAD_INS_DCACHE",
+    "EventCode": "0x19",
+    "BriefDescription": "load instruction access DCache"
+  },
+  {
+    "EventName": "LOAD_INS_MISS_DCACHE",
+    "EventCode": "0x1A",
+    "BriefDescription": "load instruction miss DCache"
+  },
+  {
+    "EventName": "STORE_INS_DCACHE",
+    "EventCode": "0x1B",
+    "BriefDescription": "store/amo instruction access DCache"
+  },
+  {
+    "EventName": "STORE_INS_MISS_DCACHE",
+    "EventCode": "0x1C",
+    "BriefDescription": "store/amo instruction miss DCache"
+  },
+  {
+    "EventName": "LOAD_SCACHE",
+    "EventCode": "0x1D",
+    "BriefDescription": "load access SCache"
+  },
+  {
+    "EventName": "STORE_SCACHE",
+    "EventCode": "0x1E",
+    "BriefDescription": "store access SCache"
+  },
+  {
+    "EventName": "LOAD_MISS_SCACHE",
+    "EventCode": "0x1F",
+    "BriefDescription": "load miss SCache"
+  },
+  {
+    "EventName": "STORE_MISS_SCACHE",
+    "EventCode": "0x20",
+    "BriefDescription": "store miss SCache"
+  },
+  {
+    "EventName": "L2C_PF_REQ",
+    "EventCode": "0x21",
+    "BriefDescription": "L2C data-prefetcher request"
+  },
+  {
+    "EventName": "L2C_PF_HIT",
+    "EventCode": "0x22",
+    "BriefDescription": "L2C data-prefetcher hit"
+  }
+]
-- 
2.25.1

