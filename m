Return-Path: <linux-kernel+bounces-62563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383478522F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8734B24270
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAF7539E;
	Tue, 13 Feb 2024 00:12:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4CA4C64;
	Tue, 13 Feb 2024 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783174; cv=none; b=PWU21QAeUOo1w0GhTXlVC8SPn42jdG3qraUfeE7N+NwERPQI05HuvVWHSxAQDG3yAz+lIMfL0bx6lTzJF4JHEoy4HHB+cpbbZoGD0Rl9TAfBSoRggWAbBFgKezDcMNmT4t3nJV5b8wDP8uo41zCKeK7QhBaBjh/UvZak8EqZeOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783174; c=relaxed/simple;
	bh=snpDxC/p4DzWPM0PkZK4dv4AVgd2kVSFn1TwirwJ8sI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prao1NMHHAIUNhTWXpB7ZkCcoeXfcrRvCmZSjfa68reM8yDbqb4bmN0LGt2y3UO8ZYRuWYuDZ0XqPDO4ryv1tRzHyM/J5pVaNK86zIyOHerdKA1q6qhDX5/mpBrsddjEivJ9zVTaH16/TFCRCnBbEC1rG+61nOE2KHLwe6kSBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389C3C433C7;
	Tue, 13 Feb 2024 00:12:53 +0000 (UTC)
Date: Mon, 12 Feb 2024 19:13:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Vincent Donnefort
 <vdonnefort@google.com>, Sven Schnelle <svens@linux.ibm.com>, Mete Durlu
 <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have saved_cmdlines arrays all in one
 allocation
Message-ID: <20240212191336.5c502f78@gandalf.local.home>
In-Reply-To: <ef94259e139e4579ee27db99975dc4cf397e2a06.camel@linux.intel.com>
References: <20240212180941.379c419b@gandalf.local.home>
	<ef94259e139e4579ee27db99975dc4cf397e2a06.camel@linux.intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 15:39:03 -0800
Tim Chen <tim.c.chen@linux.intel.com> wrote:

> > diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> > index e4fbcc3bede5..210c74dcd016 100644
> > --- a/kernel/trace/trace_sched_switch.c
> > +++ b/kernel/trace/trace_sched_switch.c
> > @@ -201,7 +201,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
> >  	int order;
> >  
> >  	/* Figure out how much is needed to hold the given number of cmdlines */
> > -	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
> > +	orig_size = sizeof(*s) + val * (TASK_COMM_LEN + sizeof(int));  
> 
> Strictly speaking, *map_cmdline_to_pid is unsigned int so it is more consistent
> to use sizeof(unsigned) in line above.  But I'm nitpicking and I'm fine to
> leave it as is.

I was thinking about making that into a macro as it is used in two places.

/* Holds the size of a cmdline and pid element */
#define SAVED_CMDLINE_MAP_ELEMENT_SIZE(s)		\
	(TASK_COMM_LEN + sizeof((s)->map_cmdline_to_pid[0]))

	orig_size = sizeof(*s) + val * SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);

> 
> >  	order = get_order(orig_size);
> >  	size = 1 << (order + PAGE_SHIFT);
> >  	page = alloc_pages(GFP_KERNEL, order);
> > @@ -212,16 +212,11 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
> >  	memset(s, 0, sizeof(*s));
> >  
> >  	/* Round up to actual allocation */
> > -	val = (size - sizeof(*s)) / TASK_COMM_LEN;
> > +	val = (size - sizeof(*s)) / (TASK_COMM_LEN + sizeof(int));

	val = (size - sizeof(*s)) / SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);

-- Steve

> >  	s->cmdline_num = val;
> >  
> > -	s->map_cmdline_to_pid = kmalloc_array(val,
> > -					      sizeof(*s->map_cmdline_to_pid),
> > -					      GFP_KERNEL);
> > -	if (!s->map_cmdline_to_pid) {
> > -		free_saved_cmdlines_buffer(s);
> > -		return NULL;
> > -	}
> > +	/* Place map_cmdline_to_pid array right after saved_cmdlines */
> > +	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val * TASK_COMM_LEN];
> >  
> >  	s->cmdline_idx = 0;
> >  	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,  


