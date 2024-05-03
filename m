Return-Path: <linux-kernel+bounces-167170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4178BA52F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB101C21C93
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A684013FF9;
	Fri,  3 May 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaoXL8/I"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016F134AC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702185; cv=none; b=mf4UqF9C/OnROtKxTL7bX3hYdmp4rag1JYsR7Vq04qKfKOxTLzLUBRJswtZqm6CmiGppY5gEu7tVaLjr/xQ22UD1iznJ5Xq6WZfkUWySRL+2ZolamJ/zYIF3qLibXt+MxYzLZpkBNkzynHPvd6gCWUa4VWJXJdJUp5BhQL9CmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702185; c=relaxed/simple;
	bh=72l7FcdnMU0yqbmlOscAZ663pKztg2XZDlvV+3fdybE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sqs2rxMhOs6d6DIVXsvCoWseq7gTrhlM/eKafSP0h6FLPEjN9Of5S9ybNelFz9Z7Kp/7IKbtqy+52I6c45CjpJSQAAvrWYDwVpNiHCnP3pc0Y4Cvwe9KD9I7Ml7vicfhntPGK0CyiMGRXGYVvsw31VXsODrBrHRDSyl3L6cKOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaoXL8/I; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f42924ca64so1928708b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 19:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714702184; x=1715306984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhL5IMfR/PIPcId0PwjBlUn/OiNG0ZYahayTjuFweeU=;
        b=VaoXL8/IB68c8WLMF9bJDEYB4fjb7SoCsZ+8+mVmZ0joNLeHVEttXtFpZDUd2reGjQ
         Ll6Rz/uXMPL4B4t7T9ZNCXVbUi30ZOzcnVyZZaOXbzdCUCgcERN6uu2mB+Gey9NegCZ5
         yZZ8Oe87ceEGxD3c5lH0JEbUJPmmOfBZpgzcHqxJjpnvz2OSJC/FUZGp6Q8CZOBcNNyv
         aKyz1srHzEbQFnlbZgVQKyug5SSz3giuMEAxyV3e5GF6VHc71ag8jTzwz9EphRFO06LD
         gGQYUw/bnPF7XEqZtBW3OEf8I45kh6SXLWVnxGLrn53k1/4YEY0xAlz4yAmhYijLs9Kb
         oYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714702184; x=1715306984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhL5IMfR/PIPcId0PwjBlUn/OiNG0ZYahayTjuFweeU=;
        b=T9rwU+nWQs1tji67o2AYMQh0h7NQHSGdhSQ+DGs2DUZs6aRdhfwamj8xsf3YDg0F5g
         Mw961lOrNVI4NtF1CrX1JwaBS65ak8QIKhjTEK0lrO3Lu2DLzdHrCY2sVK7bbAqde5gy
         wDtkB2Qrd3lnrBPQyP86kju6HTn/7Xz/KUvZfuArFu4AvNCL7ttem2+VOJLB17CUtkjO
         uOS0F5rEoT7UEGPUM5yDzwBi+p76rSXpKIxTu1ON23UsKrNbaDXysDXOzcjaqg7kpBpL
         zEHbMY0G7a3fot3McpQUnhmS0VOS15EXTG36TTtpxmtgrSx/BK2wb4ZHDAQTpCXvAU/c
         NLDA==
X-Forwarded-Encrypted: i=1; AJvYcCU8tK/mra+4upSY2U3mrzPuO9WPKX6nYyIydwTLZXflZbcaEmASZVXhfkMszNCIQXf15wdniW5uYQ5nndlpwYZnT4a61FXkNmnltASq
X-Gm-Message-State: AOJu0YxDz74glENwh1iOPLg6RRCbFJC5BMjEfM3rLFCRwGZOXjWKXkvA
	l2/raHO2/HKQ6EWAX//N2g/BCQc6OslXNHsD4WYcu5iDJ2dvBDKO
