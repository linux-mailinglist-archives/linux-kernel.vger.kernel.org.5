Return-Path: <linux-kernel+bounces-49235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8084678D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B9F1F273B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490C17550;
	Fri,  2 Feb 2024 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ4nnEyT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D317548;
	Fri,  2 Feb 2024 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706853026; cv=none; b=iyfly4jvnwk/25wuXGLUZp8XZUyp6yzpAPBUhdOw0IzATtgEIeHw+Xv31UWnhsdhNdWQrafnMHM2kLwwUyFgIOAxqUM9OWi/26ymEbVZq4Y/1YX7Nvu6SjWRwdBfPEa7ni0qoSZZjdrHXQ/JzLqjPravKYvb79P2GctlfoqsUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706853026; c=relaxed/simple;
	bh=slpcBsRAKhKxKWrz95v7CuGzL1LVcvfpXIlwBuE0XZY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=snbiIjJIZLP1lXJg5RuHbeQEhgorGPg/CNhCEfYk1KaM8f6WE5+DcQVNUMpGJ0/awSomCf8ZDqvwDu/+zI6lwmu+uKgHW2PKEIopezG6oQky1PGryX/XAE9ICzA27Iyv1085X+20I9374jvMeAP92IrkWcS+rDM7lRWFOIma6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ4nnEyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D2CC433F1;
	Fri,  2 Feb 2024 05:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706853026;
	bh=slpcBsRAKhKxKWrz95v7CuGzL1LVcvfpXIlwBuE0XZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZ4nnEyT1hXpq44Wa9eEnZYDIjFzrtN84NEJhHeuLpxqGzQuOWHpI2a3//hRBW+kF
	 HIjmgT+m8q5CZx5P27LFwh66L9V5p1pJXwYBWEBw1yYc/28f3/exv2O2rpgPAmEGPC
	 iLWESTbKHwbwxXME90ELxA+8Ug6cPSLbzrg6g0lG8rlbmI1HGrX0CGIC7U6NiY9/H6
	 021lj5xhzKm2QHkkIlo6a24CR5pqgbnlGaHgiH/lG5d1xyVq3a3PTNSehfd/DJtXA1
	 3M8z+izUmruxF3ik/+R92ezN/Sjza0PwFzxx0FgO6F7ZE1rc0Y1PZm4pyrIKhFpc60
	 2l9kgI9mTic1w==
Date: Fri, 2 Feb 2024 14:50:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 0/4] tracing/user_events: Introduce multi-format events
Message-Id: <20240202145022.56eba9be71df744331e8c58d@kernel.org>
In-Reply-To: <20240130182549.GC827-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
	<20240130110933.32c9aa0eceff2f0f917affd1@kernel.org>
	<20240130182549.GC827-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 10:25:49 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Tue, Jan 30, 2024 at 11:09:33AM +0900, Masami Hiramatsu wrote:
> > Hi Beau,
> > 
> > On Tue, 23 Jan 2024 22:08:40 +0000
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> > > Currently user_events supports 1 event with the same name and must have
> > > the exact same format when referenced by multiple programs. This opens
> > > an opportunity for malicous or poorly thought through programs to
> > > create events that others use with different formats. Another scenario
> > > is user programs wishing to use the same event name but add more fields
> > > later when the software updates. Various versions of a program may be
> > > running side-by-side, which is prevented by the current single format
> > > requirement.
> > > 
> > > Add a new register flag (USER_EVENT_REG_MULTI_FORMAT) which indicates
> > > the user program wishes to use the same user_event name, but may have
> > > several different formats of the event in the future. When this flag is
> > > used, create the underlying tracepoint backing the user_event with a
> > > unique name per-version of the format. It's important that existing ABI
> > > users do not get this logic automatically, even if one of the multi
> > > format events matches the format. This ensures existing programs that
> > > create events and assume the tracepoint name will match exactly continue
> > > to work as expected. Add logic to only check multi-format events with
> > > other multi-format events and single-format events to only check
> > > single-format events during find.
> > 
> > Thanks for this work! This will allow many instance to use the same
> > user-events at the same time.
> > 
> > BTW, can we force this flag set by default? My concern is if any user
> > program use this user-event interface in the container (maybe it is
> > possible if we bind-mount it). In this case, the user program can
> > detect the other program is using the event if this flag is not set.
> > Moreover, if there is a malicious program running in the container,
> > it can prevent using the event name from other programs even if it
> > is isolated by the name-space.
> > 
> 
> The multi-format use a different system name (user_events_multi). So you
> cannot use the single-format flag to detect multi-format names, etc. You
> can only use it to find other single-format names like you could always do.
> 
> Likewise, you cannot use the single-event flag to block or prevent
> multi-format events from being created.

