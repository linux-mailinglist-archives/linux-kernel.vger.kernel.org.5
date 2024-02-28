Return-Path: <linux-kernel+bounces-85670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A686B8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918F1B26533
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749897442A;
	Wed, 28 Feb 2024 20:20:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1085E082;
	Wed, 28 Feb 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151634; cv=none; b=j3PX9nVKWIJbRyAaeJc7t8eWw7sf0p5QOs10sxefchb4jon/s7Gl2Ge5tlZYwAa3yeh8u6R4qwQjy9RT0TTHpJ1a+Dyp/ztQuTfIIo6sUGj9JZ+q8tpVfxJ+7PTBSxZym1pic0tMPcPHrV5JXLV9NKFljm6ex1SU0LBrpIxAmO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151634; c=relaxed/simple;
	bh=YAtFYPmb2SAHktjqVXsdcZBKF2SuuMbdEdsoHa6pIlA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDn3YK63wpBA35MQwB/UBSFCyh2zQTLCYoIkCWwbADkxRtaPZIGVXdsNGW5b8OZpnxSQ2f66yMEIc5lXOA1ZwD3cXnL6XkR9Gew4gnqw7zkfFPeDj7zkyO92WlH1+0Kn8VqZsOKte0I1niKOEpHIA3q6HIu6ERErjntN9TF0vXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B551C433F1;
	Wed, 28 Feb 2024 20:20:32 +0000 (UTC)
Date: Wed, 28 Feb 2024 15:22:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ankur Arora
 <ankur.a.arora@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@meta.com
Subject: Re: [PATCH RFC ftrace] Chose RCU Tasks based on TASKS_RCU rather
 than PREEMPTION
Message-ID: <20240228152236.7a4c9eec@gandalf.local.home>
In-Reply-To: <f6507b10-5bb5-4407-bd4d-c547193a5a28@paulmck-laptop>
References: <f6507b10-5bb5-4407-bd4d-c547193a5a28@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 11:38:29 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> The advent of CONFIG_PREEMPT_AUTO, AKA lazy preemption, will mean that
> even kernels built with CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY
> might see the occasional preemption, and that this preemption just might
> happen within a trampoline.
> 
> Therefore, update ftrace_shutdown() to invoke synchronize_rcu_tasks()
> based on CONFIG_TASKS_RCU instead of CONFIG_PREEMPTION.
> 
> Only build tested.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Ankur Arora <ankur.a.arora@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: <linux-trace-kernel@vger.kernel.org>
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 2da4eaa2777d6..c9e6c69cf3446 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3156,7 +3156,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>  		 * synchronize_rcu_tasks() will wait for those tasks to
>  		 * execute and either schedule voluntarily or enter user space.
>  		 */
> -		if (IS_ENABLED(CONFIG_PREEMPTION))
> +		if (IS_ENABLED(CONFIG_TASKS_RCU))
>  			synchronize_rcu_tasks();

What happens if CONFIG_TASKS_RCU is not enabled? Does
synchronize_rcu_tasks() do anything? Or is it just a synchronize_rcu()?

If that's the case, perhaps just remove the if statement and make it:

	synchronize_rcu_tasks();

Not sure an extra synchronize_rcu() will hurt (especially after doing a
synchronize_rcu_tasks_rude() just before hand!

-- Steve

