Return-Path: <linux-kernel+bounces-108236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30712880832
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1AB283DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD65FB8E;
	Tue, 19 Mar 2024 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeaMfJv4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17201D52D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891201; cv=none; b=td61kcswKYqd0rWawAbxyh0tg2BZvgW5tunglVQaq9SPEw0Vw5w5s6Sdcki8pXB2b0dwJbSieGQ7HaBbDZzppwweUW6z30+0D5n42nA3xpMQTpanXs8ToLJ+BApVS0kQc12BUPJLbwOJcfl3Wt+WA5w9R4DeVeRrA+GYa7tITd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891201; c=relaxed/simple;
	bh=4ZxSGXZ55yPyytrthEFK3xMPNqPoa7iYlBUKFWVCHaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gndmZ9DL7Yrq2wvP5Thm8XO51gSzpO4vWEIoreBacdbYyetdj/pzc+bF2+eJKyAL9ywu0yYBZMjIeMyZ9k6Meqr23lgeIF3E41pUrIK1bvbmHHsT7IGO5AyQgGtIuhq9dj1qFyJzMIXHoPVbAxefHh7MxLwW8XC7D4Wc7ejqd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeaMfJv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135C4C433C7;
	Tue, 19 Mar 2024 23:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710891201;
	bh=4ZxSGXZ55yPyytrthEFK3xMPNqPoa7iYlBUKFWVCHaw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TeaMfJv4Q3QXcDAvLdtGyyjEF1IpApNH1P9v8ptg3/bHYdlzN0lQP1OkoqwjuUuDN
	 PPrjwPEE6Sp3Uidmtk6nNMMfJN4GKXZWWFkJ1k8k5jFZwb90dsbjvqkk9KAMYmh7x9
	 srp7QGAEa2U0EF3sjkolO7d2xUSkP8vd3cO+4lo2PK/cH7SW8wPPT/ElsDiFgKPQKw
	 CxHrK2wYTZUd0OGMh2DQI9vIkZNfxw4GyRXOEWn+mtHFqNHXyvYP9fQk1ZtJjHQAwz
	 dUVtBd9eEqLOueJEMVyvwHDc4BxMq2ymr3p+tB7ur+GAKjc69wCCgKs32lsnaAIZ43
	 zXYeoR/UiSg5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EBC2DCE2880; Tue, 19 Mar 2024 16:33:18 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:33:18 -0700
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
Subject: Re: Tasks RCU, ftrace, and trampolines (was: Re: [PATCH 00/30]
 PREEMPT_AUTO: support lazy rescheduling)
Message-ID: <920d4364-52e3-4aaa-9026-0755b65dbf11@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240221131901.69c80c47@gandalf.local.home>
 <8f30ecd8-629b-414e-b6ea-b526b265b592@paulmck-laptop>
 <20240221151157.042c3291@gandalf.local.home>
 <53020731-e9a9-4561-97db-8848c78172c7@paulmck-laptop>
 <ZddtKszRH5Ak5tZ7@FVFF77S0Q05N>
 <1ec4dc29-8868-4d82-8c5e-c17ad025bc22@paulmck-laptop>
 <Zdh8CdrtbL9LgOLG@FVFF77S0Q05N>
 <5641c2f4-3453-4b04-ab0d-db9e5b464b9c@paulmck-laptop>
 <91437fa8-c192-4a71-8073-bdd9c3889926@paulmck-laptop>
 <Zfl6y-NLuwbmyyL8@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfl6y-NLuwbmyyL8@FVFF77S0Q05N>

On Tue, Mar 19, 2024 at 11:45:15AM +0000, Mark Rutland wrote:
> Hi Paul,
> 
> On Fri, Mar 01, 2024 at 05:16:33PM -0800, Paul E. McKenney wrote:
> > The networking NAPI code ends up needing special help to avoid starving
> > Tasks RCU grace periods [1].  I am therefore revisiting trying to make
> > Tasks RCU directly detect trampoline usage, but without quite as much
> > need to identify specific trampolines...
> > 
> > I am putting this information in a Google document for future
> > reference [2].
> > 
> > Thoughts?
> 
> Sorry for the long delay! I've been looking into this general area over the
> last couple of weeks due to the latent bugs I mentioned in:
> 
>   https://lore.kernel.org/lkml/Zenx_Q0UiwMbSAdP@FVFF77S0Q05N/
> 
> I was somewhat hoping that staring at the code for long enough would result in
> an ephinany (and a nice simple-to-backport solution for the latent issues), but
> so far that has eluded me.
> 
> I believe some of those cases will need to use synchronize_rcu_tasks() and we
> might be able to make some structural changes to minimize the number of times
> we'd need to synchronize (e.g. having static ftrace call ops->func from the ops
> pointer, so we can switch ops+func atomically), but those look pretty invasive
> so far.
> 
> I haven't been able to come up with "a precise and completely reliable way to
> determine whether the current preemption occurred within a trampoline". Since
> preemption might occur within a trampoline's callee that eventually returns
> back to the trampoline, I believe that'll either depend on having a reliable
> stacktrace or requiring the trampoline to dynamically register/unregister
> somewhere around calling other functions. That, and we do also care about those
> callees themselves, and it's not just about the trampolines...
> 
> On arm64, we kinda have "permanent trampolines", as our
> DYNAMIC_FTRACE_WILL_CALL_OPS implementation uses a common trampoline. However,
> that will tail-call direct functions (and those could also be directly called
> from ftrace callsites), so we don't have a good way of handling those without a
> change to the direct func calling convention.
> 
> I assume that permanent trampolines wouldn't be an option on architectures
> where trampolines are a spectre mitigation.

Thank you for checking!  I placed a pointer to this email in the document
and updated the relevant sections accordingly.

> Mark.
> 
> > 								Thanx, Paul
> > 
> > [1] https://lore.kernel.org/all/Zd4DXTyCf17lcTfq@debian.debian/
> > [2] https://docs.google.com/document/d/1kZY6AX-AHRIyYQsvUX6WJxS1LsDK4JA2CHuBnpkrR_U/edit?usp=sharing

