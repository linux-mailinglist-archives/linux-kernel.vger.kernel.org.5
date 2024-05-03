Return-Path: <linux-kernel+bounces-167250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E88BA66C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3CBB2321B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560ED139CF8;
	Fri,  3 May 2024 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xEokoUz0"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503913959F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711859; cv=none; b=UoBGW1ShNCCevpal8pqbyyNKSd8g8R55wP4JOOVRM5bfs8Vxp+3RTA/NHomXU+NlqChZxG2+Bf7TcOyxXX2gA4Ed1eoGjTMgHlSq51k4VtYFtGq8uzIFMWyKWjiCns4XkJWDB0IwR3b9rHSfKvx2ol3nk6t1+Th07bbQcPAgMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711859; c=relaxed/simple;
	bh=TuTVSbXhC2+Pf7yEowJN8gfvY+TdoOJRAjnj2qooZU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVsg5rfL3OHf8xn7lCpAV1h0ZNeXav1kXDguGu8p9X0hqU4Sg/LTrEVKzN/4adliLdgkdd8Czjz9T6/sTZUw9RukBtfFPPHjx+JaXtbooBD5uW/lVLYpfzIj1B8sgdvRicDzAENLQNfM/hY5SfPpV4yiuRKYOJeCU0osyfh4UjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xEokoUz0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ed41eb3382so1273715ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 21:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711857; x=1715316657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7J8+4BPg11tVammG7iU8LBCVcp0HAz7W5E4tQ6iskcc=;
        b=xEokoUz0nHaZ+OsGmh64obMsyimka54QYDLK5L25Y8Mnym6Jf8Xf74YMREKz8VAlg+
         Mu+TkljfuuYy8sokKji8LgDRAxWin84DSybbg9/+KVAyvYB0V1HzXq5lF+Ex7pXRC2CF
         MV8FQFzItGKyufKgBtPoQA/FPGtdqA+nf9Ly8AHxCfntI7BI55CxSnAzaDg6a1SlFEjc
         c3nKJeaw0HEFAUy0b1Ei3rcjt+FJeRF0bMGlB+REwHkEZ4BFSIqTmMAoEkCc4DMDaVFs
         v497J5kI/rPzMplIDMEWeLx0haOMklIWsxYXRqk5fJfDWIibPp7o7CeYuv2qPg6WDIa/
         4qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711857; x=1715316657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J8+4BPg11tVammG7iU8LBCVcp0HAz7W5E4tQ6iskcc=;
        b=Z0pOC+JvrNfX0UBx2Ecpu4G43bv6SWhE0oalr1E6ZLPpbwiY8A6TkAD9wpJqxe3tga
         XINI0pKHHRcVl9GXFI+HEXthyt+uqhVtu2ufy0helXCb6IORjl/UA0+b4HWzKRtG8fQn
         g7izVZaolJitPtD09q9O3C6yNMEXuyn2mLmbktS2nnSb692h4Nic+DmIdLwwJpLLw1mS
         RCDwjiG/R7FLml504vti5dOxE6tei4CLLk9P58jIoL3muMbHj9pxFr9WecUjJAMIJcxb
         aUhLoB0X+UKEU7DZB4Pgf59MUYY8Rqs7cyPPWYoslv2Iv2jKiTNXisCOpoXDQ/YClLXH
         Jvhg==
X-Forwarded-Encrypted: i=1; AJvYcCUR2GZVWZI5ASEbY0MJ0IIoMISi29/jYOWKMumKmHDT8d0RI7hxgZdY66tCqfD1SSOF4ShohodmCcWj4PVd68vgO1iRIWnn54vrnYWO
X-Gm-Message-State: AOJu0YzmEKha3/qaoRy2ySs1JKMdIx/LJO5BAR0uAjS1+oqj5oCxjpP8
	C3E1KC96XGH3ys7MLzpAt/kanIDDUkSjH1x+u6pSqXLANcxX4/f7/wBcHzBZAZo=
X-Google-Smtp-Source: AGHT+IE2GM/FT0Bn/phAha5Olfrwy5UPqVYHFI/KC1ovLGni/veB92iOt5IkZk5eHeVdspJeej9buw==
X-Received: by 2002:a17:903:246:b0:1e5:d021:cf58 with SMTP id j6-20020a170903024600b001e5d021cf58mr1945544plh.36.1714711857409;
        Thu, 02 May 2024 21:50:57 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id li11-20020a170903294b00b001e3c77db2aesm2276384plb.88.2024.05.02.21.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:50:54 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:50:50 -0700
Subject: [PATCH v4 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-cpufeature_fixes-v4-1-b3d1a088722d@rivosinc.com>
References: <20240502-cpufeature_fixes-v4-0-b3d1a088722d@rivosinc.com>
In-Reply-To: <20240502-cpufeature_fixes-v4-0-b3d1a088722d@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711851; l=4634;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=TuTVSbXhC2+Pf7yEowJN8gfvY+TdoOJRAjnj2qooZU8=;
 b=QqmJvtQyLn100wNUhTZKNDHlffN3SHuM3dGD+WP+ZSJN+94mkJDGWHu4cu0YHNBzMywFInnmG
 uKF6sHe4L9OCxlWy+zEPhROi9Hq8yPPqN0T1U2x+j1PsHO3R1wmlm/X
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The riscv_cpuinfo struct that contains mvendorid and marchid is not
populated until all harts are booted which happens after the DT parsing.
Use the mvendorid/marchid from the boot hart to determine if the DT
contains an invalid V.

Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/sbi.h   |  2 ++
 arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++----
 arch/riscv/kernel/cpufeature.c |  8 ++++++--
 3 files changed, 44 insertions(+), 6 deletions(-)

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
index 3ed2359eae35..13d4fc0d1817 100644
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
@@ -544,8 +549,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		 * CPU cores with the ratified spec will contain non-zero
 		 * marchid.
 		 */
-		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
-		    riscv_cached_marchid(cpu) == 0x0) {
+		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
 			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
 			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
 		}

-- 
2.44.0


