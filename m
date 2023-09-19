Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A87A6F96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjISXhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjISXhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:37:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F53102
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:36:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695166616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwrjj9klT6Mv+lDOVyiJshohazCfaljG2o+1s5vTdVw=;
        b=yN5BAaKp9smhcOIya0polsWzu1L7uL0PJNdbFhCVmegd2+BY2nqmCfvnCDqAZA5YgsN5vw
        e5gh1Ghee+vhIwg7wJrk6k9RnOgHJwoGWayLm7e3yXYGGNARzlJvnXvjWZY5olLWn/Qo/z
        QAwVU2caB8vTL6tfLQ7LRhHDxxzJj28L+FHJJVaHvvYGDxxa7VJD8BL70CZRwe3hzoDAYd
        2Od+bj52XfOXlHhsfdx8cof08zIiOsG0Tqvh71y8zacasBoVaAPT74QxbsnUpNPo8jWy15
        rxfCMCTHHkNS4XamMTDiZ2zenjHqh5m9oZnty1p24gBeeL7tQZnNrn3I3XdpLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695166616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwrjj9klT6Mv+lDOVyiJshohazCfaljG2o+1s5vTdVw=;
        b=pFZv9BGurkwvXc0zoKyUU2XDOhZaU/nBRM8nn4iGv9gAOS9YDgLW8TRDqpm7N+nnz7cBwU
        DQXvjL4lB7aYymDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH printk v2 09/11] panic: Add atomic write enforcement to
 oops
In-Reply-To: <20230919230856.661435-10-john.ogness@linutronix.de>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-10-john.ogness@linutronix.de>
Date:   Wed, 20 Sep 2023 01:42:47 +0206
Message-ID: <875y45ag6o.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-20, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 86ed71ba8c4d..e2879098645d 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -630,6 +634,36 @@ bool oops_may_print(void)
>   */
>  void oops_enter(void)
>  {
> +	enum nbcon_prio prev_prio;
> +	int cpu = -1;

oops_exit() calls put_cpu(). Here used to be the corresponding
get_cpu(). Somehow I managed to drop it. Here are the inline fixups.

int cur_cpu = get_cpu();
int old_cpu = -1;

> +
> +	/*
> +	 * If this turns out to be the first CPU in oops, this is the
> +	 * beginning of the outermost atomic section. Otherwise it is
> +	 * the beginning of an inner atomic section.
> +	 */
> +	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
> +
> +	if (atomic_try_cmpxchg_relaxed(&oops_cpu, &cpu, smp_processor_id())) {

if (atomic_try_cmpxchg_relaxed(&oops_cpu, &old_cpu, cur_cpu)) {

> +		/*
> +		 * This is the first CPU in oops. Save the outermost
> +		 * @prev_prio in order to restore it on the outermost
> +		 * matching oops_exit(), when @oops_nesting == 0.
> +		 */
> +		oops_prev_prio = prev_prio;
> +
> +		/*
> +		 * Enter an inner atomic section that ends at the end of this
> +		 * function. In this case, the nbcon_atomic_enter() above
> +		 * began the outermost atomic section.
> +		 */
> +		prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
> +	}
> +
> +	/* Track nesting when this CPU is the owner. */
> +	if (cpu == -1 || cpu == smp_processor_id())

if (old_cpu == -1 || old_cpu == cur_cpu)

> +		oops_nesting++;
> +
>  	tracing_off();
>  	/* can't trust the integrity of the kernel anymore: */
>  	debug_locks_off();
