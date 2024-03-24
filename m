Return-Path: <linux-kernel+bounces-115998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF0889915
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41DD1C3217E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D789E26AD90;
	Mon, 25 Mar 2024 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXNHt0pd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CE23B485;
	Sun, 24 Mar 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322360; cv=none; b=mIIeN449J5X0uHPo5GqYCSu0AIGrB4RnI1FkBYqFP3lni+T4TSCoGo/dB3BpRASczfX/rPffaKEhlBq/c3Uhb1QGqYjsP0UrQ2DgAVwgd7qVi4/ScILugxGdYKlLLh5KV0dS2KSbLjKjROkS4UtB8DUEKkYwPLRbQX2F4NHxF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322360; c=relaxed/simple;
	bh=5CKGby1NuCF7QCsolsfXL0BdWTq1mp477nUEtXnb8Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8Z0TSV6pNNg8FzEeesGOgIG7kMTjkbTnvO9MAVPMad2tbKjbZ6dwV/z7yT37723XIny7rLuzmrDPjp1YgLKsTj4PDdq/g9/Oxm5snW8ILe2eKbVpucpXtujXcmFTo65Uk4YuhkgGmT2rt9t3G7GnDmgvwQyhbzO5oCnkRMxK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXNHt0pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54525C43399;
	Sun, 24 Mar 2024 23:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322359;
	bh=5CKGby1NuCF7QCsolsfXL0BdWTq1mp477nUEtXnb8Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXNHt0pdCo+Tvdc2bYAVQkwzMzIT6ZAstIxQEdLbfVyXsf6cy5NKqX42JvZ56Fvjg
	 cLMPbmUBQHc8aNU3AYcHTYDVcLpkT7JglJj/h4jk6Co1EKFW+tQYfcJ4M1ysqzPRXd
	 5xRneOGkZ+p+57L7N4dZIrUyMnPzDhm6sP6qPbFFsSsr4KnzcVuBz1GTvq19s1a4zp
	 pXqTwOF2pOtEfS+MMcQXX9PAW3+P6zGppnWyWW0iOQ3TG4ECBQIXUyIT7twnw7DVbt
	 fqmGTDRhhqH3URxTmN7wU9WkcVLGb5BHQKGzJ1r1irF5fdCE2rIllSU++1hNdWfA0s
	 PnPc9kYDUpa0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 441/451] bpf: report RCU QS in cpumap kthread
Date: Sun, 24 Mar 2024 19:11:57 -0400
Message-ID: <20240324231207.1351418-442-sashal@kernel.org>
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
index 0508937048137..806a7c1b364b6 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -306,6 +306,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -331,10 +332,12 @@ static int cpu_map_kthread_run(void *data)
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


