Return-Path: <linux-kernel+bounces-65355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7166854BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7923B289F56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116555A7A4;
	Wed, 14 Feb 2024 14:44:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5295A4FD;
	Wed, 14 Feb 2024 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921887; cv=none; b=AMgtsnMz1SvKWIztpEhczSIFbMH/FKM8rq3DvEpUGWAmLbA5tEcGKZ6JTwwiaCSBRxBSEmUjdWfpqy8TyzNet6XJxHkPPEse3fzucI9tvKUpFtoi0+C+7+xOHnTpCnnR05/p4y5AhUg5ooycyUX/L3DeqvjLqZVi73x7xAoSgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921887; c=relaxed/simple;
	bh=Q9eBesZ5QD6ZC02ZVDqG4p5BGWCeCIzNlp1bEssnMFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDLu0DGmjclzm9uuxi4lUUbs3MtzQJDpMZR+5F8zS4PN03HRAFEbsiQzMZxa5d7vrMx6FdWC+RGz1s2vaD51LbW1n1B0TDGVwGqlt38M/m3mWukjc4XZSPvbpbqaKiL2FyAFgQnnV/0S39uViBsBsdEo//nzpxkZ1XUWbe9uAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816B7C433F1;
	Wed, 14 Feb 2024 14:44:46 +0000 (UTC)
Date: Wed, 14 Feb 2024 09:46:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>
Subject: Re: [regression] tracing: kmemleak warning in
 allocate_cmdlines_buffer()
Message-ID: <20240214094617.1e6ec684@gandalf.local.home>
In-Reply-To: <87r0hfnr9r.fsf@kernel.org>
References: <87r0hfnr9r.fsf@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 14:50:56 +0200
Kalle Valo <kvalo@kernel.org> wrote:

> Hi Steven,
> 
> I upgraded our ath11k test setup to v6.8-rc4 and noticed a new kmemleak
> warning in the log:

Thanks for the report.

> 
> unreferenced object 0xffff8881010c8000 (size 32760):
>   comm "swapper", pid 0, jiffies 4294667296
>   hex dump (first 32 bytes):
>     ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>     ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>   backtrace (crc ae6ec1b9):
>     [<ffffffff86722405>] kmemleak_alloc+0x45/0x80
>     [<ffffffff8414028d>] __kmalloc_large_node+0x10d/0x190
>     [<ffffffff84146ab1>] __kmalloc+0x3b1/0x4c0
>     [<ffffffff83ed7103>] allocate_cmdlines_buffer+0x113/0x230
>     [<ffffffff88649c34>] tracer_alloc_buffers.isra.0+0x124/0x460
>     [<ffffffff8864a174>] early_trace_init+0x14/0xa0
>     [<ffffffff885dd5ae>] start_kernel+0x12e/0x3c0
>     [<ffffffff885f5758>] x86_64_start_reservations+0x18/0x30
>     [<ffffffff885f582b>] x86_64_start_kernel+0x7b/0x80
>     [<ffffffff83a001c3>] secondary_startup_64_no_verify+0x15e/0x16b
> 
> I don't see this warning in v6.8-rc3 and also reverting commit
> 44dc5c41b5b1 ("tracing: Fix wasted memory in saved_cmdlines logic")
> makes the warning go away. Let me know if you need more info or help
> with testing, I see the warning every time so it's easy to reproduce.
> 

Hmm, I changed the code a bit and I wonder if this is a false positive?

Instead of allocating the structure via kmalloc() I now use it as part of a
page.

That is, the old code had:

        s = kmalloc(sizeof(*s), GFP_KERNEL);
	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);

Where as the new code has:

	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
	order = get_order(orig_size);
	size = 1 << (order + PAGE_SHIFT);
	page = alloc_pages(GFP_KERNEL, order);
	if (!page)
		return NULL;

	s = page_address(page);
	memset(s, 0, sizeof(*s));

	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);


Does kmemleak handle structures that are assigned to alloc_pages()
allocations? I don't think it does.

I think we need to inform kmemleak about this. Does the following patch fix
this for you?

-- Steve

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

