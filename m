Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D487A9F04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjIUUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjIUUP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:15:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7F258C35
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+u8izbFoLuSllLM08vr13/32lSsiAXqYRiVuRRRYEco=; b=PMfJj393Wz9Y804NH1wze3V/3m
        YH94qJXXDishs6R1SVcVEn9yysvAEeQfoSHI+2GctOlEkNA7UUatT/vLnY0q51P93fbF13Mhmren+
        I+HNxsXPYzx/vylWKvSTasRGz/zvoP6cACVn/WmTEV4XU88++Y4IB89e1ygs93+RnIUFPgr16KxyK
        ojWg5jgy6QWOsZZXC1LRUXRP7CI8DwgV/xKDFS/HVMv+sse/fOWNEdh6Me2gZjGF2pyjCw2fp8LcW
        cYYikEL8LUoIBawaCDDaZU2lC0eW1vjOoqARBSUWWoPlszeDVRu6k61oTG7eIT4Yr61Xm2zQTII3Q
        TZXHYyRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjEKk-00FDkE-1Z;
        Thu, 21 Sep 2023 07:42:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 985EA3002E3; Thu, 21 Sep 2023 09:42:47 +0200 (CEST)
Date:   Thu, 21 Sep 2023 09:42:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Message-ID: <20230921074247.GC14803@noisy.programming.kicks-ass.net>
References: <20220909192848.963982-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909192848.963982-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 03:28:48PM -0400, Waiman Long wrote:
> It was found that a circular lock dependency can happen with the
> following locking sequence:
> 
>    +--> (console_sem).lock --> &p->pi_lock --> &rq->__lock --+
>    |                                                         |
>    +---------------------------------------------------------+
> 
> The &p->pi_lock --> &rq->__lock sequence is very common in all the
> task_rq_lock() calls.
> 
> The &rq->__lock --> (console_sem).lock sequence happens when the
> scheduler code calling printk() or more likely the various WARN*()
> macros while holding the rq lock. The (console_sem).lock is actually
> a raw spinlock guarding the semaphore. In the particular lockdep splat
> that I saw, it was caused by SCHED_WARN_ON() call in update_rq_clock().
> To work around this locking sequence, we may have to ban all WARN*()
> calls when the rq lock is held, which may be too restrictive, or we
> may have to add a WARN_DEFERRED() call and modify all the call sites
> to use it.

No, this is all because printk() is pure garbage -- but I believe it's
being worked on.

And I despise that whole deferred thing -- that's just worse garbage.

If you map printk to early_printk none of this is a problem (and this is
what i've been doing for something close to a decade).

Printk should not do synchronous, or in-context, printing to non-atomic
consoles. Doubly so when atomic console are actually available.

As long as it does this printk is fundamentally unreliable and any of
these hacks are just that.

> Even then, a deferred printk or WARN function may still call
> console_trylock() which may, in turn, calls up_console_sem() leading
> to this locking sequence.
> 
> The other ((console_sem).lock --> &p->pi_lock) locking sequence
> was caused by the fact that the semaphore up() function is calling
> wake_up_process() while holding the semaphore raw spinlock. This lockiing
> sequence can be easily eliminated by moving the wake_up_processs()
> call out of the raw spinlock critical section using wake_q which is
> what this patch implements. That is the easiest and the most certain
> way to break this circular locking sequence.

So I don't mind the patch, but I hate everything about your
justification for it.
