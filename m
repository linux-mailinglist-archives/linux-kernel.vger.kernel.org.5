Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26A7DE036
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjKALQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKALQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:16:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FCEF7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zSh13B1ZZlhI2RrNckeOHFhnIe/fCZORE5Av6JJudls=; b=RONL5jvbv9t8WJohNIHc5jI0nG
        gl+wlFbu1+NtVPYCnZCmPwnto1RKN9oaAx5jlFC0pN7SoobS+JHPDJh+ULYoNOifQpiHjMT+zuWEi
        f7+LHJJmuXBXGlGWifK6z7jeUSTfeQe7c1Xp8R85WvigUBcwN+CitLRXDKsAOWVszcoPVOA4o9q4q
        Z8vP7A0g3gcSBy+CD4mWI94wd8pPHvZwFLMTv7ncLexZSOxNKkMLj5dou1MYl6RvEaeqOg4neAMXz
        vQXRPVYrN/fFRFwjEZmzG78KlkHrLmqDYVbocvbGq3x1hZeYQmF2f/lGE45HgaIDaeJpyIV324FL6
        NzSMyskA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qy9Cv-005fUV-1I;
        Wed, 01 Nov 2023 11:16:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 108F23002AF; Wed,  1 Nov 2023 12:16:21 +0100 (CET)
Date:   Wed, 1 Nov 2023 12:16:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        feng.tang@intel.com
Subject: [PATCH v2] x86/tsc: Have tsc=recalibrate override things
Message-ID: <20231101111621.GC19106@noisy.programming.kicks-ass.net>
References: <20231030160050.GA15024@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030160050.GA15024@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: x86/tsc: Have tsc=recalibrate override things
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 30 Oct 2023 17:00:50 +0100

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
 arch/x86/kernel/tsc.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1430,14 +1430,13 @@ static void tsc_refine_calibration_work(
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
@@ -1479,14 +1478,12 @@ static int __init init_tsc_clocksource(v
 	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
 	 * the refined calibration and directly register it as a clocksource.
 	 */
-	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
+	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ) && !tsc_force_recalibrate) {
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
-
-		if (!tsc_force_recalibrate)
-			return 0;
+		return 0;
 	}
 
 	schedule_delayed_work(&tsc_irqwork, 0);
