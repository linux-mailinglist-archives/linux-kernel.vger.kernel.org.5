Return-Path: <linux-kernel+bounces-168429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1248BB87C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D221B21BA3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBC684E16;
	Fri,  3 May 2024 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi/ze38P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05984D30
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714780119; cv=none; b=oWE01+fG5drjxRaUX6vZc78LbgKk2eDpccPtXa6npClitVCisDlDc0SC3aAJbmc0i32gc0bHluyicYhBCROw7gq+q74sefclqI0XerXXhCOLhZgSWqAvmXbuShzU3m7pJRrVGZvAYdXIn27UKWo+b+v5A+aBEvXtrIWdmbXMECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714780119; c=relaxed/simple;
	bh=MBVYVk8YRq3x5wnUxk1XWITNQn7czjHBfq7A9PEktHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCWYLdgkfTFSdcgQIVpzRxmz+1qpPt8+8+TeWbhDyjLe4wrPJQMyM7yR1CERzhKdVzwKKzlyY7JB+Em4aUVJvrJuEUT+0yoio1Rg6VZKr34t3JcVzJdRFobTQZ3+rXgcV6iAuJ32YC3MfeidGHtHZcTm5Yo7chxYNStjOr4pibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi/ze38P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9500FC116B1;
	Fri,  3 May 2024 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714780118;
	bh=MBVYVk8YRq3x5wnUxk1XWITNQn7czjHBfq7A9PEktHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hi/ze38P+azLP0viMTP2sQ8nr8jbTE4YvyapIPXzB1pFJPYib9L7zFZLLgg8qjkCM
	 RHZN4L8MQ1LHNAV4RGJ2jL4ZFV2Hf6qkRkC+GCGVnu4H20Nk0IqYQXAoj1X0SFRe4i
	 tLBfros+RknG4vvE9SYDxi2pfWx1SrNNzv8FFZE9M7NwfNJhIZBNkul0DlVryVv7bV
	 k4xuv9Q74CeagysDX8AE8MtPAC/OiNRF7OPMj4HA/lgrhdYFbJfLd2n/FtZULHtY8a
	 zEOcvVvjiWkcE7j4p+KweQXMoQvToIFPJOoQiSGXDYkZi8XBgzgrCDcf103gLltOdw
	 8dqGEuKfX3QxQ==
Date: Fri, 3 May 2024 16:48:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <20240503234834.y3gfp5qthporsx7m@treble>
References: <cover.1713559768.git.jpoimboe@kernel.org>
 <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop>
 <20240421052540.w7gtahoko2qerhqq@treble>
 <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com>
 <CAJzB8QFx344hSSYy4jigtmQX+KfSpFOn+18WAfZAeym5LUMoKg@mail.gmail.com>
 <CAJzB8QFxfCCYTMfEYidB+PYvDV5J2zbdsnpyQR-gS-D-0y2gEA@mail.gmail.com>
 <20240503195653.5wkdfwno7nybepqc@treble>
 <20240503204417.2kxp2i3xjdmtapxq@treble>
 <a8d0a893-25ec-4119-abb5-c65adda51b49@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8d0a893-25ec-4119-abb5-c65adda51b49@paulmck-laptop>

On Fri, May 03, 2024 at 04:33:00PM -0700, Paul E. McKenney wrote:
> Does arch/x86/entry/syscall_32.c need the following additional patch?
> 
> A quick smoke test passes, but perhaps I am just getting lucky...
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index aab31760b4e3e..d9ae910ea6f33 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -14,9 +14,13 @@
>  #endif
>  
>  #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
> +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __ia32_##sym(const struct pt_regs *);
>  #include <asm/syscalls_32.h>
>  #undef __SYSCALL
>  
> +#undef __SYSCALL_NORETURN
> +#define __SYSCALL_NORETURN __SYSCALL
> +
>  #define __SYSCALL(nr, sym) __ia32_##sym,
>  const sys_call_ptr_t ia32_sys_call_table[] = {
>  #include <asm/syscalls_32.h>

Ah, yeah, that looks right.

-- 
Josh

