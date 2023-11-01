Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A47DDB59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjKADJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKADJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:09:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD95BA4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698808138; x=1730344138;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7oU5zP/ORh3VkaRH+O4IqYYm4jA/RodQFLfi2B7JOSo=;
  b=LXtPBV64jMXOtPcCud4Jsf8RfQDfawn72srAVe6G4KKP36NpckbZExsf
   rIDCGAzh0a0uAjBpr0+IZIU2RVZOafqbinmp7mWEmIVJAAw9Y4zbu78Ng
   P31QPrxWR7TVyJd5ZslIGpQRglK23z1cXnIFoAY9C9rkPx9P20pwLw26l
   Q5LdLTRZ5fw/Y9Os1zbQIJukDmWfmihrMTFSrN8BUuyjoLrphxlvfYbtY
   SuIG827MGSqCB27Qy/rLLLssOLqA4VEotMTII7O9OgiiWC57YbZLTEa56
   dYKfgh3CSIoRonwgojw/IKWzlvUyz9NylPwvHGNGO1De60+Za3WxiASZC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="474664458"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="474664458"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 20:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884409636"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="884409636"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 20:08:53 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Byungchul Park <byungchul@sk.com>
Cc:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel_team@skhynix.com>, <akpm@linux-foundation.org>,
        <namit@vmware.com>, <xhao@linux.alibaba.com>,
        <mgorman@techsingularity.net>, <hughd@google.com>,
        <willy@infradead.org>, <peterz@infradead.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
In-Reply-To: <20231030095803.GA81877@system.software.com> (Byungchul Park's
        message of "Mon, 30 Oct 2023 18:58:03 +0900")
References: <20231030072540.38631-1-byungchul@sk.com>
        <20231030072540.38631-3-byungchul@sk.com>
        <a8337371-50ed-4618-b48e-78b96d18810f@redhat.com>
        <20231030095803.GA81877@system.software.com>
Date:   Wed, 01 Nov 2023 11:06:51 +0800
Message-ID: <87edha6uk4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byungchul Park <byungchul@sk.com> writes:

