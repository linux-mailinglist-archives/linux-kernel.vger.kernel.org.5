Return-Path: <linux-kernel+bounces-155929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604068AF8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E6DB244B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D931442F3;
	Tue, 23 Apr 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KjjcZVg6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC1143C47
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908015; cv=none; b=ZAys3rxf6YsELMmYDZzhwjl6Rr4WwdeuVc09AmZGrPSDpJSaJZuRQ3TLivxC5hy7/3hrEdB/6CRz/wvbnryiEyS23UnnSPOo1Ta3bJVOebphJV0Zdn1PmY7ldb7sjX3XeFVtqr+4zO3kigIXmaTUcG5Kcg5KsgEcviZmy62xa2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908015; c=relaxed/simple;
	bh=WTSDOsANVORGkRoRiiItlqmB10yYEFCjydCZuf55SdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sctLngzM7a8Tbjq7P8s9GDfTTkbNmbXIsDmFzr60altvO+ssIvMMdhZpynLJa/YYK1OavMMSD5fRiNJ9UsEgFYKpFjcfKu8VGxh/O646PWKodp4mHSsxKfsIBl/dAM+GTiX/IPpIzMO2PtAmdydrDi5xoM2p/UEtg/FR+U8dC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KjjcZVg6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713908010;
	bh=WTSDOsANVORGkRoRiiItlqmB10yYEFCjydCZuf55SdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KjjcZVg6Qmz/d19GHkqM09gbMVElPzwbC7mayziwjkbkKOvnAkCX1w2ywQOpCJ7Ze
	 yzC3IbITJaRC5lQoJqAmkY5D8jfdN/OqUiMY++qgCJDLFPyVQbtAgHPceptebE1eMs
	 0lkts5DDQWGr5hU50dBuZzEdV3mGdVNYqNM71v9PbFNai0UV0Z8zFWWhRlbZR1dEEJ
	 dqODXIwH9Z4iWz1qEgOaGRWeOCDmZNxbRaZfaNHKpu/yHO4hbfSEP9hu54e+Bztwif
	 Ga/pQ7LZ56RPuAjAuq1aIBxAUJkUk55PCXIDE5ulWEPzv33fc6I3kCye8oRZ3XbZWl
	 E71rRtk4uKVTQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 18AB13782142;
	Tue, 23 Apr 2024 21:33:30 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	Adrian Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/panthor: Enable fdinfo for memory stats
Date: Tue, 23 Apr 2024 22:32:36 +0100
Message-ID: <20240423213240.91412-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213240.91412-1-adrian.larumbe@collabora.com>
References: <20240423213240.91412-1-adrian.larumbe@collabora.com>
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

Also, we consider a PRIME imported BO to be resident if its matching
dma_buf has an open attachment, which means its backing storage had already
been allocated.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index d6483266d0c2..386c0dfeeb5f 100644
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
+	if (bo->base.base.import_attach || bo->base.pages)
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
2.44.0


