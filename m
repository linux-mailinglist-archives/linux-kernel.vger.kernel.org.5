Return-Path: <linux-kernel+bounces-49072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BE2846585
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D559F1C24D56
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037CD6ABB;
	Fri,  2 Feb 2024 01:46:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D4BA2C;
	Fri,  2 Feb 2024 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838381; cv=none; b=B/JrEC0XpRf2TQareOA1zXf9fsaEgon4MHQk75sqHqzAJ3M6j4HfOdOhuy9rVs+ga23hCpDzhlWLD32c8ANpwInKKD+dnMHIoj/ErnujbDOKFWu9NzTlwmJChbr1XAMRDSZXqLr8bs57kqoVlkjkJdzRxoE52oAzfODvxFU1RWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838381; c=relaxed/simple;
	bh=zQL/rMBDuoXBWrWx5GoEV+Lp22Ug6QFEu8XoV5dB1T0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNCnw6Y1xilQE01qioVhjAQmkKmjIQMe0hDqyMOnHH4YYplatcWKjuNQJv/7Q64zsQ0gt2DEly05vMtYdJjog0MjxZPoxtgMKYU4ynNmD9DuBoPOgL3oUdSmmn7fTpJ4OKCMafNTvUIVi+1d87RTJ3ITwBKuFX1bPk9HCCHzkDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62967C433C7;
	Fri,  2 Feb 2024 01:46:20 +0000 (UTC)
Date: Thu, 1 Feb 2024 20:46:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
 <kernel@pengutronix.de>
Subject: Re: Boot-time dumping of ftrace fuctiongraph buffer
Message-ID: <20240201204637.2afab2db@gandalf.local.home>
In-Reply-To: <d33e5271-219d-4b8e-be5a-8903219d7fd6@pengutronix.de>
References: <d33e5271-219d-4b8e-be5a-8903219d7fd6@pengutronix.de>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 13:21:37 +0100
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> Hello,
> 
> I semi-regularly debug probe failures. For drivers that use dev_err_probe
> rigorously, this is a quick matter: The probe function records a deferral reason
> and if the deferral persists, deferred_probe_timeout_work_func() will print
> the collected reasons, even if PID 1 is never started.
> 
> For drivers that don't call dev_err_probe, I find myself sometimes doing printf
> debugging inside the probe function.

Is the driver built in or started after init?

> 
> I would like to replace this with the function graph tracer:
> 
>   - record the probe function, configured over kernel command line
>     (The device indefinitely deferring probe is printed to the console,
>      so I know what I am looking for on the next boot)
> 
>   - Dump the function graph trace
> 
>   - See if the last call before (non-devm) cleanup is getting a clock, a GPIO,
>     a regulator or w/e.
> 
> For this to be maximally useful, I need to configure this not only at boot-time,
> but also dump the ftrace buffer at boot time. Probe deferral can hinder the kernel from
> calling init and providing a shell, where I could read /sys/kernel/tracing/trace.

OK so the driver is built in.

> 
> I found following two mechanisms that looked relevant, but seem not to
> do exactly what I want:
> 
>   - tp_printk: seems to be related to trace points only and not usable
>     for the function graph output
> 
>   - dump_on_oops: I don't get an Oops if probe deferral times out, but maybe
>     one could patch the kernel to check a oops_on_probe_deferral or dump_on_probe_deferral
>     kernel command line parameter in deferred_probe_timeout_work_func()?
> 
> 
> Is there existing support that I am missing? Any input on whether this
> would be a welcome feature to have?

Well you can start function_graph on the kernel command line and event
filter on a give function

 ftrace=function_graph function_graph_filter=probe_func

You can add your own ftrace_dump() on some kind of detected error and put
that in the kernel command line. For example RCU has:

  rcupdate.rcu_cpu_stall_ftrace_dump=

Which will do a ftrace dump when a RCU stall is triggered.

-- Steve


