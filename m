Return-Path: <linux-kernel+bounces-62523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D81852253
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFFB1F2395E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AB14F608;
	Mon, 12 Feb 2024 23:11:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BF4F1E0;
	Mon, 12 Feb 2024 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779481; cv=none; b=LpL/gXp6MNJ8MofNeIE4+7RFTlqso/RBwubn9fwIVGhAZu1dwkzDm+LlkXuP+SeHreNq5TZ8k112cmpE0JV8S2wtjvdXNhxnTbCXZcybNaTyqZJeqiFoKn+kX8E6dNhPPYa9oRJt6iEswnLlLJNM+T0+lJME+zqULtDpsErU0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779481; c=relaxed/simple;
	bh=IeqVsqHBBxkRlvWKuRk+BM+q2fCSQTabzCOE3hEGlcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsbRWtgiD28n0YCwOarpTDvPQUz1SgZqSPHDqfmL7TLdMRGoqBaY9Zf54ED+mafGr1DcHrtSWRGzigJ/vV+vvlWch36u7buYCPx4O/TLE2s3psK4k0VzDVsICerCVGm6LSEqbAVjujM+CUTyySOci0pqMFMryq9hMVQ9VZxuBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22F4C43394;
	Mon, 12 Feb 2024 23:11:19 +0000 (UTC)
Date: Mon, 12 Feb 2024 18:12:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
Message-ID: <20240212181202.70f47870@gandalf.local.home>
In-Reply-To: <957e4c37-954f-4c35-98ba-df5edde4b5ce@linux.ibm.com>
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
	<20240205092353.523cc1ef@rorschach.local.home>
	<yt9d34u63xxz.fsf@linux.ibm.com>
	<yt9dsf262d2n.fsf@linux.ibm.com>
	<20240206060113.39c0f5bc@rorschach.local.home>
	<yt9deddovn3w.fsf@linux.ibm.com>
	<20240207060923.182ecb55@rorschach.local.home>
	<9a062196-ccbe-440e-a2f9-23eb8c5eb837@linux.ibm.com>
	<20240207072812.4a29235f@rorschach.local.home>
	<yt9dzfwch00u.fsf@linux.ibm.com>
	<20240207104703.071ee985@rorschach.local.home>
	<8c986cb3-61b3-4f65-81c9-ffcfa994390f@linux.ibm.com>
	<20240212135320.26f90f28@gandalf.local.home>
	<957e4c37-954f-4c35-98ba-df5edde4b5ce@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 23:54:00 +0100
Mete Durlu <meted@linux.ibm.com> wrote:

> On 2/12/24 19:53, Steven Rostedt wrote:
> > 
> > Right, it will definitely force the race window to go away.
> > 
> > Can you still trigger this issue with just Sven's patch and not this change?  
> Sven's patch makes the test cases much more resilient. I needed to ramp
> up the load up to 4 stressors on a 4 core system before the test starts
> to fail again. At this point it is fair to say that the system is under
> significant load.
> 
> The failing condition is now different, which tells me that
> Sven's patch have already solved(or improved) the previous issue.
> What is failing now:
> 
>    echo '** ENABLE TRACING'
>    enable_tracing
> 
>    cnt=`cnt_trace`
>    if [ $cnt -eq 0 ]; then
>       fail "Nothing found in trace"
>    fi
> 
> Adding a sleep between enable_tracing and cnt_trace seems to improve the
> situation a lot. (my guess is that, the trace writer isn't getting any
> runtime before the test checks the trace output)
> 
>    echo '** ENABLE TRACING'
>    enable_tracing
> 
>   +sleep $SLEEP_TIME
>    cnt=`cnt_trace`
>    if [ $cnt -eq 0 ]; then
>       fail "Nothing found in trace"
>    fi
> 
> Didn't see any failure while increasing the system load until 8
> stressors (this might have been luck). When system was under load with
> 8 stressors, I have seen the test failing 2 out of 10 times. Definitely
> an improvement over the current situation.
> 


So, I plan on adding Sven's patch for my next pull request to Linus. I had
forgotten it when I did my last one (largely due to traveling). I'll hold
off a week to see if any other fixes come in.

-- Steve

