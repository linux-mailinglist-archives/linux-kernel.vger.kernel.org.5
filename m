Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA26F78505A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjHWGIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjHWGIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:08:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E54E57
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692770925; x=1724306925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XD3/3K0nIGecjSFVYtz/OHToCMKY/2ivaChArcZPdHQ=;
  b=YcdO+AQHyOvudv4qay02ZVE8HJrYjKqTdvlWdQhX7mqQ7wJM+7CwmJes
   uulKPanlQMLgkzfV8DjWkltSRI79yCkjjIxFkKrsKAixUj+MxuRmtUvcF
   R8AvbKbcbYcSyTlPDCQrtItPXTP0iX0VRgDu7U2/gSZ/H90n8EtwtXmu8
   sbPnVAHAhXfKHDuqQiflsqC27tyrTm17B7PezxwiXAzpgjyYotH4GgZhU
   l9HyOjrOGTFtSK1gRzTE00qHVszw6mQHSnq8vYNLVmxQWDE7ZFOMcI1iw
   BCPp10BAGUB+pjGxIl65+kBeaOJ8FWJuJNCI2/QCtplLLgAG1457DGe1D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="364255247"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364255247"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 23:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="860201841"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="860201841"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 23:08:40 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Reduce cost of accessing tg->load_avg
Date:   Wed, 23 Aug 2023 14:08:31 +0800
Message-ID: <20230823060832.454842-1-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