X-Google-Smtp-Source: AGHT+IGFfHVy5fUogSlRJyYhQr2KateAeFxl34nAMUxN7ZvfwM5gWink+XTgnMZ4VmD4Jc0as7TrVA==
X-Received: by 2002:a05:6a00:464e:b0:6f3:ebb3:6bc3 with SMTP id kp14-20020a056a00464e00b006f3ebb36bc3mr1600958pfb.3.1714702183461;
        Thu, 02 May 2024 19:09:43 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id p8-20020a056a000a0800b006ecc6c1c67asm1956160pfh.215.2024.05.02.19.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 19:09:43 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	willy@infradead.org
Subject: [PATCH v2] mm/vmstat: sum up all possible CPUs instead of using vm_events_fold_cpu
Date: Fri,  3 May 2024 14:09:24 +1200
Message-Id: <20240503020924.208431-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When unplugging a CPU, the current code merges its vm_events
with an online CPU. Because, during summation, it only considers
online CPUs, which is a crude workaround. By transitioning to
summing up all possible CPUs, we can eliminate the need for
vm_events_fold_cpu.

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 originally suggested by Ryan while he reviewed mTHP counters
 patchset[1]; I am also applying this suggestion to vm_events

 -v2:
 also drop cpus_read_lock() as we don't care about cpu hotplug any more;
 -v1:
 https://lore.kernel.org/linux-mm/20240412123039.442743-1-21cnbao@gmail.com/

 [1] https://lore.kernel.org/linux-mm/ca73cbf1-8304-4790-a721-3c3a42f9d293@arm.com/

 include/linux/vmstat.h |  5 -----
 mm/page_alloc.c        |  8 --------
 mm/vmstat.c            | 21 +--------------------
 3 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 735eae6e272c..f7eaeb8bfa47 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -83,8 +83,6 @@ static inline void count_vm_events(enum vm_event_item item, long delta)
 
 extern void all_vm_events(unsigned long *);
 
-extern void vm_events_fold_cpu(int cpu);
-
 #else
 
 /* Disable counters */
@@ -103,9 +101,6 @@ static inline void __count_vm_events(enum vm_event_item item, long delta)
 static inline void all_vm_events(unsigned long *ret)
 {
 }
-static inline void vm_events_fold_cpu(int cpu)
-{
-}
 
 #endif /* CONFIG_VM_EVENT_COUNTERS */
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cd584aace6bf..8b56d785d587 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5826,14 +5826,6 @@ static int page_alloc_cpu_dead(unsigned int cpu)
 	mlock_drain_remote(cpu);
 	drain_pages(cpu);
 
-	/*
-	 * Spill the event counters of the dead processor
-	 * into the current processors event counters.
-	 * This artificially elevates the count of the current
-	 * processor.
-	 */
-	vm_events_fold_cpu(cpu);
-
 	/*
 	 * Zero the differential counters of the dead processor
 	 * so that the vm statistics are consistent.
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..aaa32418652e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -114,7 +114,7 @@ static void sum_vm_events(unsigned long *ret)
 
 	memset(ret, 0, NR_VM_EVENT_ITEMS * sizeof(unsigned long));
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct vm_event_state *this = &per_cpu(vm_event_states, cpu);
 
 		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
@@ -129,29 +129,10 @@ static void sum_vm_events(unsigned long *ret)
 */
 void all_vm_events(unsigned long *ret)
 {
-	cpus_read_lock();
 	sum_vm_events(ret);
-	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(all_vm_events);
 
-/*
- * Fold the foreign cpu events into our own.
- *
- * This is adding to the events on one processor
- * but keeps the global counts constant.
- */
-void vm_events_fold_cpu(int cpu)
-{
-	struct vm_event_state *fold_state = &per_cpu(vm_event_states, cpu);
-	int i;
-
-	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
-		count_vm_events(i, fold_state->event[i]);
-		fold_state->event[i] = 0;
-	}
-}
-
 #endif /* CONFIG_VM_EVENT_COUNTERS */
 
 /*
-- 
2.34.1


