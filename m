Return-Path: <linux-kernel+bounces-69721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD80858DB7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B39D1C210A2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A821CF99;
	Sat, 17 Feb 2024 07:41:33 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E141C2A6;
	Sat, 17 Feb 2024 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155692; cv=none; b=k1ZCTQxADJK5NqQf7Uu4atWS0VNF8yoZkHQclOKTmxkMDdc7184t0zL/8JLk46MZfUXn+dAaQ5cvVq4IlHFlASJVvSqCRwSFPd6+N/L5VnkXHWYk3V7CkSPwHnZKCy+42mBUwEkNOaDzuQnH3O9UmquCSjGinLzHP/SWymSSleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155692; c=relaxed/simple;
	bh=xnUfh5tNvpXi9BR+N3yxZpocjCbyoo7Gh9VK7eqqUzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtbTlHjDuqwACtb1RuwJIIX0wH+VkjXL3ahxeoRwwzZp6iy1xWloWtf2FjqVn4qnBXhbHzTcIo1OvtAkkiQ/61SQGYvwAly5qQkaaGJaFMsM9oa9xVEZ+5Nv8ws23XKA0YrtCKXgptuGSaMFLix1tnNmjHJmpDXG/bR46GGyeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TcLKP0CWlz1Q90Y;
	Sat, 17 Feb 2024 15:39:21 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C39B18001B;
	Sat, 17 Feb 2024 15:41:26 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 17 Feb 2024 15:41:25 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas
 Richter <tmricht@linux.ibm.com>, <changbin.du@gmail.com>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH v8 1/5] perf: build: introduce the libcapstone
Date: Sat, 17 Feb 2024 15:40:42 +0800
Message-ID: <20240217074046.4100789-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240217074046.4100789-1-changbin.du@huawei.com>
References: <20240217074046.4100789-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100002.china.huawei.com (7.221.188.184)

Later we will use libcapstone to disassemble instructions of samples.

Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
v3:
  - display with perf version --build-options. (Adrian Hunter)
  - exclude libcapstone from make_minimal.
v2:
  - change tools/perf/tests/make also.
---
 tools/build/Makefile.feature           |  2 ++
 tools/build/feature/Makefile           |  4 ++++
 tools/build/feature/test-all.c         |  4 ++++
 tools/build/feature/test-libcapstone.c | 11 +++++++++++
 tools/perf/Makefile.config             | 21 +++++++++++++++++++++
 tools/perf/Makefile.perf               |  3 +++
 tools/perf/builtin-version.c           |  1 +
 tools/perf/tests/make                  |  4 +++-
 8 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libcapstone.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 64df118376df..1e2ab148d5db 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -87,6 +87,7 @@ FEATURE_TESTS_EXTRA :=                  \
          gtk2-infobar                   \
          hello                          \
          libbabeltrace                  \
+         libcapstone                    \
          libbfd-liberty                 \
          libbfd-liberty-z               \
          libopencsd                     \
@@ -134,6 +135,7 @@ FEATURE_DISPLAY ?=              \
          libcrypto              \
          libunwind              \
          libdw-dwarf-unwind     \
+         libcapstone            \
          zlib                   \
          lzma                   \
          get_cpuid              \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 37722e509eb9..ed54cef450f5 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -54,6 +54,7 @@ FILES=                                          \
          test-timerfd.bin                       \
          test-libdw-dwarf-unwind.bin            \
          test-libbabeltrace.bin                 \
+         test-libcapstone.bin			\
          test-compile-32.bin                    \
          test-compile-x32.bin                   \
          test-zlib.bin                          \
@@ -286,6 +287,9 @@ $(OUTPUT)test-libdw-dwarf-unwind.bin:
 $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
+$(OUTPUT)test-libcapstone.bin:
+	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
+
 $(OUTPUT)test-compile-32.bin:
 	$(CC) -m32 -o $@ test-compile.c
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 6f4bf386a3b5..dd0a18c2ef8f 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -134,6 +134,10 @@
 #undef main
 #endif
 
+#define main main_test_libcapstone
+# include "test-libcapstone.c"
+#undef main
+
 #define main main_test_lzma
 # include "test-lzma.c"
 #undef main
