Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D026B7EF759
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjKQSOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKQSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:14:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D5D7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l5xyyENtc79OotoxV9LHjiMneBMu5Xck1CB+EZ0bjwU=; b=zu9pH4Ejkh/pZtjC4eEu73ZVtf
        JNIQj2L5WL3GWMP2m07ki/P9wNscHIDzZiVi/Hshu6tSDjGZVUOsiaRaIsjh9KY8AP23XJjYm4Anp
        riVDbqpAp5Pyfy+qDXLUwWZnmzmYgkkpTbuWbJs/2XgkhmG2mIs78U5fYhoZPBTUyjFSGEWjaF6P4
        Ij/gJVxJRs/ayqSLoeQNgSHV2OwNzEqPyxjVR1H1xvbIF1PHsSjauyWIa06Nlm7+c2stbsPX5z8zz
        WcD54Z4DaUycECX+nFupQ4/ouqt8y9RnTxiJY2JE0O8fBck0fcfI2EnLVcvD6gxSYpyAYAfvhaaOT
        M36nrUWA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r43MP-0074kn-28;
        Fri, 17 Nov 2023 18:14:33 +0000
Date:   Fri, 17 Nov 2023 10:14:33 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
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
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 66/86] treewide: kernel: remove cond_resched()
Message-ID: <ZVetiSheCDo49Zqm@bombadil.infradead.org>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-10-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107230822.371443-10-ankur.a.arora@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:08:02PM -0800, Ankur Arora wrote:
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
> All of these are from set-1 except for the retry loops in
> task_function_call() or the mutex testing logic.
> 
> Replace these with cond_resched_stall(). The others can be removed.
> 
> [1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/
> 
> Cc: Tejun Heo <tj@kernel.org> 
> Cc: Zefan Li <lizefan.x@bytedance.com> 
> Cc: Johannes Weiner <hannes@cmpxchg.org> 
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com> 
> Cc: Eric Biederman <ebiederm@xmission.com> 
> Cc: Will Deacon <will@kernel.org> 
> Cc: Luis Chamberlain <mcgrof@kernel.org> 
> Cc: Oleg Nesterov <oleg@redhat.com> 
> Cc: Juri Lelli <juri.lelli@redhat.com> 
> Cc: Vincent Guittot <vincent.guittot@linaro.org> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Sounds like the sort of test which should be put into linux-next to get
test coverage right away. To see what really blows up.

 Luis
