Return-Path: <linux-kernel+bounces-116105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E608896B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522DA29CC47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C028DFA6;
	Mon, 25 Mar 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzg21le6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B527F0A0;
	Sun, 24 Mar 2024 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323604; cv=none; b=JttY4WAmVX6S2ELOjyA9JxwnRfwlndZRu/EhWjJg9j/ybpcVG0BpT7xdrI8MUF0JQkcyvvzB0CpGWR4amwuWK8A0zrW7f8TGDoiMl5RO4E/q6aRUbb2OoQPhWily98X7VZzAHcgrSmFtJynGQahK3Y0ytcv0Ac8zbhXpr3RxCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323604; c=relaxed/simple;
	bh=34NgVSaXwpxNu1Y2kRUvJtxcbAIMn1pKbBU9bE04Kn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDAEVw0438cLrgegVCd2VZg9oPfm6nYK62cjFJbxhqcFwQwldaOAvW62/izrWb8rDn4bQcTrpg4x9jUuqivoywajPK5aIdAUbGUBlxW0qkhyQ5UVROiyioLYbgs9rtVBmZ14MWV+i7RZPzDtvCDjPee4RKnrEj+3JAUEvsIb7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzg21le6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06069C433B1;
	Sun, 24 Mar 2024 23:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323603;
	bh=34NgVSaXwpxNu1Y2kRUvJtxcbAIMn1pKbBU9bE04Kn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzg21le62SAyB1977WdYY3dL4j7nl+MVH0oDegAHn5Hs/lplq0dR4Mbn41LMo/L+k
	 OmpaeHtRQc6uuAv4jG+IcMyE0M+3o72tkiIz6NxsnkksEMc29dRXig1/KGYbIbiftP
	 gwNtzL1M8LdnUoBlqtymHt1jQ5cS1vkEyM91NS/n/t0J4nnI/ffli1DXWf5ybj2V5l
	 W1CRLnNiClWTPDc/23IP+s1YgpQIrIZT8FdBFGJMidD2zyIX5zTYLsBwakqFeuZT2e
	 sR0m7ZSq0W4t1r1zd2ArRbMOQMkTzUEUo4lQ/nWCtyYHMFDYR1rjUUsqRE0ocRPSom
	 JFvubEwiGRoUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 310/317] bpf: report RCU QS in cpumap kthread
Date: Sun, 24 Mar 2024 19:34:50 -0400
Message-ID: <20240324233458.1352854-311-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index f7de5b313cc5b..a8429cfb4ae8c 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -305,6 +305,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -330,10 +331,12 @@ static int cpu_map_kthread_run(void *data)
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


