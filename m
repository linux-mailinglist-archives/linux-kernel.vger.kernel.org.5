Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409D777D890
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbjHPCtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbjHPCsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:48:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCBF212D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692154129; x=1723690129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Skr/d/Gsy3Lv09RBnrhYA65xNjEbgJO9BhEyIPx5uU=;
  b=bWViVOIrPFA1VVHqBEMj8zUFA2TwinpuNRDsTmEeowOAxtyeFE6QAOMB
   q3ixA7s0xwfT9FBnr29NQNO6OHrhNfT16bWcVu0aIKLZYzg2T1fmMbZ4T
   nPQ9BbRmXgpCWEr2BtfAL+UKyhkxgZgNsoRDnlW7bfYpXQPc26ewd2MOu
   Tu0/55Hli+qMHOS/anPBhV5e90jGufqGIrbETDGvLNOakfRkwgvCglIMJ
   WjkFGYFRuOG98GgWpU1OhRhfH0cUHHvvPF4VC06Gnh37zrwQUxihsUce+
   gSG+hQOQ7Q5b59W8EmcH99ZtnOtI7yao+E0xquF+WM4kxzPxUyyi53YES
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438770432"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="438770432"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 19:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734040502"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="734040502"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 19:48:42 -0700
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
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/1] Reduce cost of accessing tg->load_avg
Date:   Wed, 16 Aug 2023 10:48:30 +0800
Message-ID: <20230816024831.682107-1-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

