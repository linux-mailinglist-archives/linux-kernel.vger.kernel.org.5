Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E019677D74E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbjHPBDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbjHPBDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:03:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51589E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692147783; x=1723683783;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=fqfvG80fFYPaOZHRXoqAFgj36lBaRMCGfwkNqilmfhk=;
  b=XqXUrPK5/cOlLCA8Bmxvm49N2whmg0DcODMqzaxL0DaORyI+zkwkXGR1
   WluKAiJlQigap3Bnv3f9Juljwfhn4ynyGdp1lkLfS3aTpaEZYGNZG1lx1
   fLDg7L4dwUTUnOhJ9SnE7FUEZWH2RJJitDrLyYSjGPsAtq+2CHWm8v9P8
   sySW5G9poSJdMYtzZJOBwfgmfJOERtMR6x0uPuB3cka8YSx2kFpxBCnmZ
   IlrN89hb/bf+o7oTTtLwbSNx1pLS3lPWCncYTISUHLiBVieLr4IoTOE5h
   P/WxDzLtZyUnAaqeE2JaMgNOSKzzeth8FtD9X3Z/MoBtja2bQK/tuF0Ly
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="369885944"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="369885944"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 18:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763462758"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="763462758"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 18:02:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Byungchul Park <byungchul@sk.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel_team@skhynix.com>, <akpm@linux-foundation.org>,
        <namit@vmware.com>, <xhao@linux.alibaba.com>,
        <mgorman@techsingularity.net>, <hughd@google.com>,
        <willy@infradead.org>, <david@redhat.com>, <peterz@infradead.org>,
        <luto@kernel.org>, <dave.hansen@linux.intel.com>
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst
 folios at migration
References: <20230804061850.21498-1-byungchul@sk.com>
        <20230804061850.21498-3-byungchul@sk.com>
        <877cpx9jsx.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230816001307.GA44941@system.software.com>
Date:   Wed, 16 Aug 2023 09:01:12 +0800
In-Reply-To: <20230816001307.GA44941@system.software.com> (Byungchul Park's
        message of "Wed, 16 Aug 2023 09:13:07 +0900")
Message-ID: <87r0o37qcn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byungchul Park <byungchul@sk.com> writes:

> On Tue, Aug 15, 2023 at 09:27:26AM +0800, Huang, Ying wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>> 
>> > Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
>> >
>> > We always face the migration overhead at either promotion or demotion,
>> > while working with tiered memory e.g. CXL memory and found out TLB
>> > shootdown is a quite big one that is needed to get rid of if possible.
>> >
>> > Fortunately, TLB flush can be defered or even skipped if both source and
>> > destination of folios during migration are kept until all TLB flushes
>> > required will have been done, of course, only if the target PTE entries
>> > have read only permission, more precisely speaking, don't have write
>> > permission. Otherwise, no doubt the folio might get messed up.
>> >
>> > To achieve that:
>> >
>> >    1. For the folios that have only non-writable TLB entries, prevent
>> >       TLB flush by keeping both source and destination of folios during
>> >       migration, which will be handled later at a better time.
>> >
>> >    2. When any non-writable TLB entry changes to writable e.g. through
>> >       fault handler, give up CONFIG_MIGRC mechanism so as to perform
>> >       TLB flush required right away.
>> >
>> >    3. TLB flushes can be skipped if all TLB flushes required to free the
>> >       duplicated folios have been done by any reason, which doesn't have
>> >       to be done from migrations.
>> >
>> >    4. Adjust watermark check routine, __zone_watermark_ok(), with the
>> >       number of duplicated folios because those folios can be freed
>> >       and obtained right away through appropreate TLB flushes.
>> >
>> >    5. Perform TLB flushes and free the duplicated folios pending the
>> >       flushes if page allocation routine is in trouble due to memory
>> >       pressure, even more aggresively for high order allocation.
>> 
>> Is the optimization restricted for page migration only?  Can it be used
>> for other places?  Like page reclaiming?
>
> Just to make sure, are you talking about the (5) description? For now,
> it's performed at the beginning of __alloc_pages_slowpath(), say, before
> page recaiming. Do you think it'd be meaningful to perform it during page
> reclaiming? Or do you mean something else?

