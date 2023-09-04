Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237DA791B42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353291AbjIDQQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbjIDQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:16:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C2DEA;
        Mon,  4 Sep 2023 09:16:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3C0B660727F;
        Mon,  4 Sep 2023 17:16:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693844173;
        bh=PqnUcFY/q0lgjJw6DSUb9APr8xzTKq/rx+fSVIiGKME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVMwR8E4oAKKzCINPOhr4QwIjSWZ8tYTACb7k+ABut6UyuFzhoTWsDJs97OB4Nhpt
         3OWu9BILyy91S8DSMbar9kDvosLWcgYsPdkfuguBtI+LYr4So/VODZwKXQw2dGBDhb
         NbR7JzRVJeu4HFgWw50XQOj2sQ8ajwoBb49xCN8q7S/yKTZyCQbvhFEZaY1hJ1IgpA
         z3jo4/fhPr3IBImxZTH6vTJApbOAV4UPsuci+Gj/YMkCl1PHaNa5sISHrLb4o7er2V
         iCs9x6ZbTouwUp+JpacW8rpRuIkL1P8Gmv13zzvkyZjVZpZHessUZLAtoyLBF+BbT0
         T9IOljabH7TJg==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        emma@anholt.net, robclark@freedesktop.org, robdclark@google.com,
        anholt@google.com, robdclark@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, jani.nikula@linux.intel.com, mripard@kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/7] drm: ci: Force db410c to host mode
Date:   Mon,  4 Sep 2023 21:45:11 +0530
Message-Id: <20230904161516.66751-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230904161516.66751-1-vignesh.raman@collabora.com>
References: <20230904161516.66751-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force db410c to host mode to fix network issue which results in failure
to mount root fs via NFS.
See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8

Use fdtoverlay command to merge base device tree with an overlay
which contains the fix for USB controllers to work in host mode.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Use fdtoverlay command to merge overlay dtbo with the base dtb instead of modifying the kernel sources
  
---
 drivers/gpu/drm/ci/build.sh                         |  5 +++++
 .../gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts  | 13 +++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index 7b014287a041..92ffd98cd09e 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -92,6 +92,11 @@ done
 
 if [[ -n ${DEVICE_TREES} ]]; then
     make dtbs
+    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
+        dtc -@ -I dts -O dtb -o drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
+        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo
+        mv arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
+    fi
     cp ${DEVICE_TREES} /lava-files/.
 fi
 
diff --git a/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
new file mode 100644
index 000000000000..57b7604f1c23
--- /dev/null
+++ b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
@@ -0,0 +1,13 @@
+/dts-v1/;
+/plugin/;
+
+/ {
+    fragment@0 {
+        target-path = "/soc@0";
+        __overlay__ {
+            usb@78d9000 {
+                dr_mode = "host";
+            };
+        };
+    };
+};
-- 
2.40.1

