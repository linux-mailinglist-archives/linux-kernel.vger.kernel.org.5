Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E157E811040
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjLMLg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjLMLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:36:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E52619A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:35:31 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4448F1F387;
        Wed, 13 Dec 2023 11:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702467329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=8s0UEn0utDfOfGT2n1kJYZoZu32ok02jwJHTlYuWSTg=;
        b=ieYYnIdVOi0vKYzDyKr2q8d3Ajocf/zBwddOqHOZZytFO57qo2/m/Iu6sox/pQys01wUEf
        Hj2S7v7UaPZDzURig9nc1N5Zy8f4vCzMMHoPTVvxKNYGJSUYcVCTQXT89ZnaQ/EutLwjI1
        fc3WGH0dqxRTclRP0d1vkTaOmwpOd/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702467329;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=8s0UEn0utDfOfGT2n1kJYZoZu32ok02jwJHTlYuWSTg=;
        b=f2Au5JGXIgqU7TrWRzaoojYivUuUcZRH1HYmDpezR1BdSRyyFw2rkKQe0Tq5j6MYcAw7CA
        Zr3PdHt+x3ywE+Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702467329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=8s0UEn0utDfOfGT2n1kJYZoZu32ok02jwJHTlYuWSTg=;
        b=ieYYnIdVOi0vKYzDyKr2q8d3Ajocf/zBwddOqHOZZytFO57qo2/m/Iu6sox/pQys01wUEf
        Hj2S7v7UaPZDzURig9nc1N5Zy8f4vCzMMHoPTVvxKNYGJSUYcVCTQXT89ZnaQ/EutLwjI1
        fc3WGH0dqxRTclRP0d1vkTaOmwpOd/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702467329;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=8s0UEn0utDfOfGT2n1kJYZoZu32ok02jwJHTlYuWSTg=;
        b=f2Au5JGXIgqU7TrWRzaoojYivUuUcZRH1HYmDpezR1BdSRyyFw2rkKQe0Tq5j6MYcAw7CA
        Zr3PdHt+x3ywE+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 299001377F;
        Wed, 13 Dec 2023 11:35:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id ld0fCgGXeWVuawAAD6G6ig
        (envelope-from <jwiesner@suse.de>); Wed, 13 Dec 2023 11:35:29 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 67E83983C3; Wed, 13 Dec 2023 12:35:28 +0100 (CET)
Date:   Wed, 13 Dec 2023 12:35:28 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, feng.tang@intel.com
Subject: [PATCH] clocksource: disable watchdog checks on TSC when TSC is
 watchdog
Message-ID: <20231213113528.GA17874@incl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: ****
X-Spam-Score: 4.29
X-Spam-Level: 
X-Rspamd-Queue-Id: 4448F1F387
X-Rspamd-Server: rspamd1
X-Spam-Score: -13.81
X-Spamd-Result: default: False [-13.81 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DWL_DNSWL_HI(-3.50)[suse.de:dkim];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         DKIM_TRACE(0.00)[suse.de:+];
         DMARC_POLICY_ALLOW(0.00)[suse.de,none];
         RCPT_COUNT_SEVEN(0.00)[11];
         WHITELIST_DMARC(-7.00)[suse.de:D:+];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
         DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
         MX_GOOD(-0.01)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
        dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ieYYnIdV;
        dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f2Au5JGX;
        dmarc=pass (policy=none) header.from=suse.de;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of jwiesner@suse.de) smtp.mailfrom=jwiesner@suse.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Production systems may repeatedly experience a switch to the HPET
clocksource on account of the watchdog marking the TSC as unstable. The
HPET is a slow clocksource that is not checked by the clocksource
watchdog, which in itself seems inconsistent - the TSC is fast but may
fail a watchdog check, the HPET is slow, bordering on useless on modern
machines, and systems are practically stuck with it (or acpi_pm) once the
TSC has been marked unstable. A switch to the HPET clocksource may result
in a large performance regression (of up to 90% for networking workloads,
for example), which may not be acceptable for production workloads.
Performance is restored only by a reboot that allows the TSC to become the
current clocksource again. Reoccurring and forced reboots are unwelcome on
production systems. The switches to the HPET may have their root cause in
the way the hardware works. Solving a hardware issue or replacing the
machine may take an inordinate amount of time, while the production
machine is still needed to do its job.

