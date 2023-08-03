Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B676F600
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjHCXJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjHCXJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:09:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98F2698
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:08:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad356f03so10751395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691104138; x=1691708938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZFR6hR4MgixZPi5Vx/h6mh3aFizC5jpLVjbFDuTXzk=;
        b=Yrtl0fTOBqR41ImU0+amCbPztuZDGzUVxCdl3x0hw6hwOIv/8k3m9WQO/mttMu369L
         zZlwEoO4tNu+89BRw7b4JSzisHqdfF51BYFauemtPvhBnCBJ3j9RdTR0bcfq39FJx3ux
         vQ0ingPHXd5bSZBRYqP4s4/XhMbsdipJBQ+m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691104138; x=1691708938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZFR6hR4MgixZPi5Vx/h6mh3aFizC5jpLVjbFDuTXzk=;
        b=cX/ApQsN33QGn4ZLUaEQ0lpEf77be1GVRTvHORLjWrySErqyrFgOGISphDtW6O4Yvz
         AKLzyM3csPEQWVEOpTowbaXDvKwTV+L7q3Dp+4n4C4tSt0IGIFZxFCrsvdrU7KV0B9zx
         CTNdpJobZNCeqDtI4qcaRF3CquwiObRp/D4J1BKzWtZzvB/Nbtb+pUax7kTDb9yVhfnI
         ZanqwuGUyWCWGzvxwMx2ojOgPxmSwnNo+x5pLncg4sGIIHhZjkI//HevD5H1iqZd4ywK
         cWkfb1cnGIOKA5hEdQ27kDMkhDO7xAjwXUdfChPqbUYBNoDU76jy8zonsm9Kh4/8h2WC
         cZvQ==
X-Gm-Message-State: AOJu0YzEtqMfw5Vu85VlY5OGuGatYk/Z2iT2HPhV9VzKROBkCpuR6U+T
        47r3ABs2oeAJd7041A8TBZJdJQ==
X-Google-Smtp-Source: AGHT+IHpt3GmqxmUYWeyDxrjsC/U+hfzZspynC8VLCIFtP8cNsZp90XHIeRqwjI5dpuN/mozNLSnNg==
X-Received: by 2002:a17:902:6909:b0:1b8:9002:c9ee with SMTP id j9-20020a170902690900b001b89002c9eemr114243plk.1.1691104137546;
        Thu, 03 Aug 2023 16:08:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:7e35:e6d0:7bbf:64])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001adf6b21c77sm369405plx.107.2023.08.03.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:08:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v3 1/2] nmi_backtrace: Allow excluding an arbitrary CPU
Date:   Thu,  3 Aug 2023 16:07:57 -0700
Message-ID: <20230803160649.v3.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APIs that allow backtracing across CPUs have always had a way to
exclude the current CPU. This convenience means callers didn't need to
find a place to allocate a CPU mask just to handle the common case.

Let's extend the API to take a CPU ID to exclude instead of just a
boolean. This isn't any more complex for the API to handle and allows
the hardlockup detector to exclude a different CPU (the one it already
did a trace for) without needing to find space for a CPU mask.