Not for (5).  TLB needs to be flushed during page reclaiming too.  Can
similar method be used to reduce TLB flushing there too?

>> > The measurement result:
>> >
>> >    Architecture - x86_64
>> >    QEMU - kvm enabled, host cpu, 2nodes((4cpus, 2GB)+(cpuless, 6GB))
>> >    Linux Kernel - v6.4, numa balancing tiering on, demotion enabled
>> >    Benchmark - XSBench with no parameter changed
>> >
>> >    run 'perf stat' using events:
>> >    (FYI, process wide result ~= system wide result(-a option))
>> >       1) itlb.itlb_flush
>> >       2) tlb_flush.dtlb_thread
>> >       3) tlb_flush.stlb_any
>> >
>> >    run 'cat /proc/vmstat' and pick up:
>> >       1) pgdemote_kswapd
>> >       2) numa_pages_migrated
>> >       3) pgmigrate_success
>> >       4) nr_tlb_remote_flush
>> >       5) nr_tlb_remote_flush_received
>> >       6) nr_tlb_local_flush_all
>> >       7) nr_tlb_local_flush_one
>> >
>> >    BEFORE - mainline v6.4
>> >    ==========================================
>> >
>> >    $ perf stat -e itlb.itlb_flush,tlb_flush.dtlb_thread,tlb_flush.stlb_any ./XSBench
>> >
>> >    Performance counter stats for './XSBench':
>> >
>> >       426856       itlb.itlb_flush
>> >       6900414      tlb_flush.dtlb_thread
>> >       7303137      tlb_flush.stlb_any
>> >
>> >    33.500486566 seconds time elapsed
>> >    92.852128000 seconds user
>> >    10.526718000 seconds sys
>> >
>> >    $ cat /proc/vmstat
>> >
>> >    ...
>> >    pgdemote_kswapd 1052596
>> >    numa_pages_migrated 1052359
>> >    pgmigrate_success 2161846
>> >    nr_tlb_remote_flush 72370
>> >    nr_tlb_remote_flush_received 213711
>> >    nr_tlb_local_flush_all 3385
>> >    nr_tlb_local_flush_one 198679
>> >    ...
>> >
>> >    AFTER - mainline v6.4 + CONFIG_MIGRC
>> >    ==========================================
>> >
>> >    $ perf stat -e itlb.itlb_flush,tlb_flush.dtlb_thread,tlb_flush.stlb_any ./XSBench
>> >
>> >    Performance counter stats for './XSBench':
>> >
>> >       179537       itlb.itlb_flush
>> >       6131135      tlb_flush.dtlb_thread
>> >       6920979      tlb_flush.stlb_any
>> 
>> It appears that the number of "itlb.itlb_flush" changes much, but not
>> for other 2 events.  Because the text segment of the executable file is
>> mapped as read-only?  And most other pages are mapped read-write?
>
> Yes, for this benchmarch, XSBench. I didn't noticed that until checking
> it using perf event either.
>
>> >    30.396700625 seconds time elapsed
>> >    80.331252000 seconds user
>> >    10.303761000 seconds sys
>> >
>> >    $ cat /proc/vmstat
>> >
>> >    ...
>> >    pgdemote_kswapd 1044602
>> >    numa_pages_migrated 1044202
>> >    pgmigrate_success 2157808
>> >    nr_tlb_remote_flush 30453
>> >    nr_tlb_remote_flush_received 88840
>> >    nr_tlb_local_flush_all 3039
>> >    nr_tlb_local_flush_one 198875
>> >    ...
>> >
>> > Signed-off-by: Byungchul Park <byungchul@sk.com>
>
> [...]
>
>> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> > index 306a3d1a0fa6..3be66d3eabd2 100644
>> > --- a/include/linux/mm_types.h
>> > +++ b/include/linux/mm_types.h
>> > @@ -228,6 +228,10 @@ struct page {
>> >  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
>> >  	int _last_cpupid;
>> >  #endif
>> > +#ifdef CONFIG_MIGRC
>> > +	struct llist_node migrc_node;
>> > +	unsigned int migrc_state;
>> > +#endif
>> 
>> We cannot enlarge "struct page".
>
> This is what I worried about. Do you have a better idea? I don't think
> they fit onto page_ext or something.

No.

--
Best Regards,
Huang, Ying
