Return-Path: <linux-kernel+bounces-97607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38DB876C70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097A01C21504
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740D65FB8B;
	Fri,  8 Mar 2024 21:33:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7BC367;
	Fri,  8 Mar 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933613; cv=none; b=pQmaj3ep3TO76v4LNFaiTFzAvMn5TpF1bCPuPpzkUWeN0Xl+BxaFK7zFpvUa92SPlPgz3mIBwJZzlmqESnsSghKuSSgbgJaWq/XZ8HfPjRmUl9994Vxp/Gq2kmRYYDXCOaV4Fc4f/v1fvx8YgtR5Sgo10r9od0JfIdLs/g6gd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933613; c=relaxed/simple;
	bh=Yha+fPwbcej5M8bdK/rgXFFhOwjR40UW0ADd4AO86+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgVcZaj0WVeGghQy+9k5+gfLTZdLSQkAlbzrvfhNp48TsKgpg7KDDTtKL4rBL9wlwwEhtC7V6B5FaPukH2PYzfKDjUwVITRUFFnbDSf/ecZTLcyMNBY8ba0arzMIQVws/vV89KXBhR0fSU6rfs87PI0lEO0IUHyvZYhwD96iKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAD7C433C7;
	Fri,  8 Mar 2024 21:33:31 +0000 (UTC)
Date: Fri, 8 Mar 2024 16:35:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, joel@joelfernandes.org, linke li
 <lilinke99@qq.com>, Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH 0/6] tracing/ring-buffer: Fix wakeup of ring buffer
 waiters
Message-ID: <20240308163528.3980c639@gandalf.local.home>
In-Reply-To: <CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
References: <20240308183816.676883229@goodmis.org>
	<CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 12:39:10 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 8 Mar 2024 at 10:38, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > A patch was sent to "fix" the wait_index variable that is used to help with
> > waking of waiters on the ring buffer. The patch was rejected, but I started
> > looking at associated code. Discussing it on IRC with Mathieu Desnoyers
> > we discovered a design flaw.  
> 
> Honestly, all of this seems excessively complicated.
> 
> And your new locking shouldn't be necessary if you just do things much
> more simply.

You mean to replace the wait_woken_*() code (that has the new locking)?

> 
> Here's what I *think* you should do:
> 
>   struct xyz {
>         ...
>         atomic_t seq;
>         struct wait_queue_head seq_wait;
>         ...
>   };
> 
> with the consumer doing something very simple like this:
> 
>         int seq = atomic_read_acquire(&my->seq);
>         for (;;) {
>                 .. consume outstanding events ..
>                 seq = wait_for_seq_change(seq, my);
>         }
> 
> and the producer being similarly trivial, just having a
> "add_seq_event()" at the end:
> 
>         ... add whatever event ..
>         add_seq_event(my);
> 
> And the helper functions for this are really darn simple:
> 
>   static inline int wait_for_seq_change(int old, struct xyz *my)
>   {
>         int new;
>         wait_event(my->seq_wait,
>                 (new = atomic_read_acquire(&my->seq)) != old);

But the index isn't the only condition for it to wake up to. If the file is
closing, it want's to know that too. Or if it's just being kicked out to
consume whatever is there and ignore the watermark.

>         return new;
>   }
> 
>   static inline void add_seq_event(struct xyz *my)
>   {
>         atomic_fetch_inc_release(&my->seq);
>         wake_up(&my->seq_wait);
>   }

But it's not only the producer that does the wakeup. That part wasn't
broken.

The broken part is a third party that comes along and wants to wake up the
consumer and tell them to just consume what's there and exit.

There's two layers:

1) the ring buffer has the above simple producer / consumer.
   Where the wake ups can happen at the point of where the buffer has
   the amount filled that the consumer wants to start consuming with.

2) The tracing layer; Here on close of a file, the consumers need to be
   woken up and not wait again. And just take whatever was there to finish
   reading.

   There's also another case that the ioctl() just kicks the current
   readers out, but doesn't care about new readers.

I'm not sure how the seq can handle both there being enough data to wake up
the consumer and the case that another task just wants the consume to wake
up and ignore the watermark.

The wake_woken_*() code was only for the second part (to wake up consumers
and tell them to no longer wait for the producer), and had nothing to do
with the produce/consumer part.

-- Steve

