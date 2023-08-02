Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F5676C805
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjHBIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHBIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:09:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AAEE7D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:09:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso32925195e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690963748; x=1691568548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R45KJ8XHyzPlJWiJBpBPEEo2H/ciDziDBY6xvMQUNYU=;
        b=2tDCQHcAPyll8azBJd6dT6utA3BsWAqg/oeFquak3rYJTTSVdo+7F+w2jLC0HXv8rP
         pSILAnhEcZPi6VbP6zEsHBU5f3qTJQHP3EE2PXKQXjx5fTw9kDg4LFayCR5OAAO+z2gm
         U/X7Dyo5P3qgMxrRek/+0NJb2+XAYK88dRSmw8MDbWma56fqnwgGDE7DnLD5qCS605sb
         yT3BVqmCRrTtQFQCn5Ws5VAlqKeqBN3E2tD0LfFdsejHXyXCNZKrWWATMGw+cdvnrzG6
         zLHkbblQ35KnzPs3j1UkRmD6kXTA1rGz0Twg+Z48zziL+KDgO0SrapKM01E9D0C6Oklu
         NcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963748; x=1691568548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R45KJ8XHyzPlJWiJBpBPEEo2H/ciDziDBY6xvMQUNYU=;
        b=OqIzgE3nebDur0FxCsJUfLiZVpK5fA55EqSHSb2yiuWLzInN+fduJHB/65rWD7v3FP
         bR9qAyWcQsvzZgY/xxSR/GZExpABZ1d3XCJ29ngu7zDM0NTfY6QpXRB8a8MXqR7CGg9V
         wX8Pw/DXqIWag5S2Vwpa7R/wJ3ulUTGOPyDX7t3I3nmZDPWngHzPdUluqsFqTaHB0daB
         5BjXnWC3DhszDBsq6CwiS53PU/FRjQRlwIN2fxuNKVsQCUU5RYA41TVrfqN/AxvKrLSQ
         ef4CC31K8xYzeTsNqDt1JkHCTSJ4WONkoHE0wFAS7pbgWiAuEIBQsuWPaQwHg9v6yBvo
         /16Q==
X-Gm-Message-State: ABy/qLYhqhw7KqICwAr+Aho9iRezQz/IKdORDH/7fw0w0BcOTnaC9Eb8
        VKxwIocwM3oYBSuhrkzZgiqrJg==
X-Google-Smtp-Source: APBJJlFUlQSRse2dEoorLdMBGniWPgB64VymNk/XGBMbL6DNGPgqSv6Jjauagm3vhVxcG56361bPrw==
X-Received: by 2002:a7b:c010:0:b0:3fe:12a2:7d25 with SMTP id c16-20020a7bc010000000b003fe12a27d25mr4060313wmb.23.1690963748207;
        Wed, 02 Aug 2023 01:09:08 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c22d600b003fbb618f7adsm1006803wmg.15.2023.08.02.01.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:09:07 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v6 05/10] riscv: Prepare for user-space perf event mmap support
Date:   Wed,  2 Aug 2023 10:03:23 +0200
Message-Id: <20230802080328.1213905-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802080328.1213905-1-alexghiti@rivosinc.com>
References: <20230802080328.1213905-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide all the necessary bits in the generic riscv pmu driver to be
able to mmap perf events in userspace: the heavy lifting lies in the
driver backend, namely the legacy and sbi implementations.

Note that arch_perf_update_userpage is almost a copy of arm64 code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu.c       | 105 +++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h |   4 ++
 2 files changed, 109 insertions(+)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index ebca5eab9c9b..432ad2e80ce3 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -14,9 +14,73 @@
 #include <linux/perf/riscv_pmu.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
+#include <linux/sched_clock.h>
 
 #include <asm/sbi.h>
 
