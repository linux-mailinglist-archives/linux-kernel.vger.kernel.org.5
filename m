Return-Path: <linux-kernel+bounces-73739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4144985CA43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CD11C21D43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B72152DEA;
	Tue, 20 Feb 2024 21:51:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CE151CDD;
	Tue, 20 Feb 2024 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465881; cv=none; b=L8hfXZbgRbQqNHCf7jrKB4yDODcgRMDlbiNzeNKPpfBMrN0wu2NwthKQPQF7rFGuui1qYPcJvLbeCDxXXKKeYoPzbPfF1yWxZDK1UfOsgHO/Q45dW4FVvfIX6dRk9eg+7rrGNbCZQKJAp7MmXIWITipZeOgrOp2N/zSNiV2dpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465881; c=relaxed/simple;
	bh=SBVugy/i+bJm3mD9Fj+7nQshn15kMHWVPHxAC6pFM8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwjZW366ak39UkkXtm7Nl0o4iCWzL01bnqAqBGJl4Y4k+jHohheIIFqotJz/ngNLZXkVaYViUKYjpblBQfqbtWn+CFkDBGEkf+K5tdjYWxBcIet5FIhUh+Jrp8TRi/VyKBxIShfj6clpu6t9ApY0amXTgw9mo0icBWWyrWEgU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C097C433F1;
	Tue, 20 Feb 2024 21:51:20 +0000 (UTC)
Date: Tue, 20 Feb 2024 16:53:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240220165306.68ecbe9d@gandalf.local.home>
In-Reply-To: <20240220104023.2182b5c3@gandalf.local.home>
References: <20240219182032.2605d0a3@gandalf.local.home>
	<20240220091922.45848d9a@gandalf.local.home>
	<168765ff-98ea-42a1-82f7-56178bfcf7ec@efficios.com>
	<20240220104023.2182b5c3@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 10:40:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Try resetting the info->add_timestamp flags to add_ts_default on goto again
> > within __rb_reserve_next().
> >  
> 
> I was looking at that too, but I don't know how it will make a difference.
> 
> Note, the test that fails is in my test suite, and takes about a half hour
> to get there. Running that suite takes up resources (it's my main test
> suite for all changes). I'm currently testing other patches so I either
> need to figure it out through inspection, or this will need to wait a while.

I did a bit of debugging and it's just getting weird. It triggers when I
run with the "perf" clock, which is the local_clock() (and this has
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y which does some strange paths for
local_clock()).

It appears that on function_graph tracing with perf clock, it fails the
local_cmpxchg a lot! And for some reason, this is causing it to fail the
overflow more often. Well, if it pushes the header page forward too, it
will also cause that to go back and add to the counter.

I tried moving the "again:" to the beginning of the function (after
resetting the add_timestamp flags and length) so that it gets a new
tail_page each time, but that doesn't appear to make a difference either.

It looks like that retry loop in some configs causes it to fail allocation
on the subbuffer over a 1000 times!

Looks like this changes expectations a bit, and will need more design
changes to make it work.

-- Steve

