Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ABF7DB807
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjJ3K0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3K0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:26:41 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8997109
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:26:37 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-e4-653f84dca000
Date:   Mon, 30 Oct 2023 19:26:31 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 1/3] mm/rmap: Recognize non-writable TLB entries during TLB
 batch flush
Message-ID: <20231030102631.GB81877@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-2-byungchul@sk.com>
 <1DB097E6-6585-4D10-95C9-7BAA5A622B7E@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1DB097E6-6585-4D10-95C9-7BAA5A622B7E@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsXC9ZZnoe7dFvtUg1Zjiznr17BZfN7wj83i
        xYZ2Rouv638xWzz91MdicXnXHDaLe2v+s1qc37WW1WLH0n1MFpcOLGCyuL7rIaPF8d4DTBab
        N01ltvj9A6huzhQri5OzJrM4CHh8b+1j8ViwqdRj8wotj8V7XjJ5bFrVyeax6dMkdo93586x
        e5yY8ZvFY+dDS495JwM93u+7yuax9Zedx+dNch7v5r9lC+CL4rJJSc3JLEst0rdL4Mr4sZu1
        YKpyxbnDe5kaGG9IdzFyckgImEj0bmpmhLEPfL4DZrMIqEqc+rSWHcRmE1CXuHHjJzOILSKg
        KHFo/z2wGmaBd6wS3z9pgtjCAlESX2ZuB4vzClhIPN76haWLkYtDSGAqo8SjrglsEAlBiZMz
        n7BANKtL/Jl3CWgoB5AtLbH8HwdEWF6ieetssDCngJ3Et9YIkLCogLLEgW3HmUBGSghsY5e4
        drCRHeJmSYmDK26wTGAUnIVkwywkG2YhbJiFZMMCRpZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmb
        GIHxuqz2T/QOxk8Xgg8xCnAwKvHwBoTbpQqxJpYVV+YeYpTgYFYS4WV2tEkV4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwMhzVVVU7ONmtbrfedLfz7/d
        oRjgtuzwXtHF8+RqZB8Wm4iePXUozOfUrsXuZ2J0Orqf73dnmM1ZdqD+7Dr/krYLa/T0xZT3
        ngsTl17NsZr187WTDa+zef7VL8kJM/zzOfNYR7vF1R/ud+va7gvq7lrr65Nw4tlhJqljLccl
        NUM+b9I5Z7erUVCJpTgj0VCLuag4EQDalPfl0wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsXC5WfdrHunxT7V4P8MJYs569ewWXze8I/N
        4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
        jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
        sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPxS8+MHls/WXn8XmTnMe7+W/ZAvijuGxSUnMy
        y1KL9O0SuDJ+7GYtmKpcce7wXqYGxhvSXYycHBICJhIHPt9hBLFZBFQlTn1ayw5iswmoS9y4
        8ZMZxBYRUJQ4tP8eWA2zwDtWie+fNEFsYYEoiS8zt4PFeQUsJB5v/cLSxcjFISQwlVHiUdcE
        NoiEoMTJmU9YIJrVJf7MuwQ0lAPIlpZY/o8DIiwv0bx1NliYU8BO4ltrBEhYVEBZ4sC240wT
        GPlmIRk0C8mgWQiDZiEZtICRZRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZg/C2r/TNxB+OX
        y+6HGAU4GJV4eAPC7VKFWBPLiitzDzFKcDArifAyO9qkCvGmJFZWpRblxxeV5qQWH2KU5mBR
        Euf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTC2+X1ofPlSZzfHlw9eWZZZ6iVfKncfnqC4yvgQ
        37F4R6HgA3+SRIOfv+uQ2uLbqPJ60vxbisuW/JhdG+ixIzg4yDZfdp/L2bytJ6OP2TUsM1T2
        iXjgmzBtparB8Z8XTh4vMnNJTd5yVWKdipiWcXug9vW23Ts1M4oK70aLTuNmuxP2nj/Du1iJ
        pTgj0VCLuag4EQB+QdrXuwIAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:52:05AM +0000, Nadav Amit wrote:
> 
> Below are some points you might find useful:

Thank you!

