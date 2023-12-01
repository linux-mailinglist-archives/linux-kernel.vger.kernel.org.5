Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09EA801112
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378124AbjLAQQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjLAQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:16:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43C41984
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:16:43 -0800 (PST)
Date:   Fri, 1 Dec 2023 17:16:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701447401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4xmHyaJusRIT36tyCzHmnCsKAKSQ/hclkqlNOGFGCiw=;
        b=Ek+h7a2QXmC+3ZoEXGpTomIISbUu0f5dlhAqzR6pnT00YjvEVju0fEYyf9AwIshht29WFY
        1qi5Bc+TrZne2wHO84D4pG4QeWITBegZ04wUZSILQltXqWG9BiFvXIrrehIj4OzjFjOTEp
        m/isiVD1jdYZODaJcK4FccfV7K079jEHDiHactj5EPdC9OKvVA/LW/PLoUvpB8vRiiLFv7
        conwHdxmC/wKIgRgfqZfSrKCnwsO7284a7Y2IkisROR2JXJV/hx8oMVuCjW95ESU1C/Wpl
        /+ZopKt5kOO9kagX+cMIGG2G5Kfd3Etvng8aXc9i7gqRwLzW6Xh/WLHUXXy/rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701447402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4xmHyaJusRIT36tyCzHmnCsKAKSQ/hclkqlNOGFGCiw=;
        b=mkT+iN3VHCTuOzmYuzZiKoLGWIG8PcIHqy/NNiG4z4W6Ysg9+biyz1FYBPMgX2hhWreR9U
        5aPKjj2Ek+f4zMBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zyhtheonly@gmail.com, zyhtheonly@yeah.net
Cc:     tglx@linutronix.de, rostedt@goodmis.org, mingo@redhat.com,
        Venkatesh Pallipadi <venki@google.com>, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
Subject: Re: [PATCH v3] sched/cputime: let ktimers align with ksoftirqd in
 accounting CPUTIME_SOFTIRQ
Message-ID: <20231201161640.Z0cJLUi3@linutronix.de>
References: <20231201073240.T9bFNCkU@linutronix.de>
 <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 16:05:41 [+0800], tiozhang wrote:
> In CONFIG_PREEMPT_RT kernel, ktimers also calls __do_softirq,
> so when accounting CPUTIME_SOFTIRQ, ktimers need to be accounted the same
> as ksoftirqd.

I still don't understand why this is a good thing and why want to align
it with ksoftirqd and what breaks if we don't.

This "skip ksoftirqd for accounting" has been added in commit
	b52bfee445d31 ("sched: Add IRQ_TIME_ACCOUNTING, finer accounting of irq ti=
me")

At this point (v2.6.37) it had no accounting of time spent in ksoftirqd as
SOFTIRQ time. This was then fixed/ added by commit
	414bee9ba613a ("softirqs: Account ksoftirqd time as cpustat softirq")

which went in v2.6.39. It started accounting it when it was noticed by
the tick. So it is less accurate. The "benefit" seems to be that this
accounting pops up in /proc/stat. As per-CPU or overall.

I *guess* this was to align the softirqs which occur at the end of an
interrupt with those which were outsourced to ksoftirqd because they
took too long. This would patch the wording
	=E2=80=A6 wanted to see more complete solution in not accounting irq
	processing time to tasks at all.
	https://lore.kernel.org/all/1284688596-6731-1-git-send-email-venki@google.=
com/

Or it tried to preserve the current status.

A different account occurs for SOFTIRQs if they occur as port of
hardirq and are maybe deferred to ksoftirqd vs a task raising softirqs
on their own like packet over loopback.
Don't see the benefit that but this is my interpretation based on what
it does.

This was v2.6.39. Since then we got threaded interrupts (also v2.6.39)
or threaded-NAPI which utilise mostly the same mechanism as ksoftirqd
but are treated differently. I don't see why ktimers should align with
ksoftirqd and honestly and I don't understand why ksoftirqd had to be
excluded to in the first place.

Sorry, but I would need to go on than this.

> Signed-off-by: tiozhang <tiozhang@didiglobal.com>

Sebastian
