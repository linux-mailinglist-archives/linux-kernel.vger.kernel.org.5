Return-Path: <linux-kernel+bounces-137716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63389E651
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF95284D11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098B5159207;
	Tue,  9 Apr 2024 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRkTDG+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467571591F1;
	Tue,  9 Apr 2024 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706244; cv=none; b=JK2/CouzBU0oHG6CHvxDy73yoGH9sQ0CzCxtmD9MUX6Cj/d+NM7QWJnrHaDg//Jxa4+98YT2EAInH7Fe711KNAVWlCuYJu4qoE1v8aHIEUqHOfIWvhksykG6FJS98C5ue4w4e7inh62Q5cVIXJD1g1ONGApIZNllEiJn6adMKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706244; c=relaxed/simple;
	bh=v4Esx9cF4KlSWIcQ2kqz/TpABAeRs6jtLpyXFM7NH+w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B8OaW/ka7MIbTiqS/+BCZ/0WseXzF4kZeF9LJCAcdqxd7I+P9xzB7EjWiMQ0C273j43gdIoudtqL51FqdnjUthcOsCqF4HoLyaj2NYNWfaVb1xQDaSPKTeQuydBUwtND1qkJgIZs7ehBHyiAXxXO1cjLYxqKHHAp/S8gw3FmyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRkTDG+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1334BC43390;
	Tue,  9 Apr 2024 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706243;
	bh=v4Esx9cF4KlSWIcQ2kqz/TpABAeRs6jtLpyXFM7NH+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MRkTDG+8qYVtJprKDkKROpi+qmMYRDozGGUHK/ANM3jblCM+04FmSYPNSJqxOPy0f
	 3AibsMXWDJLkq5lIJhLOnniO1RXbiqfoG9VxeMOTZnhp/ZW5ip/hqorJd5nJK7xnAu
	 9BE/9VrovpSZM2DwXg2ubmBAqni6ooUrfj00SJwVBnU1Bll4Z2tepkwsjQ37kbvR82
	 7/J/XexNSvWH9kw+t7/KGyzDm9OJXbTnlXFS3ZZ0OK8QHRG/93tgRNeiTrAFJR4Gtc
	 4suJPDU95W2D8i+SXtP5OXGYHZlvsSXF6Yekr58Kg5B4QoPxMf79wpTD3rpOR/IqCq
	 +HsV3zP8Qg5WQ==
Date: Wed, 10 Apr 2024 08:44:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 rsavitski@google.com
Subject: Re: [PATCH] ring-buffer: Only update pages_touched when a new page
 is touched
Message-Id: <20240410084400.d08b17cc846c233619e3c9fd@kernel.org>
In-Reply-To: <20240409151309.0d0e5056@gandalf.local.home>
References: <20240409151309.0d0e5056@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 15:13:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The "buffer_percent" logic that is used by the ring buffer splice code to
> only wake up the tasks when there's no data after the buffer is filled to
> the percentage of the "buffer_percent" file is dependent on three
> variables that determine the amount of data that is in the ring buffer:
> 
>  1) pages_read - incremented whenever a new sub-buffer is consumed
>  2) pages_lost - incremented every time a writer overwrites a sub-buffer
>  3) pages_touched - incremented when a write goes to a new sub-buffer
> 
> The percentage is the calculation of:
> 
>   (pages_touched - (pages_lost + pages_read)) / nr_pages
> 
> Basically, the amount of data is the total number of sub-bufs that have been
> touched, minus the number of sub-bufs lost and sub-bufs consumed. This is
> divided by the total count to give the buffer percentage. When the
> percentage is greater than the value in the "buffer_percent" file, it
> wakes up splice readers waiting for that amount.
> 
> It was observed that over time, the amount read from the splice was
> constantly decreasing the longer the trace was running. That is, if one
> asked for 60%, it would read over 60% when it first starts tracing, but
> then it would be woken up at under 60% and would slowly decrease the
> amount of data read after being woken up, where the amount becomes much
> less than the buffer percent.
> 
> This was due to an accounting of the pages_touched incrementation. This
> value is incremented whenever a writer transfers to a new sub-buffer. But
> the place where it was incremented was incorrect. If a writer overflowed
> the current sub-buffer it would go to the next one. If it gets preempted
> by an interrupt at that time, and the interrupt performs a trace, it too
> will end up going to the next sub-buffer. But only one should increment
> the counter. Unfortunately, that was not the case.
> 
> Change the cmpxchg() that does the real switch of the tail-page into a
> try_cmpxchg(), and on success, perform the increment of pages_touched. This
> will only increment the counter once for when the writer moves to a new
> sub-buffer, and not when there's a race and is incremented for when a
> writer and its preempting writer both move to the same new sub-buffer.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, isn't this a real bugfix, because the page_touched can be
bigger than nr_pages without this fix?

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 25476ead681b..6511dc3a00da 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1393,7 +1393,6 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
>  	old_write = local_add_return(RB_WRITE_INTCNT, &next_page->write);
>  	old_entries = local_add_return(RB_WRITE_INTCNT, &next_page->entries);
>  
> -	local_inc(&cpu_buffer->pages_touched);
>  	/*
>  	 * Just make sure we have seen our old_write and synchronize
>  	 * with any interrupts that come in.
> @@ -1430,8 +1429,9 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
>  		 */
>  		local_set(&next_page->page->commit, 0);
>  
> -		/* Again, either we update tail_page or an interrupt does */
> -		(void)cmpxchg(&cpu_buffer->tail_page, tail_page, next_page);
> +		/* Either we update tail_page or an interrupt does */
> +		if (try_cmpxchg(&cpu_buffer->tail_page, &tail_page, next_page))
> +			local_inc(&cpu_buffer->pages_touched);
>  	}
>  }
>  
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

