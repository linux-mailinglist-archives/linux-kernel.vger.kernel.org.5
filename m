Return-Path: <linux-kernel+bounces-73168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79485BE85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9201C21CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E5E6A8D3;
	Tue, 20 Feb 2024 14:17:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB66A352;
	Tue, 20 Feb 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438658; cv=none; b=lskySCh9hvbNx9R0VgXt3KKl8++5ORviJjmomUcSDvkFwdGohdaIWfPVqKgQaECU8xBunKRMuQJtz7EyFc91F9nJoIslkwXp22dPZ/SczdTs5SNdKjEAufm96i48B/yvAmEr7IJs/ewcpIiX/xvdzYj+0AGhe9+8pV4dN+NF19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438658; c=relaxed/simple;
	bh=qHlJwqessxV9XUwxNx0X6io3N2Cccxou6H8VwK7z4/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKdA15Nlf0xuyEkLxbe4P142Im3gOUg/x+Qsos8FSVyoRozxL6M/c9ccfeuTa2pde83RNX36ELN7SbJJ5TYjTfn9aaC+N+Ioeb1i2bPIxSNlVJRhN7KnzIh9KC15WzdXXUZ+hthgRMjlNiuHPdL3okHnMXYOglNGKGJo5PXghY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55523C433C7;
	Tue, 20 Feb 2024 14:17:37 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:19:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240220091922.45848d9a@gandalf.local.home>
In-Reply-To: <20240219182032.2605d0a3@gandalf.local.home>
References: <20240219182032.2605d0a3@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 18:20:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Instead of using local_add_return() to reserve the ring buffer data,
> Mathieu Desnoyers suggested using local_cmpxchg(). This would simplify the
> reservation with the time keeping code.
> 
> Although, it does not get rid of the double time stamps (before_stamp and
> write_stamp), using cmpxchg() does get rid of the more complex case when
> an interrupting event occurs between getting the timestamps and reserving
> the data, as when that happens, it just tries again instead of dealing
> with it.
> 
> Before we had:
> 
> 	w = local_read(&tail_page->write);
> 	/* get time stamps */
> 	write = local_add_return(length, &tail_page->write);
> 	if (write - length == w) {
> 		/* do simple case */
> 	} else {
> 		/* do complex case */
> 	}
> 
> By switching the local_add_return() to a local_try_cmpxchg() it can now be:
> 
> 	 w = local_read(&tail_page->write);
>  again:
> 	/* get time stamps */
> 	if (!local_try_cmpxchg(&tail_page->write, &w, w + length))
> 		goto again;
> 
> 	 /* do simple case */

Something about this logic is causing __rb_next_reserve() to sometimes
always return -EAGAIN and triggering the:

    RB_WARN_ON(cpu_buffer, ++nr_loops > 1000)

Which disables the ring buffer.

I'm not sure what it is, but until I do, I'm removing the patch from my
queue.

-- Steve



