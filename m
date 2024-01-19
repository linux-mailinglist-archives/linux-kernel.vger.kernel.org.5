Return-Path: <linux-kernel+bounces-31587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A088833065
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBA1C23BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225858220;
	Fri, 19 Jan 2024 21:41:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41158217;
	Fri, 19 Jan 2024 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700492; cv=none; b=FTVIXaEHiejb15XMQfUsUGgXJiZHVm4loT82qdQN7uOAozMxFbPMGvtMBApXdGKmGxnCFayYAugP4TBfWLgrXKWwnYbFzAxx7eIkXFe6bu7t8Nskbr8Zbi27Gyxkm+Q1IQRZMcL5ZXOUwNhcav+vGhw+ytZn3NEec1DMGxfj/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700492; c=relaxed/simple;
	bh=eC4XqyL+AmSKRqhuhKoHuMFTp8Cil693CxJZanrtSd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYdM/IPgMGLdWxgFdvtTERVoAYfPcVY9cb1r4+igcbaOjW1iY0RGpwS6Smvg8itzC+pGJtJ0RVR7Yuw5VmB1cq4ombJx/M4xengQH0nh3LB2Bt18S5dq5aEwTZVJrXzJ4G7ywSpwh3FOrjHjxSZFMAh5IAhG5ZWm53PpleG+1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27977C433C7;
	Fri, 19 Jan 2024 21:41:31 +0000 (UTC)
Date: Fri, 19 Jan 2024 16:42:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Philippe Proulx
 <pproulx@efficios.com>
Subject: Re: [PATCH] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240119164252.54ccb654@gandalf.local.home>
In-Reply-To: <cd3f37cc-31ba-4eb4-8d67-852d05570e7b@efficios.com>
References: <20240118181206.4977da2f@gandalf.local.home>
	<504085e9-bf91-4948-a158-abae5dcb276a@efficios.com>
	<20240119103754.154dc009@gandalf.local.home>
	<cd3f37cc-31ba-4eb4-8d67-852d05570e7b@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 15:56:21 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > So when an overflow happens, you just insert a timestamp, and then events
> > after that is based on that?  
> 
> No. Let's use an example to show how it works.
> 
> For reference, LTTng uses 5-bit for event ID and 27-bit for timestamps
> in the compact event header representation. But for the sake of making this
> discussion easier, let's assume a tracer would use 16-bit for timestamps in the
> compact representation.
> 
> Let's say we have the following ktime_get() values (monotonic timestamp value) for
> a sequence of events:
> 
>                                    Timestamp (Hex)    Encoding in the trace
> 
> Packet header timestamp begin     0x12345678         64-bit: 0x12345678
> 
> Event 1                           0x12345678         16-bit: 0x5678
>     (When decoded, same value as previous timestamp, no overflow)
> Event 2                           0x12347777         16-bit: 0x7777
>     (When decoded, going from "0x5678" to "0x7777" does not overflow 16-bit)
> Event 3                           0x12350000         16-bit: 0x0000
>     (When decoded, going from "0x7777" to "0x0000" overflow 16-bit exactly once
>      which allows the trace reader to reconstruct timestamp 0x12350000 from the
>      previous timestamp and the 16-bit timestamp encoding.)
> Event 4                           0x12370000         64-bit: 0x12370000
>     (Encoding over 16-bit not possible because going from 0x12350000 to
>      0x12370000 would overflow 16-bit twice, which cannot be detected
>      by a trace reader. Therefore use the full 64-bit timestamp in the
>      "large" event header representation.)

I think that's basically what I said, but you are just looking at it
differently ;-) Or should I say, you are using bits for optimization.

The events are based off of the last injected timestamp. The above example,
starts with an timestamp injection into the packet header: 0x12345678, with
the lsb 16bits ignore. So in actuality, it inserts 0x12340000, plus adds a
5678 that represents the creation of the header (like we discussed about in
the last tracing meeting).

The first event has: 0x5678 which is based on the previous injected
timestamp of 0x12340000.

the events go on just using a delta from that until you see it overflow (or
too big of a delta to fit in the 16 bits), and you insert a new full
timestamps that everything will be based on:

  0x12370000

Now events following that are just a delta from that timestamp. But you
calculate the delta simply by masking out the lower bits.

But how do you detect the overflow? That last timestamps to know if the tsc
overflowed or not needs to be saved and compared. I would assume you have a
similar race that I have.

> 
> >   
> >>
> >> The fact that Ftrace exposes this ring buffer binary layout as a user-space
> >> ABI makes it tricky to move to the Common Trace Format timestamp encoding.
> >> There are clearly huge simplifications that could be made by moving to this
> >> scheme though. Is there any way to introduce a different timestamp encoding
> >> scheme as an extension to the Ftrace ring buffer ABI ? This would allow us to
> >> introduce this simpler scheme and gradually phase out the more complex delta
> >> encoding when no users are left.  
> > 
> > I'm not sure if there's a path forward. The infrastructure can easily swap
> > in and out a new implementation. That is, there's not much dependency on
> > the way the ring buffer works outside the ring buffer itself.
> > 
> > If we were to change the layout, it would likely require a new interface
> > file to read. The trace_pipe_raw is the only file that exposes the current
> > ring buffer. We could create a trace_out_raw or some other named file that
> > has a completely different API and it wouldn't break any existing API.  
> 
> Or introduce "trace_pipe_raw2" or some kind of versioned file names as new
> ABIs.

I hate "version numbers" ;-)  I would rather have a meaning name instead.

"trace_pipe_raw_ts_delta" or something that gives a hint to why it's
different.

> 
> > Although, if we want to change the "default" way, it may need some other
> > knobs or something, which wouldn't be hard.  
> 
> The delta-timestamp-encoding would have to stay there for a while as long
> as users have not switched over to trace_pipe_raw2. Then when it's really
> gone, the trace_pipe_raw could either go away or return an error when
> opened.
> 
> > Now I have to ask, what's the motivation for this. The code isn't that
> > complex anymore. Yes it still has the before/after timestamps, but the
> > most complexity in that code was due to what happens in the race of
> > updating the reserved data. But that's no longer the case with the
> > cmpxchg(). If you look at this patch, that entire else statement was
> > deleted. And that deleted code was what made me sick to my stomach ;-)
> > Good riddance!  
> 
> The motivation for this would be to further simplify the implementation
> of __rb_reserve_next(), rb_add_timestamp(), and rb_try_to_discard(), and
> remove a few useless loads, stores, and conditional branches on the fast-path
> of __rb_reserve_next(). This would turn the before/after timestamp
> stores/loads/comparisons into a simple "last timestamp" field and a comparison
> of the current timestamp against the "last timestamp" value to figure out
> whether the compact representation can be used.
> 
> I don't know whether it's worth the trouble or not, it's really up to you. :)

Yeah, making such a change would require an analysis to know if it would
speed things up enough to make a significant difference to do that effort.

-- Steve

