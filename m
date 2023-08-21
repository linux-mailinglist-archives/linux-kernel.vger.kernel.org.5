Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB104782170
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjHUCcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjHUCcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:32:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325E999
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 19:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692585120; x=1724121120;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=rOsOn2g8PU/rMT6eZ1g1pj2lVKXIGech1fG5c6FeRg0=;
  b=HADCZsnenTCKUHHt/8mFm1DoAC0hiXLd2wDC2fQu16sbN6JFKe12UDsa
   3gYz3ul1pLw9XHZsMH7hJ5ZY//pwbaxyt6Bkrm2ZbYWPn4zssSOOfo+dj
   zusQO7a4NL6PAkpZc1WvGgoCVKpkF/oTI7+Ycsaxn/+XBY15zEMb8HTP5
   em/qwA4gB933hEOtxjrBQagp2vsIrL3E35IxgDHLgbcVqoiNEgOYpRvxE
   8mwaKTcMcm1JZ3+nP5wD2MdY/uAKv1EdFB0Mb590EwRxgKcfUyhmWV51/
   LMytOFXzYSdLYsr3KOGpvLlspB4L7n770e4UqKkJY5B8uVIUltudbu6NJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="377215929"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="377215929"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 19:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="909525259"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="909525259"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 19:31:57 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <shy828301@gmail.com>, <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Extend migrate_misplaced_page() to support batch
 migration
References: <cover.1692440586.git.baolin.wang@linux.alibaba.com>
Date:   Mon, 21 Aug 2023 10:29:52 +0800
In-Reply-To: <cover.1692440586.git.baolin.wang@linux.alibaba.com> (Baolin
        Wang's message of "Sat, 19 Aug 2023 18:52:33 +0800")
Message-ID: <87cyzhdt5r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Hi,
>
> Currently, on our ARM servers with NUMA enabled, we found the cross-die latency
> is a little larger that will significantly impact the workload's performance.
> So on ARM servers we will rely on the NUMA balancing to avoid the cross-die
> accessing. And I posted a patchset[1] to support speculative numa fault to
> improve the NUMA balancing's performance according to the principle of data
> locality. Moreover, thanks to Huang Ying's patchset[2], which introduced batch
> migration as a way to reduce the cost of TLB flush, and it will also benefit
> the migration of multiple pages all at once during NUMA balancing.
>
> So we plan to continue to support batch migration in do_numa_page() to improve
> the NUMA balancing's performance, but before adding complicated batch migration
> algorithm for NUMA balancing, some cleanup and preparation work need to do firstly,
> which are done in this patch set. In short, this patchset extends the
> migrate_misplaced_page() interface to support batch migration, and no functional
> changes intended.

Will these cleanup benefit anything except batching migration?  If not,
I suggest you to post the whole series.  In this way, people will be
more clear about why we need these cleanup.

--
Best Regards,
Huang, Ying

> [1] https://lore.kernel.org/lkml/cover.1639306956.git.baolin.wang@linux.alibaba.com/t/#mc45929849b5d0e29b5fdd9d50425f8e95b8f2563
> [2] https://lore.kernel.org/all/20230213123444.155149-1-ying.huang@intel.com/T/#u
>
> Baolin Wang (4):
>   mm: migrate: move migration validation into numa_migrate_prep()
>   mm: migrate: move the numamigrate_isolate_page() into do_numa_page()
>   mm: migrate: change migrate_misplaced_page() to support multiple pages
>     migration
>   mm: migrate: change to return the number of pages migrated
>     successfully
>
>  include/linux/migrate.h | 15 ++++++++---
>  mm/huge_memory.c        | 19 +++++++++++---
>  mm/memory.c             | 34 +++++++++++++++++++++++-
>  mm/migrate.c            | 58 ++++++++---------------------------------
>  4 files changed, 71 insertions(+), 55 deletions(-)
