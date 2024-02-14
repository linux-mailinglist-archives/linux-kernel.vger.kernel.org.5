Return-Path: <linux-kernel+bounces-65151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8685489B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE9EB281DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2A01B965;
	Wed, 14 Feb 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k16JtjQ0"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BEC1BC3A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910837; cv=none; b=XPfJcrjbF2vy/qsa2e6eZUnuU6xumPKMG+bQNVaBM3zp667SnDb4n3aOhIpdtn1D4ihOtXVdmKMkAaqaJidtQpSIhGH8Nw5h7r1iEMDgLuKow1FSunSJ8gHRSJxCuvB7kjsxjY0nCbx5KUBdL/hWd5qFEVNSkCuo47NefAGwh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910837; c=relaxed/simple;
	bh=DJYjh7MgXUwnka/7RGMkLj9tcjN0l6NhK730MXgdb4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gcYUkDhk4gdUbwmX48KPNoEWCLIsW6ol4YScaIBJRihrf7FFkSyHwge8lqYnkXnfkG5nU7wYy/2KNotvplIpPyIVVhj+a58BYAsEpAypxgdu+UPkyswwwQu7yUWmkGkKNxxaX/yutJplGwVEJ/MwUMdSyAWRmmDmD51vB+u7Scs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k16JtjQ0; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707910833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6q0ZJ+/QgkBKiu+7vLI7Vww0Q4/7AWcn0562kHI25UM=;
	b=k16JtjQ0Q0Cfr3s5i9zroS0QYD++HZIYliM0Vf8VwADRosR3o9l8gytGbENg/ogRvDx20Y
	2ZC7z2tOdU9mPIG6hl0ru8vOVRqy2xwLV+u7bGQeT9SXDGrjpnkCHUQ5q2+oS+JLH7KqYP
	U7JdUdz/pZUY23oE++pJXZyUFNzF9+0=
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
Subject: [PATCH v1 3/4] perf parse-regs: Introduce a weak function arch__sample_reg_masks()
Date: Wed, 14 Feb 2024 19:39:46 +0800
Message-Id: <20240214113947.240957-4-leo.yan@linux.dev>
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

Every architecture can provide a register list for sampling. If an
architecture doesn't support register sampling, it won't define the data
structure 'sample_reg_masks'. Consequently, any code using this
structure must be protected by the macro 'HAVE_PERF_REGS_SUPPORT'.

This patch defines a weak function, arch__sample_reg_masks(), which will
be replaced by an architecture-defined function for returning the
architecture's register list. With this refactoring, the function always
exists, the condition checking for 'HAVE_PERF_REGS_SUPPORT' is not
needed anymore, so remove it.

Signed-off-by: Leo Yan <leo.yan@linux.dev>
---
 tools/perf/arch/arm/util/perf_regs.c       | 7 ++++++-
 tools/perf/arch/arm64/util/machine.c       | 2 ++
 tools/perf/arch/arm64/util/perf_regs.c     | 7 ++++++-
 tools/perf/arch/csky/util/perf_regs.c      | 7 ++++++-
 tools/perf/arch/loongarch/util/perf_regs.c | 7 ++++++-
 tools/perf/arch/mips/util/perf_regs.c      | 7 ++++++-
 tools/perf/arch/powerpc/util/perf_regs.c   | 7 ++++++-
 tools/perf/arch/riscv/util/perf_regs.c     | 7 ++++++-
 tools/perf/arch/s390/util/perf_regs.c      | 7 ++++++-
 tools/perf/arch/x86/util/perf_regs.c       | 7 ++++++-
 tools/perf/util/parse-regs-options.c       | 8 ++------
 tools/perf/util/perf_regs.c                | 9 +++++++++
 tools/perf/util/perf_regs.h                | 3 +--
 13 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
index 2c56e8b56ddf..f94a0210c7b7 100644
--- a/tools/perf/arch/arm/util/perf_regs.c
+++ b/tools/perf/arch/arm/util/perf_regs.c
@@ -2,7 +2,7 @@
 #include "perf_regs.h"
 #include "../../../util/perf_regs.h"
 
-const struct sample_reg sample_reg_masks[] = {
+static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
@@ -15,3 +15,8 @@ uint64_t arch__user_reg_mask(void)
 {
 	return PERF_REGS_MASK;
 }
+
+const struct sample_reg *arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index ba1144366e85..aab1cc2bc283 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -12,5 +12,7 @@
 
 void arch__add_leaf_frame_record_opts(struct record_opts *opts)
 {
+	const struct sample_reg *sample_reg_masks = arch__sample_reg_masks();
+
 	opts->sample_user_regs |= sample_reg_masks[PERF_REG_ARM64_LR].mask;
 }
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 1b79d8eab22f..09308665e28a 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -16,7 +16,7 @@
 #define HWCAP_SVE	(1 << 22)
 #endif
 
-const struct sample_reg sample_reg_masks[] = {
+static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(x0, PERF_REG_ARM64_X0),
 	SMPL_REG(x1, PERF_REG_ARM64_X1),
 	SMPL_REG(x2, PERF_REG_ARM64_X2),
@@ -175,3 +175,8 @@ uint64_t arch__user_reg_mask(void)
 	}
 	return PERF_REGS_MASK;
 }
+
+const struct sample_reg *arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
index c0877c264d49..6b1665f41180 100644
--- a/tools/perf/arch/csky/util/perf_regs.c
+++ b/tools/perf/arch/csky/util/perf_regs.c
@@ -2,7 +2,7 @@
 #include "perf_regs.h"
 #include "../../util/perf_regs.h"
 
