Return-Path: <linux-kernel+bounces-100718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA3879C57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2AD1C2194E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B21E53F;
	Tue, 12 Mar 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYOo/XDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF26139580
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272406; cv=none; b=jI5NO9NcMcid/nyZNHQzVaWESUoOrQwf/TerTlQpfees06zlENfsu053YfbnUPH/ob6d0k8PkytdA9EROBRpDoXH6742xzhevK/9UGful4PTM96UyWCED3yb/gTVChAeOubn22AtGieeMAQ12/55/Sn/82n1j5uKHbipfPB7n04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272406; c=relaxed/simple;
	bh=okjnyuV3qRyIwA1q+mq9Bab3HPTae2KkQUI3a1rLtss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTabsiQF7DMt/kNjDLWKoWZtgLQhdYxZ2JE9O6HithBuAf/KHokpDJeNglPFyCe281JOXp6AjWZdTvRsbMMerp3GUpu71tTn9qbFOMhUPR3Xz9Tn/rkL2XadY6gBFVgWCg3TOE/zgKihP+TMgrwOc9AFjOX2WUI5r11gWjc6jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYOo/XDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239BFC433C7;
	Tue, 12 Mar 2024 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710272406;
	bh=okjnyuV3qRyIwA1q+mq9Bab3HPTae2KkQUI3a1rLtss=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SYOo/XDGLPRGLSiEAXvXdVCwEiynDyywJQi0gtFmxp9yTMzEQRGoS1fplrXbbBM7W
	 BCpEG3hibPB1UgJjJzG7sAhAEio8zi5vQNBPhY6E47ECyI/+kh6BlJgPzD/Fd4RxSI
	 5V6VGw8Mmmnh78Ker3frH944PXBiWeqJWjhub9YPL51viy3y8kKr4xvFOU4I4ZEJ4T
	 B3cvXzQqp1kMPHSi2tIGJqHHy3JVB2o/COMuNFEv6+1lgcPz2DjeqMb4Vha5oT4ViV
	 4L+6Bks0FBpapXEqbqCZ1pwfFA/fn7or2yFvBQKeXL8TYsml9BLCAmCUzjjK+h57ft
	 EyMNo2pXETjDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B36E4CE0C4C; Tue, 12 Mar 2024 12:40:05 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:40:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
	bristot@kernel.org, mathieu.desnoyers@efficios.com,
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, rostedt@goodmis.org,
	David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
Message-ID: <d8b67a49-611c-4631-b54f-f20f8146d40f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
 <87plw5pd2x.fsf@oracle.com>
 <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
 <87wmq9mkx2.fsf@oracle.com>
 <36eef8c5-8ecd-4c90-8851-1c2ab342e2bb@paulmck-laptop>
 <87cys0il7x.fsf@oracle.com>
 <CAHk-=whgp+Az+rR4L3oAnmbpSq7QqUEjJUNRpeeqsJ3O+Z8-QQ@mail.gmail.com>
 <85cba8bd-5d2f-4da2-b4f9-93ae7c6a2a45@paulmck-laptop>
 <874jdbpryq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jdbpryq.ffs@tglx>

On Tue, Mar 12, 2024 at 01:14:37PM +0100, Thomas Gleixner wrote:
> On Mon, Mar 11 2024 at 17:03, Paul E. McKenney wrote:
> > On Mon, Mar 11, 2024 at 01:23:09PM -0700, Linus Torvalds wrote:
> >> Because any potential future case is *not* going to be the same
> >> cond_resched() that the current case is anyway. It is going to have
> >> some very different cause.
> >
> > Fair enough, and that approach just means that we will be reaching out
> > to Ankur and Thomas sooner rather than later if something goes sideways
> > latency-wise.  ;-)
> 
> You can't make an omelette without breaking eggs.

Precisely!  ;-)

							Thanx, Paul

