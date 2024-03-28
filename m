Return-Path: <linux-kernel+bounces-93274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56777872D59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABDD1C25F71
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93BF18B1A;
	Wed,  6 Mar 2024 03:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PBNK+Xo2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2821BF2B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694516; cv=none; b=id0HZR6h0SygPOJ56CDxvu7CjK7UQdUSPyLPfKiPe+n1Y6GYA1Abx4fddV6BN1NRQ3go1c+fw3o/dbI/ECUxKHtDv5YhjM5BVKmHx/cTMDrpKetQ0QV45Mi8jVt/GyVw5yTKYs6QsiopC36xdTIUoboS1/FPI/O4F/8rdR4fFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694516; c=relaxed/simple;
	bh=IyOF7zbWgKjz2D54u6TrGoKoAjHbfelWWorWmFZMDR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSvV0zg+AJYktZBW3YRiRRtZzRBMpCzHZlHmDHeyqdNJFk264t0t7RBKQUOOUYVTJzxdUuMyjoH1eS+iZN8/Lfm64CaUAX324zbkvbjYqjJF7OITJeApwF29MBhKf/5FtrgTg5fIFUw/o6oGNxLZAJYuuIR+GV2wh+UuICAxGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PBNK+Xo2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709694512;
	bh=IyOF7zbWgKjz2D54u6TrGoKoAjHbfelWWorWmFZMDR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBNK+Xo2X4Ao99odgmheJOw2k4HtcWr0DRWrBpRmAr4BaJZsdGKMTVGIFaqWIANFR
	 3g5B/INw5YjsiRh1ONb5/GlnYZjSDiJgO7Bm86jKT7kSzLhDgABKVCvHVC8gPDEsPG
	 7PCOYpLuPWiu/Ckt/UvKR4XZnTZDaCG22jGYl1eXoGaEs9QHFqLHPaJn2ZhdjiUxfC
	 JN3J65GWBs39qsc6hM80V8/tIzvOH0dscXZRkMmaZu+Fd5YTe2l800pecA4uIkbpjN
	 hRTJ/acEDEkt7Xy4mNT3cwgZBGDZwvbCZBXkt5UsF2QrrBUeJo4H6Ow2a7KTmxLqpI
	 ZhgDv6ph3CdKg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B168B37820D0;
	Wed,  6 Mar 2024 03:08:28 +0000 (UTC)
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
Subject: [PATCH v4 09/11] drm/ci: rockchip: Refactor existing rockchip jobs
Date: Wed,  6 Mar 2024 08:36:47 +0530
Message-Id: <20240306030649.60269-10-vignesh.raman@collabora.com>
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

For rockchip rk3288 and rk3399, the display driver is rockchip.
Currently, in drm-ci for rockchip, only the display driver is
tested. Refactor the existing rockchip jobs so that gpu driver
testing jobs can be added later and update xfails accordingly.

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

---
 drivers/gpu/drm/ci/test.yml                   | 36 ++++++++----
 .../drm/ci/xfails/rockchip-rk3288-fails.txt   | 58 ++++++-------------
 .../drm/ci/xfails/rockchip-rk3288-flakes.txt  | 20 +++++++
 .../drm/ci/xfails/rockchip-rk3288-skips.txt   | 54 ++---------------
 .../drm/ci/xfails/rockchip-rk3399-fails.txt   | 38 ++++++------
 .../drm/ci/xfails/rockchip-rk3399-flakes.txt  | 28 +++++++--
 .../drm/ci/xfails/rockchip-rk3399-skips.txt   |  5 +-
 7 files changed, 110 insertions(+), 129 deletions(-)
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 6ae6398b3d88..831e580e6dfd 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -153,33 +153,45 @@ msm:sdm845:
   script:
     - ./install/bare-metal/cros-servo.sh
 
-rockchip:rk3288:
-  extends:
-    - .lava-igt:arm32
+.rockchip:
   stage: rockchip
   variables:
-    DRIVER_NAME: rockchip
-    DEVICE_TYPE: rk3288-veyron-jaq
     DTB: ${DEVICE_TYPE}
     BOOT_METHOD: depthcharge
+
+.rk3288:
+  extends:
+    - .lava-igt:arm32
+    - .rockchip
+  variables:
+    DEVICE_TYPE: rk3288-veyron-jaq
     KERNEL_IMAGE_TYPE: "zimage"
