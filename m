Return-Path: <linux-kernel+bounces-136429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C6589D3F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C516F1C21EA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C67E783;
	Tue,  9 Apr 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MV2n6VXy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E880028
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650490; cv=none; b=Yyr5JLN7yyKlO35Hc5mpTIRxny/yCPQQ+/siz4SxQN5ReyXd3DT96CHPBEnIkS9nJ+3sMDHPOJcDgbTE9cDxna2ivESvW+RarZEO9m4Ev0nahFN1sb7IMNxGj5WS289/f9im0yP/hE8IA+97m5uNKrC7ZuQx2OaIEiYmFFLxw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650490; c=relaxed/simple;
	bh=myg+rJGKzDzUq3HGuP9WcyNPU0FNUmcZxqkQzmD7zD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPZ1zUtAhhN+ku9lUSCH8JQfklYkFTYjb4GVBnyxOtWjj9nxTtDU+4YvNy2mc4Q51hk0k8j5XKytXDckN2xTPamMNDciC7RMBFGWm9oOegg75o3ftyfmVTByII7AQPGBht0595a4sphe1qtc23nBUnOBKq590cqvUe34iPzYJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MV2n6VXy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712650487;
	bh=myg+rJGKzDzUq3HGuP9WcyNPU0FNUmcZxqkQzmD7zD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MV2n6VXyCEwymLeR8ylBWjcSt2o8ulfY+917gmfyfgaVukBNqjRa1UBYm1TaFGQ9c
	 ERmjekmbI6RkzjUkpvhO6zuLsSaxcXu1s/EIABPPeMtwZdEMkyTq7pv/6pNMAIAnk0
	 3mbmsGD0Cykwfs/PxWS68DlRoiqywahg9kZca9bu/WvbXMXeBLxITTBKpIYVXfWnjT
	 JEzBNMGkteBeu1/IOOs5KMry08hE40tWS8VGOmxQOoqXn8oylf4Xq7EWHgXQ9qEcTq
	 mxPA3mMuJ49kyNbdbQ03yc8Rr2lvp0Tw3NMM+IUJFUpTzyy6VBmRm8ksGSOefFaocp
	 YzI0cn/szombg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 854BD37820F8;
	Tue,  9 Apr 2024 08:14:43 +0000 (UTC)
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
Subject: [PATCH v6 7/8] drm/ci: rockchip: add tests for rockchip display driver
Date: Tue,  9 Apr 2024 13:43:28 +0530
Message-Id: <20240409081329.472463-8-vignesh.raman@collabora.com>
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

For rockchip rk3288 and rk3399, the display driver is rockchip
and gpu driver is panfrost. Currently, in drm-ci for rockchip
rk3288 and rk3399, only the gpu driver is tested. Refactor
the existing rockchip jobs to test both display and gpu driver
and update xfails.

Since the correct driver name is passed from the job to test gpu
and display driver, remove the check to set IGT_FORCE_DRIVER
based on driver name for rockchip jobs.

Skip kms tests for panfrost driver since it is not a kms driver and
skip driver-specific tests.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Refactor the patch to rename job to indicate display driver testing,
    rename the existing xfail files.

v3:
  - Add the job name in GPU_VERSION and use it for xfail file names
    instead of using DRIVER_NAME. Also update xfails.

v4:
  - Remove the display suffix in job and rename xfails accordingly.
    Remove the change adding job name in GPU_VERSION.

v5:
  - Add rockchip-display job and skip driver-specfic tests.

v6:
  - Squash commits for display and gpu driver testing. Reword the commit message.

