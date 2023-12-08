Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0642F80A4D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573850AbjLHNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573883AbjLHNzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:55:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A701732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:55:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702043751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVHxB4/OkmRYHQXloRKzXxuV03ASclMXr8YytSHh3t0=;
        b=m/TwwdJAXkOKLpBuWx9lfP+PtNvL2Zfc5JIkri+KXj1DXyYLYI62YAyPgX3WMkHT0BYD8O
        FgP1VUZ1TpNxamy69Lsl6wJ/31GJQWVnNL2fEjAzMriruoSozgmumJsxcq3qPmc8zXikkY
        d/+q+XZLEgdYbVKJQ2lLreRYNqmMJkG9K6mhbnH3wYWy5EZPbaeRZ0jPitLOx6EKvfvYNu
        EgQSlpfnt8kAiWa1KB2qed+mzWryKl9fGKdn7W4ENUbV9USfbg0Ok3S4CtVGlyqG7RtEdp
        RDxOFDaBjn5B8iMCmd/2Uai91fG031wW7JQ5ESIlZAJ4zyB/REWkhpgMc6rfwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702043751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVHxB4/OkmRYHQXloRKzXxuV03ASclMXr8YytSHh3t0=;
        b=fY4qNYgCmptVeEdiTdbDdzu+2elSWp/wk83LcFn7Oxv4U7gc8qPuXEXeP5jDjR0b9x45gi
        qvdqiHdnNLN+PTBQ==
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] irqchip/irq-xtensa-pic: clean up
In-Reply-To: <20231205101307.1303186-1-jcmvbkbc@gmail.com>
References: <20231205101307.1303186-1-jcmvbkbc@gmail.com>
Date:   Fri, 08 Dec 2023 14:55:51 +0100
Message-ID: <87r0jwssrc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05 2023 at 02:13, Max Filippov wrote:
> - get rid of the cached_irq_mask variable
> - make mask/unmask operations atomic
> - use BIT() macro instead of bit shifts
> - drop .disable and .enable as they are equivalent to the default
>   implementations
>  static void xtensa_irq_mask(struct irq_data *d)
>  {
> -	cached_irq_mask &= ~(1 << d->hwirq);
> -	xtensa_set_sr(cached_irq_mask, intenable);
> -}
> +	unsigned long flags;
> +	u32 irq_mask;
>  
> -static void xtensa_irq_unmask(struct irq_data *d)
> -{
> -	cached_irq_mask |= 1 << d->hwirq;
> -	xtensa_set_sr(cached_irq_mask, intenable);
> +	local_irq_save(flags);

All of these callbacks are invoked with interrupts disabled already. No
point in disabling them some more.

> +	irq_mask = xtensa_get_sr(intenable);
> +	irq_mask &= ~BIT(d->hwirq);
> +	xtensa_set_sr(irq_mask, intenable);
> +	local_irq_restore(flags);
>  }

Thanks,

        tglx
