Return-Path: <linux-kernel+bounces-33280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD228367E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BD1286186
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5FB5B1EC;
	Mon, 22 Jan 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzxW3g4s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06A5A7B3;
	Mon, 22 Jan 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935593; cv=none; b=ARjOgLmODmuQZfUb5CjEiCxdsBfy1U0NdKz0e485YxUz0BXUcWQRCX/KhntkKr89e1q3bkYobDlX2tNPR8VHb7SdGSGtYtz4hLBoL9X9ocG7OnbjC9iofbNgMRXlXBJir/31y9dNyP+8xZveFg+T4BWw2LdejTELGdnn6elkhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935593; c=relaxed/simple;
	bh=9oQY2nlqZpvXgpcB9Y+B2gmJcaPcux2UKvXEAgFpgdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfwIE4c7rSDSCTxkogpz2hXeUbAQoJHVozq4P2+1tfdpaESebR7SuMvYLXyj59xPl3cvWvIGoMUUrlzWVe/HvNJNQrnhifuamz2xHUaaDivXEgL+sCfsXZm+VkaJitd4ye+yx+UgXx/KS51CKn8GpOcN+IqXkvX9DatEkfFmTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzxW3g4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA73C433C7;
	Mon, 22 Jan 2024 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935592;
	bh=9oQY2nlqZpvXgpcB9Y+B2gmJcaPcux2UKvXEAgFpgdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzxW3g4sfUf8gKRfMEHGvdj6VxysbeQun/Js6QbQORLfnOcleGRjRKQlSRQm7gkBV
	 wMDY01g9A6usFv22sdXva4AYhQ/qTGGuCIKnABn/UJ4951j/xDjc0nkGpqaOV4bQ+T
	 +4W5shsVtR+4/VVhELF2pz9Q4v0D9szHT6CuLOOlApF29j9VUYmufLXN3PnWpenZn7
	 rOIzV8KU9n4QaAm18/4DW7DsPdCxggz2lVrT6mu92iOq9t8SeFCG67Lgn4NhLB+oMl
	 NXwpJkkCkSeYCiS4DdSMG7Cm66ek5axe9DVbSoVwfMDbkl4mNUxUlv87/TH48hQYtT
	 POMHXWpRTYACw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Wang, Beyond" <Wang.Beyond@amd.com>, Wang@web.codeaurora.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
	airlied@gmail.com, daniel@ffwll.ch, Felix.Kuehling@amd.com,
	Philip.Yang@amd.com, guchun.chen@amd.com,
	Arunpravin.PaneerSelvam@amd.com, Hongkun.Zhang@amd.com,
	marek.olsak@amd.com, pierre-eric.pelloux-prayer@amd.com,
	Jun.Ma2@amd.com, maarten.lankhorst@linux.intel.com,
	mukul.joshi@amd.com, lijo.lazar@amd.com,
	srinivasan.shanmugam@amd.com, rajneesh.bhardwaj@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 58/88] drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap
Date: Mon, 22 Jan 2024 09:51:31 -0500
Message-ID: <20240122145608.990137-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 5ad03f2afdb4..425cebcc5cbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1245,19 +1245,15 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
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
@@ -1274,13 +1270,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
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
 
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index d28e21baef16..a3ea8a82db23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -344,9 +344,7 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
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
index ab4a762aed5b..75c9fd2c6c2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -545,10 +545,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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
 
@@ -1553,7 +1554,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
-	amdgpu_bo_move_notify(bo, false, NULL);
+	amdgpu_bo_move_notify(bo, false);
 }
 
 static struct ttm_device_funcs amdgpu_bo_driver = {
-- 
2.43.0


