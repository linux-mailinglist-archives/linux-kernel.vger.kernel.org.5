Return-Path: <linux-kernel+bounces-98364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C7687792C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329F51F2094E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286FD3BBCC;
	Sun, 10 Mar 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eP29k1/1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jcEI/8vq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FA39FE4
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710113942; cv=none; b=NUAQTPFddqL0Dhpqh6LyAuOa0gYiQRUnuOo1gb8K6ezEl8aB5Xp6XdETx7/XYkpoWCuukom8gZq09WwpVJ+gooMpMSb02zAjh3MBQNopZvakqVtaW36DTM/xnz1VELj00SG0gKuF/oXZCDBZJ51ACtr8TQQtmkhCaT3rGbcsEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710113942; c=relaxed/simple;
	bh=gJ7mJuSwscukJt4U5iBZU39u8eWwVg+w9s+t8iCwot8=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=V8asl4Ict0hmQ/xzmGARPCl+GgWMuvT+z7nWUB7V1B8bxZ+KylzTHyuWhVjHSoQJhpk4OVFR0pGVnc/yNN3Faw20PaPoB8NICvGQT76EWGkSAA7A6nLb4dLaFfERTlHDEReURANi3ZR/CdQdZK8igb73NvE51Ogh+ETBzEl7U6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eP29k1/1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jcEI/8vq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710113938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=dyopAHEa7F5ji4mKu/MTMOIEg2J78C4pPSepxDZH8TY=;
	b=eP29k1/1Y12Rb2WpbPjrwYxqehBGWpvCru2AwAM3Kkoraf9JUl311/0LKkOTHzW/y4512G
	sYpI3801qbPgTQcuNO7Kal2hwvsQ0wQTuJxdY+Nc90kiU0BqSACeVh6p+s4wjxPplRcOns
	cH6vzPii5j2ivbtnwVNj4CZmU+ylppkNoTt8ptJE58Y1ZEdWDhU3KaucON7FvjVhUCC22E
	mfZ/BNuXbBqjarMU2Sjq1xQW8cWaRh69AnvHuyAYj5yE6zEutHaejJif9/eCiIvQlkcmId
	Zsi1lY+GmeCvzqZowTqD+TMuWvf1PWp2ICe3k2TUaD+xVquu9VPCyfIpPg7FKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710113938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=dyopAHEa7F5ji4mKu/MTMOIEg2J78C4pPSepxDZH8TY=;
	b=jcEI/8vqHf4Tmx6RVEo0KUI8Z3niuEEkIFr5NECGa8ick74AP8JdRCUIKft0E2BCFf/TkU
	rtnzMRXIaU+1JTAg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/ptp for v6.9-rc1
References: <171011361246.2468526.10740060923051583953.tglx@xen13>
Message-ID: <171011361885.2468526.7938950392542631632.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Mar 2024 00:38:57 +0100 (CET)

Linus,

please pull the latest timers/ptp branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-ptp-2024-=
03-10

up to:  27f6a9c87a97: kvmclock: Unexport kvmclock clocksource

Updates for timekeeping and PTP core:

  The cross-timestamp mechanism which allows to correlate hardware
  clocks uses clocksource pointers for describing the correlation.

  That's suboptimal as drivers need to obtain the pointer, which requires
  needless exports and exposing internals.

  This can be completely avoided by assigning clocksource IDs and using
  them for describing the correlated clock source.

  This update adds clocksource IDs to all clocksources in the tree which
  can be exposed to this mechanism and removes the pointer and now needless
  exports.

  This is separate from the timer core changes as it was provided to the
  PTP folks to build further changes on top.

  A related improvement for the core and the correlation handling has not
  made it this time, but is expected to get ready for the next round.

Thanks,

	tglx

------------------>
Peter Hilber (7):
      timekeeping: Add clocksource ID to struct system_counterval_t
      x86/tsc: Add clocksource ID, set system_counterval_t.cs_id
      x86/kvm, ptp/kvm: Add clocksource ID, set system_counterval_t.cs_id
      ptp/kvm, arm_arch_timer: Set system_counterval_t.cs_id to constant
      timekeeping: Evaluate system_counterval_t.cs_id instead of .cs
      treewide: Remove system_counterval_t.cs, which is never read
      kvmclock: Unexport kvmclock clocksource

