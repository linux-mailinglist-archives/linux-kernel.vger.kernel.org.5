Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E37F4BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbjKVP4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbjKVP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:56:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497921B3;
        Wed, 22 Nov 2023 07:56:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2851b271e51so772172a91.1;
        Wed, 22 Nov 2023 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700668591; x=1701273391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uI9QwUqTrK/TTo7oDObuDkV0/9qXHslf5MXRPDTXe08=;
        b=Kq5muNg7TUtzzx/HxhrRAHDCaAKP8jQ+W2rmXje2lX5p6ablcAGx4zMaLM5rn+IWAd
         dpM1k9QlSop4BgZh0dQApFeBqFeZkoUDF01+/uktcKQa2Tbn6AlXdNx3dmKdvZu0p1i2
         Y6S7WGEr0Frv5k3tt/bRL7Ul8EEVWBgiuswmDjg4KilTJcGBiY74G5jDgly6dLzey1u9
         UOQVuT58FoOmODPTK5S96Xk6VKrZPc6msj2hV7t942BB7j7OoLU9z8ld5BP8HAGTs+Zr
         E229tRZ0yCdDtfkkIrgUjdnX7xVhniAepXiVrNEs8Xyz+me8dJ2jDnia/y+i7Wwsn+BP
         X1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668591; x=1701273391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uI9QwUqTrK/TTo7oDObuDkV0/9qXHslf5MXRPDTXe08=;
        b=Q6xdHh9+EAz/Slylvc3s0QxEIEBXDqFRTfL5lPM07BP7LQ31o5BmO7s31jkryShFRP
         N2QX6dk/eb6n8Ixy9ER0FcPNCbHcgZi9ZpnVqZCDLqPhXw9wX3IZjR04xQv/2IbDPg+Y
         v9kfwxxEkBJtkMWiXKNr4WP3qwHXPSfcB6HPsUBQcLWZZD0bUAtnDqhFxDNEeW8xx3ZP
         /QoPW+UK6hghxkObmrstSqafDunYTGqp69aa61i37sdezjvTO9TTnrTjt9Gta+fz6crT
         yYHa4i/18FLnALnhQcmDlKWdOrmwrKHZ3nqcvu7nsZ56eQiifRt/UgJNnnPEQ40+pFHK
         uHHQ==
X-Gm-Message-State: AOJu0YyqEbGA+8zwvnK1zbY58aDJ5m/uhhZNr2X6L0WyYkKB29kP3Sq4
        vL5/Boy5MVDu3fdozhHO6YYL2XoSW0UcjF6j
X-Google-Smtp-Source: AGHT+IFFl/m9AR6jyfXLquchr+iRx8oQ6H0cn+mgEm8bXuVtz6+CPLuwrrAzdX4uRMx9FfkOw6HBcw==
X-Received: by 2002:a17:90b:3e83:b0:280:a002:be85 with SMTP id rj3-20020a17090b3e8300b00280a002be85mr4489253pjb.20.1700668590236;
        Wed, 22 Nov 2023 07:56:30 -0800 (PST)
Received: from DESKTOP-NK4TH6S.localdomain ([220.116.189.210])
        by smtp.gmail.com with ESMTPSA id lx3-20020a17090b4b0300b00285139b71cdsm168400pjb.11.2023.11.22.07.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:56:30 -0800 (PST)
From:   Paran Lee <p4ranlee@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, shjy180909@gmail.com,
        austindh.kim@gmail.com, honggyu.kp@gmail.com, tegongkang@gmail.com,
        Paran Lee <p4ranlee@gmail.com>
Subject: [PATCH] perf callchain: Support riscv cross-platform
Date:   Thu, 23 Nov 2023 00:55:48 +0900
Message-Id: <20231122155548.2449-1-p4ranlee@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support riscv cross platform callchain unwind.
Tested on RISCV 64 Starfive VisionFive2 Board
------------
$ uname -ra
Linux starfive 5.15.0-starfive #
1 SMP Mon Dec 19 07:56:37 EST 2022 riscv64 GNU/Linux
paran@starfive:~/linux-next$ cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux bookworm/sid"
NAME="Debian GNU/Linux"
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
------------
paran@starfive:~/linux-next/tools/perf$
 make  NO_AUXTRACE=1  NO_LIBTRACEEVENT=1 -j4
Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]
...
CC      arch/riscv/util/dwarf-regs.o
CC      arch/riscv/util/unwind-libunwind.o
...
LINK    perf
------------
Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 tools/build/Makefile.feature                  |  2 +
 tools/build/feature/Makefile                  |  8 ++++
 tools/perf/Makefile.config                    | 18 +++++++++
 tools/perf/arch/riscv/util/Build              |  1 +
 tools/perf/arch/riscv/util/unwind-libunwind.c | 17 ++++++++
 tools/perf/check-headers.sh                   |  3 ++
 tools/perf/util/libunwind/riscv.c             | 40 +++++++++++++++++++
 tools/perf/util/unwind-libunwind.c            |  5 +++
 8 files changed, 94 insertions(+)
 create mode 100644 tools/perf/arch/riscv/util/unwind-libunwind.c
 create mode 100644 tools/perf/util/libunwind/riscv.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 934e2777a2db..e4140dee1d70 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -93,9 +93,11 @@ FEATURE_TESTS_EXTRA :=                  \
          libunwind-x86_64               \
          libunwind-arm                  \
          libunwind-aarch64              \
