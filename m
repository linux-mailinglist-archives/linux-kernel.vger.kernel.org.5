Return-Path: <linux-kernel+bounces-89077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E430A86EA3F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003751C22446
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474483C47A;
	Fri,  1 Mar 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cry3iSVZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C13182B9;
	Fri,  1 Mar 2024 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324711; cv=none; b=p6HVQkPKuOODCpnVYawsH2G/VPPSNSUL5JdD1/pg0ZrbzIupcvZvMKNDLagiRbxKoCFSWrWH63KUq4oswgPqsM3ARznpUHlmSxTis/17CXEyArwi6mA6yWZYL7K5youWDycHSGfh+l9ZAm+ig2kF5g1WP8Bq5l1oK/6WHEZGpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324711; c=relaxed/simple;
	bh=NbJWYIXhuWsSLKTuuf57NsT0HeUXNYUm+t2wP6ldURc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXQ/qfetiuXkjeDpnnA2bfSe+gUg5kP76AtDKj+DaFQFar28s/DbyYzneSglhMdZx81gCaBNuC+K48vNoTs82OmEP/T3KI9E02S38siZnJ+fVkS49WgfY7b77URpnAKmb/aSZ2OLID9FPVyN8D+wNgjcfZQeSn6XhmCnE1ciE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cry3iSVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996BDC433F1;
	Fri,  1 Mar 2024 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324710;
	bh=NbJWYIXhuWsSLKTuuf57NsT0HeUXNYUm+t2wP6ldURc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Cry3iSVZDK2HW9ERSNepVknZ0sfy0csOD8tA92/cMob9VuXSTQym6E6adCN8us2MG
	 BpozCW6Tz9Wg89v2c8H0mQXbfMB/eYwE/Nzl8+Aa2jPhWJJSw9n/imZA3B+t02a4ML
	 SdTyQ4eFMwyr9nHcLXAb99LeI0IDAA9eYjSP9AJOeXf2tVAby/Fkh7IVRZYEEYksgd
	 CYzUSEcj8wD5donYnvRkX9dlwDklnG0U8Cqg4/eQ6oqf2iXYFwIqP7XD2asfiBbKrZ
	 EvmkTP0FZ0//KQT68oFlDETuBfKNM+acU2HVKtgygyKC6QHMFCm5je/KNb6y+teiLv
	 ES4L3cPkZ4NFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F74ACE140C; Fri,  1 Mar 2024 12:25:10 -0800 (PST)
Date: Fri, 1 Mar 2024 12:25:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@meta.com
Subject: Re: [PATCH RFC ftrace] Chose RCU Tasks based on TASKS_RCU rather
 than PREEMPTION
Message-ID: <2835d5ea-0396-49f6-88fb-be49cb998cc5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f6507b10-5bb5-4407-bd4d-c547193a5a28@paulmck-laptop>
 <20240228152236.7a4c9eec@gandalf.local.home>
 <b5acdc28-0441-49ca-9e8d-50d6ac40c395@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5acdc28-0441-49ca-9e8d-50d6ac40c395@paulmck-laptop>

On Wed, Feb 28, 2024 at 01:16:04PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 28, 2024 at 03:22:36PM -0500, Steven Rostedt wrote:
> > On Wed, 28 Feb 2024 11:38:29 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > The advent of CONFIG_PREEMPT_AUTO, AKA lazy preemption, will mean that
> > > even kernels built with CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY
> > > might see the occasional preemption, and that this preemption just might
> > > happen within a trampoline.
> > > 
> > > Therefore, update ftrace_shutdown() to invoke synchronize_rcu_tasks()
> > > based on CONFIG_TASKS_RCU instead of CONFIG_PREEMPTION.
> > > 
> > > Only build tested.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Ankur Arora <ankur.a.arora@oracle.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: <linux-trace-kernel@vger.kernel.org>
> > > 
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index 2da4eaa2777d6..c9e6c69cf3446 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -3156,7 +3156,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
> > >  		 * synchronize_rcu_tasks() will wait for those tasks to
> > >  		 * execute and either schedule voluntarily or enter user space.
> > >  		 */
> > > -		if (IS_ENABLED(CONFIG_PREEMPTION))
> > > +		if (IS_ENABLED(CONFIG_TASKS_RCU))
> > >  			synchronize_rcu_tasks();
> > 
> > What happens if CONFIG_TASKS_RCU is not enabled? Does
> > synchronize_rcu_tasks() do anything? Or is it just a synchronize_rcu()?
> 
> It is just a synchronize_rcu().
> 
> > If that's the case, perhaps just remove the if statement and make it:
> > 
> > 	synchronize_rcu_tasks();
> > 
> > Not sure an extra synchronize_rcu() will hurt (especially after doing a
> > synchronize_rcu_tasks_rude() just before hand!
> 
> That would work for me.  If there are no objections, I will make this
> change.

But I did check the latency of synchronize_rcu_tasks_rude() (about 100ms)
and synchronize_rcu() (about 20ms).  This is on a 80-hardware-thread
x86 system that is being flooded with calls to one or the other of
these two functions, but is otherwise idle.  So adding that unnecessary
synchronize_rcu() adds about 20% to that synchronization delay.

Which might still be OK, but...  In the immortal words of MS-DOS,
"Are you sure?".  ;-)

							Thanx, Paul

