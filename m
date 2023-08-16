Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7420177D6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbjHPAQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbjHPAQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:16:09 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 167C71986
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:16:05 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-f0-64dc1542ce1b
Date:   Wed, 16 Aug 2023 09:13:07 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20230816001307.GA44941@system.software.com>
References: <20230804061850.21498-1-byungchul@sk.com>
 <20230804061850.21498-3-byungchul@sk.com>
 <877cpx9jsx.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cpx9jsx.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXC9ZZnoa6T6J0Ug2t7NCzmrF/DZvFiQzuj
        xdf1v5gtnn7qY7G4vGsOm8W9Nf9ZLc7vWstqsWPpPiaL67seMloc7z3AZPH7B1B2zhQri5Oz
        JrM48Hos2FTqsXmFlsfiPS+ZPDat6mTz2PRpErvHiRm/WTx2PrT0mHcy0OP9vqtsHlt/2Xl8
        3iTn8W7+W7YAnigum5TUnMyy1CJ9uwSujFW3N7AWtOlUPJ5/ibGBca1iFyMnh4SAicSMc0uY
        YOzHM5vZQWwWAVWJo+1NLCA2m4C6xI0bP5lBbBEBDYlPC5eD1TALbGOSWHDPAcQWFoiROLHl
        M9gcXgELiT0tj4BsLg4hgamMEnPmbWGGSAhKnJz5hAWiWUvixr+XQEUcQLa0xPJ/HCBhTgE7
        ibULL4CViwooSxzYdhxsjoTAfzaJ2Zf3sUIcKilxcMUNlgmMArOQjJ2FZOwshLELGJlXMQpl
        5pXlJmbmmOhlVOZlVugl5+duYgTG1LLaP9E7GD9dCD7EKMDBqMTDy7DwdooQa2JZcWXuIUYJ
        DmYlEd4e3lspQrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODil
        GhglnAoOSRS3Hw59fiLtZOEJI6vdf/fJuqnwX7jxcsY9j9XsuyrWdF3q83eYt3HaI6WZN5xX
        Ly3x9zFxqT33aUEG0zZOv/abK9Y96J+5bj57bK6xcqcYf2zMjtr8mRtfCHuXfgg02XJxevXP
        yjiTySuPLX8gHLer+5z+RAbuT2l3ohak/2z6H3VXiaU4I9FQi7moOBEA+lBfq6UCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsXC5WfdrOskeifF4MIHCYs569ewWbzY0M5o
        8XX9L2aLp5/6WCwOzz3JanF51xw2i3tr/rNanN+1ltVix9J9TBbXdz1ktDjee4DJ4vcPoOyc
        KVYWJ2dNZnHg81iwqdRj8wotj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOkx72Sgx/t9V9k8
        Fr/4wOSx9Zedx+dNch7v5r9lC+CN4rJJSc3JLEst0rdL4MpYdXsDa0GbTsXj+ZcYGxjXKnYx
        cnJICJhIPJ7ZzA5iswioShxtb2IBsdkE1CVu3PjJDGKLCGhIfFq4HKyGWWAbk8SCew4gtrBA
        jMSJLZ+ZQGxeAQuJPS2PgGwuDiGBqYwSc+ZtYYZICEqcnPmEBaJZS+LGv5dARRxAtrTE8n8c
        IGFOATuJtQsvgJWLCihLHNh2nGkCI+8sJN2zkHTPQuhewMi8ilEkM68sNzEzx1SvODujMi+z
        Qi85P3cTIzBCltX+mbiD8ctl90OMAhyMSjy8DAtvpwixJpYVV+YeYpTgYFYS4e3hvZUixJuS
        WFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwOh7Iel8tO2HlfWi
        Uk2NvsIXPrREsVd2vxe6484dtrTF9aGM74Zarc+Ss9o4KidkNvIVu1nqJPd6xL836Z72h3/t
        6/3yupLnTk2WSme0fnpT8seud0c9tsc/tFi5j/fAjqRopR2PzuYnP7FYzbZf6qaGS/bzNRsz
        30S2dxt/eGky8cLpxvQ9NUosxRmJhlrMRcWJAOfD40uMAgAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:27:26AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
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
> >    1. For the folios that have only non-writable TLB entries, prevent
> >       TLB flush by keeping both source and destination of folios during
> >       migration, which will be handled later at a better time.
> >
> >    2. When any non-writable TLB entry changes to writable e.g. through
> >       fault handler, give up CONFIG_MIGRC mechanism so as to perform
> >       TLB flush required right away.
> >
> >    3. TLB flushes can be skipped if all TLB flushes required to free the
> >       duplicated folios have been done by any reason, which doesn't have
> >       to be done from migrations.
> >
> >    4. Adjust watermark check routine, __zone_watermark_ok(), with the
> >       number of duplicated folios because those folios can be freed
> >       and obtained right away through appropreate TLB flushes.
> >
> >    5. Perform TLB flushes and free the duplicated folios pending the
> >       flushes if page allocation routine is in trouble due to memory
> >       pressure, even more aggresively for high order allocation.
> 
> Is the optimization restricted for page migration only?  Can it be used
> for other places?  Like page reclaiming?

