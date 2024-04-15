Return-Path: <linux-kernel+bounces-145215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FE8A50E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8484528CF1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8022D127B45;
	Mon, 15 Apr 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAAFwy6j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD5126F3A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186125; cv=none; b=cyYVulrY1LoIOoR4YJbDXkxPRKEZeC44GphDYKHsswL7LF/VPZV9q8fa6jVRghOhasxzBpEbVdB4pI/kj+SEZK+G+alnAC+TK0PbJ0+lpK9wi7mlMnqe9TX6wB+n+DUmubSxztKbNSZOa50t/LgbEAqdJl/3mE/1Y3kP6Jo4bi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186125; c=relaxed/simple;
	bh=wangW2WSspV67FmNKT8bxZVzAh3dG2lDGsi65zTLlTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy4DUV7JO6tr2vj6VdxI4rSAtzJvwVQIGEmvsKbNrTpNYo9zELgJ7m3rmhaY5MmZA4RrWn4UIuTr4XH6xM/repd7RmNgEQ2bcP0EQ1vdGUVEEF8vvq5sCO6O99cii9sfsOjFrtkUmoWSLzD33i0Z1ltmlx3ebYKqwTrvtb1Zcu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAAFwy6j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713186123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=elCvWszvv8dhzDRJndbHppgZOzQPbalPx1y/c7jKkW8=;
	b=VAAFwy6jzUkG65t71jeCJiHHTeRMZY7CdnlIfNgIZysWcSNlzEM90G+MqFtfJxcNR0pU6e
	wc32NNcWOfcWmlIJpCLCD/yq2sVPotUl43MM67kGqrqAw8aAtEuQdG6f94z4AEerBHTO7f
	RxHZnZ9/x1DoV7kxuJLnrIMGG7ZvNc0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-Jnl2YFweMG62snuvcQt6lg-1; Mon,
 15 Apr 2024 09:01:57 -0400
X-MC-Unique: Jnl2YFweMG62snuvcQt6lg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A08DB29AB426;
	Mon, 15 Apr 2024 13:01:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with SMTP id EE72C1C06701;
	Mon, 15 Apr 2024 13:01:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 15 Apr 2024 15:00:31 +0200 (CEST)
Date: Mon, 15 Apr 2024 15:00:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] posix-timers: Handle returned errors poperly in
 [i]timer_delete()
Message-ID: <20240415130023.GA27124@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <8734rm95ah.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734rm95ah.fsf@somnus>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/15, Anna-Maria Behnsen wrote:
>
> timer_delete_hook() returns -EINVAL when the clock or the timer_del
> callback of the clock does not exist. This return value is not handled by
> the callsites timer_delete() and itimer_delete().

IIUC this shouldn't happen? timer_delete_hook() WARN()s in this case,
not sure we need to return this error to userspace...

> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -1009,6 +1009,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
>  {
>  	struct k_itimer *timer;
>  	unsigned long flags;
> +	int ret;
>  
>  	timer = lock_timer(timer_id, &flags);
>  
> @@ -1019,7 +1020,11 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
>  	/* Prevent signal delivery and rearming. */
>  	timer->it_signal_seq++;
>  
> -	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
> +	ret = timer_delete_hook(timer);
> +	if (ret < 0)
> +		return ret;

unlock_timer() ?

>  static void itimer_delete(struct k_itimer *timer)
>  {
>  	unsigned long flags;
> +	int ret;
>  
>  	/*
>  	 * irqsave is required to make timer_wait_running() work.
> @@ -1054,13 +1060,17 @@ static void itimer_delete(struct k_itime
>  	spin_lock_irqsave(&timer->it_lock, flags);
>  
>  retry_delete:
> +	ret = timer_delete_hook(timer);
> +	if (WARN_ON_ONCE(ret < 0))
> +		return;

the same.

Oleg.


