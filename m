Return-Path: <linux-kernel+bounces-33660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCCB836CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC271C213CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A4965BB8;
	Mon, 22 Jan 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gUuhI4jp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DBxCPPhD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gUuhI4jp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DBxCPPhD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A065BB2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939690; cv=none; b=hMBa155Ys8oEHZMZT8bKNdZNV+I1Z6qv4BJkamhvI8aLcUfr4N/L9wYtMSsWBmAb71y32VnvQP4t8u3GAMq5dT+nx6Gp5GGASp3fJ+f3xduYi5uyjXKa1Z7X+ERdA52jbMgm2ZA8NoYSvyIYvTriRp9RX49vPI1Ya+72LGCAx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939690; c=relaxed/simple;
	bh=uYlw100VVlrQIEYrMbIEpSPuGQhW9SQObJGbsRgx+FE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NY3WqYrVxMKcbraE1ls+vouHAim08yJVHrn43EJB4BPZW48Zx93QBr2QuxjSERrJ8JEhP0z6rtLRsQsBDCBGxBMI5rC1s0MK2p/leilBZ4GjRqMjkqj7Nng0T+e6VtjaIHKLXxVQBieCmxQW2p6g2pSHKw8DdHRKN7lRI5OnMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gUuhI4jp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DBxCPPhD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gUuhI4jp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DBxCPPhD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94A671FC11;
	Mon, 22 Jan 2024 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705939683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=460U9Izgj7CrTJya2LYPirKTait4awUVIieuFaCP3d8=;
	b=gUuhI4jpz+Dr1jivwSk2VKwaMznOZBsMVCl11VawcBaOwW5bjvwfVkUl1Jo1H4FydOY01B
	fnRsRmKsci39yf3SteORV4rLayr7whoc0fG1PHsQ1X42J6sL4RvPSbxKvaufnL/GiOHC1L
	qIwXCbdL/7mMSlgJwy4WS4BNrR97+ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705939683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=460U9Izgj7CrTJya2LYPirKTait4awUVIieuFaCP3d8=;
	b=DBxCPPhD4DILBDmi1f9RMM9sMxgtMcQWmr1aB6umFB/ivvxcHnVzKsTp9pd1p1r7itusZI
	7Vwv8BKhwOQpdaCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705939683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=460U9Izgj7CrTJya2LYPirKTait4awUVIieuFaCP3d8=;
	b=gUuhI4jpz+Dr1jivwSk2VKwaMznOZBsMVCl11VawcBaOwW5bjvwfVkUl1Jo1H4FydOY01B
	fnRsRmKsci39yf3SteORV4rLayr7whoc0fG1PHsQ1X42J6sL4RvPSbxKvaufnL/GiOHC1L
	qIwXCbdL/7mMSlgJwy4WS4BNrR97+ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705939683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=460U9Izgj7CrTJya2LYPirKTait4awUVIieuFaCP3d8=;
	b=DBxCPPhD4DILBDmi1f9RMM9sMxgtMcQWmr1aB6umFB/ivvxcHnVzKsTp9pd1p1r7itusZI
	7Vwv8BKhwOQpdaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74B2D13995;
	Mon, 22 Jan 2024 16:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MjJ5HOOSrmWydgAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Mon, 22 Jan 2024 16:08:03 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id CE27B9C7DD; Mon, 22 Jan 2024 17:07:58 +0100 (CET)
Date: Mon, 22 Jan 2024 17:07:58 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] clocksource: disable watchdog checks on TSC when TSC is
 watchdog
Message-ID: <20240122160758.GA30919@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

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
I am resubmitting this patch because there has been no reaction to it.
I sent it over the Christmas period. Perhaps, it got forgotten.

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

