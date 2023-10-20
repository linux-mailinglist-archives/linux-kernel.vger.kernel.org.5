Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3297D0711
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376275AbjJTDmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346982AbjJTDmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:42:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7043FD63
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:42:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:e646:872b:8302:9b9b:d59b:1681])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 48082660734D;
        Fri, 20 Oct 2023 04:42:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697773357;
        bh=V6K2VUBWjxN+LHfNphCVJYj4rZzevGT8L0HKOHvoHPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASHX5+/qCm5G4u6XsXnRtFmUmYl2z9ifG4QKoWdcAcFdE43NHpZJuohWRdlKTLx7w
         2d24IxFG0Mt8lZddJrW0oPko2CHHvpWy7LzAtbZH4Fax7pfYL/xvCMCUSVRva0BUpS
         WOPzdSMvGik6MosSYFETPkX8R54EwtvTGx1WpuznXm8bz7X501IjUh+YoQU3Y/X+Wc
         skjsmTw+cp7Qb5npSFtml+yTFVI1xAy9enRszBTnwLymj11+nkzLOTPVp4fTAtiFIn
         NuLwZ7695IPSph8vwbdjjMFYYMO4qcsrdLW0EpvrWPb0ncSpXy39OWWL6g1479yplc
         BzRGz3a94Dthg==
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org,
        Helen Koike <helen.koike@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     robdclark@chromium.org, dmitry.baryshkov@linaro.org,
        vignesh.raman@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, david.heidelberg@collabora.com,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] drm/ci: export kernel config
Date:   Fri, 20 Oct 2023 00:41:22 -0300
Message-Id: <20231020034124.136295-8-helen.koike@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020034124.136295-1-helen.koike@collabora.com>
References: <20231020034124.136295-1-helen.koike@collabora.com>
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

Export the resultant kernel config, making it easier to verify if the
resultant config was correctly generated.

Suggested-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: David Heidelberg <david.heidelberg@collabora.com>

---

v2:
- no changes
---
 drivers/gpu/drm/ci/build.sh       | 1 +
 drivers/gpu/drm/ci/image-tags.yml | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index e3908f4d71cb..e5c5dcedd108 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -153,6 +153,7 @@ mkdir -p artifacts/install/lib
 mv install/* artifacts/install/.
 rm -rf artifacts/install/modules
 ln -s common artifacts/install/ci-common
+cp .config artifacts/${CI_JOB_NAME}_config
 
 for image in ${KERNEL_IMAGE_NAME}; do
     cp /lava-files/$image artifacts/install/.
diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/image-tags.yml
index 7dd3f995f8a2..7ab4f2514da8 100644
--- a/drivers/gpu/drm/ci/image-tags.yml
+++ b/drivers/gpu/drm/ci/image-tags.yml
@@ -4,7 +4,7 @@ variables:
    DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
 
    DEBIAN_X86_64_BUILD_IMAGE_PATH: "debian/x86_64_build"
-   DEBIAN_BUILD_TAG: "2023-10-08-igt"
+   DEBIAN_BUILD_TAG: "2023-10-08-config"
 
    KERNEL_ROOTFS_TAG: "2023-10-06-amd"
 
-- 
2.39.2

