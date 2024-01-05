Return-Path: <linux-kernel+bounces-18258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31122825AAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74C51F20C27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE53A1D0;
	Fri,  5 Jan 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="miPaG4Hu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496F3A1A5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480436;
	bh=zkWIJ7P9a1m72+FqeXAbXwbM9DM9q7qPsdOCL/PnHw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=miPaG4HuD6TrsZB5vjF09RmNn3Kv/vL8zJWm0NmB4CXk5oPvt/0pLFN+4ug8zAQXr
	 QyIVqu8GNWov925rkVbmgYnI591tXKO8ahE62rh/EQEdcE+3QP03LmNEpSLVNIqpA0
	 Pa4Iv5g9cd5oVudpHQFKDineB2eId4+6Z6lLG+Dpks0WJx1ISR9IqenNM7/M1VidcG
	 gezJlH6cj3gWqB4Gx67gw71X74QW1RzpBJ/vQyVXjjrTUvQ3NczXrOr4+MaADY0Azh
	 rz1TypBo10P0asqwX4BuZyr6EJ8ZIvEYvmlM0lxrQsoG/Vmg8nK4ZHHrMgggyFKLQQ
	 dRHp1x3enna4A==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E4F83782047;
	Fri,  5 Jan 2024 18:47:15 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Emma Anholt <emma@anholt.net>,
	Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v19 20/30] drm/v3d: Explicitly get and put drm-shmem pages
Date: Fri,  5 Jan 2024 21:46:14 +0300
Message-ID: <20240105184624.508603-21-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To simplify the drm-shmem refcnt handling, we're moving away from
the implicit get_pages() that is used by get_pages_sgt(). From now on
drivers will have to pin pages while they use sgt. V3D driver doesn't
support shrinker, hence pages are pinned and sgt is valid as long as
pages' use-count > 0.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 1bdfac8beafd..ccf04ce93e8c 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -50,6 +50,9 @@ void v3d_free_object(struct drm_gem_object *obj)
 	/* GPU execution may have dirtied any pages in the BO. */
 	bo->base.pages_mark_dirty_on_put = true;
 
+	if (!obj->import_attach)
+		drm_gem_shmem_put_pages(&bo->base);
+
 	drm_gem_shmem_free(&bo->base);
 }
 
@@ -139,12 +142,18 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
 	bo = to_v3d_bo(&shmem_obj->base);
 	bo->vaddr = NULL;
 
-	ret = v3d_bo_create_finish(&shmem_obj->base);
+	ret = drm_gem_shmem_get_pages(shmem_obj);
 	if (ret)
 		goto free_obj;
 
+	ret = v3d_bo_create_finish(&shmem_obj->base);
+	if (ret)
+		goto put_pages;
+
 	return bo;
 
+put_pages:
+	drm_gem_shmem_put_pages(shmem_obj);
 free_obj:
 	drm_gem_shmem_free(shmem_obj);
 	return ERR_PTR(ret);
-- 
2.43.0


