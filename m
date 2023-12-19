Return-Path: <linux-kernel+bounces-5319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDB481895B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D812E1F23DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3CD1B27D;
	Tue, 19 Dec 2023 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro8s2e6B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237001B270;
	Tue, 19 Dec 2023 14:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A433C433C7;
	Tue, 19 Dec 2023 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702994931;
	bh=qermIcNndRs4NNt6coSsX2HdKHOBXCJ/SRIJwiNKWz0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ro8s2e6Bi41rJCJ73+OxheKUaJ9Ka2c4+x4aHuUOcNIqvuz9Ptsle/b2SZpMfbsEt
	 9t52BIGw7VOAoP5qGLZQJ+IulFPkPzn0LLtbebVTt2L1unO50JZVL0gqXnADVXN+Jw
	 kKNJKsRgzY6rXo4a0pJsN5otKSaNexllAp0hesu2idRXgwHujmXmnVjf8V+JgEbPhk
	 F28dx8qj9Y74xHS18ltSRfwm7BNxUTMJ4XQxlw7PFZW1g442X6MKg9eHFB3ASO2br/
	 yldfX81y49zGnb8hlFShvqtcojfaI2cO3cY5H8/blH9cTKcQBAilargprTVLYqUxzf
	 IT5HZTe3tLwMg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Hillf Danton <hdanton@sina.com>
Subject: [PATCH 0/8 v2] rcu: Fix expedited GP deadlock (and cleanup some nocb stuff)
Date: Tue, 19 Dec 2023 15:08:35 +0100
Message-Id: <20231219140843.939329-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TREE04 can trigger a writer stall if run with memory pressure. This
is due to a circular dependency between waiting for expedited grace
period and polling on expedited grace period when workqueues go back
to mayday serialization.

Here is a proposal fix.

Changes since v1:

* Add __maybe_unused to __call_rcu_nocb_wake() declaration (reported by Paul)

* Add reviewed-by tags

* Fix nocb changelog (reported by Neeraj)

* Fixed comment (reported by Hillf)

Frederic Weisbecker (8):
  rcu/nocb: Make IRQs disablement symmetric
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
 kernel/rcu/tree.h        |  18 ++--
 kernel/rcu/tree_exp.h    |  81 +++-----------
 kernel/rcu/tree_nocb.h   |  38 ++++---
 kernel/rcu/tree_plugin.h |  52 ++-------
 6 files changed, 194 insertions(+), 222 deletions(-)

-- 
2.34.1


