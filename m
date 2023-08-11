Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14528778934
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjHKIuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjHKIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:50:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E58213B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691743811; x=1723279811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T7eIZTizi/1+md1Xz2qj/FMgLHZOhIC+aHP88G90UUk=;
  b=Seagh88RyeNRk5PJZbx6ucjV/ukUdnEFXGIz3h8C+T5oLPgytYweIolh
   tiEgK4AkoJs05x5xNBAejbp85rsijnNr8AY8XFEz3XZNWhADhldlbC+N6
   x+SjaN/A/dJKDhK10FJuuMpGaVg1nItjl57p5XLe0mhNXB1yQAIopfGkL
   4O5PD5pFPC5YoV6y7LOw/UL4/bquwfRDXQzUcW/nuzsdExA6r9WtVICbx
   ea1Kz/Ayy3VwJQz2Y2GduHH+94MWXm6Im+yOU2zxFwxooj3/SE26wtzV/
   eZ0BJy3yHi36hmxrzklX7Nq4RkxD4iUzd15ANxjDA2YF+WFEoRS5a+1LT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="371641868"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="371641868"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="735720466"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="735720466"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Aug 2023 01:50:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUNqL-007ENk-1T;
        Fri, 11 Aug 2023 11:50:01 +0300
Date:   Fri, 11 Aug 2023 11:50:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Lafreniere <peter@n8pjl.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shiju.jose@huawei.com, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 2/4] sched/fair: fix opencoded numa_nearest_node()
Message-ID: <ZNX2ObMnC3aiL9XZ@smile.fi.intel.com>
References: <20230810162442.9863-1-yury.norov@gmail.com>
 <20230810162442.9863-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810162442.9863-3-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:24:40AM -0700, Yury Norov wrote:
> task_numa_placement() searches for a nearest node by calling
> for_each_node_state(). Now that we have numa_nearest_node(), switch to
> using it.

For better looking you may rewrap the above as

---8<---
task_numa_placement() searches for a nearest node by calling
for_each_node_state(). Now that we have numa_nearest_node(),
switch to using
---8<---

-- 
With Best Regards,
Andy Shevchenko


