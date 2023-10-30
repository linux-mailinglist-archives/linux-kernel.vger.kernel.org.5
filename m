Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712197DBD48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjJ3QBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjJ3QBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:01:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96CFEA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0+qFdwwFeIeTDlmcKhFsT4JEWXz4TvtGEXLhaLsK2tQ=; b=O8+03RLdBjmceNy3pKcecsMxdh
        nuBamGXiNJfYrUAT2sPZf1r4gfQo70C3zvjVgfy7HEOtnxYWBu3J9K9s6MR6601fFPXHxgt5MBmcC
        C/GobWvxsjRzx1Kbuh4YAV98Bq6FTYHEwmBDC9XSRPvP7NInllKkt8O53ctaHZ4gWIISe7cU82EJO
        GLIqPqd2xzwMSEPQQ4ka9KUVj9OK7ZtMsNKHA20ljGbza0N1cqBgEchyE5ESEldhuyIxyhZlnbLl4
        VtWayoihUV9Vq+L5oGsZM+O1mRIEKG8abfegKkHx/X4X2lt02Z8+1x5khWvhot/Ddst1SLKDL6DkA
        yqkJs7hQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxUh8-004zQE-Ow; Mon, 30 Oct 2023 16:00:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 435AB300478; Mon, 30 Oct 2023 17:00:50 +0100 (CET)
Date:   Mon, 30 Oct 2023 17:00:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        feng.tang@intel.com
Subject: [PATCH] x86/tsc: Have tsc=recalibrate override things
Message-ID: <20231030160050.GA15024@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My brand-spanking new SPR supermicro workstation was reporting NTP
failures:

Oct 30 13:00:26 spr ntpd[3517]: CLOCK: kernel reports TIME_ERROR: 0x41: Clock Unsynchronized
Oct 30 13:00:58 spr ntpd[3517]: CLOCK: time stepped by 32.316775
Oct 30 13:00:58 spr ntpd[3517]: CLOCK: frequency error 41699 PPM exceeds tolerance 500 PPM

CPUID provides:

    Time Stamp Counter/Core Crystal Clock Information (0x15):
       TSC/clock ratio = 200/2
       nominal core crystal clock = 25000000 Hz
    Processor Frequency Information (0x16):
       Core Base Frequency (MHz) = 0x9c4 (2500)
       Core Maximum Frequency (MHz) = 0x12c0 (4800)
       Bus (Reference) Frequency (MHz) = 0x64 (100)

and the kernel believes this. Since commit a7ec817d5542 ("x86/tsc: Add
option to force frequency recalibration with HW timer") there is the
tsc=recalibrate option, which forces the recalibrate.

This duely reports:

Oct 30 12:42:39 spr kernel: tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
Oct 30 12:42:39 spr kernel: tsc: Previous calibrated TSC freq:         2500.000 MHz
Oct 30 12:42:39 spr kernel: tsc: TSC freq recalibrated by [HPET]:         2399.967 MHz

but then continues running at 2500, offering no solace and keeping NTP
upset -- drifting ~30 seconds for every 15 minutes.

Have tsc=recalibrate override the CPUID provided numbers. This makes the
machine usable and keeps NTP 'happy':

Oct 30 16:48:44 spr ntpd[2200]: CLOCK: time stepped by -0.768679

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/tsc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..ebca304ecea0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1430,14 +1430,13 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 			hpet ? "HPET" : "PM_TIMER",
 			(unsigned long)freq / 1000,
 			(unsigned long)freq % 1000);
+	} else {
 
-		return;
+		/* Make sure we're within 1% */
+		if (abs(tsc_khz - freq) > tsc_khz/100)
+			goto out;
 	}
 
-	/* Make sure we're within 1% */
-	if (abs(tsc_khz - freq) > tsc_khz/100)
-		goto out;
-
 	tsc_khz = freq;
 	pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
 		(unsigned long)tsc_khz / 1000,
@@ -1475,18 +1474,19 @@ static int __init init_tsc_clocksource(void)
 	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
 		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 
-	/*
-	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
-	 * the refined calibration and directly register it as a clocksource.
-	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
-		clocksource_register_khz(&clocksource_tsc, tsc_khz);
-		clocksource_unregister(&clocksource_tsc_early);
 
-		if (!tsc_force_recalibrate)
-			return 0;
+		/*
+		 * When TSC frequency is known (retrieved via MSR or CPUID), we
+		 * skip the refined calibration and directly register it as a
+		 * clocksource.
+		 */
+		if (!tsc_force_recalibrate) {
+			clocksource_register_khz(&clocksource_tsc, tsc_khz);
+			clocksource_unregister(&clocksource_tsc_early);
+		}
 	}
 
 	schedule_delayed_work(&tsc_irqwork, 0);

