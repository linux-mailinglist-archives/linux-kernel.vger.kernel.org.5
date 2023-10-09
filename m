Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A2C7BD187
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 02:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbjJIAv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 20:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjJIAvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 20:51:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AAAC5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 17:51:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [179.221.49.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 82C3D660708F;
        Mon,  9 Oct 2023 01:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696812709;
        bh=YlrmObl+V8+O2Q33dquJjN5GhRz2SQOuwYCfJfNcc7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtqphMBUdFwBMxT9NMJHCOYt83yRevFAXF4cXCVRgMLPIsstGSfuQfg64gpL9qNUf
         oNX28wx6u51TdtOgB/oxjFy5eV2unDl6lO7Ox+c5MJZSwRFlAT2zt4GqFKfQGzFcpf
         x4vlvtW1pOVS9pOBK9L05SFxeGpPn9M3Cbm5yNZeKroDFdLwdPj6/wA9cAXpItxLBj
         EevAyZpxDaHSW+GgEqoeel6UB7F4LAtGSDwln5QPZMKhBn28usQADZ2DqT1NDzlAia
         X9A5Z5QQH7S0L33fkbtOMZWZafI543uTQSLjwumQQTjx6lT7iYGlO8GFV7gUmFw7T7
         K8h3oBxlSwDtQ==
From:   Helen Koike <helen.koike@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     robdclark@chromium.org, dmitry.baryshkov@linaro.org,
        vignesh.raman@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, david.heidelberg@collabora.com,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] drm/ci: adjust the number of shards
Date:   Sun,  8 Oct 2023 21:49:51 -0300
Message-Id: <20231009004953.203576-7-helen.koike@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009004953.203576-1-helen.koike@collabora.com>
References: <20231009004953.203576-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the number of shards to the number of available devices in the
farm.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 drivers/gpu/drm/ci/test.yml | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 3479d2a0108d..a94af2f99d75 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -155,7 +155,7 @@ rockchip:rk3399:
   extends:
     - .lava-igt:arm64
   stage: rockchip
-  parallel: 3
+  parallel: 4
   variables:
     DRIVER_NAME: rockchip
     DEVICE_TYPE: rk3399-gru-kevin
@@ -178,7 +178,7 @@ rockchip:rk3399:
 i915:apl:
   extends:
     - .i915
-  parallel: 12
+  parallel: 6
   variables:
     DEVICE_TYPE: asus-C523NA-A20057-coral
     GPU_VERSION: apl
@@ -187,7 +187,7 @@ i915:apl:
 i915:glk:
   extends:
     - .i915
-  parallel: 5
+  parallel: 4
   variables:
     DEVICE_TYPE: hp-x360-12b-ca0010nr-n4020-octopus
     GPU_VERSION: glk
@@ -196,7 +196,7 @@ i915:glk:
 i915:amly:
   extends:
     - .i915
-  parallel: 8
+  parallel: 5
   variables:
     DEVICE_TYPE: asus-C433TA-AJ0005-rammus
     GPU_VERSION: amly
@@ -205,7 +205,7 @@ i915:amly:
 i915:kbl:
   extends:
     - .i915
-  parallel: 5
+  parallel: 6
   variables:
     DEVICE_TYPE: hp-x360-14-G1-sona
     GPU_VERSION: kbl
@@ -214,7 +214,7 @@ i915:kbl:
 i915:whl:
   extends:
     - .i915
-  parallel: 8
+  parallel: 4
   variables:
     DEVICE_TYPE: dell-latitude-5400-8665U-sarien
     GPU_VERSION: whl
@@ -223,7 +223,7 @@ i915:whl:
 i915:cml:
   extends:
     - .i915
-  parallel: 6
+  parallel: 5
   variables:
     DEVICE_TYPE: asus-C436FA-Flip-hatch
     GPU_VERSION: cml
@@ -251,6 +251,7 @@ i915:tgl:
 amdgpu:stoney:
   extends:
     - .amdgpu
+  parallel: 2
   variables:
     DEVICE_TYPE: hp-11A-G6-EE-grunt
     GPU_VERSION: stoney
-- 
2.34.1

