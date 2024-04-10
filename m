Return-Path: <linux-kernel+bounces-138766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA0589FA16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0311C20C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A916E882;
	Wed, 10 Apr 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYPaFUrY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F116E88F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759837; cv=none; b=VNyxrRsO/cYsYCCfHDc+1Lek8HbpGiNO4Rtl3E3vPwTRNm5IMJ7yqKeyw/A9ZwsXNI/7xpkW7l08j98KOhdEOBLoBIyoebk2Ek6SYOmjGvYCyxO4ZQE/toRiFeUF9jsLXOHI6reI4GqErxskKw7QOQpuVEN7pZ4OagcejPh0/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759837; c=relaxed/simple;
	bh=TrpEW+6B4Jv83pnm2iw9qpP7oQ/M2UPszbPFDwKZP68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efR1W09Nlna3K1UaJ0G4ByFzIuT47/PhEJQlpUwY9oDL1aSN2YplEqcmmgzIOl1sNL8bnNd+G3GxAESzCrpT1/wlh8MUCXdfrRMsozRWvJJiDIJyp2tCVXIqc74r3P5g/88BWFibuom9+CIegprL8uq9WV9jypSrvWGnIYj63h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYPaFUrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492DFC433A6;
	Wed, 10 Apr 2024 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712759836;
	bh=TrpEW+6B4Jv83pnm2iw9qpP7oQ/M2UPszbPFDwKZP68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYPaFUrYMEHydYRmDrE8qoQqRKFuBC31/2h8g4fwPOqV+nAT/n1JwR5yQZD6pk67Z
	 YftpOz4ingL9S507aSlv6DaIQPyBiPDcy95aYXGNGqytMPzTbZa+6oUE/+mKt4WRzr
	 brwurqZB9APv3hfmxqOQiHWFQYoTGyVXiMiGST6IN7WJHf9Rh1+ZukXBbWT0ilnj7O
	 sm12yPdKQTApssOgnYFwuuJOkMKenLaOZzDL0Xjbyi8ceVg8Xxusov54R+33Lp88yg
	 9iYlDomN9KbA82NyXit+Rsu93OUENjhnEBDoKH4L/4J2zLb5HizxI9gM/1CHlyGnK0
	 kkGV+cKyPSDpg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] clocksource/drivers/timer-clint: Add T-Head C9xx clint
Date: Wed, 10 Apr 2024 22:23:47 +0800
Message-ID: <20240410142347.964-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410142347.964-1-jszhang@kernel.org>
References: <20240410142347.964-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To use the T-HEAD C9xx clint in RISCV-M NOMMU env, we need to take
care two points:

1.The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
implement such support.

2. As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer:
add a quirk for lacking mtime register") of opensbi:

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

So, we need to fall back to read time CSR instead of mtime register.
Add riscv_csr_time_available static key for this purpose.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/clint.h    |  2 ++
 arch/riscv/include/asm/timex.h    | 18 +++++++++---
 drivers/clocksource/timer-clint.c | 48 +++++++++++++++++++++++++++----
 3 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
index 0789fd37b40a..c6057a182c5d 100644
--- a/arch/riscv/include/asm/clint.h
+++ b/arch/riscv/include/asm/clint.h
@@ -10,6 +10,7 @@
 #include <asm/mmio.h>
 
 #ifdef CONFIG_RISCV_M_MODE
+#include <linux/jump_label.h>
 /*
  * This lives in the CLINT driver, but is accessed directly by timex.h to avoid
  * any overhead when accessing the MMIO timer.
@@ -21,6 +22,7 @@
  * like "riscv_mtime", to signify that these non-ISA assumptions must hold.
  */
 extern u64 __iomem *clint_time_val;
