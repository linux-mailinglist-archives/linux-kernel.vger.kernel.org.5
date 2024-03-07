Return-Path: <linux-kernel+bounces-96046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5E875685
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A22E28389B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD8135A6D;
	Thu,  7 Mar 2024 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYqyygud"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F98135A46
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838063; cv=none; b=srrsKKVk0GARgtUFbJ1+3zXEq/gTVjufsgs9R6fimhkR5R5D3s5/BXfzFtazz7Fa59MkdOB551XduEFgHTOh19b6b3OkOfLt0yWqD57RYl9vGLshVAEoiZv2n6GRk6OFLAUw+HUyO5ZeL/UNGwCjPclIM8WDueXGpaZMRsjbhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838063; c=relaxed/simple;
	bh=xqdCq5jKU4ORzMILrNtu9YOfneH1J2iFlj3zsYmWy4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTQul22TnDXbPEKVQ1gZ4rH9NUdwX5Pl607XVCRwsFPRJD/6jtXQX3lIYI+/60cbccrLga1gpDGEGXgXfyXBNoQVJZA2WjRGSQO+njJchNzVjLRw9K3D+EGTx0IaSanKX5GXCtqg/pH//hDroNxa2S8V8IO2HD7Pe2OqjbCoZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYqyygud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA86BC433C7;
	Thu,  7 Mar 2024 19:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709838062;
	bh=xqdCq5jKU4ORzMILrNtu9YOfneH1J2iFlj3zsYmWy4U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YYqyygudPMviN+nhtYpCH71pOTredcthSYaA3x3x4YyvKbXYJHfcEt3QZXk9UcalH
	 sqsWcBFmCMTgjUFIZQXgGSytO7ASU1oV/+BM2kLnKrgk3XIlrBdfl6TITIlDZMst2r
	 SIWA1xLPygIlDoZ5uXgtsb7p/Z9Z0baVYkeEQ38qvIEuXbWHfBYdfmPxOwZpP08VLD
	 plLbiRQReVXvWsWqt2hAg9tef0Tduk39i+bo88SUGpq74KFd7BUfBRGX0CkNtyNgEq
	 /7S/WybN823vswsIqxKIlqzDj9zOPEF4TTjPnpyWPzr7rmMa3rdWRf6A9QMunA8D3p
	 nXtYbzmVDylxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5E7B3CE0716; Thu,  7 Mar 2024 11:01:02 -0800 (PST)
Date: Thu, 7 Mar 2024 11:01:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
Message-ID: <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com>
 <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>

On Wed, Mar 06, 2024 at 03:42:10PM -0500, Joel Fernandes wrote:
> Hi Ankur,
> 
> On 3/5/2024 3:11 AM, Ankur Arora wrote:
> > 
> > Joel Fernandes <joel@joelfernandes.org> writes:
> > 
> [..]
> >> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
> >> 'voluntary' business because
> >> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
> >> is not about the old voluntary.
> > 
> > What do you think about folding the higher scheduling class preemption logic
> > into preempt=none? As Juri pointed out, prioritization of at least the leftmost
> > deadline task needs to be done for correctness.
> > 
> > (That'll get rid of the current preempt=voluntary model, at least until
> > there's a separate use for it.)
> 
> Yes I am all in support for that. Its less confusing for the user as well, and
> scheduling higher priority class at the next tick for preempt=none sounds good
> to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
> reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
> that is more aggressive, it could be added in the future.

This would be something that happens only after removing cond_resched()
might_sleep() functionality from might_sleep(), correct?

							Thanx, Paul

> >> 2. you are also planning to remove cond_resched()s via this series and leave
> >> it to the scheduler right?
> > 
> > Yeah, under PREEMPT_AUTO, cond_resched() will /almost/ be not there. Gets
> > defined to:
> > 
> > static inline int _cond_resched(void)
> > {
> >         klp_sched_try_switch();
> >         return 0;
> > }
> > 
> > Right now, we need cond_resched() to make timely forward progress while
> > doing live-patching.
> 
> Cool, got it!
> 
> >> Or call it preempt=higher, or something? No one is going to understand the
> >> meaning of voluntary the way it is implied here IMHO.
> > 
> > I don't think there's enough to make it worth adding a new model. For
> > now I'm tending towards moving the correctness parts to preempt=none and
> > making preempt=voluntary identical to preempt=none.
> 
> Got it, sounds good.
> 
> > Thanks for the review.
> 
> Sure! Thanks for this work. Looking forward to the next series,
> 
>  - Joel
> 

