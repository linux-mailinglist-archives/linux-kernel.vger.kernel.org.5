Return-Path: <linux-kernel+bounces-45774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2914A84361B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12D8B223BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346003D98B;
	Wed, 31 Jan 2024 05:33:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A53D572;
	Wed, 31 Jan 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679185; cv=none; b=d2p88v9Eo2CHaTxapz6n80ve5IyoBCohYmx9yYCSG+KKMvmWsGaY/dB5f4EIcwHSmRAPn/NdV6pX1VcMaBKMP5lfGibdJ0MSYPIo3q6Zjmh9GGsR/NFDOxW2RoxirNW5A/PW2FV+2+Pp3V7YOJ96mjctOoWr+h7Wfa9GOIXACXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679185; c=relaxed/simple;
	bh=9eNMyVRmJlRMLKSTZzoMPiOUu+w8lh4JoPKvelIwgak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNGMEGuxKNXP/6S0wwNSsIT4JgNYKWrVU6a3V8ppZRPh6tDqPWgZwFpaWxV+9FT7qmhLrLKLciVhKZeA2EBkM3nv0cPEPk96v6Nmgohnfz0NH2fcLDKEotW+In20Jd4FjTrRmce3SDC/5csLtGZ8Z4/ZA6LOhxm/qBL8IiXqKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB23BC43390;
	Wed, 31 Jan 2024 05:33:04 +0000 (UTC)
Date: Wed, 31 Jan 2024 00:33:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without
 refcounts
Message-ID: <20240131003317.7a63e799@gandalf.local.home>
In-Reply-To: <CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-5-torvalds@linux-foundation.org>
	<20240131000956.3dbc0fc0@gandalf.local.home>
	<CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 21:25:30 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Does this work:
> >
> >         d_invalidate(dentry);  
> 
> It does, but it's basically irrelevant with the d_revalidate approach.
> 
> Basically, once you have d_revalidate(), the unhashing happens there,
> and it's just extra work and pointless to do it elsewhere.
> 
> So if you look at the "clean up dentry ops and add revalidate
> function" patch, you'll see that it just does
> 
> -       simple_recursive_removal(dentry, NULL);
> 
> and the thing is just history.

With even the last patch included, without the d_invalidate() I get errors
with simply doing:

 # cd /sys/kernel/tracing
 # mkdir instances/foo
 # ls instances/foo/events
 # rmdir instances/foo

As the rmdir calls tracefs_remove() that calls simple_recursive_removal()
that then walks into the "events" directory. Without that d_invalidate, it
walks beyond just the top directory and then splats on the dentries that
are cached.


> 
> So really, that final patch is the one that fixes the whole eventfs
> mess for good (knock wood). But you can't do it first, because it
> basically depends on all the refcount fixes.

I'm running my full suite with the final patch included, plus some of the
updates I mentioned in replies to other patches, as well as including this
"d_invalidate()" as it doesn't pass without it.

> 
> It might be possible to re-organize the patches so that the refcount
> changes go first, then the d_revalidate(), and then the rest. But I
> suspect they all really end up depending on each other some way,
> because the basic issue was that the whole "keep unrefcounted dentry
> pointers around" was just wrong.  So it doesn't end up right until
> it's _all_ fixed, because every step of the way exposes some problem.
> 
> At least that was my experience. Fix one thing, and it exposes the
> hack that another thing depended on.
> 
> This is actually something that Al is a master at. You sometimes see
> him send one big complicated patch where he talks about all the
> problems in some area and it's one huge "fix up everything patch" that
> looks very scary.
> 
> And then a week later he sends a series of 19 patches that all make
> sense and all look "obvious" and all make small progress.
> 
> And magically they end up matching that big cleanup patch in the end.
> And you just *know* that it didn't start out as that beautiful logical
> series, because you saw the big messy patch first...

I'll take a look at breaking the patches up further, as I now have a much
better understanding of dentries then I did before this discussion.

-- Steve

