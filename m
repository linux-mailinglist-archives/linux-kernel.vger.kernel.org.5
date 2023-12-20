Return-Path: <linux-kernel+bounces-6870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31255819EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B79FFB2339C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF422305;
	Wed, 20 Dec 2023 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M9b7xfe4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0925777
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703074308;
	bh=Oh463TEYwWlMnYER5Qs7j3iFZItrw8O/XAP1/5Xns2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9b7xfe4SEa6MrlfHuJX3mN4lKOCgV2ixf1mwLt5VLRaN/BYK43jBqAH7+w8nmWLY
	 2DvBlHHU4EdWR19FSey0+CxbzGWZ/bjIcbwpE7/0f0s7/a0GSaoci/WmyFzVX+wwo4
	 FLnzKvpkB3tieXdBNd+Fg+K94ySxhgd/QOKCnygoUl0BpzH2lv6GZ3YX/ZiIQx3YSY
	 iyhWLhAOQyJ6WOCvfbfMpi9q/plT21jiTNdX5ZPRCe2ETwe1QuEX5S2BWNXKHX3yTC
	 iMudimtroNePbPIf8Ea7rD73tbDV6EMtjb14uV1HvsVRO3vJx3DulwmhnSL9nTL1MM
	 6OYrucRAGuGbQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E938F3781FEF;
	Wed, 20 Dec 2023 12:11:42 +0000 (UTC)
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
Subject: [PATCH v1 3/8] drm/ci: rockchip: Test both GPU and display drivers
Date: Wed, 20 Dec 2023 17:41:05 +0530
Message-Id: <20231220121110.1441160-4-vignesh.raman@collabora.com>
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

Rockchip rk3288 and rk3399 SOCs have a separate display controller
and GPU, with different drivers for each. Add support in drm-ci
to test both these drivers.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/test.yml | 50 ++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 1945c0a70e76..8081925303f5 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -135,33 +135,59 @@ msm:sdm845:
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
 
+rockchip:rk3288-gpu:
+  extends:
+    - .rk3288
+  variables:
+    GPU_VERSION: rk3288-gpu
+    DRIVER_NAME: panfrost
+
+rockchip:rk3288-display:
+  extends:
+    - .rk3288
+  variables:
+    GPU_VERSION: rk3288-display
+    DRIVER_NAME: rockchip
+
+rockchip:rk3399-gpu:
+  extends:
+    - .rk3399
+  variables:
+    GPU_VERSION: rk3399-gpu
+    DRIVER_NAME: panfrost
+
+rockchip:rk3399-display:
+  extends:
+    - .rk3399
+  variables:
+    GPU_VERSION: rk3399-display
+    DRIVER_NAME: rockchip
+
 .i915:
   extends:
     - .lava-igt:x86_64
-- 
2.40.1


