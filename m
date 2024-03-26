Return-Path: <linux-kernel+bounces-119482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A4088C983
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A461C204FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1205914A82;
	Tue, 26 Mar 2024 16:38:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489173DAC0F;
	Tue, 26 Mar 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471093; cv=none; b=OQ4H8oXosRQ66njrzRAMQACwG2mt2LjiYmN8tGDi1cz2/vIgMHRi6fkMYffmKlXId+ONiojOUY01cOpioZQagichW1GV2sJEPEQeth0yo1nBfV4kk2bBI9Vj5+Hty38CRnKMh9rVLBb7KSXDJqRtLHL6YUpn6asgy64x8SoNicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471093; c=relaxed/simple;
	bh=1VUl5T3Hy9/wKjGM7Ekj16noT58ordY8L5XY+CsT5wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAMvyH0vVZDZ4ABlXPwhZ3fvIZAhEdf/MLjS7QFO4H47WGd1u6WwpskeHxpcC5/+8m6cmfbOX6z3GihZOBP73WOa3Fb4RjW472PawNKnkUBiejljHQZabbB+DxPRErE5ERhzvZGhVQn3X5h4YEET84q4AxjkgyELNcXm+3lV24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E6452F4;
	Tue, 26 Mar 2024 09:38:45 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A34C3F694;
	Tue, 26 Mar 2024 09:38:10 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:38:07 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-trace-kernel@vger.kernel.org,
	Calvin Owens <jcalvinowens@gmail.com>
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Message-ID: <ZgL5779MIS61GpV6@FVFF77S0Q05N.cambridge.arm.com>
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
 <ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>
 <20240327002403.62649aee45508b7a16caedba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327002403.62649aee45508b7a16caedba@kernel.org>

On Wed, Mar 27, 2024 at 12:24:03AM +0900, Masami Hiramatsu wrote:
> On Tue, 26 Mar 2024 14:46:10 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > On Mon, Mar 25, 2024 at 11:56:32AM +0900, Masami Hiramatsu wrote:
> > > I think, we'd better to introduce `alloc_execmem()`,
> > > CONFIG_HAVE_ALLOC_EXECMEM and CONFIG_ALLOC_EXECMEM at first
> > > 
> > >   config HAVE_ALLOC_EXECMEM
> > > 	bool
> > > 
> > >   config ALLOC_EXECMEM
> > > 	bool "Executable trampline memory allocation"
> > > 	depends on MODULES || HAVE_ALLOC_EXECMEM
> > > 
> > > And define fallback macro to module_alloc() like this.
> > > 
> > > #ifndef CONFIG_HAVE_ALLOC_EXECMEM
> > > #define alloc_execmem(size, gfp)	module_alloc(size)
> > > #endif
> > 
> > Please can we *not* do this? I think this is abstracting at the wrong level (as
> > I mentioned on the prior execmem proposals).
> > 
> > Different exectuable allocations can have different requirements. For example,
> > on arm64 modules need to be within 2G of the kernel image, but the kprobes XOL
> > areas can be anywhere in the kernel VA space.
> > 
> > Forcing those behind the same interface makes things *harder* for architectures
> > and/or makes the common code more complicated (if that ends up having to track
> > all those different requirements). From my PoV it'd be much better to have
> > separate kprobes_alloc_*() functions for kprobes which an architecture can then
> > choose to implement using a common library if it wants to.
> > 
> > I took a look at doing that using the core ifdeffery fixups from Jarkko's v6,
> > and it looks pretty clean to me (and works in testing on arm64):
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kprobes/without-modules
> > 
> > Could we please start with that approach, with kprobe-specific alloc/free code
> > provided by the architecture?
> 
> OK, as far as I can read the code, this method also works and neat! 
> (and minimum intrusion). I actually found that exposing CONFIG_ALLOC_EXECMEM
> to user does not help, it should be an internal change. So hiding this change
> from user is better choice. Then there is no reason to introduce the new
> alloc_execmem, but just expand kprobe_alloc_insn_page() is reasonable.
> 
> Mark, can you send this series here, so that others can review/test it?

I've written up a cover letter and sent that out:
  
  https://lore.kernel.org/lkml/20240326163624.3253157-1-mark.rutland@arm.com/

Mark.

