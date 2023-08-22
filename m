Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849EB78382A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjHVCt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjHVCtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:49:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25C11D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692672563; x=1724208563;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yFb4Bx4e8Iusd0lzEpsWaGhmFI+ZDT5vW3XxtZMaBsk=;
  b=dHloWcfVerxqqmkLgytH6AG7W5LtFvDucil6X1IL7CkqsZ7fGAM7um+b
   ZU30NMqx3wxJLLsxwS3xn4kTwfpg96ZwkD0W/Lv1KlID49HD9ZfdHNygL
   3DzTFpF7oK3p0n/TATXDbCNOf670euZeV3OD/nYo4FvTbqexHzrucuiS4
   /RAF2A2lA5aPHWvokA3N5Fy4LNZZHbYLG4JBmk7dQjRepXa1BAxXhLcbD
   xZiOS3wrbOVinCTKUSMUAp9+5HTBs2+5wC40MzI0qUZbStwcEEwItl4MB
   cdVVXX/HoGBM/U1M/i2/m6GZjgES4Zn52GUx9+bet1gT1zk3fvtiH/Kia
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376495978"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="376495978"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 19:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="1066861678"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="1066861678"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 19:49:20 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <shy828301@gmail.com>, <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Extend migrate_misplaced_page() to support batch
 migration
References: <cover.1692665449.git.baolin.wang@linux.alibaba.com>
Date:   Tue, 22 Aug 2023 10:47:15 +0800
In-Reply-To: <cover.1692665449.git.baolin.wang@linux.alibaba.com> (Baolin
        Wang's message of "Tue, 22 Aug 2023 08:53:48 +0800")
Message-ID: <87pm3fbxos.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
>
> In addition, these cleanup can also benefit the compound page's NUMA balancing,
> which was discussed in previous thread[3]. IIUC, for the compound page's NUMA
> balancing, it is possible that partial pages were successfully migrated, so it is
> necessary to return the number of pages that were successfully migrated from
> migrate_misplaced_page().

But I don't find the return number is used except as bool now.

Per my understanding, I still don't find much value of the changes
except as preparation for batch migration in NUMA balancing.  So I still
think it's better to wait for the whole series.  Where we can check why
these changes are necessary for batch migration.  And I think that you
will provide some number to justify the batch migration, including pros
and cons.

--
Best Regards,
Huang, Ying

> This series is based on the latest mm-unstable(d226b59b30cc).
>
> [1] https://lore.kernel.org/lkml/cover.1639306956.git.baolin.wang@linux.alibaba.com/t/#mc45929849b5d0e29b5fdd9d50425f8e95b8f2563
> [2] https://lore.kernel.org/all/20230213123444.155149-1-ying.huang@intel.com/T/#u
> [3] https://lore.kernel.org/all/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
>
> Changes from v1:
>  - Move page validation into a new function suggested by Huang Ying.
>  - Change numamigrate_isolate_page() to boolean type.
>  - Update some commit message.
>
> Baolin Wang (4):
>   mm: migrate: factor out migration validation into
>     numa_page_can_migrate()
>   mm: migrate: move the numamigrate_isolate_page() into do_numa_page()
>   mm: migrate: change migrate_misplaced_page() to support multiple pages
>     migration
>   mm: migrate: change to return the number of pages migrated
>     successfully
>
>  include/linux/migrate.h | 15 +++++++---
>  mm/huge_memory.c        | 23 +++++++++++++--
>  mm/internal.h           |  1 +
>  mm/memory.c             | 43 ++++++++++++++++++++++++++-
>  mm/migrate.c            | 64 +++++++++--------------------------------
>  5 files changed, 88 insertions(+), 58 deletions(-)
