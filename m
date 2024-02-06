Return-Path: <linux-kernel+bounces-55519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCC584BDA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973BC292747
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84314AA0;
	Tue,  6 Feb 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPw2AFI2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554B134D7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246034; cv=none; b=AltdgEpUFlwFSgoj1B2SHspA/murzuS553mLP7xpZR11A/d2AulTPbOVADU0cY5LqiJumnSmsedsPoeghob4FS9ZLWkKObIkdT9w/vUo22irgoWx7WRsJu1O/u1A3anXGRf6wwS+IW+8RWXWVg9W2jVmlJttWwb3M0lZld7+isI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246034; c=relaxed/simple;
	bh=eLiM7F0NYaYwEZdIKULrX5PquxR5xdCAZWcTr3ag9Ik=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=byk0BwZCn1sWqSwNWb+cpP0t7Q3EcGgkh3dj9ZiaOsG2jFFPDY35tXK5A1y2dviCScxaByjHXM1F5KKuS062FlfoGe3KlB1PESqw9VnY1oh2xrLwUf2AftOqpMy/ejC9fiZAfmgDuOYioYx8aJBACfIS/13fV4OrbP6wAvRnKLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPw2AFI2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0tiqWczwl5gDbY1ngK0gOH79fYCUh1b4q8ALen4EPQo=;
	b=WPw2AFI2E07SLeC6A+RSTSGbk/v2sc3R5UDiDSc9GF/Z1/0sWkMx8HYCX3SqJ71npMOVxp
	MLYkpuJREYXPUUfshzLV0+ThplKGJJf7X1krqF2UABNmfnU/z0uHDdk4hHUeSp/nU3muLp
	Q9Ym5K59oVnB4igCzt5LeKX7OfpTIXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-zKnh0DFhPey1tSZHQ2dJkg-1; Tue, 06 Feb 2024 14:00:26 -0500
