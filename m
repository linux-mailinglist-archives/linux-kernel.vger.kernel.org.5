Return-Path: <linux-kernel+bounces-93275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13249872D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47FB28CC94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32A1BF35;
	Wed,  6 Mar 2024 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FnKYoGZ8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2B1BDE7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694520; cv=none; b=nM9V8D0pvGNSn4AYnThirSYWSRwLGCBQ1EJpHEgQQ1NL1RksgCmJ7jf073nu7974HKI6O5DcfhlABIl03/xannr8xT+Os5STj4VBPYKssct/8eT2hesApQzNH/olv3PCSUxlB1XJ97dO/1wjSVZq8HY07HtGoKnZObyEiOGI8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694520; c=relaxed/simple;
	bh=Ier7Zs9YGiPE6VTwgq6zjqYKqPQimOUMviUj1yfjmjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1qIAe635Sx3UBrWkfogqf/t6go8/qZmDq5SqbSf+314NUyxy2eg6odKkuJk23wMo2QaBDMPrHdOkx+R2rXrvmuGeYG2RQOPIOMAYpBiZYKtbVKJGSY+zMHTfeWYdeI866hR3ddSzuY2N0INdKcQmZ3pKu3w/YR2vFLWyCdcWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FnKYoGZ8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709694517;
	bh=Ier7Zs9YGiPE6VTwgq6zjqYKqPQimOUMviUj1yfjmjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnKYoGZ81TDnfWT+3G0NKjLwVz3d8pjPGml7hX64VkJBxYANpkcm9sc0RsENdRjiL
	 9JlfO7Hn5/+4uWNIL3aY1GRO2UFaJm9Zz0Tav0bd47Qt3E0nK/Prg+20Ybu+yaQNse
	 feXpaWbEjaAkBieo3y+jSerWGcNPGKzPVpc3qE3Yrw8OUUCu2Va01s8NpmGVGuicPB
	 QuXcg6nkS0yIG4xocLXUf8zq4SF42nU67Pv0LLNrxdKt3h25X5Bdq0cNBZRG6FcVnY
	 hk0IzvMHPr5VL7v0u6+utdhLKW9OAaGD+kYwYcmTdP52rdMxNpdCbKUAKaZdBSjrEb
	 7vfO9sI2rjqCw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 48F9B37820DE;
	Wed,  6 Mar 2024 03:08:33 +0000 (UTC)
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
Subject: [PATCH v4 10/11] drm/ci: rockchip: Add job to test panfrost GPU driver
Date: Wed,  6 Mar 2024 08:36:48 +0530
Message-Id: <20240306030649.60269-11-vignesh.raman@collabora.com>
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

v4:
  - Remove the gpu suffix in job and rename xfails accordingly.

---
 drivers/gpu/drm/ci/test.yml                      | 16 ++++++++++++++++
 .../gpu/drm/ci/xfails/panfrost-rk3288-fails.txt  |  1 +
 .../gpu/drm/ci/xfails/panfrost-rk3288-skips.txt  |  2 ++
 .../gpu/drm/ci/xfails/panfrost-rk3399-fails.txt  |  1 +
 .../gpu/drm/ci/xfails/panfrost-rk3399-skips.txt  |  2 ++
 5 files changed, 22 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 831e580e6dfd..ac8e974723a5 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -185,6 +185,14 @@ rockchip:rk3288:
     GPU_VERSION: rk3288
     DRIVER_NAME: rockchip
 
+panfrost:rk3288:
+  extends:
+    - .rk3288
+  stage: panfrost
+  variables:
+    GPU_VERSION: rk3288
+    DRIVER_NAME: panfrost
+
 rockchip:rk3399:
   extends:
     - .rk3399
@@ -192,6 +200,14 @@ rockchip:rk3399:
     GPU_VERSION: rk3399
     DRIVER_NAME: rockchip
 
+panfrost:rk3399:
+  extends:
+    - .rk3399
+  stage: panfrost
+  variables:
+    GPU_VERSION: rk3399
+    DRIVER_NAME: panfrost
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
index 000000000000..2ea09d1648bc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
@@ -0,0 +1,2 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
new file mode 100644
index 000000000000..6f5e760d5ec0
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
@@ -0,0 +1 @@
+panfrost_prime@gem-prime-import,Fail
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
new file mode 100644
index 000000000000..2ea09d1648bc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
@@ -0,0 +1,2 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
-- 
2.40.1


