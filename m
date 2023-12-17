Return-Path: <linux-kernel+bounces-2885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9B81639B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D1D1F21BF0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9284B143;
	Sun, 17 Dec 2023 23:56:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B74B12A;
	Sun, 17 Dec 2023 23:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB8EC433C8;
	Sun, 17 Dec 2023 23:56:55 +0000 (UTC)
Date: Sun, 17 Dec 2023 18:56:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Add disable-filter-buf option
Message-ID: <20231217185652.0cd0f10c@rorschach.local.home>
In-Reply-To: <20231217171045.21e0bd95c26f17f1f19f6733@kernel.org>
References: <20231215102633.7a24cb77@rorschach.local.home>
	<21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
	<20231215120417.567d5ea4@rorschach.local.home>
	<fbf8991a-ce83-462c-b87a-b60c6635d223@efficios.com>
	<20231215123458.63f57238@rorschach.local.home>
	<f1a75239-341e-4611-a48d-88e10407dcd4@efficios.com>
	<20231215134335.2388aba5@rorschach.local.home>
	<368d36b2-e5ea-46d4-b214-6d04cf20685a@efficios.com>
	<20231217171045.21e0bd95c26f17f1f19f6733@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 17:10:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >> It exposes the following details which IMHO should be hidden or
> > >> configurable in a way that allows moving to a whole new mechanism
> > >> which will have significantly different characteristics in the
> > >> future:
> > >>
> > >> It exposes that:
> > >>
> > >> - filtering uses a copy to a temporary buffer, and
> > >> - that this copy is enabled by default.
> > >>
> > >> Once exposed, those design constraints become immutable due to ABI.  
> > > 
> > > No it is not. There is no such thing as "immutable ABI". The rule is
> > > "don't break user space" If this functionality in the kernel goes away,
> > > the knob could become a nop, and I doubt any user space will break
> > > because of it.
> > > 
> > > That is, the only burden is keeping this option exposed. But it could
> > > be just like that light switch that has nothing connected to it. It's
> > > still there, but does nothing if you switch it. This knob can act the
> > > same way. This does not in anyway prevent future innovation.  
> > 
> > I am not comfortable with exposing internal ring buffer implementation
> > details to userspace which may or may not be deprecated as no-ops
> > in the future. This will lead to useless clutter.  
> 
> Hmm, but this may change the ring buffer consumption rate if the filter
> is enabled. The ring buffer may be filled quickly than the user expected.

WHich it has been since 0fc1b09ff1ff4 ("tracing: Use temp buffer when
filtering events"), and before that commit, things were a bit slower.
That commit sped things up. But, even with that commit, there's no
guarantee that you will get to use the temp buffer and just write
directly into the ring buffer.

And I found that currently histograms (and sythetic events!) also write
directly into the buffer :-p


> Thus if user specifies the rare condition, most of the events on the ring
> buffer is filled with garbage. And user will know the buffer size *seems*
> smaller than the setting.

Not sure what you mean by that. The event on the buffer is removed
unless another event sneaks in and makes it impossible to reset the
next write location before the discarded event.

> I think copying overhead will be a secondary effect, the biggest noticable
> difference is how many events are recorded in the ring buffer. Thus, what
> about naming the option as "filter-on-buffer"?

I'm not sure I understand that. How about just call it "filter_direct",
which means to write directly on the buffer, and default that off.

> 
> If we introduce filtering on input directly, at that point we will use
> it if "filter-on-buffer = no", because this is also not noticable from
> users.

The "filter on input" will be a different interface, as the current
filter is only on the output of TRACE_EVENT() fields. The input
parameters isn't exposed at all, and may never be, as that would make
peterz and others keep all tracepoints from their subsystems.

As my main motivation for this was to create a kselftest that can
stress test the filtering directly into the ring buffer (like it use
to, and like it does for interrupting events and histograms and
synthetic events), we can still add tests to make sure that part works.

I'm fine slapping a Kconfig of CONFIG_TRACE_FORCE_DIRECT_KNOB and
place the documentation in the help content saying it adds a knob to
allow kselftest stress test the direct to ring buffer filtering.

-- Steve