Randy Dunlap (1):
      x86/tsc: Correct kernel-doc notation


 arch/x86/include/asm/kvmclock.h      |  2 --
 arch/x86/kernel/kvmclock.c           |  4 ++--
 arch/x86/kernel/tsc.c                | 34 +++++++++++++++++++---------------
 drivers/clocksource/arm_arch_timer.c |  6 +++---
 drivers/ptp/ptp_kvm_common.c         | 10 +++++-----
 drivers/ptp/ptp_kvm_x86.c            |  4 ++--
 include/linux/clocksource_ids.h      |  3 +++
 include/linux/ptp_kvm.h              |  4 ++--
 include/linux/timekeeping.h          | 10 ++++++----
 kernel/time/timekeeping.c            |  9 +++++----
 10 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/kvmclock.h b/arch/x86/include/asm/kvmclock.h
index 511b35069187..f163176d6f7f 100644
--- a/arch/x86/include/asm/kvmclock.h
+++ b/arch/x86/include/asm/kvmclock.h
@@ -4,8 +4,6 @@
=20
 #include <linux/percpu.h>
=20
-extern struct clocksource kvm_clock;
-
 DECLARE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
=20
 static __always_inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5bb395551c44..5b2c15214a6b 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -154,15 +154,15 @@ static int kvm_cs_enable(struct clocksource *cs)
 	return 0;
 }
=20
-struct clocksource kvm_clock =3D {
+static struct clocksource kvm_clock =3D {
 	.name	=3D "kvm-clock",
 	.read	=3D kvm_clock_get_cycles,
 	.rating	=3D 400,
 	.mask	=3D CLOCKSOURCE_MASK(64),
 	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
+	.id     =3D CSID_X86_KVM_CLK,
 	.enable	=3D kvm_cs_enable,
 };
-EXPORT_SYMBOL_GPL(kvm_clock);
=20
 static void kvm_register_clock(char *txt)
 {
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..5a69a49acc96 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -53,7 +53,7 @@ static int __read_mostly tsc_force_recalibrate;
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
-static struct clocksource *art_related_clocksource;
+static bool have_art;
=20
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 =3D 32 */
@@ -652,7 +652,7 @@ static unsigned long quick_pit_calibrate(void)
 }
=20
 /**
- * native_calibrate_tsc
+ * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
 unsigned long native_calibrate_tsc(void)
@@ -1168,6 +1168,7 @@ static struct clocksource clocksource_tsc_early =3D {
 	.mask			=3D CLOCKSOURCE_MASK(64),
 	.flags			=3D CLOCK_SOURCE_IS_CONTINUOUS |
 				  CLOCK_SOURCE_MUST_VERIFY,
+	.id			=3D CSID_X86_TSC_EARLY,
 	.vdso_clock_mode	=3D VDSO_CLOCKMODE_TSC,
 	.enable			=3D tsc_cs_enable,
 	.resume			=3D tsc_resume,
@@ -1190,6 +1191,7 @@ static struct clocksource clocksource_tsc =3D {
 				  CLOCK_SOURCE_VALID_FOR_HRES |
 				  CLOCK_SOURCE_MUST_VERIFY |
 				  CLOCK_SOURCE_VERIFY_PERCPU,
+	.id			=3D CSID_X86_TSC,
 	.vdso_clock_mode	=3D VDSO_CLOCKMODE_TSC,
 	.enable			=3D tsc_cs_enable,
 	.resume			=3D tsc_resume,
@@ -1309,8 +1311,10 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 	do_div(tmp, art_to_tsc_denominator);
 	res +=3D tmp + art_to_tsc_offset;
=20
-	return (struct system_counterval_t) {.cs =3D art_related_clocksource,
-			.cycles =3D res};
+	return (struct system_counterval_t) {
+		.cs_id	=3D have_art ? CSID_X86_TSC : CSID_GENERIC,
+		.cycles	=3D res,
+	};
 }
 EXPORT_SYMBOL(convert_art_to_tsc);
=20
@@ -1327,12 +1331,10 @@ EXPORT_SYMBOL(convert_art_to_tsc);
  * that this flag is set before conversion to TSC is attempted.
  *
  * Return:
- * struct system_counterval_t - system counter value with the pointer to the
- *	corresponding clocksource
- *	@cycles:	System counter value
- *	@cs:		Clocksource corresponding to system counter value. Used
- *			by timekeeping code to verify comparability of two cycle
- *			values.
+ * struct system_counterval_t - system counter value with the ID of the
+ *	corresponding clocksource:
+ *	cycles:		System counter value
+ *	cs_id:		The clocksource ID for validating comparability
  */
=20
 struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
@@ -1347,8 +1349,10 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 a=
rt_ns)
 	do_div(tmp, USEC_PER_SEC);
 	res +=3D tmp;
