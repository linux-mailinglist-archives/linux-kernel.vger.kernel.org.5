Return-Path: <linux-kernel+bounces-115805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB26889937
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D239B39EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F10145B12;
	Mon, 25 Mar 2024 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAkMMrV/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5AE145350;
	Sun, 24 Mar 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321991; cv=none; b=Go8Nh6KGtpBV35u+VB89nakAb8OnlHmWTpKrbJUtJJYJwrthyY3YhSQWLdvFVLs6MFAMFeWJ2QA+Nf3pngTTkmvRcIBqxuLBhpGL6WSiO2LaKogJ2Pk8c2o9ClSES4S/1TZxWSyvgQ+9iVzSDtMQ/PcesEjvhynhjLR8sFb0O98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321991; c=relaxed/simple;
	bh=Tw2Mo9pMwb8UWfiQMOBnWjkJa+eOioaYjMoii0+/Lik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+XElpkk1hvtOrwsdubcMcLZxw0fyffwsjlDQ2DtqyZbULlQ5c8JzyGTgCspGjwjYzaaKI72NNBZ3dfG83uigGyTU3dGX8WwZ3htr810bc0TlVhWo2mc2f0tMkGj4g5ArullRnaDHG5Ifm4GbL19lVvmm5eKjZlCZux/mVKdQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAkMMrV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C6BC433C7;
	Sun, 24 Mar 2024 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321991;
	bh=Tw2Mo9pMwb8UWfiQMOBnWjkJa+eOioaYjMoii0+/Lik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAkMMrV/eglPj3oNSgwyQh93HexX8RVkkQvvlXcqegZgV21aG4wSAWPEGQiYEi9ZW
	 2s1DhUmrs+cUBrX+GZNeGA+9zuGmpQYLJ4l1vm+/sGO9cMUSBnJ7IyJB/471TSUaNr
	 QevaejDBrNnmdFs1MtAaGVYrKGYFr4YQFHMkZovui7YtDZo1gv+GrOBlBzyCfIrVMF
	 0etEMTpLSIYO98uRqURZwNMbndjkWOkn5oLoiKEe3HEXJgWVUo12D+/btZDmOlcdAJ
	 Vy+F4v+Q2gleWTKvk0iroaKq1DuntW1nj+5iLfZaZmi3PUi65T4RCzkzo1fZgeMBWM
	 flfcqPdBwCDLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 063/451] rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
Date: Sun, 24 Mar 2024 19:05:39 -0400
Message-ID: <20240324231207.1351418-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit a636c5e6f8fc34be520277e69c7c6ee1d4fc1d17 ]

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
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9d7464a90f85d..c879ed0c55079 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4471,6 +4471,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
 		return;
 	}
-- 
2.43.0


