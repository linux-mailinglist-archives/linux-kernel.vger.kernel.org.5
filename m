Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4D0766965
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjG1JxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjG1Jww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:52:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173D1BE4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:52:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690537966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YghHFfYCYAWFBc0EraENKwpa3nnd0b9yhfSdQDigIOc=;
        b=DcbySZW3Vr69tOr7+Gp9njYVr1ItPdQ18TmSmFsFyI1RVNkTCiVPMZg2EiXRNxSSSjV9eO
        RmVmC9XE9agLZu4oDZ1Tg8XyOt5yWT1NLAS2Gt2dlXWANCt8xWI7jPN2at4eJscH9s+cFF
        0ILklMb1TZYaULmAiC4Nu+EPp5tQxemim+LOfQdz43IT6ZQTmnHAQE/7Xs2NiY8Sm8XvnD
        fICg3/we6Zp/BWmThyQENzpllnJ4eZarWMsyeKqPkSG1HCnEaGZNaFtLbjclpwXaiBVVrH
        ueKMT9p7PNZe98UiUTpAXyLFlHVoHUa3zeDSB/qw5dPcTQsvw9dtTJvyN5g2Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690537966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YghHFfYCYAWFBc0EraENKwpa3nnd0b9yhfSdQDigIOc=;
        b=kHOUssCUiiT6+FRRE/GeKpH4iUf2qD4cvAoUMIpc6O1D1W131ogmqz7GG/CL9n1GQhN+b3
        rrGHZ2nEitwCgpBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/8] printk: Provide debug_store() for nbcon
 debugging
In-Reply-To: <20230728000233.50887-3-john.ogness@linutronix.de>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-3-john.ogness@linutronix.de>
Date:   Fri, 28 Jul 2023 11:58:44 +0206
Message-ID: <878rb01hxv.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-28, John Ogness <john.ogness@linutronix.de> wrote:
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
> +	va_end(args);
> +
> +	return r;
> +}
> +#define debug_store(cond, fmt, ...)						\
> +	do {									\
> +		if (cond)							\
> +			__debug_store(pr_fmt("DEBUG: " fmt), ##__VA_ARGS__)	\

Missing a semi-colon here. Wrapping this with a do-while was a
last-minute change requested by checkpatch.pl. Probably nobody would
notice because you must manually define DEBUG_NBCON by changing the
source code. Fixed for v3 (assuming Petr allows me to keep this
debugging code in place).

> +	} while (0)
> +#else
> +#define debug_store(cond, fmt, ...)
> +#endif

John
