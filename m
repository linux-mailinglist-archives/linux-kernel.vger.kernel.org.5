Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6C7784C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjHVVa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjHVVax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:30:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17AAE4D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:30:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf078d5fb7so33245635ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692739850; x=1693344650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NTSblsAu8PNy2OgT43FimYv6UYWrsT3fb8iGcpeqoY=;
        b=SSwVk0/Y6ZNUglAJO0DD6i6/m5NNNngXeG3Y6lw2BIZyrknN1/imUbQMG5WLp0Op+m
         d9VQYQnoaA6skHN+tGDuiemWjBBac93s/XMTWlw8mW/NLtczFpdMrwj2baINYvFmYBlV
         +hNDcfecQe2m+uT4ySEkasCQpLR/uSQXdaOkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739850; x=1693344650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NTSblsAu8PNy2OgT43FimYv6UYWrsT3fb8iGcpeqoY=;
        b=RFXSqk5OyWO/y5Dzgd4ubfPykRU1AepAOyyIW+E+1mnJeL+ob8i/V+CcxUrmMfqvkS
         uyFLxOao7tFkEFZvTiuWCvb2o2ChWLsql7UZYHvAMPZnBWL5nEvVEFhDoUuxuOeVs7NL
         OYXI+ASpM7hkuJiQw1TbG/fHtWAsXKkRqInOGdxY/yTf0NC/k5xk9SOGC2WqUVDRRzcL
         T8Rzq8uqIWp9AhS2MUivaOUp8XEzH/G1ddL4cNimDnpjfjx/AKERRaLXsNCoor6Nn8eW
         LNZ4Xb3PowAnsKwX3eDusuIOPXzxySmDi0Adot+ahLXE4b/+AEc+qOIRiy6LJeY1bR6u
         pI/A==
X-Gm-Message-State: AOJu0YzHS8a8RfW/CtXkNE7yw+bHUo8qbETL0+fcsA0pZ2mtM+IzsJlR
        moLXQ3gH8TIKcRhLgUD1xsJfng==
X-Google-Smtp-Source: AGHT+IHA2klR/hpR4pC+xNHo1EGJFPmRBiLjPNVhxt8TvBFzkQhWq2zyCjyW7Wf1mZrMjB+TX9rFuw==
X-Received: by 2002:a17:902:b403:b0:1bd:bfc0:4627 with SMTP id x3-20020a170902b40300b001bdbfc04627mr7708342plr.40.1692739850223;
        Tue, 22 Aug 2023 14:30:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:83f0:2bc5:38c4:a9de])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b001befac3b3cbsm9451475plg.290.2023.08.22.14.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:30:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/6] arm64: smp: Remove dedicated wakeup IPI
Date:   Tue, 22 Aug 2023 14:26:58 -0700
Message-ID: <20230822142644.v10.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822212927.249645-1-dianders@chromium.org>
References: <20230822212927.249645-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes in v10:
- ("arm64: smp: Remove dedicated wakeup IPI") new for v10.

 arch/arm64/include/asm/smp.h              |  4 ++--
 arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
 arch/arm64/kernel/smp.c                   | 28 +++++++++--------------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 9b31e6d0da17..798fd76a883a 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -89,9 +89,9 @@ extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
-extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
+extern void arch_send_wakeup_ipi(int cpu);
 #else
-static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
+static inline void arch_send_wakeup_ipi(int cpu)
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
index 960b98b43506..bfe60adbc453 100644
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
+void arch_send_wakeup_ipi(int cpu)
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

