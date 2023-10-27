Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7877D9BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbjJ0OlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjJ0OlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:41:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90883C4;
        Fri, 27 Oct 2023 07:41:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5322DC433BB;
        Fri, 27 Oct 2023 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698417660;
        bh=2vJeqFrics6fc78kHY5YdWmhThNCY0QoEBQ/4MZcNew=;
        h=From:To:Cc:Subject:Date:From;
        b=mywJLKmT3DdKLlNO9j9rzeGAwa0y142m4eFgcv5wonr70a4Y9SHDzaZDaLM+N1MLc
         wWr0Tn9nxV/shiabf1M/DOhjlwjXiGPYVywXa9OekjiseeK5kqBt26PDdMxq5HLBcb
         e9CnVnIsqUmxskNL/4y/4VhxiJScWvR+L47mEuiRLF0jo6CQMsJF5tN1d1G+jB09Nq
         u9iTTooTtKeg/n6wrthw8OnksTRT4L8JpoM0TIZQa/8jLS/TNfoNc3KJW8pGdl7l4z
         hIJoSquufh9WqXxiiV2/hu2sKzwfNQBC4IfH83O14RkL3l2M59KFPtaX44nTrMGfx8
         RXb8aq4hGxJOw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/4] rcu: Fix PF_IDLE related issues v3
Date:   Fri, 27 Oct 2023 16:40:46 +0200
Message-Id: <20231027144050.110601-1-frederic@kernel.org>
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

Hi,

The modification of PF_IDLE semantics lately to fix a bug in rcutiny
eventually introduced new bugs in RCU-tasks. This v3 carries the
following changes:

* Use per_cpu_ptr() to correctly handle the remote CPU on [1/4] (Thanks Zqiang)

* Test is_idle_task() even for non-idle task (idle injection) [2/4] (Thanks Peterz)

* No need to use WRITE_ONCE() / READ_ONCE() on PF_IDLE modification [4/4]
  (Thanks Peterz)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/tasks-dev

HEAD: afb666ef0fcde0b2ec30b007b0b30e5622ea30f0

Thanks,
	Frederic
---

Frederic Weisbecker (4):
      rcu: Introduce rcu_cpu_online()
      rcu/tasks: Handle new PF_IDLE semantics
      rcu/tasks-trace: Handle new PF_IDLE semantics
      sched: Exclude CPU boot code from PF_IDLE area


 kernel/cpu.c        |  4 ++++
 kernel/rcu/rcu.h    |  2 ++
 kernel/rcu/tasks.h  | 32 +++++++++++++++++++++++++++++---
 kernel/rcu/tree.c   |  7 +++++++
 kernel/sched/idle.c |  1 -
 5 files changed, 42 insertions(+), 4 deletions(-)
