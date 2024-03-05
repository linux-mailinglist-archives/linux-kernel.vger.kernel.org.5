Return-Path: <linux-kernel+bounces-93040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC63C872A0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8C91F25CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E212D20D;
	Tue,  5 Mar 2024 22:18:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075212D202;
	Tue,  5 Mar 2024 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677120; cv=none; b=tJPHh4HdBcEZ6wDKbyK1mKKpVMGH54Pd/X8lXFYWLJm+ky4w9TcRhEUzMByor1A+IxOezUmQI2SqxnSqeKitK1GNdlYi6hYH9mk94iSs/3RlNmvglYRDt4OyBfFGszVTJR3Z6ijufnHz9Mh8AN3sdM9AuO9zx1Tco+gzQcIEJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677120; c=relaxed/simple;
	bh=KtqRJIlcfoVIXZZ1FG9N27/oAs+vJkYnbi0aKOo09xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5LMyKE7l8+mnJVosQ6WZJ+OW0SDF4TcnxnwXb5VDeVSPo0HTwKknxbNMcQkfU6r7iOf/siFZlThwfhWeG4oipEPpCIt1YKS3ksnIvu7fIZRRRmNlGFDYrgymecS7ZhsMNTLPcZZhplGvtkDqUswc9qVaw7rhtKPxju+ZjIcluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3982C15;
	Tue,  5 Mar 2024 14:19:07 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E1F23F738;
	Tue,  5 Mar 2024 14:18:30 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	keescook@chromium.org,
	Jason@zx2c4.com,
	gustavoars@kernel.org,
	mark.rutland@arm.com,
	rostedt@goodmis.org,
	arnd@arndb.de,
	broonie@kernel.org,
	guohui@uniontech.com,
	Manoj.Iyer@arm.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>,
	James Yang <james.yang@arm.com>,
	Shiyou Huang <shiyou.huang@arm.com>
Subject: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Date: Tue,  5 Mar 2024 16:18:24 -0600
Message-ID: <20240305221824.3300322-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305221824.3300322-1-jeremy.linton@arm.com>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The existing arm64 stack randomization uses the kernel rng to acquire
5 bits of address space randomization. This is problematic because it
creates non determinism in the syscall path when the rng needs to be
generated or reseeded. This shows up as large tail latencies in some
benchmarks and directly affects the minimum RT latencies as seen by
cyclictest.

Other architectures are using timers/cycle counters for this function,
which is sketchy from a randomization perspective because it should be
possible to estimate this value from knowledge of the syscall return
time, and from reading the current value of the timer/counters.

So, a poor rng should be better than the cycle counter if it is hard
to extract the stack offsets sufficiently to be able to detect the
PRNG's period. Lets downgrade from get_random_u16() to
prandom_u32_state() under the theory that the danger of someone
guessing the 1 in 32 per call offset, is larger than that of being
able to extract sufficient history to accurately predict future
offsets. Further it should be safer to run with prandom_u32_state than
disabling stack randomization for those subset of applications where the
difference in latency is on the order of ~5X worse.

Reported-by: James Yang <james.yang@arm.com>
Reported-by: Shiyou Huang <shiyou.huang@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/syscall.c | 42 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 9a70d9746b66..33b3ea4adff8 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
+#include <linux/prandom.h>
 #include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
 
@@ -37,6 +38,45 @@ static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
 	return syscall_fn(regs);
 }
 
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+DEFINE_PER_CPU(struct rnd_state, kstackrng);
+
+static u16 kstack_rng(void)
+{
+	u32 rng = prandom_u32_state(this_cpu_ptr(&kstackrng));
+
+	return rng & 0x1ff;
+}
+
+/* Should we reseed? */
+static int kstack_rng_setup(unsigned int cpu)
+{
+	u32 rng_seed;
+
+	/* zero should be avoided as a seed */
+	do {
+		rng_seed = get_random_u32();
+	} while (!rng_seed);
+	prandom_seed_state(this_cpu_ptr(&kstackrng), rng_seed);
+	return 0;
+}
+
+static int kstack_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:kstackrandomize",
+				kstack_rng_setup, NULL);
+	if (ret < 0)
+		pr_err("kstack: failed to register rng callbacks.\n");
+	return 0;
+}
+
+arch_initcall(kstack_init);
+#else
+static u16 kstack_rng(void) { return 0; }
+#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
+
 static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 			   unsigned int sc_nr,
 			   const syscall_fn_t syscall_table[])
@@ -66,7 +106,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	 *
 	 * The resulting 5 bits of entropy is seen in SP[8:4].
 	 */
-	choose_random_kstack_offset(get_random_u16() & 0x1FF);
+	choose_random_kstack_offset(kstack_rng());
 }
 
 static inline bool has_syscall_work(unsigned long flags)
-- 
2.43.0


