Return-Path: <linux-kernel+bounces-112907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A99887FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09825B214D6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D555BACB;
	Sun, 24 Mar 2024 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPuMTlRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3B45033;
	Sun, 24 Mar 2024 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319718; cv=none; b=TBUMa19CEVOhDQSqPFSWRuh+qy/F1SlbDunGw7Z1HAio4wvJn6T6EqOYceLfAxA7MtHKPrzrvSaUCeGwLhpJJwCWr6NeWxUhPrhNythMgQ59G8txqhmdeQGTTuT2ALwUPyUxeO/2sLysXuwforiVOpRH5sQZAhev8ZWGCEB/yzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319718; c=relaxed/simple;
	bh=Oy/tMwvVydN42G0bJnVh71AIihietZ6FD/F8TRdgP4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muxZubRKPQtKwvtJKWIUmFdOP5a7zAAvjujEmm9YOTNO3Urcdq/tdOrvztm25ZqafZY75rT+1OJPNvtlLxMBwx82L+NSK0znXWJT1FO0DxZMb1olS71mw39lyfc3qGk2zDHRnJeuR8zRO9TpA20izVBIx5t5cJFsErqyytGIW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPuMTlRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E382EC433B2;
	Sun, 24 Mar 2024 22:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319717;
	bh=Oy/tMwvVydN42G0bJnVh71AIihietZ6FD/F8TRdgP4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vPuMTlRn23RcT0+oXGi+82vA9LeWgqlPz4I8YM9sNcV+vMyGFq6k2SctP3fhxtmPe
	 mVxJy6R5APmY+6EHmcjsLHR97cb0B/eaGTehdZFuna0f3xyUe4ewc5emyDE1EqxHuy
	 mcGbrDbDrmiM6q5rhtfqlBMziUqtgHXrk7aM2+osGujM2TOAUl1gMuQwDeZCk+7rco
	 cSWYyvg3cIqMYbbN5TFwY0aLdg2/HyAft/SGrUoN0f5fXsiovuqp2bxNvnh2E8EIRE
	 Np57OcqaNiWeNJhjtKSjNxVfWyyC24s1eNDjFNMmcgWSl2UnWn9O+93aMPUBybCDdQ
	 SVZv7qraqtzkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 020/715] rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
Date: Sun, 24 Mar 2024 18:23:19 -0400
Message-ID: <20240324223455.1342824-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index b2bccfd37c383..38c86f2c040b5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4749,6 +4749,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
 		return;
 	}
-- 
2.43.0


