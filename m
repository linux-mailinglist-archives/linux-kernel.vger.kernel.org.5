Return-Path: <linux-kernel+bounces-65796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB888551F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BE01F20984
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77715127B7E;
	Wed, 14 Feb 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5CIfjXE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5AB126F3E;
	Wed, 14 Feb 2024 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934825; cv=none; b=dlQCG1zLvILkf6dOP2C/5uoX0xV+VgH1ZILQSV5rNSXVuNuTn7xs/SiVYM0kzETXaYcGYJStZ7D7+qLe1DgXA+Qmlxm5X0PinbXJxiG27PYz1Cif23S4U0c2n50A6vDBLzEm52vPNLOZ7xDpJRXdeL3whk4n/CTJ3NAP8/qJy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934825; c=relaxed/simple;
	bh=PTX79Fr3Yf/DKhXSG/icIh5ogvuh9dWkZkc8teuKW4E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kqHtY5lKxoeC+jbiG2OY49JkLrXD0vx9qb6lyvkzb4NjblK2CvDWaKQMnmRLZDVGqXxknpI9uCz9abQZpXkkWIA1unVyNM9QRMHRRmfpMd+NvdM6tyksSAcU/BxklSx2a5/qUnNFOF+OkAiAH3zz7QXtoPrengIpBfkwShF8U2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5CIfjXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2B9C433F1;
	Wed, 14 Feb 2024 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934825;
	bh=PTX79Fr3Yf/DKhXSG/icIh5ogvuh9dWkZkc8teuKW4E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=f5CIfjXEf/R3e29WGZgQL5Ic1GDWj9c9ATaExeXZTj1Z1BIbKf1vaupXlV0iZDvJu
	 iSnhd5pygx5Rp9TkwUbMyUKk66RGhwUMhbfVUrrizT93QVLfxmTBfe4bA8DUF+t2nG
	 2BMSD0wJRhr3W4jVBzjRLr0QBRMCA4PIBozcoRao9S0TSwt95rWk4452JQDJILgjKS
	 jBGMddxBwpqjnqv1svtf7bbVhAenqlbtMqp8EQPRT5YQyqukTsZj3IUFCrwim5aTDb
	 ser88cs2bmUhM08+gXSdG7iT7L0rMGsQsEmBB6cLEKUCpkPdrBik3pD7l8I7tXXCbj
	 /zlg3wHVpeMKg==
From: Kalle Valo <kvalo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>,  Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Catalin Marinas
 <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] tracing: Inform kmemleak of saved_cmdlines allocation
References: <20240214112046.09a322d6@gandalf.local.home>
Date: Wed, 14 Feb 2024 20:20:22 +0200
In-Reply-To: <20240214112046.09a322d6@gandalf.local.home> (Steven Rostedt's
	message of "Wed, 14 Feb 2024 11:20:46 -0500")
Message-ID: <87h6iaewm1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

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
> Tested-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Applies cleanly to v6.8-rc4 and I don't see the leak anymore, thank you
for fixing it so quickly!

Tested-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

