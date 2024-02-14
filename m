Return-Path: <linux-kernel+bounces-65150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E1885489A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871551C23280
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A40199B9;
	Wed, 14 Feb 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hhqXvhqM"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2DD1B96E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910829; cv=none; b=ZvT/X35gqZiAdHppB0OSXbOP80BM44mrIlIWbxA6XXNHYyNAJXq6VEU57CyCfA8pvppffIhHLkKu3zeNJrpBLNcxQpD0kI/lDWVdIkC8Qj1Uu0oDRHBRKUIhcT1HzYFaH/rHR4h+mu8PkOqdmfOkYSGBm06ozMdFZbEpsxBYYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910829; c=relaxed/simple;
	bh=sUVHJStUPDAf8x44uZgtpOx2qRPnBa4keaRUx4keBN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKK4KpogV2IXTZigMaoxTRUwAIIdAmywP1+R4wSAMtgCsLhsfVy9pBnuleURVtMLoSZbOykWYPznJkutH8ackIaOcj2+J+4+4nu0Jrgj+VsnckQvGbO6AMC2fapyIAseREKHNEU5K23h4ppBDy1TxAoo7D70+BLTmlEcz6DHAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hhqXvhqM; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707910825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+jtmsFWXII41uvDY5Lu/Q/m21GTQe10cCp5uwl7EPc=;
	b=hhqXvhqMo0R0uQJ9/yon2V7+wZQm7vfh7AekzUup5HL44wksP9/4gAGJjhNB4Dy//NkcwL
	49tqLDhCkilgzb3REtvqkSWtgH+D/9c0h0S0HlEcyXOx3bmRjrL5FXx5P9GbHTuuWkBFaj
	NcmvDungxvXJ+sX8MgbZThH6bLHUoVM=
From: Leo Yan <leo.yan@linux.dev>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ming Wang <wangming01@loongson.cn>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Leo Yan <leo.yan@linux.dev>
Subject: [PATCH v1 2/4] perf parse-regs: Always build perf register functions
Date: Wed, 14 Feb 2024 19:39:45 +0800
Message-Id: <20240214113947.240957-3-leo.yan@linux.dev>
In-Reply-To: <20240214113947.240957-1-leo.yan@linux.dev>
References: <20240214113947.240957-1-leo.yan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the macro HAVE_PERF_REGS_SUPPORT is used as a switch to turn
on or turn off the code of perf registers. If any architecture cannot
support perf register, it disables the perf register parsing, for both
the native parsing and cross parsing for other architectures.

To support both the native parsing and cross parsing, the tool should
always build the perf regs functions. Thus, this patch removes
HAVE_PERF_REGS_SUPPORT from the perf regs files.

Signed-off-by: Leo Yan <leo.yan@linux.dev>
---
 .../util/perf-regs-arch/perf_regs_aarch64.c   |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_arm.c  |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_csky.c |  4 ---
 .../util/perf-regs-arch/perf_regs_loongarch.c |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_mips.c |  4 ---
 .../util/perf-regs-arch/perf_regs_powerpc.c   |  4 ---
 .../util/perf-regs-arch/perf_regs_riscv.c     |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_s390.c |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  4 ---
 tools/perf/util/perf_regs.c                   |  4 ---
 tools/perf/util/perf_regs.h                   | 31 -------------------
 11 files changed, 71 deletions(-)

diff --git a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
index 696566c54768..9dcda80d310f 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 #include "../perf_regs.h"
 #include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
 
@@ -92,5 +90,3 @@ uint64_t __perf_reg_sp_arm64(void)
 {
 	return PERF_REG_ARM64_SP;
 }
-
-#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_arm.c b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
index 700fd07cd2aa..e29d130a587a 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_arm.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 #include "../perf_regs.h"
 #include "../../../arch/arm/include/uapi/asm/perf_regs.h"
 
@@ -56,5 +54,3 @@ uint64_t __perf_reg_sp_arm(void)
 {
 	return PERF_REG_ARM_SP;
 }
-
-#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_csky.c b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
index a2841094e096..75b461ef2eba 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_csky.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 #include "../perf_regs.h"
 #include "../../arch/csky/include/uapi/asm/perf_regs.h"
 
