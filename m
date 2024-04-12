Return-Path: <linux-kernel+bounces-143346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED38A3770
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35468285746
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF591149006;
	Fri, 12 Apr 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFsV9t9s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299EB3D0B8;
	Fri, 12 Apr 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955618; cv=none; b=GRTKeQjVFdOHfekDtVLW5wX0/tYQ+rfzhW+SnUkanIaJJZRE1f7a39OLa4BPy2fQ0pg1sYuRhmk3Pfx06cRuwSNVG11tD14/QAwDmMYMDiTEw/sU4F8wBdx5fv8vkKuAgXH317c/jAPZGAxyAzw9mNAunHPvCBHnfbb1RCzrP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955618; c=relaxed/simple;
	bh=ufExrA51nJyDuRZXOc6Zqlx89622UOkI5PEpjDpkuFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp8emQNQyaC95k2tdM88XmneZPbgxjmGNcYoEHWcWPFT3qHMLZLkVAAaB0tfjAt0C9y3UdJml4hRGHPqFj4KvVIR1b02cj8ynpDAbGR8HA+UQT3f17D574QvPKn41HRSLILR0nIC+tpBfkDwDIj920mzUl1XRQf+66nhOcjuJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFsV9t9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6111BC2BD11;
	Fri, 12 Apr 2024 21:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712955617;
	bh=ufExrA51nJyDuRZXOc6Zqlx89622UOkI5PEpjDpkuFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFsV9t9s6+jpzEwEmP+dIWWBhZTPFt/rJGzOY6NZzVIQABiZruk5OcirG5RfZyaI9
	 27ZctoEN1U22XtTW9xZ5n2pIr06PaWb7bBC0Ni0SuZ0eaMoA79uJvs+gZCbYIrBCxU
	 TNq6G2mAbVIwDgOLIvHsBPwMzdFHb9/8gYHG+Oo2gPoaqHB1W2zpKXBMA/95RDgTtM
	 eNEGMhpqyDatnIsgX649O4JJVbadReziMgJhiahKHqaIvlVFPd5G0Qg9iQLKZTcdiE
	 4a4Z0QCDgYqvDj1lB6ZUvihWCdBiervg3/7lJMb7zUF2FgPIlc6qipDc4Qe9sQMnTy
	 xlxJ/gPTg75BQ==
Date: Fri, 12 Apr 2024 23:59:07 +0300
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
Message-ID: <Zhmgm86tzpanoweB@kernel.org>
References: <20240409210254.660888920@goodmis.org>
 <20240409211351.075320273@goodmis.org>
 <202404091521.B63E85D@keescook>
 <20240409191156.5f92a15c@gandalf.local.home>
 <202404091638.2F98764A41@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404091638.2F98764A41@keescook>

On Tue, Apr 09, 2024 at 04:41:24PM -0700, Kees Cook wrote:
> On Tue, Apr 09, 2024 at 07:11:56PM -0400, Steven Rostedt wrote:
> > On Tue, 9 Apr 2024 15:23:07 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> > 
> > > Do we need to involve e820 at all? I think it might be possible to just
> > > have pstore call request_mem_region() very early? Or does KASLR make
> > > that unstable?
> > 
> > Yeah, would that give the same physical memory each boot, and can we
> > guarantee that KASLR will not map the kernel over the previous location?
> 
> Hm, no, for physical memory it needs to get excluded very early, which
> means e820.

Whatever memory is reserved in arch/x86/kernel/e820.c, that happens after
kaslr, so to begin with, a new memmap parameter should be also added to
parse_memmap in arch/x86/boot/compressed/kaslr.c to ensure the same
physical address will be available after KASLR.

More generally, memmap= is x86 specific and a bit of a hack.
Why won't you add a new kernel parameter that will be parsed in, say, 
mm/mm_init.c and will create the mmap_map (or whatever it will be named)
and reserve that memory in memblock rather than in e820?

This still will require update to arch/x86/boot/compressed/kaslr.c of
course.

> So, yeah, your proposal makes sense. I'm not super excited
> about this be x86-only though. What does arm64 for for memmap?
> 
> -- 
> Kees Cook
> 

-- 
Sincerely yours,
Mike.

