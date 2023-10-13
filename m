Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E77C8520
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJML7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjJML7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E7CA;
        Fri, 13 Oct 2023 04:59:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E96DC433C7;
        Fri, 13 Oct 2023 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198348;
        bh=mdyvAP957loI8J8QOxKdfswgmuSBf12C4pS3V4YG9sU=;
        h=From:To:Cc:Subject:Date:From;
        b=pBISt8PuC4Qco3NADCdhtqPjh8dL/EGmsyK4MpMEaCOQGER+N58KwVTqtvk4Vz7yY
         rfPBy11nvSgnf2hGZ65acpV1yi67Fj2TzCrlLJqlNMNBi4T9N9ncqoWPeJn4BGIpmW
         Pa99/cUGBkYtiIru0Tujlu9afRUtEG62O1oIizKQgI4jpccT2OcexRg3XECNMLJ54U
         2WIqP8De3l43jf/b6bdxERbTuci/Wj2h5N+yrLoXxttJadTjYuQnFVbELVZ07X0kQ4
         ehhPif6PypewPdFE3DOSgzhqUthvsGbPqt13MY6YlO0wfvG676ak723kwMQY2XVQku
         +LXrt303Qa/jQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 00/18] RCU fixes for v6.7
Date:   Fri, 13 Oct 2023 13:58:44 +0200
Message-Id: <20231013115902.1059735-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please find below the general (S)RCU fixes:

Catalin Marinas (1):
  rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing
    objects

Denis Arefev (1):
  srcu: Fix srcu_struct node grpmask overflow on 64-bit systems

Frederic Weisbecker (8):
  rcu: Use rcu_segcblist_segempty() instead of open coding it
  rcu: Assume IRQS disabled from rcu_report_dead()
  rcu: Assume rcu_report_dead() is always called locally
  rcu: Conditionally build CPU-hotplug teardown callbacks
  rcu: Standardize explicit CPU-hotplug calls
  rcu: Comment why callbacks migration can't wait for CPUHP_RCUTREE_PREP
  srcu: Fix callbacks acceleration mishandling
  srcu: Only accelerate on enqueue time

Joel Fernandes (Google) (3):
  Revert "checkpatch: Error out if deprecated RCU API used"
  srcu: Fix error handling in init_srcu_struct_fields()
  rcu/tree: Remove superfluous return from void call_rcu* functions

Paul E. McKenney (2):
  rcu: Add sysfs to provide throttled access to rcu_barrier()
  rcu: Eliminate rcu_gp_slow_unregister() false positive

Yue Haibing (1):
  rcu: Remove unused function declaration rcu_eqs_special_set()

Zhen Lei (2):
  mm: Remove kmem_valid_obj()
  rcu: Dump memory object info if callback function is invalid

 .../Expedited-Grace-Periods.rst               |   2 +-
 .../Design/Memory-Ordering/TreeRCU-gp-fqs.svg |   4 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg |   4 +-
 .../Memory-Ordering/TreeRCU-hotplug.svg       |   4 +-
 .../RCU/Design/Requirements/Requirements.rst  |   4 +-
 .../admin-guide/kernel-parameters.txt         |   7 +
 arch/arm64/kernel/smp.c                       |   4 +-
 arch/powerpc/kernel/smp.c                     |   2 +-
 arch/s390/kernel/smp.c                        |   2 +-
 arch/x86/kernel/smpboot.c                     |   2 +-
 include/linux/interrupt.h                     |   2 +-
 include/linux/rcupdate.h                      |   2 -
 include/linux/rcutiny.h                       |   2 +-
 include/linux/rcutree.h                       |  17 +-
 include/linux/slab.h                          |   5 +-
 kernel/cpu.c                                  |  13 +-
 kernel/rcu/rcu.h                              |   7 +
 kernel/rcu/rcu_segcblist.c                    |   4 +-
 kernel/rcu/srcutiny.c                         |   1 +
 kernel/rcu/srcutree.c                         |  76 ++++--
 kernel/rcu/tasks.h                            |   1 +
 kernel/rcu/tiny.c                             |   1 +
 kernel/rcu/tree.c                             | 230 ++++++++++++------
 mm/slab_common.c                              |  41 +---
 mm/util.c                                     |   4 +-
 scripts/checkpatch.pl                         |   9 -
 26 files changed, 284 insertions(+), 166 deletions(-)

-- 
2.34.1

