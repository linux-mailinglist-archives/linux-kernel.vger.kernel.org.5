Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151377D8327
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbjJZMtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344972AbjJZMtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:49:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC26210A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:48:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF58C433C8;
        Thu, 26 Oct 2023 12:48:08 +0000 (UTC)
Date:   Thu, 26 Oct 2023 08:48:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20231026084807.3d50aee9@gandalf.local.home>
In-Reply-To: <20231026075016.GC15694@google.com>
References: <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
        <87edj64rj1.fsf@oracle.com>
        <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
        <87zg1u1h5t.fsf@oracle.com>
        <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
        <20230911150410.GC9098@noisy.programming.kicks-ass.net>
        <87h6o01w1a.fsf@oracle.com>
        <20230912082606.GB35261@noisy.programming.kicks-ass.net>
        <87cyyfxd4k.ffs@tglx>
        <20231024103426.4074d319@gandalf.local.home>
        <20231026075016.GC15694@google.com>
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

On Thu, 26 Oct 2023 16:50:16 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> > The goal is to prevent a thread / vCPU being preempted while holding a lock
> > or resource that other threads / vCPUs will want. That is, prevent
> > contention, as that's usually the biggest issue with performance in user
> > space and VMs.  
> 
> I think some time ago we tried to check guest's preempt count on each vm-exit
> and we'd vm-enter if guest exited from a critical section (those that bump
> preempt count) so that it can hopefully finish whatever is was going to
> do and vmexit again. We didn't look into covering guest's RCU read-side
> critical sections.
> 
> Can you educate me, is your PoC significantly different from guest preempt
> count check?

No, it's probably very similar. Just the mechanism to allow it to run
longer may be different.

-- Steve
