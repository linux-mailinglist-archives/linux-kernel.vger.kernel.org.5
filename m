Return-Path: <linux-kernel+bounces-46822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9908444BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACEFFB25265
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E20812A171;
	Wed, 31 Jan 2024 16:47:02 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6A12AAFF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719621; cv=none; b=pWwb6Qbe5WViRBe+W9/ZJv6LpP2cOhgNB7tF9LjiJh1ijTkdyzJ+frZurkfck8jmam+Zn/KgAc7D2aSEYP2NOSbJPcXIiVPV27nQ/J2T1MLK6bGs7Z4AL6vu1IVnu+eGkZ5+S77T4u9LG8XChFmuI2+dKKHOvwukJhOtyVPlpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719621; c=relaxed/simple;
	bh=/ZoewK1v9MuRgKEhRZAMYf3wtplIR+Tuwlz07nKIhdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kc69KR4n+PgMGqCBAg+6EH+gaurL66nRwVQ8u7JBr+QWBgdb08+kTMTQw6RJ2oqhxuIvXKmdnCYMsp189+NzG+OmsxHOwluEMtii8oTB9NfxJpTw1X1G0CpzLIb+NQLwglEE08L10rgmkqh6z4oBAiwVKMYIL07FlodwYq0lqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:88f0:c83b:bafa:cdc3])
	by xavier.telenet-ops.be with bizsmtp
	id hUmq2B00L4efzLr01UmqnH; Wed, 31 Jan 2024 17:46:51 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rVDio-00Grc8-FU;
	Wed, 31 Jan 2024 17:46:50 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rVDje-008lkg-Mh;
	Wed, 31 Jan 2024 17:46:50 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] lib: add CPU MHz benchmark test
Date: Wed, 31 Jan 2024 17:46:48 +0100
Message-Id: <a2396ae072d6f9e009b5de558efe166b844a1397.1706718625.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working on SoC bring-up, (a full) userspace may not be available,
making it hard to benchmark the CPU performance of the system under
development.  Still, one may want to have a rough idea of the (relative)
performance of one or more CPU cores, especially when working on e.g.
the clock driver that controls the CPU core clock(s).

Hence add the CPU MHz benchmark test[1], which estimates the clock
frequency of the CPU core it is running on, and make it available as a
Linux kernel test module.

When built-in, this benchmark can be run without any userspace present.

Parallel runs (run on multiple CPU cores) are supported, just kick the
"run" file multiple times.

This has been tested on the folowing CPU cores:
  - ARM: Cortex A7, A9, and A15,
  - ARM64: Cortex A53, A55, A57, and A76,
  - m68k: MC68040,
  - MIPS: TX4927,
  - RISC-V: AndesTech AX45, Kendryte K210, SiFive U54 and U74, VexRiscV.
  - SuperH: SH7751R.
The reported figures are usually within 1-2% of the actual CPU clock
rate.

[1] https://github.com/wtarreau/mhz.git

