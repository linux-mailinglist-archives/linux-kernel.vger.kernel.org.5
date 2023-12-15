Return-Path: <linux-kernel+bounces-1428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0314814EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97A1286DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED44182EF2;
	Fri, 15 Dec 2023 17:35:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7083011B;
	Fri, 15 Dec 2023 17:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F60C433C8;
	Fri, 15 Dec 2023 17:34:59 +0000 (UTC)
Date: Fri, 15 Dec 2023 12:34:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Add disable-filter-buf option
Message-ID: <20231215123458.63f57238@rorschach.local.home>
In-Reply-To: <fbf8991a-ce83-462c-b87a-b60c6635d223@efficios.com>
References: <20231215102633.7a24cb77@rorschach.local.home>
	<21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
	<20231215120417.567d5ea4@rorschach.local.home>
	<fbf8991a-ce83-462c-b87a-b60c6635d223@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 12:24:14 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-15 12:04, Steven Rostedt wrote:
> > On Fri, 15 Dec 2023 10:53:39 -0500
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:  
> [...]
> >>
> >> So rather than stacking tons of "on/off" switches for filter
> >> features, how about you let users express the mechanism they
> >> want to use for filtering with a string instead ? e.g.
> >>
> >> filter-method="temp-buffer"
> >> filter-method="ring-buffer"
> >> filter-method="input-arguments"  
> > 
> > If I add other ways to filter, it will be a separate file to control
> > that, but all options are on/off switches. Even if I add other
> > functionality to the way buffers are created, this will still have the
> > same functionality to turn the entire thing on or off.  
> 
> I'll be clearer then: I think this is a bad ABI. In your reply, you justify
> this bad ABI by implementation motivations.

What's wrong with a way to stop the copying ?

The option is just a way to say "I don't want to do the copy into the
buffer, I want to go directly into it"

> 
> I don't care about the implementation, I care about the ABI, and
> I feel that your reply is not addressing my concern at all.

Maybe I don't understand your concern.

It's an on/off switch (like all options are). This is just a way to say
"I want to indirect copying of the event before filtering or not".

The "input-argument" part above may never happen. What's different
between tracefs and LTTng, is that all events are created by the
subsystem not by me. You don't use the TRACE_EVENT() macro, but you
need to manually create each event you care about yourself. It's more
of a burden but you also then have the luxury of hooking to the input
portion. That is not exposed, and that is by design. As that could
possibly make all tracepoints an ABI, and you'll have people like
peterz nacking any new tracepoint in the scheduler. He doesn't allow
trace events anymore because of that exposure.

> 
> Moreover, double-negative boolean options (disable-X=false) are confusing.

I agree with this, and will rename it to "filter-buffer" instead. I
blame getting up at 3am for my 5:15am flight for not thinking clearly
on that ;-)

Thanks!

-- Steve

