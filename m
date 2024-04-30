Return-Path: <linux-kernel+bounces-163383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C388B6A27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C44928216F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C018E0E;
	Tue, 30 Apr 2024 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzSf6suE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF3A1865A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456973; cv=none; b=pRNHa3gSE3nPm/gH7L3BIf5M+MQmkE6XFoO4IlyPvhXl1cawiBcNpiL5eKfHwhU0Mw3nCXLf5aToUQcX5V/Fx3VcIJ+Pk98sN9tXm3KRApR92jLD1WP2Y3FcUJL6jST6TZMj27Mcfysh6luV5012xsmdHJYSbtspgM6HYxEuXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456973; c=relaxed/simple;
	bh=sNwgjAA5n6vIbiyq0PGOZo2Y0hPkG0cNpvgy5eJdU1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR/bvuWR4xw0PtMBP84MPpycss70h3ZhBw3VMQAA2TVQ/YX2ZlUgjWlqbrz8HcCuf8QSqeIusO6fgmtX14RNmzNObwxU1cx3Xqgrd4KUIFzKUVp16nEBDdu30C9FotVG7yZ67bo2rVxyiv2A18LWYlUrII47KUt6hFgdj3aQhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzSf6suE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1549AC4AF19;
	Tue, 30 Apr 2024 06:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714456972;
	bh=sNwgjAA5n6vIbiyq0PGOZo2Y0hPkG0cNpvgy5eJdU1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZzSf6suEDWr2C4HwFO9PMdj3LczIsCGszUBsrThRhMGdNyf+ioN6u3dkFIWcMzpfc
	 vU7JO4It86mNidziVqSeFD+0EkLFZu37yYgKdDPJVM9ex5S78uqo1W7hPksXx4nank
	 Rn1gH8IRBWjHoM68f2yWEcbbAoa4srPDwFGECOyNunazPWtrCflBFTR0p70j5RaeDd
	 3AvqnNiHJME7loxQhgmoKwPBvgWQWJvrwjti/p7yJOPYTEa4ax0NmD7YAU1iUhGaae
	 UVNCx28SLGh43zbe1xPXaTGvfCZ5gIzyTOMvUFuArQjOvYXqPTZtcqdE45KJYux8XM
	 qtPKmoaxgHo+Q==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 2/2] watchdog: Allow nmi watchdog to use raw perf event
Date: Mon, 29 Apr 2024 23:02:36 -0700
Message-ID: <20240430060236.1878002-2-song@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430060236.1878002-1-song@kernel.org>
References: <20240430060236.1878002-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NMI watchdog permanently consumes one hardware counters per CPU on the
system. For systems that use many hardware counters, this causes more
aggressive time multiplexing of perf events.

OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
used. Add kernel cmdline arg nmi_watchdog=rNNN to configure the watchdog
to use raw event. For example, on Intel CPUs, we can use "r300" to
configure the watchdog to use ref-cycles event.

If the raw event does not work, fall back to use "cycles".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Song Liu <song@kernel.org>

---
Changes in v5:
Change the design so that we can configure the watchdog with any raw
event.
Add fall back mechanism that use "cycles" if the raw event doesn't work.

v4: https://lore.kernel.org/lkml/20230518002555.1114189-1-song@kernel.org/

Changes in v4:
Fix compile error for !CONFIG_HARDLOCKUP_DETECTOR_PERF. (kernel test bot)

Changes in v3:

Pivot the design to use kernel arg nmi_watchdog=ref-cycles (Peter)
---
 .../admin-guide/kernel-parameters.txt         |  5 ++-
 include/linux/nmi.h                           |  2 +
 kernel/watchdog.c                             |  2 +
 kernel/watchdog_perf.c                        | 44 +++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 213d0719e2b7..7445738f45b3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3776,10 +3776,12 @@
 			Format: [state][,regs][,debounce][,die]
 
 	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
-			Format: [panic,][nopanic,][num]
+			Format: [panic,][nopanic,][rNNN,][num]
 			Valid num: 0 or 1
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
+			rNNN - configure the watchdog with raw perf event 0xNNN
+
 			When panic is specified, panic when an NMI watchdog
 			timeout occurs (or 'nopanic' to not panic on an NMI
 			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
@@ -7467,4 +7469,3 @@
 				memory, and other data can't be written using
 				xmon commands.
 			off	xmon is disabled.
-
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index f53438eae815..a8dfb38c9bb6 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -105,10 +105,12 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
 extern void hardlockup_detector_perf_cleanup(void);
+extern void hardlockup_config_perf_event(const char *str);
 #else
 static inline void hardlockup_detector_perf_stop(void) { }
 static inline void hardlockup_detector_perf_restart(void) { }
 static inline void hardlockup_detector_perf_cleanup(void) { }
+static inline void hardlockup_config_perf_event(const char *str) { }
 #endif
 
 void watchdog_hardlockup_stop(void);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f54484de16f..ab0129b15f25 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -80,6 +80,8 @@ static int __init hardlockup_panic_setup(char *str)
 		watchdog_hardlockup_user_enabled = 0;
 	else if (!strncmp(str, "1", 1))
 		watchdog_hardlockup_user_enabled = 1;
+	else if (!strncmp(str, "r", 1))
+		hardlockup_config_perf_event(str + 1);
 	while (*(str++)) {
 		if (*str == ',') {
 			str++;
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 8ea00c4a24b2..fff032b47c55 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -90,6 +90,14 @@ static struct perf_event_attr wd_hw_attr = {
 	.disabled	= 1,
 };
 
+static struct perf_event_attr fallback_wd_hw_attr = {
+	.type		= PERF_TYPE_HARDWARE,
+	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 1,
+};
+
 /* Callback function for perf event subsystem */
 static void watchdog_overflow_callback(struct perf_event *event,
 				       struct perf_sample_data *data,
@@ -122,6 +130,13 @@ static int hardlockup_detector_event_create(void)
 	/* Try to register using hardware perf events */
 	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
 					       watchdog_overflow_callback, NULL);
+	if (IS_ERR(evt)) {
+		wd_attr = &fallback_wd_hw_attr;
+		wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
+		evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
+						       watchdog_overflow_callback, NULL);
+	}
+
 	if (IS_ERR(evt)) {
 		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
 			 PTR_ERR(evt));
@@ -259,3 +274,32 @@ int __init watchdog_hardlockup_probe(void)
 	}
 	return ret;
 }
+
+/**
+ * hardlockup_config_perf_event - Overwrite config of wd_hw_attr.
+ */
+void __init hardlockup_config_perf_event(const char *str)
+{
+	u64 config;
+	char buf[24];
+	char *comma = strchr(str, ',');
+
+	if (!comma) {
+		if (kstrtoull(str, 16, &config))
+			return;
+	} else {
+		unsigned int len = comma - str;
+
+		if (len >= sizeof(buf))
+			return;
+
+		if (strscpy(buf, str, sizeof(buf)) < 0)
+			return;
+		buf[len] = 0;
+		if (kstrtoull(buf, 16, &config))
+			return;
+	}
+
+	wd_hw_attr.type = PERF_TYPE_RAW;
+	wd_hw_attr.config = config;
+}
-- 
2.43.0


