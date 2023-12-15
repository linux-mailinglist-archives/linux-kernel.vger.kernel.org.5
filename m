Return-Path: <linux-kernel+bounces-1539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C2E814FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EE7286F62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2F3C46B;
	Fri, 15 Dec 2023 18:43:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945146528;
	Fri, 15 Dec 2023 18:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E72C433C8;
	Fri, 15 Dec 2023 18:43:37 +0000 (UTC)
Date: Fri, 15 Dec 2023 13:43:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Add disable-filter-buf option
Message-ID: <20231215134335.2388aba5@rorschach.local.home>
In-Reply-To: <f1a75239-341e-4611-a48d-88e10407dcd4@efficios.com>
References: <20231215102633.7a24cb77@rorschach.local.home>
	<21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
	<20231215120417.567d5ea4@rorschach.local.home>
	<fbf8991a-ce83-462c-b87a-b60c6635d223@efficios.com>
	<20231215123458.63f57238@rorschach.local.home>
	<f1a75239-341e-4611-a48d-88e10407dcd4@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 13:25:07 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> I am not against exposing an ABI that allows userspace to alter the
> filter behavior. I disagree on the way you plan to expose the ABI.

These are no different than the knobs for sched_debug

> 
> Exposing this option as an ABI in this way exposes too much internal
> ring buffer implementation details to userspace.

There's already lots of exposure using options. The options are just
knobs, nothing more.

> 
> It exposes the following details which IMHO should be hidden or
> configurable in a way that allows moving to a whole new mechanism
> which will have significantly different characteristics in the
> future:
> 
> It exposes that:
> 
> - filtering uses a copy to a temporary buffer, and
> - that this copy is enabled by default.
> 
> Once exposed, those design constraints become immutable due to ABI.

No it is not. There is no such thing as "immutable ABI". The rule is
"don't break user space" If this functionality in the kernel goes away,
the knob could become a nop, and I doubt any user space will break
because of it.

That is, the only burden is keeping this option exposed. But it could
be just like that light switch that has nothing connected to it. It's
still there, but does nothing if you switch it. This knob can act the
same way. This does not in anyway prevent future innovation.

> 
> > 
> > The option is just a way to say "I don't want to do the copy into the
> > buffer, I want to go directly into it"  
> 
> My main concern is how this concept, once exposed to userspace,
> becomes not only an internal implementation detail, but a fundamental
> part of the design which cannot ever go away without breaking the ABI
> or making parts of the ABI irrelevant.

Again, it's not about breaking ABI. Linus himself stated that Linux
constantly breaks ABI. As long as breaking ABI doesn't break user
space, it's OK. I've broken tracing ABI several times over the last
decade, and nobody complained. It's *how" you break it. It's similar to
the tree falling in the forest. If you break ABI and no user space
application notices, did you really break ABI?

> 
> I can make a parallel with the scheduler: this is as if the sched
> feature knobs (which are there only for development/debugging purposes)
> would all be exposed as userspace ABI. This would seriously
> limit the evolution of the scheduler design in the future. I see this
> as the same problem at the ring buffer level.

Heh, I mentioned sched before reading this. Again, it's whether or not
userspace can notice if behavior changes or not. If it can't notice, it
didn't break.

> 
> >   
> >>
> >> I don't care about the implementation, I care about the ABI, and
> >> I feel that your reply is not addressing my concern at all.  
> > 
> > Maybe I don't understand your concern.
> > 
> > It's an on/off switch (like all options are). This is just a way to say
> > "I want to indirect copying of the event before filtering or not".  
> 
> Not all tracefs options are booleans. The "current_tracer" file ABI

"current_trace" is not an option. Look in /sys/kernel/tracing/options.
They are all boolean.

> exposes a string input/output parameter. I would recommend the same
> for the equivalent of a "current_filter" file.

I still do not see the benefit. The "current_filter" would expose just
as much implementation that I can see. This option is just an knob to
turn it on or off. Most options, nobody knows about, and are seldom
used by anyone but me ;-)

Once you put a file in the main directory, it become much more likely
to be used.

> 
> > 
> > The "input-argument" part above may never happen. What's different
> > between tracefs and LTTng, is that all events are created by the
> > subsystem not by me. You don't use the TRACE_EVENT() macro, but you
> > need to manually create each event you care about yourself. It's more
> > of a burden but you also then have the luxury of hooking to the input
> > portion. That is not exposed, and that is by design. As that could
> > possibly make all tracepoints an ABI, and you'll have people like
> > peterz nacking any new tracepoint in the scheduler. He doesn't allow
> > trace events anymore because of that exposure.  
> 
> I'm not arguing for moving to the input-argument scheme, I just used
> this as an hypothetical example to show why we should not expose
> internal implementation details to userspace which will prevent future
> evolution only for the sake of having debugging knobs.

Again, this is just a knob in the options directory, and not a full
fledge feature. Options are not always guaranteed to be there,
depending on the config. There's some options that are even created by
what tracer is in "current_tracer".

I added this mainly to be able to add a kselftest to stress test the
discard code. If it would make you feel better, I could even add a
config around it to have it only exposed if the config is enabled.

-- Steve

