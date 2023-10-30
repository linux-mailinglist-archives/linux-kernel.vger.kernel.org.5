Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534267DBA28
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjJ3Mvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjJ3Mvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:51:45 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52D75C2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:51:38 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-91-653fa6d786d2
Date:   Mon, 30 Oct 2023 21:51:30 +0900
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
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20231030125129.GD81877@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsXC9ZZnke71ZfapBvs2qljMWb+GzeLzhn9s
        Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
        2LxpKrPF7x9AdXOmWFmcnDWZxUHA43trH4vHgk2lHptXaHks3vOSyWPTqk42j02fJrF7vDt3
        jt3jxIzfLB47H1p6zDsZ6PF+31U2j62/7Dw+b5LzeDf/LVsAXxSXTUpqTmZZapG+XQJXRkPv
        VOaCjn6miksTSxoYp15k7GLk5JAQMJGY/7eBtYuRA8y+sMcHJMwioCqxt/ERK4jNJqAucePG
        T2YQW0RAUeLQ/ntgrcwC71glvn/SBLGFBaIlPu19xQ5i8wpYSExr2wdUw8UhJDCVUeLXgfMs
        EAlBiZMzn7BANKtL/Jl3iRlkL7OAtMTyfxwQYXmJ5q2zwXZxCthJ3Dm/mg3EFhVQljiw7TgT
        yEwJgX3sEo/+tbJD3C8pcXDFDZYJjIKzkKyYhWTFLIQVs5CsWMDIsopRKDOvLDcxM8dEL6My
        L7NCLzk/dxMjMGqX1f6J3sH46ULwIUYBDkYlHt4NPfapQqyJZcWVuYcYJTiYlUR4mR1tUoV4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwhnP2FSgalFY+
        7vxV6/u9aMGt7ed7vlcv6Znx6F7b0gTFF8HTalrmTiy+KTrJtD+n8Nq5VQJr7zztvKO+UDK9
        JOPfrGUf9gl7CfHuFFvT9u3TWk25Ca2nt1x9frx7Qsl2qfTd8+dWCRkKSwjPZAlSfK3vKBBw
        kEFHkVsyLfjh5TrHf+zWlltalFiKMxINtZiLihMB94p72dYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC5WfdrHt9mX2qwc/JvBZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
        HO89wGSxedNUZovfP4Dq5kyxsjg5azKLg6DH99Y+Fo8Fm0o9Nq/Q8li85yWTx6ZVnWwemz5N
        Yvd4d+4cu8eJGb9ZPHY+tPSYdzLQ4/2+q2wei198YPLY+svO4/MmOY9389+yBfBHcdmkpOZk
        lqUW6dslcGU09E5lLujoZ6q4NLGkgXHqRcYuRg4OCQETiQt7fLoYOTlYBFQl9jY+YgWx2QTU
        JW7c+MkMYosIKEoc2n+PEcRmFnjHKvH9kyaILSwQLfFp7yt2EJtXwEJiWts+oBouDiGBqYwS
        vw6cZ4FICEqcnPmEBaJZXeLPvEvMIHuZBaQllv/jgAjLSzRvnQ22i1PATuLO+dVsILaogLLE
        gW3HmSYw8s1CMmkWkkmzECbNQjJpASPLKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMAYXFb7
        Z+IOxi+X3Q8xCnAwKvHwbuixTxViTSwrrsw9xCjBwawkwsvsaJMqxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwChjud7K8cS+7LfKP1Rtpr64WLr0p27r
        H7VL6x0WzS5+/Pbzk5eVK4RreBzaFlt8TbLk3LtoG0ey/KPbpcvOLXt7f4G+wP2sB52KETd9
        BGMbWY81TTtXGvR4z9xZppoxiQpX1r565ju7VTp6Wr/VKw617BvzYnZusrKp/Dh9/rdr83+K
        bGqa//eaEktxRqKhFnNRcSIADW9cx70CAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 08:50:20AM +0000, Nadav Amit wrote:
> Hi Byungchul,
> 
> Few more comments. I think I lost concentration towards the end.
> 
> This patch should be broken into multiple patches, I think, and have more
> comments.
> 
> I didn’t thoroughly review the entire “stopping” mechanism and other parts
> of the code.

I really spent a lot of time hesitating whether splitting it or not.
However, the test result cannot be stable without those. I'm still
confused. I think the test result should be stable at each commit,
right?

> > On Oct 30, 2023, at 9:25 AM, Byungchul Park <byungchul@sk.com> wrote:
> > 
> > 
> > 
> > +#ifdef CONFIG_MIGRC
> 
> Do you really need a new config option?

I will remove the config if more guys give the same opinion. Thank you
for the opinion anyway.

> I think you rely on the UBC stuff and that should be the only config
> option you rely on.

CONFIG_64BIT too, for a new page flag.

