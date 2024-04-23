Return-Path: <linux-kernel+bounces-154377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9B98ADB62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D25281C10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C919D11184;
	Tue, 23 Apr 2024 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="By5tKlFv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UR4ID+jk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204FE57E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834138; cv=none; b=ej6uBxpZqXTjBhEovn+pzrrxGechxMeuCSfTcfUoM1nSFDo6H9i1c4j7+tQhA+LbHix9UrQ0L9DakScPWcQ5i6DFb/0wgPTUKPVyLbfaKSTlypsp8zqsoFfotICL912YGQQWGv+LY30Um6F/3s14qm3Yy6vODAtAVUqBLO/4Ncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834138; c=relaxed/simple;
	bh=uWpj90WzaivTpwV3wRAddW6tg90OKeaqEUAm2vDazMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eQ8YmxGljNdqJiNwG5V/hdhtQlf1TOLQUVKFmABimv643XEJyUYnSnIeiTX/RHeV6xxG0vBE2AVhcYzWCmYzuch4n1Hlr6fsdP3ovE/NypRalOWrEfW6YKUedTz+rCkOqR0hiFXg2RA4aLGVU9uM7bk2kL/3IJSdojAIu1ctda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=By5tKlFv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UR4ID+jk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713834135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9dZh/zkbcqMryMT4S/DkvJjtqvfHQKiNRTkLprSWL8=;
	b=By5tKlFvILbXDv5rNI7WxSK8H0hWIUveJ/O0Lw1WwMcwMkQKDi1aqBLtFoy31jwX5z+ue5
	NGlk5KA8EPNLP3u74AUWTnqyVAUx0yRqjne1znNISad4/1lmHkd1q91h5Ly0Ln6lfKkgvH
	lX38xr08oQgpwokdIgHWGaPaVwdOYorPX8gjwXujMUNQxA69F3Sa4wI2VTE8vQTQfz5wRv
	nthjKkEUmCioncEkhG7UQrqUhuAVrkgHU0kJaxhg1cNhnnIyJumFXVSYALV9ISb1fOlvwq
	kjKsCd2/0bth3BaJLbstS62O66j3lmTqxw0Slkw4rXjzuWUNrOimVI6qplI9jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713834135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9dZh/zkbcqMryMT4S/DkvJjtqvfHQKiNRTkLprSWL8=;
	b=UR4ID+jkokw2iZXPOchoRTOKnavwHuT/2JbUHVWbEc5ISAK1C990M0U+CFDVSTB/CYfeS5
	UfCkZfZT3CZr1PCg==
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, joe.jin@oracle.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] genirq/cpuhotplug: retry with online CPUs on
 irq_do_set_affinity failure
In-Reply-To: <240e09fb-257f-d32c-64c8-559430b06a2a@oracle.com>
References: <20240419013322.58500-1-dongli.zhang@oracle.com>
 <20240419013322.58500-2-dongli.zhang@oracle.com> <87ttjtunbx.ffs@tglx>
 <240e09fb-257f-d32c-64c8-559430b06a2a@oracle.com>
Date: Tue, 23 Apr 2024 03:02:11 +0200
Message-ID: <87bk60vqlo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 22 2024 at 16:09, Dongli Zhang wrote:
> On 4/22/24 13:58, Thomas Gleixner wrote:
>> On Thu, Apr 18 2024 at 18:33, Dongli Zhang wrote:
> Would you mind suggesting if the below commit message is fine to you?
>
>
> genirq/cpuhotplug: retry with cpu_online_mask when irq_do_set_affinity return
> -ENOSPC
>
> When a CPU goes offline, the interrupts pinned to that CPU are
> re-configured.
>
> Its managed interrupts undergo either migration to other CPUs or shutdown
> if all CPUs listed in the affinity are offline. This patch doesn't affect
> managed interrupts.
>
> For regular interrupts, they are migrated to other selected online CPUs.
> The target CPUs are chosen from either desc->pending_mask (suppose
> CONFIG_GENERIC_PENDING_IRQ) or d->common->affinity (suppose CONFIG_SMP).
> The cpu_online_mask is used as target CPUs only when CPUs in both
> desc->pending_mask and d->common->affinity are offline.
>
> However, there is a bad corner case, when desc->pending_mask or
> d->common->affinity is selected as the target cpumask, but none of their
> CPUs has any available vectors.

Up to here it's fine.

> As a result, an -ENOSPC error happens:
>
>   "IRQ151: set affinity failed(-28)."
>
> This is from the debugfs. The allocation fails although other online CPUs
> (except CPU=2) have many free vectors.

The debugfs output is not really providing more information than the
last sentence. It just occupies space :)

> The steps to reproduce the issue are in [1]. The core idea is:
>
> 1. Create a KVM guest with many virtio-net PCI devices, each configured
> with a very large number of queues/vectors.
>
> 2. Set the affinity of all virtio-net interrupts to "2,3".

That makes absolutely no sense at all. :)

But yes, I can see the non-real world problem with that.

> For regular interrupts, if irq_do_set_affinity() returns -ENOSPC, retry it
> with all online CPUs. The issue does not happen for managed interrupts
> because the vectors are always reserved (in cm->managed_map) before the CPU
> offline operation.
>
> [1]
> https://lore.kernel.org/all/20240419013322.58500-1-dongli.zhang@oracle.com/

The reproduction instructions are just additional information and not
necessarily change log material.

So I'd just say after the above:
> However, there is a bad corner case, when desc->pending_mask or
> d->common->affinity is selected as the target cpumask, but none of their
> CPUs has any available vectors.

   In this case the migration fails and the device interrupt becomes
   stale. This is not any different from the case where the affinity
   mask does not contain any online CPU, but there is no fallback
   operation for this.

   Instead of giving up retry the migration attempt with the online CPU
   mask if the interrupt is not managed as managed interrupts cannot be
   affected by this problem.

Hmm?

> I will change it to a single line.
>
> Would you mind suggesting which is preferred? !cpumask_equal(affinity,
> cpu_online_mask) or (affinity != cpu_online_mask)?

If at all you want !cpumask_subset(cpu_online_mask, affinity), but as
this is a corner case 'affinity != cpu_online_mask' should be good
enough.

Thanks,

        tglx

