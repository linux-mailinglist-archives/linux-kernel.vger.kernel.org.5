Return-Path: <linux-kernel+bounces-159369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516EB8B2DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C4B281E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8C158D94;
	Thu, 25 Apr 2024 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EU9i+AOL"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF2156C6A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088906; cv=none; b=mi25k9UuEa0u/QiUHDT2boQptLyCkNVxEb3qycmxWEz5p4b+Ael6nD0CHHo9LeHQIqQe/VtHjkEukMjmVjPzwDQJJtNgdQKE0Bk/lScMTnIhriFlUyag/ZfGG98q5pZkQSswwwTrYlu/vKSnqeEEIlzXt5jwzGr4To1eXX77hwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088906; c=relaxed/simple;
	bh=6tcJOvrFV1iMaEVoAqZMacKXa4AyJaINchYn8HitefA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DX5cbNaXAlfMmU87vRZQR7tEP/b//IE85NFO+9MsTZXqdnuWOd5JbimtjgAToukzqIie78SsOkC2cbe3m+Cgshr7F13ci0aNfN5La6SGCMwkYBonoQ3D2YS97nYMDt4weCsP2ppIDjG5hX7Fiqb+OJoQKMHMtRpp75t16q7kBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EU9i+AOL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eab699fcddso11166435ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714088903; x=1714693703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ7DvnuhtpSAdZVzlWSG9HvYdyHUjrzZHHo/ISn+uFM=;
        b=EU9i+AOLNslermU3q/qwldC0XhQEH2zkmqLeDal9esAqTJR64uQVgUT3cMy5sg/u4Q
         xhbBedqJomQYGacBk9/zrH+fEBFs+6YUiUbYB5UQHIBTCDf8qVwMWF12k0ZRZZtU04aD
         IW9SnpKKhrZ37QIQHppVI85RnB8VlLVjw6F5sO7cqPahrADTjQXjjEF13nUvHgxr0qb9
         lca1z7035I8wfP7V/VgSSnlRBcJuftGag8P5SeMNU3Przz+xH0Y6BruIDYtNmmbTGeos
         AVjX7K24OYwO9eT36COZFoa/BZItDY+Tbfp8W1qmEAJk8foip15ar/ZbaIn0SFCCvGJb
         UKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714088903; x=1714693703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZ7DvnuhtpSAdZVzlWSG9HvYdyHUjrzZHHo/ISn+uFM=;
        b=Woz0elrHmHOUdGue7eGoEtI/wn/FFigSqYhHfThUjOs/NKJlZfVr2gzIIRZZKyw2ms
         1Z0dIk9YPx3l3RMtfQW16LKgIzaL1DFx8cvhraMNsvc527Ot42mFLcmilSkCF/t7k/9m
         4juDV1u2dROTmSOXcSKS07azfcEFUWhpEs2KPQ/rphCM2R+Q9vLpVIjGNEvk9e8wXDkm
         WwNwUG0nx3VZF0JWTizI0+OvuB5KnLeo98qKZsCUOVKO4itr6GPZufzSpd1M1KecbQ6T
         4nrkR70yL4nBQEo5XqzDzb82rox/kJolbwNAdDri5NtZ7aHApfEUM8hFljSIWgV8+fjF
         f2jg==
X-Gm-Message-State: AOJu0YzMHfAYPYefHL/MLQCXk90yjqCCptEwJCboapFGDEZAswVHBFxy
	cm743ibAK0ixagqAsxy283gzVgrQMQm21EWCZdMeVr+fzZFkNsyBj0vvZxo/3Y6nlWOshcLzjaz
	d
X-Google-Smtp-Source: AGHT+IGpkxpVvMWJQWbQvANCX7WQJuW5fyjePUy9yCGZseGfULFbWEJYzubnJIqYoSm63FBKJq95AA==
X-Received: by 2002:a17:903:1246:b0:1e4:31e9:83ba with SMTP id u6-20020a170903124600b001e431e983bamr1293736plh.1.1714088903558;
        Thu, 25 Apr 2024 16:48:23 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001e0b5eeee41sm14349281pla.38.2024.04.25.16.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 16:48:23 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 kvm-riscv/for-next 2/2] drivers/perf: riscv: Fix RV32 snapshot overflow use case
Date: Thu, 25 Apr 2024 20:16:37 -0700
Message-Id: <20240426031637.4135544-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426031637.4135544-1-atishp@rivosinc.com>
References: <20240426031637.4135544-1-atishp@rivosinc.com>
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

Fixes: 22f5dac41004 ("drivers/perf: riscv: Implement SBI PMU snapshot function")

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c   | 45 +++++++++++++++++++---------------
 include/linux/perf/riscv_pmu.h |  2 ++
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 2694110f1cff..5d699b06dcb6 100644
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
@@ -769,36 +770,36 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
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
+			for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG)
+				cpu_hw_evt->snapshot_cval_shcopy[i * BITS_PER_LONG + idx] =
+							sdata->ctr_values[idx];
 			/* Save the overflow mask to avoid clobbering */
-			if (BIT(i) & sdata->ctr_overflow_mask)
-				temp_ctr_overflow_mask |= BIT(i + i * BITS_PER_LONG);
+			temp_ctr_overflow_mask |= sdata->ctr_overflow_mask << (i * BITS_PER_LONG);
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
 
@@ -850,7 +851,7 @@ static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
 static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
 						   u64 ctr_ovf_mask)
 {
-	int idx = 0;
+	int i, idx = 0;
 	struct perf_event *event;
 	unsigned long flag = SBI_PMU_START_FLAG_INIT_SNAPSHOT;
 	u64 max_period, init_val = 0;
@@ -863,7 +864,7 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
 			hwc = &event->hw;
 			max_period = riscv_pmu_ctr_get_width_mask(event);
 			init_val = local64_read(&hwc->prev_count) & max_period;
-			sdata->ctr_values[idx] = init_val;
+			cpu_hw_evt->snapshot_cval_shcopy[idx] = init_val;
 		}
 		/*
 		 * We do not need to update the non-overflow counters the previous
@@ -871,10 +872,14 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
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
 
@@ -898,7 +903,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
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