> > +#else
> > +static inline void arch_migrc_adj(struct arch_tlbflush_unmap_batch *batch, int gen) {}
> > +#endif
> > +
> > static inline bool pte_flags_need_flush(unsigned long oldflags,
> > 					unsigned long newflags,
> > 					bool ignore_access)
> > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > index 314cd9912a88..0bdb617ffe94 100644
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -1219,9 +1219,80 @@ STATIC_NOPV void native_flush_tlb_local(void)
> > 	native_write_cr3(__native_read_cr3());
> > }
> > 
> > +#ifdef CONFIG_MIGRC
> > +DEFINE_PER_CPU(int, migrc_done);
> 
> Any concern about overflow?

No problem because I use the before() funtion below to compare two
int values.

> Following what I read later in the patch, you consider migrc_done as shared.
> If that’s the case you should have used DECLARE_PER_CPU_SHARED_ALIGNED.

Each CPU updates its local migrc_done while any CPU at any time can
happen to read all the CPUs' migrc_done at once. I will change it to
DECLARE_PER_CPU_SHARED_ALIGNED.

> But I am not sure it should be shared, because that’s is used for an
> optimization. See my comment below regarding this matter.
> 
> > +
> > +static inline bool before(int a, int b)
> > +{
> > +	return a - b < 0;
> > +}
> 
> I think you should be able to manage without this function. 

How? AFAIK, generation numbers are usually handled this way. Am I
missing something?

> > +
> > +static inline int migrc_tlb_local_begin(void)
> 
> Usually, it is better to leave it to the compiler to make inline decisions.
> IOW, if there is no really good reason, I wouldn't use “inline" in “.c” files.

Hm.. Okay I will.

