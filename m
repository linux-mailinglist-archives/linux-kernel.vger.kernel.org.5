Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF0179935E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbjIIAYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343854AbjIIAYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:24:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FCC26B0;
        Fri,  8 Sep 2023 17:24:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADC0C433CA;
        Sat,  9 Sep 2023 00:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694218973;
        bh=fdHvbgwWgP/EMGj/RzIWLuGXd8eizNOtytTbA7I4uT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5EsHUb9GTtranFlWFnWBcVNoWqh35qKwTh2vWFquGFh3Nxwefhz8QzZCqUhzSxI7
         EqCvSvupAQNXnyLvVW1nDglrlQSKcI+1Dr+8oCr0I0pnjZQgvwncMJu7rfuPVPhL7R
         NvDrmkPLBZ580hdbyRNZcfYZj27NaewDVHDcLM8TfFdjaJZw4HH4MrxSLSOcQW8hN2
         aZVZSjzjP8f5ODp4khyUrmcM1AgAwrnf/c9WfpCKU5thnkA8Hj/Gpl7PY69MWc6wIl
         n6vs9wVz1AUrHdUz44S5CFQQAoBoLHh8wRSL8F/TkcaE2xgGNqXQlt4/CmXxib9tRX
         v4Y6CP77C84kw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>, linux@armlinux.org.uk,
        bhe@redhat.com, gpiccoli@igalia.com, akpm@linux-foundation.org,
        chenlifu@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 08/11] ARM: 9317/1: kexec: Make smp stop calls asynchronous
Date:   Fri,  8 Sep 2023 20:22:28 -0400
Message-Id: <20230909002233.3578213-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002233.3578213-1-sashal@kernel.org>
References: <20230909002233.3578213-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mårten Lindahl <marten.lindahl@axis.com>

[ Upstream commit 8922ba71c969d2a0c01a94372a71477d879470de ]

If a panic is triggered by a hrtimer interrupt all online cpus will be
notified and set offline. But as highlighted by commit 19dbdcb8039c
("smp: Warn on function calls from softirq context") this call should
not be made synchronous with disabled interrupts:

 softdog: Initiating panic
 Kernel panic - not syncing: Software Watchdog Timer expired
 WARNING: CPU: 1 PID: 0 at kernel/smp.c:753 smp_call_function_many_cond
   unwind_backtrace:
     show_stack
     dump_stack_lvl
     __warn
     warn_slowpath_fmt
     smp_call_function_many_cond
     smp_call_function
     crash_smp_send_stop.part.0
     machine_crash_shutdown
     __crash_kexec
     panic
     softdog_fire
     __hrtimer_run_queues
     hrtimer_interrupt

Make the smp call for machine_crash_nonpanic_core() asynchronous.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/machine_kexec.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 46364b699cc30..5d07cf9e0044d 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -94,16 +94,28 @@ static void machine_crash_nonpanic_core(void *unused)
 	}
 }
 
+static DEFINE_PER_CPU(call_single_data_t, cpu_stop_csd) =
+	CSD_INIT(machine_crash_nonpanic_core, NULL);
+
 void crash_smp_send_stop(void)
 {
 	static int cpus_stopped;
 	unsigned long msecs;
+	call_single_data_t *csd;
+	int cpu, this_cpu = raw_smp_processor_id();
 
 	if (cpus_stopped)
 		return;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
+	for_each_online_cpu(cpu) {
+		if (cpu == this_cpu)
+			continue;
+
+		csd = &per_cpu(cpu_stop_csd, cpu);
+		smp_call_function_single_async(cpu, csd);
+	}
+
 	msecs = 1000; /* Wait at most a second for the other cpus to stop */
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
 		mdelay(1);
-- 
2.40.1

