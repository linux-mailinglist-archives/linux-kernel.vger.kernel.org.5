Return-Path: <linux-kernel+bounces-65428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA18854CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46729B28B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230DF5F845;
	Wed, 14 Feb 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYt6Wjdc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD95A785;
	Wed, 14 Feb 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924644; cv=none; b=IuL5cZJoYnb22dx6/93CuBKalCa1KTvs5qtgdvGg5vks2HL1QLAf25WKLaQCjuF60lC8Td8KnY08pGb/4z4OBU+Cnhmoo3LdhERxCzVH8oKMo7ge2ylybDcN5IK2nkLcSHbBd40S0hQwGZ2uTzpEwi1K4H0w+RaQqIJwHS2+Rp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924644; c=relaxed/simple;
	bh=oaDfMgX7jA4rJYpXSLq7LkCkF/VhsccfGzmr4lYdP5o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eHzqt6HWsKW+7xMqNII7hXKlDopntBTMgFsxREagnCRvcLVQSA69gz1FJ4FXibOlMlHTbUq4F2a3FFv8vWzcBtBQYAESnMxkN7q85SBekI/l4EGqsRtkEWca4RuYjXxKs7yIGCrtXnOT2JFBIypYu1oVesWYUV5G2/inFuEde1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYt6Wjdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934B4C433C7;
	Wed, 14 Feb 2024 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707924643;
	bh=oaDfMgX7jA4rJYpXSLq7LkCkF/VhsccfGzmr4lYdP5o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eYt6WjdcPNZTMI0OJKu8MjI+o57ukyuk9v7ZzrfkyFXNZvyWopZVtrBKiiLFW4jMO
	 DyjiMgGuDqV12pcm+4+EDRV2K6Lq/SMDyb8cMGeYuC59M7Sj3zURLaQ2yLf4J0E4Fu
	 dexHynPaWg2PKdd56qdfTtRNJnBV7/GEWvefIRP1KSxz7L6V/Po1GY0mgkhA1a3bGU
	 rbDjvyWmxej9Yr6b+QE4EmUm9y5BVMoPmxIclKB3m2qCYMCZikN8+EEsCQ0yF1aO1o
	 0BNu5IAHrP31+b8r/MKiiP4ZcjrzWUqW2/hWoZ0wSJHy7SeL2h+jZOFBi2U8wUKsU/
	 3IE83WTtolsJA==
From: Kalle Valo <kvalo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: regressions@lists.linux.dev,  linux-kernel@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org,  Jeff Johnson
 <quic_jjohnson@quicinc.com>
Subject: Re: [regression] tracing: kmemleak warning in
 allocate_cmdlines_buffer()
References: <87r0hfnr9r.fsf@kernel.org>
	<20240214094617.1e6ec684@gandalf.local.home>
Date: Wed, 14 Feb 2024 17:30:40 +0200
In-Reply-To: <20240214094617.1e6ec684@gandalf.local.home> (Steven Rostedt's
	message of "Wed, 14 Feb 2024 09:46:17 -0500")
Message-ID: <87mss3njvj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 14 Feb 2024 14:50:56 +0200
> Kalle Valo <kvalo@kernel.org> wrote:
>
>> Hi Steven,
>> 
>> I upgraded our ath11k test setup to v6.8-rc4 and noticed a new kmemleak
>> warning in the log:
>
> Thanks for the report.
>
>> 
>> unreferenced object 0xffff8881010c8000 (size 32760):
>>   comm "swapper", pid 0, jiffies 4294667296
>>   hex dump (first 32 bytes):
>>     ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>     ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>   backtrace (crc ae6ec1b9):
>>     [<ffffffff86722405>] kmemleak_alloc+0x45/0x80
>>     [<ffffffff8414028d>] __kmalloc_large_node+0x10d/0x190
>>     [<ffffffff84146ab1>] __kmalloc+0x3b1/0x4c0
>>     [<ffffffff83ed7103>] allocate_cmdlines_buffer+0x113/0x230
>>     [<ffffffff88649c34>] tracer_alloc_buffers.isra.0+0x124/0x460
>>     [<ffffffff8864a174>] early_trace_init+0x14/0xa0
>>     [<ffffffff885dd5ae>] start_kernel+0x12e/0x3c0
>>     [<ffffffff885f5758>] x86_64_start_reservations+0x18/0x30
>>     [<ffffffff885f582b>] x86_64_start_kernel+0x7b/0x80
>>     [<ffffffff83a001c3>] secondary_startup_64_no_verify+0x15e/0x16b
>> 
>> I don't see this warning in v6.8-rc3 and also reverting commit
>> 44dc5c41b5b1 ("tracing: Fix wasted memory in saved_cmdlines logic")
>> makes the warning go away. Let me know if you need more info or help
>> with testing, I see the warning every time so it's easy to reproduce.
>> 
>
> Hmm, I changed the code a bit and I wonder if this is a false positive?
>
> Instead of allocating the structure via kmalloc() I now use it as part of a
> page.
>
> That is, the old code had:
>
>         s = kmalloc(sizeof(*s), GFP_KERNEL);
> 	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);
>
> Where as the new code has:
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
>
> Does kmemleak handle structures that are assigned to alloc_pages()
> allocations? I don't think it does.
>
> I think we need to inform kmemleak about this. Does the following patch fix
> this for you?

It does, thank you!

Tested-by: Kalle Valo <kvalo@kernel.org>

> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index e4fbcc3bede5..de4182224ea2 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c

Although the patch didn't apply for me as in my tree the functions are
in kernel/trace/trace.c. I don't know what happened so as a quick hack I
just manually added the three lines to my version of trace.c. Let me
know if there's a git tree or branch you would like me to test, I can do
that easily.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

