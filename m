Return-Path: <linux-kernel+bounces-107480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC487FD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEBD1C21AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9177F471;
	Tue, 19 Mar 2024 11:45:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A51CD13
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848744; cv=none; b=hhdkHWOO1Qb6Bvi5JB5HEtyqQL1wCOWfekhU/4qclKt+jtdWViq+3ZreUbBRhqdk+Lt7JKAKHQ7NjBmcGKBcyI85LOUK1qpL4e314gq/YZVYqhLQz59j3Di/NPYNUFXaBrM4TVXoRQOWNU92gIQrM6QkHh+OpPXdpw/ZoKKRHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848744; c=relaxed/simple;
	bh=+pqyA3fJ6tcbDlL7z/QlW0zjx2SAHzb+A9tHoI6tAZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZA+AhL6dVXgNHK9I94Yr7Awt8//ltKkCaHxeIKQniDy97UwelcCnR+buCSN9dk1t74YChZI/EMXYw1qpaGuAz5SRkAIu7g3m3yjnRFyqXHZYK//viR1DdUvDW3L1UJ09WqDcNjfyWxK9bl6purnGAM7FTjom117HS+u35vWilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B7A2106F;
	Tue, 19 Mar 2024 04:46:14 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66DDA3F67D;
	Tue, 19 Mar 2024 04:45:34 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:45:15 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Subject: Tasks RCU, ftrace, and trampolines (was: Re: [PATCH 00/30]
 PREEMPT_AUTO: support lazy rescheduling)
Message-ID: <Zfl6y-NLuwbmyyL8@FVFF77S0Q05N>
References: <2b735ba4-8081-4ddb-9397-4fe83143d97f@paulmck-laptop>
 <20240221131901.69c80c47@gandalf.local.home>
 <8f30ecd8-629b-414e-b6ea-b526b265b592@paulmck-laptop>
 <20240221151157.042c3291@gandalf.local.home>
 <53020731-e9a9-4561-97db-8848c78172c7@paulmck-laptop>
 <ZddtKszRH5Ak5tZ7@FVFF77S0Q05N>
 <1ec4dc29-8868-4d82-8c5e-c17ad025bc22@paulmck-laptop>
 <Zdh8CdrtbL9LgOLG@FVFF77S0Q05N>
 <5641c2f4-3453-4b04-ab0d-db9e5b464b9c@paulmck-laptop>
 <91437fa8-c192-4a71-8073-bdd9c3889926@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91437fa8-c192-4a71-8073-bdd9c3889926@paulmck-laptop>

Hi Paul,

On Fri, Mar 01, 2024 at 05:16:33PM -0800, Paul E. McKenney wrote:
> The networking NAPI code ends up needing special help to avoid starving
> Tasks RCU grace periods [1].  I am therefore revisiting trying to make
> Tasks RCU directly detect trampoline usage, but without quite as much
> need to identify specific trampolines...
> 
> I am putting this information in a Google document for future
> reference [2].
> 
> Thoughts?

Sorry for the long delay! I've been looking into this general area over the
last couple of weeks due to the latent bugs I mentioned in:

  https://lore.kernel.org/lkml/Zenx_Q0UiwMbSAdP@FVFF77S0Q05N/

I was somewhat hoping that staring at the code for long enough would result in
an ephinany (and a nice simple-to-backport solution for the latent issues), but
so far that has eluded me.

I believe some of those cases will need to use synchronize_rcu_tasks() and we
might be able to make some structural changes to minimize the number of times
we'd need to synchronize (e.g. having static ftrace call ops->func from the ops
pointer, so we can switch ops+func atomically), but those look pretty invasive
so far.

I haven't been able to come up with "a precise and completely reliable way to
determine whether the current preemption occurred within a trampoline". Since
preemption might occur within a trampoline's callee that eventually returns
back to the trampoline, I believe that'll either depend on having a reliable
stacktrace or requiring the trampoline to dynamically register/unregister
somewhere around calling other functions. That, and we do also care about those
callees themselves, and it's not just about the trampolines...

On arm64, we kinda have "permanent trampolines", as our
DYNAMIC_FTRACE_WILL_CALL_OPS implementation uses a common trampoline. However,
that will tail-call direct functions (and those could also be directly called
from ftrace callsites), so we don't have a good way of handling those without a
change to the direct func calling convention.

I assume that permanent trampolines wouldn't be an option on architectures
where trampolines are a spectre mitigation.

Mark.

> 								Thanx, Paul
> 
> [1] https://lore.kernel.org/all/Zd4DXTyCf17lcTfq@debian.debian/
> [2] https://docs.google.com/document/d/1kZY6AX-AHRIyYQsvUX6WJxS1LsDK4JA2CHuBnpkrR_U/edit?usp=sharing

