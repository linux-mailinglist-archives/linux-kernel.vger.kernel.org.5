Return-Path: <linux-kernel+bounces-5322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442481895E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B170728658B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9F1C6BF;
	Tue, 19 Dec 2023 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+04tnMX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBB1C69A;
	Tue, 19 Dec 2023 14:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC92C433C9;
	Tue, 19 Dec 2023 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702994939;
	bh=ZjGnGBQcKOLWjk3O6+MQmOZH7Lf2D/YICIuiuNyYbfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+04tnMX7lHaLk33grTKASgCQ0JPdFsQ3e3PKPR7VEV9x0G36dYtdTqvSdAJ88YFn
	 b3HBIic3EufpEQ+fWvtPtn4FUsP983DvXrPLQk0sii9jA+z10/Xghbzg9CuZgKzp05
	 0cGOR2IwbavesVVOQFQAsNkHKDCoFPCSKdmnrEbc28FFIX0HZrfOY73guoM1DjL0C6
	 gzhibUM9AhqGwJ4rA7RI96U3HSom2TRnu3evXM2MIvgO2Pg3LGz9WMXQgdZDiFuD5+
	 S5N0DESOHsNhGSrfMFtYy5MXC2I6jWV6zP4flNpVaaCvPcjpj4yExqPbcP7KKE+nvt
	 hG0BRDkYZVpMQ==
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
	Hillf Danton <hdanton@sina.com>,
	Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH 3/8] rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
Date: Tue, 19 Dec 2023 15:08:38 +0100
Message-Id: <20231219140843.939329-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219140843.939329-1-frederic@kernel.org>
References: <20231219140843.939329-1-frederic@kernel.org>
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
index de5796ce024f..65d730a2b492 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4759,6 +4759,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
 		return;
 	}
-- 
2.34.1


