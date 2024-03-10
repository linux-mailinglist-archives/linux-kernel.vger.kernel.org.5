Return-Path: <linux-kernel+bounces-98366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A6B87792D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5581C20D77
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC713C460;
	Sun, 10 Mar 2024 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6Sdvm5f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrRlU9jN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799323BB50
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710113944; cv=none; b=BjA1/VK38A/KuLhi3G9fdBBhUeSwagOQ0dSWEeT7QE34k+4Tv/eslXrPX9UiHChrPCVgPGCqxnkec6py6lhRwAB8qvoe0oKOVD8uOy4TbI5iL3OVoON/GZOTxxl1RUWBmSIZCyYX02NwGeiunR7KKxZKLrONJNxzChy8wfWPTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710113944; c=relaxed/simple;
	bh=dksMPSA6fQwPrhCCoHt+8EG7ISWtFNyr6ZJrEHu7cTA=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=j0oaCcOObDFWfmnazNWAKVEzRiyzCuwwbgHW7ZFjAOefVap6gYIT2xWptMYooAKZpmO5wDLle9gLVpi8KVssr8mSjfwKzDSpvX69pzIJZyB+PeDmmjfAnRLOR2C9ZK8OSm3x2j3FKUP4iuF6gvNXaHL8/2ixp1UgakOu0n+wa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6Sdvm5f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrRlU9jN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710113934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=Sqibis0bCat6hwboMFP8Lc/aKxubSBlukudl48GwluM=;
	b=j6Sdvm5fw/XibGgB7VYn4IXoc/MF+RnELtpa8xQ6Y4pTZwpdAWTdEls6y4k3esuHRFEPqb
	Mu2wlrf5Nr0hg6egVZcK3Nv0rDrkfQvZ+rKjYaRfD655gnxT9qlw55dMqNFgJXlz3+6l9y
	JGlK6fMVLrnPNOVhaT/ZEzlzHoTQbwlTQwbZh6bg3jcdBVC630eg20oz4aBCOtz2jbT+ol
	BgEGcRN0hW7/hb2zd11GCfiTPVACv/TJRfCfCFu/0/jawWFU7uEkWmyuGxZZ97W/gziXTt
	jfzijjykyq6+6yEBTq1g/d6RykiZ/wCf2efuZ5vthg1D3HH/ZL44ZwgF6HAIEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710113934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=Sqibis0bCat6hwboMFP8Lc/aKxubSBlukudl48GwluM=;
	b=rrRlU9jNHBxVAjMAuyDK7YiXQnc9T0EcKK1YfpDo3WkCTi/MysYO9Gw4VZ7EcM6y/2/Nuj
	8g4f13PA8u3eLvAg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v6.9-rc1
References: <171011361246.2468526.10740060923051583953.tglx@xen13>
Message-ID: <171011361564.2468526.10150004610808473613.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Mar 2024 00:38:54 +0100 (CET)

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-03=
-10

up to:  266e95786452: cpu: Remove stray semicolon

A small boring set of cleanups for the SMP and CPU hotplug code.

Thanks,

	tglx

------------------>
Alexey Dobriyan (2):
      cpu: Mark cpu_possible_mask as __ro_after_init
      smp: Make __smp_processor_id() 0-argument macro

Li Zhijian (1):
      kernel/cpu: Convert snprintf() to sysfs_emit()

Max Kellermann (1):
      cpu: Remove stray semicolon

Randy Dunlap (1):
      cpu/hotplug: Delete an extraneous kernel-doc description


 include/linux/smp.h | 2 +-
 kernel/cpu.c        | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index e87520dc2959..cc517002c599 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -261,7 +261,7 @@ static inline int get_boot_cpu_id(void)
  * regular asm read for the stable.
  */
 #ifndef __smp_processor_id
-#define __smp_processor_id(x) raw_smp_processor_id(x)
+#define __smp_processor_id() raw_smp_processor_id()
 #endif
=20
 #ifdef CONFIG_DEBUG_PREEMPT
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba4950b..cc4a8068747c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -54,7 +54,6 @@
  * @rollback:	Perform a rollback
  * @single:	Single callback invocation
  * @bringup:	Single callback bringup or teardown selector
- * @cpu:	CPU number
  * @node:	Remote CPU node; for multi-instance, do a
  *		single entry callback for install/remove
  * @last:	For multi-instance rollback, remember how far we got
@@ -3005,7 +3004,7 @@ static ssize_t control_show(struct device *dev,
 		return sysfs_emit(buf, "%d\n", cpu_smt_num_threads);
 #endif
=20
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+	return sysfs_emit(buf, "%s\n", state);
 }
=20
 static ssize_t control_store(struct device *dev, struct device_attribute *at=
tr,
@@ -3018,7 +3017,7 @@ static DEVICE_ATTR_RW(control);
 static ssize_t active_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
+	return sysfs_emit(buf, "%d\n", sched_smt_active());
 }
 static DEVICE_ATTR_RO(active);
=20
@@ -3107,10 +3106,10 @@ const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) =3D CPU_B=
ITS_ALL;
 EXPORT_SYMBOL(cpu_all_bits);
=20
 #ifdef CONFIG_INIT_ALL_POSSIBLE
-struct cpumask __cpu_possible_mask __read_mostly
+struct cpumask __cpu_possible_mask __ro_after_init
 	=3D {CPU_BITS_ALL};
 #else
-struct cpumask __cpu_possible_mask __read_mostly;
+struct cpumask __cpu_possible_mask __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
=20


