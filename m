Return-Path: <linux-kernel+bounces-32906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C678361C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAD21F23D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA761DFF3;
	Mon, 22 Jan 2024 11:21:14 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828063B7A9;
	Mon, 22 Jan 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922474; cv=none; b=I5+TLd8Zut/stODgwTUM06/QoRhvhYNZZSUjhNIntfU90LEndPUSDzbMtuTeJaWPCT30Wk7eYTgG8AAaYhnhIgq1Q20iVESIUZuWQqzva1Z8kYaWCs6ZQMUZZr/LbmfHHrLAmEQ0Kcp5qjjwhBz2C3xoRsDqD1Z0/2AlefTHCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922474; c=relaxed/simple;
	bh=SrHChNOrDwiea1KRH54c2R17NO+i7RO0qbSOW/9ix9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFbxbF/j8SBFsdv33mZvtyw35Zojux9oK22z9DJqkudiDF3OOVg1wQJ9ADn1j8AlZJ4cnqhUxL2ohPXcXgn6CrxDjEb7X3YkZleWUYGLUKthpKMVUNeX7FQMtF3gbzWHeaJ9QUl2cKwRfXZn5Yr3cEao6GryQKqsAi2q9lONEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TJSRz6BJSzXgbX;
	Mon, 22 Jan 2024 19:19:59 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 3265D140499;
	Mon, 22 Jan 2024 19:21:09 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 22 Jan 2024 19:21:07 +0800
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
Subject: [PATCH v5 1/5] perf: build: introduce the libcapstone
Date: Mon, 22 Jan 2024 19:20:50 +0800
Message-ID: <20240122112054.1576835-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122112054.1576835-1-changbin.du@huawei.com>
References: <20240122112054.1576835-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100002.china.huawei.com (7.221.188.184)

Later we will use libcapstone to disassemble instructions of samples.

Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
v2:
  - change tools/perf/tests/make also.
---
 tools/build/Makefile.feature           |  2 ++
 tools/build/feature/Makefile           |  4 ++++
 tools/build/feature/test-all.c         |  4 ++++
 tools/build/feature/test-libcapstone.c | 11 +++++++++++
 tools/perf/Makefile.config             | 21 +++++++++++++++++++++
 tools/perf/Makefile.perf               |  3 +++
 tools/perf/tests/make                  |  2 ++
 7 files changed, 47 insertions(+)
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
index 27e7c478880f..56c2720c1d0f 100644
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
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 8a4da7eb637a..b08026f5d4e7 100644
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


