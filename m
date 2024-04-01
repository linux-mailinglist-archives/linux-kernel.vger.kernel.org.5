Return-Path: <linux-kernel+bounces-126457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1C893847
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9590A1C2095D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ABD15AD0;
	Mon,  1 Apr 2024 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UmQnnZvI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A713ADD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952048; cv=none; b=J6gJ58OmnMGCLeg3dw7lX9SKzW5HOf1bMNErAyjt7I3fhPg6nWQXQvnVWs4xdobmXLHx389ARVWaa5nY2sfNOSh1fzMYTeXMBYyLdJGwN02JOQcLzywX8NpzD3KK2s3FiB5bCzT//CBKoAKq//W/24P5U/CNA2TcB5EA6bAnipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952048; c=relaxed/simple;
	bh=8qJ3ciIUKXzXMXkGK0xRIsuO+xbVMIkMF57BNwi+b7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XXLIdX7/pkqxDBjSufzZO9EX8Woxfo7PjyZo4laHJemWNVBgugm3HAMFq+JSbTcbpJIjulZoQ4B1gLkZQu+AdnAut68EUEeJCErjTKqZ9j4HOT3UXN3jshl4lGukEtcv8/GJO2sp7oNyVZqa/fYo54gjq3XFQHc2bCzAYY0mdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UmQnnZvI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711952045;
	bh=8qJ3ciIUKXzXMXkGK0xRIsuO+xbVMIkMF57BNwi+b7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmQnnZvIRURZFOh1t9ztUQYqqAkkUnvyoENbOwxPitVhdVSeDvES9QDs+k8HBEHRm
	 VyfW+8BQYx98LfJwHJxKD/VZwP08w+RNbEYIKeId2um/qBawDvWpGHrtArAmoYpfVb
	 jwDrKySp+Iu7VbJli79F/rWj9+XIZkAxu5SN8vm6Gb96cmGMr+rZmLs8gxFzte8LNf
	 KNhqnNfRVCCg82JfKmVkZhvj/9nZ3PmCH++Oa8yGpkjP2z/r7XPxVZ+Z2vYynzsMRu
	 jE1RCqpPXx4A7oMB9TYhAyylFCMw10RdJqBWT5zHdoA9oQWvcXnyL0G2OEGsJQiMpV
	 mBiSmKBRKvAig==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 01DAC37813B6;
	Mon,  1 Apr 2024 06:14:01 +0000 (UTC)
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
Subject: [PATCH v5 09/10] drm/ci: rockchip: Add job to test panfrost GPU driver
Date: Mon,  1 Apr 2024 11:42:34 +0530
Message-Id: <20240401061235.192713-10-vignesh.raman@collabora.com>
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

For rockchip rk3288 and rk3399, the GPU driver is panfrost.
So add support in drm-ci to test panfrost driver for rockchip
SOC and update xfails. Skip KMS tests for panfrost driver
since it is not a not a KMS driver and skip driver-specific tests.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Add panfrost GPU jobs for rockchip SOC with new xfails.

v3:
  - Skip KMS tests for panfrost driver since it is not a not
    a KMS driver and update xfails. Add the job name in GPU_VERSION
    and use it for xfail file names instead of using DRIVER_NAME.

v4:
  - Remove the gpu suffix in job and rename xfails accordingly.

v5:
  - Skip driver-specific tests.

---
 drivers/gpu/drm/ci/test.yml                         | 10 ++++++++++
 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt |  1 +
 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt |  8 ++++++++
 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt |  1 +
 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt |  8 ++++++++
 5 files changed, 28 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 96b299c32c07..8c90ae5a51e6 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -191,11 +191,21 @@ rockchip:rk3288:
     - .rk3288
     - .rockchip-display
 
+panfrost:rk3288:
+  extends:
+    - .rk3288
+    - .panfrost-gpu
+
 rockchip:rk3399:
   extends:
     - .rk3399
     - .rockchip-display
 
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
-- 
2.40.1


