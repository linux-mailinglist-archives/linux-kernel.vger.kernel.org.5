Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807017D5D66
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbjJXVqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344380AbjJXVqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:46:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF2FE8;
        Tue, 24 Oct 2023 14:46:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F533C433C8;
        Tue, 24 Oct 2023 21:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698183994;
        bh=yHSm2YM/bMQkAnbmpHj+BQijT/wk2j7ErJc48tU8SPo=;
        h=From:To:Cc:Subject:Date:From;
        b=tLccx/3EY+Moi4YGUpshCDMQO45hBfs9xgyAkvQGsPrridNrqRMnPfmAUc3YBChZg
         LjAwkkG3W+kBMV0YDLKC/UViCQN1vlDCWRRwSay+Vjsq5RdhXf5EbLCVCwJGJFWALq
         tkOt17wt3Nns9/Lfgbf2oq1gOin78wctBTNVGOpsfjOZmMCH5C/0nghz36lnUjnHeq
         HsrXV/2C6PACjRx7U4UFtTtGL0pJsT2AOpl/F88C0Iz+2Vbz039Doh6oYaSNfXVYJD
         B1K+2uDwA8ELfBnfCWd0sJLpRS30uNOm3J7k97VrRn5N4Ho/JY0uszNFqxkaOC1ovZ
         p4kl/Ja14CDPQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/4] rcu: Fix PF_IDLE related issues v2
Date:   Tue, 24 Oct 2023 23:46:21 +0200
Message-ID: <20231024214625.6483-1-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
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

The modification of PF_IDLE semantics lately to fix a bug in rcutiny
eventually introduced new bugs in RCU-tasks. In this v2, this series
propose to fix these issues without reverting:

	cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")

Frederic Weisbecker (4):
  rcu: Introduce rcu_cpu_online()
  rcu/tasks: Handle new PF_IDLE semantics
  rcu/tasks-trace: Handle new PF_IDLE semantics
  sched: Exclude CPU boot code from PF_IDLE area

 include/linux/sched.h |  2 +-
 kernel/cpu.c          |  4 ++++
 kernel/rcu/rcu.h      |  2 ++
 kernel/rcu/tasks.h    | 33 ++++++++++++++++++++++++++++++---
 kernel/rcu/tree.c     |  7 +++++++
 kernel/sched/idle.c   |  1 -
 6 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.41.0

