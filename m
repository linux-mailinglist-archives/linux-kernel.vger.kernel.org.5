Return-Path: <linux-kernel+bounces-44802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93284279F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D73128527F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6686AF2;
	Tue, 30 Jan 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RGNEnZ3O"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5780058
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627136; cv=none; b=HjsexDYYCPjnFfIKVKcAT4VZyw00An/RBQTlclwJPSUlDj9yiytpqW5iYCW0gKVNoYb2fvfsxbvGsGImqK5qiwvf/oymj3sGj34c8Fop2Lchnut1/46t8/IIY2REw/PTfXa/AuAww5fPSB0ampsTGE/xxsaBmB7GIKp2+5BO1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627136; c=relaxed/simple;
	bh=URYtar/EYKdvk24yq8i2kmfS77H7Oa8ScrMzfoeJcCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thNRPcNmDrvkCc8UVdiIUSsc9d2k2n7AYRqd0vcYX+Ba9dW/RL/wc0s7RjKvX1/NXfiaq7p8pfvoBqwMSKjcJv7kJcdOi/px+4eMIjJqz91TQ8eHHtOT6dUh2zQXvRlunp9Xg2f4W3nE1/2mi7FV4y70G6p2qPcb6CuNwIsgvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RGNEnZ3O; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706627133;
	bh=URYtar/EYKdvk24yq8i2kmfS77H7Oa8ScrMzfoeJcCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGNEnZ3Osl5NmwJb/YucgJH/VPBsfpuYGZdMIh9Osq3ocSSBTncfl7RqEHTlqcgwo
	 HYXqnHLkMJG+GbK0On8O2Yu7/XWl++SPYClDzyQ1WmbMbDnTCMHDvm/jzd9je9oseH
	 vA7cG0y64Bsjz/K9V9rRU4Pans333w4KAdqMIrjUU1o4qtVyzyxs6/BDeokiGUwDaA
	 ZGY5x5iX8iv/dWywlQZwMXhJjxOBNhOZKT3M3BansHFy2pAsWoRPlO9xIJZh03969L
	 kaX9yX7Qz39AGzd9b2f6WlFeThUe7sl9eCdY0NBrh0Pobfsyirwq2lLAnwsdIPqod6
	 ueKJx+DDL1/pA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EAE323782084;
	Tue, 30 Jan 2024 15:05:27 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniel@fooishbar.org,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	robdclark@gmail.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] drm/ci: rockchip: Add job to test panfrost GPU driver
Date: Tue, 30 Jan 2024 20:33:38 +0530
Message-Id: <20240130150340.687871-8-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130150340.687871-1-vignesh.raman@collabora.com>
References: <20240130150340.687871-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For rockchip rk3288 and rk3399, the GPU driver is panfrost.
So add support in drm-ci to test panfrost driver for rockchip
SOC and update xfails. Skip KMS tests for panfrost driver
since it is not a not a KMS driver.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Add panfrost GPU jobs for rockchip SOC with new xfails.

v3:
  - Skip KMS tests for panfrost driver since it is not a not
    a KMS driver and update xfails. Add the job name in GPU_VERSION
    and use it for xfail file names instead of using DRIVER_NAME.

---
 drivers/gpu/drm/ci/test.yml                        | 14 ++++++++++++++
 .../drm/ci/xfails/rockchip-rk3288-gpu-fails.txt    |  1 +
 .../drm/ci/xfails/rockchip-rk3288-gpu-skips.txt    |  2 ++
 .../drm/ci/xfails/rockchip-rk3399-gpu-fails.txt    |  1 +
 .../drm/ci/xfails/rockchip-rk3399-gpu-skips.txt    |  2 ++
 5 files changed, 20 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-gpu-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-gpu-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-gpu-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-gpu-skips.txt

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 1b8846c6bdbf..8ab8a8f56d6a 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -175,6 +175,13 @@ msm:sdm845:
     KERNEL_IMAGE_TYPE: ""
     RUNNER_TAG: mesa-ci-x86-64-lava-rk3399-gru-kevin
 
+rockchip:rk3288-gpu:
+  extends:
+    - .rk3288
+  variables:
+    GPU_VERSION: rockchip-rk3288-gpu
+    DRIVER_NAME: panfrost
+
 rockchip:rk3288-display:
   extends:
     - .rk3288
@@ -182,6 +189,13 @@ rockchip:rk3288-display:
     GPU_VERSION: rockchip-rk3288-display
     DRIVER_NAME: rockchip
 
+rockchip:rk3399-gpu:
+  extends:
+    - .rk3399
+  variables:
+    GPU_VERSION: rockchip-rk3399-gpu
+    DRIVER_NAME: panfrost
+
 rockchip:rk3399-display:
   extends:
     - .rk3399
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-gpu-fails.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-gpu-fails.txt
new file mode 100644
index 000000000000..abd35a8ef6f4
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-gpu-fails.txt
@@ -0,0 +1 @@
+panfrost_prime@gem-prime-import,Crash
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-gpu-skips.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-gpu-skips.txt
new file mode 100644
index 000000000000..2ea09d1648bc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-gpu-skips.txt
@@ -0,0 +1,2 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-gpu-fails.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-gpu-fails.txt
new file mode 100644
index 000000000000..6f5e760d5ec0
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-gpu-fails.txt
@@ -0,0 +1 @@
+panfrost_prime@gem-prime-import,Fail
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-gpu-skips.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-gpu-skips.txt
new file mode 100644
index 000000000000..2ea09d1648bc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-gpu-skips.txt
@@ -0,0 +1,2 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
-- 
2.40.1


