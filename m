Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A879BF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjIKXTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 19:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbjIKW4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 18:56:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE56E8F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:21:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBB5C116AF;
        Mon, 11 Sep 2023 22:19:56 +0000 (UTC)
Date:   Mon, 11 Sep 2023 18:20:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230911182012.7f1f35c1@gandalf.local.home>
In-Reply-To: <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
        <20230830184958.2333078-8-ankur.a.arora@oracle.com>
        <20230908070258.GA19320@noisy.programming.kicks-ass.net>
        <87zg1v3xxh.fsf@oracle.com>
        <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
        <87edj64rj1.fsf@oracle.com>
        <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
        <20230911124856.453fba22@gandalf.local.home>
        <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 13:50:53 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And it seems like it's actually server people who want the "no
> preemption" (and presumably avoid all the preempt count stuff entirely
> - it's not necessarily the *preemption* that is the cost, it's the
> incessant preempt count updates)

I'm sure there's some overhead with the preemption itself. With the
meltdown/spectre mitigations going into and out of the kernel does add some
more overhead. And finishing a system call before being preempted may give
some performance benefits for some micro benchmark out there.

Going out on a crazy idea, I wonder if we could get the compiler to help us
here. As all preempt disabled locations are static, and as for functions,
they can be called with preemption enabled or disabled. Would it be
possible for the compiler to mark all locations that need preemption disabled?

If a function is called in a preempt disabled section and also called in a
preempt enable section, it could make two versions of the function (one
where preemption is disabled and one where it is enabled).

Then all we would need is a look up table to know if preemption is safe or
not by looking at the instruction pointer.

Yes, I know this is kind of a wild idea, but I do believe it is possible.

The compiler wouldn't need to know of the concept of "preemption" just a
"make this location special, and keep functions called by that location
special and duplicate them if they are are called outside of this special
section".

 ;-)

-- Steve
