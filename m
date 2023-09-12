Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FCD79C816
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjILHVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjILHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:21:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD3AE73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SQh3rTelxPqFb429u0G0UHU1c75sTLGZsPlbJ9GGmsI=; b=EueUI5PKXyFfELDlL1PaAzAmY6
        3Nt3ZDLV38T9rxIVVMl25sdBylDO1mCOwt4KQ7ueqmQvGXQm6mTUCN6LAxajvrJC4L3sbEzMkGhGQ
        sirKmDRr2OvWoV4oAbp4e4R3aGadv0+R3LznfBtDZrABzAVYKJLcyZJzTvYV1sQDe9cRlSpKFQmIu
        QxxL5DoQ2nor98afWkmNf+ZEnOrQ8se0EhzJupPG3KVDLnUxveRY0kRDDSOLERj5vVzSWfYHEAjPD
        6iwLuVQ4/3IfAVx53B9iaCjG8GNpZbqQ6eqqB1DEbIrSfXgeLl6mfh631FlX61Mir15IR98B+EI2b
        OxDnSQFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfxh7-005v6Q-2K;
        Tue, 12 Sep 2023 07:20:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD506300348; Tue, 12 Sep 2023 09:20:22 +0200 (CEST)
Date:   Tue, 12 Sep 2023 09:20:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230912072022.GA35261@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <20230911124856.453fba22@gandalf.local.home>
 <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
 <CAHk-=whc0Jsji_h-vLyDLT6Q-NCjSTMOg9qXACmoPZOdWqMovg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whc0Jsji_h-vLyDLT6Q-NCjSTMOg9qXACmoPZOdWqMovg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:16:18PM -0700, Linus Torvalds wrote:
> On Mon, 11 Sept 2023 at 13:50, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Except we've actually been *adding* to this whole mess, rather than
> > removing it. So we have actively *expanded* on that preemption choice
> > with PREEMPT_DYNAMIC.
> 
> Actually, that config option makes no sense.
> 
> It makes the sched_cond() behavior conditional with a static call.
> 
> But all the *real* overhead is still there and unconditional (ie all
> the preempt count updates and the "did it go down to zero and we need
> to check" code).
> 
> That just seems stupid. It seems to have all the overhead of a
> preemptible kernel, just not doing the preemption.
> 
> So I must be mis-reading this, or just missing something important.
> 
> The real cost seems to be
> 
>    PREEMPT_BUILD -> PREEMPTION -> PREEMPT_COUNT
> 
> and PREEMPT vs PREEMPT_DYNAMIC makes no difference to that, since both
> will end up with that, and thus both cases will have all the spinlock
> preempt count stuff.
> 
> There must be some non-preempt_count cost that people worry about.
> 
> Or maybe I'm just mis-reading the Kconfig stuff entirely. That's
> possible, because this seems *so* pointless to me.
> 
> Somebody please hit me with a clue-bat to the noggin.

Well, I was about to reply to your previous email explaining this, but
this one time I did read more email..

Yes, PREEMPT_DYNAMIC has all the preempt count twiddling and only nops
out the schedule()/cond_resched() calls where appropriate.

This work was done by a distro (SuSE) and if they're willing to ship
this I'm thinking the overheads are acceptable to them.

For a significant number of workloads the real overhead is the extra
preepmtions themselves more than the counting -- but yes, the counting
is measurable, but probably in the noise compared to other some of the
other horrible things we have done the past years.

Anyway, if distros are fine shipping with PREEMPT_DYNAMIC, then yes,
deleting the other options are definitely an option.
