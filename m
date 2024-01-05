Return-Path: <linux-kernel+bounces-17895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2788254A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A709B228E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3DA2D7A7;
	Fri,  5 Jan 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gpZp/G9P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B72D63E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4283cd9bd87so7977981cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 05:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704462668; x=1705067468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksuLF6jukPjWhV98H6vhWkgqmGNNXL1H2FBqRmQPvDI=;
        b=gpZp/G9Ps3GwhwhtrmaHqm+7Bd0pAs0vTojb9aW1lKELdWIafjMteN0FbjfSHpROxa
         XMfR3Omjo0D9jXwZ7udR1s8pL4evexO22fiIWkqqHFfMFiLd/nUA5ADldsamuOqvJ+Kc
         i5+zJVKou7Etp2hPKyUhZ7NcNV4RC9SlQIgCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704462668; x=1705067468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksuLF6jukPjWhV98H6vhWkgqmGNNXL1H2FBqRmQPvDI=;
        b=B6UBKDFDWTkVq95cHA0EOCC7Ea9+gn+sgykedFhsKTbqhf4Jb1wqTMmTXfOpfOMtY8
         EJdG7ax0rGNUP8dQCs22UNF9Qv2dd9WsjY4Pc0uy19PKnWW63rfGkB78xaUmBlSrZLcm
         ctW7WOEk89WhEsqfqFUsCfYXlqTHUw5mS62GasaOTWHrXGhwL9550U2bELgKTTtpMnCP
         isV+ei+Q9caQb0LR1d0BOEtzegg68xyJ9zhbUm6I4u9zRAsabnw36VvPsN9FOzSpFwdb
         MjUhcbOgvCOh3SYX8dwY/pYKy+CL99izvyoO9k3LyXsWd16zZ7EDO0PR2wy4qJn13ss2
         3U2w==
X-Gm-Message-State: AOJu0YxMz3FkKBa1OzBQIIa4oLNJaa16OcHGLm2Sk9PjPk4pt86w8MLY
	wzGICEtial+9N6BpzXw10y9twt0Rk7ut
X-Google-Smtp-Source: AGHT+IH1lxCcp+T2dHzD0vZ0T89p5MYD7pVY2qc7j+xUQ1MVhbY8BJx9RZYRteVUmBIEKZdoTFJ8Gg==
X-Received: by 2002:a05:622a:1e0a:b0:429:7dbc:d6be with SMTP id br10-20020a05622a1e0a00b004297dbcd6bemr38885qtb.97.1704462668469;
        Fri, 05 Jan 2024 05:51:08 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id fc24-20020a05622a489800b00428346b88bfsm733372qtb.65.2024.01.05.05.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:51:08 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/ttm: Make sure the mapped tt pages are decrypted when needed
Date: Fri,  5 Jan 2024 08:51:05 -0500
Message-Id: <20240105135105.1921947-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2b5648aa-f83d-d8f7-b0fd-39c859f32f33@linux.intel.com>
References: <2b5648aa-f83d-d8f7-b0fd-39c859f32f33@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some drivers require the mapped tt pages to be decrypted. In an ideal
world this would have been handled by the dma layer, but the TTM page
fault handling would have to be rewritten to able to do that.

A side-effect of the TTM page fault handling is using a dma allocation
per order (via ttm_pool_alloc_page) which makes it impossible to just
trivially use dma_mmap_attrs. As a result ttm has to be very careful
about trying to make its pgprot for the mapped tt pages match what
the dma layer thinks it is. At the ttm layer it's possible to
deduce the requirement to have tt pages decrypted by checking
whether coherent dma allocations have been requested and the system
is running with confidential computing technologies.

This approach isn't ideal but keeping TTM matching DMAs expectations
for the page properties is in general fragile, unfortunately proper
fix would require a rewrite of TTM's page fault handling.

Fixes vmwgfx with SEV enabled.

