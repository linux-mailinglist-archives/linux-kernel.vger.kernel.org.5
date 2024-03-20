Return-Path: <linux-kernel+bounces-108273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF48808A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3FB1F23DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35BA47;
	Wed, 20 Mar 2024 00:41:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EA4C7E;
	Wed, 20 Mar 2024 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895310; cv=none; b=aPuzcQqELS4/8bxoerH/piexXK28VNweC5ooAoAw4ptT2/Da7axFQLfnIePoj5vCMx5H+pwvsNNNj6c2Nkqn6mEJ7HRCzgkgSGgpj5sYyMcSjPdkHaf5GWm1X/ue02O2LHaJku6QBK2baGkhVhVQFJbX5LAKxzjqqJH9F6a6QeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895310; c=relaxed/simple;
	bh=ajojewtS5GOwYcGGsxv3U2sYM7eoNoLJkIimpLEMk7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LT2hN8FjCHqGayNtmxp2lqAfmDDEMQrIwWq46tjLrFjECqj+HmNqf3Aj/YqprObr0DYuL+Hn+eE0oZq88tROdFZcGY+Vo0y7kcn1IKaWfxaXJujRc0zZZzC2upAmv7+voyRd4xRbpgLagYD9mUZBOoyjuxhamDiPG5ebWI0UsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A464C433F1;
	Wed, 20 Mar 2024 00:41:47 +0000 (UTC)
Date: Tue, 19 Mar 2024 20:44:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>, Ingo Molnar
 <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com, Thomas Gleixner <tglx@linutronix.de>, Vineeth Pillai
 <vineeth@bitbyteword.org>, Youssef Esmat <youssefesmat@google.com>, Beau
 Belgrave <beaub@linux.microsoft.com>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, "Paul E.
 McKenney" <paulmck@kernel.org>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/8] tracing: Persistent traces across a reboot or crash
Message-ID: <20240319204410.6cb9842b@gandalf.local.home>
In-Reply-To: <202403091234.DE25C77028@keescook>
References: <20240306015910.766510873@goodmis.org>
 <202403091016.5CDF0E2EE@keescook>
 <20240309135116.40f65cee@rorschach.local.home>
 <202403091234.DE25C77028@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 12:40:51 -0800
Kees Cook <keescook@chromium.org> wrote:

> The part I'd like to get wired up sanely is having pstore find the
> nvdimm area automatically, but it never quite happened:
> https://lore.kernel.org/lkml/CAGXu5jLtmb3qinZnX3rScUJLUFdf+pRDVPjy=CS4KUtW9tLHtw@mail.gmail.com/

The automatic detection is what I'm looking for.

> 
> > Thanks for the info. We use pstore on ChromeOS, but it is currently
> > restricted to 1MB which is too small for the tracing buffers. From what
> > I understand, it's also in a specific location where there's only 1MB
> > available for contiguous memory.  
> 
> That's the area that is specifically hardware backed with persistent
> RAM.
> 
> > I'm looking at finding a way to get consistent memory outside that
> > range. That's what I'll be doing next week ;-)
> > 
> > But this code was just to see if I could get a single contiguous range
> > of memory mapped to ftrace, and this patch set does exactly that.  
> 
> Well, please take a look at pstore. It should be able to do everything
> you mention already; it just needs a way to define multiple regions if
> you want to use an area outside of the persistent ram area defined by
> Chrome OS's platform driver.

I'm not exactly sure how to use pstore here. At boot up I just need some
consistent memory reserved for the tracing buffer. It just needs to be the
same location at every boot up.

I don't need a front end. If you mean a way to access it from user space.
The front end is the tracefs directory, as I need all the features that the
tracefs directory gives.

I'm going to look to see how pstore is set up in ChromeOS and see if I can
use whatever it does to allocate another location.

-- Steve

