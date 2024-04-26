Return-Path: <linux-kernel+bounces-160724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6D8B41B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB80F2835A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3543A8E4;
	Fri, 26 Apr 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aimjhRJE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B677D38F82
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168753; cv=none; b=C99aEIhPdmKjvXpAd94M0L0vW6hYiQd7Q9S969vHqHldJfnX5tK0k1e/NQjphuTVenU920mVBfUeQYlT3yKwQY526fcpLTwku/6kUItaC4rgrWderu8CNschu2fRQziT7xg0tmzrUXxtVe1sCWU5vJM5De8Gi8PAeC+bpAIxJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168753; c=relaxed/simple;
	bh=VX1Y1UYuXkBzRvt8gF0IdHZLo9dneKHFhN1a5O4FF2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BmjPqRgKEC5ITpQNqwXH6y8jFwoJgZLPoVNBAuOcUeMbE8/2ZU//4RaYq7WqOZHJ+XAGXsXC9SeGYXOtR/uKWcL867ZpAeJxYFTWdpladW6w9W++ikr65U5F3wzQqAqQT2ZoVgmb2kdM8yXpx4l5pQIBfiHeNRnqlaAXKKD19SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aimjhRJE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3e84a302eso21202275ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714168751; x=1714773551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5z5Mv/2BBvV1JkDAAEQ2eU+L6J6I/Qb2vWkC4DKGuhk=;
        b=aimjhRJEQ8sCiRd8kIY6P2Rk9KuRyCybtTsUe+N+tHLiWj8xFQoak6b12AKFVV8D9c
         mguGoACEb8J6GXEbF5AVzA6+xVMh5lW7S3ExPbHOdOkAGC+Xi6WAFJHK8R2R3QzUBnvG
         8MDAFkfV8TqfNnbXWlthIptdNHNntOIpjjnBmCt4i1USOrqL0HgUiLqZmmKbM3ZKHW28
         RPFw0xYCdLAV3VnUkndEv/V5H58bI4IiZtPClsQB3LvwpjaMgp83lsb/PNgtULBTjD0y
         iqjsP9YzJYrUqjDe+/yF7zRHknvFPfynDXt+UCJAKqUeVqCOxzb21a7+LHWa+eTFRIFS
         FQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714168751; x=1714773551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z5Mv/2BBvV1JkDAAEQ2eU+L6J6I/Qb2vWkC4DKGuhk=;
        b=EviqqL8muEHt44/HyFsDUbPvsh+H//lHa7fd4SBStQ6sllYlAkdNHupBjxxbsghqzG
         GkphyHiKML2DSDxIqodss56JfqEaDuCxTCYUagC1FLtfQ4cGjYmFBSFfbpyE0kN7Yft3
         tRLMqDESR331j26RSZ+E74ihvTG87G8PG/ofcgtXYAK8n11z9tEOB7LpHZU0TnfU/hHp
         YL31t5o5VWzMFYx6SISLcSUFetBMeWN73NfH9k/niDqCeHoKRO3PimCPsH6FC6eS3+8n
         RtKGpzaZOD/nwU8sCVx7hJrIH9HTNlHcbDna8MFWtPjy1L6WUysT5yNW4l5BjKFIo0ck
         T7mA==
X-Forwarded-Encrypted: i=1; AJvYcCU7rc4d/YDq6DJdDNQAt9M+wuTrZ4GkMAciqHY0vhCZtVWB/siDvH1k4qvYYrgKNUoFibJocPtu3mWYwLYpwizBvyBhmOYWb0hphypF
X-Gm-Message-State: AOJu0YwgVsPEaZ6aRPAurfBWDZjMFq2eF+PPXuj3kbQRHjPatlh1Tky3
	68AnNoP0SqupbBBNfEtoZ1T9GFaWU7YdeFOPHJ4+oH51ElmtnxRFQZUHpMfIX3k=
X-Google-Smtp-Source: AGHT+IH/pNxhEQGe0VDJp1wwswkelnXqZTWCaOASRoPoEKeCOdPJa738fSUl/pa8dYH6jN1ay6rU5g==
X-Received: by 2002:a17:903:110e:b0:1e5:c0ee:a7f9 with SMTP id n14-20020a170903110e00b001e5c0eea7f9mr4378566plh.14.1714168751046;
        Fri, 26 Apr 2024 14:59:11 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b001e2a7e90321sm15899787plc.224.2024.04.26.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:59:10 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:58:54 -0700
