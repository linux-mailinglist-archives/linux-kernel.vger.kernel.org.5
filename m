Return-Path: <linux-kernel+bounces-65413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017EB854C97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FD71F2138F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF05C90D;
	Wed, 14 Feb 2024 15:24:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36AB5C615;
	Wed, 14 Feb 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924285; cv=none; b=LiEh+jnjVNLmCKQEQHgBa3Ar96ycPyvinv/8PunXOcCQ5n/+ruSXBvHll0SxM+83OYnvu5GmAiT/Gmv+V+3+6scizq+koasZSOqWNLy4X/cpjbf3DypxqOQWL1aNtxdwPcmyvDjg2dHUbPTqrM2e+6Oi0qUhzqBjhAHw4g4J/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924285; c=relaxed/simple;
	bh=L5cnEPgQBCTKATmDrlFkB5ENVPxihI25y/FHUbAZsmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KKXRN0leKqSplbb8E1wFXYLgDUAS+Ez+kDZFt1ipgMCJmopXfi2oLI9LRSWRFHqA2Vz27FEXVnXcTNFfH7hRkMxlj5aj7Y4DYIYOPUEwxz90a6vcag4noMyvvD1y75hS52qMHAGgeHPpN7ZXbPf9bc9Zd/omh3KAlFCd3XuzLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1613C433C7;
	Wed, 14 Feb 2024 15:24:43 +0000 (UTC)
Date: Wed, 14 Feb 2024 10:26:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Kalle Valo <kvalo@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>
Subject: [PATCH] tracing: Inform kmemleak of saved_cmdlines allocation
Message-ID: <20240214102614.1a1405be@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The allocation of the struct saved_cmdlines_buffer structure changed from:

        s = kmalloc(sizeof(*s), GFP_KERNEL);
	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);

to:

	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
	order = get_order(orig_size);
	size = 1 << (order + PAGE_SHIFT);
	page = alloc_pages(GFP_KERNEL, order);
	if (!page)
		return NULL;

	s = page_address(page);
	memset(s, 0, sizeof(*s));

	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);

Where that s->saved_cmdlines allocation looks to be a dangling allocation
to kmemleak. That's because kmemleak only keeps track of kmalloc()
allocations. For allocations that use page_alloc() directly, the kmemleak
needs to be explicitly informed about it.

Add kmemleak_alloc() and kmemleak_free() around the page allocation so
that it doesn't give the following false positive:

unreferenced object 0xffff8881010c8000 (size 32760):
  comm "swapper", pid 0, jiffies 4294667296
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace (crc ae6ec1b9):
    [<ffffffff86722405>] kmemleak_alloc+0x45/0x80
    [<ffffffff8414028d>] __kmalloc_large_node+0x10d/0x190
    [<ffffffff84146ab1>] __kmalloc+0x3b1/0x4c0
    [<ffffffff83ed7103>] allocate_cmdlines_buffer+0x113/0x230
    [<ffffffff88649c34>] tracer_alloc_buffers.isra.0+0x124/0x460
    [<ffffffff8864a174>] early_trace_init+0x14/0xa0
    [<ffffffff885dd5ae>] start_kernel+0x12e/0x3c0
    [<ffffffff885f5758>] x86_64_start_reservations+0x18/0x30
    [<ffffffff885f582b>] x86_64_start_kernel+0x7b/0x80
    [<ffffffff83a001c3>] secondary_startup_64_no_verify+0x15e/0x16b

Link: https://lore.kernel.org/linux-trace-kernel/87r0hfnr9r.fsf@kernel.org/

Fixes: 44dc5c41b5b1 ("tracing: Fix wasted memory in saved_cmdlines logic")
Reported-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_sched_switch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index e4fbcc3bede5..de4182224ea2 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -9,6 +9,7 @@
 #include <linux/kallsyms.h>
 #include <linux/uaccess.h>
 #include <linux/ftrace.h>
+#include <linux/kmemleak.h>
 #include <trace/events/sched.h>
 
 #include "trace.h"
@@ -190,6 +191,7 @@ static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
 	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
 
 	kfree(s->map_cmdline_to_pid);
+	kmemleak_free(s);
 	free_pages((unsigned long)s, order);
 }
 
@@ -210,6 +212,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 
 	s = page_address(page);
 	memset(s, 0, sizeof(*s));
+	kmemleak_alloc(s, size, 1, GFP_KERNEL);
 
 	/* Round up to actual allocation */
 	val = (size - sizeof(*s)) / TASK_COMM_LEN;
-- 
2.43.0


