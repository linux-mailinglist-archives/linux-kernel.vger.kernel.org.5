Return-Path: <linux-kernel+bounces-105022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADCD87D7BC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B431C21001
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8C71C32;
	Sat, 16 Mar 2024 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rh505mqi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="StuDEB3w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0517E9;
	Sat, 16 Mar 2024 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710551473; cv=none; b=OR4MzYaDzenGtAqksLB7AIw0E56ETl/JmJLinCaF4OpKUHftRkxq0fCwwwNkQP1WPaMucPkLslpaOZeYaJL78ogiZcZfLB5cJy+VEud7Q0u662fyfeyE/RxN/ndGiPl1Bu4bb1JgZa3+uWZlGBlr+XqpSzvZjxtG5ezWh5AyhZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710551473; c=relaxed/simple;
	bh=0x+7dm1ig6PJcpF1GUOtIfcHHMjn4K89eyUR1yOWBjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mqsZkiNDy5k/XQJmXuP8xBSvYshAlg1FMFmtHAL1Au1fIUw03MloRZOJkJtaAl3UdZi5h0ZVE1aLd93pTz7IdU4MnOEVxCZn8rMgc2csUXKhpykOW19ERihvUtHu+P0b7Sn78Hv7ohUNZVYXRbHwO4+LqlEHexEmwV9H8C4ebek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rh505mqi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=StuDEB3w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710551468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeOBxiT9OJ2ujhiixfzKfCr6Amo1IfVgJ8QNhCy+nqU=;
	b=rh505mqi7MOOOw/hLQty3SDFS/ucKfDds03oZSo/TZRFCmN+HL0lLM2WlBYW5Jo5pL6KCU
	S03y3ts1KSMZjI1U2hAJk8BsRk/Dhay9+AXZwk7VUbxB0e6GHGsTyitxH8tIFi+nlDG0Zd
	KPYuryxc/aZW/H0EclBnfMQAkl9lXQdHQF92/s9WR54aJCpd0nCd7EKcokUpKtCdolebPu
	h/7vOnoKbr26Dka+9ADvFNHABkbAWMQu0mMajcZA6zvjHRZtN3O8R9fnGvVXolZrZI050a
	QbTAP0XjT+AsH+OF59collBJYIfZUYALm8xnTJ6x3fwrAWhzNMLmPsabfa9O/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710551468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeOBxiT9OJ2ujhiixfzKfCr6Amo1IfVgJ8QNhCy+nqU=;
	b=StuDEB3w4uHRL8P9KxpQznaP/wNlQdzmkhCwQRU2XJivKCnYML6JMQPDqqg9KPKdrgF1Tp
	CUuSUgzDZ7K4awCQ==
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
 x86@kernel.org, Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
In-Reply-To: <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
 <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
Date: Sat, 16 Mar 2024 02:11:07 +0100
Message-ID: <877ci3j80k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 15 2024 at 16:23, Linus Torvalds wrote:
> On Fri, 15 Mar 2024 at 15:55, Thomas Gleixner <tglx@linutronix.de> wrote:
>> So the proper thing to do is to check for num_possible_cpus() == 1 in
>> that function.
>
> I think that's _one_ proper thing. I still think that the deeper
> problem is that it still looks at local apic rules even when those
> rules are completely nonsensical.
>
> For example, that MAX_LOCAL_APIC range test may not matter simply
> because it's testing a constant value, but it still smells entirely
> wrong to even check for that, when the system doesn't necessarily have
> one.

cpu_info.apic_id defaults to 0, so unless the calling code is completely
broken it will be correct. And I rather catch the case of calling code
being broken in the !APIC case if we still want to support systems
without a local APIC.

> So I think your patch may fix the immediate bug, but I think it's
> still just a band-aid.
>
> Either we should just make all machines look like they have the proper
> local apic mappings, or we shouldn't look at any local apic rules AT
> ALL.

Sure. I can simply check if there was an APIC registered instead.

>> Sure you can argue that we could avoid it for SMP=n builds completely,
>> but I think the right thing to do is to aim for removing CONFIG_SMP and
>> make the UP build a subset of a generic SMP capable build which has
>> CONFIG_NR_CPUS=1, i.e. num_possible_cpus() = 1. Why?
>
> I wouldn't be entirely opposed to just doing that. UP has become
> fairly irrelevant.
>
> That said, UP is *not* entirely irrelevant on other architectures, and
> if we drop UP support on x86, we'll be effectively dropping a lot of
> coverage testing. The number of people who do cross-compilers is
> pretty small.
>
> End result: I'd *much* rather get rid of X86_UP_APIC and the "nolapic"
> kernel command line, and say "even UP has to have a local APIC".
>
> We already require a Pentium-class CPU, so in practice we already
> require that local APIC setup. And yes, machines existed where it
> could be turned off, but I don't think that is relevant any more.

You wish. We still support 486 and some of the still produced 486 clones
do not have a local APIC.

Not that I care and yes I'm all for getting rid of CONFIG_.*_APIC and of
the related config/command line options. If we refuse to boot on
hardware which does not enumerate an APIC then even better.

But that is only a part of the overall problem.

> Put another way: I think "UP config for wider build testing" is a
> _lot_ more relevant than "no LAPIC support".

I really have to disagree here.

The concept of making UP a proper subset of SMP has absolutely nothing
to do with x86 and UP test coverage.

We want SMP as a general concept and overhaul the whole kernel to get
rid of this ever increasing non-sensical UP burden. The real world UP
small system use cases have moved over to other OSes like Zephyr & Co
long ago.

Just because some esoteric architectures (m68k comes to my mind) will
have serious issues with that for the very wrong reasons does not mean
that we should not go there.

It's going to be quite some effort, but the overall benefit is worth it.

OTOH, it's absolutely not rocket science to pretend to be SMP capable
and if some architectures fail to accomodate on the way then we just
should remove them as that's a clear sign of being unmaintained and
irrelevant.

The amount of untested SMP=n code in the kernel becomes frigthening and
your argument that build coverage is making a difference is wishful
thinking at best.

Anything else than making the kernel SMP capable and making UP builds a
well defined subset via CONFIG_NR_CPUS=1 is a complete waste of time and
effort.

If your intention is to indulge in the historical glory of Linux running
on any (by now) irrelevant hardware on the planet, then I stop arguing
right here.

If not, can we please have a serious discussion about going SMP only and
making UP the simple and obvious NR_CPUS=1 subset?

The amount of subtle SMP=n fallout has been kinda exponentially
increasing over the years and it's just putting burden on the wrong
people. TBH, I'm tired of this nonsense.

Thanks,

        tglx

