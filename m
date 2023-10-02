Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665DC7B53C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbjJBNFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:05:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F12E93
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:05:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 27A532185D;
        Mon,  2 Oct 2023 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696251926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttnDvYpWgMvTjf+0dEP2kht6WC3whxjt9OhSv87ziXU=;
        b=AOyEcTQH3P2Sk3FPLf42UuEmjhuEvwEpfiOZXiicIFk3FKfLpE3yHqkD3URM8Ae/8W/Khs
        TPCqWmLX488XpBOENXerj70opvnVuwmybxLKyiMCZESPuWjZNYKztyHMI4gv//RLOawqPR
        8zAbu3HGh4Za3dsanpLYqmbFyLsX7rw=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A47F52C142;
        Mon,  2 Oct 2023 13:05:25 +0000 (UTC)
Date:   Mon, 2 Oct 2023 15:05:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@intel.com>
Subject: Re: [PATCH printk] printk: flush consoles before checking progress
Message-ID: <ZRrAFS3cELj1DDN2@alley>
References: <20230929113233.863824-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929113233.863824-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-29 13:38:33, John Ogness wrote:
> Finally, in case pr_flush() needs to poll-wait (for example,
> because there has been a handover to another CPU), reduce the
> polling interval from 100ms to 1ms. In the bug report it was
> mentioned that 100ms is unnecessarily long.
> 
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217955
> Fixes: 9e70a5e109a4 ("printk: Add per-console suspended state")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 7e0b4dd02398..cf7841fc6eef 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3775,16 +3781,11 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  		if (diff == 0 || remaining == 0)
>  			break;
>  
> -		if (remaining < 0) {
> -			/* no timeout limit */
> -			msleep(100);
> -		} else if (remaining < 100) {
> -			msleep(remaining);
> -			remaining = 0;
> -		} else {
> -			msleep(100);
> -			remaining -= 100;
> -		}
> +		msleep(1);

I was about to push this patch and ran checkpatch.pl. It warned about

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst
#73: FILE: kernel/printk/printk.c:3782:
+               msleep(1);

And indeed, Documentation/timers/timers-howto.rst says that msleep()
might sleep longer that expected for <20ms delays. I guess that
it is somehow related to jiffies, HZ, and load on the system.

I think that we need to count jiffies here. Something like:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index db81b68d7f14..6ea500d95fd9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3723,7 +3723,8 @@ late_initcall(printk_late_init);
 /* If @con is specified, only wait for that console. Otherwise wait for all. */
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
 {
-	int remaining = timeout_ms;
+	unsigned long timeout_jiffies = msecs_to_jiffies(timeout_ms);
+	unsigned_long timeout_end = jiffies + timeout_jiffies;
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
@@ -3772,24 +3773,19 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		console_srcu_read_unlock(cookie);
 
 		if (diff != last_diff && reset_on_progress)
-			remaining = timeout_ms;
+			timeout_end = jiffies + timeout_jiffies;
 
 		console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
-		if (diff == 0 || remaining == 0)
+		if (diff == 0)
 			break;
 
-		if (remaining < 0) {
-			/* no timeout limit */
-			msleep(100);
-		} else if (remaining < 100) {
-			msleep(remaining);
-			remaining = 0;
-		} else {
-			msleep(100);
-			remaining -= 100;
-		}
+		/* Negative timeout means an infinite wait. */
+		if (timeout_ms >= 0 && time_after_eq(jiffies, timeout_end))
+			break;
+
+		msleep(2000 / HZ);
 
 		last_diff = diff;
 	}

Note that I used 2000 / HZ to make sure that it will be >= 1.

And we should do this in a separate patch. It seems that sleeping
is a bigger magic than I expected.

Best Regards,
Petr
