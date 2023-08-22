Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C4F783EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjHVLbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjHVLbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:31:01 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285CFCCA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692703859;
        bh=Rhxx1505nyaBKkevGIY3vs2MQF3lYf7OC0CY8zRoL1w=;
        h=From:To:Cc:Subject:Date:From;
        b=eKCvInwcr1LuD6mieeKO3A5krOYureCDE6pUSXQx+cxDnmKQA8ni2oyVGFZUue4bx
         O4EWCbjNaNI94dVcZd6zv2mg9TVfhHpl2eILovOP2wKrL3hZnoo+ucpa3RrNjGc4Ia
         DFa0AlSirt7JoZRZiR916tPQLpSLRPFwFfkQVvbqS9deGTw9ZcvlhnOjNviZM/GA+F
         9M+noEDozNGTO4jTosCSW/CQHkarGBHndZjgMmFT1xyU5xN04U9ALwVcPyH0/nq7Jf
         3tzsm7MW5rvFhhwzb9QAodq9ZqtWfXdyRfujYcMR2Jel1oAKlI3mpkruqmUACM+wed
         +dtdt8krMOaBA==
Received: from thinkos.home (unknown [142.120.205.109])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RVRxH1mZcz1M0x;
        Tue, 22 Aug 2023 07:30:59 -0400 (EDT)
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
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
Subject: [RFC PATCH v3 0/3] sched: Skip queued wakeups only when L2 is shared
Date:   Tue, 22 Aug 2023 07:31:30 -0400
Message-Id: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
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

This series improves performance of scheduler wakeups on large systems
by skipping queued wakeups only when CPUs share their L2 cache, rather
than when they share their LLC.

The speedup mainly reproduces on workloads which have at least *some*
idle time (because it significantly increases the number of migrations,
and thus remote wakeups), *and* it needs to have a sufficient load to
cause contention on the runqueue locks.

Feedback is welcome,

Thanks,

Mathieu

Mathieu Desnoyers (3):
  sched: Rename cpus_share_cache to cpus_share_llc
  sched: Introduce cpus_share_l2c (v3)
  sched: ttwu_queue_cond: skip queued wakeups across different l2 caches

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
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: x86@kernel.org

 block/blk-mq.c                 |  2 +-
 include/linux/sched/topology.h | 10 ++++++++--
 kernel/sched/core.c            | 14 +++++++++++---
 kernel/sched/fair.c            |  8 ++++----
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        | 32 +++++++++++++++++++++++++++++---
 6 files changed, 55 insertions(+), 13 deletions(-)

-- 
2.39.2

