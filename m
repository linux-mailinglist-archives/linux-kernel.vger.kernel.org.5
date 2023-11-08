Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963187E527D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjKHJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:15:30 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF30F10A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:15:27 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r0eeO-00FKJO-MD; Wed, 08 Nov 2023 17:15:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 08 Nov 2023 17:15:11 +0800
Date:   Wed, 8 Nov 2023 17:15:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>
Subject: Re: [RFC PATCH 71/86] treewide: lib: remove cond_resched()
Message-ID: <ZUtRn7oJLL5fisco@gondor.apana.org.au>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-15-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107230822.371443-15-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:08:07PM -0800, Ankur Arora wrote:
> There are broadly three sets of uses of cond_resched():
> 
> 1.  Calls to cond_resched() out of the goodness of our heart,
>     otherwise known as avoiding lockup splats.
> 
> 2.  Open coded variants of cond_resched_lock() which call
>     cond_resched().
> 
> 3.  Retry or error handling loops, where cond_resched() is used as a
>     quick alternative to spinning in a tight-loop.
> 
> When running under a full preemption model, the cond_resched() reduces
> to a NOP (not even a barrier) so removing it obviously cannot matter.
> 
> But considering only voluntary preemption models (for say code that
> has been mostly tested under those), for set-1 and set-2 the
> scheduler can now preempt kernel tasks running beyond their time
> quanta anywhere they are preemptible() [1]. Which removes any need
> for these explicitly placed scheduling points.
> 
> The cond_resched() calls in set-3 are a little more difficult.
> To start with, given it's NOP character under full preemption, it
> never actually saved us from a tight loop.
> With voluntary preemption, it's not a NOP, but it might as well be --
> for most workloads the scheduler does not have an interminable supply
> of runnable tasks on the runqueue.
> 
> So, cond_resched() is useful to not get softlockup splats, but not
> terribly good for error handling. Ideally, these should be replaced
> with some kind of timed or event wait.
> For now we use cond_resched_stall(), which tries to schedule if
> possible, and executes a cpu_relax() if not.
> 
> Almost all the cond_resched() calls are from set-1. Remove them.
> 
> [1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net> 
> Cc: Kees Cook <keescook@chromium.org> 
> Cc: Eric Dumazet <edumazet@google.com> 
> Cc: Jakub Kicinski <kuba@kernel.org> 
> Cc: Paolo Abeni <pabeni@redhat.com> 
> Cc: Thomas Graf <tgraf@suug.ch>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  lib/crc32test.c          |  2 --
>  lib/crypto/mpi/mpi-pow.c |  1 -
>  lib/memcpy_kunit.c       |  5 -----
>  lib/random32.c           |  1 -
>  lib/rhashtable.c         |  2 --
>  lib/test_bpf.c           |  3 ---
>  lib/test_lockup.c        |  2 +-
>  lib/test_maple_tree.c    |  8 --------
>  lib/test_rhashtable.c    | 10 ----------
>  9 files changed, 1 insertion(+), 33 deletions(-)

Nack.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
