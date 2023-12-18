Return-Path: <linux-kernel+bounces-4478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAA0817E06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF6C284D32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2247995E;
	Mon, 18 Dec 2023 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuJESOJ2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B1768FC;
	Mon, 18 Dec 2023 23:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BCEC433C8;
	Mon, 18 Dec 2023 23:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702941572;
	bh=x/5xI2oI/qJM/7tPaUtUa288bDEyvUKnDytjUeL9Kh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuJESOJ2ve3eFm0UYRg2rZDQWAy4X4nBL5GMaqztfenpsittW/7VpTa2Fhrd4QSGm
	 +4WtgAd5/4b0ttyCzM/F0tWSKiBtHuIgRSmPJC+MNF4qQK7AzbDFLquasL5HIhBvko
	 2od7mFYsC3y7Z9lM/13oy3C5Ds0lgasesvO74eNVZbI0UDBt/hrYn+2OcZE1v8lBsQ
	 F1o10ntJRcveoVk9Uqd/OvHDDEpWoLi5bGtodA9+4g8SXSWR7E84jbSCX3xnEqp+ta
	 tuxCuQSKug4vCynxWCzXdsfwjFQS+o/dd0A4bRCEumq3jmNKrGJFoV6WBRWwEugbtK
	 0X6UvUFT1qdUw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/3] rcu/exp: Remove full barrier upon main thread wakeup
Date: Tue, 19 Dec 2023 00:19:16 +0100
Message-ID: <20231218231916.11719-4-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231218231916.11719-1-frederic@kernel.org>
References: <20231218231916.11719-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an expedited grace period is ending, care must be taken so that all
the quiescent states propagated up to the root are correctly ordered
against the wake up of the main expedited grace period workqueue.

This ordering is already carried through the root rnp locking augmented
by an smp_mb__after_unlock_lock() barrier.

Therefore the explicit smp_mb() placed before the wake up is not needed
and can be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2ac440bc7e10..014ddf672165 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -198,10 +198,9 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 		}
 		if (rnp->parent == NULL) {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-			if (wake) {
-				smp_mb(); /* EGP done before wake_up(). */
+			if (wake)
 				swake_up_one_online(&rcu_state.expedited_wq);
-			}
+
 			break;
 		}
 		mask = rnp->grpmask;
-- 
2.42.1


