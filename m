Return-Path: <linux-kernel+bounces-165411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B288B8C65
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117ABB23EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEB612FB09;
	Wed,  1 May 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYSPzSqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9B5FBB1;
	Wed,  1 May 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575540; cv=none; b=XcGKMzGLsmEOqgq210NKp9iz0IkFMyc9Xs9NSuk88GJJYGALP8UriNvqTZ1D52+bwkGNfNXprBJTSI11IeIms0qrUTy2uEpDf/5do9PAP4C8l2nfzEqE1Bq1u8bn/sCMrjkQrNpeHBxDOIJJHfXp/u0rWs7Oo7F1dKVsHZRxyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575540; c=relaxed/simple;
	bh=397yuEegza1YdxCHGmXo6Fr1V3efYfawXEgbly0+WSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKEKTi1cFHsQnK1Wb+WFhJw6Q00IgYivFww33zOIhZeiK1wazYBRCSsuCum37Rf6xYqsfMJgJ/ETysVqTT5RCUmNhAvxDgGW6dVOvH457TiPw0BdfPuaI3nYRAbwNpiyTa8t4rD0SVUIF2x6nl8VDGQbv/x0MZzJdhcvZdxp79I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYSPzSqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37583C4AF18;
	Wed,  1 May 2024 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714575540;
	bh=397yuEegza1YdxCHGmXo6Fr1V3efYfawXEgbly0+WSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYSPzSqHFLggbq/xDWYyuhjhUA3byLwI0cx20K+Ar9H0VFMume+4mA27mZufxXN/J
	 VKgOoUDQemQOr7L3Ygs+Gga6YEZcBqDMORKkDNDsWFVWM6k74eSypUDVzcnPqME0d1
	 On1AuvdGl3WZuSpo3YqkwaV3plOdeqN3b9AFy5bqX+qHtznRQtYeLOe4geDiyoj6Wr
	 +pVoO67wG+b53CM0KBXBz45w+0LkBJMbzFSDEyL3EJ7qRUk97dtX9zUBeIueBeFdgN
	 m92gi+XSOseCE6xMOh+VvwTCIDrfyAMnReFeSM0HHb1iBks0/k4qQowBV2E/n7X1od
	 zuI3FXuNKBwMA==
Date: Wed, 1 May 2024 17:57:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as
 memmap=nn*align:name
Message-ID: <ZjJYV7ak5ApgNTBx@kernel.org>
References: <20240409210254.660888920@goodmis.org>
 <20240409211351.075320273@goodmis.org>
 <202404091521.B63E85D@keescook>
 <20240409191156.5f92a15c@gandalf.local.home>
 <202404091638.2F98764A41@keescook>
 <Zhmgm86tzpanoweB@kernel.org>
 <20240412181940.3e1d99f7@gandalf.local.home>
 <202404151017.FC002AA5@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404151017.FC002AA5@keescook>

On Mon, Apr 15, 2024 at 10:22:53AM -0700, Kees Cook wrote:
> On Fri, Apr 12, 2024 at 06:19:40PM -0400, Steven Rostedt wrote:
> > On Fri, 12 Apr 2024 23:59:07 +0300
> > Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > On Tue, Apr 09, 2024 at 04:41:24PM -0700, Kees Cook wrote:
> > > > On Tue, Apr 09, 2024 at 07:11:56PM -0400, Steven Rostedt wrote:  
> > > > > On Tue, 9 Apr 2024 15:23:07 -0700
> > > > > Kees Cook <keescook@chromium.org> wrote:
> > > > >   
> > > > > > Do we need to involve e820 at all? I think it might be possible to just
> > > > > > have pstore call request_mem_region() very early? Or does KASLR make
> > > > > > that unstable?  
> > > > > 
> > > > > Yeah, would that give the same physical memory each boot, and can we
> > > > > guarantee that KASLR will not map the kernel over the previous location?  
> > > > 
> > > > Hm, no, for physical memory it needs to get excluded very early, which
> > > > means e820.  
> > > 
> > > Whatever memory is reserved in arch/x86/kernel/e820.c, that happens after
> > > kaslr, so to begin with, a new memmap parameter should be also added to
> > > parse_memmap in arch/x86/boot/compressed/kaslr.c to ensure the same
> > > physical address will be available after KASLR.
> > 
> > But doesn't KASLR only affect virtual memory not physical memory?
> 
> KASLR for x86 (and other archs, like arm64) do both physical and virtual
> base randomization.
> 
> > This just makes sure the physical memory it finds will not be used by the
> > system. Then ramoops does the mapping via vmap() I believe, to get a
> > virtual address to access the physical address.
> 
> I was assuming, since you were in the e820 code, that it was
> manipulating that before KASLR chose a location. But if not, yeah, Mike
> is right -- you need to make sure this is getting done before
> decompress_kernel().

Right now kaslr can handle up to 4 memmap regions and parse_memmap() in
arch/x86/boot/compressed/kaslr.c should be updated for a new memmap type.

But I think it's better to add a new kernel parameter as I suggested in
another email and teach mem_avoid_memmap() in kaslr.c to deal with it, as
well as with crashkernel=size@offset, btw.
 
> -- 
> Kees Cook

-- 
Sincerely yours,
Mike.

