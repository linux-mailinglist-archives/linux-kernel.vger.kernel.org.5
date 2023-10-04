Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4639A7B7D10
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbjJDKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242116AbjJDKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:25:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702DCB4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:25:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696415109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTyylAzC8frK5geYcRE1ljeQ4FXoAjG7xVcVT7SH0zc=;
        b=cGGqmAWcYEV9nAldg4P7m8UdpFr/96/n5vkWSAp9ph6995vvwEGv41zhYACTC8KUjktW61
        jVnzjPMF8h+a0ZpTXtSp+3c6ZyfgsfI9QnLVgwSA30wiJT6GZxC8MqZsFr8xlTPrfyrs5m
        UMt2Yf6uGlcosgMvMS4PyiTRzRGvcFvhMB2IwjW80coc2a9tXUi/y+FqibE/jLWapU9On6
        ai+/eIxgPVEOhBrNfm0q0kpzobZa61Cn3eP8sdKsb15RaiOCZmH07j659Kq8ksJJuCgL/q
        g4BroMK4H7xdzBA/732Kx3IcpiDWynyyG+vGl9I+0J5WvmXhKCr7+rK/kB7SoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696415109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTyylAzC8frK5geYcRE1ljeQ4FXoAjG7xVcVT7SH0zc=;
        b=xJihxi2knh20Hh/jP24o5YtEkJB1V02mdU2zU2a+RL8wRc6LT7Bw34vjtArWLEx/5kZju0
        dKM7fROtLSaJJ5Dg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@intel.com>
Subject: Re: [PATCH printk] printk: flush consoles before checking progress
In-Reply-To: <ZRrAFS3cELj1DDN2@alley>
References: <20230929113233.863824-1-john.ogness@linutronix.de>
 <ZRrAFS3cELj1DDN2@alley>
Date:   Wed, 04 Oct 2023 12:31:07 +0206
Message-ID: <87h6n64rcs.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-02, Petr Mladek <pmladek@suse.com> wrote:
> I was about to push this patch and ran checkpatch.pl. It warned about
>
> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst
> #73: FILE: kernel/printk/printk.c:3782:
> +               msleep(1);
>
> And indeed, Documentation/timers/timers-howto.rst says that msleep()
> might sleep longer that expected for <20ms delays. I guess that
> it is somehow related to jiffies, HZ, and load on the system.
>
> I think that we need to count jiffies here.

Agreed. The @timeout_ms parameter should be respected.

> Something like:
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index db81b68d7f14..6ea500d95fd9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3723,7 +3723,8 @@ late_initcall(printk_late_init);
>  /* If @con is specified, only wait for that console. Otherwise wait for all. */
>  static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
>  {
> -	int remaining = timeout_ms;
> +	unsigned long timeout_jiffies = msecs_to_jiffies(timeout_ms);
> +	unsigned_long timeout_end = jiffies + timeout_jiffies;
>  	struct console *c;
>  	u64 last_diff = 0;
>  	u64 printk_seq;
> @@ -3772,24 +3773,19 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  		console_srcu_read_unlock(cookie);
>  
>  		if (diff != last_diff && reset_on_progress)
> -			remaining = timeout_ms;
> +			timeout_end = jiffies + timeout_jiffies;
>  
>  		console_unlock();
>  
>  		/* Note: @diff is 0 if there are no usable consoles. */
> -		if (diff == 0 || remaining == 0)
> +		if (diff == 0)
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
> +		/* Negative timeout means an infinite wait. */
> +		if (timeout_ms >= 0 && time_after_eq(jiffies, timeout_end))
> +			break;
> +
> +		msleep(2000 / HZ);

Is there really any advantage to this? I would just do msleep(1) and let
msleep round up. Everything else (tracking via jiffies) looks fine to me.

>  		last_diff = diff;
>  	}
>
> And we should do this in a separate patch. It seems that sleeping
> is a bigger magic than I expected.

Agreed.

John
