Return-Path: <linux-kernel+bounces-44800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB2E84279A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B731F22A01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7939285C73;
	Tue, 30 Jan 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y7I63n76"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55327823D5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627124; cv=none; b=CU39K7Z0lq5em+aU6EeWK6EeuQKolqmieiTOBnLAHi3djOHxZaxRXb2M47w/YWzWOZ+T6SOR5aNFrLm6xWrfMY/MWK0C9nr//nHCbFrckr6eULwQatAbYdIt8AXoQIvBVrinVf5Z7XabSwHpQrXpCumJ9R4me5YHsUV6CdMV87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627124; c=relaxed/simple;
	bh=zvEHPqsSi2mmxgkeDkWSdLIXDtcP/2UPBIsgY7QDhVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Goish00SVIE+FGGzxbmjAA6NsOF7C9VF8z7gkEjlpfkJZflJ16q6OKQnyz+KA7C5y9vbRn1YxVxHInkEL6LLOGaQUHYhKu2j0wSpwMalhgpXkXiSo7+QF05lmWvGPfmyj7aRuOl/JaEngA8uBvbU6phPP9WoMCpU6FwuljwHZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y7I63n76; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706627121;
	bh=zvEHPqsSi2mmxgkeDkWSdLIXDtcP/2UPBIsgY7QDhVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7I63n76OUj2pQJtD1zFNyuejbbnbSQjLkRcqs1py3PAdTlydMWXOuLzFG/U0BrnZ
	 UZvuWMaeg5fUJD3rSHYjv4Dv8vKhuun4Y7Dy4PFU1rUPBlU3H3TVFP/m/kRE/fr0CP
	 G0bH++zt1joHs40Qm5t2dZv4x7KC5ckUJRBHe1MDD4KU91KdBPi9M/FHZNQjO/WfGD
	 woiqQU78fHzMqoJFCPd1gnkSC6z7GIVH7Fik5fr7EI38640Guo22f1Vujc7Vk8b+ZK
	 PEzBqpEP1rvy8JabfDq+FV+F2OyeUR1h0yOQp4D2qcrF49IAKeJY9I7+5FKriXJXQ1
	 71AZ4qqHLF8Hg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E0EAE3782089;
	Tue, 30 Jan 2024 15:05:16 +0000 (UTC)
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
Subject: [PATCH v3 5/9] drm/ci: meson: Add job to test panfrost GPU driver
Date: Tue, 30 Jan 2024 20:33:36 +0530
Message-Id: <20240130150340.687871-6-vignesh.raman@collabora.com>
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

For amlogic meson SOC the GPU driver is panfrost. So add
support in drm-ci to test panfrost driver for amlogic meson
SOC and update xfails. Skip KMS tests for panfrost driver
since it is not a not a KMS driver.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Add panfrost GPU jobs for amlogic meson SOC with new xfails.

v3:
  - Skip KMS tests for panfrost driver since it is not a not a KMS
    driver and update xfails. Add the job name in GPU_VERSION and use
    it for xfail file names instead of using DRIVER_NAME.

---
 drivers/gpu/drm/ci/test.yml                        | 7 +++++++
 drivers/gpu/drm/ci/xfails/meson-g12b-gpu-fails.txt | 1 +
 drivers/gpu/drm/ci/xfails/meson-g12b-gpu-skips.txt | 2 ++
 3 files changed, 10 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-gpu-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-gpu-skips.txt

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index bf4c303a65f2..f4053bc0e365 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -358,6 +358,13 @@ mediatek:mt8183-display:
     DEVICE_TYPE: meson-g12b-a311d-khadas-vim3
     RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
 
+meson:g12b-gpu:
+  extends:
+    - .g12b
+  variables:
+    GPU_VERSION: meson-g12b-gpu
+    DRIVER_NAME: panfrost
+
 meson:g12b-display:
   extends:
     - .g12b
diff --git a/drivers/gpu/drm/ci/xfails/meson-g12b-gpu-fails.txt b/drivers/gpu/drm/ci/xfails/meson-g12b-gpu-fails.txt
new file mode 100644
index 000000000000..6f5e760d5ec0
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/meson-g12b-gpu-fails.txt
@@ -0,0 +1 @@
+panfrost_prime@gem-prime-import,Fail
diff --git a/drivers/gpu/drm/ci/xfails/meson-g12b-gpu-skips.txt b/drivers/gpu/drm/ci/xfails/meson-g12b-gpu-skips.txt
new file mode 100644
index 000000000000..2ea09d1648bc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/meson-g12b-gpu-skips.txt
@@ -0,0 +1,2 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
-- 
2.40.1


