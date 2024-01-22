Return-Path: <linux-kernel+bounces-33439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348FD836A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6942EB2D4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB204F201;
	Mon, 22 Jan 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkmvyHtw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D453F8C7;
	Mon, 22 Jan 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936302; cv=none; b=r9B5WOilRUzL+S5IA9InhB7kStMnckTzTYjW6mtJhs6f5SmiqoG4MXIido9ICd7RZsib0zH1ev5cN8yaPcAF/SwdJWqSPpgs4/++WwYAOuVECdWNBmSm5b9TUMaMzAjd1pgt7Xr/rz57BngkfCyC6GBlup9ygXgUnVtfL8IIfLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936302; c=relaxed/simple;
	bh=K52h5TwE0bsIWGp3/sknhaN0bqzlEaz0kC2Y+TotkRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIOvRvhrcK2bsc4HbexytE/jQ0NNCzV5zFKWz0rVV29UZTbXKi+oox+AgvdO/EZDNwkZBmORMcludR2fbT4EZ9H8MgQGm82sOKpwL+b9qERTfsvErYk6sbHYdOzDSNPFH/JCc8M2FoWRelpHnAZYRnXBGeMf4I9zxalb9ZV7ZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkmvyHtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE7AC433C7;
	Mon, 22 Jan 2024 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936301;
	bh=K52h5TwE0bsIWGp3/sknhaN0bqzlEaz0kC2Y+TotkRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkmvyHtwn3X495Ox2fspuVAxipf4ZkJ4poP2W6+dDd+XjPr+wLJ1uKPOCNa3swYIn
	 Xq6lxAB58iy3Qsalkb49LfLn2rZzFvRN33ayZY8gp79w6B/tcf+66bS7RNQt1Z85g1
	 p64PPwQ+3sX+Ob4YAJ39uhqSQipig1EXRU28swl3FfuCoiKz0rg7r3GY69rXB1eb1u
	 eCYxRyC026CCBmKO5lkNf+5wGFv6h+ka0fbKVa0/PU8z3mkQDnIfotdJiYhDEfnb7v
	 q5uwrUyLYLFedZq80RfoxzXgqYkKWEweyU5yvjFMzAL1bh8k050Kj2LXcmAHqzLIPg
	 5EfMNx9eRNcxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Wang, Beyond" <Wang.Beyond@amd.com>, Wang@web.codeaurora.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
	airlied@gmail.com, daniel@ffwll.ch, Felix.Kuehling@amd.com,
	Philip.Yang@amd.com, guchun.chen@amd.com, Hongkun.Zhang@amd.com,
	Arunpravin.PaneerSelvam@amd.com, marek.olsak@amd.com,
	pierre-eric.pelloux-prayer@amd.com, Jun.Ma2@amd.com,
	maarten.lankhorst@linux.intel.com, mukul.joshi@amd.com,
	matthew.auld@intel.com, srinivasan.shanmugam@amd.com,
	rajneesh.bhardwaj@amd.com, lijo.lazar@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 38/53] drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap
Date: Mon, 22 Jan 2024 10:08:39 -0500
Message-ID: <20240122150949.994249-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: "Wang, Beyond" <Wang.Beyond@amd.com>

[ Upstream commit 94aeb4117343d072e3a35b9595bcbfc0058ee724 ]

Issue: during evict or validate happened on amdgpu_bo, the 'from' and
'to' is always same in ftrace event of amdgpu_bo_move

where calling the 'trace_amdgpu_bo_move', the comment says move_notify
is called before move happens, but actually it is called after move
happens, here the new_mem is same as bo->resource

Fix: move trace_amdgpu_bo_move from move_notify to amdgpu_bo_move

Signed-off-by: Wang, Beyond <Wang.Beyond@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 +------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  5 +++--
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 0ee7c935fba1..cde2fd2f7117 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1222,19 +1222,15 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
  * amdgpu_bo_move_notify - notification about a memory move
  * @bo: pointer to a buffer object
  * @evict: if this move is evicting the buffer from the graphics address space
- * @new_mem: new information of the bufer object
  *
  * Marks the corresponding &amdgpu_bo buffer object as invalid, also performs
  * bookkeeping.
  * TTM driver callback which is called when ttm moves a buffer.
  */
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
-			   bool evict,
-			   struct ttm_resource *new_mem)
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct amdgpu_bo *abo;
-	struct ttm_resource *old_mem = bo->resource;
 
 	if (!amdgpu_bo_is_amdgpu_bo(bo))
 		return;
@@ -1251,13 +1247,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 	/* remember the eviction */
 	if (evict)
 		atomic64_inc(&adev->num_evictions);
-
-	/* update statistics */
-	if (!new_mem)
-		return;
-
-	/* move_notify is called before move happens */
-	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
 }
 
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 6dcd7bab42fb..2ada421e79e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -312,9 +312,7 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			   size_t buffer_size, uint32_t *metadata_size,
 			   uint64_t *flags);
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
-			   bool evict,
-			   struct ttm_resource *new_mem);
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
 void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
 vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
 void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 10469f20a10c..158b791883f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -555,10 +555,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			return r;
 	}
 
+	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
 out:
 	/* update statistics */
 	atomic64_add(bo->base.size, &adev->num_bytes_moved);
-	amdgpu_bo_move_notify(bo, evict, new_mem);
+	amdgpu_bo_move_notify(bo, evict);
 	return 0;
 }
 
@@ -1503,7 +1504,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
-	amdgpu_bo_move_notify(bo, false, NULL);
+	amdgpu_bo_move_notify(bo, false);
 }
 
 static struct ttm_device_funcs amdgpu_bo_driver = {
-- 
2.43.0


