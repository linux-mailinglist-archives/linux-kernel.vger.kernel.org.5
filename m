Return-Path: <linux-kernel+bounces-47662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD478450E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9411C2219F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6317993D;
	Thu,  1 Feb 2024 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="biFY8IM1"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934A64A80;
	Thu,  1 Feb 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766425; cv=none; b=K5B60ORB0j7he0nE/ZPZY8qPzFLg6tJjUGnuJQ8mkLzxibU2FHO1xtRJ/MLHAooN39m7hf9Ufsesrd+jSLm9wVooKTJCnCljiIzkx0FZO8Nr/3q1Aenvv3hPbYHs6JAHvIMTaTF01ymmbyheU7P7PUB52PMY/5uue4qBUNUmcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766425; c=relaxed/simple;
	bh=/1bEYk08Sa7REZ1vgOc1czDmWTXAzrHpsJ4a79TVcss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lomo8r0khQaGGHF6Basbo25ASagSsDvUsrgX4f7RKiFu5dEV7YLPaaSE0iyAf0/JH0JwGMhee68DAVZTXyl1qThx4tsgrlTXa9A5vucD3GSUscQZnSrWnl+TOMUrIbby6MMMae2lDSzN8UPWFSqwSjO8f/ZA72LZWMIkhZQBrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=biFY8IM1; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4115kU5I3816769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 31 Jan 2024 21:46:36 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4115kU5I3816769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706766396;
	bh=nl8GwCdrYPclmQGu8+kI7+SS7bS/6CzwFVL0dnry+o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biFY8IM1PNcSPilh6QJf1rkybOf1JOHFvjzJpj71A8rTiviAe1KLLWipNZ0GR8UI0
	 7E+arW8EL0CFB50t4GM5Wjui4OguN35NPWFoq7Rm+u2JJh0itXz7/1ghXIv+/pO3MA
	 dySREUOv94TpAnJpGkBvrFaF3b84+BZQ24Nogfu6tupKjJW9C1iZF5z+kfsNwV5vX7
	 862ZR4hD0YdH7kHS/36r7x/zZXIUuecMv3BRN9vWfY37Zwm74XMHjTCJ0CLh9SXHtm
	 /VIcOKZlpb4iwEpgjvTPYUJ9vwn43XLKJhhK4cju8UryB5JfyugGUEXvCILqu67Fvn
	 6AT3M9HVYegzg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
Subject: [PATCH v1 2/3] x86/cpufeatures: Generate a feature mask header based on build config
Date: Wed, 31 Jan 2024 21:46:28 -0800
Message-ID: <20240201054629.3816748-3-xin@zytor.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201054629.3816748-1-xin@zytor.com>
References: <20240201054629.3816748-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Introduce an awk script to auto-generate a header with required and
disabled feature masks based on <asm/cpufeatures.h> and build config.

Thus for any feature with a build config, e.g., X86_FRED, just add

config X86_DISABLED_FEATURE_FRED
	def_bool y
	depends on !X86_FRED

to arch/x86/Kconfig.cpufeatures, instead of adding a feature disable
flag, e.g., DISABLE_FRED, to <asm/disabled-features.h>.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/Makefile                  |  17 ++++-
 arch/x86/boot/cpucheck.c           |   3 +-
 arch/x86/boot/cpuflags.c           |   1 -
 arch/x86/boot/mkcpustr.c           |   3 +-
 arch/x86/include/asm/Kbuild        |   1 +
 arch/x86/include/asm/cpufeature.h  |   1 +
 arch/x86/include/asm/cpufeatures.h |   8 ---
 arch/x86/kernel/verify_cpu.S       |   1 +
 arch/x86/tools/featuremasks.awk    | 108 +++++++++++++++++++++++++++++
 9 files changed, 129 insertions(+), 14 deletions(-)
 create mode 100755 arch/x86/tools/featuremasks.awk

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index ba046afb850e..fbc9316427e2 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -243,9 +243,22 @@ archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
 
 ###