=20
-	return (struct system_counterval_t) { .cs =3D art_related_clocksource,
-					      .cycles =3D res};
+	return (struct system_counterval_t) {
+		.cs_id	=3D have_art ? CSID_X86_TSC : CSID_GENERIC,
+		.cycles	=3D res,
+	};
 }
 EXPORT_SYMBOL(convert_art_ns_to_tsc);
=20
@@ -1357,7 +1361,7 @@ static void tsc_refine_calibration_work(struct work_str=
uct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
  * tsc_refine_calibration_work - Further refine tsc freq calibration
- * @work - ignored.
+ * @work: ignored.
  *
  * This functions uses delayed work over a period of a
  * second to further refine the TSC freq value. Since this is
@@ -1455,7 +1459,7 @@ static void tsc_refine_calibration_work(struct work_str=
uct *work)
 		goto unreg;
=20
 	if (boot_cpu_has(X86_FEATURE_ART))
-		art_related_clocksource =3D &clocksource_tsc;
+		have_art =3D true;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
@@ -1481,7 +1485,7 @@ static int __init init_tsc_clocksource(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
 		if (boot_cpu_has(X86_FEATURE_ART))
-			art_related_clocksource =3D &clocksource_tsc;
+			have_art =3D true;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
=20
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index e054de92de91..8d4a52056684 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1807,7 +1807,7 @@ TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_time=
r_acpi_init);
 #endif
=20
 int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts,
-				 struct clocksource **cs)
+				 enum clocksource_ids *cs_id)
 {
 	struct arm_smccc_res hvc_res;
 	u32 ptp_counter;
@@ -1831,8 +1831,8 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct tim=
espec64 *ts,
 	*ts =3D ktime_to_timespec64(ktime);
 	if (cycle)
 		*cycle =3D (u64)hvc_res.a2 << 32 | hvc_res.a3;
-	if (cs)
-		*cs =3D &clocksource_counter;
+	if (cs_id)
+		*cs_id =3D CSID_ARM_ARCH_COUNTER;
=20
 	return 0;
 }
diff --git a/drivers/ptp/ptp_kvm_common.c b/drivers/ptp/ptp_kvm_common.c
index 2418977989be..15ccb7dd2ed0 100644
--- a/drivers/ptp/ptp_kvm_common.c
+++ b/drivers/ptp/ptp_kvm_common.c
@@ -28,15 +28,15 @@ static int ptp_kvm_get_time_fn(ktime_t *device_time,
 			       struct system_counterval_t *system_counter,
 			       void *ctx)
 {
-	long ret;
-	u64 cycle;
+	enum clocksource_ids cs_id;
 	struct timespec64 tspec;
-	struct clocksource *cs;
+	u64 cycle;
+	int ret;
=20
 	spin_lock(&kvm_ptp_lock);
=20
 	preempt_disable_notrace();
-	ret =3D kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs);
+	ret =3D kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs_id);
 	if (ret) {
 		spin_unlock(&kvm_ptp_lock);
 		preempt_enable_notrace();
@@ -46,7 +46,7 @@ static int ptp_kvm_get_time_fn(ktime_t *device_time,
 	preempt_enable_notrace();
=20
 	system_counter->cycles =3D cycle;
-	system_counter->cs =3D cs;
+	system_counter->cs_id =3D cs_id;
=20
 	*device_time =3D timespec64_to_ktime(tspec);
=20
diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/ptp_kvm_x86.c
index 902844cc1a17..617c8d6706d3 100644
--- a/drivers/ptp/ptp_kvm_x86.c
+++ b/drivers/ptp/ptp_kvm_x86.c
@@ -93,7 +93,7 @@ int kvm_arch_ptp_get_clock(struct timespec64 *ts)
 }
=20
 int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
-			      struct clocksource **cs)
+			      enum clocksource_ids *cs_id)
 {
 	struct pvclock_vcpu_time_info *src;
 	unsigned int version;
@@ -123,7 +123,7 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct times=
pec64 *tspec,
 		*cycle =3D __pvclock_read_cycles(src, clock_pair->tsc);
 	} while (pvclock_read_retry(src, version));
