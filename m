Return-Path: <linux-kernel+bounces-116302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D08895E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74153299D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0193CF98B;
	Mon, 25 Mar 2024 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QirIoVzc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CC17ADCF;
	Sun, 24 Mar 2024 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324192; cv=none; b=HTnQZOTDCv32A0dAMOYGy+GOWTfFDKVQfZjtyY9901lHp3KsHxPqJMG4x53bI6qLCOwy//5/mNxLyOCPOVXt2MPNXop9mVpZuBURIV8UbfpT8ARvHJg017C8Y9isKLsZYxEnH8vHxdrnMQ/hX0OSkB/+mtYT1w7LRGLZmJUPrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324192; c=relaxed/simple;
	bh=cqG8zAIduB+HMGSaADU04Ol2ADU/OiKOhz3LLH4sFQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3IYVUMDwjZHMUiBHdkLE0Fm7gUW+RxLttHuOqTDjVL3MQTHmlo7aQw95LYm78PbfevOWeyyFRLVfJmhmXEC/+gYuH38LsEvekhcrKVHW00MkM+GNPof3McsyPREkMaxfhp8T4BymoSWyyhAHMN0ybt7fOPmWhYfzYBDLMDeD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QirIoVzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10882C433B1;
	Sun, 24 Mar 2024 23:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324191;
	bh=cqG8zAIduB+HMGSaADU04Ol2ADU/OiKOhz3LLH4sFQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QirIoVzc14Di3VZp8YOrmRJxuHAofsop7yxfWW0rAl8TMcalqr0qp5+Dhlf3kDmim
	 /dfM9VV4cwvN0Z098t3CIjVYy1qWxAkO7nmWI4a0IS3mPgDDa5WVBLxSmqAU4dKE7s
	 JzfFPyaQOlqDVxu9679U85Mr6RzhNyPy4zMnoA0PrU56imvNFg1cj0fmWkmhk7ebGa
	 oNh79kaTQUjgSKAmEeOcEN7BAQluCqtQEOu3f2v9K/shhrztLn/JapGQfUCCkfNCKy
	 jaC2BI8BSf9KqWA0cnvtdaaaPlGTJhp/2rI4qh9fIIDnfn2J3Xy2GMi7B2iCS5qcI8
	 2RSKn6wabuX5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 180/183] bpf: report RCU QS in cpumap kthread
Date: Sun, 24 Mar 2024 19:46:33 -0400
Message-ID: <20240324234638.1355609-181-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index a367fc8503933..19be747f4e5ab 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -249,6 +249,7 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
@@ -271,10 +272,12 @@ static int cpu_map_kthread_run(void *data)
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


