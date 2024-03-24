Return-Path: <linux-kernel+bounces-116226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFD388A56C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162CFB36695
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38C93C0D69;
	Mon, 25 Mar 2024 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfIW+jeC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD7131BB3;
	Sun, 24 Mar 2024 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323858; cv=none; b=GaRBGr3XW5nLCjbwzeAmHu0Kf8WFJQg2o5PKGnENZ2U+sW48NDXjYerZTnTWyG5BNQakM66scnwbZQBu4lO4gUUdOHTGL2WHPTB+F9Jjsa+Dz2qJxQejUABm2IzRjto6dyaMu5T+yAnVjVFtG3vZJ5WPzjkrZZjfqA18kTpzvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323858; c=relaxed/simple;
	bh=QMGPU9v5zCezGY7dbzADYR4mYAy++b+NW7nLcEaX8zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMrG1MYWvqipyO8cfrGyeeShBXIr0evFNFMnfgHpEKgrPegIxW2TN2CJf62+XKeBO5u7i6iG5GqVbj7vyg4bBkl3yDx+Ei2VoxIDrJxvO5SJLHEadGOARND4OwqN2/RQDKj9Zv3u64uB/6nwMyNVgv+G2iENdxsCUjlewPb0BpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfIW+jeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B69BC43390;
	Sun, 24 Mar 2024 23:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323857;
	bh=QMGPU9v5zCezGY7dbzADYR4mYAy++b+NW7nLcEaX8zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfIW+jeCP6Ic8m1ilPF9oe0K2Qw7QsrD1f0Lh4HucExe2pEENJLV3L8WwPdWh5l2M
	 +51usPwbKBk+Abtg4k6yp3U+welj7cbNw06EjaXH/oNYSCsg7CNztC1c56bMn4T7Tu
	 zfYY+Vc22LY6itA5pYs3tatsdtfQCL0WAyPbMRnW5Xxeqk6N9W7uQoINql/9bEQvDn
	 dmWJtxFMMUsF7JYEvRlaqT6tYIkQiNKqQF/qdZ2aBMojNB/I9g4lvFL9A1yFRe5fAW
	 Bobb8QBxXQDCRDO99nYqv0hR0IyTMnCGyj8a9f1t8RXO+oMq4BjKq7F0H6JzxSgOv0
	 60LaCSIrFl7FQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 235/238] bpf: report RCU QS in cpumap kthread
Date: Sun, 24 Mar 2024 19:40:23 -0400
Message-ID: <20240324234027.1354210-236-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 2dcc04b2f330e..9a4378df45998 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -299,6 +299,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
@@ -322,10 +323,12 @@ static int cpu_map_kthread_run(void *data)
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


