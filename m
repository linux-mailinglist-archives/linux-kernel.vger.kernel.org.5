Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09407A080C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbjINOzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240504AbjINOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:55:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7DB1FD8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:55:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EDD6E1F854;
        Thu, 14 Sep 2023 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694703340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HrHgPkh8Ohakc8NUNO+y/2a9KUeM3lj7Jc30unn6Hew=;
        b=B/YZ0+vz1pIFZChYxAMyGvk/OxX8nSIzcvKLCbP+D44jl/d2iu1mI7miFjoEya3tZQF+rY
        3LGml+EOFm3Yj4t5YikN094RTZe0mxG+ihOBPiQf/Dkn4RnlpjG7GH/7jhpkJ+HQpCUcW5
        hwzz4wYIc0ep3mDOr+1V6ihR+lK4Y3E=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 927882C142;
        Thu, 14 Sep 2023 14:55:40 +0000 (UTC)
Date:   Thu, 14 Sep 2023 16:55:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 4/8] printk: nbcon: Add buffer management
Message-ID: <ZQMe7PA4BR0aemIu@alley>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
 <20230908185008.468566-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908185008.468566-5-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-08 20:56:04, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In case of hostile takeovers it must be ensured that the previous
> owner cannot scribble over the output buffer of the emergency/panic
> context. This is achieved by:
> 
>  - Adding a global output buffer instance for the panic context.
>    This is the only situation where hostile takeovers can occur and
>    there is always at most 1 panic context.
> 
>  - Allocating an output buffer per non-boot console upon console
>    registration. This buffer is used by the console owner when not
>    in panic context. (For boot consoles, the existing shared global
>    legacy output buffer is used instead. Boot console printing will
>    be synchronized with legacy console printing.)
> 
>  - Choosing the appropriate buffer is handled in the acquire/release
>    functions.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -20,6 +21,9 @@
>   * region and aborts the operation if it detects a takeover.
>   *
>   * In case of panic the nesting context can take over the console forcefully.
> + * If the interrupted context touches the assigned record buffer after
> + * takeover, it does not cause harm because the interrupting single panic
> + * context is assigned its own panic record buffer.
>   *
>   * A concurrent writer on a different CPU with a higher priority can directly
>   * take over if the console is not in an unsafe state by carefully writing

The above chunk had a merge conflict with my proposed changes for
the 2nd patch. It uses a completely different text from the commit
message. I added the info into the new text the following way:

@@ -73,6 +74,10 @@
  *      the console is an unsafe state. It is used only in panic() by
  *      the final attempt to flush consoles in a try and hope mode.
  *
+ *      Note that separate record buffers are used in panic(). As a result,
+ *      the messages can be read and formatted without any risk even after
+ *      using the hostile takeover in unsafe state.
+ *
  * The release function simply clears the 'prio' and 'cpu' fields.
  *
  * All operations on @console::nbcon_state are atomic cmpxchg based


> @@ -426,6 +431,12 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
>  
>  	nbcon_context_acquire_hostile(ctxt, &cur);
>  success:
> +	/* Assign the appropriate buffer for this context. */
> +	if (atomic_read(&panic_cpu) == cpu)
> +		ctxt->pbufs = &panic_nbcon_pbufs;
> +	else
> +		ctxt->pbufs = con->pbufs;
> +
>  	return true;
>  }

Also the above chunk had conflict with the proposed changes. I
resolbed it the following way:

@@ -496,7 +502,18 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 
 	err = nbcon_context_try_acquire_hostile(ctxt, &cur);
 out:
-	return !err;
+	if (err)
+		return false;
+
+	/* Acquire succeded */
+
+	/* Assign the appropriate buffer for this context. */
+	if (atomic_read(&panic_cpu) == cpu)
+		ctxt->pbufs = &panic_nbcon_pbufs;
+	else
+		ctxt->pbufs = con->pbufs;
+
+	return true;
 }
 
 static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,


> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3448,6 +3442,15 @@ void register_console(struct console *newcon)
>  		goto unlock;
>  	}
>  
> +	if (newcon->flags & CON_NBCON) {
> +		/*
> +		 * Ensure the nbcon console buffers can be allocated
> +		 * before modifying any global data.
> +		 */
> +		if (!nbcon_alloc(newcon))
> +			goto unlock;
> +	}
> +
>  	/*
>  	 * See if we want to enable this console driver by default.
>  	 *

We have to call nbcon_free() when try_enable_*_console() failed.
Something like:

@@ -3484,8 +3484,10 @@ void register_console(struct console *newcon)
 		err = try_enable_preferred_console(newcon, false);
 
 	/* printk() messages are not printed to the Braille console. */
-	if (err || newcon->flags & CON_BRL)
+	if (err || newcon->flags & CON_BRL) {
+		nbcon_free(newcon);
 		goto unlock;
+	}
 
 	/*
 	 * If we have a bootconsole, and are switching to a real console,


With the proposed changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
