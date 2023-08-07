Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8AE7717F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjHGBpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHGBpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:45:13 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7B6C171A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 18:45:10 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-af-64d04ca56cf9
Date:   Mon, 7 Aug 2023 10:42:29 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20230807014229.GB69206@system.software.com>
References: <20230804061850.21498-1-byungchul@sk.com>
 <20230804061850.21498-3-byungchul@sk.com>
 <7023C1AF-6C9B-4544-8EC4-0BB790C1E338@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7023C1AF-6C9B-4544-8EC4-0BB790C1E338@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC9ZZnke4ynwspBl37WC3mrF/DZvFiQzuj
        xdf1v5gtnn7qY7G4vGsOm8W9Nf9ZLc7vWstqsWPpPiaL67seMloc7z3AZPH7B1B2zhQri5Oz
        JrM48Hos2FTqsXmFlsfiPS+ZPDat6mTz2PRpErvHiRm/WTx2PrT0mHcy0OP9vqtsHlt/2Xl8
        3iTn8W7+W7YAnigum5TUnMyy1CJ9uwSujCUPPrMW3DWqeDZnC2MD4zn1LkZODgkBE4mT0/Yz
        wtg7jr5kBrFZBFQkeg52gMXZBNQlbtz4CRYXEVCUOLT/HlicWeAKi8TXeXwgtrBAjMSJLZ+Z
        QGxeAQuJowuvsXYxcnEICUxllLjRfRsqIShxcuYTFohmdYk/8y4BDeUAsqUllv/jgAjLSzRv
        nQ22i1PATmLu1stgraICyhIHth1nApkpIdDPLrFzRxPU0ZISB1fcYJnAKDgLyYpZSFbMQlgx
        C8mKBYwsqxiFMvPKchMzc0z0MirzMiv0kvNzNzECY3BZ7Z/oHYyfLgQfYhTgYFTi4W04fD5F
        iDWxrLgy9xCjBAezkgjvvCdAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NT
        C1KLYLJMHJxSDYyFVi991AqTE8qaTz3au46xec0UsQs+zxkdDKuWJ6rk903Y+7Jd5lrdxFPP
        VS60P3Rcv2779zd/0tex7/u2R87V7y7DzhMT17T0v1E+xDlzzsdeVwM/hnnv7Q5eaPlhV635
        af7RmVn9j77s4LYutXyqNfOa5V12/ZAypll3Nqr4roufIlWo72alxFKckWioxVxUnAgAGiuj
        aL0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXC5WfdrLvU50KKwYRb5hZz1q9hs3ixoZ3R
        4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCyu73rIaHG89wCTxe8fQNk5
        U6wsTs6azOLA57FgU6nH5hVaHov3vGTy2LSqk81j06dJ7B4nZvxm8dj50NJj3slAj/f7rrJ5
        LH7xgclj6y87j8+b5DzezX/LFsAbxWWTkpqTWZZapG+XwJWx5MFn1oK7RhXP5mxhbGA8p97F
        yMkhIWAisePoS2YQm0VARaLnYAcjiM0moC5x48ZPsLiIgKLEof33wOLMAldYJL7O4wOxhQVi
        JE5s+cwEYvMKWEgcXXiNtYuRi0NIYCqjxI3u21AJQYmTM5+wQDSrS/yZdwloKAeQLS2x/B8H
        RFheonnrbLBdnAJ2EnO3XgZrFRVQljiw7TjTBEa+WUgmzUIyaRbCpFlIJi1gZFnFKJKZV5ab
        mJljqlecnVGZl1mhl5yfu4kRGFHLav9M3MH45bL7IUYBDkYlHt6Gw+dThFgTy4orcw8xSnAw
        K4nwznsCFOJNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamCU
        yZobsHP/wS2JZzh1DO/cf7TdQMFSVfNBd5P5pV8z2uc/uGitvLJjiqS8LRdrsdEBiRma3HJu
        d15t/VvNsGLpzaxN16wv9t5+l6++f1GSvRr3+y23ateJP+08tqQn7Lm6SaGplp2/eQPnIblT
        gkLbLn798rV0fTNnuRTrScU5k/Ot1K/+0HRTYinOSDTUYi4qTgQAGQvBOKQCAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:32:30PM +0000, Nadav Amit wrote:
