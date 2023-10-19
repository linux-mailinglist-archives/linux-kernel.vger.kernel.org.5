Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9A7CF7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjJSMCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjJSMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:02:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D7318D;
        Thu, 19 Oct 2023 05:02:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FABCC433C8;
        Thu, 19 Oct 2023 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716929;
        bh=kcjx4YxAcQZb48f+2uZ3X8gmikqy2As6pSmOkQMDucE=;
        h=From:To:Cc:Subject:Date:From;
        b=toHsj1C/DSVPW8X+7tT+6QYuYKC/K+Ph7m5cgF8s0sdURqsVtvelUs0J2wQLAZfGq
         CpvviPL+5dqaU5xKiR3x6UBcrf4+WrFk3dpbLOxV4mfyvvWJ1ecM2CYrJDGapMBusK
         BwMn7v6vZvbO3j1Frp+qiLfGgCEasy4EQGrdKm/0dsNPngEOTrZ9nLxpC3zvjDypan
         rabC3xGdilb8DZ10vvYNVwkKa9mVcRvPVCs0+xE9infTn4EyDORq8wpS7ozC6zPnGN
         8kjlaW2JJ/bu3nS2jEMwaw75ERXSbhHc3SmI9AQBfmeBOBZW53q2ymnxH6ID+8A0/Q
         pYLb+P6UEmeAw==
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
Subject: [PATCH 0/6] RCU stall detection updates for v6.7
Date:   Thu, 19 Oct 2023 14:01:56 +0200
Message-Id: <20231019120202.1216228-1-frederic@kernel.org>
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

Please find below the RCU stall detection updates for the next merge 
window:

Joel Fernandes (Google) (1):
  rcu/tree: Defer setting of jiffies during stall reset

Paul E. McKenney (2):
  rcu: Add RCU CPU stall notifier
  rcutorture: Add test of RCU CPU stall notifiers

Zhen Lei (3):
  rcu: Delete a redundant check in rcu_check_gp_kthread_starvation()
  rcu: Don't redump the stalled CPU where RCU GP kthread last ran
  rcu: Eliminate check_cpu_stall() duplicate code

Thanks,
        Frederic.

 include/linux/rcu_notifier.h |  32 +++++++++
 kernel/rcu/rcu.h             |   6 ++
 kernel/rcu/rcutorture.c      |  21 ++++++
 kernel/rcu/tree.c            |  12 ++++
 kernel/rcu/tree.h            |   4 ++
 kernel/rcu/tree_exp.h        |   6 +-
 kernel/rcu/tree_stall.h      | 135 +++++++++++++++++++++++++----------
 7 files changed, 178 insertions(+), 38 deletions(-)
 create mode 100644 include/linux/rcu_notifier.h

-- 
2.34.1