Arguably, this new API also encourages safer behavior. Specifically if
the caller wants to avoid tracing the current CPU (maybe because they
already traced the current CPU) this makes it more obvious to the
caller that they need to make sure that the current CPU ID can't
change.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("nmi_backtrace: Allow excluding an arbitrary CPU") new for v3.

 arch/arm/include/asm/irq.h       |  2 +-
 arch/arm/kernel/smp.c            |  4 ++--
 arch/loongarch/include/asm/irq.h |  2 +-
 arch/loongarch/kernel/process.c  |  4 ++--
 arch/mips/include/asm/irq.h      |  2 +-
 arch/mips/kernel/process.c       |  4 ++--
 arch/powerpc/include/asm/irq.h   |  2 +-
 arch/powerpc/kernel/stacktrace.c |  4 ++--
 arch/powerpc/kernel/watchdog.c   |  4 ++--
 arch/sparc/include/asm/irq_64.h  |  2 +-
 arch/sparc/kernel/process_64.c   |  6 +++---
 arch/x86/include/asm/irq.h       |  2 +-
 arch/x86/kernel/apic/hw_nmi.c    |  4 ++--
 include/linux/nmi.h              | 12 ++++++------
 kernel/watchdog.c                |  2 +-
 lib/nmi_backtrace.c              |  6 +++---
 16 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 18605f1b3580..26c1d2ced4ce 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -32,7 +32,7 @@ void handle_IRQ(unsigned int, struct pt_regs *);
 #include <linux/cpumask.h>
 
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
-					   bool exclude_self);
+					   int exclude_cpu);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 6756203e45f3..3431c0553f45 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -846,7 +846,7 @@ static void raise_nmi(cpumask_t *mask)
 	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 {
-	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_nmi);
+	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, raise_nmi);
 }
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index a115e8999c69..218b4da0ea90 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -40,7 +40,7 @@ void spurious_interrupt(void);
 #define NR_IRQS_LEGACY 16
 
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
-void arch_trigger_cpumask_backtrace(const struct cpumask *mask, bool exclude_self);
+void arch_trigger_cpumask_backtrace(const struct cpumask *mask, int exclude_cpu);
 
 #define MAX_IO_PICS 2
 #define NR_IRQS	(64 + (256 * MAX_IO_PICS))
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 2e04eb07abb6..778e8d09953e 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -345,9 +345,9 @@ static void raise_backtrace(cpumask_t *mask)
 	}
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 {
-	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace);
+	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, raise_backtrace);
 }
 
 #ifdef CONFIG_64BIT
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 75abfa834ab7..3a848e7e69f7 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -77,7 +77,7 @@ extern int cp0_fdc_irq;
 extern int get_c0_fdc_int(void);
 
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
-				    bool exclude_self);
+				    int exclude_cpu);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 
 #endif /* _ASM_IRQ_H */
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index a3225912c862..5387ed0a5186 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -750,9 +750,9 @@ static void raise_backtrace(cpumask_t *mask)
 	}
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 {
-	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace);
+	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, raise_backtrace);
 }
 
 int mips_get_process_fp_mode(struct task_struct *task)
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index f257cacb49a9..ba1a5974e714 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -55,7 +55,7 @@ int irq_choose_cpu(const struct cpumask *mask);
 
 #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI)
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
-					   bool exclude_self);
+					   int exclude_cpu);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 5de8597eaab8..b15f15dcacb5 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -221,8 +221,8 @@ static void raise_backtrace_ipi(cpumask_t *mask)
 	}
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 {
-	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);
+	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, raise_backtrace_ipi);
 }
 #endif /* defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI) */
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index edb2dd1f53eb..8c464a5d8246 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -245,7 +245,7 @@ static void watchdog_smp_panic(int cpu)
 			__cpumask_clear_cpu(c, &wd_smp_cpus_ipi);
 		}
 	} else {
-		trigger_allbutself_cpu_backtrace();
+		trigger_allbutcpu_cpu_backtrace(cpu);
 		cpumask_clear(&wd_smp_cpus_ipi);
 	}
 
@@ -416,7 +416,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 		xchg(&__wd_nmi_output, 1); // see wd_lockup_ipi
 
 		if (sysctl_hardlockup_all_cpu_backtrace)