diff --git a/tools/build/feature/test-libcapstone.c b/tools/build/feature/test-libcapstone.c
new file mode 100644
index 000000000000..fbe8dba189e9
--- /dev/null
+++ b/tools/build/feature/test-libcapstone.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <capstone/capstone.h>
+
+int main(void)
+{
+	csh handle;
+
+	cs_open(CS_ARCH_X86, CS_MODE_64, &handle);
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index aa55850fbc21..3e1072c59757 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -191,6 +191,15 @@ endif
 FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
 
+# for linking with debug library, run like:
+# make DEBUG=1 LIBCAPSTONE_DIR=/opt/capstone/
+ifdef LIBCAPSTONE_DIR
+  LIBCAPSTONE_CFLAGS  := -I$(LIBCAPSTONE_DIR)/include
+  LIBCAPSTONE_LDFLAGS := -L$(LIBCAPSTONE_DIR)/
+endif
+FEATURE_CHECK_CFLAGS-libcapstone := $(LIBCAPSTONE_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libcapstone := $(LIBCAPSTONE_LDFLAGS) -lcapstone
+
 ifdef LIBZSTD_DIR
   LIBZSTD_CFLAGS  := -I$(LIBZSTD_DIR)/lib
   LIBZSTD_LDFLAGS := -L$(LIBZSTD_DIR)/lib
@@ -1094,6 +1103,18 @@ ifndef NO_LIBBABELTRACE
   endif
 endif
 
+ifndef NO_CAPSTONE
+  $(call feature_check,libcapstone)
+  ifeq ($(feature-libcapstone), 1)
+    CFLAGS += -DHAVE_LIBCAPSTONE_SUPPORT $(LIBCAPSTONE_CFLAGS)
+    LDFLAGS += $(LICAPSTONE_LDFLAGS)
+    EXTLIBS += -lcapstone
+    $(call detected,CONFIG_LIBCAPSTONE)
+  else
+    msg := $(warning No libcapstone found, disables disasm engine support for 'perf script', please install libcapstone-dev/capstone-devel);
+  endif
+endif
+
 ifndef NO_AUXTRACE
   ifeq ($(SRCARCH),x86)
     ifeq ($(feature-get_cpuid), 0)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f8774a9b1377..c2134cf456ef 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -84,6 +84,9 @@ include ../scripts/utilities.mak
 # Define NO_LIBBABELTRACE if you do not want libbabeltrace support
 # for CTF data format.
 #
+# Define NO_CAPSTONE if you do not want libcapstone support
+# for disasm engine.
+#
 # Define NO_LZMA if you do not want to support compressed (xz) kernel modules
 #
 # Define NO_AUXTRACE if you do not want AUX area tracing support
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index ac20c2b9bbc2..afd409130238 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -73,6 +73,7 @@ static void library_status(void)
 	STATUS(HAVE_LIBCRYPTO_SUPPORT, libcrypto);
 	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
 	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
+	STATUS(HAVE_LIBCAPSTONE_SUPPORT, libcapstone);
 	STATUS(HAVE_ZLIB_SUPPORT, zlib);
 	STATUS(HAVE_LZMA_SUPPORT, lzma);
 	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 8a4da7eb637a..a1f8adf85367 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -83,6 +83,7 @@ make_no_libelf      := NO_LIBELF=1
 make_no_libunwind   := NO_LIBUNWIND=1
 make_no_libdw_dwarf_unwind := NO_LIBDW_DWARF_UNWIND=1
 make_no_backtrace   := NO_BACKTRACE=1
+make_no_libcapstone := NO_CAPSTONE=1
 make_no_libnuma     := NO_LIBNUMA=1
 make_no_libaudit    := NO_LIBAUDIT=1
 make_no_libbionic   := NO_LIBBIONIC=1
@@ -122,7 +123,7 @@ make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
 make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
-make_minimal        += NO_LIBCAP=1 NO_SYSCALL_TABLE=1
+make_minimal        += NO_LIBCAP=1 NO_SYSCALL_TABLE=1 NO_CAPSTONE=1
 
 # $(run) contains all available tests
 run := make_pure
@@ -152,6 +153,7 @@ run += make_no_libelf
 run += make_no_libunwind
 run += make_no_libdw_dwarf_unwind
 run += make_no_backtrace
+run += make_no_libcapstone
 run += make_no_libnuma
 run += make_no_libaudit
 run += make_no_libbionic
-- 
2.25.1


