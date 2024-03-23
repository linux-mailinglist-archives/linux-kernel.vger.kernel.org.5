Return-Path: <linux-kernel+bounces-112469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E331887A38
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07337B21351
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74CE5B5D6;
	Sat, 23 Mar 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iHJPLAG2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O/z/ck3P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F65A10A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711223528; cv=none; b=F/vEmgl0NbvI3i+TrrPZld+ez/dIMjhDjoh2tqm6KhXqHoZ36+4lUjWh2AFxM0ZYr7xtWSjiAfQfp756Myg01T5nEBuluBGaWK7jgD8LH2LdhrTe0gKm11ZsdpgMGYPgNqpaCqTJp11YY+ReXTL5cWzuzfxSLFuEmZSjwCii0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711223528; c=relaxed/simple;
	bh=NSCoOxI47MPHSdqcnwxqUyAs8NrmmH6uq2ngkSmUA6Q=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=WtWHCxxKu6Jq3N4Fc9c6EDWrKBu0IZ2rfPgqvqdINN84xipzd1gxtjrlQ+1MioFfFybbsizKu9zI3KOfmWGZbXdspi14n8OCwbrb51VTZJR0phl+BX18Qt2H1VUnXadSxLQurS8U/5QxeBmxGUCQLqF2j/9fn7uqYX0/XlOXGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iHJPLAG2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O/z/ck3P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711223524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=uISftncO67WoLzla+p8VY4NBfhy2gZdxyOPNUQz2wWU=;
	b=iHJPLAG2GEaALt/nBYFq40KcGsCS39LgIICXkF4zwd2cdWo/LaVxuCSH0m+gY05nzSrqaL
	emc2ccnjIJB38zOT0lbX/QJAfwAN2ak5xkWq3j6CYxkai+By5F43RA+yN6H+PU6x0hPTrQ
	ihVouuLmFPu97mu5WQy2eIvsR8p7qQVc1Bu30+usdU5ozHyLWG0FaXWV6hxS+rICuyV94t
	Vwnjlj3kCwxsldoG/Bosa8Yg21FhQu8U9s2K6ysEtmbD+DBhCS0dE9bKXR0SGyqYdg8j96
	e2gW5G4kmzrMHZngAZHLgKpsWk3m2qD0aZ3KVq9gdgcERjHrxr9htIXng46tGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711223524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=uISftncO67WoLzla+p8VY4NBfhy2gZdxyOPNUQz2wWU=;
	b=O/z/ck3PGW1dROpeEnYJ2jxJ+khjsIYpHGe1XLVhLu/JwJ5LadvxH+Jx0I65Ehoa/Q3loa
	uW8awNY+JirXY0Cw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v6.9-rc1
References: <171122346785.2772088.10596056144848184713.tglx@xen13>
Message-ID: <171122347264.2772088.18245020534552619618.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 23 Mar 2024 20:52:04 +0100 (CET)

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
24-03-23

up to:  03877039863b: timers: Fix removed self-IPI on global timer's enqueue =
in nohz_full

Two regression fixes for the timer and timer migration code:

  1) Prevent endless timer requeuing which is caused by two CPUs racing out
     of idle. This happens when the last CPU goes idle and therefore has to
     ensure to expire the pending global timers and some other CPU come out
     of idle at the same time and the other CPU wins the race and expires
     the global queue. This causes the last CPU to chase ghost timers
     forever and reprogramming it's clockevent device endlessly.

     Cure this by re-evaluating the wakeup time unconditionally.

  2) The split into local (pinned) and global timers in the timer wheel
     caused a regression for NOHZ full as it broke the idle tracking of
     global timers. On NOHZ full this prevents an self IPI being sent which
     in turn causes the timer to be not programmed and not being expired on
     time.

     Restore the idle tracking for the global timer base so that the self
     IPI condition for NOHZ full is working correctly again.

Thanks,

	tglx

------------------>
Frederic Weisbecker (2):
      timers/migration: Fix endless timer requeue after idle interrupts
      timers: Fix removed self-IPI on global timer's enqueue in nohz_full


 kernel/time/timer.c           | 12 +++++++++++-
 kernel/time/timer_migration.c | 11 +++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e69e75d3858c..dee29f1f5b75 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -642,7 +642,8 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer=
_list *timer)
 	 * the base lock:
 	 */
 	if (base->is_idle) {
-		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED));
+		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED ||
+			       tick_nohz_full_cpu(base->cpu)));
 		wake_up_nohz_cpu(base->cpu);
 	}
 }
@@ -2292,6 +2293,13 @@ static inline u64 __get_next_timer_interrupt(unsigned =
long basej, u64 basem,
 		 */
 		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
 			base_local->is_idle =3D true;
+			/*
+			 * Global timers queued locally while running in a task
+			 * in nohz_full mode need a self-IPI to kick reprogramming
+			 * in IRQ tail.
+			 */
+			if (tick_nohz_full_cpu(base_local->cpu))
+				base_global->is_idle =3D true;
 			trace_timer_base_idle(true, base_local->cpu);
 		}
 		*idle =3D base_local->is_idle;
@@ -2364,6 +2372,8 @@ void timer_clear_idle(void)
 	 * path. Required for BASE_LOCAL only.
 	 */
 	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
+	if (tick_nohz_full_cpu(smp_processor_id()))
+		__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 	trace_timer_base_idle(false, smp_processor_id());
=20
 	/* Activate without holding the timer_base->lock */
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 611cd904f035..c63a0afdcebe 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1038,8 +1038,15 @@ void tmigr_handle_remote(void)
 	 * in tmigr_handle_remote_up() anyway. Keep this check to speed up the
 	 * return when nothing has to be done.
 	 */
-	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
-		return;
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask)) {
+		/*
+		 * If this CPU was an idle migrator, make sure to clear its wakeup
+		 * value so it won't chase timers that have already expired elsewhere.
+		 * This avoids endless requeue from tmigr_new_timer().
+		 */
+		if (READ_ONCE(tmc->wakeup) =3D=3D KTIME_MAX)
+			return;
+	}
=20
 	data.now =3D get_jiffies_update(&data.basej);
=20


