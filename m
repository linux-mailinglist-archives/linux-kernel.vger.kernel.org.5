Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983BE7CF0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjJSHHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbjJSHHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:07:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C7185;
        Thu, 19 Oct 2023 00:07:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [103.93.195.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B29066072FF;
        Thu, 19 Oct 2023 08:07:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697699253;
        bh=35DFjxAotz1IVCItB2GsZcDMQyNA7MbHQR3Htt8pU1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbAReMsKB3X1LneMPjihBxcf/Yb7zcNIJ+3pD75rfBDPtBVZP7D+f/klvBlsqycvt
         SILiNS67mA9BDON/3Sqx7MCGGdzy7OBKMx1NrKWQAH9h2dCzaj99A+g3TzY94wye57
         mkHK9nNDJTMAh7k7jrK1XuObVCRD7wklTl8Cws9fsugii4D4YUGeMPhEWqinJN64Q/
         KaRAz9/6Ijff1n3uXf4baqy03ui5Ikh78zZcEysO89niCSc2StIks2hsE9f1DpAHSc
         t5P04JquPu2sJ1bwDq3zoIMe4vJpkgRUa0hjgPkTT3ZKyabeTj4RVDTXigEWFnWSDA
         hQeVQYygD0Fbg==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 5/9] drm: ci: Use scripts/config to enable/disable configs
Date:   Thu, 19 Oct 2023 12:36:46 +0530
Message-Id: <20231019070650.61159-6-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231019070650.61159-1-vignesh.raman@collabora.com>
References: <20231019070650.61159-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of modifying files in git to enable/disable
configs, use scripts/config on the .config file which
will be used for building the kernel.

Suggested-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Added a new patch in the series to use scripts/config to enable/disable configs

v3:
  - No changes

v4:
  - No changes

v5:
  - No changes

---
 drivers/gpu/drm/ci/build.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index b1ea9b458922..614111b7670b 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -70,19 +70,19 @@ if [ -z "$CI_MERGE_REQUEST_PROJECT_PATH" ]; then
     fi
 fi
 
-for opt in $ENABLE_KCONFIGS; do
-  echo CONFIG_$opt=y >> drivers/gpu/drm/ci/${KERNEL_ARCH}.config
-done
-for opt in $DISABLE_KCONFIGS; do
-  echo CONFIG_$opt=n >> drivers/gpu/drm/ci/${KERNEL_ARCH}.config
-done
-
 if [[ -n "${MERGE_FRAGMENT}" ]]; then
     ./scripts/kconfig/merge_config.sh ${DEFCONFIG} drivers/gpu/drm/ci/${MERGE_FRAGMENT}
 else
     make `basename ${DEFCONFIG}`
 fi
 
+for opt in $ENABLE_KCONFIGS; do
+    ./scripts/config --enable CONFIG_$opt
+done
+for opt in $DISABLE_KCONFIGS; do
+    ./scripts/config --disable CONFIG_$opt
+done
+
 make ${KERNEL_IMAGE_NAME}
 
 mkdir -p /lava-files/
-- 
2.40.1

