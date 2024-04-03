Return-Path: <linux-kernel+bounces-130279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E34897651
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32101F2B320
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE215622D;
	Wed,  3 Apr 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgBvv5ka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF3152DE7;
	Wed,  3 Apr 2024 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164626; cv=none; b=gVPCsyKBq55hEPGYe/MYx/+6brHkKAX9MXZtjiFsUm6tVC1cCdOFWKMHXF7OsKuhNNzSNLhES7b8D8Il2AZVDmIypmA8pcVAVwcGce4L8Z9py29apKo0lpHFnimObYnUNd2lYer4u02PMscqSMCFjuwU2TYVyRpmTb5hEOuqGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164626; c=relaxed/simple;
	bh=H3xOa9xqZcstwrIpXJpzBcYIwiJ7WDy4DtKMGrPqAnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aa5n7vUpTEYHYgv3ThIJpRtWY3jbveEytnOPeMuyRK0tIQVv59N3eWm1yL2zc5+cfu47tK/TZPGK8Cx6rZeEWYT3L8KKZqJyv2q/t+VZlK1LWcQ+wK8RK/Za+ShSoSm0Sl5dquA6d7PwV4ltUHUIF7Ecs+QxcYZRby+42U9S46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgBvv5ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24193C43390;
	Wed,  3 Apr 2024 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164626;
	bh=H3xOa9xqZcstwrIpXJpzBcYIwiJ7WDy4DtKMGrPqAnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgBvv5kaSYwkx7svuiSIC4vJnf2Zd08GMSHS+h+CSpK09hKj4WLWfLsMQ+rgFjfpV
	 wKoRDYufRcYkncT//3ApNC/xsPMYzuMh3ICN0rs8fLeEvnwXcZ7iBGqFfOkBKOzxGl
	 EuVrK9r+UDuKtuFq8zSBhGL8Fi2HhMD9kt+/vrH8ir2ypayiG660lW/37091oOFrXL
	 LRpB6r2E2G1gW7Wv+xjb7Cg5FEnQYIWxchpImOnLuxAJ/bL9djLP5ow8mM7HS19uSD
	 330IxLUQPSSFH99CA2PC07jNuiByowe1QtjCbckX+q7cYfWJHPbPTXP9MvL1zM/q82
	 UeQGv7rZYLFxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <andrea.righi@canonical.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 05/28] kernfs: RCU protect kernfs_nodes and avoid kernfs_idr_lock in kernfs_find_and_get_node_by_id()
Date: Wed,  3 Apr 2024 13:16:07 -0400
Message-ID: <20240403171656.335224-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 4207b556e62f0a8915afc5da4c5d5ad915a253a5 ]

The BPF helper bpf_cgroup_from_id() calls kernfs_find_and_get_node_by_id()
which acquires kernfs_idr_lock, which is an non-raw non-IRQ-safe lock. This
can lead to deadlocks as bpf_cgroup_from_id() can be called from any BPF
programs including e.g. the ones that attach to functions which are holding
the scheduler rq lock.

Consider the following BPF program:

  SEC("fentry/__set_cpus_allowed_ptr_locked")
  int BPF_PROG(__set_cpus_allowed_ptr_locked, struct task_struct *p,
	       struct affinity_context *affn_ctx, struct rq *rq, struct rq_flags *rf)
  {
	  struct cgroup *cgrp = bpf_cgroup_from_id(p->cgroups->dfl_cgrp->kn->id);

	  if (cgrp) {
		  bpf_printk("%d[%s] in %s", p->pid, p->comm, cgrp->kn->name);
		  bpf_cgroup_release(cgrp);
	  }
	  return 0;
  }

