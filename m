Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DC87CE947
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjJRUpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRUpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:45:10 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09BAA4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697661905;
        bh=WFYnTqSi8zmo4rKmus4j8G1ssP+zDU3csH61FA/nZ0M=;
        h=From:To:Cc:Subject:Date:From;
        b=n2DL5hkWXvJpUEhQ8GWDJBXeq8cgm/0mCkXlHVYB26KVrYtKLl0FeB9TdxrhxuEdo
         RQ/urvBw0i7lWu3p00sEGzV0M11NW4kqxfM/JongARbhqHOcTpmlX7KkLGVDUaapCB
         aENdejOgMo617IblNOhDQSprcbqS3KFnrZC3jvCCuej+Tr/pGGcg7gElrIKsFNYLlT
         7n3LhCrZo8pc2PS2aHvOQC7+R7lEwMH+gsuzhI0pccflp41xNP56CUTQEW0IcXTMYf
         EI0qmUUmTG/I+gTmi5nEbKKHnED4qcOgTO/vS9FCTy/lltIQKTMeyJIkcrBnvX1yxK
         /KRgvdVgAN0cQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4S9jXK0N5pz1Y97;
        Wed, 18 Oct 2023 16:45:05 -0400 (EDT)
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
Subject: [RFC PATCH 0/2] sched/fair migration reduction features
Date:   Wed, 18 Oct 2023 16:45:09 -0400
Message-Id: <20231018204511.1563390-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series introduces two new scheduler features: UTIL_FITS_CAPACITY
and SELECT_BIAS_PREV. When used together, they achieve a 47% speedup of
a hackbench workload which leaves some idle CPU time on a 192-core AMD
EPYC.

The main metrics which are significantly improved are:

- cpu-migrations are reduced by 93%,
- CPU utilization is increased by 22%.

Feedback is welcome. I am especially interested to learn whether this
series has positive or detrimental effects on performance of other
workloads.

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
  sched/fair: Introduce UTIL_FITS_CAPACITY feature
  sched/fair: Introduce SELECT_BIAS_PREV to reduce migrations

 kernel/sched/fair.c     | 77 ++++++++++++++++++++++++++++++++++++-----
 kernel/sched/features.h | 12 +++++++
 kernel/sched/sched.h    |  5 +++
 3 files changed, 86 insertions(+), 8 deletions(-)

-- 
2.39.2