> On Mon, Oct 30, 2023 at 09:00:56AM +0100, David Hildenbrand wrote:
>> On 30.10.23 08:25, Byungchul Park wrote:
>> > Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
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
>> >     1. For the folios that map only to non-writable TLB entries, prevent
>> >        TLB flush at migration by keeping both source and destination
>> >        folios, which will be handled later at a better time.
>> > 
>> >     2. When any non-writable TLB entry changes to writable e.g. through
>> >        fault handler, give up CONFIG_MIGRC mechanism so as to perform
>> >        TLB flush required right away.
>> > 
>> >     3. Temporarily stop migrc from working when the system is in very
>> >        high memory pressure e.g. direct reclaim needed.
>> > 
>> > The measurement result:
>> > 
>> >     Architecture - x86_64
>> >     QEMU - kvm enabled, host cpu
>> >     Numa - 2 nodes (16 CPUs 1GB, no CPUs 8GB)
>> >     Linux Kernel - v6.6-rc5, numa balancing tiering on, demotion enabled
>> >     Benchmark - XSBench -p 50000000 (-p option makes the runtime longer)
>> > 
>> >     run 'perf stat' using events:
>> >        1) itlb.itlb_flush
>> >        2) tlb_flush.dtlb_thread
>> >        3) tlb_flush.stlb_any
>> >        4) dTLB-load-misses
>> >        5) dTLB-store-misses
>> >        6) iTLB-load-misses
>> > 
>> >     run 'cat /proc/vmstat' and pick:
>> >        1) numa_pages_migrated
>> >        2) pgmigrate_success
>> >        3) nr_tlb_remote_flush
>> >        4) nr_tlb_remote_flush_received
>> >        5) nr_tlb_local_flush_all
>> >        6) nr_tlb_local_flush_one
>> > 
>> >     BEFORE - mainline v6.6-rc5
>> >     ------------------------------------------
>> >     $ perf stat -a \
>> > 	   -e itlb.itlb_flush \
>> > 	   -e tlb_flush.dtlb_thread \
>> > 	   -e tlb_flush.stlb_any \
>> > 	   -e dTLB-load-misses \
>> > 	   -e dTLB-store-misses \
>> > 	   -e iTLB-load-misses \
>> > 	   ./XSBench -p 50000000
>> > 
>> >     Performance counter stats for 'system wide':
>> > 
>> >        20953405     itlb.itlb_flush
>> >        114886593    tlb_flush.dtlb_thread
>> >        88267015     tlb_flush.stlb_any
>> >        115304095543 dTLB-load-misses
>> >        163904743    dTLB-store-misses
>> >        608486259	   iTLB-load-misses
>> > 
>> >     556.787113849 seconds time elapsed
>> > 
>> >     $ cat /proc/vmstat
>> > 
>> >     ...
>> >     numa_pages_migrated 3378748
>> >     pgmigrate_success 7720310
>> >     nr_tlb_remote_flush 751464
>> >     nr_tlb_remote_flush_received 10742115
>> >     nr_tlb_local_flush_all 21899
>> >     nr_tlb_local_flush_one 740157
>> >     ...
>> > 
>> >     AFTER - mainline v6.6-rc5 + CONFIG_MIGRC
>> >     ------------------------------------------
>> >     $ perf stat -a \
>> > 	   -e itlb.itlb_flush \
>> > 	   -e tlb_flush.dtlb_thread \
>> > 	   -e tlb_flush.stlb_any \
>> > 	   -e dTLB-load-misses \
>> > 	   -e dTLB-store-misses \
>> > 	   -e iTLB-load-misses \
>> > 	   ./XSBench -p 50000000
>> > 
>> >     Performance counter stats for 'system wide':
>> > 
>> >        4353555      itlb.itlb_flush
>> >        72482780     tlb_flush.dtlb_thread
>> >        68226458     tlb_flush.stlb_any
>> >        114331610808 dTLB-load-misses
>> >        116084771    dTLB-store-misses
>> >        377180518    iTLB-load-misses
>> > 
>> >     552.667718220 seconds time elapsed
>> > 
>> >     $ cat /proc/vmstat
>> > 
>> 
>> So, an improvement of 0.74% ? How stable are the results? Serious question:
>
> I'm getting very stable result.
>
>> worth the churn?
>
> Yes, ultimately the time wise improvement should be observed. However,
> I've been focusing on the numbers of TLB flushes and TLB misses because
> better result in terms of total time will be followed depending on the
> test condition. We can see the result if we test with a system that:
>
>    1. has more CPUs that would induce a crazy number of IPIs.

FYI, the TLB flushing IPI number reduces much with commit 7e12beb8ca2a
("migrate_pages: batch flushing TLB") if multiple pages are migrated
together.

--
Best Regards,
Huang, Ying

>    2. has slow memories that makes TLB miss overhead bigger.
>    3. runs workloads that is harmful at TLB miss and IPI storm.
>    4. runs workloads that causes heavier numa migrations.
>    5. runs workloads that has a lot of read only permission mappings.
>    6. and so on.
>
> I will share the results once I manage to meet the conditions.
>
> By the way, I should've added IPI reduction because it also has super
> big delta :)
>
>> Or did I get the numbers wrong?
>> 
>> >   #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
>> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> > index 5c02720c53a5..1ca2ac91aa14 100644
>> > --- a/include/linux/page-flags.h
>> > +++ b/include/linux/page-flags.h
>> > @@ -135,6 +135,9 @@ enum pageflags {
>> >   #ifdef CONFIG_ARCH_USES_PG_ARCH_X
>> >   	PG_arch_2,
>> >   	PG_arch_3,
>> > +#endif
>> > +#ifdef CONFIG_MIGRC
>> > +	PG_migrc,		/* Page has its copy under migrc's control */
>> >   #endif
>> >   	__NR_PAGEFLAGS,
>> > @@ -589,6 +592,10 @@ TESTCLEARFLAG(Young, young, PF_ANY)
>> >   PAGEFLAG(Idle, idle, PF_ANY)
>> >   #endif
>> > +#ifdef CONFIG_MIGRC
>> > +PAGEFLAG(Migrc, migrc, PF_ANY)
>> > +#endif
>> 
>> I assume you know this: new pageflags are frowned upon.
>
> Sorry for that. I really didn't want to add a new headache.
>
> 	Byungchul
