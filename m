Return-Path: <linux-kernel+bounces-45142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E7842C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9B31C23F16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F447992C;
	Tue, 30 Jan 2024 18:52:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14879922;
	Tue, 30 Jan 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640739; cv=none; b=SOx4dwoMNRb6MWn/R2vjXLUIOidqfUYPSlOKQAXqRY8LC4KG0Em+Xi+NyxEkSbrymRZEKXuZdetP+MxyUcNFxmE8gdfGPlDsircyzViHIkHrC6ZCxsVsF4camar8JKMN52E66396wPo/4Kb3YUDWJ6dMzlq+/atPiJn16Nl0PUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640739; c=relaxed/simple;
	bh=VI+11BxTPHbaqxH2CqckgfYqM1FmLjMbf1aOw4y+a+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md6+qvIgqdVT/Q0zqd8fEln/x5KVzkBtKd07c5Zad2I1oBEFCRMNUKZ47IW1TrdEFd0qpgC8I6+2I2SRx5OE0bb59Q9RrZgNODtc0LJS2Uukzo0G1ilAA05hqwdA9ALt9pobvoSCyniVwDCnIxujUuttiEvl6AAwv2+if9Bcuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437BEC433C7;
	Tue, 30 Jan 2024 18:52:18 +0000 (UTC)
Date: Tue, 30 Jan 2024 13:52:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240130135230.25eb6f21@gandalf.local.home>
In-Reply-To: <20240130180515.GA827-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
	<20240123220844.928-3-beaub@linux.microsoft.com>
	<20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
	<20240126191007.GA456-beaub@linux.microsoft.com>
	<20240126150445.71c5d426@gandalf.local.home>
	<20240129172907.GA444-beaub@linux.microsoft.com>
	<20240129212407.157a5533@gandalf.local.home>
	<20240130180515.GA827-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 10:05:15 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Mon, Jan 29, 2024 at 09:24:07PM -0500, Steven Rostedt wrote:
> > On Mon, 29 Jan 2024 09:29:07 -0800
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> >   
> > > Thanks, yeah ideally we wouldn't use special characters.
> > > 
> > > I'm not picky about this. However, I did want something that clearly
> > > allowed a glob pattern to find all versions of a given register name of
> > > user_events by user programs that record. The dot notation will pull in
> > > more than expected if dotted namespace style names are used.
> > > 
> > > An example is "Asserts" and "Asserts.Verbose" from different programs.
> > > If we tried to find all versions of "Asserts" via glob of "Asserts.*" it
> > > will pull in "Asserts.Verbose.1" in addition to "Asserts.0".  
> > 
> > Do you prevent brackets in names?
> >   
> 
> No. However, since brackets have a start and end token that are distinct
> finding all versions of your event is trivial compared to a single dot.
> 
> Imagine two events:
> Asserts
> Asserts[MyCoolIndex]
> 
> Resolves to tracepoints of:
> Asserts:[0]
> Asserts[MyCoolIndex]:[1]
> 
> Regardless of brackets in the names, a simple glob of Asserts:\[*\] only
> finds Asserts:[0]. This is because we have that end bracket in the glob
> and the full event name including the start bracket.
> 
> If I register another "version" of Asserts, thne I'll have:
> Asserts:[0]
> Asserts[MyCoolIndex]:[1]
> Asserts:[2]
> 
> The glob of Asserts:\[*\] will return both:
> Asserts:[0]
> Asserts:[2]

But what if you had registered "Asserts:[MyCoolIndex]:[1]"

Do you prevent colons?

> 
> At this point the program can either record all versions or scan further
> to find which version of Asserts is wanted.
> 
> > > 
> > > While a glob of "Asserts.[0-9]" works when the unique ID is 0-9, it
> > > doesn't work if the number is higher, like 128. If we ever decide to
> > > change the ID from an integer to say hex to save space, these globs
> > > would break.
> > > 
> > > Is there some scheme that fits the C-variable name that addresses the
> > > above scenarios? Brackets gave me a simple glob that seemed to prevent a
> > > lot of this ("Asserts.\[*\]" in this case).  
> > 
> > Prevent a lot of what? I'm not sure what your example here is.
> >   
> 
> I'll try again :)
> 
> We have 2 events registered via user_events:
> Asserts
> Asserts.Verbose
> 
> Using dot notation these would result in tracepoints of:
> user_events_multi/Asserts.0
> user_events_multi/Asserts.Verbose.1
> 
> Using bracket notation these would result in tracepoints of:
> user_events_multi/Asserts:[0]
> user_events_multi/Asserts.Verbose:[1]
> 
> A recording program only wants to enable the Asserts tracepoint. It does
> not want to record the Asserts.Verbose tracepoint.
> 
> The program must find the right tracepoint by scanning tracefs under the
> user_events_multi system.
> 
> A single dot suffix does not allow a simple glob to be used. The glob
> Asserts.* will return both Asserts.0 and Asserts.Verbose.1.
> 
> A simple glob of Asserts:\[*\] will only find Asserts:[0], it will not
> find Asserts.Verbose:[1].
> 
> We could just use brackets and not have the colon (Asserts[0] in this
> case). But brackets are still special for bash.

Are these shell scripts or programs. I use regex in programs all the time.
And if you have shell scripts, use awk or something.

Unless you prevent something from being added, I don't see the protection.

> 
> > > 
> > > Are we confident that we always want to represent the ID as a base-10
> > > integer vs a base-16 integer? The suffix will be ABI to ensure recording
> > > programs can find their events easily.  
> > 
> > Is there a difference to what we choose?
> >   
> 
> If a simple glob of event_name:\[*\] cannot be used, then we must document
> what the suffix format is, so an appropriate regex can be created. If we
> start with base-10 then later move to base-16 we will break existing regex
> patterns on the recording side.
> 
> I prefer, and have in this series, a base-16 output since it saves on
> the tracepoint name size.

I honestly don't care which base you use. So if you want to use base 16,
I'm fine with that.

> 
> Either way we go, we need to define how recording programs should find
> the events they care about. So we must be very clear, IMHO, about the
> format of the tracepoint names in our documentation.
> 
> I personally think recording programs are likely to get this wrong
> without proper guidance.
> 

Agreed.

-- Steve

