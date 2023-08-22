Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52D784C11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjHVVbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjHVVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:31:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E54CFC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:30:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf7423ef3eso19276815ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692739857; x=1693344657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5gCGegQW5oGbMQ/BTeF2BnmDhxlWa9PqRY9ItnmdA4=;
        b=i2j2emfnK5XP7t+5MPqLiRHwEldyIx58mwxs8qZCGbml5ejZ6JH7+3EA7zApwPx7Xp
         DKzJZt+j4/BQ260X/yfDtcOiRK549Q7XtaY8dwyRKZzevzWXRbEs0+J82fq0ifmhegao
         Q+N6UM9e5wW7FSXIc832M2QlxQB51Qtz5z/vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739857; x=1693344657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5gCGegQW5oGbMQ/BTeF2BnmDhxlWa9PqRY9ItnmdA4=;
        b=kCwtKaoqvxqXDNjkad1Vn35oQFQQIauH/v+Cq2RbY0QlOR6k0O8PnqOLHf2kL02Cyc
         MucqC2o5iMvp/myMWujWwLDxlnByrJWI8rioVjEGsa18rOjyfEeFvu5bWDWElKmk6I1e
         paFYenBsjC2OdcozdZLqqlCJltqO/fM3bs2A+2AkcPBthntK7dk2wRaKcVzNEQnwFumH
         biScpFaLN8crrNOzsWiEzU3+cTDyEa1+++JrCfjn5gJ7VoLhb1IJCzaLLQNy1WLQ0gwF
         83ieY3/XdHQU4zsDs1I3kiDf6ONrO3AnzRBk/XM9dDO+ohnYL9Bq01HdT6Jhu6QGm3lj
         SFOw==
X-Gm-Message-State: AOJu0Yx6DKB/Qjh9oIJ0f56JdlBTNF5eZXpmiYgJzqniEKAxhadDy5G+
        xkcsrjwh1IObiBqhOAjMDq0v9g==
X-Google-Smtp-Source: AGHT+IHzEMJvwLDxrbrpnP1PL0V1S39JCggLWYRvJ4nQH33U88JSDAsszYF9eNIHgI3tAnb1soYQPw==
X-Received: by 2002:a17:903:41cc:b0:1af:aafb:64c8 with SMTP id u12-20020a17090341cc00b001afaafb64c8mr8892237ple.21.1692739857271;
        Tue, 22 Aug 2023 14:30:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:83f0:2bc5:38c4:a9de])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b001befac3b3cbsm9451475plg.290.2023.08.22.14.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:30:56 -0700 (PDT)
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
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 6/6] arm64: kgdb: Implement kgdb_roundup_cpus() to enable pseudo-NMI roundup
Date:   Tue, 22 Aug 2023 14:27:01 -0700
Message-ID: <20230822142644.v10.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
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

Up until now we've been using the generic (weak) implementation for
kgdb_roundup_cpus() when using kgdb on arm64. Let's move to a custom
one. The advantage here is that, when pseudo-NMI is enabled on a
device, we'll be able to round up CPUs using pseudo-NMI. This allows
us to debug CPUs that are stuck with interrupts disabled. If
pseudo-NMIs are not enabled then we'll fallback to just using an IPI,
which is still slightly better than the generic implementation since
it avoids the potential situation described in the generic
kgdb_call_nmi_hook().

Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I debated whether this should be in "arch/arm64/kernel/smp.c" or if I
should try to find a way for it to go into "arch/arm64/kernel/kgdb.c".
In the end this is so little code that it didn't seem worth it to find
a way to export the IPI defines or to otherwise come up with some API
between kgdb.c and smp.c. If someone has strong feelings and wants
this to change, please shout and give details of your preferred
solution.

FWIW, it seems like ~half the other platforms put this in "smp.c" with
an ifdef for KGDB and the other half put it in "kgdb.c" with an ifdef
for SMP. :-P

Changes in v10:
- Don't allocate the cpumask on the stack; just iterate.
- Moved kgdb calls to smp.c to avoid needing to export IPI info.
- kgdb now has its own IPI.

Changes in v9:
- Remove fallback for when debug IPI isn't available.
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.

 arch/arm64/kernel/smp.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index c51d54019f5f..5ee6b69b4360 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -32,6 +32,7 @@
 #include <linux/irq_work.h>
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
+#include <linux/kgdb.h>
 #include <linux/kvm_host.h>
 #include <linux/nmi.h>
 
@@ -75,10 +76,11 @@ enum ipi_msg_type {
 	IPI_IRQ_WORK,
 	NR_IPI,
 	/*
-	 * CPU_BACKTRACE is special and not included in NR_IPI
+	 * CPU_BACKTRACE and KGDB_ROUNDUP are special and not included in NR_IPI
 	 * or tracable with trace_ipi_*
 	 */
 	IPI_CPU_BACKTRACE = NR_IPI,
+	IPI_KGDB_ROUNDUP,
 	MAX_IPI
 };
 
@@ -868,6 +870,22 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
 }
 
+#ifdef CONFIG_KGDB
+void kgdb_roundup_cpus(void)
+{
+	int this_cpu = raw_smp_processor_id();
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		/* No need to roundup ourselves */
+		if (cpu == this_cpu)
+			continue;
+
+		__ipi_send_single(ipi_desc[IPI_KGDB_ROUNDUP], cpu);
+	}
+}
+#endif
+
 /*
  * Main handler for inter-processor interrupts
  */
@@ -919,6 +937,10 @@ static void do_handle_IPI(int ipinr)
 		nmi_cpu_backtrace(get_irq_regs());
 		break;
 
+	case IPI_KGDB_ROUNDUP:
+		kgdb_nmicallback(cpu, get_irq_regs());
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -949,6 +971,7 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 	case IPI_CPU_STOP:
 	case IPI_CPU_CRASH_STOP:
 	case IPI_CPU_BACKTRACE:
+	case IPI_KGDB_ROUNDUP:
 		return true;
 	default:
 		return false;
-- 
2.42.0.rc1.204.g551eb34607-goog

