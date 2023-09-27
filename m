Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8433D7B036B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjI0MCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjI0MCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:02:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF012A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:02:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 75E081F88F;
        Wed, 27 Sep 2023 12:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695816139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KTfs5yhlTCE0o2SXh5aaYXX3rf4gvBwg1JvGvr+LWu0=;
        b=DnSiAjjZuQTTj/CXNknIWTwmVKSVt+USmsNxtwCRXOFOMBIQRyOA4Lsgeqi3Bx1OVwRYhF
        wqQixbUJdiydkqyv5nEiNxxT7G2vfmx6R54rpr4XvI2ZEIa8E2kITKOQejvIywOWPSYVl1
        HkMCGmwEtSgW0oIxctaR8RCwauPhjSE=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D9F262C142;
        Wed, 27 Sep 2023 12:02:18 +0000 (UTC)
Date:   Wed, 27 Sep 2023 14:02:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH printk v2 08/11] panic: Add atomic write enforcement to
 warn/panic
Message-ID: <ZRQZycM9uTAnxn8C@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-9-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:53, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Invoke the atomic write enforcement functions for warn/panic to
> ensure that the information gets out to the consoles.
> 
> For the panic case, add explicit intermediate atomic flush
> calls to ensure immediate flushing at important points.
> Otherwise the atomic flushing only occurs when dropping out of
> the elevated priority, which for panic may never happen.

It would be great to avoid the need for the explicit flushes
except for the final unsafe one. Otherwise, we would play
another Whack-a-mole game. People would report that
panic() failed and they needed to add another explicit flush
to find the culprit...

> It is important to note that if there are any legacy consoles
> registered, they will be attempting to directly print from the
> printk-caller context, which may jeopardize the reliability of
> the atomic consoles. Optimally there should be no legacy
> consoles registered.

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -275,6 +275,7 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>   */
>  void panic(const char *fmt, ...)
>  {
> +	enum nbcon_prio prev_prio;
>  	static char buf[1024];
>  	va_list args;
>  	long i, i_next = 0, len;
> @@ -322,6 +323,8 @@ void panic(const char *fmt, ...)
>  	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
>  		panic_smp_self_stop();
>  
> +	prev_prio = nbcon_atomic_enter(NBCON_PRIO_PANIC);
> +

It would make sense to flush nbcon consoles the safe way
at this point before we allow dangerous games for legacy
consoles via bust_spinlock().

>  	console_verbose();
>  	bust_spinlocks(1);
>  	va_start(args, fmt);
> @@ -382,6 +385,8 @@ void panic(const char *fmt, ...)
>  	if (_crash_kexec_post_notifiers)
>  		__crash_kexec(NULL);
>  
> +	nbcon_atomic_flush_all();

There should be one more safe flush after dump_stack() just
in case the kexec fails. The legacy consoles also tried
to flush the consoles in each called printk().

...

I do not want to review or comment each added or needed
nbcon_atomic_flush_all(). I hope that they won't be needed
in the end.

Best Regards,
Petr