-# Syscall table generation
+# Feature masks header and syscall table generation
 
-archheaders:
+out := arch/x86/include/generated/asm
+featuremasks_hdr := featuremasks.h
+featuremasks_awk := $(srctree)/arch/x86/tools/featuremasks.awk
+cpufeatures_hdr := $(srctree)/arch/x86/include/asm/cpufeatures.h
+quiet_cmd_gen_featuremasks = GEN     $@
+      cmd_gen_featuremasks = $(AWK) -f $(featuremasks_awk) $(cpufeatures_hdr) $(KCONFIG_CONFIG) > $@
+
+$(out)/$(featuremasks_hdr): $(featuremasks_awk) $(cpufeatures_hdr) $(KCONFIG_CONFIG) FORCE
+	$(shell mkdir -p $(out))
+	$(call if_changed,gen_featuremasks)
+
+targets += $(out)/$(featuremasks_hdr)
+
+archheaders: $(out)/$(featuremasks_hdr)
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
 ###
diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index fed8d13ce252..49b982c4e932 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -22,10 +22,11 @@
 # include "boot.h"
 #endif
 #include <linux/types.h>
+#include <asm/featuremasks.h>
 #include <asm/intel-family.h>
 #include <asm/processor-flags.h>
-#include <asm/required-features.h>
 #include <asm/msr-index.h>
+
 #include "string.h"
 #include "msr.h"
 
diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index d75237ba7ce9..0cabdacb2a2f 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -3,7 +3,6 @@
 #include "bitops.h"
 
 #include <asm/processor-flags.h>
-#include <asm/required-features.h>
 #include <asm/msr-index.h>
 #include "cpuflags.h"
 
diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
index da0ccc5de538..b90110109675 100644
--- a/arch/x86/boot/mkcpustr.c
+++ b/arch/x86/boot/mkcpustr.c
@@ -12,8 +12,6 @@
 
 #include <stdio.h>
 
-#include "../include/asm/required-features.h"
-#include "../include/asm/disabled-features.h"
 #include "../include/asm/cpufeatures.h"
 #include "../include/asm/vmxfeatures.h"
 #include "../kernel/cpu/capflags.c"
@@ -23,6 +21,7 @@ int main(void)
 	int i, j;
 	const char *str;
 
