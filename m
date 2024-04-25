Return-Path: <linux-kernel+bounces-159084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 475E28B2919
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB871F22366
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7B1534FC;
	Thu, 25 Apr 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="upL2gC1L"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64E15251C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714074001; cv=none; b=o15MP6yiI2qZDb4TppW37yJp9HAMO/vVCjkVF36f+/Smuv9YyFlOGidvDCN+daRlPjNDgio9KQbGmdPDqHej91Bpo4oeZ2AcnZj5gh7GhB75LNLMJeoVHH/gQgosKG6H2UYzlLdAFFPtW0skEBooNfZmUfMpvul7N9dq8UIENS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714074001; c=relaxed/simple;
	bh=eonC85eoFtBJtpDL59x2N+cpTWUJEFnuEMfzaBkKfbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhibZs+qYo7CJiYLkhkPQP2/hmr2vz9zlZrOE43vl7PQz2sVdx5X1itKHZwU1oX1NKvggJUnfJEJpsWYB63LxV0pCSa/Gx1lTLL7oec8Qo7GRBMrOGV3P3DvSltZ1JIbSKfbTBIvAWipTgQDo67ho4B2aVsQemLdrEBEOPq2bYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=upL2gC1L; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ecec796323so1500971b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714073998; x=1714678798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuEzACDgvxR/jlPdG6IpUjcsXiIpoPyyUaqA1tLQdL8=;
        b=upL2gC1L8CFSqUuAPyKO3LEYl+hZzyh/EtbUL57j/HmavW4/e3cAvek43PkBql8iHa
         XdJw3djlCml+IQdFbF/tAbHy+vy0UOlsye6N2tcbbm+oIaOArEX5OFD8TKBshJY76WSc
         xjptYUd6tgTFxM0GyomxKYXz1ma/2g3lZB1+Pc7OG4a1y6uAj8P6gDvTFvJJibk6tHuU
         utagmLn40wGJHYRVI02Sb9nv9wsA8Caua8kf7phCollEcZvFKE36t1Ro6LVxV6nRi/Bx
         06kbZv4JjveSU5lFSD1My0n6hcZq06n/kKsz11IlioFwhwOmIi5ePXrATt4DSNZpkDq8
         Skvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714073998; x=1714678798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuEzACDgvxR/jlPdG6IpUjcsXiIpoPyyUaqA1tLQdL8=;
        b=ItV7ibO+Tt83LOB78Go0gJIqvTqDMZF2C9R92x4wwv9Ivtv7s740Jtr6JmXplNE0NN
         QYEEnOGuEUWq0LeVaHACGkJBpJNsu9PukLecJTQtbCL3GzWQJ5TlfwcF28GygDFE77WC
         ipwZIvrFT10CS0AFG65ey4c8UQ3EcXj/f1HLYb2qE8JPnDMXlCkhzcXPHtnjdetTCLzH
         eCjIpxIlTTHhD+8dXMO+s0CxWDF7HJG6GmnaGii2hmYmMiOtmVDg9bAJtI/jwzzD5Lzt
         2Sw6uiAptrcPE9y+O8GjK6ACvReFhqsSU5PEqBXClen+nhSmOY6nzA4+nukh+6gmUov3
         sYNA==
X-Gm-Message-State: AOJu0Yx9DIHQhSwGRi7FM6rgWVXx/JRC1rdJIdlzkIX1IMbIIxL16rFB
	wV3CTr4gc1d7xXpjjvyKcp3d8BJCBxe40BhcCp4cg8gnjaeovMNZKvV6sUHDou97IZ2kljn8dPf
	0
X-Google-Smtp-Source: AGHT+IHWwmGuvBVQMoylwvzXz3CnnNRk0Jt2cal/7gbWtOpzPMnzFmO8NffRKGYa6qFriuIqRhnFMA==
X-Received: by 2002:a05:6a20:dc95:b0:1aa:9595:4261 with SMTP id ky21-20020a056a20dc9500b001aa95954261mr722289pzb.22.1714073998176;
        Thu, 25 Apr 2024 12:39:58 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fk12-20020a056a003a8c00b006e6a684a6ddsm13525487pfb.220.2024.04.25.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:39:57 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>
Subject: [kvm-riscv/for-next 2/2] drivers/perf: riscv: Fix RV32 snapshot overflow use case
Date: Thu, 25 Apr 2024 16:29:32 -0700
Message-Id: <20240425232933.4111680-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425232933.4111680-1-atishp@rivosinc.com>
References: <20240425232933.4111680-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shadow copy alogirthm is implemented incorrectly. This patch fixes
the behavior by keeping a per cpu shadow copy of the counter values to
avoid clobbering for the cases where system more than XLEN counters and
the overflown counter index are beyond XLEN. This issue can only be
observed only in RV32 if an SBI implementation assigns logical counters
ids greater than XLEN or firmware counter overflow is supported in the
future.

Fixes : commit 22f5dac41004d ("drivers/perf: riscv: Implement SBI PMU snapshot function")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c   | 49 +++++++++++++++++++---------------
 include/linux/perf/riscv_pmu.h |  2 ++
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 2694110f1cff..98aaeb13e9db 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -588,6 +588,7 @@ static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
 		return sbi_err_map_linux_errno(ret.error);
 	}
 
