Return-Path: <linux-kernel+bounces-24818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A8F82C2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF876B225D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7927E6EB6A;
	Fri, 12 Jan 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1VHfd28"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104D6EB4E;
	Fri, 12 Jan 2024 15:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614ECC433C7;
	Fri, 12 Jan 2024 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705074391;
	bh=sqERbnaek2gOhofvXHUtaO6gMYEIXaSQNKqGujdSGJs=;
	h=From:To:Cc:Subject:Date:From;
	b=s1VHfd28XLMMWLH27XZJhQJuSKihUO2kfwK8Q0e4CcjbNWEo6bWpYb8hHvli79hrT
	 1bMHVu1vt2phOwgvIJx6pf2xfgxkfkqaZDf30YgovBRjdFihg5+XJkz07DoN0cvCua
	 Uc+YI973ty5oeC08vyE8MGlx5EdAftM2sQ+x25fjKfpY3lczMAt9shiXT3vIbTadOm
	 TpBtlk47uTEEowBQcN8t0RIC1YmFqMqfVIVl2I21/p0N39YO1U29x4Ylq3Dzs7aSCX
	 Q43T+Lqx5CHF4D03Bwrk6P7yM1l6QtKsxLSceJE/9IwqmAm99oyDz5OwcOOOb6oavy
	 17LWod7r0pjWA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/7] rcu: Fix expedited GP deadlock
Date: Fri, 12 Jan 2024 16:46:14 +0100
Message-Id: <20240112154621.261852-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TREE04 can trigger a writer stall if run with memory pressure. This
is due to a circular dependency between waiting for expedited grace
period and polling on expedited grace period when workqueues go back
to mayday serialization.

Here is a proposal fix.

Changes since v2 (no functional changes, just renames and reorganization):

_ Move nocb cleanups to their own series
_ Rename can_queue parameter to use_worker [2/7]
_ Better explain the rename of the mutex [3/7]
_ New commit with just code move to ease review [4/7]
_ Comment declaration of the new rnp->exp_worker field [5/7]

Thanks.

Frederic Weisbecker (7):
  rcu/exp: Fix RCU expedited parallel grace period kworker allocation
    failure recovery
  rcu/exp: Handle RCU expedited grace period kworker allocation failure
  rcu: s/boost_kthread_mutex/kthread_mutex
  rcu/exp: Move expedited kthread worker creation functions above
    rcutree_prepare_cpu()
  rcu/exp: Make parallel exp gp kworker per rcu node
  rcu/exp: Handle parallel exp gp kworkers affinity
  rcu/exp: Remove rcu_par_gp_wq

 kernel/rcu/rcu.h         |   5 --
 kernel/rcu/tree.c        | 175 +++++++++++++++++++++++++++------------
 kernel/rcu/tree.h        |  11 ++-
 kernel/rcu/tree_exp.h    |  78 +++--------------
 kernel/rcu/tree_plugin.h |  52 ++----------
 5 files changed, 142 insertions(+), 179 deletions(-)

-- 
2.34.1


