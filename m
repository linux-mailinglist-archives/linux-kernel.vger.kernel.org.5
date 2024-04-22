Return-Path: <linux-kernel+bounces-154024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB378AD63A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723AA1F2139E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD71CA85;
	Mon, 22 Apr 2024 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VRyK8Lhk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B8DN4vUU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED151CFBB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819497; cv=none; b=B2C6wYDPGpN8KvK1FewgDVHjpO19ADWKvsWD0lVteeLDe+w2AjPUAChWzoqzgFe/01473fbg/8nuCB/EmAJnj6g91DjXgHBmcLsUOd0Y9ALAANIeV5WlPsQNH7Hbmj0jxtXxNniXCQJYgeZc8OhncVn6m6kQHxVyA+vnmQ0ByO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819497; c=relaxed/simple;
	bh=4VJD8ZY2gnee7zkRLhLEys8Kj6aTMcM2qn6As5itFSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3odW0/W1TX6FpYUAzcSfQPMKZAeqxKr2x5VRxexeFpVSJMo3rrDwfoL/8X5fuZvEsZ5pGX0ycjcpwPLGk3+giB2PVYHNJuYO7gOsiRLceg8LZtgf3lam8LnJB2YmopeBDvRlTD3bM37ti9wKQuxNmD5WjgU9JZ8vU9dfKu8o3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VRyK8Lhk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B8DN4vUU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713819493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSc0hX3DjpOKrj9Bx6Nhif6oXI/bPfYstUjL188V6dE=;
	b=VRyK8Lhkx9+ipQ93AwTZMKAEaSk4AdKVcpIDrTcn3QZzpUPfhTn+WDVIvjczPiav5w7lrE
	lsgGd1cjvB3siLL5NXVrE/Zzk0B68pQrjHdv+1Oa8iqZqsEdF5LYBy4oUS0K37YK4BwKhD
	QMj8eSP64J2z0k+URo57YLGym2hR3nyESs08o5B0KOrZduUeNHuosRKjgeKAnNUJsNOvnH
	QI7qz3FSh4UPI/tzbO/uuWSwQufchwR9pFJGjQq1cMFeoQCiCrJep/Qtg+r1TvIue8QfWv
	T2dMvjezkKkNYO5NyV0l3hqvkVLgIBrvk0lyVHjaQeXfeuqsUUf+FEJeoUB1eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713819493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSc0hX3DjpOKrj9Bx6Nhif6oXI/bPfYstUjL188V6dE=;
	b=B8DN4vUUSiCsYY/2YQh7h+u9FpRBSYHRK0Ei1rdxPcyt+YCIvDie++A66grhuCH9zC/Jmt
	NKa7geSJgKtyUUDA==
To: Dongli Zhang <dongli.zhang@oracle.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev, joe.jin@oracle.com
Subject: Re: [PATCH 1/1] genirq/cpuhotplug: retry with online CPUs on
 irq_do_set_affinity failure
In-Reply-To: <20240419013322.58500-2-dongli.zhang@oracle.com>
References: <20240419013322.58500-1-dongli.zhang@oracle.com>
 <20240419013322.58500-2-dongli.zhang@oracle.com>
Date: Mon, 22 Apr 2024 22:58:10 +0200
Message-ID: <87ttjtunbx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 18 2024 at 18:33, Dongli Zhang wrote:

> When a CPU is offline, its IRQs may migrate to other CPUs. For managed
> IRQs, they are migrated, or shutdown (if all CPUs of the managed IRQ
> affinity are offline). For regular IRQs, there will only be a
> migration.

Please write out interrupts. There is enough space for it and IRQ is
just not a regular word.

> The migrate_one_irq() first uses pending_mask or affinity_mask of the IRQ.
>
> 104         if (irq_fixup_move_pending(desc, true))
> 105                 affinity = irq_desc_get_pending_mask(desc);
> 106         else
> 107                 affinity = irq_data_get_affinity_mask(d);
>
> The migrate_one_irq() may use all online CPUs, if all CPUs in
> pending_mask/affinity_mask are already offline.
>
> 113         if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
> 114                 /*
> 115                  * If the interrupt is managed, then shut it down and leave
> 116                  * the affinity untouched.
> 117                  */
> 118                 if (irqd_affinity_is_managed(d)) {
> 119                         irqd_set_managed_shutdown(d);
> 120                         irq_shutdown_and_deactivate(desc);
> 121                         return false;
> 122                 }
> 123                 affinity = cpu_online_mask;
> 124                 brokeaff = true;
> 125         }

Please don't copy code into the change log. Describe the problem in
text.

> However, there is a corner case. Although some CPUs in
> pending_mask/affinity_mask are still online, they are lack of available
> vectors. If the kernel continues calling irq_do_set_affinity() with those CPUs,
> there will be -ENOSPC error.
>
> This is not reasonable as other online CPUs still have many available
> vectors.

Reasonable is not the question here. It's either correct or not.

> name:   VECTOR
>  size:   0
>  mapped: 529
>  flags:  0x00000103
> Online bitmaps:        7
> Global available:    884
> Global reserved:       6
> Total allocated:     539
> System: 36: 0-19,21,50,128,236,243-244,246-255
>  | CPU | avl | man | mac | act | vectors
>      0   147     0     0   55  32-49,51-87
>      1   147     0     0   55  32-49,51-87
>      2     0     0     0  202  32-49,51-127,129-235

Just ouf of curiousity. How did this end up with CPU2 completely
occupied?

>      4   147     0     0   55  32-49,51-87
>      5   147     0     0   55  32-49,51-87
>      6   148     0     0   54  32-49,51-86
>      7   148     0     0   54  32-49,51-86
>
> This issue should not happen for managed IRQs because the vectors are already
> reserved before CPU hotplug.

Should not? It either does or it does not.

> For regular IRQs, do a re-try with all online
> CPUs if the prior irq_do_set_affinity() is failed with -ENOSPC.
>
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  kernel/irq/cpuhotplug.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> index 1ed2b1739363..d1666a6b73f4 100644
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -130,6 +130,19 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	 * CPU.
>  	 */
>  	err = irq_do_set_affinity(d, affinity, false);
> +
> +	if (err == -ENOSPC &&
> +	    !irqd_affinity_is_managed(d) &&
> +	    affinity != cpu_online_mask) {

This really wants to be a single line conditional.

> +		affinity = cpu_online_mask;
> +		brokeaff = true;
> +
> +		pr_debug("IRQ%u: set affinity failed for %*pbl, re-try with all online CPUs\n",
> +			 d->irq, cpumask_pr_args(affinity));

How is it useful to print cpu_online_mask here?

Thanks,

        tglx