+	memset(cpu_hw_evt->snapshot_cval_shcopy, 0, sizeof(u64) * RISCV_MAX_COUNTERS);
 	cpu_hw_evt->snapshot_set_done = true;
 
 	return 0;
@@ -605,7 +606,7 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
 	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
 
 	/* Read the value from the shared memory directly only if counter is stopped */
-	if (sbi_pmu_snapshot_available() & (hwc->state & PERF_HES_STOPPED)) {
+	if (sbi_pmu_snapshot_available() && (hwc->state & PERF_HES_STOPPED)) {
 		val = sdata->ctr_values[idx];
 		return val;
 	}
@@ -769,36 +770,38 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 	unsigned long flag = 0;
-	int i;
+	int i, idx;
 	struct sbiret ret;
-	unsigned long temp_ctr_values[64] = {0};
-	unsigned long ctr_val, temp_ctr_overflow_mask = 0;
+	u64 temp_ctr_overflow_mask = 0;
 
 	if (sbi_pmu_snapshot_available())
 		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
 
+	/* Reset the shadow copy to avoid save/restore any value from previous overflow */
+	memset(cpu_hw_evt->snapshot_cval_shcopy, 0, sizeof(u64) * RISCV_MAX_COUNTERS);
+
 	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
 		/* No need to check the error here as we can't do anything about the error */
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
 				cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
 		if (!ret.error && sbi_pmu_snapshot_available()) {
 			/* Save the counter values to avoid clobbering */
-			temp_ctr_values[i * BITS_PER_LONG + i] = sdata->ctr_values[i];
-			/* Save the overflow mask to avoid clobbering */
-			if (BIT(i) & sdata->ctr_overflow_mask)
-				temp_ctr_overflow_mask |= BIT(i + i * BITS_PER_LONG);
+			for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG) {
+				cpu_hw_evt->snapshot_cval_shcopy[i * BITS_PER_LONG + idx] =
+							sdata->ctr_values[idx];
+				/* Save the overflow mask to avoid clobbering */
+				if (BIT(idx) & sdata->ctr_overflow_mask)
+					temp_ctr_overflow_mask |= BIT(idx + i * BITS_PER_LONG);
+			}
 		}
 	}
 
-	/* Restore the counter values to the shared memory */
+	/* Restore the counter values to the shared memory for used hw counters */
 	if (sbi_pmu_snapshot_available()) {
-		for (i = 0; i < 64; i++) {
-			ctr_val = temp_ctr_values[i];
-			if (ctr_val)
-				sdata->ctr_values[i] = ctr_val;
-			if (temp_ctr_overflow_mask)
-				sdata->ctr_overflow_mask = temp_ctr_overflow_mask;
-		}
+		for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS)
+			sdata->ctr_values[idx] = cpu_hw_evt->snapshot_cval_shcopy[idx];
+		if (temp_ctr_overflow_mask)
+			sdata->ctr_overflow_mask = temp_ctr_overflow_mask;
 	}
 }
 
@@ -850,7 +853,7 @@ static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
 static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
 						   u64 ctr_ovf_mask)
 {
-	int idx = 0;
+	int i, idx = 0;
 	struct perf_event *event;
 	unsigned long flag = SBI_PMU_START_FLAG_INIT_SNAPSHOT;
 	u64 max_period, init_val = 0;
@@ -863,7 +866,7 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
 			hwc = &event->hw;
 			max_period = riscv_pmu_ctr_get_width_mask(event);
 			init_val = local64_read(&hwc->prev_count) & max_period;
-			sdata->ctr_values[idx] = init_val;
+			cpu_hw_evt->snapshot_cval_shcopy[idx] = init_val;
 		}
 		/*
 		 * We do not need to update the non-overflow counters the previous
@@ -871,10 +874,14 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
 		 */
 	}
 
-	for (idx = 0; idx < BITS_TO_LONGS(RISCV_MAX_COUNTERS); idx++) {
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+		/* Restore the counter values to relative indices for used hw counters */
+		for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG)
+			sdata->ctr_values[idx] =
+					cpu_hw_evt->snapshot_cval_shcopy[idx + i * BITS_PER_LONG];
 		/* Start all the counters in a single shot */
 		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LONG,
-			  cpu_hw_evt->used_hw_ctrs[idx], flag, 0, 0, 0);
+			  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
 	}
 }
 
@@ -898,7 +905,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	int lidx, hidx, fidx;
 	struct riscv_pmu *pmu;
 	struct perf_event *event;
-	unsigned long overflow;
+	u64 overflow;
 	u64 overflowed_ctrs = 0;
 	struct cpu_hw_events *cpu_hw_evt = dev;
 	u64 start_clock = sched_clock();
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index c3fa90970042..701974639ff2 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -45,6 +45,8 @@ struct cpu_hw_events {
 	phys_addr_t snapshot_addr_phys;
 	/* Boolean flag to indicate setup is already done */
 	bool snapshot_set_done;
+	/* A shadow copy of the counter values to avoid clobbering during multiple SBI calls */
+	u64 snapshot_cval_shcopy[RISCV_MAX_COUNTERS];
 };
 
 struct riscv_pmu {
-- 
2.34.1