+static bool riscv_perf_user_access(struct perf_event *event)
+{
+	return ((event->attr.type == PERF_TYPE_HARDWARE) ||
+		(event->attr.type == PERF_TYPE_HW_CACHE) ||
+		(event->attr.type == PERF_TYPE_RAW)) &&
+		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
+}
+
+void arch_perf_update_userpage(struct perf_event *event,
+			       struct perf_event_mmap_page *userpg, u64 now)
+{
+	struct clock_read_data *rd;
+	unsigned int seq;
+	u64 ns;
+
+	userpg->cap_user_time = 0;
+	userpg->cap_user_time_zero = 0;
+	userpg->cap_user_time_short = 0;
+	userpg->cap_user_rdpmc = riscv_perf_user_access(event);
+
+	userpg->pmc_width = 64;
+
+	do {
+		rd = sched_clock_read_begin(&seq);
+
+		userpg->time_mult = rd->mult;
+		userpg->time_shift = rd->shift;
+		userpg->time_zero = rd->epoch_ns;
+		userpg->time_cycles = rd->epoch_cyc;
+		userpg->time_mask = rd->sched_clock_mask;
+
+		/*
+		 * Subtract the cycle base, such that software that
+		 * doesn't know about cap_user_time_short still 'works'
+		 * assuming no wraps.
+		 */
+		ns = mul_u64_u32_shr(rd->epoch_cyc, rd->mult, rd->shift);
+		userpg->time_zero -= ns;
+
+	} while (sched_clock_read_retry(seq));
+
+	userpg->time_offset = userpg->time_zero - now;
+
+	/*
+	 * time_shift is not expected to be greater than 31 due to
+	 * the original published conversion algorithm shifting a
+	 * 32-bit value (now specifies a 64-bit value) - refer
+	 * perf_event_mmap_page documentation in perf_event.h.
+	 */
+	if (userpg->time_shift == 32) {
+		userpg->time_shift = 31;
+		userpg->time_mult >>= 1;
+	}
+
+	/*
+	 * Internal timekeeping for enabled/running/stopped times
+	 * is always computed with the sched_clock.
+	 */
+	userpg->cap_user_time = 1;
+	userpg->cap_user_time_zero = 1;
+	userpg->cap_user_time_short = 1;
+}
+
 static unsigned long csr_read_num(int csr_num)
 {
 #define switchcase_csr_read(__csr_num, __val)		{\
@@ -171,6 +235,8 @@ int riscv_pmu_event_set_period(struct perf_event *event)
 
 	local64_set(&hwc->prev_count, (u64)-left);
 
+	perf_event_update_userpage(event);
+
 	return overflow;
 }
 
@@ -267,6 +333,9 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	hwc->idx = -1;
 	hwc->event_base = mapped_event;
 
+	if (rvpmu->event_init)
+		rvpmu->event_init(event);
+
 	if (!is_sampling_event(event)) {
 		/*
 		 * For non-sampling runs, limit the sample_period to half
@@ -283,6 +352,39 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	return 0;
 }
 
+static int riscv_pmu_event_idx(struct perf_event *event)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+
+	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
+		return 0;
+
+	if (rvpmu->csr_index)
+		return rvpmu->csr_index(event) + 1;
+
+	return 0;
+}
+
+static void riscv_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+
+	if (rvpmu->event_mapped) {
+		rvpmu->event_mapped(event, mm);
+		perf_event_update_userpage(event);
+	}
+}
+
+static void riscv_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+
+	if (rvpmu->event_unmapped) {
+		rvpmu->event_unmapped(event, mm);
+		perf_event_update_userpage(event);
+	}
+}
+
 struct riscv_pmu *riscv_pmu_alloc(void)
 {
 	struct riscv_pmu *pmu;
@@ -307,6 +409,9 @@ struct riscv_pmu *riscv_pmu_alloc(void)
 	}
 	pmu->pmu = (struct pmu) {
 		.event_init	= riscv_pmu_event_init,
+		.event_mapped	= riscv_pmu_event_mapped,
+		.event_unmapped	= riscv_pmu_event_unmapped,
+		.event_idx	= riscv_pmu_event_idx,
 		.add		= riscv_pmu_add,
 		.del		= riscv_pmu_del,
 		.start		= riscv_pmu_start,
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 5deeea0be7cb..43282e22ebe1 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -55,6 +55,10 @@ struct riscv_pmu {
 	void		(*ctr_start)(struct perf_event *event, u64 init_val);
 	void		(*ctr_stop)(struct perf_event *event, unsigned long flag);
 	int		(*event_map)(struct perf_event *event, u64 *config);
+	void		(*event_init)(struct perf_event *event);
+	void		(*event_mapped)(struct perf_event *event, struct mm_struct *mm);
+	void		(*event_unmapped)(struct perf_event *event, struct mm_struct *mm);
+	uint8_t		(*csr_index)(struct perf_event *event);
 
 	struct cpu_hw_events	__percpu *hw_events;
 	struct hlist_node	node;
-- 
2.39.2

