Return-Path: <linux-kernel+bounces-109240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24348816A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CBF282AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F346A341;
	Wed, 20 Mar 2024 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF7cVlUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67A1DFC6;
	Wed, 20 Mar 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956281; cv=none; b=QdX5zNX+63P07ufyKopght5QYRIROsCrNBxyawaKNQFsJn45WVeW8o99g9I879c0N7sM0XiF6Gc4C4hthViNN0PuM0Qyh2vmAdvwzRSXYXQy9nDccuXg8BdWyNe+K23aWMt3doxuIHb9eCGCDn3Er8G3JfMsS49n/ogISjtSfuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956281; c=relaxed/simple;
	bh=eGsTs/M0MZ1gL7Z17waNl7v25/yUG8QyR7jEDqlU/xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8ZgMtGD1zZ1kV/yClr4tKga46ImjFT5NqOePgbyio1GkYjOAc6CWw8FHOIbw3eRl9aspD6koPk5QezHcvCbWD7bg/8lZkhu72EZOL1PqumbrSbOAoicDcj3wdBO/Js+39FwjHWvidaAl0+jITE9ZWEr9ug+QWlpdty5M3YpaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF7cVlUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ADEC43390;
	Wed, 20 Mar 2024 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710956281;
	bh=eGsTs/M0MZ1gL7Z17waNl7v25/yUG8QyR7jEDqlU/xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QF7cVlUQU5HBfd1GgzNN+vS4TX49eeRAhrxROKDRHGjBHt5roIBulvIFVETxHw8qs
	 3grk6Aife8CxoPVT9ZeZm9cCpI3aBbIfKQKIki+4NVJ/ps1PZddwGgCN2RcNrwkmyB
	 hvfhAhbQ0XgbvLyfaEaetZBzGI2j8ZeZAdPbI4bnFR6eXxEOn2UnNgAdXqJhtA93PK
	 plH5vyk+FToyCoq1/5xEqKc+jOVXmr++SSKlCKff7cxsCDv1Uhp2+Nb3DCIQBK8lXD
	 qfI3hjgHYGo7Qv2dTzD7G6ToNnnSGnA8EaabVjfwT1uDyYEyzbgTF7SoiibrL+IKf6
	 827d32BNq6uAQ==
Date: Wed, 20 Mar 2024 10:37:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	Kees Cook <keescook@chromium.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [tip: x86/percpu] x86/percpu: Convert this_percpu_xchg_op() from
 asm() to C code, to generate better code
Message-ID: <20240320173758.GA3017166@dev-arch.thelio-3990X>
References: <20240320083127.493250-1-ubizjak@gmail.com>
 <171093476000.10875.14076471223590027773.tip-bot2@tip-bot2>
 <ZfrMcyZXCBQD/sE8@gmail.com>
 <CAFULd4bNETbtP3VTGao4o3mtfpw6d=rhcWp5N+pnzp-f3fjXAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bNETbtP3VTGao4o3mtfpw6d=rhcWp5N+pnzp-f3fjXAw@mail.gmail.com>

On Wed, Mar 20, 2024 at 02:12:14PM +0100, Uros Bizjak wrote:
> On Wed, Mar 20, 2024 at 12:45 PM Ingo Molnar <mingo@kernel.org> wrote:
> > Clang claims to be compatible:
> >
> >   https://releases.llvm.org/9.0.0/tools/clang/docs/LanguageExtensions.html
> >
> >   "You can also use the GCC compatibility macros __seg_fs and __seg_gs for the
> >    same purpose. The preprocessor symbols __SEG_FS and __SEG_GS indicate their
> >    support."
> >
> > I haven't tried it yet though.
> 
> In the RFC submission, the support was determined by the functional
> check [2]. Perhaps we should re-introduce this instead of checking for
> known compiler versions:
> 
> +config CC_HAS_NAMED_AS
> + def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC)
> -x c - -c -o /dev/null)
> 
> [2] https://lore.kernel.org/lkml/20231001131620.112484-3-ubizjak@gmail.com/

