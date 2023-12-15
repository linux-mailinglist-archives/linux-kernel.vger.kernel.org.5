Return-Path: <linux-kernel+bounces-1350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C007814DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161EB2854F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CC3EA8D;
	Fri, 15 Dec 2023 17:04:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934433EA78;
	Fri, 15 Dec 2023 17:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3050C433C8;
	Fri, 15 Dec 2023 17:04:19 +0000 (UTC)
Date: Fri, 15 Dec 2023 12:04:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Add disable-filter-buf option
Message-ID: <20231215120417.567d5ea4@rorschach.local.home>
In-Reply-To: <21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
References: <20231215102633.7a24cb77@rorschach.local.home>
	<21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 10:53:39 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> 
> I'm not convinced that a boolean state is what you need here.

I will admit the biggest motivation for this was to allow for debugging ;-)

> 
> Yes, today you are in a position where you have two options:
> 
> a) use the filter buffer, which falls back on copy to ring buffer
>     if nested,
> 
> b) disable the filter buffer, and thus always copy to ring buffer
>     before filtering,
> 
> But I think it would not be far-fetched to improve the implementation
> of the filter-buffer to have one filter-buffer per nesting level
> (per execution context), or just implement the filter buffer as a
> per-cpu stack, which would remove the need to fall back on copy
> to ring buffer when nested. Or you could even do like LTTng and
> filter on the input arguments directly.

The filtering on the input arguments is much more difficult as they are
not exposed to user space. I plan on adding that feature, but it will
be more tied to the probe infrastructure, and be separate from this
type of filtering.

When looking at removing the discard, I found that the histogram logic
currently depends on writing to the ring buffer directly. That's
because it needs to know the timestamp, and may or may not discard it.
I'll have to look at this code more and see if I can get rid of that.
In fact, this patch taps into that logic (it's what added the
tracing_set_filter_buffering() function.

> 
> But each of these changes would add yet another boolean tunable,
> which can quickly make the mix hard to understand from a user
> perspective.

Honestly, if I do the stack filtering (it's already per_cpu), it will
replace this altogether, and this option will still be available. That
is, it will switch off buffering an event regardless of the
implementation.

> 
> So rather than stacking tons of "on/off" switches for filter
> features, how about you let users express the mechanism they
> want to use for filtering with a string instead ? e.g.
> 
> filter-method="temp-buffer"
> filter-method="ring-buffer"
> filter-method="input-arguments"

If I add other ways to filter, it will be a separate file to control
that, but all options are on/off switches. Even if I add other
functionality to the way buffers are created, this will still have the
same functionality to turn the entire thing on or off.

Thanks for the review.

-- Steve

