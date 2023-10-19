Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FDB7D056B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346711AbjJSXf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjJSXfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:35:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CB7115;
        Thu, 19 Oct 2023 16:35:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD2EC433C7;
        Thu, 19 Oct 2023 23:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697758551;
        bh=SzLWgqoBPQQV6V/J505+0jRncHFp919ngRzIfJhC4vg=;
        h=From:To:Cc:Subject:Date:From;
        b=kdlrCLav/1qxe+M3GYO1Mt3VSCTSLV695AQlk5hcUYK7f8k5YG8jeexEqBnddmSCF
         cj2sxDOoteNjSh/oGgmCdbNKq67BTYV0VPlJ6uOXoIZqSmz9sPwwoEn9b2UXBNxrnQ
         mutI3F+8Fq9zoXNcmSzgDeIXdf1OaH20XpUHlZ7nQSaHMHITf/5zLGhT2JQ3sUOy9/
         R8D+X1bKaQpzOTmi1yuDlBJD0l39ZK+koMwdYH0d6/+L5JNwWe5wagC+BG9AIEJMwA
         faSGciZKKVeoDCQxtAGIQg5ZQJtDST1mxkx3CaeILSGfxFqmn9zHuD0ngVb62r2l/u
         +cEP/irpUWV1Q==
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
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 0/4] rcu: Fix PF_IDLE related issues, part. 1
Date:   Fri, 20 Oct 2023 01:35:39 +0200
Message-Id: <20231019233543.1243121-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The modification of PF_IDLE semantics lately to fix a bug in rcutiny
eventually introduced new bugs in RCU-tasks. This series revert that
PF_IDLE modification and fix rcutiny in an alternate way.

More issues need to be fixed in RCU-tasks:

* The boot code preceding the idle entry is included in this
  quiescent state. Especially after the completion of kthreadd_done
  after which init/1 can launch userspace concurrently. The window
  is tiny before PF_IDLE is set but it exists.

* Similarly, the boot code preceding the idle entry on secondary
  CPUs is wrongly accounted as RCU tasks quiescent state.

And those will be fixed separetely.

Frederic Weisbecker (4):
  softirq: Rename __raise_softirq_irqoff() to raise_softirq_no_wake()
  softirq: Introduce raise_ksoftirqd_irqoff()
  rcu: Make tiny RCU use ksoftirqd to trigger a QS from idle
  Revert "kernel/sched: Modify initial boot task idle setup"

 block/blk-mq.c            |  2 +-
 include/linux/interrupt.h |  3 ++-
 kernel/rcu/tiny.c         | 21 +++++++++++++-----
 kernel/sched/core.c       |  2 +-
 kernel/sched/idle.c       |  1 -
 kernel/softirq.c          | 45 +++++++++++++++++++++++++--------------
 lib/irq_poll.c            |  4 ++--
 net/core/dev.c            |  8 +++----
 8 files changed, 55 insertions(+), 31 deletions(-)

-- 
2.34.1

