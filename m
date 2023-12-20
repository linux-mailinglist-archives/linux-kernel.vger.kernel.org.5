Return-Path: <linux-kernel+bounces-6871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907DD819EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE2B24D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907C358B2;
	Wed, 20 Dec 2023 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H826zMsu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726034CD5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703074313;
	bh=cpGbNlIDrcIqhAFCyy26RbpIG22BYa4C8X4/107Zjy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H826zMsu4Ly2DqEn2dK54lHrjWC37YcV8O1ySVSqZjIhNZXFth9HFiQ5cPYSiXQs4
	 6nYwDCj0JViAuWFV+f2RmXtHzu1QaOLmelK0NqTPsoZwUr6rER4/dpQvsJwp4UfR4h
	 T5r+ROQkeRrl6Gb7/JGzUTn8fx/WsJYq6j5YaG/Sokk41Jflnud+mcgW9V+7b5xqy+
	 408M2U9Ku6TMpEMXtqYZvvMWID2JWK4qhFTFWJgXyQKG8sfW0oL8nI5Pb8kZQ3uvla
	 5+yKUYIGfXMiI9Ts7GbiIgGkZbEPGsDsPGW8oS5Tx+hlolGyM6o0bjMVdJ21a9cRRQ
	 T6D5oDR733+Ug==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9DEB73781FD5;
	Wed, 20 Dec 2023 12:11:48 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	daniels@collabora.com
Cc: david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	emma@anholt.net,
	robdclark@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/8] drm/ci: meson: Test both GPU and display drivers
Date: Wed, 20 Dec 2023 17:41:06 +0530
Message-Id: <20231220121110.1441160-5-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220121110.1441160-1-vignesh.raman@collabora.com>
References: <20231220121110.1441160-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Meson SOC have a separate display controller and GPU,
with different drivers for each. Add support in drm-ci
to test both these drivers.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/test.yml | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 8081925303f5..159eb7ba3588 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -357,20 +357,32 @@ mediatek:mt8183-display:
     - .lava-igt:arm64
   stage: meson
   variables:
-    DRIVER_NAME: meson
     DTB: ${DEVICE_TYPE}
     BOOT_METHOD: u-boot
     KERNEL_IMAGE_TYPE: "image"
 
-meson:g12b:
+.g12b:
   extends:
     - .meson
   parallel: 3
   variables:
     DEVICE_TYPE: meson-g12b-a311d-khadas-vim3
-    GPU_VERSION: g12b
     RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
 
+meson:g12b-gpu:
+  extends:
+    - .g12b
+  variables:
+    GPU_VERSION: g12b-gpu
+    DRIVER_NAME: panfrost
+
+meson:g12b-display:
+  extends:
+    - .g12b
+  variables:
+    GPU_VERSION: g12b-display
+    DRIVER_NAME: meson
+
 virtio_gpu:none:
   stage: virtio-gpu
   variables:
-- 
2.40.1


