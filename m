Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0376794125
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbjIFQGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242660AbjIFQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:06:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99091994
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:06:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0d5b16aacso26276075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694016377; x=1694621177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lfr/P8kWWmXIp7IhRx//NCB6T5i3PT6aneosjdAWJJE=;
        b=XgrnGzJzQle9Xmpd3kosxfg7/52TbtNrTBi7ejMp+Tk0tO/Y8y1HvuWdCUhf9mu0xs
         +uFHhcyfKA/qnqo3CJRbhULf5A9JkVXfhzeCRB61VSxD+Jq+azPbKx6Cz3kzPCNr9J85
         aih3qeUyEXWiYyg1B/w4XMeU1/jMGIhu4DHnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694016377; x=1694621177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lfr/P8kWWmXIp7IhRx//NCB6T5i3PT6aneosjdAWJJE=;
        b=CgvHLGp9/YQeEO2jf11Py8Kpcd6BN6ysP3DNeg8EqJ4xJrXUFsa/s/hL8PXKvojUrO
         TZm5JMSQ1v3gsDbSJGg8VK04wtvcw9A+f0SCY3P1RKT6dmVnG466hJx06TIKLNW8RxUc
         pDFFOF83Km34xbBhFzOuDMEt8fs1IAe+bGR0IYal+KhSaWQ8IXGiORb1v+A6ciQ8EuJd
         Bgw3+9mi/jKsSSe9UsCk/Q1pkQrP2kqphqA1Z0xRrkh8yx6RgGW+t2t740zSOmCwhWcL
         abhmLys2Ts2u8vRWxMTKsGnbDGUJj1gQvQtKR6lst3anxU3kAjQ+4A9BG4tYy9vzQXkT
         YCfw==
X-Gm-Message-State: AOJu0YzZVERjKF3LpXScZyI1drJ/TWQN4utvFU5Fwk0xLWQHJvyPyZvg
        9H9JHVQk6lOHLPkaYhEyk+3jMQ==
X-Google-Smtp-Source: AGHT+IG+Oj3GH6FuXei+71b7K8aA0VmHKNiHpdBjrZsaPyOrc2TSYGU8tqH4LOs9XgNI+1+Ma548aA==
X-Received: by 2002:a17:902:c40a:b0:1c2:811:2cee with SMTP id k10-20020a170902c40a00b001c208112ceemr18485781plk.23.1694016377111;
        Wed, 06 Sep 2023 09:06:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4a07:e00a:fdae:750b])
        by smtp.gmail.com with ESMTPSA id ju19-20020a170903429300b001b8c689060dsm11338859plb.28.2023.09.06.09.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:06:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephen Boyd <swboyd@chromium.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, ito-yuichi@fujitsu.com,
        Douglas Anderson <dianders@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, scott@os.amperecomputing.com,
        vschneid@redhat.com
Subject: [PATCH v13 6/7] arm64: kgdb: Implement kgdb_roundup_cpus() to enable pseudo-NMI roundup
Date:   Wed,  6 Sep 2023 09:03:01 -0700
Message-ID: <20230906090246.v13.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906160505.2431857-1-dianders@chromium.org>
References: <20230906160505.2431857-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v10)

Changes in v10:
- Don't allocate the cpumask on the stack; just iterate.
- Moved kgdb calls to smp.c to avoid needing to export IPI info.
- kgdb now has its own IPI.

Changes in v9:
- Remove fallback for when debug IPI isn't available.
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.

 arch/arm64/kernel/smp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 800c59cf9b64..1a53e57c81d0 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -32,6 +32,7 @@
 #include <linux/irq_work.h>
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
+#include <linux/kgdb.h>
 #include <linux/kvm_host.h>
 #include <linux/nmi.h>
 
@@ -79,6 +80,7 @@ enum ipi_msg_type {
 	 * with trace_ipi_*
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
2.42.0.283.g2d96d420d3-goog

