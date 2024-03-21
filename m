Return-Path: <linux-kernel+bounces-110619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E798886159
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C751C21C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350F13442D;
	Thu, 21 Mar 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="qt2gdZoX"
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB3258AC0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050949; cv=none; b=RRXbC3pgVSKLl83HAuC1lPpiyp+G5ZSLJPi7DVja3aL4u+zObSRojaNDpSuHz6rubplF6Ip4lx4rRKERzptl/z6j11hMlcQ8BQiDQif+CecGyFwWb6nzKMlQJhtXjBVSdx/B+uUnZyzCNsohRuTHPQkAkCOKEobBwr2NXWhiqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050949; c=relaxed/simple;
	bh=+4GFlx9wmE8jOFa2CKAstEXz5v+dAcH3A/WMKOXX7vU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BZb/lxbSJ6l6AadPB3iCObTrOnLVTFoBzB6naSLAq2rXVd6fLMjK5heXD3r5dx0GP2l6CKhCdC//WMK2N5mzZM6/6ZXyrq1iGmVTW4VJTE24vwG+6lcsgNjBrfsOxdyeN3sdIJdGzEU2pO8E4Bst200VyiPFHEDgPLlUtDls5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=qt2gdZoX; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
	by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id EAA3460D0A;
	Thu, 21 Mar 2024 22:55:38 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown [2a02:6b8:b081:b40f::1:37])
	by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id MtMYPb1Id8c0-SDvU4oeX;
	Thu, 21 Mar 2024 22:55:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1711050938;
	bh=MQrIrVqhzfnNhKZwYK372BECsAieptxJxNrqXtN0PWM=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=qt2gdZoXhD474n+zPo5LhZoJ9H2qSkNYgWdol2Nk92CdQFAUURfAQzvA3Aiq6BOuv
	 mCkHg+8pfpuRKTz2Mf6iXKM7+rlb1nUp4c15rROW4MmB+myXK8pfEn3QRc7m13rtE3
	 Y5KGAvsC0B22YJNoQyi6Zo7KVqw7aaN563CE35vI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: gpiccoli@igalia.com,
	davydov-max@yandex-team.ru,
	den-plotnikov@yandex-team.ru,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Subject: [PATCH] x86/split_lock: fix delayed detection enabling
Date: Thu, 21 Mar 2024 22:55:22 +0300
Message-Id: <20240321195522.24830-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the warn mode with disabled mitigation mode is used, then on each cpu
where the split lock occurred detection will be disabled in order to make
progress and delayed work will be scheduled, which then will enable
detection back. Now it turns out that all CPUs use one global delayed
work structure. This leads to the fact that if a split lock occurs on
several CPUs at the same time (within 2 jiffies), only one cpu will
schedule delayed work, but the rest will not. The return value of
schedule_delayed_work_on() would have shown this, but it is not checked
in the code
In order to fix the warn mode with disabled mitigation mode, delayed work
has to be a per-cpu.

Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 arch/x86/kernel/cpu/intel.c | 65 ++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 40dec9b56f87..655165225d49 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -996,28 +996,6 @@ static struct ratelimit_state bld_ratelimit;
 static unsigned int sysctl_sld_mitigate = 1;
 static DEFINE_SEMAPHORE(buslock_sem, 1);
 
-#ifdef CONFIG_PROC_SYSCTL
-static struct ctl_table sld_sysctls[] = {
-	{
-		.procname       = "split_lock_mitigate",
-		.data           = &sysctl_sld_mitigate,
-		.maxlen         = sizeof(unsigned int),
-		.mode           = 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
-	},
-};
-
-static int __init sld_mitigate_sysctl_init(void)
-{
-	register_sysctl_init("kernel", sld_sysctls);
-	return 0;
-}
-
-late_initcall(sld_mitigate_sysctl_init);
-#endif
-
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
 	int len = strlen(opt), ratelimit;
@@ -1140,7 +1118,43 @@ static void __split_lock_reenable(struct work_struct *work)
 {
 	sld_update_msr(true);
 }
-static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
+/*
+ * In order for each cpu to schedule itself delayed work independently of the
+ * others, delayed work struct should be per-cpu. This is not required when
+ * sysctl_sld_mitigate is enabled because of the semaphore that limits
+ * the number of simultaneously scheduled delayed works to 1.
+ */
+static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
+
+#ifdef CONFIG_PROC_SYSCTL
+static struct ctl_table sld_sysctls[] = {
+	{
+		.procname       = "split_lock_mitigate",
+		.data           = &sysctl_sld_mitigate,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+};
+
+static int __init sld_mitigate_sysctl_init(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct delayed_work *work = per_cpu_ptr(&sl_reenable, cpu);
+		*work = (struct delayed_work) __DELAYED_WORK_INITIALIZER(*work,
+			__split_lock_reenable, 0);
+	}
+
+	register_sysctl_init("kernel", sld_sysctls);
+	return 0;
+}
+
+late_initcall(sld_mitigate_sysctl_init);
+#endif
 
 /*
  * If a CPU goes offline with pending delayed work to re-enable split lock
@@ -1182,12 +1196,11 @@ static void split_lock_warn(unsigned long ip)
 		 */
 		if (down_interruptible(&buslock_sem) == -EINTR)
 			return;
-		work = &sl_reenable_unlock;
-	} else {
-		work = &sl_reenable;
 	}
 
 	cpu = get_cpu();
+	work = (sysctl_sld_mitigate ?
+		&sl_reenable_unlock : this_cpu_ptr(&sl_reenable));
 	schedule_delayed_work_on(cpu, work, 2);
 
 	/* Disable split lock detection on this CPU to make progress */
-- 
2.34.1


