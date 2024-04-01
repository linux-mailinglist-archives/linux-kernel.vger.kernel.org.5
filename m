Return-Path: <linux-kernel+bounces-126451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D81893840
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BE51F2134C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2178DDC5;
	Mon,  1 Apr 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wyv4u3HU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923DD30B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952029; cv=none; b=RlgYLGUUB+Yo5u4kNTLDcHtqWtH1poU9XjisuCoAIetkxKDHbUuHO0oLfsSefzILD+0fHbf4aFdfmAk64wbQxupSpEktLcKltgPMeLaG9QSFbE9ntSeXRRcT0DDNk7jjDagU7G/x4/mdZgNwjD/9NAkgno6k/66vDA9cjwLCQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952029; c=relaxed/simple;
	bh=gFJgio/5eXS8aESLqo8/x8ew3QqvRD78waKLy6A6rUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSkgdi4Y2kETK97GgoB+RFjqXjXZqH3NM1oKTpq9Ar7pCoI4aG1m5M8KS28AW96bKppudRqbVrza++4Or5Tynt0IQ5zOQvpElC2PI5crNvilfFhhkgFuMZ3jAm24Gt//vHyAE4vFqz+X8ahAxfM4bknaExYo5wo6PnvYnzUEmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wyv4u3HU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711952025;
	bh=gFJgio/5eXS8aESLqo8/x8ew3QqvRD78waKLy6A6rUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wyv4u3HUzb71kbVPhKH7Fi6dQBUDE3NHoFIwHhJu7TxB/FquQvYT36+9sPyzfSCZk
	 iY4ez7EjMGjKs/dY8CzItvWIC5fySUjl44Jg5QMMkFNFA0oPKw96An4sKr+XbeSebn
	 6xK7EG9m5V8eCW+64ga2BqtZQ5ioXCJOfEWClYtDTptnVliechG88ecTO9SbSVQOAS
	 dMzPNjEXhnsNU5Id6Gw3wQtfSr/040+V74SPujtR5ONWfX2IfGjNBAC7knjpyLEcaW
	 664TjULk05phHSRJdfnICGDut+wZhPfiQ0mAIFaaQVwPkGXKNNf7FSpJLJWij90fYZ
	 NYpu7B3Ki5vJQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3C698378212C;
	Mon,  1 Apr 2024 06:13:42 +0000 (UTC)
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
Subject: [PATCH v5 04/10] drm/ci: mediatek: Refactor existing mediatek jobs
Date: Mon,  1 Apr 2024 11:42:29 +0530
Message-Id: <20240401061235.192713-5-vignesh.raman@collabora.com>
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

For mediatek mt8173 and mt8183, the display driver is mediatek.
Currently, in drm-ci for mediatek, only the display driver is
tested. Refactor the existing mediatek jobs so that gpu driver
testing jobs can be added later and update xfails accordingly.
Since the correct driver name is passed from the job to test gpu
and display driver, remove the check to set IGT_FORCE_DRIVER
based on driver name.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Refactor the patch to rename job to indicate display driver testing,
    rename the existing xfail files, and remove IGT_FORCE_DRIVER from the
    script since it's now set by the job.

v3:
  - Add the job name in GPU_VERSION and use it for xfail file names instead
    of using DRIVER_NAME. Also update xfails.

v4:
  - Remove the display suffix in job and rename xfails accordingly.
    Remove the change adding job name in GPU_VERSION.

v5:
  - Add mediatek-display job.

---
 drivers/gpu/drm/ci/igt_runner.sh              | 10 ---------
 drivers/gpu/drm/ci/test.yml                   | 21 +++++++++++++++----
 .../drm/ci/xfails/mediatek-mt8173-fails.txt   | 15 -------------
 .../drm/ci/xfails/mediatek-mt8173-flakes.txt  | 13 ++++++++++++
 .../drm/ci/xfails/mediatek-mt8183-fails.txt   | 21 ++++++++++++-------
 .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |  8 +++++++
 6 files changed, 51 insertions(+), 37 deletions(-)
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt

diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index f1a08b9b146f..ce6e22369d4d 100755
--- a/drivers/gpu/drm/ci/igt_runner.sh
+++ b/drivers/gpu/drm/ci/igt_runner.sh
@@ -20,16 +20,6 @@ cat /sys/kernel/debug/dri/*/state
 set -e
 
 case "$DRIVER_NAME" in
-    rockchip|meson)
-        export IGT_FORCE_DRIVER="panfrost"
-        ;;
-    mediatek)
-        if [ "$GPU_VERSION" = "mt8173" ]; then
-            export IGT_FORCE_DRIVER=${DRIVER_NAME}
-        elif [ "$GPU_VERSION" = "mt8183" ]; then
-            export IGT_FORCE_DRIVER="panfrost"
-        fi
-        ;;
     amdgpu)
         # Cannot use HWCI_KERNEL_MODULES as at that point we don't have the module in /lib
         mv /install/modules/lib/modules/* /lib/modules/.
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 612c9ede3507..d8af670ee51d 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -282,14 +282,17 @@ amdgpu:stoney:
 .mediatek:
   extends:
     - .lava-igt:arm64
-  stage: mediatek
   variables:
-    DRIVER_NAME: mediatek
     DTB: ${DEVICE_TYPE}
     BOOT_METHOD: depthcharge
     KERNEL_IMAGE_TYPE: ""
 
-mediatek:mt8173:
+.mediatek-display:
+  stage: mediatek
+  variables:
+    DRIVER_NAME: mediatek
+
+.mt8173:
   extends:
     - .mediatek
   parallel: 4
@@ -298,7 +301,7 @@ mediatek:mt8173:
     GPU_VERSION: mt8173
     RUNNER_TAG: mesa-ci-x86-64-lava-mt8173-elm-hana
 
-mediatek:mt8183:
+.mt8183:
   extends:
     - .mediatek
   parallel: 3
@@ -307,6 +310,16 @@ mediatek:mt8183:
     GPU_VERSION: mt8183
     RUNNER_TAG: mesa-ci-x86-64-lava-mt8183-kukui-jacuzzi-juniper-sku16
 
+mediatek:mt8173:
+  extends:
+    - .mt8173
+    - .mediatek-display
+
+mediatek:mt8183:
+  extends:
+    - .mt8183
+    - .mediatek-display
+
 # drm-mtk doesn't even probe yet in mainline for mt8192
 .mediatek:mt8192:
   extends:
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
index ef0cb7c3698c..c63abd603b02 100644
--- a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
@@ -9,28 +9,13 @@ kms_bw@linear-tiling-3-displays-1920x1080p,Fail
 kms_bw@linear-tiling-3-displays-2560x1440p,Fail
 kms_bw@linear-tiling-3-displays-3840x2160p,Fail
 kms_color@invalid-gamma-lut-sizes,Fail
-kms_color@pipe-A-invalid-gamma-lut-sizes,Fail
-kms_color@pipe-B-invalid-gamma-lut-sizes,Fail
 kms_cursor_legacy@cursor-vs-flip-atomic,Fail
 kms_cursor_legacy@cursor-vs-flip-legacy,Fail
 kms_flip@flip-vs-modeset-vs-hang,Fail
 kms_flip@flip-vs-panning-vs-hang,Fail
 kms_flip@flip-vs-suspend,Fail
 kms_flip@flip-vs-suspend-interruptible,Fail
-kms_force_connector_basic@force-edid,Fail
-kms_force_connector_basic@force-load-detect,Fail
-kms_force_connector_basic@prune-stale-modes,Fail
-kms_hdmi_inject@inject-4k,Fail
-kms_plane_scaling@planes-upscale-20x20,Fail
-kms_plane_scaling@planes-upscale-20x20-downscale-factor-0-25,Fail
-kms_plane_scaling@planes-upscale-20x20-downscale-factor-0-5,Fail
-kms_plane_scaling@planes-upscale-20x20-downscale-factor-0-75,Fail
-kms_plane_scaling@upscale-with-modifier-20x20,Fail
-kms_plane_scaling@upscale-with-pixel-format-20x20,Fail
-kms_plane_scaling@upscale-with-rotation-20x20,Fail
 kms_properties@get_properties-sanity-atomic,Fail
 kms_properties@plane-properties-atomic,Fail
 kms_properties@plane-properties-legacy,Fail
 kms_rmfb@close-fd,Fail
-kms_selftest@drm_format,Timeout
-kms_selftest@drm_format_helper,Timeout
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
new file mode 100644
index 000000000000..64b30c092c85
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
@@ -0,0 +1,13 @@
+# Board Name: mt8173-elm-hana.dtb
+# Bug Report: https://lore.kernel.org/dri-devel/931e3f9a-9c5c-fc42-16fc-abaac4e0c0ff@collabora.com/T/#u
+# IGT Version: 1.28-gd2af13d9f
+# Failure Rate: 50
+# Linux Version: 6.7.0-rc3
+
+# Reported by deqp-runner
+kms_cursor_legacy@cursor-vs-flip-atomic-transitions
+
+# Below test shows inconsistency across multiple runs,
+# giving results of Pass and Timeout/Fail alternately
+kms_prop_blob@invalid-set-prop
+kms_prop_blob@invalid-set-prop-any
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
index 67d690fc4037..91cd1c4ec068 100644
--- a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
@@ -1,13 +1,18 @@
-kms_addfb_basic@addfb25-bad-modifier,Fail
+core_setmaster_vs_auth,Fail
+kms_bw@linear-tiling-1-displays-1920x1080p,Fail
 kms_bw@linear-tiling-1-displays-2560x1440p,Fail
+kms_bw@linear-tiling-1-displays-3840x2160p,Fail
 kms_bw@linear-tiling-2-displays-1920x1080p,Fail
 kms_bw@linear-tiling-2-displays-2560x1440p,Fail
 kms_bw@linear-tiling-2-displays-3840x2160p,Fail
-kms_bw@linear-tiling-3-displays-2560x1440p,Fail
-kms_bw@linear-tiling-3-displays-3840x2160p,Fail
-kms_color@pipe-A-invalid-gamma-lut-sizes,Fail
-kms_plane_cursor@overlay,Fail
-kms_plane_cursor@primary,Fail
-kms_plane_cursor@viewport,Fail
-kms_plane_scaling@upscale-with-rotation-20x20,Fail
+kms_color@invalid-gamma-lut-sizes,Fail
+kms_cursor_legacy@cursor-vs-flip-atomic,Fail
+kms_cursor_legacy@cursor-vs-flip-legacy,Fail
+kms_flip@flip-vs-modeset-vs-hang,Fail
+kms_flip@flip-vs-panning-vs-hang,Fail
+kms_flip@flip-vs-suspend,Fail
+kms_flip@flip-vs-suspend-interruptible,Fail
+kms_properties@get_properties-sanity-atomic,Fail
+kms_properties@plane-properties-atomic,Fail
+kms_properties@plane-properties-legacy,Fail
 kms_rmfb@close-fd,Fail
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
new file mode 100644
index 000000000000..5885a950fa72
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
@@ -0,0 +1,8 @@
+# Board Name: mt8183-kukui-jacuzzi-juniper-sku16.dtb
+# Bug Report: https://lore.kernel.org/dri-devel/931e3f9a-9c5c-fc42-16fc-abaac4e0c0ff@collabora.com/T/#u
+# IGT Version: 1.28-gd2af13d9f
+# Failure Rate: 100
+# Linux Version: 6.7.0-rc3
+
+# Reported by deqp-runner
+kms_cursor_legacy@cursor-vs-flip-atomic-transitions
-- 
2.40.1


