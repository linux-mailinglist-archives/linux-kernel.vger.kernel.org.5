Return-Path: <linux-kernel+bounces-150009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74A8A9907
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67CA2848BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236015FD01;
	Thu, 18 Apr 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="klkSKEoG"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551115FCE1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441000; cv=none; b=MszfXkN+HIidPXZfN7WZCBzT2DQhnIp0ZRIXhy8EoM24KPx0oK5rFlgVqEWsO+cT3rsy8x+eR0/h9AUQwCHgR+66frrrQZEPBL8qvX7qeAF14Q8WRG6Z4aCz2TmeYyW1kgTmW70wPN2TkQuXyBbB675k+D4dDO6dFF88mWJo5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441000; c=relaxed/simple;
	bh=IUC/g2ll8GsqkikZu/gX2UqnZQi0veoWOYO5tJSzJiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKZ4NCaf4flljgjTggFy5x+pF0X4Bo2RAqx0UOrVsOpu2z4C0rYI8xTwpGUB6u6G2rBRniTl3RFictg68drY4HabyT/y9PpsUUCpCnbLovTG68WH/YsxVaGuUYk3ZjIKVVfviAnfa00+7xhuv42ie3L2bGRoIZh6tQ4DoPhEcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=klkSKEoG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso470973a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713440998; x=1714045798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJdeD5iiUhWW9ibJfrIuQV6O5oUuL7RJYhdQuUEPhzw=;
        b=klkSKEoGImRvZCMN/aNmEiKVcY4LoSMB+f/a+eoKR5kZtj5e/ignrsoSQqoN+cHX1C
         ar4ddOGlhM02UiDwU4w1yntIWLlLBvgRLyLiJr26Rp3gLaX0HYmjghebSIucfmVrZTVt
         Hksj7PYKX6McoGF/SQNUw6Zw1rRbiMtewfZAWtrLZQdBezcC1yiwVLCxYqt1gCzFKXAG
         o4XtXTURgt3Egt2ErPY7B6BcGTPocu025aAjhbV79Up1/Kt+hzem2XnjOgsvfF9JO7un
         f1gUL9iXDe8xDeO4McIxfzY6SVgx9dW4MeI4rrFQL0J6wKBhywxG51K5JgbQBNh+/MLp
         QmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440998; x=1714045798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJdeD5iiUhWW9ibJfrIuQV6O5oUuL7RJYhdQuUEPhzw=;
        b=cEi5bIlim8h8nkHrNmveyi8E1tmiaQzX95Pwb3pmTs3DrA7Oqn8CwtppqmpJ2Mkc/x
         IBRiuud1qU6t6VVHLbG59L46gm7rb1XGhX9U0oxYH8NjltWvLUkxvJzDZW44pu3bPdpL
         nCWIzgK+UOvkXQPZ8GqNR9aIQDyCvhdafbvrccJP3wxVoQ0Z6FPh0yFyhFdJzVhqdifm
         tawzb9xpDqCBx+DWp0YPZ3tnmYbWp+lIU3XP5Nm+GT3CsahRa7a4RE3VvBMypVwHjwtG
         5+9Aa0gkgSr9kRODdWlTAfn2IQyJ+GV5b5LXbT3cxeV85Jg8I8w5AXJZWYwDAzXJuSfm
         s3HA==
X-Forwarded-Encrypted: i=1; AJvYcCWGf1ZPQeT8q6MvAFKKxDingYPyHnyu5B+fhnTcy1uGB14pouUTfVGUy2xT9xCpuzQLmakgxwALOWcbq2K/aeLxutx0qwCgG/935klh
X-Gm-Message-State: AOJu0YyoXl9TgzW3y/GxYzl7Ib3kMwWeGzBMvII4C6L3jG6pkoUiXc0W
	u0EXjP8XshHokZ/GqOl7vP7UmSsQm5R+XX4LD/kQi5bSrrEYAdyYnuCaaAAnHwcTOxKsTyH29HV
	+/zk=
X-Google-Smtp-Source: AGHT+IEhQRyarVDWCbICPcIgg9trabajpb3eBKbcprMDbL7Q13Be7F8tBjQiW5L97nkQIRBDFgy6Pg==
X-Received: by 2002:a17:90a:e2c8:b0:2a0:7758:31ac with SMTP id fr8-20020a17090ae2c800b002a0775831acmr2355963pjb.25.1713440997972;
        Thu, 18 Apr 2024 04:49:57 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090aa40700b002abdb19f499sm1032293pjp.26.2024.04.18.04.49.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Apr 2024 04:49:57 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lihangjing@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 1/2] riscv: process: Introduce idle thread using Zawrs extension
Date: Thu, 18 Apr 2024 19:49:41 +0800
Message-Id: <20240418114942.52770-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240418114942.52770-1-luxu.kernel@bytedance.com>
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Zawrs extension introduces a new instruction WRS.NTO, which will
register a reservation set and causes the hart to temporarily stall
execution in a low-power state until a store occurs to the reservation
set or an interrupt is observed.

