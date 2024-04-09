Return-Path: <linux-kernel+bounces-136424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C008089D3F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DBAB2424F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568817F464;
	Tue,  9 Apr 2024 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vQig3oWY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3047EF03
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650470; cv=none; b=cz6KyxvG4QlOTgyJcjnd5z7XTeQhTssTc37gIrW59J0RZ3HwEq1Dho+7JYR7v//PaifzzdD2xKdjJ4LBwQpowgaL00AXoed2X5zscDUuhZPIzXcFF6K0OFwkGM0osUKVTVF2l/GkdzwvkmQBIA1kVdRmxQUD0ydkjgGXp8H4ArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650470; c=relaxed/simple;
	bh=atnM7VrWweDiTimJjVrECjlnN7wKdVLuCzM5GU+yiqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJjqCAHNszXPEbiwUuTtGuD9wu8FSoL5sSknZCYbBdV01l0v+tMt4TvxHND5y3tN+Q3SPgEWDKWQ0Mbk2N9ZQHoQROABPAwYXBx9Id/2ClKC11olVjCAtHkZcUH3aUVOhXcN2KGNyzwtiHmeAzvgkQBw5rmqS7Ztg0IBCrqoDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vQig3oWY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712650466;
	bh=atnM7VrWweDiTimJjVrECjlnN7wKdVLuCzM5GU+yiqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQig3oWY4Bj3Pg/QxqCqhDvC1zTiL2AepmByfSA4VKaDiEBWzpVzuxouK9WpXbXZo
	 Qq7LKw52xN+tCXkDLw34LMZ5ovyyYMBV6oshb5hARPLynV94aJtEtnQZ1Wca2+YWRX
	 F6n0GTWmvIQe2J1+dc0lU3zUJnk7zoRUuSZmpsT9cgS1Oih1OOdcUT1asqzy4DbVj7
	 18nutYytA1W56cAqCX5n3f5lGNEXkGxjKm8IkSnmhZG1NQtJp4AIen6voDjoo1YnLQ
	 Vw2FORAjVKy2VQEq3FSxAx4bj0NTnsaavAYT8u71j7B/KdI9dGMrimuNAo7CWrKw17
	 pOVjcD7GgsrdQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3168137820EE;
	Tue,  9 Apr 2024 08:14:23 +0000 (UTC)
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
Subject: [PATCH v6 2/8] drm/ci: uprev mesa version
Date: Tue,  9 Apr 2024 13:43:23 +0530
Message-Id: <20240409081329.472463-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409081329.472463-1-vignesh.raman@collabora.com>
References: <20240409081329.472463-1-vignesh.raman@collabora.com>
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

Also copy helper scripts to install, so that the ci jobs can
use these scripts for logging.

Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v3:
  - New patch in series to uprev mesa.

v4:
  - Fix checkpatch warning.

v5:
  - Copy helper scripts to install, so that the ci jobs can
    use these scripts for logging.

v6:
  - No changes.

---
 drivers/gpu/drm/ci/build.sh       |  1 +
 drivers/gpu/drm/ci/container.yml  |  6 +++---
 drivers/gpu/drm/ci/gitlab-ci.yml  | 11 ++++++++---
 drivers/gpu/drm/ci/image-tags.yml |  3 ++-
 drivers/gpu/drm/ci/test.yml       |  2 ++
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index 106f2d40d222..8a3baa003904 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -128,6 +128,7 @@ fi
 # Pass needed files to the test stage
 mkdir -p install
 cp -rfv .gitlab-ci/* install/.
+cp -rfv ci/*  install/.
 cp -rfv install/common install/ci-common
 cp -rfv drivers/gpu/drm/ci/* install/.
 
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
index 084e3ff8e3f4..2f9a5e217f5c 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -1,6 +1,6 @@
 variables:
   DRM_CI_PROJECT_PATH: &drm-ci-project-path mesa/mesa
-  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 9d162de9a05155e1c4041857a5848842749164cf
+  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha c4b32f9e90b7204735e6adf1f60c178bf85752e7
 
   UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
   TARGET_BRANCH: drm-next
@@ -26,10 +26,13 @@ variables:
   JOB_ARTIFACTS_BASE: ${PIPELINE_ARTIFACTS_BASE}/${CI_JOB_ID}
   # default kernel for rootfs before injecting the current kernel tree
   KERNEL_REPO: "gfx-ci/linux"
-  KERNEL_TAG: "v6.6.4-for-mesa-ci-e4f4c500f7fb"
+  KERNEL_TAG: "v6.6.13-mesa-9916"
   KERNEL_IMAGE_BASE: https://${S3_HOST}/mesa-lava/${KERNEL_REPO}/${KERNEL_TAG}
   LAVA_TAGS: subset-1-gfx
   LAVA_JOB_PRIORITY: 30
+  ARTIFACTS_BASE_URL: https://${CI_PROJECT_ROOT_NAMESPACE}.${CI_PAGES_DOMAIN}/-/${CI_PROJECT_NAME}/-/jobs/${CI_JOB_ID}/artifacts
+  # Python scripts for structured logger
+  PYTHONPATH: "$PYTHONPATH:$CI_PROJECT_DIR/install"
 
 default:
   before_script:
@@ -46,6 +49,7 @@ default:
     - cd $CI_PROJECT_DIR
     - curl --output - $DRM_CI_PROJECT_URL/-/archive/$DRM_CI_COMMIT_SHA/mesa-$DRM_CI_COMMIT_SHA.tar.gz | tar -xz
     - mv mesa-$DRM_CI_COMMIT_SHA/.gitlab-ci* .
+    - mv mesa-$DRM_CI_COMMIT_SHA/bin/ci .
     - rm -rf mesa-$DRM_CI_COMMIT_SHA/
     - echo -e "\e[0Ksection_end:$(date +%s):drm_ci_download_section\r\e[0K"
 
@@ -98,6 +102,7 @@ include:
 stages:
   - sanity
   - container
+  - code-validation
   - git-archive
   - build
   - amdgpu
@@ -107,7 +112,6 @@ stages:
   - msm
   - rockchip
   - virtio-gpu
-  - lint
 
 # YAML anchors for rule conditions
 # --------------------------------
@@ -218,6 +222,7 @@ make git archive:
   script:
     # Remove drm-ci files we just added
     - rm -rf .gitlab-ci.*
+    - rm -rf ci
 
     # Compactify the .git directory
     - git gc --aggressive
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
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 8bc63912fddb..612c9ede3507 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -150,6 +150,8 @@ msm:sdm845:
     BM_KERNEL: https://${PIPELINE_ARTIFACTS_BASE}/arm64/cheza-kernel
     GPU_VERSION: sdm845
     RUNNER_TAG: google-freedreno-cheza
+    DEVICE_TYPE: sdm845-cheza-r3
+    FARM: google
   script:
     - ./install/bare-metal/cros-servo.sh
 
-- 
2.40.1


