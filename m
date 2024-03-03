Return-Path: <linux-kernel+bounces-89862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1916B86F6A7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2203D1C2092B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0067994B;
	Sun,  3 Mar 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+a5ypPK"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863E76417;
	Sun,  3 Mar 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709492651; cv=none; b=Xw3FEHbt6UcbdDbVD7FpQupJnNIOXPm0MFsb93QNDcB3C+LlnDyCGVF+x3TADTmZWU7x9Wq81Blbbr26pPQssCo3PitzZaHg0/aVs8CNH3/T62nqR525Y8DQmz+ktOqY3GOGQcdpdtVHa2iyC+kv2HCDjMCInG7dQTShnlLCm9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709492651; c=relaxed/simple;
	bh=XcvvUXceBSb176i0TRf9vtM0/PGGD8QMPdQJXgBDrGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5cF//b39Ihxsc7F2r6JXkdwUimX8A4R3k9FQmIHqDio6EceWUW1w8KcL9uEhQYLCWJPQQu9vLVJoFcjoe/kA+ONytlTE9k0Y71YUaiWRoDYsHS8krLPePjuj4HV6nSciL6Jlafxf2Y9vQqSGUfW5XxhX93PPXakRB/z+44cDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+a5ypPK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d27fef509eso51989561fa.3;
        Sun, 03 Mar 2024 11:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709492648; x=1710097448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DVCx1/HHcWKKtGLW0BdzytODfQzaAANbwcrDliILZk=;
        b=g+a5ypPKj39pLt0g100sovnhYOjmmpKRjj5SOMZzfM0X5JFz6Q9fjQ/i6lsZV6nr4z
         3EiKITfu0Lxkjmi2b0EzFOTpZzKI3Br8AFbaHd3GI6BNnaqjU+yu8LUNVtWB+oCSNJtN
         uFFNQZSkRl/hhL6zNI1Hk9L+ae0jZw81Rc+LfB1wJQvMd2WEe/ywWHab9Zvpfszb1MhT
         YC5+JEk4BZZYCCmUW5sPHJ+IA8TlB7HJfOilhiLr+qNbpsM0XJIPmNmimTTgiH2XwWBY
         fasCUXyWFFmfXZpkUbJY2DM6IolgmNWIStw2nx1vwRM8dARZMdu1J84l5T9aq61RPRUb
         NVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709492648; x=1710097448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DVCx1/HHcWKKtGLW0BdzytODfQzaAANbwcrDliILZk=;
        b=qWoYJ5XlqUCVi89M0gyhWTuEhblZvD0h7eXDFCCFN1/dzCUNgunf3rp2hkHKhEjNky
         V2FGZrSjxqWjDgUvgUqwhA6hBAa4035GaMsuk8gJQTLpttYkDjTK+/Latekqi0Jzs+91
         c6bn59s8LXFVJ7CcOyagtj8Tya8BzoCG5vZtz0ugGPneGJrKfrbdp3jV1ea/u6RLm6Qd
         /Iibf1kqbU5OiFZqBipeX6pBYgpGkDVM1JD7yjSp4r53M+HcPSvlJ6SGEebN6gnGE5iT
         R6xeFMgUKiJqcsKihyp8GoNpYQLIoFiJdExNspQ62tmy8wtc4/3SH7DdIxNFbb23Hh+F
         lOzw==
X-Forwarded-Encrypted: i=1; AJvYcCVaafcDldWlfWmcORKFO05QtFtkJe/jUVaOM+4kCu9/aXVhkoHQ5OmG0hp9fQSmz1VVkV8xIVYQ5hSzuvMmx6HpBbx+d7fkf1JpjOI1/50XnzMoGSHqoXash4P180IQe+el+snEJxnTZuEM
X-Gm-Message-State: AOJu0Ywlfu1Ok96Ud8KQ50E+zFRhrI32f/mcml3490SO45Wfo7Lk9T5/
	RsiK8O61T9nTJOTgajVVuPl48yyA+q4ru6WeofguIObPkDuFxtsCZDYa6R8aVC+JC/HLAOW2+IA
	s/dRaolKJQFQHOKq0iHDtspUHXtQSyxt62/U=
X-Google-Smtp-Source: AGHT+IFCSdD6OHt6bljSwkVkmweyQrmbR5W6Rf3Y/xTV8dRYMkGvWt4G0Q4Zm0KA/B2fjDQRxo5V6x5AwJlIy4MUrgI=
X-Received: by 2002:a2e:6e10:0:b0:2d2:8fb4:46cf with SMTP id
 j16-20020a2e6e10000000b002d28fb446cfmr4825247ljc.15.1709492647620; Sun, 03
 Mar 2024 11:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx> <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx>