@@ -96,5 +94,3 @@ uint64_t __perf_reg_sp_csky(void)
 {
 	return PERF_REG_CSKY_SP;
 }
-
-#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c b/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
index a9ba0f934123..043f97f4e3ac 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 #include "../perf_regs.h"
 #include "../../../arch/loongarch/include/uapi/asm/perf_regs.h"
 
@@ -87,5 +85,3 @@ uint64_t __perf_reg_sp_loongarch(void)
 {
 	return PERF_REG_LOONGARCH_R3;
 }
-
-#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_mips.c b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
index 5a45830cfbf5..793178fc3c78 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_mips.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 #include "../perf_regs.h"
 #include "../../../arch/mips/include/uapi/asm/perf_regs.h"
 
@@ -83,5 +81,3 @@ uint64_t __perf_reg_sp_mips(void)
 {
 	return PERF_REG_MIPS_R29;
 }
-
-#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
index 1f0d682db74a..08636bb09a3a 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 #include "../perf_regs.h"
 #include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
 
@@ -141,5 +139,3 @@ uint64_t __perf_reg_sp_powerpc(void)
 {
 	return PERF_REG_POWERPC_R1;
 }
-
-#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
index e432630be4c5..337b687c655d 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 #include "../perf_regs.h"
 #include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
 
@@ -88,5 +86,3 @@ uint64_t __perf_reg_sp_riscv(void)
 {
 	return PERF_REG_RISCV_SP;
 }
-
-#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
index 1c7a46db778c..d69bba881080 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 #include "../perf_regs.h"
 #include "../../../arch/s390/include/uapi/asm/perf_regs.h"
 
@@ -92,5 +90,3 @@ uint64_t __perf_reg_sp_s390(void)
 {
 	return PERF_REG_S390_R15;
 }
-
-#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index 873c620f0634..708954a9d35d 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 #include "../perf_regs.h"
 #include "../../../arch/x86/include/uapi/asm/perf_regs.h"
 
@@ -94,5 +92,3 @@ uint64_t __perf_reg_sp_x86(void)
 {
 	return PERF_REG_X86_SP;
 }
-
-#endif
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index e2275856b570..64724eb58dd5 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -21,8 +21,6 @@ uint64_t __weak arch__user_reg_mask(void)
 	return 0;
 }
 
-#ifdef HAVE_PERF_REGS_SUPPORT
-
 const char *perf_reg_name(int id, const char *arch)
 {
 	const char *reg_name = NULL;
@@ -125,5 +123,3 @@ uint64_t perf_arch_reg_sp(const char *arch)
 	pr_err("Fail to find SP register for arch %s, returns 0\n", arch);
 	return 0;
 }
-
-#endif
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index ecd2a5362042..7fd0c7b4cec1 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -27,7 +27,6 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op);
 uint64_t arch__intr_reg_mask(void);
 uint64_t arch__user_reg_mask(void);
 
-#ifdef HAVE_PERF_REGS_SUPPORT
 extern const struct sample_reg sample_reg_masks[];
 
 const char *perf_reg_name(int id, const char *arch);
@@ -67,34 +66,4 @@ static inline uint64_t DWARF_MINIMAL_REGS(const char *arch)
 	return (1ULL << perf_arch_reg_ip(arch)) | (1ULL << perf_arch_reg_sp(arch));
 }
 
-#else
-
-static inline uint64_t DWARF_MINIMAL_REGS(const char *arch __maybe_unused)
-{
-	return 0;
-}
-
-static inline const char *perf_reg_name(int id __maybe_unused, const char *arch __maybe_unused)
-{
-	return "unknown";
-}
-
-static inline int perf_reg_value(u64 *valp __maybe_unused,
-				 struct regs_dump *regs __maybe_unused,
-				 int id __maybe_unused)
-{
-	return 0;
-}
-
-static inline uint64_t perf_arch_reg_ip(const char *arch __maybe_unused)
-{
-	return 0;
-}
-
-static inline uint64_t perf_arch_reg_sp(const char *arch __maybe_unused)
-{
-	return 0;
-}
-
-#endif /* HAVE_PERF_REGS_SUPPORT */
 #endif /* __PERF_REGS_H */
-- 
2.34.1