v2: Explicitly include cc_platform.h
v3: Use CC_ATTR_GUEST_MEM_ENCRYPT instead of CC_ATTR_MEM_ENCRYPT to
limit the scope to guests and log when memory decryption is enabled.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 3bf3710e3718 ("drm/ttm: Add a generic TTM memcpy move for page-based iomem")
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # v5.14+
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 13 +++++++++++--
 drivers/gpu/drm/ttm/ttm_tt.c      | 12 ++++++++++++
 include/drm/ttm/ttm_tt.h          |  9 ++++++++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index fd9fd3d15101..0b3f4267130c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -294,7 +294,13 @@ pgprot_t ttm_io_prot(struct ttm_buffer_object *bo, struct ttm_resource *res,
 	enum ttm_caching caching;
 
 	man = ttm_manager_type(bo->bdev, res->mem_type);
-	caching = man->use_tt ? bo->ttm->caching : res->bus.caching;
+	if (man->use_tt) {
+		caching = bo->ttm->caching;
+		if (bo->ttm->page_flags & TTM_TT_FLAG_DECRYPTED)
+			tmp = pgprot_decrypted(tmp);
+	} else  {
+		caching = res->bus.caching;
+	}
 
 	return ttm_prot_from_caching(caching, tmp);
 }
@@ -337,6 +343,8 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 		.no_wait_gpu = false
 	};
 	struct ttm_tt *ttm = bo->ttm;
+	struct ttm_resource_manager *man =
+			ttm_manager_type(bo->bdev, bo->resource->mem_type);
 	pgprot_t prot;
 	int ret;
 
@@ -346,7 +354,8 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
-	if (num_pages == 1 && ttm->caching == ttm_cached) {
+	if (num_pages == 1 && ttm->caching == ttm_cached &&
+	    !(man->use_tt && (ttm->page_flags & TTM_TT_FLAG_DECRYPTED))) {
 		/*
 		 * We're mapping a single page, and the desired
 		 * page protection is consistent with the bo.
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index d978dc539a9b..578a7c37f00b 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -31,11 +31,13 @@
 
 #define pr_fmt(fmt) "[TTM] " fmt
 
+#include <linux/cc_platform.h>
 #include <linux/sched.h>
 #include <linux/shmem_fs.h>
 #include <linux/file.h>
 #include <linux/module.h>
 #include <drm/drm_cache.h>
+#include <drm/drm_device.h>
 #include <drm/drm_util.h>
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_tt.h>
@@ -61,6 +63,7 @@ static atomic_long_t ttm_dma32_pages_allocated;
 int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 {
 	struct ttm_device *bdev = bo->bdev;
+	struct drm_device *ddev = bo->base.dev;
 	uint32_t page_flags = 0;
 
 	dma_resv_assert_held(bo->base.resv);
@@ -82,6 +85,15 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 		pr_err("Illegal buffer object type\n");
 		return -EINVAL;
 	}
+	/*
+	 * When using dma_alloc_coherent with memory encryption the
+	 * mapped TT pages need to be decrypted or otherwise the drivers
+	 * will end up sending encrypted mem to the gpu.
+	 */
+	if (bdev->pool.use_dma_alloc && cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		page_flags |= TTM_TT_FLAG_DECRYPTED;
+		drm_info(ddev, "TT memory decryption enabled.");
+	}
 
 	bo->ttm = bdev->funcs->ttm_tt_create(bo, page_flags);
 	if (unlikely(bo->ttm == NULL))
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index a4eff85b1f44..2b9d856ff388 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -79,6 +79,12 @@ struct ttm_tt {
 	 *   page_flags = TTM_TT_FLAG_EXTERNAL |
 	 *		  TTM_TT_FLAG_EXTERNAL_MAPPABLE;
 	 *
+	 * TTM_TT_FLAG_DECRYPTED: The mapped ttm pages should be marked as
+	 * not encrypted. The framework will try to match what the dma layer
+	 * is doing, but note that it is a little fragile because ttm page
+	 * fault handling abuses the DMA api a bit and dma_map_attrs can't be
+	 * used to assure pgprot always matches.
+	 *
 	 * TTM_TT_FLAG_PRIV_POPULATED: TTM internal only. DO NOT USE. This is
 	 * set by TTM after ttm_tt_populate() has successfully returned, and is
 	 * then unset when TTM calls ttm_tt_unpopulate().
@@ -87,8 +93,9 @@ struct ttm_tt {
 #define TTM_TT_FLAG_ZERO_ALLOC		BIT(1)
 #define TTM_TT_FLAG_EXTERNAL		BIT(2)
 #define TTM_TT_FLAG_EXTERNAL_MAPPABLE	BIT(3)
+#define TTM_TT_FLAG_DECRYPTED		BIT(4)
 
-#define TTM_TT_FLAG_PRIV_POPULATED	BIT(4)
+#define TTM_TT_FLAG_PRIV_POPULATED	BIT(5)
 	uint32_t page_flags;
 	/** @num_pages: Number of pages in the page array. */
 	uint32_t num_pages;
-- 
2.40.1


