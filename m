Return-Path: <linux-kernel+bounces-166304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDFA8B98CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2120B2811D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730DA58AA7;
	Thu,  2 May 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="AiN9qZJO"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976457333
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645780; cv=none; b=pnGmSP2qgMJlHh3cHacTNF2Ge1gU7/JRUAgrzJnGf/EGOo0iU+F+05YgfX0MbznOb9MFAZ7gkR4kdYYoNwMzFKav+jkpJVnxmGQlH4+KGEkVUZJSdsNKC2VvBV8xmtl6VbNwuk7v0L2t7a/XRfjtYzzL6Ws/i0vv79Uw0X/Ne4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645780; c=relaxed/simple;
	bh=i2s20f7InC2NyYNbpKgBeu8U+br+ygvboY0KeBgHUZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rzz9wWLE7KBeh92W24upBBsgg5j/xGQlS2voNgystQWQd8NvMK0Xa5xQRYhbdmR9KdDZkxD7pmJo/1EJRP3oVwlwxYp6KL9vNmi/du/0XEuC6icK127FJUIti0IgHJ8r59kM3V0xX2GS5zdXQUI0yEH2PRnJ1Sj2V8GUiOoW6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=AiN9qZJO; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 82EB660910;
	Thu,  2 May 2024 13:27:44 +0300 (MSK)
Received: from davydov-max-nux.yandex.net (unknown [2a02:6b8:8f:4:b109:a1eb:adad:8bd8])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id VRQf6I2Ida60-3IHe2CJi;
	Thu, 02 May 2024 13:27:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1714645663;
	bh=SqeQ0fwjbHbev+ThpT2U2uVA+Y3CxxB2925TJzRuIaE=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=AiN9qZJOioqqmAYjfU+hzTNktOpGkx6TuEQ8Cf3MCgZ0UfDm3NtXmFxJzOFgHIPuQ
	 slcPVP7CJai7qM0aQLatT8MmbWApd4izZQuatMpUH5yRCF0JmgKodxZVZPdEc/MoaD
	 0qlGq8YximaY5gnUNVZ1iQ6Yo8ENZRtbrbXK53UA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: davydov-max@yandex-team.ru,
	den-plotnikov@yandex-team.ru,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	gpiccoli@igalia.com
Subject: [PATCH v2] x86/split_lock: fix delayed detection enabling
Date: Thu,  2 May 2024 13:27:31 +0300
Message-Id: <20240502102731.84429-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the warn mode with disabled mitigation mode is used, then on each
CPU where the split lock occurred detection will be disabled in order to
make progress and delayed work will be scheduled, which then will enable
detection back. Now it turns out that all CPUs use one global delayed
work structure. This leads to the fact that if a split lock occurs on
several CPUs at the same time (within 2 jiffies), only one CPU will
schedule delayed work, but the rest will not. The return value of
schedule_delayed_work_on() would have shown this, but it is not checked
in the code.

A diagram that can help to understand the bug reproduction:
https://lore.kernel.org/all/2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru/

In order to fix the warn mode with disabled mitigation mode, delayed work
has to be a per-CPU.

Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 arch/x86/kernel/cpu/intel.c | 65 ++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be30d7fa2e66..527906aee688 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -971,28 +971,6 @@ static struct ratelimit_state bld_ratelimit;
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
@@ -1115,7 +1093,43 @@ static void __split_lock_reenable(struct work_struct *work)
 {
 	sld_update_msr(true);
 }
-static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
+/*
+ * In order for each CPU to schedule itself delayed work independently of the
+ * others, delayed work struct should be per-CPU. This is not required when
+ * sysctl_sld_mitigate is enabled because of the semaphore, that limits
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
@@ -1157,12 +1171,11 @@ static void split_lock_warn(unsigned long ip)
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