-    GPU_VERSION: rk3288
     RUNNER_TAG: mesa-ci-x86-64-lava-rk3288-veyron-jaq
 
-rockchip:rk3399:
+.rk3399:
   extends:
     - .lava-igt:arm64
-  stage: rockchip
+    - .rockchip
   parallel: 2
   variables:
-    DRIVER_NAME: rockchip
     DEVICE_TYPE: rk3399-gru-kevin
-    DTB: ${DEVICE_TYPE}
-    BOOT_METHOD: depthcharge
     KERNEL_IMAGE_TYPE: ""
-    GPU_VERSION: rk3399
     RUNNER_TAG: mesa-ci-x86-64-lava-rk3399-gru-kevin
 
+rockchip:rk3288:
+  extends:
+    - .rk3288
+  variables:
+    GPU_VERSION: rk3288
+    DRIVER_NAME: rockchip
+
+rockchip:rk3399:
+  extends:
+    - .rk3399
+  variables:
+    GPU_VERSION: rk3399
+    DRIVER_NAME: rockchip
+
 .i915:
   extends:
     - .lava-igt:x86_64
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
index 90c63f519e9e..c16e0a06cc8f 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
@@ -1,54 +1,30 @@
-kms_3d,Crash
-kms_bw@linear-tiling-2-displays-1920x1080p,Fail
 kms_bw@linear-tiling-2-displays-2560x1440p,Fail
-kms_bw@linear-tiling-2-displays-3840x2160p,Fail
 kms_bw@linear-tiling-3-displays-1920x1080p,Fail
-kms_bw@linear-tiling-3-displays-2560x1440p,Fail
-kms_bw@linear-tiling-3-displays-3840x2160p,Fail
+kms_cursor_crc@cursor-onscreen-32x10,Crash
+kms_cursor_crc@cursor-onscreen-64x21,Crash
+kms_cursor_crc@cursor-onscreen-64x64,Crash
+kms_cursor_crc@cursor-random-32x10,Crash
+kms_cursor_crc@cursor-random-64x21,Crash
+kms_cursor_crc@cursor-random-64x64,Crash
+kms_cursor_crc@cursor-sliding-32x10,Crash
+kms_cursor_crc@cursor-sliding-32x32,Crash
+kms_cursor_crc@cursor-sliding-64x64,Crash
+kms_cursor_legacy@basic-flip-before-cursor-atomic,Fail
+kms_cursor_legacy@basic-flip-before-cursor-legacy,Fail
+kms_cursor_legacy@cursor-vs-flip-atomic,Fail
+kms_cursor_legacy@cursor-vs-flip-atomic-transitions,Fail
+kms_cursor_legacy@cursor-vs-flip-toggle,Fail
+kms_cursor_legacy@flip-vs-cursor-crc-atomic,Crash
+kms_cursor_legacy@flip-vs-cursor-crc-legacy,Crash
 kms_flip@flip-vs-modeset-vs-hang,Crash
 kms_flip@flip-vs-panning-vs-hang,Crash
-kms_force_connector_basic@force-load-detect,Fail
 kms_invalid_mode@int-max-clock,Crash
-kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Crash
-kms_pipe_crc_basic@nonblocking-crc-frame-sequence,Crash
 kms_pipe_crc_basic@read-crc-frame-sequence,Crash
 kms_plane@pixel-format,Crash
-kms_plane@pixel-format-source-clamping,Crash
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
-kms_plane_cursor@viewport,Crash
-kms_plane_lowres@tiling-none,Fail
-kms_plane_scaling@downscale-with-modifier-factor-0-25,Fail
-kms_plane_scaling@downscale-with-rotation-factor-0-25,Fail
-kms_plane_scaling@upscale-with-modifier-20x20,Fail
-kms_plane_scaling@upscale-with-modifier-factor-0-25,Fail
-kms_plane_scaling@upscale-with-pixel-format-20x20,Fail
-kms_plane_scaling@upscale-with-pixel-format-factor-0-25,Fail
-kms_plane_scaling@upscale-with-rotation-20x20,Fail
-kms_prime@basic-crc,Fail
-kms_properties@connector-properties-atomic,Crash
+kms_prop_blob@invalid-set-prop,Crash
 kms_properties@connector-properties-legacy,Crash
 kms_properties@get_properties-sanity-atomic,Crash
 kms_properties@get_properties-sanity-non-atomic,Crash
 kms_rmfb@close-fd,Crash