> > +{
> > +	int ret = atomic_read(&migrc_gen);
> > +
> > +	/*
> > +	 * The following order should be guaranteed:
> > +	 *
> > +	 *    1. A migrc's request is queued at migration.
> > +	 *    2. Each CPU performs __flush_tlb_local().
> > +	 *    3. Marks this CPU has performed the TLB flush after 1.
> 
> (3) is not clear to me, specifically what “after 1” means.

It means 'whether TLB flush on this CPU required by a migrc's request
has been performed *since* the request was queued?'.

> > +	 *
> > +	 * To achieve that, a kind of timestamp, migrc_gen was
> > +	 * introduced to track the the order but conservatively, that
> > +	 * is, it doesn't care whether TLB flush is performed more than
> > +	 * it's needed but should guarantee TLB flush has been performed
> > +	 * after the timestamp in migrc_done.
> > +	 *
> > +	 * 1 is done by migrc_unmap_done() and migrc_req_end().
> > +	 * 2 is done by __flush_tlb_local().
> > +	 * 3 is done by migrc_tlb_local_begin() and migrc_tlb_local_end().
> > +	 *
> > +	 * FYI, an example that should avoid is:
> 
> FYI?
> 
> > +	 *
> > +	 *    1. Performs __flush_tlb_local().
> > +	 *    2. A migrc's request is queued at migration.
> > +	 *    3. Marks this CPU has performed the TLB flush after 2(?).
> 
> I think this example is not needed. But the comment can be improved.

I also think this is not necessary but I added it for better
understanding. So you are asking me to improve the comment right? Lemme
try it.

> > +	 *
> > +	 * XXX: barrier() would be sufficient if the architecture
> > +	 * already quarantees the order between memory access to
> > +	 * migrc_gen and TLB flush.
> > +	 */
> 
> Since UBC is used by two architectures IIRC, then is it needed or not?
> Having an unnecessary smp_mb() is not great.

Totally right.

> On x86 the memory write and the TLB flush are ordered. I think you also

What about a memory read and TLB flush? If yes too, then I can use
barrier() instead of smp_mb(). Thanks a lot!

> regard the remote TLB flush and those should also be ordered (IIUC).
> 
> > +	smp_mb();
> > +
> > +	return ret;
> > +}
> > +
> > +static inline void migrc_tlb_local_end(int gen)
> > +{
> > +	/*
> > +	 * XXX: barrier() would be sufficient if the architecture
> > +	 * quarantees the order between TLB flush and memory access to
> > +	 * migrc_done.
> > +	 */
> > +	smp_mb();
> > +
> > +	if (before(READ_ONCE(*this_cpu_ptr(&migrc_done)), gen))
> 
> I have no idea why READ_ONCE() is needed here, and the fact that you think
> it is needed is a bit concerning.

I was worried if we can quarantee the read *actually* accesses the
memory every time when repeatedly getting here. However, yeah.. I don't
have to.. I think the compilers would work well for that. I will remove
it. Thank you.

> > +		WRITE_ONCE(*this_cpu_ptr(&migrc_done), gen);
> > +}
> > +#else
> > +static inline int migrc_tlb_local_begin(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void migrc_tlb_local_end(int gen)
> > +{
> > +}
> > +#endif
> > +
> > void flush_tlb_local(void)
> > {
> > +	unsigned int gen;
> > +
> > +	gen = migrc_tlb_local_begin();
> > 	__flush_tlb_local();
> > +	migrc_tlb_local_end(gen);
> > }
> > 
> > /*
> > @@ -1246,6 +1317,21 @@ void __flush_tlb_all(void)
> > }
> > EXPORT_SYMBOL_GPL(__flush_tlb_all);
> > 
> > +#ifdef CONFIG_MIGRC
> > +/*
> > + * Skip CPUs that have already performed TLB flushes required, which is
> > + * tracked by migrc_gen and migrc_done.
> > + */
> > +void arch_migrc_adj(struct arch_tlbflush_unmap_batch *batch, int gen)
> > +{
> > +	int cpu;
> > +
> > +	for_each_cpu(cpu, &batch->cpumask)
> > +		if (!before(READ_ONCE(*per_cpu_ptr(&migrc_done, cpu)), gen))
> > +			cpumask_clear_cpu(cpu, &batch->cpumask);
> 
> This is an optimization, and I think it should have gone into a different patch
> with separate performance benefit evaluation. Accessing remote CPUs caches to
> decide whether to flush the remote TLB is a performance tradeoff, so this change
> might not always be a win.

Right. I will.

> > +}
> > +#endif
> > +
> > void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> > {
> > 	struct flush_tlb_info *info;
> > @@ -1274,6 +1360,11 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> > 	put_cpu();
> > }
> > 
> > +void arch_tlbbatch_clean(struct arch_tlbflush_unmap_batch *batch)
> 
> arch_tlbbatch_clear() perhaps? Or maybe even better name that describes what
> it does in a higher level (i.e., when it should be used?)

I use this at each preparation phase when I want to gather batched
information e.g. to gather which CPUs need TLB flush.

arch_tlbbatch_init()
arch_tlbbatch_clear()
arch_tlbbatch_reset()
arch_tlbbatch_?()

> > +{
> > +	cpumask_clear(&batch->cpumask);
> > +}
> > +
> > void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
> > 			struct arch_tlbflush_unmap_batch *bsrc)
> > {
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index bf5d0b1b16f4..ddefe6033b66 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4062,4 +4062,29 @@ static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> > 
> > #endif
> > 
> > +#ifdef CONFIG_MIGRC
> > +void migrc_init_page(struct page *p);
> > +void migrc_unpend_folio(struct folio *f);
> > +bool migrc_pending_folio(struct folio *f);
> > +void migrc_shrink(struct llist_head *h);
> > +bool migrc_try_flush_free_folios(nodemask_t *nodes);
> > +void fold_ubc_nowr_to_migrc(void);
> > +void free_migrc_req(struct migrc_req *req);
> > +int migrc_pending_nr_in_zone(struct zone *z);
> > +void migrc_stop_pending(void);
> > +void migrc_resume_pending(void);
> 
> How about some comments to describe when each of those should be used?

Sounds great. I will add comments.

> And do they need to be in mm.h or can they be in mm/internal.h ?

Otherwise, architecture code like x86 cannot use these functions.

> > +extern atomic_t migrc_gen;
> > +#else
> > +static inline void migrc_init_page(struct page *p) {}
> > +static inline void migrc_unpend_folio(struct folio *f) {}
> > +static inline bool migrc_pending_folio(struct folio *f) { return false; }
> > +static inline void migrc_shrink(struct llist_head *h) {}
> > +static inline bool migrc_try_flush_free_folios(nodemask_t *nodes) { return false; }
> > +static inline void fold_ubc_nowr_to_migrc(void) {}
> > +static inline void free_migrc_req(struct migrc_req *req) {}
> > +static inline int migrc_pending_nr_in_zone(struct zone *z) { return 0; }
> > +static inline void migrc_stop_pending(void) {}
> > +static inline void migrc_resume_pending(void) {}
> > +#endif
> > #endif /* _LINUX_MM_H */
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 36c5b43999e6..55350f1d0db2 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -101,6 +101,13 @@ struct page {
> > 				/* Or, free page */
> > 				struct list_head buddy_list;
> > 				struct list_head pcp_list;
> > +#ifdef CONFIG_MIGRC
> > +				/*
> > +				 * Hang onto migrc's request queues,
> > +				 * waiting for TLB flushes.
> > +				 */
> > +				struct llist_node migrc_node;
> > +#endif
> 
> Any reason for the use of llist?

For lockless design at the beginning.. but for now.. you are right. I
don't have to keep it as llist. I will change it so as to use lru for
that purpose instead.

I'm suprised a lot how much you understand the code. Respect.

> > 			};
> > 			/* See page-flags.h for PAGE_MAPPING_FLAGS */
> > 			struct address_space *mapping;
> > @@ -306,6 +313,13 @@ struct folio {
> > 	/* private: */
> > 				};
> > 	/* public: */
> > +#ifdef CONFIG_MIGRC
> > +				/*
> > +				 * Hang onto migrc's request queues,
> > +				 * waiting for TLB flushes.
> > +				 */
> > +				struct llist_node migrc_node;
> > +#endif
> > 			};
> > 			struct address_space *mapping;
> > 			pgoff_t index;
> > @@ -1372,4 +1386,39 @@ enum {
> > 	/* See also internal only FOLL flags in mm/internal.h */
> > };
> > 
> > +#ifdef CONFIG_MIGRC
> > +struct migrc_req {
> > +	/*
> > +	 * folios pending for TLB flush
> > +	 */
> > +	struct llist_head folios;
> > +
> > +	/*
> > +	 * the last folio in 'struct llist_head folios'
> > +	 */
> > +	struct llist_node *last;
> 
> Sounds like some unconventional synchronization scheme is going to come
> later. Sounds like trouble...

I don't think so. What would make trouble with this? Anyway, I wouldn't
need this anymore if I use list_head instead of llist.

> > +
> > +	/*
> > +	 * for hanging to migrc's request queue, migrc_reqs
> > +	 */
> > +	struct llist_node llnode;
> > +
> > +	/*
> > +	 * architecture specific batch data
> > +	 */
> > +	struct arch_tlbflush_unmap_batch arch;
> > +
> > +	/*
> > +	 * timestamp when hanging to migrc's request queue, migrc_reqs
> > +	 */
> > +	int gen;
> > +
> > +	/*
> > +	 * associated numa node
> > +	 */
> > +	int nid;
> > +};
> > +#else
> > +struct migrc_req {};
> > +#endif
> > #endif /* _LINUX_MM_TYPES_H */
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 4106fbc5b4b3..4e78d1c9ceb2 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -980,6 +980,9 @@ struct zone {
> > 	/* Zone statistics */
> > 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
> > 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
> > +#ifdef CONFIG_MIGRC
> > +	atomic_t		migrc_pending_nr;
> > +#endif
> > } ____cacheline_internodealigned_in_smp;
> > 
> > enum pgdat_flags {
> > @@ -1398,6 +1401,10 @@ typedef struct pglist_data {
> > #ifdef CONFIG_MEMORY_FAILURE
> > 	struct memory_failure_stats mf_stats;
> > #endif
> > +#ifdef CONFIG_MIGRC
> > +	atomic_t migrc_pending_nr;
> > +	struct llist_head migrc_reqs;
> > +#endif
> > } pg_data_t;
> > 
> > #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 5c02720c53a5..1ca2ac91aa14 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -135,6 +135,9 @@ enum pageflags {
> > #ifdef CONFIG_ARCH_USES_PG_ARCH_X
> > 	PG_arch_2,
> > 	PG_arch_3,
> > +#endif
> > +#ifdef CONFIG_MIGRC
> > +	PG_migrc,		/* Page has its copy under migrc's control */
> 
> Well, you know that’s not great.

Yeah. I really didn't want to add this. Any idea to distinguish folios
that have their copies in migrc's pending list from others?

Migrc needs to initiate TLB flush needed when facing do_wp_page() fault
handler that chages any mapping associated to those folios under migrc's
control, from wp permission to writable.

> > #endif
> > 	__NR_PAGEFLAGS,
> > 
> > @@ -589,6 +592,10 @@ TESTCLEARFLAG(Young, young, PF_ANY)
> > PAGEFLAG(Idle, idle, PF_ANY)
> > #endif
> > 
> > +#ifdef CONFIG_MIGRC
> > +PAGEFLAG(Migrc, migrc, PF_ANY)
> > +#endif
> > +
> > /*
> >  * PageReported() is used to track reported free pages within the Buddy
> >  * allocator. We can use the non-atomic version of the test and set
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 63189c023357..b7c402850b2f 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1325,6 +1325,14 @@ struct task_struct {
> > 
> > 	struct tlbflush_unmap_batch	tlb_ubc;
> > 	struct tlbflush_unmap_batch	tlb_ubc_nowr;
> > +#ifdef CONFIG_MIGRC
> > +	/*
> > +	 * Temporarily used while a migration is on processing before
> > +	 * hanging to the associated numa node at the end of the
> > +	 * migration.
> > +	 */
> > +	struct migrc_req		*mreq;
> 
> Why is this indirection needed?

To gather folios in the local context without any synchronization like
tlb_ubc. Or I need to pass the pointer to a ton of functions as an
additional parameter but it looks worse. I guess that's why tlb_ubc is
used that way too.

> > +#endif
> > 
> > 	/* Cache last used pipe for splice(): */
> > 	struct pipe_inode_info		*splice_pipe;
> > diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> > index 1478b9dd05fa..85b3b8859bc8 100644
> > --- a/include/trace/events/mmflags.h
> > +++ b/include/trace/events/mmflags.h
> > @@ -95,6 +95,12 @@
> > #define IF_HAVE_PG_ARCH_X(_name)
> > #endif
> > 
> > +#ifdef CONFIG_MIGRC
> > +#define IF_HAVE_PG_MIGRC(_name) ,{1UL << PG_##_name, __stringify(_name)}
> > +#else
> > +#define IF_HAVE_PG_MIGRC(_name)
> > +#endif
> > +
> > #define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }
> > 
> > #define __def_pageflag_names						\
> > @@ -125,7 +131,8 @@ IF_HAVE_PG_HWPOISON(hwpoison)						\
> > IF_HAVE_PG_IDLE(idle)							\
> > IF_HAVE_PG_IDLE(young)							\
> > IF_HAVE_PG_ARCH_X(arch_2)						\
> > -IF_HAVE_PG_ARCH_X(arch_3)
> > +IF_HAVE_PG_ARCH_X(arch_3)						\
> > +IF_HAVE_PG_MIGRC(migrc)
> > 
> > #define show_page_flags(flags)						\
> > 	(flags) ? __print_flags(flags, "|",				\
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 6d35728b94b2..4d88dab52059 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -908,6 +908,20 @@ config NUMA_BALANCING_DEFAULT_ENABLED
> > 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
> > 	  machine.
> > 
> > +config MIGRC
> > +	bool "Deferring TLB flush by keeping read copies on migration"
> > +	depends on ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> > +	depends on NUMA_BALANCING
> > +	depends on 64BIT
> > +	default n
> > +	help
> > +	  TLB flush is necessary when PTE changes by migration. However,
> > +	  TLB flush can be deferred if both copies of the src page and
> > +	  the dst page are kept until TLB flush if they are non-writable.
> > +	  System performance will be improved especially in case that
> > +	  promotion and demotion types of migrations are heavily
> > +	  happening.
> 
> I don’t think users should have any control over this feature.
> 
> > +
> > menuconfig CGROUPS
> > 	bool "Control Group support"
> > 	select KERNFS
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 6c264d2f969c..75dc48b6e15f 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3359,6 +3359,19 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> > 	if (vmf->page)
> > 		folio = page_folio(vmf->page);
> > 
> > +	/*
> > +	 * This folio has its read copy to prevent inconsistency while
> > +	 * deferring TLB flushes. However, the problem might arise if
> > +	 * it's going to become writable.
> > +	 *
> > +	 * To prevent it, give up the deferring TLB flushes and perform
> > +	 * TLB flush right away.
> > +	 */
> > +	if (folio && migrc_pending_folio(folio)) {
> > +		migrc_unpend_folio(folio);
> > +		migrc_try_flush_free_folios(NULL);
> 
> So many potential function calls… Probably they should have been combined
> into one and at least migrc_pending_folio() should have been an inline
> function in the header.

I will try to change it as you mention.

> > +	}
> > +
> 
> What about mprotect? I thought David has changed it so it can set writable
> PTEs.

I will check it out.

> > 	/*
> > 	 * Shared mapping: we are guaranteed to have VM_WRITE and
> > 	 * FAULT_FLAG_WRITE set at this point.
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 2053b54556ca..76278eca8417 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -57,6 +57,204 @@
> > 
> > #include "internal.h"
> > 
> > +#ifdef CONFIG_MIGRC
> > +
> > +atomic_t migrc_gen;
> 
> This would overflow.

It's safe. As I mentioned, I use before() function to compare two
generation numbers.

> > +
> > +static struct migrc_req *alloc_migrc_req(void)
> > +{
> > +	return kmalloc(sizeof(struct migrc_req), GFP_KERNEL);
> > +}
> > +
> > +void free_migrc_req(struct migrc_req *req)
> > +{
> > +	kfree(req);
> > +}
> > +
> > +void migrc_init_page(struct page *p)
> > +{
> > +	ClearPageMigrc(p);
> > +}
> 
> So many wrappers for short functions. A bit of unnecessary overheads.

Hmm.. Okay. Lemme try to get rid of unnecessary wrappers.

> > +
> > +/*
> > + * One of migrc's core functions that frees up all the folios in a
> > + * migrc's pending queue.
> > + *
> > + * The list should be isolated before.
> > + */
> > +void migrc_shrink(struct llist_head *h)
> 
> I am not sure by the name of it that it does what I originally thought it does
> seeing the word “shrink” (I thought it should be a memory shrinker to free memory
> when too many pages got their TLB flush deferred).
> 
> I don’t think it should be exposed for someone to call it without actual TLB
> flush.

I might need a better name. I will rename it.

> > +{
> > +	struct folio *f, *f2;
> > +	struct llist_node *n;
> > +
> > +	n = llist_del_all(h);
> > +	llist_for_each_entry_safe(f, f2, n, migrc_node) {
> > +		struct pglist_data *node;
> > +		struct zone *zone;
> > +
> > +		node = NODE_DATA(folio_nid(f));
> > +		zone = page_zone(&f->page);
> > +		atomic_dec(&node->migrc_pending_nr);
> > +		atomic_dec(&zone->migrc_pending_nr);
> 
> Why do you need both?

node->migrc_pending_nr is not used anymore in the current version. I
will remove it.

> > +		folio_put(f);
> > +	}
> > +}
> > +
> > +void migrc_unpend_folio(struct folio *f)
> > +{
> > +	folio_clear_migrc(f);
> > +}
> > +
> > +bool migrc_pending_folio(struct folio *f)
> > +{
> > +	return folio_test_migrc(f);
> > +}
> > +
> > +/*
> > + * Marks the folios as being under migrc's control.
> > + */
> > +static void migrc_mark_folios(struct folio *fsrc, struct folio *fdst)
> > +{
> > +	if (!current->mreq)
> > +		return;
> > +
> > +	folio_get(fsrc);
> > +	folio_set_migrc(fsrc);
> > +	folio_set_migrc(fdst);
> > +	fold_ubc_nowr_to_migrc();
> > +}
> > +
> > +static bool migrc_marked_folios(struct folio *fsrc, struct folio *fdst)
> > +{
> > +	/*
> > +	 * XXX: The condition below is so tricky. Please suggest a
> > +	 * better idea to determine if it's under migrc's control.
> > +	 */
> > +	return migrc_pending_folio(fsrc) && migrc_pending_folio(fdst);
> 
> Tricky == racy?

No. I meant the way to implement is tricky. 

> I do not follow the ordering that ensures a migrated page would not
> become writable before the migration is over. Perhaps a comment on what
> guarantees the order would help.

I will check it and add comments explaining it.

> > +}
> > +
> > +static void migrc_undo_folios(struct folio *fsrc, struct folio *fdst)
> > +{
> > +	/*
> > +	 * TLB flushes needed are already done at this moment so the
> > +	 * flag doesn't have to be kept.
> > +	 */
> > +	folio_clear_migrc(fsrc);
> > +	folio_clear_migrc(fdst);
> > +
> > +	folio_put(fsrc);
> > +}
> > +
> > +static void migrc_expand_req(struct folio *f)
> > +{
> > +	struct migrc_req *req = current->mreq;
> > +	struct pglist_data *node;
> > +	struct zone *zone;
> > +
> > +	if (!req)
> > +		return;
> > +
> > +	/*
> > +	 * Focusing on numa migration, all the nids in a req are same.
> > +	 */
> > +	if (req->nid == -1)
> > +		req->nid = folio_nid(f);
> > +	else if (WARN_ON(req->nid != folio_nid(f)))
> > +		return;
> > +
> > +	if (llist_add(&f->migrc_node, &req->folios))
> > +		req->last = &f->migrc_node;
> > +
> > +	node = NODE_DATA(folio_nid(f));
> > +	zone = page_zone(&f->page);
> > +	atomic_inc(&node->migrc_pending_nr);
> > +	atomic_inc(&zone->migrc_pending_nr);
> > +}
> > +
> > +static void migrc_unmap_done(void)
> > +{
> > +	if (current->mreq)
> > +		current->mreq->gen = atomic_inc_return(&migrc_gen);
> > +}
> > +
> > +/*
> > + * Prepares for gathering folios pending for TLB flushes, try to
> > + * allocate objects needed, initialize them and make them ready.
> > + */
> > +static void migrc_req_start(void)
> > +{
> > +	struct migrc_req *req;
> > +
> > +	if (WARN_ON(current->mreq))
> > +		return;
> > +
> > +	req = alloc_migrc_req();
> > +	if (!req)
> > +		return;
> > +
> > +	arch_tlbbatch_clean(&req->arch);
> > +	init_llist_head(&req->folios);
> > +	req->last = NULL;
> > +	req->nid = -1;
> > +	current->mreq = req;
> > +}
> > +
> > +/*
> > + * Hang the request with the collected folios to 'migrc_reqs' llist of
> > + * the corresponding node.
> > + */
> > +static void migrc_req_end_if_started(void)
> > +{
> > +	struct migrc_req *req = current->mreq;
> > +
> > +	if (!req)
> > +		return;
> > +
> > +	if (llist_empty(&req->folios))
> > +		free_migrc_req(req);
> > +	else
> > +		llist_add(&req->llnode, &NODE_DATA(req->nid)->migrc_reqs);
> > +
> > +	current->mreq = NULL;
> > +}
> > +
> > +int migrc_pending_nr_in_zone(struct zone *z)
> > +{
> > +	return atomic_read(&z->migrc_pending_nr);
> > +}
> > +
> > +static atomic_t migrc_stop = ATOMIC_INIT(0);
> 
> Comments?

I will add comments on it.

> > +
> > +void migrc_stop_pending(void)
> > +{
> > +	atomic_inc(&migrc_stop);
> > +}
> > +
> > +void migrc_resume_pending(void)
> > +{
> > +	atomic_dec(&migrc_stop);
> > +}
> > +
> > +static inline bool migrc_stopped_pending(void)
> > +{
> > +	return !!atomic_read(&migrc_stop);
> > +}
> > +
> > +static bool can_migrc_system(void)
> > +{
> > +	return !migrc_stopped_pending();
> > +}
> > +#else
> > +static inline void migrc_mark_folios(struct folio *fsrc, struct folio *fdst) {}
> > +static inline bool migrc_marked_folios(struct folio *fsrc, struct folio *fdst) { return false; }
> > +static inline void migrc_undo_folios(struct folio *fsrc, struct folio *fdst) {}
> > +static inline void migrc_expand_req(struct folio *f) {}
> > +static inline void migrc_unmap_done(void) {}
> > +static inline void migrc_req_start(void) {}
> > +static inline void migrc_req_end_if_started(void) {}
> > +static inline bool can_migrc_system(void) { return false; }
> > +#endif
> > +
> > bool isolate_movable_page(struct page *page, isolate_mode_t mode)
> > {
> > 	struct folio *folio = folio_get_nontail_page(page);
> > @@ -379,6 +577,7 @@ static int folio_expected_refs(struct address_space *mapping,
> > 		struct folio *folio)
> > {
> > 	int refs = 1;
> > +
> > 	if (!mapping)
> > 		return refs;
> > 
> > @@ -406,6 +605,13 @@ int folio_migrate_mapping(struct address_space *mapping,
> > 	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
> > 	long nr = folio_nr_pages(folio);
> > 
> > +	/*
> > +	 * Migrc mechanism increases the reference count to defer
> > +	 * freeing up folios until a better time.
> > +	 */
> > +	if (migrc_marked_folios(folio, newfolio))
> > +		expected_count++;
> > +
> > 	if (!mapping) {
> > 		/* Anonymous page without mapping */
> > 		if (folio_ref_count(folio) != expected_count)
> > @@ -1620,16 +1826,30 @@ static int migrate_pages_batch(struct list_head *from,
> > 	LIST_HEAD(unmap_folios);
> > 	LIST_HEAD(dst_folios);
> > 	bool nosplit = (reason == MR_NUMA_MISPLACED);
> > +	bool migrc_cond1;
> 
> Try to find better names.

Okay.

> > 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
> > 			!list_empty(from) && !list_is_singular(from));
> > 
> > +	/*
> > +	 * For now, apply migrc only to numa migration.
> > +	 */
> > +	migrc_cond1 = can_migrc_system() &&
> > +		      ((reason == MR_DEMOTION && current_is_kswapd()) ||
> > +		      (reason == MR_NUMA_MISPLACED));
> > +
> > +	if (migrc_cond1)
> > +		migrc_req_start();
> > 	for (pass = 0; pass < nr_pass && retry; pass++) {
> > 		retry = 0;
> > 		thp_retry = 0;
> > 		nr_retry_pages = 0;
> > 
> > 		list_for_each_entry_safe(folio, folio2, from, lru) {
> > +			int nr_required;
> > +			bool migrc_cond2;
> > +			bool migrc;
> > +
> > 			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
> > 			nr_pages = folio_nr_pages(folio);
> > 
> > @@ -1657,9 +1877,34 @@ static int migrate_pages_batch(struct list_head *from,
> > 				continue;
> > 			}
> > 
> > +			/*
> > +			 * In case that the system is in high memory
> > +			 * pressure, let's stop migrc from working and
> > +			 * free up all the folios in the pending queues
> > +			 * not to impact the system.
> > +			 */
> > +			if (unlikely(migrc_cond1 && !can_migrc_system())) {
> > +				migrc_cond1 = false;
> > +				migrc_req_end_if_started();
> > +				migrc_try_flush_free_folios(NULL);
> > +			}
> > +
> > +			nr_required = nr_flush_required();
> > 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
> > 					private, folio, &dst, mode, reason,
> > 					ret_folios);
> > +			/*
> > +			 * migrc_cond2 will be true only if:
> > +			 *
> > +			 *    1. There's no writable mapping at all
> > +			 *    2. There's read only mapping found
> > +			 *    3. Not already under migrc's control
> > +			 */
> > +			migrc_cond2 = nr_required == nr_flush_required() &&
> > +				      nr_flush_required_nowr() &&
> > +				      !migrc_pending_folio(folio);
> > +			migrc = migrc_cond1 && migrc_cond2;
> > +
> > 			/*
> > 			 * The rules are:
> > 			 *	Success: folio will be freed
> > @@ -1720,6 +1965,9 @@ static int migrate_pages_batch(struct list_head *from,
> > 			case MIGRATEPAGE_UNMAP:
> > 				list_move_tail(&folio->lru, &unmap_folios);
> > 				list_add_tail(&dst->lru, &dst_folios);
> > +
> > +				if (migrc)
> > +					migrc_mark_folios(folio, dst);
> > 				break;
> > 			default:
> > 				/*
> > @@ -1733,12 +1981,24 @@ static int migrate_pages_batch(struct list_head *from,
> > 				stats->nr_failed_pages += nr_pages;
> > 				break;
> > 			}
> > +
> > +			/*
> > +			 * Done with the current folio. Fold the ro
> > +			 * batch data gathered, to the normal batch.
> > +			 */
> > +			fold_ubc_nowr();
> > 		}
> > 	}
> > 	nr_failed += retry;
> > 	stats->nr_thp_failed += thp_retry;
> > 	stats->nr_failed_pages += nr_retry_pages;
> > move:
> > +	/*
> > +	 * Generate a new timestamp that will be used to filter out
> > +	 * CPUs that have already performed TLB flushes needed.
> > +	 */
> > +	migrc_unmap_done();
> > +
> > 	/* Flush TLBs for all unmapped folios */
> > 	try_to_unmap_flush();
> > 
> > @@ -1774,6 +2034,9 @@ static int migrate_pages_batch(struct list_head *from,
> > 			case MIGRATEPAGE_SUCCESS:
> > 				stats->nr_succeeded += nr_pages;
> > 				stats->nr_thp_succeeded += is_thp;
> > +
> > +				if (migrc_marked_folios(folio, dst))
> > +					migrc_expand_req(folio);
> > 				break;
> > 			default:
> > 				nr_failed++;
> > @@ -1791,6 +2054,8 @@ static int migrate_pages_batch(struct list_head *from,
> > 
> > 	rc = rc_saved ? : nr_failed;
> > out:
> > +	migrc_req_end_if_started();
> > +
> > 	/* Cleanup remaining folios */
> > 	dst = list_first_entry(&dst_folios, struct folio, lru);
> > 	dst2 = list_next_entry(dst, lru);
> > @@ -1798,6 +2063,9 @@ static int migrate_pages_batch(struct list_head *from,
> > 		int page_was_mapped = 0;
> > 		struct anon_vma *anon_vma = NULL;
> > 
> > +		if (migrc_marked_folios(folio, dst))
> > +			migrc_undo_folios(folio, dst);
> > +
> > 		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
> > 		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
> > 				       true, ret_folios);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 95546f376302..2fa84c3a9681 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1535,6 +1535,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> > 
> > 	set_page_owner(page, order, gfp_flags);
> > 	page_table_check_alloc(page, order);
> > +
> > +	for (i = 0; i != 1 << order; ++i)
> > +		migrc_init_page(page + i);
> 
> Do we really need an additional atomic operation to clear the page-flag here?

Of course not. I will change it.

> > }
> > 
> > static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
> > @@ -2839,6 +2842,8 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
> > 	long min = mark;
> > 	int o;
> > 
> > +	free_pages += migrc_pending_nr_in_zone(z);
> > +
> > 	/* free_pages may go negative - that's OK */
> > 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
> > 
> > @@ -2933,7 +2938,7 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
> > 		long usable_free;
> > 		long reserved;
> > 
> > -		usable_free = free_pages;
> > +		usable_free = free_pages + migrc_pending_nr_in_zone(z);
> > 		reserved = __zone_watermark_unusable_free(z, 0, alloc_flags);
> > 
> > 		/* reserved may over estimate high-atomic reserves. */
> > @@ -3121,6 +3126,16 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
> > 				       gfp_mask)) {
> > 			int ret;
> > 
> > +			/*
> > +			 * Free the pending folios so that the remaining
> > +			 * code can use them. Check zone_watermark_fast()
> > +			 * again with more accurate stats before going.
> > +			 */
> > +			migrc_try_flush_free_folios(ac->nodemask);
> > +			if (zone_watermark_fast(zone, order, mark,
> > +			    ac->highest_zoneidx, alloc_flags, gfp_mask))
> > +				goto try_this_zone;
> > +
> > 			if (has_unaccepted_memory()) {
> > 				if (try_to_accept_memory(zone, order))
> > 					goto try_this_zone;
> > @@ -3911,6 +3926,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > 	unsigned int cpuset_mems_cookie;
> > 	unsigned int zonelist_iter_cookie;
> > 	int reserve_flags;
> > +	bool migrc_stopped = false;
> > 
> > restart:
> > 	compaction_retries = 0;
> > @@ -4042,6 +4058,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > 	if (page)
> > 		goto got_pg;
> > 
> > +	/*
> > +	 * The system is in very high memory pressure. Stop migrc from
> > +	 * expanding its pending queue and working temporarily.
> > +	 */
> > +	if (!migrc_stopped) {
> > +		migrc_stop_pending();
> > +		migrc_stopped = true;
> > +	}
> > +
> > 	/* Caller is not willing to reclaim, we can't balance anything */
> > 	if (!can_direct_reclaim)
> > 		goto nopage;
> > @@ -4169,6 +4194,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > 	warn_alloc(gfp_mask, ac->nodemask,
> > 			"page allocation failure: order:%u", order);
> > got_pg:
> > +	if (migrc_stopped)
> > +		migrc_resume_pending();
> > 	return page;
> > }
> > 
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index a045f3b57c60..d0fa7bf66e70 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -606,6 +606,82 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
> > 
> > #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> > 
> > +#ifdef CONFIG_MIGRC
> > +/*
> > + * Gather folios and CPUs in cpumask to handle.
> > + */
> > +static void migrc_gather(struct llist_head *folios,
> > +			 struct arch_tlbflush_unmap_batch *arch,
> > +			 struct llist_head *reqs)
> > +{
> > +	struct llist_node *reqs_nodes;
> > +	struct migrc_req *req;
> > +	struct migrc_req *req2;
> > +
> > +	reqs_nodes = llist_del_all(reqs);
> > +	if (!reqs_nodes)
> > +		return;
> > +
> > +	/*
> > +	 * TODO: Optimize the time complexity.
> > +	 */
> 
> Please mark the patch as an RFC until no more TODOs.

I removed RFC because those are longterm TODOs that are not essential.

> > +	llist_for_each_entry_safe(req, req2, reqs_nodes, llnode) {
> > +		struct llist_node *n;
> > +
> > +		arch_migrc_adj(&req->arch, req->gen);
> > +		arch_tlbbatch_fold(arch, &req->arch);
> > +
> > +		n = llist_del_all(&req->folios);
> > +		llist_add_batch(n, req->last, folios);
> > +		free_migrc_req(req);
> > +	}
> > +}
> > +
> > +bool migrc_try_flush_free_folios(nodemask_t *nodes)
> > +{
> > +	struct arch_tlbflush_unmap_batch arch;
> > +	LLIST_HEAD(folios);
> 
> Again, I don’t understand why llist is needed.

Yep. I will change it to list_head. Thanks!

Appreciate all your great comments.

	Byungchul