-			trigger_allbutself_cpu_backtrace();
+			trigger_allbutcpu_cpu_backtrace(cpu);
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index b436029f1ced..8c4c0c87f998 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -87,7 +87,7 @@ static inline unsigned long get_softint(void)
 }
 
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
-				    bool exclude_self);
+				    int exclude_cpu);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 
 extern void *hardirq_stack[NR_CPUS];
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index b51d8fb0ecdc..1ea3f37fa985 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -236,7 +236,7 @@ static void __global_reg_poll(struct global_reg_snapshot *gp)
 	}
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 {
 	struct thread_info *tp = current_thread_info();
 	struct pt_regs *regs = get_irq_regs();
@@ -252,7 +252,7 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 
 	memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
 
-	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
+	if (cpumask_test_cpu(this_cpu, mask) && this_cpu != exclude_cpu)
 		__global_reg_self(tp, regs, this_cpu);
 
 	smp_fetch_global_regs();
@@ -260,7 +260,7 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 	for_each_cpu(cpu, mask) {
 		struct global_reg_snapshot *gp;
 
-		if (exclude_self && cpu == this_cpu)
+		if (cpu == exclude_cpu)
 			continue;
 
 		gp = &global_cpu_snapshot[cpu].reg;
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 29e083b92813..836c170d3087 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -42,7 +42,7 @@ extern void init_ISA_irqs(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
-				    bool exclude_self);
+				    int exclude_cpu);
 
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 34a992e275ef..d6e01f924299 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -34,9 +34,9 @@ static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 	apic->send_IPI_mask(mask, NMI_VECTOR);
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 {
-	nmi_trigger_cpumask_backtrace(mask, exclude_self,
+	nmi_trigger_cpumask_backtrace(mask, exclude_cpu,
 				      nmi_raise_cpu_backtrace);
 }
 
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index e3e6a64b98e0..00982b133dc1 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -157,31 +157,31 @@ static inline void touch_nmi_watchdog(void)
 #ifdef arch_trigger_cpumask_backtrace
 static inline bool trigger_all_cpu_backtrace(void)
 {
-	arch_trigger_cpumask_backtrace(cpu_online_mask, false);
+	arch_trigger_cpumask_backtrace(cpu_online_mask, -1);
 	return true;
 }
 
-static inline bool trigger_allbutself_cpu_backtrace(void)
+static inline bool trigger_allbutcpu_cpu_backtrace(int exclude_cpu)
 {
-	arch_trigger_cpumask_backtrace(cpu_online_mask, true);
+	arch_trigger_cpumask_backtrace(cpu_online_mask, exclude_cpu);
 	return true;
 }
 
 static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
 {
-	arch_trigger_cpumask_backtrace(mask, false);
+	arch_trigger_cpumask_backtrace(mask, -1);
 	return true;
 }
 
 static inline bool trigger_single_cpu_backtrace(int cpu)
 {
-	arch_trigger_cpumask_backtrace(cpumask_of(cpu), false);
+	arch_trigger_cpumask_backtrace(cpumask_of(cpu), -1);
 	return true;
 }
 
 /* generic implementation */
 void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
-				   bool exclude_self,
+				   int exclude_cpu,
 				   void (*raise)(cpumask_t *mask));
 bool nmi_cpu_backtrace(struct pt_regs *regs);
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index be38276a365f..085d7a78f62f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -523,7 +523,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			dump_stack();
 
 		if (softlockup_all_cpu_backtrace) {
-			trigger_allbutself_cpu_backtrace();
+			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
 			clear_bit_unlock(0, &soft_lockup_nmi_warn);
 		}
 
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 5274bbb026d7..33c154264bfe 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -34,7 +34,7 @@ static unsigned long backtrace_flag;
  * they are passed being updated as a side effect of this call.
  */
 void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
-				   bool exclude_self,
+				   int exclude_cpu,
 				   void (*raise)(cpumask_t *mask))
 {
 	int i, this_cpu = get_cpu();
@@ -49,8 +49,8 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	}
 
 	cpumask_copy(to_cpumask(backtrace_mask), mask);
-	if (exclude_self)
-		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
+	if (exclude_cpu != -1)
+		cpumask_clear_cpu(exclude_cpu, to_cpumask(backtrace_mask));
 
 	/*
 	 * Don't try to send an NMI to this cpu; it may work on some
-- 
2.41.0.585.gd2178a4bd4-goog

