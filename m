Return-Path: <linux-kernel+bounces-75556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7985EB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D741C21E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A751272D6;
	Wed, 21 Feb 2024 21:36:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E62126F37
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551414; cv=none; b=bjo6hu3YRU+O6zloiGiBgw0eGc1+JKBEggPp48+m/9yqMA1G0Y5g/FpFg1aYo09rT3rzlv46VIbsGf0ltWtHeAfl2BHog/LnsFdXX9zjPIXjeUe+eI+1hMI8jvrX+wEyvvwRyefwcu+tEX2iAxcrYf9I8MXyYXk9mv69psOayR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551414; c=relaxed/simple;
	bh=0RWRYjgzZ8namkUbz7x0brecXpRx2iB3QKzERWdrecE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rF49PlUFTsNQgViU0YXMMGszuiwMa62EiqP8UtPIPsnLFiXMLXAnqUWBB3LCnii5Qptwy4ZcAb40Skc1I1SOkKh6DgpLM7KUO5B5wv5sJRI8wfdiHsZ3u+lhbFpUD5NBWdtogrto4SvKwT3e6KChSWJmY95yVL8MT0a2UskIgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D08C433F1;
	Wed, 21 Feb 2024 21:36:50 +0000 (UTC)
Date: Wed, 21 Feb 2024 16:38:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
 richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 23/30] sched/fair: handle tick expiry under lazy
 preemption
Message-ID: <20240221163838.780caaa9@gandalf.local.home>
In-Reply-To: <20240213055554.1802415-24-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
	<20240213055554.1802415-24-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 21:55:47 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> The default policy for lazy scheduling is to schedule in exit-to-user,
> assuming that would happen within the remaining time quanta of the
> task.
> 
> However, that runs into the 'hog' problem -- the target task might
> be running in the kernel and might not relinquish CPU on its own.
> 
> Handle that by upgrading the ignored tif_resched(NR_lazy) bit to
> tif_resched(NR_now) at the next tick.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> 
> ---
> Note:
>   Instead of special casing the tick, it might be simpler to always
>   do the upgrade on the second resched_curr().
> 
>   The theoretical problem with doing that is that the current
>   approach deterministically provides a well-defined extra unit of
>   time. Going with a second resched_curr() might mean that the
>   amount of extra time the task gets depends on the vagaries of
>   the incoming resched_curr() (which is fine if it's mostly from
>   the tick; not fine if we could get it due to other reasons.)
> 
>   Practically, both performed equally well in my tests.
> 
>   Thoughts?

I personally prefer the determinism of using the tick to force the resched.

-- Steve