---
 drivers/gpu/drm/ci/igt_runner.sh              |  3 --
 drivers/gpu/drm/ci/test.yml                   | 48 ++++++++++++++-----
 .../drm/ci/xfails/panfrost-rk3288-fails.txt   |  1 +
 .../drm/ci/xfails/panfrost-rk3288-skips.txt   |  8 ++++
 .../drm/ci/xfails/panfrost-rk3399-fails.txt   |  1 +
 .../drm/ci/xfails/panfrost-rk3399-skips.txt   |  8 ++++
 .../drm/ci/xfails/rockchip-rk3288-fails.txt   | 35 --------------
 .../drm/ci/xfails/rockchip-rk3288-flakes.txt  | 21 ++++++++
 .../drm/ci/xfails/rockchip-rk3288-skips.txt   |  7 +++
 .../drm/ci/xfails/rockchip-rk3399-fails.txt   | 30 ++----------
 .../drm/ci/xfails/rockchip-rk3399-flakes.txt  | 28 +++++++++--
 .../drm/ci/xfails/rockchip-rk3399-skips.txt   |  5 ++
 12 files changed, 115 insertions(+), 80 deletions(-)
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt

diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index 1762b8870948..ce6e22369d4d 100755
--- a/drivers/gpu/drm/ci/igt_runner.sh
+++ b/drivers/gpu/drm/ci/igt_runner.sh
@@ -20,9 +20,6 @@ cat /sys/kernel/debug/dri/*/state
 set -e
 
 case "$DRIVER_NAME" in
-    rockchip)
-        export IGT_FORCE_DRIVER="panfrost"
-        ;;
     amdgpu)
         # Cannot use HWCI_KERNEL_MODULES as at that point we don't have the module in /lib
         mv /install/modules/lib/modules/* /lib/modules/.
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index a453876509e9..02d6779c456d 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -155,33 +155,57 @@ msm:sdm845:
   script:
     - ./install/bare-metal/cros-servo.sh
 
-rockchip:rk3288:
-  extends:
-    - .lava-igt:arm32
+.rockchip-device:
+  variables:
+    DTB: ${DEVICE_TYPE}
+    BOOT_METHOD: depthcharge
+
+.rockchip-display:
   stage: rockchip
   variables:
     DRIVER_NAME: rockchip
+
+.rk3288:
+  extends:
+    - .lava-igt:arm32
+    - .rockchip-device
+  variables:
     DEVICE_TYPE: rk3288-veyron-jaq
-    DTB: ${DEVICE_TYPE}
-    BOOT_METHOD: depthcharge
-    KERNEL_IMAGE_TYPE: "zimage"
     GPU_VERSION: rk3288
+    KERNEL_IMAGE_TYPE: "zimage"
     RUNNER_TAG: mesa-ci-x86-64-lava-rk3288-veyron-jaq
 
-rockchip:rk3399:
+.rk3399:
   extends:
     - .lava-igt:arm64
-  stage: rockchip
+    - .rockchip-device
   parallel: 2
   variables:
-    DRIVER_NAME: rockchip
     DEVICE_TYPE: rk3399-gru-kevin
-    DTB: ${DEVICE_TYPE}
-    BOOT_METHOD: depthcharge
-    KERNEL_IMAGE_TYPE: ""
     GPU_VERSION: rk3399
+    KERNEL_IMAGE_TYPE: ""
     RUNNER_TAG: mesa-ci-x86-64-lava-rk3399-gru-kevin
 
+rockchip:rk3288:
+  extends:
+    - .rk3288
+    - .rockchip-display
+
+panfrost:rk3288:
+  extends:
+    - .rk3288
+    - .panfrost-gpu
+
+rockchip:rk3399:
+  extends:
+    - .rk3399
+    - .rockchip-display
+
+panfrost:rk3399:
+  extends:
+    - .rk3399
+    - .panfrost-gpu
+
 .i915:
   extends:
     - .lava-igt:x86_64
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
new file mode 100644
index 000000000000..abd35a8ef6f4
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
@@ -0,0 +1 @@
+panfrost_prime@gem-prime-import,Crash
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
new file mode 100644
index 000000000000..41a846a59644
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
@@ -0,0 +1,8 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
+
+# Skip driver specific tests
+msm_.*
+^amdgpu.*
+v3d_.*
+vc4_.*
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
new file mode 100644
index 000000000000..6f5e760d5ec0
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
@@ -0,0 +1 @@
+panfrost_prime@gem-prime-import,Fail
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
new file mode 100644
index 000000000000..41a846a59644
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
@@ -0,0 +1,8 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
+
+# Skip driver specific tests
+msm_.*
+^amdgpu.*
+v3d_.*
+vc4_.*
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
index 282817a22cf8..80c23ca3d79d 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
@@ -1,55 +1,20 @@
 kms_3d,Crash
 kms_bw@linear-tiling-2-displays-1920x1080p,Fail
 kms_bw@linear-tiling-2-displays-2560x1440p,Fail
-kms_bw@linear-tiling-2-displays-3840x2160p,Fail
 kms_bw@linear-tiling-3-displays-1920x1080p,Fail
-kms_bw@linear-tiling-3-displays-2560x1440p,Fail
-kms_bw@linear-tiling-3-displays-3840x2160p,Fail
 kms_flip@flip-vs-modeset-vs-hang,Crash
 kms_flip@flip-vs-panning-vs-hang,Crash
-kms_force_connector_basic@force-load-detect,Fail
 kms_invalid_mode@int-max-clock,Crash
 kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Crash
 kms_pipe_crc_basic@nonblocking-crc-frame-sequence,Crash
 kms_pipe_crc_basic@read-crc-frame-sequence,Crash
 kms_plane@pixel-format,Crash
 kms_plane@pixel-format-source-clamping,Crash
-kms_plane@plane-position-hole,Crash
-kms_plane@plane-position-hole-dpms,Crash
 kms_plane_cursor@overlay,Crash
-kms_plane_cursor@pipe-A-overlay-size-128,Fail
-kms_plane_cursor@pipe-A-overlay-size-256,Fail
-kms_plane_cursor@pipe-A-overlay-size-64,Fail
-kms_plane_cursor@pipe-A-primary-size-128,Fail
-kms_plane_cursor@pipe-A-primary-size-256,Fail
-kms_plane_cursor@pipe-A-primary-size-64,Fail
-kms_plane_cursor@pipe-A-viewport-size-128,Fail
-kms_plane_cursor@pipe-A-viewport-size-256,Fail
-kms_plane_cursor@pipe-A-viewport-size-64,Fail
-kms_plane_cursor@pipe-B-overlay-size-128,Fail
-kms_plane_cursor@pipe-B-overlay-size-256,Fail
-kms_plane_cursor@pipe-B-overlay-size-64,Fail
-kms_plane_cursor@pipe-B-primary-size-128,Fail
-kms_plane_cursor@pipe-B-primary-size-256,Fail
-kms_plane_cursor@pipe-B-primary-size-64,Fail
-kms_plane_cursor@pipe-B-viewport-size-128,Fail
-kms_plane_cursor@pipe-B-viewport-size-256,Fail
-kms_plane_cursor@pipe-B-viewport-size-64,Fail
 kms_plane_cursor@primary,Crash
 kms_plane_cursor@viewport,Crash
-kms_plane_lowres@tiling-none,Fail
-kms_plane_scaling@downscale-with-modifier-factor-0-25,Fail
-kms_plane_scaling@downscale-with-rotation-factor-0-25,Fail
-kms_plane_scaling@upscale-with-modifier-20x20,Fail
-kms_plane_scaling@upscale-with-modifier-factor-0-25,Fail
-kms_plane_scaling@upscale-with-pixel-format-20x20,Fail
-kms_plane_scaling@upscale-with-pixel-format-factor-0-25,Fail
-kms_plane_scaling@upscale-with-rotation-20x20,Fail
-kms_prime@basic-crc,Fail
 kms_properties@connector-properties-atomic,Crash
 kms_properties@connector-properties-legacy,Crash
 kms_properties@get_properties-sanity-atomic,Crash
 kms_properties@get_properties-sanity-non-atomic,Crash
 kms_rmfb@close-fd,Crash
-kms_setmode@invalid-clone-single-crtc,Crash
-panfrost_prime@gem-prime-import,Crash
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
new file mode 100644
index 000000000000..f1f22e8aecd3
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
@@ -0,0 +1,21 @@
+# Board Name: rk3288-veyron-jaq.dtb
+# Bug Report: https://lore.kernel.org/dri-devel/bdb53650-1888-30b8-93ee-2290d020af4a@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-gd2af13d9f
+# Linux Version: 6.7.0-rc3
+
+# Reported by deqp-runner
+kms_cursor_crc@cursor-offscreen-64x21
+kms_cursor_legacy@flip-vs-cursor-legacy
+kms_cursor_legacy@flip-vs-cursor-atomic
+kms_plane@plane-panning-top-left
+kms_cursor_crc@cursor-alpha-opaque
+kms_flip@dpms-vs-vblank-race-interruptible
+kms_flip@plain-flip-ts-check-interruptible
+kms_universal_plane@universal-plane-functional
+
+# The below test shows inconsistency across multiple runs, giving
+# results of Pass and Crash alternately.
+kms_cursor_crc@cursor-size-change
+core_setmaster_vs_auth
+kms_flip@modeset-vs-vblank-race
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt
index 3e99106e50e0..0866028d095c 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt
@@ -54,5 +54,12 @@ kms_pipe_crc_basic@disable-crc-after-crtc
 # Skip driver specific tests
 msm_.*
 ^amdgpu.*
+panfrost_.*
 v3d_.*
 vc4_.*
+
+# Machine is hanging in this test with linux kernel version 6.7.0-rc4, so skip it
+kms_cursor_crc@cursor-onscreen-32x32
+kms_pipe_crc_basic@disable-crc-after-crtc
+kms_pipe_crc_basic@pipe-A-eDP-1
+kms_bw@linear-tiling-3-displays-2560x1440
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
index 32ca7f29472e..cbb5d4a88cba 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
@@ -1,12 +1,12 @@
-kms_color@gamma,Fail
+kms_atomic_transition@modeset-transition,Fail
+kms_atomic_transition@modeset-transition-fencing,Fail
+kms_atomic_transition@plane-toggle-modeset-transition,Fail
 kms_color@legacy-gamma,Fail
-kms_color@pipe-A-legacy-gamma,Fail
-kms_color@pipe-B-legacy-gamma,Fail
 kms_cursor_crc@cursor-alpha-opaque,Fail
 kms_cursor_crc@cursor-alpha-transparent,Fail
 kms_cursor_crc@cursor-dpms,Fail
 kms_cursor_crc@cursor-offscreen-32x10,Fail
-kms_cursor_crc@cursor-offscreen-32x32,Fail
+kms_cursor_crc@cursor-offscreen-64x21,Fail
 kms_cursor_crc@cursor-offscreen-64x64,Fail
 kms_cursor_crc@cursor-onscreen-32x10,Fail
 kms_cursor_crc@cursor-onscreen-32x32,Fail
@@ -26,9 +26,7 @@ kms_cursor_crc@cursor-sliding-64x21,Fail
 kms_cursor_crc@cursor-sliding-64x64,Fail
 kms_flip@basic-flip-vs-wf_vblank,Fail
 kms_flip@blocking-wf_vblank,Fail
-kms_flip@dpms-vs-vblank-race,Fail
 kms_flip@flip-vs-absolute-wf_vblank,Fail
-kms_flip@flip-vs-absolute-wf_vblank-interruptible,Fail
 kms_flip@flip-vs-blocking-wf-vblank,Fail
 kms_flip@flip-vs-modeset-vs-hang,Fail
 kms_flip@flip-vs-panning,Fail
@@ -40,10 +38,8 @@ kms_flip@plain-flip-fb-recreate-interruptible,Fail
 kms_flip@plain-flip-ts-check,Fail
 kms_flip@plain-flip-ts-check-interruptible,Fail
 kms_flip@wf_vblank-ts-check,Fail
-kms_flip@wf_vblank-ts-check-interruptible,Fail
 kms_invalid_mode@int-max-clock,Fail
 kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
-kms_pipe_crc_basic@compare-crc-sanitycheck-xr24,Fail
 kms_pipe_crc_basic@disable-crc-after-crtc,Fail
 kms_pipe_crc_basic@nonblocking-crc,Fail
 kms_pipe_crc_basic@nonblocking-crc-frame-sequence,Fail
@@ -56,21 +52,5 @@ kms_plane@plane-panning-top-left,Fail
 kms_plane@plane-position-covered,Fail
 kms_plane@plane-position-hole,Fail
 kms_plane@plane-position-hole-dpms,Fail
-kms_plane_cursor@overlay,Fail
-kms_plane_cursor@pipe-B-overlay-size-128,Fail
-kms_plane_cursor@pipe-B-overlay-size-256,Fail
-kms_plane_cursor@pipe-B-overlay-size-64,Fail
-kms_plane_cursor@pipe-B-primary-size-128,Fail
-kms_plane_cursor@pipe-B-primary-size-256,Fail
-kms_plane_cursor@pipe-B-primary-size-64,Fail
-kms_plane_cursor@pipe-B-viewport-size-128,Fail
-kms_plane_cursor@pipe-B-viewport-size-256,Fail
-kms_plane_cursor@pipe-B-viewport-size-64,Fail
-kms_plane_cursor@primary,Fail
-kms_plane_cursor@viewport,Fail
-kms_plane_multiple@atomic-pipe-B-tiling-none,Fail
-kms_plane_multiple@tiling-none,Fail
-kms_prime@basic-crc,Fail
 kms_rmfb@close-fd,Fail
-kms_universal_plane@universal-plane-pipe-B-functional,Fail
-panfrost_prime@gem-prime-import,Fail
+kms_universal_plane@universal-plane-functional,Fail
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
index c9fdc623ab91..5126a849bf4a 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
@@ -1,7 +1,25 @@
-kms_bw@linear-tiling-2-displays-1920x1080p
-kms_cursor_crc@cursor-offscreen-64x21
+# Board Name: rk3399-gru-kevin.dtb
+# Bug Report: https://lore.kernel.org/dri-devel/bdb53650-1888-30b8-93ee-2290d020af4a@collabora.com/T/#u
+# IGT Version: 1.28-gd2af13d9f
+# Failure Rate: 50
+# Linux Version: 6.7.0-rc3
+
+# Reported by deqp-runner
+kms_bw@linear-tiling-1-displays-1920x1080p
+kms_color@gamma
+kms_cursor_legacy@cursorA-vs-flipA-toggle
+kms_cursor_legacy@nonblocking-modeset-vs-cursor-atomic
+kms_flip@dpms-vs-vblank-race
 kms_flip@dpms-vs-vblank-race-interruptible
+kms_flip@flip-vs-absolute-wf_vblank-interruptible
 kms_flip@flip-vs-wf_vblank-interruptible
-kms_plane_cursor@overlay
-kms_plane_cursor@primary
-kms_plane_cursor@viewport
+kms_flip@modeset-vs-vblank-race-interruptible
+kms_pipe_crc_basic@compare-crc-sanitycheck-xr24
+kms_setmode@basic
+
+# The below test shows inconsistency across multiple runs, giving
+# results of Pass and Crash alternately.
+kms_bw@linear-tiling-2-displays-1920x1080p
+kms_bw@linear-tiling-3-displays-2560x1440p
+kms_cursor_crc@cursor-rapid-movement-32x10
+kms_flip@wf_vblank-ts-check-interruptible
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt
index bd0bba0d8477..f309aeca857a 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt
@@ -7,5 +7,10 @@ kms_cursor_legacy.*
 # Skip driver specific tests
 msm_.*
 ^amdgpu.*
+panfrost_.*
 v3d_.*
 vc4_.*
+
+# Machine ends up hanging after lots of Oopses with linux version 6.7.0-rc4
+# rockchip-dp ff970000.dp: AUX CH error happened: 0x2
+kms_plane_multiple.*
-- 
2.40.1


