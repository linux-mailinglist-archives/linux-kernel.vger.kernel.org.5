Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F979C749
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjILG6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjILG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:58:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF27E75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694501906; x=1726037906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/szf/MsXVCWQEzu53ZsZkY2QIuhVOzh+2dv+9+qCamU=;
  b=MvLW3FQv/M4VWkBvdVm7pmerVU4c5WuARy1JqtjFbntwekOx3If6ws8T
   +KjFbPAhsPWe0dwm+yhClEwsNzApRvRKI4yjBX9xwcmnrvBfLvDiJt8Ep
   maOEVsmPovCfxIgdL81HufLp2d1tM8e2wJn0qR+5Cxoouq0Mq7hCT2MFk
   JtRRHycK0rbZYHFBP4jSKMtWxQqYLgoPEkLhJiSwqXrAz7Rm47nwXiEfd
   GbpGG4P8wYAZzGRDPP/9j+53wC7x9BMR5AIdXbrPUyvxKSY7C9ErqlgEe
   rwa40EJOHOpLmEo1hE4Br9OznvD62Fc4MGPNf7jZSq//N5mlQcvTL7gte
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358571018"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="358571018"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746762650"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="746762650"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:58:22 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] Reduce cost of accessing tg->load_avg
Date:   Tue, 12 Sep 2023 14:58:07 +0800
Message-ID: <20230912065808.2530-1-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Rebase on top of tag sched-core-2023-08-28, also applies cleanly on
  top of v6.6-rc1;
- Explain why ratelimit to once per ms in the changelog as suggested by
  David Vernet;
- Collected reviewed-by and tested-by tags, thank you all for your review
  and test!

After rebase, I did a new run of postgres_sysbench workload on Intel
Sapphire Rapids and the data is about the same as v1. Consider that
there is no much change in load tracking from v6.6, I've kept the old
data.

RFC v2 -> v1:
- drop RFC;
- move cfs_rq->last_update_tg_load_avg before cfs_rq->tg_load_avg_contrib;
- add Vincent's reviewed-by tag.

RFC v2:
Nitin Tekchandani noticed some scheduler functions have high cost                                                      
according to perf/cycles while running postgres_sysbench workload.                                                     
I perf/annotated the high cost functions: update_cfs_group() and                                                       
update_load_avg() and found the costs were ~90% due to accessing to                                                    
tg->load_avg. This series is an attempt to reduce the overhead of                                                      
the two functions.                                                                                                     
                                                                                                                       
Thanks to Vincent's suggestion from v1, this revision used a simpler way                                               
to solve the overhead problem by limiting updates to tg->load_avg to at                                                
most once per ms. Benchmark shows that it has good results and with the                                                
rate limit in place, other optimizations in v1 don't improve performance                                               
further so they are dropped from this revision.

Aaron Lu (1):
  sched/fair: ratelimit update to tg->load_avg

 kernel/sched/fair.c  | 13 ++++++++++++-
 kernel/sched/sched.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.41.0

