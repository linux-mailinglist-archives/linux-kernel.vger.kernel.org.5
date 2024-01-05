Return-Path: <linux-kernel+bounces-18252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C29825A9E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62041C232AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21C039843;
	Fri,  5 Jan 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kg85oLbd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94538F8B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480427;
	bh=MjcmD6gU68LDlFoDzu5LGGvN6a0gG7s2tx477nPNH80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kg85oLbd4ffNzHiDa0cajzNYVvBhIZ8MqdJWOoByqrMIpeMq3B2j4jZ3r/uKszve9
	 ssD3lwpTpX0nS/g2JlPEmcTwT+innDur/vJRigpwF4LjWDmLQNgBO/pvHu3/UtX2J4
	 wWKmpfOaeog7a1pvI46vrbN3yAuUbP9cUV0LhHD3OPXyyJbhcnZPRgoniUqL/UW55q
	 c7tApQ2ohn1MamZElQjeFpbqd6E4+S1xolcBOmXu1F6RhPpfb2fj+ISblkkhap7o8G
	 or8+FNrLoahMA5Lk+ycWfagGRHd7SgTy+VDDCBMWB+NV+SDHKz5TUt6DaPByeN/O0e
	 vXu8MqNZvoDqw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9FD0F378205C;
	Fri,  5 Jan 2024 18:47:05 +0000 (UTC)
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
Subject: [PATCH v19 14/30] drm/shmem-helper: Add drm_gem_shmem_put_pages()
Date: Fri,  5 Jan 2024 21:46:08 +0300
Message-ID: <20240105184624.508603-15-dmitry.osipenko@collabora.com>
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

We're going to move away from having implicit get_pages() done by
get_pages_sgt() to ease simplify refcnt handling. Drivers will manage
get/put_pages() by themselves. Add drm_gem_shmem_put_pages().

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 20 ++++++++++++++++++++
 include/drm/drm_gem_shmem_helper.h     |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index dc416a4bce1b..f5ed64f78648 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -218,6 +218,7 @@ static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
  * @shmem: shmem GEM object
  *
  * This function decreases the use count and puts the backing pages when use drops to zero.
+ * Caller must hold GEM's reservation lock.
  */
 void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
 {
@@ -228,6 +229,25 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
 
+/*
+ * drm_gem_shmem_put_pages - Decrease use count on the backing pages for a shmem GEM object
+ * @shmem: shmem GEM object
+ *
+ * This function decreases the use count and puts the backing pages when use drops to zero.
+ * It's unlocked version of drm_gem_shmem_put_pages_locked(), caller must not hold
+ * GEM's reservation lock.
+ */
+void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
+{
+	if (refcount_dec_not_one(&shmem->pages_use_count))
+		return;
+
+	dma_resv_lock(shmem->base.resv, NULL);
+	drm_gem_shmem_put_pages_locked(shmem);
+	dma_resv_unlock(shmem->base.resv);
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages);
+
 /*
  * drm_gem_shmem_get_pages - Increase use count on the backing pages for a shmem GEM object
  * @shmem: shmem GEM object
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 6dedc0739fbc..525480488451 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -111,6 +111,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
 
 int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem);
+void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
 int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);
-- 
2.43.0


