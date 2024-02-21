Return-Path: <linux-kernel+bounces-75610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D068985EBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C68B24753
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFC3F8C8;
	Wed, 21 Feb 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdu06XWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98753C491
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555507; cv=none; b=BzpkwINa0LY13P6CZnwC9YJJPj0IivL50x9qsMsUbAb79D4Ur/1J8RMgRMS3JrERYeFbtRlZVrQRE3a3spyfwFupb9+D/msIWvHGBaQQhRH/UyZmdeo8yJF65nKGtvUeo7j/hDxOa6mp5VEM2q37jP3xImOPxNsUh7E3KzKrsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555507; c=relaxed/simple;
	bh=N5qsqlaM6wIWKBrbuRB67nhnIYO7bZ0mzk6l+tLJOdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqPU1xkJtBDi2pKLKkjMcROnFlnsLQ3plgiQfCPTj11xEoEIa6mxs2e5wJ7FMDhXziq4YP8s45V2naJBc5JjyIE/RjIY4AdpTwo0+A0RIUT+HzSITyOy9hRp8fkLk/uo9BKZPB5GCu6uzWdlXoRICnA/FlsVIR3Kf3ZfIAovarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdu06XWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48461C433C7;
	Wed, 21 Feb 2024 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708555506;
	bh=N5qsqlaM6wIWKBrbuRB67nhnIYO7bZ0mzk6l+tLJOdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fdu06XWz4dMTMbGXS2rN56c+se4iGqzxyS45CO7VnTqJcYpMvPelGT7J7ghXB1Qx6
	 GueVGgGpGmUTqxge5bEJzk7WdOloQble4z/n9EktLC7khJ/d7FUzdmJd2uxktiffsA
	 0LcV1ZBCF1xQhGOt3aPL3e/NP4RD4T+S/Nm5D0hXJqxDEWUlJEjYTPxsU65mZY5R0t
	 pQpI40S4uQx9UMMeWGZFORASLV5GnoLw+2fVAyvJp4yCdVXnBkaNd4+ad4DDRysACd
	 lSwHGLWqZeNcbzdiDT5KZZgTcgO0gYk2HMx8GRSGeCh2/faxOIMmLHtU5hmYfFB9yZ
	 lS2SD8LIUiYyA==
Date: Wed, 21 Feb 2024 23:45:03 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v11 18/20] timers: Implement the hierarchical pull model
Message-ID: <ZdZ87whmpul8xIBI@pavilion.home>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
 <20240221090548.36600-19-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221090548.36600-19-anna-maria@linutronix.de>

Le Wed, Feb 21, 2024 at 10:05:46AM +0100, Anna-Maria Behnsen a écrit :
> Placing timers at enqueue time on a target CPU based on dubious heuristics
> does not make any sense:
> 
>  1) Most timer wheel timers are canceled or rearmed before they expire.
> 
>  2) The heuristics to predict which CPU will be busy when the timer expires
>     are wrong by definition.
> 
> So placing the timers at enqueue wastes precious cycles.
> 
> The proper solution to this problem is to always queue the timers on the
> local CPU and allow the non pinned timers to be pulled onto a busy CPU at
> expiry time.
> 
> Therefore split the timer storage into local pinned and global timers:
> Local pinned timers are always expired on the CPU on which they have been
> queued. Global timers can be expired on any CPU.
> 
> As long as a CPU is busy it expires both local and global timers. When a
> CPU goes idle it arms for the first expiring local timer. If the first
> expiring pinned (local) timer is before the first expiring movable timer,
> then no action is required because the CPU will wake up before the first
> movable timer expires. If the first expiring movable timer is before the
> first expiring pinned (local) timer, then this timer is queued into an idle
> timerqueue and eventually expired by another active CPU.
> 
> To avoid global locking the timerqueues are implemented as a hierarchy. The
> lowest level of the hierarchy holds the CPUs. The CPUs are associated to
> groups of 8, which are separated per node. If more than one CPU group
> exist, then a second level in the hierarchy collects the groups. Depending
> on the size of the system more than 2 levels are required. Each group has a
> "migrator" which checks the timerqueue during the tick for remote expirable
> timers.
> 
> If the last CPU in a group goes idle it reports the first expiring event in
> the group up to the next group(s) in the hierarchy. If the last CPU goes
> idle it arms its timer for the first system wide expiring timer to ensure
> that no timer event is missed.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Though I must confess I only had a shallow look at group creation (init_group,
get_group, connect_child_parent, setup_groups, add_cpu, and tmigr_init). But for
the rest, I'm running out of bad scenarios. Time for the rest of the world to
find them!

Thanks for the hard work!

