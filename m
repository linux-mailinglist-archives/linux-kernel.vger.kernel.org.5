Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C67CFF03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbjJSQFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbjJSQFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:05:20 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687F312A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697731516;
        bh=HmwG14J3AlJoFMkkIkRSsNIqRZMe3libr4mFaqc0lWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sOQBiwTuhHyiox3zgOd1KHiJH4E0m1+/QHJ135qcyd3qkrjfs25NHK7KSwkEsNHtY
         OBYe1p6yydyvA98wddrcu0R8YLVH04MRPcIcdx19zbQ20sl77vg8vNUzUN69M/4I7Y
         tl1YKxIRvBiHH4pVjUAmuDcf2ZsucjVMIJjGyIPICljcpQs6nWemi9F+RTHvzD3tq2
         InVT2Q9wOAqugVbn1iwThq0WKU/zdUt5TOTHjXSJ++MUrbhuXf1ThOuc1SzTZB1EKJ
         OS+fdfrdzZqlGvXLKYohEC92SJFi+UDAmQM8Tn6ER1mBbHhVcKNq5HDAyeJ8u2SCYE
         eI1sCihlLbQDw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SBCH00lhcz1YPd;
        Thu, 19 Oct 2023 12:05:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
Subject: [RFC PATCH v2 0/2] sched/fair migration reduction features
Date:   Thu, 19 Oct 2023 12:05:21 -0400
Message-Id: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series introduces two new scheduler features: UTIL_FITS_CAPACITY
and SELECT_BIAS_PREV. When used together, they achieve a 41% speedup of
a hackbench workload which leaves some idle CPU time on a 192-core AMD
EPYC.

The main metrics which are significantly improved are:

- cpu-migrations are reduced by 80%,
- CPU utilization is increased by 17%.

Feedback is welcome. I am especially interested to learn whether this
series has positive or detrimental effects on performance of other
workloads.

The main changes since v1 are to take into account feedback from Chen Yu
and keep a 20% margin of unused utilization in the capacity fit, and use
scale_rt_capacity() which is more precise.

Thanks,

Mathieu

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Gautham R . Shenoy <gautham.shenoy@amd.com>
Cc: x86@kernel.org

Mathieu Desnoyers (2):
  sched/fair: Introduce UTIL_FITS_CAPACITY feature (v2)
  sched/fair: Introduce SELECT_BIAS_PREV to reduce migrations

 kernel/sched/fair.c     | 68 ++++++++++++++++++++++++++++++++++++-----
 kernel/sched/features.h | 12 ++++++++
 kernel/sched/sched.h    |  5 +++
 3 files changed, 77 insertions(+), 8 deletions(-)

-- 
2.39.2

