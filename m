Return-Path: <linux-kernel+bounces-109149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD48881556
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CE21C22AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8BC5579A;
	Wed, 20 Mar 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKnqgjLg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C35D5577E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951352; cv=none; b=QeWjVsp5Dwco3/bagTfUy+yPYWkdKC7DUWUQ+3pCNd6B3zuBeE38nWkJ+tfA0cVMKe72Lqfm9/YXVhf2Cpsrbsb3r4ga91vkE1Evs/v6F/RpgvWoJ1mlQCTXxQ0nKZJmra9zG0gAyZdpfkAzsqr029PA2PDrokvpXnirRSmdLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951352; c=relaxed/simple;
	bh=pNUTtnip1jZyKceBb2YKX7qImvQmdShebTlumYIYMq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO3JecxSkft6HcVhoBeurDS0ZNrmAMagzAARsbxkmpeI9/9f3Hz+EtxYUoUWAtoUsQ7xIPOfYAe1VbJZT2XOy8xXow+u08QX7nYvIgAqhIkYESvFChILUDnjjuWAcidX+/F83u/IGeSRYE52VSmqSLO9HOFFd3uLw4/lss3JWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKnqgjLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53436C433C7;
	Wed, 20 Mar 2024 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710951351;
	bh=pNUTtnip1jZyKceBb2YKX7qImvQmdShebTlumYIYMq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKnqgjLgUjxBUtdHMbNgQQWA8yFWDRpZxADCZYuaEvm5BIqmw1InJ6bT0ngZgN5mE
	 OZn+OeDjrDCHp+AWtBgiCKwsdlnqkRzN4vQKtBPZ5/p1Bs0H8cQBeK3ScR6Z3Hl2wL
	 J3zpCz4nBewVH+2s5fRGke/jRqcVs/NPlNNihN914eQA0/imPnu9NfoTqupsFjVSCZ
	 z3eGq/O8MkIQUqO1NInI/sas+yX/NzKAX+TqXuxGeRrED1SQ/e0xnq92Jnbq8RlR+P
	 iKTU1MW5c4uAHWtXoSO5t+DB8wGR1NZ+KeGhTDcjr0k/3FQcbq4Q2bJftOba4Xawx7
	 D5BNqcq9ZK/XQ==
Date: Wed, 20 Mar 2024 17:15:48 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <ZfsLtMijRrNZfqh6@localhost.localdomain>
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>

Le Wed, Mar 20, 2024 at 04:14:24AM -0700, Paul E. McKenney a écrit :
> On Tue, Mar 19, 2024 at 02:18:00AM -0700, Paul E. McKenney wrote:
> > On Tue, Mar 19, 2024 at 12:07:29AM +0100, Frederic Weisbecker wrote:
> > > While running in nohz_full mode, a task may enqueue a timer while the
> > > tick is stopped. However the only places where the timer wheel,
> > > alongside the timer migration machinery's decision, may reprogram the
> > > next event accordingly with that new timer's expiry are the idle loop or
> > > any IRQ tail.
> > > 
> > > However neither the idle task nor an interrupt may run on the CPU if it
> > > resumes busy work in userspace for a long while in full dynticks mode.
> > > 
> > > To solve this, the timer enqueue path raises a self-IPI that will
> > > re-evaluate the timer wheel on its IRQ tail. This asynchronous solution
> > > avoids potential locking inversion.
> > > 
> > > This is supposed to happen both for local and global timers but commit:
> > > 
> > > 	b2cf7507e186 ("timers: Always queue timers on the local CPU")
> > > 
> > > broke the global timers case with removing the ->is_idle field handling
> > > for the global base. As a result, global timers enqueue may go unnoticed
> > > in nohz_full.
> > > 
> > > Fix this with restoring the idle tracking of the global timer's base,
> > > allowing self-IPIs again on enqueue time.
> > 
> > Testing with the previous patch (1/2 in this series) reduced the number of
> > problems by about an order of magnitude, down to two sched_tick_remote()
> > instances and one enqueue_hrtimer() instance, very good!
> > 
> > I have kicked off a test including this patch.  Here is hoping!  ;-)
> 
> And 22*100 hours of TREE07 got me one run with a sched_tick_remote()
> complaint and another run with a starved RCU grace-period kthread.
> So this is definitely getting more reliable, but still a little ways
> to go.

Right, there is clearly something else. Investigation continues...

