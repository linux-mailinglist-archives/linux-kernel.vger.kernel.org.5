Return-Path: <linux-kernel+bounces-133913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB489AA9E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790731F21D66
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B8364DA;
	Sat,  6 Apr 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0ZeV5ZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58733CF5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403325; cv=none; b=I0vus0qAkRIUtFMqdJKYAQuOWl7nLMWoTz+vz12rn9BXhiDUBzI7b4Wg5xuSBWMLfriCcggMrylidD3jRX58C/2P3xgr+njj4gqw0wvoZs3tD60jge/xLkZNiNOfTDQTldxFzaTvvQVdccnfcUnNTwaBfX6ARyC3HcO8ymI3AL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403325; c=relaxed/simple;
	bh=P4a9KYACvIIRNW48O2VQT45jjUsOBcQvvKsYyjPbY5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlAVO76PVpID2jAt8+fA33u2pUyMv263EIp/3M24tA0Q9Ti23MRj+D69FRIDtrU29aLXd4dj8HWh5KZOKCaCbLrjZMrR1ckyyMHNZHPffZ/iqcImXr34rjnTXdgEHxpvI6FasbMFDIISp8SQRp2xWxVNrR7Vukt7RHkqEY4oOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0ZeV5ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E50C43390;
	Sat,  6 Apr 2024 11:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712403324;
	bh=P4a9KYACvIIRNW48O2VQT45jjUsOBcQvvKsYyjPbY5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0ZeV5ZCLAozcfubDL9o5rFOQR1+aqsnMrGjnK5RkVMi0AK653WLvHm9FWjD/3bV/
	 GPIq9K7BruLtMize8NP++CRewTgdCOYYrG1bwdb5C4b7yp2cZWVeKE9IxEW28tF9ks
	 +9zW/QLnp5L6aGIUzIGEG2u7p6tnOMILYYL6VkJpFjTCw1WIjg1mPnaM5Z8f2dKMEp
	 jf8yyeH8Tl9kLVRkhzK7zP4/byvejzsoROKUU92Ov8UXN90YAN3QgbsvOkkQ837gMO
	 wSNXf4iTIpSdqVHhRnZoCNcwayoaG02MA6ydDoLRTKYLIszGRljPd3aksEK7B+EkTz
	 ADbyryrsZY0yw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] clocksource/drivers/timer-clint: Add option to use CSR instead of mtime
Date: Sat,  6 Apr 2024 19:21:58 +0800
Message-ID: <20240406112159.1634-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406112159.1634-1-jszhang@kernel.org>
References: <20240406112159.1634-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer: add a
quirk for lacking mtime register") of opensbi:

"T-Head developers surely have a different understanding of time CSR and
CLINT's mtime register with SiFive ones, that they did not implement
the mtime register at all -- as shown in openC906 source code, their
time CSR value is just exposed at the top of their processor IP block
and expects an external continous counter, which makes it not
overrideable, and thus mtime register is not implemented, even not for
reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
extended CSR, these systems still rely on the mtimecmp registers to
generate timer interrupts. This makes it necessary to implement T-Head
C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
reading mtime register and falls back to default code that reads time
CSR."

To use the clint in RISCV-M NOMMU env on Milkv Duo little core, we
need to fall back to read time CSR instead of mtime register. Add the
option for this purpose.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/timex.h    | 6 +++---
 drivers/clocksource/Kconfig       | 9 +++++++++
 drivers/clocksource/timer-clint.c | 7 +++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index a06697846e69..1c3eed4263cd 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -10,7 +10,7 @@
 
 typedef unsigned long cycles_t;
 
-#ifdef CONFIG_RISCV_M_MODE
+#if defined(CONFIG_RISCV_M_MODE) && !defined(CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME)
 
 #include <asm/clint.h>
 
@@ -46,7 +46,7 @@ static inline unsigned long random_get_entropy(void)
 }
 #define random_get_entropy()	random_get_entropy()
 
-#else /* CONFIG_RISCV_M_MODE */
+#else /* CONFIG_RISCV_M_MODE && !CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME */
 
 static inline cycles_t get_cycles(void)
 {
@@ -60,7 +60,7 @@ static inline u32 get_cycles_hi(void)
 }
 #define get_cycles_hi get_cycles_hi
 
-#endif /* !CONFIG_RISCV_M_MODE */
+#endif /* !CONFIG_RISCV_M_MODE || CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME */
 
 #ifdef CONFIG_64BIT
 static inline u64 get_cycles64(void)
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 34faa0320ece..7bbdbf2f96a8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -650,6 +650,15 @@ config CLINT_TIMER
 	  This option enables the CLINT timer for RISC-V systems.  The CLINT
 	  driver is usually used for NoMMU RISC-V systems.
 
+config CLINT_USE_CSR_INSTEADOF_MTIME
+	bool "Use TIME CSR instead of the mtime register"
+	depends on CLINT_TIMER
+	help
+	  Use TIME CSR instead of mtime register. Enable this option if
+	  prefer TIME CSR over MTIME register, or if the implementation
+	  doesn't implement the mtime register in CLINT, so fall back on
+	  TIME CSR.
+
 config CSKY_MP_TIMER
 	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
 	depends on CSKY
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index f468fa8bf5f0..0d3890e00b75 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -76,6 +76,12 @@ static void clint_ipi_interrupt(struct irq_desc *desc)
 #define clint_get_cycles_hi()	readl_relaxed(((u32 *)clint_timer_val) + 1)
 #endif
 
+#ifdef CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME
+static u64 notrace clint_get_cycles64(void)
+{
+	return get_cycles64();
+}
+#else
 #ifdef CONFIG_64BIT
 static u64 notrace clint_get_cycles64(void)
 {
@@ -94,6 +100,7 @@ static u64 notrace clint_get_cycles64(void)
 	return ((u64)hi << 32) | lo;
 }
 #endif /* CONFIG_64BIT */
+#endif /* CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME */
 
 static u64 clint_rdtime(struct clocksource *cs)
 {
-- 
2.43.0