+         libunwind-riscv                \
          libunwind-debug-frame          \
          libunwind-debug-frame-arm      \
          libunwind-debug-frame-aarch64  \
+         libunwind-debug-frame-riscv    \
          cxx                            \
          llvm                           \
          llvm-version                   \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index dad79ede4e0a..e3218f98f824 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -45,8 +45,10 @@ FILES=                                          \
          test-libunwind-x86_64.bin              \
          test-libunwind-arm.bin                 \
          test-libunwind-aarch64.bin             \
+		 test-libunwind-riscv.bin               \
          test-libunwind-debug-frame-arm.bin     \
          test-libunwind-debug-frame-aarch64.bin \
+		 test-libunwind-debug-frame-riscv.bin   \
          test-pthread-attr-setaffinity-np.bin   \
          test-pthread-barrier.bin		\
          test-stackprotector-all.bin            \
@@ -189,12 +191,18 @@ $(OUTPUT)test-libunwind-arm.bin:
 $(OUTPUT)test-libunwind-aarch64.bin:
 	$(BUILD) -lelf -lunwind-aarch64
 
+$(OUTPUT)test-libunwind-riscv.bin:
+	$(BUILD) -lelf -lunwind-riscv
+
 $(OUTPUT)test-libunwind-debug-frame-arm.bin:
 	$(BUILD) -lelf -lunwind-arm
 
 $(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
 	$(BUILD) -lelf -lunwind-aarch64
 
+$(OUTPUT)test-libunwind-debug-frame-riscv.bin:
+	$(BUILD) -lelf -lunwind-riscv
+
 $(OUTPUT)test-libaudit.bin:
 	$(BUILD) -laudit
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b3e6ed10f40c..b72c1b886b28 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -88,6 +88,8 @@ endif
 
 ifeq ($(SRCARCH),riscv)
   NO_PERF_REGS := 0
+    CFLAGS += -I$(OUTPUT)arch/riscv/include/generated
+    LIBUNWIND_LIBS = -lunwind -lunwind-riscv
 endif
 
 ifeq ($(SRCARCH),csky)
@@ -147,6 +149,7 @@ FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_L
 
 FEATURE_CHECK_LDFLAGS-libunwind-arm += -lunwind -lunwind-arm
 FEATURE_CHECK_LDFLAGS-libunwind-aarch64 += -lunwind -lunwind-aarch64
+FEATURE_CHECK_LDFLAGS-libunwind-riscv += -lunwind -lunwind-riscv
 FEATURE_CHECK_LDFLAGS-libunwind-x86 += -lunwind -llzma -lunwind-x86
 FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64
 
@@ -651,6 +654,21 @@ ifndef NO_LIBUNWIND
     endif
   endif
 
+  $(call feature_check,libunwind-riscv)
+  ifeq ($(feature-libunwind-riscv), 1)
+    $(call detected,CONFIG_LIBUNWIND_RISCV)
+    CFLAGS += -DHAVE_LIBUNWIND_RISCV_SUPPORT
+    LDFLAGS += -lunwind-riscv
+    EXTLIBS_LIBUNWIND += -lunwind-riscv
+    have_libunwind = 1
+    $(call feature_check,libunwind-debug-frame-riscv)
+    ifneq ($(feature-libunwind-debug-frame-riscv), 1)
+      msg := $(warning No debug_frame support found in libunwind-riscv);
+      CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME_riscv
+    endif
+  endif
+
+
   ifneq ($(feature-libunwind), 1)
     msg := $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR);
     NO_LOCAL_LIBUNWIND := 1
diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 603dbb5ae4dc..0f75e25ae638 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -2,4 +2,5 @@ perf-y += perf_regs.o
 perf-y += header.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/riscv/util/unwind-libunwind.c b/tools/perf/arch/riscv/util/unwind-libunwind.c
