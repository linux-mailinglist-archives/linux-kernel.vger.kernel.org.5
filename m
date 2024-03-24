Return-Path: <linux-kernel+bounces-113596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B69888596
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351FB1F240F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D00F1CD616;
	Sun, 24 Mar 2024 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOrkQhyI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A851CC602;
	Sun, 24 Mar 2024 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320399; cv=none; b=rVh+7CEHdpDsuvqp24tEOqlhi2DWNdH7XhpTRYOZXZXMcTtOpoVLCf1qjWI9gA/Bnqj4QPfaDHA8NgoET2sk+r8WQV4rUzqKnHmx7rGA7u/yaNwuEu66FagQClAkftgU75UCAoWhKx6HtwzisIkFy/v5GxCNAs1EdRNZ2pO/Ni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320399; c=relaxed/simple;
	bh=3V3Y8Z3T/2ffOncnPPsWGzqaz/UacQ7HKa0i63JPH1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd5dOzaA2FPFGNX5I7fv/iQ5XbvTTd8axOeDGjx4nUBeVdQ5wIcBAHB2fJFZ+gfit2svsLyV1nw+PwbYTKrQAONT2p5zmDudhSYs6VB8RecFWOG80rWjw+dno+0xPxwc4HxKuGb/l4VI1gyBkDV44TocuyZMokguUZ/EiXihFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOrkQhyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFC4C433B1;
	Sun, 24 Mar 2024 22:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320399;
	bh=3V3Y8Z3T/2ffOncnPPsWGzqaz/UacQ7HKa0i63JPH1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOrkQhyIn+/gGkp10Szef4rjXk7NKoBYOD98FxU/XUnn2lOFXRY/rvPmo8dUXtQPa
	 foiSIw71oG1cMILexnUAs7Y27i3R881isdF2BNCHE2a3vf9tE0HG8SiemIbf+fg0eM
	 Wx7MKpd0VfFXE/7ew3Q51FPva5sATkzw1mLVJrEUivcH6w7Q3ICpmJnztyxjGtMsUN
	 98Na7Hyyy9huiedNLcaBujbqJa7Qf4DWTVJq+eStKHoQ6xu1WngzmXK1+3cVRhVUcW
	 e/NTabHgFV9SjkZpJue4h4I2ms7FdmxpJ017a3KcUiWIEN4aXAAOMNItqQucm/1ViZ
	 SyilEKwZnuNbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 705/715] bpf: report RCU QS in cpumap kthread
Date: Sun, 24 Mar 2024 18:34:44 -0400
Message-ID: <20240324223455.1342824-706-sashal@kernel.org>
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


