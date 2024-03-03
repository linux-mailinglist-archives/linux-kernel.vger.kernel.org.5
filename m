Return-Path: <linux-kernel+bounces-89821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D203586F61B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF432859E1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6FE6BFB5;
	Sun,  3 Mar 2024 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IDoCFjAl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TufsC5F/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9862E40B;
	Sun,  3 Mar 2024 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483491; cv=none; b=onLpyXfiGCD+A7zPfYVEctxh3z1Vy7NNXd7o4M+lYozWkhGjO9j9LFu+NBDFwHRe+86U6x7mrVlzMHElja1rh54SxEwEqf1b+c4U/PWb+kpMxhYMSDU43l/h4TazbEy+Bh7bfFsHu3TqzY6nc0dy9jiHGjYOoL+ZQmX+sVnShbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483491; c=relaxed/simple;
	bh=X+pk8b7tR3gtMrDrQgbHGGcG5RBmg0fmKIppHBXG4iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQBD92jGjjEpxz/OEu/ojqrB5/0iESvk3DARu/0k0sAyrgYzc+zX/X6znrjVK9Bd7UtZd0Jnev+qYhexlh+Xl7YBQ3kq6tHi/n/EIg/CR6LryOmg7w7VwCRLR5FeVgeKWuLcAyFplbs2LXuWVGIBp/UPZPFEutO5ALfTh+odx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IDoCFjAl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TufsC5F/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709483481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P54JmtoAfGF/B3ri9buymyAdBatM4sq1A71NktfEGs8=;
	b=IDoCFjAlgYE2Ij/SpuO9DUycSuo2KilsGsFvafrKTst7oEiMqOJuzDxA1PpwkZyGhRsSUH
	2iRDWzjv64I7J4KQafb+9gu254ul3wL5XmwxMPvGlwNjj+a25ojY46MmsXtiQTbrEgmXm8
	E/sxldvidkKnHtBJFg7oT+uh+lgmTuWAtSWuM1lhRXnoQXbZKrLZCGt2v7gVC7YAyrhK3k
	xa0fS1h3NTi2NFMiI1Go2rlDx88Y/2Jtbw3MjEEwgW6uSYIEvqGc6dzlhGbyXYDDwl1qis
	MSknsINEm8omErcYj+9jfrG3gEykqpPJVwHXU3NRQmxY4B/dBAXdFZdvIJN2uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709483481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P54JmtoAfGF/B3ri9buymyAdBatM4sq1A71NktfEGs8=;
	b=TufsC5F/xcavTvzD+l2AFGGnkCpHEZwee+8dOac2cgFy7TC+bwQn/vPUaXY/w4u+Z8eiSj
	22WI8Gi+C3guQ1Cg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
 x86@kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse
 Mailing-list <linux-sparse@vger.kernel.org>, Uros Bizjak
 <ubizjak@gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
In-Reply-To: <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx>
 <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
Date: Sun, 03 Mar 2024 17:31:21 +0100
Message-ID: <87edcruvja.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 02 2024 at 14:49, Linus Torvalds wrote:
> On Sat, 2 Mar 2024 at 14:00, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> I had commented out both. But the real reason is the EXPORT_SYMBOL,
>> which obviously wants to be EXPORT_PER_CPU_SYMBOL_GPL...
>
> Side note: while it's nice to hear that sparse kind of got this right,
> I wonder what gcc does when we start using the named address spaces
> for percpu variables.
>
> We actively make EXPORT_PER_CPU_SYMBOL_XYZ be a no-op for sparse
> exactly because sparse ended up warning about the regular
> EXPORT_SYMBOL, and we didn't have any "real" per-cpu export model.

Right.

> So EXPORT_PER_CPU_SYMBOL_GPL() is kind of an artificial "shut up
> sparse".

Aside of that it's also making it clear what this is about. So I don't
think it's purely artifical.

> But with __seg_gs/fs support for native percpu symbols with
> gcc, I wonder if we'll hit the same thing. Or is there something that
> makes gcc not warn about the named address spaces?

Right now the pending code in tip does not complain about the
EXPORT_PER_CPU_SYMBOL_GPL() part because our current macro maze is
hideous. Here is the preprocessor output.

This is DECLARE_PER_CPU() in the header:

extern __attribute__((section(".data..percpu" ""))) __typeof__(u64) x86_spec_ctrl_current;

Here is DEFINE_PER_CPU():

__attribute__((section(".data..percpu" ""))) __typeof__(u64) x86_spec_ctrl_current;

And the EXPORT:

extern typeof(x86_spec_ctrl_current) x86_spec_ctrl_current;

static void * __attribute__((__used__))
   __attribute__((__section__(".discard.addressable")))
   __UNIQUE_ID___addressable_x86_spec_ctrl_current804 = (void *)(uintptr_t)&x86_spec_ctrl_current;

   asm(".section \".export_symbol\",\"a\" ;
       __export_symbol_x86_spec_ctrl_current: ;
       .asciz \"GPL\" ; .asciz \"\" ; .balign 8 ; .quad x86_spec_ctrl_current ; .previous");

And the __seg_gs magic happens only in the per CPU accessor itself:

__attribute__((__noinline__)) __attribute__((no_instrument_function))
 __attribute((__section__(".noinstr.text")))
 __attribute__((__no_sanitize_address__))
 __attribute__((__no_profile_instrument_function__))
 u64 spec_ctrl_current(void)
{
 return ({
    // this_cpu_read(x86_spec_ctrl_current)

    typeof(x86_spec_ctrl_current) pscr_ret__;

    do { const void *__vpp_verify = (typeof((&(x86_spec_ctrl_current)) + 0))((void *)0); (void)__vpp_verify;
    } while (0);

    switch(sizeof(x86_spec_ctrl_current))
    {
    case 1: pscr_ret__ = ({
            *(volatile typeof(x86_spec_ctrl_current) __seg_gs *)(typeof(*&(x86_spec_ctrl_current)) __seg_gs *)(uintptr_t)(&(x86_spec_ctrl_current)); });
            break;
    case 2: pscr_ret__ = ({
            *(volatile typeof(x86_spec_ctrl_current) __seg_gs *)(typeof(*&(x86_spec_ctrl_current)) __seg_gs *)(uintptr_t)(&(x86_spec_ctrl_current)); });
            break;
    case 4: pscr_ret__ = ({
            *(volatile typeof(x86_spec_ctrl_current) __seg_gs *)(typeof(*&(x86_spec_ctrl_current)) __seg_gs *)(uintptr_t)(&(x86_spec_ctrl_current)); });
            break;
    case 8: pscr_ret__ = ({
            *(volatile typeof(x86_spec_ctrl_current) __seg_gs *)(typeof(*&(x86_spec_ctrl_current)) __seg_gs *)(uintptr_t)(&(x86_spec_ctrl_current)); });
            break;

    default: __bad_size_call_parameter(); break;
    }

    pscr_ret__;
  });
}

So all the export etc. just works because it all operates on a plain
data type and the __seg_gs is only bolted on via type casts in the
accessors.

As the per cpu variables are in the .data..percpu section the linker
puts them at address 0 and upwards. So the cast to a __seg_gs pointer
makes it end up at the real kernel address because of GSBASE + "offset".

The compiler converts this to RIP relative addressing:

  movq   $0x0,%gs:0x7e14169f(%rip)        # 1ba08 <fpu_fpregs_owner_ctx>

This obviously has a downside. If I do:

   u64 foo;

   this_cpu_read(foo);

the compiler is just happy to build that w/o complaining and it will
only explode at runtime because foo is a kernel data address which added
to GSBASE will result in accessing some random address:

  mov    %gs:0x15d08d4(%rip),%rax        # ffffffff834aac60 <x86_spec_ctrl_base>

This is not at all different from the inline ASM based version which is
in your tree. The only difference is that the macro maze is pure C and
the __set_gs cast allows the compiler to (micro) optimize, e.g. 'mov
%gs:...; movzbl' into a single 'movzbl'.

IOW, right now the only defense against such a mistake is actually the
sparse check. Maybe one of the coccinelle scripts has something similar,
I don't know.

I did not follow the __set_gs work closely, so I don't know whether Uros
ever tried to actually mark the per CPU variable __set_gs right away,
which would obviously catch the above 'foo' nonsense.

I think this should just work, but that would obviously require to do
the type cast magic at the EXPORT_SYMBOL side and in some other places.

Thanks,

        tglx



