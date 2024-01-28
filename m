Return-Path: <linux-kernel+bounces-41795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B283F7C7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF791C222C1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5239912FF70;
	Sun, 28 Jan 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj6v/ZFl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736912FF66;
	Sun, 28 Jan 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458546; cv=none; b=psMSAYggewfJp1aCdmaz3jwfSZIVu+c7GT5cAtLH6ijwC2hAyniKMIUYll/qXqFxIOa88PYWlrLombMDkW82MJzTuBpi5oryvIOjICN4IoB++QktxwjSGnzU6mS3VO0RM9OYeHDlIONc2Diiqc+eqzdb2aDlV/cRaMM3CA7tohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458546; c=relaxed/simple;
	bh=HnNvAAn1rjY6zhwbiXIqCcpICKiU6fgayXFmvSoLjc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr2l/7txaXz/lZHp5oYT8PYVIWf+K3m7NyWUWVj3qXnvpJn7lcRblNm0sFBM4TICqUCyMCu3wo5CFQce/Q07d6QMd6iCUz4d8Iu9404yLAjdFjRpE4V7nsa9e8dhyLHmczagCtHuymDvvVcyYO0i/1bRavdU5gxJpeBYZEDJ7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj6v/ZFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8AEC433C7;
	Sun, 28 Jan 2024 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458546;
	bh=HnNvAAn1rjY6zhwbiXIqCcpICKiU6fgayXFmvSoLjc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yj6v/ZFlkZf9oGTLDoGkbEGuCnoXJv76q5u+hKy2oMqpAPyTmnl0aMiRBeSsTANOA
	 XLmn3GO0+ipKXMnyYiQz+pmuQjF2yMuFK8RfQQ8Ih3RKoYDxljv2l4oWlJJYZHkJEt
	 GAyPEF7OmIM76G4h2gsuyb44tIj2CpWwSEC5/fLR6mrxsVGGcOOBe9woHsX1gwvpbi
	 U3jM1Q2BWA0vF4QrybojWuBtAIdF/PbyM8eQjqVMNvKWiIAxskuI9UrUcpGhFpedzt
	 9gVQic8xP2oc9bZvcBgJcZJap+a1+dQcniEVks3PLdOtfefoCQcZ8BW5UNIev7DcOw
	 x/mXFnn+u4VFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
	Philip Yang <philip.yang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 13/19] drm/amdkfd: Fix lock dependency warning
Date: Sun, 28 Jan 2024 11:15:10 -0500
Message-ID: <20240128161524.204182-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161524.204182-1-sashal@kernel.org>
References: <20240128161524.204182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Felix Kuehling <felix.kuehling@amd.com>

[ Upstream commit 47bf0f83fc86df1bf42b385a91aadb910137c5c9 ]

======================================================
WARNING: possible circular locking dependency detected
6.5.0-kfd-fkuehlin #276 Not tainted
------------------------------------------------------
kworker/8:2/2676 is trying to acquire lock:
ffff9435aae95c88 ((work_completion)(&svm_bo->eviction_work)){+.+.}-{0:0}, at: __flush_work+0x52/0x550

but task is already holding lock:
ffff9435cd8e1720 (&svms->lock){+.+.}-{3:3}, at: svm_range_deferred_list_work+0xe8/0x340 [amdgpu]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&svms->lock){+.+.}-{3:3}:
       __mutex_lock+0x97/0xd30
       kfd_ioctl_alloc_memory_of_gpu+0x6d/0x3c0 [amdgpu]
       kfd_ioctl+0x1b2/0x5d0 [amdgpu]
       __x64_sys_ioctl+0x86/0xc0
       do_syscall_64+0x39/0x80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       down_read+0x42/0x160
       svm_range_evict_svm_bo_worker+0x8b/0x340 [amdgpu]
       process_one_work+0x27a/0x540
       worker_thread+0x53/0x3e0
       kthread+0xeb/0x120
       ret_from_fork+0x31/0x50
       ret_from_fork_asm+0x11/0x20

-> #0 ((work_completion)(&svm_bo->eviction_work)){+.+.}-{0:0}:
       __lock_acquire+0x1426/0x2200
       lock_acquire+0xc1/0x2b0
       __flush_work+0x80/0x550
       __cancel_work_timer+0x109/0x190
       svm_range_bo_release+0xdc/0x1c0 [amdgpu]
       svm_range_free+0x175/0x180 [amdgpu]
       svm_range_deferred_list_work+0x15d/0x340 [amdgpu]
       process_one_work+0x27a/0x540
       worker_thread+0x53/0x3e0
       kthread+0xeb/0x120
       ret_from_fork+0x31/0x50
       ret_from_fork_asm+0x11/0x20

other info that might help us debug this:

Chain exists of:
  (work_completion)(&svm_bo->eviction_work) --> &mm->mmap_lock --> &svms->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&svms->lock);
                               lock(&mm->mmap_lock);
                               lock(&svms->lock);
  lock((work_completion)(&svm_bo->eviction_work));

I believe this cannot really lead to a deadlock in practice, because
svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
refcount is non-0. That means it's impossible that svm_range_bo_release
is running concurrently. However, there is no good way to annotate this.

To avoid the problem, take a BO reference in
svm_range_schedule_evict_svm_bo instead of in the worker. That way it's
impossible for a BO to get freed while eviction work is pending and the
cancel_work_sync call in svm_range_bo_release can be eliminated.

v2: Use svm_bo_ref_unless_zero and explained why that's safe. Also
removed redundant checks that are already done in
amdkfd_fence_enable_signaling.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2cbe8ea16f24..e2d4e2b42a7c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -347,14 +347,9 @@ static void svm_range_bo_release(struct kref *kref)
 		spin_lock(&svm_bo->list_lock);
 	}
 	spin_unlock(&svm_bo->list_lock);
-	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base)) {
-		/* We're not in the eviction worker.
-		 * Signal the fence and synchronize with any
-		 * pending eviction work.
-		 */
+	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
+		/* We're not in the eviction worker. Signal the fence. */
 		dma_fence_signal(&svm_bo->eviction_fence->base);
-		cancel_work_sync(&svm_bo->eviction_work);
-	}
 	dma_fence_put(&svm_bo->eviction_fence->base);
 	amdgpu_bo_unref(&svm_bo->bo);
 	kfree(svm_bo);
@@ -2872,13 +2867,14 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
 {
-	if (!fence)
-		return -EINVAL;
-
-	if (dma_fence_is_signaled(&fence->base))
-		return 0;
-
-	if (fence->svm_bo) {
+	/* Dereferencing fence->svm_bo is safe here because the fence hasn't
+	 * signaled yet and we're under the protection of the fence->lock.
+	 * After the fence is signaled in svm_range_bo_release, we cannot get
+	 * here any more.
+	 *
+	 * Reference is dropped in svm_range_evict_svm_bo_worker.
+	 */
+	if (svm_bo_ref_unless_zero(fence->svm_bo)) {
 		WRITE_ONCE(fence->svm_bo->evicting, 1);
 		schedule_work(&fence->svm_bo->eviction_work);
 	}
@@ -2893,8 +2889,6 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	struct mm_struct *mm;
 
 	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
-	if (!svm_bo_ref_unless_zero(svm_bo))
-		return; /* svm_bo was freed while eviction was pending */
 
 	/* svm_range_bo_release destroys this worker thread. So during
 	 * the lifetime of this thread, kfd_process and mm will be valid.
-- 
2.43.0


