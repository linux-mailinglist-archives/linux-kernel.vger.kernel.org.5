Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856E97E5ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjKHTls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHTlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:41:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA3C2116
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:41:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF815C433C7;
        Wed,  8 Nov 2023 19:41:40 +0000 (UTC)
Date:   Wed, 8 Nov 2023 14:41:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>
Subject: Re: [RFC PATCH 71/86] treewide: lib: remove cond_resched()
Message-ID: <20231108144144.3d257286@gandalf.local.home>
In-Reply-To: <202311081114.0F15C1FB9@keescook>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-15-ankur.a.arora@oracle.com>
        <202311081114.0F15C1FB9@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 11:15:37 -0800
Kees Cook <keescook@chromium.org> wrote:

> FOr the memcpy_kunit.c cases, I don't think there are preemption
> locations in its loops. Perhaps I'm misunderstanding something? Why will
> the memcpy test no longer produce softlockup splats?

This patchset will switch over to a NEED_RESCHED_LAZY routine, so that
VOLUNTARY and NONE preemption models will be forced to preempt if its in
the kernel for too long.

Time slice is over: set NEED_RESCHED_LAZY

For VOLUNTARY and NONE, NEED_RESCHED_LAZY will not preempt the kernel (but
will preempt user space).

If in the kernel for over 1 tick (1ms for 1000Hz, 4ms for 250Hz, etc),
if NEED_RESCHED_LAZY is still set after one tick, then set NEED_RESCHED.

NEED_RESCHED will now schedule in the kernel once it is able to regardless
of preemption model. (PREEMPT_NONE will now use preempt_disable()).

This allows us to get rid of all cond_resched()s throughout the kernel as
this will be the new mechanism to keep from running inside the kernel for
too long. The watchdog is always longer than one tick.

-- Steve
