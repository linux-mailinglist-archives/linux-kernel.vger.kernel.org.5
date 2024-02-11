Return-Path: <linux-kernel+bounces-60670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F46285083D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB7F283CA8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DC859148;
	Sun, 11 Feb 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RnXUVT8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sXCME+G+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976A36102
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707641559; cv=none; b=vBtDT35ZHDJOIjwBw1JxDQrmmXup1IIO4C7nnNDsnryRFUhHirNqPWLmEs3LOdjwHBEaN2Dd9CfD/1xfEqNH17xboH53OjXdix1Q13fewTeP6lNtImTtaGwmH966gESxi4dZh+CUgP2veEVkRHp2YDwn+Vruu4fRYAIOtyuWl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707641559; c=relaxed/simple;
	bh=5/KJ8UmaTHfcxQ/VvEhJSEbawz0UTFGTW0QdGobkaJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TN2GwCvhtepnMI89ghtXnU28UDwgyfmYnalFdoI484zKv/JTJdG4IS6h+cC9H8Nv+BLF7yy26b0SLDAQB8vIF+eMLkK+mXO3avvTx41/WIX9tQCJiYKPrwFHw99LCQV7H+edlPRp4YDmNXJGrN7Up9FRkvvAcMQIKTvqZDzmorY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RnXUVT8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sXCME+G+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707641556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4KzbqLIbkjVoM79cJzW6n/jxJ6bg7hc4WdupSvPxOpc=;
	b=4RnXUVT8Emnznx0ytc+B8ktt+yIwp0gr1mg0OJLAlsyjQG7c82YakL1MLDXT0mJVV8Kr/f
	zvBKIdi5eZdUSEwknlvVgNdcHCiwanIO22O2RCSJhaO+CcvQfnuoR/qXFVwOlgOcnq2hjg
	h/XK1GpuvqC7Udm14TngaCM1JmQbYvpxUPldQVEsGFAhfFuLwrur4wgcnBmtKHjsmZS3bD
	BAr7zB4qrK8uruI0YiCcv4r/d1cfeBWkeev6SfpXAw0b0vKP6eyOWx5db49rKMdLR7EO6q
	xvy7QVkOS7QxnuktduSf+BfmpVpi6txhN30UkTaaRFsVrEgjK/PEGtgqb1guCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707641556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4KzbqLIbkjVoM79cJzW6n/jxJ6bg7hc4WdupSvPxOpc=;
	b=sXCME+G+YzFfbZvm/QEgHoX9qdst184QXoCEx8zjK8w5ScUiYPU5ZMwkpGuFSvX2UyzGrB
	OwBfQ74paZQMzfCw==
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>, Leonardo Bras <leobras@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch 04/12] clockevent unbind: use smp_call_func_single_fail
In-Reply-To: <ZcN8zA4WaLx7c3qy@tpad>
References: <20240206184911.248214633@redhat.com>
 <20240206185709.928420669@redhat.com> <87jzngmqsw.ffs@tglx>
 <ZcN8zA4WaLx7c3qy@tpad>
Date: Sun, 11 Feb 2024 09:52:35 +0100
Message-ID: <87plx3l6wc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 07 2024 at 09:51, Marcelo Tosatti wrote:
> On Wed, Feb 07, 2024 at 12:55:59PM +0100, Thomas Gleixner wrote:
>
> OK, so the problem is the following: due to software complexity, one is
> often not aware of all operations that might take place.

The problem is that people throw random crap on their systems and avoid
proper system engineering and then complain that their realtime
constraints are violated. So you are proliferating bad engineering
practices and encourage people not to care.

> Now think of all possible paths, from userspace, that lead to kernel
> code that ends up in smp_call_function_* variants (or other functions
> that cause IPIs to isolated CPUs).

So you need to analyze every possible code path and interface and add
your magic functions there after figuring out whether that's valid or
not.

> The alternative, from blocking this in the kernel, would be to validate all 
> userspace software involved in your application, to ensure it won't end
> up in the kernel sending IPIs. Which is impractical, isnt it ?

It's absolutely not impractical. It's part of proper system
engineering. The wet dream that you can run random docker containers and
everything works magically is just a wet dream.

> (or rather, with such option in the kernel, it would be possible to run 
> applications which have not been validated, since the kernel would fail
> the operation that results in IPI to isolated CPU).

That's a fallacy because you _cannot_ define with a single CPU mask
which interface is valid in a particular configuration to end up with an
IPI and which one is not. There are legitimate reasons in realtime or
latency constraint systems to invoke selective functionality which
interferes with the overall system constraints.

How do you cover that with your magic CPU mask? You can't.

Aside of that there is a decent chance that you are subtly breaking user
space that way. Just look at that hwmon/coretemp commit you pointed to:

  "Temperature information from the housekeeping cores should be
   sufficient to infer die temperature."

That's just wishful thinking for various reasons:

  - The die temperature on larger packages is not evenly distributed and
    you can run into situations where the housekeeping cores are sitting
    "far" enough away from the worker core which creates the heat spot

  - Some monitoring applications just stop to work when they can't read
    the full data set, which means that they break subtly and you can
    infer exactly nothing.

> So the idea would be an additional "isolation mode", which when enabled, 
> would disallow the IPIs. Its still possible for root user to disable
> this mode, and retry the operation.
>
> So lets say i want to read MSRs on a given CPU, as root.
>
> You'd have to: 
>
> 1) readmsr on given CPU (returns -EPERM or whatever), since the
> "block interference" mode is enabled for that CPU.
>
> 2) Disable that CPU in the block interference cpumask.
>
> 3) readmsr on the given CPU (success).
>
> 4) Re-enable CPU in block interference cpumask, if desired.

That's just wrong. Why?

Once you enable it just to read the MSR you enable the operation for
_ALL_ other non-validated crap too. So while the single MSR read might
be OK under certain circumstances the fact that you open up a window for
all other interfaces to do far more interfering operations is a red
flag.

This whole thing is a really badly defined policy mechanism of very
dubious value.

Thanks,

        tglx