> > On Aug 3, 2023, at 11:18 PM, Byungchul Park <byungchul@sk.com> wrote:
> > 
> > Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
> > 
> > We always face the migration overhead at either promotion or demotion,
> > while working with tiered memory e.g. CXL memory and found out TLB
> > shootdown is a quite big one that is needed to get rid of if possible.
> > 
> > Fortunately, TLB flush can be defered or even skipped if both source and
> > destination of folios during migration are kept until all TLB flushes
> > required will have been done, of course, only if the target PTE entries
> > have read only permission, more precisely speaking, don't have write
> > permission. Otherwise, no doubt the folio might get messed up.
> > 
> > To achieve that:
> > 
> >   1. For the folios that have only non-writable TLB entries, prevent
> >      TLB flush by keeping both source and destination of folios during
> >      migration, which will be handled later at a better time.
> > 
> >   2. When any non-writable TLB entry changes to writable e.g. through
> >      fault handler, give up CONFIG_MIGRC mechanism so as to perform
> >      TLB flush required right away.
> > 
> >   3. TLB flushes can be skipped if all TLB flushes required to free the
> >      duplicated folios have been done by any reason, which doesn't have
> >      to be done from migrations.
> > 
> >   4. Adjust watermark check routine, __zone_watermark_ok(), with the
> >      number of duplicated folios because those folios can be freed
> >      and obtained right away through appropreate TLB flushes.
> > 
> >   5. Perform TLB flushes and free the duplicated folios pending the
> >      flushes if page allocation routine is in trouble due to memory
> >      pressure, even more aggresively for high order allocation.
> 
> So I think that what you want to do may be possible, but I think it worth
> checking once an RFC that can be reviewed is posted. The complexity and
> overheads would then need to be evaluated.
> 
> The patch in its current form, I am afraid, is very very hard to review.
> It is way too big and is missing comments. Having CONFIG_MIGRC makes no

Sorry for that. I will split this patch set into more pieces and try to
add sufficient comments, and then will repost it in the next spin.

> sense (I guess it is intended to be a “chicken-bit”). Variable and

Exactly.

> function names are not informative. The memory barriers are handle

Yeah, 'naming' is the hardest one to do. Lemme try to rename those.

> improperly (please check again the smp_mb__after_atomic() rules).

Thank you. I meant to put a smp_mb() along with atomic_read() after
that, between reading migrc_gen and TLB flush. I will check it more.

> Actually, when it comes to concurrency, there are many things I did not
> understand from a glance at the code when it comes to concurrency: the
> use of llist_add when (I think?) the llist is not shared (I think?); the

A llist isolated for handling TLB flush and freeing folios is a stack
variable so it's not shared. However, there is another type of llist
that is a global llist so as to be shared, that is for collecting
all the requests in the system.

> use of WRITE_ONCE() for synchronization; migrc_gen scheme (and BTW, since
> such a counter might overflow it should be atomic64).

Sure. It would overflow but it's not a big problem because we can
compare between the generation numbers with '(int)(a - b) < 0' trick
unless more than the MAX_INT/2 numbers of requests happen at the same
time. I assumed it's barely gonna happen.

> But much more importantly, going up one level, there are several issues
> that should be addressed/considered/discussed:
> 
> a. It seems to me that when a new PTE is established (e.g., following
>    an mmap()), and there are pending deferred flushes, a full TLB flush
>    would also be required. So your point (2) would need to be extended.

It has nothing to do with tiering migration. So I think It would work as
it was with the original code, say, it would perform TLB flush needed
for the PTE change. I don't think CONFIG_MIGRC needs to consider the
case. Could you explain what would be a probelm in this case in more
detail?

> b. When a reference to the page is taken in other means (get_user_pages()),
>    a TLB flush might also be needed.

All TLB flush would be performed as it was, except TLB flushes at
tiering migration where CONFIG_MIGRC works. I might miss things.. Please
explain in more detail what you think is a problem.

> c. If we start deferring TLB flushes for a long time, and throughout that
>    time many events (TLB flush, page-faults, etc.) might require a *full*
>    TLB flush, that might have negative impact.

I let it work as it was, except tiering migration. It'd help me get you
if you describe in more detail. I might need to make this patch set more
readable first tho. However, I'd like to understand what you are
concerning exactly so that I can answer like either 'you don't have to
worry about that because blur blur' or 'Oh my I will fix it thank you'.

> d. The interactions with other mechanisms that inspect the PTE to make
>    decisions and might not take into account the fact a TLB flush was not
>    done need to be considered. The interaction with mmu_gather has been
>    taken for, but there is a question of whether something here might
>    break it.  

I also think I need to be more careful when it comes to mmu_gather
things. My opinion on this is, it'd be okay becasue CONFIG_MIGRC only
works with tiering migration and let other pathes where TLB flush is
required go as it was. Howerver, it definitely should be considered if
those routines that require TLB flush during tiering migration. Am I
missing something?

> Now there are many things in the patch that need to be addressed and are
> unacceptable in their current form (e.g., migrc_try_flush() flushing
> potentially twice the same cores), but reviewing this patch in its

No. It doens't flush twice cuz it keeps whether each CPU has been TLB
flushed that was requested, or not ;)

> current form is too tedious for me.

I will reform it.

> [ BTW: for future versions, consider cc'ing Peter Zijlstra, Andy
>   Lutomirski and Dave Hansen. ]

I will.

Appreciate all your comments!

	Byungchul
