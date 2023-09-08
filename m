Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063607987B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243495AbjIHNUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjIHNUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:20:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A419B5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:20:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694179234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oO1gFl3OKa4t8K8AP1W/DdE2zLBmEcRzdjv56gJls20=;
        b=urc0KUmqr+YNlIw1FuklEojRP4zqNCUjDR8EO298olL+nLaqYmQKhybEsB10sVLzZiFbwz
        2nkJNbsvxop6+DJtxz6Y1QJRiey0vkn2pwVYpMcG4OVeKBf46ZfuCNB/PrXLUE4lXa33rK
        6CifuxUFZYLjBzjRKheTi+r06WKxAwPJT+zuVMRioA2AEsi/UBYkW4nRrsiW/NOGavatKf
        9OfHGyfDYITI223YrtTTpPxtqR8rkDMncMA6i37TGulk6TC36v03EFobMGu6tXfrqshD+R
        siIE/zCPq8+p5FLvWnj8sy1vxbQb+uk0i0BpEVhTd7zbTjimvrr5yhKAEhLlzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694179234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oO1gFl3OKa4t8K8AP1W/DdE2zLBmEcRzdjv56gJls20=;
        b=eDnjoENdMjxyHVKFBK2bz7wwSWKGdwBP56Z4ay7Wqv+JZJ9RI6Zm/gOb/4wSg3g1r/SCzt
        FaNxCbRVUcfV9LDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 4/7] printk: nbcon: Add ownership state functions
In-Reply-To: <ZPiFW6H-umxxB4CE@alley>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
 <20230903150539.245076-5-john.ogness@linutronix.de>
 <ZPiFW6H-umxxB4CE@alley>
Date:   Fri, 08 Sep 2023 15:26:32 +0206
Message-ID: <8734zox0m7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-06, Petr Mladek <pmladek@suse.com> wrote:
>> +static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_state *cur)
>> +{

[...]

>> +	/*
>> +	 * It is not known whether the handover succeeded. The outermost
>
> It was not immediately clear to me what exactly "handover succeeded" did mean.
> I would write:
>
> 	* It is not clear whether the waiter really took the lock
> 	* and re-printed the record. The outermost calsite...

It is not just about printing. A console is locked by drivers for other
purposes as well. And that is the situation that this comment is mostly
targetting. For v4 I change it to:

        /*
         * It is not clear whether the waiter really took over ownership. The
         * outermost callsite must make the final decision whether console
         * ownership is needed for it to proceed. If yes, it must reacquire
         * ownership (possibly hostile) before carefully proceeding.
         *
         * The calling context no longer owns the console so go back all the
         * way instead of trying to implement reacquire heuristics in tons of
         * places.
         */

John Ogness