> > +
> > /*
> >  * Blindly accessing user memory from NMI context can be dangerous
> >  * if we're in the middle of switching the current user task or
> > diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
> > index aa44fff8bb9d..35ba9425d48d 100644
> > --- a/include/linux/mm_types_task.h
> > +++ b/include/linux/mm_types_task.h
> > @@ -59,8 +59,8 @@ struct tlbflush_unmap_batch {
> > 	 */
> > 	struct arch_tlbflush_unmap_batch arch;
> > 
> > -	/* True if a flush is needed. */
> > -	bool flush_required;
> > +	/* The number of flush requested. */
> 
> Number of what? Base pages I presume.

How many times set_tlb_ubc_flush_pending() has been called.

> > +	int nr_flush_required;
> 
> Perhaps unsigned would be better suited?

Will change it to unsigned.

> > 	/*
> > 	 * If true then the PTE was dirty when unmapped. The entry must be
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 77f01ac385f7..63189c023357 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1324,6 +1324,7 @@ struct task_struct {
> > #endif
> > 
> > 	struct tlbflush_unmap_batch	tlb_ubc;
> > +	struct tlbflush_unmap_batch	tlb_ubc_nowr;
> 
> tlb_ubc_nowr is - I think - less informative the tlb_ubc_ro (and a comment
> would be useful).

At the beginning, I named it tlb_ubc_ro but.. I forgot why I changed it
to tlb_ubc_nowr but.. I will change it back and add a comment on it.

> > +
> > +int nr_flush_required(void)
> > +{
> > +	return current->tlb_ubc.nr_flush_required;
> > +}
> > +
> > +int nr_flush_required_nowr(void)
> > +{
> > +	return current->tlb_ubc_nowr.nr_flush_required;
> > +}
> 
> I haven’t gone through the users of these functions yet, as they are not included
> in this patch (which is usually not great).

Right. I will place these two on another patch that uses the functions.
Or need to add an explanation in this commit message.

> Anyhow, it might be a bit wasteful to have a function call for such a function. See
> if it is possible to avoid that call.

I will move them to mm/internal.h with inline added if possible.

> > +
> > /*
> >  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
> >  * important if a PTE was dirty when it was unmapped that it's flushed
> > @@ -615,11 +641,12 @@ void try_to_unmap_flush(void)
> > {
> > 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
> > 
> > -	if (!tlb_ubc->flush_required)
> > +	fold_ubc_nowr();
> > +	if (!tlb_ubc->nr_flush_required)
> > 		return;
> > 
> > 	arch_tlbbatch_flush(&tlb_ubc->arch);
> > -	tlb_ubc->flush_required = false;
> > +	tlb_ubc->nr_flush_required = 0;
> > 	tlb_ubc->writable = false;
> > }
> > 
> > @@ -627,8 +654,9 @@ void try_to_unmap_flush(void)
> > void try_to_unmap_flush_dirty(void)
> > {
> > 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
> > +	struct tlbflush_unmap_batch *tlb_ubc_nowr = &current->tlb_ubc_nowr;
> > 
> > -	if (tlb_ubc->writable)
> > +	if (tlb_ubc->writable || tlb_ubc_nowr->writable)
> > 		try_to_unmap_flush();
> > }
> > 
> > @@ -645,15 +673,16 @@ void try_to_unmap_flush_dirty(void)
> > static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
> > 				      unsigned long uaddr)
> > {
> > -	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
> > +	struct tlbflush_unmap_batch *tlb_ubc;
> > 	int batch;
> > 	bool writable = pte_dirty(pteval);
> > 
> > 	if (!pte_accessible(mm, pteval))
> > 		return;
> > 
> > +	tlb_ubc = pte_write(pteval) || writable ? &current->tlb_ubc : &current->tlb_ubc_nowr;
> 
> Using the ternary operator here is a bit confusing. You can use an “if”
> instead or if you mind is set doing it this way at least make it easier to
> read:
> 
> 	tlb_ubc = (pte_write(pteval) || writable) ? &current->tlb_ubc :
> 						    &current->tlb_ubc_nowr;

You are right. I should change it that way. Thanks.

> And of course, add a comment.

Okay. Also will add a comment.

> > 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
> > -	tlb_ubc->flush_required = true;
> > +	tlb_ubc->nr_flush_required += 1;
> 
> Presumably overflow is impossible for other reasons, but something like that
> worries me.

Agree with you. Lemme think it more and fix it.

Thank you.

	Byungchul