-kms_setmode@invalid-clone-single-crtc,Crash
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
new file mode 100644
index 000000000000..de13bac3a5bc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
@@ -0,0 +1,20 @@
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
+kms_universal_plane@universal-plane-functional
+
+# The below test shows inconsistency across multiple runs, giving
+# results of Pass and Crash alternately.
+kms_cursor_crc@cursor-size-change
+core_setmaster_vs_auth
+kms_flip@modeset-vs-vblank-race
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt
index f20c3574b75a..627bf03f3c78 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt
@@ -1,52 +1,8 @@
 # Suspend to RAM seems to be broken on this machine
 .*suspend.*
 
-# Too unstable, machine ends up hanging after lots of Oopses
-kms_cursor_legacy.*
-
-# Started hanging the machine on Linux 5.19-rc2:
-#
-# [IGT] kms_plane_lowres: executing
-# [IGT] kms_plane_lowres: starting subtest pipe-F-tiling-y
-# [IGT] kms_plane_lowres: exiting, ret=77
-# Console: switching to colour frame buffer device 170x48
-# rockchip-drm display-subsystem: [drm] *ERROR* flip_done timed out
-# rockchip-drm display-subsystem: [drm] *ERROR* [CRTC:35:crtc-0] commit wait timed out
-# BUG: spinlock bad magic on CPU#3, kms_plane_lowre/482
-# 8<--- cut here ---
-# Unable to handle kernel paging request at virtual address 7812078e
-# [7812078e] *pgd=00000000
-# Internal error: Oops: 5 [#1] SMP ARM
-# Modules linked in:
-# CPU: 3 PID: 482 Comm: kms_plane_lowre Tainted: G        W         5.19.0-rc2-323596-g00535de92171 #1
-# Hardware name: Rockchip (Device Tree)
-# Process kms_plane_lowre (pid: 482, stack limit = 0x1193ac2b)
-#  spin_dump from do_raw_spin_lock+0xa4/0xe8
-#  do_raw_spin_lock from wait_for_completion_timeout+0x2c/0x120
-#  wait_for_completion_timeout from drm_crtc_commit_wait+0x18/0x7c
-#  drm_crtc_commit_wait from drm_atomic_helper_wait_for_dependencies+0x44/0x168
-#  drm_atomic_helper_wait_for_dependencies from commit_tail+0x34/0x180
-#  commit_tail from drm_atomic_helper_commit+0x164/0x18c
-#  drm_atomic_helper_commit from drm_atomic_commit+0xac/0xe4
-#  drm_atomic_commit from drm_client_modeset_commit_atomic+0x23c/0x284
-#  drm_client_modeset_commit_atomic from drm_client_modeset_commit_locked+0x60/0x1c8
-#  drm_client_modeset_commit_locked from drm_client_modeset_commit+0x24/0x40
-#  drm_client_modeset_commit from drm_fbdev_client_restore+0x58/0x94
-#  drm_fbdev_client_restore from drm_client_dev_restore+0x70/0xbc
-#  drm_client_dev_restore from drm_release+0xf4/0x114
-#  drm_release from __fput+0x74/0x240
-#  __fput from task_work_run+0x84/0xb4
-#  task_work_run from do_exit+0x34c/0xa20
-#  do_exit from do_group_exit+0x34/0x98
-#  do_group_exit from __wake_up_parent+0x0/0x18
-# Code: e595c008 12843d19 03e00000 03093168 (15940508)
-# ---[ end trace 0000000000000000 ]---
-# note: kms_plane_lowre[482] exited with preempt_count 1
-# Fixing recursive fault but reboot is needed!
-kms_plane_lowres@pipe-F-tiling-y
-
-# Take too long, we have only two machines, and these are very flaky
-kms_cursor_crc.*
-
-# Machine is hanging in this test, so skip it
-kms_pipe_crc_basic@disable-crc-after-crtc
\ No newline at end of file
+# Machine is hanging in this test with linux kernel version 6.7.0-rc4, so skip it
+kms_cursor_crc@cursor-onscreen-32x32
+kms_pipe_crc_basic@disable-crc-after-crtc
+kms_pipe_crc_basic@pipe-A-eDP-1
+kms_bw@linear-tiling-3-displays-2560x1440
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
index d516d9c1d546..ace0d6ed6f2f 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
@@ -1,12 +1,13 @@
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
 kms_cursor_crc@cursor-offscreen-32x32,Fail
