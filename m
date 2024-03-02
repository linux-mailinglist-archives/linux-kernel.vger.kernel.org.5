Return-Path: <linux-kernel+bounces-89288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA2686EDC1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EBFB21A54
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C543253AC;
	Sat,  2 Mar 2024 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJEoBVqA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193810E3
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342195; cv=none; b=rx/utdSRFLRvbU6DQFU5HO4b3CwltBUQvGZBtsEfpy5F+Co61lQNKhU+6OGFxm4i4XBOX5bt/pcwjY1q1WMfA1T1vobdelzinVegWFdbzfcq+4JItA2t1agxcRfh9YQ1peBNUxJt+dSp7czz/+GAK+iax441UZH09tFRN/yg5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342195; c=relaxed/simple;
	bh=USATP74KI+XzG2soiQE5kgdb5/VxlCqpaYbTagyTRCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfiIYcMAiL8ItFlY5BunEfW0fvzRPGgP3iXSbq9k+QkcQ/XrqqT/DAy9W2U6BwBSHtZOBO5h3P2xCTBDTlD9IVKfi0sPB7d98YcwTcItI0WbPnWxQB0r3ifDNFN7LC0JyeY6vEZBEccC53mHaNAVElHOj/Puvwwds2ezVX4SJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJEoBVqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC43C433C7;
	Sat,  2 Mar 2024 01:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709342194;
	bh=USATP74KI+XzG2soiQE5kgdb5/VxlCqpaYbTagyTRCk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oJEoBVqAesdyYp0ftv4LNZ2PSoPLVrt9JZolcsGssxjesJcbs8je0BzziPOgzWVZK
	 +jpVEZXeTRpRLUaWvzdTOpOMhg/1MM9FCkRi6yP0lRorEv7gDIklOjUa6QcL+RUfCG
	 IKLbjcTj8LYTBCMcisDaEf7q2j5Upd1cDkxL59ZqnL45RLluHeRDG6DQT+iegHXM73
	 ekhspmtZR/Tr0YAQQZ6BskDD5B7VLBxYP9alF75TqFairOqfXziNDrWJf1nQf4FtUz
	 4uiAPW3lwkE//2csNwBo0lrHtTr/ZVDS5t4y6/MNKo37K2JcamvCGPjLJjuBFozEE4
	 5hmEXzFOZQQaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D5A7DCE140C; Fri,  1 Mar 2024 17:16:33 -0800 (PST)
Date: Fri, 1 Mar 2024 17:16:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	peterz@infradead.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, David.Laight@aculab.com,
	richard@nod.at, jon.grimm@amd.com, bharata@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Message-ID: <91437fa8-c192-4a71-8073-bdd9c3889926@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7db5c057-8bd4-4209-8484-3a0f9f3cd02d@paulmck-laptop>
 <2b735ba4-8081-4ddb-9397-4fe83143d97f@paulmck-laptop>
 <20240221131901.69c80c47@gandalf.local.home>
 <8f30ecd8-629b-414e-b6ea-b526b265b592@paulmck-laptop>
 <20240221151157.042c3291@gandalf.local.home>
 <53020731-e9a9-4561-97db-8848c78172c7@paulmck-laptop>
 <ZddtKszRH5Ak5tZ7@FVFF77S0Q05N>
 <1ec4dc29-8868-4d82-8c5e-c17ad025bc22@paulmck-laptop>
 <Zdh8CdrtbL9LgOLG@FVFF77S0Q05N>
 <5641c2f4-3453-4b04-ab0d-db9e5b464b9c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5641c2f4-3453-4b04-ab0d-db9e5b464b9c@paulmck-laptop>

