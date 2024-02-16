Return-Path: <linux-kernel+bounces-67942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D9857360
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8192886F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E65AD27A;
	Fri, 16 Feb 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUhZx22k"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41797944E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046609; cv=none; b=NNJ5UqGfcZM1Q/1sETmFUW5LyhYBs/JZmqEk49/X60+cVuis9Z7cSn8aO8nN7SUqM8D7p5LNJT+dqTVQnALWk2Ssn1htJjGrgw+WDPZC6Lg4lESfLJRZ3rqAWyuH1FjmHSj/tLsj680oGW4wwwawj2WJ6T7WjFdm6yqrr9Ngu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046609; c=relaxed/simple;
	bh=0JHR3l9DN+fqhDtNvHdRw7p9tn4xLAVfjDU4V2u4tYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiILm1ADp9UwQjTzksDIul6COFuWokc5vW9TEyWu97H+jCanvfc6/5gtt+SQVRUEh0m270ilqJSjWZheimWDuBsnoUItl6pca9oeByQTTJuE39kSNvpcrSHiNsqvGl9gkinRZT6VILkH+Z26VC2rTTw67h2KUmUNwrMHMCiCbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUhZx22k; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dba6b9b060so1547835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708046607; x=1708651407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQ5UD7DqCV9seyvUktDYlJY7urQZU6nmp/cILwGa/sc=;
        b=AUhZx22kx7QJevlZKx641WpJpnk8QHsz5DKZKvnafnXcz6MtnCOK0EGUSNqmN35Oqv
         RWN9qLeVnobD+sLW7a38ZI8beKSgyuyEUPojXuVt/m4FkxpBgQzasgNajr4sV8xn0sbS
         cR3NGXTumewjUrEYi3LhriPmrZTRcLdYDnvE/5orZ4uThOMWqLaZcJUfmGp/d8yR4a5n
         lLS46MLVEHb/SnyX9+W5Gp2oTUctk46ZKaRWi+gaxu9jJTQlKG0tUZJf1Udsa0hzHVWm
         rQqJptWEM9FWOSgw+5fJgT+ULO69uAVQMRBht5HP/n7Uab2J7xuS7G6s5oIBcZOb4wX5
         mEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708046607; x=1708651407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ5UD7DqCV9seyvUktDYlJY7urQZU6nmp/cILwGa/sc=;
        b=UMyTyFe86kzGjVr3X37NDWzC4Kn98KBgDJKN75P8hYHDBiJQAAzdqTPtjvAS2kBUDt
         n8ZWtUvyBmmQRhJqYS7P/rcKXuRY/+gCG1t7kRo07NhIV6tZuTIS/ZzntAl/T3QYfxOA
         NxLKT8T6vZvuxYbxlFH6nwYL3o7o4JJTH/lR6dyVazUB/5enl7faSgXxhDr+HVtcfvgB
         ZqpczrpZay6piz5PZHaGsc1XT6lCOINbprc/WI4t9KNE5iLGOV+A+ARXLuhUAZf4F820
         LLGFIuSNbFRxzgzPdeXrM+WqguFD5sUDHtFe6fYJl+5THnHRYG4T+8cIwhxHi3M5FhTM
         L24g==
X-Gm-Message-State: AOJu0YwsD/49NurLbkeC7POZGr7Zi8BbfpX/H1HHFiZHzPy+PHWFMl0W
	O0wt2zjUaCyYvWQ6y1GKD5mWdcCF0qLEP4s1Xdjyhfq3XqmS02ySjRD1N5Tew58=
X-Google-Smtp-Source: AGHT+IGIIEviTsZP0A4QNJz+fvZDucgOEcyIFRfpSAZFKEWknF3bXpKb3kQJA249C+/Tq+epxwiEqw==
X-Received: by 2002:a17:902:d491:b0:1db:8f88:8d83 with SMTP id c17-20020a170902d49100b001db8f888d83mr3882661plg.15.1708046607315;
        Thu, 15 Feb 2024 17:23:27 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id im9-20020a170902bb0900b001d9aa663282sm1902826plb.266.2024.02.15.17.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 17:23:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 15 Feb 2024 15:23:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH wq/for-6.9] workqueue, irq_work: Build fix for
 !CONFIG_IRQ_WORK
Message-ID: <Zc65DUZKIx5IIgrX@slm.duckdns.org>
References: <Zc0IzeM6tAvm1NTl@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc0IzeM6tAvm1NTl@mtj.duckdns.org>

From 9d6efa8d0dd012db22958a225246812441b25405 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 15 Feb 2024 15:02:30 -1000

2f34d7337d98 ("workqueue: Fix queue_work_on() with BH workqueues") added
irq_work usage to workqueue; however, it turns out irq_work is actually
optional and the change breaks build on configuration which doesn't have
CONFIG_IRQ_WORK enabled.

Fix build by making workqueue use irq_work only when CONFIG_SMP and enabling
CONFIG_IRQ_WORK when CONFIG_SMP is set. It's reasonable to argue that it may
be better to just always enable it. However, this still saves a small bit of
memory for tiny UP configs and also the least amount of change, so, for now,
let's keep it conditional.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 2f34d7337d98 ("workqueue: Fix queue_work_on() with BH workqueues")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
---
Hello,

As this is breaking build for some configs, I'll apply this to wq/for-6.9.
If there's any objection, please let me know. I'll back out and work on a
different approach.

Thanks.

 init/Kconfig       |  2 ++
 kernel/workqueue.c | 24 +++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8df18f3a9748..41be05a8ba5e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -107,6 +107,8 @@ config CONSTRUCTORS
 
 config IRQ_WORK
 	bool
+	depends on SMP
+	default y
 
 config BUILDTIME_TABLE_SORT
 	bool
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 04e35dbe6799..6ae441e13804 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1209,6 +1209,20 @@ static struct irq_work *bh_pool_irq_work(struct worker_pool *pool)
 	return &per_cpu(bh_pool_irq_works, pool->cpu)[high];
 }
 
+static void kick_bh_pool(struct worker_pool *pool)
+{
+#ifdef CONFIG_SMP
+	if (unlikely(pool->cpu != smp_processor_id())) {
+		irq_work_queue_on(bh_pool_irq_work(pool), pool->cpu);
+		return;
+	}
+#endif
+	if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+		raise_softirq_irqoff(HI_SOFTIRQ);
+	else
+		raise_softirq_irqoff(TASKLET_SOFTIRQ);
+}
+
 /**
  * kick_pool - wake up an idle worker if necessary
  * @pool: pool to kick
@@ -1227,15 +1241,7 @@ static bool kick_pool(struct worker_pool *pool)
 		return false;
 
 	if (pool->flags & POOL_BH) {
-		if (likely(pool->cpu == smp_processor_id())) {
-			if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
-				raise_softirq_irqoff(HI_SOFTIRQ);
-			else
-				raise_softirq_irqoff(TASKLET_SOFTIRQ);
-		} else {
-			irq_work_queue_on(bh_pool_irq_work(pool), pool->cpu);
-		}
-
+		kick_bh_pool(pool);
 		return true;
 	}
 
-- 
2.43.2