+	printf("#include <asm/featuremasks.h>\n\n");
 	printf("static const char x86_cap_strs[] =\n");
 
 	for (i = 0; i < NCAPINTS; i++) {
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index a192bdea69e2..29c3481f40fc 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -8,6 +8,7 @@ generated-y += syscalls_x32.h
 generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
+generated-y += featuremasks.h
 
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index a26bebbdff87..9c7c19c9b5fc 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -9,6 +9,7 @@
 #include <asm/asm.h>
 #include <linux/bitops.h>
 #include <asm/alternative.h>
+#include <asm/featuremasks.h>
 
 enum cpuid_leafs
 {
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 872389e09c8d..7df47cffe35d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -2,14 +2,6 @@
 #ifndef _ASM_X86_CPUFEATURES_H
 #define _ASM_X86_CPUFEATURES_H
 
-#ifndef _ASM_X86_REQUIRED_FEATURES_H
-#include <asm/required-features.h>
-#endif
-
-#ifndef _ASM_X86_DISABLED_FEATURES_H
-#include <asm/disabled-features.h>
-#endif
-
 /*
  * Defines x86 CPU feature bits
  */
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index 1258a5872d12..3205cbb47b9c 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -29,6 +29,7 @@
  */
 
 #include <asm/cpufeatures.h>
+#include <asm/featuremasks.h>
 #include <asm/msr-index.h>
 
 SYM_FUNC_START_LOCAL(verify_cpu)
diff --git a/arch/x86/tools/featuremasks.awk b/arch/x86/tools/featuremasks.awk
new file mode 100755
index 000000000000..2af32c60fc76
--- /dev/null
+++ b/arch/x86/tools/featuremasks.awk
@@ -0,0 +1,108 @@
+#!/usr/bin/awk
+#
+# Convert cpufeatures.h to a list of compile-time masks
+# Note: this blithly assumes that each word has at least one
+# feature defined in it; if not, something else is wrong!
+#
+
+BEGIN {
+	printf "#ifndef _ASM_X86_FEATUREMASKS_H\n";
+	printf "#define _ASM_X86_FEATUREMASKS_H\n\n";
+
+	file = 0
+}
+
+BEGINFILE {
+	switch (++file) {
+	case 1:			# cpufeatures.h
+		FPAT = "#[ \t]*[a-z]+|[A-Za-z0-9_]+|[^ \t]";
+		break;
+	case 2:			# .config
+		FPAT = "CONFIG_[A-Z0-9_]+|is not set|[yn]";
+		break;
+	}
+}
+
+file == 1 && $1 ~ /^#[ \t]*define$/ && $2 ~ /^X86_FEATURE_/ &&
+$3 == "(" && $5 == "*" && $7 == "+" && $9 == ")" {
+	nfeat = $4 * $6 + $8;
+	feat = $2;
+	sub(/^X86_FEATURE_/, "", feat);
+	feats[nfeat] = feat;
+}
+file == 1 && $1 ~ /^#[ \t]*define$/ && $2 == "NCAPINTS" {
+	ncapints = strtonum($3);
+}
+
+file == 2 && $1 ~ /^CONFIG_X86_[A-Z]*_FEATURE_/ {
+	on = ($2 == "y");
+	printf "/* %s = %s (%d) */\n", $1, $2, on;
+	if (split($1, fs, "CONFIG_X86_|_FEATURE_") == 3) {
+		printf "/* %s %s = %d */\n", fs[2], fs[3], on;
+		featstat[fs[2], fs[3]] = on;
+	}
+}
+
+END {
+	sets[1] = "REQUIRED";
+	sets[2] = "DISABLED";
+
+	for (ns in sets) {
+		s = sets[ns];
+
+		printf "/*\n";
+		printf " * %s features:\n", s;
+		printf " *\n";
+		fstr = "";
+		for (i = 0; i < ncapints; i++) {
+			mask = 0;
+			for (j = 0; j < 32; j++) {
+				nfeat = i*32 + j;
+				feat = feats[nfeat];
+				if (feat) {
+					st = !!featstat[s, feat];
+					if (st) {
+						nfstr = fstr " " feat;
+						if (length(nfstr) > 72) {
+							printf " *   %s\n", fstr;
+							nfstr = " " feat;
+						}
+						fstr = nfstr;
+					}
+					mask += st * (2 ^ j);
+				}
+			}
+			masks[i] = mask;
+		}
+		printf " *   %s\n */\n\n", fstr;
+
+		for (i = 0; i < ncapints; i++) {
+			printf "#define %s_MASK%-3d 0x%08x\n", s, i, masks[i];
+		}
+
+		printf "\n#define %s_MASKS ", s;
+		pfx = "{";
+		for (i = 0; i < ncapints; i++) {
+			printf "%s \\\n\t%s_MASK_%d", pfx, s, i;
+			pfx = ",";
+		}
+		printf " \\\n}\n\n";
+
+		printf "#define %s_FEATURE(x) \\\n", s;
+		printf "\t((( ";
+		for (i = 0; i < ncapints; i++) {
+			if (masks[i]) {
+				printf "\\\n\t\t((x) >> 5) == %2d ? %s_MASK%-3d : ", i, s, i;
+			}
+		}
+		printf "0 \\\n";
+		printf "\t) >> ((x) & 31)) & 1)\n\n";
+
+		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
+	}
+
+	printf "#define SSE_MASK\t\\\n";
+	printf "\t(REQUIRED_MASK0 & ((1<<(X86_FEATURE_XMM & 31)) | (1<<(X86_FEATURE_XMM2 & 31))))\n\n";
+
+	printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
+}
-- 
2.43.0


