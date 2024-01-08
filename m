Return-Path: <linux-kernel+bounces-19624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABF826FEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6504E1F22D00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1044C8E;
	Mon,  8 Jan 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsO9rgYN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE544C76
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704720799; x=1736256799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G54Pi13jT8VpODe/nYPHSczABLoKWp9Q4adw6Xh/qxE=;
  b=NsO9rgYNz9BOEZyZN7ywOdeYFpGLRNZDDoUbUmp6UYFhJeYI1RDMAH15
   rsTUDfi0EKL/CgPwE+5tutDEOrJvqwT/IACXOlx2HccT0x+al4zqetEGp
   wWlTTMwopuPfloxzYX6LQcqdXqv1pVI1LjvpCeZkNi6AtYuFFr2h3xioS
   2qUWje3tCVyLB3FwrCQc2P76rI502ZQoRYlVj6IGFQX6DxoOdwC20jZZ9
   rQ12EdVUBbEEbqpy+3+m9mG5SKCTgv+eHqu8iA/eQHnS7H8ukyZkpjgpe
   ff2PQrhoDMS0JNrllxVN0/wp2Lbgof4DJx24Gsnhe8jaaDAxUAVEe0bu0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4669364"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="4669364"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:33:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="815606779"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="815606779"
Received: from ddraghic-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.53])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:33:12 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id CC77610498C; Mon,  8 Jan 2024 16:33:08 +0300 (+03)
Date: Mon, 8 Jan 2024 16:33:08 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCHv2] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Message-ID: <20240108133308.dqffkxcojo3nab6p@box.shutemov.name>
References: <20240107122847.27740-1-kirill.shutemov@linux.intel.com>
 <b69afad98d043ddfb685982c9977105f1b563485.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b69afad98d043ddfb685982c9977105f1b563485.camel@intel.com>

On Mon, Jan 08, 2024 at 01:10:31PM +0000, Huang, Kai wrote:
> On Sun, 2024-01-07 at 15:28 +0300, Kirill A. Shutemov wrote:
> > The trampoline_start64() vector is used when a secondary CPU starts in
> > 64-bit mode. The current implementation directly enters compatibility
> > mode. It is necessary to disable paging and re-enable it in the correct
> > paging mode: either 4- or 5-level, depending on the configuration.
> > 
> > The X86S[1] ISA does not support compatibility mode in ring 0, and
> > paging cannot be disabled.
> > 
> > The trampoline_start64() function is reworked to only enter compatibility
> > mode if it is necessary to change the paging mode. If the CPU is already
> > in the desired paging mode, it will proceed in long mode.
> > 
> > This change will allow a secondary CPU to boot on an X86S machine as
> > long as the CPU is already in the correct paging mode.
> > 
> > In the future, there will be a mechanism to switch between paging modes
> > without disabling paging.
> > 
> > [1] https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > 
> > ---
> >  v2:
> >   - Fix build with GCC;
> > ---
> >  arch/x86/realmode/rm/trampoline_64.S | 31 +++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
> > index c9f76fae902e..c07354542188 100644
> > --- a/arch/x86/realmode/rm/trampoline_64.S
> > +++ b/arch/x86/realmode/rm/trampoline_64.S
> > @@ -37,13 +37,15 @@
> >  	.text
> >  	.code16
> >  
> > -.macro LOCK_AND_LOAD_REALMODE_ESP lock_pa=0
> > +.macro LOCK_AND_LOAD_REALMODE_ESP lock_pa=0 lock_rip=0
> >  	/*
> >  	 * Make sure only one CPU fiddles with the realmode stack
> >  	 */
> >  .Llock_rm\@:
> >  	.if \lock_pa
> >          lock btsl       $0, pa_tr_lock
> > +	.elseif \lock_rip
> > +        lock btsl       $0, tr_lock(%rip)
> >  	.else
> >          lock btsl       $0, tr_lock
> >  	.endif
> > @@ -220,6 +222,33 @@ SYM_CODE_START(trampoline_start64)
> >  	lidt	tr_idt(%rip)
> >  	lgdt	tr_gdt64(%rip)
> >  
> > +	/* Check if paging mode has to be changed */
> > +	movq	%cr4, %rax
> > +	xorq	tr_cr4(%rip), %rax
> > +	andq	$X86_CR4_LA57, %rax
> > +	jnz	.L_switch_paging
> 
> This seems depends on the BIOS will always use 4-level paging.  Can we make such
> assumption?

What makes you think this?

The check is basically

    if ((tr_cr4 ^ CR4) & X86_CR4_LA57)
	goto .L_switch_paging;

It means if LA57 is not the same between tr_cr4 and CR4 we need to change
paging mode.

> > +
> > +	/* Paging mode is correct proceed in 64-bit mode */
> > +
> > +	LOCK_AND_LOAD_REALMODE_ESP lock_rip=1
> > +
> > +	movw	$__KERNEL_DS, %dx
> > +	movl	%edx, %ss
> > +	addl	$pa_real_mode_base, %esp
> > +	movl	%edx, %ds
> > +	movl	%edx, %es
> > +	movl	%edx, %fs
> > +	movl	%edx, %gs
> > +
> > +	movl	$pa_trampoline_pgd, %eax
> > +	movq	%rax, %cr3
> > +
> > +	jmpq	*tr_start(%rip)
> 
> IIUC you won't be using __KERNEL_CS in this case?  Not sure whether this matters
> though, because the spec says in 64-bit mode the hardware treats CS,DS,ES,SS as
> zero.
> 

secondary_startup_64() will set CS to __KERNEL_CS before jumping to C
code.

> > +.L_switch_paging:
> > +	/*
> > +	 * To switch between 4- and 5-level paging modes, it is necessary
> > +	 * to disable paging. This must be done in the compatibility mode.
> > +	 */
> >  	ljmpl	*tr_compat(%rip)
> >  SYM_CODE_END(trampoline_start64)
> >  
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

