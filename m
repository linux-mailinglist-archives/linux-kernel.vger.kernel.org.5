Return-Path: <linux-kernel+bounces-80399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3D88667CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4251F21C07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E41BC4D;
	Mon, 26 Feb 2024 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XIvyROOh"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA9DF4D;
	Mon, 26 Feb 2024 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913403; cv=none; b=X2nbQI38PArZ71ripedPzznD0yB8zKqsZ78/mu+TuwEpnG1l+cpqZG5dqfecRwLoGleSYOrkogNzR5i7ku6OpQUXynDCebQ+7EoO7wtZK/L9N+HDvBZxJJAfvV6tWvmuggqtSZJnvWUmXcKo4vUosSECmKzJDnc8skVMku9E+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913403; c=relaxed/simple;
	bh=42gH4qBC/Oia0dXWguVUjy9QiaWAqbXw3cvqChcFo3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L3/H4/8XBN5YBktt/qgd9Oh/wf5d8wjrcgezEuJ3Pq2Hy3RMQzgfmv/bra4VYiJliX9YRWy0/fQAVl6Y+zGT76+RI/bBcaFuvj5oiaONxGTa+maLCOzb5SAelfRvU8CVvDEyfYtIr5EwsB0muI9adJGk+q8TPvUhSc32+R71RD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XIvyROOh; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708913393; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uN6ubd7T7BDgKGYOOcoXXMe2toDXWaMbHm9pDjI4o+Y=;
	b=XIvyROOhSxK91wwUVMK+jpvHP1KDOSyC4gzrMSzUSJaH/hWd7ljCbUlZWGYFCopMWLHT40brMp8zNEkLDIljRz7PUiaRJ2LLHvpgOfotccsduQsc9aEbkWGuaYqHiAno3K4CknCjWsn4G4sk4E6jfi/JZCh5HIcakBIGpvCcD/U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1A1HdQ_1708913390;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W1A1HdQ_1708913390)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 10:09:52 +0800
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
Subject: [PATCHv10 3/4] genirq: Avoid summation loops for /proc/interrupts
Date: Mon, 26 Feb 2024 10:09:38 +0800
Message-Id: <20240226020939.45264-4-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240226020939.45264-1-yaoma@linux.alibaba.com>
References: <20240226020939.45264-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We could use the irq_desc::tot_count member to avoid the summation
loop for interrupts which are not marked as 'PER_CPU' interrupts in
'show_interrupts'. This could reduce the time overhead of reading
/proc/interrupts.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
---
 include/linux/irqdesc.h | 2 ++
 kernel/irq/irqdesc.c    | 2 +-
 kernel/irq/proc.c       | 9 +++++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 2912b1998670..1ee96d7232b4 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -121,6 +121,8 @@ static inline void irq_unlock_sparse(void) { }
 extern struct irq_desc irq_desc[NR_IRQS];
 #endif
 
+extern bool irq_is_nmi(struct irq_desc *desc);
+
 static inline unsigned int irq_desc_kstat_cpu(struct irq_desc *desc,
 					      unsigned int cpu)
 {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 9cd17080b2d8..56a767957a9d 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -955,7 +955,7 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
-static bool irq_is_nmi(struct irq_desc *desc)
+bool irq_is_nmi(struct irq_desc *desc)
 {
 	return desc->istate & IRQS_NMI;
 }
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 6954e0a02047..b3b1b93f0410 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -489,8 +489,13 @@ int show_interrupts(struct seq_file *p, void *v)
 		goto outsparse;
 
 	if (desc->kstat_irqs) {
-		for_each_online_cpu(j)
-			any_count |= data_race(per_cpu(desc->kstat_irqs->cnt, j));
+		if (!irq_settings_is_per_cpu_devid(desc) &&
+		    !irq_settings_is_per_cpu(desc) &&
+		    !irq_is_nmi(desc))
+			any_count = data_race(desc->tot_count);
+		else
+			for_each_online_cpu(j)
+				any_count |= data_race(per_cpu(desc->kstat_irqs->cnt, j));
 	}
 
 	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
-- 
2.37.1 (Apple Git-137.1)


