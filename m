Return-Path: <linux-kernel+bounces-109476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239958819A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D162728453A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E87985C7D;
	Wed, 20 Mar 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXwDs7Pf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A783381D1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975320; cv=none; b=bnlOS3j4Ar/oUL6gey+WEFlMmu9Kpmjrjkan/kOzb9woS4UPOmV2NPAN8xa86D3GXHCjEwkkAF6RVq8EOsauBcfGrvy53mpzrvzfz0GPzqr3CX9S+WJHv9CHea6XMnA7q7Q6X60W2I6WZYGDZUmDtCKredKF4qwk8DcBIwm8hsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975320; c=relaxed/simple;
	bh=DpItbTfCRtsp3QfBKRvAonSxvMxe8uSVUklGaCB6Nrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfMJK4mJxt0gjbHhGybuxpydpgDz8f6/UAoBHSzQK59mvlVuzezVifVG2kdxuk5JQhYF7q5/i6qVT1hr9xtGkbfMiaIb2htqCZgr/VQmsjm9SdH2Bh+uFltnm6t0eNL/WYTgf7APBH/qjnbSBCkltYBs+OVNy6kv2EanS3OrCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXwDs7Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9968EC433C7;
	Wed, 20 Mar 2024 22:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710975319;
	bh=DpItbTfCRtsp3QfBKRvAonSxvMxe8uSVUklGaCB6Nrw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LXwDs7PfqhdJZgEWblaU0LIWQkK88pK8wgY6+JBVL/+5iPWGjWHcuAOfuJSnd7qHg
	 5N+jn/Sjng+9ghuUBwO/TxUDZKXlLIjkIu9QcojI+gRjikHQAUWcb0ak8aoELt51Tq
	 xXYgXK1cgsT0s3WkYuMcmgVqpxRdNPBC4UuvcDC8sL8cUzCv85hptwr1uc7wnQqg61
	 Zw4fIvpfxOvZFcuVekuZceuY+FivkoCX39YQLs5s39JJuDTND6yiA57aM3XrwYhSAt
	 gEb7m+gc0d15ab8dyR9anNiZLIpXZZSCidLexLRYEipIulPVP6/TPW+9z2yVVSLinN
	 yJnO0A4bCcVvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88A54CE0716; Wed, 20 Mar 2024 15:55:17 -0700 (PDT)
Date: Wed, 20 Mar 2024 15:55:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfsLtMijRrNZfqh6@localhost.localdomain>

On Wed, Mar 20, 2024 at 05:15:48PM +0100, Frederic Weisbecker wrote:
> Le Wed, Mar 20, 2024 at 04:14:24AM -0700, Paul E. McKenney a écrit :
> > On Tue, Mar 19, 2024 at 02:18:00AM -0700, Paul E. McKenney wrote:
> > > On Tue, Mar 19, 2024 at 12:07:29AM +0100, Frederic Weisbecker wrote:
> > > > While running in nohz_full mode, a task may enqueue a timer while the
> > > > tick is stopped. However the only places where the timer wheel,
> > > > alongside the timer migration machinery's decision, may reprogram the
> > > > next event accordingly with that new timer's expiry are the idle loop or
> > > > any IRQ tail.
> > > > 
> > > > However neither the idle task nor an interrupt may run on the CPU if it
> > > > resumes busy work in userspace for a long while in full dynticks mode.
> > > > 
> > > > To solve this, the timer enqueue path raises a self-IPI that will
> > > > re-evaluate the timer wheel on its IRQ tail. This asynchronous solution
> > > > avoids potential locking inversion.
> > > > 
> > > > This is supposed to happen both for local and global timers but commit:
> > > > 
> > > > 	b2cf7507e186 ("timers: Always queue timers on the local CPU")
> > > > 
> > > > broke the global timers case with removing the ->is_idle field handling
> > > > for the global base. As a result, global timers enqueue may go unnoticed
> > > > in nohz_full.
> > > > 
> > > > Fix this with restoring the idle tracking of the global timer's base,
> > > > allowing self-IPIs again on enqueue time.
> > > 
> > > Testing with the previous patch (1/2 in this series) reduced the number of
> > > problems by about an order of magnitude, down to two sched_tick_remote()
> > > instances and one enqueue_hrtimer() instance, very good!
> > > 
> > > I have kicked off a test including this patch.  Here is hoping!  ;-)
> > 
> > And 22*100 hours of TREE07 got me one run with a sched_tick_remote()

Sigh.  s/22/12/

> > complaint and another run with a starved RCU grace-period kthread.
> > So this is definitely getting more reliable, but still a little ways
> > to go.

An additional eight hours got anohtre sched_tick_remote().

> Right, there is clearly something else. Investigation continues...

Please let me know if there is a debug patch that I could apply.

							Thanx, Paul

