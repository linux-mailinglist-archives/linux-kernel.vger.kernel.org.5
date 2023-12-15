Return-Path: <linux-kernel+bounces-1552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9C6814FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B7F1F24CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5003FE40;
	Fri, 15 Dec 2023 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3wI1NN5+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KkijHHHK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E973FB11
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702667367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdoNIFgiKKjltF4d35fDvG6l9Px6HFW2fOBXd8f2UN8=;
	b=3wI1NN5+yNmVu/AqvyeGuaWppDOdo9WTn+Jgs5VU9aH7NVHOqe3Uz6A2b/pPGygllUbwYI
	H9KXBvtmZbc2FQX7f55UNaQVoXO89KXWzTfLc/y5ju96zCEWSbSwvaESDRW6LEhtEPRU3q
	I1wmjnohlWtsB/z7KBTthUGXi7vLPzke+ea/KWMGPin4yEX0Z+Yf8gQd48lzUGLdjdxQaS
	smCid615OtOT2SWVFOp/WVA3y7d7cUVRCaUCPD5hozPniN+k5343VSTZISj6xgXJAEa8IW
	8lubTGpaQexBEJqFhYL7F1SdNusOLJDXIxY5r1ji81DrNafj9kdz+e8cRIY9bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702667367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdoNIFgiKKjltF4d35fDvG6l9Px6HFW2fOBXd8f2UN8=;
	b=KkijHHHKwrD5Nqa0XioXOX9S/s6w3dr6sFH2uCNTRuln6fZml1iHZThYDuqNiZ8lMXQK0b
	24dc6Ji3xm+brbBQ==
To: Sven Schnelle <svens@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 1/3] entry: move exit to usermode functions to header file
In-Reply-To: <20231205133015.752543-2-svens@linux.ibm.com>
References: <20231205133015.752543-1-svens@linux.ibm.com>
 <20231205133015.752543-2-svens@linux.ibm.com>
Date: Fri, 15 Dec 2023 20:09:27 +0100
Message-ID: <87r0jnmgew.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 05 2023 at 14:30, Sven Schnelle wrote:
> +/**
> + * exit_to_user_mode_loop - do any pending work before leaving to user space
> + */
> +static __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> +							    unsigned long ti_work)
> +{
> +	/*
> +	 * Before returning to user space ensure that all pending work
> +	 * items have been completed.
> +	 */
> +	while (ti_work & EXIT_TO_USER_MODE_WORK) {
> +
> +		local_irq_enable_exit_to_user(ti_work);
> +
> +		if (ti_work & _TIF_NEED_RESCHED)
> +			schedule();
> +
> +		if (ti_work & _TIF_UPROBE)
> +			uprobe_notify_resume(regs);
> +
> +		if (ti_work & _TIF_PATCH_PENDING)
> +			klp_update_patch_state(current);
> +
> +		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> +			arch_do_signal_or_restart(regs);
> +
> +		if (ti_work & _TIF_NOTIFY_RESUME)
> +			resume_user_mode_work(regs);
> +
> +		/* Architecture specific TIF work */
> +		arch_exit_to_user_mode_work(regs, ti_work);
> +
> +		/*
> +		 * Disable interrupts and reevaluate the work flags as they
> +		 * might have changed while interrupts and preemption was
> +		 * enabled above.
> +		 */
> +		local_irq_disable_exit_to_user();
> +
> +		/* Check if any of the above work has queued a deferred wakeup */
> +		tick_nohz_user_enter_prepare();
> +
> +		ti_work = read_thread_flags();
> +	}
> +
> +	/* Return the latest work state for arch_exit_to_user_mode() */
> +	return ti_work;
> +}

I'm not really sure about this part. exit_to_user_mode_loop() is the
slowpath when a TIF work flag is set. I can see the benefit on the
fastpath functions which are way smaller.

Thanks,

        tglx


