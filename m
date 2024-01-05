Return-Path: <linux-kernel+bounces-18264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F9825AB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E84D286681
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0593BB2D;
	Fri,  5 Jan 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="koD1jTYA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935343B2BD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480446;
	bh=Xy26gJL0rfEIAQ3GTzMQ9EaB0QSmN8Rrgbq8+tRhsXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koD1jTYASaaq0lH30DCRGwRlLF4icZe6o4RtGhMtxdBXY6SQHCj+AAoMWGtCV5jal
	 3o38uo19aKWom4br+OTJmNgxqtAXnvCQUYJjZ8hDcNButj0PQLLHni40YT501PCe6q
	 ErF+M+MYMwDfZlVE+2dFDViPRVojFs1vXPkPZ8WiG92SaZ7MSFVtT17Scs7uYMdJsy
	 HZalfvQSfjP9e4W+qiuVHBQZioyrxkCXK6FpqhTSHYXKdRKIxj01ioqjERVM7ygUfQ
	 hQGNr+u92vLMktYspBAr0AJKm4va1ejnViBWlDzvwRtDU+HLnQGiP3yS7a15I0yQuP
	 J7987sqBJRbVw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E4CC2378206D;
	Fri,  5 Jan 2024 18:47:24 +0000 (UTC)
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
Subject: [PATCH v19 26/30] drm/shmem-helper: Turn warnings about imported GEM into errors
Date: Fri,  5 Jan 2024 21:46:20 +0300
Message-ID: <20240105184624.508603-27-dmitry.osipenko@collabora.com>
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

Turn sanity warnings about DRM-SHMEM API misuse into a error conditions
for cases where imported GEM is used when it shouldn't be used.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 0d95d723b90d..7d2fe12bd793 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -409,7 +409,8 @@ int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem)
 	struct drm_gem_object *obj = &shmem->base;
 	int ret;
 
-	drm_WARN_ON(obj->dev, obj->import_attach);
+	if (drm_WARN_ON(obj->dev, obj->import_attach))
+		return -EINVAL;
 
 	if (refcount_inc_not_zero(&shmem->pages_pin_count))
 		return 0;
@@ -872,7 +873,8 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 
-	drm_WARN_ON(obj->dev, obj->import_attach);
+	if (drm_WARN_ON(obj->dev, obj->import_attach))
+		return ERR_PTR(-EINVAL);
 
 	if (drm_WARN_ON(obj->dev, !shmem->pages))
 		return ERR_PTR(-ENOMEM);
@@ -909,7 +911,8 @@ struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object
 	if (shmem->sgt)
 		return shmem->sgt;
 
-	drm_WARN_ON(obj->dev, obj->import_attach);
+	if (drm_WARN_ON(obj->dev, obj->import_attach))
+		return ERR_PTR(-EINVAL);
 
 	sgt = drm_gem_shmem_get_sg_table(shmem);
 	if (IS_ERR(sgt))
-- 
2.43.0


