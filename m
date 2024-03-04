Return-Path: <linux-kernel+bounces-90697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC84870380
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E84B21A31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AD53F9D5;
	Mon,  4 Mar 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToVwlgxB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA93EA72;
	Mon,  4 Mar 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560732; cv=none; b=rUxUnTY/KGyWSqW7QEcRo9HBqD4QMJpbcGzC3qGi8F7uAQPGIDGjX0AVBcDQZuwourIHQTTZMNKZuBostqH86suNjV1mRferWPfnGiTtsyxavrCKIlt97iixjjPEhePicezjg5mJbQ55VZ8NUiWCbMJUyAdEvv7Z8wiH3o+FkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560732; c=relaxed/simple;
	bh=rQWP12B+ZOT796DFSjZOMLwUXkzwZeaMzqg82VZNbY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0qbtr1gF0uNFDJyAmzZFtmZXvpt5yJdJra1ATfERayuEbOnB++mEkRws+hNsKwQIS7pka7cwRQ8ctBNeAhhfBy0Ts3YWa/mgIIarTtW/D+PQU3Zclf18xOp7Nfu12P0WbtORbJb3g2E6M/pcEvWF+6owHdKcgw3JoWnLi84mmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToVwlgxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08703C43390;
	Mon,  4 Mar 2024 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709560732;
	bh=rQWP12B+ZOT796DFSjZOMLwUXkzwZeaMzqg82VZNbY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToVwlgxB6pd5r8A0uqzEe+rb9BkwmIOD17N8MR5OYURX12JuYAE3wgPmjTD9zNoNR
	 QAhTYYgfwZ7VMYidZRO6kz74w9RvRLcXDZUrTan9XU6FKhAw4KsMHw8PVSDNjx2fwg
	 1Seay5sLfD/PRijZMBwi3elk5glcDPDkcSiDebB+B1tkiPWicSWg16XWeLRsGr1llJ
	 Cl4IgSiwDK/V2XUfOaR1zEFfFg4SBxvWU+Nexn/XDRtOBkceRRIHBxlcVNwQatVBim
	 qDc54lB00pARuwtLE8DQ5WCYM6errmAT4loB+74fhVDyuZBUP9kwSffSGtnyhkOv4j
	 PNs3EMg4Twdpg==
Date: Mon, 4 Mar 2024 10:58:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/4] perf annotate: Improve memory usage for symbol
 histogram
Message-ID: <ZeXTmdhu3Y_gC9ma@x1>
References: <20240228005230.287113-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228005230.287113-1-namhyung@kernel.org>

On Tue, Feb 27, 2024 at 04:52:26PM -0800, Namhyung Kim wrote:
> This is another series of memory optimization in perf annotate.
 
> When perf annotate (or perf report/top with TUI) processes samples, it
> needs to save the sample period (overhead) at instruction level.  For
> now, it allocates an array to do that for the whole symbol when it
> hits any new symbol.  This comes with a lot of waste since samples can
> be very few and instructions span to multiple bytes.
 
> For example, when a sample hits symbol 'foo' that has size of 100 and
> that's the only sample falls into the symbol.  Then it needs to
> allocate a symbol histogram (sym_hist) and the its size would be
 
>   16 (header) + 16 (sym_hist_entry) * 100 (symbol_size) = 1616
 
> But actually it just needs 32 (header + sym_hist_entry) bytes.  Things
> get worse if the symbol size is bigger (and it doesn't have many
> samples in different places).  Also note that it needs separate
> histogram for each event.
 
> Let's split the sym_hist_entry and have it in a hash table so that it
> can allocate only necessary entries.
 
> No functional change intended.

I tried this before/after this series:

  $ time perf annotate --stdio2 -i perf.data.annotate

For:

  perf record -e '{cycles,instructions,cache-misses}' make -k CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin

And found these odd cases:

  $ diff -u before after
  --- before	2024-02-28 15:38:25.086062812 -0300
  +++ after	2024-02-29 14:12:05.606652725 -0300
  @@ -2450826,7 +2450826,7 @@
                                ↓ je       1c62                  
                                → call     operator delete(void*)@plt
                                { return _M_dataplus._M_p; }
  -                       1c62:   mov      0x13c0(%rsp),%rdi     
  +  0.00   0.00 100.00   1c62:   mov      0x13c0(%rsp),%rdi     
                                if (_M_data() == _M_local_data())
                                  lea      0x13d0(%rsp),%rax     
                                  cmp      %rax,%rdi             
  @@ -2470648,7 +2470648,7 @@
                                  mov      %rbx,%rdi             
                                → call     operator delete(void*)@plt
                                using reference = T &;     
  -  0.00   0.00 100.00  11c65:   mov      0x8(%r12),%rax        
  +                      11c65:   mov      0x8(%r12),%rax        
                                size_t size() const { return Size; }
                                  mov      0x10(%r12),%ecx       
                                  mov      %rax,%rbp             
  $


This is a large function:

Samples: 574K of events 'anon group { cpu_core/cycles/u, cpu_core/instructions/u, cpu_core/cache-misses/u }', 4000 Hz, Event count (approx.): 614695751751, [percent: local period]$
clang::CompilerInvocation::ParseCodeGenArgs(clang::CodeGenOptions&, llvm::opt::ArgList&, clang::InputKind, clang::DiagnosticsEngine&, llvm::Triple const&, std::__cxx11::basic_string<char, std
Percent 

Probably when building the BPF skels in tools/perf/

- Arnaldo

