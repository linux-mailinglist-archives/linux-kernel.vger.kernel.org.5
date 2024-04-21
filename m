Return-Path: <linux-kernel+bounces-152534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227EC8AC024
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8BB1F20EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1821E1BF5C;
	Sun, 21 Apr 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FHMf4LCm"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD3E560;
	Sun, 21 Apr 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713717634; cv=none; b=LQp36CfdSl/pxCIlZvEfjxOZVoxUNKxdVBfbT7v/u+j0TonyWMs+IKnGL/oS4qcqgRYG9LTL4ZJfOUn0dtucz9/zO4GKlEaKybvK4lOu74sSUvlz2ds6RrFI0ThWh5N1nvViX6EQee6Wa3G9uMtOireq2VX8E2iKbckKQ5P69TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713717634; c=relaxed/simple;
	bh=ukg6qw8U5Z46p/Fn0ryD5cc6wFsTS2m4KBCjmzl/FDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tfe8r0bSte9LYHl1nczmBruyOWQuD8pJ9LD3Oo42fSv80ObmeTP6mZX34Cop5qNYRAnFcj6UjBzCgvOmstbWqDcnOjEy9D6hZJfvevTEOpCuQODclbiYs6GDnVjUCtS1fpuZutCheXCmK0eQPPzS8jU5s28ApaQDQY/zHWq8fiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FHMf4LCm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713717625;
	bh=ukg6qw8U5Z46p/Fn0ryD5cc6wFsTS2m4KBCjmzl/FDw=;
	h=From:To:Cc:Subject:Date:From;
	b=FHMf4LCmyFf5sixIFOITfaBalimO45l0A7Outx06Sts1yx4+4MvBT2JPMxy1t/BJ0
	 oc2+KwLuAjRJWikNO8C9f5/H5GrNs3nz8ExTEKMj+MJ2B8usgSmIW/GhGrNn/110fc
	 znsUyXRpHE83zjhERdl2mpfr/NmwLvN7Lbzzw5SYjedXUbvVO+TKlLOI3Dt28TjssR
	 s4qQkOTsrZahKRFRkDryXUSLj441cAqF3Dt8EtDhfHoJ3Ce/jbofap91a576mZdDy8
	 5dJ1o1Swd4+4fXwECbqbkmV95oeksFSu2HulSgd2s9fScDNmKHW0a+1/hry2ByKTN8
	 Y41a+E3i2DgwQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4523F37804B2;
	Sun, 21 Apr 2024 16:40:24 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH] drm/panfrost: Fix dma_resv deadlock at drm object pin time
Date: Sun, 21 Apr 2024 17:39:47 +0100
Message-ID: <20240421163951.3398622-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When Panfrost must pin an object that is being prepared a dma-buf
attachment for on behalf of another driver, the core drm gem object pinning
code already takes a lock on the object's dma reservation.

However, Panfrost GEM object's pinning callback would eventually try taking
the lock on the same dma reservation when delegating pinning of the object
onto the shmem subsystem, which led to a deadlock.

This can be shown by enabling CONFIG_DEBUG_WW_MUTEX_SLOWPATH, which throws
the following recursive locking situation:

weston/3440 is trying to acquire lock:
ffff000000e235a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: drm_gem_shmem_pin+0x34/0xb8 [drm_shmem_helper]
but task is already holding lock:
ffff000000e235a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: drm_gem_pin+0x2c/0x80 [drm]

Fix it by assuming the object's reservation had already been locked by the
time we reach panfrost_gem_pin.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>
Fixes: a78027847226 ("drm/gem: Acquire reservation lock in drm_gem_{pin/unpin}()")
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index d47b40b82b0b..6c26652d425d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -192,7 +192,12 @@ static int panfrost_gem_pin(struct drm_gem_object *obj)
 	if (bo->is_heap)
 		return -EINVAL;
 
-	return drm_gem_shmem_pin(&bo->base);
+	/*
+	 * Pinning can only happen in response to a prime attachment request from
+	 * another driver, but that's already being handled by drm_gem_pin
+	 */
+	drm_WARN_ON(obj->dev, obj->import_attach);
+	return drm_gem_shmem_pin_locked(&bo->base);
 }
 
 static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj)

base-commit: 04687bff66b8a4b22748aa7215d3baef0b318e5b
-- 
2.44.0


