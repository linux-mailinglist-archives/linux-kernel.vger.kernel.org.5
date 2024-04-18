Return-Path: <linux-kernel+bounces-149414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B119C8A90D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668CC281DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7728E2375F;
	Thu, 18 Apr 2024 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XijevkKi"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD7848E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404817; cv=none; b=ULB4Upf8mFgJyzMnDtAxwvemBeWWmPPfyCfUnAIU0BAL7YD1WWlgSES1IrOjjEW/YQg7vlBNPy2tfvFUND+8fYiYjkxYv6MABW5xIu6UCChfvfDm080sLBSfacJHv0qH4LT/E1cYpLflhWR5IeaGdmPh80SLwGTimoLEDyEMX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404817; c=relaxed/simple;
	bh=6FA3Mc74uMP1zfHPCLYwZwh+5wtiXjN95/T/EaVto2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZscpkU0a7hr+YSL8OmIEGnmyvjj16m08oGJZCA6CPpD5P43CJp6GpgrX5PfC3jEh9BewGBX8s5UFeawlc0xagecZO2RXErcbzzy3SxOLq08+gFeZ0RBVnoMw2dEIdtAX/KDUGxUTkdw2d0OV4R1qe3IYIGlS5TbfqsaoXRcZqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XijevkKi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso341134b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713404815; x=1714009615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6c8NPGKwh1d0/MjyCA8yMerWDofMIRhSyFhdVq9q0Y=;
        b=XijevkKibMOohYDSZtHDC9B+VDMhhjferixtd5eppOXPNZsPEVV0h/skIPjp+Rxcyo
         M6SadHEXCnaNvF0kFKzNWr+pJ38wPYxZc92a7gAgACKvzibKL/i4OT6ILHYc8E4rN5SL
         a9NfBS4gdfpbnsnp/tZ/sQ5NZkKmPiZKkR2nnfxOMJvMSNgu8RCUL5EquKIcNpmVsaki
         QINLnB30fVlaf5CWqWowBKJ9lXFLWfC56oJajqfXJOFh5tu62NaBPLfC7gE7b27+mokr
         M9/II/V0Q51y0zueYwFCmlbxsS1o8YpnuOlSl3FKirwuA0KyYOUIKGOd5KQASse09hw3
         FS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713404815; x=1714009615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6c8NPGKwh1d0/MjyCA8yMerWDofMIRhSyFhdVq9q0Y=;
        b=Fea7PKA68K/eSfUsCTmAFEPEXdfDUPjytP6hLbpgcdtTqbXgjeeNUnVczg1cdCyU9t
         Yz3w+6xBHcVTENNVmwVhoBguHupkl2bpzbIBgwaroK3RqqIuMDfrvYWDyB/8tpKc4prZ
         pb93JW13X7AsYpR8k9wnvEiiAzbryEUaTdggagDkJ8qLccNsRazIIsuX5VFibj6DE/eR
         WQ2bdtLUUpfC/YrkxOqNunykyMzPs6Vcj9HWHqGWMrgdDbC0JgU4ieZ3m+2qY60mTuYM
         stnSXAEJ5/DfBtBewnm+TK5+pzwNheJyiirzpNXwbOuLzP3eTVnTBb9xD3f6xKy2yaDa
         WnJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7QPuoc9RLpK8vexHe5KkIaWB560vOT5tzLmHTXVSPX1Qy83VZJDj3ZbrGu9bVwQLSEx6B8MKP7JN57jk53lh4f6yLA39xG0ZfgeS0
X-Gm-Message-State: AOJu0YzJW5EAb8Q0hFC7baaravIdN9kptebKpjGElL4Gt/J9NSZvrOBG
	A3lw8e6lsY9nGhcXO4OzsxKxpJL/jvrujAK/Gu9OhmGfPbPRtyAlsLzartCH1cw=
X-Google-Smtp-Source: AGHT+IG/zkc64TRdRoXvs2+mG5mbGFnkrm9XNWov4qLhxwL9z0H8pSIwQdLydUaOfge/1TpfmdkRpQ==
X-Received: by 2002:a05:6a00:b85:b0:6ed:d68d:947f with SMTP id g5-20020a056a000b8500b006edd68d947fmr1799221pfj.1.1713404814947;
        Wed, 17 Apr 2024 18:46:54 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id h190-20020a636cc7000000b005d6a0b2efb3sm273999pgc.21.2024.04.17.18.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 18:46:54 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2] perf: RISC-V: Check standard event availability
Date: Wed, 17 Apr 2024 18:46:37 -0700
Message-ID: <20240418014652.1143466-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V SBI PMU specification defines several standard hardware and
cache events. Currently, all of these events are exposed to userspace,
even when not actually implemented. They appear in the `perf list`
output, and commands like `perf stat` try to use them.

This is more than just a cosmetic issue, because the PMU driver's .add
function fails for these events, which causes pmu_groups_sched_in() to
prematurely stop scheduling in other (possibly valid) hardware events.

Add logic to check which events are supported by the hardware (i.e. can
be mapped to some counter), so only usable events are reported to
userspace. Since the kernel does not know the mapping between events and
possible counters, this check must happen during boot, when no counters
are in use. Make the check asynchronous to minimize impact on boot time.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---
Before this patch:
$ perf list hw

List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  ref-cycles                                         [Hardware event]
  stalled-cycles-backend OR idle-cycles-backend      [Hardware event]
  stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event]