Subject: [PATCH v2 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-cpufeature_fixes-v2-1-7377442b1327@rivosinc.com>
References: <20240426-cpufeature_fixes-v2-0-7377442b1327@rivosinc.com>
In-Reply-To: <20240426-cpufeature_fixes-v2-0-7377442b1327@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714168747; l=4872;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=VX1Y1UYuXkBzRvt8gF0IdHZLo9dneKHFhN1a5O4FF2c=;
 b=2xyEAQOLy5fmXV5x9uhPYv9OMvTVGRVCYPF+zx4H0rpNyqhUnYgEbZgt8mBRrBySg0aTxXpen
 rqR3WiqN6m5AHQi3O+uwrG2J1q2dE6G9/87T3TcHlN8jQqAyH/K+j/8
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The riscv_cpuinfo struct that contains mvendorid and marchid is not
populated until all harts are booted which happens after the DT parsing.
Use the vendorid/archid values from the DT if available or assume all
harts have the same values as the boot hart as a fallback.

Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/sbi.h   |  2 ++
 arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++----
 arch/riscv/kernel/cpufeature.c | 11 +++++++++--
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..0fab508a65b3 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -370,6 +370,8 @@ static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1
 static inline void sbi_init(void) {}
 #endif /* CONFIG_RISCV_SBI */
 
+unsigned long riscv_get_mvendorid(void);
+unsigned long riscv_get_marchid(void);
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id);
 unsigned long riscv_cached_marchid(unsigned int cpu_id);
 unsigned long riscv_cached_mimpid(unsigned int cpu_id);
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index d11d6320fb0d..c1f3655238fd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -139,6 +139,34 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 	return -1;
 }
 
+unsigned long __init riscv_get_marchid(void)
+{
+	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
+
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
+#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
+	ci->marchid = csr_read(CSR_MARCHID);
+#else
+	ci->marchid = 0;
+#endif
+	return ci->marchid;
+}
+
+unsigned long __init riscv_get_mvendorid(void)
+{
+	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
+
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
+#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
+	ci->mvendorid = csr_read(CSR_MVENDORID);
+#else
+	ci->mvendorid = 0;
+#endif
+	return ci->mvendorid;
+}
+
 DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
@@ -170,12 +198,16 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
 	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
 
 #if IS_ENABLED(CONFIG_RISCV_SBI)
-	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
-	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
+	if (!ci->mvendorid)
+		ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
+	if (!ci->marchid)
+		ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
 	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
 #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
-	ci->mvendorid = csr_read(CSR_MVENDORID);
-	ci->marchid = csr_read(CSR_MARCHID);
+	if (!ci->mvendorid)
+		ci->mvendorid = csr_read(CSR_MVENDORID);
+	if (!ci->marchid)
+		ci->marchid = csr_read(CSR_MARCHID);
 	ci->mimpid = csr_read(CSR_MIMPID);
 #else
 	ci->mvendorid = 0;
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..500a9bd70f51 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -490,6 +490,8 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 	struct acpi_table_header *rhct;
 	acpi_status status;
 	unsigned int cpu;
+	u64 boot_vendorid;
+	u64 boot_archid;
 
 	if (!acpi_disabled) {
 		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
@@ -497,6 +499,9 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			return;
 	}
 
+	boot_vendorid = riscv_get_mvendorid();
+	boot_archid = riscv_get_marchid();
+
 	for_each_possible_cpu(cpu) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 		unsigned long this_hwcap = 0;
@@ -543,9 +548,11 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		 * version of the vector specification put "v" into their DTs.
 		 * CPU cores with the ratified spec will contain non-zero
 		 * marchid.
+		 *
+		 * Assume that if the boot hart is T-Head, then all harts in the
+		 * SoC are also T-Head and have the same archid.
 		 */
-		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
-		    riscv_cached_marchid(cpu) == 0x0) {
+		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
 			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
 			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
 		}

-- 
2.44.0


