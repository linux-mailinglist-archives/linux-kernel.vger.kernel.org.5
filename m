Return-Path: <linux-kernel+bounces-116060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D27D889681
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AA2B26422
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C37A27CBD2;
	Mon, 25 Mar 2024 03:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB9Td2dS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1995176FB8;
	Sun, 24 Mar 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323464; cv=none; b=D45kDA3PIJ9a0O4EPg0ctJ6fRP13ud1As6PIuRxQOySZHsaSjycMZySapu3c3lVXtWz3T6tUSxCrdyxdUkDXVN3uQ/U74Q0W/sckIH770Q71O6bP6zfTHQ1AHsjF7zyHBWHgDFrPM1ospLwUrb2bX/rgjHRCIAXro25j90qcdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323464; c=relaxed/simple;
	bh=6MDhhdy4wZHD+LTDdrq17u2hKHcZzGeV/wYljldK5Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RED4IYUdYWxrNKAruVPZSKh8ry0EnkqgjFdM6pmiVI0T+ELqWC7nS2hI4oNSao84aXmjMzsFcqZjSx/gGlP9sBGoZXRhlM66Tn+r0emmGvLcLXlU7WP121dW0m/ju1tUJ3XmUOVjoDvhVhdUYnKPaty5vtZPXXv8ZAZcn7dMEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB9Td2dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B74FC433C7;
	Sun, 24 Mar 2024 23:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323463;
	bh=6MDhhdy4wZHD+LTDdrq17u2hKHcZzGeV/wYljldK5Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hB9Td2dSxWL8lOgAW+ZEFC1ldUo7RhEqlgQUFWZfwTtpO7PD9oAG9D3YPOUTjE9KG
	 iwKhD8E48mQAtU8Z49P8AqsCO73n2iZnAam4IvWyDQm3Sx/hNIKmIZCKLd8CHgNi5E
	 HFqQTiri1MCaL7AcFQyXhT9eNF7ywBNxyd8P77c/3Kg+IPElTauCOCvoRThisGKf+l
	 AohQKTljbJDjD/MJwlaxNXtzAF9J3uUnvl9o6PFUGdvIkCLpJJGuuvrVKsaFNSoMD8
	 IcwAPxlODmg/hoyU0OPHHDFe11mIoe1MMO7j0LsSMepqB/0VhwCiTG3G5xUYSaTCWT
	 ypFjdymOX0kXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 168/317] drm/ttm: add ttm_resource_fini v2
Date: Sun, 24 Mar 2024 19:32:28 -0400
Message-ID: <20240324233458.1352854-169-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit de3688e469b08be958914674e8b01cb0cea42388 ]

Make sure we call the common cleanup function in all
implementations of the resource manager.

