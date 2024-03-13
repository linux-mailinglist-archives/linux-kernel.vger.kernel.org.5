Return-Path: <linux-kernel+bounces-101938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680087ACE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8256E1C21F12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D29135A50;
	Wed, 13 Mar 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLIbgFDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876711332A0;
	Wed, 13 Mar 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348083; cv=none; b=B7utDL0LAQ9jNsFFFP61dYZq47r97UYdbqirkddCpdHmzq/ormP2mMeGWafTEzNixRVci3eXneBbJ3Qsh/46W/qC66T91UYGFH5nNRVr5U9UtkS/o7vci0oFFVCfAlpkaLi9JZ6j2oyJ3OIXKZXJtEWy3KoKjKKnH/jecF7ARQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348083; c=relaxed/simple;
	bh=YsaLaBnyylV1LtDnSSY5Tl3iBCuBoD9QvxOoxVK4Piw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLAN32/zZ7EfWHlp2+FFZYGC0Sc8TTzTMCPPRzIJkZoh39HKudzplENdZ7Bzb2CTS9YOBzlZCUYdJfTJhMiQVkXiyLpKR5fK6B0y/1ngYayIeeW+MTBEbHs+K526dp2plEzsaMEjQfIkZ4HtvvtckAKYABXRD+DfOLJdXC1oNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLIbgFDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6C9C43394;
	Wed, 13 Mar 2024 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348083;
	bh=YsaLaBnyylV1LtDnSSY5Tl3iBCuBoD9QvxOoxVK4Piw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLIbgFDsPxbgAhoT+sSNwYH6sFSzA0Mk4UBn7PzuZ8VDe41DY6q4KQ+CCKNtBs4VX
	 sW6UzTo1LrRD25HGoYI6uKemLqXhU1VRMlIGOBvL+KxcaGDStHEim+UykoFntj9qw8
	 jOaHrXCG7bMxiwrtq128ktUEUBS9QgNTxjkHqQLhDx3ddQ8Us+RKVAthRx3xZ9zv+w
	 IfSpC2K5zk20Z+uJ1usUYKzjyMC9nmAGE11ilBKMlE/R9/VTiYjztGocnu8j/TIR84
	 Ff2tNFZuXiz92Hb3+zPKDYVTxI/u720bePNee3vXz0+QJPyJrwecXhgK72Ag+eUJy2
	 JWWEoPupiQeXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 70/71] blk-iocost: Pass gendisk to ioc_refresh_params
Date: Wed, 13 Mar 2024 12:39:56 -0400
Message-ID: <20240313163957.615276-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit e33b93650fc5364f773985a3e961e24349330d97 ]

Current kernel (d2980d8d826554fa6981d621e569a453787472f8) crashes
when blk_iocost_init for `nvme1` disk.

	BUG: kernel NULL pointer dereference, address: 0000000000000050
	#PF: supervisor read access in kernel mode
	#PF: error_code(0x0000) - not-present page

	blk_iocost_init (include/asm-generic/qspinlock.h:128
			 include/linux/spinlock.h:203
			 include/linux/spinlock_api_smp.h:158
			 include/linux/spinlock.h:400
			 block/blk-iocost.c:2884)
	ioc_qos_write (block/blk-iocost.c:3198)
	? kretprobe_perf_func (kernel/trace/trace_kprobe.c:1566)
	? kernfs_fop_write_iter (include/linux/slab.h:584 fs/kernfs/file.c:311)
	? __kmem_cache_alloc_node (mm/slab.h:? mm/slub.c:3452 mm/slub.c:3491)
	? _copy_from_iter (arch/x86/include/asm/uaccess_64.h:46
			   arch/x86/include/asm/uaccess_64.h:52
			   lib/iov_iter.c:183 lib/iov_iter.c:628)
	? kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1693)
	cgroup_file_write (kernel/cgroup/cgroup.c:4061)
	kernfs_fop_write_iter (fs/kernfs/file.c:334)
	vfs_write (include/linux/fs.h:1849 fs/read_write.c:491
		   fs/read_write.c:584)
	ksys_write (fs/read_write.c:637)
	do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

