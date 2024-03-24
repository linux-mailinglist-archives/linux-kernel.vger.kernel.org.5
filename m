Return-Path: <linux-kernel+bounces-114071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C4C88883D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C831C2656A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3301B23453B;
	Sun, 24 Mar 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFyXFX1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE4D1FEC72;
	Sun, 24 Mar 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321360; cv=none; b=R/67ZbPzXpmFzwlLUOmpLyQ8Ffld2mYhvZK8jzHP2ob6dZLjVjYl//XAHLUAv1qJZ6Pz1ZuESMX/8a19ehudDqUOoahRKckZxAJ8eSZoBy9L5DXnvuJ1xrwX3NFUOxl1W7QNmhIYhsndV5ywvNxV6/647ZK1fcnU0EGZyNmX9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321360; c=relaxed/simple;
	bh=07OLBcZWNFpd2dvobb1dW1Ge/9r10M08MOnow2/sVFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXPdwBV+0PkTsidDDESMyUPYlY16LNh58r638gaDX2RWd5ID3tZ0wqoBhPKwAqS0M4Fi1PkKBmSTRK7dfgR5xymBH3ZdHBsxcaiBuhwJJXl/nB553yHU8ABwvgphKLEGmtf9FE7fxQHAM3GZqaTZMS9O0HEiJ7Od5v4f4upd9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFyXFX1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0AAC43399;
	Sun, 24 Mar 2024 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321359;
	bh=07OLBcZWNFpd2dvobb1dW1Ge/9r10M08MOnow2/sVFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFyXFX1ESLIrgEVQBuZByfxl47MlcKh8P99mK0TARAmDrds1MNhcwaBLuGM/1DRf3
	 F7OpDEKXRRspkWql2pHm2BFL9hKmzwsddM3ieS8lm041T2w3CDOU51JQ67V3w81vyl
	 Oq/MLNQ02Gebn7RCWs63z7R/tttuu61qok5xt2Rz1aUdvHuxL2dG8DaD77DIq9ebt9
	 r/NwLTe64QeUUT9UvFkodKyCVj2IUEGFYMUko9JBzOfmuJXGTe/EGjsJrPguLMSQ4R
	 ymFmtI/h+2a7HN4FjLgWo//lWfjdHPJvDgGkKXfcUgzmt8a8nG5HttoOOTwGedAH1n
	 RSr/SiS99Pgjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 084/638] rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
Date: Sun, 24 Mar 2024 18:52:01 -0400
Message-ID: <20240324230116.1348576-85-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 4fe47ed95eebc..2e8d4572e8620 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4677,6 +4677,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
 		return;
 	}
-- 
2.43.0


