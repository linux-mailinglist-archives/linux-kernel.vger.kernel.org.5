Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2279C2AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbjILCXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbjILCX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:23:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F113C468
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:47:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7878FC4160E;
        Mon, 11 Sep 2023 23:16:07 +0000 (UTC)
Date:   Mon, 11 Sep 2023 19:16:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230911191623.3408d66d@gandalf.local.home>
In-Reply-To: <877cowz4pk.fsf@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
        <20230830184958.2333078-8-ankur.a.arora@oracle.com>
        <20230908070258.GA19320@noisy.programming.kicks-ass.net>
        <87zg1v3xxh.fsf@oracle.com>
        <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
        <87edj64rj1.fsf@oracle.com>
        <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
        <20230911124856.453fba22@gandalf.local.home>
        <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
        <20230911182012.7f1f35c1@gandalf.local.home>
        <877cowz4pk.fsf@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 16:10:31 -0700
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> An even crazier version of that idea would be to have
> preempt_disable/enable() demarcate regions, and the compiler putting all
> of the preemption disabled region out-of-line to a special section.
> Seems to me, that then we could do away to preempt_enable/disable()?
> (Ignoring the preempt_count used in hardirq etc.)
> 

I thought about this too, but wasn't sure if it would be easier or harder
to implement. This would still require the duplicate functions (which I
guess would be the most difficult part).

> This would allow preemption always, unless executing in the
> preemption-disabled section.
> 
> Though I don't have any intuition for how much extra call overhead this
> would add.

I don't think this version would have as high of an overhead. You would get
a direct jump (which isn't bad as all speculation knows exactly where to
look), and it would improve the look up. No table, just a simple range
check.

-- Steve
