Return-Path: <linux-kernel+bounces-96019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4799875629
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FD01C2143C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9CC133406;
	Thu,  7 Mar 2024 18:34:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20C12F5A5;
	Thu,  7 Mar 2024 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836459; cv=none; b=XzcN4qiTPH4EVAAEuM/5uBm5m77w/hbh5j2sozz42PVybTOm6IWY1NGQ2G/oeF34QBLA6J3yH9+7JwfmT1cB7PNnVygtToGu+eXXYyBbCsW54tk+RIF5EuAyuEUiERqKjsApF+ODwODap6H4b0ZKICw4FJuD1gndN0G7v5ZyUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836459; c=relaxed/simple;
	bh=c3690T2hw5jOKdAJMsouSoyRHA+UMx5AeSXSfJrDW4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUYas+iKer7dSbBu9w/vQQ84q67AOKMmn7p6up/ZMqdKT/StohFnf08eG888qKC19eqgtizxaAHu7vybEA7wU4Ui9//fSSzsHnv8rdRjJOby93gxSYH8YhAldR9XT4LX4b9C5Dgn7FN1Nu3x3eCuhNFXJChc/veyxLHecCq8Rq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835011FB;
	Thu,  7 Mar 2024 10:34:52 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3450A3F762;
	Thu,  7 Mar 2024 10:34:14 -0800 (PST)
Date: Thu, 7 Mar 2024 18:34:11 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <ZeoIo1dOW11STQHb@FVFF77S0Q05N>
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
 <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
 <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
 <f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
 <CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
 <fcaf6cad-9959-4b6d-a6e4-05ae1b2fabdc@joelfernandes.org>
 <Zenx_Q0UiwMbSAdP@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zenx_Q0UiwMbSAdP@FVFF77S0Q05N>

On Thu, Mar 07, 2024 at 04:57:33PM +0000, Mark Rutland wrote:
> On Mon, Mar 04, 2024 at 04:16:01AM -0500, Joel Fernandes wrote:
> > On 3/2/2024 8:01 PM, Joel Fernandes wrote:
> > Case 1: For !CONFIG_DYNAMIC_FTRACE update of ftrace_trace_function
> > 
> > This config is itself expected to be slow. However seeing what it does, it is
> > trying to make sure the global function pointer "ftrace_trace_function" is
> > updated and any readers of that pointers would have finished reading it. I don't
> > personally think preemption has to be disabled across the entirety of the
> > section that calls into this function. So sensitivity to preempt disabling
> > should not be relevant for this case IMO, but lets see if ftrace folks disagree
> > (on CC). It has more to do with, any callers of this function pointer are no
> > longer calling into the old function.
> 
> I've been looking into this case for the last couple of days, and the short
> story is that the existing code is broken today for PREEMPT_FULL, and the code
> for CONFIG_DYNAMIC_FTRACE=y is similarly broken. A number of architectures have
> also implemented the entry assembly incorrectly...

> I believe our options are:
> 
> * Avoid the mismatch by construction:
> 
>   - On architectures with trampolines, we could ensure that the list_ops gets
>     its own trampoline and that we *always* use a trampoline, never using a
>     common ftrace_caller. When we switch callers from one trampoline to another
>     they'd atomically get the new func+ops.
> 
>     I reckon that might be a good option for x86-64?
> 
>   - On architectures without trampolines we could 
>     require that that the ftrace_caller 
>     loads ops->func from the ops pointer.
>     
>     That'd mean removing the 'ftrace_trace_function' pointer and removing
>     patching of the call to the trace function (but the actual tracee callsites
>     would still be patched).
> 
>     I'd be in favour of this for arm64 since that matches the way CALL_OPS
>     works; the only difference is we'd load a global ops pointer rather than a
>     per-callsite ops pointer.
> 
> * Use rcu_tasks_trace to synchronize updates?

Having acquainted myself with the RCU flavours, I think the RCU Tasks Trace
suggestion wouldn't help, but *some* flavour of RCU might give us what we need.

That said, my preference is the "avoid the mismatch by construction" camp, as
even if we need to wait for uses of the old func+ops to finish, we'd have fewer
transitions (and consequently less patching) if we have:

	switch_to_new_ops();
	wait_for_old_ops_usage_to_finish();

.. rather than:

	switch_to_list_func();
	wait_for_old_ops_usage_to_finish();
	switch_to_new_ops();
	ensure_new_ops_are_visible();
	switch_to_new_func();

Mark.