new file mode 100644
index 000000000000..e9d6c9c06f84
--- /dev/null
+++ b/tools/perf/arch/riscv/util/unwind-libunwind.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+
+#ifndef REMOTE_UNWIND_LIBUNWIND
+#include <libunwind.h>
+#include "perf_regs.h"
+#include "../../../util/unwind.h"
+#endif
+#include "../../../util/debug.h"
+
+int LIBUNWIND__ARCH_REG_ID(int regnum)
+{
+	if (regnum < 0 || regnum >= PERF_REG_RISCV_MAX)
+		return -EINVAL;
+
+	return regnum;
+}
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 66ba33dbcef2..3a774c9544c4 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -48,6 +48,7 @@ FILES=(
   "arch/loongarch/include/uapi/asm/perf_regs.h"
   "arch/mips/include/uapi/asm/perf_regs.h"
   "arch/powerpc/include/uapi/asm/perf_regs.h"
+  "arch/riscv/include/uapi/asm/perf_regs.h"
   "arch/s390/include/uapi/asm/perf_regs.h"
   "arch/x86/include/uapi/asm/perf_regs.h"
   "arch/x86/include/uapi/asm/kvm.h"
@@ -67,6 +68,8 @@ FILES=(
   "arch/mips/include/uapi/asm/errno.h"
   "arch/parisc/include/uapi/asm/errno.h"
   "arch/powerpc/include/uapi/asm/errno.h"
+  "arch/riscv/include/uapi/asm/kvm.h"
+  "arch/riscv/include/uapi/asm/unistd.h"
   "arch/sparc/include/uapi/asm/errno.h"
   "arch/x86/include/uapi/asm/errno.h"
   "include/asm-generic/bitops/arch_hweight.h"
diff --git a/tools/perf/util/libunwind/riscv.c b/tools/perf/util/libunwind/riscv.c
new file mode 100644
index 000000000000..c340c5609161
--- /dev/null
+++ b/tools/perf/util/libunwind/riscv.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file setups defines to compile arch specific binary from the
+ * generic one.
+ *
+ * The function 'LIBUNWIND__ARCH_REG_ID' name is set according to arch
+ * name and the definition of this function is included directly from
+ * 'arch/riscv/util/unwind-libunwind.c', to make sure that this function
+ * is defined no matter what arch the host is.
+ *
+ * Finally, the arch specific unwind methods are exported which will
+ * be assigned to each riscv thread.
+ */
+
+#define REMOTE_UNWIND_LIBUNWIND
+
+/* Define arch specific functions & regs for libunwind, should be
+ * defined before including "unwind.h"
+ */
+#define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__riscv_reg_id(regnum)
+
+#include "unwind.h"
+#include "libunwind-riscv.h"
+#define perf_event_riscv_regs perf_event_riscv64_regs
+#include <../../../arch/riscv/include/uapi/asm/perf_regs.h>
+#undef perf_event_riscv_regs
+#include "../../arch/riscv/util/unwind-libunwind.c"
+
+/* NO_LIBUNWIND_DEBUG_FRAME is a feature flag for local libunwind,
+ * assign NO_LIBUNWIND_DEBUG_FRAME_RISCV64 to it for compiling riscv
+ * unwind methods.
+ */
+#undef NO_LIBUNWIND_DEBUG_FRAME
+#ifdef NO_LIBUNWIND_DEBUG_FRAME_RISCV
+#define NO_LIBUNWIND_DEBUG_FRAME
+#endif
+#include "util/unwind-libunwind-local.c"
+
+struct unwind_libunwind_ops *
+riscv_unwind_libunwind_ops = &_unwind_libunwind_ops;
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 76cd63de80a8..52190f1eaf0d 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -11,6 +11,7 @@
 struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *arm64_unwind_libunwind_ops;
+struct unwind_libunwind_ops __weak *riscv_unwind_libunwind_ops;
 
 static void unwind__register_ops(struct maps *maps, struct unwind_libunwind_ops *ops)
 {
@@ -54,6 +55,10 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 		if (dso_type == DSO__TYPE_64BIT)
 			ops = arm64_unwind_libunwind_ops;
 	}
+	} else if (!strcmp(arch, "riscv64") || !strcmp(arch, "riscv")) {
+		if (dso_type == DSO__TYPE_64BIT)
+			ops = riscv_unwind_libunwind_ops;
+	}
 
 	if (!ops) {
 		pr_warning_once("unwind: target platform=%s is not supported\n", arch);
-- 
2.25.1

