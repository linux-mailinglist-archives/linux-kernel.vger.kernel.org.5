Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD89C80AF58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574834AbjLHWGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574835AbjLHWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:05:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DDE10E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:05:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A29DC433C7;
        Fri,  8 Dec 2023 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702073152;
        bh=CgYvOu578AFfLRbBC6EHcv8SUptcV6n5XjcrCPA7nDI=;
        h=From:To:Cc:Subject:Date:From;
        b=Pw+MKktqBiWhUgo6VfuY7O/2yoxIeItlKxQdYL8fX1bz1s/zy7Ihk79bC/wo1Bxzi
         uRBhcWs2U2UYM8pajpvAJQqhLS1aJEJRK3lZWjiB/Kbo2QkALyO58X3A+D0NApzlhs
         Bn8MOA1bGIAehpbs4DsmTNLqnsEvc+owbWRKAMWST3L6qc9VgdnxnPkdwwF1GDQ9ft
         Gv8/IyjFjDnOlait/gfqbobtCiex+zCxlqD/+1oAvQaJ8mGK9w38VwSjdMgdTa4A87
         lZqYCSKGDMU3PDjsZgd5PKusJFY5k5lUn0Nhnu4KjvGW4OcWko9ekeeaqzdFsFBZ7v
         jnjrxXCI3aBvA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/8] rcu: Fix expedited GP deadlock (and cleanup some nocb stuff)
Date:   Fri,  8 Dec 2023 23:05:37 +0100
Message-ID: <20231208220545.7452-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TREE04 can trigger a writer stall if run with memory pressure. This
is due to a circular dependency between waiting for expedited grace
period and polling on expedited grace period when workqueues go back
to mayday serialization.

Here is a proposal fix.

Frederic Weisbecker (8):
  rcu/nocb: Make IRQs disablement symetric
  rcu/nocb: Re-arrange call_rcu() NOCB specific code
  rcu/exp: Fix RCU expedited parallel grace period kworker allocation
    failure recovery
  rcu/exp: Handle RCU expedited grace period kworker allocation failure
  rcu: s/boost_kthread_mutex/kthread_mutex
  rcu/exp: Make parallel exp gp kworker per rcu node
  rcu/exp: Handle parallel exp gp kworkers affinity
  rcu/exp: Remove rcu_par_gp_wq

 kernel/rcu/rcu.h         |   5 -
 kernel/rcu/tree.c        | 222 +++++++++++++++++++++++++--------------
 kernel/rcu/tree.h        |  12 +--
 kernel/rcu/tree_exp.h    |  81 +++-----------
 kernel/rcu/tree_nocb.h   |  38 ++++---
 kernel/rcu/tree_plugin.h |  52 ++-------
 6 files changed, 191 insertions(+), 219 deletions(-)

-- 
2.42.1

