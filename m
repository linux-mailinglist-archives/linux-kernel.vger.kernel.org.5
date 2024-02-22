Return-Path: <linux-kernel+bounces-76587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14E85F99E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409351C23DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D734135401;
	Thu, 22 Feb 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJ/aRi9G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZiRjwR+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9712FF74;
	Thu, 22 Feb 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608183; cv=none; b=Nwl1Ejh1B5ZivsPScwLCuf7xxAlVAQcA+s42OcB3N2AZR/1QJMy1ddi6sQsKQ1SHVWrv0wfLM18bVK5mORtUtZrvxiLBtanMSLTKkfShBL6CbDvFMFfgocRQenXDPNmtD7rGWS0kbXu3W+6PPYKnQ2xYYtKFFovsj7p7Dpc1NEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608183; c=relaxed/simple;
	bh=QwJXV1RkcSLVuEf5+mwh8xc/Wk/KLMXNQAhGRjILcLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iphpEmq0ggzkCB6dz0OvjCsoL5Hjdx/3lz5R0zUK8G94ViLlkeyTMws990bXpbXGFO6k1/CwtDwrI2DNd9FreMAJAQisMXCvZAUfnmHcofMN2RYRp2WXvrhQy2n5mqk3IdcLDdQtzMceupziH1F3L/Xuc/eyNq0/eYtVWiYMHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJ/aRi9G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZiRjwR+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708608179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vf5dvD6c9m5aF5XZpNNQqDW+xIF8f6dZ9wpf3QuuKjg=;
	b=xJ/aRi9Gob5dP6fvvpiv3zn7PZE9HFQr94NPdSMrY4AzE6pDg8n0L+2vR0M28Mo6inozlm
	XtuNX5M3axqYfryju9DgSEnvEXVE8HbWSCW/X4tdKvRzb6QEYoP8uqntJOm2OYc4HfJHtu
	xjt+aZhGw9XUSr9MHEphDXnvi+KLMBg7e+0iJUrQYVR2aOcGTuzr2WEcsU/7L8er0u1dzu
	/sHlTd81mVhPurNKGTm+yhiGi9F6qwX0XoJWzrrIsFRuAMb9Ij67/wYRJFJn10aOGH+kNc
	bybA7AJsephj7eHNyHWkHzGKRePVN8g7nRDE99IYCUJACRsns9er6rQ62nK7Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708608179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vf5dvD6c9m5aF5XZpNNQqDW+xIF8f6dZ9wpf3QuuKjg=;
	b=vZiRjwR+O+KEUdSoAq9a5bC4DugVLuX4J9+mRlpoGBM0/Mb5+vfuYr4/7HNl5mbun2GsY7
	N0SXEJdk6CjzaIDw==
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, liusong@linux.alibaba.com, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 yaoma@linux.alibaba.com
Subject: Re: [PATCHv9 2/3] irq: use a struct for the kstat_irqs in the
 interrupt descriptor
In-Reply-To: <20240222093420.13956-3-yaoma@linux.alibaba.com>
References: <20240222093420.13956-1-yaoma@linux.alibaba.com>
 <20240222093420.13956-3-yaoma@linux.alibaba.com>
Date: Thu, 22 Feb 2024 14:22:59 +0100
Message-ID: <87jzmwfxak.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 22 2024 at 17:34, Bitao Hu wrote:

First of all the subsystem prefix is 'genirq:'. 'git log kernel/irq/'
gives you a pretty good hint. It's documented....

Secondly the subject line does not match what this patch is about. It's
not about using a struct, it's about providing a snapshot mechanism, no?

> The current implementation uses an int for the kstat_irqs in the
> interrupt descriptor.
>
> However, we need to know the number of interrupts which happened
> since softlockup detection took a snapshot in order to analyze
> the problem caused by an interrupt storm.
>
> Replacing an int with a struct and providing sensible interfaces
> for the watchdog code can keep it self contained to the interrupt
> core code.

So something like this makes a useful change log for this:

 Subject: genirq: Provide a snapshot mechanism for interrupt statistics

 The soft lockup detector lacks a mechanism to identify interrupt storms
 as root cause of a lockup. To enable this the detector needs a
 mechanism to snapshot the interrupt count statistics on a CPU when the
 detector observes a potential lockup scenario and compare that against
 the interrupt count when it warns about the lockup later on. The number
 of interrupts in that period give a hint whether the lockup might be
 caused by an interrupt storm.

 Instead of having extra storage in the lockup detector and accessing
 the internals of the interrupt descriptor directly, convert the per CPU
 irq_desc::kstat_irq member to a data structure which contains the
 counter plus a snapshot member and provide interfaces to take a
 snapshot of all interrupts on the current CPU and to retrieve the delta
 of a specific interrupt later on.

Hmm?

> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>

Interesting. You fully authored the patch?

That's not how it works. You cannot take work from others and claim that
it is yours. The minimal courtesy is to add a 'Originally-by:' tag.

> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index 623b8136e9af..3ad40cf30c66 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -488,18 +488,15 @@ int show_interrupts(struct seq_file *p, void *v)
>  	if (!desc || irq_settings_is_hidden(desc))
>  		goto outsparse;
>  
> -	if (desc->kstat_irqs) {
> -		for_each_online_cpu(j)
> -			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
> -	}
> +	if (desc->kstat_irqs)
> +		any_count = data_race(desc->tot_count);

This is an unrelated change and needs to be split out into a separate
patch with a proper changelog which explains why this is equivalent.
  
Thanks,

        tglx

