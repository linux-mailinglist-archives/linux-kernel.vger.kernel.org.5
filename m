Return-Path: <linux-kernel+bounces-114929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED533888C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790F0B2E910
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445502D6F1C;
	Mon, 25 Mar 2024 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il0aGbY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA0280202;
	Sun, 24 Mar 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323634; cv=none; b=hgK+/yqumheyvyLzSP/W5Z7qjcG3pPW/1/bpArrW+TIOjQY3pOm040obdJjemBDUessllXkzImcFOvIaegVlzZkvsPtorLewVJClqyge+vZGdrotIdjuzFv/tsit0zA+lxLdVIrUSIaiCL3gqnGyB7hfCzNT8Lg+ODehua0BXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323634; c=relaxed/simple;
	bh=w1SWC/npLs9PAnsaTRTUf2qggJJX/Bjpja5a1dxH1+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhGy6wPex+yU9XO+3dpUoOIqNLqqiGNmOz5+yjFCNWjnrd+yydep5xvzUobe583HvDuHHEJE2g+jHjSsEVdH8sapriecmkxNAlTDWovfQJ4qlVlYLXMX+Kx34QaZ3Ob9JZbH+4ArkcNAIO5+QCE/8OE/N2abHyLiWhXe1CR65xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il0aGbY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B38C433F1;
	Sun, 24 Mar 2024 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323633;
	bh=w1SWC/npLs9PAnsaTRTUf2qggJJX/Bjpja5a1dxH1+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=il0aGbY1BYGseK4eyztPVld6YbeSFDNvsliJq98kkL1zfEBoo4Sc7MxcPLsbIr+uN
	 c+ldbGXS2ARm/NOsTjehYOGcp9hhP0FKqSSVu4u1hdno0QMOi2qsjXY/bsAQT6mLNP
	 aqDBh2CFLRaERf2rwTZuA9xcWE794wspCcW+ZU9PuA7G4pJSn5whSyqK6vZImA7hLn
	 FLNm4AFwhITLLXZN05exhBCBDcjWVErEqpQ4WE0t0z2Xp0LgpqfGsUDXc/61FDf3Sc
	 xT+C+xnvJ8mb2K7sdEXC3dEi/WEf+36uEOjdAa35skLJ6WnAzFE4uNGTQKJs5/7RuJ
	 T3jP31AMEss0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Robert Kolchmeyer <rkolchmeyer@google.com>
Subject: [PATCH 5.10 004/238] bpf: Defer the free of inner map when necessary
Date: Sun, 24 Mar 2024 19:36:32 -0400
Message-ID: <20240324234027.1354210-5-sashal@kernel.org>
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

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 876673364161da50eed6b472d746ef88242b2368 ]

When updating or deleting an inner map in map array or map htab, the map
may still be accessed by non-sleepable program or sleepable program.
However bpf_map_fd_put_ptr() decreases the ref-counter of the inner map
directly through bpf_map_put(), if the ref-counter is the last one
(which is true for most cases), the inner map will be freed by
ops->map_free() in a kworker. But for now, most .map_free() callbacks
don't use synchronize_rcu() or its variants to wait for the elapse of a
RCU grace period, so after the invocation of ops->map_free completes,
the bpf program which is accessing the inner map may incur
use-after-free problem.

Fix the free of inner map by invoking bpf_map_free_deferred() after both
one RCU grace period and one tasks trace RCU grace period if the inner
map has been removed from the outer map before. The deferment is
accomplished by using call_rcu() or call_rcu_tasks_trace() when
releasing the last ref-counter of bpf map. The newly-added rcu_head
field in bpf_map shares the same storage space with work field to
reduce the size of bpf_map.

Fixes: bba1dc0b55ac ("bpf: Remove redundant synchronize_rcu.")
Fixes: 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in sleepable programs")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20231204140425.1480317-5-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 62fca83303d608ad4fec3f7428c8685680bb01b0)
Signed-off-by: Robert Kolchmeyer <rkolchmeyer@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h     |  7 ++++++-
 kernel/bpf/map_in_map.c | 11 ++++++++---
 kernel/bpf/syscall.c    | 26 ++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bfdf40be5360a..a75faf437e750 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -175,9 +175,14 @@ struct bpf_map {
 	 */
 	atomic64_t refcnt ____cacheline_aligned;
 	atomic64_t usercnt;
-	struct work_struct work;
+	/* rcu is used before freeing and work is only used during freeing */
+	union {
+		struct work_struct work;
+		struct rcu_head rcu;
+	};
 	struct mutex freeze_mutex;
 	atomic64_t writecnt;
+	bool free_after_mult_rcu_gp;
 };
 
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 0cf4cb6858105..caa1a17cbae15 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -102,10 +102,15 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 
 void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
-	/* ptr->ops->map_free() has to go through one
-	 * rcu grace period by itself.
+	struct bpf_map *inner_map = ptr;
+
+	/* The inner map may still be used by both non-sleepable and sleepable
+	 * bpf program, so free it after one RCU grace period and one tasks
+	 * trace RCU grace period.
 	 */
-	bpf_map_put(ptr);
+	if (need_defer)
+		WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
+	bpf_map_put(inner_map);
 }
 
 u32 bpf_map_fd_sys_lookup_elem(void *ptr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 16affa09db5c9..e1bee8cd34044 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -493,6 +493,25 @@ static void bpf_map_put_uref(struct bpf_map *map)
 	}
 }
 
+static void bpf_map_free_in_work(struct bpf_map *map)
+{
+	INIT_WORK(&map->work, bpf_map_free_deferred);
+	schedule_work(&map->work);
+}
+
+static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
+{
+	bpf_map_free_in_work(container_of(rcu, struct bpf_map, rcu));
+}
+
+static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		bpf_map_free_rcu_gp(rcu);
+	else
+		call_rcu(rcu, bpf_map_free_rcu_gp);
+}
+
 /* decrement map refcnt and schedule it for freeing via workqueue
  * (unrelying map implementation ops->map_free() might sleep)
  */
@@ -502,8 +521,11 @@ static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map, do_idr_lock);
 		btf_put(map->btf);
-		INIT_WORK(&map->work, bpf_map_free_deferred);
-		schedule_work(&map->work);
+
+		if (READ_ONCE(map->free_after_mult_rcu_gp))
+			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
+		else
+			bpf_map_free_in_work(map);
 	}
 }
 
-- 
2.43.0


