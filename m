Return-Path: <linux-kernel+bounces-88807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52B586E6DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E828F6BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359B848E;
	Fri,  1 Mar 2024 17:09:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC926FC9;
	Fri,  1 Mar 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312953; cv=none; b=Ll7XEc9hJ1ZFBhsk7S4dhqziXnwdx56JxfUV2ZHlr/Mb/GTrmD3UIFa+SNp4Z3TNVcZuJsqmY9kHsJ21yQCX4NiEABs11pofoFOCqXfpzuDQL9DJqULMh2CCW7PXSoikzpbE/NXJ98aipYUvOF2Tqc4BFOe6ln2FItUuKcXDqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312953; c=relaxed/simple;
	bh=XDqoJAXdIq1KRDq0R/8lbUoPXXIchNJTUrkc2hFa5YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBnN0q60oJGdA4C+pCOSBSj7DWXuNtcV1tR8Hid9Kh+l7zAEZr+DD6lPzCEimq9kSS/I3+KIoJsN8wvf19716VechrFhYIr/2kBBE5+6RXS1KuxCSzuLmR8wcMmV6fk7li+LG5HdWsaldcWYl16UdzTBzfhPRUjFlXjaXfnSI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EAAC433C7;
	Fri,  1 Mar 2024 17:09:12 +0000 (UTC)
Date: Fri, 1 Mar 2024 12:11:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linke <lilinke99@qq.com>, paulmck <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>, Josh Triplett
 <josh@joshtriplett.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] ring-buffer: use READ_ONCE() to read
 cpu_buffer->commit_page in concurrent environment
Message-ID: <20240301121121.47b4fbdd@gandalf.local.home>
In-Reply-To: <fde2e34a-2f5f-4bee-8f6f-60acf2e0d4a3@efficios.com>
References: <tencent_3F31ADAB6142D8948E5BD02B854ED2A77106@qq.com>
	<20240301104945.43119349@gandalf.local.home>
	<fde2e34a-2f5f-4bee-8f6f-60acf2e0d4a3@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 11:37:54 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-03-01 10:49, Steven Rostedt wrote:
> > On Fri, 1 Mar 2024 13:37:18 +0800
> > linke <lilinke99@qq.com> wrote:
> >   
> >>> So basically you are worried about read-tearing?
> >>>
> >>> That wasn't mentioned in the change log.  
> >>
> >> Yes. Sorry for making this confused, I am not very familiar with this and
> >> still learning.  
> > 
> > No problem. We all have to learn this anyway.
> >   
> >>  
> >>> Funny part is, if the above timestamp read did a tear, then this would
> >>> definitely not match, and would return the correct value. That is, the
> >>> buffer is not empty because the only way for this to get corrupted is if
> >>> something is in the process of writing to it.  
> >>
> >> I agree with you here.
> >>
> >> 	commit = rb_page_commit(commit_page);
> >>
> >> But if commit_page above is the result of a torn read, the commit field
> >> read by rb_page_commit() may not represent a valid value.  
> > 
> > But commit_page is a word length, and I will argue that any compiler that
> > tears "long" words is broken. ;-)  
> 
> [ For those tuning in, we are discussing ring_buffer_iter_empty()
>    "commit_page = cpu_buffer->commit_page;" racy load. ]
> 
> I counter-argue that real-world compilers *are* broken based on your
> personal definition, but we have to deal with them, as documented
> in Documentation/memory-barriers.txt (see below).
> 
> What is the added overhead of using a READ_ONCE() there ? Why are
> we wasting effort trying to guess the compiler behavior if the
> real-world performance impact is insignificant ?
> 
> Quote from memory-barrier.txt explaining the purpose of {READ,WRITE}_ONCE():
> 
> "(*) For aligned memory locations whose size allows them to be accessed
>       with a single memory-reference instruction, prevents "load tearing"
>       and "store tearing," in which a single large access is replaced by
>       multiple smaller accesses."
> 
> I agree that {READ,WRITE}_ONCE() are really not needed at initialization,
> when there are demonstrably no concurrent accesses to the data
> 
> But trying to eliminate {READ,WRITE}_ONCE() on concurrently accessed fields
> just adds complexity, prevents static analyzers to properly understand the
> code and report issues, and just obfuscates the code.
> 
> Thanks,
> 
> Mathieu
> 
> >   
> >>
> >> In this case, READ_ONCE() is only needed for the commit_page.  
> > 
> > But we can at least keep the READ_ONCE() on the commit_page just because it
> > is used in the next instruction.
> 

And here I did state that READ_ONCE() does have another use case. So
there's no argument about adding it here.

-- Steve


