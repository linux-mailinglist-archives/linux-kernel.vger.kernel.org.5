Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1090771791
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHGAqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 20:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGAql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:46:41 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 953A5B1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 17:46:38 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-37-64d03ee9cc1e
Date:   Mon, 7 Aug 2023 09:43:53 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20230807004353.GA69206@system.software.com>
References: <20230804061850.21498-1-byungchul@sk.com>
 <20230804061850.21498-3-byungchul@sk.com>
 <A59E5AD9-11DA-435A-AD17-6F735F0C0840@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A59E5AD9-11DA-435A-AD17-6F735F0C0840@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXC9ZZnoe5LuwspBu0fjS3mrF/DZvFiQzuj
        xdf1v5gtnn7qY7G4vGsOm8W9Nf9ZLc7vWstqsWPpPiaL67seMloc7z3AZPH7B1B2zhQri5Oz
        JrNYzD56j92Bz2PBplKPzSu0PBbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHvJOBHr3N79g8
        3u+7yuax9Zedx+dNch7v5r9lC+CN4rJJSc3JLEst0rdL4Mr4N/cPW8FZ7YqPez8wNjA+Vuhi
        5OCQEDCRuPo3rIuRE8zse3WGFcRmEVCR6JizlBnEZhNQl7hx4yeYLSIgLXG67w+QzcXBLHCG
        SeLa3DlgCWGBGIkTWz4zgdi8AhYSfRePsIIUCQlMZZRYu+8lVEJQ4uTMJywgNrOAlsSNfyBx
        DiBbWmL5Pw4Qk1PATmLhezGQClEBZYkD244zgYyREOhnl7h7eh0jxKGSEgdX3GCZwCgwC8nU
        WUimzkKYuoCReRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYJQtq/0TvYPx04XgQ4wCHIxKPLwN
        h8+nCLEmlhVX5h5ilOBgVhLhnfcEKMSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJ
        anZqakFqEUyWiYNTqoFxcoqyg6jpJJMVHvnKtxrLitZPmGlTvZzp9r6sh6sXCvh7vXVMNPvE
        8uivbQebtK2f1q3XaY3cBbofjGfa7v/09OC9vPAPq4+cnu9e1/X6xPeki+92100KLvqb/mjL
        hi0XD3McdTdbnLE/d0ewh3KfzTceBXaHjJAvj81mzt5ad3XKNgXD39FxSizFGYmGWsxFxYkA
        VbiC4a4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42Lh8rNu1n1pdyHF4GqvisWc9WvYLF5saGe0
        +Lr+F7PF0099LBaH555ktbi8aw6bxb01/1ktzu9ay2qxY+k+Jovrux4yWhzvPcBk8fsHUHbO
        FCuLk7Mms1jMPnqP3YHfY8GmUo/NK7Q8Fu95yeSxaVUnm8emT5PYPU7M+M3isfOhpce8k4Ee
        vc3v2Dze77vK5rH4xQcmj62/7Dw+b5LzeDf/LVsAXxSXTUpqTmZZapG+XQJXxr+5f9gKzmpX
        fNz7gbGB8bFCFyMnh4SAiUTfqzOsIDaLgIpEx5ylzCA2m4C6xI0bP8FsEQFpidN9f4BsLg5m
        gTNMEtfmzgFLCAvESJzY8pkJxOYVsJDou3iEFaRISGAqo8TafS+hEoISJ2c+YQGxmQW0JG78
        A4lzANnSEsv/cYCYnAJ2Egvfi4FUiAooSxzYdpxpAiPvLCTNs5A0z0JoXsDIvIpRJDOvLDcx
        M8dUrzg7ozIvs0IvOT93EyMwapbV/pm4g/HLZfdDjAIcjEo8vA2Hz6cIsSaWFVfmHmKU4GBW
        EuGd9wQoxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwChY
        q+akx7uq5ZTb+pMWs7/29nyeEfJOh+PIoguvxDSkbOae7Ao5vKbw4WXXZ0/WBl3UNRSdP9/p
        agLL3V8b7M2cvDRnvFyctLz5LsvGdPMpl85yq93b/HK+lVViFcfRy2ck5x+XvSG1eI5WJdOa
        22e2XnO0/c31ZJ9SWNwvnSlf21uMv2SHvj2sxFKckWioxVxUnAgA85RtapYCAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 12:08:07PM -0400, Zi Yan wrote:
> On 4 Aug 2023, at 2:18, Byungchul Park wrote:
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
> 
> So this would only reduce or eliminate TLB flushes? The same goal should
> be achievable with batched TLB flush, right? You probably can group

CONFIG_MIGRC achieves the reduction with:

   1) Batch TLB flush,
   2) defer TLB flush aggressively for non-writable folios.

The 2nd benifit is one that this patch set focuses on more.

> to-be-migrated pages into a read-only group and a writable group and
> migrate the read-only group first then the writable group. It would
> reduce or eliminate the TLB flushes for the read-only group of pages, right?

I'm not sure we are in the same page.

> > To achieve that:
> >
> >    1. For the folios that have only non-writable TLB entries, prevent
> >       TLB flush by keeping both source and destination of folios during
> >       migration, which will be handled later at a better time.
> 
> In this case, the page table points to the destination folio, but TLB
> would cache the old translation pointing to the source folio. I wonder
> if there would be any correctness issue.

Kinda yes. That's why I keep the old source folio until guaranteed all
TLB flushes required will be done or special cases e.g. memory pressure
or the permission changes to writable through fault handler.

Worth noting that of course this works only with non-writable folios to
keep the consistency and correctness.

It'd be apprecisated to point out if I miss something.

	Byungchul

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
> >
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
> >
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
> > ---
> 
> --
> Best Regards,
> Yan, Zi


