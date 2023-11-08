Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1837E524B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjKHJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:01:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D663E1716
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o1k+9LWQfYbsH6i1YBwZRWYzVVi+NlhgulqChyyrbdM=; b=UijKzCUtSAjkXA/3c/Hfb7U+GB
        X22EpK22RyTqUR4yRClfaa5LOckiOPJvWXBFzCZ8esoeqIby5dvOUkK0LaRB+HJo+ubheya33SW73
        7LOoAwO9OAE+GnMqTROOces4f2NKk6ASjVHUHPPadGNKzj/O1wv1jSPrieyxWOHapzEgVRVpBiKN0
        qRap08yPkXO78wVLKbwjbjPG4LrYJ3vKAztZTXY+fLRAx3rgDdDa34mtLQNoBUDd/+5EE/rfW42NR
        roPg2tIhqjIkVFOU83rVba7ZgyhBddFzv/PBDudPuImnkz0IXEmjOJt6GCayyX92DKbZkixtnA/dJ
        xP1kSbIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0ePz-00DMrH-25;
        Wed, 08 Nov 2023 09:00:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C6BD30049D; Wed,  8 Nov 2023 10:00:11 +0100 (CET)
Date:   Wed, 8 Nov 2023 10:00:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 35/86] thread_info: change to
 tif_need_resched(resched_t)
Message-ID: <20231108090011.GF8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-36-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-36-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:21PM -0800, Ankur Arora wrote:

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 95d47783ff6e..5f0d7341cb88 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2172,9 +2172,11 @@ static inline int rwlock_needbreak(rwlock_t *lock)
>  
>  static __always_inline bool need_resched(void)
>  {
> -	return unlikely(tif_need_resched());
> +	return unlikely(tif_need_resched(RESCHED_eager) ||
> +			tif_need_resched(RESCHED_lazy));
>  }
>  
> +

We really needed this extra blank line, yes? :-)

>  /*
>   * Wrappers for p->thread_info->cpu access. No-op on UP.
>   */
> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> index 478084f9105e..719416fe8ddc 100644
> --- a/include/linux/sched/idle.h
> +++ b/include/linux/sched/idle.h
> @@ -63,7 +63,7 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
>  	 */
>  	smp_mb__after_atomic();
>  
> -	return unlikely(tif_need_resched());
> +	return unlikely(need_resched());
>  }

You're stacking unlikely's, need_resched() already has unlikely.