On Fri, Feb 23, 2024 at 07:31:50AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 23, 2024 at 11:05:45AM +0000, Mark Rutland wrote:
> > On Thu, Feb 22, 2024 at 11:11:34AM -0800, Paul E. McKenney wrote:
> > > On Thu, Feb 22, 2024 at 03:50:02PM +0000, Mark Rutland wrote:
> > > > On Wed, Feb 21, 2024 at 12:22:35PM -0800, Paul E. McKenney wrote:
> > > > > On Wed, Feb 21, 2024 at 03:11:57PM -0500, Steven Rostedt wrote:
> > > > > > On Wed, 21 Feb 2024 11:41:47 -0800
> > > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > > 
> > > > > > > > I wonder if we can just see if the instruction pointer at preemption is at
> > > > > > > > something that was allocated? That is, if it __is_kernel(addr) returns
> > > > > > > > false, then we need to do more work. Of course that means modules will also
> > > > > > > > trigger this. We could check __is_module_text() but that does a bit more
> > > > > > > > work and may cause too much overhead. But who knows, if the module check is
> > > > > > > > only done if the __is_kernel() check fails, maybe it's not that bad.  
> > > > > > > 
> > > > > > > I do like very much that idea, but it requires that we be able to identify
> > > > > > > this instruction pointer perfectly, no matter what.  It might also require
> > > > > > > that we be able to perfectly identify any IRQ return addresses as well,
> > > > > > > for example, if the preemption was triggered within an interrupt handler.
> > > > > > > And interrupts from softirq environments might require identifying an
> > > > > > > additional level of IRQ return address.  The original IRQ might have
> > > > > > > interrupted a trampoline, and then after transitioning into softirq,
> > > > > > > another IRQ might also interrupt a trampoline, and this last IRQ handler
> > > > > > > might have instigated a preemption.
> > > > > > 
> > > > > > Note, softirqs still require a real interrupt to happen in order to preempt
> > > > > > executing code. Otherwise it should never be running from a trampoline.
> > > > > 
> > > > > Yes, the first interrupt interrupted a trampoline.  Then, on return,
> > > > > that interrupt transitioned to softirq (as opposed to ksoftirqd).
> > > > > While a softirq handler was executing within a trampoline, we got
> > > > > another interrupt.  We thus have two interrupted trampolines.
> > > > > 
> > > > > Or am I missing something that prevents this?
> > > > 
> > > > Surely the problematic case is where the first interrupt is taken from a
> > > > trampoline, but the inner interrupt is taken from not-a-trampoline? If the
> > > > innermost interrupt context is a trampoline, that's the same as that without
> > > > any nesting.
> > > 
> > > It depends.  If we wait for each task to not have a trampoline in effect
> > > then yes, we only need to know whether or not a given task has at least
> > > one trampoline in use.  One concern with this approach is that a given
> > > task might have at least one trampoline in effect every time it is
> > > checked, unlikely though that might seem.
> > > 
> > > If this is a problem, one way around it is to instead ask whether the
> > > current task still has a reference to one of a set of trampolines that
> > > has recently been removed.  This avoids the problem of a task always
> > > being one some trampoline or another, but requires exact identification
> > > of any and all trampolines a given task is currently using.
> > >
> > > Either way, we need some way of determining whether or not a given
> > > PC value resides in a trampoline.  This likely requires some data
> > > structure (hash table?  tree?  something else?) that must be traversed
> > > in order to carry out that determination.  Depending on the traversal
> > > overhead, it might (or might not) be necessary to make sure that the
> > > traversal is not on the entry/exit/scheduler fast paths.  It is also
> > > necessary to keep the trampoline-use overhead low and the trampoline
> > > call points small.
> > 
> > Thanks; I hadn't thought about that shape of livelock problem; with that in
> > mind my suggestion using flags was inadequate.
> > 
> > I'm definitely in favour of just using Tasks RCU! That's what arm64 does today,
> > anyhow!
> 
> Full speed ahead, then!!!  But if you come up with a nicer solution,
> please do not keep it a secret!

The networking NAPI code ends up needing special help to avoid starving
Tasks RCU grace periods [1].  I am therefore revisiting trying to make
Tasks RCU directly detect trampoline usage, but without quite as much
need to identify specific trampolines...

I am putting this information in a Google document for future
reference [2].

Thoughts?

								Thanx, Paul

[1] https://lore.kernel.org/all/Zd4DXTyCf17lcTfq@debian.debian/
[2] https://docs.google.com/document/d/1kZY6AX-AHRIyYQsvUX6WJxS1LsDK4JA2CHuBnpkrR_U/edit?usp=sharing

