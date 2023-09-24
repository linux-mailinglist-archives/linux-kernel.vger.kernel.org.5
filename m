Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907917AC5F8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 02:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjIXAKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXAKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 20:10:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898FC136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 17:10:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695514213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=44ZfN8hP0QQtdpjF0Zc3c5fCB9l6TSMIkTAqwLspWJI=;
        b=N6FKUZ+RXWbmWn4kurOuqfbKCsockcm4uIIYqu1EjGyzaHKzGVs1Qvt3F0D0wCFZ2+1We6
        eYTCXK/9zRMCf2ri8uHAWrwLsQJhUeIsfUfoulL3NUK6cp5LRHuOoBW4NrhBSo+pRjLph+
        hKNgEdzbJj8fRg5AoO43panmWiJaNFVKXSU8/FVISVLHY4LCy5GuHg7IGjgZGgddBQLoXi
        B9jINd4NPF53tELMzze3Udxt+G53x40N54THU9TjFRTNVFT/0aEENKytBO2OBJjG+sUuD1
        v891yCL8w0AUa/JbA+yKqA6+6PEDPuhNbMN5ZoUjmnTxptfoqVuQYU7Yn2zpYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695514213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=44ZfN8hP0QQtdpjF0Zc3c5fCB9l6TSMIkTAqwLspWJI=;
        b=cCkfwObGO6HxiffPrS9eGP21T+wj0v1EqCpCfgioWpayKQJh2nutRo46DfHO66bME5o73A
        8ZmzqjjhX3sso2Bw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <87h6nkh5bw.ffs@tglx>
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <87h6nkh5bw.ffs@tglx>
Date:   Sun, 24 Sep 2023 02:10:12 +0200
Message-ID: <87bkdsh1nf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24 2023 at 00:50, Thomas Gleixner wrote:
> On Tue, Sep 19 2023 at 14:30, Thomas Gleixner wrote:
> That's way better because it describes the scope and the task will
> either schedule out in lock() on contention or provide a sensible lazy
> preemption point in preempt_lazy_enable(). It also nests properly:
>
>       preempt_lazy_disable();
>       lock(A);
>       do_stuff()
>         preempt_lazy_disable();
>         lock(B);
>         do_other_stuff();
>         unlock(B);
>         preempt_lazy_enable();
>       unlock(A);
>       preempt_lazy_enable();
>
> So in this case it does not matter wheter do_stuff() is invoked from a
> lock held section or not. The scope which defines the throughput
> relevant hint to the scheduler is correct in any case.

Which also means that automatically injecting it into lock primitives
makes suddenly sense in the same way as the implicit preempt_disable()
in the rw/spinlock primitives does.

Thanks,

        tglx