I applied this change on top of current mainline (a4145ce1e7bc) and
built ARCH=x86_64 defconfig with LLVM 17.0.6 from [1] but it doesn't get
too far :)

  In file included from arch/x86/kernel/asm-offsets.c:9:
  In file included from include/linux/crypto.h:15:
  In file included from include/linux/completion.h:12:
  In file included from include/linux/swait.h:7:
  In file included from include/linux/spinlock.h:56:
  In file included from include/linux/preempt.h:79:
  In file included from arch/x86/include/asm/preempt.h:7:
  arch/x86/include/asm/current.h:47:10: error: multiple identical address spaces specified for type [-Werror,-Wduplicate-decl-specifier]
     47 |                 return this_cpu_read_const(const_pcpu_hot.current_task);
        |                        ^
  arch/x86/include/asm/percpu.h:471:34: note: expanded from macro 'this_cpu_read_const'
    471 | #define this_cpu_read_const(pcp)        __raw_cpu_read(, pcp)
        |                                         ^
  arch/x86/include/asm/percpu.h:441:30: note: expanded from macro '__raw_cpu_read'
    441 |         *(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));               \
        |                                     ^
  arch/x86/include/asm/percpu.h:105:28: note: expanded from macro '__my_cpu_ptr'
    105 | #define __my_cpu_ptr(ptr)       (__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
        |                                  ^
  arch/x86/include/asm/percpu.h:104:40: note: expanded from macro '__my_cpu_type'
    104 | #define __my_cpu_type(var)      typeof(var) __percpu_seg_override
        |                                             ^
  arch/x86/include/asm/percpu.h:45:31: note: expanded from macro '__percpu_seg_override'
     45 | #define __percpu_seg_override   __seg_gs
        |                                 ^
  <built-in>:338:33: note: expanded from macro '__seg_gs'
    338 | #define __seg_gs __attribute__((address_space(256)))
        |                                 ^
  In file included from arch/x86/kernel/asm-offsets.c:9:
  In file included from include/linux/crypto.h:15:
  In file included from include/linux/completion.h:12:
  In file included from include/linux/swait.h:7:
  In file included from include/linux/spinlock.h:56:
  In file included from include/linux/preempt.h:79:
  In file included from arch/x86/include/asm/preempt.h:7:
  arch/x86/include/asm/current.h:47:10: error: multiple identical address spaces specified for type [-Werror,-Wduplicate-decl-specifier]
  arch/x86/include/asm/percpu.h:471:34: note: expanded from macro 'this_cpu_read_const'
    471 | #define this_cpu_read_const(pcp)        __raw_cpu_read(, pcp)
        |                                         ^
  arch/x86/include/asm/percpu.h:441:9: note: expanded from macro '__raw_cpu_read'
    441 |         *(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));               \
        |                ^
  arch/x86/include/asm/percpu.h:104:40: note: expanded from macro '__my_cpu_type'
    104 | #define __my_cpu_type(var)      typeof(var) __percpu_seg_override
        |                                             ^
  arch/x86/include/asm/percpu.h:45:31: note: expanded from macro '__percpu_seg_override'
     45 | #define __percpu_seg_override   __seg_gs
        |                                 ^
  <built-in>:338:33: note: expanded from macro '__seg_gs'
    338 | #define __seg_gs __attribute__((address_space(256)))
        |                                 ^
  In file included from arch/x86/kernel/asm-offsets.c:9:
  In file included from include/linux/crypto.h:15:
  In file included from include/linux/completion.h:12:
  In file included from include/linux/swait.h:7:
  In file included from include/linux/spinlock.h:60:
  In file included from include/linux/thread_info.h:60:
  In file included from arch/x86/include/asm/thread_info.h:59:
  In file included from arch/x86/include/asm/cpufeature.h:5:
  arch/x86/include/asm/processor.h:530:10: error: multiple identical address spaces specified for type [-Werror,-Wduplicate-decl-specifier]
    530 |                 return this_cpu_read_const(const_pcpu_hot.top_of_stack);
        |                        ^
  arch/x86/include/asm/percpu.h:471:34: note: expanded from macro 'this_cpu_read_const'
    471 | #define this_cpu_read_const(pcp)        __raw_cpu_read(, pcp)
        |                                         ^
  arch/x86/include/asm/percpu.h:441:30: note: expanded from macro '__raw_cpu_read'
    441 |         *(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));               \
        |                                     ^
  arch/x86/include/asm/percpu.h:105:28: note: expanded from macro '__my_cpu_ptr'
    105 | #define __my_cpu_ptr(ptr)       (__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
        |                                  ^
  arch/x86/include/asm/percpu.h:104:40: note: expanded from macro '__my_cpu_type'
    104 | #define __my_cpu_type(var)      typeof(var) __percpu_seg_override
        |                                             ^
  arch/x86/include/asm/percpu.h:45:31: note: expanded from macro '__percpu_seg_override'
     45 | #define __percpu_seg_override   __seg_gs
        |                                 ^
  <built-in>:338:33: note: expanded from macro '__seg_gs'
    338 | #define __seg_gs __attribute__((address_space(256)))
        |                                 ^
  In file included from arch/x86/kernel/asm-offsets.c:9:
  In file included from include/linux/crypto.h:15:
  In file included from include/linux/completion.h:12:
  In file included from include/linux/swait.h:7:
  In file included from include/linux/spinlock.h:60:
  In file included from include/linux/thread_info.h:60:
  In file included from arch/x86/include/asm/thread_info.h:59:
  In file included from arch/x86/include/asm/cpufeature.h:5:
  arch/x86/include/asm/processor.h:530:10: error: multiple identical address spaces specified for type [-Werror,-Wduplicate-decl-specifier]
  arch/x86/include/asm/percpu.h:471:34: note: expanded from macro 'this_cpu_read_const'
    471 | #define this_cpu_read_const(pcp)        __raw_cpu_read(, pcp)
        |                                         ^
  arch/x86/include/asm/percpu.h:441:9: note: expanded from macro '__raw_cpu_read'
    441 |         *(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));               \
        |                ^
  arch/x86/include/asm/percpu.h:104:40: note: expanded from macro '__my_cpu_type'
    104 | #define __my_cpu_type(var)      typeof(var) __percpu_seg_override
        |                                             ^
  arch/x86/include/asm/percpu.h:45:31: note: expanded from macro '__percpu_seg_override'
     45 | #define __percpu_seg_override   __seg_gs
        |                                 ^
  <built-in>:338:33: note: expanded from macro '__seg_gs'
    338 | #define __seg_gs __attribute__((address_space(256)))
        |                                 ^
  4 errors generated.

[1]: https://mirrors.edge.kernel.org/pub/tools/llvm/

Cheers,
Nathan

