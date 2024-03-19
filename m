Return-Path: <linux-kernel+bounces-107884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416658802FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B5AB23A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F9E134CB;
	Tue, 19 Mar 2024 17:04:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C6111B1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867873; cv=none; b=KLNq8orYQZ65FjNiwPBgeS4bML01R+MkYTMjgunS6Vf4CMkBpy6W/uhIIqI4vHhHPhDLa83CLuiuHL/ehvMTQDvVoa4235jiRWmtN+hATsaDFmuBU8KCQVu5XJI7Nmnu57o3kRIElK5CnuOiDIg0nyKQS9pcaD2v5qgfhivaEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867873; c=relaxed/simple;
	bh=0f0Lamjx/p5FWofoisDahieLZWYw9/EunEeJsbYhEV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbITUaqMeSGwCiNRib9FA/+nF13SIvnag41erDVEk5LAcX+n1k4MJufgrF2vtnL52qVMXjudxE3qskwH3Dmoel2Q2IbN9gMldoqS5y+ue0e//LZmDCwAALQSkXauEflcV1yEoSxvHVfgqCW9P16iRWPdoIX3eM9lcNbkXLNLRaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E9DC433C7;
	Tue, 19 Mar 2024 17:04:31 +0000 (UTC)
Date: Tue, 19 Mar 2024 13:06:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alison Schofield <alison.schofield@intel.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, John
 Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>,
 Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort
 <vdonnefort@google.com>, linke li <lilinke99@qq.com>
Subject: Re: [GIT PULL v2] tracing: Updates for v6.9
Message-ID: <20240319130653.0cfdaf6e@gandalf.local.home>
In-Reply-To: <CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com>
References: <20240318113053.7f87ce7f@gandalf.local.home>
	<CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 09:23:10 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 18 Mar 2024 at 08:28, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - Added checks to make sure that the source of __string() is also the
> >   source of __assign_str() so that it can be safely removed in the next
> >   merge window.  
> 
> Aargh.
> 
> I didn't notice this initially, because it doesn't happen with gcc (or
> maybe not with allmodconfig), but with clang I get
> 
>     CC [M]  net/sunrpc/sched.o
>   In file included from net/sunrpc/sched.c:31:
>   In file included from ./include/trace/events/sunrpc.h:2524:
>   In file included from ./include/trace/define_trace.h:102:
>   In file included from ./include/trace/trace_events.h:419:
>   include/trace/events/sunrpc.h:707:4: error: result of comparison
> against a string literal is unspecified (use an explicit string
> comparison function instead) [-Werror,-Wstring-compare]
> 
> and then about 250 lines ot messy "explanations" for how it was
> expanded because it happens on line 709 too in the same macro, and it
> ends up being three macros deep or something.
> 
> So no, this all needs to be re-done. That
> 
>                 WARN_ON_ONCE(__builtin_constant_p(src) ?                \
>                              strcmp((src), __data_offsets.dst##_ptr_) : \
>                              (src) != __data_offsets.dst##_ptr_);       \
> 
> does *NOT* work.

In most all cases, src is not a constant and should always equal to what was
passed to __string(), but if it is a constant like "some string" then clang
warns that comparing pointers to strings is UB.

That is,

	__string(src, mystring)

[..]

	__assign_str(src, mystring);

works, but if it has:

	__string(src, "this string");

then

	__assign_str(src, "this string");

is UB due to the compiler having two different pointers to "this string".

I originally just had the "src != str" check but then it was reported that
clang complained about it. It still complained with the
__builtin_constant_p() but the code that it produced did the right thing.

This is in the fast path (where the trace event happens), but I can make it
always do strcmp(), even though it will slow down what is being recorded,
as I plan on removing the parameter in the next merge window anyway.

-- Steve