-const struct sample_reg sample_reg_masks[] = {
+static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
@@ -15,3 +15,8 @@ uint64_t arch__user_reg_mask(void)
 {
 	return PERF_REGS_MASK;
 }
+
+const struct sample_reg *arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
index 2c56e8b56ddf..f94a0210c7b7 100644
--- a/tools/perf/arch/loongarch/util/perf_regs.c
+++ b/tools/perf/arch/loongarch/util/perf_regs.c
@@ -2,7 +2,7 @@
 #include "perf_regs.h"
 #include "../../../util/perf_regs.h"
 
-const struct sample_reg sample_reg_masks[] = {
+static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
@@ -15,3 +15,8 @@ uint64_t arch__user_reg_mask(void)
 {
 	return PERF_REGS_MASK;
 }
+
+const struct sample_reg *arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
index c0877c264d49..6b1665f41180 100644
--- a/tools/perf/arch/mips/util/perf_regs.c
+++ b/tools/perf/arch/mips/util/perf_regs.c
@@ -2,7 +2,7 @@
 #include "perf_regs.h"
 #include "../../util/perf_regs.h"
 
-const struct sample_reg sample_reg_masks[] = {
+static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
@@ -15,3 +15,8 @@ uint64_t arch__user_reg_mask(void)
 {
 	return PERF_REGS_MASK;
 }
+
+const struct sample_reg *arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index b38aa056eea0..e8e6e6fc6f17 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -17,7 +17,7 @@
 #define PVR_POWER9		0x004E
 #define PVR_POWER10		0x0080
 
-const struct sample_reg sample_reg_masks[] = {
+static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(r0, PERF_REG_POWERPC_R0),
 	SMPL_REG(r1, PERF_REG_POWERPC_R1),
 	SMPL_REG(r2, PERF_REG_POWERPC_R2),
@@ -232,3 +232,8 @@ uint64_t arch__user_reg_mask(void)
 {
 	return PERF_REGS_MASK;
 }
+
+const struct sample_reg *arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
index c0877c264d49..6b1665f41180 100644
--- a/tools/perf/arch/riscv/util/perf_regs.c
+++ b/tools/perf/arch/riscv/util/perf_regs.c
@@ -2,7 +2,7 @@
 #include "perf_regs.h"
 #include "../../util/perf_regs.h"
 
-const struct sample_reg sample_reg_masks[] = {
+static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
@@ -15,3 +15,8 @@ uint64_t arch__user_reg_mask(void)
 {
 	return PERF_REGS_MASK;
 }
+
+const struct sample_reg *arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
index c0877c264d49..6b1665f41180 100644
--- a/tools/perf/arch/s390/util/perf_regs.c
+++ b/tools/perf/arch/s390/util/perf_regs.c
@@ -2,7 +2,7 @@
 #include "perf_regs.h"
 #include "../../util/perf_regs.h"
 
-const struct sample_reg sample_reg_masks[] = {
+static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
@@ -15,3 +15,8 @@ uint64_t arch__user_reg_mask(void)
 {
 	return PERF_REGS_MASK;
 }
+
+const struct sample_reg *arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index b813502a2727..12fd93f04802 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -13,7 +13,7 @@
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
 
-const struct sample_reg sample_reg_masks[] = {
+static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
 	SMPL_REG(BX, PERF_REG_X86_BX),
 	SMPL_REG(CX, PERF_REG_X86_CX),
@@ -276,6 +276,11 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	return SDT_ARG_VALID;
 }
 
+const struct sample_reg *arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
+
 uint64_t arch__intr_reg_mask(void)
 {
 	struct perf_event_attr attr = {
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index a4a100425b3a..cda1c620968e 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -46,22 +46,18 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 
 			if (!strcmp(s, "?")) {
 				fprintf(stderr, "available registers: ");
-#ifdef HAVE_PERF_REGS_SUPPORT
-				for (r = sample_reg_masks; r->name; r++) {
+				for (r = arch__sample_reg_masks(); r->name; r++) {
 					if (r->mask & mask)
 						fprintf(stderr, "%s ", r->name);
 				}
-#endif
 				fputc('\n', stderr);
 				/* just printing available regs */
 				goto error;
 			}
-#ifdef HAVE_PERF_REGS_SUPPORT
-			for (r = sample_reg_masks; r->name; r++) {
+			for (r = arch__sample_reg_masks(); r->name; r++) {
 				if ((r->mask & mask) && !strcasecmp(s, r->name))
 					break;
 			}
-#endif
 			if (!r || !r->name) {
 				ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
 					    s, intr ? "-I" : "--user-regs=");
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 64724eb58dd5..44b90bbf2d07 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -21,6 +21,15 @@ uint64_t __weak arch__user_reg_mask(void)
 	return 0;
 }
 
+static const struct sample_reg sample_reg_masks[] = {
+	SMPL_REG_END
+};
+
+const struct sample_reg * __weak arch__sample_reg_masks(void)
+{
+	return sample_reg_masks;
+}
+
 const char *perf_reg_name(int id, const char *arch)
 {
 	const char *reg_name = NULL;
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 7fd0c7b4cec1..f2d0736d65cc 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -26,8 +26,7 @@ enum {
 int arch_sdt_arg_parse_op(char *old_op, char **new_op);
 uint64_t arch__intr_reg_mask(void);
 uint64_t arch__user_reg_mask(void);
-
-extern const struct sample_reg sample_reg_masks[];
+const struct sample_reg *arch__sample_reg_masks(void);
 
 const char *perf_reg_name(int id, const char *arch);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
-- 
2.34.1