There are machines that experience switches to the HPET but also are known
to have handled their workload without any apparent issues before the
threshold for the watchdog got reduced in 2e27e793e280 ("clocksource:
Reduce clocksource-skew threshold"). The value
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US option can be increased to widen
the margin of error for evaluating time skews but a change like this would
be applied to all systems running a particular distribution kernel, which
is not desirable. It is almost a rule that no matter the threhold there
will be a system exceeding that threshold. So, a workaround is need for
special cases where the measured time skew exceeds the margin of error.

It is possible to pass tsc=nowatchdog to the kernel, which disables the
clocksource watchdog on the TSC, effectively leaving the operator of the
production machine blind to any clocksource malfunction. Also, the
tsc=nowatchdog parameter is intended for situations with tight latency
requirements and not for working around repeated switches to the HPET. For
machines with more than 4 NUMA nodes, the current state of the TSC code
does allow tsc=reliable tsc=watchdog to be passed to the kernel to disable
the clocksource watchdog on the TSC while allowing the TSC to act as a
watchdog but the tsc=reliable parameter also disables TSC warp detection
and the tsc_sync_check_timer even on machines with the TSC_ADJUST feature,
which is unnecessary and possibly harmful.

The sematics of the recently introduced tsc=watchdog, 0051293c5330
("clocksource: Enable TSC watchdog checking of HPET and PMTMR only when
requested"), could be changed to disable the clocksource watchdog on the
TSC no matter the number of NUMA nodes while allowing the TSC to act as a
watchdog for other clocksources. This way, a watchdog check failing would
not result in the current clocksource (TSC) getting marked unstable and
the operator would still be informed that the machine may be experiencing
a clocksource issue. Passing tsc=watchdog to the kernel could be used as a
workaround before the underlying hardware issue is resolved or as a
permanent solution with the understanding that only a warning will be
printed into the kernel log but no action will be taken if the TSC
actually becomes unstable.

There is one side effect of the sematic change of tsc=watchdog - it fixes
the HPET not having its CLOCK_SOURCE_MUST_VERIFY bit set as intended by
efc8b329c7fd ("clocksource: Verify HPET and PMTMR when TSC unverified").
The HPET never had its CLOCK_SOURCE_MUST_VERIFY bit set on account of the
order in which clocksources are initialized in x86_late_time_init(). The
HPET initialization and clocksource registration always comes before the
TSC init function unsets the CLOCK_SOURCE_MUST_VERIFY bit.

Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
 arch/x86/include/asm/time.h                     | 2 +-
 arch/x86/kernel/hpet.c                          | 2 +-
 arch/x86/kernel/tsc.c                           | 7 +++----
 drivers/clocksource/acpi_pm.c                   | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..665a4df9a511 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6695,10 +6695,11 @@
 			obtained from HW or FW using either an MSR or CPUID(0x15).
 			Warn if the difference is more than 500 ppm.
 			[x86] watchdog: Use TSC as the watchdog clocksource with
-			which to check other HW timers (HPET or PM timer), but
-			only on systems where TSC has been deemed trustworthy.
-			This will be suppressed by an earlier tsc=nowatchdog and
-			can be overridden by a later tsc=nowatchdog.  A console
+			which to check other HW timers (HPET or PM timer).
+			Disables watchdog checks on TSC, even on systems where
+			TSC has not been deemed trustworthy. This will be
+			suppressed by an earlier tsc=nowatchdog and can be
+			overridden by a later tsc=nowatchdog. A console
 			message will flag any such suppression or overriding.
 
 	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
index f360104ed172..c2364b74a318 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -7,7 +7,7 @@
 
 extern void hpet_time_init(void);
 extern bool pit_timer_init(void);
-extern bool tsc_clocksource_watchdog_disabled(void);
+extern bool tsc_clocksource_as_watchdog(void);
 
 extern struct clock_event_device *global_clock_event;
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 41eecf180b7f..9f6222cea684 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1091,7 +1091,7 @@ int __init hpet_enable(void)
 	if (!hpet_counting())
 		goto out_nohpet;
 
-	if (tsc_clocksource_watchdog_disabled())
+	if (tsc_clocksource_as_watchdog())
 		clocksource_hpet.flags |= CLOCK_SOURCE_MUST_VERIFY;
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..ec1860178ea1 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1221,10 +1221,9 @@ static void __init tsc_disable_clocksource_watchdog(void)
 	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 }
 
-bool tsc_clocksource_watchdog_disabled(void)
+bool tsc_clocksource_as_watchdog(void)
 {
-	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY) &&
-	       tsc_as_watchdog && !no_tsc_watchdog;
+	return tsc_as_watchdog && !no_tsc_watchdog;
 }
 
 static void __init check_system_tsc_reliable(void)
@@ -1609,7 +1608,7 @@ void __init tsc_init(void)
 		return;
 	}
 
-	if (tsc_clocksource_reliable || no_tsc_watchdog)
+	if (tsc_clocksource_reliable || no_tsc_watchdog || tsc_as_watchdog)
 		tsc_disable_clocksource_watchdog();
 
 	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 82338773602c..9b5dad94713e 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -211,7 +211,7 @@ static int __init init_acpi_pm_clocksource(void)
 		return -ENODEV;
 	}
 
-	if (tsc_clocksource_watchdog_disabled())
+	if (tsc_clocksource_as_watchdog())
 		clocksource_acpi_pm.flags |= CLOCK_SOURCE_MUST_VERIFY;
 	return clocksource_register_hz(&clocksource_acpi_pm, PMTMR_TICKS_PER_SEC);
 }
-- 
2.35.3


-- 
Jiri Wiesner
SUSE Labs
