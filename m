Return-Path: <linux-kernel+bounces-73930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF82885CDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869ED2814F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0D5235;
	Wed, 21 Feb 2024 02:03:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE23FE0;
	Wed, 21 Feb 2024 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481000; cv=none; b=mYR8ZWTzEzGvL4PYFjkaGEf2LZWbKXqPohw2GYaIg1LGJd4oVF4owKCJNybbuPZUpUiaWcmsUk2inFImXMpJFZxCwhGzBBKQ8J9mQ1h5DDqFpZYMSVCFCZ1d7AoamOYIImrl462RRlYZXHpp7KEQfiectRIUo1YbH/aeOIDpd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481000; c=relaxed/simple;
	bh=KEbCD0+Yt5WycZBGFG+KMXcNoaLDk8sz4dr4unOnTvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqXjQ8ZmG2sUOrb1NrN0Avxs+40lf4XZwMRRWQtr8ZsfbQ4nJ9u4z9rQEJp2EpXV7o1cHLucY0rATN+GT4FQm1S6EkrGXtM4Klj3uQsfNM+oiWOZpj4Oyh6oWxxKr1k+nn0JWIdIwzKrgbNisp7Iw4vyxcQQZfSPC+mBX85+6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EE08FEC;
	Tue, 20 Feb 2024 18:03:54 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAC763F766;
	Tue, 20 Feb 2024 18:03:15 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	keescook@chromium.org,
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
Subject: [RFC] arm64: syscall: Direct PRNG kstack randomization
Date: Tue, 20 Feb 2024 20:02:58 -0600
Message-ID: <20240221020258.1210148-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
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
PRNG's period.

So, we can potentially choose a 'better' or larger PRNG, going as far
as using one of the CSPRNGs already in the kernel, but the overhead
increases appropriately. Further, there are a few options for
reseeding, possibly out of the syscall path, but is it even useful in
this case?

Reported-by: James Yang <james.yang@arm.com>
Reported-by: Shiyou Huang <shiyou.huang@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/syscall.c | 55 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 9a70d9746b66..70143cb8c7be 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -37,6 +37,59 @@ static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
 	return syscall_fn(regs);
 }
 
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+DEFINE_PER_CPU(u32, kstackrng);
+static u32 xorshift32(u32 state)
+{
+	/*
+	 * From top of page 4 of Marsaglia, "Xorshift RNGs"
+	 * This algorithm is intended to have a period 2^32 -1
+	 * And should not be used anywhere else outside of this
+	 * code path.
+	 */
+	state ^= state << 13;
+	state ^= state >> 17;
+	state ^= state << 5;
+	return state;
+}
+
+static u16 kstack_rng(void)
+{
+	u32 rng = raw_cpu_read(kstackrng);
+
+	rng = xorshift32(rng);
+	raw_cpu_write(kstackrng, rng);
+	return rng & 0x1ff;
+}
+
+/* Should we reseed? */
+static int kstack_rng_setup(unsigned int cpu)
+{
+	u32 rng_seed;
+
+	do {
+		rng_seed = get_random_u32();
+	} while (!rng_seed);
+	raw_cpu_write(kstackrng, rng_seed);
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
@@ -66,7 +119,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	 *
 	 * The resulting 5 bits of entropy is seen in SP[8:4].
 	 */
-	choose_random_kstack_offset(get_random_u16() & 0x1FF);
+	choose_random_kstack_offset(kstack_rng());
 }
 
 static inline bool has_syscall_work(unsigned long flags)
-- 
2.43.0