This commit implements new version of idle thread for RISC-V via Zawrs
extension.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
---
 arch/riscv/Kconfig                 | 24 +++++++++++++++++
 arch/riscv/include/asm/cpuidle.h   | 11 +-------
 arch/riscv/include/asm/hwcap.h     |  1 +
 arch/riscv/include/asm/processor.h | 17 +++++++++++++
 arch/riscv/kernel/cpu.c            |  5 ++++
 arch/riscv/kernel/cpufeature.c     |  1 +
 arch/riscv/kernel/process.c        | 41 +++++++++++++++++++++++++++++-
 7 files changed, 89 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..a0d344e9803f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -19,6 +19,7 @@ config RISCV
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_VM_PGTABLE
@@ -525,6 +526,20 @@ config RISCV_ISA_SVPBMT
 
 	   If you don't know what to do here, say Y.
 
+config RISCV_ISA_ZAWRS
+	bool "Zawrs extension support for wait-on-reservation-set instructions"
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the Zawrs
+	   extension and enable its usage.
+
+	   The Zawrs extension defines a pair of instructions to be used
+	   in polling loops that allows a core to enter a low-power state
+	   and wait on a store to a memory location.
+
+	   If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_V
 	bool
 	default y
@@ -1075,6 +1090,15 @@ endmenu # "Power management options"
 
 menu "CPU Power Management"
 
+config RISCV_ZAWRS_IDLE
+	bool "Idle thread using ZAWRS extensions"
+	depends on RISCV_ISA_ZAWRS
+	default y
+	help
+		Adds support to implement idle thread using ZAWRS extension.
+
+		If you don't know what to do here, say Y.
+
 source "drivers/cpuidle/Kconfig"
 
 source "drivers/cpufreq/Kconfig"
diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
index 71fdc607d4bc..94c9ecb46571 100644
--- a/arch/riscv/include/asm/cpuidle.h
+++ b/arch/riscv/include/asm/cpuidle.h
@@ -10,15 +10,6 @@
 #include <asm/barrier.h>
 #include <asm/processor.h>
 
-static inline void cpu_do_idle(void)
-{
-	/*
-	 * Add mb() here to ensure that all
-	 * IO/MEM accesses are completed prior
-	 * to entering WFI.
-	 */
-	mb();
-	wait_for_interrupt();
-}
+void cpu_do_idle(void);
 
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..5b358c3cf212 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,7 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_ZAWRS		75
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 0faf5f161f1e..1143367de8c6 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -157,6 +157,21 @@ static inline void wait_for_interrupt(void)
 	__asm__ __volatile__ ("wfi");
 }
 
+static inline void wrs_nto(unsigned long *addr)
+{
+	int val;
+
+	__asm__ __volatile__(
+#ifdef CONFIG_64BIT
+			"lr.d %[p], %[v] \n\t"
+#else
+			"lr.w %[p], %[v] \n\t"
+#endif
+			".long 0x00d00073 \n\t"
+			: [p] "=&r" (val), [v] "+A" (*addr)
+			: : "memory");
+}
+
 extern phys_addr_t dma32_phys_limit;
 
 struct device_node;
@@ -183,6 +198,8 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
 
+extern void select_idle_routine(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index d11d6320fb0d..69cebd41f5f3 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -22,6 +22,11 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 	return phys_id == cpuid_to_hartid_map(cpu);
 }
 
+void __init arch_cpu_finalize_init(void)
+{
+	select_idle_routine();
+}
+
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
  * isn't an enabled and valid RISC-V hart node.
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..c080e6ca54ba 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -305,6 +305,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
+	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 92922dbd5b5c..9f0f7b888bc1 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -15,6 +15,7 @@
 #include <linux/tick.h>
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
+#include <linux/static_call.h>
 
 #include <asm/unistd.h>
 #include <asm/processor.h>
@@ -37,11 +38,49 @@ EXPORT_SYMBOL(__stack_chk_guard);
 
 extern asmlinkage void ret_from_fork(void);
 
-void arch_cpu_idle(void)
+static __cpuidle void default_idle(void)
+{
+	/*
+	 * Add mb() here to ensure that all
+	 * IO/MEM accesses are completed prior
+	 * to entering WFI.
+	 */
+	mb();
+	wait_for_interrupt();
+}
+
+static __cpuidle void wrs_idle(void)
+{
+	/*
+	 * Add mb() here to ensure that all
+	 * IO/MEM accesses are completed prior
+	 * to entering WRS.NTO.
+	 */
+	mb();
+	wrs_nto(&current_thread_info()->flags);
+}
+
+DEFINE_STATIC_CALL_NULL(riscv_idle, default_idle);
+
+void __cpuidle cpu_do_idle(void)
+{
+	static_call(riscv_idle)();
+}
+
+void __cpuidle arch_cpu_idle(void)
 {
 	cpu_do_idle();
 }
 
+void __init select_idle_routine(void)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ZAWRS_IDLE) &&
+			riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS))
+		static_call_update(riscv_idle, wrs_idle);
+	else
+		static_call_update(riscv_idle, default_idle);
+}
+
 int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
 {
 	if (!unaligned_ctl_available())
-- 
2.20.1


