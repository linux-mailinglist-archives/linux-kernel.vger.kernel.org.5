Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71EE787452
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbjHXPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbjHXPdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:33:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26074CEE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:33:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a1af910e0so3908899b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692891185; x=1693495985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aMgOf9t5wZdItqfD8SuPWRf/5pRJuQTcqZyNhidj2Y=;
        b=AZcePvBBhLgkuuo3km02W9zjKJl2IhG7RrpVAOMkpvOcG/2wlGtsOJ8VGUvm88K+0I
         ULFKV0H5DtB2Ugyi5Um/HOZQERkOQQyNxdBF88kTbiY3YXfvVrp7vkL90VTn6aa6Mfo2
         6ad6p5cCSR9M5b7zvmTZ06V8Uk4jid4du5IE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692891185; x=1693495985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aMgOf9t5wZdItqfD8SuPWRf/5pRJuQTcqZyNhidj2Y=;
        b=CpTKui+rSJJzP1Ag1JXPgQvbIifnium6JH2WRGL8m0pBHNFOzy7Wo3q/ybt2Fqpk4X
         QiVvzkiF0VL1IYVTi3NM4eMsUA22v9gfQJoFI6Y3CN8ubx+gKF7ZeU2DO9Fij59mVQ45
         ezfF2h3VNhrB4vWY2IGTmslzTxoENlC9GeQtgVSRChNUJtLlhJuloG8TTMnUTdbZ8/j6
         9kETHlW8IIpEPzy0XyGboxbUWUZhbExUjpWloedbOS+RrhgGZimoJYzywkHEdLx9ucLv
         ZQBxk8ycwJCgOh1n4mnfvWhxwTQFy/c0ybUgQVYa7tNPFhjLVzc8MmRzSA4XZk4pJ4Z5
         InDQ==
X-Gm-Message-State: AOJu0YwZdrXw6ZXYJYh8bsriAk/YsD9ElGODD5ByWOGGIKEsOoAQcBwZ
        36XPOxJ7IEp6pP6X8y/M/jOFnA==
X-Google-Smtp-Source: AGHT+IE49YAPoY25JDom7a5S38XfT+jTZ7unVGsTuJC6+qpZJdGADROO+tI9gqgujK1/LGuMovHWQg==
X-Received: by 2002:a05:6a20:7354:b0:140:3775:3086 with SMTP id v20-20020a056a20735400b0014037753086mr14235980pzc.59.1692891185652;
        Thu, 24 Aug 2023 08:33:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:afa3:fcf5:1b7f:f7e2])
        by smtp.gmail.com with ESMTPSA id m30-20020a63711e000000b0056365ee8603sm11631337pgc.67.2023.08.24.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:33:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 3/6] arm64: smp: Remove dedicated wakeup IPI
Date:   Thu, 24 Aug 2023 08:30:29 -0700
Message-ID: <20230824083012.v11.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824153233.1006420-1-dianders@chromium.org>
References: <20230824153233.1006420-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

To enable NMI backtrace and KGDB's NMI cpu roundup, we need to free up
at least one dedicated IPI.

On arm64 the IPI_WAKEUP IPI is only used for the ACPI parking protocol,
which itself is only used on some very early ARMv8 systems which
couldn't implement PSCI.

Remove the IPI_WAKEUP IPI, and rely on the IPI_RESCHEDULE IPI to wake
CPUs from the parked state. This will cause a tiny amonut of redundant
work to check the thread flags, but this is miniscule in relation to the
cost of taking and handling the IPI in the first place. We can safely
handle redundant IPI_RESCHEDULE IPIs, so there should be no functional
impact as a result of this change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Will Deacon <will@kernel.org>
---
I have no idea how to test this. I just took Mark's patch and jammed
it into my series. Logicially the patch seems reasonable to me.

Changes in v11:
- arch_send_wakeup_ipi() now takes an unsigned int.

Changes in v10:
- ("arm64: smp: Remove dedicated wakeup IPI") new for v10.

 arch/arm64/include/asm/smp.h              |  4 ++--
 arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
 arch/arm64/kernel/smp.c                   | 28 +++++++++--------------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 9b31e6d0da17..efb13112b408 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -89,9 +89,9 @@ extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
-extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
+extern void arch_send_wakeup_ipi(unsigned int cpu);
 #else
-static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
+static inline void arch_send_wakeup_ipi(unsigned int cpu)
 {
 	BUILD_BUG();
 }
diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index b1990e38aed0..e1be29e608b7 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -103,7 +103,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 		       &mailbox->entry_point);
 	writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
 
-	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+	arch_send_wakeup_ipi(cpu);
 
 	return 0;
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 960b98b43506..a5848f1ef817 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -72,7 +72,6 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP,
 	NR_IPI
 };
 
@@ -764,7 +763,6 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
-	[IPI_WAKEUP]		= "CPU wake-up interrupts",
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
@@ -797,13 +795,6 @@ void arch_send_call_function_single_ipi(int cpu)
 	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
 }
 
-#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
-void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
-{
-	smp_cross_call(mask, IPI_WAKEUP);
-}
-#endif
-
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
@@ -897,14 +888,6 @@ static void do_handle_IPI(int ipinr)
 		break;
 #endif
 
-#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
-	case IPI_WAKEUP:
-		WARN_ONCE(!acpi_parking_protocol_valid(cpu),
-			  "CPU%u: Wake-up IPI outside the ACPI parking protocol\n",
-			  cpu);
-		break;
-#endif
-
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -979,6 +962,17 @@ void arch_smp_send_reschedule(int cpu)
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
+#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
+void arch_send_wakeup_ipi(unsigned int cpu)
+{
+	/*
+	 * We use a scheduler IPI to wake the CPU as this avoids the need for a
+	 * dedicated IPI and we can safely handle spurious scheduler IPIs.
+	 */
+	arch_smp_send_reschedule(cpu);
+}
+#endif
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void tick_broadcast(const struct cpumask *mask)
 {
-- 
2.42.0.rc1.204.g551eb34607-goog

