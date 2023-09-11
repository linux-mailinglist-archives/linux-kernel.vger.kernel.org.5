Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F69279B058
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350022AbjIKVfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbjIKPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:05:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D098E40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/tHifxU4D/kPyGjpOI02IN1gWwytnQQSgtFJSuo6bxE=; b=Za0ofSf5X9r5Y5JVDdtrBM2RMz
        H++Qqgf2yVdOQBA5J9bgHFhGyM9HPz2P93Q+n4bV0oQma2kd+pVFS7/LhJ4I/nIirRQW0yqPN8MYH
        izYtoJu/JrBguKJORrMBgoT4lvzjQlTsiGjGKTildbb+YRFHuLfVylnawjRmwz3/6p+JebFBC18+I
        1mrgz+/DbDWwgKWVLijXJ77+2KG1sSTAtmRhrOUsX1s4c3fmNZ71F61gccbpcwhWeVTkan54CRhOp
        13a7usPu2pKE9dINl8TnBTS8KKDJZkLs9xfxYtMqtWpkjUoM6Q9xjkAdZjxAGIG3GFawsmFJMGvLw
        lw5KVIMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfiSP-0054Av-0c;
        Mon, 11 Sep 2023 15:04:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45BA43005B2; Mon, 11 Sep 2023 17:04:10 +0200 (CEST)
Date:   Mon, 11 Sep 2023 17:04:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230911150410.GC9098@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 11:32:32AM -0700, Linus Torvalds wrote:

> I was hoping that we'd have some generic way to deal with this where
> we could just say "this thing is reschedulable", and get rid of - or
> at least not increasingly add to - the cond_resched() mess.

Isn't that called PREEMPT=y ? That tracks precisely all the constraints
required to know when/if we can preempt.

The whole voluntary preempt model is basically the traditional
co-operative preemption model and that fully relies on manual yields.

The problem with the REP prefix (and Xen hypercalls) is that
they're long running instructions and it becomes fundamentally
impossible to put a cond_resched() in.

> Yes. I'm starting to think that that the only sane solution is to
> limit cases that can do this a lot, and the "instruciton pointer
> region" approach would certainly work.

From a code locality / I-cache POV, I think a sorted list of
(non overlapping) ranges might be best.
