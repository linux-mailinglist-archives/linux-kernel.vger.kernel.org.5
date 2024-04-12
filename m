Return-Path: <linux-kernel+bounces-143403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E508A3880
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9647CB2305C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF615219F;
	Fri, 12 Apr 2024 22:19:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF01514F8;
	Fri, 12 Apr 2024 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712960385; cv=none; b=VaZd0LwFSVmbP0n6cwQYUTXMTW03bUY5A3tmKwcwL9w/m2ujZRm7wnkShJuvgZC7tJuV5qWT2XD9+paDDJLia1P32ejz5x/DA94vNFlqXkJGK02+b9XbWf1sCAMYU3UJGD+J0Q9HDQ0hwIYTx9p6WTF2ZHh4HgVbTjSeVnUY0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712960385; c=relaxed/simple;
	bh=/onQSb447PUp3dDVYzH/jjnW7A1pQYjgI2ywHWde/3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3mXSPS7S5duBjgUEbkYKdBGHk9wM1ufpvknbrAtn25h/bV7muc4LK0Ug3e8TLyA08bM5fcb/oCnp/xFAvmEC8SbLxKtX0REYduMOvWA8GUiexUM9KsbfZTbfk6er1TxZyIftkz+fwUZRfDjiF09KM3p7ZrKJ8pdOOlQTwTZIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37F5C113CC;
	Fri, 12 Apr 2024 22:19:41 +0000 (UTC)
Date: Fri, 12 Apr 2024 18:19:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, wklin@google.com, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as
 memmap=nn*align:name
Message-ID: <20240412181940.3e1d99f7@gandalf.local.home>
In-Reply-To: <Zhmgm86tzpanoweB@kernel.org>
References: <20240409210254.660888920@goodmis.org>
	<20240409211351.075320273@goodmis.org>
	<202404091521.B63E85D@keescook>
	<20240409191156.5f92a15c@gandalf.local.home>
	<202404091638.2F98764A41@keescook>
	<Zhmgm86tzpanoweB@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 23:59:07 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> On Tue, Apr 09, 2024 at 04:41:24PM -0700, Kees Cook wrote:
> > On Tue, Apr 09, 2024 at 07:11:56PM -0400, Steven Rostedt wrote:  
> > > On Tue, 9 Apr 2024 15:23:07 -0700
> > > Kees Cook <keescook@chromium.org> wrote:
> > >   
> > > > Do we need to involve e820 at all? I think it might be possible to just
> > > > have pstore call request_mem_region() very early? Or does KASLR make
> > > > that unstable?  
> > > 
> > > Yeah, would that give the same physical memory each boot, and can we
> > > guarantee that KASLR will not map the kernel over the previous location?  
> > 
> > Hm, no, for physical memory it needs to get excluded very early, which
> > means e820.  
> 
> Whatever memory is reserved in arch/x86/kernel/e820.c, that happens after
> kaslr, so to begin with, a new memmap parameter should be also added to
> parse_memmap in arch/x86/boot/compressed/kaslr.c to ensure the same
> physical address will be available after KASLR.

But doesn't KASLR only affect virtual memory not physical memory?

This just makes sure the physical memory it finds will not be used by the
system. Then ramoops does the mapping via vmap() I believe, to get a
virtual address to access the physical address.

> 
> More generally, memmap= is x86 specific and a bit of a hack.
> Why won't you add a new kernel parameter that will be parsed in, say, 
> mm/mm_init.c and will create the mmap_map (or whatever it will be named)
> and reserve that memory in memblock rather than in e820?

Hmm, I only did this approach because I'm familiar with the memmap hack and
extended upon it. But yeah, if I can do the same thing in mm_init.c it
could possibly work for all archs. Thanks for the suggestion, I'll play
with that.

> 
> This still will require update to arch/x86/boot/compressed/kaslr.c of
> course.

Oh, is the issue if KASLR maps the kernel over this location, then we lose
it? We need to tell KASLR not to touch this location?

-- Steve

