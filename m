Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D2D7DB704
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjJ3J6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjJ3J62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:58:28 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AF05D4E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:58:09 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-11-653f7e308b6a
Date:   Mon, 30 Oct 2023 18:58:03 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20231030095803.GA81877@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <a8337371-50ed-4618-b48e-78b96d18810f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8337371-50ed-4618-b48e-78b96d18810f@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsXC9ZZnoa5BnX2qwaVfahZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CV8eNm
        G3PBCd2KH0efMzUwblbsYuTkkBAwkXhyZwkrjL338Ww2EJtFQFXiZMs+ZhCbTUBd4saNn2C2
        iICGxKa2DUA2FwezwDsmiXk9T1lAEsIC0RKf9r5iB7F5BSwk2n/tYQcpEhKYyiixc+cxFoiE
        oMTJmU/AbGYBLYkb/14ydTFyANnSEsv/cYCEOQXsJJoefgBbJiqgLHFg23EmkDkSAqvYJWb2
        XmaHuFRS4uCKGywTGAVmIRk7C8nYWQhjFzAyr2IUyswry03MzDHRy6jMy6zQS87P3cQIjMNl
        tX+idzB+uhB8iFGAg1GJhzcg3C5ViDWxrLgy9xCjBAezkggvs6NNqhBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZGO+EdxgKW4r6dfVM7vhc3RTW4Fe53
        2LZuz1fJhbPOR5/kTWLN/f5n8iPhXY+db/xYnLl3h9TqPKtHIpla6kXebNd9zL4/26VyQ3Tx
        8u64jLttoRVXsq/MC3dg5uZYlN7gozivof7eZDnLVMEDYsdSCr83iiUYzvG7yP9dvYRzKvck
        QfbsjC1KLMUZiYZazEXFiQCRJJ3HvwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXC5WfdrGtQZ59qMP+WgMWc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBk/brYxF5zQrfhx9DlTA+NmxS5GTg4JAROJvY9ns4HYLAKqEidb9jGD2GwC6hI3
        bvwEs0UENCQ2tW0Asrk4mAXeMUnM63nKApIQFoiW+LT3FTuIzStgIdH+aw87SJGQwFRGiZ07
        j7FAJAQlTs58AmYzC2hJ3Pj3kqmLkQPIlpZY/o8DJMwpYCfR9PAD2DJRAWWJA9uOM01g5J2F
        pHsWku5ZCN0LGJlXMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBEbVsto/E3cwfrnsfohRgINR
        iYc3INwuVYg1say4MvcQowQHs5IIL7OjTaoQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w1AQh
        gfTEktTs1NSC1CKYLBMHp1QD4x2997G9K6YlL+e8mHLE781K3ZKwQoED6csPF8V2f+W4/Hme
        4oonEhGZXxsnBYSbn397MNJm9hrmL3p/9le+FZjXE7jO0m/SUTaP2F4P/ue57P9nsSf+rftQ
        5P3Qu2zfuQ369qoTpQWm1blUnXGq21m40bNYTzra1S7KJHCJ54Sru6a89fhyQImlOCPRUIu5
        qDgRAPjNvt2mAgAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:00:56AM +0100, David Hildenbrand wrote:
