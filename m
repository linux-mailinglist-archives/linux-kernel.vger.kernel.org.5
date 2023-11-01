Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423027DDE59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjKAJVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjKAJVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:21:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD92120
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:21:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 75CDF219E1;
        Wed,  1 Nov 2023 09:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698830464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aEA5Bn5qqMBKnK83id7ZAri0LcBHPYglLttHP/O2Csg=;
        b=kqn6sEW4MNl8xclDYz/UTR5PJHXE9m3QBCb8fczzYVJ16j9nBIx+r/VLSB45JXd63PfJr4
        EcGPxU6p2VbXezcLa5NRcyFjPKoF4/ZEv1WSHp34b8Nnpqgpl/GACfPL36j8scXm31mUuo
        Ngq7wBsUURdXwjJxYdXvJu6NwRn1cds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698830464;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aEA5Bn5qqMBKnK83id7ZAri0LcBHPYglLttHP/O2Csg=;
        b=8gcDjwF4nX6QOJUOk75hIrivSgHdImjRRdFrxwoa0yA8sPIseb283OZhQ8Y6lDiLx34vrC
        c+S0hDyQ46n/WmBg==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A02F2C65A;
        Wed,  1 Nov 2023 09:21:03 +0000 (UTC)
Date:   Wed, 1 Nov 2023 09:21:01 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20231101092101.i562axvfqjdvw2rx@suse.de>
References: <cover.1697816692.git.raghavendra.kt@amd.com>
 <2ea7cbce80ac7c62e90cbfb9653a7972f902439f.1697816692.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <2ea7cbce80ac7c62e90cbfb9653a7972f902439f.1697816692.git.raghavendra.kt@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:27:46PM +0530, Raghavendra K T wrote:
> Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> 
> NUMA Balancing allows updating PTEs to trap NUMA hinting faults if the
> task had previously accessed VMA. However unconditional scan of VMAs are
> allowed during initial phase of VMA creation until process's
> mm numa_scan_seq reaches 2 even though current task had not accessed VMA.
> 
> Rationale:
>  - Without initial scan subsequent PTE update may never happen.
>  - Give fair opportunity to all the VMAs to be scanned and subsequently
> understand the access pattern of all the VMAs.
> 
> But it has a corner case where, if a VMA is created after some time,
> process's mm numa_scan_seq could be already greater than 2.
> 
> For e.g., values of mm numa_scan_seq when VMAs are created by running
> mmtest autonuma benchmark briefly looks like:
> start_seq=0 : 459
> start_seq=2 : 138
> start_seq=3 : 144
> start_seq=4 : 8
> start_seq=8 : 1
> start_seq=9 : 1
> This results in no unconditional PTE updates for those VMAs created after
> some time.
> 
> Fix:
> - Note down the initial value of mm numa_scan_seq in per VMA start_seq.
> - Allow unconditional scan till start_seq + 2.
> 
> Result:
> SUT: AMD EPYC Milan with 2 NUMA nodes 256 cpus.
> base kernel: upstream 6.6-rc6 with Mels patches [1] applied.
> 
> kernbench
> ==========		base                  patched %gain
> Amean    elsp-128      165.09 ( 0.00%)      164.78 *   0.19%*
> 
> Duration User       41404.28    41375.08
> Duration System      9862.22     9768.48
> Duration Elapsed      519.87      518.72
> 
> Ops NUMA PTE updates           1041416.00      831536.00
> Ops NUMA hint faults            263296.00      220966.00
> Ops NUMA pages migrated         258021.00      212769.00
> Ops AutoNUMA cost                 1328.67        1114.69
> 
> autonumabench
> 
> NUMA01_THREADLOCAL
> ==================
> Amean  elsp-NUMA01_THREADLOCAL   81.79 (0.00%)  67.74 *  17.18%*
> 
> Duration User       54832.73    47379.67
> Duration System        75.00      185.75
> Duration Elapsed      576.72      476.09
> 
> Ops NUMA PTE updates                  394429.00    11121044.00
> Ops NUMA hint faults                    1001.00     8906404.00
> Ops NUMA pages migrated                  288.00     2998694.00
> Ops AutoNUMA cost                          7.77       44666.84
> 
> Link: https://lore.kernel.org/linux-mm/ZSXF3AFZgIld1meX@gmail.com/T/
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
