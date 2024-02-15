Return-Path: <linux-kernel+bounces-66793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD1E856192
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6121F28EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C111153369;
	Thu, 15 Feb 2024 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TxDuQQkr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T7YjQ1yG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035358AAC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996617; cv=none; b=RbO3H/4CQkIaSm71y2dHgAHul93PiFfW6lFnwoL730Nz3i/xVJD2CF78jd4cLD6VTC2oEcoaAh2pGc2tC3ONIC+5JE0S53iKPKi4ICuYSPY/EJevtIdoaLPymOpeIV530/Ett+kf4V7fV6V8c1JqersemwKaSi4pq6Tq5pYQg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996617; c=relaxed/simple;
	bh=/NlBYqsuUjHYJxp06grcn4rt6RtykxvGpioPgpY+MhI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=GHfr9WujI6n0TjklSujYabj+mN/x0TxgH2cyqDdtEkn/z+NmdkD8ztCWHs69B8UySgzKyurk9XE49MpRKxbl9yEB6cut1GNcklfU3NAoNxUlshPr6tXGOzTgAbv1KvQ17DgwZcHzu2nlNPfjFp+WtzqacGyn7GfWkekJ1eKzRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TxDuQQkr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T7YjQ1yG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707996611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=LDdUW45YEQdT3DVHYEZ9F/rzCBdeht+B3hjzNnRk9gI=;
	b=TxDuQQkrKEXCn0vAD9K4IVM6Z7Npr2N9umHZf2ndsdUnnKdTUILChCOGYSf8fR9NcKgfcF
	iG9m5dyKR7U2we7Wv4APCR3CHWCLHmKrjLLl3l46YXpEz3c6I3Lr/KId7ZikKSzCS1pLzU
	xBCJcYOwieDuquXnLPBbNFyF0E/XK0hQP7hnyWbDxAlEHtrzgRhCsO8J0hjk2PpMYNNw1s
	mW7R674zCoI381TdDA1OttYDo1vZFmSsqbkmJn1X9UGHY2afbleLcCPztA/Y87FRmbDc/y
	18TSG6fCWYls9cMn4aEv4fkGkhC0a6uVOBUhItP6bW1PXlZ2nbvu7dpBI0GZ2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707996611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=LDdUW45YEQdT3DVHYEZ9F/rzCBdeht+B3hjzNnRk9gI=;
	b=T7YjQ1yGi4cVq+TLSamAPw1d9+fjIY8btu1NSNXhap86vOAvpYbm/J1jW3805Kwz4yQ0DR
	mOmX6mSr0lQf0fBw==
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
 liusong@linux.alibaba.com
Cc: yaoma@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 2/2] watchdog/softlockup: report the most frequent
 interrupts
In-Reply-To: <20240214021430.87471-3-yaoma@linux.alibaba.com>
Date: Thu, 15 Feb 2024 12:30:11 +0100
Message-ID: <87mss2dkxo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 14 2024 at 10:14, Bitao Hu wrote:
> +static void start_counting_irqs(void)
> +{
> +	int i;
> +	int local_nr_irqs;
> +	struct irq_desc *desc;
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +
> +	if (!counts) {
> +		/*
> +		 * nr_irqs has the potential to grow at runtime. We should read
> +		 * it and store locally to avoid array out-of-bounds access.
> +		 */
> +		local_nr_irqs = nr_irqs;
> +		counts = kcalloc(local_nr_irqs, sizeof(u32), GFP_ATOMIC);

Seriously? The system has a problem and you allocate memory from the
detection code in hard interrupt context?

> +		if (!counts)
> +			return;
> +
> +		for (i = 0; i < local_nr_irqs; i++) {
> +			desc = irq_to_desc(i);
> +			if (!desc)
> +				continue;
> +			counts[i] = desc->kstat_irqs ?
> +				*this_cpu_ptr(desc->kstat_irqs) : 0;
> +		}

This code has absolutely no business to access an interrupt
descriptor. There is an existing interface to retrieve the stats.

Also iterating one by one over the total number of interrupts is a
complete waste as the interrupt number space is sparse.

> +		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
> +			if (irq_counts_sorted[i].irq == -1)
> +				break;
> +
> +			desc = irq_to_desc(irq_counts_sorted[i].irq);
> +			if (desc && desc->action)
> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
> +				       i + 1, irq_counts_sorted[i].counts,
> +				       irq_counts_sorted[i].irq, desc->action->name);

You cannot dereference desc->action here:

    1) It can be NULL'ed between check and dereference.

    2) Both 'action' and 'action->name' can be freed in parallel

And no, you cannot take desc->lock here to prevent this. Stop fiddling
in the internals of interrupt descriptors.


See my reply on V1 how the stats can be done. That neither needs a
memory allocation nor the local_nr_irqs heuristics and just can use
proper interfaces.

Your initialization code then becomes:

	if (!this_cpu_read(snapshot_taken)) {
        	kstat_snapshot_irqs();
        	this_cpu_write(snapshot_taken, true);
        }

and the analysis boils down to:

        u64 cnt, sorted[3] = {};
        unsigned int irq, i;

    	for_each_active_irq(irq) {
        	cnt = kstat_get_irq_since_snapshot(irq);

		if (cnt) {
                     	for (cnt = (cnt << 32) + irq, i = 0; i < 3; i++) {
                		if (cnt > sorted[i])
                        		swap(cnt, sorted[i]);
                	}
		}
	}

Resetting the thing just becomes:

	this_cpu_write(snapshot_taken, false);

No allocation/free, no bound checks, proper abstractions. See?

Thanks,

        tglx

