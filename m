Return-Path: <linux-kernel+bounces-6869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F6819EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC0FB22A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F270D2554E;
	Wed, 20 Dec 2023 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HGhCroeI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17525543
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703074302;
	bh=+0AvrTjeqCyyQg+Af9MRsTk9GQX39b2It/8QLf8vlv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGhCroeInfokeP9IwBzeJjmiyK/ktpDqc9mlDjL4q501VVkIoGY5773j4wlK0ZjrA
	 X7Xc/FA3S0rfuXfEmAEYzzbGSS/LiiWC/NcYsXzWKBx9fjt705dcIsf9rimZo6+0vv
	 +u4j4cLLTJ+YFQ7xwSAAcFzqhkGIguaHGidbLifbaQsgxwbqc1kRnexJlbTC/RDmw8
	 bR/w567GAam4+GlbuiOI25Zl2cNiBd08A23IexJb6zPjET4vGVtF9hzc3b3m9q6lMo
	 mKeC+9PLA8R0rJz2vFIrp+De81nfBQ/CYXymxh77JRNn+WuTGJehGuCzMVRC0sj2NU
	 jhEQcU8D9ho4g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1C1933781FF1;
	Wed, 20 Dec 2023 12:11:36 +0000 (UTC)
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
Subject: [PATCH v1 2/8] drm/ci: mediatek: Test both GPU and display drivers
Date: Wed, 20 Dec 2023 17:41:04 +0530
Message-Id: <20231220121110.1441160-3-vignesh.raman@collabora.com>
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

Mediatek 8173 and 8183 SOCs have a separate display controller
and GPU, with different drivers for each. Add support in drm-ci
to test both these drivers.

Powervr driver was merged in linux kernel, but there's no mediatek
support yet. So disable the mt8173-gpu job which uses powervr driver.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/test.yml | 39 ++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 2c9a1838e728..1945c0a70e76 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -264,29 +264,58 @@ amdgpu:stoney:
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
 
+mediatek:mt8173-gpu:
+  extends:
+    - .mt8173
+  variables:
+    GPU_VERSION: mt8173-gpu
+    DRIVER_NAME: powervr
+  rules:
+    # TODO: powervr driver was merged in linux kernel, but there's no mediatek support yet
+    # Remove the rule once mediatek support is added for powervr
+    - when: never
+
+mediatek:mt8173-display:
+  extends:
+    - .mt8173
+  variables:
+    GPU_VERSION: mt8173-display
+    DRIVER_NAME: mediatek
+
+mediatek:mt8183-gpu:
+  extends:
+    - .mt8183
+  variables:
+    GPU_VERSION: mt8183-gpu
+    DRIVER_NAME: panfrost
+
+mediatek:mt8183-display:
+  extends:
+    - .mt8183
+  variables:
+    GPU_VERSION: mt8183-display
+    DRIVER_NAME: mediatek
+
 # drm-mtk doesn't even probe yet in mainline for mt8192
 .mediatek:mt8192:
   extends:
-- 
2.40.1


