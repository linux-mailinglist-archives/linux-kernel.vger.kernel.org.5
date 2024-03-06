Return-Path: <linux-kernel+bounces-93267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C244872D4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05A328CF6D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B02101C4;
	Wed,  6 Mar 2024 03:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W5td+ZMn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3118641
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694485; cv=none; b=NkUe9OiGHeIpMY53LcC9jzXCY6HjbksBnciAptdSId+90vq9RCy52Hc8GbOz5+wBXf0tOcPyDX4rjFjg5/7KFSfxhJ8fISHsHC9W2OfcuXrfCevmWAXwX4iT6L2G9VQjV+3RlOnJYpnu8AXFqfwXH03tO5UEOPHwWWgxgfCPAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694485; c=relaxed/simple;
	bh=9AGshVuqfSUV9LWFEfpfaYudsukU+NAf/iov2knBx5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NOogm8l5OksCBx4DPhOaHImeit9je+vaN4iuKqZXsxVaQKB2Q3l63eGh79sNA+cj/v3cwjmQ4Z9UT91ZXAEy3ZZG4u4v/VdUHGde88BZ0PH3lHyn5ZsGKGR31vRVh1MrjgHPWnPbb04Q8teWw8qAsx2bbAHNg5acECeRN0pqxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W5td+ZMn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709694482;
	bh=9AGshVuqfSUV9LWFEfpfaYudsukU+NAf/iov2knBx5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5td+ZMnJ99xZ4wzKC9CQIT+HA3Vv5TEQPOaP2PiO6wxmyDYOMrJ08abn1VwISo4F
	 yg03jDUcuqAsec4uhqBTrpVrjiqYL7rQM5/dVYHwFuAjR8gUJl4OQrtvBLOrEqc3pw
	 kFgECyZMLKL0LTXGKdvSYQBVgQGVDiBWgyfccbl7b2jN5btMiXK7b1slbUd8KdtgIn
	 m5wjONcI1YegVnrl3UbIP+no+h+mDHD4/Ta6MZnwO+cjrt7xsNZ3pqZEbf5g3V+1e+
	 lehcGURz2bvqfiAbQfHwlPGk+05xv60imIiP7EGM/qliBRfUUaSjLXX4FqU7WIRyMQ
	 fF6vdJwT1wfBw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4CE8437820C6;
	Wed,  6 Mar 2024 03:07:58 +0000 (UTC)
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
Subject: [PATCH v4 02/11] drm/ci: uprev mesa version
Date: Wed,  6 Mar 2024 08:36:40 +0530
Message-Id: <20240306030649.60269-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240306030649.60269-1-vignesh.raman@collabora.com>
References: <20240306030649.60269-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zlib.net is not allowing tarball download anymore and results
in below error in kernel+rootfs_arm32 container build,
urllib.error.HTTPError: HTTP Error 403: Forbidden
urllib.error.HTTPError: HTTP Error 415: Unsupported Media Type

Uprev mesa which includes a fix for this issue.
https://gitlab.freedesktop.org/mesa/mesa/-/commit/908f444e

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v3:
  - New patch in series to uprev mesa.

v4:
  - Fix checkpatch warning.

---
 drivers/gpu/drm/ci/container.yml  | 6 +++---
 drivers/gpu/drm/ci/gitlab-ci.yml  | 6 +++---
 drivers/gpu/drm/ci/image-tags.yml | 3 ++-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ci/container.yml b/drivers/gpu/drm/ci/container.yml
index 9764e7921a4f..1060eb380b02 100644
--- a/drivers/gpu/drm/ci/container.yml
+++ b/drivers/gpu/drm/ci/container.yml
@@ -40,11 +40,11 @@ debian/x86_64_test-android:
   rules:
     - when: never
 
-windows_build_vs2019:
+windows_build_msvc:
   rules:
     - when: never
 
-windows_test_vs2019:
+windows_test_msvc:
   rules:
     - when: never
 
@@ -56,7 +56,7 @@ rustfmt:
    rules:
     - when: never
 
-windows_vs2019:
+windows_msvc:
    rules:
     - when: never
 
diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 084e3ff8e3f4..bc8cb3420476 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -1,6 +1,6 @@
 variables:
   DRM_CI_PROJECT_PATH: &drm-ci-project-path mesa/mesa
-  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 9d162de9a05155e1c4041857a5848842749164cf
+  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha c4b32f9e90b7204735e6adf1f60c178bf85752e7
 
   UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
   TARGET_BRANCH: drm-next
@@ -26,7 +26,7 @@ variables:
   JOB_ARTIFACTS_BASE: ${PIPELINE_ARTIFACTS_BASE}/${CI_JOB_ID}
   # default kernel for rootfs before injecting the current kernel tree
   KERNEL_REPO: "gfx-ci/linux"
-  KERNEL_TAG: "v6.6.4-for-mesa-ci-e4f4c500f7fb"
+  KERNEL_TAG: "v6.6.13-mesa-9916"
   KERNEL_IMAGE_BASE: https://${S3_HOST}/mesa-lava/${KERNEL_REPO}/${KERNEL_TAG}
   LAVA_TAGS: subset-1-gfx
   LAVA_JOB_PRIORITY: 30
@@ -98,6 +98,7 @@ include:
 stages:
   - sanity
   - container
+  - code-validation
   - git-archive
   - build
   - amdgpu
@@ -107,7 +108,6 @@ stages:
   - msm
   - rockchip
   - virtio-gpu
-  - lint
 
 # YAML anchors for rule conditions
 # --------------------------------
diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/image-tags.yml
index 7ab4f2514da8..cf07c3e09b8c 100644
--- a/drivers/gpu/drm/ci/image-tags.yml
+++ b/drivers/gpu/drm/ci/image-tags.yml
@@ -1,5 +1,5 @@
 variables:
-   CONTAINER_TAG: "2023-10-11-mesa-uprev"
+   CONTAINER_TAG: "2022-01-29-mesa-uprev"
    DEBIAN_X86_64_BUILD_BASE_IMAGE: "debian/x86_64_build-base"
    DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
 
@@ -7,6 +7,7 @@ variables:
    DEBIAN_BUILD_TAG: "2023-10-08-config"
 
    KERNEL_ROOTFS_TAG: "2023-10-06-amd"
+   PKG_REPO_REV: "67f2c46b"
 
    DEBIAN_X86_64_TEST_BASE_IMAGE: "debian/x86_64_test-base"
    DEBIAN_X86_64_TEST_IMAGE_GL_PATH: "debian/x86_64_test-gl"
-- 
2.40.1


