Return-Path: <linux-kernel+bounces-115745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 227BF8896D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC0CB34A21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254F36827E;
	Mon, 25 Mar 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3G1zpWm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA7D156C6E;
	Sun, 24 Mar 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321899; cv=none; b=bRocXA4LU1brXfo1XI3CuL4f/d49gsBsOqLms3dPg0/HyLeVPc8DcpmTja26Bx90ti6Bfn8DQmrDWFCbrb+7d274M31nnsGgJdnBx6PuzcQ73zQk7TyG0apTDMfdxPEh61a0ESe4FLkPZhNRhNtHKKt8RMnzk225M00NX/235UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321899; c=relaxed/simple;
	bh=Lm58yLj4CP4NhjAUo2FqJTK/ATsFSEnj/2hVBaANo48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckBTiO9gnxxWPj1EYm6puTTTGDY0zp6V1IIBoOlNGWX0BFJS9QEmFUkYBDl12HIBK5xTmgeEgeWx2kzsXB8sz+vcwx+9NvMMA1Y+EMsGK2mJ1IGjMNxuaezEfkGXp9URCDK5Y/wsTpXmDAL9a+ozVnN+luOT8cBwdSSbOZ4s9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3G1zpWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B00C433C7;
	Sun, 24 Mar 2024 23:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321899;
	bh=Lm58yLj4CP4NhjAUo2FqJTK/ATsFSEnj/2hVBaANo48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3G1zpWmZSvpYGIKlJBMMzocw54S6v5LnVPAiybF+JEoaoFbyZYPVie/sJB6K7BsA
	 vzAWTZJdwxtW858Uvry/eUBzP/l0nwC9Tds4wEyMTtPgGoLrhvOeByr5sQMbc3FKbT
	 mIbX/XIzUIklT94RQHsI3G9WyPl3ZQfUIamCekhJIShNijyegI46NmwMCCJhKmU6XH
	 FfIAxPRj/1SRss3IYFuRd6yGuTJ+VooWvyoSP8M0oL7qkIB1yuOZTc0xHn0ENuUXGV
	 Ibb4iyVumnadd0r+KOdzTSHyMkNO6DPMIke8cjkfXb9mEOKYU8s5EMGZz4KRRy1ZjO
	 vvapN88pE+xtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 628/638] bpf: report RCU QS in cpumap kthread
Date: Sun, 24 Mar 2024 19:01:05 -0400
Message-ID: <20240324230116.1348576-629-sashal@kernel.org>
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
index 9140b8bff9c04..df03e66a687c1 100644
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


