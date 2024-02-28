Return-Path: <linux-kernel+bounces-85711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313C86B9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82DE1F25FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9C86278;
	Wed, 28 Feb 2024 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyfdGmBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD786241;
	Wed, 28 Feb 2024 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154965; cv=none; b=IVpxgG1lODtDcaqKk6jHyKua4Cr3npYSlaTKuhU6pFYrIw0pOnjoHYALeOH6rAVIQMdH6QzZ38KgLDxvdzayRK8H23c7Q7r2vAY0bCG/RQHvHdLvoaGE2pIdtBQhgRNTpgW7R1AveHdQSBmmrJDPlY67KC929HC5nH6D/Cl6UQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154965; c=relaxed/simple;
	bh=tLkK7HiFrVQn53zl701UulLerP36hjLPt8SmsC1MkTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhuBxgI40V+cAA2fSKEzUi2atsf3CIkv6AYXOraXIIoN/1HlcdejsxLp5dRmNpysWGeuC0KvbXmyFWIdhmuPreANLU3bMSc3fQq3mnW90toZ5nCCKdKwPsby3LnPWgKzDO3jwzTwgkw+9MDVn+Z84vqzikEu05yjhBmNQqBdKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyfdGmBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F01C433C7;
	Wed, 28 Feb 2024 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709154964;
	bh=tLkK7HiFrVQn53zl701UulLerP36hjLPt8SmsC1MkTk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MyfdGmBeVBLalf5giO0n+MQrpOq+iPNQHM0R+9NNdIYnulltiV2k/RVRaeirND7S/
	 sU58XtolspGI+RdnAPDRwdavPOJsTfJX5tc3rmldx94VMtIsXb93MikONH+uOLi7OI
	 BMaas0mlsjstsLgRoPUOcsXDUV7PlCv+YyJD39bXMpIH/Whg+3l0RVS34tv2bikh38
	 cZPvsenq2CSl/i2jbGlGTMdq1e+/aPKobzYGidKboKXuz3D8lsrVxxFZk6Oa0VuQET
	 5oZBFCCa96atXwe6I2se2DGPNfXyB7We4rtkpc2Ty0c2fBsCTD4/32+xTY3aCfgSk4
	 non/64E3Ik7yg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4A0C3CE03F3; Wed, 28 Feb 2024 13:16:04 -0800 (PST)
Date: Wed, 28 Feb 2024 13:16:04 -0800
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
Message-ID: <b5acdc28-0441-49ca-9e8d-50d6ac40c395@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f6507b10-5bb5-4407-bd4d-c547193a5a28@paulmck-laptop>
 <20240228152236.7a4c9eec@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228152236.7a4c9eec@gandalf.local.home>

On Wed, Feb 28, 2024 at 03:22:36PM -0500, Steven Rostedt wrote:
> On Wed, 28 Feb 2024 11:38:29 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > The advent of CONFIG_PREEMPT_AUTO, AKA lazy preemption, will mean that
> > even kernels built with CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY
> > might see the occasional preemption, and that this preemption just might
> > happen within a trampoline.
> > 
> > Therefore, update ftrace_shutdown() to invoke synchronize_rcu_tasks()
> > based on CONFIG_TASKS_RCU instead of CONFIG_PREEMPTION.
> > 
> > Only build tested.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Ankur Arora <ankur.a.arora@oracle.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: <linux-trace-kernel@vger.kernel.org>
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 2da4eaa2777d6..c9e6c69cf3446 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -3156,7 +3156,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
> >  		 * synchronize_rcu_tasks() will wait for those tasks to
> >  		 * execute and either schedule voluntarily or enter user space.
> >  		 */
> > -		if (IS_ENABLED(CONFIG_PREEMPTION))
> > +		if (IS_ENABLED(CONFIG_TASKS_RCU))
> >  			synchronize_rcu_tasks();
> 
> What happens if CONFIG_TASKS_RCU is not enabled? Does
> synchronize_rcu_tasks() do anything? Or is it just a synchronize_rcu()?

It is just a synchronize_rcu().

> If that's the case, perhaps just remove the if statement and make it:
> 
> 	synchronize_rcu_tasks();
> 
> Not sure an extra synchronize_rcu() will hurt (especially after doing a
> synchronize_rcu_tasks_rude() just before hand!

That would work for me.  If there are no objections, I will make this
change.

							Thanx, Paul

