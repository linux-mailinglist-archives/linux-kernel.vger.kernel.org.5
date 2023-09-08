Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2210B799106
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbjIHUgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjIHUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:36:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF9EA3;
        Fri,  8 Sep 2023 13:36:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAABDC433C8;
        Fri,  8 Sep 2023 20:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205372;
        bh=TIEmpsAKURry6qJEscQuFYmrXAfV6S/0QPa4RuI6qLg=;
        h=From:To:Cc:Subject:Date:From;
        b=HDrzRLwDEnvL2EhqTnttOS8Tjo/ynYGrbq80SVAFCNVdAp5A+YGjm4eyInzAI/RU+
         zF79o0S5sKeKYnSdc9OnOlrUR7zxVE2lw+t/kPytTFtBSepcDUofzVsLsX+5B6dA3h
         fTvXbthUmPL/NAgt5qty5vsCKKgd0rRKY9TkFu+6w08PlIErUouwUVY/46hGNqounL
         Kz+x0ry1NCcckkU8GjxP1qtae3AM2vYDYAFnBKtn5NWqDoRrnFbZ1p7JYW4HYKeuWu
         OuN7PAtj0i14eQEHRo+H8nZ4yTzH3EDJkOK7Lhyy2P8om+e3cmuTuqadg8Ux52aU3a
         6OU5TprpEZoNg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 00/10] rcu cleanups
Date:   Fri,  8 Sep 2023 22:35:53 +0200
Message-ID: <20230908203603.5865-1-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a bunch of accumulated cleanups. Many of them are trivial but
beware some tricky ordering changes in the middle :-)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 43d6b973aeb7459d29cd52054142291b099bf8ad

Thanks,
	Frederic
---

Frederic Weisbecker (10):
      rcu: Use rcu_segcblist_segempty() instead of open coding it
      rcu: Rename jiffies_till_flush to jiffies_lazy_flush
      rcu/nocb: Remove needless LOAD-ACQUIRE
      rcu/nocb: Remove needless full barrier after callback advancing
      rcu: Assume IRQS disabled from rcu_report_dead()
      rcu: Assume rcu_report_dead() is always called locally
      rcu: Conditionally build CPU-hotplug teardown callbacks
      rcu: Standardize explicit CPU-hotplug calls
      rcu: Remove references to rcu_migrate_callbacks() from diagrams
      rcu: Comment why callbacks migration can't wait for CPUHP_RCUTREE_PREP


 .../Expedited-Grace-Periods.rst                    |   2 +-
 .../Memory-Ordering/TreeRCU-callback-registry.svg  |   9 --
 .../RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg  |   4 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |  13 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg |   4 +-
 .../RCU/Design/Requirements/Requirements.rst       |   4 +-
 arch/arm64/kernel/smp.c                            |   4 +-
 arch/powerpc/kernel/smp.c                          |   2 +-
 arch/s390/kernel/smp.c                             |   2 +-
 arch/x86/kernel/smpboot.c                          |   2 +-
 include/linux/interrupt.h                          |   2 +-
 include/linux/rcupdate.h                           |   2 -
 include/linux/rcutiny.h                            |   2 +-
 include/linux/rcutree.h                            |  16 ++-
 kernel/cpu.c                                       |  13 +-
 kernel/rcu/rcu.h                                   |   8 +-
 kernel/rcu/rcu_segcblist.c                         |   4 +-
 kernel/rcu/rcuscale.c                              |   6 +-
 kernel/rcu/tree.c                                  | 138 ++++++++++-----------
 kernel/rcu/tree_nocb.h                             |  24 ++--
 20 files changed, 129 insertions(+), 132 deletions(-)