In-Reply-To: <87edcruvja.ffs@tglx>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 3 Mar 2024 20:03:56 +0100
Message-ID: <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 5:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Sat, Mar 02 2024 at 14:49, Linus Torvalds wrote:
> > On Sat, 2 Mar 2024 at 14:00, Thomas Gleixner <tglx@linutronix.de> wrote=
:
> >>
> >> I had commented out both. But the real reason is the EXPORT_SYMBOL,
> >> which obviously wants to be EXPORT_PER_CPU_SYMBOL_GPL...
> >
> > Side note: while it's nice to hear that sparse kind of got this right,
> > I wonder what gcc does when we start using the named address spaces
> > for percpu variables.
> >
> > We actively make EXPORT_PER_CPU_SYMBOL_XYZ be a no-op for sparse
> > exactly because sparse ended up warning about the regular
> > EXPORT_SYMBOL, and we didn't have any "real" per-cpu export model.
>
> Right.
>
> > So EXPORT_PER_CPU_SYMBOL_GPL() is kind of an artificial "shut up
> > sparse".
>
> Aside of that it's also making it clear what this is about. So I don't
> think it's purely artifical.
>
> > But with __seg_gs/fs support for native percpu symbols with
> > gcc, I wonder if we'll hit the same thing. Or is there something that
> > makes gcc not warn about the named address spaces?
>
> Right now the pending code in tip does not complain about the
> EXPORT_PER_CPU_SYMBOL_GPL() part because our current macro maze is
> hideous. Here is the preprocessor output.
>
> This is DECLARE_PER_CPU() in the header:
>
> extern __attribute__((section(".data..percpu" ""))) __typeof__(u64) x86_s=
pec_ctrl_current;
>
> Here is DEFINE_PER_CPU():
>
> __attribute__((section(".data..percpu" ""))) __typeof__(u64) x86_spec_ctr=
l_current;
>
> And the EXPORT:
>
> extern typeof(x86_spec_ctrl_current) x86_spec_ctrl_current;
>
> static void * __attribute__((__used__))
>    __attribute__((__section__(".discard.addressable")))
>    __UNIQUE_ID___addressable_x86_spec_ctrl_current804 =3D (void *)(uintpt=
r_t)&x86_spec_ctrl_current;
>
>    asm(".section \".export_symbol\",\"a\" ;
>        __export_symbol_x86_spec_ctrl_current: ;
>        .asciz \"GPL\" ; .asciz \"\" ; .balign 8 ; .quad x86_spec_ctrl_cur=
rent ; .previous");
>
> And the __seg_gs magic happens only in the per CPU accessor itself:
>
> __attribute__((__noinline__)) __attribute__((no_instrument_function))
>  __attribute((__section__(".noinstr.text")))
>  __attribute__((__no_sanitize_address__))
>  __attribute__((__no_profile_instrument_function__))
>  u64 spec_ctrl_current(void)
> {
>  return ({
>     // this_cpu_read(x86_spec_ctrl_current)
>
>     typeof(x86_spec_ctrl_current) pscr_ret__;
>
>     do { const void *__vpp_verify =3D (typeof((&(x86_spec_ctrl_current)) =
+ 0))((void *)0); (void)__vpp_verify;
>     } while (0);
>
>     switch(sizeof(x86_spec_ctrl_current))
>     {
>     case 1: pscr_ret__ =3D ({
>             *(volatile typeof(x86_spec_ctrl_current) __seg_gs *)(typeof(*=
&(x86_spec_ctrl_current)) __seg_gs *)(uintptr_t)(&(x86_spec_ctrl_current));=
 });
>             break;
>     case 2: pscr_ret__ =3D ({
>             *(volatile typeof(x86_spec_ctrl_current) __seg_gs *)(typeof(*=
&(x86_spec_ctrl_current)) __seg_gs *)(uintptr_t)(&(x86_spec_ctrl_current));=
 });
>             break;
>     case 4: pscr_ret__ =3D ({
>             *(volatile typeof(x86_spec_ctrl_current) __seg_gs *)(typeof(*=
&(x86_spec_ctrl_current)) __seg_gs *)(uintptr_t)(&(x86_spec_ctrl_current));=
 });
>             break;
>     case 8: pscr_ret__ =3D ({
>             *(volatile typeof(x86_spec_ctrl_current) __seg_gs *)(typeof(*=
&(x86_spec_ctrl_current)) __seg_gs *)(uintptr_t)(&(x86_spec_ctrl_current));=
 });
>             break;
>
>     default: __bad_size_call_parameter(); break;
>     }
>
>     pscr_ret__;
>   });
> }
>
> So all the export etc. just works because it all operates on a plain
> data type and the __seg_gs is only bolted on via type casts in the
> accessors.
>
> As the per cpu variables are in the .data..percpu section the linker
> puts them at address 0 and upwards. So the cast to a __seg_gs pointer
> makes it end up at the real kernel address because of GSBASE + "offset".
>
> The compiler converts this to RIP relative addressing:
>
>   movq   $0x0,%gs:0x7e14169f(%rip)        # 1ba08 <fpu_fpregs_owner_ctx>
>
> This obviously has a downside. If I do:
>
>    u64 foo;
>
>    this_cpu_read(foo);
>
> the compiler is just happy to build that w/o complaining and it will
> only explode at runtime because foo is a kernel data address which added
> to GSBASE will result in accessing some random address:
>
>   mov    %gs:0x15d08d4(%rip),%rax        # ffffffff834aac60 <x86_spec_ctr=
l_base>
>
> This is not at all different from the inline ASM based version which is
> in your tree. The only difference is that the macro maze is pure C and
> the __set_gs cast allows the compiler to (micro) optimize, e.g. 'mov
> %gs:...; movzbl' into a single 'movzbl'.
>
> IOW, right now the only defense against such a mistake is actually the
> sparse check. Maybe one of the coccinelle scripts has something similar,
> I don't know.
>
> I did not follow the __set_gs work closely, so I don't know whether Uros
> ever tried to actually mark the per CPU variable __set_gs right away,
> which would obviously catch the above 'foo' nonsense.

No, because [1]:

"gcc does not provide a way to remove segment qualifiers, which is needed
to use typeof() to create local instances of the per-cpu variable. For
this reason, do not use the segment qualifier for per-cpu variables, and
do casting using the segment qualifier instead."

[1] https://lore.kernel.org/lkml/20190823224424.15296-3-namit@vmware.com/

Uros.

>
> I think this should just work, but that would obviously require to do
> the type cast magic at the EXPORT_SYMBOL side and in some other places.
>
> Thanks,
>
>         tglx
>
>

