Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626487A865E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjITOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjITOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:20:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF857AF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:20:23 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695219622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ISU7Z209dvjV/dZTqrULlabBGPAiylPFZlrHnDMrZ8=;
        b=AWvkSQDu9AnCgO9RIwd8Z/iRmk+X7Gk+wXH4UNlQii5SAYs7i1oDRVj6g6W3k0BaFF8yA/
        81+GB0DuGMqtCsHt5g5AVYzG5i2htK1GWNAKAYEm2kQWh8LfB4yRjYzDq5eOkXz1n6V32C
        oECgeqFcADjtpAhrasNvCBT+Bv8vchk8RO2+6l32shvRrog90V0U+GFZtslC2HdhPTURYb
        sU6id9L++FvtIoORMTW3OwL1gRWYp6yygD6w7nI36tBrXwyqgfsTsBmtGgNCW8SkB0yEtZ
        c9EJseo3QCnHIdqua64SZ9kSXtzLQfmKCUF+Ymd/OEITMeFESW2GaJcYC5yMGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695219622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ISU7Z209dvjV/dZTqrULlabBGPAiylPFZlrHnDMrZ8=;
        b=sMKPJAo001hI1432/fllQdoza/Mp/8sd6OQNQs0Q9ek16riZxZkx16AgGhq3lSOr+tpsfy
        qIBINibXGFjF91CQ==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH printk v2 09/11] panic: Add atomic write enforcement to
 oops
In-Reply-To: <ZQrzhh62pDB5yUyi@smile.fi.intel.com>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-10-john.ogness@linutronix.de>
 <ZQrzhh62pDB5yUyi@smile.fi.intel.com>
Date:   Wed, 20 Sep 2023 16:26:12 +0206
Message-ID: <871qetsz8j.fsf@jogness.linutronix.de>
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

On 2023-09-20, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Sep 20, 2023 at 01:14:54AM +0206, John Ogness wrote:
>> Invoke the atomic write enforcement functions for oops to
>> ensure that the information gets out to the consoles.
>> 
>> Since there is no single general function that calls both
>> oops_enter() and oops_exit(), the nesting feature of atomic
>> write sections is taken advantage of in order to guarantee
>> full coverage between the first oops_enter() and the last
>> oops_exit().
>> 
>> It is important to note that if there are any legacy consoles
>> registered, they will be attempting to directly print from the
>> printk-caller context, which may jeopardize the reliability of
>> the atomic consoles. Optimally there should be no legacy
>> consoles registered.
>
> ...
>
>> +	if (atomic_read(&oops_cpu) == smp_processor_id()) {
>> +		oops_nesting--;
>> +		if (oops_nesting == 0) {
>> +			atomic_set(&oops_cpu, -1);
>
> Between read and set the variable can change, can't it?

CPU migration is disabled. @oops_cpu contains the CPU ID of the only CPU
that is printing the oops. (Perhaps the variable should be called
"oops_printing_cpu"?)

If this matches smp_processor_id(), then the current CPU is the only one
that is allowed to change it back to -1. So no, if the first condition
is true, it cannot change before atomic_set(). And if the second
condition is true, this is the only CPU+context that is allowed to
change it back to -1;

> If not, why this variable is atomic then? Or, why it's not a problem?
> If the latter is the case, perhaps a comment to explain this?

If not atomic, it will be a data race since one CPU might be changing
@oops_cpu and another is reading it. For type "int" such a data race
would be fine because it doesn't matter which side of the race the
reader was on, both values will not match the current CPU ID.

The reason that I didn't implement it using cmpxchg(),
data_race(READ_ONCE()), and WRITE_ONCE() is because I once learned that
you should never mix cmpxchg() with READ_ONCE()/WRITE_ONCE() because
there are architectures that do not support cmpxchg() as an atomic
instruction. The answer was always: "use atomic_t instead... that is
what it is for".

But AFAICT for this case it would be fine because obviously cmpxchg()
will not race with itself. And successfully reading a matching CPU ID
means there cannot be any cmpxchg() in progress. And writing only occurs
after seeing a matching CPU ID.

So I can change it from atomic_t to int. Although I do feel like that
might require explanation about why the data race is safe.

Or perhaps it is enough just to have something like this:

/**
 * oops_printing_cpu - The ID of the CPU responsible for printing the
 *                     OOPS message(s) to the consoles.
 *
 * This is atomic_t because multiple CPUs can read this variable
 * simultaneously when exiting OOPS while another CPU can be
 * modifying this variable to begin or end its printing duties.
 */
static atomic_t oops_printing_cpu = ATOMIC_INIT(-1);

John Ogness