X-MC-Unique: zKnh0DFhPey1tSZHQ2dJkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FE63185A788;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 31769112132A;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 29FE0401E1202; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185709.955049547@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:16 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 05/12] timekeeping_notify: use stop_machine_fail when appropriate
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Change timekeeping_notify to use stop_machine_fail when appropriate,
which will fail in case the target CPU is tagged as block interference CPU.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/include/linux/clocksource.h
===================================================================
--- linux-isolation.orig/include/linux/clocksource.h
+++ linux-isolation/include/linux/clocksource.h
@@ -267,7 +267,7 @@ extern void clocksource_arch_init(struct
 static inline void clocksource_arch_init(struct clocksource *cs) { }
 #endif
 
-extern int timekeeping_notify(struct clocksource *clock);
+extern int timekeeping_notify(struct clocksource *clock, bool fail);
 
 extern u64 clocksource_mmio_readl_up(struct clocksource *);
 extern u64 clocksource_mmio_readl_down(struct clocksource *);
Index: linux-isolation/kernel/time/clocksource.c
===================================================================
--- linux-isolation.orig/kernel/time/clocksource.c
+++ linux-isolation/kernel/time/clocksource.c
@@ -125,7 +125,7 @@ static u64 suspend_start;
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
-static void clocksource_select(void);
+static int clocksource_select(bool fail);
 
 static LIST_HEAD(watchdog_list);
 static struct clocksource *watchdog;
@@ -679,7 +679,7 @@ static int clocksource_watchdog_kthread(
 {
 	mutex_lock(&clocksource_mutex);
 	if (__clocksource_watchdog_kthread())
-		clocksource_select();
+		clocksource_select(false);
 	mutex_unlock(&clocksource_mutex);
 	return 0;
 }
@@ -976,7 +976,7 @@ static struct clocksource *clocksource_f
 	return NULL;
 }
 
-static void __clocksource_select(bool skipcur)
+static int __clocksource_select(bool skipcur, bool fail)
 {
 	bool oneshot = tick_oneshot_mode_active();
 	struct clocksource *best, *cs;
@@ -984,7 +984,7 @@ static void __clocksource_select(bool sk
 	/* Find the best suitable clocksource */
 	best = clocksource_find_best(oneshot, skipcur);
 	if (!best)
-		return;
+		return 0;
 
 	if (!strlen(override_name))
 		goto found;
@@ -1021,10 +1021,16 @@ static void __clocksource_select(bool sk
 	}
 
 found:
-	if (curr_clocksource != best && !timekeeping_notify(best)) {
+	if (curr_clocksource != best) {
+		int ret;
+
+		ret = timekeeping_notify(best, fail);
+		if (ret)
+			return ret;
 		pr_info("Switched to clocksource %s\n", best->name);
 		curr_clocksource = best;
 	}
+	return 0;
 }
 
 /**
@@ -1035,14 +1041,14 @@ found:
  * Select the clocksource with the best rating, or the clocksource,
  * which is selected by userspace override.
  */
-static void clocksource_select(void)
+static int clocksource_select(bool fail)
 {
-	__clocksource_select(false);
+	return __clocksource_select(false, fail);
 }
 
-static void clocksource_select_fallback(void)
+static int clocksource_select_fallback(void)
 {
-	__clocksource_select(true);
+	return __clocksource_select(true, true);
 }
 
 /*
@@ -1061,7 +1067,7 @@ static int __init clocksource_done_booti
 	 * Run the watchdog first to eliminate unstable clock sources
 	 */
 	__clocksource_watchdog_kthread();
-	clocksource_select();
+	clocksource_select(false);
 	mutex_unlock(&clocksource_mutex);
 	return 0;
 }
@@ -1209,7 +1215,7 @@ int __clocksource_register_scale(struct
 	clocksource_enqueue_watchdog(cs);
 	clocksource_watchdog_unlock(&flags);
 
-	clocksource_select();
+	clocksource_select(false);
 	clocksource_select_watchdog(false);
 	__clocksource_suspend_select(cs);
 	mutex_unlock(&clocksource_mutex);
@@ -1238,7 +1244,7 @@ void clocksource_change_rating(struct cl
 	__clocksource_change_rating(cs, rating);
 	clocksource_watchdog_unlock(&flags);
 
-	clocksource_select();
+	clocksource_select(false);
 	clocksource_select_watchdog(false);
 	clocksource_suspend_select(false);
 	mutex_unlock(&clocksource_mutex);
@@ -1260,8 +1266,12 @@ static int clocksource_unbind(struct clo
 	}
 
 	if (cs == curr_clocksource) {
+		int ret;
+
 		/* Select and try to install a replacement clock source */
-		clocksource_select_fallback();
+		ret = clocksource_select_fallback();
+		if (ret)
+			return ret;
 		if (curr_clocksource == cs)
 			return -EBUSY;
 	}
@@ -1352,17 +1362,17 @@ static ssize_t current_clocksource_store
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	ssize_t ret;
+	ssize_t ret, err;
 
 	mutex_lock(&clocksource_mutex);
 
 	ret = sysfs_get_uname(buf, override_name, count);
 	if (ret >= 0)
-		clocksource_select();
+		err = clocksource_select(true);
 
 	mutex_unlock(&clocksource_mutex);
 
-	return ret;
+	return err ? err : ret;
 }
 static DEVICE_ATTR_RW(current_clocksource);
 
Index: linux-isolation/kernel/time/timekeeping.c
===================================================================
--- linux-isolation.orig/kernel/time/timekeeping.c
+++ linux-isolation/kernel/time/timekeeping.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/sched/loadavg.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/isolation.h>
 #include <linux/syscore_ops.h>
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
@@ -1497,13 +1498,24 @@ static int change_clocksource(void *data
  * This function is called from clocksource.c after a new, better clock
  * source has been registered. The caller holds the clocksource_mutex.
  */
-int timekeeping_notify(struct clocksource *clock)
+int timekeeping_notify(struct clocksource *clock, bool fail)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 
 	if (tk->tkr_mono.clock == clock)
 		return 0;
-	stop_machine(change_clocksource, clock, NULL);
+
+	if (!fail)
+		stop_machine(change_clocksource, clock, NULL);
+	else {
+		int ret, idx;
+
+		idx = block_interf_srcu_read_lock();
+		ret = stop_machine_fail(change_clocksource, clock, NULL);
+		block_interf_srcu_read_unlock(idx);
+		if (ret)
+			return ret;
+	}
 	tick_clock_notify();
 	return tk->tkr_mono.clock == clock ? 0 : -1;
 }



