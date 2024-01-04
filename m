Return-Path: <linux-kernel+bounces-17189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA482495B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70341F23043
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC102C681;
	Thu,  4 Jan 2024 20:03:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7282C1B3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382DCC433C7;
	Thu,  4 Jan 2024 20:03:54 +0000 (UTC)
Date: Thu, 4 Jan 2024 15:05:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ajay Kaher <akaher@vmware.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [for-next][PATCH 2/3] eventfs: Stop using dcache_readdir() for
 getdents()
Message-ID: <20240104150500.38b15a62@gandalf.local.home>
In-Reply-To: <20240104140246.688a3966@gandalf.local.home>
References: <20240104164703.808999991@goodmis.org>
	<20240104164738.483305222@goodmis.org>
	<CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com>
	<20240104140246.688a3966@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 14:02:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > And that very fact actually makes me wonder:
> >   
> > >         for (i = 0; i < ei->nr_entries; i++) {
> > > +               void *cdata = ei->data;
> > > +
> > > +               if (c > 0) {
> > > +                       c--;
> > > +                       continue;
> > > +               }    
> > 
> > The 'ei->nr_entries' things are in a stable array, so the indexing for
> > them cannot change (ie even if "is_freed" were to be set the array is
> > still stable).  
> 
> Yeah, the entries is fixed. If the ei itself gets freed, so does all the
> entries at the same time. The individual entries should too.
> 
> Hmm, it probably doesn't even make sense to continue the loop if is_freed
> is set as the same variable will be checked every time. :-/  Should just be
> a "break;" not a "continue;"

Also, I just realized it breaks if we update the 'c--' before the callback. :-/

I have to put this check *after* the callback check.

Reason being, the callback can say "this event doesn't get this file" and
return 0, which tells eventfs to skip this file.

For example, we have

 # ls /sys/kernel/tracing/events/ftrace/function
format  hist  hist_debug  id  inject

and

 # ls /sys/kernel/tracing/events/sched/sched_switch/
enable  filter  format  hist  hist_debug  id  inject  trigger

The "ftrace" event files are for information only. They describe the
internal events. For example, the "function" event is what is written into
the ring buffer by the function tracer. That event is not enabled by the
events directory. It is only enabled when "function" is written into
current_tracer.

Same for filtering. The filter logic for function events is done by the
"set_ftrace_filter" file in tracefs.

But the "sched_switch" event is enabled and filtered by the eventfs
directory. Here we see "enable" and "filter" files that the user could
write into to enabled and/or filter the sched_switch event.

Now because the "function" and "sched_switch" registered the same way, the
callback that handles the two has:

static int event_callback(const char *name, umode_t *mode, void **data,
			  const struct file_operations **fops)
{
	struct trace_event_file *file = *data;
	struct trace_event_call *call = file->event_call;

[..]
	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
		if (call->class->reg && strcmp(name, "enable") == 0) {
			*mode = TRACE_MODE_WRITE;
			*fops = &ftrace_enable_fops;
			return 1;
		}

		if (strcmp(name, "filter") == 0) {
			*mode = TRACE_MODE_WRITE;
			*fops = &ftrace_event_filter_fops;
			return 1;
		}
	}
[..]
	return 0;
}

Where the function event has that "TRACE_EVENT_FL_IGNORE_ENABLE" flag set,
so when the entry for "enable" or "filter" is passed to it, it returns 0.

Before, where we had c-- after the callback, we had:

 # ls /sys/kernel/tracing/events/ftrace/function
format  hist  hist_debug  id  inject

After changing the c-- to before the callback I now get:

 # ls /sys/kernel/tracing/events/ftrace/function/
format  hist  hist  hist_debug  hist_debug  id  inject  inject

Where the missing "enable" and "filter" files caused the indexing to be
off, and the ls repeated "hist" and "hist_debug" because of it. Oh, and the
function event doesn't have "trigger" either which is why we get two
"inject" files.

I have to move the c-- update down. I can still do it before creating the
dentry though, as if that fails, we should just bail.

-- Steve