Just to make sure, are you talking about the (5) description? For now,
it's performed at the beginning of __alloc_pages_slowpath(), say, before
page recaiming. Do you think it'd be meaningful to perform it during page
reclaiming? Or do you mean something else?

> > The measurement result:
> >
> >    Architecture - x86_64
> >    QEMU - kvm enabled, host cpu, 2nodes((4cpus, 2GB)+(cpuless, 6GB))
> >    Linux Kernel - v6.4, numa balancing tiering on, demotion enabled
> >    Benchmark - XSBench with no parameter changed
> >
> >    run 'perf stat' using events:
> >    (FYI, process wide result ~= system wide result(-a option))
> >       1) itlb.itlb_flush
> >       2) tlb_flush.dtlb_thread
> >       3) tlb_flush.stlb_any
> >
> >    run 'cat /proc/vmstat' and pick up:
> >       1) pgdemote_kswapd
> >       2) numa_pages_migrated
> >       3) pgmigrate_success
> >       4) nr_tlb_remote_flush
> >       5) nr_tlb_remote_flush_received
> >       6) nr_tlb_local_flush_all
> >       7) nr_tlb_local_flush_one
> >
> >    BEFORE - mainline v6.4
> >    ==========================================
> >
> >    $ perf stat -e itlb.itlb_flush,tlb_flush.dtlb_thread,tlb_flush.stlb_any ./XSBench
> >
> >    Performance counter stats for './XSBench':
> >
> >       426856       itlb.itlb_flush
> >       6900414      tlb_flush.dtlb_thread
> >       7303137      tlb_flush.stlb_any
> >
> >    33.500486566 seconds time elapsed
> >    92.852128000 seconds user
> >    10.526718000 seconds sys
> >
> >    $ cat /proc/vmstat
> >
> >    ...
> >    pgdemote_kswapd 1052596
> >    numa_pages_migrated 1052359
> >    pgmigrate_success 2161846
> >    nr_tlb_remote_flush 72370
> >    nr_tlb_remote_flush_received 213711
> >    nr_tlb_local_flush_all 3385
> >    nr_tlb_local_flush_one 198679
> >    ...
> >
> >    AFTER - mainline v6.4 + CONFIG_MIGRC
> >    ==========================================
> >
> >    $ perf stat -e itlb.itlb_flush,tlb_flush.dtlb_thread,tlb_flush.stlb_any ./XSBench
> >
> >    Performance counter stats for './XSBench':
> >
> >       179537       itlb.itlb_flush
> >       6131135      tlb_flush.dtlb_thread
> >       6920979      tlb_flush.stlb_any
> 
> It appears that the number of "itlb.itlb_flush" changes much, but not
> for other 2 events.  Because the text segment of the executable file is
> mapped as read-only?  And most other pages are mapped read-write?

Yes, for this benchmarch, XSBench. I didn't noticed that until checking
it using perf event either.

> >    30.396700625 seconds time elapsed
> >    80.331252000 seconds user
> >    10.303761000 seconds sys
> >
> >    $ cat /proc/vmstat
> >
> >    ...
> >    pgdemote_kswapd 1044602
> >    numa_pages_migrated 1044202
> >    pgmigrate_success 2157808
> >    nr_tlb_remote_flush 30453
> >    nr_tlb_remote_flush_received 88840
> >    nr_tlb_local_flush_all 3039
> >    nr_tlb_local_flush_one 198875
> >    ...
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>

[...]

> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 306a3d1a0fa6..3be66d3eabd2 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -228,6 +228,10 @@ struct page {
> >  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> >  	int _last_cpupid;
> >  #endif
> > +#ifdef CONFIG_MIGRC
> > +	struct llist_node migrc_node;
> > +	unsigned int migrc_state;
> > +#endif
> 
> We cannot enlarge "struct page".

This is what I worried about. Do you have a better idea? I don't think
they fit onto page_ext or something.

	Byungchul
