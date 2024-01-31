Return-Path: <linux-kernel+bounces-46250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0502843D04
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B78028C480
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09B69DEA;
	Wed, 31 Jan 2024 10:42:16 +0000 (UTC)
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 255F969E02
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697736; cv=none; b=QylJWF/Oj4k4dlcYxgVAE3J8Cq+K/fyIF6J/tlyj6dZZAjz2I3i52qC74n5bEqS2NeOaHuZ30anFkP9m2CiM7VaB/WRYecFVPNOhnjFlKaN/0K1g3tcngImM66RxTKllj0K6+gkTQ0lTDzUOdY4gI6uqyqjoQk9B/uu7IFmJvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697736; c=relaxed/simple;
	bh=nEgY3eaMkta1zmgIzkGZ9lrZP6bUGs2ipmNJx8u1B2E=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uiD9qLWi3V6g99NUCKOSmI9jSkqwH4z2bhNQVninV4eaJs+Pk7Dn5PHxjz3E3YonKNEFeccTI03n0fv0SdDWfG4G9q0QFCp8MrZuOD4XkXgxrgKA++pm8NtUCCECkum70kWfS8kMvrXCxzXT+gXzNjbyeIn7qjyQOSDDhVe9z/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id D78DE183576DEC;
	Wed, 31 Jan 2024 18:42:00 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 18:42:00 +0800
Date: Wed, 31 Jan 2024 18:41:52 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: tiozhang <tiozhang@didiglobal.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, "Steven Rostedt (Google)"
	<rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>, <tiozhang@didiglobal.com>
Subject: [PATCH] hrtimer: add cmdline parameter retry_threshold to config
 retry times in interrupt handler routine
Message-ID: <20240131104152.GA19461@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
	zyhtheonly@yeah.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

Motivation of doing this is to give user a config option to reduce time
cost in hrtimer irq when influenced by some time consuming hrtimer
callbacks running in irq context.
E.g, if we tune this parameter to 1, we dont retry anymore to prevent
occasionally consecutive time consuming callbacks running in a single
interrupt.

Signed-off-by: tiozhang <tiozhang@didiglobal.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/time/hrtimer.c                           | 17 +++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1457995fd41..29fcb1c43863 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1737,6 +1737,11 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
+	hrtimer.retry_threshold=
+			[KNL] Number of retry times when expired timer found
+			in hrtimer interrupt handle routine. Default 3.
+			Format: <int> (must be <= 3)
+
 	hugepages=	[HW] Number of HugeTLB pages to allocate at boot.
 			If this follows hugepagesz (below), it specifies
 			the number of pages of hugepagesz to be allocated.
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 238262e4aba7..d3c17aa6cc13 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -144,6 +144,8 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
+static int retry_threshold = 3;
+
 static inline bool is_migration_base(struct hrtimer_clock_base *base)
 {
 	return base == &migration_base;
@@ -1836,7 +1838,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	 * - being scheduled away when running in a VM
 	 *
 	 * We need to prevent that we loop forever in the hrtimer
-	 * interrupt routine. We give it 3 attempts to avoid
+	 * interrupt routine. We give it at most 3 attempts to avoid
 	 * overreacting on some spurious event.
 	 *
 	 * Acquire base lock for updating the offsets and retrieving
@@ -1845,7 +1847,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 	now = hrtimer_update_base(cpu_base);
 	cpu_base->nr_retries++;
-	if (++retries < 3)
+	if (++retries < retry_threshold)
 		goto retry;
 	/*
 	 * Give the system a chance to do something else than looping
@@ -2398,3 +2400,14 @@ int __sched schedule_hrtimeout(ktime_t *expires,
 	return schedule_hrtimeout_range(expires, 0, mode);
 }
 EXPORT_SYMBOL_GPL(schedule_hrtimeout);
+
+static int __init hrtimer_retry_threshold_setup(char *str)
+{
+	if (kstrtoint(str, 0, &retry_threshold) || retry_threshold > 3) {
+		retry_threshold = 3;
+		pr_warn("hrtimer.retry_threshold: bad given value, using default as 3\n");
+	}
+
+	return 1;
+}
+__setup("hrtimer.retry_threshold=", hrtimer_retry_threshold_setup);
-- 
2.17.1


