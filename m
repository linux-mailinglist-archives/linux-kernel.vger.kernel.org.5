Return-Path: <linux-kernel+bounces-15435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9B822BF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074841F23F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D062618E17;
	Wed,  3 Jan 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T33Dvq1B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D618E06
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2721AC433C7;
	Wed,  3 Jan 2024 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704280695;
	bh=7j4rRvQhFlXNPbxO4qDErGk4qOnDNU6odiqKx4NSeJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T33Dvq1B38BBStl8DVJQDWzr+/YVqnCcVcLSOREXVwVv7zndIJSkO0XbQ3wg71IBG
	 lKzYwWNCL2s7MsFCC73XrHm1Wgu9Fp6MzxvvnDYNaI352uUO0ZFPMkL2n8FiCxSD0M
	 houebhQytEz3Z1vmvPnuMD3xdBSzjYw4XE2CVGARVjxkMmOMNV/U5c4ptw9FqUK2qJ
	 pXqmSfvpmG4r3BuDqviG9zkipc9L45b88alCdoh9VxzB0q4Bm5t22rxHU26DBWwfbH
	 +tAW8UzptTScyiznIfSFmiF+LVjKYvNmUpQLbvsmSp/vesLPvD5n0sE5gNVRiVOcL0
	 tNULqAsPIfWvA==
Date: Wed, 3 Jan 2024 19:05:04 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: leobras.c@gmail.com
Cc: Leonardo =?utf-8?B?QnLDoXM=?= <leobras@redhat.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will@kernel.org>, peterz@infradead.org,
	boqun.feng@gmail.com, Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	parri.andrea@gmail.com, andrzej.hajda@intel.com, guoren@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables
 of size 1 and 2
Message-ID: <ZZU/YNPMigiD/k1g@xhacker>
References: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
 <2a4f1f47e945772b9fbb53a51e148636e0ae6e48.camel@redhat.com>
 <ZW_GzKUoqO4fD4Je@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW_GzKUoqO4fD4Je@LeoBras>

On Tue, Dec 05, 2023 at 09:56:44PM -0300, leobras.c@gmail.com wrote:
> From: Leonardo Bras <leobras@redhat.com>
> 
> On Wed, Aug 30, 2023 at 06:59:46PM -0300, Leonardo Brás wrote:
> > On Thu, 2023-08-10 at 09:23 -0700, Palmer Dabbelt wrote:
> > > On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > > > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> > > > > On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > > > > > xchg for variables of size 1-byte and 2-bytes is not yet available for
> > > > > > riscv, even though its present in other architectures such as arm64 and
> > > > > > x86. This could lead to not being able to implement some locking mechanisms
> > > > > > or requiring some rework to make it work properly.
> > > > > > 
> > > > > > Implement 1-byte and 2-bytes xchg in order to achieve parity with other
> > > > > > architectures.
> > > > > > 
> > > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > > 
> > > > 
> > > > Hello Arnd Bergmann, thanks for reviewing!
> > > > 
> > > > > Parity with other architectures by itself is not a reason to do this,
> > > > > in particular the other architectures you listed have the instructions
> > > > > in hardware while riscv does not.
> > > > 
> > > > Sure, I understand RISC-V don't have native support for xchg on variables of
> > > > size < 4B. My argument is that it's nice to have even an emulated version for
> > > > this in case any future mechanism wants to use it.
> > > > 
> > > > Not having it may mean we won't be able to enable given mechanism in RISC-V. 
> > > 
> > > IIUC the ask is to have a user within the kernel for these functions.  
> > > That's the general thing to do, and last time this came up there was no 
> > > in-kernel use of it -- the qspinlock stuff would, but we haven't enabled 
> > > it yet because we're worried about the performance/fairness stuff that 
> > > other ports have seen and nobody's got concrete benchmarks yet (though 
> > > there's another patch set out that I haven't had time to look through, 
> > > so that may have changed).
> > > 
> > > So if something uses these I'm happy to go look closer.
> > 
> > IIUC patches 4 & 5 will be used by qspinlock, which may not be done yet, so we
> > don't have an use for them for the time being.
> > 
> > Otherwise, any comments on patches 1, 2 & 3?
> 
> ping

Hi,

I believe the "RFC" makes some reviewers think the series isn't ready
for review, so could you please send a new one w/o RFC?

thanks

> 
> > 
> > > 
> > > > > Emulating the small xchg() through cmpxchg() is particularly tricky
> > > > > since it's easy to run into a case where this does not guarantee
> > > > > forward progress.
> > > > > 
> > > > 
> > > > Didn't get this part:
> > > > By "emulating small xchg() through cmpxchg()", did you mean like emulating an
> > > > xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> > > > 
> > > > If so, yeah, it's a fair point: in some extreme case we could have multiple
> > > > threads accessing given cacheline and have sc always failing. On the other hand,
> > > > there are 2 arguments on that:
> > > > 
> > > > 1 - Other architectures, (such as powerpc, arm and arm64 without LSE atomics)
> > > > also seem to rely in this mechanism for every xchg size. Another archs like csky
> > > > and loongarch use asm that look like mine to handle size < 4B xchg. 
> > > >     
> > > > 
> > > > >  This is also something that almost no architecture
> > > > > specific code relies on (generic qspinlock being a notable exception).
> > > > > 
> > > > 
> > > > 2 - As you mentioned, there should be very little code that will actually make
> > > > use of xchg for vars < 4B, so it should be safe to assume its fine to not
> > > > guarantee forward progress for those rare usages (like some of above mentioned
> > > > archs).
> > > > 
> > > > > I would recommend just dropping this patch from the series, at least
> > > > > until there is a need for it.
> > > > 
> > > > While I agree this is a valid point, I believe its more interesting to have it
> > > > implemented if any future mechanism wants to make use of this. 
> > > > 
> > > > 
> > > > Thanks!
> > > > Leo
> > > 
> > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

