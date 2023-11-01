Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9E87DDF70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjKAKbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjKAKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:31:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E9DA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AdMoMRnJbhIexa+O8wRz6i1mgPwE7z0trzuc+nyuQEM=; b=OaeoBP70Q7nlTJAgaaMOGRrjDW
        z+4bitIwzxirHaaGd5ByozfhOnj1GAeYtZTy9N1e9rr4b/KT3AqQD2LjErjc7w7ed+z182W7QWHb6
        GWQtLP+3k44ZkDueVccvTJ/uTTU1ipfWtz//sgC9DmFFCuYtGOxwQmRPqAHYRCWXtvmevxvXhzRxX
        zEbkMi0Z1NCtAymKmkhBcqoBmx7g/zb39F+CksTsNQ6Lmlgl23WbqW5HfOpvf/DsJMcEcB9tE92GG
        I+/Tg4TGAxyRu8CGLrHjf+iVQoBEbpQn+YrK4vx+EGBgiDxTmqHB81QrYRHAfYEDDcAkWR6JnH5xX
        mhZcUOuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qy8VG-005dj6-2F;
        Wed, 01 Nov 2023 10:31:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A59B3002AF; Wed,  1 Nov 2023 11:31:14 +0100 (CET)
Date:   Wed, 1 Nov 2023 11:31:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH V1 1/1] sched/numa: Fix mm numa_scan_seq based
 unconditional scan
Message-ID: <20231101103114.GK15024@noisy.programming.kicks-ass.net>
References: <cover.1697816692.git.raghavendra.kt@amd.com>
 <2ea7cbce80ac7c62e90cbfb9653a7972f902439f.1697816692.git.raghavendra.kt@amd.com>
 <20231101092101.i562axvfqjdvw2rx@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101092101.i562axvfqjdvw2rx@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:21:01AM +0000, Mel Gorman wrote:
> On Fri, Oct 20, 2023 at 09:27:46PM +0530, Raghavendra K T wrote:
> > Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> > 
> > NUMA Balancing allows updating PTEs to trap NUMA hinting faults if the
> > task had previously accessed VMA. However unconditional scan of VMAs are
> > allowed during initial phase of VMA creation until process's
> > mm numa_scan_seq reaches 2 even though current task had not accessed VMA.
> > 
> > Rationale:
> >  - Without initial scan subsequent PTE update may never happen.
> >  - Give fair opportunity to all the VMAs to be scanned and subsequently
> > understand the access pattern of all the VMAs.
> > 
> > But it has a corner case where, if a VMA is created after some time,
> > process's mm numa_scan_seq could be already greater than 2.
> > 
> > For e.g., values of mm numa_scan_seq when VMAs are created by running
> > mmtest autonuma benchmark briefly looks like:
> > start_seq=0 : 459
> > start_seq=2 : 138
> > start_seq=3 : 144
> > start_seq=4 : 8
> > start_seq=8 : 1
> > start_seq=9 : 1
> > This results in no unconditional PTE updates for those VMAs created after
> > some time.
> > 
> > Fix:
> > - Note down the initial value of mm numa_scan_seq in per VMA start_seq.
> > - Allow unconditional scan till start_seq + 2.
> > 
> > Result:
> > SUT: AMD EPYC Milan with 2 NUMA nodes 256 cpus.
> > base kernel: upstream 6.6-rc6 with Mels patches [1] applied.
> > 
> > kernbench
> > ==========		base                  patched %gain
> > Amean    elsp-128      165.09 ( 0.00%)      164.78 *   0.19%*
> > 
> > Duration User       41404.28    41375.08
> > Duration System      9862.22     9768.48
> > Duration Elapsed      519.87      518.72
> > 
> > Ops NUMA PTE updates           1041416.00      831536.00
> > Ops NUMA hint faults            263296.00      220966.00
> > Ops NUMA pages migrated         258021.00      212769.00
> > Ops AutoNUMA cost                 1328.67        1114.69
> > 
> > autonumabench
> > 
> > NUMA01_THREADLOCAL
> > ==================
> > Amean  elsp-NUMA01_THREADLOCAL   81.79 (0.00%)  67.74 *  17.18%*
> > 
> > Duration User       54832.73    47379.67
> > Duration System        75.00      185.75
> > Duration Elapsed      576.72      476.09
> > 
> > Ops NUMA PTE updates                  394429.00    11121044.00
> > Ops NUMA hint faults                    1001.00     8906404.00
> > Ops NUMA pages migrated                  288.00     2998694.00
> > Ops AutoNUMA cost                          7.77       44666.84
> > 
> > Link: https://lore.kernel.org/linux-mm/ZSXF3AFZgIld1meX@gmail.com/T/
> > 
> > Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> 
> Acked-by: Mel Gorman <mgorman@suse.de>

Thanks, will queue for the next merge window (6.8 I think that is) once
6.7-rc1 comes around.
