Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB97F1495
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjKTNqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjKTNqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:46:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4672A9E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:46:00 -0800 (PST)
Date:   Mon, 20 Nov 2023 14:45:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700487958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sIDLtNcX5xP/2fRcdt4XuAP61ekbwx/J5uuozCpmqwc=;
        b=rq+C0U7ZmduqJ8mXb5DiMg0j8PC3cRXOwx8Rk87zAB2Tj37KQj3IVphCXaD4mkG6zQNVAu
        cimDs/RVZynGvItrYXWoVtEq5eVHJ1jf3WUcnYSiXRsIdD9W6JK4LgSuZRPN1rMeyCgt3F
        7Pw04Fbbci/V7s7oWG9MMsv5haBRlOh2ctOOhy3d/IiRP9/xjEDSOUNmqDPZIvSXFGC0DD
        bB4Md0bpXIeqZRyepjROsZGVT3segUWDSr13rQ/3Zs90E34ZfyN+mgXHOr0DXv02vROgBw
        gtZSVUn58ZollmhI+klugmPy81jXEynI2I6OP65F2YCpLyh0j3yX0SdUMba62A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700487958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sIDLtNcX5xP/2fRcdt4XuAP61ekbwx/J5uuozCpmqwc=;
        b=2qxCEwXnNYV/lk5uCO56N8CF7qvqT9vK6ClR8MqT7cG8msniVxDnW6H5Ld4/BaG8bKg4zA
        c3uFjcrE2KN9G7CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH printk v2 1/9] printk: ringbuffer: Do not skip
 non-finalized records with prb_next_seq()
Message-ID: <20231120134556.DkKNwy7B@linutronix.de>
References: <20231106210730.115192-1-john.ogness@linutronix.de>
 <20231106210730.115192-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106210730.115192-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

based on my research this should be the most recent post of this patch.
If so then

On 2023-11-06 22:13:22 [+0106], John Ogness wrote:
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -6,6 +6,7 @@
> @@ -1441,20 +1445,144 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
>  	return false;
>  }
>  
> +#ifdef CONFIG_64BIT
> +
> +#define __u64seq_to_ulseq(u64seq) (u64seq)
> +#define __ulseq_to_u64seq(ulseq) (ulseq)
> +
> +#else /* CONFIG_64BIT */
> +
> +static u64 prb_first_seq(struct printk_ringbuffer *rb);
> +
> +#define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
> +static inline u64 __ulseq_to_u64seq(u32 ulseq)
> +{
> +	u64 rb_first_seq = prb_first_seq(prb);
> +	u64 seq;
> +
> +	/*
> +	 * The provided sequence is only the lower 32 bits of the ringbuffer
> +	 * sequence. It needs to be expanded to 64bit. Get the first sequence
> +	 * number from the ringbuffer and fold it.
> +	 */
> +	seq = rb_first_seq - ((u32)rb_first_seq - ulseq);

This needs to become
	seq = rb_first_seq - ((s32)((u32)rb_first_seq - ulseq));

in order to continue booting on 32bit. Otherwise, if this survives one
cycle then we can deprecate all 32bit platforms. I am happy either way.

Sebastian
