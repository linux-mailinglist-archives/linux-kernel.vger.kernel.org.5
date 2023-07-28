Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF7276706A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbjG1PW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbjG1PWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:22:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DE63582
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:22:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B7DB31F8A3;
        Fri, 28 Jul 2023 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690557766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYmKEmnRiA+21fjw/1miLoZlyC9GhZvBc8hEfEmyKVM=;
        b=n8nkWuIb2SEdTWheL0JxXrhzlI+rZ88BsVdsp7wa5KjMp6FnqhFfx0NgOuQQ5PP6Y2bOyv
        BRT6VSSkQmAhLJ6mGN5j34Zz3wDIurVsX6S6zIO+VUfkBU1CEpGIM6GtYW4mC4k36qBykg
        QEQhbujGwazqsrLrZiXlceRkvciR1Dg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59F902C142;
        Fri, 28 Jul 2023 15:22:46 +0000 (UTC)
Date:   Fri, 28 Jul 2023 17:22:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/8] printk: Provide debug_store() for nbcon
 debugging
Message-ID: <ZMPdRVXq3IybuvzN@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 02:08:27, John Ogness wrote:
> To debug and validate nbcon ownership transitions, provide a new
> macro debug_store() (enabled with DEBUG_NBCON) to log transition
> information to the ringbuffer. If enabled, this macro only logs
> to the ringbuffer and does not trigger any printing. This is to
> avoid triggering recursive printing in the nbcon consoles.
> 
> --- a/kernel/printk/printk_nbcon.c
> +++ b/kernel/printk/printk_nbcon.c
> @@ -10,6 +10,35 @@
>   * the legacy style console_lock mechanism.
>   */
>  
> +/*
> + * Define DEBUG_NBCON to allow for nbcon ownership transitions to be logged
> + * to the ringbuffer. The debug_store() macro only logs to the lockless
> + * ringbuffer and does not trigger any printing.
> + */
> +#undef DEBUG_NBCON
> +
> +#ifdef DEBUG_NBCON
> +/* Only write to ringbuffer. */
> +int __debug_store(const char *fmt, ...)
> +{
> +	va_list args;
> +	int r;
> +
> +	va_start(args, fmt);
> +	r = vprintk_store(2, 7, NULL, fmt, args);

I have never used the facility number before. It seems that they are
defined in /usr/include/sys/syslog.h, for example, see
https://sites.uclouvain.be/SystInfo/usr/include/sys/syslog.h.html

They are even somehow documented in "man 3 syslog", for example, see
https://linux.die.net/man/3/syslog

We should probably use one of the LOG_LOCALX numbers, e.g.

#define        LOG_LOCAL0        (16<<3)

Also, please use LOGLEVEL_DEBUG instead of the hard coded "7".

> +	va_end(args);
> +
> +	return r;
> +}
> +#define debug_store(cond, fmt, ...)						\
> +	do {									\
> +		if (cond)							\
> +			__debug_store(pr_fmt("DEBUG: " fmt), ##__VA_ARGS__)	\
> +	} while (0)
> +#else
> +#define debug_store(cond, fmt, ...)
> +#endif
> +
>  /**
>   * nbcon_state_set - Helper function to set the console state
>   * @con:	Console to update

Best Regards,
Petr
