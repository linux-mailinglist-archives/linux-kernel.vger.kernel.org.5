Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D527725E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjHGNfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjHGNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:35:33 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE6A9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1691415332;
  x=1722951332;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=YHNEaDy2r6kxnZWFMLyhqsXhrsplDLTKyk6Oya5XTzI=;
  b=hJj3MLru47bsKCl8nFlJXqITtFQU+hpEh9Y8q7gmNQqeJP8cJnryfMrO
   GAmmDhDYKQstITguGK4nOhFFWOcAAri8AELxFG2Etn7NQysgKoQXs2VCm
   whNN6fJ9I3Tw2XvwtcDD30r29PABUIGfFlwi+NUpI58hIvcXi3B7p0qoN
   +yD/zHrNBA3afMG1hoLgbhqoUtBUEefp8nqFm+8Dhi0sujsGHKV3eV5tp
   bcM3cUYWJ1/DcEc+CWhXGnmL8ZgI8yp/JEMmym9NHHNqUzvGbn2bu584R
   Dof6cr1Y76cRdkwNAXBBJImStRtwz1tHyOcpUibViVoaWvYbTgAY3eODv
   A==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Mon, 7 Aug 2023 15:34:50 +0200
Subject: [PATCH v2] ARM: kexec: Make smp stop calls asynchronous
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230807-arm-smp-call-async-v2-1-ce2307dd528c@axis.com>
X-B4-Tracking: v=1; b=H4sIAPny0GQC/22NQQ6CMBBFr0K6dkxbAdGV9zAshjKVJrSQDiEQw
 t0tuHX5/s/L2wRTdMTimW0i0uzYDSGBvmTCdBg+BK5NLLTUN1nJO2D0wH4Eg30PyGswkBvVom7
 pUWolktggEzQRg+kO1SNPFI9jjGTdctbedeLO8TTE9YzP6lh/nVIV/zqzAgVFZXO0jZZW2hcuj
 q9m8KLe9/0LvsqOR8wAAAA=
To:     Russell King <linux@armlinux.org.uk>
CC:     Baoquan He <bhe@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691415329; l=2394;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=I5pU/e9Qq+g1cUnHBmdzxZ7d0mwn3mejD1Eb5k4FO5c=;
 b=kPnl+cpPkI6RIPl2SutToGYsPbnY+LdNDSlSDe59MMHgRKqzdhAOTUnlHTnn3FIjqu7i4cC0b
 01gkSNJL2irBsSCbikg0bBN/iYQKGxEyyjaQGCI3sbbvyVgd/vLz8np
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changes in v2:
- Fixed commit msg typo "noitfied" => "notified"
- Link to v1: https://lore.kernel.org/r/20230615-arm-smp-call-async-v1-1-58f4afb20f0f@axis.com
---
 arch/arm/kernel/machine_kexec.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 46364b699cc3..5d07cf9e0044 100644
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

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230807-arm-smp-call-async-4c1da2de9621

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>

