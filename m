Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17407989D4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbjIHPXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjIHPX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:23:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162F11FE1;
        Fri,  8 Sep 2023 08:23:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE52766072E2;
        Fri,  8 Sep 2023 16:23:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694186599;
        bh=WAVH3aE6YH73IbakKHhLz1OxqV6EfdN7Z6LYf6+NDJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcjB6R8jwmybsou4rFMPv9acOAA6HzKPS/vVOGD8KXnqUXT6g0gy7FBu9jA4wS073
         MQyr50q5xlN02pWwznfoPImf0w7/x8KMWupqET/vWBps2Z15hh+3MinqjDcftckaMY
         Q+rpXO+WEtoCUE0QRDt4sNX9PYUKotKNEW+XJFlcP8Jx88OVaZDBxzPK1QqzddFTHj
         wWOda0UB873m1gxtCgMWvi+2bUYeDDBbUtzhxZMI5qXJ+mIWc8t+T5stCx0Jr1PD3k
         n9DVKtiv0sxiGcvFjqHdHcaqCZJueLcotU853Hh4fJI65qtlomoSXhheaTWX7QAyTi
         Rj3e9V6F7fY/w==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        angelogioacchino.delregno@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        dmitry.baryshkov@linaro.org, matthias.bgg@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/9] drm: ci: Force db410c to host mode
Date:   Fri,  8 Sep 2023 20:52:19 +0530
Message-Id: <20230908152225.432139-4-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908152225.432139-1-vignesh.raman@collabora.com>
References: <20230908152225.432139-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force db410c to host mode to fix network issue which results in failure
to mount root fs via NFS.
See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8

Compile the base device tree with overlay support and use fdtoverlay
command to merge base device tree with an overlay which contains the
fix for USB controllers to work in host mode. [suggested by Maxime Ripard]

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Use fdtoverlay command to merge overlay dtbo with the base dtb instead of modifying the kernel sources

v3:
  - drm-ci scripts to use device tree overlay from arch/arm64/boot/dts/qcom and compile base device tree with overlay support

---
 drivers/gpu/drm/ci/build.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index 7b014287a041..092c195af242 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -91,7 +91,12 @@ for image in ${KERNEL_IMAGE_NAME}; do
 done
 
 if [[ -n ${DEVICE_TREES} ]]; then
-    make dtbs
+    make DTC_FLAGS=-@ dtbs
+    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
+        dtc -@ -I dts -O dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtbo arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
+        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtb arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtbo
+        mv arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtb arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
+    fi
     cp ${DEVICE_TREES} /lava-files/.
 fi
 
-- 
2.40.1

