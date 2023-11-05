Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939687E12D6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjKEJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 04:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:35:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B0B7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 01:35:17 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699176915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efQV1h0/CAOqs1+sgjoIFcEvtB7beW5JNDxDr/YouM4=;
        b=oQbtTYAAlu63CiAV0R8qyqlmLij0oKp2G1dGLjs/1aDIK8pky4GXFEMxvXJ9eQdqRgQUA7
        o06EOQJu9yHS0qDlEg/GjcIFJ0XKeCPrpjBWAy5NsI7JTncRiaRwaOcruXZxPjm+Rrdr2q
        paCyKgIWpBZXjyhqjH9h+d9MX92A+oTMwYt4bUegFwN+aMvExNw1gIxEn4+Njw7cL+6jk6
        zGa7y4C7dnnMPKsMYO787bJGwWoYxU2JRvqBAhqr4CyBvYUZ58Sga9zjxOOdsXKu3E/5WJ
        LoDAI/iom7OcNO3VG754aGi4+qrI2mSA5kHT7tV6JBZRz7LylhK5Ql667twmeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699176915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efQV1h0/CAOqs1+sgjoIFcEvtB7beW5JNDxDr/YouM4=;
        b=T71n6hUco4RAO2MnKVotK1yvrnHUWuz9lAX0a8EWS/VC9pp1GnYT0qWAtGKfOlHlSgE4Uy
        RUCQ8AU9muCPK5Dw==
To:     greearb@candelatech.com, linux-kernel@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH/RFC] debugobjects/slub:  Print slab info and backtrace.
In-Reply-To: <20231103013704.1232723-1-greearb@candelatech.com>
References: <20231103013704.1232723-1-greearb@candelatech.com>
Date:   Sun, 05 Nov 2023 10:35:15 +0100
Message-ID: <878r7cilv0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2023 at 18:37, greearb@candelatech.com wrote:
> When debugobjects detects a problem, it may be in generic code
> where the backtraces currently printed are not helpful.
>
> To try to improve this, store the backtrace of where the
> debug_obj was created and print that out when problems
> are found.

To make debugobjects massively slower than it is already.

> Also print out slub info for the object held by the
> debug_obj.  In my particular case, this was not super
> useful, appearantly because of all of the KASAN and other
> debugging I have enabled.  Still, might provide a few
> clues.

So either it is useful or not. You could have disabled the other
debugging to figure this out, no?

Aside of that this is a separate issue and wants to be split out into a
separate patch if at all.

> diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
> index 32444686b6ff..8e8df719bd88 100644
> --- a/include/linux/debugobjects.h
> +++ b/include/linux/debugobjects.h
> @@ -31,6 +31,11 @@ struct debug_obj {
>  	unsigned int		astate;
>  	void			*object;
>  	const struct debug_obj_descr *descr;
> +#ifdef CONFIG_STACKDEPOT

If at all then this wants to be CONFIG_DEBUG_OBJECTS_STACKTRACE or such.

> +#define DEBUG_OBJ_ADDRS_COUNT 16

Don't glue a define into the struct. That's unreadable.

> +	/* Including stackdepot.h blows up the build, so open-code the handle. */

Seriously no. The obvious fix is to move 'struct debug_obj' into the C
file as it is not used anywhere else.

> +	u64 trace_handle;
> +#endif
>  };

> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index a517256a270b..1f458e473bc5 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -17,6 +17,8 @@
>  #include <linux/hash.h>
>  #include <linux/kmemleak.h>
>  #include <linux/cpu.h>
> +#include <linux/slab.h>
> +#include <linux/stackdepot.h>
>  
>  #define ODEBUG_HASH_BITS	14
>  #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
> @@ -216,6 +218,33 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
>  	return obj;
>  }
>  
> +#ifdef CONFIG_STACKDEPOT
> +static void debug_print_stack_info(struct debug_obj *object)
> +{
> +	if (object->trace_handle) {
> +		pr_err("debugobjects: debug_obj allocated at:\n");
> +		stack_depot_print(object->trace_handle);
> +		pr_err("end of stack dump\n");
> +	}
> +}
> +
> +static noinline depot_stack_handle_t set_track_prepare(void)
> +{
> +	depot_stack_handle_t trace_handle;
> +	unsigned long entries[DEBUG_OBJ_ADDRS_COUNT];
> +	unsigned int nr_entries;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +
> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> +	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +
> +	return trace_handle;
> +}
> +
> +#else
> +static void debug_print_stack_info(struct debug_obj *object) { }
> +static depot_stack_handle_t set_track_prepare(void) { }
> +#endif
> +
>  static struct debug_obj *
>  alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
>  {
> @@ -272,6 +301,12 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
>  		obj->state  = ODEBUG_STATE_NONE;
>  		obj->astate = 0;
>  		hlist_add_head(&obj->node, &b->list);
> +
> +		/* Save stack of where object was created */
> +#ifdef CONFIG_STACKDEPOT
> +		/* kernel backtrace */
> +		obj->trace_handle = set_track_prepare();

Handing the object pointer to the function spares the ugly ifdef.

Also what on earth means set_track_prepare()? If I hadn't seen the
function before then I'd had a hard time to decode this. Self
explanatory function names spare also commenting the obvious. I.e. this
whole thing boils down to:

      debug_save_stack_trace(obj);

or such.

Thanks,

        tglx