$ perf stat -ddd true

 Performance counter stats for 'true':

              4.36 msec task-clock                       #    0.744 CPUs utilized
                 1      context-switches                 #  229.325 /sec
                 0      cpu-migrations                   #    0.000 /sec
                38      page-faults                      #    8.714 K/sec
         4,375,694      cycles                           #    1.003 GHz                         (60.64%)
           728,945      instructions                     #    0.17  insn per cycle
            79,199      branches                         #   18.162 M/sec
            17,709      branch-misses                    #   22.36% of all branches
           181,734      L1-dcache-loads                  #   41.676 M/sec
             5,547      L1-dcache-load-misses            #    3.05% of all L1-dcache accesses
     <not counted>      LLC-loads                                                               (0.00%)
     <not counted>      LLC-load-misses                                                         (0.00%)
     <not counted>      L1-icache-loads                                                         (0.00%)
     <not counted>      L1-icache-load-misses                                                   (0.00%)
     <not counted>      dTLB-loads                                                              (0.00%)
     <not counted>      dTLB-load-misses                                                        (0.00%)
     <not counted>      iTLB-loads                                                              (0.00%)
     <not counted>      iTLB-load-misses                                                        (0.00%)
     <not counted>      L1-dcache-prefetches                                                    (0.00%)
     <not counted>      L1-dcache-prefetch-misses                                               (0.00%)

       0.005860375 seconds time elapsed

       0.000000000 seconds user
       0.010383000 seconds sys

After this patch:
$ perf list hw

List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]

$ perf stat -ddd true

 Performance counter stats for 'true':

              5.16 msec task-clock                       #    0.848 CPUs utilized
                 1      context-switches                 #  193.817 /sec
                 0      cpu-migrations                   #    0.000 /sec
                37      page-faults                      #    7.171 K/sec
         5,183,625      cycles                           #    1.005 GHz
           961,696      instructions                     #    0.19  insn per cycle
            85,853      branches                         #   16.640 M/sec
            20,462      branch-misses                    #   23.83% of all branches
           243,545      L1-dcache-loads                  #   47.203 M/sec
             5,974      L1-dcache-load-misses            #    2.45% of all L1-dcache accesses
   <not supported>      LLC-loads
   <not supported>      LLC-load-misses
   <not supported>      L1-icache-loads
   <not supported>      L1-icache-load-misses
   <not supported>      dTLB-loads
            19,619      dTLB-load-misses
   <not supported>      iTLB-loads
             6,831      iTLB-load-misses
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

       0.006085625 seconds time elapsed

       0.000000000 seconds user
       0.013022000 seconds sys


Changes in v2:
 - Move the event checking to a workqueue to make it asynchronous
 - Add more details to the commit message based on the v1 discussion

 drivers/perf/riscv_pmu_sbi.c | 45 +++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8cbe6e5f9c39..c326954af066 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -20,6 +20,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/sched/clock.h>
 #include <linux/soc/andes/irq.h>
+#include <linux/workqueue.h>
 
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
@@ -109,7 +110,7 @@ struct sbi_pmu_event_data {
 	};
 };
 
-static const struct sbi_pmu_event_data pmu_hw_event_map[] = {
+static struct sbi_pmu_event_data pmu_hw_event_map[] = {
 	[PERF_COUNT_HW_CPU_CYCLES]		= {.hw_gen_event = {
 							SBI_PMU_HW_CPU_CYCLES,
 							SBI_PMU_EVENT_TYPE_HW, 0}},
@@ -143,7 +144,7 @@ static const struct sbi_pmu_event_data pmu_hw_event_map[] = {
 };
 
 #define C(x) PERF_COUNT_HW_CACHE_##x
-static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
+static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
 [PERF_COUNT_HW_CACHE_OP_MAX]
 [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	[C(L1D)] = {
@@ -288,6 +289,34 @@ static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_M
 	},
 };
 
+static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
+			0, cmask, 0, edata->event_idx, 0, 0);
+	if (!ret.error) {
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+			  ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+	} else if (ret.error == SBI_ERR_NOT_SUPPORTED) {
+		/* This event cannot be monitored by any counter */
+		edata->event_idx = -EINVAL;
+	}
+}
+
+static void pmu_sbi_check_std_events(struct work_struct *work)
+{
+	for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
+		pmu_sbi_check_event(&pmu_hw_event_map[i]);
+
+	for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
+		for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++)
+			for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
+				pmu_sbi_check_event(&pmu_cache_event_map[i][j][k]);
+}
+
+static DECLARE_WORK(check_std_events_work, pmu_sbi_check_std_events);
+
 static int pmu_sbi_ctr_get_width(int idx)
 {
 	return pmu_ctr_list[idx].width;
@@ -473,6 +502,12 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 	u64 raw_config_val;
 	int ret;
 
+	/*
+	 * Ensure we are finished checking standard hardware events for
+	 * validity before allowing userspace to configure any events.
+	 */
+	flush_work(&check_std_events_work);
+
 	switch (type) {
 	case PERF_TYPE_HARDWARE:
 		if (config >= PERF_COUNT_HW_MAX)
@@ -634,7 +669,8 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 	 * which may include counters that are not enabled yet.
 	 */
 	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, pmu->cmask, 0, 0, 0, 0);
+		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+
 }
 
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
@@ -1108,6 +1144,9 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 
 	register_sysctl("kernel", sbi_pmu_sysctl_table);
 
+	/* Asynchronously check which standard events are available */
+	schedule_work(&check_std_events_work);
+
 	return 0;
 
 out_unregister:
-- 
2.44.0