+kms_cursor_crc@cursor-offscreen-64x21,Fail
 kms_cursor_crc@cursor-offscreen-64x64,Fail
 kms_cursor_crc@cursor-onscreen-32x10,Fail
 kms_cursor_crc@cursor-onscreen-32x32,Fail
@@ -16,6 +17,7 @@ kms_cursor_crc@cursor-random-32x10,Fail
 kms_cursor_crc@cursor-random-32x32,Fail
 kms_cursor_crc@cursor-random-64x21,Fail
 kms_cursor_crc@cursor-random-64x64,Fail
+kms_cursor_crc@cursor-rapid-movement-32x10,Fail
 kms_cursor_crc@cursor-rapid-movement-32x32,Fail
 kms_cursor_crc@cursor-rapid-movement-64x21,Fail
 kms_cursor_crc@cursor-rapid-movement-64x64,Fail
@@ -24,23 +26,33 @@ kms_cursor_crc@cursor-sliding-32x10,Fail
 kms_cursor_crc@cursor-sliding-32x32,Fail
 kms_cursor_crc@cursor-sliding-64x21,Fail
 kms_cursor_crc@cursor-sliding-64x64,Fail
+kms_cursor_legacy@basic-flip-before-cursor-atomic,Fail
+kms_cursor_legacy@basic-flip-before-cursor-legacy,Fail
+kms_cursor_legacy@cursor-vs-flip-atomic,Fail
+kms_cursor_legacy@cursor-vs-flip-legacy,Fail
+kms_cursor_legacy@cursor-vs-flip-toggle,Fail
+kms_cursor_legacy@flip-vs-cursor-atomic,Fail
+kms_cursor_legacy@flip-vs-cursor-crc-atomic,Fail
+kms_cursor_legacy@flip-vs-cursor-crc-legacy,Fail
+kms_cursor_legacy@flip-vs-cursor-legacy,Fail
+kms_cursor_legacy@long-nonblocking-modeset-vs-cursor-atomic,Fail
 kms_flip@basic-flip-vs-wf_vblank,Fail
 kms_flip@blocking-wf_vblank,Fail
 kms_flip@dpms-vs-vblank-race,Fail
+kms_flip@dpms-vs-vblank-race-interruptible,Fail
 kms_flip@flip-vs-absolute-wf_vblank,Fail
-kms_flip@flip-vs-absolute-wf_vblank-interruptible,Fail
 kms_flip@flip-vs-blocking-wf-vblank,Fail
 kms_flip@flip-vs-modeset-vs-hang,Fail
 kms_flip@flip-vs-panning,Fail
 kms_flip@flip-vs-panning-interruptible,Fail
 kms_flip@flip-vs-panning-vs-hang,Fail
 kms_flip@modeset-vs-vblank-race,Fail
+kms_flip@modeset-vs-vblank-race-interruptible,Fail
 kms_flip@plain-flip-fb-recreate,Fail
 kms_flip@plain-flip-fb-recreate-interruptible,Fail
 kms_flip@plain-flip-ts-check,Fail
 kms_flip@plain-flip-ts-check-interruptible,Fail
 kms_flip@wf_vblank-ts-check,Fail
-kms_flip@wf_vblank-ts-check-interruptible,Fail
 kms_invalid_mode@int-max-clock,Fail
 kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
 kms_pipe_crc_basic@compare-crc-sanitycheck-xr24,Fail
@@ -56,20 +68,6 @@ kms_plane@plane-panning-top-left,Fail
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
 kms_plane_multiple@tiling-none,Fail
-kms_prime@basic-crc,Fail
 kms_rmfb@close-fd,Fail
-kms_universal_plane@universal-plane-pipe-B-functional,Fail
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
index 10c3d81a919a..cf5577b7720c 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt
@@ -1,5 +1,6 @@
 # Suspend to RAM seems to be broken on this machine
 .*suspend.*
 
-# Too unstable, machine ends up hanging after lots of Oopses
-kms_cursor_legacy.*
+# Machine ends up hanging after lots of Oopses with linux version 6.7.0-rc4
+# rockchip-dp ff970000.dp: AUX CH error happened: 0x2
+kms_plane_multiple.*
-- 
2.40.1


