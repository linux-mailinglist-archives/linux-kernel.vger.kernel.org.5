Return-Path: <linux-kernel+bounces-119493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F40888C9A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B621C64B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A01798A;
	Tue, 26 Mar 2024 16:45:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE30D4A0A;
	Tue, 26 Mar 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471527; cv=none; b=E1zO2qCVZ5Ma7JnpmtadBhuW0Xb9e5qDpWOECITCGD9Eu6RHaXEhSDnnZEXYv07OqbqYr9HqlbZt1KaUJwjZOtOcsloB6BPFmENpZLoGH7eaPpJaW4Lvxev65GakBSPEv1V40SMGVkoUBdCptXWK1wgImGJDerJmr6lL5jfJjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471527; c=relaxed/simple;
	bh=e95uhVBTfAzZnFOKr0O1j5p3MLRuxzZEWptMHK7NSpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7WfTXi0r/0u6fRQxwC+iyRYBOlvhfytFHiJK69sRd9+W6khzEK7dhB+bLyliRagaAGzOdOEi6sRWBcpsaqLAqhZ6N7KgxJ5afTjMiq4yegHH097pOZNTwVx2gV5ub92nbYEfUxrk+k0A+JApuMRRYdRGQJOyKRBvDOY34Vv7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8D5F2F4;
	Tue, 26 Mar 2024 09:45:58 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B7D93F694;
	Tue, 26 Mar 2024 09:45:23 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:45:20 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Calvin Owens <jcalvinowens@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Message-ID: <ZgL7oG5EfLGYDGRS@FVFF77S0Q05N.cambridge.arm.com>
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
 <ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>
 <20240327002403.62649aee45508b7a16caedba@kernel.org>
 <ZgL0ks5gikCG7NBN@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgL0ks5gikCG7NBN@debian-BULLSEYE-live-builder-AMD64>

On Tue, Mar 26, 2024 at 09:15:14AM -0700, Calvin Owens wrote:
> On Wednesday 03/27 at 00:24 +0900, Masami Hiramatsu wrote:
> > On Tue, 26 Mar 2024 14:46:10 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > > Different exectuable allocations can have different requirements. For example,
> > > on arm64 modules need to be within 2G of the kernel image, but the kprobes XOL
> > > areas can be anywhere in the kernel VA space.
> > > 
> > > Forcing those behind the same interface makes things *harder* for architectures
> > > and/or makes the common code more complicated (if that ends up having to track
> > > all those different requirements). From my PoV it'd be much better to have
> > > separate kprobes_alloc_*() functions for kprobes which an architecture can then
> > > choose to implement using a common library if it wants to.
> > > 
> > > I took a look at doing that using the core ifdeffery fixups from Jarkko's v6,
> > > and it looks pretty clean to me (and works in testing on arm64):
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kprobes/without-modules
> > > 
> > > Could we please start with that approach, with kprobe-specific alloc/free code
> > > provided by the architecture?
> 
> Heh, I also noticed that dead !RWX branch in arm64 patch_map(), I was
> about to send a patch to remove it.
> 
> > OK, as far as I can read the code, this method also works and neat! 
> > (and minimum intrusion). I actually found that exposing CONFIG_ALLOC_EXECMEM
> > to user does not help, it should be an internal change. So hiding this change
> > from user is better choice. Then there is no reason to introduce the new
> > alloc_execmem, but just expand kprobe_alloc_insn_page() is reasonable.
> 
> I'm happy with this, it solves the first half of my problem. But I want
> eBPF to work in the !MODULES case too.
> 
> I think Mark's approach can work for bpf as well, without needing to
> touch module_alloc() at all? So I might be able to drop that first patch
> entirely.

I'd be very happy with eBPF following the same approach, with BPF-specific
alloc/free functions that we can implement in arch code.

IIUC eBPF code *does* want to be within range of the core kernel image, so for
arm64 we'd want to factor some common logic out of module_alloc() and into
something that module_alloc() and "bpf_alloc()" (or whatever it would be
called) could use. So I don't think we'd necessarily save on touching
module_alloc(), but I think the resulting split would be better.

Thanks,
Mark.

