Return-Path: <linux-kernel+bounces-107870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846338802C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5DD1F236BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0C61BC49;
	Tue, 19 Mar 2024 16:56:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09218EC0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867372; cv=none; b=ADSy52U4qg75oHJ+tiIPqYPAHyAQXmPnI22JjqsuarQBggmLJFhKlJayvetTC/55SmrmGe7iR6sXnn9ks/AmcTOCKa9u9jd5TWP19ri2kWsvzIcj8r3GuCpW3OxwNfEenYHkN1FtkGVOGxuvnMFp9TTf4wwIhrA1/Pb0yN4Acyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867372; c=relaxed/simple;
	bh=shhA6J6IcnJOSAhU1RZmsl4eapiTt7sfthNIV7XitGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF2DehjFNsuujV2I0oFmxdqlRIhDKxvP5X8vpQcKX7in/fVla0fmtidz9BOsyjkvR8jyTFvzsDNaDl3dWDGthKmiuzN333uesKkQmsUZbrwdvOvA+DY3HwKedo1eOkoJM1FFl+iNpWVfHKDduXLYzNZRZnMXp3FjVLPIMn1ZXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB314C433C7;
	Tue, 19 Mar 2024 16:56:10 +0000 (UTC)
Date: Tue, 19 Mar 2024 12:58:33 -0400
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
Message-ID: <20240319125833.30098a37@gandalf.local.home>
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
> 
> Also, looking at that __assign_str() macro, it seems literally insane.
> On the next line it will do
> 
>                 memcpy(__str__, __data_offsets.dst##_ptr_ ? :           \
>                        EVENT_NULL_STR, __len__);                        \
> 
> so now it checks "__data_offsets.dst##_ptr_" for NULL - but that's one
> line after it just did that strcmp on it.
> 
> WTF?
> 
> This code is completely bogus.

The WARN_ON_ONCE() was added separately and missed that we do now allow it
to be NULL.

I'll fix that.

-- Steve

