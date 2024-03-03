Return-Path: <linux-kernel+bounces-89946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1D86F7E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB84E1C20A8C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C673E7AE75;
	Sun,  3 Mar 2024 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b6hPQNSO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQFmOUAz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3A2C1B1;
	Sun,  3 Mar 2024 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709509763; cv=none; b=djAStygAmbycZ7mtNUwRzafscTx4Jwxy6hiCgOXaZxBV1NC8GEqoYVEAXidI57yla5QF86yxtCy4sv4/nlWRrup4hBBku3JQ/W5mREZypW9atYf7aIDYttypbCaSwDfc7R8B07LS8cS1MR3JLm9tIOs3Rcf2jzLMGLjDJABCghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709509763; c=relaxed/simple;
	bh=v5ar+tdN7/lYRRRUenodLkDikwASd1JhTisMy47kCzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R3hicFenP1/L9E9aWYmLpHvT9n7RDF7joBycNHlddE/IYZ1I1BiopNOtLrzIWkLY6rxXu7UgApDrELpL+Z4dxO1lbKmctDZlqDShSV2Dr7pSl0KJVPbyYdqvc8wAyqhC0inLl20RviwFGo37QNH6WQvgaJqa8ghigBbgkbpBnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b6hPQNSO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQFmOUAz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709509759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIqVj5QDEFMwPaAVH8zc/FziwYScHdoN6hh4zSkLtiM=;
	b=b6hPQNSOv9Xd2HqKeB9R7CvmHIvdYEU5vg5UMHXIY0KaUDjknpJXr8pU4fB80nnr9KIesf
	KLiWQCSGoo8oRcXAqPmeU3H5S/6Yxh4e2mlHSPceM2khm7C6KVC99NBjhOIMM+4yy5I3JR
	Q2y5NZ/h6XuWJSzqy4u0xSLYbVPLzpEMfGV0jQcOAbn1NTIV+YXh740bnn6Xdl+F/sDVGD
	KteJtHrLKdMUZ6K7Ne/91jK08CeMluba3R2CDkuPHct6cs/qxAPOMJu0mP6f5K5Zu8cDpI
	Uzpo4M019waBhrVENLc215bNxxKKC1mxi8gn6RSDw9OdtCygIB+2M9NbzVI2rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709509759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIqVj5QDEFMwPaAVH8zc/FziwYScHdoN6hh4zSkLtiM=;
	b=oQFmOUAzNABJMPQ1wG1zUHQ+0PjksQAHfuYGGkDf0PD7+YmJCQ8/8ntg8xcS6Gs3tHOj2Z
	rKSxQAP0HZtS/HCQ==
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot
 <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
 x86@kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse
 Mailing-list <linux-sparse@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
In-Reply-To: <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com>
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx>
 <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx>
 <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
 <87bk7vuldh.ffs@tglx>
 <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
 <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com>
Date: Mon, 04 Mar 2024 00:49:18 +0100
Message-ID: <87bk7ux4e9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03 2024 at 21:24, Uros Bizjak wrote:
> On Sun, Mar 3, 2024 at 9:21=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
>> On Sun, Mar 3, 2024 at 9:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> > That's so sad because it would provide us compiler based __percpu
>> > validation.
>>
>> Unfortunately, the c compiler can't strip qualifiers, so typeof() is
>> of limited use also when const and volatile qualifiers are used.
>> Perhaps some extension could be introduced to c standard to provide an
>> unqualified type, e.g. typeof_unqual().
>
> Oh, there is one in C23 [1].

Yes. I found it right after ranting.

gcc >=3D 14 and clang >=3D 16 have support for it of course only when adding
-std=3Dc2x to the command line.

Sigh. The name space qualifiers are non standard and then the thing
which makes them more useful is hidden behind a standard.

Why can't we have useful tools?

Though the whole thing looks worthwhile:

#define verify_per_cpu_ptr(ptr)						\
do {									\
	const void __seg_gs *__vpp_verify =3D (typeof((ptr) + 0))NULL;    \
	(void)__vpp_verify;						\
} while (0)

#define per_cpu_ptr(ptr, cpu)						\
({									\
	verify_per_cpu_ptr(ptr);					\
	(typeof_unqual(*(ptr)) *)(uintptr_t)ptr + per_cpu_offset(cpu);	\
})

unsigned int __seg_gs test;

unsigned int foo1(unsigned int cpu)
{
	return *per_cpu_ptr(&test, cpu);
}

unsigned int foo2(unsigned int cpu)
{
	unsigned int x, *p =3D per_cpu_ptr(&x, cpu);

	return *p;
}

x.c:29:23: error: initializing 'const __attribute__((address_space(256))) v=
oid *' with an expression of type 'typeof ((&x) + 0)' (aka 'unsigned int *'=
) changes address space of pointer
        unsigned int x, *p =3D per_cpu_ptr(&x, cpu);

That's exactly what we want. It would have caught all the long standing
and ignored __percpu sparse warnings right away.

This also simplifies all the other per cpu accessors. The most trivial
is read()

#define verify_per_cpu(variable)					\
{									\
	const unsigned int __s =3D sizeof(variable);			\
									\
	verify_per_cpu_ptr(&(variable));				\
	BUILD_BUG_ON(__s =3D=3D 1 || __s =3D=3D 2 || __s =3D=3D 4 || __s =3D=3D 8,=
	\
		     "Wrong size for per CPU variable");		\
}

#define __pcpu_read(variable)						\
({									\
	verify_per_cpu(variable);					\
	READ_ONCE(variable);						\
})

which in turn catches all the mistakes, i.e. wrong namespace and wrong
size.

I'm really tempted to implement this as an alternative to the current
pile of macro horrors. Of course this requires to figure out first what
kind of damage -std=3Dc2x will do.

I get to that in my copious spare time some day.

Thanks,

        tglx

