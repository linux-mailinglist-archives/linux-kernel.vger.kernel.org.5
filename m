Return-Path: <linux-kernel+bounces-126453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C0893842
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD961F212E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36041B663;
	Mon,  1 Apr 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LdXkbIG1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA508107B2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952036; cv=none; b=UjFO/nDGvH+KzfbHrL0RaV/azLMhQN8bqiqISQD2xCXpjuVt91rXYqlrE3EwYxnXUSzAil+RG5AdrY4mnoJpuv9peRskysWa2kRr67gkzbQnY7+3dH/P/Hr7zou7Un1A5pAVNR1tn6kUnt5LvFyCum/c8nXHIG947ACHf3JdXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952036; c=relaxed/simple;
	bh=Y/EJnUT9W3b2YTtHw5yO6M6zWXCKTBILu7zeL6ZvtDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCYEGnz9RI759HB02EAXWz4FDHlIgA8KMt8iD2Iaa9Scc42KBUpYa/nHPEVN5zpJ6yUdzY0u/Er9b1Kwsu66NMZ2K1XinQzgogZ9NJp/KX/BPKLEO9haloaMaaS8wwiNjeO2k+Blka7Bkb7RuDm4ttIH9YELKHGSobipa9BFL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LdXkbIG1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711952033;
	bh=Y/EJnUT9W3b2YTtHw5yO6M6zWXCKTBILu7zeL6ZvtDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdXkbIG1CXWG/t+z1iz4X9AtEdosfEjdupCYrnwi7vJxfBApp35FlkXVZ1X/n8Y/L
	 QhXdM2aeo3DI7NpznPD82l6nCkbYlHIviuMs+LVUzvZragB57bZN6Q+mF7/C7iO8+Q
	 E1Dom4fT4jes1nGDFWLwkQ6Uuw9tr3BlRv+wRGIzlu72nfR/YdZpnoc6s61thepbzC
	 /Bf8D/NDjSNr6crLDFWqH8P2zE7BpRdZMNB9MuZPvov+KZY7uZraSGQjF7YP8Hix5l
	 BGb1gIUn+bD762TImY9vYFyZY02jmjVa3B4G9Iw7FdiM/Rq2dhq7jvazB9zzdHQzTr
	 jLnhRp7Of4i7g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D8C123781360;
	Mon,  1 Apr 2024 06:13:49 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	emma@anholt.net,
	robdclark@gmail.com,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	hamohammed.sa@gmail.com,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	mairacanal@riseup.net,
	mcanal@igalia.com,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/10] drm/ci: meson: Refactor existing meson jobs
Date: Mon,  1 Apr 2024 11:42:31 +0530
Message-Id: <20240401061235.192713-7-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240401061235.192713-1-vignesh.raman@collabora.com>
References: <20240401061235.192713-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Amlogic Meson SOC the display driver is meson. Currently,
in drm-ci for meson, only the display driver is tested.
Refactor the existing meson jobs so that gpu driver testing
jobs can be added later and update xfails accordingly.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Refactor the patch to rename job to indicate display driver testing,
    rename the existing xfail files.

v3:
  - Add the job name in GPU_VERSION and use it for xfail file names instead
    of using DRIVER_NAME.

v4:
  - Remove the display suffix in job and rename xfails accordingly.
    Remove the change adding job name in GPU_VERSION.

v5:
  - Add meson-display job.

---
 drivers/gpu/drm/ci/test.yml                    | 14 +++++++++++---
 drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt |  5 -----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index adeb05bdb440..505733069995 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -357,14 +357,17 @@ panfrost:mt8183:
 .meson:
   extends:
     - .lava-igt:arm64
-  stage: meson
   variables:
-    DRIVER_NAME: meson
     DTB: ${DEVICE_TYPE}
     BOOT_METHOD: u-boot
     KERNEL_IMAGE_TYPE: "image"
 
-meson:g12b:
+.meson-display:
+  stage: meson
+  variables:
+    DRIVER_NAME: meson
+
+.g12b:
   extends:
     - .meson
   parallel: 3
@@ -373,6 +376,11 @@ meson:g12b:
     GPU_VERSION: g12b
     RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
 
+meson:g12b:
+  extends:
+    - .g12b
+    - .meson-display
+
 virtio_gpu:none:
   stage: virtio-gpu
   variables:
diff --git a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt b/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
index 56a2ae7047b4..029b4ade21f6 100644
--- a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
@@ -5,11 +5,6 @@ kms_cursor_legacy@single-bo,Fail
 kms_cursor_legacy@single-move,Fail
 kms_cursor_legacy@torture-bo,Fail
 kms_cursor_legacy@torture-move,Fail
-kms_force_connector_basic@force-edid,Fail
-kms_hdmi_inject@inject-4k,Fail
-kms_plane_cursor@overlay,Fail
-kms_plane_cursor@primary,Fail
-kms_plane_cursor@viewport,Fail
 kms_properties@connector-properties-atomic,Fail
 kms_properties@connector-properties-legacy,Fail
 kms_properties@get_properties-sanity-atomic,Fail
-- 
2.40.1


