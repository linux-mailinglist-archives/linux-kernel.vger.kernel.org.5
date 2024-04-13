Return-Path: <linux-kernel+bounces-143703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 930988A3C6F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AB71F2211D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9B3DBBE;
	Sat, 13 Apr 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PmYA3c5+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zVWQo0F5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EDD1DFD0
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713006626; cv=none; b=h+eWIvfVFRzqM6bFZlGUoCJ37g+ncn90I7xjT80rflgFMmwUorrq3apdpQUCwrEVhIZft0E5+zjoPXpk/d4zbCFomKMQAgEabrfginORpKSlkMXnB3mWEPUdq/CiAx/OoOHce3Nh5XVk0Ymozs6Pz/JJIvrwO+stSI33LWhC8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713006626; c=relaxed/simple;
	bh=AK8PSoFQHCoOJm4ED6t2eH2/Y+s506tQ0RjjxcOPYss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=isiODrXUfU01HRQz+MeM9bGraSQWOKyxp9dS79tKmmqj9HmH2JrJMpnbMTvudNp8JLGoq5ak7XhYWUX1K5K3Xtvny8AGgs8lsZE0930si5k5XApXltwPusKzyCz8uoLcNpHjI8hVvlmUiyGzcDduacNmqm8l4HQRGTf0V/ZhhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PmYA3c5+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zVWQo0F5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713006616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ud3R6yDl9VRbE7siqBnptDz2G1hQfqVZPP/3nt2wP+w=;
	b=PmYA3c5+62jlKLwDbz4DIE0xTP+huhpo2hiHvJ/XSwRKrifPsClIptWaCctZlHyD6e0ohL
	DC0Tau6a7G5n4ENAcOBG0n6oUpA1uytTHFBngfAvmU4OQ8uRH4n/KPchkbwMsD3+6gt+AN
	fuYRGYoAeWTI7TUZMrZshkF5eOa5oc4SMU3kMwulOjXM7tJFKaUkAOpY/wVg4Y1hh6PkYm
	Sq07E0IBN+1ce/wtcuNKsK4QIkkl6c5bf6ozDVtxV6ueMJCyVDDGPTyNB8SPYfBFmwoorT
	mUA2pIC6bsZ9awqepqMMEpOg5nK7UmekgCP7C2wFsisHTtC3I5vlWNHVRxwVzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713006616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ud3R6yDl9VRbE7siqBnptDz2G1hQfqVZPP/3nt2wP+w=;
	b=zVWQo0F5mq2VVw2SSbud1xpcs6kSc6YY1Xyl5zi2X96xxL0xoeqJ6s3uB4ES3WuicT3i+e
	hfVlss9IwHxOx6Bg==
To: syzbot <syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org
Cc: lizhi.xu@windriver.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] [syzbot] [kernel?] inconsistent lock state in
 sock_hash_delete_elem
In-Reply-To: <00000000000045aaf30615035889@google.com>
References: <00000000000045aaf30615035889@google.com>
Date: Sat, 13 Apr 2024 13:10:16 +0200
Message-ID: <8734rpzffr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Mar 31 2024 at 23:46, syzbot wrote:
> For archival purposes, forwarding an incoming command email to
> linux-kernel@vger.kernel.org.
>
> ***
>
> Subject: [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
> Author: lizhi.xu@windriver.com
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d44efa0d0611..07a3c1d2c2d8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5676,7 +5676,7 @@ void scheduler_tick(void)
>  
>  	sched_clock_tick();
>  
> -	rq_lock(rq, &rf);
> +	rq_lock_irqsave(rq, &rf);

That's just wrong. scheduler_tick() is invoked from hard interrupt
context with interrupts disabled.
  
>  	update_rq_clock(rq);
>  	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> @@ -5688,7 +5688,7 @@ void scheduler_tick(void)
>  	sched_core_tick(rq);
>  	task_tick_mm_cid(rq, curr);
>  
> -	rq_unlock(rq, &rf);
> +	rq_unlock_irqrestore(rq, &rf);
>  
>  	if (sched_feat(LATENCY_WARN) && resched_latency)
>  		resched_latency_warn(cpu, resched_latency);

