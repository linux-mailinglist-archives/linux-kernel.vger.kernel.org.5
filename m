Return-Path: <linux-kernel+bounces-113999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED2E8887DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C699E288EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D67157484;
	Sun, 24 Mar 2024 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1day8qD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD612D76B;
	Sun, 24 Mar 2024 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321142; cv=none; b=U5dHuFA4TZlw3difVDuRnG5rjA3QQvAIypuw/9ac3/tAaGZNLpl3BnL2AuGQ9T80FL9pnjv8FvaSHLF+IlfG9eD9AUOEboJ/aWT9Erd1cTMl2wsm+HipdgwVoH9e5+ouHpWXJis8HmslJyWcP0IYXWolTWYGRqaR+HUJwIp1JWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321142; c=relaxed/simple;
	bh=3V3Y8Z3T/2ffOncnPPsWGzqaz/UacQ7HKa0i63JPH1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTkw4tsSvtB0uFR/yDmTG6o9y2FKM6Zx4niJHFWwZKx8sYv0Oguq1AyEPmtBTgzW2/SxguHkMSLqRHicUotRzPj/unZ//qaiqeWA00r2Fij4mGQ8kYfyg5g15paFQI3d8+PC3SURknx83ERCFmVjWI4rqOrDQyVEOX9e9DPxaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1day8qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA447C43394;
	Sun, 24 Mar 2024 22:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321141;
	bh=3V3Y8Z3T/2ffOncnPPsWGzqaz/UacQ7HKa0i63JPH1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1day8qDctDTKFY8AC1sAQFp0mUJuQJ+v8O96An+qppz2morNXbraRaKw8gND2eWN
	 zhe5tJKFugqA4fUMgKyfRilt69QLrNyuTjEfayX8c0bhflyoritTD6VEIgCqkTLFBj
	 onI59iNEqBxvq19jKzaSxT0xiFzj27Cs2bbO1Nieeofen2Ax60qNNfvJ4Gq7/JD9y+
	 +Fye3UE/H5z0igsMxWQ0rb8wVjk1OeUTfLxl5EcaccM0Y6nFBBdcS0GFMeh75AyLuv
	 rdsAH//5bEY9EbVjl5vlp58aL20+v33eREtCFi3kYmm+AJYZe3oMucqOuCzeAT5pPW
	 MZHKUuZNpFKNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 703/713] bpf: report RCU QS in cpumap kthread
Date: Sun, 24 Mar 2024 18:47:09 -0400
Message-ID: <20240324224720.1345309-704-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit 00bf63122459e87193ee7f1bc6161c83a525569f ]

When there are heavy load, cpumap kernel threads can be busy polling
packets from redirect queues and block out RCU tasks from reaching
quiescent states. It is insufficient to just call cond_resched() in such
context. Periodically raise a consolidated RCU QS before cond_resched
fixes the problem.

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Link: https://lore.kernel.org/r/c17b9f1517e19d813da3ede5ed33ee18496bb5d8.1710877680.git.yan@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/cpumap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index ef82ffc90cbe9..8f1d390bcbdeb 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -262,6 +262,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -287,10 +288,12 @@ static int cpu_map_kthread_run(void *data)
 			if (__ptr_ring_empty(rcpu->queue)) {
 				schedule();
 				sched = 1;
+				last_qs = jiffies;
 			} else {
 				__set_current_state(TASK_RUNNING);
 			}
 		} else {
+			rcu_softirq_qs_periodic(last_qs);
 			sched = cond_resched();
 		}
 
-- 
2.43.0