Hmm, got it.

> 
> Changing this behavior to default would break all of our environments.
> So I'm pretty sure it would break others. The current environment
> expects tracepoints to show up as their registered name under the
> user_events system name. If this changed out from under us on a specific
> kernel version, that would be bad.
> 
> I'd like eventually to have a tracer namespace concept for containers.
> Then we would have a user_event_group per tracer namespace. Then all
> user_events within the container have a unique system name which fully
> isolates them. However, even with that isolation, we still need a way to
> allow programs in the same container to have different versions of the
> same event name.

Agreed.

> 
> Multi-format events fixes this problem. I think isolation should be
> dealt with via true namespace isolation at the tracing level.
> 
> > Steve suggested that if a user program which is running in a namespace
> > uses user-event without this flag, we can reject that by default.
> > 
> > What would you think about?
> > 
> 
> This would break all of our environments. It would make previously
> compiled programs using the existing ABI from working as expected.
> 
> I'd much prefer that level of isolation to happen at the namespace level
> and why user_events as plumbing for different groups to achieve this.
> It's also why the ABI does not allow programs to state a system name.
> I'm trying to reserve the system name for the group/tracer/namespace
> isolation work.

OK, that's reasonable enough.

Thank you!

> 
> Thanks,
> -Beau
> 
> > Thank you,
> > 
> > 
> > > 
> > > Add a register_name (reg_name) to the user_event struct which allows for
> > > split naming of events. We now have the name that was used to register
> > > within user_events as well as the unique name for the tracepoint. Upon
> > > registering events ensure matches based on first the reg_name, followed
> > > by the fields and format of the event. This allows for multiple events
> > > with the same registered name to have different formats. The underlying
> > > tracepoint will have a unique name in the format of {reg_name}:[unique_id].
> > > The unique_id is the time, in nanoseconds, of the event creation converted
> > > to hex. Since this is done under the register mutex, it is extremely
> > > unlikely for these IDs to ever match. It's also very unlikely a malicious
> > > program could consistently guess what the name would be and attempt to
> > > squat on it via the single format ABI.
> > > 
> > > For example, if both "test u32 value" and "test u64 value" are used with
> > > the USER_EVENT_REG_MULTI_FORMAT the system would have 2 unique
> > > tracepoints. The dynamic_events file would then show the following:
> > >   u:test u64 count
> > >   u:test u32 count
> > > 
> > > The actual tracepoint names look like this:
> > >   test:[d5874fdac44]
> > >   test:[d5914662cd4]
> > > 
> > > Deleting events via "!u:test u64 count" would only delete the first
> > > tracepoint that matched that format. When the delete ABI is used all
> > > events with the same name will be attempted to be deleted. If
> > > per-version deletion is required, user programs should either not use
> > > persistent events or delete them via dynamic_events.
> > > 
> > > Beau Belgrave (4):
> > >   tracing/user_events: Prepare find/delete for same name events
> > >   tracing/user_events: Introduce multi-format events
> > >   selftests/user_events: Test multi-format events
> > >   tracing/user_events: Document multi-format flag
> > > 
> > >  Documentation/trace/user_events.rst           |  23 +-
> > >  include/uapi/linux/user_events.h              |   6 +-
> > >  kernel/trace/trace_events_user.c              | 224 +++++++++++++-----
> > >  .../testing/selftests/user_events/abi_test.c  | 134 +++++++++++
> > >  4 files changed, 325 insertions(+), 62 deletions(-)
> > > 
> > > 
> > > base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> > > -- 
> > > 2.34.1
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

