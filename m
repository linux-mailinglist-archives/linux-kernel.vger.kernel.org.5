Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049617A5DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjISJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjISJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:28:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D116EC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zk8ROmqt3R1Ehu4MGLOYKYYFzESLaULeiHUsO5ZO2kg=; b=nczm4co9A9StH7BpTdsp+LnvvH
        cJiSGG9N6ey/mLHzJdsrXfUqxo/4Fu1OUoDPASDs0zKsBM6co3hxeBMZqQQCuUcuvQQ3eWdeEn6HP
        l9IZRknenEyL2yokLiy8MH18SRwE7KqVO2SHP0fzw4OyT7tJa8Hhu/li9VK85G4qjYDJoukLt+36V
        tt/UVQYfXW3JkdjLPaaMDvWPYuoKBClRK6yGlWtB7VOHePTjsGi2UaIS/0byz5q3FZLMIo867HH/+
        WP++gfONPJKSfCl9fpXL9O+tXNxlZh9OZhwdAdPodkKLaMGU+omD0qhly8m1I5CrN/BWrLaplGc/y
        Mvw3CYLA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiX1z-00GPwo-BU; Tue, 19 Sep 2023 09:28:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04A5430042E; Tue, 19 Sep 2023 11:28:31 +0200 (CEST)
Date:   Tue, 19 Sep 2023 11:28:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
Message-ID: <20230919092830.GF21729@noisy.programming.kicks-ass.net>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693287931.git.raghavendra.kt@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 11:36:08AM +0530, Raghavendra K T wrote:

> Peter Zijlstra (1):
>   sched/numa: Increase tasks' access history
> 
> Raghavendra K T (5):
>   sched/numa: Move up the access pid reset logic
>   sched/numa: Add disjoint vma unconditional scan logic
>   sched/numa: Remove unconditional scan logic using mm numa_scan_seq
>   sched/numa: Allow recently accessed VMAs to be scanned
>   sched/numa: Allow scanning of shared VMAs
> 
>  include/linux/mm.h       |  12 +++--
>  include/linux/mm_types.h |   5 +-
>  kernel/sched/fair.c      | 109 ++++++++++++++++++++++++++++++++-------
>  3 files changed, 102 insertions(+), 24 deletions(-)

So I don't immediately see anything horrible with this. Mel, do you have
a few cycles to go over this as well?
