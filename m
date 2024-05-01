Return-Path: <linux-kernel+bounces-164978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765438B85CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3BF284786
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586014D9E9;
	Wed,  1 May 2024 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L4J7fJjX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1045000;
	Wed,  1 May 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546621; cv=none; b=NsCYCckVcQDFb0ojjAoOp18ENOlXJoAnio5iMbQlRtbwZE6mUL/hh6bxFRuWZXLKCdrvU6Uq2dU9tQFMa6KnvR+nUpz/cCAMQEvDz68azRW8ra3dDij64aLDWM6StORu5a4p25Y7UXRTWGbSl46rczJBA6FRJG+KtZWZISQa74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546621; c=relaxed/simple;
	bh=iEC0/RKlUV3PA5EcZER+WAMWrbc6jCqUUJ6YQFg0IQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnE6iEEDs0RS/3sxJADrHgJyB3x0px1AGkOr2UWMN0icj4jiC/KhMvgZDga9DYSVpnwcSjTWYw5PGVBU9s823FJ6EB2zGAWB6k4tnAQmmD3UnBRl8YPzhspFErMgjRvwt4PBZFxv8INlowjbe0V/SstrpIyKfMvCbPkIqHiAFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L4J7fJjX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714546618;
	bh=iEC0/RKlUV3PA5EcZER+WAMWrbc6jCqUUJ6YQFg0IQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4J7fJjXtl6k75cLOq+bIqsFXeMGPNnZNIQJ3s+qZLzcCFimVLyxv6ueYXJ9GqnFn
	 8IXzp5d56O/ECJoyof37PwfFiTZJI8Rb1d+hWl5nh2plBG0kmYeHY+8QVVHMHlKdoT
	 KTZu3hbGFD3m+m1DumEWzKgjGVQa4PdUSDbH7oFlHTUsw/uLTQNQTwzcGpI5gX2rbl
	 c7QZryTq7wgEaMMsM4cj5ZGIVNkQqLurX9iGx9RyyAO23DHPBQw52P0RsYmOdPeVgX
	 aKOkEohfl6O56ANrpPwmHGdp+fmlS4+T8PnccI1lncp8QVBiCXscTeKnJTGerwb8Go
	 0nmKcYvu7GqiQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5CF4937820E1;
	Wed,  1 May 2024 06:56:57 +0000 (UTC)
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
	Christian Koenig= <christian.koenig@amd.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Zack Rusin <zack.rusin@broadcom.com>
Cc: kernel@collabora.com,
	Adrian Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH v3 1/2] drm/panfrost: Fix dma_resv deadlock at drm object pin time
Date: Wed,  1 May 2024 07:55:59 +0100
Message-ID: <20240501065650.2809530-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501065650.2809530-1-adrian.larumbe@collabora.com>
References: <20240501065650.2809530-1-adrian.larumbe@collabora.com>
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
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/lima/lima_gem.c         | 2 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 7ea244d876ca..c4e0f9faaa47 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -185,7 +185,7 @@ static int lima_gem_pin(struct drm_gem_object *obj)
 	if (bo->heap_size)
 		return -EINVAL;
 
-	return drm_gem_shmem_pin(&bo->base);
+	return drm_gem_shmem_object_pin(obj);
 }
 
 static int lima_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index d47b40b82b0b..f268bd5c2884 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -192,7 +192,7 @@ static int panfrost_gem_pin(struct drm_gem_object *obj)
 	if (bo->is_heap)
 		return -EINVAL;
 
-	return drm_gem_shmem_pin(&bo->base);
+	return drm_gem_shmem_object_pin(obj);
 }
 
 static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj)
-- 
2.44.0


