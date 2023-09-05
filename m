Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E3792D07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbjIESFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbjIESFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:05:03 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A280BE00
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693933807;
        bh=AcMD81TekA/JK8LoCnSfZUmeGklie5gXP/o4TUk+hg8=;
        h=From:To:Cc:Subject:Date:From;
        b=MbZ3+UHu2Hn7pCY3Vfd/ktDB78uR6Kon3udHrJMu5q8chkpW7mJUOFM+aeCcJjLSw
         ZZFk0Q0tdyzACEojrA4zSrXLpOEbJxWOxakZzVlJJ6vYJ+cNZwICHfFkzat3jOoxAC
         CnXztkQX3cscwR2Fiwg6AdTDQ38lX2Tz1s7g5yfZI4FhF1NqoilQANAPI7YC9XB+QF
         wYMXvlJFZd0SGjm6tnH3sWkS31iYC+ma4wuMc0sZAS0SmgUE6mVnvZIwqDLYDd0pRc
         hqCfo0iuAOohH8b4dGafx1fmlW4Kyz5jMT/jw1cD2XFMxlq4iYiGXR0JLwekcHqZBK
         +ZfcjqgeRg1IA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RgBp65H6tz1NXl;
        Tue,  5 Sep 2023 13:10:06 -0400 (EDT)
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
Subject: [RFC PATCH 0/2] sched/eevdf: Rate limit task migration
Date:   Tue,  5 Sep 2023 13:11:03 -0400
Message-Id: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
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

Implement task migration rate limiting to speed up workload patterns
such as hackbench which trigger frequent migrations.

The first patch implements a simple rate limiting of 1 migration per
2ms. The second patch implements adaptative task migration rate
limiting.

I would be interested to hear feedback on this approach, especially
about how it behaves on various workloads.

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
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: x86@kernel.org

Mathieu Desnoyers (2):
  sched: rate limit migrations to 1 per 2ms per task
  sched: Implement adaptative rate limiting of task migrations

 include/linux/sched.h |  4 ++++
 kernel/sched/core.c   |  3 +++
 kernel/sched/fair.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |  4 ++++
 4 files changed, 51 insertions(+)

-- 
2.39.2