+DECLARE_STATIC_KEY_FALSE(riscv_csr_time_available);
 #endif
 
 #endif
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index a06697846e69..007a15482d75 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -17,18 +17,27 @@ typedef unsigned long cycles_t;
 #ifdef CONFIG_64BIT
 static inline cycles_t get_cycles(void)
 {
-	return readq_relaxed(clint_time_val);
+	if (static_branch_likely(&riscv_csr_time_available))
+		return csr_read(CSR_TIME);
+	else
+		return readq_relaxed(clint_time_val);
 }
 #else /* !CONFIG_64BIT */
 static inline u32 get_cycles(void)
 {
-	return readl_relaxed(((u32 *)clint_time_val));
+	if (static_branch_likely(&riscv_csr_time_available))
+		return csr_read(CSR_TIME);
+	else
+		return readl_relaxed(((u32 *)clint_time_val));
 }
 #define get_cycles get_cycles
 
 static inline u32 get_cycles_hi(void)
 {
-	return readl_relaxed(((u32 *)clint_time_val) + 1);
+	if (static_branch_likely(&riscv_csr_time_available))
+		return csr_read(CSR_TIMEH);
+	else
+		return readl_relaxed(((u32 *)clint_time_val) + 1);
 }
 #define get_cycles_hi get_cycles_hi
 #endif /* CONFIG_64BIT */
@@ -40,7 +49,8 @@ static inline u32 get_cycles_hi(void)
  */
 static inline unsigned long random_get_entropy(void)
 {
-	if (unlikely(clint_time_val == NULL))
+	if (!static_branch_likely(&riscv_csr_time_available) &&
+	   (unlikely(clint_time_val == NULL)))
 		return random_get_entropy_fallback();
 	return get_cycles();
 }
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index f468fa8bf5f0..acfcd78cc576 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -39,10 +39,13 @@ static u64 __iomem *clint_timer_cmp;
 static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
 static unsigned int clint_timer_irq;
+static bool is_c900_clint;
 
 #ifdef CONFIG_RISCV_M_MODE
 u64 __iomem *clint_time_val;
 EXPORT_SYMBOL(clint_time_val);
+DEFINE_STATIC_KEY_FALSE(riscv_csr_time_available);
+EXPORT_SYMBOL(riscv_csr_time_available);
 #endif
 
 #ifdef CONFIG_SMP
@@ -79,17 +82,27 @@ static void clint_ipi_interrupt(struct irq_desc *desc)
 #ifdef CONFIG_64BIT
 static u64 notrace clint_get_cycles64(void)
 {
-	return clint_get_cycles();
+	if (static_branch_likely(&riscv_csr_time_available))
+		return csr_read(CSR_TIME);
+	else
+		return clint_get_cycles();
 }
 #else /* CONFIG_64BIT */
 static u64 notrace clint_get_cycles64(void)
 {
 	u32 hi, lo;
 
-	do {
-		hi = clint_get_cycles_hi();
-		lo = clint_get_cycles();
-	} while (hi != clint_get_cycles_hi());
+	if (static_branch_likely(&riscv_csr_time_available)) {
+		do {
+			hi = clint_get_cycles_hi();
+			lo = clint_get_cycles();
+		} while (hi != clint_get_cycles_hi());
+	} else {
+		do {
+			hi = csr_read(CSR_TIMEH);
+			lo = csr_read(CSR_TIME);
+		} while (hi != csr_read(CSR_TIMEH));
+	}
 
 	return ((u64)hi << 32) | lo;
 }
@@ -128,6 +141,19 @@ static int clint_clock_shutdown(struct clock_event_device *evt)
 	return 0;
 }
 
+static int c900_clint_clock_next_event(unsigned long delta,
+				       struct clock_event_device *ce)
+{
+	void __iomem *r = clint_timer_cmp +
+			  cpuid_to_hartid_map(smp_processor_id());
+	u64 val = clint_get_cycles64() + delta;
+
+	csr_set(CSR_IE, IE_TIE);
+	writel_relaxed(val, r);
+	writel_relaxed(val >> 32, r + 4);
+	return 0;
+}
+
 static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
 	.name				= "clint_clockevent",
 	.features			= CLOCK_EVT_FEAT_ONESHOT,
@@ -141,6 +167,9 @@ static int clint_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
 
+	if (is_c900_clint)
+		ce->set_next_event = c900_clint_clock_next_event;
+
 	ce->cpumask = cpumask_of(cpu);
 	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
 
@@ -284,5 +313,14 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	return rc;
 }
 
+static int __init c900_clint_timer_init_dt(struct device_node *np)
+{
+	is_c900_clint = true;
+	static_branch_enable(&riscv_csr_time_available);
+
+	return clint_timer_init_dt(np);
+}
+
 TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
 TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
+TIMER_OF_DECLARE(clint_timer2, "thead,c900-clint", c900_clint_timer_init_dt);
-- 
2.43.0