__set_cpus_allowed_ptr_locked() is called with rq lock held and the above
BPF program calls bpf_cgroup_from_id() within leading to the following
lockdep warning:

  =====================================================
  WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
  6.7.0-rc3-work-00053-g07124366a1d7-dirty #147 Not tainted
  -----------------------------------------------------
  repro/1620 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
  ffffffff833b3688 (kernfs_idr_lock){+.+.}-{2:2}, at: kernfs_find_and_get_node_by_id+0x1e/0x70

		and this task is already holding:
  ffff888237ced698 (&rq->__lock){-.-.}-{2:2}, at: task_rq_lock+0x4e/0xf0
  which would create a new lock dependency:
   (&rq->__lock){-.-.}-{2:2} -> (kernfs_idr_lock){+.+.}-{2:2}
  ...
   Possible interrupt unsafe locking scenario:

	 CPU0                    CPU1
	 ----                    ----
    lock(kernfs_idr_lock);
				 local_irq_disable();
				 lock(&rq->__lock);
				 lock(kernfs_idr_lock);
    <Interrupt>
      lock(&rq->__lock);

		 *** DEADLOCK ***
  ...
  Call Trace:
   dump_stack_lvl+0x55/0x70
   dump_stack+0x10/0x20
   __lock_acquire+0x781/0x2a40
   lock_acquire+0xbf/0x1f0
   _raw_spin_lock+0x2f/0x40
   kernfs_find_and_get_node_by_id+0x1e/0x70
   cgroup_get_from_id+0x21/0x240
   bpf_cgroup_from_id+0xe/0x20
   bpf_prog_98652316e9337a5a___set_cpus_allowed_ptr_locked+0x96/0x11a
   bpf_trampoline_6442545632+0x4f/0x1000
   __set_cpus_allowed_ptr_locked+0x5/0x5a0
   sched_setaffinity+0x1b3/0x290
   __x64_sys_sched_setaffinity+0x4f/0x60
   do_syscall_64+0x40/0xe0
   entry_SYSCALL_64_after_hwframe+0x46/0x4e

Let's fix it by protecting kernfs_node and kernfs_root with RCU and making
kernfs_find_and_get_node_by_id() acquire rcu_read_lock() instead of
kernfs_idr_lock.

This adds an rcu_head to kernfs_node making it larger by 16 bytes on 64bit.
Combined with the preceding rearrange patch, the net increase is 8 bytes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <andrea.righi@canonical.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20240109214828.252092-4-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/dir.c             | 31 ++++++++++++++++++++-----------
 fs/kernfs/kernfs-internal.h |  2 ++
 include/linux/kernfs.h      |  2 ++
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index bce1d7ac95caa..458519e416fe7 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -529,6 +529,20 @@ void kernfs_get(struct kernfs_node *kn)
 }
 EXPORT_SYMBOL_GPL(kernfs_get);
 
+static void kernfs_free_rcu(struct rcu_head *rcu)
+{
+	struct kernfs_node *kn = container_of(rcu, struct kernfs_node, rcu);
+
+	kfree_const(kn->name);
+
+	if (kn->iattr) {
+		simple_xattrs_free(&kn->iattr->xattrs, NULL);
+		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
+	}
+
+	kmem_cache_free(kernfs_node_cache, kn);
+}
+
 /**
  * kernfs_put - put a reference count on a kernfs_node
  * @kn: the target kernfs_node
@@ -557,16 +571,11 @@ void kernfs_put(struct kernfs_node *kn)
 	if (kernfs_type(kn) == KERNFS_LINK)
 		kernfs_put(kn->symlink.target_kn);
 
-	kfree_const(kn->name);
-
-	if (kn->iattr) {
-		simple_xattrs_free(&kn->iattr->xattrs, NULL);
-		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
-	}
 	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
 	spin_unlock(&kernfs_idr_lock);
-	kmem_cache_free(kernfs_node_cache, kn);
+
+	call_rcu(&kn->rcu, kernfs_free_rcu);
 
 	kn = parent;
 	if (kn) {
@@ -575,7 +584,7 @@ void kernfs_put(struct kernfs_node *kn)
 	} else {
 		/* just released the root kn, free @root too */
 		idr_destroy(&root->ino_idr);
-		kfree(root);
+		kfree_rcu(root, rcu);
 	}
 }
 EXPORT_SYMBOL_GPL(kernfs_put);
@@ -715,7 +724,7 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 	ino_t ino = kernfs_id_ino(id);
 	u32 gen = kernfs_id_gen(id);
 
-	spin_lock(&kernfs_idr_lock);
+	rcu_read_lock();
 
 	kn = idr_find(&root->ino_idr, (u32)ino);
 	if (!kn)
@@ -739,10 +748,10 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 	if (unlikely(!__kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
-	spin_unlock(&kernfs_idr_lock);
+	rcu_read_unlock();
 	return kn;
 err_unlock:
-	spin_unlock(&kernfs_idr_lock);
+	rcu_read_unlock();
 	return NULL;
 }
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 237f2764b9412..b42ee6547cdc1 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -49,6 +49,8 @@ struct kernfs_root {
 	struct rw_semaphore	kernfs_rwsem;
 	struct rw_semaphore	kernfs_iattr_rwsem;
 	struct rw_semaphore	kernfs_supers_rwsem;
+
+	struct rcu_head		rcu;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 99aaa050ccb76..e857a150babc6 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -223,6 +223,8 @@ struct kernfs_node {
 	unsigned short		flags;
 	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
+
+	struct rcu_head		rcu;
 };
 
 /*
-- 
2.43.0


