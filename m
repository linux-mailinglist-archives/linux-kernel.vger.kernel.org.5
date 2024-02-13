Return-Path: <linux-kernel+bounces-63513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBDE85309E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07E21F2835E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34C42079;
	Tue, 13 Feb 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVO9fvKU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wHnozyNz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137D42070
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827804; cv=none; b=S2K8ERQI6ZNl7Ly9/EI6lRuMJh7IWFrb2WqbDbMza5rzB6tsWcRH0AXGwAxsh9rUXgACUKAnkxriwCD+jr/25xc53ooXRDP/6iynHK2YQkQCIVVnB4eaTqm8mie+sKItMq/8XV3ifkQfsoOy2wdJS8vlU6D4TcbTb4EEobuKlCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827804; c=relaxed/simple;
	bh=u7Gj4MawtZchNvB4IMfRVaTsXDme7kgSGLdFK94qFWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GL6RVRP/g/LC5AQ4ynIi/Ei9OUGWbzSOTM6LhlALGJPlNyAlY5Drm+AoULx+3TYuaJhdw5Js+d/QShR0TRA0gdtoVgfhyGUIFZi1hlytPMVIjTbgkOWl/+MLq4E1gXyNzKUMCZSvmxCsfhk5ABSYhuJDA4N6jkv2VHlmBwC679c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KVO9fvKU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wHnozyNz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707827800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pb2pqQV0xUnwZMXOVMtuXzPc3E6lATgDDAmVYInJbIQ=;
	b=KVO9fvKU4jfYtiqA6VTtqgUIfPRmafYvV9hD95YC+/7FJIc98F3a6ynNQse9woP+fYYxYq
	Cn2+7bSlzRn1zeQetpEFXS8IgasjECZe25f60L+ZmIij70bHmjJsh/DEeOQvmngJ05FhKU
	+Z6Iv7x1PNstbMFvLBxksbn8c1N16yBQT55YpizuJv/oT4eQvzODd3HYWQg5cIb5SiuAYv
	HCWCKbdSwxT11pq1/o/jj061r0pB7gxF0kXCDUvlb4fQBsuqvnA9lab9Bneq+db64ORDaM
	j6KEEdT8AA8+HSNGbkcTqiMmEoMzjStdypO2VVYGmCsbNFDp8J1HS5Ci4XxLjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707827800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pb2pqQV0xUnwZMXOVMtuXzPc3E6lATgDDAmVYInJbIQ=;
	b=wHnozyNza0ssaJwmrK8QajDYWvto8xHEeJV9cUBfbUWHNhE/+8gwtoKJcPcbixESCm0MoK
	PW6n+TVq3hXwQHBw==
To: Costa Shulyupin <costa.shul@redhat.com>, Waiman Long
 <longman@redhat.com>, linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] hrtimer: select housekeeping CPU during migration
In-Reply-To: <20240211135213.2518068-1-costa.shul@redhat.com>
References: <20240211135213.2518068-1-costa.shul@redhat.com>
Date: Tue, 13 Feb 2024 13:36:40 +0100
Message-ID: <87o7ckh76v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Feb 11 2024 at 15:52, Costa Shulyupin wrote:
> because during CPU deactivation a timer can migrate
> to isolated CPU and break CPU isolation.

That's not a sentence.

> For reference see function get_nohz_timer_target,

get_nohz_timer_target()

> which selects CPU for new timers from
> housekeeping_cpumask(HK_TYPE_TIMER)

But what is the point of this statement?

> Inspired by Waiman Long <longman@redhat.com>

Can you please use a proper tag, i.e. Suggested-by and not invent some
random free form text just because?

> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  kernel/time/hrtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index f82997cf53b6..460d916e24b7 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -2227,7 +2227,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
>  int hrtimers_cpu_dying(unsigned int dying_cpu)
>  {
>  	struct hrtimer_cpu_base *old_base, *new_base;
> -	int i, ncpu = cpumask_first(cpu_active_mask);
> +	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
>  	pr_debug("ncpu=%d, dying_cpu=%d\n", ncpu, dying_cpu);
>  
>  	tick_cancel_sched_timer(dying_cpu);

Q: Against which tree is this supposed to apply?

A: Against some private tree of yours which added the pr_debug() in a
   previous commit.

Can you please read and follow Documentation/process/ and provide
patches which actually can be applied without fixing them up manually?

Thanks,

        tglx

        

