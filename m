Return-Path: <linux-kernel+bounces-24819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C659D82C300
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2481EB23C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E589E7316A;
	Fri, 12 Jan 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqvOXEaD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1366EB7D;
	Fri, 12 Jan 2024 15:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E52C43399;
	Fri, 12 Jan 2024 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705074393;
	bh=5LTULEAdFpJcQBG6D6ceSXiQtGzk7tED42bNjO0Rk+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqvOXEaDSm1CyW5xE6ar9yif2JT/BSSeb2hAxaUYvxBC6RV1EP+KCjwxqnM4uTE5d
	 ROXKPFvKXMRZAaQSuZlw9GGniXf904gAus9MjM1pD+J8eNFhVBCnk0jzebVLg92FUl
	 cF3wK2nh3V0kXZI6b3Umu13fTPJTisxf4RZIHX7Yus7DyXamvjfI41l4vVq20EakH2
	 bddQVhGqId+9VUGOA3l5xGOFZHX6altm21y38nHW/TdVLH8m1QwYnexISLbIIF1jiK
	 blXNHTKWz7zh31Y66VGCeg14Iimr3ahuwaE3N0rhD9BPwEUx5sVUc3OJ1hpNCo4e6y
	 ekPoSnbYMIVWw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH 1/7] rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
Date: Fri, 12 Jan 2024 16:46:15 +0100
Message-Id: <20240112154621.261852-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112154621.261852-1-frederic@kernel.org>
References: <20240112154621.261852-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under CONFIG_RCU_EXP_KTHREAD=y, the nodes initialization for expedited
grace periods is queued to a kworker. However if the allocation of that
kworker failed, the nodes initialization is performed synchronously by
the caller instead.

Now the check for kworker initialization failure relies on the kworker
pointer to be NULL while its value might actually encapsulate an
allocation failure error.

Make sure to handle this case.

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kthread_worker")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 499803234176..b000c1a83fc2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4760,6 +4760,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
 		return;
 	}
-- 
2.34.1


