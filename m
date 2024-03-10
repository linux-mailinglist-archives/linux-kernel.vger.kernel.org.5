Return-Path: <linux-kernel+bounces-98174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CE187760A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66290B20B2D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 10:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E3C208C8;
	Sun, 10 Mar 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CchBOQw0"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DB20312
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710065015; cv=none; b=BsZyd+yMjdMPvmiW70IpKNrLMrfG5wYRnL2QP7qzEU8mtRojZSZaF9eWKmwRdJwo3vlxxJXveawIQnvdRApsvYmwDPCmRAANO61JcJhoM9VPIbJBnxoDRvtZNF5b8MNpm8xax8QAz0RfI/QkZ8D7JwhkyeuvpU/pCPS3mY2JB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710065015; c=relaxed/simple;
	bh=ODKswa5CUJaU3YGLm+CuGHnSbODtPb8Pzdi7BdThR1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhWQMsvpnVoKfApL+QdpxEf+dQohteImV8t7eo1iCP6ROoBHI80sy1VWgIwVonERagy5EY1u+LMw2BRQ5slnGaG8Fmz9xhbpAp8ehBlXEQUZb7D3K2XxBEWg5N83kK2flo8boHn1KxN5re5z4seDAvDcQKxzHG3HxObVCkf6jcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=CchBOQw0; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690c1747c3cso9211346d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710065013; x=1710669813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRw83r26dUzmXUGRBQ0rsHKELCL2+O1vFNrTC/BrAHk=;
        b=CchBOQw0yWKJPSLRezqrw7QAOtfCzSgn3Rhn7y4IT/QPlFCdxIyBDWtP1kglQVxvkM
         VxrRaBoBT5J/C8OenWgjVUzt2N6QCxHKuuxVpEVcNm3+/zbdOzA3dqSmTprHrefu+f/D
         gcP38460atgU0zkJKjF/Pa507r0US+smmx4EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710065013; x=1710669813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRw83r26dUzmXUGRBQ0rsHKELCL2+O1vFNrTC/BrAHk=;
        b=VqWKVz1tSwo+zSNV+7KWJarqZF4h97izGj5IyM04HEdGWESQFlMLqyKpGBqftKI7DN
         FSUsIpJqUNH3n8oAiZOReVoRiMcI/It0G1nrr2hR38lQKRFUG23adnWzo1CWfI1N0hZp
         twOz5J+XG6Q9JTQHd21mxZVq07m3tVRHmdJvHIkkgjW6zKQTgYXUVZyfEvkU6lEQ6aYC
         EOcJCY3P9/aKB7Rvw8YJMbGmAugpwY4TlJ5UzDN/+ZeINY6GkK4qTZN//C4ixffJmWTx
         /I971vqLntGLszuCd3neXCzgc67g4xQpfN1wTTje1NM8NQ344ZimnfIm1WpaAtVl3tWw
         o1qg==
X-Gm-Message-State: AOJu0YwOv1OdW7ez8oJieg1wutQJcvZa/gGCLCPYRAAr/km/lfIS7Kca
	1eDO+pca34Y9h8l1Us5s5yI3CLRcEaFvFUdRY0/oT+I5kdZyfcJkenphBUK6H0E=
X-Google-Smtp-Source: AGHT+IHBX+UKSD1e6owiqcXqfLroval1RSKYSGVtXU1UFq6HNY2Onl8gA8nkfcFr4GHOuXQeBYJWqg==
X-Received: by 2002:a05:6214:20a4:b0:690:5ff8:cc0 with SMTP id 4-20020a05621420a400b006905ff80cc0mr7179427qvd.11.1710065012835;
        Sun, 10 Mar 2024 03:03:32 -0700 (PDT)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id kh20-20020a056214515400b00690c78902a1sm809884qvb.109.2024.03.10.03.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 03:03:31 -0700 (PDT)
Date: Sun, 10 Mar 2024 06:03:30 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
	bristot@kernel.org, mathieu.desnoyers@efficios.com,
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, rostedt@goodmis.org,
	David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <20240310100330.GA2705505@joelbox2>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213055554.1802415-16-ankur.a.arora@oracle.com>

Hello Ankur and Paul,

On Mon, Feb 12, 2024 at 09:55:39PM -0800, Ankur Arora wrote:
> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
> states for read-side critical sections via rcu_all_qs().
> One reason why this was necessary: lacking preempt-count, the tick
> handler has no way of knowing whether it is executing in a read-side
> critical section or not.
> 
> With PREEMPT_AUTO=y, there can be configurations with (PREEMPT_COUNT=y,
> PREEMPT_RCU=n). This means that cond_resched() is a stub which does
> not provide for quiescent states via rcu_all_qs().
> 
> So, use the availability of preempt_count() to report quiescent states
> in rcu_flavor_sched_clock_irq().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/rcu/tree_plugin.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 26c79246873a..9b72e9d2b6fe 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -963,13 +963,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>   */
>  static void rcu_flavor_sched_clock_irq(int user)
>  {
> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
> +	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
> +	     !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {

I was wondering if it makes sense to even support !PREEMPT_RCU under
CONFIG_PREEMPT_AUTO.

AFAIU, this CONFIG_PREEMPT_AUTO series preempts the kernel on
the next tick boundary in the worst case, with all preempt modes including
the preempt=none mode.

Considering this, does it makes sense for RCU to be non-preemptible in
CONFIG_PREEMPT_AUTO=y? Because if that were the case, and a read-side critical
section extended beyond the tick, then it prevents the PREEMPT_AUTO preemption
from happening, because rcu_read_lock() would preempt_disable().

To that end, I wonder if CONFIG_PREEMPT_AUTO should select CONFIG_PREEMPTION
(or CONFIG_PREEMPT_BUILD, not sure which) as well because it does cause
kernel preemption. That then forces selection of CONFIG_PREEMPT_RCU as well.

thanks,

 - Joel







>  
>  		/*
>  		 * Get here if this CPU took its interrupt from user
> -		 * mode or from the idle loop, and if this is not a
> -		 * nested interrupt.  In this case, the CPU is in
> -		 * a quiescent state, so note it.
> +		 * mode, from the idle loop without this being a nested
> +		 * interrupt, or while not holding a preempt count.
> +		 * In this case, the CPU is in a quiescent state, so note
> +		 * it.
>  		 *
>  		 * No memory barrier is required here because rcu_qs()
>  		 * references only CPU-local variables that other CPUs
> -- 
> 2.31.1
> 

