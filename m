Return-Path: <linux-kernel+bounces-93270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AE4872D54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5881F2360C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D32D1B593;
	Wed,  6 Mar 2024 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e9hMU3E1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F481B7E4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694498; cv=none; b=PYLTQIzWePW66Wj0W+gnaQOdzCEdRRRJ4s18a7Wrj8Is8Ig8TI4NjT+ceDgA8UxCAOPNDV/mCo1rccv93KS3o1yKKyXyU6ID+znGNmQ/qMFVW/iiKWB221ATdP7BTvx+/E+LGP57zt/EOPln8cy6xDKsf8CDQEy6EWawVE73nOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694498; c=relaxed/simple;
	bh=IOOplzt3a+1WgBxTkdTD5u+hoOWtgBCavIFPsM/LyC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3onfBKk9f1xOMX2gLe7W7mU/8nmPe/sQlrY3/15hZB55hbXvxSfjlP1ftAKT0h3nEz416+tWlq5AxUfBq+vf0zZ5ayjj2o2BcEK6383q+YZCiphWRMoqwUv4jVlHSEinGRk4iWpyxJbUnOjBaeIBYVIO4mktdjv1Exgjvdx9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e9hMU3E1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709694495;
	bh=IOOplzt3a+1WgBxTkdTD5u+hoOWtgBCavIFPsM/LyC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9hMU3E11256A4vuSkZ4g8oJ540xjnNbvfynsgXvr9t8YLbvy77UQe6ykYI9JOLam
	 I4/EA5y9Dlrg79y8U6/e7jZDwGceCB6Clfl+e+peie5f+FC1o/sSJoZDbfyh/g6Fa5
	 eZifoUsgR+aeDeKfWCrKf1l+2sEewBCq0XMa9fVyRme5O0+l9/OT1mr0IfLu5o8Goo
	 paxB1aAjMrehDp6Qs2TNc7nwHM0j8JRhsBPWfM/i9yP4z/B4SrxYBNSVBN6voCVhV1
	 Zt6oyobWu1NaRylKkl3/HxoWCnY8L51pQbiJzc/ZAiAHSgjhtWedeJI4/32wr+dBP2
	 mhd+kOs49d7pg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 451A337820C6;
	Wed,  6 Mar 2024 03:08:11 +0000 (UTC)
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
Subject: [PATCH v4 05/11] drm/ci: mediatek: Refactor existing mediatek jobs
Date: Wed,  6 Mar 2024 08:36:43 +0530
Message-Id: <20240306030649.60269-6-vignesh.raman@collabora.com>
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

---
 drivers/gpu/drm/ci/igt_runner.sh              | 10 ---------
 drivers/gpu/drm/ci/test.yml                   | 21 ++++++++++++++-----
 .../drm/ci/xfails/mediatek-mt8173-fails.txt   | 15 -------------
 .../drm/ci/xfails/mediatek-mt8173-flakes.txt  | 13 ++++++++++++
 .../drm/ci/xfails/mediatek-mt8183-fails.txt   | 21 ++++++++++++-------
 .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |  8 +++++++
 6 files changed, 50 insertions(+), 38 deletions(-)
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt

diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index 77cd81fe6d1a..711f32772e48 100755
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
index 0857773e5c5f..f8f48523ada3 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -282,29 +282,40 @@ amdgpu:stoney:
     - .lava-igt:arm64
   stage: mediatek
   variables:
-    DRIVER_NAME: mediatek
     DTB: ${DEVICE_TYPE}
     BOOT_METHOD: depthcharge
     KERNEL_IMAGE_TYPE: ""
 
-mediatek:mt8173:
+.mt8173:
   extends:
     - .mediatek
   parallel: 4
   variables:
     DEVICE_TYPE: mt8173-elm-hana
-    GPU_VERSION: mt8173
     RUNNER_TAG: mesa-ci-x86-64-lava-mt8173-elm-hana
 
-mediatek:mt8183:
+.mt8183:
   extends:
     - .mediatek
   parallel: 3
   variables:
     DEVICE_TYPE: mt8183-kukui-jacuzzi-juniper-sku16
-    GPU_VERSION: mt8183
     RUNNER_TAG: mesa-ci-x86-64-lava-mt8183-kukui-jacuzzi-juniper-sku16
 
+mediatek:mt8173:
+  extends:
+    - .mt8173
+  variables:
+    GPU_VERSION: mt8173
+    DRIVER_NAME: mediatek
+
+mediatek:mt8183:
+  extends:
+    - .mt8183
+  variables:
+    GPU_VERSION: mt8183
+    DRIVER_NAME: mediatek
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
index 67d690fc4037..28c825c9cd60 100644
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
+kms_prop_blob@invalid-set-prop-any,Fail
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


