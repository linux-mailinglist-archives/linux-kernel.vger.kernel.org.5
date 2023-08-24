Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511357866F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbjHXEyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239347AbjHXEyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:54:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807310EF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692852850; x=1724388850;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=MNBB+IANHYIULWcaIcfxdhU2Gp/vh9az340FIASmAwU=;
  b=KMhYug30Rp8ObnIOftw9+6FzBU+UcyyU+haD8yByXGvHsRGjaaBME4ed
   scMxhdm/hYjFWWBbmyQIxWLP0OrIVlhatXJSuDjhEWKzrUiJzY0n4PwRe
   oeFInXNzkDDfOA/0DZb/E2ymDFhzlyRZ0d62/yw5CNLqlppCjSkrhVbja
   0bK/KnXKDZ90SbM6ywH1a/ENynJBONLSkX+CDy2b30Ooj6Wt1i78+TYE8
   1+DEirYUpMLzLKEQ2o5dKzvgyyMY4bht+ee97ghkd28Zi0updgjnuFZ5y
   B5CsgwZ+FbLOnHqKi99KbWt+a6SCFXo/XW4fAzijXtklhaHSOXA2cszVj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374313307"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374313307"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 21:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="740029781"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="740029781"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 21:54:08 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <shy828301@gmail.com>, <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Extend migrate_misplaced_page() to support batch
 migration
References: <cover.1692665449.git.baolin.wang@linux.alibaba.com>
        <87pm3fbxos.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <fc31bade-e15a-3cbf-7ed8-5b322374afe8@linux.alibaba.com>
Date:   Thu, 24 Aug 2023 12:51:59 +0800
In-Reply-To: <fc31bade-e15a-3cbf-7ed8-5b322374afe8@linux.alibaba.com> (Baolin
        Wang's message of "Thu, 24 Aug 2023 11:13:32 +0800")
Message-ID: <87zg2h9h5c.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 8/22/2023 10:47 AM, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> Hi,
>>>
>>> Currently, on our ARM servers with NUMA enabled, we found the cross-die latency
>>> is a little larger that will significantly impact the workload's performance.
>>> So on ARM servers we will rely on the NUMA balancing to avoid the cross-die
>>> accessing. And I posted a patchset[1] to support speculative numa fault to
>>> improve the NUMA balancing's performance according to the principle of data
>>> locality. Moreover, thanks to Huang Ying's patchset[2], which introduced batch
>>> migration as a way to reduce the cost of TLB flush, and it will also benefit
>>> the migration of multiple pages all at once during NUMA balancing.
>>>
>>> So we plan to continue to support batch migration in do_numa_page() to improve
>>> the NUMA balancing's performance, but before adding complicated batch migration
>>> algorithm for NUMA balancing, some cleanup and preparation work need to do firstly,
>>> which are done in this patch set. In short, this patchset extends the
>>> migrate_misplaced_page() interface to support batch migration, and no functional
>>> changes intended.
>>>
>>> In addition, these cleanup can also benefit the compound page's NUMA balancing,
>>> which was discussed in previous thread[3]. IIUC, for the compound page's NUMA
>>> balancing, it is possible that partial pages were successfully migrated, so it is
>>> necessary to return the number of pages that were successfully migrated from
>>> migrate_misplaced_page().
>> But I don't find the return number is used except as bool now.
>
> As I said above, this is a preparation for batch migration and
> compound page NUMA balancing in future.
>
> In addition, after looking into the THP' NUMA migration, I found this
> change is necessary for THP migration. Since it is possible that
> partial subpages were successfully migrated if the THP is split, so
> below THP numa fault statistics is not always correct:
>
> if (page_nid != NUMA_NO_NODE)
> 	task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
> 				flags);
>
> I will try to fix this in next version.

IIUC, THP will not be split for NUMA balancing.  Please check the
nosplit logic in migrate_pages_batch().

	bool nosplit = (reason == MR_NUMA_MISPLACED);

--
Best Regards,
Huang, Ying

>> Per my understanding, I still don't find much value of the changes
>> except as preparation for batch migration in NUMA balancing.  So I still
>
> IMO, only patch 3 is just a preparation for batch migration, but other
> patches are some cleanups for migrate_misplaced_page(). I can drop the
> preparation patches in this series and revise the commit message.
>
>> think it's better to wait for the whole series.  Where we can check why
>> these changes are necessary for batch migration.  And I think that you
>> will provide some number to justify the batch migration, including pros
>> and cons.
>> --
>> Best Regards,
>> Huang, Ying
>> 
>>> This series is based on the latest mm-unstable(d226b59b30cc).
>>>
>>> [1] https://lore.kernel.org/lkml/cover.1639306956.git.baolin.wang@linux.alibaba.com/t/#mc45929849b5d0e29b5fdd9d50425f8e95b8f2563
>>> [2] https://lore.kernel.org/all/20230213123444.155149-1-ying.huang@intel.com/T/#u
>>> [3] https://lore.kernel.org/all/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
>>>
>>> Changes from v1:
>>>   - Move page validation into a new function suggested by Huang Ying.
>>>   - Change numamigrate_isolate_page() to boolean type.
>>>   - Update some commit message.
>>>
>>> Baolin Wang (4):
>>>    mm: migrate: factor out migration validation into
>>>      numa_page_can_migrate()
>>>    mm: migrate: move the numamigrate_isolate_page() into do_numa_page()
>>>    mm: migrate: change migrate_misplaced_page() to support multiple pages
>>>      migration
>>>    mm: migrate: change to return the number of pages migrated
>>>      successfully
>>>
>>>   include/linux/migrate.h | 15 +++++++---
>>>   mm/huge_memory.c        | 23 +++++++++++++--
>>>   mm/internal.h           |  1 +
>>>   mm/memory.c             | 43 ++++++++++++++++++++++++++-
>>>   mm/migrate.c            | 64 +++++++++--------------------------------
>>>   5 files changed, 88 insertions(+), 58 deletions(-)
