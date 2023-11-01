Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C237DE59C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbjKARuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjKARux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:50:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1538EA2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VQU/ph1sN3uqpoValzEQw01xluy/sVRwBxsE8vbGC3s=; b=XaSQupFrL5k0GrLxoEnBk/JVX+
        jMaCk/JoBb8mGromBN9h2QqtaptZU/4SUM5BL9ou66lJqLXhfGNqx2mOd24bjT0TvCDDOUacV5rTM
        oKdT2UZcN2wPphVaBMUmHvl3cBzDRi5RDX6dsU6Oo+vEgp/HKe57RX53wjvFWPjQLWyBQDcmpq41n
        r8eJxoxevZVh+3zvtM/oYvZqNaGauxTLwI8xU0wotKChegXY/Lykanl3GRTcungM971SSM6DirRyY
        d6TXrO1YJ9IU+s2NrjRy9/Rw3qrTvY5TMkcHH6tPPKCxODFDwUuxU1h4KxtvlbpdY0vW5J3PnSJhK
        PHFpckvw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyFMS-005rQH-3D;
        Wed, 01 Nov 2023 17:50:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5D2C3002AF; Wed,  1 Nov 2023 18:50:36 +0100 (CET)
Date:   Wed, 1 Nov 2023 18:50:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        feng.tang@intel.com
Subject: Re: [PATCH v2] x86/tsc: Have tsc=recalibrate override things
Message-ID: <20231101175036.GA30898@noisy.programming.kicks-ass.net>
References: <20231030160050.GA15024@noisy.programming.kicks-ass.net>
 <20231101111621.GC19106@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101111621.GC19106@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 12:16:21PM +0100, Peter Zijlstra wrote:
> Subject: x86/tsc: Have tsc=recalibrate override things
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon, 30 Oct 2023 17:00:50 +0100
> 
> My brand-spanking new SPR supermicro workstation was reporting NTP
> failures:
> 
> Oct 30 13:00:26 spr ntpd[3517]: CLOCK: kernel reports TIME_ERROR: 0x41: Clock Unsynchronized
> Oct 30 13:00:58 spr ntpd[3517]: CLOCK: time stepped by 32.316775
> Oct 30 13:00:58 spr ntpd[3517]: CLOCK: frequency error 41699 PPM exceeds tolerance 500 PPM
> 
> CPUID provides:
> 
>     Time Stamp Counter/Core Crystal Clock Information (0x15):
>        TSC/clock ratio = 200/2
>        nominal core crystal clock = 25000000 Hz
>     Processor Frequency Information (0x16):
>        Core Base Frequency (MHz) = 0x9c4 (2500)
>        Core Maximum Frequency (MHz) = 0x12c0 (4800)
>        Bus (Reference) Frequency (MHz) = 0x64 (100)
> 
> and the kernel believes this. Since commit a7ec817d5542 ("x86/tsc: Add
> option to force frequency recalibration with HW timer") there is the
> tsc=recalibrate option, which forces the recalibrate.
> 
> This duely reports:
> 
> Oct 30 12:42:39 spr kernel: tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> Oct 30 12:42:39 spr kernel: tsc: Previous calibrated TSC freq:         2500.000 MHz
> Oct 30 12:42:39 spr kernel: tsc: TSC freq recalibrated by [HPET]:         2399.967 MHz

Additionally, we could consider something like the below. This makes the
machine print:

[    0.000000] DMI: Supermicro SYS-531A-I/X13SRA-TF, BIOS 1.1b 08/01/2023
[    0.000000] tsc: [Firmware Bug]: DMI based CPUID-15h crystal frequency override: 24000000

This way I can boot without additional parameters.

---
Index: linux-2.6/arch/x86/kernel/tsc.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/tsc.c
+++ linux-2.6/arch/x86/kernel/tsc.c
@@ -15,6 +15,7 @@
 #include <linux/timex.h>
 #include <linux/static_key.h>
 #include <linux/static_call.h>
+#include <linux/dmi.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
@@ -651,6 +652,35 @@ success:
 	return delta;
 }
 
+static unsigned long dmi_crystal_hz;
+
+static int dmi_crystal_hz_override(const struct dmi_system_id *d)
+{
+	if (dmi_crystal_hz != (unsigned long)d->driver_data) {
+		dmi_crystal_hz = (unsigned long)d->driver_data;
+		pr_err(FW_BUG "DMI based CPUID-15h crystal frequency override: %lu\n",
+				dmi_crystal_hz);
+	}
+	return 1;
+}
+
+/*
+ * List of systems that managed to screw up CPUID-15h :-(
+ */
+static const struct dmi_system_id tsc_dmi_table[] = {
+	{
+		.callback = dmi_crystal_hz_override,
+		.ident = "Supermicro X13SRA-TF",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Supermicro"),
+			DMI_MATCH(DMI_BOARD_NAME, "X13SRA-TF"),
+		},
+		/* The board advertises a 25MHz crystal, in reality it has 24MHz */
+		.driver_data = (void *)24000000UL,
+	},
+	{}
+};
+
 /**
  * native_calibrate_tsc
  * Determine TSC frequency via CPUID, else return 0.
@@ -671,6 +701,10 @@ unsigned long native_calibrate_tsc(void)
 	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
 	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
 
+	dmi_crystal_hz = ecx_hz;
+	if (ecx_hz && dmi_check_system(tsc_dmi_table))
+		ecx_hz = dmi_crystal_hz;
+
 	if (ebx_numerator == 0 || eax_denominator == 0)
 		return 0;
 
