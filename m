Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790927DF785
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjKBQUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjKBQT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:19:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D0513D;
        Thu,  2 Nov 2023 09:19:52 -0700 (PDT)
Date:   Thu, 2 Nov 2023 17:19:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698941991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvFTteVbImxdySo7jFzcYlYpzDRgsvn6yjCySuFzuTA=;
        b=W4tBgJ39n+qAv+2rq/lBP9MtwEYtvfMqMMY5ZPBN6Ml1YrfSv8jqA3iBTY3pWUROgl2uk2
        gBkcEXmhUy7OUo7QJNzo0GxSIK7vOWuU3oRxEtqZ9MYo62hrMs565r+7ALTpDG6137GXZQ
        JMz18ogKSAEYdVecdAFXfx6emFN5W6Bzyljt5KYp7UvNsz2caQekcU6SSz/vzg83CkF/3i
        y7UNTgZoRxExA3AGPXKeofTBUPe6vZolDA3vUkLbwjDhE3QU11FEu5NKeft/Pw0GgX0Qv5
        SnaB2jSmF8HzAKHwVrTUfL47Af53eLQ4n1T4HQNwi60Th9C/NqPkgifkv1hGUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698941991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvFTteVbImxdySo7jFzcYlYpzDRgsvn6yjCySuFzuTA=;
        b=kqzWP+CBNF9w1Lcir2gCG+4QbYWBS0ORPIlD4oJyaKXzYzgn3OtC02M0sNlsF9OsPfN9LL
        D3AYxz34xQfDWzDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH] sched/fair: Make the BW replenish timer expire in
 hardirq context for PREEMPT_RT
Message-ID: <20231102161949.IdSqSK2E@linutronix.de>
References: <20231030145104.4107573-1-vschneid@redhat.com>
 <20231031160120.GE15024@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231031160120.GE15024@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-31 17:01:20 [+0100], Peter Zijlstra wrote:
> On Mon, Oct 30, 2023 at 03:51:04PM +0100, Valentin Schneider wrote:
> > task would get PI'd to FIFO1 (ktimers' default priority). Unfortunately,
> > rwlocks cannot sanely do PI as they allow multiple readers.
=E2=80=A6

> I'm thinking working on that is saner than adding this O(n) cgroup loop
> to hard-irq context. Hmm?

I have plans to get rid of the softirq issue and the argument for "bad"
or inefficient rwlocks is usually "get rid of rwlocks then". So=E2=80=A6

Then I looked at the patch and it only swapped the flag nothing else and
this hardly works. So I looked at sched_cfs_period_timer():
| static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
| {
=E2=80=A6
|         raw_spin_lock_irqsave(&cfs_b->lock, flags);
=E2=80=A6
|         raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
|=20
|         return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
|}

Judging by this, the whole callback runs already with disabled
interrupts. At least now it enabled interrupts if multiple callbacks are
invoked=E2=80=A6

Sebastian
