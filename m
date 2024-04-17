Return-Path: <linux-kernel+bounces-149063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39FB8A8B43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C726B21F01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F711712;
	Wed, 17 Apr 2024 18:41:14 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC38F4A;
	Wed, 17 Apr 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379273; cv=none; b=IxrrPE7ZxK64qyL/JQ3wckc3/6rzedwI7sE1l2DNSZPTbhPLGfW1exHCXjYui71GHlpUThZcvmISo58awCW/Opu+M7eUcW3VOkivYyB9z5JZegFDzeJZ0lq1mSTkl+NITf9y0A84S7N/7eRaALo7f3gqEqtDi9kcGAL11yLKCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379273; c=relaxed/simple;
	bh=Ru7UYv/AeIgZXVSt5LnPpEnVAeH0fF5Fi5Cs5IYnadY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZ2c9K1o6SQsMo/XRM979IRcWFUJQGbxUxN1YbcyQpACCUDmOLjHuK9YqNsJ046mAQhBDA86qYTkBdg+tvXf1ZqxlV5bm1iXGwBk0CyHhMhaIgoh1KjZ2JeFK24GV1YDKQ38fZn4QFP9Qy3Hq5hcLuL0Ggh/28PfOhJ+gyzk4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8BCE640E024C;
	Wed, 17 Apr 2024 18:41:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GR1CM0GmmCcU; Wed, 17 Apr 2024 18:40:56 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 754F040E0028;
	Wed, 17 Apr 2024 18:40:48 +0000 (UTC)
Date: Wed, 17 Apr 2024 20:40:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, x86@kernel.org
Subject: Re: [tip: locking/core] locking/atomic/x86: Introduce
 arch_try_cmpxchg64_local()
Message-ID: <20240417184040.GEZiAXqKvw3uRcmTJL@fat_crate.local>
References: <20240414161257.49145-1-ubizjak@gmail.com>
 <171312759954.10875.1385994404712358986.tip-bot2@tip-bot2>
 <20240415201119.GBZh2J57f3aouPE_JR@fat_crate.local>
 <CAFULd4aFSBHNxyVyVt9soPnJXDgiOu6qCCNMLoenFNXtk0W4wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4aFSBHNxyVyVt9soPnJXDgiOu6qCCNMLoenFNXtk0W4wA@mail.gmail.com>

On Wed, Apr 17, 2024 at 06:24:21PM +0200, Uros Bizjak wrote:
> We are dealing with locking primitives, probably the hottest part of
> the kernel. For 64-bits, the patch is effectively a couple of lines,
> reusing and extending existing macros,

Ok.

> the line count for a modern 32-bit target is also a couple of lines,
> but there the saved insn count is much higher, around 10 instructions.

Yah, that __arch_try_cmpxchg64_emu_local() thing with yet another
alternative in there. So that's not a couple of lines - it is yet
another cryptic alternative we need to pay attention to.

> Really? Was this decision reached by the community consensus?

Nothing official. Unofficially, we don't care.

> The linux kernel has many uses, and using it for servers by a big
> company, you are the voice of,

No, here I'm wearing my maintainer hat.

> I'm sure that 32-bit is quite relevant for embedded users and more

People keep dangling those "embedded users" each time. Which users are
those? I haven't seen anyone complaining about 32-bit kernels being
broken or testing them. Because we keep breaking them and no one
notices. Maybe that's a sign for how much they're used.

Although, I broke 32-bit recently and people caught it so there are some
straddlers from time to time. But that's very seldom. And each time we
tell them to switch to 64-bit.

> than relevant to a student or an enthusiast in some remote part of the
> world.

Trust me, they have 64-bit CPUs. Most of the 32-bit CPUs they had are
probably dead already. Like mine.

32-bit only CPUs like P4, for example, should be trashed just because
they're contributing to global warming. :-P

> As a maintainer, you should also take care of the communities
> that are somehow neglected, where unilateral decisions like the one
> above can have unwanted consequences.

We still keep 32-bit kernels alive - no one has dropped them yet - we
just don't add new features.

> If the line count is the problem, I can easily parametrize new and
> existing big macro descriptions in a follow-up patch. However, I was
> advised to not mix everything together in one patch, but rest assured,
> the creation and testing of the follow-up patch would take me less
> time than writing the message you are reading.

I'm simply making sure we're not going off the rails with
micro-optimizing for no apparent reason.

Saving a

	test   %rax,%rax

doesn't need fixing in my book. Because I don't think you'll be able to
even measure it.

> It brings no future maintenance burden, but it perhaps improves
> someone's life a tiny bit.

This is where you and I disagree: touching that alternative in
__arch_try_cmpxchg64_emu_local() does as we tend to change them from
time to time, especially in recent times.

And I wouldn't mind touching it but if it is there to save 10 insns on
32-bit - which doesn't matter - then why bother?

Or do you have a relevant 32-bit workload which brings any improvement
by this change?

> Last, but not least, I'm bringing some ideas from the compiler
> development community, where the attitude to redundant instructions is
> totally different. It could take weeks of effort and considerable
> rewrite of compiler functionality just to remove one instruction ;)
> Micro-optimizations add up!

I'm sure but they all need to be weighed in. Zapping a TEST REG,REG is
not worth it. On most machines, that ALU insn executes in 1 cycle.

I wanna say, such "optimizations" should be checked by benchmarks to see
whether they even give any improvements but we can't check every patch.

IOW, all the patches we're adding should answer the "Is it really worth
the effort?" question. And don't forget that "it brings no future
maintenance burden" is wrong. It brings a maintenance burden every time
we refactor the kernel. And we do that all the time. So the more sites
you have to touch, the more it adds up.

So even if your patch saves 10 insns but there's not a single workload
where it matters, then don't bother. There are other, lower hanging
fruits we need to tackle first.

> Thanks for reading this,

Thanks for taking the time to explain how you're seeing it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