v2: fix missing case in i915, rudimentary kerneldoc, should be
    filled in more when we add more functionality

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20220124122514.1832-2-christian.koenig@amd.com
Stable-dep-of: 89709105a609 ("drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |  2 ++
 .../gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |  2 ++
 drivers/gpu/drm/i915/i915_ttm_buddy_manager.c |  2 ++
 drivers/gpu/drm/nouveau/nouveau_mem.c         |  3 ++-
 drivers/gpu/drm/nouveau/nouveau_mem.h         |  3 ++-
 drivers/gpu/drm/nouveau/nouveau_ttm.c         |  9 ++++----
 drivers/gpu/drm/ttm/ttm_range_manager.c       |  2 ++
 drivers/gpu/drm/ttm/ttm_resource.c            | 23 +++++++++++++++++++
 drivers/gpu/drm/ttm/ttm_sys_manager.c         |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |  2 ++
 .../gpu/drm/vmwgfx/vmwgfx_system_manager.c    |  1 +
 include/drm/ttm/ttm_resource.h                |  3 +++
 13 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 675a72ef305da..ea5470c8c9212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -169,6 +169,7 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
 	return 0;
 
 err_free:
+	ttm_resource_fini(man, &node->base.base);
 	kfree(node);
 
 err_out:
@@ -200,6 +201,7 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
 	if (!(res->placement & TTM_PL_FLAG_TEMPORARY))
 		atomic64_sub(res->num_pages, &mgr->used);
 
+	ttm_resource_fini(man, res);
 	kfree(node);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index d02c8637f909f..ffddec08e931f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -95,6 +95,7 @@ static void amdgpu_preempt_mgr_del(struct ttm_resource_manager *man,
 	struct amdgpu_preempt_mgr *mgr = to_preempt_mgr(man);
 
 	atomic64_sub(res->num_pages, &mgr->used);
+	ttm_resource_fini(man, res);
 	kfree(res);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7b2b0980ec412..55d68408951d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -476,6 +476,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	while (i--)
 		drm_mm_remove_node(&node->mm_nodes[i]);
 	spin_unlock(&mgr->lock);
+	ttm_resource_fini(man, &node->base);
 	kvfree(node);
 
 error_sub:
@@ -515,6 +516,7 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
 	atomic64_sub(usage, &mgr->usage);
 	atomic64_sub(vis_usage, &mgr->vis_usage);
 
+	ttm_resource_fini(man, res);
 	kvfree(node);
 }
 
diff --git a/drivers/gpu/drm/i915/i915_ttm_buddy_manager.c b/drivers/gpu/drm/i915/i915_ttm_buddy_manager.c
index 6877362f6b85f..5740087f9ce93 100644
--- a/drivers/gpu/drm/i915/i915_ttm_buddy_manager.c
+++ b/drivers/gpu/drm/i915/i915_ttm_buddy_manager.c
@@ -109,6 +109,7 @@ static int i915_ttm_buddy_man_alloc(struct ttm_resource_manager *man,
 	i915_buddy_free_list(mm, &bman_res->blocks);
 	mutex_unlock(&bman->lock);
 err_free_res:
+	ttm_resource_fini(man, &bman_res->base);
 	kfree(bman_res);
 	return err;
 }
@@ -123,6 +124,7 @@ static void i915_ttm_buddy_man_free(struct ttm_resource_manager *man,
 	i915_buddy_free_list(&bman->mm, &bman_res->blocks);
 	mutex_unlock(&bman->lock);
 
+	ttm_resource_fini(man, res);
 	kfree(bman_res);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_mem.c b/drivers/gpu/drm/nouveau/nouveau_mem.c
index 2ca3207c13fcd..2e517cdc24c9c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_mem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_mem.c
@@ -162,11 +162,12 @@ nouveau_mem_vram(struct ttm_resource *reg, bool contig, u8 page)
 }
 
 void
-nouveau_mem_del(struct ttm_resource *reg)
+nouveau_mem_del(struct ttm_resource_manager *man, struct ttm_resource *reg)
 {
 	struct nouveau_mem *mem = nouveau_mem(reg);
 
 	nouveau_mem_fini(mem);
+	ttm_resource_fini(man, reg);
 	kfree(mem);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_mem.h b/drivers/gpu/drm/nouveau/nouveau_mem.h
index 2c01166a90f25..325551eba5cd4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_mem.h
+++ b/drivers/gpu/drm/nouveau/nouveau_mem.h
@@ -23,7 +23,8 @@ nouveau_mem(struct ttm_resource *reg)
 
 int nouveau_mem_new(struct nouveau_cli *, u8 kind, u8 comp,
 		    struct ttm_resource **);
-void nouveau_mem_del(struct ttm_resource *);
+void nouveau_mem_del(struct ttm_resource_manager *man,
+		     struct ttm_resource *);
 int nouveau_mem_vram(struct ttm_resource *, bool contig, u8 page);
 int nouveau_mem_host(struct ttm_resource *, struct ttm_tt *);
 void nouveau_mem_fini(struct nouveau_mem *);
diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index 2ca9d9a9e5d5e..91ef33f8f22cb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -36,9 +36,10 @@
 #include <core/tegra.h>
 
 static void
-nouveau_manager_del(struct ttm_resource_manager *man, struct ttm_resource *reg)
+nouveau_manager_del(struct ttm_resource_manager *man,
+		    struct ttm_resource *reg)
 {
-	nouveau_mem_del(reg);
+	nouveau_mem_del(man, reg);
 }
 
 static int
@@ -62,7 +63,7 @@ nouveau_vram_manager_new(struct ttm_resource_manager *man,
 
 	ret = nouveau_mem_vram(*res, nvbo->contig, nvbo->page);
 	if (ret) {
-		nouveau_mem_del(*res);
+		nouveau_mem_del(man, *res);
 		return ret;
 	}
 
@@ -118,7 +119,7 @@ nv04_gart_manager_new(struct ttm_resource_manager *man,
 	ret = nvif_vmm_get(&mem->cli->vmm.vmm, PTES, false, 12, 0,
 			   (long)(*res)->num_pages << PAGE_SHIFT, &mem->vma[0]);
 	if (ret) {
-		nouveau_mem_del(*res);
+		nouveau_mem_del(man, *res);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/ttm/ttm_range_manager.c b/drivers/gpu/drm/ttm/ttm_range_manager.c
index f4b08a8705b32..69962b5769c54 100644
--- a/drivers/gpu/drm/ttm/ttm_range_manager.c
+++ b/drivers/gpu/drm/ttm/ttm_range_manager.c
@@ -89,6 +89,7 @@ static int ttm_range_man_alloc(struct ttm_resource_manager *man,
 	spin_unlock(&rman->lock);
 
 	if (unlikely(ret)) {
+		ttm_resource_fini(man, *res);
 		kfree(node);
 		return ret;
 	}
@@ -108,6 +109,7 @@ static void ttm_range_man_free(struct ttm_resource_manager *man,
 	drm_mm_remove_node(&node->mm_nodes[0]);
 	spin_unlock(&rman->lock);
 
+	ttm_resource_fini(man, res);
 	kfree(node);
 }
 
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 2431717376e70..2c590b4c46cb7 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -29,6 +29,14 @@
 #include <drm/ttm/ttm_resource.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
+/**
+ * ttm_resource_init - resource object constructure
+ * @bo: buffer object this resources is allocated for
+ * @place: placement of the resource
+ * @res: the resource object to inistilize
+ *
+ * Initialize a new resource object. Counterpart of &ttm_resource_fini.
+ */
 void ttm_resource_init(struct ttm_buffer_object *bo,
                        const struct ttm_place *place,
                        struct ttm_resource *res)
@@ -44,6 +52,21 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_resource_init);
 
+/**
+ * ttm_resource_fini - resource destructor
+ * @man: the resource manager this resource belongs to
+ * @res: the resource to clean up
+ *
+ * Should be used by resource manager backends to clean up the TTM resource
+ * objects before freeing the underlying structure. Counterpart of
+ * &ttm_resource_init
+ */
+void ttm_resource_fini(struct ttm_resource_manager *man,
+		       struct ttm_resource *res)
+{
+}
+EXPORT_SYMBOL(ttm_resource_fini);
+
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res_ptr)
diff --git a/drivers/gpu/drm/ttm/ttm_sys_manager.c b/drivers/gpu/drm/ttm/ttm_sys_manager.c
index 63aca52f75e12..135394dcca95a 100644
--- a/drivers/gpu/drm/ttm/ttm_sys_manager.c
+++ b/drivers/gpu/drm/ttm/ttm_sys_manager.c
@@ -23,6 +23,7 @@ static int ttm_sys_man_alloc(struct ttm_resource_manager *man,
 static void ttm_sys_man_free(struct ttm_resource_manager *man,
 			     struct ttm_resource *res)
 {
+	ttm_resource_fini(man, res);
 	kfree(res);
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
index b2c4af331c9d5..bfd686bb8d194 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
@@ -116,6 +116,7 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
 	gman->used_gmr_pages -= (*res)->num_pages;
 	spin_unlock(&gman->lock);
 	ida_free(&gman->gmr_ida, id);
+	ttm_resource_fini(man, *res);
 	kfree(*res);
 	return -ENOSPC;
 }
@@ -129,6 +130,7 @@ static void vmw_gmrid_man_put_node(struct ttm_resource_manager *man,
 	spin_lock(&gman->lock);
 	gman->used_gmr_pages -= res->num_pages;
 	spin_unlock(&gman->lock);
+	ttm_resource_fini(man, res);
 	kfree(res);
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_system_manager.c b/drivers/gpu/drm/vmwgfx/vmwgfx_system_manager.c
index b0005b03a6174..a64188c7268d5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_system_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_system_manager.c
@@ -49,6 +49,7 @@ static int vmw_sys_man_alloc(struct ttm_resource_manager *man,
 static void vmw_sys_man_free(struct ttm_resource_manager *man,
 			     struct ttm_resource *res)
 {
+	ttm_resource_fini(man, res);
 	kfree(res);
 }
 
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 140b6b9a8bbe6..dd6929f0c4f6d 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -262,6 +262,9 @@ ttm_resource_manager_cleanup(struct ttm_resource_manager *man)
 void ttm_resource_init(struct ttm_buffer_object *bo,
                        const struct ttm_place *place,
                        struct ttm_resource *res);
+void ttm_resource_fini(struct ttm_resource_manager *man,
+		       struct ttm_resource *res);
+
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res);
-- 
2.43.0


