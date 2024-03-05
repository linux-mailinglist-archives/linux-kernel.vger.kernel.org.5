Return-Path: <linux-kernel+bounces-92997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CFB87292E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EC328553B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A97A12C809;
	Tue,  5 Mar 2024 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vwp6/95P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A114012
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673084; cv=none; b=Sudyd3p0HVF0LufesiyMFz0qY4omry/3inZgdoGsnCnTVqkgCDJqehyDDiMljXWQ12ox5u+ZjYFvPzsO073k/pQ56p1MmLBd8nDwZX1gh9yMTW/JMk1wQ6U0rUto3n7XKqlaxKF6+GN0t5pn9qPQRmhSu9hkZXtDszty5okPJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673084; c=relaxed/simple;
	bh=42G9g4HltAvmEeN59wy+CM/K9KGre53PrTNDCbfrKwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E253ET5QTg17Wbb4bewokDG2lUo+IFMUtrwsNZHvp02sVFDoC7BnSTQzvpfUQfc+bNmt3AZcuW43NwIFwJC0xjzn/YhRCpO3+YNcFVwz24k6WpD8iToHaY1pe7FQGF5q5UAnHj/1BjbpHPewFt1Oq8HT6xA5jfqcSQhXUMHKt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vwp6/95P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709673080;
	bh=42G9g4HltAvmEeN59wy+CM/K9KGre53PrTNDCbfrKwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vwp6/95PxS/uOq5u0qY2dAzuPECbSdmy2ifM+gDUOBaHShS4DQx/zRZPT3RbzQInc
	 U4eDVvBmoQGuaf02gDJvaEkLSMKm0YYb22HMW+5ShjUfB3t/uZSUX0jsw4TOa/7f3G
	 VVBgL7N0BATlOmKDfdxF1YotUmxntMMVy32Yujw7l6caOaNKPolZgbRNgmf0+nXeKu
	 QF+T1q+pK4WeV2/RO3vgEFNEydX52OuSsXSFDeK3aPtrxCvR9KMQhlPlQGDYG5U51T
	 5ixwZy61jhuQuXESj801hk4RsUvrxyuelm+gBkj9VmxOwI6McpupEv3dvys1BtidOC
	 7FLP8BANMbDaQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1662B3782089;
	Tue,  5 Mar 2024 21:11:20 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: boris.brezillon@collabora.com,
	steven.price@arm.com,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: adrian.larumbe@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 2/2] drm/panthor: Enable fdinfo for memory stats
Date: Tue,  5 Mar 2024 21:05:50 +0000
Message-ID: <20240305211000.659103-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305211000.659103-1-adrian.larumbe@collabora.com>
References: <20240305211000.659103-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When vm-binding an already-created BO, the entirety of its virtual size is
then backed by system memory, so its RSS is always the same as its virtual
size.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c |  1 +
 drivers/gpu/drm/panthor/panthor_gem.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index fa06b9e2c6cd..a5398e161f75 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1363,6 +1363,7 @@ static void panthor_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 
 	panthor_gpu_show_fdinfo(ptdev, file->driver_priv, p);
 
+	drm_show_memory_stats(p, file);
 }
 
 static const struct file_operations panthor_drm_driver_fops = {
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index d6483266d0c2..845724e3fd93 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -143,6 +143,17 @@ panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
 	return drm_gem_prime_export(obj, flags);
 }
 
+static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
+{
+	struct panthor_gem_object *bo = to_panthor_bo(obj);
+	enum drm_gem_object_status res = 0;
+
+	if (bo->base.pages)
+		res |= DRM_GEM_OBJECT_RESIDENT;
+
+	return res;
+}
+
 static const struct drm_gem_object_funcs panthor_gem_funcs = {
 	.free = panthor_gem_free_object,
 	.print_info = drm_gem_shmem_object_print_info,
@@ -152,6 +163,7 @@ static const struct drm_gem_object_funcs panthor_gem_funcs = {
 	.vmap = drm_gem_shmem_object_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = panthor_gem_mmap,
+	.status = panthor_gem_status,
 	.export = panthor_gem_prime_export,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
-- 
2.43.0


