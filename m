Return-Path: <linux-kernel+bounces-150383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C68A9E45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2011F2220B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874516C69F;
	Thu, 18 Apr 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkLzIXkI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B616C698
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453888; cv=none; b=MVV9VY0dIkVYTmZMsWr7xPVlhpHAcijmeF4t9798BZjTUbWsmQxf0Xtdq9Mkw5Zoh90rtxcUlVhQKvoP3lMaIAxInJZDEnCJTtIyDErnEEwkknJ3ikno4OHt4KA7W4+a6tCImekfpVcc7BTlXPUmaNU7e/WgkJK3rYdH+MQ8QKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453888; c=relaxed/simple;
	bh=BPjE/4rb0RFs/ob/QfoIMzgDM5hkO3lIQWHpPl8o5s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg9L9SGnuvI+6JF1RLBrOybG/vZem7w+bbS5SBV8vDzRqDKheH0xt5Mb8XBMi2P/yeGdGryjFL/YCncdCJHWoF6EnzLMt0cmq4/vcZL4zF48/NRbtw+uIFi0qfPK9PxUS2FOCqSYI88zeQH0DUeZ9Te7mcqAcoJ3LOQ8w0Wp4wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkLzIXkI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713453885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7zT4wiai3WPuYZUe+Kd9EBI29RwdhaDIkMVwyp/P1Nw=;
	b=bkLzIXkIpL4dzhGtC4M5XujYM5GxrA93dvGNcOqXQrrkC5BTVC8l5pp9ta/tUnvT8BfTyL
	9KKYV/NDB6l5P5mAgiQRg9ky+JGxZDQzv3vGP1JMx3p19ybdWjoB4SiTy51bWbIQGL7yis
	Z4WIxRxqINht2qV0hGvPId6WeGUeSgA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-PklEqtjiO-GI3Q97k8rbwg-1; Thu,
 18 Apr 2024 11:24:39 -0400
X-MC-Unique: PklEqtjiO-GI3Q97k8rbwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 300063806707;
	Thu, 18 Apr 2024 15:24:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0515C1121312;
	Thu, 18 Apr 2024 15:24:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 18 Apr 2024 17:23:13 +0200 (CEST)
Date: Thu, 18 Apr 2024 17:23:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch V2 25/50] signal: Confine POSIX_TIMERS properly
Message-ID: <20240418152308.GA20625@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.509700441@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410165552.509700441@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 04/11, Thomas Gleixner wrote:
>
> Move the itimer rearming out of the signal code and consolidate all posix
> timer related functions in the signal code under one ifdef.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/posix-timers.h |    5 +
>  kernel/signal.c              |  125 +++++++++++++++----------------------------
>  kernel/time/itimer.c         |   22 +++++++
>  kernel/time/posix-timers.c   |   15 ++++-
>  4 files changed, 82 insertions(+), 85 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


A minor nit below...

> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
..
> +static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
> +static inline void posixtimer_rearm(struct kernel_siginfo *info) { }

Do we really need these 2 nops ? please see below.

..

> +		if (unlikely(signr == SIGALRM))
> +			posixtimer_rearm_itimer(tsk);

..

> +	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
> +		if (unlikely(resched_timer))
> +			posixtimer_rearm(info);
>  	}

This looks a bit inconsistent to me.

Can't we change the callsite of posixtimer_rearm_itimer() to check
IS_ENABLED(CONFIG_POSIX_TIMERS) too,

		if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
			if (unlikely(signr == SIGALRM))
				posixtimer_rearm_itimer(tsk);
		}
?

This will make the code more symmetrical, and we can avoid the dumb
definitions of posixtimer_rearm_itimer/posixtimer_rearm.

Oleg.