=20
-	*cs =3D &kvm_clock;
+	*cs_id =3D CSID_X86_KVM_CLK;
=20
 	return 0;
 }
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index 16775d7d8f8d..a4fa3436940c 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -6,6 +6,9 @@
 enum clocksource_ids {
 	CSID_GENERIC		=3D 0,
 	CSID_ARM_ARCH_COUNTER,
+	CSID_X86_TSC_EARLY,
+	CSID_X86_TSC,
+	CSID_X86_KVM_CLK,
 	CSID_MAX,
 };
=20
diff --git a/include/linux/ptp_kvm.h b/include/linux/ptp_kvm.h
index 746fd67c3480..e8c74fa3f455 100644
--- a/include/linux/ptp_kvm.h
+++ b/include/linux/ptp_kvm.h
@@ -8,15 +8,15 @@
 #ifndef _PTP_KVM_H_
 #define _PTP_KVM_H_
=20
+#include <linux/clocksource_ids.h>
 #include <linux/types.h>
=20
 struct timespec64;
-struct clocksource;
=20
 int kvm_arch_ptp_init(void);
 void kvm_arch_ptp_exit(void);
 int kvm_arch_ptp_get_clock(struct timespec64 *ts);
 int kvm_arch_ptp_get_crosststamp(u64 *cycle,
-		struct timespec64 *tspec, struct clocksource **cs);
+		struct timespec64 *tspec, enum clocksource_ids *cs_id);
=20
 #endif /* _PTP_KVM_H_ */
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7c43e98cf211..7e50cbd97f86 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -268,15 +268,17 @@ struct system_device_crosststamp {
 };
=20
 /**
- * struct system_counterval_t - system counter value with the pointer to the
+ * struct system_counterval_t - system counter value with the ID of the
  *				corresponding clocksource
  * @cycles:	System counter value
- * @cs:		Clocksource corresponding to system counter value. Used by
- *		timekeeping code to verify comparibility of two cycle values
+ * @cs_id:	Clocksource ID corresponding to system counter value. Used by
+ *		timekeeping code to verify comparability of two cycle values.
+ *		The default ID, CSID_GENERIC, does not identify a specific
+ *		clocksource.
  */
 struct system_counterval_t {
 	u64			cycles;
-	struct clocksource	*cs;
+	enum clocksource_ids	cs_id;
 };
=20
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..0ff065c5d25b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1232,11 +1232,12 @@ int get_device_system_crosststamp(int (*get_time_fn)
 			return ret;
=20
 		/*
-		 * Verify that the clocksource associated with the captured
-		 * system counter value is the same as the currently installed
-		 * timekeeper clocksource
+		 * Verify that the clocksource ID associated with the captured
+		 * system counter value is the same as for the currently
+		 * installed timekeeper clocksource
 		 */
-		if (tk->tkr_mono.clock !=3D system_counterval.cs)
+		if (system_counterval.cs_id =3D=3D CSID_GENERIC ||
+		    tk->tkr_mono.clock->id !=3D system_counterval.cs_id)
 			return -ENODEV;
 		cycles =3D system_counterval.cycles;
=20


