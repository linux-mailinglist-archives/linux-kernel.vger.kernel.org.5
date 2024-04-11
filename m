Return-Path: <linux-kernel+bounces-140008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50AB8A0A43
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5AE2827EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37D13FD7B;
	Thu, 11 Apr 2024 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Dr/I0tWU"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD913E8AB;
	Thu, 11 Apr 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821311; cv=none; b=m52GUuatzdXaGCQF+PjG5uWLKEeJtzO2v2sl3YXiiWieXf9ukc41oD1gkYCy386XH6kFO394Mpusa5c6T+UWLRl9Fs6bkNeTEnrsWEmt4tWla9WGvidlBws2P1k3TEUIJtM2s5DwFQy9sWJo48f45J/y/QSIA9uXpZtp8u5t7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821311; c=relaxed/simple;
	bh=wSmtT/QGZvyDyFmReyInpkD4Pd8xYPNmrS6RmhpsL/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQwAR9Wtm3UXl43K7JHLYHLMgDLXP2QHL795T9huMi7M87WN8QDeAQJx/I/CN/4Nxa8qdxkDroPaORtnV7GLCVFu4mRJCMgpPYCULxL1JVf30dCg6pgN83Dz/B2hbBM/O3zWrh5nLaSQH87OphSJCG87wtV4aWtsHGL5GFZLiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Dr/I0tWU; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712821306; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gF7qIKS2+QnTwBDX4CgdxCnFsGoEC/Sga8w5/JAmLtI=;
	b=Dr/I0tWU+XAeSdKP9g2oT/P1UU0nCOamOaYg2E8XkfVOmf59fGZztWBi/16aSkWZW0y5/2t4DcvOfo3NNCajIhO3+tWDuN97jp9VbWD7FpPZZK70Wk80XklrpO/qp5YZ5SaEMViqVECyZ6Tta8S8Gbm9+WLHu4C1YYkPdunng34=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W4KbQ9Q_1712821302;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W4KbQ9Q_1712821302)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 15:41:44 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	tglx@linutronix.de,
	liusong@linux.alibaba.com,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	deller@gmx.de,
	npiggin@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv13 2/5] genirq: Provide a snapshot mechanism for interrupt statistics
Date: Thu, 11 Apr 2024 15:41:31 +0800
Message-Id: <20240411074134.30922-3-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240411074134.30922-1-yaoma@linux.alibaba.com>
References: <20240411074134.30922-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The soft lockup detector lacks a mechanism to identify interrupt storms
as root cause of a lockup. To enable this the detector needs a
mechanism to snapshot the interrupt count statistics on a CPU when the
detector observes a potential lockup scenario and compare that against
the interrupt count when it warns about the lockup later on. The number
of interrupts in that period give a hint whether the lockup might be
caused by an interrupt storm.

Instead of having extra storage in the lockup detector and accessing
the internals of the interrupt descriptor directly, add a snapshot
member to the per CPU irq_desc::kstat_irq structure and provide
interfaces to take a snapshot of all interrupts on the current CPU
and to retrieve the delta of a specific interrupt later on.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
---
 include/linux/irqdesc.h     |  4 ++++
 include/linux/kernel_stat.h |  8 ++++++++
 kernel/irq/Kconfig          |  4 ++++
 kernel/irq/irqdesc.c        | 25 +++++++++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index c28612674acb..fd091c35d572 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -20,9 +20,13 @@ struct pt_regs;
 /**
  * struct irqstat - interrupt statistics
  * @cnt:	real-time interrupt count
+ * @ref:	snapshot of interrupt count
  */
 struct irqstat {
 	unsigned int	cnt;
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+	unsigned int	ref;
+#endif
 };
 
 /**
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9935f7ecbfb9..9c042c6384bb 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -79,6 +79,14 @@ static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
 	return sum;
 }
 
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+extern void kstat_snapshot_irqs(void);
+extern unsigned int kstat_get_irq_since_snapshot(unsigned int irq);
+#else
+static inline void kstat_snapshot_irqs(void) { }
+static inline unsigned int kstat_get_irq_since_snapshot(unsigned int irq) { return 0; }
+#endif
+
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 2531f3496ab6..529adb1f5859 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -108,6 +108,10 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
 config GENERIC_IRQ_RESERVATION_MODE
 	bool
 
+# Snapshot for interrupt statistics
+config GENERIC_IRQ_STAT_SNAPSHOT
+	bool
+
 # Support forced irq threading
 config IRQ_FORCED_THREADING
        bool
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b59b79200ad7..f348faffa7b4 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -994,6 +994,31 @@ static unsigned int kstat_irqs(unsigned int irq)
 	return sum;
 }
 
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+
+void kstat_snapshot_irqs(void)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	for_each_irq_desc(irq, desc) {
+		if (!desc->kstat_irqs)
+			continue;
+		this_cpu_write(desc->kstat_irqs->ref, this_cpu_read(desc->kstat_irqs->cnt));
+	}
+}
+
+unsigned int kstat_get_irq_since_snapshot(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (!desc || !desc->kstat_irqs)
+		return 0;
+	return this_cpu_read(desc->kstat_irqs->cnt) - this_cpu_read(desc->kstat_irqs->ref);
+}
+
+#endif
+
 /**
  * kstat_irqs_usr - Get the statistics for an interrupt from thread context
  * @irq:	The interrupt number
-- 
2.37.1 (Apple Git-137.1)


