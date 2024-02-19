Return-Path: <linux-kernel+bounces-71319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC7C85A377
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5B3283C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B4131A7E;
	Mon, 19 Feb 2024 12:32:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516C2E652
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345948; cv=none; b=GcwZ5i+Rb9idvbZpj+EnUvZ+UPWn9UB4XLaDUl6Vg2mLPICqXBsA4sScrjGhkpaDTlGyCC+GSDMYmny5dwPXoyAeP35JLO2s2Cc3UZUrCJOJa7WPk29BQYoxTAKEVgBTgpyAHz+FH82UitUUboi7l37u4AkOQOepKjEPlHdhdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345948; c=relaxed/simple;
	bh=TpY5wvjvpTME5DvC+TJRlgikQDnOPMM1tS9WDjvoTMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CedZjR87LDKLtjhJNMSXg1e1hTwpNg+BOQRfurk+QYLzFrojiW6I4wEMxehsRYUCUELcVqYF2UM/vzHMMxxaBgAu2Hvpza55Hs+2TlooN9pB8chY+O/zHtGcFX3xQbYfGEPnyCmvjip9PJV1fq350i+IgxwRBIue2vVpDjuSyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DBE6FEC;
	Mon, 19 Feb 2024 04:33:05 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE45B3F73F;
	Mon, 19 Feb 2024 04:32:20 -0800 (PST)
Date: Mon, 19 Feb 2024 12:32:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH 17/30] x86/thread_info: define TIF_NEED_RESCHED_LAZY
Message-ID: <ZdNKUlYzQG4fk4YF@FVFF77S0Q05N>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-18-ankur.a.arora@oracle.com>
 <Zcy_TJt9L0EXcsVM@FVFF77S0Q05N>
 <874jeardni.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jeardni.fsf@oracle.com>

On Wed, Feb 14, 2024 at 12:31:29PM -0800, Ankur Arora wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> > On Mon, Feb 12, 2024 at 09:55:41PM -0800, Ankur Arora wrote:

> >> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> >> index d63b02940747..88c1802185fc 100644
> >> --- a/arch/x86/include/asm/thread_info.h
> >> +++ b/arch/x86/include/asm/thread_info.h
> >> @@ -81,8 +81,11 @@ struct thread_info {
> >>  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
> >>  #define TIF_SIGPENDING		2	/* signal pending */
> >>  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
> >> -#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
> >> -#define TIF_SSBD		5	/* Speculative store bypass disable */
> >> +#ifdef CONFIG_PREEMPT_AUTO
> >> +#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling */
> >> +#endif
> >> +#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
> >> +#define TIF_SSBD		6	/* Speculative store bypass disable */
> >
> > It's a bit awkward/ugly to conditionally define the TIF_* bits in arch code,
> > and we don't do that for other bits that are only used in some configurations
> > (e.g. TIF_UPROBE). That's not just for aesthetics -- for example, on arm64 we
> > try to keep the TIF_WORK_MASK bits contiguous, which is difficult if a bit in
> > the middle doesn't exist in some configurations.
> 
> That's useful to know. And, I think you are right about the
> ugliness of this.
> 
> > Is it painful to organise the common code so that arch code can define
> > TIF_NEED_RESCHED_LAZY regardless of whether CONFIG_PREEMPT_AUTO is selected?
> 
> So, the original reason I did it this way was because I wanted to have
> zero performance impact on !CONFIG_PREEMPT_AUTO configurations whether
> TIF_NEED_RESCHED_LAZY was defined or not.
> (I was doing some computation with TIF_NEED_RESCHED_LAZY at that point.)
> 
> Eventually I changed that part of code but this stayed.
> 
> Anyway, this should be easy enough to fix with done #ifdefry.
> 
> Thanks for reviewing.

Great!

BTW, the series overall looks to be in very good shape; thanks a lot for
working on this!

Mark.