> On 30.10.23 08:25, Byungchul Park wrote:
> > Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
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
> >     1. For the folios that map only to non-writable TLB entries, prevent
> >        TLB flush at migration by keeping both source and destination
> >        folios, which will be handled later at a better time.
> > 
> >     2. When any non-writable TLB entry changes to writable e.g. through
> >        fault handler, give up CONFIG_MIGRC mechanism so as to perform
> >        TLB flush required right away.
> > 
> >     3. Temporarily stop migrc from working when the system is in very
> >        high memory pressure e.g. direct reclaim needed.
> > 
> > The measurement result:
> > 
> >     Architecture - x86_64
> >     QEMU - kvm enabled, host cpu
> >     Numa - 2 nodes (16 CPUs 1GB, no CPUs 8GB)
> >     Linux Kernel - v6.6-rc5, numa balancing tiering on, demotion enabled
> >     Benchmark - XSBench -p 50000000 (-p option makes the runtime longer)
> > 
> >     run 'perf stat' using events:
> >        1) itlb.itlb_flush
> >        2) tlb_flush.dtlb_thread
> >        3) tlb_flush.stlb_any
> >        4) dTLB-load-misses
> >        5) dTLB-store-misses
> >        6) iTLB-load-misses
> > 
> >     run 'cat /proc/vmstat' and pick:
> >        1) numa_pages_migrated
> >        2) pgmigrate_success
> >        3) nr_tlb_remote_flush
> >        4) nr_tlb_remote_flush_received
> >        5) nr_tlb_local_flush_all
> >        6) nr_tlb_local_flush_one
> > 
> >     BEFORE - mainline v6.6-rc5
> >     ------------------------------------------
> >     $ perf stat -a \
> > 	   -e itlb.itlb_flush \
> > 	   -e tlb_flush.dtlb_thread \
> > 	   -e tlb_flush.stlb_any \
> > 	   -e dTLB-load-misses \
> > 	   -e dTLB-store-misses \
> > 	   -e iTLB-load-misses \
> > 	   ./XSBench -p 50000000
> > 
> >     Performance counter stats for 'system wide':
> > 
> >        20953405     itlb.itlb_flush
> >        114886593    tlb_flush.dtlb_thread
> >        88267015     tlb_flush.stlb_any
> >        115304095543 dTLB-load-misses
> >        163904743    dTLB-store-misses
> >        608486259	   iTLB-load-misses
> > 
> >     556.787113849 seconds time elapsed
> > 
> >     $ cat /proc/vmstat
> > 
> >     ...
> >     numa_pages_migrated 3378748
> >     pgmigrate_success 7720310
> >     nr_tlb_remote_flush 751464
> >     nr_tlb_remote_flush_received 10742115
> >     nr_tlb_local_flush_all 21899
> >     nr_tlb_local_flush_one 740157
> >     ...
> > 
> >     AFTER - mainline v6.6-rc5 + CONFIG_MIGRC
> >     ------------------------------------------
> >     $ perf stat -a \
> > 	   -e itlb.itlb_flush \
> > 	   -e tlb_flush.dtlb_thread \
> > 	   -e tlb_flush.stlb_any \
> > 	   -e dTLB-load-misses \
> > 	   -e dTLB-store-misses \
> > 	   -e iTLB-load-misses \
> > 	   ./XSBench -p 50000000
> > 
> >     Performance counter stats for 'system wide':
> > 
> >        4353555      itlb.itlb_flush
> >        72482780     tlb_flush.dtlb_thread
> >        68226458     tlb_flush.stlb_any
> >        114331610808 dTLB-load-misses
> >        116084771    dTLB-store-misses
> >        377180518    iTLB-load-misses
> > 
> >     552.667718220 seconds time elapsed
> > 
> >     $ cat /proc/vmstat
> > 
> 
> So, an improvement of 0.74% ? How stable are the results? Serious question:

I'm getting very stable result.

> worth the churn?

Yes, ultimately the time wise improvement should be observed. However,
I've been focusing on the numbers of TLB flushes and TLB misses because
better result in terms of total time will be followed depending on the
test condition. We can see the result if we test with a system that:

   1. has more CPUs that would induce a crazy number of IPIs.
   2. has slow memories that makes TLB miss overhead bigger.
   3. runs workloads that is harmful at TLB miss and IPI storm.
   4. runs workloads that causes heavier numa migrations.
   5. runs workloads that has a lot of read only permission mappings.
   6. and so on.

I will share the results once I manage to meet the conditions.

By the way, I should've added IPI reduction because it also has super
big delta :)

> Or did I get the numbers wrong?
> 
> >   #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 5c02720c53a5..1ca2ac91aa14 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -135,6 +135,9 @@ enum pageflags {
> >   #ifdef CONFIG_ARCH_USES_PG_ARCH_X
> >   	PG_arch_2,
> >   	PG_arch_3,
> > +#endif
> > +#ifdef CONFIG_MIGRC
> > +	PG_migrc,		/* Page has its copy under migrc's control */
> >   #endif
> >   	__NR_PAGEFLAGS,
> > @@ -589,6 +592,10 @@ TESTCLEARFLAG(Young, young, PF_ANY)
> >   PAGEFLAG(Idle, idle, PF_ANY)
> >   #endif
> > +#ifdef CONFIG_MIGRC
> > +PAGEFLAG(Migrc, migrc, PF_ANY)
> > +#endif
> 
> I assume you know this: new pageflags are frowned upon.

Sorry for that. I really didn't want to add a new headache.

	Byungchul