This happens because ioc_refresh_params() is being called without
a properly initialized ioc->rqos, which is happening later in the callee
side.

ioc_refresh_params() -> ioc_autop_idx() tries to access
ioc->rqos.disk->queue but ioc->rqos.disk is NULL, causing the BUG above.

Create function, called ioc_refresh_params_disk(), that is similar to
ioc_refresh_params() but where the "struct gendisk" could be passed as
an explicit argument. This function will be called when ioc->rqos.disk
is not initialized.

Fixes: ce57b558604e ("blk-rq-qos: make rq_qos_add and rq_qos_del more useful")

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230228111654.1778120-1-leitao@debian.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ab5830ba23e0f..0d4bc9d8f2cac 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -801,7 +801,11 @@ static void ioc_refresh_period_us(struct ioc *ioc)
 	ioc_refresh_margins(ioc);
 }
 
-static int ioc_autop_idx(struct ioc *ioc)
+/*
+ *  ioc->rqos.disk isn't initialized when this function is called from
+ *  the init path.
+ */
+static int ioc_autop_idx(struct ioc *ioc, struct gendisk *disk)
 {
 	int idx = ioc->autop_idx;
 	const struct ioc_params *p = &autop[idx];
@@ -809,11 +813,11 @@ static int ioc_autop_idx(struct ioc *ioc)
 	u64 now_ns;
 
 	/* rotational? */
-	if (!blk_queue_nonrot(ioc->rqos.disk->queue))
+	if (!blk_queue_nonrot(disk->queue))
 		return AUTOP_HDD;
 
 	/* handle SATA SSDs w/ broken NCQ */
-	if (blk_queue_depth(ioc->rqos.disk->queue) == 1)
+	if (blk_queue_depth(disk->queue) == 1)
 		return AUTOP_SSD_QD1;
 
 	/* use one of the normal ssd sets */
@@ -902,14 +906,19 @@ static void ioc_refresh_lcoefs(struct ioc *ioc)
 		    &c[LCOEF_WPAGE], &c[LCOEF_WSEQIO], &c[LCOEF_WRANDIO]);
 }
 
-static bool ioc_refresh_params(struct ioc *ioc, bool force)
+/*
+ * struct gendisk is required as an argument because ioc->rqos.disk
+ * is not properly initialized when called from the init path.
+ */
+static bool ioc_refresh_params_disk(struct ioc *ioc, bool force,
+				    struct gendisk *disk)
 {
 	const struct ioc_params *p;
 	int idx;
 
 	lockdep_assert_held(&ioc->lock);
 
-	idx = ioc_autop_idx(ioc);
+	idx = ioc_autop_idx(ioc, disk);
 	p = &autop[idx];
 
 	if (idx == ioc->autop_idx && !force)
@@ -938,6 +947,11 @@ static bool ioc_refresh_params(struct ioc *ioc, bool force)
 	return true;
 }
 
+static bool ioc_refresh_params(struct ioc *ioc, bool force)
+{
+	return ioc_refresh_params_disk(ioc, force, ioc->rqos.disk);
+}
+
 /*
  * When an iocg accumulates too much vtime or gets deactivated, we throw away
  * some vtime, which lowers the overall device utilization. As the exact amount
@@ -2884,7 +2898,7 @@ static int blk_iocost_init(struct gendisk *disk)
 
 	spin_lock_irq(&ioc->lock);
 	ioc->autop_idx = AUTOP_INVALID;
-	ioc_refresh_params(ioc, true);
+	ioc_refresh_params_disk(ioc, true, disk);
 	spin_unlock_irq(&ioc->lock);
 
 	/*
-- 
2.43.0


