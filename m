Return-Path: <linux-kernel+bounces-142652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701BC8A2E52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2341C227B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1891545C04;
	Fri, 12 Apr 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR9POcIY"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7404597E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925054; cv=none; b=lhwP0mjxmiYcyZibfPO2M/HRhetxM7x0C1PVX4+f/HOeCmwvDCpeRMkmUwFd0EmDENG8rNeW/X1CA00YrhCFBCznxZ3z+dAOwK14S4/j+yFqp3Wp7vZg5wR8Hj3Synct+YvprqzwqEQi9wOBvfg7XKbpkDWgAAqqYJpt4a2davc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925054; c=relaxed/simple;
	bh=Vb6XdN2lfMY03jDF1qrR94KLXYE49Am0mLjanbcKARo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BnMoEa5Gm53ZQ+UO1n30f9tlfXqyfvQ0d0IXYiAOSi0A9oRhcXFz6XAqYmqXc77lNRnhfKu+57Ecm0RVejBr6AbkfRB7TwiXCWuO7by9Hqvbc9ncpx7VfKXM0DzqAKJvW7PKIoeYsjSkYmSlvDWeFgJ23V9QMH5cRwLPO6ZbzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR9POcIY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed267f2936so726915b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712925052; x=1713529852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBp2pQhn2lVJ6DLLpM94qL9WNtmqnM/dHEgV5vi8MEs=;
        b=XR9POcIYrc/qdZt2gwTgaTHcpbD4dFQzj9Zl5TD/hmYcCSAkCTwmYZkVE9kSbSoDYF
         RiJLR3pRnXimz+/vNTHrDGXBv8fM8q0PX1jK6xMr42gPaepEZixpnmdPiko8pqna5+uk
         dSS86RO9yn+T1NHSp+MrELy1JmF2I4TLiNYEnA2nKMruxBC2HdxOZTAZ9YB5onrb5NJ5
         guDNzui1tz4HhWbeg4a6lFpY9O8pPYBAt/GGQ2bGiR7xVg+f7Dey1QVCQKfyLCvs7Y+T
         VZCxueF8AKkCFi4kSO50em4nCkz1K8WoQvGjZXRsfx8zMuifQ9yJ0g6KnAfuPD6gtv8q
         bZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712925052; x=1713529852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBp2pQhn2lVJ6DLLpM94qL9WNtmqnM/dHEgV5vi8MEs=;
        b=BYwUsTCR4B+zCwuKCREFLdy+6yAXacWGZuXs1u8GcLP+jGjY7HjTPjkHmkG66fl9X0
         C9kadW/MPJuzUjFKWhUSxDTLdtbo/pvB427et0YF7HtacLO9enl90/t0h8gE7Ad8GB3q
         7c/x5jMgXMU1QgmTxLQZPW08XqsjVRI3kv5u0oJueeeXCjrNEKk3iuN2koQitIbnNoVB
         MAQh3rYrpOBJEklrCbeQbh0+zGc3McJg/sx4d7ot2z6Ur1S5Inl5JFeD0vQXWAgDgHat
         s8JCXTSFqmfObeiM6YEx5hbp0NlVPPvnl+RtURWetEyWT3Usn58zi9FurRza0A/gbdIg
         9LgA==
X-Gm-Message-State: AOJu0Yy5JaEVM9M3EgAOdWfdWW9NmAvduBzcbidNKph0ruaUvc4POCpy
	25F29pvNiDhTmSxvHpkEfigfaQYbx9XFsRHzx8VIfb8vkC3a0/eo
X-Google-Smtp-Source: AGHT+IFIUprURx2SnyjUhwDxV4Bh2nvA3DyQ8qZ4jt626IUF0nOKgdRgq8pciGun9s1GWuqw1O8L/g==
X-Received: by 2002:a05:6a20:4309:b0:1a9:9e0f:142b with SMTP id h9-20020a056a20430900b001a99e0f142bmr2619543pzk.39.1712925052106;
        Fri, 12 Apr 2024 05:30:52 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001e520495f51sm2864065plt.124.2024.04.12.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 05:30:51 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	vbabka@suse.cz,
	hannes@cmpxchg.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [RFC PATCH] mm/vmstat: sum up all possible CPUs instead of using vm_events_fold_cpu
Date: Sat, 13 Apr 2024 00:30:39 +1200
Message-Id: <20240412123039.442743-1-21cnbao@gmail.com>
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
 -v1:
 originally suggested by Ryan while he reviewed mTHP counters
 patchset[1]; I am also applying this suggestion to vm_events

 [1] https://lore.kernel.org/linux-mm/ca73cbf1-8304-4790-a721-3c3a42f9d293@arm.com/

 include/linux/vmstat.h |  5 -----
 mm/page_alloc.c        |  8 --------
 mm/vmstat.c            | 19 +------------------
 3 files changed, 1 insertion(+), 31 deletions(-)

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
index b51becf03d1e..640d5752e400 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5832,14 +5832,6 @@ static int page_alloc_cpu_dead(unsigned int cpu)
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
index db79935e4a54..bae6ff476870 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -114,7 +114,7 @@ static void sum_vm_events(unsigned long *ret)
 
 	memset(ret, 0, NR_VM_EVENT_ITEMS * sizeof(unsigned long));
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct vm_event_state *this = &per_cpu(vm_event_states, cpu);
 
 		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
@@ -135,23 +135,6 @@ void all_vm_events(unsigned long *ret)
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


