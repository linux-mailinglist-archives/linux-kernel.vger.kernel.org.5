Return-Path: <linux-kernel+bounces-18248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFCE825A96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51411F24282
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473A0381B4;
	Fri,  5 Jan 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="foN9vxtm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D8374E3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480420;
	bh=8xy9qG3NliGtZPVd2hDSN91KOpRZFrkHzfliPWL1Kr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foN9vxtmljHtDoFxKZXdVfUlvUk2ldHQPkysEuMIrETOzSthVpHbW8FrNMkkctFbI
	 DUPAoLi9rJaMXAE1q+5pDZrSwThFYaQrk9oUJPH5bE7RY4VFdzjA1CAGbcLUL5qi3n
	 SOJ26VbLZDldYr7D9USPHVQ9Mx0SjnYr6gCe9BLSnr6+chRZ5JWn/hJzpJCR8HtHW7
	 nac4YIRyxvZdGG31a0mq9S46EA6fdhtNzngGy03ko8VIF36vggCoISL58oQq4MKQQW
	 Ip0WEQ6JQRjX8E2x+cVBXfIumzyu2kCtG4yu4uM2ZpL5h5tNGwX4ofghxUSqRGkruE
	 wSWbCppHn48VA==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 30AC2378204E;
	Fri,  5 Jan 2024 18:46:59 +0000 (UTC)
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
Subject: [PATCH v19 10/30] drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
Date: Fri,  5 Jan 2024 21:46:04 +0300
Message-ID: <20240105184624.508603-11-dmitry.osipenko@collabora.com>
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

The vmapped pages shall be pinned in memory and previously get/put_pages()
were implicitly hard-pinning/unpinning the pages. This will no longer be
the case with addition of memory shrinker because pages_use_count > 0 won't
determine anymore whether pages are hard-pinned (they will be soft-pinned),
while the new pages_pin_count will do the hard-pinning. Switch the
vmap/vunmap() to use pin/unpin() functions in a preparation of addition
of the memory shrinker support to drm-shmem.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 19 ++++++++++++-------
 include/drm/drm_gem_shmem_helper.h     |  2 +-
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 1c032513abf1..9c89183f81b7 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -256,6 +256,14 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 	return ret;
 }
 
+static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
+{
+	dma_resv_assert_held(shmem->base.resv);
+
+	if (refcount_dec_and_test(&shmem->pages_pin_count))
+		drm_gem_shmem_put_pages_locked(shmem);
+}
+
 /**
  * drm_gem_shmem_pin - Pin backing pages for a shmem GEM object
  * @shmem: shmem GEM object
@@ -303,10 +311,7 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
 		return;
 
 	dma_resv_lock(shmem->base.resv, NULL);
-
-	if (refcount_dec_and_test(&shmem->pages_pin_count))
-		drm_gem_shmem_put_pages_locked(shmem);
-
+	drm_gem_shmem_unpin_locked(shmem);
 	dma_resv_unlock(shmem->base.resv);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_unpin);
@@ -344,7 +349,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 			return 0;
 		}
 
-		ret = drm_gem_shmem_get_pages_locked(shmem);
+		ret = drm_gem_shmem_pin_locked(shmem);
 		if (ret)
 			goto err_zero_use;
 
@@ -367,7 +372,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
 err_put_pages:
 	if (!obj->import_attach)
-		drm_gem_shmem_put_pages_locked(shmem);
+		drm_gem_shmem_unpin_locked(shmem);
 err_zero_use:
 	shmem->vmap_use_count = 0;
 
@@ -404,7 +409,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 			return;
 
 		vunmap(shmem->vaddr);
-		drm_gem_shmem_put_pages_locked(shmem);
+		drm_gem_shmem_unpin_locked(shmem);
 	}
 
 	shmem->vaddr = NULL;
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 2c5dc62df20c..80623b897803 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -124,7 +124,7 @@ int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv);
 static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_object *shmem)
 {
 	return (shmem->madv > 0) &&
-		!shmem->vmap_use_count && shmem->sgt &&
+		!refcount_read(&shmem->pages_pin_count) && shmem->sgt &&
 		!shmem->base.dma_buf && !shmem->base.import_attach;
 }
 
-- 
2.43.0


