Return-Path: <linux-kernel+bounces-155972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB68AFC25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A691F24053
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97937171;
	Tue, 23 Apr 2024 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E+gmPWpk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2FE364D6;
	Tue, 23 Apr 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912425; cv=none; b=HyPFJfhqMF5fUUW5RzkCQE1/K5XI7yzSHghP2jvuBp+O9qhCOCNWe8Rlq3igNppBFDRJQDTtD0wYXk0FryVRYBfnS8ziaNA7Pr6IuZejugCJh5aha4kGK1YfaMUkDnchAoWfGw9/BD1flMvnmg6HPUnnuE/uGVwBqNZWXI/1ni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912425; c=relaxed/simple;
	bh=3CYseH+FU0vBKnt2WiMn8qQr3YasgNMroL1dksT8+ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LWs+KEJduDfNol+5kXo5ropoq+LU1rlLwOPLrA4I8SVaRcBCnMUdgVKYqgxeK7rkceDjXzleSw0JPnrC4jWatgghQdbPBrqeXQ+TH+BaBmC7/59Ulz/7qNf8ivFEYL5p+yPYEL/AvylkqC86jMRnRRvBsGO8RfMZGQ3DEv/zSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E+gmPWpk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713912421;
	bh=3CYseH+FU0vBKnt2WiMn8qQr3YasgNMroL1dksT8+ec=;
	h=From:To:Cc:Subject:Date:From;
	b=E+gmPWpkN8TEBota5F4adiG1zxgXpWkcuAt5RrETOOslgqXXQge/S11Rfvb7sT/ac
	 NL755WrATlQ/T1M6xL37YKS2Eop0AVT4VkpSogy1yi0Le6IgLCHqZFRJrY962/LMN3
	 26uojcImUl4pBPWvttouhjF3SzLNl9fZycmbxiaexlVZfhrfidhFX8+nSsh2iwUujt
	 KwXCDRdVn7wgOnveA8ZjfkYmbQQT4rcsYvIzF1RWu06jxCet0J9bjk6IJzqdQr4ivZ
	 D5D19giasvFoNVl+ssCQYvyzFwmRJhiNDC9f9dJ5KpYMByEsWXUhGTuNO4R1aKevOQ
	 EaumuDIFvq49g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DFE3F3781013;
	Tue, 23 Apr 2024 22:47:00 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Qiang Yu <yuq825@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Zack Rusin <zack.rusin@broadcom.com>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2] drm/panfrost: Fix dma_resv deadlock at drm object pin time
Date: Tue, 23 Apr 2024 23:46:23 +0100
Message-ID: <20240423224651.138163-1-adrian.larumbe@collabora.com>
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

Do the same thing for the Lima driver, as it most likely suffers from the
same issue.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>
Fixes: a78027847226 ("drm/gem: Acquire reservation lock in drm_gem_{pin/unpin}()")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/lima/lima_gem.c         | 9 +++++++--
 drivers/gpu/drm/panfrost/panfrost_gem.c | 8 +++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 7ea244d876ca..8a5bcf498ef6 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -184,8 +184,13 @@ static int lima_gem_pin(struct drm_gem_object *obj)
 
 	if (bo->heap_size)
 		return -EINVAL;
-
-	return drm_gem_shmem_pin(&bo->base);
+	/*
+	 * Pinning can only happen in response to a prime attachment request
+	 * from another driver, but dma reservation locking is already being
+	 * handled by drm_gem_pin
+	 */
+	drm_WARN_ON(obj->dev, obj->import_attach);
+	return drm_gem_shmem_object_pin(obj);
 }
 
 static int lima_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index d47b40b82b0b..e3fbcb020617 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -192,7 +192,13 @@ static int panfrost_gem_pin(struct drm_gem_object *obj)
 	if (bo->is_heap)
 		return -EINVAL;
 
-	return drm_gem_shmem_pin(&bo->base);
+	/*
+	 * Pinning can only happen in response to a prime attachment request
+	 * from another driver, but dma reservation locking is already being
+	 * handled by drm_gem_pin
+	 */
+	drm_WARN_ON(obj->dev, obj->import_attach);
+	return drm_gem_shmem_object_pin(obj);
 }
 
 static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj)
-- 
2.44.0


