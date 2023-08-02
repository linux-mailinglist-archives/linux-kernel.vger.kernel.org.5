Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1721476D7B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjHBT0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHBT0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:26:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF7198B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:26:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26826f93a1fso54717a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691004396; x=1691609196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YoqyI/XiFTcZ0l4BsoYyXnYQUsdBHx0RPZa0K7IP7RE=;
        b=W90c3LYqxCQejsdA13wix+Z+oz5S40cLcWGStf2LcSBINctqmlnIZyC3cbO4UhNa71
         3tQ1HrwRP6T7Lz/CX62MxRRH6wH8ioEtCfKBQ+BJaI9lt/MMCq11lY/e1P/EzpnixuQH
         lsvOUsfS+rX9jCFLHHOa85yCi4OfN63dAzu3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691004396; x=1691609196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YoqyI/XiFTcZ0l4BsoYyXnYQUsdBHx0RPZa0K7IP7RE=;
        b=A4KcJi9xvqcZvFmd+x8rtWFMqJXBVo2FeU9EiZH8leM/vmfuBx3zgQTWKMCfovyTMD
         lZJunSIKa5NwYpOnZeeNjfPmcrL5TglC5EVTMzP+mfgI6c8V/unIRgytMeMkctEgbpEL
         SehP8crHk8iLJ0CXOufK5JRzGvwoyPH6FUA2CQpAfSdJCIDtlf22oOBpssAH+PBZAM1n
         iyh3s8Tn7n+yGlWEOj3LwXBnSOuWWlbZoBR9M0gYWJdrd0ni7P0pz60QRlxVAMTjkJ/J
         v75HAPJy7doWcK2Ifg1R7ShkEXio+iqdK+uimimkSpYOqprOJWCWfPfJC7Gm59XOzPBs
         Vkeg==
X-Gm-Message-State: ABy/qLYIaux4uIzz/954HQzOTxNoxKY37vObrPSsckJS7y+Wp2DNKSBq
        1GVnp7w6e7Bodk+jclknkYbGoA==
X-Google-Smtp-Source: APBJJlF0wsw1TXbRGmlGZ6iSwCmnLk1v+HJSSZBEwc2IyRyuXMOULVj7VHVYDSLlusfxzxCpI3m9lQ==
X-Received: by 2002:a17:90a:5d0c:b0:263:6e10:7cdd with SMTP id s12-20020a17090a5d0c00b002636e107cddmr16745127pji.38.1691004396230;
        Wed, 02 Aug 2023 12:26:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:db33:7523:f391:a4d])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a008800b00268b439a0cbsm1527266pja.23.2023.08.02.12.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:26:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Petr Mladek <pmladek@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog/hardlockup: Avoid large stack frames in watchdog_hardlockup_check()
Date:   Wed,  2 Aug 2023 12:26:00 -0700
Message-ID: <20230802122555.v2.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to
watchdog_hardlockup_check()") we started storing a `struct cpumask` on
the stack in watchdog_hardlockup_check(). On systems with
CONFIG_NR_CPUS set to 8192 this takes up 1K on the stack. That
triggers warnings with `CONFIG_FRAME_WARN` set to 1024.

Instead of putting this `struct cpumask` on the stack, we'll allocate
it on the heap whenever userspace tells us that they want to backtrace
all CPUs upon a hardlockup.

NOTE: the reason that this mask is even needed is to make sure that we
can print the hung CPU first, which makes the logs much easier to
understand.

Fixes: 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to watchdog_hardlockup_check()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202307310955.pLZDhpnl-lkp@intel.com
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Allocate space when userspace requests all cpus be backtraced.

 kernel/watchdog.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index be38276a365f..25d5627a6580 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -93,6 +93,8 @@ static DEFINE_PER_CPU(bool, watchdog_hardlockup_warned);
 static DEFINE_PER_CPU(bool, watchdog_hardlockup_touched);
 static unsigned long watchdog_hardlockup_all_cpu_dumped;
 
+static struct cpumask *hardlockup_backtrace_mask;
+
 notrace void arch_touch_nmi_watchdog(void)
 {
 	/*
@@ -106,6 +108,29 @@ notrace void arch_touch_nmi_watchdog(void)
 }
 EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
+static int hardlockup_all_cpu_backtrace_proc_handler(struct ctl_table *table, int write,
+		  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	/*
+	 * Only allocate memory for the backtrace mask if userspace actually
+	 * wants to trace all CPUs since this can take up 1K of space on a
+	 * system with CONFIG_NR_CPUS=8192.
+	 */
+	if (sysctl_hardlockup_all_cpu_backtrace && !hardlockup_backtrace_mask) {
+		hardlockup_backtrace_mask =
+			   kzalloc(sizeof(*hardlockup_backtrace_mask), GFP_KERNEL);
+	} else if (!sysctl_hardlockup_all_cpu_backtrace && hardlockup_backtrace_mask) {
+		kfree(hardlockup_backtrace_mask);
+		hardlockup_backtrace_mask = NULL;
+	}
+
+	return ret;
+}
+
 void watchdog_hardlockup_touch_cpu(unsigned int cpu)
 {
 	per_cpu(watchdog_hardlockup_touched, cpu) = true;
@@ -151,9 +176,6 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 	 */
 	if (is_hardlockup(cpu)) {
 		unsigned int this_cpu = smp_processor_id();
-		struct cpumask backtrace_mask;
-
-		cpumask_copy(&backtrace_mask, cpu_online_mask);
 
 		/* Only print hardlockups once. */
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
@@ -167,19 +189,20 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 				show_regs(regs);
 			else
 				dump_stack();
-			cpumask_clear_cpu(cpu, &backtrace_mask);
 		} else {
-			if (trigger_single_cpu_backtrace(cpu))
-				cpumask_clear_cpu(cpu, &backtrace_mask);
+			trigger_single_cpu_backtrace(cpu);
 		}
 
 		/*
 		 * Perform multi-CPU dump only once to avoid multiple
 		 * hardlockups generating interleaving traces
 		 */
-		if (sysctl_hardlockup_all_cpu_backtrace &&
-		    !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped))
-			trigger_cpumask_backtrace(&backtrace_mask);
+		if (hardlockup_backtrace_mask &&
+		    !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped)) {
+			cpumask_copy(hardlockup_backtrace_mask, cpu_online_mask);
+			cpumask_clear_cpu(cpu, hardlockup_backtrace_mask);
+			trigger_cpumask_backtrace(hardlockup_backtrace_mask);
+		}
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
@@ -192,6 +215,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 
 #else /* CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER */
 
+#define hardlockup_all_cpu_backtrace_proc_handler proc_dointvec_minmax
 static inline void watchdog_hardlockup_kick(void) { }
 
 #endif /* !CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER */
@@ -916,7 +940,7 @@ static struct ctl_table watchdog_sysctls[] = {
 		.data		= &sysctl_hardlockup_all_cpu_backtrace,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= hardlockup_all_cpu_backtrace_proc_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-- 
2.41.0.585.gd2178a4bd4-goog