Suggested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
As suggested by Willy in "Re: Dhrystone -- userland version"
(https://lore.kernel.org/all/20230109143059.GB25476@1wt.eu)

Known issues:
  - The reported value is off on the following systems:
      - RBTX4927: 120 MHz (should be 200 MHz, userspace mhz is OK)
	  user: count=76500 us50=19990 us250=96885 diff=76895 cpu_MHz=198.973
	  kernel:     43663      19943       93024                    119
	  msleep(1000) does sleep 1s, and ktime_get() advances accordingly
      - RZ/Five: 1971 MHz (should be 1000 MHz, userspace mhz not tested)
	  kernel:    679625      20001       88962                   1971
	  msleep(1000) does sleep 1s, and ktime_get() advances accordingly
      - VexRiscV: 12 MHz (should be 64 MHz, userspace mhz not tested)
    I assume this is due to different optimization flags.
    I haven't compared the generated code yet.

  - On fast systems with a large clock granularity (e.g. ARAnyM running
    Linux/m68k), the measured durations for the short and long loops may
    be identical, causing division-by-zero exceptions.
    The same happens with the userspace version, cfr.
    https://github.com/wtarreau/mhz/issues/5.

 lib/Kconfig.debug |  32 +++++++
 lib/Makefile      |   1 +
 lib/test_mhz.c    | 214 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 lib/test_mhz.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 019e5026b619bc2b..8c05f977f278a8ad 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2131,6 +2131,38 @@ menuconfig RUNTIME_TESTING_MENU
 
 if RUNTIME_TESTING_MENU
 
+config TEST_MHZ
+	tristate "CPU MHz test"
+	help
+	  Enable this to include the CPU MHz benchmark.  This benchmark test
+	  estimates the clock frequency of the CPU core it is running on.
+
+	  To run the benchmark, it needs to be enabled explicitly, either from
+	  the kernel command line (when built-in), or from userspace (when
+	  built-in or modular).
+
+	  Run once during kernel boot:
+
+	      test_mhz.run
+
+	  Set number of iterations from kernel command line:
+
+	      test_mhz.iterations=<n>
+
+	  Set number of iterations from userspace:
+
+	      echo <n> > /sys/module/test_mhz/parameters/iterations
+
+	  Trigger manual run from userspace:
+
+	      echo y > /sys/module/test_mhz/parameters/run
+
+	  If the number of iterations is <= 0, the test will devise a suitable
+	  number of iterations (test runs for at least 2s) automatically.
+	  This process takes ca. 4s.
+
+	  If unsure, say N.
+
 config TEST_DHRY
 	tristate "Dhrystone benchmark test"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e619560..209c25d053858482 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
+obj-$(CONFIG_TEST_MHZ) += test_mhz.o
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
 obj-$(CONFIG_TEST_DHRY) += test_dhry.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
diff --git a/lib/test_mhz.c b/lib/test_mhz.c
new file mode 100644
index 0000000000000000..cb0f85193088ec9a
--- /dev/null
+++ b/lib/test_mhz.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: MIT
+/*
+ * CPU core MHz benchmark
+ *
+ * Copyright (C) 2023 Glider bv
+ *
+ * Based on https://github.com/wtarreau/mhz.git, which is
+ * Copyright (C) 2016-2023 Willy Tarreau <w@1wt.eu>
+ */
+
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/smp.h>
+
+static int mhz_run_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops run_ops = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = mhz_run_set,
+};
+static bool mhz_run;
+module_param_cb(run, &run_ops, &mhz_run, 0200);
+MODULE_PARM_DESC(run, "Run the test (default: false)");
+
+static int iterations = -1;
+module_param(iterations, int, 0644);
+MODULE_PARM_DESC(iterations,
+		"Number of iterations through the benchmark (default: auto)");
+
+/*
+ * Performs read-after-write operations that the CPU is not supposed to be able
+ * to parallelize.  The "asm" statements are here to prevent the compiler from
+ * reordering this code.
+ */
+#define dont_move(var)	do { asm volatile("" : "=r"(var) : "0" (var)); } while (0)
+
+#define run1cycle_ae()	do { a ^= e; dont_move(a); } while (0)
+#define run1cycle_ba()	do { b ^= a; dont_move(b); } while (0)
+#define run1cycle_cb()	do { c ^= b; dont_move(c); } while (0)
+#define run1cycle_dc()	do { d ^= c; dont_move(d); } while (0)
+#define run1cycle_ed()	do { e ^= d; dont_move(e); } while (0)
+#define run1cycle_eb()	do { e ^= b; dont_move(e); } while (0)
+
+#define run5cycles()			\
+	do {				\
+		run1cycle_ae();		\
+		run1cycle_ba();		\
+		run1cycle_cb();		\
+		run1cycle_dc();		\
+		run1cycle_ed();		\
+	} while (0)
+
+#define run10cycles()			\
+	do {				\
+		run5cycles();		\
+		run5cycles();		\
+	} while (0)
+
+#define run100cycles()			\
+	do {				\
+		run10cycles();		\
+		run10cycles();		\
+		run10cycles();		\
+		run10cycles();		\
+		run10cycles();		\
+		run10cycles();		\
+		run10cycles();		\
+		run10cycles();		\
+		run10cycles();		\
+		run10cycles();		\
+	} while (0)
+
+
+/*
+ * Performs 50 operations in a loop, all dependant on each other, so that the
+ * CPU cannot parallelize them, hoping to take 50 cycles per loop, plus the
+ * loop counter overhead.
+ */
+static noinline __aligned(64) void loop50(unsigned int n)
+{
+	unsigned int a = 0, b = 0, c = 0, d = 0, e = 0;
+
+	do {
+		run10cycles();
+		run10cycles();
+		run10cycles();
+		run10cycles();
+		run10cycles();
+	} while (__builtin_expect(--n, 1));
+}
+
+/*
+ * Performs 250 operations in a loop, all dependant on each other, so that the
+ * CPU cannot parallelize them, hoping to take 250 cycles per loop, plus the
+ * loop counter overhead.  Do not increase this loop so that it fits in a small
+ * 1 kB L1 cache on 32-bit instruction sets.
+ */
+static noinline __aligned(64) void loop250(unsigned int n)
+{
+	unsigned int a = 0, b = 0, c = 0, d = 0, e = 0;
+
+	do {
+		run10cycles();
+		run10cycles();
+		run10cycles();
+		run10cycles();
+		run10cycles();
+		run100cycles();
+		run100cycles();
+	} while (__builtin_expect(--n, 1));
+}
+
+static unsigned int run_once(unsigned int count)
+{
+	s64 dur50, dur250, dur;
+	unsigned int i;
+	ktime_t begin;
+
+	/*
+	 * Now run the 50 cycles loop.
+	 * We'll pick the lowest value among 5 runs of the short loop.
+	 */
+	dur50 = LLONG_MAX;
+	for (i = 0; i < 5; i++) {
+		begin = ktime_get();
+		loop50(count);
+		dur = ktime_us_delta(ktime_get(), begin);
+		if (dur < dur50)
+			dur50 = dur;
+	}
+
+	/*
+	 * Now run the 250 cycles loop.
+	 * We'll pick the lowest value among 5 runs of the long loop.
+	 */
+	dur250 = LLONG_MAX;
+	for (i = 0; i < 5; i++) {
+		begin = ktime_get();
+		loop250(count);
+		dur = ktime_us_delta(ktime_get(), begin);
+		if (dur < dur250)
+			dur250 = dur;
+	}
+
+	return DIV_U64_ROUND_CLOSEST(count * 200ULL, dur250 - dur50);
+}
+
+/*
+ * Determines how long loop50() must be run to reach more than 20 milliseconds.
+ * This will ensure that an integral number of clock ticks will have happened
+ * on 100, 250, 1000 Hz systems.
+ */
+static unsigned int calibrate(void)
+{
+	unsigned int duration = 0;
+	unsigned int count = 1000;
+	ktime_t start;
+
+	while (duration < 10000) {
+		count = count * 5 / 4;
+		start = ktime_get();
+		loop50(count);
+		duration = ktime_us_delta(ktime_get(), start);
+	}
+
+	return DIV_U64_ROUND_CLOSEST(count * 20000ULL, duration);
+}
+
+static void mhz_benchmark(void)
+{
+	unsigned int cpu = get_cpu();
+	unsigned int mhz;
+
+	if (iterations < 0)
+		iterations = calibrate();
+
+	mhz = run_once(iterations);
+
+	put_cpu();
+
+	pr_info("CPU%u: %u MHz\n", cpu, mhz);
+}
+
+static int mhz_run_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	if (val) {
+		ret = param_set_bool(val, kp);
+		if (ret)
+			return ret;
+	} else {
+		mhz_run = true;
+	}
+
+	if (mhz_run && system_state == SYSTEM_RUNNING)
+		mhz_benchmark();
+
+	return 0;
+}
+
+static int __init mhz_init(void)
+{
+	if (mhz_run)
+		mhz_benchmark();
+
+	return 0;
+}
+module_init(mhz_init);
+
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.34.1


