Return-Path: <linux-kernel+bounces-119205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A488C585
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED130B23FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1813C3EE;
	Tue, 26 Mar 2024 14:46:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B1FED9;
	Tue, 26 Mar 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464384; cv=none; b=XebUICckSYSqEMxoOXKYVeQlt3UTnArdT1YBGvKXbOoIlNq0EjUPMR/KpfDCxi+YMVpBxrlaBuCEn+E+oLomyezyrAkBTeP/3B1eOE4qyCrziiKj+g1DYf/4QnV2QE2QHLktreXBRROJJfkmVd295ABiqy8acC6KpCMG0CQHHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464384; c=relaxed/simple;
	bh=7P7H1Co+Rl3zjj/dyl7b91+RN3DmNLupMXf8qxmlhzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmOj6rfhk3yHxFszwD5ltrCK4EfXne84/OxaSZiSzTQuvC4ksWztW+LED6rM51S3gLy/Qa5kiXF2VqohGFKf1/TtbdkamPC/g0pM5dKePiFXDPbK/wUn+Q9TqM8oSH5c59VlMbH4rYDA0bgDEe2uKChNu3APYuQHdByvhB0yusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB30339;
	Tue, 26 Mar 2024 07:46:55 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F2EC3F694;
	Tue, 26 Mar 2024 07:46:20 -0700 (PDT)
Date: Tue, 26 Mar 2024 14:46:10 +0000
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
Message-ID: <ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325115632.04e37297491cadfbbf382767@kernel.org>

Hi Masami,

On Mon, Mar 25, 2024 at 11:56:32AM +0900, Masami Hiramatsu wrote:
> Hi Jarkko,
> 
> On Sun, 24 Mar 2024 01:29:08 +0200
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > Tracing with kprobes while running a monolithic kernel is currently
> > impossible due the kernel module allocator dependency.
> > 
> > Address the issue by allowing architectures to implement module_alloc()
> > and module_memfree() independent of the module subsystem. An arch tree
> > can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file.
> > 
> > Realize the feature on RISC-V by separating allocator to module_alloc.c
> > and implementing module_memfree().
> 
> Even though, this involves changes in arch-independent part. So it should
> be solved by generic way. Did you checked Calvin's thread?
> 
> https://lore.kernel.org/all/cover.1709676663.git.jcalvinowens@gmail.com/
> 
> I think, we'd better to introduce `alloc_execmem()`,
> CONFIG_HAVE_ALLOC_EXECMEM and CONFIG_ALLOC_EXECMEM at first
> 
>   config HAVE_ALLOC_EXECMEM
> 	bool
> 
>   config ALLOC_EXECMEM
> 	bool "Executable trampline memory allocation"
> 	depends on MODULES || HAVE_ALLOC_EXECMEM
> 
> And define fallback macro to module_alloc() like this.
> 
> #ifndef CONFIG_HAVE_ALLOC_EXECMEM
> #define alloc_execmem(size, gfp)	module_alloc(size)
> #endif

Please can we *not* do this? I think this is abstracting at the wrong level (as
I mentioned on the prior execmem proposals).

Different exectuable allocations can have different requirements. For example,
on arm64 modules need to be within 2G of the kernel image, but the kprobes XOL
areas can be anywhere in the kernel VA space.

Forcing those behind the same interface makes things *harder* for architectures
and/or makes the common code more complicated (if that ends up having to track
all those different requirements). From my PoV it'd be much better to have
separate kprobes_alloc_*() functions for kprobes which an architecture can then
choose to implement using a common library if it wants to.

I took a look at doing that using the core ifdeffery fixups from Jarkko's v6,
and it looks pretty clean to me (and works in testing on arm64):

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kprobes/without-modules

Could we please start with that approach, with kprobe-specific alloc/free code
provided by the architecture?

Thanks,
Mark.

