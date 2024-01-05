Return-Path: <linux-kernel+bounces-18261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD597825AAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B281C23B4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F23A8FE;
	Fri,  5 Jan 2024 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kEoyrUuq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F23A8DA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480441;
	bh=92DtaMjqXiYcBus3ShTQudZc7/346pWIqwyiwc+pNg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEoyrUuqdlwGs9/4O1PrKLsmZzI4Qej2W6V9qzlpK5WXJD5FO5/7xgqBoX8Ye5FOg
	 UOulsj9FNHuqHJO6tCgTyhe6URp00htm15iutOBQhSX09/qLL6Ad2PHzYg2XpltfXE
	 lAOx/3vdvleFz0Yz3tcgltqtVEl3+1HHKBDcWKSGulLCaYZfRYClEs5tuG4o5yJ/H3
	 T3ZAjeT4JQ2L+Mqpb5QigjMzoytAMbLi+PiGtjX6QZdn2kP3zaHiB+h5BiM5wq3tZ/
	 dJZtoQmTCTFFxOqUAVQaEUg+ZvvOBLsfg/5P5nlPyFRDxwC5+69nCOlo+aKsQgewhr
	 gKNZgZcK76bSg==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 273D3378204A;
	Fri,  5 Jan 2024 18:47:20 +0000 (UTC)
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
Subject: [PATCH v19 23/30] drm/shmem-helper: Export drm_gem_shmem_get_pages_sgt_locked()
Date: Fri,  5 Jan 2024 21:46:17 +0300
Message-ID: <20240105184624.508603-24-dmitry.osipenko@collabora.com>
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

Export drm_gem_shmem_get_pages_sgt_locked() that will be used by virtio-gpu
shrinker during GEM swap-in operation done under the held reservation lock.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 22 +++++++++++++++++++++-
 include/drm/drm_gem_shmem_helper.h     |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 59cebd1e35af..8fd7851c088b 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -875,12 +875,31 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
 
-static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem)
+/**
+ * drm_gem_shmem_get_pages_sgt_locked - Provide a scatter/gather table of pinned
+ *                                      pages for a shmem GEM object
+ * @shmem: shmem GEM object
+ *
+ * This is a locked version of @drm_gem_shmem_get_sg_table that exports a
+ * scatter/gather table suitable for PRIME usage by calling the standard
+ * DMA mapping API.
+ *
+ * Drivers must hold GEM's reservation lock when using this function.
+ *
+ * Drivers who need to acquire an scatter/gather table for objects need to call
+ * drm_gem_shmem_get_pages_sgt() instead.
+ *
+ * Returns:
+ * A pointer to the scatter/gather table of pinned pages or error pointer on failure.
+ */
+struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 	int ret;
 	struct sg_table *sgt;
 
+	dma_resv_assert_held(shmem->base.resv);
+
 	if (shmem->sgt)
 		return shmem->sgt;
 
@@ -904,6 +923,7 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
 	kfree(sgt);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages_sgt_locked);
 
 /**
  * drm_gem_shmem_get_pages_sgt - Pin pages, dma map them, and return a
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index df97c11fc99a..167f00f089de 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -149,6 +149,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem);
 
 struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem);
 struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem);
+struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem);
 
 void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 			      struct drm_printer *p, unsigned int indent);
-- 
2.43.0


