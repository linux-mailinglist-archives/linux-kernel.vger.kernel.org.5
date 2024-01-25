Return-Path: <linux-kernel+bounces-39073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A40983CA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4BC1C2119F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858D1339A3;
	Thu, 25 Jan 2024 18:07:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1D12FF99
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206053; cv=none; b=TNihoA4Yq71TLLoPn8sABT9gydvyfWkiuP6e6yaXme71C8m3I8bIC2sN6joKd6mT8sz0Hjd4PH1bVBCq7NSkgwuVmMOk1gCzDHq03nRRbOF+kZM2gxpM1K+QDuFx+N5jLb+Tthy+tWg5yNAJ188pT1b8aqI4URvqV05KUOZK0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206053; c=relaxed/simple;
	bh=1ha2NkqwcEhVF22kW7frlLxGPQjna2Lf2KSUzxUzFwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naK2bsQ4kTYacWVg7j7dNv1nXv5A62koah9c4Pnt7cUl3LwEES6P2XabX6fu9AD8Q30c4kYtiK+2v+zXRdImb6+y2HZ0s366PtQFbdAYxlunaUk1p7REmYkGUqRKolIhzo8LICqw00hsLA3gT7GgPAdKhjFulgICFOk9JLf120A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6826C433C7;
	Thu, 25 Jan 2024 18:07:31 +0000 (UTC)
Date: Thu, 25 Jan 2024 13:07:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240125130731.3b0e2a42@gandalf.local.home>
In-Reply-To: <20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
	<20240122100630.6a400dd3@gandalf.local.home>
	<CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
	<20240122114743.7e46b7cb@gandalf.local.home>
	<CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
	<CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
	<CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
	<20240122144443.0f9cf5b9@gandalf.local.home>
	<20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 18:40:31 +0100
Christian Brauner <brauner@kernel.org> wrote:

> But luckily no one is probably going to tar up tracefs. ;)

Actually, inodes isn't the biggest issue of tar, as tar *is* a common
operation on tracefs.

If you want to create a synthetic event using the sqlhist tool for an
embedded board, we recommend copying the tracefs directory over to your
workstation from the embedded device. Unfortunately tar never works. That's
because all tracefs (and debugfs) files have zero size in stat().

 # cd /tmp
 # (cd /sys/kernel && tar cvf - tracing) | tar xvf -
 # ls -s tracing
total 28
0 available_events                  0 max_graph_depth         0 stack_trace
0 available_filter_functions        4 options                 0 stack_trace_filter
0 available_filter_functions_addrs  4 osnoise                 0 synthetic_events
0 available_tracers                 4 per_cpu                 0 timestamp_mode
0 buffer_percent                    0 printk_formats          0 touched_functions
0 buffer_size_kb                    0 README                  0 trace
0 buffer_subbuf_size_kb             0 recursed_functions      0 trace_clock
0 buffer_total_size_kb              0 saved_cmdlines          0 trace_marker
0 current_tracer                    0 saved_cmdlines_size     0 trace_marker_raw
0 dynamic_events                    0 saved_tgids             0 trace_options
0 dyn_ftrace_total_info             0 set_event               0 trace_pipe
0 enabled_functions                 0 set_event_notrace_pid   4 trace_stat
0 error_log                         0 set_event_pid           0 tracing_cpumask
0 eval_map                          0 set_ftrace_filter       0 tracing_max_latency
4 events                            0 set_ftrace_notrace      0 tracing_on
0 free_buffer                       0 set_ftrace_notrace_pid  0 tracing_thresh
0 function_profile_enabled          0 set_ftrace_pid          0 uprobe_events
4 hwlat_detector                    0 set_graph_function      0 uprobe_profile
4 instances                         0 set_graph_notrace       0 user_events_data
0 kprobe_events                     0 snapshot                0 user_events_status
0 kprobe_profile                    0 stack_max_size

So instead we have been recommending cp -r

Note, for the sqlhist command, only the events are needed, so the
instructions is only to copy the events directory, because copying all of
tracefs will try to copy the "trace_pipe" file which will block which hangs
'cp'. And I don't know an option to tell the cp command not to block.

 # cd /tmp
 # mkdir tracing
 # cp -r /sys/kernel/tracing/events tracing/events
 # ls -s tracing/events/sched/sched_switch/
total 20
4 enable  4 filter  4 format  0 hist  0 hist_debug  4 id  0 inject  4 trigger

Where the tar would have had:

 # ls -s tracing/events/sched/sched_switch/
total 0
0 enable  0 filter  0 format  0 hist  0 hist_debug  0 id  0 inject  0 trigger


-- Steve

