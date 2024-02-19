Return-Path: <linux-kernel+bounces-71247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CAB85A270
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E741F2632F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E12D04A;
	Mon, 19 Feb 2024 11:48:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A4D34CFF;
	Mon, 19 Feb 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343333; cv=none; b=plIHavBpDfdUik3Y5VIXI1RL1zjVQDlUFC0bUEPVptMRSnUp0v2/+TdEjaJiESCFHJ1QK/TpHboaR/OX28U2prneF1yf9yiBtWtecehkM2BALNFlzZeaQoE7fvwP252QTeWv11blvOUhicdCj9bW8rSA5/4yWLXtboKVePIJNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343333; c=relaxed/simple;
	bh=8vfBdAUdcC5/jUyUyf3YuQWzc34sXBUJ6eDjZ3kQmws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auyxFxjl+cumNiLRCisM8cTxPMnR4TGnLYZQL/c/VOsyoAFO9n8WZfsmaLVTpEgkxSZtLHQshEaUt8wtlgbvZfQGEQnCj0Az5sABe5EtryzPNNQ+L/NCtTaqsj+RydR3NNwZxqoHt+JgDMXspQA9OHVLiaPTc958bcDairlX4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EACBC433C7;
	Mon, 19 Feb 2024 11:48:51 +0000 (UTC)
Date: Mon, 19 Feb 2024 11:48:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] tracing: Inform kmemleak of saved_cmdlines allocation
Message-ID: <ZdNAIJGSWqTItD6b@arm.com>
References: <20240214102614.1a1405be@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214102614.1a1405be@gandalf.local.home>

On Wed, Feb 14, 2024 at 10:26:14AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The allocation of the struct saved_cmdlines_buffer structure changed from:
> 
>         s = kmalloc(sizeof(*s), GFP_KERNEL);
> 	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);
> 
> to:
> 
> 	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
> 	order = get_order(orig_size);
> 	size = 1 << (order + PAGE_SHIFT);
> 	page = alloc_pages(GFP_KERNEL, order);
> 	if (!page)
> 		return NULL;
> 
> 	s = page_address(page);
> 	memset(s, 0, sizeof(*s));
> 
> 	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);
> 
> Where that s->saved_cmdlines allocation looks to be a dangling allocation
> to kmemleak. That's because kmemleak only keeps track of kmalloc()
> allocations. For allocations that use page_alloc() directly, the kmemleak
> needs to be explicitly informed about it.
> 
> Add kmemleak_alloc() and kmemleak_free() around the page allocation so
> that it doesn't give the following false positive:
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
> Link: https://lore.kernel.org/linux-trace-kernel/87r0hfnr9r.fsf@kernel.org/
> 
> Fixes: 44dc5c41b5b1 ("tracing: Fix wasted memory in saved_cmdlines logic")
> Reported-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

