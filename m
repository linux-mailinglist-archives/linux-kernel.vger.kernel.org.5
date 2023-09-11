Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD679A17D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjIKCtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIKCts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:49:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96AD2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694400584; x=1725936584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=63f/LdQJ/j8DCo6YR8EfAaxaXL27tJlQbZ0kwGt3pVM=;
  b=f4p/qeOnFbM8zvXZzENkPNhhoZnZU/TfvE+KXhvSVPLWZLVvwUwRFgX+
   eAlCkAdaHJ1FlI0PGJBwUFslanf6uPna+0Qnkcbw724OaOiF0SQ5iGhCd
   AvsBX0yoK2c0QXGOTdne0utN5rJFtpzDEYI3fKwtsMINV66cbngWEPPTF
   +NUPpnVyCB2Qra1d7RUBS53K1tnkl6EyVQcVTd4Fc4bn9p7BGF8CidIon
   jzQ5Fv6HyErMDHiwnIcAHDihWbSVBkzSScREbfw/vSmyOmboElShWau3/
   bVEcIZDMA7ixWRj8Y/RMFKoTe40chMm4AwRcjzySxuwqGLgJC/++jXf0e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="368217065"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="368217065"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 19:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="808661192"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="808661192"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2023 19:49:39 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 0/2] Makes it easier for the wakee to choose previous CPU
Date:   Mon, 11 Sep 2023 10:49:14 +0800
Message-Id: <cover.1694397335.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When task p is woken up, the scheduler leverages select_idle_sibling()
to find an idle CPU for it. p's previous CPU is usually a preference
because it can improve cache locality. However in many cases the
previous CPU has already been taken by other wakees, thus p has to
find another idle CPU.

Inhit the task migration while keeping the work conservation of
scheduler could benefit many workloads. Inspired by Mathieu's
proposal to limit the task migration ratio[1], this patch takes
the task average sleep duration into consideration. If the
task is a short sleeping one, then tag its previous CPU as cache
hot for a short while. During this tag period, other wakees are
not allowed to pick this idle CPU until a timeout. Later if the
task is woken up again, it can find its previous CPU still be
idle, and chooses it in select_idle_sibling().

The benchmark from netperf has shown some improvement, which is
described in patch 2/2.

This series is based on the tip/sched/core on top of
Commit 3f4feb58037a ("sched: Misc cleanups").

It would be appreciated for any feedback/comments.

Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1

Chen Yu (2):
  sched/fair: Record the average sleep time of a task
  sched/fair: skip the cache hot CPU in select_idle_cpu()

 include/linux/sched.h   |  3 +++
 kernel/sched/fair.c     | 47 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    |  1 +
 4 files changed, 49 insertions(+), 3 deletions(-)

-- 
2.25.1

