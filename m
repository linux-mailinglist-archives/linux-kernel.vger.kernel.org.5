Return-Path: <linux-kernel+bounces-37201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ADD83AC81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381B029C2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CB781ABA;
	Wed, 24 Jan 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qhX3uEJK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NvH05ak7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qhX3uEJK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NvH05ak7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E27CF13
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107586; cv=none; b=gxCP5qyoFGdqU5T0UB/6KMzRPMWx1HJyOzd5otO41ewPfXZJLakMU4a+DrlYI1yxXqMcT41WNgIfP+IxAsbA7nh1xKLaRmqC8az2muw3dgC6X/MFX9PGTODpBir2qTH6KQXZo8OvKrzhFMy3UoNnBhAolURSgCPQ00UOPqdwNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107586; c=relaxed/simple;
	bh=WCibBFfibzqFpDP9HZMzDddnPZYdR2zuHwq8uK6CkZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L1QVX00Yq8Lu7GnwdPF8/LsnDDqw8Pct6zknabqHbGiOtFHBgOzXqrwLyDZTxRGR+APJIVFv0/MK1m0HLV06JYfhm+JMKi1e+HmPrlRKZM9p3LeSL8zUCeOTPKZ7H74mv/kM1PYFhlVwNmV9VL9V1pfdZ7xTs6kuSqc9dNvp/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qhX3uEJK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NvH05ak7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qhX3uEJK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NvH05ak7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51FB322308;
	Wed, 24 Jan 2024 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706107582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5rkOT44PlHmm6TdsUOcAxZrzlfAOAubGywWPKAhas88=;
	b=qhX3uEJKZ8nEczU4Sd/b5z+8+hkJ+Np5seP4DpQezsGg+PH5R8t5htyaS77KjdnRFogopr
	ffztDrriBPm1AwUNhgeMJ8XHdc3i1qpVeeuI6IEA0cVdcPO6LScOND7greb8ZppjnQnTqz
	klcY02jK7Hb/kpXK7cRTWq0cS4SJvqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706107582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5rkOT44PlHmm6TdsUOcAxZrzlfAOAubGywWPKAhas88=;
	b=NvH05ak7ucZe67y6/s7Jds8w2fijukVfpdFEw52oZfrJFtpVm+W7kDcUJdgZW7mNhjuKmv
	jimV5HjumaKvPFCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706107582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5rkOT44PlHmm6TdsUOcAxZrzlfAOAubGywWPKAhas88=;
	b=qhX3uEJKZ8nEczU4Sd/b5z+8+hkJ+Np5seP4DpQezsGg+PH5R8t5htyaS77KjdnRFogopr
	ffztDrriBPm1AwUNhgeMJ8XHdc3i1qpVeeuI6IEA0cVdcPO6LScOND7greb8ZppjnQnTqz
	klcY02jK7Hb/kpXK7cRTWq0cS4SJvqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706107582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5rkOT44PlHmm6TdsUOcAxZrzlfAOAubGywWPKAhas88=;
	b=NvH05ak7ucZe67y6/s7Jds8w2fijukVfpdFEw52oZfrJFtpVm+W7kDcUJdgZW7mNhjuKmv
	jimV5HjumaKvPFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 353391333E;
	Wed, 24 Jan 2024 14:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OF7zDL4isWWnYQAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Wed, 24 Jan 2024 14:46:22 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 5DF869C977; Wed, 24 Jan 2024 15:46:21 +0100 (CET)
Date: Wed, 24 Jan 2024 15:46:21 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Feng Tang <feng.tang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clocksource: disable watchdog checks on TSC when TSC is
 watchdog
Message-ID: <20240124144621.GA5998@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qhX3uEJK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NvH05ak7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -6.01
X-Rspamd-Queue-Id: 51FB322308
X-Spam-Flag: NO

Change the semantics of the tsc=watchdog option to always remove the
CLOCK_SOURCE_MUST_VERIFY bit from the TSC clocksource so as to provide an
alternative to the tsc=nowatchdog option, which is used routinely to
prevent switches to the HPET clocksource on machines with hardware issues.

Currently, the TSC does not get checked on machines with a stable TSC (4
NUMA nodes or less, CONSTANT_TSC, NONSTOP_TSC and TSC_ADJUST), and the
tsc=watchdog option allows one to have the PMTMR (acpi_pm) checked
instead. There are production machines that do not quality for having the
clocksource watchdog disabled (usually on account of having more than 4
NUMA nodes) and that also may have a malfunctioning CPU that causes a
watchdog check failure in a few days after a reboot resulting in the
current clocksource being switched to the HPET. Solving a hardware issue
or replacing the machine may take an inordinate amount of time, while the
production machine is still needed to do its job.

It is possible to pass tsc=nowatchdog to the kernel, which disables the
clocksource watchdog on the TSC, effectively leaving the operator of the
production machine blind to any clocksource malfunction. The sematics of
the recently introduced tsc=watchdog option, 0051293c5330 ("clocksource:
Enable TSC watchdog checking of HPET and PMTMR only when requested"), is
changed by this patch so that the TSC does not get checked when
tsc=watchdog is specified regardless of the TSC passing or not passing the
criteria for being judged to be stable. This way, the TSC acts as a
watchdog checking other clocksources (HPET, PMTMR) and a failed check
does not result in the current clocksource (TSC) getting marked unstable.
Passing tsc=watchdog has the advantange of the operator being informed
that the machine may be experiencing clocksource issues.

There is one side effect of the semantic change of tsc=watchdog - it fixes
the HPET not having its CLOCK_SOURCE_MUST_VERIFY bit set as intended by
efc8b329c7fd ("clocksource: Verify HPET and PMTMR when TSC unverified").
When the system is booting up, the HPET does not have its
CLOCK_SOURCE_MUST_VERIFY bit set on account of the order in which
clocksources are initialized in x86_late_time_init(). The HPET
initialization and clocksource registration always comes before the TSC
init function unsets the CLOCK_SOURCE_MUST_VERIFY bit.

Fixes: efc8b329c7fd ("clocksource: Verify HPET and PMTMR when TSC unverified")
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
v2: the changelog was updated to improve intelligibility

 Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
 arch/x86/include/asm/time.h                     | 2 +-
 arch/x86/kernel/hpet.c                          | 2 +-
 arch/x86/kernel/tsc.c                           | 7 +++----
 drivers/clocksource/acpi_pm.c                   | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..860896571c04 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6722,10 +6722,11 @@
 			obtained from HW or FW using either an MSR or CPUID(0x15).
 			Warn if the difference is more than 500 ppm.
 			[x86] watchdog: Use TSC as the watchdog clocksource with
-			which to check other HW timers (HPET or PM timer), but
-			only on systems where TSC has been deemed trustworthy.
-			This will be suppressed by an earlier tsc=nowatchdog and
-			can be overridden by a later tsc=nowatchdog.  A console
+			which to check other HW timers (HPET or PM timer).
+			TSC is not checked by the watchdog, even on systems
+			where TSC has not been deemed trustworthy. This will be
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
index a38d0c93a66e..46f2b4ffdba7 100644
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

