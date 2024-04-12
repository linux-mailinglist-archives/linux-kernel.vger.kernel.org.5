Return-Path: <linux-kernel+bounces-142234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F48A294D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B348B238EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D850243;
	Fri, 12 Apr 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udFcTnE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2748CF0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910459; cv=none; b=N+9vFPDOmMOHRL9uJeQnm3O3/CyakaI88RLWJiltpKTlgXqFXqS/fsfvY1+VqdJrVKJWUbAePdZjbYvMeJXroEPmzF/tH3Fwmui0uZ/nufUVRAcs2nK1asO1MVpI4+THDxcgvWRyUsAsD01y6R6nk/BeT29wlz6LQsDWV5WloSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910459; c=relaxed/simple;
	bh=XwtNlEmgpK3zjZsze08Ldua+UC2fjVVksY9f893xNiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHrNfn6Y1utiZZ8SDIupnOzxXgPMm/ZotFuBJJ2D+ufwYVvrbx7OGv+Sb2TLOKsypXk9SHv1kq9K+FPDlixpUnyrWaSc3ZOPu8Eq9sUnFCAe2AYRmTjlwJ4T1UBjTSPSV+6DuhtXnIUnxaHOZMLt4rixlNzsjFFIFyoBH80nfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udFcTnE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DF7C113CD;
	Fri, 12 Apr 2024 08:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712910458;
	bh=XwtNlEmgpK3zjZsze08Ldua+UC2fjVVksY9f893xNiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=udFcTnE5aQLh8wc5PQbjktn7Dsxg9bHAuIbtj0l41B+4PMoKd1iPZvuLcYCxNWL4z
	 7G+yCyrAHDOgSE8vFIj2XjmOVDvgmnAl+8ZMg2AlVj8O6kj1ueI194HB8XhhGW62ho
	 yCivCOCsLWSjD0zBPN+2XbZ+rJ4F+A8n4jqDP9e/p9h6eYsx/QYFHsg0kE6qfBvMIN
	 5q3AuiesTV5EaRIa6kB7kkUOmAVlw/NaQ5knYNjy0LBCWmhSNtXmUB1c9vrpqYpjeY
	 nXKPqMqbtHMPMR1yVijMbJHZu2zUfo2QWEDWAWR2U1xqv6zlPpreSgJOAhygFNbywe
	 JABZlEoZMJbng==
Message-ID: <8b766da9-61a5-4d26-8634-c2b4b4b87353@kernel.org>
Date: Fri, 12 Apr 2024 10:27:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/6] sched/fair: Fair server interface
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>
References: <cover.1712337227.git.bristot@kernel.org>
 <1abba9e7f47ad4a5dfd8b2dfb59aa607983cdce4.1712337227.git.bristot@kernel.org>
 <20240411144327.GB40213@noisy.programming.kicks-ass.net>
 <e4efd69c-b155-4c13-99c3-9603f5769f93@kernel.org>
 <20240412074316.GF30852@noisy.programming.kicks-ass.net>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240412074316.GF30852@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 09:43, Peter Zijlstra wrote:
> On Thu, Apr 11, 2024 at 05:02:41PM +0200, Daniel Bristot de Oliveira wrote:
>> On 4/11/24 16:43, Peter Zijlstra wrote:
> 
>>> The 'defer' thing is dubious though, I don't suppose anybody would ever
>>> want to actually change that, other than you while poking around at this
>>> code, right?
>>
>> In a setup where all real-time tasks are DL (without fixed-priority tasks (FIFO/RR))
>> the defer = 0 makes more sense because the bandwidth is reserved anyways, and the
>> DL server would have a relatively low prio (long period).
> 
> Tell me more -- how is it better in that case? I would think it wouldn't
> matter much.

I agree, it does not metter much... but, as an exercise...

When we have only FIFO and Fair tasks, we expect the highest priority FIFO task to
run first. In this case, the scheduling latency is a major metric. That is why we
need to defer. This is most of the cases now.

When we have only DL and fair tasks, there should not be much expectation of which task
will have the highest priority because the priority is dynamic (the earliest deadline
changes over time... there is no fixed highest priority task). In this case, the
response time is the major metric. Given that the bandwidth of the server is reserved
and that the default period is long, the dl server would not become the highest
priority task often, naturally running in the spare time. Thus, the server can run
without defer... without breaking the major metric.

Yeah, it is a remote case... and deferring is also valid as the user will likely want
the real DL tasks to run before the fair scheduler... and activate the server only
if near starvation (defer). Also, it is hard to think of a system without FIFO/RR tasks
for now...

So, yeah... it is a remote case. It is better to remove it now... We can add a comment
explaining this possibility for the next generations...

-- Daniel






