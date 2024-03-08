Return-Path: <linux-kernel+bounces-96506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3EA875D34
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D94B21816
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC9F2DF73;
	Fri,  8 Mar 2024 04:36:06 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455518E01
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709872566; cv=none; b=SKMYVHLPWv8fWhW73jZ79+lio38P80ZkIE+XOV3aHH5ugTvkxSt5tiTdUDYKbV+Ccy5SED2hi8bZGuCe3nPxh2EC1gFB0BlJJKJNzdiy0zdafUK/aMi6bCTt8bllNvTVWANQYo0NDVWDVoXoJgOhF1SH+Sz7w/DQwkj3SQOrgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709872566; c=relaxed/simple;
	bh=0usxjDEZiIZM0VtulQTH8zHq7XHMasZx1wCE2IspjoY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ENjZAIR0eSE8W7qXoTqHTsmp0OfycckXvS4savTF0lqrU2ahXQ9FhP5fcNxSSS1rs1T9vMml34OOHGU2FlwVJum1UE9C4+myVPgw6Ia3xF5kj7Vl57LVQC4S/y7jJTEs5Bx5H4TU8joaCN/4ZUGe19M5LobnVGUT8nncHvkVSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TrYFn5DkPz1h1Zw;
	Fri,  8 Mar 2024 12:33:33 +0800 (CST)
Received: from kwepemd100005.china.huawei.com (unknown [7.221.188.91])
	by mail.maildlp.com (Postfix) with ESMTPS id 34A9E14011B;
	Fri,  8 Mar 2024 12:35:56 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100005.china.huawei.com (7.221.188.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 12:35:55 +0800
Received: from M910t (10.110.54.157) by kwepemd100011.china.huawei.com
 (7.221.188.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 8 Mar
 2024 12:35:55 +0800
Date: Fri, 8 Mar 2024 12:34:48 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
CC: <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <changbin.du@huawei.com>
Subject: [BUG] kmsan: instrumentation recursion problems
Message-ID: <20240308043448.masllzeqwht45d4j@M910t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

Hey, folks,
I found two instrumentation recursion issues on mainline kernel.

1. recur on preempt count.
__msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> preempt_disable() -> __msan_metadata_ptr_for_load_4()

2. recur in lockdep and rcu
__msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> pfn_valid() -> rcu_read_lock_sched() -> lock_acquire() -> rcu_is_watching() -> __msan_metadata_ptr_for_load_8()


Here is an unofficial fix, I don't know if it will generate false reports.

$ git show
commit 7f0120b621c1cbb667822b0f7eb89f3c25868509 (HEAD -> master)
Author: Changbin Du <changbin.du@huawei.com>
Date:   Fri Mar 8 20:21:48 2024 +0800

    kmsan: fix instrumentation recursions

    Signed-off-by: Changbin Du <changbin.du@huawei.com>

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0db4093d17b8..ea925731fa40 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -7,6 +7,7 @@ obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o

 # Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
 KCSAN_SANITIZE_lockdep.o := n
+KMSAN_SANITIZE_lockdep.o := n

 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2bccfd37c38..8935cc866e2d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -692,7 +692,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
  * Make notrace because it can be called by the internal functions of
  * ftrace, and making this notrace removes unnecessary recursion calls.
  */
-notrace bool rcu_is_watching(void)
+notrace __no_sanitize_memory bool rcu_is_watching(void)
 {
        bool ret;

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..33aa4df8fd82 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5848,7 +5848,7 @@ static inline void preempt_latency_start(int val)
        }
 }

-void preempt_count_add(int val)
+void __no_sanitize_memory preempt_count_add(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
        /*
@@ -5880,7 +5880,7 @@ static inline void preempt_latency_stop(int val)
                trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }

-void preempt_count_sub(int val)
+void __no_sanitize_memory preempt_count_sub(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT


-- 
Cheers,
Changbin Du

