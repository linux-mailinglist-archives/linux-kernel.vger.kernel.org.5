Return-Path: <linux-kernel+bounces-98758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4007E877EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7204A1C2132F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90B3C478;
	Mon, 11 Mar 2024 11:24:35 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57343BBF6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156275; cv=none; b=HPOnSHQyzWB+cxbJ2jC4lmL3wn5lusCwVXfWcNmYkD+bIknbslNMwvrx8eOSBC85fzhMRSI8UIP7cWT2jLUvhoi+WoRw8jh4k3FuChBFfrte4cmtJnMi4x0pCbs28hQ/lEYs/Y4rcRWkEM5JyG2x4b9G36AmQKGlZHomnPzijN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156275; c=relaxed/simple;
	bh=87WVZ0PBli/RXm37Y5K39EPeq7giUbkZeUO+FJta81g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LTLMhNAk3qD/TzlioIA5NEjEyOGlIzJUAsaYXzej/3Mav5zTqFuYNlamo15OIu43HK10RDKDTxTZiqhYcpOGW2JJBbP6noYYysPMpXg6IGyqoTaEKZSrWI08XgCNHuffkZJIHxvFE35jve5F+JaBbNt5illMAueHLWcegL9ou4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TtZB80BlGz1Q9YQ;
	Mon, 11 Mar 2024 19:22:24 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CBB81400F4;
	Mon, 11 Mar 2024 19:24:28 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 11 Mar 2024 19:24:26 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, <kasan-dev@googlegroups.com>,
	<linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>, Marco
 Elver <elver@google.com>
Subject: [PATCH] mm: kmsan: fix instrumentation recursion on preempt_count
Date: Mon, 11 Mar 2024 19:23:30 +0800
Message-ID: <20240311112330.372158-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100011.china.huawei.com (7.221.188.204)

This disables msan check for preempt_count_{add,sub} to fix a
instrumentation recursion issue on preempt_count:

  __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() ->
	preempt_disable() -> __msan_metadata_ptr_for_load_4()

With this fix, I was able to run kmsan kernel with:
  o CONFIG_DEBUG_KMEMLEAK=n
  o CONFIG_KFENCE=n
  o CONFIG_LOCKDEP=n

KMEMLEAK and KFENCE generate too many false positives in unwinding code.
LOCKDEP still introduces instrumenting recursions issue. But these are
other issues expected to be fixed.

Cc: Marco Elver <elver@google.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..5b63bb98e60a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5848,7 +5848,7 @@ static inline void preempt_latency_start(int val)
 	}
 }
 
-void preempt_count_add(int val)
+void __no_kmsan_checks preempt_count_add(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -5880,7 +5880,7 @@ static inline void preempt_latency_stop(int val)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }
 
-void preempt_count_sub(int val)
+void __no_kmsan_checks preempt_count_sub(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
-- 
2.25.1


